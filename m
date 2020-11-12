Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F642B0B15
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKLRPk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgKLRPj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 12:15:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE480C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 09:15:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i19so8964904ejx.9
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zgAr2YD5FSCrEuWqU3x8j9dSy2p2WemsltjRt1Ix8lI=;
        b=kgfW2F7MelfrtjJPB22MjqF48CwVpRESk2phbG7oQWV0m5pf8vfk78nCqjhC4j0V1f
         rgj9nFTpi8KmqdTxJ5/5abAusxIs4jCLMd+VBMtHxeOIhll5TN00EZm6UCJxh7LamMn4
         hDdU9coFpHR5MlyJZUImyTUoj34tbfelG7av7pkOL7tj+beiMGIJTvNUVGcfHgEPlbrc
         DddulbcN44LobF2adcjNZ798lU3cMnvXR658NE0b90jMRlSaL0ZeuCEQwjcR+2hqDvxf
         6+P+l6xqNrsrykso4iwxUji6MpX0KXSFXL9id62ozncT2gVp8rUaKKTRM4/Imzj08/1h
         o9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zgAr2YD5FSCrEuWqU3x8j9dSy2p2WemsltjRt1Ix8lI=;
        b=Py+3WKP79SNzFVVBHlZlb3XZMb5DWSPmv2XvhVfTa1VLtj5lWNwsKLdm5G9ebJRXWe
         fe+bupmku1eMjRiFZgWyhu0lt11dSIbIm06ymSIUJxhKE65pVpjSxvQEKSfgr2n+twAs
         B/EafN7YrDM8su0XU1mPPrlnAE0ttiX+aMDsoHmDCyGffdq2FhugJOW5En1PfKOUcTUD
         QxCwpa0kQ5WkpnDmh72H3OSDtJwJn8keZSKiIrP3+9f4eNmW/BSBwIv5Bl+3kJTsCXWu
         Uz74eD2dCsChiZct/4VgmOSIqZIkycNjWoirVKxrE7ln1ZegYR3y7WDJLfZWDPPcqWtn
         hg5Q==
X-Gm-Message-State: AOAM531SIkjz8ZtQXLc5FN1rLQjQzVhQPxwWV3a+nw0lfugR2Mu6AcHL
        0aFaDmoDdLefqN6n0V6u/4QkWLSyvaIYqI0lCqbpMObtm44=
X-Google-Smtp-Source: ABdhPJzx1usCX1fvcPDM/GISkAsgBkej3/ooxoBpIF1elgFoub2tQ+kxcBWfiniDj77VhDZrd/xyDeeT5sNMK7s7jV4=
X-Received: by 2002:a17:906:6d89:: with SMTP id h9mr303363ejt.152.1605201338242;
 Thu, 12 Nov 2020 09:15:38 -0800 (PST)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 12 Nov 2020 12:15:22 -0500
Message-ID: <CAFX2Jfnq+spZtxSbsy+tiUPgcYP4pHCJ_d2BGTW4TTQKchgJpQ@mail.gmail.com>
Subject: [GIT PULL] Please pull NFS Client Bugfixes for Linux 5.10-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-2

for you to fetch changes up to 11decaf8127b035242cb55de2fc6946f8961f671:

  NFS: Remove unnecessary inode lock in nfs_fsync_dir() (2020-11-12
10:41:26 -0500)

----------------------------------------------------------------
One stable fix and a few other smaller fixes this time around:

- Stable fixes:
  - Fix failure to unregister shrinker

- Other fixes:
  - Fix unnecessary locking to clear up some contention
  - Fix listxattr receive buffer size
  - Fix default mount options for nfsroot

Thanks,
Anna
----------------------------------------------------------------
Chuck Lever (1):
      NFS: Fix listxattr receive buffer size

Helge Deller (1):
      nfsroot: Default mount option should ask for built-in NFS version

J. Bruce Fields (1):
      NFSv4.2: fix failure to unregister shrinker

Trond Myklebust (2):
      NFS: Remove unnecessary inode locking in nfs_llseek_dir()
      NFS: Remove unnecessary inode lock in nfs_fsync_dir()

 fs/nfs/dir.c        | 15 +++++----------
 fs/nfs/nfs42xattr.c |  2 ++
 fs/nfs/nfs42xdr.c   |  4 ++--
 fs/nfs/nfsroot.c    |  6 ++++++
 4 files changed, 15 insertions(+), 12 deletions(-)
