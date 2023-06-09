Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2272A3EC
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFIUAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIUAR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 16:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953830F4
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 13:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FB3961F2E
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 20:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F440C4339C;
        Fri,  9 Jun 2023 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686340815;
        bh=sZUdB4HXewAprQJemD6d+JaBNZUoLjQO4bIc7WuNV9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUew2KC7xLgIw8GmeoREsvI1GV+6JXA1WVH7fb5wnGl6fTSmkkQO5B2Jvb/qxIPc2
         G0FN7mkMFBJjPWC2XBRlLDWzrazj7P5oHElPTNgI7T/ctizHpENM9JUCJXEZjQj2ae
         8KQbtckayIEayJJdvIs+AKIEvtYsqXG5VQEOV9eEAp35aBEUBbtylflAtkW6PiH21J
         CYSg51JmNpR5rog8BedFAYZBBk0oRdVbCetPhtl4TZkXZlEQ7VatWPxrp8UAJQdj3E
         Ri/gyMJ1mNaHBhOzi2LHcfl1Jg5khll7OaU10QqAwiInki3FY4tpGI2Peim7WCVysL
         SXUY5uhVxuL7g==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 2/3] NFSv4.2: Fix READ_PLUS size calculations
Date:   Fri,  9 Jun 2023 16:00:12 -0400
Message-ID: <20230609200013.849882-2-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230609200013.849882-1-anna@kernel.org>
References: <20230609200013.849882-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I bump the decode_read_plus_maxsz to account for hole segments, but I
need to subtract out this increase when calling
rpc_prepare_reply_pages() so the common case of single data segment
replies can be directly placed into the xdr pages without needing to be
shifted around.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: d3b00a802c845 ("NFS: Replace the READ_PLUS decoding code")
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index ef3b150970ff..75765382cc0e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -51,10 +51,16 @@
 					(1 /* data_content4 */ + \
 					 2 /* data_info4.di_offset */ + \
 					 1 /* data_info4.di_length */)
+#define NFS42_READ_PLUS_HOLE_SEGMENT_SIZE \
+					(1 /* data_content4 */ + \
+					 2 /* data_info4.di_offset */ + \
+					 2 /* data_info4.di_length */)
+#define READ_PLUS_SEGMENT_SIZE_DIFF	(NFS42_READ_PLUS_HOLE_SEGMENT_SIZE - \
+					 NFS42_READ_PLUS_DATA_SEGMENT_SIZE)
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
 					 1 /* rpr_eof */ + \
 					 1 /* rpr_contents count */ + \
-					 NFS42_READ_PLUS_DATA_SEGMENT_SIZE)
+					 NFS42_READ_PLUS_HOLE_SEGMENT_SIZE)
 #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + \
 					 2 /* offset */ + \
@@ -781,8 +787,8 @@ static void nfs4_xdr_enc_read_plus(struct rpc_rqst *req,
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_read_plus(xdr, args, &hdr);
 
-	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
-				args->count, hdr.replen);
+	rpc_prepare_reply_pages(req, args->pages, args->pgbase, args->count,
+				hdr.replen - READ_PLUS_SEGMENT_SIZE_DIFF);
 	encode_nops(&hdr);
 }
 
-- 
2.41.0

