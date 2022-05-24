Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C435A5330BE
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiEXS45 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 May 2022 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiEXS4z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 May 2022 14:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB350075
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 11:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88649615D9
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F3DC34100
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:56:52 +0000 (UTC)
Subject: [PATCH v2 0/6] RELEASE_LOCKOWNER discussion, cont...
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 May 2022 14:56:51 -0400
Message-ID: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Check-point for discussion.

For completeness, here is the whole series of patches (including
experimental and temporary patches) that I'm considering for
addressing the RELEASE_LOCKOWNER "sleep while spin locked" splat.
It's not finished by any means.

Getting the new boolean arguments right is not straightforward. This
series does not work properly, for example, when LOCK returns
NFS4ERR_DENIED -- it leaves the lo_lockcnt bumped. I still fear this
approach would be brittle in the long run; I'm leaning towards the
so_count-based approach instead, as that is simple and nicely
contained within NFSD itself.

Thanks for taking a look.

---

Chuck Lever (6):
      fs/locks.c: Count held file locks
      NFSD: Fix possible sleep during nfsd4_release_lockowner()
      blargh
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()
      NFSD: nfsd_file_put() can sleep


 fs/lockd/svclock.c  |  4 +--
 fs/locks.c          | 20 +++++++-----
 fs/nfsd/filecache.c |  2 ++
 fs/nfsd/nfs4state.c | 80 +++++++++++++++++++++++++--------------------
 fs/nfsd/state.h     |  1 +
 include/linux/fs.h  | 12 ++-----
 6 files changed, 65 insertions(+), 54 deletions(-)

--
Chuck Lever

