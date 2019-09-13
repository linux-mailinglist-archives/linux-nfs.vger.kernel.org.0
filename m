Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C238DB1DA2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 14:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfIMM3F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 08:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbfIMM3F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Sep 2019 08:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19D8B307D91F;
        Fri, 13 Sep 2019 12:29:05 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6CC160E1C;
        Fri, 13 Sep 2019 12:29:04 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 1D3AE109C550; Fri, 13 Sep 2019 08:29:04 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] nfs_instantiate() might succeed leaving dentry negative unhashed
Date:   Fri, 13 Sep 2019 08:29:01 -0400
Message-Id: <cover.1568377101.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 12:29:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After adding commit b0c6108ecf64 ("nfs_instantiate(): prevent multiple
aliases for directory inode") my NFS client crashes while doing lustre race
tests simultaneously on a local filesystem and the same filesystem exported
via knfsd:

    BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
     Call Trace:
      ? iput+0x76/0x200
      ? d_splice_alias+0x307/0x3c0
      ? dput.part.31+0x96/0x110
      ? nfs_instantiate+0x45/0x160 [nfs]
      nfs3_proc_setacls+0xa/0x20 [nfsv3]
      nfs3_proc_create+0x1cc/0x230 [nfsv3]
      nfs_create+0x83/0x160 [nfs]
      path_openat+0x11aa/0x14d0
      do_filp_open+0x93/0x100
      ? __check_object_size+0xa3/0x181
      do_sys_open+0x184/0x220
      do_syscall_64+0x5b/0x1b0
      entry_SYSCALL_64_after_hwframe+0x65/0xca

   158 static int __nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
   159         struct posix_acl *dfacl)
   160 {
161     struct nfs_server *server = NFS_SERVER(inode);

The 0x28 offset is i_sb in struct inode, we passed a NULL inode to
nfs3_proc_setacls().

After taking this apart, I find the dentry in R12 has a NULL inode after
nfs_instantiate(), which makes sense if we move it to the alias just after
nfs_fhget() (See the referenced commit above).  Indeed, on the list of
children is the identical positive dentry that is left behind after
d_splice_alias().  Moving it would usualy be fine for callers, except for
NFSv3 because we want the inode pointer to ride the dentry back up the
stack so we can set ACLs on it and/or set attributes in the case of EXCLUSIVE.

The first patch splits up nfs_instantiate() so that we can have two call
paths, the original - whose callers don't care about what dentry ends up
hashed, and a new one that returns the dentry or the alias.

The second patch modifies NFSv3 to use the latter path for callers that need
to reference the dentry.

The third patch removes a test for positive dentry that seems to be
impossible - I can't find a path for it, and it has never been hit in all my
testing.

Benjamin Coddington (3):
  NFS: Refactor nfs_instantiate() for dentry referencing callers
  NFSv3: use nfs_add_or_obtain() to create and reference inodes
  NFS: remove unused check for negative dentry

 fs/nfs/dir.c           | 41 +++++++++++++++++++++++---------------
 fs/nfs/nfs3proc.c      | 45 +++++++++++++++++++++++++++++++++---------
 include/linux/nfs_fs.h |  3 +++
 3 files changed, 64 insertions(+), 25 deletions(-)

-- 
2.20.1

