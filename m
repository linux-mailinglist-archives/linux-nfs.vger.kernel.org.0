Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02B7160789
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Feb 2020 01:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgBQAgn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Feb 2020 19:36:43 -0500
Received: from fieldses.org ([173.255.197.46]:38422 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgBQAgn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 16 Feb 2020 19:36:43 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id D2A9D315; Sun, 16 Feb 2020 19:36:42 -0500 (EST)
Date:   Sun, 16 Feb 2020 19:36:42 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200217003642.GB21562@fieldses.org>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
 <20200124011019.GA8247@magnolia>
 <20200127223631.GA28982@fieldses.org>
 <20200216082851.h2y6bs3h4dvpqyvv@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216082851.h2y6bs3h4dvpqyvv@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Feb 16, 2020 at 04:28:51PM +0800, Murphy Zhou wrote:
> Hi Bruce,
> 
> On Mon, Jan 27, 2020 at 05:36:31PM -0500, J. Bruce Fields wrote:
> > On Thu, Jan 23, 2020 at 05:10:19PM -0800, Darrick J. Wong wrote:
> > > On Thu, Jan 23, 2020 at 04:32:17PM +0800, Murphy Zhou wrote:
> > > > Hi,
> > > > 
> > > > Deleting the files left by generic/175 costs too much time when testing
> > > > on NFSv4.2 exporting xfs with rmapbt=1.
> > > > 
> > > > "./check -nfs generic/175 generic/176" should reproduce it.
> > > > 
> > > > My test bed is a 16c8G vm.
> > > 
> > > What kind of storage?
> > > 
> > > > NFSv4.2  rmapbt=1   24h+
> > > 
> > > <URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
> > > transactions on the inactivation?  (speculates wildly at the end of the
> > > workday)
> > > 
> > > I'll have a look in the morning.  It might take me a while to remember
> > > how to set up NFS42 :)
> > 
> > It may just be the default on a recent enough distro.
> > 
> > Though I'd be a little surprised if this behavior is specific to the
> > protocol version.
> 
> Can NFS client or server know the file has reflinked part ? Is there
> any thing like a flag or a bit tracking this?

Not that I'm aware of.

--b.
