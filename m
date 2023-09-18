Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446E07A4BF3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjIRPXv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjIRPXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D519D
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE373C116B4;
        Mon, 18 Sep 2023 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045581;
        bh=rfFAteDhYCQvoSPjxMRQ5ipc/xK9xXR6g5Fbi87zWOU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gVU/jMdWy3YfE/TA7pg/2P42r3Xmw62TfbHB8wiMRKGONSieBt/SAwszCF/xmQ5fB
         YhZu/MDfYe1hTlt+D+5VU3BoggBRrFznuzWJB0C0ZpOAmfef3WYfjaNaGH9oMBnvED
         AIn253gYWkxf05mjLYjYSiToBbYr5Xi2LAZ7I4ZMHX1QG8T0Y7tdiXHvmZx3WIbi9y
         wIj/IoSfOyG9txt8cRVaMawdDueBcszW7cExoMgx3flkBLWD+6wf5d1pn0CfzeN2K/
         4k4zJyB3bO2JPl3h0RiFqkIwVNDYbK7e6mVhsh3CB0Jk+Q33P/EBnmFlGRrS/kbKQ9
         fkde2LHDDHsuw==
Subject: [PATCH v1 27/52] NFSD: Add nfsd4_encode_fattr4_maxread()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:39 -0400
Message-ID: <169504557996.133720.11598552337976844789.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_MAXREAD into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 546879759c71..35911ecccfbd 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3170,6 +3170,12 @@ static __be32 nfsd4_encode_fattr4_maxname(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, args->statfs.f_namelen);
 }
 
+static __be32 nfsd4_encode_fattr4_maxread(struct xdr_stream *xdr,
+					  const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, svc_max_payload(args->rqstp));
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3434,10 +3440,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXREAD) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) svc_max_payload(rqstp));
+		status = nfsd4_encode_fattr4_maxread(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_MAXWRITE) {
 		p = xdr_reserve_space(xdr, 8);


