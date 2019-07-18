Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E716CDDF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRMLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 08:11:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39131 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfGRMLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 08:11:35 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so51032692ioh.6
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aMRuM337D3njizRGsy172LfhY5gl2ZFtj3K5iO5Dyvo=;
        b=rWd367pblPI3uAJ8A6/Iw8TvXtgogFQOonH3sZIJilHQUXdhmiBAHMsXpVjHqRctN9
         1WAlCaYQMe3o1UJdNYGLY+3dUpCpp7oTAne6GXuQLzp65qZayp+YJOePKP/2drbwpJuE
         pHifIzSU4GunyvV0Hgk1tTJy07eQy/2n+t6vXeYExxCUDv7j25ZC9PwKK1+iy4MdpCyE
         iJQ0TTwPz9yyOmAohMx/sYkmNBW++DXWOBd+gNlire7AeDqNNk2Q2qkgGniW8ol1w3cd
         QR6jVwcSxdduHbXXq7qupQFdgzRoAlnkHbdva8gENAFUQ6bE70b7xX9su/faZTGIMKU8
         V0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMRuM337D3njizRGsy172LfhY5gl2ZFtj3K5iO5Dyvo=;
        b=p0VBnH/l57S9c/D1GjjbG4J/FrHtqA/6GsMncMiR4JObUWNCq1KaLgbZ6jit/eYg5q
         Wg48Qtin0jH8Lj76wlXyp6HY2g61hJYmjdgVGybZ9P+BEP6mrSbs1X+4WP7/IjO9ccej
         cxULN0z6XgFaCDtibSKoXU34g8DY/ULH04mzPf3W+OrscsTCQD01By4jrvn+hmRhqDcZ
         PkvWgPKKYxNNOJPB1gbDEyg6USLxYiKupyzdfrUu4x+XjXGicyzf+0UNmTtjMMhdeTUz
         AlDAjwcjFMGsjcslluq6djjJGww4Cu6pDaoOvqjYdbGXIeIk/trtoe5SwRCvqovH+dyZ
         +S9w==
X-Gm-Message-State: APjAAAUCb75isZRGUdje0CUCX0vG4fHC8SNok5g/Vyo94wR7guWru/RC
        zhhRFoKBDWiHvblF+vk1GUM4Kd8=
X-Google-Smtp-Source: APXvYqxwqALlGMtVk/LfJkKCdBhQvk0jLfghyenXmqskiEQ7SmLUSckLWTe1XUYoWRZIeOoTUEGokw==
X-Received: by 2002:a5d:885a:: with SMTP id t26mr37429965ios.218.1563451893765;
        Thu, 18 Jul 2019 05:11:33 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i3sm23406741ion.9.2019.07.18.05.11.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 05:11:33 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix initialisation of struct rpc_xprt_switch
Date:   Thu, 18 Jul 2019 08:08:03 -0400
Message-Id: <20190718120804.108146-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718120804.108146-1-trond.myklebust@hammerspace.com>
References: <20190718120804.108146-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we do initialise the fields xps_nactive, xps_queuelen
and xps_net.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtmultipath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index c12778e1235e..f3ecd0bee484 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -103,7 +103,9 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 	if (xps != NULL) {
 		spin_lock_init(&xps->xps_lock);
 		kref_init(&xps->xps_kref);
-		xps->xps_nxprts = 0;
+		xps->xps_nxprts = xps->xps_nactive = 0;
+		atomic_long_set(&xps->xps_queuelen, 0);
+		xps->xps_net = NULL;
 		INIT_LIST_HEAD(&xps->xps_xprt_list);
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		xprt_switch_add_xprt_locked(xps, xprt);
-- 
2.21.0

