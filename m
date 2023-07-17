Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10093756E96
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGQUxX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGQUxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 16:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E741702
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 13:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8193F61265
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 20:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89033C433C7;
        Mon, 17 Jul 2023 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689627161;
        bh=fR3gJSpm32obogOfvijfq+oe3qtayu6qbsZyOoujcHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmHgmvOiV0TH4nT2gfYVEbNv+wKdyI2/vl4pIPmR4UgIahagfJvGWTJ2crMuwIq4j
         OBiDtTwMwodxIi9sUFbioL92p4DSay/9yshfZ7dBX4Q3S5zkuSyU3eTLuXcr/saUhE
         UdE4RpSKLmsoLhX9fMcpgpz4h80ye+rMQ3+BzaBxkV/toy5HElvEN3IBvcNvHBGUcB
         AU3e1QqySwv+9/OoD3/nvfPo2dcr7ZMtewkKnKQlEG2GJPE409pieBnOZiJBjRN4D9
         66IsN5X5l3glLspTtnTS9cbjDfUqrucgw++hNsrQ2dZFubbor4N45QbBQGu5eqIsO/
         XGO10B9WG1vdQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v5 2/5] NFSv4.2: Fix READ_PLUS size calculations
Date:   Mon, 17 Jul 2023 16:52:36 -0400
Message-ID: <20230717205239.921002-3-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717205239.921002-1-anna@kernel.org>
References: <20230717205239.921002-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index d0919c5bf61c..78193f04d892 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -54,10 +54,16 @@
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
@@ -617,8 +623,8 @@ static void nfs4_xdr_enc_read_plus(struct rpc_rqst *req,
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

