Return-Path: <linux-nfs+bounces-15316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E2BE64B6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35BC9352195
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A999C30FC15;
	Fri, 17 Oct 2025 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esy274jG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCF30F55E
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675040; cv=none; b=FvI0blpn3CFDWiycH6MDC357GVyDN7f0Vp0ZGdGx7YUfKdpRPaMDm7JW47vSMUnCJnaTCcfiWK/UWXZdoWJdtr98oGonMyCm0t4w7WVJQSI9GJ5iGc6x3DciVk62RmTu9BlBNad23pWXcEJdbKX3V4lnuqIxKkoYXRLIxmEMHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675040; c=relaxed/simple;
	bh=+ekasFalVsXJKFZ9kzxIalWIkPkrJVW8hYut5gHfJbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB6udC+AIqW2poB0BVUKrhFw/rBKNdxbORsv7rQIIx/BKvZ60pGiIrE4EEkPhKtx+ZAXkICZHEIrO6y+mtkUMc/DVGQRtYtBp1V6Zq172LOV33HuvD2KwYV2j0GfluGlTaYv1P08XNw85njvKYab179szCsFzrP8tzTGOB2XHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esy274jG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so1445622a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 21:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675036; x=1761279836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU16oluyBYBU5AvUVieF6f38wb8silk8996KSyx/0bI=;
        b=Esy274jGHQrZ3W5XcSbw1k4h1dMVdbREWuq2I0kxsSSRGKZx30cy8NjMaxAIOJJ138
         gSh+Nc2+VD6madEFbYndxt9Jwkd2CWpgfllYXeah45Pz4WUFVfVpBMwNHHefW5EsJTCy
         CnbbA+slk3CyapEvJRHx47cFy+SgbOsYtMk2h8bX+aR2myi1GEboHvd4jf9N5IjLxg/a
         HRWDpowjAlrBW4mrNhmSzmk40Ksb5mtqytHA8Ixxd/SPpw1UoTc63eZz7k7/zsCL1+rQ
         UY/I6ckNSXmJTfORJUf++RbcQIUnUq/yfHNn9DRLYmtx87BIDUYum3XvnXYesyKAw3n7
         TYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675036; x=1761279836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU16oluyBYBU5AvUVieF6f38wb8silk8996KSyx/0bI=;
        b=ubyoUHuoCCcjbqEIAG0CIMJOO6INUbIKTyitnjiv3f0NQbsAhL9A0yXltQ+yZsvwUd
         GAnf2UCgvQJkPHW69KCU+3Ni098P28DrG7PCGVTYLzz4sLZ0g5b+qLsgPJpYC/frNUfs
         zKovY3c6ptz0DOBHJzaytMPnH63f3hrJ75K8+6HKqzwr3n0KKZXaUKMNWGaNpuiv2p4K
         hPJcR/sJDSD2xsXY4+NhugAMQuOiVl7FPmxugiIG4+aY46KSKWQ13KEobsbBaKaiBTMm
         c0X6H1gmTSgmJLO5CXUrJ3GqAWQYTspWIE9Ts7U+CvUxcYwCCkdK2eGgMNLbmu3JkZ/c
         Z6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAilfN77Q2x7RwtIfXOUQR8p6PncpdGlevkFCMW389B6lHLjPUBtAgIiEgRhjNaDjz9xnc+4DXuGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87BgDPRZ2OfSreVgDYU0ulXIZSXZnEmu/qrbqgt3vn3bbPAiX
	7r1tmniFivD3TqXMJNLsYpi4C9LaXro2XLkjMuR1WVjETgWKt/QJIQ5Z
X-Gm-Gg: ASbGncteQYdZo/4JfENhJWBCtw2JXD1Od0cc25MttdyVoZXel30QiH0wIUbsxUo1W9i
	B1B83oaQCwz4YnpivOSKq1fd7HtJea1FAJlK8qFt/MVnDv+v7va6R4VBQ9uQ7+7r5hPKkC6PuzL
	XjuV4aM6Wfh4Y0fwBReSRDZohmzg9ffmaMx/4Z3rtpf4NYsEczrTk8TpOfluLo9kbmD4XML9s4e
	5SxF7jhibI67HIoqrWVbHNxh61uiKFTx9Wp6JZqS5/YPUTm1YdXnKgunRUDPrA164JrbaSaEDL6
	0e38sYb61vZtEbz1pkPiLLO76pmkGCVJyuBF/1LH32RhLO7ZMyd1ObIGghgpIUoI1qLIdjRYoCg
	KPeNvsH4l9rz0FYlOuc0kN6Rz+MAMWQZ3K9v9qxh87oE9BDmxaCZAju6H9+9UJ3OmwlYj7v3kUv
	k/gm+iRkN2ibOaqlf7A9xtkF+bjdzWMyqLYxJrb7L+zFWmfItDoI/35EX3OlHltNn/vjywewJE8
	bwvEjpYto9K2dAORYub
X-Google-Smtp-Source: AGHT+IGLOnUugbLEaMm8emhVTwGbBDc/InDpSx6ku4mK0z8X35Z7r6wOx9oRpJvKxnCh9rM5u21MKA==
X-Received: by 2002:a17:90b:180a:b0:329:7285:6941 with SMTP id 98e67ed59e1d1-33bcf8e4e35mr2895374a91.19.1760675036441;
        Thu, 16 Oct 2025 21:23:56 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:55 -0700 (PDT)
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
Subject: [PATCH v4 4/7] net/handshake: Support KeyUpdate message types
Date: Fri, 17 Oct 2025 14:23:09 +1000
Message-ID: <20251017042312.1271322-5-alistair.francis@wdc.com>
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

When reporting the msg-type to userspace let's also support reporting
KeyUpdate events. This supports reporting a client/server event and if
the other side requested a KeyUpdateRequest.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v4:
 - Don't overload existing functions, instead create new ones
v3:
 - Fixup yamllint and kernel-doc failures

 Documentation/netlink/specs/handshake.yaml | 16 ++++-
 drivers/nvme/host/tcp.c                    | 15 +++-
 drivers/nvme/target/tcp.c                  | 10 ++-
 include/net/handshake.h                    |  8 +++
 include/uapi/linux/handshake.h             | 13 ++++
 net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
 6 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index a273bc74d26f..c72ec8fa7d7a 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -21,12 +21,18 @@ definitions:
     type: enum
     name: msg-type
     value-start: 0
-    entries: [unspec, clienthello, serverhello]
+    entries: [unspec, clienthello, serverhello, clientkeyupdate,
+              clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
   -
     type: enum
     name: auth
     value-start: 0
     entries: [unspec, unauth, psk, x509]
+  -
+    type: enum
+    name: key-update-type
+    value-start: 0
+    entries: [unspec, send, received, received_request_update]
 
 attribute-sets:
   -
@@ -74,6 +80,13 @@ attribute-sets:
       -
         name: keyring
         type: u32
+      -
+        name: key-update-request
+        type: u32
+        enum: key-update-type
+      -
+        name: key-serial
+        type: u32
   -
     name: done
     attributes:
@@ -116,6 +129,7 @@ operations:
             - certificate
             - peername
             - keyring
+            - key-serial
     -
       name: done
       doc: Handler reports handshake completion
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 611be56f8013..2696bf97dfac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,7 @@
 #include <linux/iov_iter.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <uapi/linux/handshake.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid,
+			      handshake_key_update_type keyupdate);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1726,7 +1731,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 
 static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
+			      key_serial_t pskid,
+			      handshake_key_update_type keyupdate)
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
@@ -1748,7 +1754,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
-	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	else
+		ret = tls_client_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
 			qid, ret);
@@ -1898,7 +1907,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	/* If PSKs are configured try to start TLS */
 	if (nvme_tcp_tls_configured(nctrl) && pskid) {
-		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
 		if (ret)
 			goto err_init_connect;
 	}
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4ef4dd140ada..8aeec4a7f136 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+	handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
-	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	else
+		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
@@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_data_ready = port->data_ready;
 		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
-			if (!nvmet_tcp_tls_handshake(queue))
+			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
 				return;
 			/* TLS handshake failed, terminate the connection */
 			goto out_destroy_sq;
diff --git a/include/net/handshake.h b/include/net/handshake.h
index dc2222fd6d99..084c92a20b68 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -10,6 +10,10 @@
 #ifndef _NET_HANDSHAKE_H
 #define _NET_HANDSHAKE_H
 
+#include <uapi/linux/handshake.h>
+
+#define handshake_key_update_type u32
+
 enum {
 	TLS_NO_KEYRING = 0,
 	TLS_NO_PEERID = 0,
@@ -38,8 +42,12 @@ struct tls_handshake_args {
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     handshake_key_update_type keyupdate);
 int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     handshake_key_update_type keyupdate);
 
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index b68ffbaa5f31..b691530073c6 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -19,6 +19,10 @@ enum handshake_msg_type {
 	HANDSHAKE_MSG_TYPE_UNSPEC,
 	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
 	HANDSHAKE_MSG_TYPE_SERVERHELLO,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATEREQUEST,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATEREQUEST,
 };
 
 enum handshake_auth {
@@ -28,6 +32,13 @@ enum handshake_auth {
 	HANDSHAKE_AUTH_X509,
 };
 
+enum handshake_key_update_type {
+	HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
+	HANDSHAKE_KEY_UPDATE_TYPE_SEND,
+	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
+	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
+};
+
 enum {
 	HANDSHAKE_A_X509_CERT = 1,
 	HANDSHAKE_A_X509_PRIVKEY,
@@ -46,6 +57,8 @@ enum {
 	HANDSHAKE_A_ACCEPT_CERTIFICATE,
 	HANDSHAKE_A_ACCEPT_PEERNAME,
 	HANDSHAKE_A_ACCEPT_KEYRING,
+	HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+	HANDSHAKE_A_ACCEPT_KEY_SERIAL,
 
 	__HANDSHAKE_A_ACCEPT_MAX,
 	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 2549c5dbccd8..c40839977ab9 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,6 +41,7 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
+	int			th_key_update_request;
 	key_serial_t		user_session_id;
 };
 
@@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->user_session_id = TLS_NO_PRIVKEY;
+	treq->user_session_id = args->user_session_id;
+
 	return treq;
 }
 
@@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake_req *req,
 		break;
 	}
 
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_SERIAL,
+			  treq->user_session_id);
+	if (ret < 0)
+		goto out_cancel;
+
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+			  treq->th_key_update_request);
+	if (ret < 0)
+		goto out_cancel;
+
 	genlmsg_end(msg, hdr);
 	return genlmsg_reply(msg, info);
 
@@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 }
 EXPORT_SYMBOL(tls_client_hello_psk);
 
+/**
+ * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a socket
+ * @args: socket and handshake parameters for this request
+ * @flags: memory allocation control flags
+ * @keyupdate: specifies the type of KeyUpdate operation
+ *
+ * Return values:
+ *   %0: Handshake request enqueue; ->done will be called when complete
+ *   %-EINVAL: Wrong number of local peer IDs
+ *   %-ESRCH: No user agent is available
+ *   %-ENOMEM: Memory allocation failed
+ */
+int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     handshake_key_update_type keyupdate)
+{
+	struct tls_handshake_req *treq;
+	struct handshake_req *req;
+	unsigned int i;
+
+	if (!args->ta_num_peerids ||
+	    args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
+		return -EINVAL;
+
+	req = handshake_req_alloc(&tls_handshake_proto, flags);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = args->ta_num_peerids;
+	for (i = 0; i < args->ta_num_peerids; i++)
+		treq->th_peerid[i] = args->ta_my_peerids[i];
+
+	return handshake_req_submit(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_client_keyupdate_psk);
+
 /**
  * tls_server_hello_x509 - request a server TLS handshake on a socket
  * @args: socket and handshake parameters for this request
@@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 }
 EXPORT_SYMBOL(tls_server_hello_psk);
 
+/**
+ * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a socket
+ * @args: socket and handshake parameters for this request
+ * @flags: memory allocation control flags
+ * @keyupdate: specifies the type of KeyUpdate operation
+ *
+ * Return values:
+ *   %0: Handshake request enqueue; ->done will be called when complete
+ *   %-ESRCH: No user agent is available
+ *   %-ENOMEM: Memory allocation failed
+ */
+int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     handshake_key_update_type keyupdate)
+{
+	struct tls_handshake_req *treq;
+	struct handshake_req *req;
+
+	req = handshake_req_alloc(&tls_handshake_proto, flags);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = 1;
+	treq->th_peerid[0] = args->ta_my_peerids[0];
+
+	return handshake_req_submit(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_server_keyupdate_psk);
+
 /**
  * tls_handshake_cancel - cancel a pending handshake
  * @sk: socket on which there is an ongoing handshake
-- 
2.51.0


