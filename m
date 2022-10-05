Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34BB5F56CC
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJEOzm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJEOzl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 10:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073A27177
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 07:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72AE6170B
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C739C433C1
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:55:37 +0000 (UTC)
Subject: [PATCH RFC 0/9] A course adjustment, maybe
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 05 Oct 2022 10:55:35 -0400
Message-ID: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
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

To make that fit, I've dropped Jeff's fix for nfsd_file_close(), but
incorporated his proposed replacement logic into nfsd_file_put().
The justification for that can be found in the patch descriptions.

Jeff's other two patches are included here because I intend to get
them merged into v6.1 soon thus they will become part of the base
for NFSD for-next. For the moment I'm leaving out Fixes tags because
I'd like to see these get some testing before they are applied to
v6.0 -- and again, we're not yet 100% sure these fix a misbehavior
that has been hit in the field.

Comments and opinions are welcome.

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


 fs/nfsd/filecache.c | 165 ++++++++++++++++---------------
 fs/nfsd/filecache.h |   4 +-
 fs/nfsd/nfs3proc.c  |  10 +-
 fs/nfsd/nfs4proc.c  |  42 ++++----
 fs/nfsd/nfs4state.c | 235 ++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfsfh.h     |  10 +-
 fs/nfsd/state.h     |   5 +-
 fs/nfsd/trace.h     |  58 ++++++++++-
 fs/nfsd/vfs.c       |  19 ++--
 fs/nfsd/vfs.h       |   3 +-
 10 files changed, 344 insertions(+), 207 deletions(-)

--
Chuck Lever

