Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333633A8E1C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFPBMa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhFPBM3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F14C061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id u30so935959qke.7
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vWcJCJxN2zJiTTQMTjQVGAA4Clv5uDSLIsXFO1UYJk=;
        b=h8erflNbs0QlMaYgZlXUyLNxzFHfIa00p6BSd+c35c4BMGQaBSyiSzqpmC8tiLKm4E
         prdArLc9WgYzlZnzrzdVs17ZIU7DG7NncfJNe323UHIrNtQXJqdyJBttpAB8R3EBxZAG
         GzN/gEECf0X4DGi1hDPdho0+aMID/htv9DE4Tg1kmKh2Z9LvHgEQ+Pvj8PeEz8+MQXL3
         cEugy1jOxeIfR76iOtAbj94Aup9knFtSnWTJJ9Un3VCDeIMLamg3cqjBXd+phOI+CyAc
         qJ8jB5kutDy2E/2t5xUg4xRis4ZL+E6XsRCWI6kNft90PtUBkdccI2cC5zuw2UWLePhU
         Z+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vWcJCJxN2zJiTTQMTjQVGAA4Clv5uDSLIsXFO1UYJk=;
        b=a6svZd0v7z9Ca1i4kMXxITV5h0pFDXCyldvomI/wecZ9u2HKRp7EkzfxaFOrOHIYgy
         eUBo2DlNNUeMQIT4n/4bWGLlQ2nSrxVcSRFV1lIBDW3LGcckFqFlHkkx00WdUJP7Qn6E
         qphN2zK+kl2HGRzdAwtf1tHTTTidMEOByOHUat9f55dc/aCnz8jHx3/c7+Jy+SH9meZK
         gKtwjk6burjwKFI4TiPWwSrOXQAyMNH0BfjE0u6p1sfFdKfYjUT4Wha2qeggevFf6kk4
         ylu/tZBN6OfXuQS/TRgoR3/fKTq/ghkghAdp1dSOHSqX5x4hQgs3CLmZp/lcuNja3TjW
         12vw==
X-Gm-Message-State: AOAM533xflmA9AxQUcuFv4AiAGDjQy7QDbzlhYEOETqm4l+wrFlJ5Kst
        /1IPXIMzMkVktLNpq+9N0XU=
X-Google-Smtp-Source: ABdhPJwsdfNoxEPj8uELqu08EUbbpklvy0gArb4gOD/nGXqVcelhW6QeDvS8yBpqu/cZhvNGIfg19g==
X-Received: by 2002:ae9:e415:: with SMTP id q21mr2552530qkc.121.1623805822975;
        Tue, 15 Jun 2021 18:10:22 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:22 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 6/6] NFSv4 allow for nconnect value of trunkable transport
Date:   Tue, 15 Jun 2021 21:10:13 -0400
Message-Id: <20210616011013.50547-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the new mount asked for nconnect mount, then create old client
number of connections to the destination address that has been
established as the same server with trunkable address.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

--- There might be a number of objection to this patch. One
I can think of is that this patch creates the nconnects based on
whether or not the new mount asked for nconnect instead of
unconditionally creating nconnect number of connections. The patch
still creates nconnect connections based on the original value
instead of picking the value of clp->cl_nconnect. I would have
preferred that would be done. I don't see what can be wrong with
using the new value. But I feared to go against what was objected
before. My preference would be to (1) create clp->cl_nconnect
connections or (2) not use this patch at all or (3) use as is
here (meaning at least not create extra connections unless asked
for by the mount).
---
 fs/nfs/nfs4client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index af57332503be..50fa9d53b444 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -427,6 +427,15 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 
 	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
 			  rpc_clnt_test_and_add_xprt, NULL);
+
+	if (clp->cl_nconnect > 1) {
+		int i;
+
+		for (i = 0; i < old->cl_nconnect - 1; i++)
+			if (rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
+					      NULL, NULL) < 0)
+				break;
+	}
 }
 
 /**
-- 
2.27.0

