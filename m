Return-Path: <linux-nfs+bounces-21552-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AJ6BNVxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21552-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66944527AC3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082FB32F926E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345F36A378;
	Tue, 12 May 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyS61SWj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C6364959
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609651; cv=none; b=sOKmfo+Kckyu254bqSrR73ziiXJFYUwxhpztRzHgT9knZgzou9SJrTXPmU+OSgTt0L4eAT9sYzV4l64DGJB+7yi8mkonONaFIoQFlBQyEyRkHaJp2LLSk1H5nGaI9w1G8h07R7L3cLBwTqjW59y922BLX0K9Snz7gnc39Vo0Ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609651; c=relaxed/simple;
	bh=BcOrmps63KcTpqoxUOowRIvdyGYectfsv07KLx6mEhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bA8rT+1hl5OF5zXbXx3HcVQLTvpQr0CMiySljE0Z2FSDrTlutK+oE/di5hBzfGRSns+xw7ukKjzLP67KJG/pLY25eHvu9QInUA2JbzzbQFK52eEu8dXiwl2pMJ0nIUGbRhIS4z8J41MjSzwZyM9CxWYo84F/PIzBIoP6t/8tYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyS61SWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B19C2BCFA;
	Tue, 12 May 2026 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609650;
	bh=BcOrmps63KcTpqoxUOowRIvdyGYectfsv07KLx6mEhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QyS61SWjwlBSxaXLbNexhbq2Eg1zBtBEJhsy9sukQPHRfQEGo1KZpoHIEuBKm994a
	 Z0bw5fr8iaiQOGs7Ar90afS8aq0xL3WGtRc29I0t0CR9e9ic7rRSIU6QTuKEL7ratH
	 LAfU5zSNoLPS6DLly+giks8HVyN/vQRswQCuKXsxnH0KufYC2NWR/Gu93au2JpUgAH
	 kJEpkGAtttZRuPFKmK1wutP+OVtmyuVKxBF/lKO3gcLK8gOzkuqdLFuxwgYS2rEttX
	 qA+5kJjW7lNtBQFTo+2CtPHiShN6nPRqoL4npCh/vT59JsR9AX5Sy5dePe66xCu6G6
	 IcgDgl0CFcg0A==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:47 -0400
Subject: [PATCH 12/38] lockd: Rename struct nlm_share to lockd_share
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-12-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=wH2UGaXTN/6bQn+i2Rq0J1USAW9HDv6UGN+8JRvD5w4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kIEqOzmHXMn2alBqJfygW8NQbigdCfUXHT
 QphEsncGjGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l2hnD/sEJcyrkWp5o9scw8tXRj0G+URxFe/BiyenHmdt0DXKG30DkiG3MDVWdAFuLwTru2/7Vr/
 l8scS2k4RQzGR84QWU2lp8Oi2Wkvn/L204DlNEnen12iOy0V1L+UrhuKUGlp4L+MGZuWWMGbSbb
 HMaLBqmwoAzyOWuTE4K8Uyd8V4wHPB6EUpF68Fv0ZHVolA6rHURQWh9fSTFNNsdXXVe5n/q3F34
 Uh0V9MAClY5lp7GVKk54Nk1GtLRZ5Ft+kT96LQBghM8iGo+cCpOZmbNqKBaEuM44rwbDH4fx0C+
 Z1vKt9cGolPDl5+qQXVgAS/WGBm3t99oySoDdDgPOpZ2syB1PQv09IGPBfx7By37m7vLFjs4m1y
 nZx2n0e70Gbrapt24TcKuxfgle707mntKsqPXcXJEoEH3AxuliCIDAIebT6HaeAC1hqQT6w6TLB
 QY/mH2+/emD/CVHfaoRFCYW9r4DRy7Iooc8EUbhlhf8+EEIFYghkSxIsmY7iex4+QcPXBvnhxzS
 UorH5Jpzqcag1/4puNfDjuAMie9JirM5Xnk8M1efIMOkiTfUANg8rOTx1Anf4ustjiTtuK4ngt5
 GuwMz6FIcbZKkSs0bpyCJIVlY2L/uYxXsj3ZjA2ZAwUHJITU1y/QTN6YdF2Sit0L8t/X2UUEfPE
 Cw48Fd+zCH7BjBg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 66944527AC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21552-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

As part of the effort to enable lockd's server-side XDR functions to
be generated from the NLM protocol specification (using xdrgen), the
internal type names must be changed to avoid conflicts with the
machine-generated type names.

Rename struct nlm_share to struct lockd_share to avoid conflicts with
the NLMv3 XDR type definitions that will be introduced when svcproc.c
is converted to use xdrgen.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h    | 4 ++--
 fs/lockd/share.h    | 4 ++--
 fs/lockd/svcshare.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index ca389525a170..5c79681b7e95 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -179,7 +179,7 @@ struct nlm_rqst {
 	void *	a_callback_data; /* sent to nlmclnt_operations callbacks */
 };
 
-struct nlm_share;
+struct lockd_share;
 
 /*
  * This struct describes a file held open by lockd on behalf of
@@ -190,7 +190,7 @@ struct nlm_file {
 	struct nfs_fh		f_handle;	/* NFS file handle */
 	struct file *		f_file[2];	/* VFS file pointers,
 						   indexed by O_ flags */
-	struct nlm_share *	f_shares;	/* DOS shares */
+	struct lockd_share *	f_shares;	/* DOS shares */
 	struct list_head	f_blocks;	/* blocked locks */
 	unsigned int		f_locks;	/* guesstimate # of locks */
 	unsigned int		f_count;	/* reference count */
diff --git a/fs/lockd/share.h b/fs/lockd/share.h
index 20ea8ee49168..1ec3ccdb2aef 100644
--- a/fs/lockd/share.h
+++ b/fs/lockd/share.h
@@ -14,8 +14,8 @@
 /*
  * DOS share for a specific file
  */
-struct nlm_share {
-	struct nlm_share *	s_next;		/* linked list */
+struct lockd_share {
+	struct lockd_share *	s_next;		/* linked list */
 	struct nlm_host *	s_host;		/* client host */
 	struct nlm_file *	s_file;		/* shared file */
 	struct xdr_netobj	s_owner;	/* owner handle */
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 53f5655c128c..5ac0ec25d62d 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -19,7 +19,7 @@
 #include "share.h"
 
 static inline int
-nlm_cmp_owner(struct nlm_share *share, struct xdr_netobj *oh)
+nlm_cmp_owner(struct lockd_share *share, struct xdr_netobj *oh)
 {
 	return share->s_owner.len == oh->len
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
@@ -39,7 +39,7 @@ __be32
 nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 		  struct xdr_netobj *oh, u32 access, u32 mode)
 {
-	struct nlm_share	*share;
+	struct lockd_share	*share;
 	u8			*ohdata;
 
 	if (nlmsvc_file_cannot_lock(file))
@@ -85,7 +85,7 @@ __be32
 nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 		    struct xdr_netobj *oh)
 {
-	struct nlm_share	*share, **shpp;
+	struct lockd_share	*share, **shpp;
 
 	if (nlmsvc_file_cannot_lock(file))
 		return nlm_lck_denied_nolocks;
@@ -111,7 +111,7 @@ nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 void nlmsvc_traverse_shares(struct nlm_host *host, struct nlm_file *file,
 		nlm_host_match_fn_t match)
 {
-	struct nlm_share	*share, **shpp;
+	struct lockd_share	*share, **shpp;
 
 	shpp = &file->f_shares;
 	while ((share = *shpp) !=  NULL) {

-- 
2.54.0


