Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA863DCF3
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Nov 2022 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiK3SSg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Nov 2022 13:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiK3SST (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Nov 2022 13:18:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6398947
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 10:15:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDE1CB81C9C
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 18:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408B1C433B5;
        Wed, 30 Nov 2022 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832129;
        bh=8PAhh+2aTi6d3mPzn3GIY6BAAQh/zqGJwCzo8E5Jviw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bpl1/vVRTkCaqA3u660K/LySXa4K1xiS3I4gzxCm6EFSonJLEN3jN1EeJc5z/QRqX
         bUPB71ERMLRbxGGkiLRBZTMx1apZDWyqr3swLwjirKKIHpiCM8PpqXluCOyOznEDP5
         4deY7ISHEv6ptqrXVKqF0+OvgDFe8AHvhoL8nmrmUsgk3hbT+VvJfq+ZyvrJGpBR3I
         KnyNSDzwzwM5KYBGlI2wTCA3QLFA+B8TujpLJfeODpXJ3iYj0X3Ne35Ud4ccfIathW
         AnwZmzpYCUK1zPP8X/zLMmo4YVwVYYvaCJd9kBJTFZSWMWEZUBKBc2//0PrzbVvcZ+
         5LIo2vKI8hkjA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 2/3] NFSv4.2: Fix up READ_PLUS alignment
Date:   Wed, 30 Nov 2022 13:15:26 -0500
Message-Id: <20221130181527.766485-2-anna@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130181527.766485-1-anna@kernel.org>
References: <20221130181527.766485-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Assume that the first segment will be a DATA segment, and place the data
directly into the xdr pages so it doesn't need to be shifted.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 2fd465cab631..d80ee88ca996 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -47,13 +47,14 @@
 #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
 #define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + 3)
-#define NFS42_READ_PLUS_SEGMENT_SIZE	(1 /* data_content4 */ + \
+#define NFS42_READ_PLUS_DATA_SEGMENT_SIZE \
+					(1 /* data_content4 */ + \
 					 2 /* data_info4.di_offset */ + \
-					 2 /* data_info4.di_length */)
+					 1 /* data_info4.di_length */)
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
 					 1 /* rpr_eof */ + \
 					 1 /* rpr_contents count */ + \
-					 2 * NFS42_READ_PLUS_SEGMENT_SIZE)
+					 NFS42_READ_PLUS_DATA_SEGMENT_SIZE)
 #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + \
 					 2 /* offset */ + \
-- 
2.38.1

