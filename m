Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40BB6F776E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEDUuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEDUuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CECBFE;
        Thu,  4 May 2023 13:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC34639E7;
        Thu,  4 May 2023 20:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB8FC433D2;
        Thu,  4 May 2023 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233329;
        bh=zhP5Gy+eyJTrENWLVRX4a338jk51BmZoBKLGF3oLTDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kSBgvcJ7rTNcodhqocxZAc8zW0mEFhfKkU5+O6EVPrZbx0zNW2hLbBG+lGQHv3jKQ
         XY4g4XnG4f+ibxgdmn5ZaDovZ+LU+Z/CK6UaN280pNXlfUGiBUdaJYw3QKajt9uh9H
         wd1QS9ZK1T9Vnkd0cfoeDJOmxO5QtIP7tPJp8bzZkAYlg2m20BRKzFVx7+XnNmUFeG
         5dgpRHTIK1ET6cCohuT7gGxQsEcVrnhrMEfkr6VlOMAlsgWi4dVs34Wj3cPgdtbBJv
         DWxh1ahK5E40X1wXv66xq0v3MIiH86AJ5lW1yWhZ+GUvkdQMf+vyjkLy2G0Oir9rPK
         k4vQTb9oMmETA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     anna@kernel.org
Subject: [PATCH] nfs/002: Add a test for xattr ctime updates
Date:   Thu,  4 May 2023 16:48:47 -0400
Message-Id: <20230504204847.405037-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/nfs/002.out |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100755 tests/nfs/002
 create mode 100644 tests/nfs/002.out

diff --git a/tests/nfs/002 b/tests/nfs/002
new file mode 100755
index 000000000000..5bfedef6c57d
--- /dev/null
+++ b/tests/nfs/002
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
+#
+# FS QA Test 002
+#
+# Test a bug whene the NFS client wasn't sending a post-op GETATTR to the
+# server after setting an xattr, resulting in `stat` reporting a stale ctime.
+#
+. ./common/preamble
+_begin_fstest auto quick attr
+
+# Import common functions
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs nfs
+_require_test_nfs_version 4.2
+_require_attrs
+
+touch $TEST_DIR/testfile
+
+before_ctime=$(stat -c %z $TEST_DIR/testfile)
+$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
+after_ctime=$(stat -c %z $TEST_DIR/testfile)
+
+test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
+
+
+before_ctime=$after_ctime
+$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
+after_ctime=$(stat -c %z $TEST_DIR/testfile)
+
+test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/nfs/002.out b/tests/nfs/002.out
new file mode 100644
index 000000000000..61705c7cc203
--- /dev/null
+++ b/tests/nfs/002.out
@@ -0,0 +1,2 @@
+QA output created by 002
+Silence is golden
-- 
2.40.1

