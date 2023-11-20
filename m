Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347F37F1CF9
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjKTSyK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjKTSyK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794ACD
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:54:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343B1C433C8;
        Mon, 20 Nov 2023 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700506446;
        bh=fKPlj3s/zKwZeZMuf6ZpyA9QY8rtitPYtb7JhHNAMew=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XyxAyNwMOUf9b1QX8NIOXQeBCTCM930C5Qoql+eF61lH6nNUG6Mn/F2/nps1H0GY+
         EGYXbaiEQrRqQJCEoZ5VrsSsGuJnzBaru1jxOT4riK7x0WmEmRAEROeIjcPAKVKGMV
         3dJC3QkvDPHK8aWjOYozp6cgp4KnTKwyJobYhuSNHBSWuMYP3R3f0Gu2+Xrzb0/ZBK
         zUkU7DGXyfue2PFY8WzPChj927Plv71ofbNm27qDqxxIZe7m23J558N/LMiy2FdBuc
         +sFvtyFW11UT+S+HYP0autIpDmcdpZ+Xvmfa2i6D1G/Ag36WxzJM/Kuu+FlqLH/+/y
         DxS7eTlLRFB/A==
Subject: [PATCH RFC 5/5] configure: Make --enable-junction=yes the default
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 20 Nov 2023 13:54:05 -0500
Message-ID: <170050644526.123525.5665867726938404920.stgit@manet.1015granger.net>
In-Reply-To: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
References: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

When I first introduced the nfsref command as part of fedfs-utils,
Bruce suggested that we should adopt nfsref as the mechanism for
managing NFSv4 referrals, over the existing refer= and replica=
export options.

Now that nfsref has been an integral part of nfs-utils for several
years, it's time to take the next step toward that goal: ensure that
the nfsref command (and the appropriate logic inside of mountd) is
built and available by default.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 configure.ac |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4ade528d72e8..e95075671571 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,14 +175,14 @@ else
 fi
 
 AC_ARG_ENABLE(sbin-override,
-	[AS_HELP_STRING([--disable-sbin-override],[Don't force nfsdcltrack and mount helpers into /sbin: always honour --sbindir])],
+	[AS_HELP_STRING([--disable-sbin-override],[Do not force nfsdcltrack and mount helpers into /sbin: always honour --sbindir])],
 	enable_sbin_override=$enableval,
 	enable_sbin_override=yes)
 	AM_CONDITIONAL(CONFIG_SBIN_OVERRIDE, [test "$enable_sbin_override" = "yes"])
 AC_ARG_ENABLE(junction,
-	[AS_HELP_STRING([--enable-junction],[enable support for NFS junctions @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-junction],[enable support for NFS junctions @<:@default=yes@:>@])],
 	enable_junction=$enableval,
-	enable_junction=no)
+	enable_junction=yes)
 	if test "$enable_junction" = yes; then
 		AC_DEFINE(HAVE_JUNCTION_SUPPORT, 1,
                           [Define this if you want junction support compiled in])


