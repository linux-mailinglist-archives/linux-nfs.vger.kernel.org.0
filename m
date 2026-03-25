Return-Path: <linux-nfs+bounces-20375-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHXZCJf1w2lZvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20375-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:47:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0217F32713C
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A4A03050B59
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0C3EDACE;
	Wed, 25 Mar 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuhgRz0v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2C3EDAC6;
	Wed, 25 Mar 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449652; cv=none; b=inczpcFfmeQqjk9wdN8A6jWsdC238gOuenjaq9DVuuIcuNDYP3GHnaaEDIJHHDlqq/dznm80h2w8nY6YQWx5YmL/5Frlv3XUVqGN0N/AOZjzwYTZ0DUakqZYkrjJmuD+yKrQTqx52AFVb3JVomkytYAFLb0Dq+dHcaygypqjeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449652; c=relaxed/simple;
	bh=N3IH110vSVveR9UotqARZCtiLBniRTymPztXiHOEEzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WG2sn6dPGMXwXNt22CDD+dCYNNhJ+V4i4fbKKB3bPRO13KsJ4+5CjxWf4ImQS5v7Y9tEcokZZWwtMmasx3M/yZuNZ/z+NqvE8mEs4jfd5edOkIb9u2Yj/cCh8Go+Y42YOFQTIhjlR4rDb4hcC5x4w+wEHQZ+kH9yxFeSMK4u0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuhgRz0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF0DC19423;
	Wed, 25 Mar 2026 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449651;
	bh=N3IH110vSVveR9UotqARZCtiLBniRTymPztXiHOEEzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SuhgRz0v4a+x7EWfdd2nGM99Pa7/IV7l5R1QTOSjrfUCQYK2JIiOmwtOC6EqqbX5g
	 bh9KGCLecNi+etcTGaPGHZ5YRF3oZOEjOOjFC7r+yjZ3W95JimerTYT/HZNxwQbQwg
	 2OLS2qn3WrbVpB5BosWDU70LqheRoZCjRoPo37ygXeOO9r60ijqWOwKlbZVWVlZkvG
	 /+gEy+CSHir5IDnk10xetRe4+3lmZKD8eTncV3QTWvZeT/fnjgO/DI/u9ZUaiOYs3o
	 +CA4ur6gntznA0zHfyeD1CJFnUn/vkU4k+xMIYNEGnX5JFOZt/vNdpblKVqJa3eCEt
	 G6Uc+G0pMaAKQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:22 -0400
Subject: [PATCH v2 01/13] nfsd: move struct nfsd_genl_rqstp to nfsctl.c
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-1-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=N3IH110vSVveR9UotqARZCtiLBniRTymPztXiHOEEzM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/Ptu9eJSTtSX7n2IzojIfKA0pDkCjJSBtIkf
 9V30MsF5O6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7QAKCRAADmhBGVaC
 FdGPD/9LORuXiQdrzd+y0H8tj7gZXc4vKon3Vj5pYYoXysYH5CT9oEBp/tzEvBX9rxmPZVb6Xea
 D6DZb49KurODmJ1vWg9lI8n5WXo5jOgsdKyPzSlER5/GTOoskmf6DWh5ikCwHoCwKg5XtdwdhnY
 Q88e4AnYOAYOwA2z8iqTq1Hdusa+58lW1mfe8F2og8NH8oZlz2X6w02Rph0Lynz/Moi4X/hdPi7
 BgJa/JqdQH1nVHlBqCBX4xz+zXerBprV6NXgpvph/sDbLJzZl1eeE3l+G8dNq4U6e2WmHrRQ+S5
 L2+twvSaczsh5vVZGCfh5/WmYC8NVIPWoO+yLf4eRreAijVi2FW/RtqiJlDCMSdy1YAXf4uRx+F
 WNxbbMryQYFYLovnGDW4sjOESPXyjFcLtv3qpsgw9Pa0UCWNUjg7NUbxHE5ULRs374yGEHDr48H
 k/Ra6m7+o/ax6s9w7mC/M5NFDTWszTVdK8SfGwmTL3Pon5XzdWBNpo1teEQgT8KrdVsxIjLuQQe
 O2Hbuhly8QkQTuNiQkRFhNIW+yBNyP0VC/qSpYNKJQcUL9freiZZBRTQvgkC5UuaBvvC5h38/5p
 oOWBCAN8K/WdfHCJAFa6OTlpitUcLsobWc6ctLCMvfDeWyi0DuGOzg4TQEEdkPOTy3/nUzWF7h5
 b98L3j8i7KrSE/w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20375-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0217F32713C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's not used outside of that file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 15 +++++++++++++++
 fs/nfsd/nfsd.h   | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 988a79ec4a79af2f9c9406be9740d1922c2b4ec8..dc294c4f8c58a6692b9dfbeb98fedbd649ae1b95 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1412,6 +1412,21 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+struct nfsd_genl_rqstp {
+	struct sockaddr		rq_daddr;
+	struct sockaddr		rq_saddr;
+	unsigned long		rq_flags;
+	ktime_t			rq_stime;
+	__be32			rq_xid;
+	u32			rq_vers;
+	u32			rq_prog;
+	u32			rq_proc;
+
+	/* NFSv4 compound */
+	u32			rq_opcnt;
+	u32			rq_opnum[16];
+};
+
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
 					    struct nfsd_genl_rqstp *genl_rqstp)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 7c009f07c90b50d7074695d4665a2eca85140eda..260bf8badb032de18f973556fa5deabe7e67870d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -60,21 +60,6 @@ struct readdir_cd {
 /* Maximum number of operations per session compound */
 #define NFSD_MAX_OPS_PER_COMPOUND	200
 
-struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
-	unsigned long		rq_flags;
-	ktime_t			rq_stime;
-	__be32			rq_xid;
-	u32			rq_vers;
-	u32			rq_prog;
-	u32			rq_proc;
-
-	/* NFSv4 compound */
-	u32			rq_opcnt;
-	u32			rq_opnum[16];
-};
-
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;

-- 
2.53.0


