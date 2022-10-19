Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04312604F15
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJSRnn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJSRnn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 13:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5261C5E15
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 10:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D674FB82572
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 17:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483EAC433C1;
        Wed, 19 Oct 2022 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666201418;
        bh=zhorUzccnj4fCYEMYcILKuGLYfRQ/Z25KahCPnqRaX8=;
        h=From:To:Cc:Subject:Date:From;
        b=pMtxroiky/lQMR2Iw10s8ivBm6wRtnuK6KsElu5NqxHYsdFIKkUMPU7PFdQdMZ7EY
         YIYvN+JJLZAG3OpulHoGcnyASX57LLZQcf3YDgwl+UjIy1xBhuNn6tjVfAo/damVIW
         MxnGWfY/7JflbHrVfDEKO8gM4JAqmmHgrKQvc7ZnxBVWpQlmvdLPuKQ3EtzKmcC2+5
         JNjLKP1XNZvK85+PCk8HgDxKWEVKQSXD5Lt2hudOO+GOwv73Vur/L2gnD3dsQOIq2A
         lEnOc0VaWNqkaJNIK3uB63mwI4dYg5/lP5ZF5VEPAtTeQQdvnyh3wmkauXyEtizyBz
         DgLcvs3TID+rg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/4] NFSv4.2: Clear FATTR4_WORD2_SECURITY_LABEL when done decoding
Date:   Wed, 19 Oct 2022 13:36:48 -0400
Message-Id: <20221019173651.32096-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to clear the FATTR4_WORD2_SECURITY_LABEL bitmap flag
irrespective of whether or not the label is too long.

Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index acfe5f4bda48..8c5298e37f0f 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4234,6 +4234,7 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
 			return -EIO;
+		bitmap[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label) {
 				if (label->len) {
@@ -4246,7 +4247,6 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 				label->lfs = lfs;
 				status = NFS_ATTR_FATTR_V4_SECURITY_LABEL;
 			}
-			bitmap[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		} else
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
-- 
2.37.3

