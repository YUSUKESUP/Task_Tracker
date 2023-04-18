import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);

// 朝の8時に実行
export const timer = functions.pubsub.schedule("0 8 * * *").onRun(async (context) => {
  try {
    functions.logger.info("timer start", {structuredData: true});

    const message = {
      notification: {
        title: "リマインド", // 通知のタイトル
        body: "本日のタスクをチェックしましょう。", // 通知の本文
      },
    };

    const db = admin.firestore();
    const collectionRef = db.collection("users");
    const querySnapshot = await collectionRef.get();
    const queryDocSnapshot = querySnapshot.docs;
    const tokens = [];
    for (const snapshot of queryDocSnapshot) {
      if (snapshot.data().fcmToken && snapshot.data().shouldNotification == true) {
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
