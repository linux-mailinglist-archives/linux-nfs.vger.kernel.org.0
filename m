Return-Path: <linux-nfs+bounces-13657-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F6CB27812
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C63318886A9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB002C08CB;
	Fri, 15 Aug 2025 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/9uAyEy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9A272E67;
	Fri, 15 Aug 2025 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234188; cv=none; b=Gj+ErXRFvRW6Co0D20bMt4f/A6I5L/nmtEJK46xPk501V3MBa1lOyNQ3q8uGvNiwWrCotHci0q0kEdmt9W72Rru/rXUBBYlOsmhjX+9NFqieNa6FYw7sCJGt5iR2/Ps3YLy4+nZXyv6DVHNWof/Kco1PSqkEdBy58Z4+MqZ7n6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234188; c=relaxed/simple;
	bh=dCh75Wq3hVwvqLlJBVYMaqoz++i9yIWJwQlUb56DQME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMukP/bbCT/TFOURIo1r1iMNxE4gWaN+MDRAECvmBFrEF0p6ZeGTYUBkqXKqbvxl73v9rwEWQwdsrzaA5BV1PpKIQzaAu02CuiNcLrfXsa5UutfEZVjKA5TMy3lKqsWe3E5jsTTqAZh9SwgeJJ46FX++TDX+CFudWbUSMnalDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/9uAyEy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so1294308b3a.2;
        Thu, 14 Aug 2025 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234186; x=1755838986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb3D+2Y2P+VKDJSul4hdca7kG6zpe2ME/ptwlX9aheU=;
        b=d/9uAyEy/pk3QQDoG6CwvkbsGMbLKeThE/I3yBxDSOp4YxJwLRgixh+wkOixWwaMeK
         ntTB7d9vyTUeNz2f0vD32Q4zjh0hlRG9oFVxBOWEiOvqosJ/0iOlKUJXpGbDvkC+w4wV
         0pb/6sEaErm8cmlKZlPx1ct47fO0gL0LGK6qIWSBDoRv/1r0o1qKA6VqUaGTp+ICOHB1
         fsS2Txf5ZcOTCEOjb5+QvOfoxBZAxOvsUxV0TZ6sSdDX8lh0mTyvSLDA5J0TQ4rD8HWP
         gEk1dS+jqTiMpM9WhPyvmlY+qKM2hvhV9WNwWqIUrT742cRpS5ew+gmYIw32RLnHwnyS
         x10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234186; x=1755838986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb3D+2Y2P+VKDJSul4hdca7kG6zpe2ME/ptwlX9aheU=;
        b=FhPleoWWFREyg8DbKbE/45H6GImdSp59vJEyl+CTXH9WUjpFH/fh4vXjxOhMm4ywxm
         Me+2aCh7jGaZ97FPB0JNkKPLUQwoKb4AQ2LpQcTqRWZhcclxD8RdqD5qNC6lcp7Ai+An
         JLsF3O98DKUZwJ2SivcEoaZYTfZap7ANGMWATXoa6ZQLRwJrp46WKnoRYvw/LptoZpVz
         snIr9fN6apGPgw7K66yK9ul4Arj9i0WcN4Wv/FNXFgM7dHNUeFTHQnK5MXPmMhXf0GdS
         zYArBZS6Gcs/aSviqCWAR76YjxkDNavYxGkZKA7FnRp2WCk3MZPTYjKnDbFWSamqptR1
         mWkg==
X-Forwarded-Encrypted: i=1; AJvYcCU6J2k7xy1J+kvqBlRlz4oPQOwGJnv1nDrBymRUp0HxuBcXawTq8NfuZtBPIg70/STUWqry7rAmeD8=@vger.kernel.org, AJvYcCU8RFqsLa5d5+f+lT+dhglE09XPtG+G2YvbS/bzu0Yfp6lv8NydhlNscridai2CEVzkNupQ4vSx@vger.kernel.org, AJvYcCV+LuO4oEu4Ei+wM3vUrROf2kj/4vLZWFqE3ldljHiFcwokR+Q7bBSxR4V8qc6n+HSSUPeCSJUTCDeRkpgf@vger.kernel.org, AJvYcCVquweRrbEoY6eSLuI6zsWYXa8TqxW8rE/FGYtgKhlRxoz/er9BjRJj8ImUgpQhSNiWm/tR4q5RVXky@vger.kernel.org
X-Gm-Message-State: AOJu0YxlF7qihy13PGxbEImwIRdejSJt4oxfdr/aowRU/+q/N3UUBwRK
	qriWEI6bLDlKusXQTYtLnbztUW9XrTVtPokTXw6if1cIlYfAlA8zf8ap
X-Gm-Gg: ASbGncvB02ZxSTjRZj3pkSWIZ54UU5eZnA1pbRHg2/a6NrT0bHk20Zhi1xzqQeCL1pQ
	7Y28I4+s+GvOPvenmbRDR/yMA1x7X5sU9pTCxj0GtZG1zSZV2kHWFk9BoTCh6AVoDf4E7Ux/XFL
	Dr52ZgtXhV/CckPhojKcF2ga8B3ALHqAO0Kopql/24yJWcxuTbVL5XDCrolNHFt6G2IKZKyUpSB
	ZWkXHvVkzWJeYE6G0SHiroxzfIpBhwxvTRP27Eei+5dI8ckOZcBZDojSj4aSbJaqq12kQt+O6At
	fzUPhXGGF2+e06ydvpuxfgRkX1L1RR9b30tQbE65db2vE8UCyGgFJVPgK9rzguoxz8jyGP6t6L9
	SwSOpL4ZOLytekM+BWd0ShdGSFe+34HW1uoAabESKVOv2UdAlFSbJ0s9c6TsJBfkY1gnJQu+Bag
	gvz0WX8QfUcsMpuMT/lfh/dkQXsLg=
X-Google-Smtp-Source: AGHT+IFCN3/82QbT1VacGPyrRYv9/F/PPZnJ8Gac/QiInZA+wk35khY28zaLI33nJg2szq2eps4NcA==
X-Received: by 2002:a17:902:e948:b0:242:3855:c77a with SMTP id d9443c01a7336-2446d8c6388mr12741515ad.34.1755234185896;
        Thu, 14 Aug 2025 22:03:05 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:03:05 -0700 (PDT)
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
Subject: [PATCH 8/8] nvmet-tcp: Support KeyUpdate
Date: Fri, 15 Aug 2025 15:02:10 +1000
Message-ID: <20250815050210.1518439-9-alistair.francis@wdc.com>
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

If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
a KeyUpdate handshake type then the underlying TLS keys need to be
updated.

If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe host sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/tcp.c | 59 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5eaab9c858be..1dc6fa28d08c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		user_key_serial;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -836,6 +837,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	return 1;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
+static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
+#endif
+
 static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 		int budget, int *sends)
 {
@@ -1114,7 +1120,7 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
 	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
-	u8 ctype, level, description;
+	u8 ctype, htype, level, description;
 	int ret = 0;
 
 	ctype = tls_get_record_type(queue->sock->sk, cmsg);
@@ -1135,6 +1141,29 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		htype = tls_get_handshake_type(queue->sock->sk, cmsg);
+
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+		if (htype == TLS_HANDSHAKE_TYPE_KEY_UPDATE) {
+			tls_clear_err(queue->sock->sk);
+			handshake_req_cancel(queue->sock->sk);
+			handshake_sk_destruct_req(queue->sock->sk);
+			queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+			/* Restore the default callbacks before starting upcall */
+			read_lock_bh(&queue->sock->sk->sk_callback_lock);
+			queue->sock->sk->sk_user_data = NULL;
+			queue->sock->sk->sk_data_ready = queue->data_ready;
+			read_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+			return nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+		}
+#endif
+		pr_err("queue %d: TLS handshake %d unhandled\n",
+		       queue->idx, htype);
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1344,7 +1373,29 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
-			nvmet_tcp_socket_error(queue, ret);
+			if (ret == -EKEYEXPIRED &&
+				queue->state != NVMET_TCP_Q_DISCONNECTING &&
+				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+				tls_clear_err(queue->sock->sk);
+				handshake_req_cancel(queue->sock->sk);
+				handshake_sk_destruct_req(queue->sock->sk);
+				queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+				/* Restore the default callbacks before starting upcall */
+				read_lock_bh(&queue->sock->sk->sk_callback_lock);
+				queue->sock->sk->sk_user_data = NULL;
+				queue->sock->sk->sk_data_ready = queue->data_ready;
+				read_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+				ret = nvmet_tcp_tls_handshake(queue,
+							      HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+#else
+				nvmet_tcp_socket_error(queue, ret);
+#endif
+			} else {
+				nvmet_tcp_socket_error(queue, ret);
+			}
 			goto done;
 		} else if (ret == 0) {
 			break;
@@ -1798,6 +1849,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->user_key_serial = user_key_serial;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1843,7 +1895,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
 
-	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE && !keyupdate) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
 		return -EINVAL;
 	}
@@ -1856,6 +1908,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_key_serial = queue->user_key_serial;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
-- 
2.50.1


