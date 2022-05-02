Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FA516C89
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383907AbiEBIzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383935AbiEBIzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 04:55:11 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B323613D7F
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 01:51:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 13F0E6081107;
        Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EprieeZUBtX5; Mon,  2 May 2022 10:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 22A0E6081104;
        Mon,  2 May 2022 10:51:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4oUXqAGU8Cth; Mon,  2 May 2022 10:51:28 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 9752A608F44C;
        Mon,  2 May 2022 10:51:27 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, steved@redhat.com,
        chris.chilvers@appsbroker.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/5] nfs-utils: Improving NFS re-exports 
Date:   Mon,  2 May 2022 10:50:40 +0200
Message-Id: <20220502085045.13038-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is the first non-RFC iteration of the NFS re-export
improvement series for nfs-utils.
While the kernel side[0] didn't change at all and is still small,
the userspace side saw much more changes.

The core idea is adding new export option: reeport=3D
Using reexport=3D it is possible to mark an export entry in the exports
file explicitly as NFS re-export and select a strategy how unique
identifiers should be provided.
Currently two strategies are supported, "auto-fsidnum" and
"predefined-fsidnum", both use a SQLite database as backend to keep
track of generated ids.
For a more detailed description see patch "exports: Implement new export =
option reexport=3D".
I choose SQLite because nfs-utils already uses it and using SQL ids can n=
icely
generated and maintained. It will also scale for large setups where the a=
mount
of subvolumes is high.

Beside of id generation this series also addresses the reboot problem.
If the re-exporting NFS server reboots, uncovered NFS subvolumes are not =
yet
mounted and file handles become stale.
Now mountd/exportd keeps track of uncovered subvolumes and makes sure the=
y get
uncovered while nfsd starts.

The whole set of features is currently opt-in via --enable-reexport.
I'm also not sure about the rearrangement of the reexport code,
currently it is a helper library.

A typical export entry on a re-exporting server looks like:
	/nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=3Dauto-fsidn=
um)
reexport=3Dauto-fsidnum will automatically assign an fsid=3D to /nfs and =
all
uncovered subvolumes.

Richard Weinberger (5):
  Implement reexport helper library
  exports: Implement new export option reexport=3D
  export: Implement logic behind reexport=3D
  export: Avoid fsid=3D conflicts
  reexport: Make state database location configurable

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=3D=
nfs_reexport_clean

 configure.ac                   |  12 ++
 nfs.conf                       |   3 +
 support/Makefile.am            |   4 +
 support/export/Makefile.am     |   2 +
 support/export/cache.c         |  71 ++++++-
 support/export/export.c        |  27 ++-
 support/include/nfslib.h       |   1 +
 support/nfs/Makefile.am        |   1 +
 support/nfs/exports.c          |  68 +++++++
 support/reexport/Makefile.am   |   6 +
 support/reexport/reexport.c    | 354 +++++++++++++++++++++++++++++++++
 support/reexport/reexport.h    |  39 ++++
 systemd/Makefile.am            |   4 +
 systemd/nfs-server-generator.c |  14 +-
 systemd/nfs.conf.man           |   6 +
 utils/exportd/Makefile.am      |   8 +-
 utils/exportd/exportd.c        |   5 +
 utils/exportfs/Makefile.am     |   6 +
 utils/exportfs/exportfs.c      |  21 +-
 utils/exportfs/exports.man     |  31 +++
 utils/mount/Makefile.am        |   7 +
 utils/mountd/Makefile.am       |   6 +
 utils/mountd/mountd.c          |   1 +
 utils/mountd/svc_run.c         |   6 +
 24 files changed, 690 insertions(+), 13 deletions(-)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/reexport.c
 create mode 100644 support/reexport/reexport.h

--=20
2.31.1

