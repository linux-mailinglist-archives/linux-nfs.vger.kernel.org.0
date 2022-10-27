Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8D6100AA
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiJ0Svt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbiJ0Svn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 14:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0740B5AA3B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B38B8B8274E
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DBAC433C1;
        Thu, 27 Oct 2022 18:51:39 +0000 (UTC)
Subject: [PATCH v6 00/14] Series short description
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, jlayton@redhat.com
Date:   Thu, 27 Oct 2022 14:51:38 -0400
Message-ID: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm proposing this series for v6.2 (for-next).

For quite some time, we've been encouraged to disable filecache
garbage collection for NFSv4 files, and I think I found a surgical
way to do just that. That is presented in "NFSD: Add an NFSD_FILE_GC
flag to enable nfsd_file garbage collection".

The other major change in this set is reworking the file_hashtbl to
resize itself dynamically. This reduces the average size of its
bucket chains, greatly speeding up hash insertion, which holds the
state_lock.

This version seems to pass thread-intensive testing so far.

Comments and opinions are welcome.

Changes since v5:
- Wrap hash insertion with inode->i_lock
- Replace hashfn and friends with in-built rhashtable functions
- Add a tracepoint to report delegation return

Changes since v4:
- Addressed some comments in the GC patch; more to come
- Split clean-ups out of the rhashtable patch, reordered the series
- Removed state_lock from the rhashtable helpers

Changes since v3:
- the new filehandle alias check was still not right

Changes since v2:
- Converted nfs4_file_rhashtbl to nfs4_file_rhltable
- Addressed most or all other review comments

Changes since RFC:
- checking nfs4_files for inode aliases is now done only on hash
  insertion
- the nfs4_file reference count is now bumped only while the RCU
  read lock is held
- comments and function names have been revised and clarified

---

Chuck Lever (14):
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace stateids returned via DELEGRETURN
      NFSD: Trace delegation revocations
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Update file_hashtbl() helpers
      NFSD: Clean up nfsd4_init_file()
      NFSD: Add a remove_nfs4_file() helper
      NFSD: Clean up find_or_add_file()
      NFSD: Refactor find_file()
      NFSD: Allocate an rhashtable for nfs4_file objects
      NFSD: Use rhashtable for managing nfs4_file objects


 fs/nfsd/filecache.c |  81 +++++++++++++++-------
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/nfs3proc.c  |  10 ++-
 fs/nfsd/nfs4proc.c  |  42 +++++------
 fs/nfsd/nfs4state.c | 165 ++++++++++++++++++++++++--------------------
 fs/nfsd/nfsfh.h     |  10 +--
 fs/nfsd/state.h     |   5 +-
 fs/nfsd/trace.h     |  59 +++++++++++++++-
 fs/nfsd/vfs.c       |  19 ++---
 fs/nfsd/vfs.h       |   3 +-
 10 files changed, 249 insertions(+), 149 deletions(-)

--
Chuck Lever

