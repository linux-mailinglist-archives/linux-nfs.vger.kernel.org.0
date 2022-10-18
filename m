Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D1603628
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 00:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJRWnz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJRWnw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 18:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FE8A7E8
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 15:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4994F61717
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 22:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D58BC433D7;
        Tue, 18 Oct 2022 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666133030;
        bh=uwCVdX1ulfgefYmg7XZs99cD0gzgSY50547f4XFvpF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epNgVUfF3nksWS3wK354Q9oyXDvTFIu6Ocq9Jct0gHFIE3sJeuzepaAhiJwnkNzcU
         egtUIR3UNZlt2dKpjAelMc4jBm8d7E/tzVoNB/6tQXZl/DG7jLgILuw+Z8PD9n3NC4
         5lwc1u6fIGpebw1fcLo9IMtuxof3G3db3joE6cRsCW3jpPoZZkqyYNLxXjsajgXaL5
         viozJP0ICKNnCT1SUhe1rVJE7O6cZLwXLss6v6POz9XdixdfjDQIHuhfVu78o1Touj
         coVSNdgAxbRiZf5QDS0e/Sp33ULSlKqx354AjTrXnSBaG+EDPd1QvSWILfoxim1frF
         hVQ85x8q3jtzw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4.2: Fix a memory stomp in decode_attr_security_label
Date:   Tue, 18 Oct 2022 18:37:23 -0400
Message-Id: <20221018223723.21242-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018223723.21242-2-trondmy@kernel.org>
References: <20221018223723.21242-1-trondmy@kernel.org>
 <20221018223723.21242-2-trondmy@kernel.org>
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

We must not change the value of label->len if it is zero, since that
indicates we stored a label.

Fixes: b4487b935452 ("nfs: Fix getxattr kernel panic and memory overflow")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 9103e022376a..deec76cf5afe 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4236,12 +4236,10 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		bitmap[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 		if (len < NFS4_MAXLABELLEN) {
-			if (label) {
-				if (label->len) {
-					if (label->len < len)
-						return -ERANGE;
-					memcpy(label->label, p, len);
-				}
+			if (label && label->len) {
+				if (label->len < len)
+					return -ERANGE;
+				memcpy(label->label, p, len);
 				label->len = len;
 				label->pi = pi;
 				label->lfs = lfs;
-- 
2.37.3

