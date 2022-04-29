Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D010514E63
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377269AbiD2O4z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiD2O4x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857767938E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08BC161CD3
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB03C385A4
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:31 +0000 (UTC)
Subject: [PATCH 0/6] Minor NFSD fixes and clean-ups for 5.19
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:53:30 -0400
Message-ID: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
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

I've gotten confirmation that the NFSv3 OPEN(CREATE) fixes posted
previously:

https://lore.kernel.org/linux-nfs/20220420192418.GB27805@fieldses.org/T/#t

are effective and so far, have not resulted in any regression. I've
pushed these to my for-next branch.

On top of these I have collected a few related clean-ups and fixes
that were found along the way, posted here for review.

---

Chuck Lever (6):
      NFSD: Remove dprintk call sites from tail of nfsd4_open()
      NFSD: Fix whitespace
      NFSD: Move documenting comment for nfsd4_process_open2()
      NFSD: Trace filecache opens
      NFSD: Clean up the show_nf_flags() macro
      SUNRPC: Use RMW bitops in single-threaded hot paths


 fs/nfsd/filecache.c                      |  5 +-
 fs/nfsd/nfs4proc.c                       | 67 +++++++++++-------------
 fs/nfsd/nfs4state.c                      | 12 +++++
 fs/nfsd/nfs4xdr.c                        |  2 +-
 fs/nfsd/trace.h                          | 34 +++++++++---
 net/sunrpc/auth_gss/svcauth_gss.c        |  4 +-
 net/sunrpc/svc.c                         |  6 +--
 net/sunrpc/svc_xprt.c                    |  2 +-
 net/sunrpc/svcsock.c                     |  8 +--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 10 files changed, 85 insertions(+), 57 deletions(-)

--
Chuck Lever

