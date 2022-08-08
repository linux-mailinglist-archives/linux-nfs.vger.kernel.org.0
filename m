Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91158C9C5
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiHHNwe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiHHNwe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 09:52:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A22DF7
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 06:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6ACECE10E7
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8D8C433D6
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:52:29 +0000 (UTC)
Subject: [PATCH v3 0/7] Wait for DELEGRETURN before returning NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 09:52:28 -0400
Message-ID: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
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

This RFC series adds logic to the Linux NFS server to make it wait a
few moments for clients to return a delegation before replying with
NFS4ERR_DELAY. There are two main benefits:

- This improves responsiveness when a delegated file is accessed
 from another client
- This removes an unnecessary latency if a client has neglected to
 return a delegation before attempting a RENAME or SETATTR

This series is incomplete:
- There are likely other operations that can benefit (eg. OPEN)

This series applies against v5.19.

Changes since v2:
- Wake immediately after client sends DELEGRETURN
- More tracepoint improvements

Changes since RFC:
- Eliminate spurious console messages on the server
- Wait for DELEGRETURN for RENAME operations
- Add CB done tracepoints
- Rework the retry loop

---

Chuck Lever (7):
      NFSD: Instrument fh_verify()
      NFSD: Replace dprintk() call site in fh_verify()
      NFSD: Trace NFSv4 COMPOUND tags
      NFSD: Add tracepoints to report NFSv4 callback completions
      NFSD: Add a mechanism to wait for a DELEGRETURN
      NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY


 fs/nfsd/nfs4layouts.c |   2 +-
 fs/nfsd/nfs4proc.c    |  56 +++++++++++---
 fs/nfsd/nfs4state.c   |  35 +++++++++
 fs/nfsd/nfsd.h        |   1 +
 fs/nfsd/nfsfh.c       |  13 +---
 fs/nfsd/trace.h       | 171 ++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h        |   2 +
 7 files changed, 251 insertions(+), 29 deletions(-)

--
Chuck Lever

