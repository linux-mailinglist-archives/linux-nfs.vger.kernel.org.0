Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA181664DD5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 22:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAJVGv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 16:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjAJVGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 16:06:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84E53729;
        Tue, 10 Jan 2023 13:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48C956186B;
        Tue, 10 Jan 2023 21:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B039BC433F0;
        Tue, 10 Jan 2023 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673384800;
        bh=mTFM/W+1TVM69X1fBf0h4Jkgx60IFGoIEKNCy1TaZj0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i9fbQGuenFmQrx1Xj5Sajt1rRDmpNK19gP+6AFCB2iPeS/N3JH+k6gcvWvk9pWuKV
         QmwzQYx2kdK+OajyY6F4tN2cyxXLI+qKfz5vGcCVO7In4JEkYerRf82fCvpT+bGxVq
         WmryD1Lf28J9OOU0TQYg7vmR3y5rQaPxAmAb8AouUyVY2ClSSogFAyrC7EYjj3VGj0
         RuerMj7GQng7vm6ByravrMe+ANCVsyB7RD47hVIA0WdOMn5ovruVzqSNz3UyDbmyDu
         Vqfjgks6YQq5/esSL5/7l25HcuXD3HdJX2ABiJZZ5dcbngTV5qVNg2rrxDpWMcRR9M
         /oYB0uloQegpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9783AE21EE8;
        Tue, 10 Jan 2023 21:06:40 +0000 (UTC)
Subject: Re: [GIT PULL] second v6.2-rc pull request for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <C9754BD7-5CC7-4330-9A1B-F6C67EB2CB3F@oracle.com>
References: <C9754BD7-5CC7-4330-9A1B-F6C67EB2CB3F@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <C9754BD7-5CC7-4330-9A1B-F6C67EB2CB3F@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-3
X-PR-Tracked-Commit-Id: 5304930dbae82d259bcf7e5611db7c81e7a42eff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
Message-Id: <167338480061.401.10229822229488866090.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Jan 2023 21:06:40 +0000
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

The pull request you sent on Tue, 10 Jan 2023 19:13:21 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7dd4b804e08041ff56c88bdd8da742d14b17ed25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
