Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EC6B75E8
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCMLYI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCMLYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 07:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EE9303DD
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 04:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA4D611DB
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 11:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3152FC4339B;
        Mon, 13 Mar 2023 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678706645;
        bh=sVjkQfpECKeMo7VdASMNcHX5iOiyZBe9KE2j7AMXZcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLYb8u55jmPW4rUYgPcAvk2+eN0unMrn6mDzGF3RyiGq98NSsYhVbC9QkISyDuFA8
         bFaiExW7sEecokcwEySGB6iYinEHih0IMB+tvDs7EJqI6RPLeTDGmQ2NbxjclHsROS
         torNRns1rcrU/xvdngOjp2yekA3OwYn79NMiVCkb8CE2HJXZa9J0KLV2pF7fl+C1WX
         O8TcoxsU6dHgW+E0ac6QSdF7gJWlMZU8QtHJZnpXVR5bKchXPfGRKuh7VdLPbR4mUl
         Po0xWpJH3mcbdRSR8MhpWMcxT4Bc5XS6ZFcFxh7Qqz5bi2DphKtOiprf+Mw8YuFnLi
         oxmE3Y38CGcSA==
From:   Jeff Layton <jlayton@kernel.org>
To:     calum.mackay@oracle.com
Cc:     bfields@fieldses.org, ffilzlnx@mindspring.com,
        linux-nfs@vger.kernel.org
Subject: [pynfs PATCH v2 3/5] nfs4.0/testserver.py: don't return an error when tests fail
Date:   Mon, 13 Mar 2023 07:23:59 -0400
Message-Id: <20230313112401.20488-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313112401.20488-1-jlayton@kernel.org>
References: <20230313112401.20488-1-jlayton@kernel.org>
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

