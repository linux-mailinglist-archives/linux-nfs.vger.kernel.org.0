Return-Path: <linux-nfs+bounces-15317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BFBE64C8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E3A19C5A97
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727830FC2C;
	Fri, 17 Oct 2025 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9kLgCPF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7A30DD23
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675045; cv=none; b=FvKqMM7UfGXdm9CVPD1PrYLSAcJd21yTEXGt2W/Pmvt7H6qzk6uyZ9IYnGL96JHpyF4H4WgXzsZg9RiOpy2G7D3oO/BaQL2XWhWDXCyd5Ha+E/A/W14eUR1Z7FU7TpuRDAvy/ql/i32LW37+dETVeTPw4l4uC9Kn8gxd931OfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675045; c=relaxed/simple;
	bh=egKMjdwqXFVhXo0/qrA1CwLDO+yiuNAjeyMBOfRZGcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr/gv3V4EmGsx7GIY2AodCv63eausO0KCRb09i1oTU8Rlfx/FJpHjtjv5fnR4rdwOmfQ7EudKg2IVptn7LCG5cR+0NWKAa99qY628dWW7kEtJojkYdYEUMLnDr6oXiudatsSrdg+4ywpj4dhX1LCVA9KkjJeeum6qkoEXF2yI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9kLgCPF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698d47e776so11045125ad.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675042; x=1761279842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynJnGU8No3Ej9J48gvJNh3pD5kzmZrz6FyAMKm2dKu0=;
        b=Q9kLgCPFd8C8xEHHLimehO7V7DjRAykcGUUK2NVEMMpfzhYLaPh8NMwhUVM8iKuSfe
         2OX6YM6dgtPi3VbF7GZrZjm93FCDZSDjDOb28gP9Lj9O6vJaylEmcAIdiziQCwPT3Ait
         sbVe08KrzOfVSKsUkQFXatBTyshY+GOYmON3iKALYcWoTl/uqa/AGoznUNI3LiE2QZDB
         dniBY5Quj24LVGeIae5FtAO/d4ozQ0A/RkM/Wy8+uM7nW68KILthV3CsfZCjckdCmRFd
         KoL88Yi7q7ToRP/F6BK8dbQDBsfMz417Di+iHMcoM15ZPZeAyTfl1MZB4P+zoL0q9lMK
         Vpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675042; x=1761279842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynJnGU8No3Ej9J48gvJNh3pD5kzmZrz6FyAMKm2dKu0=;
        b=sOfkj5d+2iuyua8egqFrP03tlSRD/gDwByDOPip7iJmiprB3LiTaoX+9KFUUw0n9ea
         NiS6P3aN2l/3gS5DzWWYesl8inFFPfRJKA7HnDRX3T+ChX7hP2xtzEgTB1dQMmFFiPSQ
         NaD/aZdZb0yP8fK2puwSYbX4CNza+nKe5bAuj01KbxG6WxzZB54YKGufw6AXniOLzw8h
         edjqV4dK0M5KODDNRQNfRikskQtx1zryHXoZROM8QYMQdRDtl+QU0TxWAXqrYYXb79OL
         2guZPHdGhgp7GlfkJuuKIbkZQlIXkBXG8CoNnpyNky+bd/qhorbAo+WvWP9iu2R9LWDh
         b8hg==
X-Forwarded-Encrypted: i=1; AJvYcCUoqChz0c8dNP+9x0UW7Ps20Sm2zE7/lhzJrA8YWKfKKUtasYvDeFdPSCs5Nb9H1/dnGK5BmK1b5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyKPFC0HH5+W6ZdKKhp0jf5bBSbOejyn0VT8ykcM0GCWqd5OQZ
	8gYPrbpfBwqZNcNTuDJvK1tx6Acic4sYrVTC9Os4iscDLYuB/aOnVkZL
X-Gm-Gg: ASbGncvqJWS76e3dQHXAose+4ZLNEUj6b0gUxLbegPTVCYW/wBIkBuoPrkDYR2XfcQK
	JRATOh3PJwj1tVlvfVO2G/ERvdUyWT6CHh0iFVeBE3ucCawD+Tmc9sKcf7N/aE0yYZ04MCwfMQf
	uabjxt9GZNdX+SZzHzvXGWl09DDmPCGb/7N8bPmTwZFvXz+Sq9Jwlo4B+S0TDnxewMhEMkG2azU
	sFBd/FVnM38L7BKw/AEUbmOmjCUQ5lmr82tsXZ3d0f/Aj/Bhr6j8C3uTH567iNKxZA/4O7rVa2Y
	NUELQugA7v//wt7z+sRZIaSH0f7HsL/tm11YIxFMkxdlhsBPCRecaok+KK96+9zaRQI4RvRXHPa
	QGd1uJ6CQN4odxPH/Iu2flZq7HbWTTy/97BAwPykxQbZ8fay6S3ITazvEgulOPoW/QpQoTKtEsV
	26XFkYpYuVTfXFYscsEfT7IiKLb+nBcEdbrwqoDGcwvBuYWLqFgH9I8DNtel3ZChVD/BSM4cGID
	D8zntYj+yz18wmlHfX2gQ7Tvanvge8=
X-Google-Smtp-Source: AGHT+IFcY3veIMHOTTRwopAq4s0Ev1n9UH4zUIWfhrPPA4Ws9V39ePWtGb2V3y+JvQ2CTsDbOiB+pg==
X-Received: by 2002:a17:902:e88e:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-290c9ca6712mr28314355ad.18.1760675042582;
        Thu, 16 Oct 2025 21:24:02 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:02 -0700 (PDT)
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
Subject: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
Date: Fri, 17 Oct 2025 14:23:10 +1000
Message-ID: <20251017042312.1271322-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
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

 drivers/nvme/host/tcp.c | 60 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2696bf97dfac..791e0cc91ad8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_session_id;
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
@@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 	if (ret <= 0)
 		return ret;
 
+	hdr = queue->pdu;
+	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
+		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+		return 1;
+	}
+
 	queue->pdu_remaining -= ret;
 	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
 		return 0;
 
-	hdr = queue->pdu;
 	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
 		if (!nvme_tcp_recv_pdu_supported(hdr->type))
 			goto unsupported_pdu;
@@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 
 	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
 		return 0;
@@ -973,12 +983,14 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 		memset(&msg, 0, sizeof(msg));
 		msg.msg_iter = req->iter;
 		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_control = cbuf,
+		msg.msg_controllen = sizeof(cbuf),
 
 		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
 		if (ret < 0) {
-			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to receive request %#x data",
-				nvme_tcp_queue_id(queue), rq->tag);
+			dev_dbg(queue->ctrl->ctrl.device,
+				"queue %d failed to receive request %#x data, %d",
+				nvme_tcp_queue_id(queue), rq->tag, ret);
 			return ret;
 		}
 		if (queue->data_digest)
@@ -1381,17 +1393,42 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
+	if (result == -EKEYEXPIRED) {
+		return -EKEYEXPIRED;
+	} else if (result == -EAGAIN) {
+		return -EAGAIN;
+	} else if (result < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"receive failed:  %d\n", result);
 		queue->rd_enabled = false;
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	}
 
 	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
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
@@ -1414,8 +1451,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
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
@@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_session_id = user_session_id;
 	}
 
 out_complete:
@@ -1752,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.51.0


