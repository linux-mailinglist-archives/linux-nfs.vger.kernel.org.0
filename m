Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361E7EFB38
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 23:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjKQWO0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 17:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWO0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 17:14:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2BB8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 14:14:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A29C433C8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259262;
        bh=ckH7unM9RJpm+yub2h4VG+eGwAFRSDMAoKA3hDR6X9E=;
        h=Subject:From:To:Date:From;
        b=SxuqE50ASoikusqvQQk+dJ9ouoV5zcbqYOiBsQmww6kaPTsQki3frKylDqgNl0SV2
         UckEIplBfcNuGierAZGmY0LFnkE3tANKvIhktcosos/siIzC2s9CgyvzEyLatrPlE0
         o8Qd1P/59XXpHwTRtyukp9ydIYoMf+PFtBf5v59blVIIvDoGGSEwhHH5kGGQp01gVN
         b8ECv3YQjFQCBbmw0GlfSXzMNX7BVBaq70KCBsKaIAi9DT6DzOJ1yBxM4u4KCBsnK0
         Qp1bLaqBzsOmszAbpJ16+DV8ro3uTxTh6m/fYY6ptiqlGWNBzlP1JJkpwRpl1lL0xR
         UbNhhGVq5QuFg==
Subject: [PATCH v2 0/4] Eliminate the RQ_SPLICE_OK flag
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 17 Nov 2023 17:14:21 -0500
Message-ID: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
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

Changes since v1:
- Address "undefined reference to `svcauth_gss_flavor'"

---

Chuck Lever (4):
      SUNRPC: Add a server-side API for retrieving an RPC's pseudoflavor
      NFSD: Replace RQ_SPLICE_OK in nfsd_read()
      NFSD: Modify NFSv4 to use nfsd_read_splice_ok()
      SUNRPC: Remove RQ_SPLICE_OK


 fs/nfsd/nfs4proc.c                |  7 +++++--
 fs/nfsd/nfs4xdr.c                 | 13 ++++++++-----
 fs/nfsd/vfs.c                     | 26 +++++++++++++++++++++++++-
 fs/nfsd/vfs.h                     |  1 +
 fs/nfsd/xdr4.h                    |  1 +
 include/linux/sunrpc/svc.h        |  2 --
 include/linux/sunrpc/svcauth.h    |  7 ++++++-
 include/trace/events/sunrpc.h     |  1 -
 net/sunrpc/auth_gss/svcauth_gss.c | 16 ++++++----------
 net/sunrpc/svc.c                  |  2 --
 net/sunrpc/svcauth.c              | 16 ++++++++++++++++
 11 files changed, 68 insertions(+), 24 deletions(-)

--
Chuck Lever

