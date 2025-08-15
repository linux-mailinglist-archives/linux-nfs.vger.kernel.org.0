Return-Path: <linux-nfs+bounces-13655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D60B27807
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB33A5E91D8
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7652BE7DA;
	Fri, 15 Aug 2025 05:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFmsFRKE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF222BE7C6;
	Fri, 15 Aug 2025 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234176; cv=none; b=JT8QgJlGV4ESxELam2Y+MH+/qHt2z4UBfUqS3OEdNhOCyxcXSfB4SHrUn0AtSACVQGtFqVkbF3oMiff0FtUey+MdfKrSLilSikUZZ//WgI6tEkTdh2Lw8gQbwQUp/ot6oVb2LcWujO79tRy9V4Re4m8Jf1F/nnBBNLDH/qRzyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234176; c=relaxed/simple;
	bh=YXGFLVw6nrmtEUTY7T4USYOqb/CEvYKMmsg3TPj1WY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs5kjGIZbWeuXdznW8+9sSfjgKbMGlx8k+n6sM9Xw5JvQWQj+BKCk/n9uy6dMQrR8yV7v3AyHmIuR89ePpim5WtOZOJBsca2x1PQRyjdJfBYcRpQSzELXzRxJnUq1yNQvFxQogCHnvkjCHS6HIXdb+tRjEj/c/WXUxI74JPV0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFmsFRKE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24458195495so11077315ad.2;
        Thu, 14 Aug 2025 22:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234174; x=1755838974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neDuK8ZnEoxPuomsrzouDeck0u2jESUqvyfxmr3mZPY=;
        b=eFmsFRKEwiNbVVFnf6dvnzxdFqX+fS2/J9UJdWCW1iumXsDlkbTR66tISFYnL0UOzS
         lXp3BJMGeUrMJxA9EdBgTEjsskdK1eUJJWk/8zoqdGKUEwQxjQXEfZ/wMkE7riGpKjeA
         /P3uL2py/KLsqDvCTiKFebVumc2lVGVSuomQrd7nysF+sPawuvMpbjxCS564pdgoP11h
         QL35WAruvE36XTmPZYZJE6Nvd9kOiwHdX/yQkoP3CZOA7WLjauIeCTo8DF0xEQLu3HMO
         sW3ZP2uCyoro4MGU3j285WVlQHcHdgbheWNcRNDVxzdl9/7Z9jbN3ZOAJt0rgdN9Qc/V
         LN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234174; x=1755838974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neDuK8ZnEoxPuomsrzouDeck0u2jESUqvyfxmr3mZPY=;
        b=gZtNOapV1AGt3gftoFmY/+RtqJ2eZFvTjuPnIYcK85yjn9nKjFHO4Tri6OFOCsTvMD
         UX0GEkwSzSgKMyVmwuTEJZerie/CJm7G0FwcQAC0q8dAaOBoOa2kC+1K/7U128wTdtxD
         UY1YixHQTBO2pe3Vsi1uybfeQ+Ok6uew1wfyYh0rTqJvjWk0wwIOFTjrEzo9wTXT5udb
         6rc7gey2ab5WTpjrWeCZhRV82h5m4oKwtXByiPrxXEHssi5n7Ehl6Y9J10jTrLqyd+Iz
         RWIMD8PL58r+bmO4XPlcxILHsW2pByQfr4EIsdWDToFiGBAAkcji7oHBn575itGweFRu
         1FuA==
X-Forwarded-Encrypted: i=1; AJvYcCV1hRIsWQXKe3TXpElV5OsjeIEDBh7soXqD6c31gLe6VajXVIOKSxzcCCPt1S1mxAJesr+6FlMynNrh@vger.kernel.org, AJvYcCW8mr8EWjkHnZVxcP2wLwHZVQa4EqzFwLfVxsNAHpfTCwZ7eQrDqOC10L2X3SEewEJDrWbzJZWU@vger.kernel.org, AJvYcCWsoyL2WJWkBI74WiQDUu17ex8HB5ZqKCKDUUkid/Cn2SUiUJVIbMAB6UnMsbISS4lVoMEtv7zvdM1obBvX@vger.kernel.org, AJvYcCXEopHvOUd0dL6K+4T1DfOYGFq/mH/NAXFZSlz8hdgugfFAe9xUyCgQwyaswKdxrRLLaRWCBGjycro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1COYZADZ3k7a8HjAw0ePExRx7JWBdvatCn+uy1vZWEDgRlpr9
	QgtppuVdEA7XrCJLisnhXF4+zoXl4AOCNaLwY9VElKd3GRbzzFd34OevITNcPw==
X-Gm-Gg: ASbGnctcKsnyjtihHUN6iM8VihdLxeq4/dJ8T/7FODcFqqxIwz0/U8N6V0ZxWX9Pvxw
	S4xv1T0VLMyvp0Ymx+TG1mP4lRRhHmvRg/Svkxxrkfmj/VKG7YMMOu+HasbdyoheyN3MW3Gobsp
	BnPcygyi+k5p/FU26eJP9CZbosdMvTqlJRqgjr3MOtFcA7VsE7p+Giy7qH6HjI8kMbfUEvclOU8
	AiM4Hz/tQJZ3iB/vIeUSNqybNRimzwG/1vE8Z87U233y7sQLsF7FG6vcZMvsZX6B8oA+dodiVVr
	7N7JPmF2BFNLCHtloifywe+ek6WoKTE8vjpvokH//4HhQYBZYtWAUo7kzy5KAb0k3mxANrgnfwX
	EK8f3xQ3icfvZJPRA4pSxFkgeJd2pqZxzBZx1TNyp68WOhmUqUV35srz9FyPxV+BR9l4yVaATNR
	NeqgtaBF0tIwCnVRRr8URELUvX6qk=
X-Google-Smtp-Source: AGHT+IG8imeIhOp6Kh+mvcy3i3tVkeltm9bQmEjxAgXG7n6od8szlHMMpip15QOuUZGKPgir+jkAGg==
X-Received: by 2002:a17:902:e74b:b0:240:70d4:85d9 with SMTP id d9443c01a7336-2446cba36cbmr13771535ad.0.1755234174437;
        Thu, 14 Aug 2025 22:02:54 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:54 -0700 (PDT)
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
Subject: [PATCH 6/8] nvme-tcp: Support KeyUpdate
Date: Fri, 15 Aug 2025 15:02:08 +1000
Message-ID: <20250815050210.1518439-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
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
 drivers/nvme/host/tcp.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cc3332529355..0c14d3ad58af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		user_key_serial;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -1313,6 +1314,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	struct nvme_tcp_request *req;
 	unsigned int noreclaim_flag;
 	int ret = 1;
+	enum nvme_ctrl_state state = nvme_ctrl_state(&(queue->ctrl->ctrl));
 
 	if (!queue->request) {
 		queue->request = nvme_tcp_fetch_request(queue);
@@ -1347,6 +1349,29 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 done:
 	if (ret == -EAGAIN) {
 		ret = 0;
+	} else if (ret == -EKEYEXPIRED &&
+		state != NVME_CTRL_CONNECTING &&
+		state != NVME_CTRL_RESETTING) {
+		int qid = nvme_tcp_queue_id(queue);
+
+		dev_dbg(queue->ctrl->ctrl.device,
+			"updating key for queue %d\n", qid);
+
+		nvme_change_ctrl_state(&(queue->ctrl->ctrl), NVME_CTRL_RESETTING);
+		tls_clear_err(queue->sock->sk);
+		handshake_req_cancel(queue->sock->sk);
+		handshake_sk_destruct_req(queue->sock->sk);
+
+		ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+					 queue, queue->ctrl->ctrl.tls_pskid,
+					 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+		if (ret < 0) {
+			dev_err(queue->ctrl->ctrl.device,
+				"failed to update the keys %d\n", ret);
+			nvme_tcp_fail_request(queue->request);
+			nvme_tcp_done_send_req(queue);
+		}
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
@@ -1383,6 +1408,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 	do {
 		bool pending = false;
 		int result;
+		enum nvme_ctrl_state state = nvme_ctrl_state(&(queue->ctrl->ctrl));
 
 		if (mutex_trylock(&queue->send_mutex)) {
 			result = nvme_tcp_try_send(queue);
@@ -1396,8 +1422,34 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED &&
+				state != NVME_CTRL_CONNECTING &&
+				state != NVME_CTRL_RESETTING) {
+				int qid = nvme_tcp_queue_id(queue);
+
+				dev_dbg(queue->ctrl->ctrl.device,
+					"updating key for queue %d\n", qid);
+
+				nvme_change_ctrl_state(&(queue->ctrl->ctrl), NVME_CTRL_RESETTING);
+				tls_clear_err(queue->sock->sk);
+				handshake_req_cancel(queue->sock->sk);
+				handshake_sk_destruct_req(queue->sock->sk);
+
+				result = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+							queue, queue->ctrl->ctrl.tls_pskid,
+							HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+				if (result < 0) {
+					dev_err(queue->ctrl->ctrl.device,
+						"failed to update the keys %d\n", result);
+					nvme_tcp_fail_request(queue->request);
+					nvme_tcp_done_send_req(queue);
+				}
+			}
+
 			return;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1705,6 +1757,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->user_key_serial = user_key_serial;
 	}
 
 out_complete:
@@ -1734,6 +1787,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_key_serial = queue->user_key_serial;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
@@ -1742,7 +1796,14 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		return ret;
 	}
+	if (keyupdate) {
+		dev_dbg(nctrl->device,
+			"queue %d: TLS keyupdate complete\n", qid);
+		return 0;
+	}
+
 	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, tmo);
+
 	if (ret <= 0) {
 		if (ret == 0)
 			ret = -ETIMEDOUT;
-- 
2.50.1


