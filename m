Return-Path: <linux-nfs+bounces-19715-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGP7Dh3Fp2nTjgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19715-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 06:37:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94031FAE5F
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 06:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 825463038528
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30B364943;
	Wed,  4 Mar 2026 05:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH76yQK+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84C373BF5
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602595; cv=none; b=ZH3SKWFBGyAOsPhez20a7WUEPGOSxOrVT+84Rnwrh8XS9z0Wm68rpBaf5v0IL4AJaW3vtrFeXrqZ8yZint8NtL91ILEer+ZnX66nfwtv6k0rlQ4j9R9F6XVw1CXJs2ewK0c/MmrZSdxaGGhNc/B+M3t5e71vEsd//vOzm0q3Wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602595; c=relaxed/simple;
	bh=7qA9Q6Pz/ZThLLziRlzsP+Ns3IK5HTYVcg1/SCKOubM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp7zCsQy6TkDnzIq5yeyxI6lKTLgjUl/BnKPDvGHnXRGd8BbWWzg5Bv6tBTjTPbmbLu/zfuBJCo1ccQP8uO5mV3kmr8MrvE10tEIgVtXWX2Kqo4EESFdRN8Y+V6AL/glIWXicyYZ5OeV7D+oM+Al+I1fMLqyYHRdZYPU3u1jZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH76yQK+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3599019ae92so1566489a91.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Mar 2026 21:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602593; x=1773207393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNCDZkyqVlGeQwFgjROGPRwx2fLC/OmgR/7kGK793I8=;
        b=cH76yQK+A9h6nZkjDPrZmT9qn339hzoy2A+8gT1IdpuEcAk7yttMr+cK+u23yi9O11
         LEfL/xVFnSgW6GGSbrX6/RXIWZdMsD3y37IIYAFMEcivx0qhfHHXqquF3oV4i4rnLOkf
         VrZ3y6GMLGNgbsvQHWAzrtubog4DdjqR3JjzsATMvOoaN03YNLJ0nNW4nA1U6hvEGaBn
         O5HKblyXVw7pRxktaqyAmtE61E2+8fVVf75TY2zcweCbkGpCoKp8jS+LdsrNbIULL/lT
         muEoSXuvIG4unAjC5uawSzvyttRPlVMFnj5ou1LZ4D97MrvnFe9QDWA5xYfUoSrxYocQ
         6J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602593; x=1773207393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xNCDZkyqVlGeQwFgjROGPRwx2fLC/OmgR/7kGK793I8=;
        b=Xkwgx35WEhYZCnTQGU7+TcYZA6zftNqVEFEIkQz0i6Plle3wo/1fgVlyE5wmf0uJdG
         kGsd4FqvqEutE86uvLKUSv2UKgi5VyeO7eBFP7YSOAyBoP2unis6cEOfOg1LoPHYL7Yo
         1J33/mepMV/8WIe/waOTjKEfvH7qZj7AXIGGqW7CwjdsgWmm1Gvgily7OIK9i7d2OxUH
         ecXeOKFOcKSUIZ85I8Az0wrPuV8TbRlujCdQyNFcTpuD9N7g3EGT527RPuhsUmZmeEUY
         qj1eH+gnixDsUB/Z2gAZQNJrouGvVMYCX40qKwGJmPZKX8bkKEOhR7wpLlSDb3N9dOcm
         jdAg==
X-Forwarded-Encrypted: i=1; AJvYcCXOu/lI7/w2YjUUhLhVlqRIIPJzvRfOhO2LMm7t63iev5CPwtwfKCRISg+S3Akk17ry7uF1G7Mh8Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5x6zt/XQg+zC/NkB5+15Ne7Gv1X/o4z/sGGk78+VQ9uhg0TVj
	koTvl/brmPIHgnGw4Y868qGVXuu3XffPu9ywBchBhlP1e6xSYZs4lANo
X-Gm-Gg: ATEYQzwp3IGwOPrBjhcjUPEx/BNSByUGayUO+x/nh1vtvIdXetaAYOV6AKk5OOM309M
	R+HDWBMX3pJ+9i+e82+f7ry6eC4NswPsrzDEbKZfWeEDkgvHHoNaFxm0guSukDyZrpJ6+ThI8Yn
	EsmkO7Wir6qRkyOCBPiYS9JNnp3j8tGAngXgGnW6Z9PMZFpJLFfaJ5riVlP+I99U26spL85aAaW
	urXSvdT6jfMur02FfQYfqxTYweWgpMfbY96fURPxOsQ0nXehKZUNT2dD7TmeS+Xglf5URBo8m5j
	7VJlKwdyEnfSIWMtbw/NtPCuVUQwhsYEPfNm1GqfQT7rUu3kIG0m4zKhf01ZZdqPECygW/KRWz/
	G58F9+PXt6mi+1kqpRTnvMzQOUjzFed6LVV0b7W+xdxJwXwoNw/6RnCYlJrqdE/cdeRlTCm9/Sy
	wewd7t6O4unhzC99nD5PDs4qGcTT5+B5qbXNQx9427SA==
X-Received: by 2002:a17:90b:538c:b0:356:2db3:1206 with SMTP id 98e67ed59e1d1-359a69dae4emr997051a91.13.1772602592975;
        Tue, 03 Mar 2026 21:36:32 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:32 -0800 (PST)
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
Subject: [PATCH v7 1/5] net/handshake: Store the key serial number on completion
Date: Wed,  4 Mar 2026 15:34:56 +1000
Message-ID: <20260304053500.590630-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D94031FAE5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19715-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,oracle.com:email,grimberg.me:email]
X-Rspamd-Action: no action

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to include a key serial number when completing a
handshake with the HANDSHAKE_CMD_DONE command.

We then store this serial number and will provide it back to userspace
in the future. This allows userspace to save data to the keyring and
then restore that data later.

This will be used to support the TLS KeyUpdate operation, as now
userspace can resume information about a established session.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reincke <hare@suse.de>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
v7:
 - No change
v6:
 - Add the "ta_" and "th_" prefixs
v5:
 - Change name to "handshake session ID"
v4:
 - No change
v3:
 - No change
v2:
 - Change "key-serial" to "session-id"

 Documentation/netlink/specs/handshake.yaml |  4 ++++
 Documentation/networking/tls-handshake.rst |  1 +
 drivers/nvme/host/tcp.c                    |  3 ++-
 drivers/nvme/target/tcp.c                  |  3 ++-
 include/net/handshake.h                    |  5 ++++-
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  4 +++-
 net/sunrpc/xprtsock.c                      |  4 +++-
 10 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..a273bc74d26f 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -87,6 +87,9 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+        name: session-id
+        type: u32
 
 operations:
   list:
@@ -123,6 +126,7 @@ operations:
             - status
             - sockfd
             - remote-auth
+            - session-id
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 6f5ea1646a47..c58b3c8b16c1 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -60,6 +60,7 @@ fills in a structure that contains the parameters of the request:
         key_serial_t    ta_my_privkey;
         unsigned int    ta_num_peerids;
         key_serial_t    ta_my_peerids[5];
+        key_serial_t    ta_handshake_session_id;
   };
 
 The @ta_sock field references an open and connected socket. The consumer
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ab3f61196a3..204f45f791a3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1676,7 +1676,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+			      key_serial_t handshake_session_id)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..63613e60f566 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1808,7 +1808,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					 key_serial_t peerid,
+					 key_serial_t handshake_session_id)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..d9b2411d5523 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -15,10 +15,12 @@ enum {
 	TLS_NO_PEERID = 0,
 	TLS_NO_CERT = 0,
 	TLS_NO_PRIVKEY = 0,
+	TLS_NO_SESSION_ID = 0,
 };
 
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   key_serial_t handshake_session_id);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
@@ -31,6 +33,7 @@ struct tls_handshake_args {
 	key_serial_t		ta_my_privkey;
 	unsigned int		ta_num_peerids;
 	key_serial_t		ta_my_peerids[5];
+	key_serial_t		ta_handshake_session_id;
 };
 
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index d7e40f594888..7fb3ef7f64df 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -56,6 +56,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_SESSION_ID,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..2542c13bb562 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -17,10 +17,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_SESSION_ID + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_SESSION_ID] = { .type = NLA_U32, },
 };
 
 /* Ops table for handshake */
@@ -36,7 +37,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_SESSION_ID,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..e72f45bdc226 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    key_serial_t handshake_session_id);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -39,6 +40,8 @@ struct tls_handshake_req {
 
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
+
+	key_serial_t		th_handshake_session_id;
 };
 
 static struct tls_handshake_req *
@@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
+	treq->th_handshake_session_id = TLS_NO_SESSION_ID;
 	return treq;
 }
 
@@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 		if (i >= treq->th_num_peerids)
 			break;
 	}
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
+			treq->th_handshake_session_id = nla_get_u32(nla);
+			break;
+		}
+	}
 }
 
 /**
@@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], treq->th_handshake_session_id);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f28c6076f7e8..5b003ac66a54 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -455,13 +455,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote peer's identity
+ * @handshake_session_id: serial number of the userspace session ID
  *
  * If a security policy is specified as an export option, we don't
  * have a specific export here to check. So we set a "TLS session
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   key_serial_t handshake_session_id)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..86eb51a9b224 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2590,9 +2590,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote's identity
+ * @handshake_session_id: serial number of the userspace session ID
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  key_serial_t handshake_session_id)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =
-- 
2.53.0


