Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8BF6952CD
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBMVNv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBMVNu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 16:13:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9F19F31
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 13:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18D05612E6
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 21:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A2FC433D2;
        Mon, 13 Feb 2023 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676322827;
        bh=EhMYICJ2Vy9p7QNOphfN+fsQKdRfaUIrZcF9n1IL9I4=;
        h=From:To:Cc:Subject:Date:From;
        b=HUwnnmaUqZsJJTl0QzteFP7DBVjyfLQ7sybEptsgXG0hLFZcjPGuACJB6R1hlc706
         TJlGF2OeU4BAJuMVxgvquTcJBQtuPRYaylSVg9LbN7xdTtRpfXprQYKDtA6Iu2i0Nl
         giJnlD7RByG0cLr37cXom5C8jZSE8EyksXVG+s1xizt7i5xhYHNfmp9zS1XOnHjF74
         FwdyM2/t1TPE9cG6kfvEUgB9xg35rWE4M0pRu9lmVb7CJNYW1NSHYgsCd8TEVP/LQ2
         prwmPz+0rwQuPUpfiI/ecTqH8e7FAyvpnKhFUXtU9Ac0tNLjHubh54oGVT+tcamzUU
         CrKdD7czKfqvw==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, chuck.lever@oracle.com
Cc:     willy@infradead.org, linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] nfsd: write verifier fixes and optimization
Date:   Mon, 13 Feb 2023 16:13:42 -0500
Message-Id: <20230213211345.385005-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
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

While looking at the recent problems with the fsync during nfsd_file
cleanup, it occured to me that we could greatly simplify and improve
the server's write verifier handling. I also noticed an existing bug
which is fixed in patch #1.

Instead of trying to check for errors via fsync and resetting the write
verifier when we get one, we can just fold the current value of the
inode's errseq_t into the hashed verifier that is generated at startup
time.

Testing this new scheme has been a real challenge. Once a writeback
error is recorded on all local filesystems, further attempts to write to
the inode return -EIO (and some filesystems even flip to r/o) and you
never see the new verifier.

Trond, you originally added the code to make it reset the verifier on a
writeback error. Do you have a good way to test that? Did you guys use
NFSv3 reexport for testing this somehow?

Jeff Layton (3):
  nfsd: copy the whole verifier in nfsd_copy_write_verifier
  errseq: add a new errseq_fetch helper
  nfsd: simplify write verifier handling

 fs/nfsd/filecache.c    | 22 +------------------
 fs/nfsd/netns.h        |  4 ----
 fs/nfsd/nfs4proc.c     | 17 ++++++---------
 fs/nfsd/nfsctl.c       |  1 -
 fs/nfsd/nfssvc.c       | 48 +++++++++++++-----------------------------
 fs/nfsd/trace.h        | 28 ------------------------
 fs/nfsd/vfs.c          | 28 +++++-------------------
 fs/nfsd/vfs.h          |  1 +
 include/linux/errseq.h |  1 +
 lib/errseq.c           | 33 ++++++++++++++++++++++++++++-
 10 files changed, 62 insertions(+), 121 deletions(-)

-- 
2.39.1

