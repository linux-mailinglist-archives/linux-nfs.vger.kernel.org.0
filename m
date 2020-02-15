Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA115FFBE
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2020 19:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBOSkC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Feb 2020 13:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgBOSkC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 15 Feb 2020 13:40:02 -0500
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581792001;
        bh=mojAO5ihb2Pcm/9RiMOF7+KKBCAFPqbJ74/4HuX7h2E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RAZA3DrB1UwDL4Cs83Pzzide5nfnnJxgj3S1Wnp9Nim35HLKubzvxZosL0oEHkdDu
         hrEdtjmIagpT5dS1F2R5lFd3mEUTfUz0WlobjKxcxlV/Aliv5UPZIPuyc6LeIZYhFb
         QFMMJviGuCl3vuElGY99K697LE68VP4h4maPy8A4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a7d05a2d486fd39295c82c0673537359bc407f4.camel@netapp.com>
References: <9a7d05a2d486fd39295c82c0673537359bc407f4.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a7d05a2d486fd39295c82c0673537359bc407f4.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.6-2
X-PR-Tracked-Commit-Id: 5d63944f8206a80636ae8cb4b9107d3b49f43d37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 829e6944699530c47739b5ef091f8137526c1494
Message-Id: <158179200184.28665.17443209911435354362.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 18:40:01 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 21:35:50 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/829e6944699530c47739b5ef091f8137526c1494

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
