Return-Path: <linux-nfs+bounces-13293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF5B1466B
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 04:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94827540378
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55243216E23;
	Tue, 29 Jul 2025 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVjSsjdH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6FA29;
	Tue, 29 Jul 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757002; cv=none; b=APsfB84YcnWk8joovYe3MijS7cVHIi9YiOM+YdMG3HeSy8RkgvCxqe4a/ilYNWE2ql1wKmngowDMiXscKfwUKMaaGaHtCBCJCkWKZOaQwBxn9WM713NG+U1r7M9BRkLBKxUY20QydsafyF7+jbwshEuABESAXCBSC9p/8drXVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757002; c=relaxed/simple;
	bh=HMvCQvp5ENsHuaarpg8RMhgfvpDNdnf+k13CDaf4Xco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzJRnEAGmH0MpXMEdytuHyTXa8NbI+U9QvgfIiEz3TcPzzMuz5ERp8pkkySsYy1cbyDqBh2HAzYVfj6lyH/H1XMfNf0BWe2Plc6ppqNT5FyG4azC49s7emT3WbGaKcVO2WdKyuJG8gD9T9nO8xwFglVng7dclvz/guMi00R7TvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVjSsjdH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-240763b322fso79725ad.0;
        Mon, 28 Jul 2025 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757000; x=1754361800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ErzOLTg/uOQwoB1OOi0W/+D3AUEpPqbgJy4pCp+H1w=;
        b=GVjSsjdHQHzCdgn2MvmRj73lRRy2b8QVfaBtxccXF/W8tU/HsThnvm4kOp5bL3/VZb
         J8SBegDfFMY6/M8AuojPPUZ74AbP7zGM5nWioXz8sHAO4WmbBHtOkHUNZYlEvYIyf+aj
         3j4nl5iYgJoIpYlOqqxLMHnJgXfuzO47fJNpfugercIHNXnAToqCU10c/wqfFUMOKP7f
         eUbOV99ghdIw9AhvGDgU4isBS3trkodKDhOqBzcUVOYgs7qT7GJRexHrNwCzwtZ5t7iQ
         oyplqeUhj2TIsk2g19tz6TtnNX/QIady/8c1JwRW0wg9B++mIPgEqtmAC5ZP5fVtwLVp
         pSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757000; x=1754361800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ErzOLTg/uOQwoB1OOi0W/+D3AUEpPqbgJy4pCp+H1w=;
        b=chMUtkd/gb8aPKeFS4RJo/4qQZcSu/UOp3FYOHIPmjAS3zUxGFVcRUbNJxc3MBgvV+
         SWNUxCimNMi++jSwPVVI0wi0pZbwGqDmzDVhyKtY/M0c6hHcrQT3ZYPyPZ5He/n+nHwO
         6NI3d5vb84Kw3w+Lf8j8FQ7xz0hOaweDgvzms1M5kpiwC+3Fnvuiy+jnXxxwJX20bHyL
         XXS4AVos5rzL1VdyhxuNFpL+m+brXVnl4M0c1UG/8tH/qYd6JeAwLhSiajsfwia9rkEZ
         0TUABTLTkHHQfR7+ct2geqsnT/kE/S3LiC77tKD+rtllpKQsNE4/VfhUOBcsc9hYBrRC
         //2A==
X-Forwarded-Encrypted: i=1; AJvYcCUDsQ+24t3a4NYAuflZibSjshJVcmBXZAi9o/V2G6BTChKR7pL6D/9eFfi0SuvNjhmiqvURdRCY@vger.kernel.org, AJvYcCWzrHyEz9P6Zedej40MH9I9fmwC92xbFAPjOJwn2sDRW+q8GX68xMhzT8HVoVYbI+I9wXT4sv8clmg=@vger.kernel.org, AJvYcCXAMJFhUwqlG9J1w1HzbK+hA6x5hhD2BVS7z9TNYBgIed2pc9aaOPpi09nBrjLWacpmBl89JOuqbvkt@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXXTNAJwgGzUZjbmM6abOMjFsl0elj/rd3mnhh99IelmtCj4S
	K6OcS5XjcI41PvyFfc3Hq0KVpZMVaOykTyjItucZQbuksYh0VrYvo0If
X-Gm-Gg: ASbGncuLodE2xgMiE8tzbWd0Zthf8HdwLKcDxqiLXEXrpoqBTNupKK5RibFivDFACwH
	vGTQ9F8vJiaGu8wRAT3WXSz4vlAkRNVUWoAiifoeRUyyMORF4JL8s9GVJMkKFL+o0qmkG1PLQZw
	ewMuZNZxuAz2kANHZcB12aMKTXWXdEk6bDW2lJ3bBoRN4KZ7s3aWrFwDAQQ0MwcYrYgMiJv6EJK
	OJWbclojUZgnIuhnpgYtnAwq9scw9KI6fE1Ms6NOqw7xMxdjrRxdwA5l2xD3g3CrrKRUFNQWZ+w
	eODFO+qUIGKvMNTf9m3tA0VQkVI8vC7bMLQMMSaH6rPBBommz1sMIk2gu90F9ksJ1tJolDc8L58
	8YWt2MRsOGmGjFmIUck/a3Mqlnw5RfiuUBkne
X-Google-Smtp-Source: AGHT+IGm00/i/5Md9wIJ3Bm72q8ofeFJb07OGmSiJpdFtE+Ka6GuL9pJd9Sn0gk85BhTLtNCqZxtwA==
X-Received: by 2002:a17:902:d507:b0:240:2145:e51f with SMTP id d9443c01a7336-2402145e7cdmr84404155ad.3.1753756999714;
        Mon, 28 Jul 2025 19:43:19 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:19 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 1/4] net/handshake: get negotiated tls record size limit
Date: Tue, 29 Jul 2025 12:41:49 +1000
Message-ID: <20250729024150.222513-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a handshake, an endpoint may specify a maximum record size limit.
Currently, this limit is not visble to the kernel particularly in the case
where userspace handles the handshake (tlshd/gnutls). This patch adds
support for retrieving the record size limit.

This is the first step in ensuring that the kernel can respect the record
size limit imposed by the endpoint.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml |  3 +++
 Documentation/networking/tls-handshake.rst |  8 +++++++-
 drivers/nvme/host/tcp.c                    |  3 ++-
 drivers/nvme/target/tcp.c                  |  3 ++-
 include/net/handshake.h                    |  4 +++-
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  4 +++-
 net/sunrpc/xprtsock.c                      |  4 +++-
 10 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d..35d5eb91a3f9 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -84,6 +84,9 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+        name: record-size-limit
+        type: u32
 
 operations:
   list:
diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/networking/tls-handshake.rst
index 6f5ea1646a47..cd984a137779 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -169,7 +169,8 @@ The synopsis of this function is:
 .. code-block:: c
 
   typedef void	(*tls_done_func_t)(void *data, int status,
-                                   key_serial_t peerid);
+                                   key_serial_t peerid,
+                                   size_t tls_record_size_limit);
 
 The consumer provides a cookie in the @ta_data field of the
 tls_handshake_args structure that is returned in the @data parameter of
@@ -200,6 +201,11 @@ The @peerid parameter contains the serial number of a key containing the
 remote peer's identity or the value TLS_NO_PEERID if the session is not
 authenticated.
 
+The @tls_record_size_limit parameter, if non-zero, exposes the tls max
+record size advertised by the endpoint. Record size must not exceed this amount.
+A negative value shall indicate that the endpoint did not advertise the
+maximum record size limit.
+
 A best practice is to close and destroy the socket immediately if the
 handshake failed.
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..65ceadb4ffed 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1673,7 +1673,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+			      size_t tls_record_size_limit)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..60e308401a54 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					key_serial_t peerid,
+					size_t tls_record_size_limit)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..c00b1aaa7aba 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -15,10 +15,12 @@ enum {
 	TLS_NO_PEERID = 0,
 	TLS_NO_CERT = 0,
 	TLS_NO_PRIVKEY = 0,
+	TLS_NO_RECORD_SIZE_LIMIT = 0,
 };
 
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   size_t tls_record_size_limit);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 3d7ea58778c9..0768eb8eb415 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -54,6 +54,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..44c43ce18361 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] = { .type = NLA_U32, },
 };
 
 /* Ops table for handshake */
@@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index d6f52839827e..7cafac6cff1f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    size_t tls_record_size_limit);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -39,6 +40,8 @@ struct tls_handshake_req {
 
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
+
+	size_t			record_size_limit;
 };
 
 static struct tls_handshake_req *
@@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
+	treq->record_size_limit = TLS_NO_RECORD_SIZE_LIMIT;
 	return treq;
 }
 
@@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 		if (i >= treq->th_num_peerids)
 			break;
 	}
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT) {
+			treq->record_size_limit = nla_get_u32(nla);
+			break;
+		}
+	}
 }
 
 /**
@@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], treq->record_size_limit);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e1c85123b445..2014d906ff06 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -417,13 +417,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote peer's identity
+ * @tls_record_size_limit: Max tls_record_size_limit of the endpoint
  *
  * If a security policy is specified as an export option, we don't
  * have a specific export here to check. So we set a "TLS session
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   size_t tls_record_size_limit)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 04ff66758fc3..509aa6269b0a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2569,9 +2569,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @data: address of xprt to wake
  * @status: status of handshake
  * @peerid: serial number of key containing the remote's identity
+ * @tls_record_size_limit: Max tls_record_size_limit of the endpoint
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  size_t tls_record_size_limit)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =
-- 
2.50.1


