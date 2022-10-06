Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5B5F6B69
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJFQUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiJFQUL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B332BA4
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A1F60C40
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 16:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1446EC433D6
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 16:20:06 +0000 (UTC)
Subject: [PATCH v2 0/9] A course adjustment, maybe...
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 06 Oct 2022 12:20:04 -0400
Message-ID: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

I'm proposing this series as the first NFSD-related patchset to go
into v6.2 (for-next), though I haven't opened that yet.

For quite some time, we've been encouraged to disable filecache
garbage collection for NFSv4 files, and I think I found a surgical
way to do just that. That is presented in "NFSD: Add an NFSD_FILE_GC
flag to enable nfsd_file garbage collection".

Comments and opinions are welcome.

Changes since RFC:
- checking nfs4_files for inode aliases is now done only on hash
  insertion
- the nfs4_file reference count is now bumped only while the RCU
  read lock is held
- comments and function names have been revised and clarified

I haven't updated the new @want_gc parameter... jury is still out.

---

Chuck Lever (7):
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Use const pointers as parameters to fh_ helpers.
      NFSD: Use rhashtable for managing nfs4_file objects
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace delegation revocations

Jeff Layton (2):
      nfsd: fix nfsd_file_unhash_and_dispose
      nfsd: rework hashtable handling in nfsd_do_file_acquire


 fs/nfsd/filecache.c | 165 +++++++++++++++---------------
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/nfs3proc.c  |  10 +-
 fs/nfsd/nfs4proc.c  |  42 ++++----
 fs/nfsd/nfs4state.c | 241 ++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfsfh.h     |  10 +-
 fs/nfsd/state.h     |   5 +-
 fs/nfsd/trace.h     |  58 ++++++++++-
 fs/nfsd/vfs.c       |  19 ++--
 fs/nfsd/vfs.h       |   3 +-
 10 files changed, 351 insertions(+), 206 deletions(-)

--
Chuck Lever

