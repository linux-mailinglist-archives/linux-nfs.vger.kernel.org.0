Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7B67A88F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jan 2023 03:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjAYCDr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 21:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAYCDr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 21:03:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B8113EE
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 18:03:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 442E91F45F;
        Wed, 25 Jan 2023 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674612223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J57XR7+8Ocoi+sa2OrIVzTmdziPnEpAQSem1k52AdwY=;
        b=XyR3eLepUk2ehA++VWZWKDqYYEIETrMFJeyNrp0zq47g/Q0BZF6ki7OpSe3bApdxZaHuzS
        DiVrVJE/5j+mH+6ZO22IvrexiuCrvbsBxqco4b4KOD6uMYEUHNGjgHc5pG5mCFJPpwsJT4
        TKCWyDSQS3vVBDDOcuGz/GSdCsaXM8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674612223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J57XR7+8Ocoi+sa2OrIVzTmdziPnEpAQSem1k52AdwY=;
        b=nlPkMvZeoguwsyFwbQFy0ppEqNAl22im8bqXpxU/rW+WYL/2azOwW4pLBuQwmxpZD9g8dD
        lTPQZ2dAJglmF2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 168A31339E;
        Wed, 25 Jan 2023 02:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f0X6Kf2N0GNXTgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 25 Jan 2023 02:03:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH/RFC] NFSv3 handle out-of-order write replies
Date:   Wed, 25 Jan 2023 13:03:37 +1100
Message-id: <167461221711.23017.1840413589310764555@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


NFSv3 includes pre/post wcc attributes which allow the client to
determine if all changes to the file have been made by itself, or any
might have been made by some other client.  IF there are gaps in the
pre/post ctime sequence it must be assumed that some other client caused
that change in that gap and the local cache must be suspect.  The next
time the file is opened, the cache should be invalidated.

Since Commit 1c341b777501 ("NFS: Add deferred cache invalidation for
close-to-open consistency violations") (I think) in linux 5.3 the Linux
client has been triggering this invalidation.  The chunk in
nfs_update_inode() in particularly triggers.

Unfortunately Linux NFS assumes that all replies will be processed in
the order sent, and will arrive in the order processed.  This is not
true in general.  Linux might ignore the wcc info in a WRITE reply -
even though the pre-ctime might match the current iversion - because the
reply is for a request that was sent before some other request for which
a reply has already been seen.  This is detected by Linux using the
gencount tests in nfs_inode_attr_cmp().

Also, when the gencount tests pass it is still possible that the
requests were processed on the service in a different order, and a gap
in the ctime sequence might be filled in by a subsequent reply.  Linux
NFS does not try to detect this.

The net result is that writing to a server and then reading the file
back can result in going to the server for the read rather than serving
it from cache - all because a couple of replies arrived out-of-order.
This is a performance regression over kernels before 5.3 (though that
change is a correctness improvement).

This has been seen with Linux writing to a Netapp server which can
occasionally re-order requests.  I have also demonstrated it with a
modified Linux server which adds pre/post attributes to V3 write
replies, and occasionally adds a delay to  force reply reordering.

This patch attempts to address the problem by replacing the
NFS_INO_DATA_INVAL_DEFER flag with a small array of segments in the
ctime sequence which have not yet been seen in replies.  Rather than
setting the flag, we add the missing segment to the array.  Rather
than testing the flag, we check if the array is empty.

The array contains A,B pairs when the local iversion is advanced from A
to B, and B,A pairs when a reply tells us that the ctime (aka the
change-id) has advanced from A to B on the server.
Overlapping segments are merged and inverted segments cancel (which
effectively comes to the same thing).  Empty segments are removed.

An expected reply (probably the common case) will have the server say
that ctime went from A to B, and Linux will update the iversion from A
to B.  Rather than adding A,B and the B,A which will cancel out, we
simply don't bother.

One difficulty in this is that in some circumstances,
NFS_ATTR_FATTR_PRECHANGE is cleared.  This causes the gap tracking to
fail because we can only add pre/post attributes to the table if bother
NFS_ATTR_FATTR_PRECHANGE and NFS_ATTR_FATTR_CHANGE are set.  If one is
cleared, we have a problem.

This patch works around that by introducing a new
NFS_ATTR_FATTR_PRECHANGE_RAW whcih is set when the normal PRECHANGE is
cleared.  If either PRECHANGE or PRECHANGE_RAW a set then we can use the
prechange value.  Obviously this is a hack.  I would be keen to
understand why PRECHANGE is being cleared so I can find a better
resolution.

I haven't given much thought to directories.  A number of places call
	nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);

only on directories and I don't understand why.  As directories still
have pre/post attributes even in NFSv4 it would be good to understand
how to get this right.

Any help would be most appreciated.

Thanks,
NeilBrown


diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f594dac436a7..8535372861e9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -84,7 +84,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 		ctx->dtsize =3D NFS_INIT_DTSIZE;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
-		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
+		    nfs_ooo_test(nfsi))
 			nfs_set_cache_invalid(dir,
 					      NFS_INO_INVALID_DATA |
 						      NFS_INO_REVAL_FORCED);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6b2cfa59a1a2..4c9ad2e6586e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -208,11 +208,12 @@ void nfs_set_cache_invalid(struct inode *inode, unsigne=
d long flags)
=20
 	nfsi->cache_validity |=3D flags;
=20
-	if (inode->i_mapping->nrpages =3D=3D 0)
-		nfsi->cache_validity &=3D ~(NFS_INO_INVALID_DATA |
-					  NFS_INO_DATA_INVAL_DEFER);
-	else if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
-		nfsi->cache_validity &=3D ~NFS_INO_DATA_INVAL_DEFER;
+	if (inode->i_mapping->nrpages =3D=3D 0) {
+		nfsi->cache_validity &=3D ~NFS_INO_INVALID_DATA;
+		nfs_ooo_clear(nfsi);
+	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
+		nfs_ooo_clear(nfsi);
+	}
 	trace_nfs_set_cache_invalid(inode, 0);
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
@@ -677,9 +678,10 @@ static int nfs_vmtruncate(struct inode * inode, loff_t o=
ffset)
 	trace_nfs_size_truncate(inode, offset);
 	i_size_write(inode, offset);
 	/* Optimisation */
-	if (offset =3D=3D 0)
-		NFS_I(inode)->cache_validity &=3D ~(NFS_INO_INVALID_DATA |
-				NFS_INO_DATA_INVAL_DEFER);
+	if (offset =3D=3D 0) {
+		NFS_I(inode)->cache_validity &=3D ~NFS_INO_INVALID_DATA;
+		nfs_ooo_clear(NFS_I(inode));
+	}
 	NFS_I(inode)->cache_validity &=3D ~NFS_INO_INVALID_SIZE;
=20
 	spin_unlock(&inode->i_lock);
@@ -1101,7 +1103,7 @@ void nfs_inode_attach_open_context(struct nfs_open_cont=
ext *ctx)
=20
 	spin_lock(&inode->i_lock);
 	if (list_empty(&nfsi->open_files) &&
-	    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
+	    nfs_ooo_test(nfsi))
 		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA |
 						     NFS_INO_REVAL_FORCED);
 	list_add_tail_rcu(&ctx->list, &nfsi->open_files);
@@ -1344,8 +1346,8 @@ int nfs_clear_invalid_mapping(struct address_space *map=
ping)
=20
 	set_bit(NFS_INO_INVALIDATING, bitlock);
 	smp_wmb();
-	nfsi->cache_validity &=3D
-		~(NFS_INO_INVALID_DATA | NFS_INO_DATA_INVAL_DEFER);
+	nfsi->cache_validity &=3D ~NFS_INO_INVALID_DATA;
+	nfs_ooo_clear(nfsi);
 	spin_unlock(&inode->i_lock);
 	trace_nfs_invalidate_mapping_enter(inode);
 	ret =3D nfs_invalidate_mapping(inode, mapping);
@@ -1807,6 +1809,38 @@ static int nfs_inode_finish_partial_attr_update(const =
struct nfs_fattr *fattr,
 	return 0;
 }
=20
+static void nfs_ooo_merge(struct nfs_inode *nfsi,
+			  u64 start, u64 end)
+{
+	int i, cnt;
+
+	/* add this range, merging if possible */
+	cnt =3D nfsi->ooo_cnt;
+	for (i =3D 0; i < cnt; i++) {
+		if (end =3D=3D nfsi->ooo[i][0])
+			end =3D nfsi->ooo[i][1];
+		else if (start =3D=3D nfsi->ooo[i][1])
+			start =3D nfsi->ooo[i][0];
+		else
+			continue;
+		/* Remove 'i' from table and loop to insert the new range */
+		cnt -=3D 1;
+		nfsi->ooo[i][0] =3D nfsi->ooo[cnt][0];
+		nfsi->ooo[i][1] =3D nfsi->ooo[cnt][1];
+		i =3D -1;
+	}
+	if (start !=3D end && cnt < ARRAY_SIZE(nfsi->ooo)) {
+		nfsi->ooo[cnt][0] =3D start;
+		nfsi->ooo[cnt][1] =3D end;
+		cnt +=3D 1;
+	}
+	if (cnt > nfsi->ooo_max) {
+		printk("ooo_max -> %d\n", cnt);
+		nfsi->ooo_max =3D cnt;
+	}
+	nfsi->ooo_cnt =3D cnt;
+}
+
 static int nfs_refresh_inode_locked(struct inode *inode,
 				    struct nfs_fattr *fattr)
 {
@@ -1817,8 +1851,17 @@ static int nfs_refresh_inode_locked(struct inode *inod=
e,
=20
 	if (attr_cmp > 0 || nfs_inode_finish_partial_attr_update(fattr, inode))
 		ret =3D nfs_update_inode(inode, fattr);
-	else if (attr_cmp =3D=3D 0)
-		ret =3D nfs_check_inode_attributes(inode, fattr);
+	else {
+		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) &&
+		    (fattr->valid & (NFS_ATTR_FATTR_PRECHANGE |
+				     NFS_ATTR_FATTR_PRECHANGE_RAW)))
+			nfs_ooo_merge(NFS_I(inode),
+				      fattr->change_attr,
+				      fattr->pre_change_attr);
+
+		if (attr_cmp =3D=3D 0)
+			ret =3D nfs_check_inode_attributes(inode, fattr);
+	}
=20
 	trace_nfs_refresh_inode_exit(inode, ret);
 	return ret;
@@ -1909,6 +1952,8 @@ int nfs_post_op_update_inode_force_wcc_locked(struct in=
ode *inode, struct nfs_fa
 	if (attr_cmp < 0)
 		return 0;
 	if ((fattr->valid & NFS_ATTR_FATTR) =3D=3D 0 || !attr_cmp) {
+		if (fattr->valid & NFS_ATTR_FATTR_PRECHANGE)
+			fattr->valid |=3D NFS_ATTR_FATTR_PRECHANGE_RAW;
 		fattr->valid &=3D ~(NFS_ATTR_FATTR_PRECHANGE
 				| NFS_ATTR_FATTR_PRESIZE
 				| NFS_ATTR_FATTR_PREMTIME
@@ -2084,8 +2129,13 @@ static int nfs_update_inode(struct inode *inode, struc=
t nfs_fattr *fattr)
 				dprintk("NFS: change_attr change on server for file %s/%ld\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
-			} else if (!have_delegation)
-				nfsi->cache_validity |=3D NFS_INO_DATA_INVAL_DEFER;
+			} else if (!have_delegation) {
+				if (fattr->valid & NFS_ATTR_FATTR_PRECHANGE)
+					nfs_ooo_merge(nfsi, fattr->change_attr,
+						      fattr->pre_change_attr);
+				nfs_ooo_merge(nfsi, inode_peek_iversion_raw(inode),
+					      fattr->change_attr);
+			}
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		}
 	} else {
@@ -2239,6 +2289,8 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 		return NULL;
 	nfsi->flags =3D 0UL;
 	nfsi->cache_validity =3D 0UL;
+	nfsi->ooo_cnt =3D 0;
+	nfsi->ooo_max =3D 0;
 #if IS_ENABLED(CONFIG_NFS_V4)
 	nfsi->nfs4_acl =3D NULL;
 #endif /* CONFIG_NFS_V4 */
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8c6cc58679ff..cdf77f49ef8f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -28,7 +28,6 @@
 			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
 			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
 			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" }, \
-			{ NFS_INO_DATA_INVAL_DEFER, "DATA_INVAL_DEFER" }, \
 			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
 			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 7931fa472561..8a83d6d204ed 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -190,6 +190,33 @@ struct nfs_inode {
 	/* Open contexts for shared mmap writes */
 	struct list_head	open_files;
=20
+	/* Keep track of out-of-order replies.
+	 * The ooo array contains start/end pairs of
+	 * number from the changeid sequence when
+	 * the inodes iversion has been updated.
+	 * It also contains end/start pair (i.e. reverse order)
+	 * of sections of the changeid sequence that have
+	 * been seen in replies from the server.
+	 * Normally these should match and when both
+	 * A:B and B:A are found in ooo, they are both removed.
+	 * And if a reply with A:B causes an iversion update
+	 * of A:B, then neither are added.
+	 * When a reply has pre_change that doesn't match
+	 * iversion, then the changeid pair, and any consequent
+	 * change in iversion ARE added.  Later replies
+	 * might fill in the gaps, or possibly a gap is caused
+	 * by a change from another client.
+	 * When a file or directory is opened, if the ooo table
+	 * is not empty, then we assume the gaps were due to
+	 * another client and we invalidate the cached data.
+	 *
+	 * We can only track a limited number of concurrent gaps.
+	 * Currently that limit is 16.
+	 */
+	int ooo_cnt;
+	int ooo_max; // TRACING
+	unsigned long ooo[16][2];
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct nfs4_cached_acl	*nfs4_acl;
         /* NFSv4 state */
@@ -253,8 +280,6 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_MTIME	BIT(10)		/* cached mtime is invalid */
 #define NFS_INO_INVALID_SIZE	BIT(11)		/* cached size is invalid */
 #define NFS_INO_INVALID_OTHER	BIT(12)		/* other attrs are invalid */
-#define NFS_INO_DATA_INVAL_DEFER	\
-				BIT(13)		/* Deferred cache invalidation */
 #define NFS_INO_INVALID_BLOCKS	BIT(14)         /* cached blocks are invalid =
*/
 #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
@@ -615,6 +640,19 @@ nfs_fileid_to_ino_t(u64 fileid)
 	return ino;
 }
=20
+static inline void nfs_ooo_clear(struct nfs_inode *nfsi)
+{
+	nfsi->ooo_cnt =3D 0;
+}
+
+static inline bool nfs_ooo_test(struct nfs_inode *nfsi)
+{
+	if (nfsi->ooo_cnt =3D=3D 0)
+		return false;
+	printk("nfs_ooo_test_and_clear() found %d\n", nfsi->ooo_cnt);
+	return true;
+}
+
 #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
=20
 /* We need to block new opens while a file is being unlinked.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..b18a877b16eb 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -106,6 +106,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_OWNER_NAME	(1U << 23)
 #define NFS_ATTR_FATTR_GROUP_NAME	(1U << 24)
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL (1U << 25)
+#define NFS_ATTR_FATTR_PRECHANGE_RAW	(1U << 26)
=20
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \

