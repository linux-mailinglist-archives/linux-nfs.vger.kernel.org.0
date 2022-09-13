Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F765B79BB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiIMShx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiIMShg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 14:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE101099
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 11:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7759661552
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 18:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81790C433D6;
        Tue, 13 Sep 2022 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663092113;
        bh=bPLBKkTMNsbpLsKMCfOR/FlX9M/qfqpFC/HnX6ydAqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LB+w6BuVqw6+hS3lVuv4lVTn8kSZ9Z32bY7MI/B8MpBF1Aw5i4Tw7zy8abnhAnhaa
         DyVTLlm/Lio9STDSb7SeE/V9VEe3K1BxGlni9DVo0ZWlJ6WNc9XKPpla2KF5qmSoGM
         Rfd9A26RBXYZzjyymG0eBZClqtTs+LoSO/tWO6sjg3Fa3ctteMb9hZ7KJwSS14ivWK
         H0wkEHuBREWc4jeKlR5dERlkxwcw3gW+BpmiIfrgwnftT+PDOHkJWEupDKW5Gr+rOx
         jrztoxK1wIy5lJpjrkZGVdIut6v17vSUf7npy1+Eb3VbPdg4bjHebgJy9NXGG3SwlA
         cvLuvJYGt/EgA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v4 1/2] NFSD: Return nfserr_serverfault if splice_ok but buf->pages have data
Date:   Tue, 13 Sep 2022 14:01:50 -0400
Message-Id: <20220913180151.1928363-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913180151.1928363-1-anna@kernel.org>
References: <20220913180151.1928363-1-anna@kernel.org>
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

This was discussed with Chuck as part of this patch set. Returning
nfserr_resource was decided to not be the best error message here, and
he suggested changing to nfserr_serverfault instead.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..01dd73ed5720 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3994,7 +3994,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	}
 	if (resp->xdr->buf->page_len && splice_ok) {
 		WARN_ON_ONCE(1);
-		return nfserr_resource;
+		return nfserr_serverfault;
 	}
 	xdr_commit_encode(xdr);
 
-- 
2.37.3

