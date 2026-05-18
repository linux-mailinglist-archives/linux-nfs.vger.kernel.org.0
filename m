Return-Path: <linux-nfs+bounces-21682-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ht2M0yVC2rXJgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21682-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:40:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FABE574B02
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22C053145992
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE13B6C13;
	Mon, 18 May 2026 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/z8UxZR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E833B6366
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143515; cv=none; b=W7VCvmzgtxV551GeU8bhnYt2v/Gssop1IHG8YKo2sKZOn5jJlxq+FI3ZkkzluFgz+GJgpSK9NSs2/IfYNCyiuN8Hsq+tDUQ82Qe7DPszelcaUHgzsdntyjC32y+CtM/k6OHcuiUz5hKLg8qCLoo3NTZKxK53vDhInrjdmcERIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143515; c=relaxed/simple;
	bh=Wvhb9+slocgIYEUY/Bt/Sx39bkRuQbjzq/9onEcbDHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU92Nq0hBhfv0hyvd0OmciWjP8bq+Yo/cJ5frhf9fSHe2WmdjI5j7qK7T4fqdgKOvLSRLmLv6Y/hPL70keRLJ+6seyQtl89N7FMo2WAAzWpT2sTQy/CQPgR0yG8jfjt6NYVOQHEkR9FSNSqtGcuVWsuTwCLAK9sUNLMgRSBGK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/z8UxZR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTl/y/xoXy47yOY7S3XBgEp05w5k7fiZoqysydk4IiE=;
	b=G/z8UxZRtl9nutW27eOMtH2SLEV6OlhTy9+D3w3Vpp2L1BJ6HPd9qSJ45Hc9tr4xkjaD+u
	a2D12xh868X/9noMJlUmurGY7l1pgj7tIi2IF30/XMEsiPoGLz0sPNCEkgZi2iSU6IZEam
	yWVqKpC8vpoGfky8yT/zbWMs+8/zW58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-WqrWpMuoPimVOEHW1oA05Q-1; Mon,
 18 May 2026 18:31:49 -0400
X-MC-Unique: WqrWpMuoPimVOEHW1oA05Q-1
X-Mimecast-MFC-AGG-ID: WqrWpMuoPimVOEHW1oA05Q_1779143506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659D91956058;
	Mon, 18 May 2026 22:31:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00B2530001A2;
	Mon, 18 May 2026 22:31:39 +0000 (UTC)
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
Subject: [PATCH v2 11/21] cifs: Use a bvecq for buffering instead of a folioq
Date: Mon, 18 May 2026 23:29:43 +0100
Message-ID: <20260518222959.488126-12-dhowells@redhat.com>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21682-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,infradead.org:email,manguebit.org:email,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2FABE574B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a bvecq for internal buffering for crypto purposes instead of a folioq
so that the latter can be phased out.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |  2 +-
 fs/smb/client/smb2ops.c  | 71 +++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 82e0adc1dabd..fc4028b5b5c8 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -288,7 +288,7 @@ struct smb_rqst {
 	struct kvec	*rq_iov;	/* array of kvecs */
 	unsigned int	rq_nvec;	/* number of kvecs in array */
 	struct iov_iter	rq_iter;	/* Data iterator */
-	struct folio_queue *rq_buffer;	/* Buffer for encryption */
+	struct bvecq	*rq_buffer;	/* Buffer for encryption */
 };
 
 struct mid_q_entry;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 189bb863a9af..230102f2e411 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4542,19 +4542,18 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 }
 
 /*
- * Copy data from an iterator to the folios in a folio queue buffer.
+ * Copy data from an iterator to the pages in a bvec queue buffer.
  */
-static bool cifs_copy_iter_to_folioq(struct iov_iter *iter, size_t size,
-				     struct folio_queue *buffer)
+static bool cifs_copy_iter_to_bvecq(struct iov_iter *iter, size_t size,
+				    struct bvecq *buffer)
 {
 	for (; buffer; buffer = buffer->next) {
-		for (int s = 0; s < folioq_count(buffer); s++) {
-			struct folio *folio = folioq_folio(buffer, s);
-			size_t part = folioq_folio_size(buffer, s);
+		for (int s = 0; s < buffer->nr_slots; s++) {
+			struct bio_vec *bv = &buffer->bv[s];
+			size_t part = umin(bv->bv_len, size);
 
-			part = umin(part, size);
-
-			if (copy_folio_from_iter(folio, 0, part, iter) != part)
+			if (copy_page_from_iter(bv->bv_page, bv->bv_offset,
+						part, iter) != part)
 				return false;
 			size -= part;
 		}
@@ -4566,7 +4565,7 @@ void
 smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
 {
 	for (int i = 0; i < num_rqst; i++)
-		netfs_free_folioq_buffer(rqst[i].rq_buffer);
+		bvecq_put(rqst[i].rq_buffer);
 }
 
 /*
@@ -4593,7 +4592,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	for (int i = 1; i < num_rqst; i++) {
 		struct smb_rqst *old = &old_rq[i - 1];
 		struct smb_rqst *new = &new_rq[i];
-		struct folio_queue *buffer = NULL;
+		struct bvecq *buffer = NULL;
 		size_t size = iov_iter_count(&old->rq_iter);
 
 		orig_len += smb_rqst_len(server, old);
@@ -4601,17 +4600,16 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 		new->rq_nvec = old->rq_nvec;
 
 		if (size > 0) {
-			size_t cur_size = 0;
-			rc = netfs_alloc_folioq_buffer(NULL, &buffer, &cur_size,
-						       size, GFP_NOFS);
-			if (rc < 0)
+			rc = -ENOMEM;
+			buffer = bvecq_alloc_buffer(size, GFP_NOFS);
+			if (!buffer)
 				goto err_free;
 
 			new->rq_buffer = buffer;
-			iov_iter_folio_queue(&new->rq_iter, ITER_SOURCE,
-					     buffer, 0, 0, size);
+			iov_iter_bvec_queue(&new->rq_iter, ITER_SOURCE,
+					    buffer, 0, 0, size);
 
-			if (!cifs_copy_iter_to_folioq(&old->rq_iter, size, buffer)) {
+			if (!cifs_copy_iter_to_bvecq(&old->rq_iter, size, buffer)) {
 				rc = smb_EIO1(smb_eio_trace_tx_copy_iter_to_buf, size);
 				goto err_free;
 			}
@@ -4701,16 +4699,15 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 }
 
 static int
-cifs_copy_folioq_to_iter(struct folio_queue *folioq, size_t data_size,
-			 size_t skip, struct iov_iter *iter)
+cifs_copy_bvecq_to_iter(struct bvecq *bq, size_t data_size,
+			size_t skip, struct iov_iter *iter)
 {
-	for (; folioq; folioq = folioq->next) {
-		for (int s = 0; s < folioq_count(folioq); s++) {
-			struct folio *folio = folioq_folio(folioq, s);
-			size_t fsize = folio_size(folio);
-			size_t n, len = umin(fsize - skip, data_size);
+	for (; bq; bq = bq->next) {
+		for (int s = 0; s < bq->nr_slots; s++) {
+			struct bio_vec *bv = &bq->bv[s];
+			size_t n, len = umin(bv->bv_len - skip, data_size);
 
-			n = copy_folio_to_iter(folio, skip, len, iter);
+			n = copy_page_to_iter(bv->bv_page, bv->bv_offset + skip, len, iter);
 			if (n != len) {
 				cifs_dbg(VFS, "%s: something went wrong\n", __func__);
 				return smb_EIO2(smb_eio_trace_rx_copy_to_iter,
@@ -4726,7 +4723,7 @@ cifs_copy_folioq_to_iter(struct folio_queue *folioq, size_t data_size,
 
 static int
 handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
-		 char *buf, unsigned int buf_len, struct folio_queue *buffer,
+		 char *buf, unsigned int buf_len, struct bvecq *buffer,
 		 unsigned int buffer_len, bool is_offloaded)
 {
 	unsigned int data_offset;
@@ -4836,8 +4833,8 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		}
 
 		/* Copy the data to the output I/O iterator. */
-		rdata->result = cifs_copy_folioq_to_iter(buffer, buffer_len,
-							 cur_off, &rdata->subreq.io_iter);
+		rdata->result = cifs_copy_bvecq_to_iter(buffer, buffer_len,
+							cur_off, &rdata->subreq.io_iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4876,7 +4873,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 struct smb2_decrypt_work {
 	struct work_struct decrypt;
 	struct TCP_Server_Info *server;
-	struct folio_queue *buffer;
+	struct bvecq *buffer;
 	char *buf;
 	unsigned int len;
 };
@@ -4890,7 +4887,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	struct mid_q_entry *mid;
 	struct iov_iter iter;
 
-	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
+	iov_iter_bvec_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
 	rc = decrypt_raw_data(dw->server, dw->buf, dw->server->vals->read_rsp_size,
 			      &iter, true);
 	if (rc) {
@@ -4939,7 +4936,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 free_pages:
-	netfs_free_folioq_buffer(dw->buffer);
+	bvecq_put(dw->buffer);
 	cifs_small_buf_release(dw->buf);
 	kfree(dw);
 }
@@ -4985,12 +4982,12 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	dw->len = len;
 	len = round_up(dw->len, PAGE_SIZE);
 
-	size_t cur_size = 0;
-	rc = netfs_alloc_folioq_buffer(NULL, &dw->buffer, &cur_size, len, GFP_NOFS);
-	if (rc < 0)
+	rc = -ENOMEM;
+	dw->buffer = bvecq_alloc_buffer(len, GFP_NOFS);
+	if (!dw->buffer)
 		goto discard_data;
 
-	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
+	iov_iter_bvec_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
 
 	/* Read the data into the buffer and clear excess bufferage. */
 	rc = cifs_read_iter_from_socket(server, &iter, dw->len);
@@ -5048,7 +5045,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	}
 
 free_pages:
-	netfs_free_folioq_buffer(dw->buffer);
+	bvecq_put(dw->buffer);
 free_dw:
 	kfree(dw);
 	return rc;


