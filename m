Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4A5B632B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiILV5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiILV5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886D94D4D2;
        Mon, 12 Sep 2022 14:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24755612CB;
        Mon, 12 Sep 2022 21:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86EEBC433B5;
        Mon, 12 Sep 2022 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663019833;
        bh=RTcLnSsFVIOur+rEjs02YX8IzyAwTszxmcAmjHS+bHc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jCmeJ+mVx5VXPv2REp1zT2U9MHG/jVkxv3a+EUZQrSiT4EnU26y1O/HijVfeIrJFi
         j3nDcJns1b2463NxuBAChIYjYDf0KODL4MqnrTT3gFUuS3e5LAkh7xH7XQqZax2GuA
         Ww8xuWxAgWhB9gI0un5vYvAZf0k9VHq3Sx+trkSsW4D/ndMeHuxOr42yNkPsQb1bES
         D2LQo23kovzCGZK4h2xrewRuiltTtHiJ5+0VbSRJG3NRrKUVh3Zm1jNV0K01nkRWTR
         3dthd9F8ybIBB3JVkDU3ye+EhKqQFEa9N1Z5EEIywonlcuvKjRjeEXgZpCOJPrCYzz
         06J7i7GBh3/fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 725CBC73FE5;
        Mon, 12 Sep 2022 21:57:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d483818d4a936584fb0603cd2c6d4fb0b0937a38.camel@hammerspace.com>
References: <d483818d4a936584fb0603cd2c6d4fb0b0937a38.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <d483818d4a936584fb0603cd2c6d4fb0b0937a38.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.20-3
X-PR-Tracked-Commit-Id: 13bd9014180425f5a35eaf3735971d582c299292
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6504d82f4440755d6fc1385532f84d0344243d61
Message-Id: <166301983346.1940.11568009322823283161.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Sep 2022 21:57:13 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 12 Sep 2022 21:34:51 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.20-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6504d82f4440755d6fc1385532f84d0344243d61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
