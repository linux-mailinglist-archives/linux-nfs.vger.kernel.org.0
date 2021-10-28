Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9E43E862
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhJ1Sh4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhJ1Shz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B9C061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:28 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s1so5291406qta.13
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BoJQS8T5pA3TgBjObqAge0sFAZ3k/4sBTrxF1sXiu+o=;
        b=Q7UiyARzm6hIZ2Q1nhY26CAc/oE4RklMNzU39Epvl8+WSyK8gS97TdnDO3GX7qrwez
         9VMrPSxys2pQHReARYr9jWPxnjCUaG4qZ+RUsPHgcF9HkPZPlwRA3dYoro9aFV/BpPHR
         mP1pgUl8gjctOMcT3lw7BRb0wvPmHZQdv5PQc/G7tegf8LPwozv9hBBdwabXBA9+RsKm
         xiZ49p1MYFaaCeRUvDwo5JM4Yl/vjy5FZEDikF/JuZvTHr5TNf1u3qwJtZf4CXYge1/y
         hjL9fOgovmKSaxq/mkE8MtRPPmg/Fj8kCirjokkL6Oo+5GH0sUGwFmhKOrKDoLKaYAzi
         QBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BoJQS8T5pA3TgBjObqAge0sFAZ3k/4sBTrxF1sXiu+o=;
        b=xHzb3Ec+lkz7u3MYhRtWUQW1F1RxLzwv1c8q0Jnsu8Jh1sFDhuOGh3Vdyja7R7/tZ9
         HcW4KwRKNckmPxbwsRg7gvTow/SaP9NhvADOUdVR5nrIeyMh1zDdZYTfhMeR6a5MRum4
         L9AgaHBeSFTb+jQRKWvv8RB79M0QKqlR8oKSTRmpEFCjQmaL4nrhGmvgG/1GTTj1jgyB
         LkMbj3xxcQkyBkZX1PCPaJR4plM/q+axuu/u3SZk7mOmrDl950jpVkfcQxFHr+6CCFfo
         bv8zWclRjXul979bEL0p9OvjGsYPOp7zTZrh46BDkBCTSB4laX+5qJNKwGj4PeXEcSBD
         ubUQ==
X-Gm-Message-State: AOAM532tmFd0BX/rbCZ+NSDKAPj22q6PH0qjliWU84P/HWqDehjD2YgB
        9EQ8ZFxbY3dJacd1LpKhitE5UooSkuc=
X-Google-Smtp-Source: ABdhPJxFXjLf74G3XY5cS5EYeQvIV6+6UXMq3VTIGRLWgjuBKRhUKrkvZhFUZMhoAPfrTAegIjY+dA==
X-Received: by 2002:ac8:7f8c:: with SMTP id z12mr6581937qtj.292.1635446127264;
        Thu, 28 Oct 2021 11:35:27 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:26 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 6/9] rpcctl: Add a command for changing xprt switch dstaddrs
Date:   Thu, 28 Oct 2021 14:35:16 -0400
Message-Id: <20211028183519.160772-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcctl/switch.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/rpcctl/switch.py b/tools/rpcctl/switch.py
index 497ee8b1923c..b1b287bb6578 100644
--- a/tools/rpcctl/switch.py
+++ b/tools/rpcctl/switch.py
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
     parser = subparser.add_parser("switch", help="Commands for xprt switches")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
     parser.set_defaults(func=list_xprt_switches)
+
+    subparser = parser.add_subparsers()
+    parser = subparser.add_parser("set", help="Set an xprt switch property")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of an xprt-switch to modify")
+    parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.set_defaults(func=set_xprt_switch_property)
-- 
2.33.1

