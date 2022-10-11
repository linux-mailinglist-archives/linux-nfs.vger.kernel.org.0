Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBC5FAB53
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 05:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJKDna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 23:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKDnZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 23:43:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905D980EAD;
        Mon, 10 Oct 2022 20:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FCE9B811E3;
        Tue, 11 Oct 2022 03:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E15C3C433D6;
        Tue, 11 Oct 2022 03:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459801;
        bh=QCYhNEz7gMxeEzz7fzyS8PWxGT32BQXbOMyOWATNa8E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ck83zCX1WV7QtqxSocj2KnEjONp4iox1SSFwiqG6arinTLkFKF0pM8C0clzgvcR27
         ZUAsHcbzS0E3ouBT4/qIFrm+TB3Gf7hKgRkm7ubY36DGNMmBBhPpAUjj0U4/AhOHO6
         Pz9veK5Pzwmkiaya87sMEUe65+qUxpIAhkHBWCOFWrT8k9FaeoyoQ3AYqQ+PMv1hg8
         KedGY3Ey+j15RetviAjr7A2ZtIzi7BdCBmr3uRLBDphu+Ne1wCNkljm0lyPF0gZp0g
         oP/fK+9Qhbff5xYITcqlUJAkPqJYwfy7THrrK2o0y4RyvrCDnKIVDlYEhfeL1dm0/k
         RaopQc3wfFXig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D105FE270E4;
        Tue, 11 Oct 2022 03:43:21 +0000 (UTC)
Subject: Re: [GIT PULL] Additional NFSD changes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <F578CDD7-B188-4A5A-A2BC-20FA40759862@oracle.com>
References: <F578CDD7-B188-4A5A-A2BC-20FA40759862@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <F578CDD7-B188-4A5A-A2BC-20FA40759862@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-1
X-PR-Tracked-Commit-Id: 243a5263014a30436c93ed3f1f864c1da845455e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc914858561c424978307561492fcf3145b8b525
Message-Id: <166545980185.4678.11727117053942457392.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:21 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 8 Oct 2022 15:08:01 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc914858561c424978307561492fcf3145b8b525

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
