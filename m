Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D096E5D7B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDRJe2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjDRJeV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:21 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2625BA7
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0807664548A1;
        Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z--oRbAiSMtN; Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5DBEF6431C4A;
        Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sLk15qvYL8iY; Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id F13D063CC168;
        Tue, 18 Apr 2023 11:34:11 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/8 v3] nfs-utils: Improving NFS re-export wrt. crossmnt
Date:   Tue, 18 Apr 2023 11:33:42 +0200
Message-Id: <20230418093350.4550-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After a longer hiatus I'm sending the next iteration of my re-export
improvement patch series. While the kernel side is upstream since v6.2,
the nfs-utils parts are still missing.
This patch series aims to solve this.

The core idea is adding new export option, reeport=3D
Using reexport=3D it is possible to mark an export entry in the exports
file explicitly as NFS re-export and select a strategy on how unique
identifiers should be provided. This makes the crossmnt feature work
in the re-export case.
Currently two strategies are supported, "auto-fsidnum" and
"predefined-fsidnum".

In my earlier series a sqlite database was mandatory to keep track of
generated fsids.
This series follows a different approach, instead of directly using
sqlite in all nfs-utils components (linking libsqlite), a new deamon
manages the database, fsidd.
fsidd offers a simple (but stupid?) text based interface over a unix doma=
in
socket which can be queried by mountd, exportfs, etc. for fsidnums.
The main idea behind fsidd is allowing users to implement their own
fsidd which keeps global state across load balancers.
I'm still not happy with fsidd, there is room for improvement but first
I'd like to know whether you like or hate this approach.

A typical export entry on a re-exporting server looks like:
        /nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=3Daut=
o-fsidnum)
reexport=3Dauto-fsidnum will automatically assign an fsid=3D to /nfs and =
all
uncovered subvolumes.

Changes since v2, https://lore.kernel.org/linux-nfs/20230404111308.23465-=
1-richard@nod.at/
	- Split patch series
	- Add improved fsidd system unit file
	- Rebased to nfs-utils master as of today
	- Dropped init code from exportd

Changes since v1, https://lore.kernel.org/linux-nfs/20220502085045.13038-=
1-richard@nod.at/
        - Factor out Sqlite and put it into a daemon
        - Add fsidd
        - Basically re-implemented the patch series
        - Lot's of fixes (e.g. nfs v4 root export)


Richard Weinberger (8):
  Add reexport helper library
  Implement reexport=3D export option
  export: Wireup reexport mechanism
  export: Uncover NFS subvolume after reboot
  exports.man: Document reexport=3D option
  reexport: Add sqlite backend
  export: Add fsidd
  Add fsid systemd service file

 configure.ac                        |   1 +
 support/Makefile.am                 |   2 +-
 support/export/Makefile.am          |   2 +
 support/export/cache.c              |  74 ++++++-
 support/export/export.c             |  20 ++
 support/include/nfslib.h            |   1 +
 support/nfs/Makefile.am             |   1 +
 support/nfs/exports.c               |  62 ++++++
 support/reexport/Makefile.am        |  18 ++
 support/reexport/backend_sqlite.c   | 267 +++++++++++++++++++++++
 support/reexport/fsidd.c            | 198 +++++++++++++++++
 support/reexport/reexport.c         | 326 ++++++++++++++++++++++++++++
 support/reexport/reexport.h         |  18 ++
 support/reexport/reexport_backend.h |  47 ++++
 systemd/Makefile.am                 |   5 +-
 systemd/fsidd.service               |  10 +
 utils/exportd/Makefile.am           |   4 +-
 utils/exportfs/Makefile.am          |   3 +
 utils/exportfs/exportfs.c           |  11 +
 utils/exportfs/exports.man          |  31 +++
 utils/mount/Makefile.am             |   3 +-
 utils/mountd/Makefile.am            |   2 +
 22 files changed, 1096 insertions(+), 10 deletions(-)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/backend_sqlite.c
 create mode 100644 support/reexport/fsidd.c
 create mode 100644 support/reexport/reexport.c
 create mode 100644 support/reexport/reexport.h
 create mode 100644 support/reexport/reexport_backend.h
 create mode 100644 systemd/fsidd.service

--=20
2.31.1

