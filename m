Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA019706EE5
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 18:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEQQ7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEQQ7E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 12:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB61BF3;
        Wed, 17 May 2023 09:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FCEF63BCF;
        Wed, 17 May 2023 16:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EE78C4339B;
        Wed, 17 May 2023 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684342743;
        bh=0Qs3E6CVVgBXyJHLmU2XPqxH27PFliWIumtFIiqZEkc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pLK3fHSNRPeTxEZu+J07tuhuaIA2TarITWJWo2FOiNHfmLos7iO4HS283SIOEAMTn
         0YQSaeTWiR9lB3r5Mnh/Rld4AkwxL/MkZMpJrFJGlmH07FBKk08siHWWzFiiqe1uvk
         ikzYGYsXUM9DBa10M8Egtw4H9aT9n9L2jZNEYS+T5yL2mjIzJitGzKoSG9de+ychrP
         V/d+7PuemKoFiSjxG7zNI+tdDi5F0JOrdvWBjwGl9z9RlbFMflrD6hT5+62G6/A9uP
         6fJysGUupeT96GzdlEnO7nWwXraZ8YaYwMxJTuCCwNF94Jz7ghW25fmNN8FAGC6+7k
         x5L5ikQGXMfkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA301C41672;
        Wed, 17 May 2023 16:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <15471F80-3338-41FA-BF28-A0A69BDE08D3@oracle.com>
References: <15471F80-3338-41FA-BF28-A0A69BDE08D3@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <15471F80-3338-41FA-BF28-A0A69BDE08D3@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.4-1
X-PR-Tracked-Commit-Id: 21a3f3328972bdb774c62b301a715b5cebf03fa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b66c114d161a457897d269420c74620c032135c
Message-Id: <168434274295.11371.2425972265719279667.pr-tracker-bot@kernel.org>
Date:   Wed, 17 May 2023 16:59:02 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 17 May 2023 14:13:03 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b66c114d161a457897d269420c74620c032135c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
