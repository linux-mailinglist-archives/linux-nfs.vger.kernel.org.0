Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F0718B8A
	for <lists+linux-nfs@lfdr.de>; Wed, 31 May 2023 23:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEaVE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 May 2023 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEaVE3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 May 2023 17:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB6129
        for <linux-nfs@vger.kernel.org>; Wed, 31 May 2023 14:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14276614E6
        for <linux-nfs@vger.kernel.org>; Wed, 31 May 2023 21:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AD3C433D2;
        Wed, 31 May 2023 21:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685567066;
        bh=rPtZAK9w8p9yyw4nFHJtqFWiNAOFSSIWJpQTMYq/zME=;
        h=From:To:Cc:Subject:Date:From;
        b=fkG3xIHgeg+WVtSDQsxekPOjbY3IUMgeZ0xjcgweGmGCl/UNnLG4z8ng2BGirHrHe
         U1h+Z8HcSeB+z9AG+N+wOqpo/E3gYPunJqW+VS/yUtWAgOdxPHR28EjzaIz1DSaQvF
         YMCMLFXwG1aAp3NUm9ExOJ6shskiWYKBM7cZ13XS0NtfpQmvXwcPlCrp8CQ43aRxlr
         kiabJpAg3mAD5Fftso2y9HLQYz1awNr1nVGpgMjk7O3Uqsn5TKtV7oJyU9HZPw/w9k
         rs1noovzda6j/hocKJ7QQ+3w4TCFqhWCcSFzalFrn7k/5vd3Ym0Yhj+Olf/qa6m6CM
         hyjuNarfvNQ+g==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 1/2] NFSv4.2: Fix READ_PLUS smatch warnings
Date:   Wed, 31 May 2023 17:04:23 -0400
Message-Id: <20230531210424.360948-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.40.1

