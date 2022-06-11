Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0354708F
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jun 2022 02:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiFKAis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jun 2022 20:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKAir (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jun 2022 20:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9831232;
        Fri, 10 Jun 2022 17:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1AE861F5D;
        Sat, 11 Jun 2022 00:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D6ABC34114;
        Sat, 11 Jun 2022 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654907924;
        bh=eS5+SBJYvKIgvd5Yu/DxZd2ASuUQIMWVcGVR7WK0xzY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TkMMDG9yM9ZfHnGNG/3cib5p8kuWQv/T+kj9Abe59iOb6Kf+29pPgkHRNfgh35ilQ
         As47q9krzCp8GzAAmMjFU/noQPXR4EwlkNmDTzoyUvNC65ujRNdeItgurrXw4sKLCP
         MK8g8vN3hXONVBTDyWSJ4dAwfQ+zZX0gVitFgjrJG0ggF7RRB0HBO4vcm+1HB0uPJF
         BCoZwT/1pvcP6LNeSNtHi7iHW1X0HwXYw/lyU296QXdQPcBV7vhVvMGIj9e52g5Q5W
         lLdZZOS0vLIGdTGNtUtvFxrnHk1VCQaJn/8PZtT2Hg+jAZbHF1ErPPDp3PIwxDSCFy
         SU+jhbh49l1EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3862AE737F6;
        Sat, 11 Jun 2022 00:38:44 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <FF9D9B25-0117-446D-B5B3-A4240C67A99F@oracle.com>
References: <FF9D9B25-0117-446D-B5B3-A4240C67A99F@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <FF9D9B25-0117-446D-B5B3-A4240C67A99F@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19-1
X-PR-Tracked-Commit-Id: da9e94fe000e11f21d3d6f66012fe5c6379bd93c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0885eacdc81f920c3e0554d5615e69a66504a28d
Message-Id: <165490792422.22575.16609460064231495408.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jun 2022 00:38:44 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 11 Jun 2022 00:17:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0885eacdc81f920c3e0554d5615e69a66504a28d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
