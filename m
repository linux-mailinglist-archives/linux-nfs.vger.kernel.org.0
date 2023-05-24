Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922FE70EA68
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 02:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjEXAnf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 20:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjEXAne (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 20:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030EB5;
        Tue, 23 May 2023 17:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 548C861B8C;
        Wed, 24 May 2023 00:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A78C433D2;
        Wed, 24 May 2023 00:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684889010;
        bh=XqBRM7wMx7bhj22GlxezAhF4kwnXTfLHZNjhx8i29XE=;
        h=Date:From:To:Cc:Subject:From;
        b=f93Pabb7KcuqabWadPFXOC3R2rz9S0T3KbI+qvoqRkbAunayJIvMEs8EsZZFS++ys
         qAl0KX2/JhMe+2GGL32tEDHx8TL6795oLn4S5lAsxJ8takKfd/LqscgyCYuTPHYzdO
         XgFyn4OFB44MqzfOFj+s5GH/j/jY33s2Cq39S4+79w6Pc9/GS3BKsEfuVTBEFQa39M
         FKLJ+Hz7tQ47ebQefuIvv6AumkfczhVQhoEOiO3esr+CULGVvyftidR1/a+3DAnNib
         8QuEXqLFMxFnMOLF6dbuYWiL2KIOUaGoYnzxL55FOgxR4iV8O6ZbQdlCD0dfsYn6J3
         nQSZtWGLvIgZQ==
Date:   Tue, 23 May 2023 18:44:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] nfsd: Replace one-element array with flexible-array
 member
Message-ID: <ZG1d51tGG4c97qqb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace a one-element array
with a flexible-arrayº member in struct vbi_anc_data and refactor
the rest of the code, accordingly.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/298
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfsd/nfs4callback.c | 2 +-
 fs/nfsd/xdr4.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4039ffcf90ba..2c688d51135d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -353,7 +353,7 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
 {
 	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
 	encode_uint32(xdr, ra->ra_keep);
-	encode_bitmap4(xdr, ra->ra_bmval, ARRAY_SIZE(ra->ra_bmval));
+	encode_bitmap4(xdr, ra->ra_bmval, 1);
 	hdr->nops++;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 510978e602da..68072170eac8 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -899,7 +899,7 @@ struct nfsd4_operation {
 struct nfsd4_cb_recall_any {
 	struct nfsd4_callback	ra_cb;
 	u32			ra_keep;
-	u32			ra_bmval[1];
+	u32			ra_bmval[];
 };
 
 #endif
-- 
2.34.1

