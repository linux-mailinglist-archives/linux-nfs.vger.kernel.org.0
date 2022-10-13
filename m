Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AF35FE17B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Oct 2022 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJMSk1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Oct 2022 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJMSkA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Oct 2022 14:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348573BC54
        for <linux-nfs@vger.kernel.org>; Thu, 13 Oct 2022 11:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF0DFB82062
        for <linux-nfs@vger.kernel.org>; Thu, 13 Oct 2022 18:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D6EFC433D6;
        Thu, 13 Oct 2022 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665684013;
        bh=Xfj5m3hZi1uDlj/p5MYGkFgoWnjEqvxQw5bxlugdpUg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QdQedPYb/1/OVV4tNrkWdKIp/8UXAoCAumXb0wkT6zXieAILO2qSM5VjehvyS46Kp
         4rqlUeCHfGT6ScLJ1uNGwZYNVoSG/BEgMH5DJoCLCAoFgd8yzvomRlAoOnX8vtP1yr
         J3J31xPdhWpR5GURQWaqUH8/93Hdfimvm/tHzvnaVPKjcj7nogNw0A/aYv2E6YyrBv
         dI7/x2Vw4OQYxdvSKnoy6MXn7Bp3/g/wZ+981JdcHfIx6KJ/updT1kqCvG491V+vnP
         mMeVxiLQD9l0yUF+x4k6qYYMMXs51DFDX7vKOJXeK4u8fFGFUltLNFvg0KZyq7H8Ui
         dHUR7/KyFZMqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60C78E29F31;
        Thu, 13 Oct 2022 18:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221012204031.657633-1-anna@kernel.org>
References: <20221012204031.657633-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221012204031.657633-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.1-1
X-PR-Tracked-Commit-Id: b739a5bd9d9f18cc69dced8db128ef7206e000cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66b834558537c623135241e1ea9ddf11b31596e4
Message-Id: <166568401338.7515.16430192362910402626.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 18:00:13 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 16:40:31 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66b834558537c623135241e1ea9ddf11b31596e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
