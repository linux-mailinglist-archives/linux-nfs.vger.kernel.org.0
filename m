Return-Path: <linux-nfs+bounces-14054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73210B44BBE
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2902E487CEF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68214238D52;
	Fri,  5 Sep 2025 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3pVNLGy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3E1A254E;
	Fri,  5 Sep 2025 02:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040449; cv=none; b=sGU7dkehx+7j+ZR0CWxqUwGf+PYG0FSK1P70cg4f9soNDnV4WSDTzf7QGTrr/tmbnhPRIG3f81TN0X1qHfXavfdXyz7sr5uZEPTt9uX2GdRWVZSTp8AkUxBwJDFVeJT81WjCp09xqf+VGPJXWd7h4eWIgInLGe4utN97WGJMbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040449; c=relaxed/simple;
	bh=5cy6JRjzIBI9DvE7Epc4708XISOfVY8WD4vu09ndm04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DprfX4todTmYyxPCpK811wmYX1SD45XIe7cWsStj0PW9bsNl24NZT3Bcvrg2cOzxkaZd0iEZIKPD2I5OhIlIm4ZsBAsOq8m9LrxL+6XFYRQW5lVUNrD+iIhdXcUfNkSN8hl11xfBbfxys2y68v4UskhGDioM/A9NkarmR6m9ClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3pVNLGy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77238a3101fso1168458b3a.0;
        Thu, 04 Sep 2025 19:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040447; x=1757645247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO0deqVZ4Wu6qgE1lyMZttIifneyNCMnsT9L2+KvrrU=;
        b=W3pVNLGyQ55N4s5CnIz1EzA3AKqdT0icbDZiYqQ+5FTA8aiLkMYwUICbkH3PW3o1PQ
         5+R+L3a6JxW+M+ZCAP5TZxwlHRUL4+UkiSKw/UW7cvOl/JTLiq2METPfuhpsYVCyCukV
         TKmjPOCQ0u50G1wq7X6M50Q1nZd4LwV/DF9lW0uOA1HxareGK6Z4ggIOAolcasaPVWhD
         +i9rcOeZetX7ESICTKWTa8HeO0vYoaSudbRWqLvJjuuf0dcAVtIFaf8I72x6iTPEukZq
         tpcOkPuhipILjoM+He1ybSYGVoMfrNOjubK9ciSYRGBEDCkj6i0wOF908LOAX83yMQso
         KCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040447; x=1757645247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO0deqVZ4Wu6qgE1lyMZttIifneyNCMnsT9L2+KvrrU=;
        b=LiKcOBz+C8+4TYyIqC7H56rUbjbUGWaDcOzX6tPl4oBIrMSZD1uMH83BaygzV4ga+f
         TIfxZXzThCdSFesgvLAryV0vHVyW4EBM0OZnh5+q2qvliiKjW6iB8fLg7AMCwcegZ643
         d5Dr5vX1sQMzEvowt/VrROJ9rA+Sk53k9IaHeQvmriFv4dtIdZLd+PYwwDtZdIlDTzaR
         yFmTVf8BZhfXKISAPkzJpdGG124wjH4Uw47OHn7O0bKvahrBbvmZh6dYkZTpnDYV+8up
         eIfxwoLEVZ+mgDIlexjQRS4dR/evNG5fTvL/8DlWRgwIexUqfcAr9DiBBlxPWbIeMEyK
         GKlg==
X-Forwarded-Encrypted: i=1; AJvYcCUb4p+Qu/c53NakoW29UKFI77xPcRQkMNsdNAF7vysTigJqBUQxknoG/pK1QfJPjk2cjMggEGlM@vger.kernel.org, AJvYcCUuDTVmVYc9pYIgNbiPQGQM/fKllSCnWI68O/cY4s5Uzyr+PIH/NPX/NHeH5+D1eu+LTnZAHZPS+1Mk+GtP@vger.kernel.org, AJvYcCWpDlY2Q72+UyXnF0ZjAASXPhyyns7pCGijdHJV+b/6sa1Yk9aYAw4+oJSE7r4cey0wmNuqvDuDuIY=@vger.kernel.org, AJvYcCXOVddhbtKNqhyDS4cSUa5yqIK9niE26om352jL7RJnZDFpWINuCxboP6p20C4JP7CmPU2IRsbmEdDG@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHRVmnNkRf7axA5XH0S+6J9/Q78yiaMcnQcRpAux6yPNvmR+Q
	JeaiEEgoz9HdXntLuM69ACOEfZ0KpKUYWQP/BixknKYNAkzY6up+fPsv
X-Gm-Gg: ASbGncu3l9YDTzqteSrV9dVul0Hn/CL9G6YNkm50FTeBQzhKqeQVMHnY8lgx1HECqAo
	Gvw7TWYeGDDGlaXGnZVsd4TN5m0NtRH1inoORD0+giJgPCqpyk8tPjK0iFZX7uGiYGrP95B+Dl0
	nfmJ6YrD19aYcWRQWwvCXPpyzr8/JzZo4gI/AeLVi6oetgQgUvMCjwR3S+BH+NCtNyvchem0nQk
	3GVBfbkiwkHnv23vKejzoa8t2wVSD5l/o0pqYZ7CZYGrgZ0LUBVJe67Gi/2W0vade3JxthmA3dl
	D1Ykt3e1IMhRHynCiXFr8KBqkRA5AiZHMpng0JaTZk4y3IQydMxS6wcLtyYHvGCBH2/2pX1Sq+e
	btvE3I0WRO8fkcHSMYTYkcFf/N63q1IpQxp+uxCBHfy87cr/NE1nNm+FJnXQ/cef10QhWXeeLwZ
	QuDljqkxQEehybPezQZsvJW5jbZENnIl5kBi3ezg==
X-Google-Smtp-Source: AGHT+IFIflOWEBeKtj74FXwmGzMdferB97owPmIaiAyj9/HyOkcsu0OmlCQyYpYJBiuldethv1MJEw==
X-Received: by 2002:a05:6a20:4324:b0:24c:af7e:e55 with SMTP id adf61e73a8af0-24cafac1191mr5153694637.10.1757040446756;
        Thu, 04 Sep 2025 19:47:26 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:26 -0700 (PDT)
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
Subject: [PATCH v2 1/7] net/handshake: Store the key serial number on completion
Date: Fri,  5 Sep 2025 12:46:53 +1000
Message-ID: <20250905024659.811386-2-alistair.francis@wdc.com>
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

Allow userspace to include a key serial number when completing a
handshake with the HANDSHAKE_CMD_DONE command.

We then store this serial number and will provide it back to userspace
in the future. This allows userspace to save data to the keyring and
then restore that data later.

This will be used to support the TLS KeyUpdate operation, as now
userspace can resume information about a established session.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Change "key-serial" to "session-id"

 Documentation/netlink/specs/handshake.yaml |  4 ++++
 drivers/nvme/host/tcp.c                    |  3 ++-
 drivers/nvme/target/tcp.c                  |  3 ++-
 include/net/handshake.h                    |  3 ++-
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 +++--
 net/handshake/tlshd.c                      | 15 +++++++++++++--
 net/sunrpc/svcsock.c                       |  3 ++-
 net/sunrpc/xprtsock.c                      |  3 ++-
 9 files changed, 31 insertions(+), 9 deletions(-)

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
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0fe8cfb7229..2700ff3b8e85 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1673,7 +1673,8 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		qid, queue->io_cpu);
 }
 
-static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
+static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
+	key_serial_t user_session_id)
 {
 	struct nvme_tcp_queue *queue = data;
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..4ef4dd140ada 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1780,7 +1780,8 @@ static int nvmet_tcp_tls_key_lookup(struct nvmet_tcp_queue *queue,
 }
 
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
-					 key_serial_t peerid)
+					 key_serial_t peerid,
+					 key_serial_t user_session_id)
 {
 	struct nvmet_tcp_queue *queue = data;
 
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8ebd4f9ed26e..a07fecea87eb 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -18,7 +18,8 @@ enum {
 };
 
 typedef void	(*tls_done_func_t)(void *data, int status,
-				   key_serial_t peerid);
+				   key_serial_t peerid,
+				   key_serial_t user_session_id);
 
 struct tls_handshake_args {
 	struct socket		*ta_sock;
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
index 081093dfd553..f78c3edd5e09 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -26,7 +26,8 @@
 
 struct tls_handshake_req {
 	void			(*th_consumer_done)(void *data, int status,
-						    key_serial_t peerid);
+						    key_serial_t peerid,
+						    key_serial_t user_session_id);
 	void			*th_consumer_data;
 
 	int			th_type;
@@ -39,6 +40,8 @@ struct tls_handshake_req {
 
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
+
+	key_serial_t		user_key_serial;
 };
 
 static struct tls_handshake_req *
@@ -55,6 +58,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
+	treq->user_key_serial = TLS_NO_PRIVKEY;
 	return treq;
 }
 
@@ -83,6 +87,13 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 		if (i >= treq->th_num_peerids)
 			break;
 	}
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_SESSION_ID) {
+			treq->user_session_id = nla_get_u32(nla);
+			break;
+		}
+	}
 }
 
 /**
@@ -105,7 +116,7 @@ static void tls_handshake_done(struct handshake_req *req,
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
 	treq->th_consumer_done(treq->th_consumer_data, -status,
-			       treq->th_peerid[0]);
+			       treq->th_peerid[0], treq->user_session_id);
 }
 
 #if IS_ENABLED(CONFIG_KEYS)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e2c5e0e626f9..1d5829aecf45 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -450,7 +450,8 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
  * is present" flag on the xprt and let an upper layer enforce local
  * security policy.
  */
-static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid,
+				   key_serial_t user_session_id)
 {
 	struct svc_xprt *xprt = data;
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c5f7bbf5775f..3489c4693ff4 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2591,7 +2591,8 @@ static int xs_tcp_tls_finish_connecting(struct rpc_xprt *lower_xprt,
  * @peerid: serial number of key containing the remote's identity
  *
  */
-static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
+static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid,
+				  key_serial_t user_session_id)
 {
 	struct rpc_xprt *lower_xprt = data;
 	struct sock_xprt *lower_transport =
-- 
2.50.1


