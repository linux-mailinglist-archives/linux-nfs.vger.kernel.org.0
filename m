Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA377F02BC
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 20:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKRTpD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKRTpD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 14:45:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D323192;
        Sat, 18 Nov 2023 11:45:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC57DC433C7;
        Sat, 18 Nov 2023 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700336699;
        bh=WF3AjDi8t/Y6575sjIG6hXj/ITx6emTzXBx6V7izzxA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IASC2g86V8Ug8Ix4poP46dHa0vMywIYS+yLopOkTyZoSDApkHC/vsnz6HHwigyGXb
         Rtg09WiMxig3uFUQk8k6dJqkoCTuYYRiN6qxkeri4t2vSXAYuy6r8ET5KBVB9YOfVD
         E4fmx0zybybnlRaZq074f03GrQPGmNA1rrcMDcdBOlVkQZYUhqJ5gvcjv9Wd/L+0jK
         bk4OkNcT0tJaRfAK00OkG4E/zuceIgLeOwv7S1lhOHfXP0nvRAleZT9qa27Yq6cA6t
         GZdZaYgjgC+09wJAcfcTQ7YlyThFF+QHhxTPiWyDkWWNiFff6QG505UaNTj6mhSuEQ
         I4S6B21BOmSLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1ECFEA6306;
        Sat, 18 Nov 2023 19:44:59 +0000 (UTC)
Subject: Re: [GIT PULL] first set of nfsd fixes for v6.7-rc (take 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <75D9A22E-436D-4358-8F3E-B857EE83C07A@oracle.com>
References: <75D9A22E-436D-4358-8F3E-B857EE83C07A@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <75D9A22E-436D-4358-8F3E-B857EE83C07A@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7-1
X-PR-Tracked-Commit-Id: bf51c52a1f3c238d72c64e14d5e7702d3a245b82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb28378af3921ea50f316d025acd1f7290873b51
Message-Id: <170033669978.17055.2600329270956986753.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Nov 2023 19:44:59 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 18 Nov 2023 16:52:18 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb28378af3921ea50f316d025acd1f7290873b51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
