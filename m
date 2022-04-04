Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B14F1B77
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379645AbiDDVU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379817AbiDDSK7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 14:10:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECAE13F50
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 11:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 356ADB818D3
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2329C2BBE4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:08:58 +0000 (UTC)
Subject: [PATCH v1 0/6] Fix request deferral for NFS/RDMA
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Apr 2022 14:08:57 -0400
Message-ID: <164909503892.3716.8666091898179474248.stgit@manet.1015granger.net>
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

Last week Trond reported a server crash in svc_rdma_sendto() that
seemed related to deferral of a request incoming on an RPC/RDMA
transport. A link to that report appears in the first patch
below.

The fundamental problem seems to be that there is no way to
guarantee test coverage of SUNRPC request deferral. "SUNRPC: Cache
deferral injection" proposes a way to address that issue.

With an on-demand mechanism for triggering a deferral, it was
straightforward to find and address the issues that led to Trond's
reported crash. The first patch in this series addresses the crash,
and the second fixes a related observability crash.

The final three patches are clean-ups that are possible now that
the deferral issues have been addressed.

Comments, opinions, and Reviewed-by's are appreciated!


---

Chuck Lever (6):
      SUNRPC: Fix NFSD's request deferral on RDMA transports
      SUNRPC: Fix the svc_deferred_event trace class
      SUNRPC: Cache deferral injection
      SUNRPC: Make cache_req::thread_wait an unsigned long
      SUNRPC: Remove dead code in svc_tcp_release_rqst()
      SUNRPC: Remove svc_rqst::rq_xprt_hlen


 include/linux/sunrpc/cache.h            |  7 +++----
 include/linux/sunrpc/svc.h              |  3 +--
 include/trace/events/sunrpc.h           | 11 +++++------
 net/sunrpc/cache.c                      | 18 +++++++++++++++++-
 net/sunrpc/debugfs.c                    |  3 +++
 net/sunrpc/fail.h                       |  2 +-
 net/sunrpc/svc_xprt.c                   | 11 ++++++-----
 net/sunrpc/svcsock.c                    | 11 -----------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  1 -
 9 files changed, 36 insertions(+), 31 deletions(-)

--
Chuck Lever

