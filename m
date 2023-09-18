Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7097A5148
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIRRvs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 13:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRRvr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 13:51:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A535FA
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 10:51:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE3CC433C7;
        Mon, 18 Sep 2023 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695059501;
        bh=sshpgfl6yIYtvztYQ3uHFOBwp9KK+o2qroWprvxwOHw=;
        h=From:To:Cc:Subject:Date:From;
        b=Iu+bkujMjeAfok8PuxSY0RQfuL9u/iVVnCSIxVzwt91Y1uUYsbvbe3xjw2rLRbZQ9
         Bus1nEOF/bcBNg8P3c6eBFHd5rWFrLD+2o0wKW9ri0GWoIoy+scXbxZu9ST7SPR4sB
         oj2WHOEulumiV+t+6oBwCjfTj0WgrEoeZ87HsqhAaEflsg/Q5rpzlg4eZky6kv9j8y
         UqMhyOilfioAVk012sUQJAnqm/hhftloHlurawxs+qESsldzduutMd5zpGUmtIVjSg
         EM8Thf5WJoqKscJAJXcyXHizWFV9hzzohcPWw5sDa7nN4UFs0T+5CwLxiPAS72Z6XI
         EdEXaBT1NYZGw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] NFS Client Bugfixes for Linux 6.6
Date:   Mon, 18 Sep 2023 13:51:40 -0400
Message-ID: <20230918175140.261140-1-anna@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-2

for you to fetch changes up to 993b5662f302628db4eb358d69b2720c88cbfaf0:

  SUNRPC: Silence compiler complaints about tautological comparisons (2023-09-15 15:50:39 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.6

Bugfixes:
  * Various O_DIRECT related fixes from Trond
    * Error handling
    * Locking issues
    * Use the correct commit infor for joining page groups
    * Fixes for rescheduling IO
  * Sunrpc bad verifier fixes
    * Report EINVAL errors from connect()
    * Revalidate creds that the server has rejected
    * Revert "SUNRPC: Fail faster on bad verifier"
  * Fix pNFS session trunking when MDS=DS
  * Fix zero-value filehandles for post-open getattr operations
  * Fix compiler warning about tautological comparisons
    * Revert "SUNRPC: clean up integer overflow check" before Trond's fix

----------------------------------------------------------------
Anna Schumaker (1):
      Revert "SUNRPC: clean up integer overflow check"

Olga Kornievskaia (2):
      NFSv4.1: fix pnfs MDS=DS session trunking
      NFSv4.1: fix zero value filehandle in post open getattr

Trond Myklebust (9):
      NFS: Fix error handling for O_DIRECT write scheduling
      NFS: Fix O_DIRECT locking issues
      NFS: More O_DIRECT accounting fixes for error paths
      NFS: Use the correct commit info in nfs_join_page_group()
      NFS: More fixes for nfs_direct_write_reschedule_io()
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      Revert "SUNRPC: Fail faster on bad verifier"
      SUNRPC: Silence compiler complaints about tautological comparisons

 fs/nfs/direct.c                        | 134 +++++++++++++++++++++++----------
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/nfs4client.c                    |   6 +-
 fs/nfs/nfs4proc.c                      |   6 +-
 fs/nfs/write.c                         |  23 +++---
 include/linux/nfs_fs_sb.h              |   1 +
 include/linux/nfs_page.h               |   4 +-
 include/linux/sunrpc/xdr.h             |   4 +-
 net/sunrpc/clnt.c                      |  14 ++--
 9 files changed, 132 insertions(+), 61 deletions(-)
