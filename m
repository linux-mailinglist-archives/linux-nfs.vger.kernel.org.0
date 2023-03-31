Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C036D2B54
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Apr 2023 00:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCaWbL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Mar 2023 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaWbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Mar 2023 18:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823241F79A
        for <linux-nfs@vger.kernel.org>; Fri, 31 Mar 2023 15:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1975762BF8
        for <linux-nfs@vger.kernel.org>; Fri, 31 Mar 2023 22:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77EAEC433EF;
        Fri, 31 Mar 2023 22:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680301861;
        bh=fgn0QylqD6gcNND9EQg83ctnKB2hn1ncvF7qxrTnRFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jctyxyQL+pshHoVbdRQFDYYvIIlHxXJ+LrBuIX/gfKFo4FYyfxw5leHJTj/rdRE3d
         P1bBmtbtVgXIuZYO7Qgg/4hCuyQpx302ziAWNP6vNpRChZq7vYfQ50BrE4tQscnUzL
         9XGNQFjKnO4GdeT9AHAYLX5hPiPk0g03vxCKhzZUY2kUIYokdP+d+7IGA3rokG9fBW
         6vFlYFt1RU8pkWrEDbPC1oF5RQ0Gnjlfmn6e58jsn+Yri9/4lybOtIgJzsV/dkcA5W
         dglJ82RsfJuj7bkYT1nPWVXVez6vqfcCxPw128LcPCLzdVfW9/U3DgLRhZsuD8zRm0
         tN5+ntAdrlq3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57A51C0C40E;
        Fri, 31 Mar 2023 22:31:01 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull a few more NFS Client Bugfixes for Linux v6.3-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230331201109.2262541-1-anna@kernel.org>
References: <20230331201109.2262541-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230331201109.2262541-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-3
X-PR-Tracked-Commit-Id: 943d045a6d796175e5d08f9973953b1d2c07d797
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0264d198aad19429df0ca2e320caf8b1f98ec64
Message-Id: <168030186134.19175.17775392484161187790.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 22:31:01 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 16:11:09 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0264d198aad19429df0ca2e320caf8b1f98ec64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
