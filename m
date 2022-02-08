Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0090C4AE375
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386264AbiBHWWz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386236AbiBHTsD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 14:48:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF1C0613CB;
        Tue,  8 Feb 2022 11:48:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE31615DB;
        Tue,  8 Feb 2022 19:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A1AC004E1;
        Tue,  8 Feb 2022 19:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644349682;
        bh=c8q0TxHVTjf4aNkQStcXVJSZB5mKfeuVp0Hhu1DcxMk=;
        h=From:To:Cc:Subject:Date:From;
        b=VJ8gWT14MPgCcP1GFBoBKr73DvfGR5bYwQHRF6+IKxXnNzBDMraPC5jdM2W2PVzVc
         UEDDOcs828zHRI5VxgF+SK4pnxDWCJDDq7pkBHJLFtwhNMUUBc8Heu+OHRRXUSdl8q
         e9OMtJQ3G1F6YxQUxM2i5cASx8thwaqIPtcSPhys6Lty3CebQfVOZ4s9ORqCc4/XcN
         6vsPMwVJFWlzKr8FmUSqx7JT8CIB3OZfOT9lgj4TqTS9zXLXTsrXhJHXj3A4nt1Aph
         452lraqlJnJY58NqcCC0DptsKFKU9nNBFrhiL3v/OgoXhZxJXerxYOAnS3Ozf1aFa/
         Se9rQVk1a2fiw==
From:   anna@kernel.org
To:     torvalds@linux-foundation.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please Pull NFS Client Bugfixes for Linux v5.17-rc
Date:   Tue,  8 Feb 2022 14:48:00 -0500
Message-Id: <20220208194800.482704-1-anna@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-2

for you to fetch changes up to b49ea673e119f59c71645e2f65b3ccad857c90ee:

  SUNRPC: lock against ->sock changing during sysfs read (2022-02-08 09:14:26 -0500)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 5.17-rc

- Stable Fixes:
  - Fix initialization of nfs_client cl_flags

- Other Fixes:
  - Fix performance issues with uncached readdir calls
  - Fix potential pointer dereferences in rpcrdma_ep_create
  - Fix nfs4_proc_get_locations() kernel-doc comment
  - Fix locking during sunrpc sysfs reads
  - Update my email address in the MAINTAINERS file to my new kernel.org email

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (1):
      MAINTAINERS: Update my email address

Dan Aloni (1):
      xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create

NeilBrown (1):
      SUNRPC: lock against ->sock changing during sysfs read

Trond Myklebust (2):
      NFS: Avoid duplicate uncached readdir calls on eof
      NFS: Fix initialisation of nfs_client cl_flags field

Yang Li (1):
      NFS: Fix nfs4_proc_get_locations() kernel-doc comment

trondmy@kernel.org (2):
      NFS: Don't overfill uncached readdir pages
      NFS: Don't skip directory entries when doing uncached readdir

 MAINTAINERS                 |  2 +-
 fs/nfs/client.c             |  2 +-
 fs/nfs/dir.c                | 24 ++++++++++++++++++------
 fs/nfs/nfs4proc.c           |  3 ++-
 include/linux/nfs_fs.h      |  1 +
 net/sunrpc/sysfs.c          |  5 ++++-
 net/sunrpc/xprtrdma/verbs.c |  3 +++
 net/sunrpc/xprtsock.c       |  7 ++++++-
 8 files changed, 36 insertions(+), 11 deletions(-)
