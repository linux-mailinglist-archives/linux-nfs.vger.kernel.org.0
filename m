Return-Path: <linux-nfs+bounces-14931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA26BB5EC0
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 06:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBCD4EC641
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF91F462D;
	Fri,  3 Oct 2025 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYShfsik"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8E218AB9
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465960; cv=none; b=jMJm5A6Z61GZlAQYs+2+SxTKEhFj60JrspYfZTHP8202v/HiGmjDylWGwkReulr2vycGSq9rR6grR0KL+f74DNHq3mJbf0Nwv518QsuO+s0Il/+XJCBTNg1M7A3Cdovok1LZrn90Mo0VdQ6w1CpBKtIfpxlyQkzSwgCOOhk1W20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465960; c=relaxed/simple;
	bh=Uq3Z8RSrHwXrnNT1paL1AoU785TlGI3mneVec9VRjM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOXeVkbetvjT1+B6lgutPWO1VsKf2VJIjlF9YHlAR0iQ95IA2wB9BR/rODOGN2lSZNxzxVKMsX8pUFDO5F6PFJWT5OIuqd0WN9/vsK4vginhyHyy8T6RfZf1Bb7Fb/tCIJtMHgZ7E8IfdqgZxPzkoV61AGRwJBiiAlJ7MhFDVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYShfsik; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso1745205a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 21:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465957; x=1760070757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDr+pGK9qXDhiZdQ2JtpI7GsJ+lt00Yrfq6Cg4/eIfw=;
        b=mYShfsikQFMcz9VCuaCUxFX20Qn8578lM+FvVSuRBuYAUwyYmfla7AD500h4acnXoX
         9Vz0Kf6s9V7wzMkyDWzvpsKTt/Y9VTbIVQozU5AUHSFyYexXq0f5D6OjvMKtSgGjX61u
         swkZ6p9vFwX8zLrBGXJBiQQ7U2y6bXlBQzxD7O3b1zavjXTwebSwEw/5OpG//frD2nft
         B4K5WovlifzVRwEFa992kCBtcMRtf5qwNTnNIxMzkciwNhS5GaMzWoDls840t0Xq7uPF
         yeDA/AcSr0nliqDLIeGVyHAhTXaJ9EftMqJu0PxZQj5BodaGKMa3gpxPgixAj7GQEcTG
         3/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465957; x=1760070757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDr+pGK9qXDhiZdQ2JtpI7GsJ+lt00Yrfq6Cg4/eIfw=;
        b=rPKvkVh3QvJVRg9HJd9y6QjvN2SeafuwsARDi8MqNmQewjKs2EPS1URZ+bGNrtsLOf
         Vga7nuSzp1LbHw3XwFF1/d1Nus4EvPjF998cepxM24D6CYSWojfKm9UbjA8FNYZcF8eL
         XK7dW8/r3nrttbS0uEEkSukaYIYq2iSwE2pvdEVJ3xWB8tDibdaO6la/D+5HLV3sniFJ
         gfPYfA76fQMHt7LOQdzB6C8z3siDQNAPpp0fZjU3Ng1olq4i23O+XGjiVDxuKGkvun2H
         0a5zjshj/UPCSNvkEf4pGj5r+3Ufut9SlffQ3cd3v0fU/jFdGq1m3GJLwNX/yZZD66dU
         goqA==
X-Forwarded-Encrypted: i=1; AJvYcCXxpb/XrONg1AP0LEDxvRWWIghGRlD6eEeuhYEFjcoKObtN4GmHq5DXGxw8BQS59gKCsT8Kthb3ZFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvD2327LQQFQJYHmu5Wstnd4qc//IoTRSBnTRuk9TbKNOxMpmC
	fEJHj/EWYebrKIhauMxHdxAgtIQ41RTsquaJRcViTTl0KDGHRgg9VjTK9xkz/g==
X-Gm-Gg: ASbGncu8i/lZFIxrh9xdtOUGE3PJVYX+GLD537Ry7Qgn5IBPXA/wFtzpaXOKoywbfn2
	BYUKfLhqkEp/tU/ulGG8I6e6rZcsO695fZB0sb0eWxYMBIIJuGSoYajUsB6etxyF1zsWmMOT3BU
	wYEu9ASVOJ0nYJdVSHUj6WRJzQndPXrIac2r2Awikyr0G+P8mwek0KSRPvGanc6fh2VKIlBhHcr
	tgTn7qPZyO4LbJgZJgPbgDWMw7iLmbrG7v1Nvx8+pFijR3+cZt0NYxuonCsdqMGSaMI1RJD2sHO
	GT/L1lcs/s4uK3K/unvfZCBdzD3uz4jkHlwSQ0wPl1StC89sEL/NldFBCy+FHixB6svpO1lK1AF
	Okqc24GCCZZz1iNlWqYTMuMMY5kQH6dStFWDTUnDbQO6vkiY8alkW0z6obrLwggbOOYlRSHSzOf
	VvVETCM06P9RAjYuhRpUXn1hs8AW311DC2un/8dHYRvfsnOhgZgIeN
X-Google-Smtp-Source: AGHT+IHKBOsUY7IpU/J35nifIpXWMGavj61RcjI2MjowdpODALHppCvI2FcArSJWrhbcaKQdWgadxw==
X-Received: by 2002:a17:90b:3b44:b0:32b:9bec:158f with SMTP id 98e67ed59e1d1-339c27d2f96mr2078376a91.29.1759465957036;
        Thu, 02 Oct 2025 21:32:37 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:36 -0700 (PDT)
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
Subject: [PATCH v3 5/8] net/handshake: Support KeyUpdate message types
Date: Fri,  3 Oct 2025 14:31:36 +1000
Message-ID: <20251003043140.1341958-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
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
v3:
 - Fixup yamllint and kernel-doc failures

 Documentation/netlink/specs/handshake.yaml | 16 +++++++++-
 Documentation/networking/tls-handshake.rst |  4 +--
 drivers/nvme/host/tcp.c                    | 12 ++++++--
 drivers/nvme/target/tcp.c                  | 11 +++++--
 include/net/handshake.h                    | 10 +++++--
 include/uapi/linux/handshake.h             | 13 +++++++++
 net/handshake/tlshd.c                      | 34 ++++++++++++++++++----
 7 files changed, 84 insertions(+), 16 deletions(-)

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
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index d7287890056a..f858011e5bfb 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -110,7 +110,7 @@ To initiate a client-side TLS handshake with a pre-shared key, use:
 
 .. code-block:: c
 
-  ret = tls_client_hello_psk(args, gfp_flags);
+  ret = tls_client_hello_psk(args, gfp_flags, handshake_key_update_type);
 
 However, in this case, the consumer fills in the @ta_my_peerids array
 with serial numbers of keys containing the peer identities it wishes
@@ -140,7 +140,7 @@ or
 
 .. code-block:: c
 
-  ret = tls_server_hello_psk(args, gfp_flags);
+  ret = tls_server_hello_psk(args, gfp_flags, handshake_key_update_type);
 
 The argument structure is filled in as above.
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 700c37af52ba..b07401ad68eb 100644
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
@@ -1748,7 +1754,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
-	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	ret = tls_client_hello_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
 			qid, ret);
@@ -1898,7 +1904,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
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
index dc2222fd6d99..7da5d09b9bad 100644
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
@@ -37,9 +41,11 @@ struct tls_handshake_args {
 
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
index 2549c5dbccd8..05126f8943f1 100644
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
 
@@ -341,6 +353,7 @@ EXPORT_SYMBOL(tls_client_hello_x509);
  * tls_client_hello_psk - request a PSK-based TLS handshake on a socket
  * @args: socket and handshake parameters for this request
  * @flags: memory allocation control flags
+ * @keyupdate: specifies if and what type of KeyUpdate operation
  *
  * Return values:
  *   %0: Handshake request enqueue; ->done will be called when complete
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
@@ -404,13 +422,15 @@ EXPORT_SYMBOL(tls_server_hello_x509);
  * tls_server_hello_psk - request a server TLS handshake on a socket
  * @args: socket and handshake parameters for this request
  * @flags: memory allocation control flags
+ * @keyupdate: specifies if and what type of KeyUpdate operation
  *
  * Return values:
  *   %0: Handshake request enqueue; ->done will be called when complete
  *   %-ESRCH: No user agent is available
  *   %-ENOMEM: Memory allocation failed
  */
-int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
+int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags,
+			 handshake_key_update_type keyupdate)
 {
 	struct tls_handshake_req *treq;
 	struct handshake_req *req;
@@ -419,7 +439,11 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
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
2.51.0


