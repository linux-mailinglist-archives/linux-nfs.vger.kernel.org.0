Return-Path: <linux-nfs+bounces-16288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD73C5084B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 05:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E67D34C1AA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 04:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9192D8763;
	Wed, 12 Nov 2025 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEKSnbU2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4F2E62C0
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921726; cv=none; b=IsdvSX3Ta5i/DREuUQ4VgyMV1AbqSWEynu9vPjEYJTI44co9aoSDhe7Wxcz0lKoci0AJuVG7kuBVtJuhvuMgZ9SL59rsHvSgDsOKuPnYAVB2NYQC65aYH2LsRdkGhgNRMdQtvHykqlUbuZbmf4M2vJ2YzfN3OnypG2uSHmP8ksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921726; c=relaxed/simple;
	bh=jCDpx8M8k0FKY4eSBRvHYTTF69BLGw4kLu44e9Ryamc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqQyQdS5qw+Wgn2L87V1ulvZpOJQ7cXJCMhoONkr6sFaKMK/6prb+BKwLPFN6aewSwiJnMRFs4c6Lf3SkA8TVsLrh72zavmJPOLJX+Dqnf8Z4kKwJZDE/+GjGdEq7Mmkc/d5Pnl8mzh5lsRiEr0S+LTxKJtPLGC4joIsi7Mj5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEKSnbU2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3434700be69so579675a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 20:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921723; x=1763526523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bypbKJSNdfzMIo5PJqXm9z2sZhPniVXZs5eZRTP+WOQ=;
        b=nEKSnbU2JVPJe8mg2mQEPIZJlETYi07y8OyyipoUX8RXUqjupW0KuGMInnX0H44kVL
         WFw3fK4ti9RSjJedsu/bA7G0X/q/mkrmsF/4OQ1fWJ+ZmoMN+m8gdcPkWf2t3FuUEmP8
         X8jAl0keiTZOnkgu50MI1mATgeef0a5r56GlEwi5V6sN5ELNB2OVtGUyW8Q+9g430eLG
         NZfDtjC7nfKXioqIUeLE8B81wr6JCGkVippy5PNSq4HzC9aKPKy/yao3fAwAs6QtyJNz
         0TcSi1H+die+YJFFt3X9GMeiIcJM66VhYLjeQ1nkUCr7qOweRSuiw7zdXEOWmJZOuloO
         B6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921723; x=1763526523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bypbKJSNdfzMIo5PJqXm9z2sZhPniVXZs5eZRTP+WOQ=;
        b=GWFwRyB6HHLp73wLzc9Ta7j+mlmMRriU5Pp6S4vivu5lJiEk1sbkHs2g8I7Mwt9nFY
         BBdrKijALcdrYKK2zjEd5DWGrv6MfFwWJTs6YED4eSePlI4EwayGyz5n8V7Bt/cWtyIw
         8KySizch1Yan/qjYi9TfYg41YWz8y6XQvVMjzEJObLDGLuiIb/tKgnI18HgVVC1AgW4a
         yl3BDrJGwWn0RRy7eXEnYPcrKZGIK3EZRpG27Q8V26o/RCoTI+m9TAXwToHrX7pFpTXA
         2iGc3p1ndUy2faAmj60256tHKvtD2L0vZ7ipoqlTcT1MhwqHASoeC2fhUKG+HPAu0ZBj
         Nnjw==
X-Forwarded-Encrypted: i=1; AJvYcCWsehSSguHrE3zPlhrRS9nvkvfw0+YEqoH5c2OxP1wUtVHswmNpFoBw6DPErGZG9FTmlvvxcOxiOT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbW769Fc5Jt5wOQrPBnXTiasGK+lkh70Jjoq2LzpvPyXE2K18p
	3L8tunyT9aSm9aVjnRWvGrGlCxMZrAE+vVW50CJBhdTDYUh72NGnN9qy
X-Gm-Gg: ASbGncvPJcvILPFTu86YH4G3AalAM5+eSmxQrS41Q6pNSU0zAQEsw5co6Sep/gX2oZB
	+bUTxEvBrPF2e3HmW2g9t3fN9bw+FdhxkYbq+iuGdXRY7KcIxASxLMMb02m/rfVG/JNc9BCzzxv
	QXTUvE/cyV/wpnulw6jVAXowNu4Zz3o92792vh3shmH3CZhyxbgng6GTKD3sN7tUYQ4JSU7cdqX
	zAwzrRdtAFZkOVa8uxEGqaX8lBxJCqflariFi44PWtqWEdsnfRfPa6ngth5g7gy5VvI/A34lllY
	tLMOBfI2NJod8/Q0HikwNqeMzpqSAYCXK5c+1fjQ2oqP7Peh9TfqeVLBnrCtLjf5F52tW9wsW3G
	UOAOyrw2WVG8Uy6Ui2W61+gaEG24lV+EjHnh51eASmdmIuWH6C2GK0MbC7/eIsPslQhLC/x7gYN
	gB34ogD5zFGobpr4ETVt3WmvycpYe3lNBCtKyIMB9yH/iPaz4nkZ1GLA+KN7l0RaZJvT5zg/njf
	1mAgK5/7w==
X-Google-Smtp-Source: AGHT+IEk3fmOmPuZqt1xGOcbomb+tiqKdW76DJidL9Gpiy8ngxFNpe36IzIVYCCq1TjDctRIbXHwUg==
X-Received: by 2002:a17:90b:1dce:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-343ddeff608mr2144322a91.37.1762921722670;
        Tue, 11 Nov 2025 20:28:42 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:42 -0800 (PST)
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
Subject: [PATCH v5 6/6] nvmet-tcp: Support KeyUpdate
Date: Wed, 12 Nov 2025 14:27:20 +1000
Message-ID: <20251112042720.3695972-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - Restructure code to avoid #ifdefs and forward declarations
 - Use a helper function for checking -EKEYEXPIRED
 - Remove all support for initiating KeyUpdate
 - Use helper function for restoring callbacks
v3:
 - Use a write lock for sk_user_data
 - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
 - Remove unused variable
v2:
 - Use a helper function for KeyUpdates
 - Ensure keep alive timer is stopped
 - Wait for TLS KeyUpdate to complete

 drivers/nvme/target/tcp.c | 203 ++++++++++++++++++++++++++------------
 1 file changed, 142 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 818efdeccef1..486ea7bb0056 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
+	key_serial_t		handshake_session_id;
 	struct delayed_work	tls_handshake_tmo_work;
 
 	unsigned long           poll_end;
@@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
 	struct sockaddr_storage	sockaddr_peer;
 	struct work_struct	release_work;
 
+	struct completion       tls_complete;
+
 	int			idx;
 	struct list_head	queue_list;
 
@@ -214,6 +217,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   enum handshake_key_update_type keyupdate);
+#endif
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -832,6 +839,23 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	return 1;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	if (ret == -EKEYEXPIRED &&
+	    queue->state != NVMET_TCP_Q_DISCONNECTING &&
+	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
+					return true;
+
+	return false;
+}
+#else
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	return false;
+}
+#endif
+
 static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 		int budget, int *sends)
 {
@@ -1106,6 +1130,103 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static void nvmet_tcp_release_queue(struct kref *kref)
+{
+	struct nvmet_tcp_queue *queue =
+		container_of(kref, struct nvmet_tcp_queue, kref);
+
+	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
+	queue_work(nvmet_wq, &queue->release_work);
+}
+
+static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
+{
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		/* Socket closed during handshake */
+		tls_handshake_cancel(queue->sock->sk);
+	}
+	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
+		queue->state = NVMET_TCP_Q_DISCONNECTING;
+		kref_put(&queue->kref, nvmet_tcp_release_queue);
+	}
+	spin_unlock_bh(&queue->state_lock);
+}
+
+static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
+{
+	struct socket *sock = queue->sock;
+
+	if (!queue->state_change)
+		return;
+
+	write_lock_bh(&sock->sk->sk_callback_lock);
+	sock->sk->sk_data_ready =  queue->data_ready;
+	sock->sk->sk_state_change = queue->state_change;
+	sock->sk->sk_write_space = queue->write_space;
+	sock->sk->sk_user_data = NULL;
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+}
+
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
+{
+	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
+			struct nvmet_tcp_queue, tls_handshake_tmo_work);
+
+	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
+	/*
+	 * If tls_handshake_cancel() fails we've lost the race with
+	 * nvmet_tcp_tls_handshake_done() */
+	if (!tls_handshake_cancel(queue->sock->sk))
+		return;
+	spin_lock_bh(&queue->state_lock);
+	if (WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)) {
+		spin_unlock_bh(&queue->state_lock);
+		return;
+	}
+	queue->state = NVMET_TCP_Q_FAILED;
+	spin_unlock_bh(&queue->state_lock);
+	nvmet_tcp_schedule_release_queue(queue);
+	kref_put(&queue->kref, nvmet_tcp_release_queue);
+}
+
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	int ret;
+
+	cancel_work(&queue->io_work);
+	queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+
+	nvmet_tcp_restore_socket_callbacks(queue);
+
+	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
+			  nvmet_tcp_tls_handshake_timeout);
+
+	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete,
+							10 * HZ);
+
+	if (ret <= 0) {
+		tls_handshake_cancel(queue->sock->sk);
+		return ret;
+	}
+
+	queue->state = NVMET_TCP_Q_LIVE;
+
+	return 0;
+}
+#else
+static int update_tls_keys(struct nvmet_tcp_queue *queue)
+{
+	return -EPFNOSUPPORT;
+}
+#endif
+
 static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 		struct msghdr *msg, char *cbuf)
 {
@@ -1131,6 +1252,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1340,6 +1464,8 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
+			if (nvmet_tls_key_expired(queue, ret))
+					goto done;
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1351,29 +1477,6 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	return ret;
 }
 
-static void nvmet_tcp_release_queue(struct kref *kref)
-{
-	struct nvmet_tcp_queue *queue =
-		container_of(kref, struct nvmet_tcp_queue, kref);
-
-	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
-	queue_work(nvmet_wq, &queue->release_work);
-}
-
-static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
-{
-	spin_lock_bh(&queue->state_lock);
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		/* Socket closed during handshake */
-		tls_handshake_cancel(queue->sock->sk);
-	}
-	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
-		queue->state = NVMET_TCP_Q_DISCONNECTING;
-		kref_put(&queue->kref, nvmet_tcp_release_queue);
-	}
-	spin_unlock_bh(&queue->state_lock);
-}
-
 static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
 {
 	queue->poll_end = jiffies + usecs_to_jiffies(idle_poll_period_usecs);
@@ -1404,8 +1507,12 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
 		if (ret > 0)
 			pending = true;
-		else if (ret < 0)
+		else if (ret < 0) {
+			if (ret == -EKEYEXPIRED)
+				break;
+
 			return;
+		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
 		if (ret > 0)
@@ -1415,6 +1522,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+		pending = true;
+	}
+
 	/*
 	 * Requeue the worker if idle deadline period is in progress or any
 	 * ops activity was recorded during the do-while loop above.
@@ -1517,21 +1629,6 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
 	kfree(cmds);
 }
 
-static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
-{
-	struct socket *sock = queue->sock;
-
-	if (!queue->state_change)
-		return;
-
-	write_lock_bh(&sock->sk->sk_callback_lock);
-	sock->sk->sk_data_ready =  queue->data_ready;
-	sock->sk->sk_state_change = queue->state_change;
-	sock->sk->sk_write_space = queue->write_space;
-	sock->sk->sk_user_data = NULL;
-	write_unlock_bh(&sock->sk->sk_callback_lock);
-}
-
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
@@ -1794,6 +1891,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->handshake_session_id = handshake_session_id;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1809,28 +1907,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	else
 		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
-}
-
-static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
-{
-	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
-			struct nvmet_tcp_queue, tls_handshake_tmo_work);
-
-	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
-	/*
-	 * If tls_handshake_cancel() fails we've lost the race with
-	 * nvmet_tcp_tls_handshake_done() */
-	if (!tls_handshake_cancel(queue->sock->sk))
-		return;
-	spin_lock_bh(&queue->state_lock);
-	if (WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)) {
-		spin_unlock_bh(&queue->state_lock);
-		return;
-	}
-	queue->state = NVMET_TCP_Q_FAILED;
-	spin_unlock_bh(&queue->state_lock);
-	nvmet_tcp_schedule_release_queue(queue);
-	kref_put(&queue->kref, nvmet_tcp_release_queue);
+	complete(&queue->tls_complete);
 }
 
 static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
@@ -1852,11 +1929,15 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.handshake_session_id = queue->handshake_session_id;
+
+	init_completion(&queue->tls_complete);
 
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
 		ret = tls_server_hello_psk(&args, GFP_KERNEL);
 	else
 		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
+
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
-- 
2.51.1


