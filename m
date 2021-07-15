Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE13CA452
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGORaO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGORaN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 13:30:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC5C06175F;
        Thu, 15 Jul 2021 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A/iOWH/eq2vDhfxyVOdH70jsjaoCTAYD+XN2BGv/PRg=; b=a8tBS7GQNc7/QxHn26QkbWu1LJ
        oF//nu8vv7GY7MZKmx17DZ1MD7SC81IBUpbTVoTfPdv5YGjHA96QLvp0bXYNYNHt4GjDzeW+5bYNd
        qqJr6939/NH5eT4uXvHtur9iFrH8mdUEtkYUEO+fs1nGlCVKLeJmUGAwAp2gHUj9iuBSfVz3G5r2e
        NX42m7HRiIJmgk3u7baJqppizWoLU3fHkkeDTKLm49i9XdC6RD0gVJuvJI1K7ydpntrk4jjifvSuv
        6UU5ht9aFS97snKG1FD189wiAZs7sTMViCj2R/oXRpTKTud7iroRh2LvWpsgOvCHCxy0MH4s0PJwX
        aX0F++mA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4569-003ZP2-8Q; Thu, 15 Jul 2021 17:24:51 +0000
Date:   Thu, 15 Jul 2021 18:24:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <YPBvUfCNmv0ElBpo@infradead.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 15, 2021 at 01:11:29PM -0400, Josef Bacik wrote:
> Because there's no alternative.  We need a way to tell userspace they've
> wandered into a different inode namespace.  There's no argument that what
> we're doing is ugly, but there's never been a clear "do X instead".  Just a
> lot of whinging that btrfs is broken.  This makes userspace happy and is
> simple and straightforward.  I'm open to alternatives, but there have been 0
> workable alternatives proposed in the last decade of complaining about it.

Make sure we cross a vfsmount when crossing the "st_dev" domain so
that it is properly reported.   Suggested many times and ignored all
the time beause it requires a bit of work.
