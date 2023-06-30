Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC4744362
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjF3Umt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjF3Umo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 16:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DF3C07
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 13:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1675B61811
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 20:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5CFC433C0;
        Fri, 30 Jun 2023 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688157762;
        bh=/E1EHoJSWzYbAcL9AzZ/2dkUvD66hVq9kCDl0SCwkck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGQPyWK3mXq7z9+uqZGqu1eoINecDFoXbVZ6JYWRNVNsFjHVsFyisX+8jm1LRsGC/
         w+FyzT2mKO/0OhvvMavOa5VPbu5zE/IY7yEb8/vQGWlnkqQv1HiAXT8SYS3Im8xPau
         /Yd7v/EU3776s2cBy5dDr4oWcSWJOSuO3yIHranD3kUEHtkXsPXChHM30XJ8doGHCI
         MJOuDidOannmmFrvoDYGKocnH1IFty/nj1dnTvwdUv8ghuItwLuzcAwZG3f3xcmHPV
         TZQ7Nr1QIHOL9QEPPUdGnsHv6oYdUH/KTlIeWZlJiRd12BNAVHojbvtJYhu8MFTlUa
         nEZVXvenSdORw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v4 1/4] NFSv4.2: Fix READ_PLUS smatch warnings
Date:   Fri, 30 Jun 2023 16:42:37 -0400
Message-ID: <20230630204240.653492-2-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630204240.653492-1-anna@kernel.org>
References: <20230630204240.653492-1-anna@kernel.org>
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

Smatch reports:
  fs/nfs/nfs42xdr.c:1131 decode_read_plus() warn: missing error code? 'status'

Which Dan suggests to fix by doing a hardcoded "return 0" from the
"if (segments == 0)" check.

Additionally, smatch reports that the "status = -EIO" assignment is not
used. This patch addresses both these issues.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305222209.6l5VM2lL-lkp@intel.com/
Fixes: d3b00a802c845 ("NFS: Replace the READ_PLUS decoding code")
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index a6df815a140c..ef3b150970ff 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1136,13 +1136,12 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	res->eof = be32_to_cpup(p++);
 	segments = be32_to_cpup(p++);
 	if (segments == 0)
-		return status;
+		return 0;
 
 	segs = kmalloc_array(segments, sizeof(*segs), GFP_KERNEL);
 	if (!segs)
 		return -ENOMEM;
 
-	status = -EIO;
 	for (i = 0; i < segments; i++) {
 		status = decode_read_plus_segment(xdr, &segs[i]);
 		if (status < 0)
-- 
2.41.0

