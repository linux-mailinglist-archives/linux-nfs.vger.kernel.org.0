Return-Path: <linux-nfs+bounces-20413-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SISmCjYUxWnr6QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20413-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:10:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D6E3341EC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D2D31A0212
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6DB3E638A;
	Thu, 26 Mar 2026 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyHHeATR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0F3E5EC1
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522112; cv=none; b=td1oPSZOBRz++ZIjp83KN7T9tOxAgjkinCQwNrFSKaACsSyvP5LWp5GQhl2T0xkfESgwh6aiqvLuQFzNyThOfkWUioxkjOb93E05ulTU+8WyFX6kB+cAAhh1pR2nWD8Rvj9J+8uqY89PrVlp0RRGiWixt0AVxrkOI0BgATF5HOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522112; c=relaxed/simple;
	bh=5QJhZ/6Fp0Lhe/y9iPccdIFdjXMOmEQBt0aJl8EquS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojs/ej6pNUsv+JXDqrLDRuXpKcW6rHWIMTBVAVZnRFO7MOPu3dUbjju1bqRFGBRdv900rdiqyXnfqSV8c0mgmHvRiSj9EvF9NJ85p/11lVFlbJrUhnJ6IHy+pEItBx6k/qyB6T2ie/JuOBZsax/WK4s1G+pe6v45d1OdEsZFr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyHHeATR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Is9VHSESh2LYKPQp2EQ9HQmWLZBLQlOGumcQU3ROqrk=;
	b=dyHHeATR6efFnwMNO6PfUQ1urPGLWNT5LGp75qwu3xCdE7wDnPVkXhZP7pYQ/RLtWcRPD3
	mRpFjKl+krshc6G6ADUtSLXPYgGkKXKgmWdWSw104kqWbiyB9IxUTZLX76HEqqsx84WjRe
	kD9SQVqMob6ZV1fGpnZ/DSJ+iObRsLM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-FUHGgS5pPEqdKsGUd4H_9w-1; Thu,
 26 Mar 2026 06:48:19 -0400
X-MC-Unique: FUHGgS5pPEqdKsGUd4H_9w-1
X-Mimecast-MFC-AGG-ID: FUHGgS5pPEqdKsGUd4H_9w_1774522097
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2F7F19560B8;
	Thu, 26 Mar 2026 10:48:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CBA81800671;
	Thu, 26 Mar 2026 10:48:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 15/26] afs: Use a bvecq to hold dir content rather than folioq
Date: Thu, 26 Mar 2026 10:45:30 +0000
Message-ID: <20260326104544.509518-16-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20413-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,manguebit.org:email,auristor.com:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70D6E3341EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a bvecq to hold the contents of a directory rather than the folioq so
that the latter can be phased out.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir.c           |  39 +++++------
 fs/afs/dir_edit.c      |  42 +++++------
 fs/afs/dir_search.c    |  33 ++++-----
 fs/afs/inode.c         |  20 +++---
 fs/afs/internal.h      |   6 +-
 fs/netfs/write_issue.c | 156 ++++++-----------------------------------
 6 files changed, 88 insertions(+), 208 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78caef3f1338..6627a0d38e73 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -136,9 +136,9 @@ static void afs_dir_dump(struct afs_vnode *dvnode)
 	pr_warn("DIR %llx:%llx is=%llx\n",
 		dvnode->fid.vid, dvnode->fid.vnode, i_size);
 
-	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
-	iterate_folioq(&iter, iov_iter_count(&iter), NULL, NULL,
-		       afs_dir_dump_step);
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
+	iterate_bvecq(&iter, iov_iter_count(&iter), NULL, NULL,
+		      afs_dir_dump_step);
 }
 
 /*
@@ -199,9 +199,9 @@ static int afs_dir_check(struct afs_vnode *dvnode)
 	if (unlikely(!i_size))
 		return 0;
 
-	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
-	checked = iterate_folioq(&iter, iov_iter_count(&iter), dvnode, NULL,
-				 afs_dir_check_step);
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
+	checked = iterate_bvecq(&iter, iov_iter_count(&iter), dvnode, NULL,
+				afs_dir_check_step);
 	if (checked != i_size) {
 		afs_dir_dump(dvnode);
 		return -EIO;
@@ -255,15 +255,14 @@ static ssize_t afs_do_read_single(struct afs_vnode *dvnode, struct file *file)
 	if (dvnode->directory_size < i_size) {
 		size_t cur_size = dvnode->directory_size;
 
-		ret = netfs_alloc_folioq_buffer(NULL,
-						&dvnode->directory, &cur_size, i_size,
-						mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
+		ret = bvecq_expand_buffer(&dvnode->directory, &cur_size, i_size,
+					  mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
 		dvnode->directory_size = cur_size;
 		if (ret < 0)
 			return ret;
 	}
 
-	iov_iter_folio_queue(&iter, ITER_DEST, dvnode->directory, 0, 0, dvnode->directory_size);
+	iov_iter_bvec_queue(&iter, ITER_DEST, dvnode->directory, 0, 0, dvnode->directory_size);
 
 	/* AFS requires us to perform the read of a directory synchronously as
 	 * a single unit to avoid issues with the directory contents being
@@ -282,9 +281,9 @@ static ssize_t afs_do_read_single(struct afs_vnode *dvnode, struct file *file)
 
 			if (ret2 < 0)
 				ret = ret2;
-		} else if (i_size < folioq_folio_size(dvnode->directory, 0)) {
+		} else if (i_size < PAGE_SIZE) {
 			/* NUL-terminate a symlink. */
-			char *symlink = kmap_local_folio(folioq_folio(dvnode->directory, 0), 0);
+			char *symlink = kmap_local_bvec(&dvnode->directory->bv[0], 0);
 
 			symlink[i_size] = 0;
 			kunmap_local(symlink);
@@ -305,8 +304,8 @@ ssize_t afs_read_single(struct afs_vnode *dvnode, struct file *file)
 }
 
 /*
- * Read the directory into a folio_queue buffer in one go, scrubbing the
- * previous contents.  We return -ESTALE if the caller needs to call us again.
+ * Read the directory into the buffer in one go, scrubbing the previous
+ * contents.  We return -ESTALE if the caller needs to call us again.
  */
 ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	__acquires(&dvnode->validate_lock)
@@ -487,7 +486,7 @@ static size_t afs_dir_iterate_step(void *iter_base, size_t progress, size_t len,
 }
 
 /*
- * Iterate through the directory folios.
+ * Iterate through the directory content.
  */
 static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *dir_ctx)
 {
@@ -502,11 +501,11 @@ static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *dir_c
 	if (i_size <= 0 || dir_ctx->pos >= i_size)
 		return 0;
 
-	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
 	iov_iter_advance(&iter, round_down(dir_ctx->pos, AFS_DIR_BLOCK_SIZE));
 
-	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, &ctx,
-		       afs_dir_iterate_step);
+	iterate_bvecq(&iter, iov_iter_count(&iter), dvnode, &ctx,
+		      afs_dir_iterate_step);
 
 	if (ctx.error == -ESTALE)
 		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
@@ -2211,8 +2210,8 @@ int afs_single_writepages(struct address_space *mapping,
 	if (is_dir ?
 	    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) :
 	    atomic64_read(&dvnode->cb_expires_at) != AFS_NO_CB_PROMISE) {
-		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
-				     i_size_read(&dvnode->netfs.inode));
+		iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
+				    i_size_read(&dvnode->netfs.inode));
 		ret = netfs_writeback_single(mapping, wbc, &iter);
 	}
 
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index fd3aa9f97ce6..59d3decf7692 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -110,9 +110,8 @@ static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
  */
 static union afs_xdr_dir_block *afs_dir_get_block(struct afs_dir_iter *iter, size_t block)
 {
-	struct folio_queue *fq;
 	struct afs_vnode *dvnode = iter->dvnode;
-	struct folio *folio;
+	struct bvecq *bq;
 	size_t blpos = block * AFS_DIR_BLOCK_SIZE;
 	size_t blend = (block + 1) * AFS_DIR_BLOCK_SIZE, fpos = iter->fpos;
 	int ret;
@@ -120,41 +119,38 @@ static union afs_xdr_dir_block *afs_dir_get_block(struct afs_dir_iter *iter, siz
 	if (dvnode->directory_size < blend) {
 		size_t cur_size = dvnode->directory_size;
 
-		ret = netfs_alloc_folioq_buffer(
-			NULL, &dvnode->directory, &cur_size, blend,
-			mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
+		ret = bvecq_expand_buffer(&dvnode->directory, &cur_size, blend,
+					  mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
 		dvnode->directory_size = cur_size;
 		if (ret < 0)
 			goto fail;
 	}
 
-	fq = iter->fq;
-	if (!fq)
-		fq = dvnode->directory;
+	bq = iter->bq;
+	if (!bq)
+		bq = dvnode->directory;
 
-	/* Search the folio queue for the folio containing the block... */
-	for (; fq; fq = fq->next) {
-		for (int s = iter->fq_slot; s < folioq_count(fq); s++) {
-			size_t fsize = folioq_folio_size(fq, s);
+	/* Search the contents for the region containing the block... */
+	for (; bq; bq = bq->next) {
+		for (int s = iter->bq_slot; s < bq->nr_slots; s++) {
+			struct bio_vec *bv = &bq->bv[s];
+			size_t bsize = bv->bv_len;
 
-			if (blend <= fpos + fsize) {
+			if (blend <= fpos + bsize) {
 				/* ... and then return the mapped block. */
-				folio = folioq_folio(fq, s);
-				if (WARN_ON_ONCE(folio_pos(folio) != fpos))
-					goto fail;
-				iter->fq = fq;
-				iter->fq_slot = s;
+				iter->bq = bq;
+				iter->bq_slot = s;
 				iter->fpos = fpos;
-				return kmap_local_folio(folio, blpos - fpos);
+				return kmap_local_bvec(bv, blpos - fpos);
 			}
-			fpos += fsize;
+			fpos += bsize;
 		}
-		iter->fq_slot = 0;
+		iter->bq_slot = 0;
 	}
 
 fail:
-	iter->fq = NULL;
-	iter->fq_slot = 0;
+	iter->bq = NULL;
+	iter->bq_slot = 0;
 	afs_invalidate_dir(dvnode, afs_dir_invalid_edit_get_block);
 	return NULL;
 }
diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index d2516e55b5ed..f1d2b49bc6f0 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -66,12 +66,11 @@ bool afs_dir_init_iter(struct afs_dir_iter *iter, const struct qstr *name)
  */
 union afs_xdr_dir_block *afs_dir_find_block(struct afs_dir_iter *iter, size_t block)
 {
-	struct folio_queue *fq = iter->fq;
 	struct afs_vnode *dvnode = iter->dvnode;
-	struct folio *folio;
+	struct bvecq *bq = iter->bq;
 	size_t blpos = block * AFS_DIR_BLOCK_SIZE;
 	size_t blend = (block + 1) * AFS_DIR_BLOCK_SIZE, fpos = iter->fpos;
-	int slot = iter->fq_slot;
+	int slot = iter->bq_slot;
 
 	_enter("%zx,%d", block, slot);
 
@@ -83,36 +82,34 @@ union afs_xdr_dir_block *afs_dir_find_block(struct afs_dir_iter *iter, size_t bl
 	if (dvnode->directory_size < blend)
 		goto fail;
 
-	if (!fq || blpos < fpos) {
-		fq = dvnode->directory;
+	if (!bq || blpos < fpos) {
+		bq = dvnode->directory;
 		slot = 0;
 		fpos = 0;
 	}
 
 	/* Search the folio queue for the folio containing the block... */
-	for (; fq; fq = fq->next) {
-		for (; slot < folioq_count(fq); slot++) {
-			size_t fsize = folioq_folio_size(fq, slot);
+	for (; bq; bq = bq->next) {
+		for (; slot < bq->nr_slots; slot++) {
+			struct bio_vec *bv = &bq->bv[slot];
+			size_t bsize = bv->bv_len;
 
-			if (blend <= fpos + fsize) {
+			if (blend <= fpos + bsize) {
 				/* ... and then return the mapped block. */
-				folio = folioq_folio(fq, slot);
-				if (WARN_ON_ONCE(folio_pos(folio) != fpos))
-					goto fail;
-				iter->fq = fq;
-				iter->fq_slot = slot;
+				iter->bq = bq;
+				iter->bq_slot = slot;
 				iter->fpos = fpos;
-				iter->block = kmap_local_folio(folio, blpos - fpos);
+				iter->block = kmap_local_bvec(bv, blpos - fpos);
 				return iter->block;
 			}
-			fpos += fsize;
+			fpos += bsize;
 		}
 		slot = 0;
 	}
 
 fail:
-	iter->fq = NULL;
-	iter->fq_slot = 0;
+	iter->bq = NULL;
+	iter->bq_slot = 0;
 	afs_invalidate_dir(dvnode, afs_dir_invalid_edit_get_block);
 	return NULL;
 }
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index dde1857fcabb..94e3442da849 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -31,12 +31,12 @@ void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op)
 	size_t dsize = 0;
 	char *p;
 
-	if (netfs_alloc_folioq_buffer(NULL, &vnode->directory, &dsize, size,
-				      mapping_gfp_mask(vnode->netfs.inode.i_mapping)) < 0)
+	if (bvecq_expand_buffer(&vnode->directory, &dsize, size,
+				mapping_gfp_mask(vnode->netfs.inode.i_mapping)) < 0)
 		return;
 
 	vnode->directory_size = dsize;
-	p = kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
+	p = kmap_local_bvec(&vnode->directory->bv[0], 0);
 	memcpy(p, op->create.symlink, size);
 	kunmap_local(p);
 	set_bit(AFS_VNODE_DIR_READ, &vnode->flags);
@@ -45,17 +45,17 @@ void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op)
 
 static void afs_put_link(void *arg)
 {
-	struct folio *folio = virt_to_folio(arg);
+	struct page *page = virt_to_page(arg);
 
 	kunmap_local(arg);
-	folio_put(folio);
+	put_page(page);
 }
 
 const char *afs_get_link(struct dentry *dentry, struct inode *inode,
 			 struct delayed_call *callback)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
-	struct folio *folio;
+	struct page *page;
 	char *content;
 	ssize_t ret;
 
@@ -84,9 +84,9 @@ const char *afs_get_link(struct dentry *dentry, struct inode *inode,
 	set_bit(AFS_VNODE_DIR_READ, &vnode->flags);
 
 good:
-	folio = folioq_folio(vnode->directory, 0);
-	folio_get(folio);
-	content = kmap_local_folio(folio, 0);
+	page = vnode->directory->bv[0].bv_page;
+	get_page(page);
+	content = kmap_local_page(page);
 	set_delayed_call(callback, afs_put_link, content);
 	return content;
 }
@@ -761,7 +761,7 @@ void afs_evict_inode(struct inode *inode)
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	netfs_free_folioq_buffer(vnode->directory);
+	bvecq_put(vnode->directory);
 
 	afs_set_cache_aux(vnode, &aux);
 	netfs_clear_inode_writeback(inode, &aux);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 009064b8d661..9bf5d2f1dbc4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -710,7 +710,7 @@ struct afs_vnode {
 #define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification op */
 #define AFS_VNODE_DIR_READ	11		/* Set if we've read a dir's contents */
 
-	struct folio_queue	*directory;	/* Directory contents */
+	struct bvecq		*directory;	/* Directory contents */
 	struct list_head	wb_keys;	/* List of keys available for writeback */
 	struct list_head	pending_locks;	/* locks waiting to be granted */
 	struct list_head	granted_locks;	/* locks granted on this file */
@@ -983,9 +983,9 @@ static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int fl
 struct afs_dir_iter {
 	struct afs_vnode	*dvnode;
 	union afs_xdr_dir_block *block;
-	struct folio_queue	*fq;
+	struct bvecq		*bq;
 	unsigned int		fpos;
-	int			fq_slot;
+	int			bq_slot;
 	unsigned int		loop_check;
 	u8			nr_slots;
 	u8			bucket;
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2de6b8621e11..9ca2c780f469 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -700,124 +700,11 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
 	return ret;
 }
 
-/*
- * Write some of a pending folio data back to the server and/or the cache.
- */
-static int netfs_write_folio_single(struct netfs_io_request *wreq,
-				    struct folio *folio)
-{
-	struct netfs_io_stream *upload = &wreq->io_streams[0];
-	struct netfs_io_stream *cache  = &wreq->io_streams[1];
-	struct netfs_io_stream *stream;
-	size_t iter_off = 0;
-	size_t fsize = folio_size(folio), flen;
-	loff_t fpos = folio_pos(folio);
-	bool to_eof = false;
-	bool no_debug = false;
-
-	_enter("");
-
-	flen = folio_size(folio);
-	if (flen > wreq->i_size - fpos) {
-		flen = wreq->i_size - fpos;
-		folio_zero_segment(folio, flen, fsize);
-		to_eof = true;
-	} else if (flen == wreq->i_size - fpos) {
-		to_eof = true;
-	}
-
-	_debug("folio %zx/%zx", flen, fsize);
-
-	if (!upload->avail && !cache->avail) {
-		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
-		return 0;
-	}
-
-	if (!upload->construct)
-		trace_netfs_folio(folio, netfs_folio_trace_store);
-	else
-		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
-
-	/* Attach the folio to the rolling buffer. */
-	folio_get(folio);
-	rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK);
-
-	/* Move the submission point forward to allow for write-streaming data
-	 * not starting at the front of the page.  We don't do write-streaming
-	 * with the cache as the cache requires DIO alignment.
-	 *
-	 * Also skip uploading for data that's been read and just needs copying
-	 * to the cache.
-	 */
-	for (int s = 0; s < NR_IO_STREAMS; s++) {
-		stream = &wreq->io_streams[s];
-		stream->submit_off = 0;
-		stream->submit_len = flen;
-		if (!stream->avail) {
-			stream->submit_off = UINT_MAX;
-			stream->submit_len = 0;
-		}
-	}
-
-	/* Attach the folio to one or more subrequests.  For a big folio, we
-	 * could end up with thousands of subrequests if the wsize is small -
-	 * but we might need to wait during the creation of subrequests for
-	 * network resources (eg. SMB credits).
-	 */
-	for (;;) {
-		ssize_t part;
-		size_t lowest_off = ULONG_MAX;
-		int choose_s = -1;
-
-		/* Always add to the lowest-submitted stream first. */
-		for (int s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->submit_len > 0 &&
-			    stream->submit_off < lowest_off) {
-				lowest_off = stream->submit_off;
-				choose_s = s;
-			}
-		}
-
-		if (choose_s < 0)
-			break;
-		stream = &wreq->io_streams[choose_s];
-
-		/* Advance the iterator(s). */
-		if (stream->submit_off > iter_off) {
-			rolling_buffer_advance(&wreq->buffer, stream->submit_off - iter_off);
-			iter_off = stream->submit_off;
-		}
-
-		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
-		stream->submit_extendable_to = fsize - stream->submit_off;
-		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
-					   stream->submit_len, to_eof);
-		stream->submit_off += part;
-		if (part > stream->submit_len)
-			stream->submit_len = 0;
-		else
-			stream->submit_len -= part;
-		if (part > 0)
-			no_debug = true;
-	}
-
-	wreq->buffer.iter.iov_offset = 0;
-	if (fsize > iter_off)
-		rolling_buffer_advance(&wreq->buffer, fsize - iter_off);
-	atomic64_set(&wreq->issued_to, fpos + fsize);
-
-	if (!no_debug)
-		kdebug("R=%x: No submit", wreq->debug_id);
-	_leave(" = 0");
-	return 0;
-}
-
 /**
  * netfs_writeback_single - Write back a monolithic payload
  * @mapping: The mapping to write from
  * @wbc: Hints from the VM
- * @iter: Data to write, must be ITER_FOLIOQ.
+ * @iter: Data to write.
  *
  * Write a monolithic, non-pagecache object back to the server and/or
  * the cache.
@@ -828,13 +715,8 @@ int netfs_writeback_single(struct address_space *mapping,
 {
 	struct netfs_io_request *wreq;
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
-	struct folio_queue *fq;
-	size_t size = iov_iter_count(iter);
 	int ret;
 
-	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
-		return -EIO;
-
 	if (!mutex_trylock(&ictx->wb_lock)) {
 		if (wbc->sync_mode == WB_SYNC_NONE) {
 			netfs_stat(&netfs_n_wb_lock_skip);
@@ -850,6 +732,9 @@ int netfs_writeback_single(struct address_space *mapping,
 		goto couldnt_start;
 	}
 
+	wreq->buffer.iter = *iter;
+	wreq->len = iov_iter_count(iter);
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
 	netfs_stat(&netfs_n_wh_writepages);
@@ -857,31 +742,34 @@ int netfs_writeback_single(struct address_space *mapping,
 	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
 		wreq->netfs_ops->begin_writeback(wreq);
 
-	for (fq = (struct folio_queue *)iter->folioq; fq; fq = fq->next) {
-		for (int slot = 0; slot < folioq_count(fq); slot++) {
-			struct folio *folio = folioq_folio(fq, slot);
-			size_t part = umin(folioq_folio_size(fq, slot), size);
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_subrequest *subreq;
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
+
+		if (!stream->avail)
+			continue;
 
-			_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
+		netfs_prepare_write(wreq, stream, 0);
 
-			ret = netfs_write_folio_single(wreq, folio);
-			if (ret < 0)
-				goto stop;
-			size -= part;
-			if (size <= 0)
-				goto stop;
-		}
+		subreq = stream->construct;
+		subreq->len = wreq->len;
+		stream->submit_len = subreq->len;
+		stream->submit_extendable_to = round_up(wreq->len, PAGE_SIZE);
+
+		netfs_issue_write(wreq, stream);
 	}
 
-stop:
-	for (int s = 0; s < NR_IO_STREAMS; s++)
-		netfs_issue_write(wreq, &wreq->io_streams[s]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
 
 	mutex_unlock(&ictx->wb_lock);
 	netfs_wake_collector(wreq);
 
+	/* TODO: Might want to be async here if WB_SYNC_NONE, but then need to
+	 * wait before modifying.
+	 */
+	ret = netfs_wait_for_write(wreq);
+
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	_leave(" = %d", ret);
 	return ret;


