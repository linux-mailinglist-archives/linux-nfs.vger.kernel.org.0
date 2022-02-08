Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00A4AE368
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiBHWWH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387066AbiBHVwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 16:52:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EBEC0612B8;
        Tue,  8 Feb 2022 13:52:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F551614EB;
        Tue,  8 Feb 2022 21:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950D3C340ED;
        Tue,  8 Feb 2022 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644357156;
        bh=GQz3JfLCbgqUTE9TZ0VpJ50qY7zv4DMdazCVVpVHhcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFtnYarSxBmL58Mrgd8oESMDznJ+DtgfRN9wWOgwTJ6/2g2dx20CbUolyVbkqP74H
         Zr9NY4JjJmafq1WmkZhk2/hzGCA7+haQEt+gpVUN44LcIREhQfk1qEa/cPwskrsLTx
         2K0tHnFWwCHPRYoZWmjyjoEYjJI2r1bRZJzsr8vI6+LdUX+sM03ET4/U71OWJEO/Tp
         dxARA/J6CR/f/EqVd0CH2Etx9fm6wxniE7QW6Gwit+M13tOOEZ838tadGRId6u+6Jn
         ngibnZ1iSnOq+kS7upHX7AKkgikoKs8FlSU1dGoYywPmz5g7M8Yh/5UK5sddin7Tsf
         CPV48kPgbQA2Q==
From:   Anna Schumaker <anna@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] generic/578: Test that filefrag is supported before running
Date:   Tue,  8 Feb 2022 16:52:31 -0500
Message-Id: <20220208215232.491780-4-anna@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208215232.491780-1-anna@kernel.org>
References: <20220208215232.491780-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

NFS does not support FIBMAP/FIEMAP, so the check for non-shared extents
on NFS v4.2 always fails with the message: "FIBMAP/FIEMAP unsupported".
I added the _require_filefrag check for NFS and other filesystems that
don't have FIEMAP or FIBMAP support.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 common/rc         | 14 ++++++++++++++
 tests/generic/578 |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b3289de985d8..73d17da9430e 100644
--- a/common/rc
+++ b/common/rc
@@ -4673,6 +4673,20 @@ _require_inode_limits()
 	fi
 }
 
+_require_filefrag()
+{
+	_require_command "$FILEFRAG_PROG" filefrag
+
+	local file="$TEST_DIR/filefrag_testfile"
+
+	echo "XX" > $file
+	${FILEFRAG_PROG} $file 2>&1 | grep -q "FIBMAP/FIEMAP[[:space:]]*unsupported"
+	if [ $? -eq 0 ]; then
+		_notrun "FIBMAP/FIEMAP not supported by this filesystem"
+	fi
+	rm -f $file
+}
+
 _require_filefrag_options()
 {
 	_require_command "$FILEFRAG_PROG" filefrag
diff --git a/tests/generic/578 b/tests/generic/578
index 01929a280f8c..64c813032cf8 100755
--- a/tests/generic/578
+++ b/tests/generic/578
@@ -23,7 +23,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _require_test_program "mmap-write-concurrent"
-_require_command "$FILEFRAG_PROG" filefrag
+_require_filefrag
 _require_test_reflink
 _require_cp_reflink
 
-- 
2.35.1

