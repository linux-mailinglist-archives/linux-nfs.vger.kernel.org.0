Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161A14795CE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhLQUzC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:55:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40046 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbhLQUzB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:55:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77340623AA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C9BC36AE5;
        Fri, 17 Dec 2021 20:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639774500;
        bh=XMjgZvkiHJrooydYRiWDd0QzZhLLk7tiOf/0TKkXaHE=;
        h=From:To:Cc:Subject:Date:From;
        b=StIHM9e2TyIulGXQl0zp6n03QzOugUPTz0FJJB9FJZhyi0X7HwIADaTddqpBLdhQB
         6AfP4pfqGkDnIthHxmmRCYpcW+HR5GjHnm9uMKB1vLKkSveVKYYWjI0nfLcIEh5pAA
         5mJY0PwTt949K/WaeRL3lxkLygtZD+nxPuFPUI68Aj04q7oaK1Xtyfxqx/X7RFEzRV
         JnK6ry9mqDjPad1J7zEUd1U35weRHmwpUCOADNjYXbgx3jlTvkl3pMqxmQvBFqITTy
         Lo9kFYJl5Lz3KIoUjYklggo2ohsg3sJobqJeAV0NAM7wD1ZrjrfIj2fbILblTedDZU
         2iMSfchD2ieTw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Date:   Fri, 17 Dec 2021 15:48:46 -0500
Message-Id: <20211217204854.439578-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

NFSv4 has support for a number of extra attributes that are of interest
to Samba when it is used to re-export a filesystem to Windows clients.
Aside from the btime, which is of interest in statx(), Windows clients
have an interest in determining the status of the 'hidden', and 'system'
flags.
Backup programs want to read the 'archive' flags and the 'time backup'
attribute.
Finally, the 'offline' flag can tell whether or not a file needs to be
staged by an HSM system before it can be read or written to.

The patch series also adds an ioctl() to allow userspace retrieval and
setting of these attributes where appropriate. It also adds an ioctl()
to allow retrieval of the raw NFSv4 ACCESS information, to allow more
fine grained determination of the user's access rights to a file or
directory. All of this information is of use for Samba.

Anne Marie Merritt (3):
  nfs: Add timecreate to nfs inode
  nfs: Add 'archive', 'hidden' and 'system' fields to nfs inode
  nfs: Add 'time backup' to nfs inode

Richard Sharpe (1):
  NFS: Support statx_get and statx_set ioctls

Trond Myklebust (4):
  NFS: Expand the type of nfs_fattr->valid
  NFS: Return the file btime in the statx results when appropriate
  NFSv4: Support the offline bit
  NFSv4: Add an ioctl to allow retrieval of the NFS raw ACCESS mask

 fs/nfs/dir.c              |  71 ++---
 fs/nfs/getroot.c          |   3 +-
 fs/nfs/inode.c            | 147 +++++++++-
 fs/nfs/internal.h         |  10 +
 fs/nfs/nfs3proc.c         |   1 +
 fs/nfs/nfs4_fs.h          |  31 +++
 fs/nfs/nfs4file.c         | 550 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         | 175 +++++++++++-
 fs/nfs/nfs4trace.h        |   8 +-
 fs/nfs/nfs4xdr.c          | 240 +++++++++++++++--
 fs/nfs/nfstrace.c         |   5 +
 fs/nfs/nfstrace.h         |   9 +-
 fs/nfs/proc.c             |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs.h    |  15 ++
 include/linux/nfs_fs_sb.h |   2 +-
 include/linux/nfs_xdr.h   |  80 ++++--
 include/uapi/linux/nfs.h  | 101 +++++++
 18 files changed, 1356 insertions(+), 94 deletions(-)

-- 
2.33.1

