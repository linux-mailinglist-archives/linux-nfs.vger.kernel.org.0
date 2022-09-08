Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C55B2914
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIHWNk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiIHWNj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324F1A83F
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A089861D99
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF65C433D6
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:13:36 +0000 (UTC)
Subject: [PATCH v4 0/8] Wait for DELEGRETURN before returning NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:13:35 -0400
Message-ID: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

This patch series adds logic to the Linux NFS server to make it wait
a few moments for clients to return a delegation before replying
with NFS4ERR_DELAY. There are two main benefits:

- It improves responsiveness when a delegated file is accessed from
  another client, and
- It removes an unnecessary latency if a client has neglected to
  return a delegation before attempting a RENAME or SETATTR

NFS4ERR_DELAY during NFSv4 OPEN is still not handled. However, I'm
comfortable merging the infrastructure in this series and support
for using it in SETATTR, RENAME, and REMOVE now, and then handling
OPEN at a later time.

This series applies against v6.0-rc4.

Changes since v3:
- Also handle JUKEBOX when an NFSv3 operation triggers a CB_RECALL

Changes since v2:
- Wake immediately after server receives DELEGRETURN
- More tracepoint improvements

Changes since RFC:
- Eliminate spurious console messages on the server
- Wait for DELEGRETURN for RENAME operations
- Add CB done tracepoints
- Rework the retry loop

---

Chuck Lever (8):
      NFSD: Replace dprintk() call site in fh_verify()
      NFSD: Trace NFSv4 COMPOUND tags
      NFSD: Add tracepoints to report NFSv4 callback completions
      NFSD: Add a mechanism to wait for a DELEGRETURN
      NFSD: Refactor nfsd_setattr()
      NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_remove() wait before returning NFS4ERR_DELAY


 fs/nfsd/nfs4layouts.c |   2 +-
 fs/nfsd/nfs4proc.c    |   6 +-
 fs/nfsd/nfs4state.c   |  34 +++++++++++
 fs/nfsd/nfsd.h        |   7 +++
 fs/nfsd/nfsfh.c       |   8 +--
 fs/nfsd/trace.h       | 131 ++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/vfs.c         | 100 ++++++++++++++++++++------------
 7 files changed, 233 insertions(+), 55 deletions(-)

--
Chuck Lever

