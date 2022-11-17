Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAF62E2AF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiKQRPr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiKQRPq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 12:15:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3B74CF2;
        Thu, 17 Nov 2022 09:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18BE5621D6;
        Thu, 17 Nov 2022 17:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7948AC433D6;
        Thu, 17 Nov 2022 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668705344;
        bh=nV3jpgsSlXC1vo4ObEgex1KWhIMV3zuGFLxrnUPvjko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kmZLH0LjkoULZgDL377KnXMh4Hk1SiH9T/+E5nNGPbutolmFk2BlsjnJHRZsCB2MZ
         Cyw0ndeVRYtL7HAGHKKPME+RXjh5HAuPscPJaYrXO5hByzxPTWjR0kV29OqyLwVecv
         TnZMAWlimT1IsvyzHOwcLpiteynj9nPf4ZBB+OYWO/xVAuu7rPaD/aBOt9ChFtVEoJ
         M2xG9LuhvP7FgyebhrdnmJfZa+mZZ2AxeV10WwmMjHpZ+a4qZBcx6E4TK/zrYSuQiz
         26R3uCX9qnOW/d9GUj3lhih9xj3URFZp2VKy7KiBhRvYr0mYkZTe2fZ7Apc33jYSxy
         yJ9i8gSkT1N6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F034E270D5;
        Thu, 17 Nov 2022 17:15:44 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd round 5 for v6.1-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <F48B9C90-E689-4896-8B57-ADEFDBCF9FCA@oracle.com>
References: <F48B9C90-E689-4896-8B57-ADEFDBCF9FCA@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <F48B9C90-E689-4896-8B57-ADEFDBCF9FCA@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-5
X-PR-Tracked-Commit-Id: 5a01c805441bdc86e7af206d8a03735cc9394ffb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81ac25651a62c958bb0e074e0d4e25060ea557dd
Message-Id: <166870534434.19027.6231688571957297864.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Nov 2022 17:15:44 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 17 Nov 2022 16:32:15 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81ac25651a62c958bb0e074e0d4e25060ea557dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
