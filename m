Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90DA6CC997
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC1RsC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC1RsB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 13:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE41CC32
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 10:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EB0618E1
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 17:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29950C433EF;
        Tue, 28 Mar 2023 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680025679;
        bh=U3auZYN3kOn3uotJ69P++5hFS+l6G8oULTnqR/CRgfY=;
        h=Subject:From:To:Cc:Date:From;
        b=ucWiK5K9cHxj/L8HzNN3Ga6rr7vJ6uWMrbQsRz7R3ytjEucOJYSuAC02DNI/rglgX
         /TbWw0C4uK4MsbvFZWCB78nDt4C5hzWcwii7PuYCZneS2zRXMLQ7enGzPxGqfbRIIW
         Exxru6OvQbat9RYaEGNnYnu79q2pk3MRnzeKXvno024UkP1wWP29KVLMKf8QEvQpPm
         nzhSXjqF2SLvw3TrK/GfQSk3FlWlskY0pYzY9Lgpf+lmGb2VKEPi5X7e2mbeaoCk4B
         fMucJw6JrjT0s+JHS4DyUwnnQKm9a0YuELHXFyNzuwKTOSQK3etRao69AQ3hfbaZSj
         ozFqpIbsgKE4g==
Subject: [PATCH RFC] NFS: Remove "select RPCSEC_GSS_KRB5
From:   Chuck Lever <cel@kernel.org>
To:     geert@linux-m68k.org, niklas.soderlund@ragnatech.se
Cc:     trondmy@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Date:   Tue, 28 Mar 2023 13:47:58 -0400
Message-ID: <168002567806.5713.3669559049257722084.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

If CONFIG_CRYPTO=n (e.g. arm/shmobile_defconfig):

   WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
     Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
     Selected by [y]:
     - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]

As NFSv4 can work without crypto enabled, remove the RPCSEC_GSS_KRB5
dependency altogether.

Trond says:
> It is possible to use the NFSv4.1 client with just AUTH_SYS, and
> in fact there are plenty of people out there using only that. The
> fact that RFC5661 gets its knickers in a twist about RPCSEC_GSS
> support is largely irrelevant to those people.
>
> The other issue is that ’select’ enforces the strict dependency
> that if the NFS client is compiled into the kernel, then the
> RPCSEC_GSS and kerberos code needs to be compiled in as well: they
> cannot exist as modules.

Fixes: e57d065277387980 ("NFS & NFSD: Update GSS dependencies")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 450d6c3bc05e..c1c7ed2fd860 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -75,7 +75,6 @@ config NFS_V3_ACL
 config NFS_V4
 	tristate "NFS client support for NFS version 4"
 	depends on NFS_FS
-	select RPCSEC_GSS_KRB5
 	select KEYS
 	help
 	  This option enables support for version 4 of the NFS protocol


