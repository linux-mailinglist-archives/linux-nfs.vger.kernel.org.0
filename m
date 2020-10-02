Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3260E2815A3
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 16:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgJBOsj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387984AbgJBOsi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 10:48:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38591C0613E2
        for <linux-nfs@vger.kernel.org>; Fri,  2 Oct 2020 07:48:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so2148347wrv.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Oct 2020 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX2FxwIrrPXuM/u/Qno1EBAL0lJUlKuwL4H9trYkJ/w=;
        b=HMPEBDcnI+9aYkikeCqm4WkYHBElYJ5zwTB0TckPg4CxxKwJRurWPrPVxKM1CTnpmK
         0NB6r5SoYtO7ajWvCGnWfNS5/Vvgvd8Xtaa00+vTfKA9oZrKFInednpFmxFEjiL3o3OI
         p2bH3MPW/URATFK4WLEezkO3+3tpL4Zh2HKbyoiGZhUrBqBzJABQdgRqq14rzntFbT0K
         Mr+girQtXk5DtiF71ivjiLrFD8C9HpIDil/hrpoaoJlGJDtH/C9Nysv/nquKbs14oy8+
         6Rqf/cvzb0FEZHn4tA/3PIOB729qXe3ruyBIN6TfK/8ICwnjj2zAc4eQxP2jq0AMEza0
         m5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX2FxwIrrPXuM/u/Qno1EBAL0lJUlKuwL4H9trYkJ/w=;
        b=Jr/a4Honry+iFD1qgZp8cTm9Mizg1I9+hpAl96LsmU3VIOSRzjlwwVA7Fa6TP3hTRU
         /uAdXIJnkXTj8ODTQ0W7oVhnPqtD4zIvXU+4tWamu5q61x4AU0ivmziT7tNe7mKjixgy
         vuqaZs1JwLNihGQDpAJM+TeeapvVhV8L21xTKnuX8mBk1s4J4v3HpFbIMN2nCgXQ9JdN
         5keCcUkcFtQUaHd/6e6AWNZJOC+/2FflzRBoaD153uWzOwXm6mNic6R+a7ucsbl7VEyD
         bPmpzqAITXRuBvuxmvzb+HIBnDpn8PSXsN32HbHz4P5nzan/hSoofRsvPjNamr3yAKif
         kGpQ==
X-Gm-Message-State: AOAM531nICU9j3699W80i4C9tmRa72577gyLdMRB5aceeCKIsi5htkYC
        zhdwaQiOdwK1n1XUb10ZMQ0UMg==
X-Google-Smtp-Source: ABdhPJw/lzcOxwf7ms6eaPAIIiOmvBHSL+VxtZJtGg7Q+xoEvpXH1a4/TvooVucTQOCG60hIfY9EXg==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr3503212wrw.294.1601650115788;
        Fri, 02 Oct 2020 07:48:35 -0700 (PDT)
Received: from jupiter.home.aloni.org ([77.126.105.230])
        by smtp.gmail.com with ESMTPSA id n4sm2001516wrp.61.2020.10.02.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:48:35 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] svcrdma: fix bounce buffers for non-zero page offsets
Date:   Fri,  2 Oct 2020 17:48:27 +0300
Message-Id: <20201002144827.984306-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This was discovered using O_DIRECT and small unaligned file offsets
at the client side.

Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 7b94d971feb3..c991eb1fd4e3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -638,7 +638,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 		while (remaining) {
 			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
 
-			memcpy(dst, page_address(*ppages), len);
+			memcpy(dst, page_address(*ppages) + pageoff, len);
 			remaining -= len;
 			dst += len;
 			pageoff = 0;
-- 
2.26.2

