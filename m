Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964179AF4A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353251AbjIKV7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbjIKMuS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 08:50:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A47CEB
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 05:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B71BC433C7;
        Mon, 11 Sep 2023 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694436613;
        bh=Ij41ybCGuDW0ic6HLnKIf1eYLQndXU6pbAajOQ4+vXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stTHYRxvHDPDSjFwPMtpr7/MlXXVZ3LxFflhK/TPwk2F8Y8eQeVZA32wHDPB7vySi
         IHGkonIhvdRypf4dryir+PQXOvOFCpF6ap1BNfm1fOBfbzWxcMEzQ0+b6kUd7jkC5M
         GJ2ftRgtZVY7p55r4TgcwWC/azL6uQAIOM6uqx/E5SpSeXnzVEPlVFGu0kvXEJLe2Z
         7aTCM2/MyptgrTZygw1nbDFGG3QGW+t3J/MbC0XpdMLP2lYeKOc4IyoZsjeLycir8H
         5aIAOGBX+yWw10o2sAzl7cvJqCPvvWu4JCIShA929vfNQuJmgoc6yT4PRRTBAM2bH0
         a6K3xo4Vdw+vg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for nfsd_server
Date:   Mon, 11 Sep 2023 14:49:44 +0200
Message-ID: <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce nfsd_server.yaml specs to generate uAPI and netlink
code for nfsd server.
Add rpc-status specs to define message reported by the nfsd server
dumping the pending RPC requests.

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd_server.yaml | 97 ++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/netlink/specs/nfsd_server.yaml

diff --git a/Documentation/netlink/specs/nfsd_server.yaml b/Documentation/netlink/specs/nfsd_server.yaml
new file mode 100644
index 000000000000..e681b493847b
--- /dev/null
+++ b/Documentation/netlink/specs/nfsd_server.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: nfsd_server
+
+doc:
+  nfsd server configuration over generic netlink.
+
+attribute-sets:
+  -
+    name: rpc-status-comp-op-attr
+    enum-name: nfsd-rpc-status-comp-attr
+    name-prefix: nfsd-attr-rpc-status-comp-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: op
+        type: u32
+  -
+    name: rpc-status-attr
+    enum-name: nfsd-rpc-status-attr
+    name-prefix: nfsd-attr-rpc-status-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: xid
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+      -
+        name: prog
+        type: u32
+      -
+        name: version
+        type: u8
+      -
+        name: proc
+        type: u32
+      -
+        name: service_time
+        type: s64
+      -
+        name: pad
+        type: pad
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: saddr6
+        type: binary
+        display-hint: ipv6
+      -
+        name: daddr6
+        type: binary
+        display-hint: ipv6
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: compond-op
+        type: array-nest
+        nested-attributes: rpc-status-comp-op-attr
+
+operations:
+  enum-name: nfsd-commands
+  name-prefix: nfsd-cmd-
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: rpc-status-get
+      doc: dump pending nfsd rpc
+      attribute-set: rpc-status-attr
+      dump:
+        pre: nfsd-server-nl-rpc-status-get-start
+        post: nfsd-server-nl-rpc-status-get-done
-- 
2.41.0

