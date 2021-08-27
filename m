Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE993F9EEF
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhH0SiU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhH0SiU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:38:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4BEC061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:31 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p4so1884613qki.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8C+GGrkuHZuCFx+eMpPXA1G1r6jwtJtqK4jsR12uQk=;
        b=I4nE/ZBna7h4ebX6cNdZuklk/98bivnaPxFVgn3gm/9hUwIKB9/AqwKEPjC8tVaFs+
         1+q7ujyw2U2JHBfih5NGA0hP5r2lJkWAdy1AHq/FZ5M78LgcxqVYnJj0GKAIvPDjVv6B
         DBMXfAa2SfCXSyDLZvcXReuImdreHjR8acOXT23f/RwX1e7GobvmhFBSvHEKGQVTCb1J
         KHczTWv8WjFXYCAMQzsE/5x4pxHDfREpId6RIFmFxQYOabc02y6A1ntT/7C2kZQoLoHG
         5Qy/YlkSGiir3X0cQpyIqGUBcp8RaRnlSMpwLxDqL7WBPr6+Rx8Pqd3gkTlOZjiPDPHF
         ijUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8C+GGrkuHZuCFx+eMpPXA1G1r6jwtJtqK4jsR12uQk=;
        b=CRc2gVDSfsUqFFOvOCW9fKwnoFCumFw5XBfUpu3iEkoC9VnZtmg//5eyxGijZqh0xm
         PeJOaA2E8zZkq0LA9whT91d1cW4h0gw3ShY2xQ4gx3cdw0v/XeBdJ032GvWnjfWPg1k/
         C3nnjuai+0TRusQ4YXeaJ/YIg9PkiA8hzK+uDB0aeMLf31begUCPM2jJva8+Y0Q5Ippd
         k3tRX0KQksJ6cIZjLSApWNXzBBKFoWNS26rbr6/9b+EwxlOMZJbwdKyX+Scev1BbJVcN
         cWgcA0RdTEYP3OKuojt8LUJ6zLRupsXj3xdG16HHnRLRz2Z94Jvcj9s62q2wlxHtYL+j
         0o2g==
X-Gm-Message-State: AOAM531LbyAysFj+KTTnNlzz6zF8z1uj4e0NV6fvCgH9nOVem18+qWKi
        82w2kazjNhZ4A1kBvSZyakoONWYyJ0coSA==
X-Google-Smtp-Source: ABdhPJwJILEeZHfaWa9zWATyxn9EhlrkoorNz6Dijp/QlIJJ7xtZ35RQDEg/zj2AJ7+ro/iJqnX3nw==
X-Received: by 2002:a37:8243:: with SMTP id e64mr10542985qkd.89.1630089450302;
        Fri, 27 Aug 2021 11:37:30 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b143:41d3:e2f6:337b])
        by smtp.gmail.com with ESMTPSA id bl36sm5207463qkb.37.2021.08.27.11.37.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:37:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 2/5] SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
Date:   Fri, 27 Aug 2021 14:37:16 -0400
Message-Id: <20210827183719.41057-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
References: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In sysfs's xprt_switch_info attribute also display the value of
number of transports with unique destination addresses for this
xprt_switch.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 414c664a3199..9a6f17e18f73 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -207,8 +207,10 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 
 	if (!xprt_switch)
 		return 0;
-	ret = sprintf(buf, "num_xprts=%u\nnum_active=%u\nqueue_len=%ld\n",
+	ret = sprintf(buf, "num_xprts=%u\nnum_active=%u\n"
+		      "num_unique_destaddr=%u\nqueue_len=%ld\n",
 		      xprt_switch->xps_nxprts, xprt_switch->xps_nactive,
+		      xprt_switch->xps_nunique_destaddr_xprts,
 		      atomic_long_read(&xprt_switch->xps_queuelen));
 	xprt_switch_put(xprt_switch);
 	return ret + 1;
-- 
2.27.0

