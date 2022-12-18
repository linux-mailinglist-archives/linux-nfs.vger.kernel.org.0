Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0CB650436
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 18:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiLRRhg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 12:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiLRRhM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 12:37:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF4E0B9
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 08:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC7D0B80BAA
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 16:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C98C433D2;
        Sun, 18 Dec 2022 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671381696;
        bh=VDWnbkHG6WLXl36i9gSzHpZbbHkjRqGCZi+DjHgIoaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rszIVcJVmcadN9sGQgj1MiNnTSH1mua+RAU9TrRkN8ftD8uZ1amk1oFCJnLTXw9ge
         soTLVsM8cq0ZdedOWxsvLvL3eArgtpKtybZL7efJzqkrEHRG8f7kc3AWY+vkK2qR+H
         QKGNDQ9KART+ui8ds/KbrMs2k0S4DHgCWHp5ODqijVq1P3zqmcLQylkTkeDjbOVKXv
         iJlbiQVZHudg075I2bOyjuk0sELT3k2LOirL1l5/sqrw70pSY3jXIakbYqGRnxASE7
         Rt9gGSeiizNkpzJ8Q7h7BWyU8LOiTpTmGJQxBa8q7cxtv2VQwEXMR+W7QJ6pnp1o8Q
         8k9QOSuM+lrdw==
Subject: [PATCH 2/6] nfsd(7): Correct grammatical usage of "threads"
From:   cel@kernel.org
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, debian@helgefjell.de
Date:   Sun, 18 Dec 2022 11:41:35 -0500
Message-ID: <167138169547.1584402.5771788433072234381.stgit@morisot.1015granger.net>
In-Reply-To: <167138168903.1584402.12231405451604036910.stgit@morisot.1015granger.net>
References: <167138168903.1584402.12231405451604036910.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Man page: nfsd.7
Issue:    thread currently → threads currently

"This file represents the number of B<nfsd> thread currently running.  "
"Reading it will show the number of threads.  Writing an ASCII decimal number "
"will cause the number of threads to be changed (increased or decreased as "
"necessary) to achieve that number."

Reported-by: Helge Kreutzmann <debian@helgefjell.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/nfsd.man |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 2abb8933fb11..6992e10829e7 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -57,7 +57,7 @@ by a backslash followed by the octal ASCII code for that character.
 .B threads
 This file represents the number of
 .B nfsd
-thread currently running.  Reading it will show the number of
+threads currently running.  Reading it will show the number of
 threads.  Writing an ASCII decimal number will cause the number of
 threads to be changed (increased or decreased as necessary) to achieve
 that number.


