Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFB5128F3
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 03:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiD1BmD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Apr 2022 21:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiD1BmC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Apr 2022 21:42:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A846E7EA12
        for <linux-nfs@vger.kernel.org>; Wed, 27 Apr 2022 18:38:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65FA3210EE;
        Thu, 28 Apr 2022 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651109928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UYu8aY/Bi1LG2I/Lzstp4Fzjn7cNUxESlHj0RyV0gc=;
        b=HYqfIgwr6MsD/ECw+k4Asp9yS7t+png2vhpZurFWRFnF19BrPkz03KbcfrmoQEKowK6251
        /VfkC47RRbg2/mR6hTjSM/T4OMnHkAjAcXlwHqQ7xyhFA2cWj02nNJB651h9xYNkhUtxIN
        o1toAcMiOwTbeSqL/OQUCdj+0DwswUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651109928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UYu8aY/Bi1LG2I/Lzstp4Fzjn7cNUxESlHj0RyV0gc=;
        b=Tafo+dnZXeCVd7AYXqSM0VU47YPOyp0oFcpQxyzZpfI/ElqE9Vmj/x9InqvxzEPp4yjGHP
        u2QH4AMT6W3mHNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 069EC13425;
        Thu, 28 Apr 2022 01:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HWpzLCbwaWJTbQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 28 Apr 2022 01:38:46 +0000
Subject: [PATCH 2/2] NFS: limit use of ACCESS cache for negative responses
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 28 Apr 2022 11:37:32 +1000
Message-ID: <165110985232.7595.17585053378305829045.stgit@noble.brown>
In-Reply-To: <165110909570.7595.8578730126480600782.stgit@noble.brown>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS currently caches the results of ACCESS lookups indefinitely while the
inode doesn't change (i.e.  while ctime, changeid, owner/group/mode etc
don't change).  This is a problem if the result from the server might
change.

When the result from the server depends purely on the credentials
provided by the client and the information in the inode, it is not
expected that the result from the server will change, and the current
behaviour is safe.

However in some configurations the server can include another lookup
step.  This happens with the Linux NFS server when the "--manage-gids"
option is given to rpc.mountd. NetApp servers have similar functionality
with "AUTH_SYS Extended Groups" functionality in ONTAP9.  With these,
the user reported by the client is mapped on the server to a list of
group ids.  If this mapping changes, the result of ACCESS can change.

This is particularly a problem when a new group is added to a user.  If
they had already tried and failed to access the file (or more commonly a
directory) then adding them to the group will not successfully give them
access as the failure is cached.  Even if the user logs out and back in
again to get the new credential on the client, they might try to access
the file before the server is aware of the change.  By default the Linux
server caches group information for 30 minutes.  This can be reduced but
there will always be a window after the group has been added when the
server can still report ACCESS based on old group information.

The inverse is less of a problem.  Removing someone from a group has
never been a guaranteed way to remove any access - at the very least a
user normally needs to log off before they lose access to any groups that
they were a member of.

If a user is removed from a group they may still be granted "access" on
the client, but this isn't sufficient to change anything for which write
access has been removed, and normally only provides read access to
cached content.  So caching positive ACCESS rights indefinitely is not a
significant security problem.

The value of the ACCESS cache is realised primarily for successful
tests.  These happen often, for example the test for X permissions
during filename lookups.  Having a quick (even lock-free) result helps
this common operation.  When the ACCESS cache denies the access there is
less cost in taking longer to confirm the access, and this is the case
where a stale cache is more problematic.

So, this patch changes the way that the access cache is used.
- If the requested access is found in the cache, and is granted, then the
  call uses the cached information no matter how old it is.
- If the requested access is found in the cache and is denied, then the
  cached result is only used if is it newer than the current MINATTRTIMEO
  for the file.
- If the requested access is found in the cache, is denied, and is more
  than MINATTRTIMEO old, then a new ACCESS request is made to the server
- If the requested access is NOT found in the cache, obviously a new
  ACCESS request is made to the server, and this will be cached.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c           |   24 +++++++++++++++++++-----
 fs/nfs/nfs4proc.c      |    1 +
 include/linux/nfs_fs.h |    1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b4e2c6a34234..c461029515b5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2900,7 +2900,8 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, u32 *mask, bool may_block)
+static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred,
+					u32 *mask, unsigned long *cjiffies, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_access_entry *cache;
@@ -2931,6 +2932,7 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 		retry = false;
 	}
 	*mask = cache->mask;
+	*cjiffies = cache->jiffies;
 	list_move_tail(&cache->lru, &nfsi->access_cache_entry_lru);
 	err = 0;
 out:
@@ -2942,7 +2944,8 @@ static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *
 	return -ENOENT;
 }
 
-static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cred, u32 *mask)
+static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cred,
+				     u32 *mask, unsigned long *cjiffies)
 {
 	/* Only check the most recently returned cache entry,
 	 * but do it without locking.
@@ -2965,6 +2968,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 		goto out;
 	*mask = cache->mask;
+	*cjiffies = cache->jiffies;
 	err = 0;
 out:
 	rcu_read_unlock();
@@ -2974,16 +2978,24 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 int nfs_access_check_cached(struct inode *inode, const struct cred *cred,
 			    u32 want, bool may_block)
 {
+	unsigned long cjiffies;
 	u32 have;
 	int status;
 
-	status = nfs_access_get_cached_rcu(inode, cred, &have);
+	status = nfs_access_get_cached_rcu(inode, cred, &have, &cjiffies);
 	if (status != 0)
 		status = nfs_access_get_cached_locked(inode, cred, &have,
-						      may_block);
+						      &cjiffies, may_block);
 
-	if (status == 0 && (want & ~have) != 0)
+	if (status == 0 && (want & ~have) != 0) {
 		status = -EACCES;
+		/* Don't trust a negative result beyond MINATTRTIMEO,
+		 * even if we hold a delegation
+		 */
+		if (!time_in_range_open(jiffies, cjiffies,
+					cjiffies + NFS_MINATTRTIMEO(inode)))
+			status = -ENOENT;
+	}
 	return status;
 }
 EXPORT_SYMBOL_GPL(nfs_access_check_cached);
@@ -3036,6 +3048,7 @@ void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set,
 	cache->fsgid = cred->fsgid;
 	cache->group_info = get_group_info(cred->group_info);
 	cache->mask = set->mask;
+	cache->jiffies = set->jiffies;
 
 	/* The above field assignments must be visible
 	 * before this item appears on the lru.  We cannot easily
@@ -3121,6 +3134,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 	 */
 	cache.mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND |
 		     nfs_access_xattr_mask(NFS_SERVER(inode));
+	cache.jiffies = jiffies;
 	if (S_ISDIR(inode->i_mode))
 		cache.mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
 	else
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1e80d88df588..a78b62c5bad1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2644,6 +2644,7 @@ static int nfs4_opendata_access(const struct cred *cred,
 		mask = NFS4_ACCESS_READ;
 
 	nfs_access_set_mask(&cache, opendata->o_res.access_result);
+	cache.jiffies = jiffies;
 	nfs_access_add_cache(state->inode, &cache, cred);
 
 	flags = NFS4_ACCESS_READ | NFS4_ACCESS_EXECUTE | NFS4_ACCESS_LOOKUP;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7614f621c42d..e40bd61c80c5 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -56,6 +56,7 @@
 struct nfs_access_entry {
 	struct rb_node		rb_node;
 	struct list_head	lru;
+	unsigned long		jiffies;
 	kuid_t			fsuid;
 	kgid_t			fsgid;
 	struct group_info	*group_info;


