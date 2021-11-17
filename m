Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59545472E
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhKQN3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 08:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhKQN3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 08:29:51 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D6C061570
        for <linux-nfs@vger.kernel.org>; Wed, 17 Nov 2021 05:26:53 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id v3so5828774uam.10
        for <linux-nfs@vger.kernel.org>; Wed, 17 Nov 2021 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5k/V/teU0Ac3V1/A8++bZwANsI1vtmhkwvwa8IFoab4=;
        b=WPpE4M4ZxG8Yxxe7Ad9XndAVoXg5ZlYs3303+V55Hsj1anmkOwmZ24UD7FdhhElzSJ
         dQkJR2TJvGblNzQ/nh+xlsfO2xevHJLAhqxTz7togUgkulRgt6QVIHOfVhEvvuebkih4
         o4rIHlaueBAQYNKdXjbXx+LeMfu/Hb/rn8Fi5u2nHU4snH74Izf1VXJ93NiSTivIj1Ex
         G/jYUU9Hl+2sIR2DewH+kW9E4C2+afe/yTRaP9tYzXBnGg6LaJsIrB3GCUNttsWBa90v
         rRZ0m2juEvGdSjTf+onWmb95XLj5ZSAp5HhpjQBF8a5hyZUBvczF0UooytuXZNnJOGzF
         GXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5k/V/teU0Ac3V1/A8++bZwANsI1vtmhkwvwa8IFoab4=;
        b=ss+LuvVkRxIkKzjXq/MGBMDcI9Y0n+tnYwGiL3C3qh0GZk04hiSgyfue94knCQgeyJ
         WEMd5oPRjDkrsJNz3bbPtQT9vUlWz92SE8uwHNPH5eGBrR6R4fiV8PfWaHxWDMZNKsf2
         1OwklISYOH93Ay+ktTYUVFLnuWZZ6GxezvPkDUGtaDScXLcFz11taCSFOM5GtuZICHcB
         JpDKkwC8T+2R8X65dafzE83vF1UFB8UwcTjaJIYiQvpYDhN3Y8/hEFgyLwnBBMYTqcg/
         gH6T8GGRqSX1gSB5SSFy17Tnwm3+vCOmQWbzlZ1q+olMLiX3sgJXYgB70C6N1dS0seLx
         0sFg==
X-Gm-Message-State: AOAM5323vqAl1ebVpfzjpnSw1KVRAAQ3iN2UOkihyBuP1l1vid05qaQ1
        bG7//EXW5jPcFVuVKNjDMO26aUNRgMA=
X-Google-Smtp-Source: ABdhPJzTfpXn3T6mH4KXQMScZ8Xk6E6OOtycHhPL54/sy4zS3E8AFNVBMk8RC+/7hE4PrpBsD9r4tA==
X-Received: by 2002:a67:e44e:: with SMTP id n14mr66843044vsm.55.1637155611960;
        Wed, 17 Nov 2021 05:26:51 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.244.167])
        by smtp.gmail.com with ESMTPSA id r2sm10327012vsk.28.2021.11.17.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 05:26:51 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [PATCH] sunrpc: fix header include guard in trace header
Date:   Wed, 17 Nov 2021 10:26:30 -0300
Message-Id: <20211117132630.2837733-1-trbecker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpcgss.h include protection was protecting against the define for
rpcrdma.h.

Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 include/trace/events/rpcgss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 3ba63319af3c..c9048f3e471b 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -8,7 +8,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM rpcgss
 
-#if !defined(_TRACE_RPCRDMA_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_TRACE_RPCGSS_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_RPCGSS_H
 
 #include <linux/tracepoint.h>
-- 
2.31.1

