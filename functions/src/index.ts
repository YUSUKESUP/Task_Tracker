import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(); // initializeApp()の位置を修正

const db = admin.firestore();

// 3分ごとに実行
export const timer = functions.pubsub.schedule("*/3 * * * *").onRun(async (context) => {
  try {
    functions.logger.info("timer start", {structuredData: true});
    // 通知を送信するトークンを取得
    // const fcmTokensSnapshot = await admin.firestore().collection("users").get();
    // const fcmTokens = fcmTokensSnapshot.docs.map((doc) => doc.data().fcmToken);
    // 通知を送信する処理
    const message = {
      notification: {
        title: "テスト", // 通知のタイトル
        body: "テスト", // 通知の本文
      }, // 通知を送信するトークンの配列
    };
    const usersRef = db.collection("users");
    const snapshot = await usersRef.get();
    if (snapshot.empty) {
      console.log("No matching user");
      return;
    }
    snapshot.forEach((doc) => {
      // push notify
      const token = doc.data()["fcmToken"];
      admin.messaging().sendToDevice(token, message);
    }); // FCM で通知を送信
    return null;
  } catch (error) {
    console.error("Error in timer:", error);
    return null;
  }
});
