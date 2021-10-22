Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A3437FB0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhJVU6b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJVU6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA1C061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 77so5836980qkh.6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Pg9Cg2bw610qpt+ZbBxtZuR3ZaWjfMwreSmpnGnoeQ=;
        b=aA9xTKZ/7/cxiafImaXsr8tqHgnnI1PqCBN0okYAndp0GTaNqR4Nx1lju127DGnTgQ
         hHFBeHHATAc/CbriA776qUVUGwZknkuMMSVRZw/D0n98pY225/6nk8DLnv9wNsNBPT35
         DWemhuuP/kEm9wGvKtkm+NHx0gseqVermoKO+Gc7V0sqmu0jGPa4EO42SPkBmcJaA/nw
         3sAhopDlTk6udyW97dHL4OddDayeHngmffy/Uwb3MegqiV0mRAIwQBlkRlLKfR/Ekucm
         6ZVMqCViuUpdzUmm6HFh9SwK9D6PVFyS8GyKtP7add2+Omm5P+h+0AYadxkuoNWsQ3xL
         exYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/Pg9Cg2bw610qpt+ZbBxtZuR3ZaWjfMwreSmpnGnoeQ=;
        b=ltBYw5UFfuOfluiWlJzhy6K8aj3+H2r5TevKLAq3PpEAlfEYqNRhcZI3tTC0h8AyvX
         DH4VY7524z5QMI0W6ne4N7G4d0IWQP2Na7rLYxSSGNY5Rb0vbv3rIqbPkxrV5Ssp2aZb
         63rKyhiBndlZNg9MZ89N82n/unmGqtQwphoc0ioXLplGzy9HPe62CF77s4MLLUHen3TS
         TvtQmCXIUS/ZgRvG/ahE7jqbzPkWErviZqUTP+/HfhF3QC7iNyvrZzmxnD+kdcRN4xX7
         zuHyAurjkMI6O3k8rpqO8zmLXEog5Qb4OzaK523qvqPnZgj5k4nvelbzgSSt+RIPW2iJ
         2XyA==
X-Gm-Message-State: AOAM530koQh5pjxDjoYUxM1hT7smV4pGoGP4Hrpn2dX4N382Ke6at0D+
        eZM3RvGCCr6CkPA3faXAXKk=
X-Google-Smtp-Source: ABdhPJyz617DeMXAHFR9VcmYWsu5MjAkF8u1Im0Yspqkz1SvWH9cYEydYfBL/5COVI/I6N3wH1fkqg==
X-Received: by 2002:a37:9f0e:: with SMTP id i14mr2099722qke.21.1634936171763;
        Fri, 22 Oct 2021 13:56:11 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:11 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 6/9] rpcsys: Add a command for changing xprt-switch dstaddrs
Date:   Fri, 22 Oct 2021 16:56:03 -0400
Message-Id: <20211022205606.66392-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcsys/switch.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/rpcsys/switch.py b/tools/rpcsys/switch.py
index 5384f970235c..859b82e07895 100644
--- a/tools/rpcsys/switch.py
+++ b/tools/rpcsys/switch.py
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
2.33.1

