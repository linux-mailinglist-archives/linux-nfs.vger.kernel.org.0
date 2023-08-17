Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48677FA1A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352536AbjHQPBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352719AbjHQPBN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 11:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94A30E3;
        Thu, 17 Aug 2023 08:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3D6621D4;
        Thu, 17 Aug 2023 15:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FE14C433C9;
        Thu, 17 Aug 2023 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692284464;
        bh=VN3C9t4YSdD28fdXxI0Viv1kJ9NaaBM58+DtZScQx/s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pkdRU5HMUGQfHySxd+gczX9rrdpyUrl09CuWkHLoTwGEAafU9XrZJbeQ9H8F3JHK9
         i+4YJL9HayffN60XqIfCSbB+CePi3OF0+3H5BEkyNBpqR5+ebxaTB+LivtNvtv0lr4
         5K/ZgujkuE4Lp31LBgetlBK5Yk/bDZM2Y8SjgyGHSBMT++FzQpC9cQ/mom/Phl/Wbd
         qG5jMlUal+wwLRvtf6uxYVTB5sNPQl0ppN4jHYlFTUAwLCCvHC+n95A0+zd8VIRSFS
         eLCDCEH4/aNuGf/6NCd5TyEj6Gd8H5YRvfH6ZZ6+FfbjIPG/hCO1u6KVh6np06Bugi
         K1/ue1MWQ7CfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54D56C59A4C;
        Thu, 17 Aug 2023 15:01:04 +0000 (UTC)
Subject: Re: [GIT PULL] one more nfsd fix for 6.5-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
References: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-4
X-PR-Tracked-Commit-Id: c96e2a695e00bca5487824d84b85aab6aa2c1891
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16931859a6500d360b90aeacab3b505a3560a3ed
Message-Id: <169228446432.8358.16976280617645697363.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Aug 2023 15:01:04 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 17 Aug 2023 14:11:20 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16931859a6500d360b90aeacab3b505a3560a3ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
