Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1D7D47B8
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 08:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjJXGuK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 02:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjJXGuH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 02:50:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9812ED68;
        Mon, 23 Oct 2023 23:50:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32C55C433C7;
        Tue, 24 Oct 2023 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698130205;
        bh=PRXhVx10/FrjA7p2MGMU9DorqGW2Xn/JzzYNkmVXj2k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mbEAN1wIsezVUNK4++FZtKNNauljLzZUs7jP7V0tZAhM5k2e43Qhi7MLqdG3XtE00
         HApA3MkfUe0atLqaVrfNAgfKf9o7MXequ1avpiACLgkEMBlx4rhCi+y7acOSWyofpi
         x4xHBEgJE9i8gk3IcP07aJT8mr6gXDuSXKul4zBaOs5d653fRnwSe/9V7ib70Y9wj2
         /e4tZHU2KiPiOooGvWTeeIAWHfF69xcCXmng+O24NI5uJyWGezfw7oGj4EYOGYOpP3
         DnRX+B+kyVbHEB0/5X3EDp6Ucv0GkgZM+B8UiyUzfqyDxPlejCW7eQoQplWKvZWt8Q
         qmUO/i1rZEelQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05A8BC595CE;
        Tue, 24 Oct 2023 06:50:05 +0000 (UTC)
Subject: Re: [git pull] nfsd fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231024061853.GG800259@ZenIV>
References: <20231024061853.GG800259@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231024061853.GG800259@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsd-fix
X-PR-Tracked-Commit-Id: 1aee9158bc978f91701c5992e395efbc6da2de3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d88520ad73b79e71e3ddf08de335b8520ae41c5c
Message-Id: <169813020491.9837.3700927031871789177.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Oct 2023 06:50:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 24 Oct 2023 07:18:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsd-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d88520ad73b79e71e3ddf08de335b8520ae41c5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
