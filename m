Return-Path: <linux-nfs+bounces-21551-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMc0GBFwA2qI5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21551-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A752776F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F4373120993
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B8370D71;
	Tue, 12 May 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKhFFK8q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1B368972
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609650; cv=none; b=KvrfkO0DC7LEI34qoPvD5NSayXbz8Y9M+Atq4xHWqb3mjlBm/Vwx2mrQGrGdiyWARXX0ypbPmJm2NqUAXLuY2DwDMfj6xfKFE8mpwJwCUs/hH79oknOJxAqcxUK7GFxULdLo2dVEWmOU8/lPEFLClAzufAJuhActe+uZsTa1vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609650; c=relaxed/simple;
	bh=WK4XTgg2r6tFBrkohWISxtoWEV3mQenwqrzvYppqHH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PeYfM2WM01+n3W2R8byzyiPlKqExT3xl1rpV3u1Ft+r7n7UmRkUvYxe18bjvkTuozhYdIrxtHcE44O1mFCGD9ut16a/1m6TldnR/oO2zkc9LFBchy1/379whGwxc3rhZ/zT9GM8PDiQEyhKWZ7lnp+TAaCs7hb99gYpjIbE3du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKhFFK8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0CEC2BCB0;
	Tue, 12 May 2026 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609650;
	bh=WK4XTgg2r6tFBrkohWISxtoWEV3mQenwqrzvYppqHH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mKhFFK8q7JHSbjlVa9yO3B/Eeng8zCVmbjjAoOLDE4rPLjdl3BWXDxVkUbgTP3mii
	 abbNDSSUXXW+9b5w47MS4y2BfBZfZorVe/rfCUEk2KvRG85tbDVgeAYmhTX/EmCo/6
	 fTkT8d3fmP6+eW1P0FiLLZiHAg8o+qFlafR8puYsxZw2oi/8tbsnUhYfsoSXy9P7vg
	 dqt5VYj6Pb579qjcLRI61eVhxU1n2rtY13oCLkIQbtmimeencKuMLv43YEWPe/m04C
	 Kg9GWlUrRr13tNaQn+swze5rwG4ehoJNJarbvNvZnoywylHbIYAdEUtAWbVvtamuD6
	 PJ+kDxjxThcLw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:46 -0400
Subject: [PATCH 11/38] lockd: Rename struct nlm_reboot to lockd_reboot
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-11-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5528;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=qCTRP6KOPyEHCw6d+RNOjVcpRHGdgibw6ZChbijTZJs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kj82z3uezda+a5uX22ZXHNhMzVeitQM+GV
 EgxJWVrttWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 lyfQEACajUoOl8ffueM8lYG3+KPT6+NcB0ujs0bmW+XoMmj0YYLJoUc8UEpVHBRHo2/rV+fW2dz
 Kg6yYLz8gY+5kI1avnhQqHUXtW+dadWfOG6fFuyOU8XL6t6DIhgV2QAQFJ7VkqkzfRMcfw8k+Ba
 3SmpQ1+cikoVqwNT5Dav+Jz6pl7Yr59jgafo9Ty30rGmaiuxKMI1xeD0RGQXrdGtw1Q6mdW8U+w
 rWc87lFM43txkZTXoyWDRvwML7LiR5NxqwTrah9ngtMX2eXrycGxkT9q4/fTgfmONOgofb8gKnc
 /4gXSEbSPrWk/r65S5FU/ElNbwPnKDr1PPwK2NMCOwchaxZunuMwg8gzxMNNIJ2fNvRuVgTFzun
 i+rey7w/N5SQEthQRKha/6c3WUc/dTwDbOy+iFPFLijGuzAguVNM05ccmk8YzA+ICrfSRAtCBVN
 Dx9cxu33Og5i6Q7YghyOCjmasbXYez7LoEdtkkVbRjgI/K7PhQdWOxfZRxgnMUWZQ914VBG5owo
 0fLQ3aK6YjK7Vpz17Z6RidUOc60yldP2RdMhKb0dI4Kup904hbnVMvqBiqO9+zC6HGr/5/5vZr6
 h2EeAlVb+zQUnCHYTUjS2dK1x5IWoY5iixo3pbfJZ1jxPk6K5X2+OxJNJtZXe1DJ1QtX4V2BuHK
 pp8z1QrCkTwYncQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 220A752776F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21551-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

As part of the effort to enable lockd's server-side XDR functions to
be generated from the NLM protocol specification (using xdrgen), the
internal type names must be changed to avoid conflicts with the
machine-generated type names.

Rename struct nlm_reboot to struct lockd_reboot for consistency with
the other renamed internal types.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/host.c     | 4 ++--
 fs/lockd/lockd.h    | 4 ++--
 fs/lockd/mon.c      | 2 +-
 fs/lockd/svc4proc.c | 4 ++--
 fs/lockd/svcproc.c  | 8 ++++----
 fs/lockd/xdr.c      | 2 +-
 fs/lockd/xdr.h      | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index ea8a8e166f7e..d572cb27533f 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -552,7 +552,7 @@ struct nlm_host * nlm_get_host(struct nlm_host *host)
 
 static struct nlm_host *next_host_state(struct hlist_head *cache,
 					struct nsm_handle *nsm,
-					const struct nlm_reboot *info)
+					const struct lockd_reboot *info)
 {
 	struct nlm_host *host;
 	struct hlist_head *chain;
@@ -582,7 +582,7 @@ static struct nlm_host *next_host_state(struct hlist_head *cache,
  * We were notified that the specified host has rebooted.  Release
  * all resources held by that peer.
  */
-void nlm_host_rebooted(const struct net *net, const struct nlm_reboot *info)
+void nlm_host_rebooted(const struct net *net, const struct lockd_reboot *info)
 {
 	struct nsm_handle *nsm;
 	struct nlm_host	*host;
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 4054e97723d8..ca389525a170 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -285,7 +285,7 @@ struct nlm_host * nlm_get_host(struct nlm_host *);
 void		  nlm_shutdown_hosts(void);
 void		  nlm_shutdown_hosts_net(struct net *net);
 void		  nlm_host_rebooted(const struct net *net,
-					const struct nlm_reboot *);
+					const struct lockd_reboot *);
 
 /*
  * Host monitoring
@@ -299,7 +299,7 @@ struct nsm_handle *nsm_get_handle(const struct net *net,
 					const char *hostname,
 					const size_t hostname_len);
 struct nsm_handle *nsm_reboot_lookup(const struct net *net,
-					const struct nlm_reboot *info);
+					const struct lockd_reboot *info);
 void		  nsm_release(struct nsm_handle *nsm);
 
 /*
diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index 3d3ee88ca4dc..a8f5ac6f0577 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -377,7 +377,7 @@ struct nsm_handle *nsm_get_handle(const struct net *net,
  * error occurred.
  */
 struct nsm_handle *nsm_reboot_lookup(const struct net *net,
-				const struct nlm_reboot *info)
+				const struct lockd_reboot *info)
 {
 	struct nsm_handle *cached;
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 1682a7c91a78..997f4f437997 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -61,7 +61,7 @@ static_assert(offsetof(struct nlm4_unlockargs_wrapper, xdrgen) == 0);
 
 struct nlm4_notifyargs_wrapper {
 	struct nlm4_notifyargs		xdrgen;
-	struct nlm_reboot		reboot;
+	struct lockd_reboot		reboot;
 };
 
 static_assert(offsetof(struct nlm4_notifyargs_wrapper, xdrgen) == 0);
@@ -918,7 +918,7 @@ static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
 static __be32 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 {
 	struct nlm4_notifyargs_wrapper *argp = rqstp->rq_argp;
-	struct nlm_reboot *reboot = &argp->reboot;
+	struct lockd_reboot *reboot = &argp->reboot;
 
 	if (!nlm_privileged_requester(rqstp)) {
 		char buf[RPC_MAX_ADDRBUFLEN];
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e033320b840f..a79c9a46db60 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -518,7 +518,7 @@ nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 static __be32
 nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
 {
-	struct nlm_reboot *argp = rqstp->rq_argp;
+	struct lockd_reboot *argp = rqstp->rq_argp;
 
 	dprintk("lockd: SM_NOTIFY     called\n");
 
@@ -732,8 +732,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_sm_notify,
 		.pc_decode = nlmsvc_decode_reboot,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_reboot),
-		.pc_argzero = sizeof(struct nlm_reboot),
+		.pc_argsize = sizeof(struct lockd_reboot),
+		.pc_argzero = sizeof(struct lockd_reboot),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "SM_NOTIFY",
@@ -816,7 +816,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 union nlmsvc_xdrstore {
 	struct lockd_args		args;
 	struct lockd_res		res;
-	struct nlm_reboot		reboot;
+	struct lockd_reboot		reboot;
 };
 
 /*
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index bcf65152a436..c78c64557fea 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -244,7 +244,7 @@ nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_reboot *argp = rqstp->rq_argp;
+	struct lockd_reboot *argp = rqstp->rq_argp;
 	__be32 *p;
 	u32 len;
 
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index a480df7cae31..65d2d6d34310 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -80,7 +80,7 @@ struct lockd_res {
 /*
  * statd callback when client has rebooted
  */
-struct nlm_reboot {
+struct lockd_reboot {
 	char			*mon;
 	unsigned int		len;
 	u32			state;

-- 
2.54.0


