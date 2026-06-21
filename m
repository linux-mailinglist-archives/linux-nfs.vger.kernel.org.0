Return-Path: <linux-nfs+bounces-22749-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P0RyLpsQOGonXgcAu9opvQ
	(envelope-from <linux-nfs+bounces-22749-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 18:26:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2FC6AB432
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 18:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PKBQ52DF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22749-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22749-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64BCB3002886
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A723FC5A;
	Sun, 21 Jun 2026 16:26:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B721B4F1F
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 16:25:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782059160; cv=none; b=VslD3hVdNv7xFTLC9TltiUeydwgUS2iwqU2dlKFSyKKOquTlDZNSFaOy36c4aKsRr8jPqvphhb5DjTaMLjcWJhMWdZOVLKkDBghy831dBUAx6SL2xN2RfwdbNrXhpD9tF5opS208uqLh8r1cFAwX7Fps3r0tkNdNyK22+iPQaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782059160; c=relaxed/simple;
	bh=cx7d39y+i+MhyXD0t92sziWAwhdXa8UIbH5Zg8sw8zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViUgHAjDeYRJStx4fCGMYDiXLvw0hJxY7wfrSXGED2aIn5k/lvJnzTv9fKfW414YUqEsIJAQQ3+cOXjSKmlVtnFWUnAGJncI5VQa2gDWB+gJBFgKsDV1zkRaLnPm3Eq38EsUsiLeUUBqa9+wUZ1LT0a+AjQ4TIteXPzBhZ8pBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKBQ52DF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CCF1F000E9;
	Sun, 21 Jun 2026 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782059158;
	bh=14RcKjKWjB9sN1q9ZY+S8mQ8DhuyHK5JPFkyrJkzLTw=;
	h=From:To:Cc:Subject:Date;
	b=PKBQ52DFnsLPf1KHeu3lF+oXABScm5nCPI7pbz67dQ91mkgO8YP8BfW3v7bdgQS9d
	 YttHfY+13ByXO6dOseio2z2Ullh4SZHUuVK+NWoKMFG1lHlx1F2AIavQIVJpRJp6eX
	 n82EaaWicfm5HGtJcZQJQejicnpTH/dpIK02rMnBoCWwU/IA/DXN6SuAddon3JoSEI
	 QZhS/x90IOo9xdn2jqgJZUfgnqjIP8DLUB4584bTPPKRgBWdGNYvIpye6ry8Avk408
	 Zgj//Md1coliFCqPA39QukQ9mPUHE/MiN5PmjWoCcx2s7zVoy1B3hJuSczFNZ8L/Wl
	 QOE9BXZcloOyg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	XIAO WU <xiaowu.417@qq.com>
Subject: [PATCH] NFSD: Guard admin state-revocation walks with NFSD_NET_UP
Date: Sun, 21 Jun 2026 12:25:51 -0400
Message-ID: <20260621162551.2469460-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22749-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neilb@ownmail.net,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:xiaowu.417@qq.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C2FC6AB432

Writing to /proc/fs/nfsd/unlock_filesystem, or sending the
NFSD_CMD_UNLOCK_FILESYSTEM or NFSD_CMD_UNLOCK_EXPORT netlink command,
walks the NFSv4 client hash tables to revoke open state and cancel
async COPY operations.  All three handlers gate that walk on
nn->nfsd_serv, but a listener added via portlist or netlink
listener_set sets nn->nfsd_serv before any nfsd thread starts.
nfsd_startup_net() has not yet allocated nn->conf_id_hashtbl, so the
walkers dereference a NULL table.  A local administrator with
CAP_SYS_ADMIN can crash the kernel this way without ever starting the
server.

nn->nfsd_serv is set when the service is created, which precedes
table allocation.  NFSD_NET_UP instead brackets the window where the
tables are live: set at the end of nfsd_startup_net() and cleared in
nfsd_shutdown_net() after they are freed, both under nfsd_mutex.
Gating the three unlock paths on NFSD_NET_UP fixes the startup-time
NULL dereference while preserving the earlier post-shutdown
use-after-free fix.

Reported-by: XIAO WU <xiaowu.417@qq.com>
Fixes: 1ac3629bf012 ("nfsd: prepare for supporting admin-revocation of state")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  7 +++----
 fs/nfsd/nfs4state.c | 14 ++++++--------
 fs/nfsd/nfsctl.c    |  6 +++---
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c413ed0810b9..8351ccaae59c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1588,10 +1588,9 @@ static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
  * @net: net namespace containing the copy operations
  * @sb: targeted superblock
  *
- * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
- *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
- *          at server shutdown without clearing the pointer, so a
- *          walk without these guarantees iterates freed slab memory.
+ * Context: Caller must hold nfsd_mutex with NFSD_NET_UP set.  Outside
+ *          that window nn->conf_id_hashtbl is unallocated or freed,
+ *          so the walk would dereference a NULL or dangling pointer.
  */
 void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4ae5d65c056a..a4398dc861a5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1946,10 +1946,9 @@ static void revoke_one_stid(struct nfsd_net *nn, struct nfs4_client *clp,
  * The clients which own the states will subsequently be notified that the
  * states have been "admin-revoked".
  *
- * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
- *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
- *          at server shutdown without clearing the pointer, so a
- *          walk without these guarantees iterates freed slab memory.
+ * Context: Caller must hold nfsd_mutex with NFSD_NET_UP set.  Outside
+ *          that window nn->conf_id_hashtbl is unallocated or freed,
+ *          so the walk would dereference a NULL or dangling pointer.
  */
 void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
@@ -2024,10 +2023,9 @@ static struct nfs4_stid *find_one_export_stid(struct nfs4_client *clp,
  * Userspace (exportfs -u) sends this after removing the last client
  * for a path, enabling the underlying filesystem to be unmounted.
  *
- * Context: Caller must hold nfsd_mutex with nn->nfsd_serv confirmed
- *          non-NULL.  nfs4_state_destroy_net() frees conf_id_hashtbl
- *          at server shutdown without clearing the pointer, so a
- *          walk without these guarantees iterates freed slab memory.
+ * Context: Caller must hold nfsd_mutex with NFSD_NET_UP set.  Outside
+ *          that window nn->conf_id_hashtbl is unallocated or freed,
+ *          so the walk would dereference a NULL or dangling pointer.
  */
 void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index caf59421f8f4..bc16fc7ca24f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -299,7 +299,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 	mutex_lock(&nfsd_mutex);
 	nn = net_generic(netns(file), nfsd_net_id);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd4_cancel_copy_by_sb(netns(file), path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
 	} else {
@@ -2424,7 +2424,7 @@ int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
 	} else {
@@ -2471,7 +2471,7 @@ int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info)
 		return error;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		nfsd_file_close_export(net, &path);
 		nfsd4_revoke_export_states(nn, &path);
 	} else
-- 
2.54.0


