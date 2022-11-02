Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744F161689E
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 17:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKBQYW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 12:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiKBQX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 12:23:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB004B34
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 09:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 821C0B823AB
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 16:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8278C433C1;
        Wed,  2 Nov 2022 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667405928;
        bh=vUnuy37s9d+5j59TKmNDq8aE/ypRT+3LCkQXiIhhHHo=;
        h=From:To:Cc:Subject:Date:From;
        b=cxqsOmZJIvRGketikfWMrltMO/yBzwpCwOfZ8Qq0og1k9LHgbMYr5P3IRVOqGdJRF
         0Vyo39o/qmVo4VuHB5Jxs6YVwUZ3OEi7XeyeM0iKBRxBbv5HY7AfCH0u78NOD82z7B
         Ikagb1YdVF4VsPO/RUpm8jX9X+wLKerndS54Ih/5iFS497V3MzysdbExtC1qq9deSu
         EIvw6SguTCTnsqXom4q8CZ6C2n+6mcrzCavPXuGidT3GpRebyhWHLR1+zpyjh3Y0km
         hPMpj18EgIYlJVRbboUOhYM3oTnTnLz01fiXf4aicaGa8MEzwdTut5XhJXPCqMohKr
         eFJJRVStyo4JQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please pull NFS Client Bugfixes for Linux v6.1-rc
Date:   Wed,  2 Nov 2022 12:18:46 -0400
Message-Id: <20221102161846.1376981-1-anna@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.1-2

for you to fetch changes up to 7e8436728e22181c3f12a5dbabd35ed3a8b8c593:

  nfs4: Fix kmemleak when allocate slot failed (2022-10-27 15:52:11 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.1-rc

Bugfixes:
  * Fix some coccicheck warnings
  * Avoid memcpy() run-time warning
  * Fix up various state reclaim / RECLAIM_COMPLETE errors
  * Fix a null pointer dereference in sysfs
  * Fix LOCK races
  * Fix gss_unwrap_resp_integ() crasher
  * Fix zero length clones
  * Fix memleak when allocate slot fails

Thanks,
Anna

----------------------------------------------------------------
Benjamin Coddington (2):
      NFSv4: Retry LOCK on OLD_STATEID during delegation return
      NFSv4.2: Fixup CLONE dest file size for zero-length count

Chuck Lever (1):
      SUNRPC: Fix crasher in gss_unwrap_resp_integ()

Kees Cook (1):
      NFS: Avoid memcpy() run-time warning for struct sockaddr overflows

Trond Myklebust (3):
      NFSv4: Fix a potential state reclaim deadlock
      NFSv4.1: Handle RECLAIM_COMPLETE trunking errors
      NFSv4.1: We must always send RECLAIM_COMPLETE after a reboot

Yushan Zhou (1):
      nfs: Remove redundant null checks before kfree

Zhang Xiaoxu (2):
      SUNRPC: Fix null-ptr-deref when xps sysfs alloc failed
      nfs4: Fix kmemleak when allocate slot failed

 fs/nfs/client.c                |  4 ++--
 fs/nfs/delegation.c            | 36 +++++++++++++++++-------------------
 fs/nfs/dir.c                   |  5 ++---
 fs/nfs/dns_resolve.c           |  7 ++++---
 fs/nfs/dns_resolve.h           |  2 +-
 fs/nfs/fs_context.c            | 14 +++++++-------
 fs/nfs/internal.h              | 14 +++++++-------
 fs/nfs/mount_clnt.c            |  4 ++--
 fs/nfs/namespace.c             |  2 +-
 fs/nfs/nfs3client.c            |  4 ++--
 fs/nfs/nfs42proc.c             |  3 +++
 fs/nfs/nfs4_fs.h               |  2 +-
 fs/nfs/nfs4client.c            | 19 ++++++++++---------
 fs/nfs/nfs4namespace.c         | 16 ++++++++--------
 fs/nfs/nfs4proc.c              | 10 ++++++----
 fs/nfs/nfs4state.c             |  2 ++
 fs/nfs/pnfs_nfs.c              |  6 +++---
 fs/nfs/super.c                 |  5 ++---
 net/sunrpc/auth_gss/auth_gss.c |  2 +-
 net/sunrpc/sysfs.c             | 12 ++++++++++--
 20 files changed, 91 insertions(+), 78 deletions(-)
