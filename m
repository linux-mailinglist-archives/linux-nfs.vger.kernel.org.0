Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25C44CE96
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Nov 2021 02:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhKKBKo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Nov 2021 20:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhKKBKo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 10 Nov 2021 20:10:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 18FFE611C9;
        Thu, 11 Nov 2021 01:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636592876;
        bh=szaoVjB9NEyPzzQYlGZEviUbCg61NAkL2ftEqTmmzWk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tIv+NmZxuYCyOqRE0uATp7V5xmkwpRLDA81NcV6TmeZPLmqX2+9eO9PzZO11awPX3
         l8s5SovP+9dathbp0/pN3+GTo/CATYkE1SXSY17p+eI1NBr+QTZ066OOHFp6SdxxDh
         LlnUCdoroa1GR0T6o0xcjSXrfPlefDdrHmbB1QdxhTlmSzuiRc6OOB3fEvON9v5fPn
         9NVIru2oLhYTwU5NiC/KKptscjPue5XYKYrma+j7tXucf0RuH489q4LxcwroPIk4MW
         e3gNMtgAd0Wu7FpeV/oQFBE3Lbfmf05XgWV0bb+5lietDqaoa7EsF4ycjUj4s6RTPv
         IJWRq2Pb2xV9w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 124566008E;
        Thu, 11 Nov 2021 01:07:56 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4cfaa985bf0f83755b8e5877330421b993b13890.camel@hammerspace.com>
References: <4cfaa985bf0f83755b8e5877330421b993b13890.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4cfaa985bf0f83755b8e5877330421b993b13890.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.16-1
X-PR-Tracked-Commit-Id: f96f8cc4a63dd645e07ea9712be4e0a76ea4ec1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ec20f489591962db8ff1718aa6055c08d88d0cc
Message-Id: <163659287606.32583.15441152130099867116.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 01:07:56 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 15:37:39 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ec20f489591962db8ff1718aa6055c08d88d0cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
