Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E62E9C2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfE3Akn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:40:43 -0400
Received: from mail.prgmr.com ([71.19.149.6]:60060 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfE3Akn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:40:43 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 0605628C00B
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2019 01:38:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 0605628C00B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1559194707;
        bh=iuloNs8wIVZA7gyks+IViCH3L+wBferKpveIH3UwHw0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aOXJi5lJQoYYWMwyquKSIdpgSTujrLf5lJRsG59NM+GkdZZWS012mWbUj1oParj6A
         Drx6ZzZuOuZX0U6DbkxIVbFFmSPkXp+jp/2vtmGwJC0VUI0R07Mc2x47ll0kizQmZi
         qFXLRcSp8CCVwyriknB4UXcZs1Wm1QbPRyzHWo8w=
Received: (qmail 18344 invoked by uid 1353); 30 May 2019 00:41:46 -0000
Date:   Wed, 29 May 2019 18:41:46 -0600
From:   Alan Post <adp@prgmr.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Message-ID: <20190530004146.GV4158@turtle.email>
References: <20190520223324.GL4158@turtle.email>
 <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
 <20190524173155.GQ4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524173155.GQ4158@turtle.email>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 24, 2019 at 11:31:55AM -0600, Alan Post wrote:
> On Tue, May 21, 2019 at 03:46:03PM +0000, Trond Myklebust wrote:
> > Have you tried upgrading to 4.19.44? There is a fix that went in not
> > too long ago that deals with a request leak that can cause stack traces
> > like the above that wait forever.
> > 
> 
> Following up on this.  I have set aside a rack of machines and put
> Linux 4.19.44 on them.  They ran jobs overnight and will do the
> same over the long weekend (Memorial day in the US).  Given the
> error rate (both over time and over submitted jobs) we see across
> the cluster this well be enough time to draw a conclusion as to
> whether 4.19.44 exhibits this hang.
> 

In the six days I've run Linux 4.19.44 on a single rack, I've seen
no occurrences of this hang.  Given the incident rate for this
issue across the cluster over the same period of time, I would have
expected to see one on two incidents on the rack running 4.19.44.

This is promising--I'm going to deploy 4.19.44 to another rack
by the end of the day Friday May 31st and hope for more of the
same.

I wondered upthread whether the following commits were what you
had in mind when you asked about 4.19.44:

    63b0ee126f7e: NFS: Fix an I/O request leakage in nfs_do_recoalesce
    be74fddc976e: NFS: Fix I/O request leakages

Confirming that it is these patches and no others has become
topical for me: my upstream is now providing a 4.19.37 build,
and I note these two patches are included since 4.19.31 and so
are presumably in my now-available upstream 4.19.37 build.

If I could trouble you to confirm whether or not this is the
complete set of patches you had in mind for the 4.19 branch
after 4.19.28 when you recommended I try 4.19.44 I would
appreciate it.

Lurking on the list for the past week or two and watching
everyone's work has been inspiring.  Thank you again.  I'll report
back no later than next week.

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
