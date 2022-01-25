Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53449BB52
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiAYSan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiAYSal (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:30:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D47C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 10:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FFA615D1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED70AC340E0;
        Tue, 25 Jan 2022 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643135433;
        bh=Z9rrJYCUO8OUsCAzczGnsD6I1q1Z5dIz4k61wAGvJVU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qqDIiyjYq23oHx3PLcxV0D17RvYNnWFLma4/1Y1wGW/YTakPHNnDuBVj5WugkPT/l
         n31DrZIo89G551hkegEHlyEDyI+fhWkewJ2GXeusMJz91y4RiA0flnjuUDqoaE3JPU
         BwjM2W4PHd7i8WaVGx+lGNx5N/JX/ocCt+7iyIrqrbihdpy5iNJEM8tKrZKJK/H2g9
         eqC8KZ4YZWNZ2qLHC3ACqGNj6iNMKSKv2g/FIJ22bEUilT+bJugt0Oovw2dpUKFYVl
         S91GIty1rxJ8ZuiDzpPxCs5gRspBUCC32fg/e8dTDWIDhmVo8gyJ6rbrnoKi4OFwoO
         y3stWAYDYez4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB109E5D084;
        Tue, 25 Jan 2022 18:30:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client Updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAFX2Jf=8s+rrwgGxm1FsaPUvEHygLFaUCNeFh989v4MXmLJFSg@mail.gmail.com>
References: <CAFX2Jf=8s+rrwgGxm1FsaPUvEHygLFaUCNeFh989v4MXmLJFSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAFX2Jf=8s+rrwgGxm1FsaPUvEHygLFaUCNeFh989v4MXmLJFSg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-1
X-PR-Tracked-Commit-Id: aed28b7a2d620cb5cd0c554cb889075c02e25e8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
Message-Id: <164313543288.9214.7010493823421894677.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Jan 2022 18:30:32 +0000
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 19 Jan 2022 15:47:05 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0280e3c58f92b2fe0e8fbbdf8d386449168de4a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
