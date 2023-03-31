Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DD6D292B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Mar 2023 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCaULO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Mar 2023 16:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCaULM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Mar 2023 16:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067E21A82
        for <linux-nfs@vger.kernel.org>; Fri, 31 Mar 2023 13:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5704462B98
        for <linux-nfs@vger.kernel.org>; Fri, 31 Mar 2023 20:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4BAC433D2;
        Fri, 31 Mar 2023 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680293470;
        bh=gEPoQYDYErEXE/Hv1KYLIJmKg35Y9pwcR2pLZVKeAh4=;
        h=From:To:Cc:Subject:Date:From;
        b=enwfHoLsighm+3B5yc8tdhhj1uR1vbhWFL5Z42XRGEWbcGC6gfhdhmXoNOSYuXXzg
         TnqLgFT6NObHItU+09QMDnVQ7182YlXRCmOo+MF2Zfva5U/8M4lkcEURmVf+PvdDA3
         4sqGPUKz25rNlp7tkQZ1o2lmeansWQ25aJJ3eGIMsW3jB0lRu7sfuvGZ9HXGT6zxvL
         ucRdOskpsgWUi6aaR3xJphNwHIG0lVQd+zVzzu0/Wr9m99O4VfHEIW3jWdzHZ/wTcx
         zVh3x4lJqRlNh9uFg4y/g7BC25oZvPPV92WmskOhtdIoIdBFVAqfxdcnHTvsIExp/R
         +H9671ix/icuw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please Pull a few more NFS Client Bugfixes for Linux v6.3-rc
Date:   Fri, 31 Mar 2023 16:11:09 -0400
Message-Id: <20230331201109.2262541-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 21fd9e8700de86d1169f6336e97d7a74916ed04a:

  NFS: Correct timing for assigning access cache timestamp (2023-03-14 15:19:44 -0400)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-3

for you to fetch changes up to 943d045a6d796175e5d08f9973953b1d2c07d797:

  SUNRPC: fix shutdown of NFS TCP client socket (2023-03-23 15:50:16 -0400)

----------------------------------------------------------------
More NFS Client Bugfixes for Linux 6.3-rc

Bugfixes:
  * Fix shutdown of NFS TCP client sockets
  * Fix hangs when recovering open state after a server reboot

Thanks,
Anna

----------------------------------------------------------------
Siddharth Kawar (1):
      SUNRPC: fix shutdown of NFS TCP client socket

Trond Myklebust (1):
      NFSv4: Fix hangs when recovering open state after a server reboot

 fs/nfs/nfs4proc.c     | 5 ++---
 net/sunrpc/xprtsock.c | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)
