Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1803437FAB
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhJVU62 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhJVU61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DAC061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bl14so5897352qkb.4
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQz+ReTvhOjs/+Zs9d2cBF8l0RxupR0A14Vhyg4nYbc=;
        b=R+z4VR06zi1sYrHmAmYAbEW7Pznv/Cj7Xt23P6U/N0kwuN+6DxCHrbhUIEDWxcycfe
         95/WAqSuJyV2G+UymsvTBVwVumjWc14CJQ1zEFDeSOtrqNTIeNHRP/18Fh9/BeixCSw+
         UeO+MBx790fnVP6zeJ9gPwAfZf6gQTVbeGYHu/BPAl42+M3UNQs/OTvZ5U7JdTO3wxXE
         oUDtOuzVGCnV1ZVhXY4Sz5hSzAdLcHOJMMFxkZZlElnV2xEpakYzfJllL5UUmvCoM1vE
         M0s+soE3w9dH00Ia5vh8Tp06RlizWCVo7bjO6Jgh5SUf4DVeMq4OvPx4sk1SIeQy0+t8
         EgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xQz+ReTvhOjs/+Zs9d2cBF8l0RxupR0A14Vhyg4nYbc=;
        b=w2EnPACpE4hgGh+M9KIuo1RcFyhrzlS4hScnJzPWGgm8oSCmi+V8bcZIyVMDKWpa82
         UkXZXPkALa6Rr/PQdw+WTxHz7mNJpdDYQByCuAOlmPeWAxitj3jCfBinztcxx8aJSzTt
         zAJbX4crZHSK185DvYGko0o8kKah+f9HQWi2RbIpL9wxxM5K5OdYQ5esmCElyffp+SFO
         6C165IRB8ZdEdF14qI9d0btqx/braeugUGEpEfuNkSYSpWmZyuWWcMYIHNKOlqiaLCnQ
         96MUetQPghTQAc7zjI7llZd/n00A5R1woNaVE0HwnSHXPHLz3pa42rYVut59+gLisu0O
         C+Tw==
X-Gm-Message-State: AOAM533E2lvZl/ZRj+aLl22HFUaXXXJ4KFl2JmEyddG5W2S8jy9RhZ3f
        AdVqTcDVJNyyy3OTYeicbTk=
X-Google-Smtp-Source: ABdhPJzhSfm1t71Byk8w16g2XHBsPyRRWa5pBlrkE7TJebEP+YUmstEdBQXRR7BcadtehAIksv5l1Q==
X-Received: by 2002:a05:620a:f0b:: with SMTP id v11mr1916659qkl.429.1634936168508;
        Fri, 22 Oct 2021 13:56:08 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:08 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 1/9] rpcsys: Add a rpcsys.py tool
Date:   Fri, 22 Oct 2021 16:55:58 -0400
Message-Id: <20211022205606.66392-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
---
 .gitignore             |  2 ++
 tools/rpcsys/rpcsys.py | 13 +++++++++++++
 tools/rpcsys/sysfs.py  | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100755 tools/rpcsys/rpcsys.py
 create mode 100644 tools/rpcsys/sysfs.py

diff --git a/.gitignore b/.gitignore
index c89d1cd2583d..a476bd20bc3b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,3 +84,5 @@ systemd/rpc-gssd.service
 cscope.*
 # generic editor backup et al
 *~
+# python bytecode
+__pycache__
diff --git a/tools/rpcsys/rpcsys.py b/tools/rpcsys/rpcsys.py
new file mode 100755
index 000000000000..8ff59ea9e81b
--- /dev/null
+++ b/tools/rpcsys/rpcsys.py
@@ -0,0 +1,13 @@
+#!/usr/bin/python
+import argparse
+import sysfs
+
+parser = argparse.ArgumentParser()
+
+def show_small_help(args):
+    parser.print_usage()
+    print("sunrpc dir:", sysfs.SUNRPC)
+parser.set_defaults(func=show_small_help)
+
+args = parser.parse_args()
+args.func(args)
diff --git a/tools/rpcsys/sysfs.py b/tools/rpcsys/sysfs.py
new file mode 100644
index 000000000000..c9d477063585
--- /dev/null
+++ b/tools/rpcsys/sysfs.py
@@ -0,0 +1,19 @@
+import pathlib
+import re
+import sys
+
+MOUNT = None
+with open("/proc/mounts", 'r') as f:
+    for line in f:
+        if re.search("^sys ", line):
+            MOUNT = line.split()[1]
+            break
+
+if MOUNT == None:
+    print("ERROR: sysfs is not mounted")
+    sys.exit(1)
+
+SUNRPC = pathlib.Path(MOUNT) / "kernel" / "sunrpc"
+if not SUNRPC.is_dir():
+    print("ERROR: sysfs does not have sunrpc directory")
+    sys.exit(1)
-- 
2.33.1

