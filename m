Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BF756E97
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGQUxY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGQUxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 16:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3110CC
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 13:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06CA61276
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 20:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F76C433CA;
        Mon, 17 Jul 2023 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689627161;
        bh=9DmJpO+l/sZ/a8mayGnHOMrUZXe2lzx/dv/ilWsBBxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1vwc3Ri7VQglHwxh5wFl8Ndq7uvowrB6UxUoGX3jMIcCEJxlvCueVEFdov3Lx2Oe
         r1Sg7Hh6E1zxt7gTk9p2btDpO4FqaK3y5gChFvgVA4iuVvqRvSs31D8WUd4268FsZe
         xnWFhou7gj6Qh2WBuKK4PspoyVmyfXm4TUoLcWgW+/VoTPKVMCPA6/3oCsM22fMBPg
         fFbIPuFs9tPpG18r8rbVvM/5/3HucPzkqApUqxZNS5vBnNuqNf5BtBQyT/W+SaiSxv
         4IcST8iaEEPVDEH2VYh/4ALtjErdrXrHh6QHqaLeL5Iw9QSPAGLFJy6mqG8JBr892E
         ukJ+ByLLrdjUA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v5 1/5] NFSv4.2: Fix READ_PLUS smatch warnings
Date:   Mon, 17 Jul 2023 16:52:35 -0400
Message-ID: <20230717205239.921002-2-anna@kernel.org>
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
index 95234208dc9e..d0919c5bf61c 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1056,13 +1056,12 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
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

