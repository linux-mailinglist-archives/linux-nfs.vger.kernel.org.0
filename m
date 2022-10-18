Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3C60339E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJRT6X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJRT6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 15:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3597025288
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 12:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C395F61689
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 19:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8B6C433D6;
        Tue, 18 Oct 2022 19:58:19 +0000 (UTC)
Subject: [PATCH v4 0/7] A course adjustment, for sure
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Tue, 18 Oct 2022 15:58:19 -0400
Message-ID: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
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

I'm proposing this series for v6.2 (for-next). I intend to open this
branch soon, now that the v6.1 merge window is closed.

For quite some time, we've been encouraged to disable filecache
garbage collection for NFSv4 files, and I think I found a surgical
way to do just that. That is presented in "NFSD: Add an NFSD_FILE_GC
flag to enable nfsd_file garbage collection".

The other major change in this set is reworking the file_hashtbl to
resize itself dynamically. This reduces the average size of its
bucket chains, greatly speeding up hash insertion, which holds the
state_lock.

Comments and opinions are welcome.

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

Chuck Lever (7):
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Use rhashtable for managing nfs4_file objects
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace delegation revocations


 fs/nfsd/filecache.c |  79 +++++++++++-----
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/nfs3proc.c  |  10 +-
 fs/nfsd/nfs4proc.c  |  42 ++++-----
 fs/nfsd/nfs4state.c | 221 ++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfsfh.h     |  10 +-
 fs/nfsd/state.h     |   5 +-
 fs/nfsd/trace.h     |  58 +++++++++++-
 fs/nfsd/vfs.c       |  19 ++--
 fs/nfsd/vfs.h       |   3 +-
 10 files changed, 305 insertions(+), 146 deletions(-)

--
Chuck Lever

