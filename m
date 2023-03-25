Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749D6C90C1
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Mar 2023 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYUmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Mar 2023 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYUmA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Mar 2023 16:42:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB038BDEE;
        Sat, 25 Mar 2023 13:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A9D7B80AC9;
        Sat, 25 Mar 2023 20:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C4CFC4339B;
        Sat, 25 Mar 2023 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679776917;
        bh=qaWXGLUlUow8qbjKFBcuZ3IukE77s1b5WKXXsxbN1Po=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LIt6h/5M/fx4L8gZHlCtBC2AiZmH69q4s8vFd6jE26RZWytjW1Sn9AAszRVH40Qaj
         oy0fS+XE13ofW0WvrL/snB4QD1mwtAeYmND1O/mN6p83o19xQ0qXor080b3VRcqdOh
         nsqk1Jt6Qn4SzmzvfWlSrOLGY4NTWzAqIDBhhU63qYzVA6YnoaDW83IyxJb9Tbx0jc
         lc6YwN0ZJLYwTUSuZcWagY51w3W3rC7aJyXo8/rZ5+L43AX+h3OHtdfThir8NnW/6E
         rmqUMy9Z1jvFJgvL6zhM8XyhTGAta+0wsCqrfoxQP5/uT6szDCqBtXkAkw+gnzAK96
         YqVb7iA3X4qMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C86FE4F0DA;
        Sat, 25 Mar 2023 20:41:57 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fix for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <72D3CC33-6DD5-4AC0-A33F-DF91B79AEEF6@oracle.com>
References: <72D3CC33-6DD5-4AC0-A33F-DF91B79AEEF6@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <72D3CC33-6DD5-4AC0-A33F-DF91B79AEEF6@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-4
X-PR-Tracked-Commit-Id: 5f24a8725fe7bc2c6adf7ce00dd3e818387d8995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da8e7da11e4ba758caf4c149cc8d8cd555aefe5f
Message-Id: <167977691698.11958.7853381407468959176.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Mar 2023 20:41:56 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 25 Mar 2023 19:27:26 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da8e7da11e4ba758caf4c149cc8d8cd555aefe5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
