Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1A4F6AFC
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiDFUOf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiDFUNZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 16:13:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A67190EB2
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 11:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DC0DB82004
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 18:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F290FC385A9
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 18:07:56 +0000 (UTC)
Subject: [PATCH v2 0/2] Fix request deferral for NFS/RDMA
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Apr 2022 14:07:55 -0400
Message-ID: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev1+g8516920
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
transport. A link to that report appears in the first patch below.

The first patch in this series addresses the crash, and the second
fixes a related observability crash. The other patches from v1
have been postponed to 5.19.

Comments, opinions, and Reviewed-by's are appreciated!

Since v1:
- Series trimmed down to just what will go to 5.18-rc
- 2nd patch re-worked so it can be backported to recent stable
- Addressed a few checkpatch.pl nits

---

Chuck Lever (2):
      SUNRPC: Fix NFSD's request deferral on RDMA transports
      SUNRPC: Fix the svc_deferred_event trace class


 include/linux/sunrpc/svc.h              | 1 +
 include/trace/events/sunrpc.h           | 9 +++++----
 net/sunrpc/svc_xprt.c                   | 3 +++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

--
Chuck Lever

