Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FC5B632C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiILV5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiILV5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F44D147;
        Mon, 12 Sep 2022 14:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7E63B80CC2;
        Mon, 12 Sep 2022 21:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58497C433C1;
        Mon, 12 Sep 2022 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663019833;
        bh=Dpk3MjwIl3rG2025TWC2dcvXU9zLT0Ds88swZfM8CnQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uO4YhKPLfb9+uZfy0vdvcVwEZTEyoWHaSyC9sj5TOt9Q5Fv+MyJkJm0p7aEEuZ73S
         FBNPX6IrFyaGgp5jBhtm/kZc2nd5MLTiZfLV+7Iy39yUnUdVuBKX8mMqZdT9OYd2Wa
         knqMztAo2WI5WFDhbTICc2k+zju6XVum7UtMsWcqkItOwAA4wQPRYMYaNuA4cEkfpb
         2XjgD84dWQAopIw93CYw+X/wYIev44pHnVZLVOP7fOlSnhrSYcP+1q2BuqP9a71xHq
         0rjWqW2pN5mYhYqgqzdsGL8r8YVqeKY/8tukWF4X+UfD3HYVKzWtoA2Dh1du5MUdEQ
         G1/FPsA9z+0Cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EE4EC04E59;
        Mon, 12 Sep 2022 21:57:13 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD change for 6.0-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <EA5CCB69-FE15-4B41-9058-E2A608E7E494@oracle.com>
References: <EA5CCB69-FE15-4B41-9058-E2A608E7E494@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <EA5CCB69-FE15-4B41-9058-E2A608E7E494@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.0-1
X-PR-Tracked-Commit-Id: 00801cd92d91e94aa04d687f9bb9a9104e7c3d46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62d1cea7d66ee690de398e281470e78e94d085f7
Message-Id: <166301983324.1940.6263551988445281115.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Sep 2022 21:57:13 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

The pull request you sent on Mon, 12 Sep 2022 21:06:53 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62d1cea7d66ee690de398e281470e78e94d085f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
