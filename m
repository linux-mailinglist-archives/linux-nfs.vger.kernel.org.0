Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E87E9DE3
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjKMNyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjKMNyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:54:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4824D4D
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 05:54:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7634AC433C7
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883672;
        bh=tvIwSInNu2GcDiwDfSZJpr0Ct0e+Mq6urNURiNHGb3o=;
        h=Subject:From:To:Date:From;
        b=DuQbM9XFzyottc5efr0306pLlS0inVL8eOsV0Va3DSGms3jaLgCxswg4oZlKz8bwl
         Q1AttCnPsZZbq1qzmigMAXN+umi6hueuRMSjwBy9Zsx7VqH9/S58Jb8O0+AN3vUmm5
         NqOwHcUe+GlUnj9Y9jOVjBAgrp0CBUBm0HNi1cFsELfV6eaR/iMBTRc+k2Ksb4Ay/L
         AQJ3ALzlrSbU6AwP33DHwKEeW+9sgN6FMUnVGAP4nkklz9SiQRjzYI88zgpmrHXcK5
         q77CPMpKTQlpZ0zOTDd49GaMO7i7UK+26SaqRxOTFiNyx/Em/LrG0/mUywxNSz7BHF
         sWEKGBduPcfWw==
Subject: [PATCH v1 0/3] Eliminate the RQ_SPLICE_OK flag
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 13 Nov 2023 08:54:31 -0500
Message-ID: <169988319025.6844.14300255016413760826.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The server's splice read path is used by the majority of exported
filesystems. At last month's bake-a-thon, we tossed around some
ideas about how to improve benchmarking and test coverage of the NFS
server's vectored-read path, which is a fallback.

One way to do this would be to expose a switch that can be set by
test harnesses to disable splice reads.

As an initial step, hoist RQ_SPLICE_OK out of the RPC layer. Later,
I'll add a netlink command to as a switch between "use splice if
possible" and "always use vectored reads". (I don't want to collide
with the work Lorenzo is doing).

---

Chuck Lever (3):
      NFSD: Replace RQ_SPLICE_OK in nfsd_read()
      NFSD: Modify NFSv4 to use nfsd_read_splice_ok()
      SUNRPC: Remove RQ_SPLICE_OK


 fs/nfsd/nfs4proc.c                |  7 +++++--
 fs/nfsd/nfs4xdr.c                 | 13 ++++++++-----
 fs/nfsd/vfs.c                     | 30 +++++++++++++++++++++++++++++-
 fs/nfsd/vfs.h                     |  1 +
 fs/nfsd/xdr4.h                    |  1 +
 include/linux/sunrpc/svc.h        |  2 --
 include/trace/events/sunrpc.h     |  1 -
 net/sunrpc/auth_gss/svcauth_gss.c | 10 ----------
 net/sunrpc/svc.c                  |  2 --
 9 files changed, 44 insertions(+), 23 deletions(-)

--
Chuck Lever

