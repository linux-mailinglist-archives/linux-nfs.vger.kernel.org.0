Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA106281C18
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgJBTd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTd5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 15:33:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BAC0613D0
        for <linux-nfs@vger.kernel.org>; Fri,  2 Oct 2020 12:33:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so2967836wrw.11
        for <linux-nfs@vger.kernel.org>; Fri, 02 Oct 2020 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iksoBoH+3pzvXPCLx1TL5IJgj6hyPQZIk0NOriAFycU=;
        b=XsircElnlp498Mtoj1OEx59eX01es418Gupi/Tksk7JogbpzTfL0EYUsvS+HIUlXyt
         vQMPVuIYV/90mE5GsXPyz3uunNVuufEN6hG7LAxkHpDNxoT41vCRf58o0J7H0D1EFjqt
         AOtUFSUKISXUuI6tML4mbAeITZXgUJQTozgJElxP/uCibKv+zZTPF8QSulBvm9wU7MPZ
         APmmgCQqyaZ/VNyDWFqj+Hso6I/YCDeXJLvJiUy2/HrNGxH8j+8Sa+2raW15LyF0kwKz
         cRawEyhivBnM9B0b3agmO8O2VIh/5bPmM4CpsrtD2KHg+HWQLhHZSMftcx0dpEOK353Z
         zKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iksoBoH+3pzvXPCLx1TL5IJgj6hyPQZIk0NOriAFycU=;
        b=nSvgoYwW2Tb68YTGsPcDzYc05P5T2RAa4zy00+znZ/f72b60znKDyja4Xx5CMqyY9d
         OD8K+uk0FEwB8D6lZXanV7h5Ws4H58J/L7jF07iTtg4bkrjW2+9LaoVYTq/3TUosNOP0
         zu2WQ8pa/HbgaCJuYrYJu7NOStE/beEiFF5wN77Ys65dkHXnL/fwKoj7iLfbgPsyTfzG
         PEtCia5JcNacLj9Lc7MMVRw+ktZV3KpqemuQlygiF8oOClvqavXkhwKlLG/o6/B0lWa2
         HrCT78+9y9glUgK+JtrP9MUVl7nR9P1ftY/2WI516tY1qkiFy5St6HwHOaXMIXb/ntzO
         0Eiw==
X-Gm-Message-State: AOAM532JkeJLq7WW1S/ui/8B2EPvFKhpvnB32G31EgdQy+OG2QPyCDLS
        TS9r3QxcYg2dWLBOclIPLjkMMw==
X-Google-Smtp-Source: ABdhPJxcvfHwEA0XU2grgSurc1Aqrf5Pb46g0CdAcx4vRdIkDaF4RPTm882RuvnFZBG2BhqWGD/qGA==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr4530366wrh.192.1601667234557;
        Fri, 02 Oct 2020 12:33:54 -0700 (PDT)
Received: from jupiter.home.aloni.org ([77.126.36.146])
        by smtp.gmail.com with ESMTPSA id i16sm2857039wrq.73.2020.10.02.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:33:53 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2] svcrdma: fix bounce buffers for unaligned offsets and multiple pages
Date:   Fri,  2 Oct 2020 22:33:43 +0300
Message-Id: <20201002193343.1040351-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <58FBC94E-3F7D-4C23-A720-6588B0B22E86@oracle.com>
References: <58FBC94E-3F7D-4C23-A720-6588B0B22E86@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This was discovered using O_DIRECT at the client side, with small
unaligned file offsets or IOs that span multiple file pages.

Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Extended testing found another issue with the loop.

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 7b94d971feb3..c3d588b149aa 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -638,10 +638,11 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 		while (remaining) {
 			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
 
-			memcpy(dst, page_address(*ppages), len);
+			memcpy(dst, page_address(*ppages) + pageoff, len);
 			remaining -= len;
 			dst += len;
 			pageoff = 0;
+			ppages++;
 		}
 	}
 
-- 
2.26.2

