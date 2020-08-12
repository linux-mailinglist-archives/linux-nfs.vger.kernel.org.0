Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F36242B02
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgHLONF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgHLONF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Aug 2020 10:13:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A03C061383;
        Wed, 12 Aug 2020 07:13:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so2089012wmi.5;
        Wed, 12 Aug 2020 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JSWXdvJKypcewGZSL+FLA89GNbkLI8DDuSajPdeI90=;
        b=PDBU2thuP7mGuehMwtGHU4dcvMwcHV2wHS5Fz6ERcv+PFycF9hHs89nJnf3Ro6X4LZ
         8CKf3LZMB+B1OK5DFcChRayeL3G+pr2+Qdrfx9nHpNm79DF33ZPufWd5bl/7aDvNW2eA
         LdneA30b4Qb49jOsRpWSz3rMEhOJ52mRdIAIDorz6qjd2XSVXi4urt3HTbgPgtA0yP1a
         Ekdf2g1B1V4h7b7XuD7hH5nLZ0AbO+wuU79ppJxLJ/nDy3w5ooBKMvfhv1W2DirFwGDV
         QSKgMcUaVIhLhvRo5VID1PCfrFtTaOm9e0mRHnfQHwqjRBt0aAkIwWXJd2KyEglKw2rf
         VoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JSWXdvJKypcewGZSL+FLA89GNbkLI8DDuSajPdeI90=;
        b=mkrgBCyHgfMiw8E/kf+K7499ZVhLEToOkoqB6Vv2Ix0YQH0XlFw5tqx5xFBcfts8Dq
         Ploa2LQu6mNbhlj5RQi4SGNUCQSDXXVTAcKv0ZOhJKSrbIWvjWkX2X2IAfa5j84Da7o7
         cUA/KeRvn8hl9M4LNGzDFwZDlIpSUnPlPSr13L1ZlYg5Yb15EvNcbuoTJAFuRddeHZah
         WGTgMYk01muZ3bEi1nvA82fMTWDrLOmc9dKEnvEwdpANC6Jl9CaGbItSB5NHwMRe6AK0
         Dr7CIeNHNKB8T/NE9zmk1zP6vBPSFk/t0etgyP1N38R0xtIGMWmldDv9hKDh18S/bl/V
         gzFQ==
X-Gm-Message-State: AOAM530lRqgHas/deQsXt62ivtvWsaJvncq+ZL/JvQgCzm1/v2td5VpE
        mBTmIUBwCEBQ87AAsNkwwJc=
X-Google-Smtp-Source: ABdhPJxLI+bpIIToGSoBCnC9gRUo94x6QghuJnyl1w5jZGtqfmNYNhSgWQpHPGGpQ35ecsDKBnh62A==
X-Received: by 2002:a1c:678b:: with SMTP id b133mr9401362wmc.117.1597241583696;
        Wed, 12 Aug 2020 07:13:03 -0700 (PDT)
Received: from localhost.localdomain (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id g14sm3818331wmk.37.2020.08.12.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:13:02 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH 1/2] nfsd: Remove unnecessary assignment in nfs4xdr.c
Date:   Wed, 12 Aug 2020 15:12:51 +0100
Message-Id: <20200812141252.21059-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In nfsd4_encode_listxattrs(), the variable p is assigned to at one point
but this value is never used before p is reassigned. Fix this.

Addresses-Coverity: ("Unused value")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f47..1a0341fd80f9a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4859,7 +4859,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 			goto out;
 		}
 
-		p = xdr_encode_opaque(p, sp, slen);
+		xdr_encode_opaque(p, sp, slen);
 
 		xdrleft -= xdrlen;
 		count++;
-- 
2.28.0

