Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1C3FB981
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhH3P6F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbhH3P57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E13C06179A
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id eh1so8529269qvb.11
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+XWwc8WLAi42CxnfebvJJpuOJJi6MzDVmVeD37GxZc=;
        b=F7wptt09vxRVT4EUcKx7YqpM5G7OphNG5Nyy2+5czl1CYptX9q2fcrV8++0BlwqSU5
         iclYIMikXRBWOkQL5oRh6zgpBdXoHBCdxSlACMw1iQcay7WnyhvUpnxqzbFyRYyQMT3m
         4gnNjEbRaAaVudFHBRBjFcDd8/efR8HLWi1pyUU4ihy/kTRce3Dgy65h7iqd5QVyXo3G
         JzcdU4yjWk7bOSX7oLwKYKxeqo8Kg2LaZJQ++n6teir5APX/Wfbf+FDz+VRyZUdIF0Og
         A0uaHDC0Faq+Ia4zj3yS57W5Lo05RDvEAnts49MsqRs+LrSTF4VJdaYWZrLzJhqNxmVb
         QtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=E+XWwc8WLAi42CxnfebvJJpuOJJi6MzDVmVeD37GxZc=;
        b=XVkVOwGva4gJKovOkmmyHNywuMKCz4+F5X9P+JukkYFnvK5JT4Uwfc0SnDhsZXnYel
         PvQy6Zrs8lrGZuE5pN92aLl7j0EXtNKe32cKC2xA2Ip8YRn5VXimz2YI45wOSvRkxeuc
         vDdtTMbprYhLRGElvYrNMjWXcbmC/EYafWGXiQXGMVVoQinRExwaq09SmWIPJOM+T28I
         Hf0WGLIf6zSEOVO0Dga/olTyzMz2R5NsgjrC0dt/j8CRzZXDu5VGcc483PMMj3IJQGwk
         QIAyw7LiSygUhBcioK8UiFQzwDCkE3qEFL/hS25PHLEh0uS57yAkqS65rJrs6zO35c0F
         C52Q==
X-Gm-Message-State: AOAM5333oW/MAonwl5hTPnOqyWUW5rauW0DTcGa+itqkfImQCitYeQ8q
        jqonDgkmQbrSAzasbfwEvpE=
X-Google-Smtp-Source: ABdhPJyX8XUEHloNIzeaHv2Jo4OGWx20sZOUygGxLizHEuuz/USncgtwH7bm/Bk3rSHAaq2aKnRb/g==
X-Received: by 2002:a0c:e412:: with SMTP id o18mr21462680qvl.57.1630339021978;
        Mon, 30 Aug 2021 08:57:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:57:01 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 6/9] nfssysfs.py: Add a command for changing xprt-switch dstaddrs
Date:   Mon, 30 Aug 2021 11:56:50 -0400
Message-Id: <20210830155653.1386161-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
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
 tools/nfssysfs/switch.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/nfssysfs/switch.py b/tools/nfssysfs/switch.py
index 5384f970235c..859b82e07895 100644
--- a/tools/nfssysfs/switch.py
+++ b/tools/nfssysfs/switch.py
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
2.33.0

