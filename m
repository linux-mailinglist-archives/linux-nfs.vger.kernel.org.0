Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511877A53D7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjIRUUk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjIRUUj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 16:20:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0410D
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 13:20:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0F86C433C7;
        Mon, 18 Sep 2023 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695068433;
        bh=TtZyTvrDkdftArNa1osQO7a4qxG9N+0riagMsmqolRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eo+F3ibKVUhcdcuymv4hpBvAO2DE8WaxjrbtdfN0m5ZpaaMnBL/nV6QlLvAU3m2bf
         KMFt7HaVi9ogZjrG5xvFuzkvPDp8r9PgCA57PHA4MerOvkS2kt4tQ6SKspM7dQ1Www
         FeMY8EeilC0p9ythJzh2BPfOkfQ0U3hYXZN5itYbUoE0wm+6LASWlb9SyIQb4dd67X
         7InMLvvHXaHB+5vYLBKZDegOfVBtkSWaJNk+WLR90CmU5hlAvIiSDEppldwc+8u7Po
         Ojjv1cVAxSzosur8tDeTsVyQ9jn9QLWnedb2AIseoy9vKC9iWpa/x9hgYi7QCiDJpK
         xNiJtWMpPQBtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93BB4C595C4;
        Mon, 18 Sep 2023 20:20:33 +0000 (UTC)
Subject: Re: [GIT PULL] NFS Client Bugfixes for Linux 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230918175140.261140-1-anna@kernel.org>
References: <20230918175140.261140-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230918175140.261140-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-2
X-PR-Tracked-Commit-Id: 993b5662f302628db4eb358d69b2720c88cbfaf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cf0f715623872823a72e451243bbf555d10d032
Message-Id: <169506843360.7829.14775685651275522304.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Sep 2023 20:20:33 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Mon, 18 Sep 2023 13:51:40 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cf0f715623872823a72e451243bbf555d10d032

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
