Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B069F72A3EB
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFIUAR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFIUAQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 16:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C37210D
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 13:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B321160BD3
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 20:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95172C433D2;
        Fri,  9 Jun 2023 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686340815;
        bh=/E1EHoJSWzYbAcL9AzZ/2dkUvD66hVq9kCDl0SCwkck=;
        h=From:To:Cc:Subject:Date:From;
        b=p5Yg0K6erhPdpT6bdjQQnyKt0CPiOv3FoGqNarD3fn9HXJTgtS11NbwJAnBjsanH8
         AdxWbxYSNTPjNCHi9eASC8jLwBCLPW2heXDdqVJQWX7YVqM6piQhHyo7SARsmnwPT9
         C4PXTDG866WHlb3735pdPB2qcVSRl+WwPnG+ak41JlzX2oMuuXai/tB8ZuYtu8kk+C
         HvLWPjmOf5TxzpBeIN4vgQoDsMzuvtFJyK7qKohNV91M0EcyweK0F1YvzkHGA5MEFI
         XTy4giYVIUX5qdJ2M0YxaVzU9OIXy6k6zUMAm4VsRBXV0A63rukhnMh9iOxsSvdoGO
         NdhzP6Py5PTvA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 1/3] NFSv4.2: Fix READ_PLUS smatch warnings
Date:   Fri,  9 Jun 2023 16:00:11 -0400
Message-ID: <20230609200013.849882-1-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
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

