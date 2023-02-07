Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92968DF25
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 18:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjBGRly (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 12:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjBGRlx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 12:41:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4EEFAD
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 09:41:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB187B81A5F
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 17:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4034CC433D2;
        Tue,  7 Feb 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675791709;
        bh=BhcBH3aIGCrCwkACzKq0hNqeLhJuKP2gNKZjV2r+c1w=;
        h=From:To:Cc:Subject:Date:From;
        b=EN3SZItLimdd5ZX78IPpoBrS6O75jDEAWdmICfaSlHmXfEPsU2JRKHki5Tu81HYU9
         OjrTDZvCmFk4iVbMt79B+pu3dcEixLCgoBW7aaupQtwiDrRV8AHuUGRF1G3lgY/r8S
         8EE0VPlOoc+Jo9YN7ycxVgQZ2JZMo8gPB87DLDQ/R25abliafTXpdlFxFJsvPE9q5k
         yL96Z5nawEwWMYJFnV3HLF5GiCtwJ3f2RAZHEeFEuSTAmRnOBLp11g32DHzMxfvw7y
         zWBp4VbhkdSnU0mKKhVGJ/TqZzzE4Y714cVQTpuC4aDM8GS/0iBQPP7LntKKsvPozU
         98hptK5YFgxKw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/2] nfsd: simplify and improve nfsd write verifier handling
Date:   Tue,  7 Feb 2023 12:41:45 -0500
Message-Id: <20230207174147.205482-1-jlayton@kernel.org>
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
the server's write verifier handling.

Instead of trying to check for errors via fsync and resetting the write
verifier when we get one, we can just fold the current value of the
inode's errseq_t into the hashed verifier that is generated at startup
time.

This is only lightly tested so far. It's a bit difficult to test these
sorts of error handling changes though, since these should be infrequent
events.

Trond, you originally added the code to make it reset the verifier on a
writeback error. Do you have a good way to test that?

Jeff Layton (2):
  errseq: add a new errseq_fetch helper
  nfsd: simplify write verifier handling

 fs/nfsd/filecache.c    | 22 +--------------------
 fs/nfsd/netns.h        |  4 ----
 fs/nfsd/nfs4proc.c     | 17 +++++++---------
 fs/nfsd/nfsctl.c       |  1 -
 fs/nfsd/nfssvc.c       | 44 +++++++++++-------------------------------
 fs/nfsd/trace.h        | 28 ---------------------------
 fs/nfsd/vfs.c          | 28 +++++----------------------
 fs/nfsd/vfs.h          |  1 +
 include/linux/errseq.h |  1 +
 lib/errseq.c           | 33 ++++++++++++++++++++++++++++++-
 10 files changed, 58 insertions(+), 121 deletions(-)

-- 
2.39.1

