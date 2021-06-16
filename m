Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4773A8E18
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhFPBM0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBMZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E342C061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:19 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k9so714134qvu.13
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR6Rd7myvHN8jhZL/Omyls/UlYm1JxgyxUCNaRwcqPM=;
        b=DomzEVfTa4IPgYqQhfxnVKkAZ9hk7bSSuMurr5iWVypr+oCpk6yO9rA1y20Q/zdtu4
         7XYXOea6mTFmqshsfoHh5zxvZS8jpjN7KO7TKDaZ2OJRYH8Lzf/T7JaiwJUuEHJbChmV
         HhLRM7wWp8ott8VsYOjdsu+B8bDSAOAJ9VkekXZX4VDWaIABHLHn8Sx1k4O5Qm67oHp+
         RpU4n3SF3BW453a9/GomgquJL9V4FcRrL/go4jUsiPrQ8BUqf+K51/LvLuefcoJDWZNZ
         ZkLfQO/s+J+nkpM97CjXpCkJWjIE3CaU9IsbX1FagaKO+ikj82fMtmDUTuxmEjpUMUIB
         PGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR6Rd7myvHN8jhZL/Omyls/UlYm1JxgyxUCNaRwcqPM=;
        b=OHfCBp8xALqn9wVUvNm+P83pt/+Nr+FlNc1oFT7IWesaRa9QcF2VgwelM7EJOwGA7O
         q3yxOUriLVqAI881kPHvbYkWRXjywylDVJ6mM6HUSMnypL5fZf115OcW4fkm1gHAwKIX
         a/7sr+QJz/eQMLo89MOwRPnD5UyggdQgwpQOb7RNZ22e+GVcj2qhe6uO+ioXBrTU/CxV
         ibkeXZitVqF/3lUU3bumlcAZ++R7JY58O1oKKwzRH/6SfD8CAiHqmxypC5b360AnZ56s
         VKayfKF6WqObECKNCOozqkvycWls6ke8M7rXHglaQRRahzOrUYDzh+BlhxSJFhBDZ62j
         SdIA==
X-Gm-Message-State: AOAM533Ur6dIM1IOWuPXnNcrFCqkt6fAGtrFTG+NxqeT6STU+Ti2DB0t
        /5JSnQp1RhXD0wAkVyoZAD7KX6SZpuT81A==
X-Google-Smtp-Source: ABdhPJxwkXEt7wOeDwmm2aPfkOB82AWUb8fG2UCUt9VQZ3VnxFS2zKo5srts4Rfx/QBPbLk+vsUgmg==
X-Received: by 2002:ad4:4ae4:: with SMTP id cp4mr8444289qvb.44.1623805818771;
        Tue, 15 Jun 2021 18:10:18 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/6] SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
Date:   Tue, 15 Jun 2021 21:10:09 -0400
Message-Id: <20210616011013.50547-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
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
index 2fbaba27d5c6..45c0cf18360d 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -164,8 +164,10 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 
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

