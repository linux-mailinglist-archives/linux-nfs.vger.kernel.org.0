Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CA470BE5
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Dec 2021 21:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhLJUjh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 15:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhLJUjh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 15:39:37 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE6C061746;
        Fri, 10 Dec 2021 12:36:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2D75B6EE1; Fri, 10 Dec 2021 15:36:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2D75B6EE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639168561;
        bh=fYeuxNnieJ4+vcxDmMxR0VJ1U8wBfbSXdFRN8yDizY4=;
        h=Date:To:Cc:Subject:From:From;
        b=aYdiSIogZAlCnQPnhU2fPrLHHfnAjM/f2B4p+NmhjhwGnUjUKhe6Y/sfbDEU/yUAS
         DMQFi2bWoeYaTyZk/bJ0385nHD8fhYPzdQ2yTNJlsUfwG4PFH0UqImE6aRTPaO7vB6
         9jiws6S1Pj/nhvmnH3Q4Cl7WBmziQ7FYCfBWsJDI=
Date:   Fri, 10 Dec 2021 15:36:01 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] more nfsd bugfixes for 5.16
Message-ID: <20211210203601.GA4596@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull nfsd bugfixes for 5.16 from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.16-2

Fix a race on startup and another in the delegation code.  The latter
has been around for years, but I suspect recent changes may have
widened the race window a little, so I'd like to go ahead and get it in.

--b.

Alexander Sverdlin (1):
      nfsd: Fix nsfd startup race (again)

J. Bruce Fields (1):
      nfsd: fix use-after-free due to delegation race

 fs/nfsd/nfs4recover.c |  1 +
 fs/nfsd/nfs4state.c   |  9 +++++++--
 fs/nfsd/nfsctl.c      | 14 +++++++-------
 3 files changed, 15 insertions(+), 9 deletions(-)
