Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B48489F6E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 19:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiAJSog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 10 Jan 2022 13:44:36 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34046 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiAJSog (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 13:44:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BA9B562DA605;
        Mon, 10 Jan 2022 19:44:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sUDv8MeZs_jk; Mon, 10 Jan 2022 19:44:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3769762DA5FD;
        Mon, 10 Jan 2022 19:44:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LKITl-soksNE; Mon, 10 Jan 2022 19:44:34 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id AD1D462DA5F3;
        Mon, 10 Jan 2022 19:44:33 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 0/3] Dealing with NFS re-export and cross mounts
Date:   Mon, 10 Jan 2022 19:44:16 +0100
Message-Id: <20220110184419.27665-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently when re-exporting a NFS share the NFS cross mount feature does
not work [0].
This RFC patch series outlines an approach to address the problem.

Crossing mounts does not work for two reasons:

1. As soon the NFS client (on the re-exporting server) sees a different
filesystem id, it installs an automount. That way the other filesystem
will be mounted automatically when someone enters the directory.
But the cross mount logic of KNFS does not know about automount.
The three patches in this series address the problem and teach both KNFSD
and the exportfs logic of NFS to deal with automount.

2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to install
a new export for the target mount point. Beside of authentication rpc.mountd
also has to find a filesystem id for the new export. Is the to be exported
filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it and
refuses to export. In the logs you’ll see error such as:
mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or fsid= required
To deal with that I changed rpc.mountd to use an arbitrary fsid.
Since this is a gross hack we need to agree on an approach to derive filesystem
ids for NFS mounts.

rpc.mountd could:
a) re-use the fsid from the original NFS server.
   Beside of requesting this information, the problem with that approach is
   that the original fsid might conflict with an existing export.
b) derive the fsid from stat->st_dev.
c) allocate a free fsid.
 
One use case to consider is load balancing. When multiple NFS servers re-export
a NFS mount, they need to use the same fsid for crossed mounts.
So I'm a little puzzled which approach is best. What do you think?

Known issues:
- Only tested with NFSv3 (both server and client) so far.

[0] https://marc.info/?l=linux-nfs&m=161653016627277&w=2

Richard Weinberger (3):
  NFSD: Teach nfsd_mountpoint() auto mounts
  fs: namei: Allow follow_down() to uncover auto mounts
  NFS: nfs_encode_fh: Remove S_AUTOMOUNT check

 fs/namei.c      | 2 +-
 fs/nfs/export.c | 5 -----
 fs/nfsd/vfs.c   | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.26.2

