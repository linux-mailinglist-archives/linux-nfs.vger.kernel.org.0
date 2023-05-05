Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1526F8782
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjEERYb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEERYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 13:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB615EE8;
        Fri,  5 May 2023 10:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C9560C32;
        Fri,  5 May 2023 17:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBDFC433EF;
        Fri,  5 May 2023 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683307469;
        bh=q+shlfQScJK1HgZP8bRzIfV3LK1GTqcBoyl3Ruu40rs=;
        h=From:To:Cc:Subject:Date:From;
        b=hRJqY22EO3jyfYEYkNxtNYBzd0+bzrnTM5q23kpuu4R4QPp5+0n33WdLZMhN68wFT
         4+maCHV2gZBNZZ4hYGmjNUXwTt4fvTtus101bFbKQOgjM29vtgL5a9yzHd9GZUQJa7
         Ex8Q2BUEwmdvWsjhxLG+ZJTmlMV2pBT/A2OnLjeQf4hU/21WMwq+YWdAnM1l8VVTKf
         gmjsQLbKZt4+zDMhdtw9ngsHb/HO2z40qTCwBvbyD4SC0Q1AfwJWG/Je3KrxISn0ZJ
         ACLTosJGov/auJtI43HqcujgMcKvhu0Ulb9Kcrj1RPFfw321eomau1l5UCjpb2mZhz
         8soqOmGy3imKA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     anna@kernel.org
Subject: [PATCH v2] generic/728: Add a test for xattr ctime updates
Date:   Fri,  5 May 2023 13:24:27 -0400
Message-Id: <20230505172427.94963-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The NFS client wasn't updating ctime after a setxattr request. This is a
test written while fixing the bug.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

---
v2:
 - Move test to generic/
 - Address comments from the mailing list
---
 tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/728.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/generic/728
 create mode 100644 tests/generic/728.out

diff --git a/tests/generic/728 b/tests/generic/728
new file mode 100755
index 000000000000..ab2414c151db
--- /dev/null
+++ b/tests/generic/728
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
+#
+# FS QA Test 728
+#
+# Test a bug where the NFS client wasn't sending a post-op GETATTR to the
+# server after setting an xattr, resulting in `stat` reporting a stale ctime.
+#
+. ./common/preamble
+_begin_fstest auto quick attr
+
+# Import common functions
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_attrs
+
+rm -rf $TEST_DIR/testfile
+touch $TEST_DIR/testfile
+
+
+_check_xattr_op()
+{
+  what=$1
+  shift 1
+
+  before_ctime=$(stat -c %z $TEST_DIR/testfile)
+  $SETFATTR_PROG $* $TEST_DIR/testfile
+  after_ctime=$(stat -c %z $TEST_DIR/testfile)
+
+  test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change after $what."
+}
+
+_check_xattr_op setxattr -n user.foobar -v 123
+_check_xattr_op removexattr -x user.foobar
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/728.out b/tests/generic/728.out
new file mode 100644
index 000000000000..ab39f45fe5da
--- /dev/null
+++ b/tests/generic/728.out
@@ -0,0 +1,2 @@
+QA output created by 728
+Silence is golden
-- 
2.40.1

