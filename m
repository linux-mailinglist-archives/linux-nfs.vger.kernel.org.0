Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B986E3F7CC7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Aug 2021 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhHYTeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Aug 2021 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhHYTeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Aug 2021 15:34:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144AEC061757
        for <linux-nfs@vger.kernel.org>; Wed, 25 Aug 2021 12:33:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 22so683308qkg.2
        for <linux-nfs@vger.kernel.org>; Wed, 25 Aug 2021 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGRdScP2/d6q5GM9NvlfAHaV5L6B1/YxATiLceTD3K4=;
        b=fCIDCqwoVOJ7+txZa2P2DF5YTlA7KMWAF4+nsExYL7aNRQfCAdtGrrgzq8pgQhjLLZ
         IsuTrinGclRdMBr1BlMVDtvsvEYDi6ABIy/1H43TRvE3fUmn1LGRh048dHdP4If2Yq6l
         CLFQCl3JWUwpBwv2yTf26buWLv10RQ+Y9seU9al6S3QbzSVbRJE++TzvYSdOTBFJJULW
         UvgNk7K0NkeFVnQSOM9giPY4k1ws30y2njGDcFoQ56hjLlin6jWJqh+SzUbmMoY0ZZDf
         Gm0CAqYUxo+pHAK0OCbdWy+W7na/46QzKL0EVnN89qaNj5sL0wKo2BpJLRKZ1VEX6teo
         /v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGRdScP2/d6q5GM9NvlfAHaV5L6B1/YxATiLceTD3K4=;
        b=UAMA1y2Up4kWqyDMR2lcuppjAHmD/5+6d8KMklb/FU0/pV5qoFrEVmgePG9P8bAF41
         3GADfqTbYFX0gMzet6gJLCT0qMTgkVrVBEoSdZPmFMawTCDxGMsJnkuHvwtgRWrlSO9v
         5RYiL4FZl42M/tyC5SHhSAFlYtyMBoGNrSFDbYPGJTatpKw/f4IympnOTDn50vkg0t22
         +ovcavPLPf4RrtrN6dn2TpFru3vDZUSFGf5xswklQrS0dg6N99rJt8AaeqsRamGuBL/H
         RttScBwKgBBqmnKGGju4UPwqrA1bcAEjHB03nwMTaM/WjE34WQ5gnfThFa8l8CbMuop3
         asog==
X-Gm-Message-State: AOAM530dt+sZKfwEKHopqoCG4TNBhum/m1QkekAaaevaAaIYEzaClCdM
        400dtBZgOaUax4wZj1Gqvg==
X-Google-Smtp-Source: ABdhPJwQ8Tu/OohbKHWjZFIvKCuFW5EjFFjBQi0QNn58FR9YHlWVX5p1GDXRuqq/JnkQXvj1iuJW2A==
X-Received: by 2002:a05:620a:56e:: with SMTP id p14mr168092qkp.126.1629919996096;
        Wed, 25 Aug 2021 12:33:16 -0700 (PDT)
Received: from leira.hammer.space (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id i18sm683111qke.103.2021.08.25.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 12:33:15 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J.Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix XPT_BUSY flag leakage in svc_handle_xprt()...
Date:   Wed, 25 Aug 2021 15:33:14 -0400
Message-Id: <20210825193314.354079-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the attempt to reserve a slot fails, we currently leak the XPT_BUSY
flag on the socket. Among other things, this make it impossible to close
the socket.

Fixes: 82011c80b3ec ("SUNRPC: Move svc_xprt_received() call sites")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/svc_xprt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5f0d33ca4bdb..b3cff4077899 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -975,7 +975,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		rqstp->rq_stime = ktime_get();
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
-	}
+	} else
+		svc_xprt_received(xprt);
 out:
 	trace_svc_handle_xprt(xprt, len);
 	return len;
-- 
2.31.1

