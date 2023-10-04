Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4667B8132
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjJDNmK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjJDNmJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57488C4
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 06:42:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF589C433C7;
        Wed,  4 Oct 2023 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426925;
        bh=jGIIFqsFyWBFrl7eSU/+kAyOvRi7vHJXfbgImCUAHsE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hfMdm+p0dOoL+AZwOClHPzZ+2LJzSF9+ukzgddmnVaH51l2m3X5vuL1ZFEcXkta5q
         +BPd0+WeMQZ0lg6DHBwnJd+1ozzkicaqGqFMNmfSf1QyqEUbabny+A+dR5bE6PrKTl
         AnLYHqoXpuwQbdROsaMk/IeDi90lxi/XfVNHyqgiRD3fmqpUEoEpf4sjGFqg5fDBZd
         JrZhYXLqS8EF5GNjvIexOKsvM7RlwHhuc7NWILu6fSw3QN/4itKNjaaPdmu/DzgOkc
         yb9hM3VyCK4RTZvikHiLkA1Q8nwhsQn4XAU8zIwlA8OGQ/+0uqz6qruMljpgKICFao
         7O5KUda0se+0Q==
Subject: [PATCH v1 4/5] NFSD: Clean up nfsd4_encode_entry4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 09:42:03 -0400
Message-ID: <169642692381.7503.16200002695655143315.stgit@klimt.1015granger.net>
In-Reply-To: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
References: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Reshape nfsd4_encode_entry4() to be more like the legacy dirent
encoders, which were recently rewritten to use xdr_stream.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   15 ++++++---------
 fs/nfsd/xdr4.h    |    3 +++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3eba3f316d97..cfc8e241e8fb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3768,7 +3768,6 @@ nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 	u32 name_and_cookie;
 	int entry_bytes;
 	__be32 nfserr = nfserr_toosmall;
-	__be32 *p;
 
 	/* In nfsv4, "." and ".." never make it onto the wire.. */
 	if (name && isdotent(name, namlen)) {
@@ -3779,17 +3778,15 @@ nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 	/* Encode the previous entry's cookie value */
 	nfsd4_encode_entry4_nfs_cookie4(cd, offset);
 
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
+	if (xdr_stream_encode_item_present(xdr) != XDR_UNIT)
 		goto fail;
-	*p++ = xdr_one;                             /* mark entry present */
+
+	/* Reserve send buffer space for this entry's cookie value. */
 	cookie_offset = xdr->buf->len;
-	p = xdr_reserve_space(xdr, 3*4 + namlen);
-	if (!p)
+	if (nfsd4_encode_nfs_cookie4(xdr, OFFSET_MAX) != nfs_ok)
+		goto fail;
+	if (nfsd4_encode_component4(xdr, name, namlen) != nfs_ok)
 		goto fail;
-	p = xdr_encode_hyper(p, OFFSET_MAX);        /* offset of next entry */
-	p = xdr_encode_array(p, name, namlen);      /* name length & name */
-
 	nfserr = nfsd4_encode_entry4_fattr(cd, name, namlen);
 	switch (nfserr) {
 	case nfs_ok:
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index cd124969589e..6f5c3f4b4ca3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -120,6 +120,7 @@ nfsd4_encode_uint64_t(struct xdr_stream *xdr, u64 val)
 }
 
 #define nfsd4_encode_changeid4(x, v)	nfsd4_encode_uint64_t(x, v)
+#define nfsd4_encode_nfs_cookie4(x, v)	nfsd4_encode_uint64_t(x, v)
 #define nfsd4_encode_length4(x, v)	nfsd4_encode_uint64_t(x, v)
 #define nfsd4_encode_offset4(x, v)	nfsd4_encode_uint64_t(x, v)
 
@@ -174,6 +175,8 @@ nfsd4_encode_opaque(struct xdr_stream *xdr, const void *data, size_t size)
 	return nfs_ok;
 }
 
+#define nfsd4_encode_component4(x, d, s)	nfsd4_encode_opaque(x, d, s)
+
 struct nfsd4_compound_state {
 	struct svc_fh		current_fh;
 	struct svc_fh		save_fh;


