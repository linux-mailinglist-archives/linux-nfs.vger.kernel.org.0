Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB314AC25
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 23:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA0Wge (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 17:36:34 -0500
Received: from fieldses.org ([173.255.197.46]:43896 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgA0Wge (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Jan 2020 17:36:34 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id D13241C95; Mon, 27 Jan 2020 17:36:31 -0500 (EST)
Date:   Mon, 27 Jan 2020 17:36:31 -0500
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200127223631.GA28982@fieldses.org>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
 <20200124011019.GA8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124011019.GA8247@magnolia>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 23, 2020 at 05:10:19PM -0800, Darrick J. Wong wrote:
> On Thu, Jan 23, 2020 at 04:32:17PM +0800, Murphy Zhou wrote:
> > Hi,
> > 
> > Deleting the files left by generic/175 costs too much time when testing
> > on NFSv4.2 exporting xfs with rmapbt=1.
> > 
> > "./check -nfs generic/175 generic/176" should reproduce it.
> > 
> > My test bed is a 16c8G vm.
> 
> What kind of storage?
> 
> > NFSv4.2  rmapbt=1   24h+
> 
> <URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
> transactions on the inactivation?  (speculates wildly at the end of the
> workday)
> 
> I'll have a look in the morning.  It might take me a while to remember
> how to set up NFS42 :)

It may just be the default on a recent enough distro.

Though I'd be a little surprised if this behavior is specific to the
protocol version.

nfsd_unlink() is basically just vfs_unlink() followed by
commit_metadata().

--b.

> 
> --D
> 
> > NFSv4.2  rmapbt=0   1h-2h
> > xfs      rmapbt=1   10m+
> > 
> > At first I thought it hung, turns out it was just slow when deleting
> > 2 massive reflined files.
> > 
> > It's reproducible using latest Linus tree, and Darrick's deferred-inactivation
> > branch. Run latest for-next branch xfsprogs.
> > 
> > I'm not sure it's something wrong, just sharing with you guys. I don't
> > remember I have identified this as a regression. It should be there for
> > a long time.
> > 
> > Sending to xfs and nfs because it looks like all related. :)
> > 
> > This almost gets lost in my list. Not much information recorded, some
> > trace-cmd outputs for your info. It's easy to reproduce. If it's
> > interesting to you and need any info, feel free to ask.
> > 
> > Thanks,
> > 
> > 
> > 7)   0.279 us    |  xfs_btree_get_block [xfs]();
> > 7)   0.303 us    |  xfs_btree_rec_offset [xfs]();
> > 7)   0.301 us    |  xfs_rmapbt_init_high_key_from_rec [xfs]();
> > 7)   0.356 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> > 7)   0.305 us    |  xfs_rmapbt_init_key_from_rec [xfs]();
> > 7)   0.306 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> > 7)               |  xfs_rmap_query_range_helper [xfs]() {
> > 7)   0.279 us    |    xfs_rmap_btrec_to_irec [xfs]();
> > 7)               |    xfs_rmap_lookup_le_range_helper [xfs]() {
> > 1)   0.786 us    |  _raw_spin_lock_irqsave();
> > 7)               |      /* xfs_rmap_lookup_le_range_candidate: dev 8:34 agno 2 agbno 6416 len 256 owner 67160161 offset 99284480 flags 0x0 */
> > 7)   0.506 us    |    }
> > 7)   1.680 us    |  }
