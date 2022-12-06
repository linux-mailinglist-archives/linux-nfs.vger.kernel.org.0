Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD8643FD4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLFJ1O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 04:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiLFJ1B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 04:27:01 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88698120;
        Tue,  6 Dec 2022 01:27:00 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1670318813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=blRdAMFznuYVK4JcJGOwO8LzBNymOBAcYfVJJpwIUoM=;
        b=VXgmNDMWuOmrgj7jvL9Yj+s68mG6Zp92jAfTI2AE1eO34LAvR/yCWdKh4Z5eS5eIef7CXR
        2Sn+zO/E917BXdMdlRhQ8OdEMoujy5Pylwn4PScPLnrkmKH9eGlLLOZ+4Cp7VXKeqijfE1
        RhP5gwJwLw2pRAnmUzKtVheeD6lWbt8=
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] fs: nfs: Added pointer check
Date:   Tue,  6 Dec 2022 12:26:53 +0300
Message-Id: <20221206092653.28911-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Return value of a function 'xdr_inline_decode' is dereferenced at
nfs4xdr.c:5540 without checking for null,
ut it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/nfs/nfs4xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c6dbfcae7517..571cc63ecb61 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5533,6 +5533,8 @@ static int decode_op_map(struct xdr_stream *xdr, struct nfs4_op_map *op_map)
 	if (bitmap_words > NFS4_OP_MAP_NUM_WORDS)
 		return -EIO;
 	p = xdr_inline_decode(xdr, 4 * bitmap_words);
+	if (!p)
+		return -EIO;
 	for (i = 0; i < bitmap_words; i++)
 		op_map->u.words[i] = be32_to_cpup(p++);
 
-- 
2.25.1

