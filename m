Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AB365B57B
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjABRFb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjABRFa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:05:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A0A45F
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC1E6105D
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A51C433EF
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679125;
        bh=5IlRDptMNGh66nkxvNlY4U17APxWIEPBOOx5knwVmzY=;
        h=Subject:From:To:Date:From;
        b=oNaYmziwemk+IvQJDJW3Sp06KaPTEchZzQX6cbRHrhRr5Sz3tBTOv9myQ7A5fF94e
         7bkmXEv93xBNd5UGcs9J2n/5xKzf8Ee7nofk/FBl7IJUtUrI68Zi84J3YsIPG7f9Od
         FNhO5V3bbsW7jGFolhHpV9U90xJBUCL1GhERegGdasVFYtoNzG++0qXkr0Tr/uQDFe
         8qS8zgc9Mop9zOAJb94+Uxb9DTqyTWANVxNUOiOXqDu4w+5rrV4DpGtgwzBgi9Tkx4
         42DpoEpF/97Lkh/U6pIFmHkbZRySOAy574uXZSnHL6l2YnTH7OjHLUT6YbWOqysd0a
         Keo3DivY1HGaw==
Subject: [PATCH v1 00/25] Server-side RPC call header parsing overhaul
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:05:24 -0500
Message-ID: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Happy new year, campers.

The following series has been percolating for quite a while, thanks
to the extended 6.1-rc cycle. I'd like to get this work reviewed
for possible inclusion in v6.3, so I'm starting early.

The purpose of this series is to replace the svc_get* macros in the
Linux kernel server's RPC call header parsing code with xdr_stream
helpers. I've measured no change in CPU utilization after the
overhaul; svc_recv() and friends remain the highest CPU consumers by
an order of magnitude.

Memory safety: Buffer bounds checking after decoding each XDR item
is more memory-safe than the current decoding mechanism. Subsequent
memory safety improvements to the xdr_stream helpers will benefit
all who use them.

Audit friendliness: The new code has lots of comments and other
clean-up to help align it with the relevant RPC specifications. The
use of common helpers also makes the decoders easier to audit.

I've split the full series in half to make it easier to review. The
patches posted here handle RPC call header decoding. Remaining
patches, to be posted later, deal with RPC reply header encoding.

Yes, there are a lot of patches, but they are each small, easily
chewed mechanical changes.

---

Chuck Lever (25):
      SUNRPC: Push svcxdr_init_decode() into svc_process_common()
      SUNRPC: Move svcxdr_init_decode() into ->accept methods
      SUNRPC: Add an XDR decoding helper for struct opaque_auth
      SUNRPC: Convert svcauth_null_accept() to use xdr_stream
      SUNRPC: Convert svcauth_unix_accept() to use xdr_stream
      SUNRPC: Convert svcauth_tls_accept() to use xdr_stream
      SUNRPC: Move the server-side GSS upcall to a noinline function
      SUNRPC: Hoist common verifier decoding code into svcauth_gss_proc_init()
      SUNRPC: Remove gss_read_common_verf()
      SUNRPC: Remove gss_read_verf()
      SUNRPC: Convert server-side GSS upcall helpers to use xdr_stream
      SUNRPC: Replace read_u32_from_xdr_buf() with existing XDR helper
      SUNRPC: Rename automatic variables in unwrap_integ_data()
      SUNRPC: Convert unwrap_integ_data() to use xdr_stream
      SUNRPC: Rename automatic variables in unwrap_priv_data()
      SUNRPC: Convert unwrap_priv_data() to use xdr_stream
      SUNRPC: Convert gss_verify_header() to use xdr_stream
      SUNRPC: Clean up svcauth_gss_accept's NULL procedure check
      SUNRPC: Convert the svcauth_gss_accept() pre-amble to use xdr_stream
      SUNRPC: Hoist init_decode out of svc_authenticate()
      SUNRPC: Re-order construction of the first reply fields
      SUNRPC: Eliminate unneeded variable
      SUNRPC: Decode most of RPC header with xdr_stream
      SUNRPC: Remove svc_process_common's argv parameter
      SUNRPC: Hoist svcxdr_init_decode() into svc_process()


 fs/lockd/svc.c                    |   1 -
 fs/nfs/callback_xdr.c             |   1 -
 fs/nfsd/nfssvc.c                  |   1 -
 include/linux/sunrpc/msg_prot.h   |   5 +
 include/linux/sunrpc/xdr.h        |   5 +-
 net/sunrpc/auth_gss/svcauth_gss.c | 512 ++++++++++++++++--------------
 net/sunrpc/svc.c                  |  69 ++--
 net/sunrpc/svc_xprt.c             |   1 -
 net/sunrpc/svcauth.c              |  13 +-
 net/sunrpc/svcauth_unix.c         | 132 +++++---
 net/sunrpc/xdr.c                  |  50 ++-
 11 files changed, 468 insertions(+), 322 deletions(-)

--
Chuck Lever

