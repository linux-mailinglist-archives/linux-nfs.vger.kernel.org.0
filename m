Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9306839FE1A
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFHRtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhFHRtO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:49:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEDC061789
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 10:47:04 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c124so21025423qkd.8
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3qsx1hJN4Ap0lnfTXiXGiNo7EkyOjgXvMFg3+Yut7o=;
        b=F0ruDejcrs5RFshNAjQFktssQ80D+Sac0aTt88+eXaTQ08EL6jQirlNbcs4IXqkMSd
         mP+KUidnpAqu/lXhnSX+ue74w4bK2ypF+v3WZEkXyUg3BekgHuOvitEthOd0shbUYaLi
         +PgC289lZsB8UMZISo9oRR8lhoQqcNDk/+kpeXvSzQLm5KWqoEig+X5tmTAvsehEaBIh
         LlABj/7w9+bTYhP4RzJCuHGwP9fqqMVNvN36kC7hyHJjf0ZsJPQCeUB7rehooHLESEz1
         Li/QtGMmKbQRdEbdW+J7etE0Uan7/20jbtK/lSB0XilesPuE64MbrrGfCw8zTHjhCnd1
         BMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l3qsx1hJN4Ap0lnfTXiXGiNo7EkyOjgXvMFg3+Yut7o=;
        b=OjVrPutDO4hu6Hc+v1cllPnHRsm4c3MYl+CvdOlEyqrypFdar08pGSo0kITH9HAQri
         N4AordmV0h3hTypzdUs66PMOcLLAjRe5+WHUQiv9qJSiqrPSEWmw5k+/duL1ESB3cHwf
         5YzCS9iPWr3E1m5IBobC3NWbXZBVu8eTUVrwznqHOLvXlgUQYoFN0lwC+q0gH4GZP0SE
         cpf1vJft7Ssdf1OwRC5MLhGAUAaQLVRtPa0FvhvQWd2osAiBHDqmsRTo/M0Yr79IeOCK
         rdQiQXy3CQNJ0KbeUW3agNj0xgNfrMWnFwCOg2YpUrsAzEp6XJCknD2nLEGryN9O+uQ/
         sB+g==
X-Gm-Message-State: AOAM531vqFIL1I2MRoiVRIU6O+uaE/F3s/NWuk5VDWOxZjL9mj98sMm8
        YH6HbxDVdNLG7+dGuXTmlYCsftLRt40=
X-Google-Smtp-Source: ABdhPJwCqUDdpg+7gUnL/ZS/eXl/FXcuYLnuibXEJAuVJPEjM/vEOFV6TIkrsGWk54tv1pbHA1Qg/Q==
X-Received: by 2002:a05:620a:20d7:: with SMTP id f23mr22138037qka.484.1623174423786;
        Tue, 08 Jun 2021 10:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:47:03 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 6/6] nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
Date:   Tue,  8 Jun 2021 13:46:57 -0400
Message-Id: <20210608174657.603256-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
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

