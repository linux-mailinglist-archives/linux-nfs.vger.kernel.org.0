Return-Path: <linux-nfs+bounces-23135-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qs8IAlQDTWr5tQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23135-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 15:47:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EC71C180
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 15:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=POB+r+HT;
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23135-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23135-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 459CD30E449F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340641A798;
	Tue,  7 Jul 2026 13:38:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9341DECC
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 13:38:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431512; cv=none; b=qFGn8cNGSgW2ZHpUlB/I7DsPY4IOtXA7r1fDp4pXWdcZRSlvgIfSR8VZJhrbKzumru2mp7yy/ShzY1EecO2msm2r5gOR/qzxMLrN0D6it8i4x81sc0cqAmzbcsGoR42SFNu2DYClk95wJlEzU5eQ07m1DoPuNyepZIx8PjjvWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431512; c=relaxed/simple;
	bh=CAOKO26TrvhNKTCTi1mLGkUVJu5FOrCWcSSMjaIyxRk=;
	h=Cc:Subject:To:From:Mime-Version:Date:Message-Id:Content-Type; b=ARcDj47sf1Hpc4kkYhCFDhambrLB4s0GUwpBVql0gYyAMsTQwP6HOWtdPWiNAtXunCZw0f0hMdhKqWR7CRNmdi7EbS6B8FBI+9Jww5ltR+zJ3FiwMZNuxm1umICc1wgRutGvB8IusKlxaS52b65yFLTgY82GAD2YDuzY47uZDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=POB+r+HT; arc=none smtp.client-ip=209.127.230.114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783431389; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bZJdeq9x+0olXhdzGkx99j28dj4IuTHPhV/YZ7oU4lI=;
 b=POB+r+HTpPHA55Kb9cYIkULiwV4swUWameJNPaMo286TXYQu3o4AoSDvErF5GC0MUWHYC5
 sqeybzFgwfTkXin2Ab/gnfGiNj2apOftusxBGCy4DSX6UGAlInUvm04hEelC3a+yQXBAmE
 0r+2PSNns3lnLc+7tMB1bdVy5Lghhb7R/u56flfKf3XBF/Bl7lZd/zXETWunDP1XV6R+Fe
 cyDY73rp6EaBo1a/4t6nmFhEAzf9kYLH2ma2RbWuP3yhOKeA+CcBCkGJ7vL4KPYhC5PTXP
 UKLfGh8xIkGIDR3QmerBFyPbthhcGPCwsy/7JTfNKKEsDiTol0v7myOx1PyX1Q==
Cc: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jia Zhu" <zhujia.zj@bytedance.com>
X-Lms-Return-Path: <lba+26a4d00db+e362ca+vger.kernel.org+zhujia.zj@bytedance.com>
Subject: [PATCH] NFSv4: pin the superblock for active state owners
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: <trondmy@kernel.org>, <anna@kernel.org>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Tue,  7 Jul 2026 21:36:23 +0800
Message-Id: <20260707133623.23078-1-zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhujia.zj@bytedance.com,m:trondmy@kernel.org,m:anna@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23135-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bytedance.com:from_mime,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 877EC71C180

NFSv4 open state can outlive the file and dentry that created it. This
was observed in production when NFSv4 state recovery, such as after a
server reboot or lease expiration, raced with unmount.

The race requires recovery to hold an open state reference while the last
open file is closed and the filesystem is unmounted, allowing the
superblock's active reference to drop to zero between
refcount_inc(&state->count) and nfs4_put_open_state():

    state manager                    umount

    nfs4_run_state_manager()
      nfs4_do_reclaim()
        nfs4_reclaim_open_state()
          refcount_inc(&state->count)
          ...
                                      close last file
                                      generic_shutdown_super()
                                        "Busy inodes after unmount"
                                      nfs_free_server()
          nfs4_put_open_state()
            iput(inode)
              evict()
                nfs_clear_inode()
                  nfs_zap_acl_cache()

The "VFS: Busy inodes after unmount" warning is the visible symptom of
that lifetime mismatch: superblock teardown proceeds even though the NFS
open state still pins an inode. After umount has freed the server, the
state manager can then run nfs4_put_open_state() for the last open-state
reference. The resulting iput(inode) can evict an NFS inode with freed
server data, causing crashes at nfs_zap_acl_cache(). This can be
reproduced by delaying the reclaim path before nfs4_put_open_state(),
then closing the last file and unmounting the NFS mount.

Pin the superblock while a state owner is active, and drop the pin when
the owner becomes idle again, so the NFS server stays alive until all
open state associated with the owner has been released.

Assisted-by: Codex:GPT-5
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/nfs/nfs4state.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 305a772e54976..a5dec0473e221 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -351,6 +351,26 @@ const struct cred *nfs4_get_clid_cred(struct nfs_client *clp)
 	return cred;
 }
 
+static bool
+nfs4_get_state_owner_active_locked(struct nfs4_state_owner *sp)
+{
+	struct nfs_server *server = sp->so_server;
+
+	/*
+	 * A counted state owner may dereference so_server until the final
+	 * nfs4_put_state_owner().  Pin the superblock when reviving an idle
+	 * owner so umount cannot free the server underneath it.
+	 */
+	if (atomic_read(&sp->so_count) == 0) {
+		if (!nfs_sb_active(server->super))
+			return false;
+		if (!list_empty(&sp->so_lru))
+			list_del_init(&sp->so_lru);
+	}
+	atomic_inc(&sp->so_count);
+	return true;
+}
+
 static struct nfs4_state_owner *
 nfs4_find_state_owner_locked(struct nfs_server *server, const struct cred *cred)
 {
@@ -369,9 +389,8 @@ nfs4_find_state_owner_locked(struct nfs_server *server, const struct cred *cred)
 		else if (cmp > 0)
 			p = &parent->rb_right;
 		else {
-			if (!list_empty(&sp->so_lru))
-				list_del_init(&sp->so_lru);
-			atomic_inc(&sp->so_count);
+			if (!nfs4_get_state_owner_active_locked(sp))
+				return NULL;
 			return sp;
 		}
 	}
@@ -397,9 +416,8 @@ nfs4_insert_state_owner_locked(struct nfs4_state_owner *new)
 		else if (cmp > 0)
 			p = &parent->rb_right;
 		else {
-			if (!list_empty(&sp->so_lru))
-				list_del_init(&sp->so_lru);
-			atomic_inc(&sp->so_count);
+			if (!nfs4_get_state_owner_active_locked(sp))
+				return NULL;
 			return sp;
 		}
 	}
@@ -449,6 +467,10 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	sp = kzalloc_obj(*sp, gfp_flags);
 	if (!sp)
 		return NULL;
+	if (!nfs_sb_active(server->super)) {
+		kfree(sp);
+		return NULL;
+	}
 	sp->so_seqid.owner_id = atomic64_inc_return(&server->owner_ctr);
 	sp->so_server = server;
 	sp->so_cred = get_cred(cred);
@@ -534,8 +556,10 @@ struct nfs4_state_owner *nfs4_get_state_owner(struct nfs_server *server,
 	spin_lock(&clp->cl_lock);
 	sp = nfs4_insert_state_owner_locked(new);
 	spin_unlock(&clp->cl_lock);
-	if (sp != new)
+	if (sp != new) {
 		nfs4_free_state_owner(new);
+		nfs_sb_deactive(server->super);
+	}
 out:
 	nfs4_gc_state_owners(server);
 	return sp;
@@ -557,6 +581,7 @@ void nfs4_put_state_owner(struct nfs4_state_owner *sp)
 {
 	struct nfs_server *server = sp->so_server;
 	struct nfs_client *clp = server->nfs_client;
+	struct super_block *sb = server->super;
 
 	if (!atomic_dec_and_lock(&sp->so_count, &clp->cl_lock))
 		return;
@@ -564,6 +589,7 @@ void nfs4_put_state_owner(struct nfs4_state_owner *sp)
 	sp->so_expires = jiffies;
 	list_add_tail(&sp->so_lru, &server->state_owners_lru);
 	spin_unlock(&clp->cl_lock);
+	nfs_sb_deactive(sb);
 }
 
 /**
-- 
2.20.1

