Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A094BA0FF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiBQNXN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbiBQNXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F9996B8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 15AA660D482C;
        Thu, 17 Feb 2022 14:16:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VIOP6svHJhew; Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3F602608A39E;
        Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nRZj-tj4N9gg; Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B624F608898A;
        Thu, 17 Feb 2022 14:16:37 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports 
Date:   Thu, 17 Feb 2022 14:15:25 +0100
Message-Id: <20220217131531.2890-1-richard@nod.at>
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

This is the second iteration of the NFS re-export improvement series for =
nfs-utils.
While the kernel side didn't change at all and is still small,
the userspace side saw much more changes.
Please note that this is still an RFC, there is room for improvement.

The core idea is adding new export option: reeport=3D
Using reexport=3D it is possible to mark an export entry in the exports f=
ile
explicitly as NFS re-export and select a strategy how unique identifiers
should be provided.
"remote-devfsid" is the strategy I have proposed in my first patch,
I understand that this one is dangerous. But I still find it useful in so=
me
situations.
"auto-fsidnum" and "predefined-fsidnum" are new and use a SQLite database=
 as
backend to keep track of generated ids.
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

Please let me know whether you like this approach.
If so I'd tidy it up and submit it as non-RFC.

TODOs/Open questions:
- When re-exporting, fs.nfs.nfs_mountpoint_timeout should be set to 0
  to make subvolumes not vanish.
  Is this something exportfs should do automatically when it sees an expo=
rt entry with a reexport=3D option?
- exportd saw only minimal testing so far, I wasn't aware of it yet. :-S
- Currently wtere is no way to release the shared memory which contains t=
he database lock.
  I guess it could be released via exportfs -f, which is the very last ex=
ec in nfs-server.service
- Add a tool to import/export entries from the reexport database which ob=
eys the shared lock.
- When doing v4->v4 or v3->v4 re-exports very first read access to a file=
 block a few seconds until
  the client does a retransmit.=20
  v3->v3 works fine. More investigation needed.

Looking forward for your feedback!

Thanks,
//richard

Richard Weinberger (6):
  Implement reexport helper library
  exports: Implement new export option reexport=3D
  export: Implement logic behind reexport=3D
  export: Record mounted volumes
  nfsd: statfs() every known subvolume upon start
  export: Garbage collect orphaned subvolumes upon start

 configure.ac                 |  12 +
 support/Makefile.am          |   4 +
 support/export/Makefile.am   |   2 +
 support/export/cache.c       | 241 +++++++++++++++++-
 support/export/export.h      |   3 +
 support/include/nfslib.h     |   1 +
 support/nfs/Makefile.am      |   1 +
 support/nfs/exports.c        |  73 ++++++
 support/reexport/Makefile.am |   6 +
 support/reexport/reexport.c  | 477 +++++++++++++++++++++++++++++++++++
 support/reexport/reexport.h  |  53 ++++
 utils/exportd/Makefile.am    |   8 +-
 utils/exportd/exportd.c      |  17 ++
 utils/exportfs/Makefile.am   |   4 +
 utils/mount/Makefile.am      |   6 +
 utils/mountd/Makefile.am     |   6 +
 utils/mountd/mountd.c        |   1 +
 utils/mountd/svc_run.c       |  18 ++
 utils/nfsd/Makefile.am       |   6 +
 utils/nfsd/nfsd.c            |  10 +
 20 files changed, 934 insertions(+), 15 deletions(-)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/reexport.c
 create mode 100644 support/reexport/reexport.h

--=20
2.31.1

