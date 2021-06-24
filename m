Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC123B2576
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFXDbR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFXDbR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC62BC061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k11so6156489ioa.5
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oa9Vgi1+mE9cwK7RVRVacr6n6EHbCKrO9HpKfsQaeJ8=;
        b=klurHPo09Nq6BBVWMy6MogC7x9jKuQwSaxvOovVosG/E4oA20+kGtRf7I2G1BetZvx
         tEf7O6KhyYTb3f9RkLLSHN0J0fgqdn+Ci4BVP/DqIMJGag0EHcx29/b8S0OESgg6PBvw
         gpMXn0L5zsDbLN2i3pGcymHTP+EFeEGihXFgNY+XVaT/z9V4r3owCHOm8/SiCBL8L0rq
         CDN0ckYzHVcnWVCSsL0ASTpyrJeK38keflsepEbVdY1paYq4cAIfhG5ak/9gYvIkJKN4
         gxhz8h7bDVwUdlcejaOuPsiWPVU3fFWChf9+V26s5HvodO3I9n3SH7seH5jIRH3JyY/B
         HZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oa9Vgi1+mE9cwK7RVRVacr6n6EHbCKrO9HpKfsQaeJ8=;
        b=i16La65suS/A5C5GFwA8A1tijsXl/NSuHPWG3VHYsmDnP4TLWrYVwpWwDHX1zdhUMF
         HfpiGePQTECwgt7bi8gDD+Z/7lWQ32B7dkI4Ux1xi3rrdlT8zPFFw8eAabRLFfiiTgu2
         8rpI39sh9lJQsAWcax9N0a97FVWPnLMkYl1wwWssBzS+IRlLEkDZd6gvQL8A99gn2UiD
         VqsL8b1d/Op40/4iBbZZBHlab6Ud8+ch4kU45C81MIvkUdBfqvQEWRF+8Xq1zPMhe09H
         u2Jodm5dJj4oUqdYbJkzw2+9tPPxUnC+gXfp6cbEaKIeg739La4cflGXAim/ilIj1s6m
         m94w==
X-Gm-Message-State: AOAM532vrksc5irOBErq1KEQtG7QOj2omGH1R+74L2l0syu+W5XUH50B
        NePUCJ2pzcE8v7E1EDEkQYSConU5SnUPnA==
X-Google-Smtp-Source: ABdhPJweLdCk/0LcgQCF0NAD3PxfliygYkl01VGmlvXjDwevTopf6b8kN0nsCA1IeNIKnJKyNvGntw==
X-Received: by 2002:a6b:7d05:: with SMTP id c5mr2296776ioq.148.1624505338152;
        Wed, 23 Jun 2021 20:28:58 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:28:57 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/8] SUNRPC display xprt's main value in sysfs's xprt_info
Date:   Wed, 23 Jun 2021 23:28:47 -0400
Message-Id: <20210624032853.4776-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Display in sysfs in the information about the xprt if this is a
main transport or not.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 45c0cf18360d..6ef5469fe998 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -103,10 +103,10 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
 		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
-		       "backlog_q_len=%u\n", xprt->last_used, xprt->cong,
-		       xprt->cwnd, xprt->max_reqs, xprt->min_reqs,
+		       "backlog_q_len=%u\nmain_xprt=%d\n", xprt->last_used,
+		       xprt->cong, xprt->cwnd, xprt->max_reqs, xprt->min_reqs,
 		       xprt->num_reqs, xprt->binding.qlen, xprt->sending.qlen,
-		       xprt->pending.qlen, xprt->backlog.qlen);
+		       xprt->pending.qlen, xprt->backlog.qlen, xprt->main);
 	xprt_put(xprt);
 	return ret + 1;
 }
-- 
2.27.0

