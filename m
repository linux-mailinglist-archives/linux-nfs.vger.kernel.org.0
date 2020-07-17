Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB57B22471C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGQXpC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 19:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGQXpB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jul 2020 19:45:01 -0400
Subject: Re: [GIT PULL] A few more NFS client bugfixes for Linux 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595029501;
        bh=AcJVwYWAkzEvgF5ovgmz76kA2jaHnGB6hOkhiiMP7ws=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VH0OJFQD52tnWCUoz1XXZCrWPax0r4cqzi9pYCB+ExYLGMnvup+evxzcUxiB8I+Ve
         jk+uVMAX+jv3rCCi9nwAH3lBiqa41RllJ4uDAsiDLOhQAjOkbYgfXP5oAwN0d2igLZ
         VPIRnl7VZ44wFqsPd4sCMqmjAgoo8d6M/NlaVfwM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAFX2Jfmu8sMKGgvUSkvntktDZD_uDhu=5d6TyqH-RuDpG4xgaA@mail.gmail.com>
References: <CAFX2Jfmu8sMKGgvUSkvntktDZD_uDhu=5d6TyqH-RuDpG4xgaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAFX2Jfmu8sMKGgvUSkvntktDZD_uDhu=5d6TyqH-RuDpG4xgaA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 nfs-for-5.8-3
X-PR-Tracked-Commit-Id: 65caafd0d2145d1dd02072c4ced540624daeab40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a70f89cc58f2368efa055cbcbd8b37384f6c588
Message-Id: <159502950150.15008.6975626625582715217.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 23:45:01 +0000
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 17:27:38 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git nfs-for-5.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a70f89cc58f2368efa055cbcbd8b37384f6c588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
