Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D613FB97B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhH3P6B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbhH3P5w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6F0C061760
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id gf5so8544647qvb.9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lys7DtM6lVqjsDSpjgsx9MbdW3F1P43uIMCRhpmes+I=;
        b=nMmmBa+0UfwTu635oDPevSXe3DGQcaJncAN3ORa1vU/nJ+DwXA71Ed0pokZ1jhhmuB
         TRMUkAEW8qIxVT1pKPYTh0qhDc1R7nfrv2F3yURGdxrU0mWYWoj0RWywGkcm6nd8nJT7
         Aar2xLi7gf1yLUizpddNeb9xXXtbXrjOlI5T78LyUpRamjtLmrL2LWgKcmjdCYXVHEEc
         tRG8kMLALcVJ5IzVt7JsSFWccxahQZ+IynoysU2kWOp8omq8kvY20RB6cX0+ohC3uHHa
         YDA9SWkO04igdPNUDGgXfmtam9rMr7zpY/nOEbwGjCwTrPjnizLkUXKM7DJQKTmL5v3c
         WcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lys7DtM6lVqjsDSpjgsx9MbdW3F1P43uIMCRhpmes+I=;
        b=mLJyz4jD+8z2uH5dRIsxGPzlGXtfcRRyCdgRnkLz35EF2ZoxLJ4/qas7SXJBeLgdbE
         oHD5/mKlnHntXYY/5At7nZT0mfQu3mzy5ZFBVy8IDDK10UwLJ3kgVf13krtws8zfaCGb
         fAIKo766V2UAtANm5skEq2/Nhp2XbsD8QUKSoILu0m+nxJiEGPEUzBgQo7POz2vx6/ag
         Fs534lF/wmgpdmF6UACKwXa9X67t0jtm+IT9hMEQIiE8cSzfMazzNr1vyIPlgdG/UkUN
         MrT8V/h02biAwWB3BefjJi7OutvjTLxPb3w4MFLbrEroe0zMMJrzZUVrWkuiAlQ/FhQg
         LjNg==
X-Gm-Message-State: AOAM532Ri9z2nRAEk+Lw1nk7ubgB7p/ydmyM/Cf7bednrBM9KRsM2Mz8
        5WJJ1ubeOfnFlfej7pWi0G4=
X-Google-Smtp-Source: ABdhPJy5exyR9YnUmu2PUQMBHFXIfeyb/C1DX3S7BgrEjDt2dIzBAiJIbr6nYqerKudjfvMBO8sflQ==
X-Received: by 2002:ad4:4982:: with SMTP id t2mr7484161qvx.46.1630339017586;
        Mon, 30 Aug 2021 08:56:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:56:57 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 2/9] nfssysfs.py: Add a command for printing xprt switch information
Date:   Mon, 30 Aug 2021 11:56:46 -0400
Message-Id: <20210830155653.1386161-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This combines the information found in xprt_switch_info with a subset of
the information found in each xprt subdirectory

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfssysfs/nfssysfs.py |  6 ++++++
 tools/nfssysfs/switch.py   | 35 +++++++++++++++++++++++++++++++++++
 tools/nfssysfs/sysfs.py    | 10 ++++++++++
 tools/nfssysfs/xprt.py     | 12 ++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 tools/nfssysfs/switch.py
 create mode 100644 tools/nfssysfs/xprt.py

diff --git a/tools/nfssysfs/nfssysfs.py b/tools/nfssysfs/nfssysfs.py
index 8ff59ea9e81b..90efcbed7ac8 100755
--- a/tools/nfssysfs/nfssysfs.py
+++ b/tools/nfssysfs/nfssysfs.py
@@ -9,5 +9,11 @@ def show_small_help(args):
     print("sunrpc dir:", sysfs.SUNRPC)
 parser.set_defaults(func=show_small_help)
 
+
+import switch
+subparser = parser.add_subparsers(title="commands")
+switch.add_command(subparser)
+
+
 args = parser.parse_args()
 args.func(args)
diff --git a/tools/nfssysfs/switch.py b/tools/nfssysfs/switch.py
new file mode 100644
index 000000000000..afb6963a0a1f
--- /dev/null
+++ b/tools/nfssysfs/switch.py
@@ -0,0 +1,35 @@
+import sysfs
+import xprt
+
+class XprtSwitch:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(str(path).rsplit("-", 1)[1])
+
+        self.xprts = [ xprt.Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
+        self.xprts.sort()
+
+        self.__dict__.update(sysfs.read_info_file(path / "xprt_switch_info"))
+
+    def __lt__(self, rhs):
+        return self.path < rhs.path
+
+    def __str__(self):
+        line = "switch %s: num_xprts %s, num_active %s, queue_len %s" % \
+                (self.id, self.num_xprts, self.num_active, self.queue_len)
+        for x in self.xprts:
+            line += "\n	%s" % x.small_str()
+        return line
+
+
+def list_xprt_switches(args):
+    switches = [ XprtSwitch(f) for f in (sysfs.SUNRPC / "xprt-switches").iterdir() ]
+    switches.sort()
+    for xs in switches:
+        if args.id == None or xs.id == args.id[0]:
+            print(xs)
+
+def add_command(subparser):
+    parser = subparser.add_parser("xprt-switch", help="Commands for xprt switches")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
+    parser.set_defaults(func=list_xprt_switches)
diff --git a/tools/nfssysfs/sysfs.py b/tools/nfssysfs/sysfs.py
index c9d477063585..79f844af34a6 100644
--- a/tools/nfssysfs/sysfs.py
+++ b/tools/nfssysfs/sysfs.py
@@ -17,3 +17,13 @@ SUNRPC = pathlib.Path(MOUNT) / "kernel" / "sunrpc"
 if not SUNRPC.is_dir():
     print("ERROR: sysfs does not have sunrpc directory")
     sys.exit(1)
+
+
+def read_info_file(path):
+    res = dict()
+    with open(path) as info:
+        for line in info:
+            if "=" in line:
+                (key, val) = line.strip().split("=")
+                res[key] = int(val)
+    return res
diff --git a/tools/nfssysfs/xprt.py b/tools/nfssysfs/xprt.py
new file mode 100644
index 000000000000..d37537771c1d
--- /dev/null
+++ b/tools/nfssysfs/xprt.py
@@ -0,0 +1,12 @@
+class Xprt:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(str(path).rsplit("-", 2)[1])
+        self.type = str(path).rsplit("-", 2)[2]
+        self.dstaddr = open(path / "dstaddr", 'r').readline().strip()
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def small_str(self):
+        return "xprt %s: %s, %s" % (self.id, self.type, self.dstaddr)
-- 
2.33.0

