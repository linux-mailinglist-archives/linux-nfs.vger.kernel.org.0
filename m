Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD56339872
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 21:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhCLU3Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 15:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhCLU3B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 15:29:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC1C061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 12:29:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lr13so55815475ejb.8
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 12:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2pngxSMEkD3zujekYOOR2iRAViH6b04JymttWnLOPSE=;
        b=Dvkx6OQTsCOqXzklEl1dHqXFJfkUDrFfAoMm8i7Qodv7SXOgA5H+/utYNMrOMMnDQC
         UKGyzYu8kx5CT16pz8t2TMcu2RumQF8N3R6r+Yy/LKR9zIv0ndSE71SinyjrQhjMoxcv
         VK69VuHF5DN+TuolSaFsPK0jTiHfrmiDdSBOoS6EzTnXRmF8UjWq2bycMBHKdloQymzb
         3RDtE5DhaC3X70aVjFu2huzL5UcLVtOvMultCwxPmC48VYicuA/2Cp9HEhLlRNTBerMj
         jflU8uywwfMOl2Ce+s2mgTasSnF8MOBpsHrZX/LGN9dV/FJJgPNeZ2DDrQcFwq67PC6I
         onqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2pngxSMEkD3zujekYOOR2iRAViH6b04JymttWnLOPSE=;
        b=mXe8qidF8uQb0EXTbFRFmcY+6YJipNmptB2wQypzWp4xVX6st2fZUe4qDP7jodhMpF
         Yup2Pg0E46+HjWbnAmFbAYfnhlIfHHgp3z4yOoTewGi3d9sJuENxXaeOMJJ6dTwXs4mH
         x+HnvgrKpzQGqTQHQym505UuDOQMfM4ufQ77+kE3CBFIx9d7vCkYgO3gSqE4DbkQ52lA
         xAN3WY89W6AZypEgU/AU8yiSOKRS3dMOrY8mfnoYU9IsKs6/XDgEm67+7fV+BLMcEN78
         mmkl31w1Z43yU0m0z/aGzQS2EdAPCRsogKAUQklxK1ZHMGqgafU4MkSuQhPE4wEVcyRo
         tgpQ==
X-Gm-Message-State: AOAM532hid18Z6re1QcVj16Wdlcr0JIY9BFHXQEdLCz6PcIPd1TqN12P
        aF3ZaxHJiiYH/+sNDdcXXx091leg3zf4QW+0KbgNG1TE5nioAw==
X-Google-Smtp-Source: ABdhPJyvN+YpXgEfHEBpHn0VnQ6shoRfcjtMam8zwkMFKpkqCDvn1OZ2lkZiXjPpZThqZk/NAKdjFqZ3yJ5TyeM65/E=
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr10683602eju.439.1615580939944;
 Fri, 12 Mar 2021 12:28:59 -0800 (PST)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 12 Mar 2021 15:28:44 -0500
Message-ID: <CAFX2Jfks7yEAs9xhG-9Znwzzmiz8JpRQv9XDpOAEM=EaxhiEpA@mail.gmail.com>
Subject: [GIT PULL] Please pull NFS client bugfixes for 5.12-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.12-2

for you to fetch changes up to 4f8be1f53bf615102d103c0509ffa9596f65b718:

  nfs: we don't support removing system.nfs4_acl (2021-03-11 13:17:42 -0500)

----------------------------------------------------------------
These are mostly fixes for issues discovered at the recent NFS bakeathon

  - Fix PNFS_FLEXFILE_LAYOUT kconfig so it is possible to build into the kernel
  - Correct size calculationn for create reply length
  - Set memalloc_nofs_save() for sync tasks to prevent deadlocks
  - Don't revalidate directory permissions on lookup failure
  - Don't clear inode cache when lookup fails
  - Change functions to use nfs_set_cache_invalid() for proper
delegation handling
  - Fix return value of _nfs4_get_security_label()
  - Return an error when attempting to remove system.nfs4_acl

Thanks,
Anna
----------------------------------------------------------------
Benjamin Coddington (1):
      SUNRPC: Set memalloc_nofs_save() for sync tasks

Frank Sorenson (1):
      NFS: Correct size calculation for create reply length

J. Bruce Fields (1):
      nfs: we don't support removing system.nfs4_acl

Ondrej Mosnacek (1):
      NFSv4.2: fix return value of _nfs4_get_security_label()

Timo Rothenpieler (1):
      nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default

Trond Myklebust (5):
      NFS: Don't revalidate the directory permissions on a lookup failure
      NFS: Don't gratuitously clear the inode cache when lookup failed
      NFS: Clean up function nfs_mark_dir_for_revalidate()
      NFS: Fix open coded versions of nfs_set_cache_invalid()
      NFS: Fix open coded versions of nfs_set_cache_invalid() in NFSv4

 fs/nfs/Kconfig     |  2 +-
 fs/nfs/dir.c       | 58
+++++++++++++++++++++++++++++++++-------------------------
 fs/nfs/inode.c     |  7 ++++---
 fs/nfs/internal.h  |  3 ++-
 fs/nfs/nfs3xdr.c   |  3 ++-
 fs/nfs/nfs42proc.c | 12 +++++++-----
 fs/nfs/nfs4proc.c  | 33 ++++++++++++++++-----------------
 fs/nfs/unlink.c    |  6 +++---
 fs/nfs/write.c     |  8 ++++----
 net/sunrpc/sched.c |  5 ++++-
 10 files changed, 76 insertions(+), 61 deletions(-)
