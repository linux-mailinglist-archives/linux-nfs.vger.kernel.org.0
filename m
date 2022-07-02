Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8808564207
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Jul 2022 20:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiGBSXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Jul 2022 14:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBSXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Jul 2022 14:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7757BE03;
        Sat,  2 Jul 2022 11:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 644AB60FE9;
        Sat,  2 Jul 2022 18:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1702C34114;
        Sat,  2 Jul 2022 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656786228;
        bh=ZwujMVrO8jBzgsoNQtbM49FDzdO+bamptrgGM1pETkk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YD18+6CvIPbWgQHlHLPiI+nGW4BCiSm4V2vEKrP6qf4w4vTZLY/kZ6Ht2HyRwsfWG
         6MEad3iJKEGWJokHtMseJCjtxnjHyuYYo0fPyPqBt/CG30HjbMPGvxLxFPObOhKqHJ
         zrRdrsHmQPLPwssxAgr5bUJ+Kbp8p8/Z8746yHOBOvlCVOQkxGap0QQ8gkYOIXnw7U
         YAO2ctMxXcLI/3bSSs1H9r4hfyIhZe24JtkUjkcVrSJZzO2suR0K6mLaj7xzQpzbMp
         vDEEybpYkT1p8YUtlUR2nWEsg7tgAgdTjZcQHEBo55XsdDTnsLDQD8bfwNGdKYJCc3
         1xLAgFHUrPBHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1417E49BBC;
        Sat,  2 Jul 2022 18:23:48 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd round of nfsd fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <67B9A04C-2112-4A3F-911B-ED192D3B3E7E@oracle.com>
References: <67B9A04C-2112-4A3F-911B-ED192D3B3E7E@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <67B9A04C-2112-4A3F-911B-ED192D3B3E7E@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19-2
X-PR-Tracked-Commit-Id: a23dd544debcda4ee4a549ec7de59e85c3c8345c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69cb6c6556ad89620547318439d6be8bb1629a5a
Message-Id: <165678622865.22071.16207227443945423823.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jul 2022 18:23:48 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 2 Jul 2022 18:01:07 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69cb6c6556ad89620547318439d6be8bb1629a5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
