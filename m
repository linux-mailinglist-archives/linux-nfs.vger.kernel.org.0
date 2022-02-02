Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829D54A77C2
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 19:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346592AbiBBSTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 13:19:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45492 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346577AbiBBSTS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 13:19:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE58618CF;
        Wed,  2 Feb 2022 18:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C423EC340EC;
        Wed,  2 Feb 2022 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825957;
        bh=cbxZgb2YNmSAHnZX1h4JYthsSFVuHb3TbalabBodBE0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E7EpREp8z/ttX5Nq2dAwfw5dtmFcR/8v5BKASkQvttNFUu3Jq/4oWkatnYeQUMhIN
         xNwm1Fnz5CwMymJKwKQvOh1lZBR7ms9lGDmc9VdjbyPDrS21ENf2oskCbLDvEI4zla
         fmoi7CnW7gF6w/k9tfmEDId9rEWyQEBDl/fMgHKAbJ2jgUtgNWqoDXG5eIxxn3Aa4d
         cg74BZiafok+dYfAtAZ+GYLWlW0MlLIZFnZtFI2W/T1e4YD91b52XkQ0Whqv2ai+ct
         LUsB+0+pULEgQQ2Nk6cK/wD6hliuoBHb6r5/TPObMrNG+igtkN3CriqB2Z48XmBC6g
         REHFhFMz2+6zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2F87E5D07E;
        Wed,  2 Feb 2022 18:19:17 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.17-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <F1000CFA-4575-4BBA-8640-4BF09A3F0811@oracle.com>
References: <F1000CFA-4575-4BBA-8640-4BF09A3F0811@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <F1000CFA-4575-4BBA-8640-4BF09A3F0811@oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.17-1
X-PR-Tracked-Commit-Id: ab451ea952fe9d7afefae55ddb28943a148247fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88808fbbead481aedb46640a5ace69c58287f56a
Message-Id: <164382595772.967.9681331585981638857.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Feb 2022 18:19:17 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 2 Feb 2022 16:32:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88808fbbead481aedb46640a5ace69c58287f56a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
