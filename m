Return-Path: <linux-nfs+bounces-14060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2838B44BDB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9A3A1DC1
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A972798ED;
	Fri,  5 Sep 2025 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onht9wzt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68127A452;
	Fri,  5 Sep 2025 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040484; cv=none; b=OlhMzZWhEUU/i8lOm21ASO02tk2d24UrUc1CjDTj9Fh+Wd8WXOyGpm05qbh/6lnvT86FGZ2uN8aNOp0v3CHm9WkN7qK9QGzpZ6Q7QsNKZLOyqed8fTyORzNT0V7cULxR5tnnsGOXAoetC4qPXbVD5E7GTif/HgTtDmc28xnZOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040484; c=relaxed/simple;
	bh=4UK7rmAawgGhsA0773xymZJziO6ODcvic3H/BSJy6es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG01pxF/wS0sYqASlH+8kwx7l7ETcE7Nlx7HyNTh/r5SS6oGabORQxFp+apkpQVCRSReR5Oqm+IlxgBodPiKStoLbwNTlZkELjzCxwDc7MU7p+SFEj0otwuZTCClJk8edKB5LrPx3S5DqJzzJY/iw7pBVtUV9tsekdrn8LeDVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onht9wzt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7723bf02181so1335629b3a.1;
        Thu, 04 Sep 2025 19:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040481; x=1757645281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5nwaGiejZsttf0FEnMcnunXH9MjlWaby5e6Q0AV81Y=;
        b=Onht9wztxgsmN1hmdmx7c6PzyspzNzy+hj+PYDcE7Z1iDp+U2Wp5x+AQ2IyQUzVxyV
         1nNTCWmj+GDxFzyq1P+nO9TSgsSm23nkelWkZftHJwudJlNqIhp3gIz+uM5eHtmmPONw
         hTAcJXiDRGQOuvdGsotDLpD+HsrmrNZ1QV/oPSQN3cGLvO4Rs1G4WWhLkz82HVcCwqMR
         w2HNtd9cemjZtgn2pMxe7mmo7ejX3A5a1npnGIYcUcsJOZ2BFxf2pgE7VTa6t3LHmNii
         d8GVHBhJzEd2bLKcfXekvAdI5B7RhtcV5Sto6xUFmLhiSZBqALhzjJBZVZvMJ6t206uT
         MSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040481; x=1757645281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5nwaGiejZsttf0FEnMcnunXH9MjlWaby5e6Q0AV81Y=;
        b=G5iO5YAVAflj/6fne1FV2cjhSQbWAYrXwl7ROL9rKtuQ7OU6M9lpIiLNyorfhqf1BR
         QiAkCTS23J+E3bH3AYtJ4uxyMzISQLz8xgXYy48N0upzUSkl5JtlkHcgHKEpfrRSbYZY
         IM8nit6izSDLJYV7H7IvEZgbxv+w1C+YBw/TgTIyBSAMcaYVk6odBmbYAqz9c1nTaoUU
         8YvK8mQx7gUnyujnzBCOhdcmfxNW/Jivkf/UjgzjBjB9pGQczEh95viHICAeanAOHuwd
         iCniPsQlEY/arAxNXoCRqdto7IXw32Di7xjNpAht6ItxI0S5Fu4jL1D4NJ55guHhO+Rg
         izZA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Dp0aMKGD2aqrZxpMgTOPSU2b1EXeAwvRiC86l5OceBjknXdpUTmKOcy5TyCfn0Jp9MfXkehd@vger.kernel.org, AJvYcCVA0CF8dYJGn4n2jjghZn43pbxsVvNs2h/oi0qfo2tjNqdfo5vL2woUEN23z265lZxoH/gAP/AgxS3hVdTW@vger.kernel.org, AJvYcCWAI7WCh3dnr2RZnz9BYoVc8k6Ga5RQ2ilZhprwA7bDlfGRTyQ2TUxulvggVK+1HQdDVF1QTxvguuI=@vger.kernel.org, AJvYcCXiqHGfU3HwuGVANijNio417k9u2XZL6HkXQQAvGc/7In96TJQXfVP+xeTEAGJuYsX5SN336QS7Qs6S@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJfsym8ZEzzIgJ3AcBdNdoQ/yAVRy7bgEe2hqj5BlZanp3Dbn
	tirj59NeIGcWI457t19nVKR4ylDEU8XCqPjzo8XOXxnXSHxtH415llOV
X-Gm-Gg: ASbGncugZ/4C7hw45Msre4uLEqjZmsvBsubhXHy0hlIchfTd9d43Rg4HkmCQfA2I/Xk
	kWzfBpxlIhgx/jBhYU1YrvOgNFDN2szOSSnBnacOYSFo6k5kIrRX+jfMRGeTFjS3VsDe2pMERpr
	+1sWb3P9+hRRdwJQpPTdi3ns49q7D+XdP159R9FfPN+tjgraS0WfGz/q8cddUFrFHZu0qfDVUHF
	+bgD15up5/JCrQOHy6Kf5/SAIkm+XVfkd1yLFXOdoUdwIzNo7iMOUMdjOe8vmJy/29CzVOfkO9o
	iNuTGdGjNYT+zX+huHgMheV9r8inTZVqHDxvZ5/Hc/8wtKfWMPC8E/3oxWbCXeSoeHEOLX2I7uU
	Lt1BRHr5bi5ZwGwQ3XyBDW6Bg16eXXi4ekcmBnFnvu2H7UVy6/1vtdud54BaIk0CIuBgv/wrfcO
	mxl5A9UOdRM8+J+czIXqq75ppQ5i0=
X-Google-Smtp-Source: AGHT+IFw5bdrv/yE14vwPnoYgwhMXZlYXMIsK0giGOwHSUwOupBk+Zwq5d32aYQQabxamDe4WIODOA==
X-Received: by 2002:a05:6a00:1956:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7723e1f4f4cmr23642414b3a.7.1757040481393;
        Thu, 04 Sep 2025 19:48:01 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:48:00 -0700 (PDT)
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
Subject: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
Date: Fri,  5 Sep 2025 12:46:59 +1000
Message-ID: <20250905024659.811386-8-alistair.francis@wdc.com>
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
v2:
 - Use a helper function for KeyUpdates
 - Ensure keep alive timer is stopped
 - Wait for TLS KeyUpdate to complete

 drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index bee0355195f5..dd09940e9635 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		user_session_id;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
 	struct sockaddr_storage	sockaddr_peer;
 	struct work_struct	release_work;
 
+	struct completion       tls_complete;
+
 	int			idx;
 	struct list_head	queue_list;
 
@@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
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
@@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
 		if (unlikely(ret < 0)) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+			if (ret == -EKEYEXPIRED &&
+				queue->state != NVMET_TCP_Q_DISCONNECTING &&
+				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+					goto done;
+			}
+#endif
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1110,11 +1125,52 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	int ret;
+
+	cancel_work(&queue->io_work);
+	handshake_req_cancel(queue->sock->sk);
+	handshake_sk_destruct_req(queue->sock->sk);
+	queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+	/* Restore the default callbacks before starting upcall */
+	read_lock_bh(&queue->sock->sk->sk_callback_lock);
+	queue->sock->sk->sk_data_ready =  queue->data_ready;
+	queue->sock->sk->sk_state_change = queue->state_change;
+	queue->sock->sk->sk_write_space = queue->write_space;
+	queue->sock->sk->sk_user_data = NULL;
+	read_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
+	nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
+
+	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
+			  nvmet_tcp_tls_handshake_timeout);
+
+	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, 10 * HZ);
+
+	if (ret <= 0) {
+		tls_handshake_cancel(queue->sock->sk);
+		return ret;
+	}
+
+	queue->state = NVMET_TCP_Q_LIVE;
+
+	return ret;
+}
+#endif
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
 	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
-	u8 ctype, level, description;
+	u8 ctype, htype, level, description;
 	int ret = 0;
 
 	ctype = tls_get_record_type(queue->sock->sk, cmsg);
@@ -1135,6 +1191,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1344,6 +1403,13 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+			if (ret == -EKEYEXPIRED &&
+				queue->state != NVMET_TCP_Q_DISCONNECTING &&
+				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+					goto done;
+			}
+#endif
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1408,14 +1474,22 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
-			return;
+		else if (ret < 0) {
+			if (ret == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			else
+				return;
+		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
-			return;
+		else if (ret < 0) {
+			if (ret == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			else
+				return;
+		}
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
@@ -1798,6 +1872,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->user_session_id = user_session_id;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1813,6 +1888,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	else
 		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
+	complete(&queue->tls_complete);
 }
 
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
@@ -1843,7 +1919,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
 
-	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE && !keyupdate) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
 		return -EINVAL;
 	}
@@ -1856,7 +1932,9 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.user_session_id = queue->user_session_id;
 
+	init_completion(&queue->tls_complete);
 	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
-- 
2.50.1


