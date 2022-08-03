Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEE588EBF
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Aug 2022 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiHCOhd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Aug 2022 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiHCOhc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Aug 2022 10:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D807019C27
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 07:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81DA6B82264
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 14:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12442C433C1;
        Wed,  3 Aug 2022 14:37:27 +0000 (UTC)
Subject: [PATCH v2 0/3] Wait for DELEGRETURN before returning NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     imammedo@redhat.com
Date:   Wed, 03 Aug 2022 10:37:26 -0400
Message-ID: <165953688893.1658.15242150042289528147.stgit@manet.1015granger.net>
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

This RFC series adds logic to the Linux NFS server to make it wait a
few moments for clients to return a delegation before replying with
NFS4ERR_DELAY. There are two main benefits:

- This improves responsiveness when a delegated file is accessed
  from another client
- This removes an unnecessary latency if a client has neglected to
  return a delegation before attempting a RENAME or SETATTR

This series is incomplete:
- There are likely other operations that can benefit (eg. OPEN)
- The wait is a fixed 30ms delay; it would be better if the server
  could match an incoming CB_RECALL reply with waiters so they can
  proceed immediately, but I am still figuring out how that can be
  done

Changes since RFC:
- Eliminate spurious console messages on the server
- Wait for DELEGRETURN for RENAME operations
- Add CB done tracepoints
- Rework the retry loop

---

Chuck Lever (3):
      NFSD: Add tracepoints to report NFSv4 callback completions
      NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY


 fs/nfsd/nfs4layouts.c |  2 +-
 fs/nfsd/nfs4proc.c    | 52 ++++++++++++++++++++++++++++++--------
 fs/nfsd/nfs4state.c   | 21 ++++++++++++++++
 fs/nfsd/nfsd.h        |  1 +
 fs/nfsd/trace.h       | 58 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/xdr4.h        |  2 ++
 6 files changed, 124 insertions(+), 12 deletions(-)

--
Chuck Lever

