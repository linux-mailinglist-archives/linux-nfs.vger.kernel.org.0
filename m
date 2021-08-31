Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2967A3FCCE6
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 20:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbhHaSUd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 14:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240187AbhHaSU3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 14:20:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2CFFA60F46;
        Tue, 31 Aug 2021 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630433974;
        bh=iaudvldPbqNjp5iY6vWXy5ETslGhBfur6lFuaWe4rcQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lXeC/QUPD82eHrIrxhpZvDvZrNBoOO1nBB+reJ1BmlnIV8x+J72GA/KHqiwIgpPWO
         57+/B3ic7yIHZjNHj5gDDUW9MNlsfZd3Px1z4VokBvz5Lfm6C1t3uKBWwszsXKk8yX
         Yxgib8gT4TaD4IrCbSDJsZj5RVf8CKH9iJbEdzOfdFwcphpax+Poxf+o6ijfNm8C4g
         aHgln6cD2uEomOpQ28EkpW2Vf3euY9QDkLYn3RLSecdf/5OmDL5hJ2tAYcqjE61Yzv
         w+kZREMMSUxLRjGPC7vge8GbgyOckTGhmxhzNq6MpSjB29Ya5QNRUjMmC3+DvSa7w8
         hdy1slxI70p9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2559E6097A;
        Tue, 31 Aug 2021 18:19:34 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <A5435167-2468-4F7B-8084-F542F8C1A838@oracle.com>
References: <A5435167-2468-4F7B-8084-F542F8C1A838@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <A5435167-2468-4F7B-8084-F542F8C1A838@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15
X-PR-Tracked-Commit-Id: 0bcc7ca40bd823193224e9f38bafbd8325aaf566
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bda95577627dc0633c48d581ea3605c27efe829
Message-Id: <163043397414.24672.6056428042510872131.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 18:19:34 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 14:46:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bda95577627dc0633c48d581ea3605c27efe829

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
