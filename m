Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4879018B
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjIARkd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345679AbjIARkc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 13:40:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C45E5F;
        Fri,  1 Sep 2023 10:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52EEFCE23ED;
        Fri,  1 Sep 2023 17:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C781C433CD;
        Fri,  1 Sep 2023 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693590025;
        bh=l2j+uv/+MikdtqQ3F2+J+3rQEZpSbqnYX/8LIP4jhGo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RDWxyLaW1kEsjwhDUjIogoBxbJIjuzXLI//gQ7sz7x/45mEaG+12y/u8XwG37fXGV
         eJyDhqRhfL03MzUw8h5ZGanmPh6L1Pyx2bHq4tx+BNcp43CNMYRUxFt0m1Syct4nub
         F8wq8QRDsqI//e8KmJdYgLczIkLmnz/a6DI1vloWLnfb30IwGb8PxNxatCRuspRLsB
         BPU/GgLW+2MvKCu4fZiGSqdc8Zq04nK6K/+u5IV7wVBjz5PM0YdovfixMzuswn9Xlh
         W4K0KR9cbkxFCfTqw4Q3d209bPCZuvh8A4GqMPHDAGitx3OGCvhmL1+4O17YNZXz7I
         UHbbYhSluJuuQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 01 Sep 2023 13:39:57 -0400
Subject: [PATCH fstests v2 3/3] generic/187: don't run this test on NFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230901-nfs-skip-v2-3-9eccd59bc524@kernel.org>
References: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
In-Reply-To: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l2j+uv/+MikdtqQ3F2+J+3rQEZpSbqnYX/8LIP4jhGo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8iIHT+4iGaE6sqm2dib7aeJMbohKQNec8L/X4
 m0paJUudUuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPIiBwAKCRAADmhBGVaC
 Fe43D/4qiB85y6dEnXVcO61XtWfDa5BVcXkH2EnobK/E/Q9/S99y/uWqz5MqlOLV+dqwab7bL8+
 NqASWCCkL94aTclfS4i2HgzbIwoVCgPnc2U6A7Ru/poL9uaisaKE2kIRu8PkWXjmM67E/1b0aNl
 AtnX3RbeCh6UDa0vK14cF9xDcb5UYphJCfQqC+LArT4vKnrjZkHg8bYuQKSvZFkcnhFKY6n47fD
 xqMTRz+d9kMLsgybC/wNR2qkfJPuxjLWUCtkyFySrZxpqouE2KFWzwRHxeErAkALTR03vJ36/H4
 HK5cA1+xWA+Z+t9E6qp1r2ArekvheswqlWlYpgnNjuxSBpl0scKtQxzb0hpC6MjGZclQGzFxy3P
 X1NUPv2JjgaFG6ZA9eCj2Fv5lShhjTQYHZ9eOZbzq+9cALMCGnq04XuI+NVKGbD8qWmAMBEiNBQ
 oDPr3OUJaqLNTenqY/7rBLoyWYy77bv//uh/IilxYvvo/Vm3kSsRp4Jm/06aV0KOqliwJHtKu38
 fQZ3D3c6gGaMcBYQH5MJ7weWQU96IROoAkYAB/kVRTQcH12rHPmN4KfAIvKgEw132VxTvACXOps
 O59oDorvMOrCKxgqCAAx1QdOH6QFDCqgrtZajrhTAp1fbZhZ/eGPZnsINXSG+9EpoHWJIWdAGdP
 XDwAOGQHnAnIlgg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This test is unreliable on NFS. It fails consistently when run vs. a
server exporting btrfs, but passes when the server exports xfs. Since we
don't have any sort of attribute that we can require to test this, just
skip this one on NFS.

Also, subsume the check for btrfs into the _supported_fs check, and add
a comment for it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/187 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/generic/187 b/tests/generic/187
index 0653b92f12f4..1b3509424462 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -29,13 +29,17 @@ _cleanup()
 . ./common/reflink
 
 # real QA test starts here
+
+# btrfs can't fragment free space. This test is unreliable on NFS, as it
+# depends on the exported filesystem.
+_supported_fs ^btrfs ^nfs generic
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
-test $FSTYP = "btrfs" && _notrun "Can't fragment free space on btrfs."
 _require_odirect
 
+
 _fragment_freesp()
 {
 	file=$1

-- 
2.41.0

