Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A654ACBA7
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 22:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbiBGVwW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 16:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiBGVwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 16:52:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2AC061355
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 13:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15BD0CE12F2
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 21:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4756BC004E1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644270737;
        bh=LNDtppmrla3a5y+kPk3soXpBrb9OUCpzpKKpUEiTfnA=;
        h=From:To:Subject:Date:From;
        b=Pl3oaoYZIQifXVFx0kCF/9GqRMAs7xnQ6LAlw/UGqt0fUe+fMA8+w3i4dP/PX4mTk
         0XU+YGjThCKV+Cjq1/Xw4QDLXpsb3Fh3H4nc6ze+igTCOtypKLdvHruWLnF96ZDrJC
         tSCckyVzYF17MnTQK7tSPgXTmLwn1Bc/6y+Xel0pdUTsAccbjtzzg8ouKsRhB4GVGP
         xJT2aVsbXnjgG7iKxZ/L0lnvv8F3IZZ0wogqSA2ZBJjVXsnZ9t8b/eG10ctH0us6Ot
         0NeKIqDcQsNKGGB0laOFNvGhjxKxzOnlijmmXMITj+pKA/hOgmE9uJdOPLqBwNZLbw
         v7r0IyTHVV5nw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Adaptive readdir readahead
Date:   Mon,  7 Feb 2022 16:46:08 -0500
Message-Id: <20220207214610.803566-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

Trond Myklebust (2):
  NFS: Adjust the amount of readahead performed by NFS readdir
  NFS: Simplify nfs_readdir_xdr_to_array()

 fs/nfs/dir.c           | 91 ++++++++++++++++++++++++++++++++----------
 include/linux/nfs_fs.h |  1 +
 2 files changed, 71 insertions(+), 21 deletions(-)

-- 
2.34.1

