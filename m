Return-Path: <linux-nfs+bounces-13654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE224B27803
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 07:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD271CE5E85
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 05:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601132BE62B;
	Fri, 15 Aug 2025 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAyg9Jbr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE6184E;
	Fri, 15 Aug 2025 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234171; cv=none; b=GndYuci2EcQ79M6U3aS/iC2rbkWpbUqOJYkSKzdo6owNJVZLWPN6sVAtkDO2sLOqdgH7O7CbN1+ZccizAl/1g4jm81KkEiBh+uJwuANvzOlPM8lE97fVkvvAeGA+99OmebTpdekuXwzBxGizwFDreKWUrcy19Y9gcxukK+OYXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234171; c=relaxed/simple;
	bh=uc9YZwdTu6vjMHyC1DDyDPSVOBUSC6MVMTV9ezoWOD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSfXtWtHS87ZL3eHdgedIlHuv4bugs2cJQI0SZw+WxHFEY/gTL6X9eq/AQ0spyD56clgIqoHL1fEpYtFe63EgE8do90XxRsaR6zlxSyuROSQ9rbAjJ0fOg8B4qh7Q3TrkzvSghZhRJIVM/qNf7NBc5/UKj+ICe81FxRaHoM3qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAyg9Jbr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47173a03ffso1008946a12.1;
        Thu, 14 Aug 2025 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234169; x=1755838969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d7zGS9Yv26ZPzVs4PTbVzcVRRnuE09pH1oWJaHcRro=;
        b=nAyg9JbrUdN7YCmhfBVinYUZwlf1zLKzB66tHGNDXH0mkjcndpak0r6nf7HUliKRzL
         Dvdor1f91GOT6ib1nJrN6MBK7wr/TH94iYIodtOzp/ac4+NK6+ukFaYj7GzJ10fjJtFV
         FLiZuqZtj13/WubZKcIihvicT75aOJyyHlRxRXhkj2f15FTSra916SfsnPbdcRPFKqp/
         KucGILnWDl+4wspzCc74lPDOAbk3CiX5BQUf6riw0hlJAU2GVJvKtOd8atCwORj7vI0U
         fElRBgLhbrTbGMAzULQ6vrb1G9536QohAnwkmhJ0tIfAZMGoZBVh4Ee7m6rgfNPZd7ok
         lHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234169; x=1755838969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d7zGS9Yv26ZPzVs4PTbVzcVRRnuE09pH1oWJaHcRro=;
        b=JbElC6r7Vpeeg8tZrEOYAd8+pVL19yy+CjHVmjAkZU9UMnu+9XWvt7CJ92PwPTXxyv
         Wi8CxdMNXvMeZTb/z8dfI6lzLz0r1YRbUJ1K4Uw9Uu2sXfzzdLfn6LFTl8z4/vcKgD+y
         0dwCayCz3D+woaN8JK1brXhq53e52FyVbDeno/b2FA5dArYB5V9MNVU9C9ziOGkyXwoO
         Sles3aqDDV+ZWw0oORZY5dgGUiKfjgE4StFvlYL+H147M2OHJ4LgKUMGNCWp2z4ztbPU
         F2bH6ttGdditWyDGT0RnmLIrsExk4MSK9FQio0l0iNJ8GZJm6PUB0SWg0PpXE8neJb4G
         I2og==
X-Forwarded-Encrypted: i=1; AJvYcCUGsKXVtV4uh91mwbjLq0dNu929LmTJEHAaR7gvwR8FwbiKFI1rWRwWYiUnRnQKZbAFEGjoLcoFtz7t@vger.kernel.org, AJvYcCV0d+zpBLu0od4gZBKnmBB+A2yjwZLsFpMjbo6Gtm8x376qhYSSOW2AUOgzunZw2QtW+bilX8aoLzs=@vger.kernel.org, AJvYcCWeeRe9ojk87wzsbbEqXAe7mnvJkTD7iKDBgl3zzO0CunrnAPHsHjyeXX9ADBXsfvZx6TBBNDx9@vger.kernel.org, AJvYcCXbg7rVRWsgzuBJzZofG47ZjMFr5eYefeykNCADTLq6RlO1yn22K1txHUXvGAIOkEmNQc18Z8dl+mDa/OnS@vger.kernel.org
X-Gm-Message-State: AOJu0YykuHZ0UagzKBUqrnSwtVpdB/1UbrmYai3KthHNoO2JdlEUmDf/
	dR7RRIGbWwxGO+cdZ45rsb7QmeeTZjNY9tM/h4XOYCaoThSot+qHYtFw
X-Gm-Gg: ASbGncsrYSNDZJ3iM9KrEZ0gi8/ADjhLp4QrynxhFqlVuB1btHnsahRTI4W0R7pJvIS
	SoofSbUD3ZonkxeMANDNnsQpnME3ltipz+YM8jOlft6CfySZszRQop2hwWj7xTtdXbGQUalkl8C
	UfYnv4/GuWwvqxTjjVcfQqUlCVNt3nyDIE+0XBl7SqkMjQddk/fCZqmi/vr6T3D5s90r2amgDBg
	MkMKoeW+PdnwtsR9c3CAhxZKxCDt09XJUU8uHtGMF1hNpVxw0i05mfKM/9bGyz6jNphSzAZoB6o
	+9NGA0Z/7Vf7p8/7zzx2mmVGk4uPaxV1Heh6JBeNOiijVNE6S0tuo88v5rJVI9xuYmZwIHbwLRN
	oix/6bCYLDj81ufWQIllvurz5j+5ssM/EGNptlHIFIzdlLDmP4Ed0HQ1eKuyHPf4yN7zxCQy5GJ
	3SiZ4/KSe/CiyCsrgbHlg3AqHwKnI=
X-Google-Smtp-Source: AGHT+IFTGcov0+aWkKYCnNTsUBtDo1QWOO20Fpd9BJJ7unGopC+vkw10J9LX6yAJ5mZ4E7jFPDrOZg==
X-Received: by 2002:a17:903:8c5:b0:242:b315:dda7 with SMTP id d9443c01a7336-2446d6eef09mr10803535ad.3.1755234168765;
        Thu, 14 Aug 2025 22:02:48 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:48 -0700 (PDT)
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
Subject: [PATCH 5/8] net/handshake: Support KeyUpdate message types
Date: Fri, 15 Aug 2025 15:02:07 +1000
Message-ID: <20250815050210.1518439-6-alistair.francis@wdc.com>
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

When reporting the msg-type to userspace let's also support reporting
KeyUpdate events. This supports reporting a client/server event and if
the other side requested a KeyUpdateRequest.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml | 15 +++++++++-
 Documentation/networking/tls-handshake.rst |  4 +--
 drivers/nvme/host/tcp.c                    | 12 ++++++--
 drivers/nvme/target/tcp.c                  | 11 ++++++--
 include/net/handshake.h                    | 11 ++++++--
 include/uapi/linux/handshake.h             | 13 +++++++++
 net/handshake/tlshd.c                      | 33 ++++++++++++++++++----
 7 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index e76b10ef62f2..8e6275af1ff8 100644
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
index bb7317a3f1a9..cc3332529355 100644
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
index 93fce316267d..5eaab9c858be 100644
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
index fab4760049c6..8f791c55edc9 100644
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
+	key_serial_t		user_key_serial;
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
index 46753116ba43..f615b8226dba 100644
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
index cb1ee8ebf2ea..ceedb2e78697 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,6 +41,8 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
+	int			th_key_update_request;
+
 	key_serial_t		user_key_serial;
 };
 
@@ -58,7 +60,8 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->user_key_serial = TLS_NO_PRIVKEY;
+	treq->user_key_serial = args->user_key_serial;
+
 	return treq;
 }
 
@@ -265,6 +268,16 @@ static int tls_handshake_accept(struct handshake_req *req,
 		break;
 	}
 
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_SERIAL,
+			  treq->user_key_serial);
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


