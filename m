Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E37A2C84
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Sep 2023 02:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbjIPAe5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 20:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbjIPAeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 20:34:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784BCC1;
        Fri, 15 Sep 2023 17:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06437C43140;
        Sat, 16 Sep 2023 00:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694824387;
        bh=asBrAn7ys2esSGzWq/PdthRC+OIxuEjab4MLqUB7vzY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tztiH3OCITBj+TRV0wPzMV/NrDiz/glsjaXcnzD2TQGmWWzmTu84Ce2u57lTBQQg1
         JiBcs4ySDX1a55FNRtLvVY4UO6Zytu1tTWmWqDqu5leUfs0W0EjpC2j3JCGz3/HUZr
         2j8CuBU/ZfNOt9XpTllCbDB9yLE1qeKBcip82ilVS+ZHuehGeHIuX6IUapuXLuczSg
         r9G3u4PL+ju9P33iDZr5E2crG8qDpWnpNVGgAw/mY7jBU0x27O/PkDpNw2T545Xhnq
         9qjz1xcklmfHxQYEY0YL/Ql454Y8xe/gF3kJmJqrQG0wsVMAJcM5Rd550VDMPU6bPk
         kmtJXYuo6EHGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDE98E26880;
        Sat, 16 Sep 2023 00:33:06 +0000 (UTC)
Subject: Re: [GIT PULL] first round of v6.6 fixes for nfsd
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63D87D8F-8513-4B12-BA9B-752BD5C7D4FD@oracle.com>
References: <63D87D8F-8513-4B12-BA9B-752BD5C7D4FD@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <63D87D8F-8513-4B12-BA9B-752BD5C7D4FD@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.6-1
X-PR-Tracked-Commit-Id: 88956eabfdea7d01d550535af120d4ef265b1d02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8d7cd656361529c334e3b90535e81d818fc1157
Message-Id: <169482438690.16821.88949473678256144.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 00:33:06 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 16:05:16 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8d7cd656361529c334e3b90535e81d818fc1157

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
