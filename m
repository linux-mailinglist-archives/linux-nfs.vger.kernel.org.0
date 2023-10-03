Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747297B71C1
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbjJCTcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240881AbjJCTco (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 15:32:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A3F93
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 12:32:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF77C433CA;
        Tue,  3 Oct 2023 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696361561;
        bh=yyvio+TsV1v8RoTPPbPQlsnb1Qj1yeHIg//WaUZ2UhA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ADFom+gDohNC0SHBBxkSVc7225BXlXKazqaClVtz4wwdYWZ08EKO/oAjhN/3esxPz
         jtCHqVeQdm/x1KcnC/1muxQsjZYIslyu+6mwSbeRtdYgngIgZdtKBXbAX+fr3OiZNX
         qTn+AmcHw5Ozgbd5XPA7oDAkEWkctwir1Eh7XdQL1eHzskoDokC84YbaLh7GAvpeAf
         MvyuGadH31jxBYm8iDw/3rbS1A6bxLzTerT5hFVDhrEmKi5Vr+uUPBpCgdMJu8/oOB
         F9JE+83uRwoicbTLZJ3By+Zg6PWr2QZCBSBvbIcYqIjV5h5ZGFkvWjDjuiYcsc1/93
         Do5POE061kbZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47055E632D1;
        Tue,  3 Oct 2023 19:32:41 +0000 (UTC)
Subject: Re: [GIT PULL] More NFS Client Bugfixes for Linux 6.6-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231003190516.117507-1-anna@kernel.org>
References: <20231003190516.117507-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231003190516.117507-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-3
X-PR-Tracked-Commit-Id: dd1b2026323a2d075ac553cecfd7a0c23c456c59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
Message-Id: <169636156128.2158.6685700478489256949.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Oct 2023 19:32:41 +0000
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
        anna@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Tue,  3 Oct 2023 15:05:16 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbf3a2cb156a2c911d8f38d8247814b4c07f49a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
