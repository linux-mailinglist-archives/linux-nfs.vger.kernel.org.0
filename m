Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE95A9F95
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIATJx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiIATJw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 15:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858D7C0D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 12:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D11AB825DC
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 19:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B610CC433D6;
        Thu,  1 Sep 2022 19:09:47 +0000 (UTC)
Subject: [PATCH v3 0/6] Fixes for server-side xdr_stream overhaul
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 15:09:46 -0400
Message-ID: <166204973526.1435.6068003336048840051.stgit@manet.1015granger.net>
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

During review of the v2 of this series, Jeff suggested looking at
svc_max_payload() call sites for similar issues, and I found some.
I've included fixes for NFSv2 and NFSv3 operations in v3 of this
series.

The NFSv4 stack is different than NFSv2/3, so the simple fixes
proposed here are not appropriate there. For one thing, NFSv4 has
these op_rsize_bop helpers that use svc_max_payload() to estimate
the reply size -- but these are called well before
svcxdr_init_encode() has set rq_res.buflen. I'm still working on
fixes for those (including get/listxattr, getattr, read, readdir,
etc).


Changes since v2:
- Dropped the clean-up patches; will re-post those separately, later
- Added fixes for NFSv3 READ and for NFSv2 READ and READDIR
- Hopefully addressed a crash when @dircount is too large

Changes since v1:
- Dropped the xdr_buf_length() helper
- Replaced 7/7 with patch that cleans up an unneeded use of xdr_buf::len
- Dropped the checks for oversized RPC records
- Fixed narrow problem with NFSv2 and NFSv3 READDIR processing

---

Chuck Lever (6):
      SUNRPC: Fix svcxdr_init_decode's end-of-buffer calculation
      SUNRPC: Fix svcxdr_init_encode's buflen calculation
      NFSD: Protect against send buffer overflow in NFSv2 READDIR
      NFSD: Protect against send buffer overflow in NFSv3 READDIR
      NFSD: Protect against send buffer overflow in NFSv2 READ
      NFSD: Protect against send buffer overflow in NFSv3 READ


 fs/nfsd/nfs3proc.c         | 11 ++++++-----
 fs/nfsd/nfsproc.c          |  6 +++---
 include/linux/sunrpc/svc.h | 19 +++++++++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

--
Chuck Lever

