Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9346D59F9
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjDDHvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 03:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDDHvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 03:51:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50610FF
        for <linux-nfs@vger.kernel.org>; Tue,  4 Apr 2023 00:50:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 171AA64548A3;
        Tue,  4 Apr 2023 09:50:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L4lUxN4ac9Ld; Tue,  4 Apr 2023 09:50:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B39264551A5;
        Tue,  4 Apr 2023 09:50:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3uaex0Y-GfQ4; Tue,  4 Apr 2023 09:50:54 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 90D3864551A3;
        Tue,  4 Apr 2023 09:50:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/2 v2] nfs-utils: Improving NFS re-export wrt. crossmnt
Date:   Tue,  4 Apr 2023 09:50:37 +0200
Message-Id: <20230404075039.10802-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
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
    	/nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=3Dauto-f=
sidnum)
reexport=3Dauto-fsidnum will automatically assign an fsid=3D to /nfs and =
all
uncovered subvolumes.

Changes since v1, https://lore.kernel.org/linux-nfs/20220502085045.13038-=
1-richard@nod.at/
	- Factor out Sqlite and put it into a daemon
	- Add fsidd
	- Basically re-implemented the patch series
	- Lot's of fixes (e.g. nfs v4 root export)


Richard Weinberger (2):
  export: Add reexport=3D option
  Implement fsidd

 configure.ac                      |   1 +
 support/Makefile.am               |   2 +-
 support/export/Makefile.am        |   2 +
 support/export/cache.c            |  74 ++++++-
 support/export/export.c           |  27 ++-
 support/include/nfslib.h          |   1 +
 support/nfs/Makefile.am           |   1 +
 support/nfs/exports.c             |  62 ++++++
 support/reexport/Makefile.am      |  18 ++
 support/reexport/backend_sqlite.c | 267 ++++++++++++++++++++++++
 support/reexport/fsidd.c          | 198 ++++++++++++++++++
 support/reexport/reexport.c       | 327 ++++++++++++++++++++++++++++++
 systemd/Makefile.am               |   2 +
 systemd/fsidd.service             |   9 +
 utils/exportd/Makefile.am         |   6 +-
 utils/exportd/exportd.c           |   5 +
 utils/exportfs/Makefile.am        |   3 +
 utils/exportfs/exportfs.c         |  11 +
 utils/exportfs/exports.man        |  31 +++
 utils/mount/Makefile.am           |   3 +-
 utils/mountd/Makefile.am          |   2 +
 21 files changed, 1041 insertions(+), 11 deletions(-)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/backend_sqlite.c
 create mode 100644 support/reexport/fsidd.c
 create mode 100644 support/reexport/reexport.c
 create mode 100644 systemd/fsidd.service

--=20
2.31.1

