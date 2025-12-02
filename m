Return-Path: <linux-nfs+bounces-16836-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE096C99C66
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 02:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7613E3A2E83
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 01:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAA212B0A;
	Tue,  2 Dec 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqR8s5jE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32085239567
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639332; cv=none; b=mH46xI7InZP0qwS8p+Zl9GFEn5xEzeOgcwJ6R/F4wcuDM9gLZU2PrSl1Nw6aCOOe5mWobsaPI+N3ul5/w5qZowivJ7StIPsH0hrTCoFPkAke9w7izQuaerd2MpFRCbS9EHTn3Cv3lpianf7DQG/6Bd3dY4VViU1DQfCdXBla95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639332; c=relaxed/simple;
	bh=RUtCX8CP3W/yuDQ/ZW/ZJRJEJWXpd/A/PFm0/jER/wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLG46k+e9SuhKzX5NovrJuEx1M7hmz+ZVHikaSrHmdjidIAv5tvdIggHxAP/g/1WEMrgY2shg9UAs6x+V8L2EgqxuKsjZpl5C0YbMbDFJXqjECYuMPOrsA98DEuvdkF+3lu74ptjO8u/izkl/RVBHVvuneh6ItEv9ghJPBwiPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqR8s5jE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2957850c63bso36207635ad.0
        for <linux-nfs@vger.kernel.org>; Mon, 01 Dec 2025 17:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639329; x=1765244129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alrcnF8hffQyqVii+35fGG8FiEZV1WdxKAf95IBHMhY=;
        b=NqR8s5jEztxYwuc0E7kXEy/Vfefn7i/ZsNniBNvBNGX9Cg3cKzL4Ot0B+IPNkFrLPO
         rxQjVGOdb3xVlE0PpSBu45Yjr34pvbUiaE5bRRmsdZpoadefanYEEBMBhr5FrELOhWbG
         omwO4NzJpWxdcujzNa9HaBiqLlq+ztJAV+CJdG7LP/JfisTjC+Bjn1E24AmNjjwOAElS
         3E3L1USIAm+sQuDxIhhJVgwqti72jxJnXd0dwUReqrQ6MRpa9TVPkuu3JL+ZPc9eFhgT
         pN+tJ1O5ev8RIPr6IMhmhF/01ImVTNSMw9XRoCPajRfJkArnaF53zHN6L44FfhWQWU/8
         bMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639329; x=1765244129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alrcnF8hffQyqVii+35fGG8FiEZV1WdxKAf95IBHMhY=;
        b=XfuGkPkTN8UOSjQtHAOS4Pa2/mwqAmfYH++hgM48CvlOJPUImT6mLa/SylsQK7HtfW
         DX/gPOoCf0nA814OMJh811FuFUzcTJri/SpFbwsyr6kR7Ws0YGe2cbXLuWjoSINipsC6
         5jSbQsKYgOdilyutIQWzz69KhhLT0nq4Viihs1Y3ul1251ZTIbtg+t09BCs9l3oeKaXj
         uOO08THdd13wqcpjqZmvblebUwb+fQVRkV+DnN2g41ECOzctiai535dF8xPKYO3p+ba2
         aWFRYkgX3MJtONnN0hDB2cGaO9vScf7JpWKuBllr+pMohrby6qh/mYY2jL4lcxwl0xzS
         pQwA==
X-Forwarded-Encrypted: i=1; AJvYcCXldz3z4j2L4BctH6Qninkg/rPx9c7YJT+X6RA3ZP3r4GIPbnzq11xznnCl/SiwbZwhG2lqIAowsTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZta9QJ1QmT/yRYGxbeHWFs5fAPTx8ZLjx5zvsDbH/3g+kKoA
	zyfUVsZMTeYh8rXnMsQnJ85KBhKpgS5RXDXcBF/+49vy86Pw6x4PCvkS
X-Gm-Gg: ASbGncv3dLwIxcb1/EeQQDYQkD49oc/6Lil3KRuGdGkJKk5zjX7UitfiSyO8KvUx++A
	wSrQkW25VLvKn/ANPoChKlySbLIwROm2uA2HLoFo/hIpqS7rG72j2Z8kzWl05WgM33hZbrGo9Vz
	EF3i48JY+m8NwuIGQYABnFr/LErAx+6daRrVquf1gAH/M+UMZyHf3AuOLO3WbkqYJAzvXeYUtfC
	0GqkaccclODzY4jDjDXVxX7wCUEQNY6BjK1AkpaPHwulgFHXaTEthyQ6yctzT6+DyddI8J96p+u
	5s0SypcFVRyyIu1GpJVWq/TkmZamKYPMTRPvzt7qHKRftpH/6NjJQeqtGrWjfbSWAzP3aMWhd1v
	P6VtrAj0cMXYYuXIWxXvPAGToKYz4aA3bFL4d61mbgqSS0Yg8jE/TGpMHkuiCQOrBXdzPqyUchh
	DjF14wgmv/BS84si8+VFW1I5/hnd+1LE2Ozi4v7RUayZQqlcF0rgfD0xMGVOnQ6MzMLPT0J7cQZ
	GZpqdNU6sfatdAEqyg=
X-Google-Smtp-Source: AGHT+IHdYVOCmmOlbphB1W7UrAZ5O3XT23PE61UI8Mwhm5s9BH8EvESHLmAwNWu7QZRIDDb2agOulw==
X-Received: by 2002:a17:902:f786:b0:298:88:c006 with SMTP id d9443c01a7336-29d5a48b3afmr8809815ad.4.1764639329398;
        Mon, 01 Dec 2025 17:35:29 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:28 -0800 (PST)
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
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 4/5] nvme-tcp: Support KeyUpdate
Date: Tue,  2 Dec 2025 11:34:28 +1000
Message-ID: <20251202013429.1199659-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202013429.1199659-1-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
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
on an KeyUpdate event as described in RFC8446
https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Based-on: 2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v6:
 - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
   instead look at the cmsg fields.
 - Don't flush async_event_work
v5:
 - Cleanup code flow
 - Check for MSG_CTRUNC in the msg_flags return from recvmsg
   and use that to determine if it's a control message
v4:
 - Remove all support for initiating KeyUpdate
 - Don't call cancel_work() when updating keys
v3:
 - Don't cancel existing handshake requests
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg

 drivers/nvme/host/tcp.c | 93 +++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4797a4532b0d..c0966929f97b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		handshake_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
 static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 {
 	char *pdu = queue->pdu;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
 		.msg_flags = MSG_DONTWAIT,
 	};
 	struct kvec iov = {
@@ -873,6 +877,12 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 	if (ret <= 0)
 		return ret;
 
+	if (cbuf[CMSG_LEN(sizeof(char)) - 1] == TLS_RECORD_TYPE_HANDSHAKE &&
+	    pdu[queue->pdu_offset] == TLS_HANDSHAKE_KEYUPDATE) {
+		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+		return 1;
+	}
+
 	queue->pdu_remaining -= ret;
 	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
@@ -944,14 +954,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg;
+	int ret;
 
 	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
 		return 0;
 
 	while (queue->data_remaining) {
-		struct msghdr msg;
-		int ret;
-
 		if (!iov_iter_count(&req->iter)) {
 			req->curr_bio = req->curr_bio->bi_next;
 
@@ -975,11 +985,8 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 		msg.msg_flags = MSG_DONTWAIT;
 
 		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
-		if (ret < 0) {
-			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to receive request %#x data",
-				nvme_tcp_queue_id(queue), rq->tag);
-			return ret;
+		if (unlikely(ret < 0)) {
+			goto msg_control;
 		}
 		if (queue->data_digest)
 			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
@@ -1002,6 +1009,29 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 		}
 	}
 
+	return 0;
+
+msg_control:
+	/*
+	 * If MSG_CTRUNC is set, it's a control message,
+	 * so let's read the control message.
+	 */
+	if (msg.msg_flags & MSG_CTRUNC) {
+		memset(&msg, 0, sizeof(msg));
+		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+
+		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
+	}
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d failed to receive request %#x data, %d",
+			nvme_tcp_queue_id(queue), rq->tag, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1384,15 +1414,37 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
-		dev_err(queue->ctrl->ctrl.device,
-			"receive failed:  %d\n", result);
-		queue->rd_enabled = false;
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	if (result < 0) {
+		if (result != -EKEYEXPIRED && result != -EAGAIN) {
+			dev_err(queue->ctrl->ctrl.device,
+				"receive failed:  %d\n", result);
+			queue->rd_enabled = false;
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		}
+		return result;
+	}
 
-	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
+	queue->nr_cqe = nr_cqe;
+	return nr_cqe;
+}
+
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+	}
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1417,8 +1469,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recvmsg(queue);
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
@@ -1726,6 +1781,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->handshake_session_id = handshake_session_id;
 	}
 
 out_complete:
@@ -1755,6 +1811,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_handshake_session_id = queue->handshake_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.51.1


