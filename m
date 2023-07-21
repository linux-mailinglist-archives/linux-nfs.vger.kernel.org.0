Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765CE75D5D3
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGUUj5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGUUj4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 16:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5630CD
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 13:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD53761D9F
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 20:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EFEC433CA;
        Fri, 21 Jul 2023 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689971995;
        bh=9DmJpO+l/sZ/a8mayGnHOMrUZXe2lzx/dv/ilWsBBxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbaosu9zR6VbMuK0+/P1rEpbTZu9L77PN0CJHc4/tFdmojVO+iRyUcaVny58/ceFF
         e0+LcWoKIQNqDwe8MGv2LEyUpq5APsVNAGTkML3U8Xm/L4TWE7S05LSJVRZddc9j6K
         WrjA3cX9zMoKk/GHKjpiLYfC5lM2HHNvrLZfo0rEj0iKz1wcegG/na3EadYKZRrtxA
         X2Ue55YjMb+q0adO86niIdioc2P1EeWgm1H3tX+aIr+zlHg/CUOzJ7aeibxM8ZnCLI
         lUoCWSGidJfPWdZp6rwpZgYEEi4ipjeZ4vXvPJwQcUl0/75+latxLSmAug2UGwyrjb
         6C93H7GOfT+tA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v6 1/5] NFSv4.2: Fix READ_PLUS smatch warnings
Date:   Fri, 21 Jul 2023 16:39:49 -0400
Message-ID: <20230721203953.315706-2-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721203953.315706-1-anna@kernel.org>
References: <20230721203953.315706-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

