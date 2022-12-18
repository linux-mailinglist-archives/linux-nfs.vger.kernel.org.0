Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF3650438
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLRRhs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 12:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiLRRh1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 12:37:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9E7F211
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 08:41:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0957FCE0B78
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 16:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17911C433EF;
        Sun, 18 Dec 2022 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671381709;
        bh=IAsPb5sAHWEdR1KyAM0hh6mb011FQIFZ4+rnuEOfo+Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qkMtHxt7Ve+yFAgrO/xL2rVnRpUsBeB3ffbyWjwl8EO9rgZUm9n5iaKwucwgyzwnu
         r2kmHEMN4BsSHQEQqwFD08SSNrlG1+9E3Fy4Xz65xI0mKE0HnTryKZNlcR33jtTdwr
         oywO5tXYQh4FKaOgeLPKqirYdMMz2Wsv7GwFjoTdvmxi/Fz5f3FOYHkHD3nHHkAf6q
         lynV/17iQSxjd9UOEwp1CSxQACDSe7r40MY065C4wk+ZvuwbZXjP6J+kFsE7E7I0Hn
         Jo0ytewU3JOLeC4pkZO4Ca4ZX9G7YY1PVOzfy1CNRKC3Zb/g/SoPN31hqesE9sxoH0
         RTCv+W0zIKLmA==
Subject: [PATCH 4/6] nfsd(7): Correct grammatical usage of "can be displayed"
From:   cel@kernel.org
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, debian@helgefjell.de
Date:   Sun, 18 Dec 2022 11:41:48 -0500
Message-ID: <167138170820.1584402.3538764439169383145.stgit@morisot.1015granger.net>
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
Issue:    can be display → can be displayed

"The directory B</proc/net/rpc> in the B<procfs> filesystem contains a number "
"of files and directories.  The files contain statistics that can be display "
"using the I<nfsstat> program.  The directories contain information about "
"various caches that the NFS server maintains to keep track of access "
"permissions that different clients have for different filesystems.  The "
"caches are:"

Reported-by: Helge Kreutzmann <debian@helgefjell.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/nfsd.man |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index e1f3f65fb297..9481670f9ffc 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -91,7 +91,7 @@ The directory
 in the
 .B procfs
 filesystem contains a number of files and directories.
-The files contain statistics that can be display using the
+The files contain statistics that can be displayed using the
 .I nfsstat
 program.
 The directories contain information about various caches that the NFS


