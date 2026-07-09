Return-Path: <linux-nfs+bounces-23210-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NUo9Bl/uT2pOqgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23210-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:54:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A458D734966
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jjOxcfk/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23210-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23210-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 619FB3050A41
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C546E3CD8C9;
	Thu,  9 Jul 2026 18:48:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE773C3458;
	Thu,  9 Jul 2026 18:47:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622881; cv=none; b=cmERoHxVwoKXYcMiLe4dZr0fyn95xeqKdFF1QQ0kbK64/5LnREo5lkCS2qjY/RIyvPOIapQ3s6qxbw3QXAXNmbti0tFrzBtdAR/ceItoU+RbKaqfi+RdZnyIURHTQGVVlGA1P0bsT2+LG+lVEeX3auCjmrUSxrLSgbnAT35HfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622881; c=relaxed/simple;
	bh=3qHQmR3WwoaoR16CpBLkHSSgMxydPb9+d61cSGSE/AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORTUXWlZmASyAckk0tba9f+oXzYJwIBDhNZr8XHTL52Q6ffCK2JH6sX8CtVp1FNMnROnYi2EPk1qfWPnor8eCgHyi+zk+c8u+qluFq3HnO5PTkU+U6pAbWV2wc5eHUDQ6SQiADI5FMYLcSACyRIqShYR6Y4ou4PFNT+hR6mBGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjOxcfk/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF13E1F00ACA;
	Thu,  9 Jul 2026 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622879;
	bh=+IQEAOPWq3/g9OUKSTDgng3dUVRKUFX5xl0myrXCxOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jjOxcfk/ryXNa552LqsSRcHnqGc70W/pb6K3PUROu4KS1RrjnNg5Y47NFfvwFFgBq
	 3eL+wvt7I+GZ1JhbyNlDMcLrJ1mTdNQnLRbavLAGKtPnOJVO4ootQXN+TrbvzkikiS
	 G+vCLE7FoqBzhxGP5FrFjipajVZiYtzBva8OwacgHaptStSVueASjtoW1yFu84hL0B
	 Aslk/lKZcvOMMW2qmA3SZzwyl1ZW+Oqa2CelQLdEKb1Km7AO9bWQyp7gWVtdQni9B8
	 WJkNgbBGyekyEatQSlJHC7RlVCa3LaiimvmMfNwqBaiQzM4qToLWImX/A6ogck7hGD
	 RfxvMH6pF5I5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:45 -0400
Subject: [PATCH v2 08/10] nfsd: split nfsd4_copy into transient and durable
 async copy objects
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-8-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20724; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3qHQmR3WwoaoR16CpBLkHSSgMxydPb9+d61cSGSE/AY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zW0S7J/EpQzrSLwOfIUKQ01GbMlSRD10rM1
 lMuz8PVnMKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1gAKCRAADmhBGVaC
 FdfvEACY5ka4lwEYkqP2hFjYW6TD2ht83jRM2+1RGPbomvVVPmYz+vMQFeAZaZ2PrEMn+Fkd56D
 oo1YD9muc/LexuchvypP7FJLx6PgTVDfEilgoiChQjfxMUhIwNO01+cC6aeHfaKeDaoRyqGWz2q
 98Ln+5qRIGGJJqyWsH3gH5BEbaSbhRPdZiI8RANAocIlDbXd4Xv38m94pEYmbmWc34Kz4HQKm4R
 FPeRg7nUujnDPsdjayGASE9UMoSsaNf5OhzXfN8xjsZomDCgxPMszbyi8WaJFQf2x6sfEpe70Z+
 hrbuhuSuzv64XQO62gTVvmPTxQCJ4AUqA/hz2MuG74tx20XyYGeHx0cWAIxI3BYYG0586ewGy4W
 KRuZusefWW+lvS6q+aktfX6EyyveKRYLhdQ8nbIq5P4NvyHCyPZoYGC9DXKLRdXDHd25L8it9sP
 +2C03DPs0Ba/bXydo0wbLacPIrFU1LuwcxvD/Op050DzIQaZV2+HTL2fbYMF+5joUsfTA1wyiBn
 3ADq2hn8kVbt9OSyXUTY7a7qrFqcZ2nY1hbNVQqbcoZ+vvvgIC0jT7AyLUAzvt2yfWQ0k6zLhk7
 YaEJvVdh19wxkyCBUVge/hMQfrDrAn6C4XoQ+oyQ6L/5ihemo9foKb6WmIeclg70G1iWDpX5gNl
 BYc/hNOmUgUbt4g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23210-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A458D734966

struct nfsd4_copy served two roles: as &u->copy it is a transient
per-COMPOUND argument in the request buffer; as the heap async_copy it is
a durable object (worker kthread, reaper linkage, CB_OFFLOAD callback, IDR
stateid) that outlives the COMPOUND, with dup_copy_fields() shuttling
state between them. That dual identity was the root of the recent lifetime
bugs.

Introduce struct nfsd4_async_copy for the durable object. It embeds a
struct nfsd4_copy (cp_copy) for the operation parameters/result and adds
the durable-only fields: async_copies linkage, task_struct, refcount,
reaper TTL, copy stateid, and CB_OFFLOAD callback. The durable object
therefore never points into the request buffer. cp_clp stays in
nfsd4_copy -- it is a request property read by the sync-copy tracepoints
on the transient object.

Mechanical split, no intended behavioral change; a step toward folding the
copy stateids into the common nfs4_stid infrastructure.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 136 ++++++++++++++++++++++++++--------------------------
 fs/nfsd/nfs4state.c |   6 +--
 fs/nfsd/state.h     |   5 +-
 fs/nfsd/xdr4.h      |  33 +++++++++----
 4 files changed, 97 insertions(+), 83 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2dbc99e76837..7d44c85335c7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -57,7 +57,7 @@ module_param(inter_copy_offload_enable, bool, 0644);
 MODULE_PARM_DESC(inter_copy_offload_enable,
 		 "Enable inter server to server copy offload. Default: false");
 
-static void cleanup_async_copy(struct nfsd4_copy *copy);
+static void cleanup_async_copy(struct nfsd4_async_copy *copy);
 
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
@@ -1465,13 +1465,13 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  */
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp)
 {
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 	bool result = false;
 
 	spin_lock(&clp->async_lock);
 	list_for_each_entry(copy, &clp->async_copies, copies) {
-		if (!test_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags) &&
-		    !test_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
+		if (!test_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_copy.cp_flags) &&
+		    !test_bit(NFSD4_COPY_F_STOPPED, &copy->cp_copy.cp_flags)) {
 			result = true;
 			break;
 		}
@@ -1487,7 +1487,7 @@ bool nfsd4_has_active_async_copies(struct nfs4_client *clp)
 void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 {
 	struct nfs4_client *clp;
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 	LIST_HEAD(reaplist);
 
 	spin_lock(&nn->client_lock);
@@ -1496,8 +1496,9 @@ void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 
 		spin_lock(&clp->async_lock);
 		list_for_each_safe(pos, next, &clp->async_copies) {
-			copy = list_entry(pos, struct nfsd4_copy, copies);
-			if (test_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags)) {
+			copy = list_entry(pos, struct nfsd4_async_copy, copies);
+			if (test_bit(NFSD4_COPY_F_OFFLOAD_DONE,
+				     &copy->cp_copy.cp_flags)) {
 				if (!--copy->cp_ttl) {
 					list_del_init(&copy->copies);
 					list_add(&copy->copies, &reaplist);
@@ -1509,31 +1510,29 @@ void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 	spin_unlock(&nn->client_lock);
 
 	while (!list_empty(&reaplist)) {
-		copy = list_first_entry(&reaplist, struct nfsd4_copy, copies);
+		copy = list_first_entry(&reaplist, struct nfsd4_async_copy,
+					copies);
 		list_del_init(&copy->copies);
 		cleanup_async_copy(copy);
 	}
 }
 
-static void nfs4_put_copy(struct nfsd4_copy *copy)
+static void nfs4_put_copy(struct nfsd4_async_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
-	/*
-	 * Drop the task_struct reference taken in nfsd4_copy(). Only async
-	 * copies have a copy_task; it is left NULL on every other path.
-	 */
+	/* Drop the task_struct reference taken in nfsd4_copy(). */
 	if (copy->copy_task)
 		put_task_struct(copy->copy_task);
-	kfree(copy->cp_src);
+	kfree(copy->cp_copy.cp_src);
 	kfree(copy);
 }
 
 static void release_copy_files(struct nfsd4_copy *copy);
 
-static void nfsd4_stop_copy(struct nfsd4_copy *copy)
+static void nfsd4_stop_copy(struct nfsd4_async_copy *copy)
 {
-	trace_nfsd_copy_async_cancel(copy);
+	trace_nfsd_copy_async_cancel(&copy->cp_copy);
 	/*
 	 * Always join the copy kthread before touching its resources. The
 	 * task_struct is pinned by get_task_struct() in nfsd4_copy(), so
@@ -1545,30 +1544,30 @@ static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 	 * is the sole owner of this teardown, so kthread_stop() runs exactly
 	 * once per copy.
 	 */
-	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
+	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_copy.cp_flags);
 	kthread_stop(copy->copy_task);
-	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
-		copy->nfserr = nfs_ok;
-	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
+	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_copy.cp_flags))
+		copy->cp_copy.nfserr = nfs_ok;
+	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_copy.cp_flags);
 
-	release_copy_files(copy);
+	release_copy_files(&copy->cp_copy);
 	nfs4_put_copy(copy);
 }
 
-static struct nfsd4_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
+static struct nfsd4_async_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
 {
-	struct nfsd4_copy *copy = NULL;
+	struct nfsd4_async_copy *copy = NULL;
 
 	spin_lock(&clp->async_lock);
 	if (!list_empty(&clp->async_copies)) {
-		copy = list_first_entry(&clp->async_copies, struct nfsd4_copy,
-					copies);
+		copy = list_first_entry(&clp->async_copies,
+					struct nfsd4_async_copy, copies);
 		refcount_inc(&copy->refcount);
 		/*
 		 * Pairs with smp_load_acquire in nfsd4_send_cb_offload();
 		 * see find_async_copy() for rationale.
 		 */
-		smp_store_release(&copy->cp_clp, NULL);
+		smp_store_release(&copy->cp_copy.cp_clp, NULL);
 		if (!list_empty(&copy->copies))
 			list_del_init(&copy->copies);
 	}
@@ -1578,7 +1577,7 @@ static struct nfsd4_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
 
 void nfsd4_shutdown_copy(struct nfs4_client *clp)
 {
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 
 	while ((copy = nfsd4_unhash_copy(clp)) != NULL) {
 		nfsd4_stop_copy(copy);
@@ -1616,7 +1615,7 @@ static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd4_copy *copy, *tmp;
+	struct nfsd4_async_copy *copy, *tmp;
 	struct nfs4_client *clp;
 	unsigned int idhashval;
 	LIST_HEAD(to_cancel);
@@ -1630,7 +1629,7 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 			spin_lock(&clp->async_lock);
 			list_for_each_entry_safe(copy, tmp,
 						 &clp->async_copies, copies) {
-				if (nfsd4_copy_on_sb(copy, sb)) {
+				if (nfsd4_copy_on_sb(&copy->cp_copy, sb)) {
 					refcount_inc(&copy->refcount);
 					/*
 					 * Hold a reference on the client while
@@ -1642,9 +1641,9 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 					 * survive callback flight.
 					 */
 					kref_get(&clp->cl_nfsdfs.cl_ref);
-					copy->nfserr = nfserr_admin_revoked;
+					copy->cp_copy.nfserr = nfserr_admin_revoked;
 					set_bit(NFSD4_COPY_F_CB_ERROR,
-						&copy->cp_flags);
+						&copy->cp_copy.cp_flags);
 					list_move(&copy->copies, &to_cancel);
 				}
 			}
@@ -1654,7 +1653,7 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 	spin_unlock(&nn->client_lock);
 
 	list_for_each_entry_safe(copy, tmp, &to_cancel, copies) {
-		struct nfs4_client *clp = copy->cp_clp;
+		struct nfs4_client *clp = copy->cp_copy.cp_clp;
 
 		list_del_init(&copy->copies);
 		nfsd4_stop_copy(copy);
@@ -1955,10 +1954,10 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 {
 	struct nfsd4_cb_offload *cbo =
 		container_of(cb, struct nfsd4_cb_offload, co_cb);
-	struct nfsd4_copy *copy =
-		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
+	struct nfsd4_async_copy *copy =
+		container_of(cbo, struct nfsd4_async_copy, cp_cb_offload);
 
-	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
+	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_copy.cp_flags);
 	nfsd4_put_client(cb->cb_clp);
 	/* Drop the copy reference taken in nfsd4_send_cb_offload(). */
 	nfs4_put_copy(copy);
@@ -2074,7 +2073,6 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	if (!nfsd4_ssc_is_inter(src))
 		dst->nf_src = nfsd_file_get(src->nf_src);
 
-	memcpy(&dst->cp_stateid, &src->cp_stateid, sizeof(src->cp_stateid));
 	memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
@@ -2099,14 +2097,14 @@ static void release_copy_files(struct nfsd4_copy *copy)
  * was never list_add'd). In both cases the copy is unreachable from
  * clp->async_copies.
  */
-static void cleanup_async_copy(struct nfsd4_copy *copy)
+static void cleanup_async_copy(struct nfsd4_async_copy *copy)
 {
 	nfs4_free_copy_state(copy);
-	release_copy_files(copy);
+	release_copy_files(&copy->cp_copy);
 	nfs4_put_copy(copy);
 }
 
-static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
+static void nfsd4_send_cb_offload(struct nfsd4_async_copy *copy)
 {
 	struct nfsd4_cb_offload *cbo = &copy->cp_cb_offload;
 	struct nfs4_client *clp;
@@ -2124,15 +2122,15 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 	 * nfsd4_unhash_copy) before the kthread reached this point. Skip
 	 * the callback; the canceling path owns the notification.
 	 */
-	clp = smp_load_acquire(&copy->cp_clp);
+	clp = smp_load_acquire(&copy->cp_copy.cp_clp);
 	if (!clp) {
-		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
+		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_copy.cp_flags);
 		return;
 	}
 
-	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
-	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
-	cbo->co_nfserr = copy->nfserr;
+	memcpy(&cbo->co_res, &copy->cp_copy.cp_res, sizeof(copy->cp_copy.cp_res));
+	memcpy(&cbo->co_fh, &copy->cp_copy.fh, sizeof(copy->cp_copy.fh));
+	cbo->co_nfserr = copy->cp_copy.nfserr;
 	cbo->co_retries = 5;
 
 	/*
@@ -2153,7 +2151,8 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 				 cbo->co_referring_slotid,
 				 cbo->co_referring_seqno);
 	trace_nfsd_cb_offload(clp, &cbo->co_res.cb_stateid,
-			      &cbo->co_fh, copy->cp_count, copy->nfserr);
+			      &cbo->co_fh, copy->cp_copy.cp_count,
+			      copy->cp_copy.nfserr);
 	nfsd4_try_run_cb(&cbo->co_cb);
 }
 
@@ -2166,7 +2165,8 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
  */
 static int nfsd4_do_async_copy(void *data)
 {
-	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
+	struct nfsd4_async_copy *async = data;
+	struct nfsd4_copy *copy = &async->cp_copy;
 	__be32 nfserr = nfs_ok;
 
 	trace_nfsd_copy_async(copy);
@@ -2210,14 +2210,14 @@ static int nfsd4_do_async_copy(void *data)
 	atomic_dec(&copy->cp_nn->pending_async_copies);
 	if (copy->cp_res.wr_bytes_written > 0 && copy->attr_update)
 		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, 0);
-	nfsd4_send_cb_offload(copy);
+	nfsd4_send_cb_offload(async);
 	/*
 	 * Drop the kthread's own reference (taken before
 	 * wake_up_process() in nfsd4_copy()). After this point, copy
 	 * may be freed by a concurrent teardown caller's pending
 	 * nfs4_put_copy().
 	 */
-	nfs4_put_copy(copy);
+	nfs4_put_copy(async);
 	return 0;
 }
 
@@ -2226,7 +2226,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	struct nfsd4_copy *async_copy = NULL;
+	struct nfsd4_async_copy *async_copy = NULL;
 	struct nfsd4_copy *copy = &u->copy;
 	struct nfsd42_write_res *result;
 	__be32 status;
@@ -2258,10 +2258,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (nfsd4_copy_is_async(copy)) {
 		struct task_struct *task;
 
-		async_copy = kzalloc_obj(struct nfsd4_copy);
+		async_copy = kzalloc_obj(struct nfsd4_async_copy);
 		if (!async_copy)
 			goto out_err;
-		async_copy->cp_nn = nn;
+		async_copy->cp_copy.cp_nn = nn;
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_ttl = NFSD_COPY_INITIAL_TTL;
@@ -2269,10 +2269,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (atomic_inc_return(&nn->pending_async_copies) >
 				(int)rqstp->rq_pool->sp_nrthreads)
 			goto out_dec_async_copy_err;
-		async_copy->cp_src = kmalloc_obj(*async_copy->cp_src);
-		if (!async_copy->cp_src)
+		async_copy->cp_copy.cp_src = kmalloc_obj(*async_copy->cp_copy.cp_src);
+		if (!async_copy->cp_copy.cp_src)
 			goto out_dec_async_copy_err;
-		dup_copy_fields(copy, async_copy);
+		dup_copy_fields(copy, &async_copy->cp_copy);
 		/*
 		 * Register the copy stateid on the long-lived async_copy
 		 * rather than on the transient COMPOUND argument buffer
@@ -2289,7 +2289,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			sizeof(result->cb_stateid));
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
-			async_copy->attr_update = true;
+			async_copy->cp_copy.attr_update = true;
 		memcpy(async_copy->cp_cb_offload.co_referring_sessionid.data,
 		       cstate->session->se_sessionid.data,
 		       NFS4_MAX_SESSIONID_LEN);
@@ -2314,10 +2314,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 */
 		refcount_inc(&async_copy->refcount);
 		wake_up_process(async_copy->copy_task);
-		spin_lock(&async_copy->cp_clp->async_lock);
+		spin_lock(&async_copy->cp_copy.cp_clp->async_lock);
 		list_add(&async_copy->copies,
-				&async_copy->cp_clp->async_copies);
-		spin_unlock(&async_copy->cp_clp->async_lock);
+				&async_copy->cp_copy.cp_clp->async_copies);
+		spin_unlock(&async_copy->cp_copy.cp_clp->async_lock);
 		status = nfs_ok;
 	} else {
 		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
@@ -2349,10 +2349,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	goto out;
 }
 
-static struct nfsd4_copy *
+static struct nfsd4_async_copy *
 find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
 {
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 
 	lockdep_assert_held(&clp->async_lock);
 
@@ -2364,10 +2364,10 @@ find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
 	return NULL;
 }
 
-static struct nfsd4_copy *
+static struct nfsd4_async_copy *
 find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 {
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 
 	spin_lock(&clp->async_lock);
 	copy = find_async_copy_locked(clp, stateid);
@@ -2380,7 +2380,7 @@ find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 		 * nfsd4_stop_copy(). smp_store_release() pairs with
 		 * smp_load_acquire() in nfsd4_send_cb_offload().
 		 */
-		smp_store_release(&copy->cp_clp, NULL);
+		smp_store_release(&copy->cp_copy.cp_clp, NULL);
 		if (!list_empty(&copy->copies))
 			list_del_init(&copy->copies);
 	}
@@ -2394,7 +2394,7 @@ nfsd4_offload_cancel(struct svc_rqst *rqstp,
 		     union nfsd4_op_u *u)
 {
 	struct nfsd4_offload_status *os = &u->offload_status;
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 	struct nfs4_client *clp = cstate->clp;
 
 	copy = find_async_copy(clp, &os->stateid);
@@ -2495,17 +2495,17 @@ nfsd4_offload_status(struct svc_rqst *rqstp,
 {
 	struct nfsd4_offload_status *os = &u->offload_status;
 	__be32 status = nfs_ok;
-	struct nfsd4_copy *copy;
+	struct nfsd4_async_copy *copy;
 	struct nfs4_client *clp = cstate->clp;
 
 	os->completed = false;
 	spin_lock(&clp->async_lock);
 	copy = find_async_copy_locked(clp, &os->stateid);
 	if (copy) {
-		os->count = copy->cp_res.wr_bytes_written;
-		if (test_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags)) {
+		os->count = copy->cp_copy.cp_res.wr_bytes_written;
+		if (test_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_copy.cp_flags)) {
 			os->completed = true;
-			os->status = copy->nfserr;
+			os->status = copy->cp_copy.nfserr;
 		}
 	} else
 		status = nfserr_bad_stateid;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3f58c729edbf..594cf392f61f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -982,7 +982,7 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	return 1;
 }
 
-int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
+int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_async_copy *copy)
 {
 	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID, NULL);
 }
@@ -1024,13 +1024,13 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	return NULL;
 }
 
-void nfs4_free_copy_state(struct nfsd4_copy *copy)
+void nfs4_free_copy_state(struct nfsd4_async_copy *copy)
 {
 	struct nfsd_net *nn;
 
 	if (copy->cp_stateid.cs_type != NFS4_COPY_STID)
 		return;
-	nn = net_generic(copy->cp_clp->net, nfsd_net_id);
+	nn = net_generic(copy->cp_copy.cp_clp->net, nfsd_net_id);
 	spin_lock(&nn->s2s_cp_lock);
 	idr_remove(&nn->s2s_cp_stateids,
 		   copy->cp_stateid.cs_stid.si_opaque.so_id);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index bc0181ef1cb6..4526b67c90d4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -872,6 +872,7 @@ struct nfsd4_blocked_lock {
 struct nfsd4_compound_state;
 struct nfsd_net;
 struct nfsd4_copy;
+struct nfsd4_async_copy;
 
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
@@ -883,8 +884,8 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 			    struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
-int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
-void nfs4_free_copy_state(struct nfsd4_copy *copy);
+int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_async_copy *copy);
+void nfs4_free_copy_state(struct nfsd4_async_copy *copy);
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 			struct nfs4_stid *p_stid);
 void nfs4_put_stid(struct nfs4_stid *s);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 805c7122eb93..f1c817e2f93c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -759,28 +759,41 @@ struct nfsd4_copy {
 	struct nfsd42_write_res	cp_res;
 	struct knfsd_fh		fh;
 
-	/* offload callback */
-	struct nfsd4_cb_offload	cp_cb_offload;
-
 	struct nfs4_client      *cp_clp;
 
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
 	bool			attr_update;
 
-	copy_stateid_t		cp_stateid;
-
-	struct list_head	copies;
-	struct task_struct	*copy_task;
-	refcount_t		refcount;
-	unsigned int		cp_ttl;
-
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
 	struct nfsd_net		*cp_nn;
 };
 
+/*
+ * Durable state for an asynchronous (background) server-side COPY.
+ *
+ * struct nfsd4_copy is a transient object that lives in the COMPOUND
+ * argument buffer (union nfsd4_op_u) and is reused once the operation
+ * returns. An async COPY, however, outlives the COMPOUND: a worker kthread
+ * keeps copying, the reaper tracks it on nfs4_client.async_copies, and a
+ * CB_OFFLOAD callback fires when it finishes. nfsd4_async_copy holds that
+ * long-lived state. The operation parameters and result are kept in the
+ * embedded cp_copy (populated by dup_copy_fields()), so the durable object
+ * never points into the request buffer.
+ */
+struct nfsd4_async_copy {
+	struct nfsd4_copy	cp_copy;	/* operation params + result */
+
+	struct list_head	copies;		/* nfs4_client.async_copies */
+	struct task_struct	*copy_task;
+	refcount_t		refcount;
+	unsigned int		cp_ttl;
+	copy_stateid_t		cp_stateid;	/* s2s_cp_stateids IDR entry */
+	struct nfsd4_cb_offload	cp_cb_offload;
+};
+
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
 {
 	if (sync)

-- 
2.55.0


