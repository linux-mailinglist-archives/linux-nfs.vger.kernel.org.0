Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8865C36CDBD
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Apr 2021 23:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhD0VL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Apr 2021 17:11:29 -0400
Received: from gaia.bitwizard.nl ([149.210.166.240]:34104 "EHLO
        gaia.bitwizard.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhD0VL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Apr 2021 17:11:29 -0400
Received: from abra2.bitwizard.nl (unknown [10.8.0.6])
        by gaia.bitwizard.nl (Postfix) with ESMTPS id 8FAAF5A0058;
        Tue, 27 Apr 2021 23:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bitwizard.nl;
        s=default; t=1619557844;
        bh=/EukPnU+lB0aLMe1uASTF5COl8QSgbnoTFlZNoQ9DtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4hhPHK+tcbi6Twz2FWZc4T7j0wKqC2jGqXYHLDYzvYqZH1rQSE+e2uNqcIBU3H6z
         k3VleB26kbwTzdWoAf7BM3sBjUhqXTwIknWRPO5U9Rrm25/ihpHv3WE7rFcIslOVmR
         IK7PpQBaIUkgQzjWZYPKL87+hDJAp8QGVPZzW9npB3yUGyjvB+f2aehbLMMf6Ssxb4
         sCatH8wsU4t44cGlcyGQ8v+G+HqPxvvAB6HaCXzm4GxiW/ru2c2O8hae6nH7VAVUqo
         kFusAKIOJce8769h33pEaqygT8CVDnDSXOYtjjQOa3cBhBKUov+wc+jbCr35o3GRXA
         3coIcstAGoUUA==
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 6437CE42624; Tue, 27 Apr 2021 23:10:44 +0200 (CEST)
Date:   Tue, 27 Apr 2021 23:10:44 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: Lockd error message is unclear.
Message-ID: <20210427211044.vxvgieqe4ud5lh7o@BitWizard.nl>
Organization: BitWizard B.V.
References: <20210427190311.cjjzeded7hl3fkew@BitWizard.nl>
 <20210427193452.GA11361@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427193452.GA11361@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 27, 2021 at 03:34:52PM -0400, J. Bruce Fields wrote:
> On Tue, Apr 27, 2021 at 09:03:11PM +0200, Rogier Wolff wrote:
> > 
> > Hi, 
> > 
> > Two things..... 
> > 
> > I got: 
> > 
> >    lockd: cannot monitor <client> 
> > 
> > in the logfile and the client was terrily slow/not working at all.
> > 
> > everything pointed to a lockd problem... 
> > 
> > In the end... it turns out that my rpc.statd stopped working.  I had
> > to go and download the sources to figure this out... I would firstly
> > suggest to improve the error message to give others running into this
> > more hints as to where to look.
> > 
> > The erorr message on line 169 of lockd.c could read: 
> > 
> > 	lockd: Error in the rpc to rpc.statd to monitor %s\n
> > 
> > Would it be an idea to print the res.status error code? 
> 
> I'm not sure about the wording, but including the error code sounds like
> a good idea.  (Would that have made a difference in your case?)

Not sure. Of course I was just "looking for a solution". So once I
figured out that rpc.statd was missing I went looking for how that
came about. 

But as it was the prime culprit was "lockd is misbehaving". With a
better error message you can shift the blame away from your part of
the system. :-)

> > second?) timeout in nsm_mon_unmon and the big backlog of requests that
> > result in the same call and timeout that frustrate the client... )
> 
> The -ECONNREFUSED case?
> 
> I'm not sure why it retries there.  Maybe just to allow stopping and
> starting rpc.statd (e.g. for upgrades) without failing operations?

Not sure IF it was retrying. Maybe not. But starting "google-chrome"
with 40 open tabs didn't progress to any tabs loading inside the half
hour that I was looking for why this was happening (unable to google
for a solution).... So in the meantime it was constantly spewing the
error message, rate limited to 10 per minute....

	Roger.

-- 
** R.E.Wolff@BitWizard.nl ** https://www.BitWizard.nl/ ** +31-15-2049110 **
**    Delftechpark 11 2628 XJ  Delft, The Netherlands.  KVK: 27239233    **
f equals m times a. When your f is steady, and your m is going down
your a is going up.  -- Chris Hadfield about flying up the space shuttle.
