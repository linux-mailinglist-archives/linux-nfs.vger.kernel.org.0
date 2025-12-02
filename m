Return-Path: <linux-nfs+bounces-16833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA5C99C42
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 02:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32F903447E3
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 01:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A51B424F;
	Tue,  2 Dec 2025 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoupdSjY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226A2153D3
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639313; cv=none; b=KNw0hbxQSO8vpqTthrjiZKxxb5qJnsZb6DQdgfJALY9AASny2i8QKc3VcdQlWYB/11WYaAlHpZS4ip/LZg3tIkz8ofhemdX0VlHdk0GVWjI+g+bFq9r1MCQMdZ2iF8kRqyaLLNMCwXUEf5caSobmMqLPiHiwsuvunZua/NMKAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639313; c=relaxed/simple;
	bh=hz26PoRu8wHYwcbPcNok7LEN/UGSvwxHbi/hTcXSdHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCEHuhdfKxVMtTzCRLNjF4kSbkGPfh8kaJBN3ZQlWwYp/5TG3ZFd/umn2V5TNo2lkQq/GDRaE0IlDc2DyLelS/Fo3uN1g4p/c/dfXhBP+phYm6ne2ayihLKMck0oJ3iIzwKh0CbQmnkUjmjgU5ZS2Gk+KSR2phLSd6EpU7s0qu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoupdSjY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298250d7769so35115035ad.0
        for <linux-nfs@vger.kernel.org>; Mon, 01 Dec 2025 17:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639311; x=1765244111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJvJhfPbnFYn3z6Y3dZFBcvJzRxMfFMy2X3buPGIRvg=;
        b=HoupdSjY34A/0OGSK+LDiB+6uAdnqhnhI4PwoGBZgTss1LecFTun8Zb7XoUqt0Ltpn
         VPEPqt+3BS6SG2FwUko0H26XZRWQXSdiaTPgpLX4sDkx6CZkFI4os5shlYa2PRtpQH64
         b5biBtE1x0k4W660KH16aC9LD3xnlpgoVhGyxcSZPtaDiz8wT63ADdXIIPbW4R6PZ0Ty
         l46QnvbZc5zwIF/mRpBBRHGEDAWddkevuyv5ihTgAmu9WQC4G2EXnzAjRsgB7IkSsojP
         KlX6b0rmRlgslWXn1hulNhVkn+mRvuDJGIm6gnCMDoImq0jqr1Qtvkj+LJpSc+X1V55g
         c0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639311; x=1765244111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJvJhfPbnFYn3z6Y3dZFBcvJzRxMfFMy2X3buPGIRvg=;
        b=r9TflycGEskSUXowDYEEFHmf6o3txgX7stvKxCN96ppnSzKlsUbD7qYSYI+VAx1QCy
         h+azDqVR5khhTX6q+n9nqCvh9BfCO3gz0LkFk08aDQtk4q3ZvyPWciu10sSrhetcNXur
         aJEoJqYyrcpreeGCSu4To6UAIpPlS8mEQEc/mitE7rs08Q5QpoxOYMb2Jv2l7Rh4+lnH
         E0noM7nB17OEbVBUcyquBPDw/6lisjFCZrrQE7+5HwFq3jwNsNx5UgoNBmj/eIrjCZg5
         4dY+xpp+/6AjytqOiPwVZQI/Rit02qUythyjF7sK9tI+dM0uapHyLGTwb/YR7tX748Mc
         zR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXPAgdTC9c0vY2mPFWgdyLoS/RJjrNaJE4erVvVRgW9DMNma6/3CFVGgSPjGe163bckInxJXeHUF5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gXgEuvsUWeNDueI8Bi0wtvrWJiobNFxjyFbBv9+tYxFtHgYc
	zDLOYDX8od3wYAGxYucJYbx5zX0CkrtKhrHoDmJFhcCdhqUqnT6DKNJL
X-Gm-Gg: ASbGncsu/sQgQMnUK6AW2vcjiJlrHE5fnY/EQLrge9fQ7qYjwK5Iin0FD3GPgdttGs9
	2Wkasn+NNR6nvNG2tBzW4kp81ge5lsh7pta0OwctAQh9DvprkA6GishCi6k7cWS4IntnS42lnc+
	1earxrIxd9/pRDW8xyJRGpuoDF/nZwx/KdEc9bQyJ3xzGj9+xSW8+AE2+ZtEpeKb9AIhXMFf+x8
	1upPDx6GL47tk6W8Cc/mb3LUE7WcyppBPFrn68LH7lES6KgySMWXcIezCIyYhUEjAdw9Vw2dDKH
	vpmPSwcltUtmJ5f6Tb3nKbIGyX+o807UJ0kLxrymmdxjmIntg44RTuP12Ick/rdDQm14pq1jrLd
	WYyruaCKKvxkOT5eoFNQaBwYSrix0ULsMV/AwnQYiaktUIKe+LdFshavXrmUaXpF13uTKaShfoJ
	pm9X4CDkE7O+b8HsbCq/LhEJB0Ph8KbHneaXbfMb0E2QSwU4RHLyI9VVYDqU7lUjsX2tzfPT+1c
	6IanYgYrNIuzfa26U4=
X-Google-Smtp-Source: AGHT+IH83tJaSf6G3Voz30gvV9am+rP5Je0+3DRGMgD/fBbFGdbiYM3LHkSvkNZ0vjcndHQPHyhM1A==
X-Received: by 2002:a17:903:37cd:b0:29a:2d0:c1b5 with SMTP id d9443c01a7336-29b6c4fc395mr396760085ad.22.1764639311213;
        Mon, 01 Dec 2025 17:35:11 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:10 -0800 (PST)
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
Subject: [PATCH v6 1/5] net/handshake: Store the key serial number on completion
Date: Tue,  2 Dec 2025 11:34:25 +1000
Message-ID: <20251202013429.1199659-2-alistair.francis@wdc.com>
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
index 9058ea64b89c..024d02248831 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1694,7 +1694,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+			      key_serial_t handshake_session_id)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..7f8516892359 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
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
index 662e7de46c54..b68ffbaa5f31 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -55,6 +55,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_SESSION_ID,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..6cdce7e5dbc0 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
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
@@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
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
index 7b90abc5cf0e..2401b4c757f6 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -444,13 +444,15 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
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
index 3aa987e7f072..5c6e7543f293 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2589,9 +2589,11 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
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
2.51.1


