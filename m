Return-Path: <linux-nfs+bounces-16837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3ABC99C72
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 02:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662543A172C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1F2405EB;
	Tue,  2 Dec 2025 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVQJ0xCV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BC243387
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639338; cv=none; b=oXtVBXVJJmIxS567rsduRxbt2GsFNkfrDHKBTnv5LGP+7EsDpBl8XM2Dbge5inj1d6U7TkCciDZ6Mviz2uxzi6yGrGAOVCCbJMkMk3X3o/sW3U5d0qbKCx3zESK9szIaXeShw4+GIdoSerYHE3Lfz58yMvaTtA7gTz8HLNglGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639338; c=relaxed/simple;
	bh=aX4b/dtOJbU7+H1rQfMiZQtLMAdUZ1mamd1Fipz5Mhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIFZ1qhaZz1ACYQSxm0SurnFk8vpxgmRH0Nrw8mtH4hDiJBVYBU9o5byvj91OXDsv+1IQP1Y8zZcMS8gyKkjujCDn1Id9ESGafcoJbOj2XAwBKG8q7CT0b3QryNaYn+DRndXxc0Q8ttkoL+eoVKHkT6PhxPZOjPgk3uh5y7eVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVQJ0xCV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2955623e6faso53872515ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 01 Dec 2025 17:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639335; x=1765244135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/I0auzUVkVcxbH70BIVYr6yUr92WLMw+xrjecYcacA=;
        b=QVQJ0xCVxeIp4RsWB3gy57tU3EvfGIUOpHBKVZE9Uujn4wc2Lx34NMCm166iFJV04R
         hGNTWmYqpuQG0KfJ4sTfRw22jPJyONeMvbmldMn2LUqI5RVSHKs0HU50Gq4lMbHejlp0
         zMIf8znfHfFwRtjLxZFM0Oxm7ajZUpA9DOAFEiT7fRDHtB9m9+bJw+YhitK2mbN5pMsb
         x8bd449toAq7D13nCbPirUHwmRiY7RKgjVC9u2eYWzgNafN13gvu9/e/UIap5ecFn2NG
         grPF3Ob973ZB1S0bPPIe5Z+GzAlVzPqr8/9+jmAKJ0dow/KdYGWMKC7EtyBk/dOtH8qv
         0GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639335; x=1765244135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/I0auzUVkVcxbH70BIVYr6yUr92WLMw+xrjecYcacA=;
        b=UtH9fvq5Jdu2zoRWIisf9RgSLvNy/oJnnVqi3KQyGwMk5uAVbBka+My57ZScnHtfri
         40l3F7jq5oc2vtlAT2/Bn1PoNkqf7za/Tx7edWCSNHoqFO60wuIydL+IquVKy2Ihs9Tj
         FP9m6F60CimJVpCpxsViYLDKFsXYvrONS5wwalezCXlDtApaSTme+R86w297BTbtv5vq
         DYy3z1N5dKkqa9yPCl/nTi5wTZQGlKWpw1N+sYxn2MDZ8wD47tTfm7UBaoj3eVlI4Tnb
         echf09OshetsWEOOrGkPWqUQ1pBfwnvLusgNbH4lqy9zW2XYDwR9AIPZiOuzRIgmX2Xc
         Tu1w==
X-Forwarded-Encrypted: i=1; AJvYcCW//juDmenDCKbNlgZXlhEgsHl+g9/j703+wvBLmxZx/Rnh23pILesatLU+cfkF+jv5+fqPf3bSbV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJttpT5A+jfBXNvI97b+XDqVDVYRne3QZqcL05h6WRy1LsDSKe
	0Iu3ybgtzfhYlhVGwxm2TCwuijv/qdqwyc+cfqpXwUYQkV0xd4sru2aP
X-Gm-Gg: ASbGnctZQ95yQZ/lHMI7xbtn0jLfFv7E4M5ZxkkfqbIY6lSAdFQRNk+nqtPTHBIZ1ZJ
	btAYoQ4zmfV5+uVo1TtT8Ja1w93DIqnjfGV7FyGJUu9FHCmEOlDQvb2w6bdPxb04tWj15fzZQ5x
	b6FLOHyEvYG3w6fu+lr2HJiDZPfbOTmibjcPPyNozoz64FE+U7pFa89ENuUC0Q1jvY1GNbnc6Cy
	CMSV6AtzmrX/hQyRoQVJbSpnJrJ/9n1pzj1J0HlwSMp8QiSfss6GZQxoN4wnOQr7T7oJPxsbfNU
	RPm/BL2A6SSlDPZfvKBlg1HbsQoybEYgiBVDIbWpu8GDzoVfE0jWD4kpdSGzC6Rv/Ka1H+B9Sir
	XPRKBG+ri7BylwcrPBlf+/nFF4Bkb/xdUCy84wUYh/eln7AIuRjAHeaFuYTByQB6OGcOEdyyAv1
	vLsJNjmtMgo0HAXZNytFyPQHMCo/ww7ENxpWwvgkRwmvMMo+XGALNKbDyz0dk8LHRIlXP4qcJQD
	p5q5crRrbpiVMtTH4A=
X-Google-Smtp-Source: AGHT+IGQK/nb9FASk2chWpg9Ni/OJR5AgPXn3/ZK8ZXqfQ8nOYrkMVsl+JxFYgH88N7Fd3k6akiHDQ==
X-Received: by 2002:a17:903:1670:b0:295:3ad7:948a with SMTP id d9443c01a7336-29baaf9a961mr298440265ad.16.1764639335372;
        Mon, 01 Dec 2025 17:35:35 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:34 -0800 (PST)
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
Subject: [PATCH v6 5/5] nvmet-tcp: Support KeyUpdate
Date: Tue,  2 Dec 2025 11:34:29 +1000
Message-ID: <20251202013429.1199659-6-alistair.francis@wdc.com>
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
v6:
 - Simplify the nvmet_tls_key_expired() check
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

 drivers/nvme/target/tcp.c | 200 ++++++++++++++++++++++++++------------
 1 file changed, 139 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 818efdeccef1..0458a9691cbc 100644
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
@@ -832,6 +839,20 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	return 1;
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
+{
+	return ret == -EKEYEXPIRED &&
+		queue->state != NVMET_TCP_Q_DISCONNECTING &&
+		queue->state != NVMET_TCP_Q_TLS_HANDSHAKE;
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
@@ -1106,6 +1127,103 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
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
@@ -1131,6 +1249,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 			ret = -EAGAIN;
 		}
 		break;
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		ret = -EAGAIN;
+		break;
 	default:
 		/* discard this record type */
 		pr_err("queue %d: TLS record %d unhandled\n",
@@ -1340,6 +1461,8 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
 		if (unlikely(ret < 0)) {
+			if (nvmet_tls_key_expired(queue, ret))
+					goto done;
 			nvmet_tcp_socket_error(queue, ret);
 			goto done;
 		} else if (ret == 0) {
@@ -1351,29 +1474,6 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
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
@@ -1404,8 +1504,12 @@ static void nvmet_tcp_io_work(struct work_struct *w)
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
@@ -1415,6 +1519,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
+	if (ret == -EKEYEXPIRED) {
+		update_tls_keys(queue);
+		pending = true;
+	}
+
 	/*
 	 * Requeue the worker if idle deadline period is in progress or any
 	 * ops activity was recorded during the do-while loop above.
@@ -1517,21 +1626,6 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
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
@@ -1794,6 +1888,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status) {
 		queue->tls_pskid = peerid;
+		queue->handshake_session_id = handshake_session_id;
 		queue->state = NVMET_TCP_Q_CONNECTING;
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
@@ -1809,28 +1904,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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
@@ -1852,11 +1926,15 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_handshake_session_id = queue->handshake_session_id;
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


