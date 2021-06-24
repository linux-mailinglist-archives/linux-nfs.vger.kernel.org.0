Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32E13B2579
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFXDbU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFXDbU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380CC061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k16so6100530ios.10
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1fkEW2LhHY59nCgB5W4dhaAN6w2ef4pK1UTWYJd0tg=;
        b=tltkt7fqSPU8930cZG2fSePLQK0/RxAzmLjFCqj/wIJu32lhwqkaoR34UqgsNxCDW7
         Ph9ljVksi0dUUClTkqUhB0R0+dtS3E4YYxawKyfuPKBK5+hkXNDaEPfHWYhgEdki3Ewk
         QfMUKCFAe7cue8K47pxB60JF9ywGf8FTsArZjTLECbT75v8GDguGr5vkoNs1vBM561dp
         2NXZfDOAaYq6+u2LPNTvGEYcEk497Zip0juByUgPpt6x4fzu0oiPqnMTGF29kGIgLm8v
         7WpzQxC5jSzFFFb01tW/z5F+i5JoBnOkmUSLRiaP2Ocjn26syBOuaJuM/4j0KaqXblpE
         yIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1fkEW2LhHY59nCgB5W4dhaAN6w2ef4pK1UTWYJd0tg=;
        b=lD4tqafrgm7XxmkJBty7EJSycJ7inGgIsx7moCAnxmTdB0QakoHC5ZGruc2tjGX+LW
         3cbfSPEjlge7VnOL8TBajLjIQmeHtDJ7sZrU58yRS2LkKBbGNm1f6Hnw3H7hrYghG/+7
         Pp2RN5k62sITxHOFXEm63N1N36so4Z9pY2bJqH1H2ZtQhg7XYv6AEmRJ2iNe0oIM2o9J
         C4fVqTWmuLf+xr48fKsiUjyGQ18k3pCLZAa+HQyYyF+RaL7CXcld0S3xSfYDKQBzTWLd
         ZxeSS/4R7t0H09gkpSIjel9GiY5IzhjU3RMFqrTzdKBiUQUpcmSVS2HTkzDJcHKvh8nD
         /OwA==
X-Gm-Message-State: AOAM530+VzoefWYa7z6qBx0bmk+5f0D6UJ0iqOZHqBkZJL00F2lrnlGs
        ddgdCJaENruldLEoeVN9fl4=
X-Google-Smtp-Source: ABdhPJw3LrfWpiWRIzeYIMBpJODcBnIb+aZLJXp3ruE1ywe44sJyTR6/hXJt80IGQX7c27Al1ujExg==
X-Received: by 2002:a6b:292:: with SMTP id 140mr2319583ioc.11.1624505340254;
        Wed, 23 Jun 2021 20:29:00 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.28.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:28:59 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/8] SUNRPC for TCP display xprt's source port in sysfs xprt_info
Date:   Wed, 23 Jun 2021 23:28:49 -0400
Message-Id: <20210624032853.4776-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Using TCP connection's source port it is useful to match connections
seen on the network traces to the xprts used by the linux nfs client.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 6ef5469fe998..816f543d4237 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/kobject.h>
 #include <linux/sunrpc/addr.h>
+#include <linux/sunrpc/xprtsock.h>
 
 #include "sysfs.h"
 
@@ -103,10 +104,13 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
 		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
-		       "backlog_q_len=%u\nmain_xprt=%d\n", xprt->last_used,
-		       xprt->cong, xprt->cwnd, xprt->max_reqs, xprt->min_reqs,
-		       xprt->num_reqs, xprt->binding.qlen, xprt->sending.qlen,
-		       xprt->pending.qlen, xprt->backlog.qlen, xprt->main);
+		       "backlog_q_len=%u\nmain_xprt=%d\nsrc_port=%u\n",
+		       xprt->last_used, xprt->cong, xprt->cwnd, xprt->max_reqs,
+		       xprt->min_reqs, xprt->num_reqs, xprt->binding.qlen,
+		       xprt->sending.qlen, xprt->pending.qlen,
+		       xprt->backlog.qlen, xprt->main,
+		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
+		       get_srcport(xprt) : 0);
 	xprt_put(xprt);
 	return ret + 1;
 }
-- 
2.27.0

