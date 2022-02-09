Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A74AF8E7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiBISBG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 13:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiBISBD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 13:01:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB8C05CB90;
        Wed,  9 Feb 2022 10:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F2361B54;
        Wed,  9 Feb 2022 18:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A808C340E7;
        Wed,  9 Feb 2022 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644429665;
        bh=hmzGQP0ola4GbYNFJkOckJN5Uy2e55nQnWsWHjgFtBY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V1xhrp2kHBFdpqxot7bmTy7FcvwbyqH9dtO5Bh0hf8BLPrJzVZu/dL1fiArvzZLDW
         MUlKOn4v4B7hKf1djdrybMyRbkVoSlF4Kr6TY1hn/coeG/rg7WJJ8hbuYUaUeqSiWk
         geiXLk4pNI0o6JScK9eRBAfwe6AZnE93o9YOzkdtxZoHdvB5v2E7otNlBHpGlaWpxy
         NRO709Ciyu1OnmzSZtNJ/ZtgRLFhr38gafyDppakDruRuNBu5V9F1nncT4aFdnYE67
         50sm6+KyBX6gFKBKIerkP37VCjaq+/Z0eara6R+Ow9EXAlJOcb0Av/dP7pBOx0+4Y/
         HfTHwuPbw5Mxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 862FCE5D084;
        Wed,  9 Feb 2022 18:01:05 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd set of nfsd changes for 5.17-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6C412830-A3AA-4587-9CB7-C3E4EA26885B@oracle.com>
References: <6C412830-A3AA-4587-9CB7-C3E4EA26885B@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6C412830-A3AA-4587-9CB7-C3E4EA26885B@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.17-2
X-PR-Tracked-Commit-Id: c306d737691ef84305d4ed0d302c63db2932f0bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4bc5bbb5fef3cf421ba3485d6d383c27ec473ed
Message-Id: <164442966554.2385.8644954811810208673.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Feb 2022 18:01:05 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 9 Feb 2022 14:44:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4bc5bbb5fef3cf421ba3485d6d383c27ec473ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
