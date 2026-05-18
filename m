Return-Path: <linux-nfs+bounces-21681-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAYRKzaVC2ohJgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21681-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:39:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A3574AE6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F42308369F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B23B6340;
	Mon, 18 May 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6QXZDOY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFF399360
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143509; cv=none; b=HV0L49oC6qNJwi8vhdyHsrHFM4bu9ReYPuSVc9Kk96ErnprfWw4By2Pb0oeYtzal6tx2zYg9zwXb1BniQwuoaNlOKOClIehDs0IRgHIkNAC3Q8mVslLjyW0hgKaDEW17T2lFRKuIQlPMwRXoCt3o1TEHfSq8csHfMUVfNyXl3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143509; c=relaxed/simple;
	bh=OAW2mP3KLCJgpAVtTfu5IP/aUHBcMzIgkIeJJ9Odc+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZgn35VLxgQ4McTojAJdRaMO9kKGTBhecBEXEVnS4fSBrQQpzIhXO1x9OAw1fbF9FLQYwKPp4q1JAYZQP4E91+aQim3RoxOcJoWoULLjxGSQXxzN0utBWQZyfbFW9desAq5h80yxUfaEZsI2XrrqF+BpA5k/l236OO7FsO2Qy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6QXZDOY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCH4vZFGyxN+iuNiVjvNTp9U4LCQz31WVr7WO5SmONk=;
	b=b6QXZDOYE+1zgApgCKbWhajcJeCcmaxHiYocRVfHqgVu0XtIKj3BoexEPZ9Pitlb2zI+lY
	st/pTBXMr8bu6B6X4Mak0BYTBIYIcgrfvd1anUe11qudSq4sk3+3saOZIa44MeHO7Szu8S
	TnRoaufm2f8bNUkRJfAgIW3NheQrqvI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-M3jtuUVRMeOzoANLjCrEWQ-1; Mon,
 18 May 2026 18:31:40 -0400
X-MC-Unique: M3jtuUVRMeOzoANLjCrEWQ-1
X-Mimecast-MFC-AGG-ID: M3jtuUVRMeOzoANLjCrEWQ_1779143498
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 454D91800578;
	Mon, 18 May 2026 22:31:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFF66180034E;
	Mon, 18 May 2026 22:31:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/21] afs: Use a bvecq to hold dir content rather than folioq
Date: Mon, 18 May 2026 23:29:42 +0100
Message-ID: <20260518222959.488126-11-dhowells@redhat.com>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21681-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,infradead.org:email,auristor.com:email]
X-Rspamd-Queue-Id: 259A3574AE6
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
 fs/afs/dir.c           |  35 +++++----
 fs/afs/dir_edit.c      |  42 +++++------
 fs/afs/dir_search.c    |  33 ++++-----
 fs/afs/inode.c         |   2 +-
 fs/afs/internal.h      |   6 +-
 fs/afs/symlink.c       |  28 +++-----
 fs/netfs/write_issue.c | 156 ++++++-----------------------------------
 7 files changed, 88 insertions(+), 214 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 498b99ccdf0e..774d86bf878e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -138,9 +138,9 @@ static void afs_dir_dump(struct afs_vnode *dvnode)
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
@@ -201,9 +201,9 @@ static int afs_dir_check(struct afs_vnode *dvnode)
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
@@ -248,15 +248,14 @@ static ssize_t afs_do_read_single(struct afs_vnode *dvnode, struct file *file)
 	if (dvnode->directory_size < i_size) {
 		size_t cur_size = dvnode->directory_size;
 
-		ret = netfs_alloc_folioq_buffer(NULL,
-						&dvnode->directory, &cur_size, i_size,
-						mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
+		ret = bvecq_expand_buffer(&dvnode->directory, &cur_size, i_size,
+					  GFP_KERNEL);
 		dvnode->directory_size = cur_size;
 		if (ret < 0)
 			return ret;
 	}
 
-	iov_iter_folio_queue(&iter, ITER_DEST, dvnode->directory, 0, 0, dvnode->directory_size);
+	iov_iter_bvec_queue(&iter, ITER_DEST, dvnode->directory, 0, 0, dvnode->directory_size);
 
 	/* AFS requires us to perform the read of a directory synchronously as
 	 * a single unit to avoid issues with the directory contents being
@@ -292,8 +291,8 @@ static ssize_t afs_read_single(struct afs_vnode *dvnode, struct file *file)
 }
 
 /*
- * Read the directory into a folio_queue buffer in one go, scrubbing the
- * previous contents.  We return -ESTALE if the caller needs to call us again.
+ * Read the directory into the buffer in one go, scrubbing the previous
+ * contents.  We return -ESTALE if the caller needs to call us again.
  */
 ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	__acquires(&dvnode->validate_lock)
@@ -474,7 +473,7 @@ static size_t afs_dir_iterate_step(void *iter_base, size_t progress, size_t len,
 }
 
 /*
- * Iterate through the directory folios.
+ * Iterate through the directory content.
  */
 static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *dir_ctx)
 {
@@ -489,11 +488,11 @@ static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *dir_c
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
@@ -2218,8 +2217,8 @@ static int afs_dir_writepages(struct address_space *mapping,
 	}
 
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
-		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
-				     i_size_read(&dvnode->netfs.inode));
+		iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
+				    i_size_read(&dvnode->netfs.inode));
 		ret = netfs_writeback_single(mapping, wbc, &iter);
 		if (ret == 1)
 			ret = 0; /* Skipped write due to lock conflict. */
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index fd3aa9f97ce6..fc918b3d8f68 100644
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
+					  GFP_KERNEL);
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
index 104411c0692f..71c9a8a526f4 100644
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
index 3f48458694ba..1e7bfde6189a 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -684,7 +684,7 @@ void afs_evict_inode(struct inode *inode)
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	netfs_free_folioq_buffer(vnode->directory);
+	bvecq_put(vnode->directory);
 	if (vnode->symlink)
 		afs_evict_symlink(vnode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0b72a8566299..d2641efc756f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -709,7 +709,7 @@ struct afs_vnode {
 #define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification op */
 #define AFS_VNODE_DIR_READ	11		/* Set if we've read a dir's contents */
 
-	struct folio_queue	*directory;	/* Directory contents */
+	struct bvecq		*directory;	/* Directory contents */
 	struct afs_symlink __rcu *symlink;	/* Symlink content */
 	struct list_head	wb_keys;	/* List of keys available for writeback */
 	struct list_head	pending_locks;	/* locks waiting to be granted */
@@ -992,9 +992,9 @@ static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int fl
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
diff --git a/fs/afs/symlink.c b/fs/afs/symlink.c
index ed5868369f37..6709b119e8a0 100644
--- a/fs/afs/symlink.c
+++ b/fs/afs/symlink.c
@@ -56,7 +56,6 @@ void afs_evict_symlink(struct afs_vnode *vnode)
 void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op)
 {
 	struct afs_symlink *symlink = op->create.symlink;
-	size_t dsize = 0;
 	size_t size = strlen(symlink->content) + 1;
 	char *p;
 
@@ -66,12 +65,12 @@ void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op)
 	if (!fscache_cookie_enabled(netfs_i_cookie(&vnode->netfs)))
 		return;
 
-	if (netfs_alloc_folioq_buffer(NULL, &vnode->directory, &dsize, size,
-				      mapping_gfp_mask(vnode->netfs.inode.i_mapping)) < 0)
+	vnode->directory = bvecq_alloc_buffer(PAGE_SIZE, GFP_KERNEL);
+	if (!vnode->directory)
 		return;
 
-	vnode->directory_size = dsize;
-	p = kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
+	vnode->directory_size = size;
+	p = kmap_local_bvec(&vnode->directory->bv[0], 0);
 	memcpy(p, symlink->content, size);
 	kunmap_local(p);
 	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
@@ -94,17 +93,12 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *vnode)
 	}
 
 	if (!vnode->directory) {
-		size_t cur_size = 0;
-
-		ret = netfs_alloc_folioq_buffer(NULL,
-						&vnode->directory, &cur_size, PAGE_SIZE,
-						mapping_gfp_mask(vnode->netfs.inode.i_mapping));
-		vnode->directory_size = PAGE_SIZE - 1;
+		vnode->directory = bvecq_alloc_buffer(PAGE_SIZE, GFP_KERNEL);
 		if (ret < 0)
 			return ret;
 	}
 
-	iov_iter_folio_queue(&iter, ITER_DEST, vnode->directory, 0, 0, PAGE_SIZE);
+	iov_iter_bvec_queue(&iter, ITER_DEST, vnode->directory, 0, 0, PAGE_SIZE);
 
 	/* AFS requires us to perform the read of a symlink as a single unit to
 	 * avoid issues with the content being changed between reads.
@@ -127,7 +121,7 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *vnode)
 		refcount_set(&symlink->ref, 1);
 		symlink->content[i_size] = 0;
 
-		const char *s = kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
+		const char *s = kmap_local_bvec(&vnode->directory->bv[0], 0);
 
 		memcpy(symlink->content, s, i_size);
 		kunmap_local(s);
@@ -136,7 +130,7 @@ static ssize_t afs_do_read_symlink(struct afs_vnode *vnode)
 	}
 
 	if (!fscache_cookie_enabled(netfs_i_cookie(&vnode->netfs))) {
-		netfs_free_folioq_buffer(vnode->directory);
+		bvecq_put(vnode->directory);
 		vnode->directory = NULL;
 		vnode->directory_size = 0;
 	}
@@ -249,14 +243,14 @@ int afs_symlink_writepages(struct address_space *mapping,
 
 	if (vnode->directory &&
 	    atomic64_read(&vnode->cb_expires_at) != AFS_NO_CB_PROMISE) {
-		iov_iter_folio_queue(&iter, ITER_SOURCE, vnode->directory, 0, 0,
-				     i_size_read(&vnode->netfs.inode));
+		iov_iter_bvec_queue(&iter, ITER_SOURCE, vnode->directory, 0, 0,
+				    i_size_read(&vnode->netfs.inode));
 		ret = netfs_writeback_single(mapping, wbc, &iter);
 	}
 
 	if (ret == 0) {
 		mutex_lock(&vnode->netfs.wb_lock);
-		netfs_free_folioq_buffer(vnode->directory);
+		bvecq_put(vnode->directory);
 		vnode->directory = NULL;
 		vnode->directory_size = 0;
 		mutex_unlock(&vnode->netfs.wb_lock);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 7f38b6676002..b2f626568fe5 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -727,124 +727,11 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
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
@@ -858,13 +745,8 @@ int netfs_writeback_single(struct address_space *mapping,
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
 			/* The VFS will have undirtied the inode. */
@@ -882,6 +764,9 @@ int netfs_writeback_single(struct address_space *mapping,
 		goto couldnt_start;
 	}
 
+	wreq->buffer.iter = *iter;
+	wreq->len = iov_iter_count(iter);
+
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
 	netfs_stat(&netfs_n_wh_writepages);
@@ -889,31 +774,34 @@ int netfs_writeback_single(struct address_space *mapping,
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


