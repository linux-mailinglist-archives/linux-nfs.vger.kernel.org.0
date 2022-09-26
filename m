Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D65EAE24
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiIZRYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 13:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiIZRXq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 13:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDF112F744
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 09:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C03160FDA
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 16:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D70C433C1;
        Mon, 26 Sep 2022 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664210329;
        bh=x+jvZpAQD49OnAwK2gXuF648cs1JpNA51XaU06fHRko=;
        h=From:To:Cc:Subject:Date:From;
        b=irO3GCstSsAxexQjQ998Ak1sCvx9tc2h2pk/KWmgtqtgzSXTBv8/szsWAte8A7R8t
         ChJAWTssHhD01E0RkLPWZ4mvMr1X2Ar+9jAC2UipdjP6BIh+nSovudhAmQ1zLxKyl+
         gN/4oYEQXa07kn2szA4cKsvw8YDxPrErnLRMuTYJ/bv1Bu7ynW5m8K8b7eapdLFm4l
         HR7dhb3+Iumc0LdBrJ8NknHQEN63ahmgqCFIn/lPVbny7NkkP4qq5q2eCMr4Ly/MNQ
         +Olzhrrds5nQA1rS/sILRQ2lqwbH7Pg5OqAauWlWdFEvPfpw4qbL/XyDtuOKV3MwlX
         ZuJsJkZthuuhA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] nfsd: minor cleanup and sanity check patches for nfsd
Date:   Mon, 26 Sep 2022 12:38:43 -0400
Message-Id: <20220926163847.47558-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck,

While hunting for some bugs, I found some warts that the first two
patches clean up. I also added some sanity checks when freeing
delegations or queueing up a CB_RECALL. Your call on whether you want
to accept those. These should apply cleanly to your for-next branch,
but the last patch may need to be adjusted when Dai fixes up his patch.

Cheers,

Jeff Layton (4):
  nfsd: only fill out return pointer on success in nfsd4_lookup_stateid
  nfsd: fix comments about spinlock handling with delegations
  nfsd: make nfsd4_run_cb a bool return function
  nfsd: extra checks when freeing delegation stateids

 fs/nfsd/nfs4callback.c | 14 ++++++++++++--
 fs/nfsd/nfs4state.c    | 26 +++++++++++++++-----------
 fs/nfsd/state.h        |  2 +-
 3 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.37.3

