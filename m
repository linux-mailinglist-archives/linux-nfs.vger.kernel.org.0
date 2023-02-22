Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569A969FAE6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjBVSUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjBVSUs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 13:20:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04053B877
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 10:20:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEDB614ED
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 18:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4346CC433EF;
        Wed, 22 Feb 2023 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677090045;
        bh=3h3eIuF+sszxxGwYVrcmtCEdtsRsi1EF/TaHNIVBm0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=HPl7QMsfzhzBO54ZjLVxFJfTnjBFIikQy0TbM2dKAte6452PAk8vadkz9lt6nd5G9
         rO4QPixt+W54y99DGEDTLfpLzJCyxNvzpQFMcjaa8nGL6MiIIPlsdKLT+roH7AdOeW
         n+FWx58DAZvqHUt2NOXawKLciAh3hjJ2/VXDJFdunjJo8K8Y+pFB5kWUAYAJ3X8RDG
         ubbDGbB32n5SBUFmJum2dLLwLbCu0+Q4nDcfqqV2c9dBJnZzBH8I84FLIR809n+aHM
         o3j3j2tr1YU+wnXRTuAYL+iBLP9kcg/mYa92u1gL4nrUrF5zrvq1E+a5OpogUsmXoc
         rk5NS2HxULj3Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     bfields@fieldses.org, dai.ngo@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Date:   Wed, 22 Feb 2023 13:20:43 -0500
Message-Id: <20230222182043.155712-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the "all"
flag is supposed to run all of the "standard" tests. For v4.1 "all" is
documented to run all of the tests, but it actually doesn't since not
every tests has "all" in its FLAGS: field.

I move that we change this. If I say that I want to run "all", then I
really do want to run _all_ of the tests. Ensure that every test has the
"all" flag set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/testmod.py | 2 ++
 1 file changed, 2 insertions(+)

If this is unacceptable, then an alternative could be to add a new
(similarly special-cased) "everything" flag.

diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index 11e759d673fd..7b3bac543084 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -386,6 +386,8 @@ def createtests(testdir):
     for t in tests:
 ##         if not t.flags_list:
 ##             raise RuntimeError("%s has no flags" % t.fullname)
+        if "all" not in t.flags_list:
+            t.flags_list.append("all")
         for f in t.flags_list:
             if f not in flag_dict:
                 flag_dict[f] = bit
-- 
2.39.2

