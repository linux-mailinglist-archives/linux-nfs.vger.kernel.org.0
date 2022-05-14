Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780F527204
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiENOdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiENOdM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31331C905
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F29260F60
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B42C340EE;
        Sat, 14 May 2022 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538790;
        bh=BftTyQzgW6WIZpyT8Bhqa3nVxo+4m15Y2HngVLtj1Kk=;
        h=From:To:Cc:Subject:Date:From;
        b=rCZpklD91KCsMJZKuIyocnzfbJ4pvUEyMUi2s+rn1EufOU4BGyFgFYewIUxFcyoyo
         Xhglg/IrqPd5OZviILxlMvi9BDTbMCCDdx6BLhHbgHILxV+Ka8iTpkkX6B2RxJ64fY
         3N7ga++qs7Qelmycj1Q/sDGbAhhDU7bYdpm/x/JhqnycrZuknIPgStCJqfNBnoYmGC
         SIjWleCgarYmQt8BP44m+XMWw6ahTdoFMGR8aZ6hqhpPCZtTIzknoggobFgdjknesa
         l2Dxy99A8ys2ROCe7OzIMXU2YpvGOmlA5TPsD1IGr7FiRwbFA47XbV4XVKQggtw4tz
         vuYniRQhDN9Hw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/5] Ensure mapping errors are reported only once
Date:   Sat, 14 May 2022 10:26:59 -0400
Message-Id: <20220514142704.4149-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The expectation since Linux 4.13 has been that EIO errors are always
reported in fsync(), whether or not they were detected and reported
earlier.
On the other hand, ENOSPC errors are reported as soon as detected, and
should only be reported once.

--
v3: minor correctness fixes

Trond Myklebust (5):
  NFS: Do not report EINTR/ERESTARTSYS as mapping errors
  NFS: fsync() should report filesystem errors over EINTR/ERESTARTSYS
  NFS: Don't report ENOSPC write errors twice
  NFS: Do not report flush errors in nfs_write_end()
  NFS: Don't report errors from nfs_pageio_complete() more than once

 fs/nfs/file.c  | 50 +++++++++++++++++++++-----------------------------
 fs/nfs/write.c | 11 ++---------
 2 files changed, 23 insertions(+), 38 deletions(-)

-- 
2.36.1

