Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4527B3415
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjI2N7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2N7W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:59:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE8DB
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:59:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7BAC433C8;
        Fri, 29 Sep 2023 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995959;
        bh=fEBBG4q4GozGuS1hCXvCLt/QF3UHt39MO0o77fthVGg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A6fHInVWrRmAkBGc7ULOiMSLBB/ebcBUeUfdWBfPywekh+7b6vGihQogHa26WoOJJ
         Se7rTC/2+7m0vAcwf0369r2lnclMCvL7wWG2VNBWainwdIcNUHfiu0kG7nCWBI/Kq+
         fCcocZ9/S3NF1SR4eXSaZGVdf9sw7UmSYvu8LkUUVwGPQz5o/9QqiQXwTHR+z5PxuV
         vb+zPozxT3nkgFak8o4LXiTebTKpW6mrqEOqe37kvL51/LKPy+OIYY1mMPkzMPHXw6
         eYT5LwIJoHeXhfRpV1mjKSeDM6nMFPiPKQBVOGRcNlogXagpsnD3sUk/wY+iqefxu8
         HszY897u0AxGQ==
Subject: [PATCH v1 5/7] NFSD: Add nfsd4_encode_open_none_delegation4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:59:18 -0400
Message-ID: <169599595863.5622.6210947146670583905.stgit@manet.1015granger.net>
In-Reply-To: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
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

To better align our implementation with the XDR specification,
refactor the part of nfsd4_encode_open() that encodes the
open_none_delegation4 type.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f7e5f54fda00..b6c5ccb9351f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4149,6 +4149,27 @@ nfsd4_encode_open_write_delegation4(struct xdr_stream *xdr,
 	return nfsd4_encode_open_nfsace4(xdr);
 }
 
+static __be32
+nfsd4_encode_open_none_delegation4(struct xdr_stream *xdr,
+				   struct nfsd4_open *open)
+{
+	__be32 status = nfs_ok;
+
+	/* ond_why */
+	if (xdr_stream_encode_u32(xdr, open->op_why_no_deleg) != XDR_UNIT)
+		return nfserr_resource;
+	switch (open->op_why_no_deleg) {
+	case WND4_CONTENTION:
+		/* ond_server_will_push_deleg */
+		status = nfsd4_encode_bool(xdr, false);
+		break;
+	case WND4_RESOURCE:
+		/* ond_server_will_signal_avail */
+		status = nfsd4_encode_bool(xdr, false);
+	}
+	return status;
+}
+
 static __be32
 nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  union nfsd4_op_u *u)
@@ -4185,24 +4206,9 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	case NFS4_OPEN_DELEGATE_WRITE:
 		/* write */
 		return nfsd4_encode_open_write_delegation4(xdr, open);
-	case NFS4_OPEN_DELEGATE_NONE_EXT: /* 4.1 */
-		switch (open->op_why_no_deleg) {
-		case WND4_CONTENTION:
-		case WND4_RESOURCE:
-			p = xdr_reserve_space(xdr, 8);
-			if (!p)
-				return nfserr_resource;
-			*p++ = cpu_to_be32(open->op_why_no_deleg);
-			/* deleg signaling not supported yet: */
-			*p++ = cpu_to_be32(0);
-			break;
-		default:
-			p = xdr_reserve_space(xdr, 4);
-			if (!p)
-				return nfserr_resource;
-			*p++ = cpu_to_be32(open->op_why_no_deleg);
-		}
-		break;
+	case NFS4_OPEN_DELEGATE_NONE_EXT:
+		/* od_whynone */
+		return nfsd4_encode_open_none_delegation4(xdr, open);
 	default:
 		BUG();
 	}


