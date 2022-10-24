Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664EA60BF5B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJYARd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiJYARL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF983642A
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E04615EB
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 22:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626FBC433D6;
        Mon, 24 Oct 2022 22:36:54 +0000 (UTC)
Subject: [PATCH v5 00/13] A course change, for sure
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 24 Oct 2022 18:36:53 -0400
Message-ID: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

The current rhashtable changes are failing some tests, so expect
another revision of this series soon.

Comments and opinions are welcome.

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

Chuck Lever (13):
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace delegation revocations
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Update file_hashtbl() helpers
      NFSD: Clean up nfsd4_init_file()
      NFSD: Add a remove_nfs4_file() helper
      NFSD: Clean up find_or_add_file()
      NFSD: Refactor find_file()
      NFSD: Allocate an rhashtable for nfs4_file objects
      NFSD: Use rhashtable for managing nfs4_file objects


 fs/nfsd/filecache.c |  81 +++++++++++++++--------
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/nfs3proc.c  |  10 ++-
 fs/nfsd/nfs4proc.c  |  42 +++++-------
 fs/nfsd/nfs4state.c | 157 +++++++++++++++++++++++---------------------
 fs/nfsd/nfsfh.h     |  10 +--
 fs/nfsd/state.h     |   5 +-
 fs/nfsd/trace.h     |  58 +++++++++++++++-
 fs/nfsd/vfs.c       |  19 ++----
 fs/nfsd/vfs.h       |   3 +-
 10 files changed, 239 insertions(+), 150 deletions(-)

--
Chuck Lever

