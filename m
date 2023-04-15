Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECC06E2DDD
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDOARy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 20:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOARx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 20:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6D40FB
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 17:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DC26450B
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 00:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A9C433D2;
        Sat, 15 Apr 2023 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681517871;
        bh=G58Efku2aEurEx7cOiEClTaBhHkLB7i6XRXkkHn0ZwE=;
        h=Subject:From:To:Date:From;
        b=RFRGXz402G4mwYNc+HxoDI32EOxrB3fOmvbeHwYS6Ycy1sJw30B0mSIIaLIOT3mQf
         MrjUQudHRo3jhYPhgiEct30QNVNi543QsgsF9Kj+a6zMib6HEw/ZEB81wVImPjhS+z
         xzQBGxEtbbxGa/ZiWrdr7TWtp3fj/YbOr4LIaE2BJGUKbHWyYG5vBlOBFVMq3TTxLO
         bfNc2d6z0xq7Twf5yp9XmKXiv/cmM9OFKJUXJfB/O513mKoYxb7RK8qZ4ICfJtmf6F
         BnNG4P/Y1bAO3jjr2B3GIqK0tZQHIi+eUWpKbMQ4igi0fR974Xd81oPq5Cd3ynpuCd
         xmmjTo2WGHO9A==
Subject: [PATCH v1 0/4] NFSD memory allocation optimizations
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 14 Apr 2023 20:17:50 -0400
Message-ID: <168151777579.1588.7882383278745556830.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've found a few ways to optimize the release of pages in NFSD.
Please let me know if I'm abusing the release_pages() and pagevec
APIs.

---

Chuck Lever (4):
      SUNRPC: Relocate svc_free_res_pages()
      SUNRPC: Convert svc_xprt_release() to the release_pages() API
      SUNRPC: Convert svc_tcp_restore_pages() to the release_pages() API
      SUNRPC: Be even lazier about releasing pages


 include/linux/sunrpc/svc.h | 12 +-----------
 net/sunrpc/svc.c           | 21 +++++++++++++++++++++
 net/sunrpc/svc_xprt.c      |  5 +----
 net/sunrpc/svcsock.c       | 12 ++++++------
 4 files changed, 29 insertions(+), 21 deletions(-)

--
Chuck Lever

