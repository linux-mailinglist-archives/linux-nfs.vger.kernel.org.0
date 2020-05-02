Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256541C27C7
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2020 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgEBSpC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 May 2020 14:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgEBSpC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 2 May 2020 14:45:02 -0400
Subject: Re: [GIT PULL] Please pull NFS client bugfixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588445102;
        bh=xJu73S7yUwIeO4v/1EQT0CT496CYeg06VFrENkb0aUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pmzjtogc7AhNIeUszAdm7yzY2kQt14asZZBMFMRz1JLl8MDTm8SCz5jLLG4wMHEmb
         ZO0nNCs64rqpBO43PSHJmX+AvwRut5fdWwd9VgTV9Zj1N+vntIBx9nJqMlDu/ImKau
         R3BuUKUxpwbPyk7F5/J7TvE1xPVNaTyv6C8pGaC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c19d10e89cda7061d6aa41c1c6ad7e75affd4051.camel@hammerspace.com>
References: <c19d10e89cda7061d6aa41c1c6ad7e75affd4051.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <c19d10e89cda7061d6aa41c1c6ad7e75affd4051.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.7-4
X-PR-Tracked-Commit-Id: 9c07b75b80eeff714420fb6a4c880b284e529d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29a47f456d6213a3173722a098a3a18865ea4db3
Message-Id: <158844510197.26966.15998962202695718378.pr-tracker-bot@kernel.org>
Date:   Sat, 02 May 2020 18:45:01 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Sat, 2 May 2020 13:35:02 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29a47f456d6213a3173722a098a3a18865ea4db3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
