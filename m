Return-Path: <linux-nfs+bounces-14058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7809B44BCF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E6B5A1333
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBB237180;
	Fri,  5 Sep 2025 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7lu/OfD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98A236457;
	Fri,  5 Sep 2025 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040472; cv=none; b=sOJ/5O9dqWTPWWQIpQh6QnDI42dMe4gYTyzyL0RWGyv0wABE95aL9CeLoZ0ZT6LdYkzPSrlx6dwGow3dXUmjJhIQczOV7C0y5WQzBW6N8UyN7Q41Ju8yUL6c5l3xSM8T9Ij7mTm01BnTR9rW9C7587FNq2btP4GysUs7PA2Yj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040472; c=relaxed/simple;
	bh=9B49ffeerjNylx+sczfzfd4NhwuoqBSAI3bdFP36aRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heew8JfP8rP5vDaCtIP1VjnidB3gF5lNjnnR7FM/HCgSSVFRLFOjBUBJd195TWPamAkTi1645bTa902eaddx79bux3pih3oiq3n6LA+lILX7LkFCwiryP0X30NyrlAq2u9ssXla2jwCB1GFaQPnL8g6p0HniYU8LEwPJfGl5PgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7lu/OfD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so1382830b3a.3;
        Thu, 04 Sep 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040470; x=1757645270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rEfo5Vz+76MiWR+j+g+Bmag1ZppKv1/fWHQvDPMqDk=;
        b=J7lu/OfD2lNvNgLVfrfQDSwNci87OZurQILf7ZLPVvwus65U+lOlrrUpyHzdueeLGJ
         baTaRmch8GNDFQSAcWo4sPpcf2ONo5mekquJ3jpxoH6vpZeamn14IJyO/hX3EJ9Om0XM
         jk7k9c5mnl5Q6g+SGJHFpqO5Du0jJdCMcFY9yj/ECDQw7sKoLKoLZWGaTrX8vqOCBE86
         EQlCYR8DhalzzuHQVfKNXwg1Y+CO9+Zj+fylpkCow7QXaxY0Ys1SMzNkXgt/Wf88d5Kw
         Az1ht8nD9OGhbUsfzsdZlCPh9GlE4NmGp5U7pE2kV0Oa60X6oxz1TpnQ0s0Zs9+2uNFv
         XtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040470; x=1757645270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rEfo5Vz+76MiWR+j+g+Bmag1ZppKv1/fWHQvDPMqDk=;
        b=ZEU888JElLmwbo+BUWNaA/mlkrf5oaFMnREzs9TeTOmVtzs9f/mOiClNNbi86tfCQS
         zSdrmBmkXjtVuo1g/cCPEURxJus4YLsKpKBz/fSj9zAHb6MNiS0eAPJDJ/5VFLgCBLJp
         SepDuvHUmjWDZBMIXrFLU/R7o4uax0/P/m33hqqeq00Hha+9sa82ZAD+JmT4HWvJ29vt
         xPE+7YzGKBNYaitaXydwt9hfEiFOZj0EdHFS8Gp9LfDd6IavtTbWC6AS81XY/NRFh7Ul
         a7bRjbd+Nv/eGaNdCLoag2NS8qaZp0vMDw7tn+IPbgqtaScommZAYAisZoRdX+IbLZOC
         Jkpg==
X-Forwarded-Encrypted: i=1; AJvYcCUUtbDccZU148vLRTRwQ66Eyq8Gbfe7KWmKi7Ze9Fm6s1s26OuAosR/guruAgcy1828vxw6uOZe+6j4dGWy@vger.kernel.org, AJvYcCUavwBs79n+QXDHNyK7hL0GTPTa8ntqGgUaGrV67R+PIH0UfnFNhNGyqVW0EbfP3xorB4RWk0i3@vger.kernel.org, AJvYcCVBi+YqG0HJr8F6xD7yaDIaQtscax8ID0a9zTQovQQGfaiEWomH1OlqYNl0L2z8wDuV2iZrmjpMpaA=@vger.kernel.org, AJvYcCXftxexhgMTfyHn/blJfX3SnSwqX2uRJyoC1L+yqcxUCtUawaVDhdzhReyenbO208Oz27vrleZ0liw5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6rYhy9dzBxpNGPOss+3eLd1gDKMCOjnWiCZueeF5mbZtAGbh
	Em/fDGN2zKBd6Aysac5EKlUCPsHjg4JYJ2PXd+KUq+oIWmUa79A6YUou
X-Gm-Gg: ASbGncs8CYvvOub+vsNJi9wWpmnhuXfNbTj45lhN2Sz/oQWNyPMvUk3WwtdvZfaQN6U
	vvPAXrtJcA0pMpYITwuHSkW2kyDrDqvZGfPRRyNEJo/MKlv+L0cG4XOfq4Wu/81bH/FJmlo4v0I
	PlIxQ1azJDhSeBKT/MMVdtEtuFAdggROo6H8gW65VBggzoOdElrFdLeb+73qx8mInrvSw0EeE7L
	aJc2a4PgbcIhlKVEiKOyq6nmrTHdJwsSPcaO1WgTZIQeBHMJG4tUxUAYH+ifoMoSRi2q31XT4mB
	IGQE+iZvy+khOtFBTVzLHAgnz3sFRk1mU3GzSihUZYeYp/Iqni8lET375mszR9UQrZ36zNrRNSj
	3ytTvMaPi+SCim1M6luFBWEu5RToeAcOqNNtXzDRRVVYQoOj3iKZ0qMK2k2ypExaD7XClr3ilNM
	uNFblARfMd+AH/RYyVv8TS5UCgxezZY+4Z9B5q+g==
X-Google-Smtp-Source: AGHT+IEaNKuzLTgIXvOISFGk6+BMfacI6AL56ph6mdk5WD3/mbhyOZIeFDt+7RiswP0+LVqIQwP7Pw==
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr22753435b3a.23.1757040469915;
        Thu, 04 Sep 2025 19:47:49 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:49 -0700 (PDT)
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
Subject: [PATCH v2 5/7] net/handshake: Support KeyUpdate message types
Date: Fri,  5 Sep 2025 12:46:57 +1000
Message-ID: <20250905024659.811386-6-alistair.francis@wdc.com>
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

When reporting the msg-type to userspace let's also support reporting
KeyUpdate events. This supports reporting a client/server event and if
the other side requested a KeyUpdateRequest.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml | 15 +++++++++-
 Documentation/networking/tls-handshake.rst |  4 +--
 drivers/nvme/host/tcp.c                    | 12 ++++++--
 drivers/nvme/target/tcp.c                  | 11 +++++--
 include/net/handshake.h                    | 11 +++++--
 include/uapi/linux/handshake.h             | 13 ++++++++
 net/handshake/tlshd.c                      | 35 ++++++++++++++++++----
 7 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index a273bc74d26f..1a3312fad410 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -21,12 +21,17 @@ definitions:
     type: enum
     name: msg-type
     value-start: 0
-    entries: [unspec, clienthello, serverhello]
+    entries: [unspec, clienthello, serverhello, clientkeyupdate, clientkeyupdaterequest, serverkeyupdate, serverkeyupdaterequest]
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
@@ -74,6 +79,13 @@ attribute-sets:
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
@@ -116,6 +128,7 @@ operations:
             - certificate
             - peername
             - keyring
+            - key-serial
     -
       name: done
       doc: Handler reports handshake completion
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 6f5ea1646a47..64a70847bd8b 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -108,7 +108,7 @@ To initiate a client-side TLS handshake with a pre-shared key, use:
 
 .. code-block:: c
 
-  ret = tls_client_hello_psk(args, gfp_flags);
+  ret = tls_client_hello_psk(args, gfp_flags, handshake_key_update_type);
 
 However, in this case, the consumer fills in the @ta_my_peerids array
 with serial numbers of keys containing the peer identities it wishes
@@ -138,7 +138,7 @@ or
 
 .. code-block:: c
 
-  ret = tls_server_hello_psk(args, gfp_flags);
+  ret = tls_server_hello_psk(args, gfp_flags, handshake_key_update_type);
 
 The argument structure is filled in as above.
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2700ff3b8e85..776047a71436 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -19,6 +19,7 @@
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <uapi/linux/handshake.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -205,6 +206,10 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid,
+			      handshake_key_update_type keyupdate);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1708,7 +1713,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 
 static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
+			      key_serial_t pskid,
+			      handshake_key_update_type keyupdate)
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
@@ -1730,7 +1736,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
-	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
 			qid, ret);
@@ -1880,7 +1886,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	/* If PSKs are configured try to start TLS */
 	if (nvme_tcp_tls_configured(nctrl) && pskid) {
-		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
 		if (ret)
 			goto err_init_connect;
 	}
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4ef4dd140ada..bee0355195f5 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -214,6 +214,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   handshake_key_update_type keyupdate);
+#endif
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -1833,7 +1837,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+	handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,7 +1857,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
-	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
@@ -1934,7 +1939,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_data_ready = port->data_ready;
 		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
-			if (!nvmet_tcp_tls_handshake(queue))
+			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
 				return;
 			/* TLS handshake failed, terminate the connection */
 			goto out_destroy_sq;
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 89dc169eae89..52036993b2b8 100644
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
@@ -32,13 +36,16 @@ struct tls_handshake_args {
 	key_serial_t		ta_my_privkey;
 	unsigned int		ta_num_peerids;
 	key_serial_t		ta_my_peerids[5];
+	key_serial_t		user_session_id;
 };
 
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
-int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate);
 int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
-int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate);
 
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
index f78c3edd5e09..ebdf32c67f37 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,7 +41,9 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
-	key_serial_t		user_key_serial;
+	int			th_key_update_request;
+
+	key_serial_t		user_session_id;
 };
 
 static struct tls_handshake_req *
@@ -58,7 +60,8 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->user_key_serial = TLS_NO_PRIVKEY;
+	treq->user_session_id = args->user_session_id;
+
 	return treq;
 }
 
@@ -265,6 +268,16 @@ static int tls_handshake_accept(struct handshake_req *req,
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
 
@@ -348,7 +361,8 @@ EXPORT_SYMBOL(tls_client_hello_x509);
  *   %-ESRCH: No user agent is available
  *   %-ENOMEM: Memory allocation failed
  */
-int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
+int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate)
 {
 	struct tls_handshake_req *treq;
 	struct handshake_req *req;
@@ -362,7 +376,11 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 	if (!req)
 		return -ENOMEM;
 	treq = tls_handshake_req_init(req, args);
-	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTHELLO;
+	if (keyupdate != HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
+	else
+		treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTHELLO;
+	treq->th_key_update_request = keyupdate;
 	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
 	treq->th_num_peerids = args->ta_num_peerids;
 	for (i = 0; i < args->ta_num_peerids; i++)
@@ -410,7 +428,8 @@ EXPORT_SYMBOL(tls_server_hello_x509);
  *   %-ESRCH: No user agent is available
  *   %-ENOMEM: Memory allocation failed
  */
-int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
+int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate)
 {
 	struct tls_handshake_req *treq;
 	struct handshake_req *req;
@@ -419,7 +438,11 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 	if (!req)
 		return -ENOMEM;
 	treq = tls_handshake_req_init(req, args);
-	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERHELLO;
+	if (keyupdate != HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
+	else
+		treq->th_type = HANDSHAKE_MSG_TYPE_SERVERHELLO;
+	treq->th_key_update_request = keyupdate;
 	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
 	treq->th_num_peerids = 1;
 	treq->th_peerid[0] = args->ta_my_peerids[0];
-- 
2.50.1


