Return-Path: <linux-nfs+bounces-339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC39805845
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16907B20C14
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442B67E8F;
	Tue,  5 Dec 2023 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMPNH0oh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B5BA
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701789017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QtFs7NsVU7SVJ5MjsiLt5FmizdYLVvWHRBit2OFQ/58=;
	b=CMPNH0oh+gU4MKyDo62t2MBSMwWDvjLCDUY6Hg5AN1inzpRSbR3sQbxzTggo9sOKrONZA9
	GrWZvK8Y9RCK0TMKlpMjzmEAvo3bsJMP0OqqQTcQ5FIZLE2Rvm3efy6OfqhMfdIXTxFCSq
	xTozymNoLXKfLu35Q/aYD6UFdFZC9YQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-gFsE1sNvMzaJUTzwLZaBtQ-1; Tue, 05 Dec 2023 10:08:49 -0500
X-MC-Unique: gFsE1sNvMzaJUTzwLZaBtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D1DE102F141;
	Tue,  5 Dec 2023 15:08:46 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5E5151E3;
	Tue,  5 Dec 2023 15:08:45 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [RESEND PATCH] NFSv4: Always ask for type with READDIR
Date: Tue,  5 Dec 2023 10:08:45 -0500
Message-ID: <badc4f7fbd63c19a9f50a7c5c17968db16bebf5f.1701788866.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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
---
 fs/nfs/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..7200d6f7cd7b 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1602,7 +1602,7 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
 static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
 {
 	uint32_t attrs[3] = {
-		FATTR4_WORD0_RDATTR_ERROR,
+		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
 	uint32_t dircount = readdir->count;
@@ -1612,7 +1612,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 	unsigned int i;
 
 	if (readdir->plus) {
-		attrs[0] |= FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
+		attrs[0] |= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
 			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
 		attrs[1] |= FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWNER|
 			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
-- 
2.43.0


