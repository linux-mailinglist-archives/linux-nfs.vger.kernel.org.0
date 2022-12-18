Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6565043A
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 18:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLRRh4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiLRRhd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 12:37:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F427DFD2
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 08:42:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48133B80B33
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 16:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C22C433D2;
        Sun, 18 Dec 2022 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671381722;
        bh=7GgFbBkE8ILwFfNZ6sboUe+XLGJDPLsZ/tRpk7cJmp8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QCsQ4Yqp43blJtRFkBNkF9g51CovTEMgf+a4paEd0NNSWM0f3oDf7WIpLWuhQWph8
         IOtDNzDfBktFQqOl3Cxx7t9wecXX5eO3N0anedMXSm/ZYBrTrv8OklKuV4NLmb9ILk
         7PyctAZij7E4XFXRVmmR295xqNJP7HuB8GFX0RKMZfCs5hEThZa+DOj2b+tt7p6G2H
         wYABlAUkoczntU6/MT47gR9zcaDXzwtrWvlTsTHeAcBq1m5BPzG7w/o2Y1tkKVTJXL
         Cdzki+EO51xu670jHFAahGjcZpzS3piA7kkro7+U7kUy1BtFkpp6bnki08ROeGawes
         4vhqSMc/XfT/w==
Subject: [PATCH 6/6] nfsd(7): Correct misspelling of "an"
From:   cel@kernel.org
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, debian@helgefjell.de
Date:   Sun, 18 Dec 2022 11:42:00 -0500
Message-ID: <167138172084.1584402.1454583560429873779.stgit@morisot.1015granger.net>
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
Issue:    and end-of-file → an end-of-file

"If the program uses select(2) or poll(2) to discover if it can read from the "
"B<channel> then it will never see and end-of-file but when all requests have "
"been answered, it will block until another request appears."

Reported-by: Helge Kreutzmann <debian@helgefjell.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/nfsd.man |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 72fe5b1467eb..ba826af742c4 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -164,7 +164,7 @@ or
 .BR poll (2)
 to discover if it can read from the
 .B channel
-then it will never see and end-of-file but when all requests have been
+then it will never see an end-of-file but when all requests have been
 answered, it will block until another request appears.
 
 .PP


