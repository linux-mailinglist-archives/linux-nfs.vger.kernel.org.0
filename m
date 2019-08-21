Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2F97E19
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfHUPGr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Aug 2019 11:06:47 -0400
Received: from fieldses.org ([173.255.197.46]:41246 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUPGr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:06:47 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CACF11E19; Wed, 21 Aug 2019 11:06:46 -0400 (EDT)
Date:   Wed, 21 Aug 2019 11:06:46 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd bugfixes for 5.3
Message-ID: <20190821150646.GC22104@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull nfsd bugfixes for 5.3 from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3-1

Fix nfsd bugs, three in the new nfsd/clients/ code, one in the reply
cache containerization.

--b.

He Zhe (1):
      nfsd4: Fix kernel crash when reading proc file reply_cache_stats

J. Bruce Fields (2):
      nfsd: use i_wrlock instead of rcu for nfsdfs i_private
      nfsd: initialize i_private before d_add

Tetsuo Handa (1):
      nfsd: fix dentry leak upon mkdir failure.

 fs/nfsd/nfscache.c |  2 +-
 fs/nfsd/nfsctl.c   | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)
