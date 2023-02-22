Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EEB69F5E5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 14:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBVNt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 08:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBVNt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 08:49:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E1311C1
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 05:49:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2754FB8159D
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 13:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB19C433D2;
        Wed, 22 Feb 2023 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677073794;
        bh=DdXBdtJvoyyGtbrR4GBCyyASdwgNEUT5rIpyRU4Q9ls=;
        h=From:To:Cc:Subject:Date:From;
        b=S5iKT5EVKKsDin0nRvmXzPyUYiXKBA3GLnhbEPq5na1y5h7iFgk/djv87bHxMDNoa
         aFPQBLRTjf7jBxQ6wAN2RbPW3tnlEfSTeCcjE5Y63+FGbTE3OPcY9/9naIU9tnwxuR
         mu+nUqnsOBFbnO7PWv1YPkhSFdBxawv5rdF5NeE+WU6MTw4Fuv+OQV45hq6z7Se8iF
         cg3p/gczZcyqawu72owprbTgWMXmenS/D/QXUMmp6yrNhOnQ2hZaReh0XlFogVBToJ
         o/ncVMLmjs6AORxFXvIWPsICsKF35lcK1y9Vam58Gr+gZxVvDOSffGjx5bfeAiDgka
         DLqIUn34Hk1PA==
From:   Jeff Layton <jlayton@kernel.org>
To:     bfields@fieldses.org, dai.ngo@oracle.com
Cc:     linux-nfs@vger.kernel.org, Frank Filz <ffilzlnx@mindspring.com>
Subject: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error when tests fail
Date:   Wed, 22 Feb 2023 08:49:52 -0500
Message-Id: <20230222134952.32851-1-jlayton@kernel.org>
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

This script was originally changed in eb3ba0b60055 ("Have testserver.py
have non-zero exit code if any tests fail"), but the same change wasn't
made to the 4.1 testserver.py script.

There also wasn't much explanation for it, and it makes it difficult to
tell whether the test harness itself failed, or whether there was a
failure in a requested test.

Stop the 4.0 testserver.py from exiting with an error code when a test
fails, so that a successful return means only that the test harness
itself worked, not that every requested test passed.

Cc: Frank Filz <ffilzlnx@mindspring.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.0/testserver.py | 2 --
 1 file changed, 2 deletions(-)

I'm not sure about this one. I've worked around this in kdevops for now,
but it would really be preferable if it worked this way, imo. If this
isn't acceptable, maybe we can add a new option that enables this
behavior?

Frank, what was the original rationale for eb3ba0b60055 ?

diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
index f2c41568e5c7..4f4286daa657 100755
--- a/nfs4.0/testserver.py
+++ b/nfs4.0/testserver.py
@@ -387,8 +387,6 @@ def main():
 
     if nfail < 0:
         sys.exit(3)
-    if nfail > 0:
-        sys.exit(2)
 
 if __name__ == "__main__":
     main()
-- 
2.39.2

