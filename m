Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C05128F2
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiD1Bl5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Apr 2022 21:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiD1Bl5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Apr 2022 21:41:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CA7EA12
        for <linux-nfs@vger.kernel.org>; Wed, 27 Apr 2022 18:38:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D785E1F37F;
        Thu, 28 Apr 2022 01:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651109922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoKCsaGfsTOGC9N/Bhbr+pKiQVsIWfPcP+PixLIaDg8=;
        b=ZsgnEBLT35NafYPmdsLyXfDIuVb0BnadTEUrkLn25y7CldffmK6A5L8rE8dcl6unqLgoBd
        3yhbnmJdaPC4nSYeVjyIyCd5C/qxJ1eoHXRQRZLj+OREOumBK0U8EbippO4ehwp53LY2mw
        +rwZvPxRON/rE1lpnBwODjqGRY4cug0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651109922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoKCsaGfsTOGC9N/Bhbr+pKiQVsIWfPcP+PixLIaDg8=;
        b=XcQwMeSOVJcCFfuPptf8QNJjcQbvkB3L6QfEu9Z4oai10A4atADCjmNbeHQPDyRhb0iCKL
        3esEt788lwW8dZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6240B13425;
        Thu, 28 Apr 2022 01:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8rHJByHwaWJMbQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 28 Apr 2022 01:38:41 +0000
Subject: [PATCH 1/2] NFS: change nfs_access_get_cached() to
 nfs_access_check_cached()
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 28 Apr 2022 11:37:32 +1000
Message-ID: <165110985230.7595.10676160398710495817.stgit@noble.brown>
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

nfs_access_get_cached() reports (on success) the access modes known to
be permitted.  The caller than has to compare this against the wanted
modes.

This is replaced with nfs_access_check_cached() which is told what modes
are wanted and returns -EACCES if they are not available, 0 if they are,
or -ECHILD or -ENOENT as before.

This new interface will allow more subtlety for choose when to trust the
cache to be encoded in nfs_access_check_cached(), which is then
available to all callers.

nfs_access_calc_mask() is changed to nfs_calc_access_mask().  This new
function is given a set of Linux MAY_* flags and returns the
corresponding set of NFS_ACCESS_* flags.  This is the inverse of
nfs_access_calc_mask().

Because of this inversion there is a small change in behaviour.  For a
non-file, non-directory, the previous code would grant MAY_WRITE if any
for NFS_ACCESS_MODIFY, NFS_ACCESS_EXTEND, NFS_ACCESS_DELETE were
granted.
This new code does not support this "any" approach, and it isn't clear
it is the most correct approach.  So for non-file, non-directories,
MAY_WRITE will only be granted if NFS_ACCESS_MODIFY is granted.

The nfs_access_exit trace event now reports the NFS_ACCESS flags, not he
Linux MAY flags.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c           |   62 +++++++++++++++++++++++++-----------------------
 fs/nfs/nfs4proc.c      |   24 +++++++------------
 include/linux/nfs_fs.h |    4 ++-
 3 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c6b263b5faf1..b4e2c6a34234 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2971,19 +2971,22 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	return err;
 }
 
-int nfs_access_get_cached(struct inode *inode, const struct cred *cred,
-			  u32 *mask, bool may_block)
+int nfs_access_check_cached(struct inode *inode, const struct cred *cred,
+			    u32 want, bool may_block)
 {
+	u32 have;
 	int status;
 
-	status = nfs_access_get_cached_rcu(inode, cred, mask);
+	status = nfs_access_get_cached_rcu(inode, cred, &have);
 	if (status != 0)
-		status = nfs_access_get_cached_locked(inode, cred, mask,
-		    may_block);
+		status = nfs_access_get_cached_locked(inode, cred, &have,
+						      may_block);
 
+	if (status == 0 && (want & ~have) != 0)
+		status = -EACCES;
 	return status;
 }
-EXPORT_SYMBOL_GPL(nfs_access_get_cached);
+EXPORT_SYMBOL_GPL(nfs_access_check_cached);
 
 static void nfs_access_add_rbtree(struct inode *inode,
 				  struct nfs_access_entry *set,
@@ -3067,26 +3070,26 @@ EXPORT_SYMBOL_GPL(nfs_access_add_cache);
 #define NFS_DIR_MAY_WRITE NFS_MAY_WRITE
 #define NFS_MAY_LOOKUP (NFS_ACCESS_LOOKUP)
 #define NFS_MAY_EXECUTE (NFS_ACCESS_EXECUTE)
-static int
-nfs_access_calc_mask(u32 access_result, umode_t umode)
+static u32
+nfs_calc_access_mask(int may_mask, umode_t umode)
 {
-	int mask = 0;
+	int access_mask = 0;
 
-	if (access_result & NFS_MAY_READ)
-		mask |= MAY_READ;
+	if (may_mask & MAY_READ)
+		access_mask |= NFS_MAY_READ;
 	if (S_ISDIR(umode)) {
-		if ((access_result & NFS_DIR_MAY_WRITE) == NFS_DIR_MAY_WRITE)
-			mask |= MAY_WRITE;
-		if ((access_result & NFS_MAY_LOOKUP) == NFS_MAY_LOOKUP)
-			mask |= MAY_EXEC;
+		if (may_mask & MAY_WRITE)
+			access_mask |= NFS_DIR_MAY_WRITE;
+		if (may_mask & MAY_EXEC)
+			access_mask |= NFS_MAY_LOOKUP;
 	} else if (S_ISREG(umode)) {
-		if ((access_result & NFS_FILE_MAY_WRITE) == NFS_FILE_MAY_WRITE)
-			mask |= MAY_WRITE;
-		if ((access_result & NFS_MAY_EXECUTE) == NFS_MAY_EXECUTE)
-			mask |= MAY_EXEC;
-	} else if (access_result & NFS_MAY_WRITE)
-			mask |= MAY_WRITE;
-	return mask;
+		if (may_mask & MAY_WRITE)
+			access_mask |= NFS_FILE_MAY_WRITE;
+		if (may_mask & MAY_EXEC)
+			access_mask |= NFS_MAY_EXECUTE;
+	} else if (may_mask & MAY_WRITE)
+		access_mask |= NFS_ACCESS_MODIFY;
+	return access_mask;
 }
 
 void nfs_access_set_mask(struct nfs_access_entry *entry, u32 access_result)
@@ -3099,14 +3102,15 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 {
 	struct nfs_access_entry cache;
 	bool may_block = (mask & MAY_NOT_BLOCK) == 0;
-	int cache_mask = -1;
+	u32 want;
 	int status;
 
 	trace_nfs_access_enter(inode);
 
-	status = nfs_access_get_cached(inode, cred, &cache.mask, may_block);
-	if (status == 0)
-		goto out_cached;
+	want = nfs_calc_access_mask(mask, inode->i_mode);
+	status = nfs_access_check_cached(inode, cred, want, may_block);
+	if (status == 0 || status == -EACCES)
+		goto out;
 
 	status = -ECHILD;
 	if (!may_block)
@@ -3132,12 +3136,10 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 		goto out;
 	}
 	nfs_access_add_cache(inode, &cache, cred);
-out_cached:
-	cache_mask = nfs_access_calc_mask(cache.mask, inode->i_mode);
-	if ((mask & ~cache_mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) != 0)
+	if ((want & ~cache.mask) != 0)
 		status = -EACCES;
 out:
-	trace_nfs_access_exit(inode, mask, cache_mask, status);
+	trace_nfs_access_exit(inode, want, cache.mask, status);
 	return status;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 16106f805ffa..1e80d88df588 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7719,7 +7719,6 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
-	u32 mask;
 	int ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
@@ -7734,10 +7733,9 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 	 * do a cached access check for the XA* flags to possibly avoid
 	 * doing an RPC and getting EACCES back.
 	 */
-	if (!nfs_access_get_cached(inode, current_cred(), &mask, true)) {
-		if (!(mask & NFS_ACCESS_XAWRITE))
-			return -EACCES;
-	}
+	if (nfs_access_check_cached(inode, current_cred(), NFS_ACCESS_XAWRITE,
+				    true) == -EACCES)
+		return -EACCES;
 
 	if (buf == NULL) {
 		ret = nfs42_proc_removexattr(inode, key);
@@ -7756,16 +7754,14 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
-	u32 mask;
 	ssize_t ret;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
 
-	if (!nfs_access_get_cached(inode, current_cred(), &mask, true)) {
-		if (!(mask & NFS_ACCESS_XAREAD))
-			return -EACCES;
-	}
+	if (nfs_access_check_cached(inode, current_cred(), NFS_ACCESS_XAREAD,
+				    true) == -EACCES)
+		return -EACCES;
 
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (ret)
@@ -7788,15 +7784,13 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 	ssize_t ret, size;
 	char *buf;
 	size_t buflen;
-	u32 mask;
 
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return 0;
 
-	if (!nfs_access_get_cached(inode, current_cred(), &mask, true)) {
-		if (!(mask & NFS_ACCESS_XALIST))
-			return 0;
-	}
+	if (nfs_access_check_cached(inode, current_cred(), NFS_ACCESS_XALIST,
+				    true) == -EACCES)
+		return 0;
 
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (ret)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b48b9259e02c..7614f621c42d 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -530,8 +530,8 @@ extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
-extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred,
-				 u32 *mask, bool may_block);
+extern int nfs_access_check_cached(struct inode *inode, const struct cred *cred,
+				   u32 want, bool may_block);
 
 /*
  * linux/fs/nfs/symlink.c


