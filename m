Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293372D6BC8
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393483AbgLJXTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Dec 2020 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393227AbgLJXTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Dec 2020 18:19:03 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C48C061248
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 14:35:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a8so10598505lfb.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 14:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QqmYo0enGwYpDJHSeYez1v7I2dhJPknDpJw0vA+IL2M=;
        b=YXBgW38fuunACkscgslN3JNUKQQDnLtfRXOqj6sNQn4u9dV0CFVVVln7o/yRMF2r3l
         S5mq7H8SA7r9X58ITchiI7T//XyVsjBha/pLoCUjKvG6cBV41VF/TfLURxXsor549Mxp
         lRnPnTDd9TD7eX+N3Ua1MDh1uJL29BDGYvEVPz+rrutzvtY5uGASVPtKzG0sMbzGDekS
         sLzRs88FQvhUDV9Uch/VVpQvb9w8RFlJjmpExO0YaTPn8U2Adkv2jzkumamU981HHYCK
         F81PEMEqCpV6IJkCIUMrF9T8DqbZo2p9olnyz/Y2MmPSI8zBtvtBSLnetuNdPxudLys5
         HBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QqmYo0enGwYpDJHSeYez1v7I2dhJPknDpJw0vA+IL2M=;
        b=WkN6vgsr9YRS9KbYoc35f/ZUUO7EKk2V6MLoy87n0wldE2l9e3MB33zCjtCOooxby+
         82mcwxyNiEGPgaEAR9Gj2LlxaAhMukgb06jXUCEN9JrP587647gDlmvPar6ROvg1fysp
         VybWTHr8bqbo8CnH6IJRNUAL61cnJcEN0k+WlIzuOX+36K92tkKUb9rmbhXRFDuF1hL3
         FITHR56mR35uL2805jN9GF66nOewsDRNcurYF0QHw6YPf8ujvXaLqYXSHLb9D3CGYehF
         zW3CS8QG16R9bHApl3inuz0DOx6NT/tlYWMzRN72wQHcrUw65IiVTs2Lsey+Js96J3+2
         L8jw==
X-Gm-Message-State: AOAM530zv2YkEMTv52kMb6nU8U78ZB6jZ16rRWTt3BquVf8xjv37I9Dl
        vOMKFI6698ZiD2tGummFKU2OWowOj7btXmE2QxnUS3PEz0M=
X-Google-Smtp-Source: ABdhPJwAurx3h1oBazgy+RHg8maxwnlqNdp1RyHCl3RkWrlXt8SBvAEL46eLGfxRUrsqEkgE3iCPxWXPrZbc+R9XBng=
X-Received: by 2002:a50:fc13:: with SMTP id i19mr9171002edr.281.1607637453474;
 Thu, 10 Dec 2020 13:57:33 -0800 (PST)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 10 Dec 2020 16:57:17 -0500
Message-ID: <CAFX2JfmhOBA6n9P_hJK1AbEUD3-k5wP8a9oeWUEZ56E2trQw5g@mail.gmail.com>
Subject: [GIT PULL] Please pull a few more NFS Client bugfixes for 5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-3

for you to fetch changes up to 21e31401fc4595aeefa224cd36ab8175ec867b87:

  NFS: Disable READ_PLUS by default (2020-12-10 16:48:03 -0500)

----------------------------------------------------------------
Here are a handful more bugfixes for 5.10. Unfortunately, we found
some problems with the new READ_PLUS operation that aren't easy to
fix. We've decided to disable this codepath through a Kconfig option
for now, but a series of patches going into 5.11 will clean up the
code and fix the issues at the same time. This seemed like the best
way to go about it.

Thanks,
Anna
----------------------------------------------------------------
Anna Schumaker (1):
      NFS: Disable READ_PLUS by default

Chuck Lever (1):
      NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS operation

Dai Ngo (1):
      NFSv4.2: Fix 5 seconds delay when doing inter server copy

Trond Myklebust (1):
      pNFS/flexfiles: Fix array overflow when flexfiles mirroring is enabled

 fs/nfs/Kconfig                         |  9 +++++++++
 fs/nfs/flexfilelayout/flexfilelayout.c | 27 +++++++++++++++++++++------
 fs/nfs/nfs42proc.c                     | 21 +++++++++++++--------
 fs/nfs/nfs42xdr.c                      |  1 -
 fs/nfs/nfs4file.c                      |  2 +-
 fs/nfs/nfs4proc.c                      |  2 +-
 fs/nfs/pagelist.c                      | 36
+++++++++++++++++++++++++++---------
 include/linux/nfs_page.h               |  4 ++++
 8 files changed, 76 insertions(+), 26 deletions(-)
