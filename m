Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF212B1119
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgKLWLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 17:11:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgKLWLC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 17:11:02 -0500
Subject: Re: [GIT PULL] Please pull NFS Client Bugfixes for Linux 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605219062;
        bh=tXCqU/WFhJWyqhqmo6FV2oZsW0c7wnbWkuHZSPdFvJc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xbyCW7KcW3xDzOVpw0OdEURNCrYnelrXUi+EfzpVMgSzKkGSAYObJYXCfTFDWEIMY
         fqRDQJeXRgmwJAXj6CQcoFyiDLTbtjQ9O9z9HyDpW3OxvL20aqz3+kQk1ffhPAbHgc
         VzvNOC/zYMeVfISvObj6hLhESi9PGYDhGC5lwVxk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAFX2Jfnq+spZtxSbsy+tiUPgcYP4pHCJ_d2BGTW4TTQKchgJpQ@mail.gmail.com>
References: <CAFX2Jfnq+spZtxSbsy+tiUPgcYP4pHCJ_d2BGTW4TTQKchgJpQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAFX2Jfnq+spZtxSbsy+tiUPgcYP4pHCJ_d2BGTW4TTQKchgJpQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-2
X-PR-Tracked-Commit-Id: 11decaf8127b035242cb55de2fc6946f8961f671
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 200f9d21aa92ae55390030b6c84757c2aa75bce0
Message-Id: <160521906209.29533.17998296387521147604.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Nov 2020 22:11:02 +0000
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 12 Nov 2020 12:15:22 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/200f9d21aa92ae55390030b6c84757c2aa75bce0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
