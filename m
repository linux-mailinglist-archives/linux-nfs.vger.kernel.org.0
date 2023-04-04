Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11F6D6D1D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjDDT1k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjDDT1i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 15:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88534686;
        Tue,  4 Apr 2023 12:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCED36390B;
        Tue,  4 Apr 2023 19:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EC53C433EF;
        Tue,  4 Apr 2023 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680636451;
        bh=Ka48JskYXkurF0Cfr2N+t4BQhhcPKr/MFDHcZZf6KxY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mq4WUVVmamZU4k2aRmYN4PBMgvXZSYz0UkDypZPqyQTkrjaMsb7PZNr1s7TjiMmV2
         w2KN+4MeqoXW8xlY0Ec767wjyfc08OqwNWPzpttWAEohwxfzsjzkErcsVFuSGnPlbc
         1bEgT5rx6PIpAuJ3rLR1VfhSD80ZESVwf2pQ0H0eipq74ybSP5O3ZeLGwd8xnx9dCJ
         Kd2u7wUvCqglJR4PoZsRRKhDdxPZAzquj06LyLDAPyMGS5wcN4Adf5pCYxkx6tJeMK
         lPjh7BqydvRu+maCki0Pz0VU8VD4imcranfzCNMkwlQcP8y1kpgum+9QzzBI4LnCWJ
         oNGooL9HtYjXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17F24E5EA85;
        Tue,  4 Apr 2023 19:27:31 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <84B35B0A-C629-4C3F-A289-859A9A83E3CD@oracle.com>
References: <84B35B0A-C629-4C3F-A289-859A9A83E3CD@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <84B35B0A-C629-4C3F-A289-859A9A83E3CD@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-5
X-PR-Tracked-Commit-Id: 7de82c2f36fb26aa78440bbf0efcf360b691d98b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ceeea1b78293834378b8d32a18288610de5600f3
Message-Id: <168063645109.19891.1235163630995332716.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Apr 2023 19:27:31 +0000
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

The pull request you sent on Tue, 4 Apr 2023 14:03:24 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ceeea1b78293834378b8d32a18288610de5600f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
