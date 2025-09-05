Return-Path: <linux-nfs+bounces-14059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E377BB44BD5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DABE5A13A1
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F727815F;
	Fri,  5 Sep 2025 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ6L/Sqo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DB2773F0;
	Fri,  5 Sep 2025 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040478; cv=none; b=GotpCviZUdx9ErWerbNdGIJOHJUD3oKZWhmFmOU4FfxLk5pcpSI17Ienv7gkcQRS1LvrEE4OV+6w+YQjCk0ClgKhYHpGIZcxutxnNp/E0xQ7Pw8cYbkEi9xaZi5S8KIPYfDgnD4U049Mo9AugK27bQRVtUd4/+GdwzNXl1vMA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040478; c=relaxed/simple;
	bh=RLz1X95Y/+v8UyvcTdAO6K0/RRwPY/3mS2OE8jsM57M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzzrLfrmH0J9SHOe+5HRFr7pAY6ZLhXyocj++3r2islPbpqB198iuQ9b6wajbyxFXycyAnSEXyJjeEftTQV4jRIPE+xOG38GxEKmX232WsKwZgVrnfUcMI0HGDQtz2rHm5KDMr9VB9Bl/i3EQUzONZkSLPWSBb3qD9434Huvn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ6L/Sqo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1464689b3a.2;
        Thu, 04 Sep 2025 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040476; x=1757645276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9e5+w0yseDVRKXyHQG0EMob0UgsivV46mk3lPkzuSY=;
        b=mZ6L/SqoQvUYFLtFWGU6gHZkpF/THgewnfwvGw8wl2/TFCYHCB75lSeupsJX8zKFOM
         5QER5tnGUzrn/UUMAxKD1wxMA2JQyNdo5ynAZuijUnM6yePqaPyOao/AoLmziQphfqAD
         TBvyM/FFY+lFavmFIRiFRME5RuJ18Dra44s2RKgqGPLyfcAAwer6k27AuSfvc7VT87sq
         UCplPwnGTALE1a6q4s2rXVY0MPu5vrH0T00VcOvsr3pK+w2RF3dajmBc2ywdmiZkARJ9
         xL0/FnIZB5ncw1Kv7MhBqCABfthXwEe459aU2UEDkdsvQxLSNx0Z/5nkhsGffWP3kxEI
         gMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040476; x=1757645276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9e5+w0yseDVRKXyHQG0EMob0UgsivV46mk3lPkzuSY=;
        b=hJ34k4Walj0Ltcoyfl0DDkH2ErgHtxR1YGGBOnqMmfZ7Yg8/8wN0vO7PgwsKNJ+cvB
         kV3EyUlKVU+WsTY+c1hVLiDDWsVqk0OV7AHBnfHPFqOz4LoAqUlhs8DhAIBHdLE/n/16
         zLk4g6waGhUoC8mR9RenXvCpKFB0to44H/2okETEhdPNPbCAIbOzg4AkjQMAmgPj20Qb
         /G1RlR8TSNJHHrKTqBliYggMlkrXfXoAKJ5iLd2SpKJL2TMSZqpSzhSHQvGgDcJMTUO6
         CBga3JoihB01aLT8C7MWBv4gLVYVjVSGIfhzcU4RKjTRUddXJ3FM9PdtzBXsuVJQnaxE
         zUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4/1qdBCj2pqxDm4OSjZa+3yyBoZt1j1gvtfVVaM73aH4mrjs9Q0kh/zAG28oMUxXnQXxAnl6Y@vger.kernel.org, AJvYcCVjeTKhBGeofck8r+dQwv8rVew0amTkv5k9GFWIwQFK5AQ1KAM/pUqkNqu+mXs+xgfK+rZSAoqHvDw=@vger.kernel.org, AJvYcCXA64Brdm6BNjGdLA+MW8dsmU6MwIMHj1RSvLrJwnU2GKNLHQqleDo1h1RBtaisusks/gkdorjoKZPD@vger.kernel.org, AJvYcCXhggADN20vSzHMdfsHzUKxEt44Oshws4TiBzJPzuyjwW+1KRV95rkU3dGwxPMjbb4LPUJy5EmzbSnGM0YG@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeGUaGL6tr6WqDhSRTR3PrSi9wV+A9QQrM1b2T+FA11+yKsM7
	B4PyaM54mOVTxPLktNv3o75MD+NOyf0CyCh7DfVIB6xM80g0fZ4SKuv2
X-Gm-Gg: ASbGncuLyKh1gg3OtW/txy1jEmJDWWBDzQW7mIS6/LwJSeaTUz4mkTdLy2D1s9TBj2D
	Oy85Kusr3nZ6RH+9OEGVKEDRt53c86Jq1tqVETrR4sx2YilxsjEo0VnJLgzTUgyLlootjdFrUg5
	171OqXtreZoQHVpOQ5I3w06YQVjWLn/fJxyZc2l4iMYMbwvaMh3xFP7H49Oh1NdbzOTsxOrCWrM
	n1zXRJWdrIX4lmxHy1cY9Kp1r5rv9qmvfIIHAEKb1vtNxA2CgqS/1JTEZUSPNml3eszrme+aIxE
	uxx7qZktde2e33aX0d+hwhdJ1UXxYKBWVzNEjb7Tib1Hofb8C2ySrdW9rj0i5Bc9dEtZipokNSS
	CGJPDOpPNmSaIY7Nv5rqbp9eRf17nnPYzk2mv+URXMIMxMQmdLbCRvhnc5a0tTey8WT2XhcquDl
	X8zvWjv+n4Lv1ZWSi8IgxvTTesRRw=
X-Google-Smtp-Source: AGHT+IE5rtWLMqPFBmeaxbv9KttLOM1H0Hi7npadmSAN8tmXCrE3ITkAgijdjWzjFV2lB+BE+swDmw==
X-Received: by 2002:a05:6a20:a11d:b0:245:ffe1:5615 with SMTP id adf61e73a8af0-245ffe186e2mr14759405637.38.1757040475632;
        Thu, 04 Sep 2025 19:47:55 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 6/7] nvme-tcp: Support KeyUpdate
Date: Fri,  5 Sep 2025 12:46:58 +1000
Message-ID: <20250905024659.811386-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
on an KeyUpdate event.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg
 
 drivers/nvme/host/tcp.c | 73 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 776047a71436..b6449effc2ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -210,6 +211,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
 			      key_serial_t pskid,
 			      handshake_key_update_type keyupdate);
+static void update_tls_keys(struct nvme_tcp_queue *queue);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -393,6 +395,14 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	do {
 		ret = nvme_tcp_try_send(queue);
 	} while (ret > 0);
+
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+
+		do {
+			ret = nvme_tcp_try_send(queue);
+		} while (ret > 0);
+	}
 }
 
 static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
@@ -1347,6 +1357,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 done:
 	if (ret == -EAGAIN) {
 		ret = 0;
+	} else if (ret == -EKEYEXPIRED) {
+		goto out;
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
@@ -1371,9 +1383,56 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
+
+	/* If we received EINVAL from read_sock then it generally means the
+	 * other side sent a command message. So let's try to clear it from
+	 * our queue with a recvmsg, otherwise we get stuck in an infinite
+	 * loop.
+	 */
+	if (consumed == -EINVAL) {
+		char cbuf[CMSG_LEN(sizeof(char))] = {};
+		struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+		struct bio_vec bvec;
+
+		bvec_set_virt(&bvec, (void *)cbuf, sizeof(cbuf));
+		iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, sizeof(cbuf));
+
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+
+		consumed = sock_recvmsg(sock, &msg, msg.msg_flags);
+	}
+
 	return consumed == -EAGAIN ? 0 : consumed;
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	cancel_work(&queue->io_work);
+	handshake_req_cancel(queue->sock->sk);
+	handshake_sk_destruct_req(queue->sock->sk);
+
+	nvme_stop_keep_alive(&(queue->ctrl->ctrl));
+	flush_work(&(queue->ctrl->ctrl).async_event_work);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+		nvme_tcp_done_send_req(queue);
+	}
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -1389,15 +1448,21 @@ static void nvme_tcp_io_work(struct work_struct *w)
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
 				pending = true;
-			else if (unlikely(result < 0))
+			else if (unlikely(result < 0)) {
+				if (result == -EKEYEXPIRED)
+					update_tls_keys(queue);
 				break;
+			}
 		}
 
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
-			return;
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			break;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1705,6 +1770,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_session_id = user_session_id;
 	}
 
 out_complete:
@@ -1734,6 +1800,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
-- 
2.50.1


