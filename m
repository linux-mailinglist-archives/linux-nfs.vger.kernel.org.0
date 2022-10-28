Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B59611A8A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ1S5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1S5R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DD1ABA3B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C9862A02
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 18:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AD2C433C1;
        Fri, 28 Oct 2022 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666983434;
        bh=ijn71jGjX0bw1vwKouyS8d1FFrhwN608ZiFlLBS7OcE=;
        h=From:To:Cc:Subject:Date:From;
        b=lIQpPvHDjneQ+nygzoz7NQHu2r7AJW/PC9D1Q8crO479fmrr1mmDljFsDudcuiU5o
         D/HqIjHI1vu0l5p6Dlb7+USlpcgFjZCUharzk97NHLz9bSmt4HSTtllqfUDb0raCEc
         i4QOj9zrYRd1XP8lssxtIqt3I072t4g0X0jSnJTf1/BqE+gMnqmsQQiSVABFZn71nB
         9iKCNjgpk5ATSr5VlwL3rnn9ByKPj89Btl3N0Lo1/VJ+v3XcsFjzXjFBml1Y+z2ucS
         54RMc6ppTFK3XJ+AmWqCsSU9mb405r/ScMLc3XRJcXOC2JaJryhIPNkaAmaoi8hVuT
         wenN0pIclN3kg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v3 0/4] nfsd: clean up refcounting in the filecache
Date:   Fri, 28 Oct 2022 14:57:08 -0400
Message-Id: <20221028185712.79863-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are a number of changes here from the last set, but I've tried to
address Neil and Chuck's comments (thanks for the review, btw).

I think I've solved the race between adding to the LRU and unhashing.
That's in patch #3. We may want to squash that into #2 before merging.

Jeff Layton (4):
  nfsd: remove the pages_flushed statistic from filecache
  nfsd: rework refcounting in filecache
  nfsd: close race between unhashing and LRU addition
  nfsd: start non-blocking writeback after adding nfsd_file to the LRU

 fs/nfsd/filecache.c | 385 +++++++++++++++++++++++---------------------
 fs/nfsd/filecache.h |   1 +
 fs/nfsd/trace.h     |   5 +-
 3 files changed, 207 insertions(+), 184 deletions(-)

-- 
2.37.3

