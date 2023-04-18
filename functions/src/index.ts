import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);

// 3分ごとに実行
export const timer = functions.pubsub.schedule("*/3 * * * *").onRun(async (context) => {
  try {
    functions.logger.info("timer start", {structuredData: true});

    const message = {
      notification: {
        title: "テスト", // 通知のタイトル
        body: "テスト", // 通知の本文
      },
    };

    const db = admin.firestore();
    const collectionRef = db.collection("users");
    const querySnapshot = await collectionRef.get();
    const queryDocSnapshot = querySnapshot.docs;
    const tokens = [];
    for (const snapshot of queryDocSnapshot) {
      if (snapshot.data().fcmToken) {
        tokens.push(snapshot.data().fcmToken);
      }
    }

    const multicastMessage = {
      tokens: tokens,
      notification: message.notification,
    };
    await admin.messaging().sendMulticast(multicastMessage); // FCM で通知を送信
    return null;
  } catch (error) {
    console.error("Error in timer:", error);
    return null;
  }
});


