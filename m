Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C9672502
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjARRcY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjARRcG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F372410C
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4625761944
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C02C433D2;
        Wed, 18 Jan 2023 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063103;
        bh=2DX01B1JGxHfUZczB1DPpcTkQOI/O73Nyk/fLGuGKQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXlAR9WGfwRK+asGYNRXx2Fmb3rKfWfzkh6FdgFbrDdkXqfdC5XTL7K1KtTJYlxD6
         F9G6MX8738Vr//iFlRbsigZy51cCunp99GDoagNXgXT31OTS8UcNlyUbTx8SdCfwDf
         5ke0hbLYv2c8a4mv/cxJIt5eXHOIdV4/ycB1SlJAJx6D0WKhmgq5RT7XwPAt7kiSGe
         n0O5VCX8iVxi9+Q1tOzXLViCX08GXw1o64Rh1Oc/DnMNmhGQ1sWAql2ekgVM8mcNmm
         SSzRnvLz5wLRfOQhudo99O2HC3R+yNJNs+7rAz8MoFlvIbFImoJvM94SauBClvO0Cx
         Gd7m2epcOskAg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] nfsd: don't take/put an extra reference when putting a file
Date:   Wed, 18 Jan 2023 12:31:37 -0500
Message-Id: <20230118173139.71846-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173139.71846-1-jlayton@kernel.org>
References: <20230118173139.71846-1-jlayton@kernel.org>
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

The last thing that filp_close does is an fput, so don't bother taking
and putting the extra reference.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a2bc4bd90b9a..f604dd8109e4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -401,11 +401,8 @@ nfsd_file_free(struct nfsd_file *nf)
 
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
-	if (nf->nf_file) {
-		get_file(nf->nf_file);
+	if (nf->nf_file)
 		filp_close(nf->nf_file, NULL);
-		fput(nf->nf_file);
-	}
 
 	/*
 	 * If this item is still linked via nf_lru, that's a bug.
-- 
2.39.0

