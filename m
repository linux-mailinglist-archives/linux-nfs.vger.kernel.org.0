Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873EC264F8F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIJTqY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 15:46:24 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:34788 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIJTpo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 15:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599767144; x=1631303144;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gmlWuiVF6lTyuXM2DMK29LqZoM8yT1IeCfMCz7Htt3A=;
  b=O0RT1xSHiq8YmuGcK8utLPpbCO1JL/o9EXf6ojNNJXqPbHLgJjSQix9J
   l1JJPXnFjkEfM+h2fz1WHhsFLWmoq0aG4Uz0MTJt6wILLwg3aMhl+yPHh
   4QGC1d2Ss5oFsAUCiqIPedWduZ+GV+5JleRaWzl4HIBIc9HdiRDSc/svh
   w=;
X-IronPort-AV: E=Sophos;i="5.76,413,1592870400"; 
   d="scan'208";a="74009299"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Sep 2020 19:43:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id A4422A0715;
        Thu, 10 Sep 2020 19:43:56 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 19:43:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 19:43:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 10 Sep 2020 19:43:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 976B3C1400; Thu, 10 Sep 2020 19:43:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <fstests@vger.kernel.org>
CC:     <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 1/3] common/attr: make _require_attrs more fine-grained
Date:   Thu, 10 Sep 2020 19:43:53 +0000
Message-ID: <20200910194355.5977-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Filesystems may not support all xattr types. But, _require_attr assumes
that being able to use "user" namespace xattrs means that all namespaces
("trusted", "system", etc) are supported. This breaks on NFS, that only
supports the "user" namespace, and a few cases in the "system" namespace.

Change _require_attrs to optionally take namespace arguments that specify
the namespaces to check for. The default behavior (no arguments) is still
to check for the "user" namespace only.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 common/attr | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/common/attr b/common/attr
index 20049de0..c60cb6ed 100644
--- a/common/attr
+++ b/common/attr
@@ -175,30 +175,43 @@ _list_acl()
 
 _require_attrs()
 {
+    local args
+    local nsp
+
+    if [ $# -eq 0 ];
+    then
+      args="user"
+    else
+      args="$*"
+    fi
+
     [ -n "$ATTR_PROG" ] || _notrun "attr command not found"
     [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
     [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
 
-    #
-    # Test if chacl is able to write an attribute on the target filesystems.
-    # On really old kernels the system calls might not be implemented at all,
-    # but the more common case is that the tested filesystem simply doesn't
-    # support attributes.  Note that we can't simply list attributes as
-    # various security modules generate synthetic attributes not actually
-    # stored on disk.
-    #
-    touch $TEST_DIR/syscalltest
-    attr -s "user.xfstests" -V "attr" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
-    cat $TEST_DIR/syscalltest.out >> $seqres.full
+    for nsp in $args
+    do
+      #
+      # Test if chacl is able to write an attribute on the target filesystems.
+      # On really old kernels the system calls might not be implemented at all,
+      # but the more common case is that the tested filesystem simply doesn't
+      # support attributes.  Note that we can't simply list attributes as
+      # various security modules generate synthetic attributes not actually
+      # stored on disk.
+      #
+      touch $TEST_DIR/syscalltest
+      $SETFATTR_PROG -n "$nsp.xfstests" -v "attr" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
+      cat $TEST_DIR/syscalltest.out >> $seqres.full
 
-    if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
-      _notrun "kernel does not support attrs"
-    fi
-    if grep -q 'Operation not supported' $TEST_DIR/syscalltest.out; then
-      _notrun "attrs not supported by this filesystem type: $FSTYP"
-    fi
+      if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
+        _notrun "kernel does not support attrs"
+      fi
+      if grep -q 'Operation not supported' $TEST_DIR/syscalltest.out; then
+        _notrun "attr namespace $nsp not supported by this filesystem type: $FSTYP"
+      fi
 
-    rm -f $TEST_DIR/syscalltest.out
+      rm -f $TEST_DIR/syscalltest.out
+    done
 }
 
 _require_attr_v1()
-- 
2.16.6

