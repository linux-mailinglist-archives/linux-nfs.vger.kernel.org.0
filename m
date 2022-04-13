Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F64FEC3A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 03:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiDMB1O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 21:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiDMB1N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 21:27:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E542E694;
        Tue, 12 Apr 2022 18:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B462FB82010;
        Wed, 13 Apr 2022 01:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83517C385A8;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649813091;
        bh=iEWTM8ZCD1t71d+51hjtBlBpGPVY+0RC7pQFx9Z/bp8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CDs0jYdmq+fifPfLwvHZfeWXkEdbVOh7v67eR2t7nXXx5IDjRPSJJjBkPFs0nBGBK
         gm+Og3ZrXjnzjuRO6TgBDpFxz4vicifmUMsn8Long7+JREZ7EzjPOohAL/k+NIWxHZ
         xNSCEC1vH16aS9BpGNb9qXuMMwfW+S/ixT+noRvwG8D8I2FZcO3ZVIZD6J68W2EjTV
         k3liNf2ks5Wh/EW/D/6avbREsYTfD4xbvTZoeqNlTELGgwsZY5TaUgL9jeN3zZ4HKN
         Ra7J80JhL5HZzTjyZKpfijJWEMgbSiPnV2pTBzFQp30HgellYEikBi9V2t9OoAcQME
         yF0FXEPRYjDfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 704CBE6D402;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
Subject: Re: [GIT PULL] 1st set of changes for v5.18-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <EBEC3138-E799-4F0A-B9BE-9445F8A17E71@oracle.com>
References: <EBEC3138-E799-4F0A-B9BE-9445F8A17E71@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <EBEC3138-E799-4F0A-B9BE-9445F8A17E71@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.18-1
X-PR-Tracked-Commit-Id: 4d5004451ab2218eab94a30e1841462c9316ba19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1488c97517adab67087aa7ed43658af49dbd0ab
Message-Id: <164981309145.9925.12200333198078078763.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Apr 2022 01:24:51 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Tue, 12 Apr 2022 22:21:16 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1488c97517adab67087aa7ed43658af49dbd0ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
