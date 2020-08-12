Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4288242B04
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLONJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgHLONI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Aug 2020 10:13:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D25CC061383;
        Wed, 12 Aug 2020 07:13:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so2164800wrs.11;
        Wed, 12 Aug 2020 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UvE1ht+RylFhXClvRKXTyvDZh96h1nFlKqOy/8yVzKg=;
        b=JY9CLFIFB4EDUtuTzUzgEJxDFErqDCHEjfAqydSvu7gRvVzwxL4BfF+0EeP3ImQPEw
         PfO8zd1FYGhyrTBsfEGWgnnP6/8dXXe80hY/x2bShajcr5PA/5Ha/cPev6Uyd0OsSxU0
         Yq04hDOMF1UK/YSz8wdIHInbAK+JEGAKOumT0rUGh/NuAfV5Ge7Ywljj51itx8AdDD/3
         gTEnt0kcpT3MluvFMR1KqsRdmjzz2dxUCtUwQbKNZijpAWk7Xl9bHenBVG7wneNeGLpQ
         eKwGFTh5GYWjOhH+ki2zO+5YSmgFyUabHwTCVKtHDrYrEuGKpi9b65Uow4++4Q5L0NN6
         b20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvE1ht+RylFhXClvRKXTyvDZh96h1nFlKqOy/8yVzKg=;
        b=p/qXpamzJlIng28s4EY6Dk8kU3PKkM/STTaEiDz/mRJwc5tqq6fEfvrwOO30UtQyQu
         0oALNWzzuaVoC9cUksgDnGVo8v+/qhpOM3zv/Gzbg4fFbfNdPLA8xPED23ujgZphuktn
         4BspwXnmstydu9ixne4iSMCO0U/h1nPUzSFeyCIdz9rwpSMl0D/zTwLtK8xEkK8ZX6iN
         1Gos05BgaD7h4f20mlD22pBu+oxGuaIVe7cxoabuYgudrKbm+eIVmbrzYFygsdCn/3gT
         h0TFuSNJfMWElPZIhKQCFW0Y+dylWbcHpJJ/6crIMQx6E46QRO2YVFbU/mFLLsFdmqOd
         7htA==
X-Gm-Message-State: AOAM531nYqjU3DMuRzQUN1YAliHzbf8QgOp82U3UWckZy+6Gx2c1Cgzy
        yGVETbRbneTpHCQ5+2yNMU8=
X-Google-Smtp-Source: ABdhPJx90Xzz4nH94+2XW8uPv8t+WS4PUrtHnxAD8MsaUAwAUcmxhICEH0amrsPs2qdD+0QvOZ1sqQ==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr37276406wrc.25.1597241587422;
        Wed, 12 Aug 2020 07:13:07 -0700 (PDT)
Received: from localhost.localdomain (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id g14sm3818331wmk.37.2020.08.12.07.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:13:07 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH 2/2] nfsd: Fix typo in comment
Date:   Wed, 12 Aug 2020 15:12:52 +0100
Message-Id: <20200812141252.21059-2-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812141252.21059-1-alex.dewar90@gmail.com>
References: <20200812141252.21059-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix typos in nfs4xdr.c.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1a0341fd80f9a..3db789139a71f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4828,7 +4828,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 		slen = strlen(sp);
 
 		/*
-		 * Check if this a user. attribute, skip it if not.
+		 * Check if this is a user attribute, skip it if not.
 		 */
 		if (strncmp(sp, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 			goto contloop;
-- 
2.28.0

