Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937336B0BC2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 15:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjCHOrW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 09:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjCHOqx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 09:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FD5A91A
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 06:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F8206185A
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 14:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E130CC433EF;
        Wed,  8 Mar 2023 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678286711;
        bh=gXLySqewK8cf/jDKSdzRfKHpY8XLTcnk3SBaiwfvlXA=;
        h=Subject:From:To:Cc:Date:From;
        b=QUX0a3TcARbErqeD0ZCdFnkwjACYeVJU4UVu/7BxRHFaC55jz2yY2OPwzSKxsA5H5
         7QBEZAiDnC2AH2u4Qt8vyaGOd+BlgIKMZMVbsFvJIhyROBuPeJexhCiIE6QcAzovI3
         Y7+Hl1ujJ3evcaiQC9hVQZfUokLAueVaisPz+6q36d4kCUGpN5Yl1i2sMS1lGF6EgU
         9LtuXMweeKRTpwcry5a6Gh8HLeonZa83DMp0U6PSBwH3t4N5XjY+j6icIcHJyQNuDL
         q91d3Cdgl+tFyvfSkfu4zRlo124frdJTXYVYfec67w4jLSSkfbmbNjv57gXPdYFu39
         L4kBsY7SBLfqQ==
Subject: [PATCH RFC] NFS & NFSD: Update GSS dependencies
From:   Chuck Lever <cel@kernel.org>
To:     geert@linux-m68k.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Mar 2023 09:45:09 -0500
Message-ID: <167828670993.16253.6476667874038066881.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Geert reports that:
> On v6.2, "make ARCH=m68k defconfig" gives you
> CONFIG_RPCSEC_GSS_KRB5=m
> On v6.3, it became builtin, due to dropping the dependencies on
> the individual crypto modules.
>
> $ grep -E "CRYPTO_(MD5|DES|CBC|CTS|ECB|HMAC|SHA1|AES)" .config
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=m
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_CBC=m
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=m
> CONFIG_CRYPTO_HMAC=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_SHA1=m

This behavior is triggered by the "default y" in the definition of
RPCSEC_GSS.

The "default y" was added in 2010 by commit df486a25900f ("NFS: Fix
the selection of security flavours in Kconfig"). However,
svc_gss_principal was removed in 2012 by commit 03a4e1f6ddf2
("nfsd4: move principal name into svc_cred"), so the 2010 fix is
no longer necessary. We can safely change the NFS_V4 and NFSD_V4
dependencies back to RPCSEC_GSS_KRB5 to get the nicer v6.2
behavior back.

Selecting KRB5 symbolically represents the true requirement here:
that all spec-compliant NFSv4 implementations must have Kerberos
available to use.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/Kconfig  |    2 +-
 fs/nfsd/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..450d6c3bc05e 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -75,7 +75,7 @@ config NFS_V3_ACL
 config NFS_V4
 	tristate "NFS client support for NFS version 4"
 	depends on NFS_FS
-	select SUNRPC_GSS
+	select RPCSEC_GSS_KRB5
 	select KEYS
 	help
 	  This option enables support for version 4 of the NFS protocol
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 7c441f2bd444..43b88eaf0673 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -73,7 +73,7 @@ config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
 	select FS_POSIX_ACL
-	select SUNRPC_GSS
+	select RPCSEC_GSS_KRB5
 	select CRYPTO
 	select CRYPTO_MD5
 	select CRYPTO_SHA256


