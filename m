Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07F46BF5EA
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 00:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCQXCg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 19:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCQXCd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 19:02:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508E61536
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 16:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FAA2B826E4
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 23:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87429C4339B;
        Fri, 17 Mar 2023 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679094079;
        bh=vzgFH8+oQaWKlEw2fWdshtGT4Ea/lJlZQxHGlC1+52Y=;
        h=Subject:From:To:Cc:Date:From;
        b=uhxQbliJ3xI3/TRuzX0v4EqVVFvJRhUo8MOUgLe/7XTnicL/g4CBu13NkM3xw4iKu
         goRXc1GejTUkIdsAq8WLJjq1VpfHOIXyg8R63qL32yLzTUzIeL/vwzHPKXuI5li+q6
         WMsdF76qigJIKa1rGIdvw5HuOBiqlX5Ha5ANXJmv5+//vRsAXQeVjTNy+eWO53pG+Z
         rZ86gNxX8PVVzOHxD0LjrH7VE1YMlLFpRu45B7+RzJ4r9IROWt1SOx/k3wMC1l4K7K
         9Ns5jm51p25/z07UplHEsIfoY0emYto/623Ings4v8Vbq7Aird43bJK06SY3wB+xuz
         6amLl0R46pQSw==
Subject: [PATCH v1 0/3] rq_pages bounds checking
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, dcritch@redhat.com, d.lesca@solinos.it
Date:   Fri, 17 Mar 2023 19:01:18 -0400
Message-ID: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A slightly modified take on Jeff's earlier patches, tested with
both NFSv3 and NFSv4.1 via simple fault injection in
svc_rqst_replace_page().

In general I'm in favor of more rq_pages bounds checking by
replacing direct modification of the rq_respages and rq_next_page
fields with accessor functions.

---

Chuck Lever (2):
      SUNRPC: add bounds checking to svc_rqst_replace_page
      NFSD: Watch for rq_pages bounds checking errors in nfsd_splice_actor()

Jeff Layton (1):
      nfsd: don't replace page in rq_pages if it's a continuation of last page


 fs/nfsd/vfs.c                 | 15 +++++++++++++--
 include/linux/sunrpc/svc.h    |  2 +-
 include/trace/events/sunrpc.h | 25 +++++++++++++++++++++++++
 net/sunrpc/svc.c              | 15 ++++++++++++++-
 4 files changed, 53 insertions(+), 4 deletions(-)

--
Chuck Lever

