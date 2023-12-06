Return-Path: <linux-nfs+bounces-358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E825F807094
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 14:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F876281C4B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92C3716D;
	Wed,  6 Dec 2023 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADN7A9di"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3021A5
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 05:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701868227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WLuYPO7/SYyjB60zU4sK9lHjmGO43aoXlJcxfyMjQPs=;
	b=ADN7A9diPSvN40h9XWh5gbpVyfFhjacFj5AN5wenMyJpPBQuMX5QG4lUXP/iSQZsyY6XWd
	qZ16/J+leN4fcCmuH9yiH9lfvhnGEyIAYr02SqkkZZAb+2QTHSfPDu+mQ2djSZ1J2KcPOQ
	knLSOrrpAAs+BO0IxuSXGntMHGZts9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-QSVCtH0ZPf6U9pLVIE7-hA-1; Wed, 06 Dec 2023 08:10:23 -0500
X-MC-Unique: QSVCtH0ZPf6U9pLVIE7-hA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39F6F80BEC5;
	Wed,  6 Dec 2023 13:10:23 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B94D82166B35;
	Wed,  6 Dec 2023 13:10:22 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2] NFSv4: Always ask for type with READDIR
Date: Wed,  6 Dec 2023 08:10:22 -0500
Message-ID: <fe9ca28dfe9511afc946c88426c4a91b2aad42d8.1701868021.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Again we have claimed regressions for walking a directory tree, this time
with the "find" utility which always tries to optimize away asking for any
attributes until it has a complete list of entries.  This behavior makes
the readdir plus heuristic do the wrong thing, which causes a storm of
GETATTRs to determine each entry's type in order to continue the walk.

For v4 add the type attribute to each READDIR request to include it no
matter the heuristic.  This allows a simple `find` command to proceed
quickly through a directory tree.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/nfs4xdr.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..69406e60f391 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1602,7 +1602,8 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
 static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
 {
 	uint32_t attrs[3] = {
-		FATTR4_WORD0_RDATTR_ERROR,
+		FATTR4_WORD0_TYPE
+		| FATTR4_WORD0_RDATTR_ERROR,
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
 	uint32_t dircount = readdir->count;
@@ -1612,12 +1613,20 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 	unsigned int i;
 
 	if (readdir->plus) {
-		attrs[0] |= FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
-			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
-		attrs[1] |= FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWNER|
-			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
-			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
-			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
+		attrs[0] |= FATTR4_WORD0_CHANGE
+			| FATTR4_WORD0_SIZE
+			| FATTR4_WORD0_FSID
+			| FATTR4_WORD0_FILEHANDLE
+			| FATTR4_WORD0_FILEID;
+		attrs[1] |= FATTR4_WORD1_MODE
+			| FATTR4_WORD1_NUMLINKS
+			| FATTR4_WORD1_OWNER
+			| FATTR4_WORD1_OWNER_GROUP
+			| FATTR4_WORD1_RAWDEV
+			| FATTR4_WORD1_SPACE_USED
+			| FATTR4_WORD1_TIME_ACCESS
+			| FATTR4_WORD1_TIME_METADATA
+			| FATTR4_WORD1_TIME_MODIFY;
 		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 	/* Use mounted_on_fileid only if the server supports it */
-- 
2.43.0


