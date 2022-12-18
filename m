Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE48650435
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 18:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiLRRhd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 12:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiLRRhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 12:37:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3927E2A8
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 08:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6D2604AD
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 16:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106A2C433D2;
        Sun, 18 Dec 2022 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671381690;
        bh=vt1rLS3aeIIQ4yiZza9OlSwNYWZVdWW0daNNoQRlcDA=;
        h=Subject:From:To:Cc:Date:From;
        b=YsMwHTxAxEbsSVG2vLcn/9GLrBcZm1jGTzx62kUQats7yHoXowKoaZxrMOmX5Ovad
         I5nDnNs4wH5q2NelFAt7TGQQwbcTJhzgciFMHw31N5Dj2X3omZEzZp2EJQ/gMXWnnW
         X6oItUZXzi8LymhskpfMzSd0sfzW8pIe1WWbNQGwteENRwKq+QTtoeEkpkNiIsOAaT
         ybZ87Ejicmi1yIZfI49Gr0nBYR3q5tV3BrvI2kCNQ3eIIIHy1KTfl4coV5fNS9Q/tO
         WcXCA9HOaLO1PGClmX/qqrnEENeibAt90SvYxqMjrcqVAanyXRgDW8flr/1VxRKtTx
         zfj9y53v/v2kQ==
Subject: [PATCH 1/6] nfsd(7): Use "backslash" consistently
From:   cel@kernel.org
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, debian@helgefjell.de
Date:   Sun, 18 Dec 2022 11:41:29 -0500
Message-ID: <167138168903.1584402.12231405451604036910.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Issue:    back-slash vs. backslash, should be consistent

"Each line of the file contains a path name, a client name, and a number of "
"options in parentheses.  Any space, tab, newline or back-slash character in "
"the path name or client name will be replaced by a backslash followed by the "
"octal ASCII code for that character."

Reported-by: Helge Kreutzmann <debian@helgefjell.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/nfsd.man |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 514153f024fa..2abb8933fb11 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -50,7 +50,7 @@ being treated identically.
 
 Each line of the file contains a path name, a client name, and a
 number of options in parentheses.  Any space, tab, newline or
-back-slash character in the path name or client name will be replaced
+backslash character in the path name or client name will be replaced
 by a backslash followed by the octal ASCII code for that character.
 
 .TP


