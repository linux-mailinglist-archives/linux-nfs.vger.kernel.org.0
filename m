Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8534F2D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDRnh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 13:43:37 -0400
Received: from mail.prgmr.com ([71.19.149.6]:36390 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfFDRnh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 13:43:37 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 5F2DE28C004
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2019 18:41:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 5F2DE28C004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1559688073;
        bh=eLOvs7vzfmDBlXrE6G0KxJ5QNCBzwmwyN3nvNz9jNaA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ieh6seVXtjKcK3HIemQgwVZ1jTQcFpIGVCQgBIjmBgcfYn5j6OFIhCqw7kLUaRcfW
         GC4OJ+Hb8LCUno6XZsV4H35cRggOFLf1bVv66F2IWy9JJh8xEIh/VwkJqRVP2BTTkl
         2b20UpWNV0YUGausPMMjqFn9AgEmQHt95q/EsTXw=
Received: (qmail 31544 invoked by uid 1353); 4 Jun 2019 17:44:48 -0000
Date:   Tue, 4 Jun 2019 11:44:48 -0600
From:   Alan Post <adp@prgmr.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Message-ID: <20190604174448.GA4158@turtle.email>
References: <20190520223324.GL4158@turtle.email>
 <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
 <20190524173155.GQ4158@turtle.email>
 <20190530004146.GV4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530004146.GV4158@turtle.email>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 29, 2019 at 06:41:46PM -0600, Alan Post wrote:
> On Fri, May 24, 2019 at 11:31:55AM -0600, Alan Post wrote:
> > On Tue, May 21, 2019 at 03:46:03PM +0000, Trond Myklebust wrote:
> > > Have you tried upgrading to 4.19.44? There is a fix that went in not
> > > too long ago that deals with a request leak that can cause stack traces
> > > like the above that wait forever.
> > > 
> > 
> > Following up on this.  I have set aside a rack of machines and put
> > Linux 4.19.44 on them.  They ran jobs overnight and will do the
> > same over the long weekend (Memorial day in the US).  Given the
> > error rate (both over time and over submitted jobs) we see across
> > the cluster this well be enough time to draw a conclusion as to
> > whether 4.19.44 exhibits this hang.
> > 
> 
> In the six days I've run Linux 4.19.44 on a single rack, I've seen
> no occurrences of this hang.  Given the incident rate for this
> issue across the cluster over the same period of time, I would have
> expected to see one on two incidents on the rack running 4.19.44.
> 
> This is promising--I'm going to deploy 4.19.44 to another rack
> by the end of the day Friday May 31st and hope for more of the
> same.
>
[snip]
>
> I'll report back no later than next week.
> 

As far as I'm concerned the problem I've reported here is resolved.

I have seen no evidence of this issue on any Linux 4.19.44 kernel
on either the rack I originally set aside or on the second rack
the same kernel was deployed to.

In addition, we began rolling out the upstream Linux 4.19.37 I
mentioned.  The total incident rate across the cluster has trended
down in near lockstep with that deployment, and none of those systems
have shown any evidence of this hang either.

It even happened in a tremendously satisfying way: late last
week we went through a multi-day period of zero occurrences
of this issue anywhere in the cluster, including on kernel
versions where it should have been happening.  That news was *too*
good--everything I understand about the issue suggested it should
have been been occurring less frequently but still ocurring.
Therefor, expecting a regression to the mean, I calculated what
our incident rate should be given our balance of kernel versions,
socialized those numbers around here, and waited for the sampling
period to close.  (we have significant day-over-day load variance
and by comparison little week-over-week load variance.)

Monday when I revisited the problem not only had the incident rate
regressed to the rate I expected, it had done so 'perfectly.'
The actual incident count matched my 'best guess' inside the
range of possible values for the entire sampling period, including
the anomalous no-incident period.

We've got operations work yet to put this issue behind us, but
as best as I can tell the work that remains is a 'simple matter
of effort.'

Thank you Trond.  If I can be of any help, please reach out.

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
