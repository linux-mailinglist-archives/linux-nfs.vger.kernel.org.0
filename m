Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59649BBC9
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiAYTJw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiAYTJu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:50 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE7C06173D
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:49 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id a7so26214786qvl.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kw5JfT3YUES2j7F/cVOsfLAQzmbaJFRQxrMCwxFTydA=;
        b=BeAY+Kibs1iqu695MqZej4L+vyS2TywF6tc9ZxaV50g/Q8xJqe3BRAVXnJZuWD97Mo
         K91lTUrqHQvZMOj1RTA0TLqFlx/z8468zUvl7s6zy6P274AZq9kGxttdTOdzQ1H/g1fD
         DvMdZKMFPnht5utoKm7IKcL5+Kjnu03nUchfmsoJs8xDnV+8/cawjUwClRFcbqxSAGVl
         ZkdSLXLXWH7n5+p7VqXwsjjk4fDRyW4KeLm9mXNqE+EukRdWBjH0vCbXReUqT3kiLp6q
         B7TP6WcQP6AwHktmnYxHR+j+cjnSXCzvlYJ+TzUEd0D5nG6Ovs8e/4DZJbrvmfapODAK
         EfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kw5JfT3YUES2j7F/cVOsfLAQzmbaJFRQxrMCwxFTydA=;
        b=n1JhE7FRwzZEKpqDXi+ixmjHH6suhtZ00yZ6rNFIRh3Msc2hH+WEiWTBAn2gA3MrlB
         HcoyFMe3zo3a5mpQ0TP5fhOYGpP9VY1oN+XpOcbuqKvLQKfcJM5EkKZ6veV2E4b7nazF
         lZDrtBszgrf0eEvNhMV6G3kr2qPBX/FBgQgy5Rve3xyfqAH/BoJkcUNg9N1lSFbvsRDR
         ufZBHTg8e1khMkcJzYavn3m+VSWlP9XFSR217W21XwFYi2QLdnvdWWu4xBJxj68pdDO/
         cErq1p2rOS1isU3xTh+R70GnNioifZTCTuzrIdzysFj32S2EExsEjQcBLXKM7XFyh04K
         h6KA==
X-Gm-Message-State: AOAM533NaSATCwRgFMbZN9WssdJHflrNTA5F92K+qPx/MoAkUf5e62V7
        iK35psupjaJDyCNVKoYi9sMzP/ePpyw=
X-Google-Smtp-Source: ABdhPJyG6E8ctjbVDuU8iEyUul0KMzZxF73cnAciwAz1XNLea1Nm8nONoAFs9sz1nGpSHmjhNKugHg==
X-Received: by 2002:a05:6214:d02:: with SMTP id 2mr19602215qvh.125.1643137788545;
        Tue, 25 Jan 2022 11:09:48 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:47 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 1/9] rpcctl: Add a rpcctl.py tool
Date:   Tue, 25 Jan 2022 14:09:38 -0500
Message-Id: <20220125190946.23586-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This will be used to print and manipulate the sunrpc sysfs directory
files. Running without arguments prints both usage information and the
location of the sunrpc sysfs directory.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
--
v6: Combine files into a single Python script
---
 tools/rpcctl/rpcctl.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 tools/rpcctl/rpcctl.py

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
new file mode 100755
index 000000000000..9851d2f5f9a6
--- /dev/null
+++ b/tools/rpcctl/rpcctl.py
@@ -0,0 +1,25 @@
+#!/usr/bin/python3
+import argparse
+import pathlib
+import sys
+
+with open("/proc/mounts", 'r') as f:
+    mount = [ line.split()[1] for line in f if line.startswith("sys ") ]
+    if len(mount) == 0:
+        print("ERROR: sysfs is not mounted")
+        sys.exit(1)
+
+sunrpc = pathlib.Path(mount[0]) / "kernel" / "sunrpc"
+if not sunrpc.is_dir():
+    print("ERROR: sysfs does not have sunrpc directory")
+    sys.exit(1)
+
+parser = argparse.ArgumentParser()
+
+def show_small_help(args):
+    parser.print_usage()
+    print("sunrpc dir:", sunrpc)
+parser.set_defaults(func=show_small_help)
+
+args = parser.parse_args()
+args.func(args)
-- 
2.34.1

