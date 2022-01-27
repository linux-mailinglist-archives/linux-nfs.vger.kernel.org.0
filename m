Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAADC49EB51
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiA0Tt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245702AbiA0Tt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:56 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A3C06173B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:55 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z1so2288314qto.3
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27Cy+fjQrrhdBt/+KeF+2iggxTxikJ4LQwj6XTmGTFQ=;
        b=SankUvwZe3dHu+0eZQaZPIPwv1v+r6VBoKzJ/gxw3J7NtdrWwU3TrZQ37i6XkKWMpN
         6sidNgBgWNdjLfokSUSacR96Uug3oDRAzV6+Rru5hP3B8qU5XGxAjBeVBt1+5ZpDa+fE
         aaxS1dC08HNR3TzhPfHKL64DsQNURqY4R3olSLPe8nF0aSXX1sIGutwZvMx/BEKUMqlr
         eBcRH2QMbCjf7QcMWoLn2fO82VJa/vN977S5NRvSlKsy79MozKU6R72RGkvJUc23BEPT
         /hq/VvFmLwAW2U34HVxSJNSvLfzT+kOzqp6oS5GEzPvWxSuIcmH9zMZhAwNFCmjSv3JJ
         wExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=27Cy+fjQrrhdBt/+KeF+2iggxTxikJ4LQwj6XTmGTFQ=;
        b=HJGyD3B/5LrKQMO1JPx949a353Vof53mZhSKV6DYzIN4TZT//fEgF4iDT6sSiHZeoQ
         jVPsYqFh7LbvinOVKXGXIBZTrrhA4mn/LgOD1vu0IQ4wmlmDr2qXED5yrkeAbIdr69rz
         VjzRs+H32kARLEqYxQNngwR3R9p3J070X/Fgc/9LLrTBC8CFg0RidfdietrZusMvcPDZ
         aqYreGSuEmsJ5pu6HRInBsyv/4aWpkC/KYxYPfoJpkJQJV0tJikr1kT9vHENGUU5zV50
         oEmbMlhz2XqC5goQqRYAuye7H3ozCYbNOxBkwkVxRzl3SSRG5qoHEbuGhqlXaED/Icg7
         F+/A==
X-Gm-Message-State: AOAM533k7VT+AcgRPP5hoQnrh7uwYiW780uLk80Euny/eEQOUAsqCoi6
        bBvyv8310HPVPVBaaTSawR8iRX3QVTM=
X-Google-Smtp-Source: ABdhPJwjBc75VZlBwgBPMIoo44u2HpCdnhV2ptIaN5TFcPlS3wLjRlGMYBCUTCdriVrAWy9VHmshHw==
X-Received: by 2002:a05:622a:1908:: with SMTP id w8mr4005465qtc.252.1643312994763;
        Thu, 27 Jan 2022 11:49:54 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:54 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 1/9] rpcctl: Add a rpcctl.py tool
Date:   Thu, 27 Jan 2022 14:49:44 -0500
Message-Id: <20220127194952.63033-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
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
v7: Check entire line for "sysfs" instead of just the start of the line
---
 tools/rpcctl/rpcctl.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 tools/rpcctl/rpcctl.py

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
new file mode 100755
index 000000000000..9737ac4a9740
--- /dev/null
+++ b/tools/rpcctl/rpcctl.py
@@ -0,0 +1,25 @@
+#!/usr/bin/python3
+import argparse
+import pathlib
+import sys
+
+with open("/proc/mounts", 'r') as f:
+    mount = [ line.split()[1] for line in f if "sysfs" in line ]
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
2.35.0

