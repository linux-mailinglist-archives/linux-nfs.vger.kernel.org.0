Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16747B55A1
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbjJBOvX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjJBOvV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 10:51:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7FB7
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 07:51:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED346C433C7;
        Mon,  2 Oct 2023 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696258279;
        bh=tPyXOm6nZ7FsqosSypBjv4U+82u+bOPrneDVb78W5GA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q+Os+IIEUiUYfCqTRAMzqvtStgVgnehnPfVX9cb8ZiwIYqyUsGJjyX1ab6wCd4IZt
         EYJ9OTWwuyUI9yCLKRhz8DNlBTmyqjQE2MhPf6iSYATDjnyMhPzwSHvHFeqVLdoWCz
         B6++QBLANG1kcBAw/Lf+FS9AiEElCHy5EbfzhJXQWYJXaD/qVljcrY+DOdc2S2oQA/
         lxccVSTiwcwS0hnU+ds9nNCBExKzTOmWCkRi/2VYsWzcPfwp0BTpcJKCHMdtBePwIg
         foEv/lDH9TnO1Hln3oGKfSW10WL/kOxS2obeuJ1+0vYl5Az9AGm/Ekjgc1uyygWAQT
         VknKjUvc9EL0Q==
Subject: [PATCH v1 1/4] NFSD: Add a utility function for encoding sessionid4
 objects
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 02 Oct 2023 10:51:17 -0400
Message-ID: <169625827794.1640.6920815972016494390.stgit@klimt.1015granger.net>
In-Reply-To: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
References: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

There is more than one NFSv4 operation that needs to encode a
sessionid4, so extract that data type into a separate helper.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 59ac16985775..e41e46213444 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3881,6 +3881,14 @@ nfsd4_encode_stateid4(struct xdr_stream *xdr, const stateid_t *sid)
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_encode_sessionid4(struct xdr_stream *xdr,
+			const struct nfs4_sessionid *sessionid)
+{
+	return nfsd4_encode_opaque_fixed(xdr, sessionid->data,
+					 NFS4_MAX_SESSIONID_LEN);
+}
+
 static __be32
 nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr,
 		    union nfsd4_op_u *u)
@@ -3902,17 +3910,16 @@ static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp,
 {
 	struct nfsd4_bind_conn_to_session *bcts = &u->bind_conn_to_session;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN + 8);
-	if (!p)
+	/* bctsr_sessid */
+	nfserr = nfsd4_encode_sessionid4(xdr, &bcts->sessionid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* bctsr_dir */
+	if (xdr_stream_encode_u32(xdr, bcts->dir) != XDR_UNIT)
 		return nfserr_resource;
-	p = xdr_encode_opaque_fixed(p, bcts->sessionid.data,
-					NFS4_MAX_SESSIONID_LEN);
-	*p++ = cpu_to_be32(bcts->dir);
-	/* Upshifting from TCP to RDMA is not supported */
-	*p++ = cpu_to_be32(0);
-	return 0;
+	/* bctsr_use_conn_in_rdma_mode */
+	return nfsd4_encode_bool(xdr, false);
 }
 
 static __be32


