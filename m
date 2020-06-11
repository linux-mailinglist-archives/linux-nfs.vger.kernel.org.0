Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514321F6E3F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2020 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgFKTuD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 15:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgFKTuD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jun 2020 15:50:03 -0400
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591905003;
        bh=aGC/zLwKzcBk84GbfabHOpjq7Bgwp5tB8060WHR77OQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mI3XD2Eq4XTKy5i98ZmDZgmCT9xJXMtodgsG99t8RXoppF6rZHU0WDkaAZDTIp4ij
         bHf0GzOk7invLVt1LDnYZTB1/dYcyMPsuLSSURnwthwbuLOwwOqss5Iwq/3uRr+an4
         ULbygEXFYUaIlrR3+bhbc8pXCJuRw6JKOJsudrMQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5149067d-621b-22b5-5f37-87fa9b14c181@gmail.com>
References: <5149067d-621b-22b5-5f37-87fa9b14c181@gmail.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <5149067d-621b-22b5-5f37-87fa9b14c181@gmail.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: ba838a75e73f55a780f1ee896b8e3ecb032dba0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a53956829914223ff6c53397b007421201354eb8
Message-Id: <159190500314.20905.16602136356923678246.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 19:50:03 +0000
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-nfs@vger.kernel.org
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 14:11:02 -0400:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a53956829914223ff6c53397b007421201354eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
