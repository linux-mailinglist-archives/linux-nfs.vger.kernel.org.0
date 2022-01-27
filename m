Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76649EB56
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbiA0Tt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiA0Tt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:59 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B72C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:59 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d8so3840979qvv.2
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l160xsQI888sYJ8Bl6uSXpCWja2VhcgNs1mAzMKSkGE=;
        b=UmNjKF896iRoEj61qhuGlK6ZfLYXMcsuN+ANLSA/eWn7Ajhm5GDG4WA1/oqYWjF5XA
         cQY0vjW56wrlF3nNaspCuatCQtZA2WWST5/wTWRe+o7/zl6rK6/aEjnO0sBikwVy9gp9
         yEAlgXuCg1TG8ZzXuAmrP96JTK1mCj8SjgAf/zTZQHwbLFhyLKWzRNtMgs487QyVeyp+
         D7YPYOMFoT909qXPsTMhHeW7t5qRsn7f3MtTfsEnr3aY74RZpfRYUg9RbkZnhQGZ+npd
         OtXsxPxdMU6tJ7doB+0nRwmf1C10D5jQyH8rHz4IX/GWTmKhXx1yocbXTBw1nwaYSDZN
         zSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l160xsQI888sYJ8Bl6uSXpCWja2VhcgNs1mAzMKSkGE=;
        b=0WUG1J9/TILYHYXnwfZ0pvYTNenUOMPtN3esOcJPOBSJba09+AiQDP8vla7i4HDyrL
         caauZGHY3oGnfwHJkdAKZz1zFRMZGfmha+6tU8cQkpXVmskICjsVbdmwuiB/lh7DNAJO
         YY0DlezFRJilTeJrVFvOSpJBatY3bAcctktZ5fO5QL3v5t5WrGlyA/cIKht/Co1qoK86
         t+XciSgFxSu3B0MGBkWBG9By5pbFO06x9YMMgZN90c41+KTFc1XGzJcKWYylkPgWIEKw
         vNRmRcfn25vJLVt6xrZoWx9l6KT9rv+2qLY157TAVQ4xYmgxFWA/EqvDXQ2y1HGt3mP5
         xHgA==
X-Gm-Message-State: AOAM532B2ZXYSsItDqwYne8wrnExJsFzuA8aH6h8qFPSv0QeCIxs9jmd
        YNGKej/laZbgNAHE/tIgVag=
X-Google-Smtp-Source: ABdhPJx/HnSm5wdH1Gk3YarcgIfb+vjzvjzvj9HMdSzDyqCEU7dFr/Dn0cntOC9q/j4t2emPU62aEA==
X-Received: by 2002:a05:6214:20e7:: with SMTP id 7mr4383694qvk.43.1643312998273;
        Thu, 27 Jan 2022 11:49:58 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:57 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 6/9] rpcctl: Add a command for changing xprt switch dstaddrs
Date:   Thu, 27 Jan 2022 14:49:49 -0500
Message-Id: <20220127194952.63033-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcctl/rpcctl.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index c481f96333f9..9404b975e33d 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -143,6 +143,12 @@ class XprtSwitch:
         parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
         parser.set_defaults(func=XprtSwitch.list_all)
 
+        subparser = parser.add_subparsers()
+        parser = subparser.add_parser("set", help="Set an xprt switch property")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of an xprt-switch to modify")
+        parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+        parser.set_defaults(func=XprtSwitch.set_property)
+
     def list_all(args):
         switches = [ XprtSwitch(f) for f in (sunrpc / "xprt-switches").iterdir() ]
         switches.sort()
@@ -150,6 +156,16 @@ class XprtSwitch:
             if args.id == None or xs.id == args.id[0]:
                 print(xs)
 
+    def set_property(args):
+        switch = XprtSwitch(sunrpc / "xprt-switches" / f"switch-{args.id[0]}")
+        try:
+            for xprt in switch.xprts:
+                if args.dstaddr != None:
+                    xprt.set_dstaddr(args.dstaddr[0])
+            print(switch)
+        except Exception as e:
+            print(e)
+
 
 class RpcClient:
     def __init__(self, path):
-- 
2.35.0

