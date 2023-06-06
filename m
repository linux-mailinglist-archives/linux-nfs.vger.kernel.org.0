Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C68724A53
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jun 2023 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjFFRds (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jun 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbjFFRdU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jun 2023 13:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF1E47;
        Tue,  6 Jun 2023 10:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318F262F6C;
        Tue,  6 Jun 2023 17:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4910AC433D2;
        Tue,  6 Jun 2023 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686072798;
        bh=FaPJqhQSAErPpRFFLZLwZA00H3+2XbcO2bJz1NtUw28=;
        h=Subject:From:To:Cc:Date:From;
        b=PP0GGZzwO4Y2RBl+L7FJbo8DM59oWILT2FoH7dM3FPZdUw+C4+emgkaKddqiUQqHa
         Q07r6AHtVdkYU6ZJRA83SgyXQnF+8WPq0ekxbCq0JwjMcrSt8gKwj/UkfhgBdvfAZb
         +FAU1vqeYY3txclhANHTSGtVj93hcyj+nC+viGpYVtb4O4UDSx+1EHFGx4aCyTR+JM
         8nNYTlc16EOVNCMOy7s1UXDzZnr16BaNyThJeLApUT5YU2ZVkYCvQaY+bm3164c/OK
         eL3DOf7jllLNPyDcwNxro9+b35lek+5LYMMTZTAsh5t2EQcW9+M2JjTeFK8CN1Ixvc
         oKILaBx0I6uZw==
Subject: [PATCH v1 0/4] svcrdma: Go back to releasing pages-under-I/O
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Tue, 06 Jun 2023 13:33:17 -0400
Message-ID: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
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

Return to the behavior of releasing reply buffer pages as part of
sending an RPC Reply over RDMA. I measured a performance improvement
(which is documented in 4/4). Similar page release behavior with
socket transports also means we should be able to share a little
more code between transports as MSG_SPLICE_PAGES rolls out.

---

Chuck Lever (4):
      SUNRPC: Revert cc93ce9529a6
      SUNRPC: Revert 579900670ac7
      SUNRPC: Revert 2a1e4f21d841
      SUNRPC: Optimize page release in svc_rdma_sendto()


 include/linux/sunrpc/svc_rdma.h            |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  8 +---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 53 ++++++++++++++--------
 3 files changed, 38 insertions(+), 27 deletions(-)

--
Chuck Lever

