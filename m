Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2236650439
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiLRRhw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 12:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiLRRha (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 12:37:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E307F21E
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 08:41:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2060B80BD9
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 16:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6773DC433D2;
        Sun, 18 Dec 2022 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671381715;
        bh=eeUeXt2AO7/nwldm9rI6cBamDX/Gpp0tzrzing6UFcw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fkPaTAaKgw9ER6gn5T4txl4PsyMLQW9wVHEv4wP18pwzRQPVw1pyXXx7DN0Rprvtp
         7lkMLitd0rA2gjoOPbFvwTdMdWQL2mc8Pdvc7MS1I6RMv11h4GbHuFu7XXcWFpr9bL
         LtOnEigVjbrD0HI69JbBOekP2kPuqP55frZwn9QbFcU29CHZc4MfhvgoLLRdk9sqwb
         FSn7uYiR5HMUylIKFHsTCdsdCzCzcFrPuAbEyLRc3l5Lkwoo4PdvZSRvoL8SvHmjEC
         CaBjambwP52OAortuibnXvUVxmPnEiVgQhHLqFbpX/QRhG7w5zAjgLHXNJuUc38wMa
         h7MBmOUJ8ksrQ==
Subject: [PATCH 5/6] nfsd(7): Correct formatting of "select or poll"
From:   cel@kernel.org
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, debian@helgefjell.de
Date:   Sun, 18 Dec 2022 11:41:54 -0500
Message-ID: <167138171450.1584402.1832671837785160899.stgit@morisot.1015granger.net>
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
Issue:    select(2) or poll(2) → B<select>(2) or B<poll>(2)

"If the program uses select(2) or poll(2) to discover if it can read from the "
"B<channel> then it will never see and end-of-file but when all requests have "
"been answered, it will block until another request appears."

Reported-by: Helge Kreutzmann <debian@helgefjell.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/nfsd.man |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 9481670f9ffc..72fe5b1467eb 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -158,8 +158,11 @@ nfsd 127.0.0.1 1057206953 localhost
 .br
 to indicate that 127.0.0.1 should map to localhost, at least for now.
 
-If the program uses select(2) or poll(2) to discover if it can read
-from the
+If the program uses
+.BR select (2)
+or
+.BR poll (2)
+to discover if it can read from the
 .B channel
 then it will never see and end-of-file but when all requests have been
 answered, it will block until another request appears.


