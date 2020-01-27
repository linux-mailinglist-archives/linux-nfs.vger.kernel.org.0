Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5514ACDA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 00:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgA0X4V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 18:56:21 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38122 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgA0X4V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 18:56:21 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 245C13A1F01;
        Tue, 28 Jan 2020 10:56:19 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwEEr-0005bi-9v; Tue, 28 Jan 2020 10:56:17 +1100
Date:   Tue, 28 Jan 2020 10:56:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200127235617.GB18610@dread.disaster.area>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
 <20200124011019.GA8247@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124011019.GA8247@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=DKXhrarefucG-zT5zuIA:9 a=VFtz45cXcEUkXO3f:21
        a=2Tythr-q2aEXjZyO:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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

Is the NFS server the same machine as what the local XFS tests were
run on?

> > NFSv4.2  rmapbt=1   24h+
> 
> <URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
> transactions on the inactivation?  (speculates wildly at the end of the
> workday)

Doubt it - NFS server uses ->commit_metadata after the async
operation to ensure that it is completed and on stable storage, so
the truncate on inactivation should run at pretty much the same
speed as on a local filesystem as it's still all async commits. i.e.
the only difference on the NFS server is the log force that follows
the inode inactivation...

> I'll have a look in the morning.  It might take me a while to remember
> how to set up NFS42 :)
> 
> --D
> 
> > NFSv4.2  rmapbt=0   1h-2h
> > xfs      rmapbt=1   10m+
> > 
> > At first I thought it hung, turns out it was just slow when deleting
> > 2 massive reflined files.

Both tests run on the scratch device, so I don't see where there is
a large file unlink in either of these tests.

In which case, I'd expect that all the time is consumed in
generic/176 running punch_alternating to create a million extents
as that will effectively run a synchronous server-side hole punch
half a million times.

However, I'm guessing that the server side filesystem has a very
small log and is on spinning rust, hence the ->commit_metadata log
forces are preventing in-memory aggregation of modifications. This
results in the working set of metadata not fitting in the log and so
each new hole punch transaction ends up waiting on log tail pushing
(i.e. metadata writeback IO).  i.e. it's thrashing the disk, and
that's why it is slow.....

Storage details, please!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
