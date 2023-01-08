Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35D6616B8
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAHQcz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjAHQ23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:28:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AF5FF3
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:28:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C26C7B801BB
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E11CC433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195305;
        bh=CJm/KRSSFn0HmKyWetudSHd9SMez/ZvnPSOW1/bCx7M=;
        h=Subject:From:To:Date:From;
        b=Tc55Dk671REokTRm//DyI4pz69KI+SqLEKqh/FTF2mFHlDNAjHnZJlzfbiOVY29BB
         ytxw9NUnJZsLxdYON5nRJuGCaIohDpHIJViIDYtzIq5b/0tbB6DNvX0Sswdcko5/w4
         4EqNjHObKdPlh9CKysRJfGOhxfqimmYuMuMxhBllePm2PTSvTHkZFLrwuv8MCAJGJ4
         BHVFFUzlnNPsJaxNuMkwUzTQiR0+Pq5jDEB1b1LcOQXsej8sODlOZZPdxhZdU2OCG6
         eorhrCelyo8r3ZSAL4YYo/oJdmDpjij3n9hNnRUMmC1xXFIWg6e0LVdw6NQF4ogY1m
         Mz2WJelTLiieg==
Subject: [PATCH v1 00/27] Server-side RPC reply header parsing overhaul
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:28:24 -0500
Message-ID: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The purpose of this series is to replace the svc_put* macros in the
Linux kernel server's RPC reply header construction code with
xdr_stream helpers. I've measured no change in CPU utilization after
the overhaul.

Memory safety: Buffer bounds checking after encoding each XDR item
is more memory-safe than the current mechanism. Subsequent memory
safety improvements to the common xdr_stream helpers will benefit
all who use them.

Audit friendliness: The new code has additional comments and other
clean-up to help align it with the relevant RPC protocol
specifications. The use of common helpers also makes the encoders
easier to audit and maintain.

I've split the full series in half to make it easier to review. The
patches posted here are the second half, handling RPC reply header
encoding.

Note that another benefit of this work is that we are taking one or
two more strides closer to greater commonality between the client
and server implementations of RPCSEC GSS.

---

Chuck Lever (27):
      SUNRPC: Clean up svcauth_gss_release()
      SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_integ()
      SUNRPC: Record gss_get_mic() errors in svcauth_gss_wrap_integ()
      SUNRPC: Replace checksum construction in svcauth_gss_wrap_integ()
      SUNRPC: Convert svcauth_gss_wrap_integ() to use xdr_stream()
      SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_priv()
      SUNRPC: Record gss_wrap() errors in svcauth_gss_wrap_priv()
      SUNRPC: Add @head and @tail variables in svcauth_gss_wrap_priv()
      SUNRPC: Convert svcauth_gss_wrap_priv() to use xdr_stream()
      SUNRPC: Check rq_auth_stat when preparing to wrap a response
      SUNRPC: Remove the rpc_stat variable in svc_process_common()
      SUNRPC: Add XDR encoding helper for opaque_auth
      SUNRPC: Push svcxdr_init_encode() into svc_process_common()
      SUNRPC: Move svcxdr_init_encode() into ->accept methods
      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_null_accept()
      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_unix_accept()
      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_tls_accept()
      SUNRPC: Convert unwrap data paths to use xdr_stream for replies
      SUNRPC: Use xdr_stream to encode replies in server-side GSS upcall helpers
      SUNRPC: Use xdr_stream for encoding GSS reply verifiers
      SUNRPC: Hoist init_encode out of svc_authenticate()
      SUNRPC: Convert RPC Reply header encoding to use xdr_stream
      SUNRPC: Final clean-up of svc_process_common()
      SUNRPC: Remove no-longer-used helper functions
      SUNRPC: Refactor RPC server dispatch method
      SUNRPC: Set rq_accept_statp inside ->accept methods
      SUNRPC: Go back to using gsd->body_start


 fs/lockd/svc.c                    |   5 +-
 fs/nfs/callback_xdr.c             |   6 +-
 fs/nfsd/nfscache.c                |   4 +-
 fs/nfsd/nfsd.h                    |   2 +-
 fs/nfsd/nfssvc.c                  |  10 +-
 include/linux/sunrpc/svc.h        | 116 +++----
 include/linux/sunrpc/xdr.h        |  23 ++
 include/trace/events/rpcgss.h     |  22 ++
 net/sunrpc/auth_gss/svcauth_gss.c | 505 +++++++++++++++---------------
 net/sunrpc/svc.c                  |  91 +++---
 net/sunrpc/svcauth_unix.c         |  40 ++-
 net/sunrpc/xdr.c                  |  29 ++
 12 files changed, 451 insertions(+), 402 deletions(-)

--
Chuck Lever

