Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4818F6C3DB5
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 23:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCUW1N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 18:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUW1M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 18:27:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29049570B5
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 15:27:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1E66205B1;
        Tue, 21 Mar 2023 22:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679437629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EutSWAjqGxT4Tfbsj+CABBX+EqNELA/sUCsP+E6na5Q=;
        b=SepKRhIKed04K5oVb61mJ7nQKgkeLWNjyOed/rTeW7exihyfa4jA48vU7VzDvAl3Kc/Xov
        0IwiypgzSm3YYej5DZVcvViYdnRTdZVALac30soyTDdLj9xQ446+U1s0u6R3Ca6AgZi01x
        eUzHbfqjYMRw0QP9dgN6KCSiC80ZpiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679437629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EutSWAjqGxT4Tfbsj+CABBX+EqNELA/sUCsP+E6na5Q=;
        b=W5cCvYLcaKIEQUQSb3vTcD9pEtvI5TCdtYHNjLdkodK/+ZpWxr3Aq5GX5v0yOA6x27/F0U
        DdabiU6O6mQyH6DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98D4013440;
        Tue, 21 Mar 2023 22:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JsUwFDwvGmQtMwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 21 Mar 2023 22:27:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH v5] NFSv3: handle out-of-order write replies.
Date:   Wed, 22 Mar 2023 09:27:04 +1100
Message-id: <167943762461.8008.3152357340238024342@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


NFSv3 includes pre/post wcc attributes which allow the client to
determine if all changes to the file have been made by the client
itself, or if any might have been made by some other client.

If there are gaps in the pre/post ctime sequence it must be assumed that
some other client changed the file in that gap and the local cache must
be suspect.  The next time the file is opened the cache should be
invalidated.

Since Commit 1c341b777501 ("NFS: Add deferred cache invalidation for
close-to-open consistency violations") in linux 5.3 the Linux client has
been triggering this invalidation.  The chunk in nfs_update_inode() in
particularly triggers.

Unfortunately Linux NFS assumes that all replies will be processed in
the order sent, and will arrive in the order processed.  This is not
true in general.  Consequently Linux NFS might ignore the wcc info in a
WRITE reply because the reply is in response to a WRITE that was sent
before some other request for which a reply has already been seen.  This
is detected by Linux using the gencount tests in nfs_inode_attr_cmp().

Also, when the gencount tests pass it is still possible that the request
were processed on the server in a different order, and a gap seen in
the ctime sequence might be filled in by a subsequent reply, so gaps
should not immediately trigger delayed invalidation.

The net result is that writing to a server and then reading the file
back can result in going to the server for the read rather than serving
it from cache - all because a couple of replies arrived out-of-order.
This is a performance regression over kernels before 5.3, though the
change in 5.3 is a correctness improvement.

This has been seen with Linux writing to a Netapp server which
occasionally re-orders requests.  In testing the majority of requests
were in-order, but a few (maybe 2 or three at a time) could be
re-ordered.

This patch addresses the problem by recording any gaps seen in the
pre/post ctime sequence and not triggering invalidation until either
there are too many gaps to fit in the table, or until there are no more
active writes and the remaining gaps cannot be resolved.

We allocate a table of 16 gaps on demand.  If the allocation fails we
revert to current behaviour which is of little cost as we are unlikely
to be able to cache the writes anyway.

In the table we store "start->end" pair when iversion is updated and
"end<-start" pairs pre/post pairs reported by the server.  Usually these
exactly cancel out and so nothing is stored.  When there are
out-of-order replies we do store gaps and these will eventually be
cancelled against later replies when this client is the only writer.

If the final write is out-of-order there may be one gap remaining when
the file is closed.  This will be noticed and if there is precisely on
gap and if the iversion can be advanced to match it, then we do so.

This patch makes no attempt to handle directories correctly.  The same
problem potentially exists in the out-of-order replies to create/unlink
requests can cause future lookup requires to be sent to the server
unnecessarily.  A similar scheme using the same primitives could be used
to notice and handle out-of-order replies.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/inode.c         | 112 +++++++++++++++++++++++++++++++++++------
 include/linux/nfs_fs.h |  47 +++++++++++++++++
 2 files changed, 144 insertions(+), 15 deletions(-)

NOTE this differs from v4 only in nfs_ooo_clear().  Previousl the wrong
flag was being cleared.  This has been corrected.
NeilBrown


diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 222a28320e1c..29faa0de4edc 100644
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
@@ -1109,7 +1111,7 @@ void nfs_inode_attach_open_context(struct nfs_open_cont=
ext *ctx)
=20
 	spin_lock(&inode->i_lock);
 	if (list_empty(&nfsi->open_files) &&
-	    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
+	    nfs_ooo_test(nfsi))
 		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA |
 						     NFS_INO_REVAL_FORCED);
 	list_add_tail_rcu(&ctx->list, &nfsi->open_files);
@@ -1353,8 +1355,8 @@ int nfs_clear_invalid_mapping(struct address_space *map=
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
@@ -1816,6 +1818,66 @@ static int nfs_inode_finish_partial_attr_update(const =
struct nfs_fattr *fattr,
 	return 0;
 }
=20
+static void nfs_ooo_merge(struct nfs_inode *nfsi,
+			  u64 start, u64 end)
+{
+	int i, cnt;
+
+	if (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER)
+		/* No point merging anything */
+		return;
+
+	if (!nfsi->ooo) {
+		nfsi->ooo =3D kmalloc(sizeof(*nfsi->ooo), GFP_ATOMIC);
+		if (!nfsi->ooo) {
+			nfsi->cache_validity |=3D NFS_INO_DATA_INVAL_DEFER;
+			return;
+		}
+		nfsi->ooo->cnt =3D 0;
+	}
+
+	/* add this range, merging if possible */
+	cnt =3D nfsi->ooo->cnt;
+	for (i =3D 0; i < cnt; i++) {
+		if (end =3D=3D nfsi->ooo->gap[i].start)
+			end =3D nfsi->ooo->gap[i].end;
+		else if (start =3D=3D nfsi->ooo->gap[i].end)
+			start =3D nfsi->ooo->gap[i].start;
+		else
+			continue;
+		/* Remove 'i' from table and loop to insert the new range */
+		cnt -=3D 1;
+		nfsi->ooo->gap[i] =3D nfsi->ooo->gap[cnt];
+		i =3D -1;
+	}
+	if (start !=3D end) {
+		if (cnt >=3D ARRAY_SIZE(nfsi->ooo->gap)) {
+			nfsi->cache_validity |=3D NFS_INO_DATA_INVAL_DEFER;
+			kfree(nfsi->ooo);
+			nfsi->ooo =3D NULL;
+			return;
+		}
+		nfsi->ooo->gap[cnt].start =3D start;
+		nfsi->ooo->gap[cnt].end =3D end;
+		cnt +=3D 1;
+	}
+	nfsi->ooo->cnt =3D cnt;
+}
+
+static void nfs_ooo_record(struct nfs_inode *nfsi,
+			   struct nfs_fattr *fattr)
+{
+	/* This reply was out-of-order, so record in the
+	 * pre/post change id, possibly cancelling
+	 * gaps created when iversion was jumpped forward.
+	 */
+	if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) &&
+	    (fattr->valid & NFS_ATTR_FATTR_PRECHANGE))
+		nfs_ooo_merge(nfsi,
+			      fattr->change_attr,
+			      fattr->pre_change_attr);
+}
+
 static int nfs_refresh_inode_locked(struct inode *inode,
 				    struct nfs_fattr *fattr)
 {
@@ -1826,8 +1888,12 @@ static int nfs_refresh_inode_locked(struct inode *inod=
e,
=20
 	if (attr_cmp > 0 || nfs_inode_finish_partial_attr_update(fattr, inode))
 		ret =3D nfs_update_inode(inode, fattr);
-	else if (attr_cmp =3D=3D 0)
-		ret =3D nfs_check_inode_attributes(inode, fattr);
+	else {
+		nfs_ooo_record(NFS_I(inode), fattr);
+
+		if (attr_cmp =3D=3D 0)
+			ret =3D nfs_check_inode_attributes(inode, fattr);
+	}
=20
 	trace_nfs_refresh_inode_exit(inode, ret);
 	return ret;
@@ -1918,6 +1984,8 @@ int nfs_post_op_update_inode_force_wcc_locked(struct in=
ode *inode, struct nfs_fa
 	if (attr_cmp < 0)
 		return 0;
 	if ((fattr->valid & NFS_ATTR_FATTR) =3D=3D 0 || !attr_cmp) {
+		/* Record the pre/post change info before clearing PRECHANGE */
+		nfs_ooo_record(NFS_I(inode), fattr);
 		fattr->valid &=3D ~(NFS_ATTR_FATTR_PRECHANGE
 				| NFS_ATTR_FATTR_PRESIZE
 				| NFS_ATTR_FATTR_PREMTIME
@@ -2072,6 +2140,15 @@ static int nfs_update_inode(struct inode *inode, struc=
t nfs_fattr *fattr)
=20
 	/* More cache consistency checks */
 	if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
+		if (!have_writers && nfsi->ooo && nfsi->ooo->cnt =3D=3D 1 &&
+		    nfsi->ooo->gap[0].end =3D=3D inode_peek_iversion_raw(inode)) {
+			/* There is one remaining gap that hasn't been
+			 * merged into iversion - do that now.
+			 */
+			inode_set_iversion_raw(inode, nfsi->ooo->gap[0].start);
+			kfree(nfsi->ooo);
+			nfsi->ooo =3D NULL;
+		}
 		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
 			/* Could it be a race with writeback? */
 			if (!(have_writers || have_delegation)) {
@@ -2093,8 +2170,11 @@ static int nfs_update_inode(struct inode *inode, struc=
t nfs_fattr *fattr)
 				dprintk("NFS: change_attr change on server for file %s/%ld\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
-			} else if (!have_delegation)
-				nfsi->cache_validity |=3D NFS_INO_DATA_INVAL_DEFER;
+			} else if (!have_delegation) {
+				nfs_ooo_record(nfsi, fattr);
+				nfs_ooo_merge(nfsi, inode_peek_iversion_raw(inode),
+					      fattr->change_attr);
+			}
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		}
 	} else {
@@ -2248,6 +2328,7 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 		return NULL;
 	nfsi->flags =3D 0UL;
 	nfsi->cache_validity =3D 0UL;
+	nfsi->ooo =3D NULL;
 #if IS_ENABLED(CONFIG_NFS_V4)
 	nfsi->nfs4_acl =3D NULL;
 #endif /* CONFIG_NFS_V4 */
@@ -2260,6 +2341,7 @@ EXPORT_SYMBOL_GPL(nfs_alloc_inode);
=20
 void nfs_free_inode(struct inode *inode)
 {
+	kfree(NFS_I(inode)->ooo);
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
 EXPORT_SYMBOL_GPL(nfs_free_inode);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index bf89fe6fc3ba..ac5dfe788297 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -191,6 +191,39 @@ struct nfs_inode {
 	/* Open contexts for shared mmap writes */
 	struct list_head	open_files;
=20
+	/* Keep track of out-of-order replies.
+	 * The ooo array contains start/end pairs of
+	 * numbers from the changeid sequence when
+	 * the inode's iversion has been updated.
+	 * It also contains end/start pair (i.e. reverse order)
+	 * of sections of the changeid sequence that have
+	 * been seen in replies from the server.
+	 * Normally these should match and when both
+	 * A:B and B:A are found in ooo, they are both removed.
+	 * And if a reply with A:B causes an iversion update
+	 * of A:B, then neither are added.
+	 * When a reply has pre_change that doesn't match
+	 * iversion, then the changeid pair and any consequent
+	 * change in iversion ARE added.  Later replies
+	 * might fill in the gaps, or possibly a gap is caused
+	 * by a change from another client.
+	 * When a file or directory is opened, if the ooo table
+	 * is not empty, then we assume the gaps were due to
+	 * another client and we invalidate the cached data.
+	 *
+	 * We can only track a limited number of concurrent gaps.
+	 * Currently that limit is 16.
+	 * We allocate the table on demand.  If there is insufficient
+	 * memory, then we probably cannot cache the file anyway
+	 * so there is no loss.
+	 */
+	struct {
+		int cnt;
+		struct {
+			u64 start, end;
+		} gap[16];
+	} *ooo;
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct nfs4_cached_acl	*nfs4_acl;
         /* NFSv4 state */
@@ -617,6 +650,20 @@ nfs_fileid_to_ino_t(u64 fileid)
 	return ino;
 }
=20
+static inline void nfs_ooo_clear(struct nfs_inode *nfsi)
+{
+	nfsi->cache_validity &=3D ~NFS_INO_DATA_INVAL_DEFER;
+	kfree(nfsi->ooo);
+	nfsi->ooo =3D NULL;
+}
+
+static inline bool nfs_ooo_test(struct nfs_inode *nfsi)
+{
+	return (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER) ||
+		(nfsi->ooo && nfsi->ooo->cnt > 0);
+
+}
+
 #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
=20
 /* We need to block new opens while a file is being unlinked.
--=20
2.40.0

