Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125D52C6018
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392614AbgK0G0j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 01:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392604AbgK0G0j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 01:26:39 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D25C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 26 Nov 2020 22:26:39 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l11so2226898plt.1
        for <linux-nfs@vger.kernel.org>; Thu, 26 Nov 2020 22:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdoOOHE7JcF5jwP7q3cULJjg33z0tNqjrQaSl4qp56U=;
        b=cpOQOie+pb5OUo8MxXyYB7WtG62WoupTRCUjt/CJfXJ7OzhoC0QciQHm+27fXOU/yy
         I1EM4qHYWKu7bF2iAEDQZDL5cCpH9UqW5F+E2KrCvxn+VHDaR1VTJFJH57+KvuFVclEq
         LI5X/9WI3xK7H7kWY4vf0wvZAMvSDmZJT90IFLe4kPxnVNUed8J7xif7m2qnPVEudO7t
         /iOYVopna5+ruRguv2o+03Rt7zt0X5OX7gvTH0i2kHeYjTikbcJAMHwg4mvgVhcNdFAs
         uO6PTzCAeKhu7yTjfy105KBzLmKXOV0BIyKv+J+sZuJw+VRihMjzWKeeCvqnib8P7qtD
         Jl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdoOOHE7JcF5jwP7q3cULJjg33z0tNqjrQaSl4qp56U=;
        b=QP2kELXUmGfnA+iERj+yufavQrX8XwN+UDHtIdsliNv2VDHo++EhxA7OpAD0b88X9E
         SR3sLqI46WgbWvGDlIjjlaR/c6SBvI/MTiFSasGE5oxKDSi1Zq8IePaa0prKwpYqvdEx
         DXG5zIJgb3Aq2gwwvaXa08/M5D9pLGZthM52a0YVrlovZ8KJmKR4HRtJ//ok1uzL5cFd
         nHOXTgPRyz/uzTeQIep2ZWHHwabFgTKZsh+2JkcThOjTRXY3mJFJg+Lh5wGGiVN08Vy5
         yFF/RNQ5w1AR6OWiTyJlKoG+2qhGs/EMoxQQHyKmDO25Au13+lpFp4mYcnm1TXUhTHtZ
         6VXw==
X-Gm-Message-State: AOAM5339PxtovFogzFyHvhipOC2ctSoUvBJKqrKfBJHUwj5PbwcmWJBK
        tfcXJL5/7MwNN7HTsJuE/XYOawPY2dCXc5li
X-Google-Smtp-Source: ABdhPJzLIhEtXd1JUxw+R2ZQEOyb1FP1V3Wt4M1xUlnFSTIra3qfw2eKSXB3RyyOddv5zcEw2Jn3Eg==
X-Received: by 2002:a17:902:7c01:b029:d8:ee2a:ce88 with SMTP id x1-20020a1709027c01b02900d8ee2ace88mr5728436pll.22.1606458398295;
        Thu, 26 Nov 2020 22:26:38 -0800 (PST)
Received: from pro6300.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id v145sm5961452pfc.112.2020.11.26.22.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 22:26:37 -0800 (PST)
From:   kazuo ito <kzpn200@gmail.com>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     kazuo ito <kzpn200@gmail.com>
Subject: [PATCH] nfsd: Fix message level for normal termination
Date:   Fri, 27 Nov 2020 15:26:59 +0900
Message-Id: <20201127062659.605229-1-kzpn200@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <7BA358F0-01C3-4530-B5EE-1CBBCE3843C2@oracle.com>
References: <7BA358F0-01C3-4530-B5EE-1CBBCE3843C2@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The warning message from nfsd terminating normally
can confuse system adminstrators or monitoring software.

Though it's not exactly fair to pin-point a commit where it
originated, the current form in the current place started
to appear in:

Fixes: e096bbc6488d ("knfsd: remove special handling for SIGHUP")
Signed-off-by: kazuo ito <kzpn200@gmail.com>
---
 fs/nfsd/nfssvc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 27b1ad136150..9323e30a7eaf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -527,8 +527,7 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 		return;
 
 	nfsd_shutdown_net(net);
-	printk(KERN_WARNING "nfsd: last server has exited, flushing export "
-			    "cache\n");
+	pr_info("nfsd: last server has exited, flushing export cache\n");
 	nfsd_export_flush(net);
 }
 
-- 
2.20.1

