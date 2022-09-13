Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB75B6E3E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiIMNRo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMNRY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 09:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E857E22
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 06:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE366147A
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 13:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99CB3C433D6;
        Tue, 13 Sep 2022 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663074968;
        bh=tkQiSHe3OFRsNX8Az0hTCzWBQH1AuacywqJ4nzPzh+E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OtaNVeKvao9Ips1aNbQiu4dhy0WseRmGylG7adQhFJ69JP7z7qUWbtFZtW4qXSjTH
         pftEV17R0TPOB22tVYNb0MwWsqNQZNx3rII+K+coWVMp/v83UBUnTR980s1Yj2NMbo
         IY4NFQ8pLLruAsygFQk0UrVYwkLD2pkCLfpcT3V5npVhj3W0jYNN1osyIKEE8sTGxy
         oeBe5vC2JNfCC+AC2j2vY+SZsFjgmqE/u77fL02plHU6rTjvblUbmr+chmlByarimb
         dAnEyTp4EmqTFT0b0VLfg+zKvmqHtC34Wx8wRucwPFBZaxwyZuLp0UIJvxyC7ib6v2
         aqtC/LPhhzP6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C044C73FE5;
        Tue, 13 Sep 2022 13:16:08 +0000 (UTC)
Subject: Re: [pull request] vfs.git: fix for nfsd regression caused by iov_iter
 stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yx/uWom4QeQrTJz5@ZenIV>
References: <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
 <Yxz+GhK7nWKcBLcI@ZenIV>
 <8B4DBE66-960F-473C-8636-8159B397FFC0@oracle.com>
 <Yx45clPaZODzYV+z@ZenIV>
 <2F22D90A-3B64-43F0-899D-E41001DF3021@redhat.com> <Yx/uWom4QeQrTJz5@ZenIV>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yx/uWom4QeQrTJz5@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: bfbfb6182ad1d7d184b16f25165faad879147f79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1221cea11fca0f6946bdd032a45b22cecfc0f99
Message-Id: <166307496849.7683.12696430843821030758.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Sep 2022 13:16:08 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 13 Sep 2022 03:43:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1221cea11fca0f6946bdd032a45b22cecfc0f99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
