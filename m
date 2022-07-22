Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8419257E57A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiGVRZ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGVRZ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 13:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9F6716D
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 10:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B0362268
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 17:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046DBC341C6;
        Fri, 22 Jul 2022 17:25:23 +0000 (UTC)
Subject: [PATCH 0/4] Pre-requisites for client-side RPC-with-TLS support
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 13:25:19 -0400
Message-ID: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
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

As Jeff recently suggested, here are a few generic patches from my
RPC-with-TLS series that I believe can go in now.

---

Chuck Lever (4):
      SUNRPC: Fail faster on bad verifier
      SUNRPC: Widen rpc_task::tk_flags
      SUNRPC: Replace dprintk() call site in xs_data_ready
      NFS: Replace fs_context-related dprintk() call sites with tracepoints


 fs/nfs/fs_context.c           | 25 +++++++-----
 fs/nfs/nfstrace.h             | 77 +++++++++++++++++++++++++++++++++++
 include/linux/sunrpc/clnt.h   |  6 ++-
 include/linux/sunrpc/sched.h  | 32 +++++++--------
 include/trace/events/sunrpc.h | 18 ++++++++
 net/sunrpc/clnt.c             | 13 +++---
 net/sunrpc/debugfs.c          |  2 +-
 net/sunrpc/xprtsock.c         |  6 ++-
 8 files changed, 142 insertions(+), 37 deletions(-)

--
Chuck Lever

