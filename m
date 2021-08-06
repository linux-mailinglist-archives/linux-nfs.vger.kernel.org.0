Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966093E303D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbhHFUSF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbhHFUSE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B28EC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t66so11290806qkb.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3qsx1hJN4Ap0lnfTXiXGiNo7EkyOjgXvMFg3+Yut7o=;
        b=cvN0fR4RfgqFi2oYUah1IS0LBYBbiwxNVj9g4OfVsrsEQPnCrJxUpvbhwA04a7gL74
         RasgSIbCu8Vhq6ZK9bCCcsDPUkFYEQ+kRfLEr9JfOoOdAzIWMH3E20nOX0+s0TebP4O6
         wcDMarYsXT0NT21EMQGAI1KdNy8eZ/hVGP0yEXGXsOTBaA0xY8XFUwu+w40nU36lXo6a
         7i9jPaQ4OTH0OezsT4zNaiqgGUS2Kfw9EuqDsfcX62rwTgTLWUHe02b/hpWzGNzmZbij
         0UalrZTE3itJXe8X3o7wEk9U1yc03mDPON+rjRpcsfVBEf44+k67qMIAv5d3DwDuABon
         tJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l3qsx1hJN4Ap0lnfTXiXGiNo7EkyOjgXvMFg3+Yut7o=;
        b=WXehw+k+S0a4ivM43wdaP6Ig5DCAjFPvigyfEgRipRZDM5MDR0dZi12a87NJ1bIf9P
         t2WS/xLsm5kVrs9sJnu6TdaJF/cPVB95nv/3Zhz66VkC53uIj39We2atHwspBs1nRTbn
         itxn+8OsArOtLzPF/+ZD57pOtVwCyaGe+WI5xIuUH/E17Jn2FdYRuFaaUHX4LDsa4moY
         8s7/vUThJDHQ/Qptq+/ZXdpawHYneLdw2d64VLiZfqgcGL3/4v7hEBz6hRTL4eorAOwG
         c9whR5umQYTtRiS1TLMXLGkSE0U34So3C1URJ3qWzhj5fAdSVk3HRFC6MHtagX6tQMGb
         RHeA==
X-Gm-Message-State: AOAM530XllqMnfRibqMZucF+keCMBQHtEFfGF+FhoWVHBKo3m3oj7WWp
        6c30xuPwOQcpR0xLCIdNVZA=
X-Google-Smtp-Source: ABdhPJwltkz55iS8UgPc43CLqY6vdyRJfSzdtkEaMJXLEYAiKj0KSccP6K8/jSJGwSTm/ofjhX2qsQ==
X-Received: by 2002:a05:620a:b1b:: with SMTP id t27mr11768441qkg.460.1628281067225;
        Fri, 06 Aug 2021 13:17:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:46 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 6/9] nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
Date:   Fri,  6 Aug 2021 16:17:36 -0400
Message-Id: <20210806201739.472806-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is basically the same as for xprts, but it iterates through all
xprts attached to the switch to apply the new address.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/switch.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/nfs-sysfs/switch.py b/tools/nfs-sysfs/switch.py
index 5384f970235c..859b82e07895 100644
--- a/tools/nfs-sysfs/switch.py
+++ b/tools/nfs-sysfs/switch.py
@@ -30,7 +30,22 @@ def list_xprt_switches(args):
         if args.id == None or xs.id == args.id[0]:
             print(xs)
 
+def set_xprt_switch_property(args):
+    switch = XprtSwitch(sysfs.SUNRPC / "xprt-switches" / f"switch-{args.id[0]}")
+    try:
+        for xprt in switch.xprts:
+            xprt.set_dstaddr(args.dstaddr[0])
+        print(switch)
+    except Exception as e:
+        print(e)
+
 def add_command(subparser):
     parser = subparser.add_parser("xprt-switch", help="Commands for xprt switches")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
     parser.set_defaults(func=list_xprt_switches)
+
+    subparser = parser.add_subparsers()
+    parser = subparser.add_parser("set", help="Set an xprt switch property")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of an xprt-switch to modify")
+    parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.set_defaults(func=set_xprt_switch_property)
-- 
2.32.0

