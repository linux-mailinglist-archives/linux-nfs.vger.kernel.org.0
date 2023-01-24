Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3E67A4CA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 22:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjAXVRf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 16:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjAXVRf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 16:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEB521FC;
        Tue, 24 Jan 2023 13:16:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE89C61324;
        Tue, 24 Jan 2023 21:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5146BC4339B;
        Tue, 24 Jan 2023 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674595017;
        bh=CBt3hpTXSroJ1dvTUO6KGSF8JMOTiYCumWma1elEgws=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o0wWEYXGaIj6wL4lhnNKWKIHNR02htqaQXVWn9rSndoJS+FWAcfO0p33HkNCZe9mY
         XBPoZdgGgEUBLwnIGPC3uG3s1ouwOhsMjX+HPnK6ix5vsWlLAfiMnPBgr5dJi/KxWS
         GxgnyjGHjxU1eUOVKwKEN/fMmn4vMAat5HPSeRHNg1hHJtGdErADBKl1RjTzcUJKQb
         5BKJfScixm3D76Jg5VhO1rUgSssbgV5/Nj7SbTxQe88JIn7Yi5EssIURs9X6NxwSja
         TkIqj7qIms3qlsp3TK7nUulInqstCGoTbj4psmIzuvx+a3X+umKActO7g4LCAUJv+F
         PW05dkzVcR3EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37FD9C04E33;
        Tue, 24 Jan 2023 21:16:57 +0000 (UTC)
Subject: Re: [GIT PULL] fourth v6.2-rc request for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <B385D9A3-FCE5-4236-821E-3EE6659F35F7@oracle.com>
References: <B385D9A3-FCE5-4236-821E-3EE6659F35F7@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <B385D9A3-FCE5-4236-821E-3EE6659F35F7@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-5
X-PR-Tracked-Commit-Id: 4bdbba54e9b1c769da8ded9abd209d765715e1d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb6e71db53f3d4351dada7c130fb652eecf994d6
Message-Id: <167459501722.6044.14540445318339334219.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Jan 2023 21:16:57 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 24 Jan 2023 16:54:22 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb6e71db53f3d4351dada7c130fb652eecf994d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
