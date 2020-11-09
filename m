Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD12AC70B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgKIVUp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgKIVUo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:20:44 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61EDC0613D3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 13:20:44 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so7107602qtp.7
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=areiMMXZzlnhm2wpgeZFwm/3fbilrhaLYUTcNjpnIv8=;
        b=B9HpvBh/MNXu2M9eSgNLiiT6p+sCWevAqFN88QbHr0tv9aI7A32lVzsXN+7OYa3ZA/
         ouCAXEMIVJO+F1VN0SYvz3CpJDiYzmwcXqEjB0q9IdfBdxRaFG57dfJIM354s28nguo+
         dDOGZJr+JigXbr1z1xPdjqGCjgFcZl9sI7iyWD5VppqdKvQwdBE10sHFFHkIEPk5WL5P
         aVfWeJAne0GPpVZMW899zJHavl56ibohMjYUYJCSft0LnUucKvjk4Cv3Z56FgCZmwcGI
         myVOGiJEebCOYQdkTKPYuN1QiuSGEUgUfizOu/mZvgQsAbAnivTPVH8b/zdVS6kqAbHs
         ywNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=areiMMXZzlnhm2wpgeZFwm/3fbilrhaLYUTcNjpnIv8=;
        b=G9EunCWO9OFmYOFdYF7TK/8BtZOLdZCOmvkskHlLsMpK0FkSKYi3j8zYIWoycM0LsO
         qa0GBzeAAniP3VZiXSw4GeS0gotnDIPbbPTq00RRkWJ125NtQd6mkFOVHyiLpybPdbWk
         5vDIlhod4HAvFGP/nA6vTjoERwZgyx8rnJ56MOH2oT0aAC/FdBCXGbFMKvNcS/rGg1LZ
         M56EV7sqgx7VLVx95FhEbpFsgLPBDxtw7idmyeKoukATMxk52NWyLUKvXYCp8n2zSZex
         n7J9ltHfXNWdqxIkSw+iEfuOI7ufQ75+pHDRefpP32+5HbuliiX5KVG3QIooB5D3DGRa
         XImw==
X-Gm-Message-State: AOAM533+3wUsu/slkdhNX3Z5pkgJnfCoFmXIKPBB04iXVAxPntZIwBy2
        Kl5PPyMPzzMaKp1+4/H1DoipgmCBXkPk
X-Google-Smtp-Source: ABdhPJyxXs8hlgb0RNHs6Pbjdgs8ReMLMdo8fIWeCwjWc1L3Jyia4PcJ2U8UV65/uZ7uo6t0noz3kw==
X-Received: by 2002:aed:3865:: with SMTP id j92mr3354810qte.318.1604956843557;
        Mon, 09 Nov 2020 13:20:43 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d188sm7025241qkb.10.2020.11.09.13.20.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:20:42 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/5] NFSv4/pNFS: Use connections to a DS that are all of the same protocol family
Date:   Mon,  9 Nov 2020 16:10:26 -0500
Message-Id: <20201109211029.540993-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109211029.540993-2-trond.myklebust@hammerspace.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
 <20201109211029.540993-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the pNFS metadata server advertises multiple addresses for the same
data server, we should try to connect to just one protocol family and
transport type on the assumption that homogeneity will improve performance.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 679767ac258d..7027dac41cc7 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -860,6 +860,9 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 				.addrlen = da->da_addrlen,
 				.servername = clp->cl_hostname,
 			};
+
+			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
+				continue;
 			/* Add this address as an alias */
 			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
 					rpc_clnt_test_and_add_xprt, NULL);
@@ -920,6 +923,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
+			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
+				continue;
 			/**
 			* Test this address for session trunking and
 			* add as an alias
-- 
2.28.0

