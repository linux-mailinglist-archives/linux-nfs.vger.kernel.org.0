Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE79D4F019
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2019 22:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFUUpy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jun 2019 16:45:54 -0400
Received: from mail.prgmr.com ([71.19.149.6]:34166 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUUpx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 Jun 2019 16:45:53 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 45ECD28C003
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 21:43:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 45ECD28C003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1561167788;
        bh=PEggR+xb+wNPnPYain2ruZE4jwc0J6l5mkP2Z/QzGlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2BxJCadQqU+Wv/Fd2e+2b/nOw++0ZsyzuoRMgEpNVxPHt3KOzXNGn6fI8QHcbF89
         4w/LvLKWer9x7K78jUXRO0hSKmG8WsGKFW3FM7tR3xy9ds8wJLh2+5QwoJozcfhGc2
         E3UxLXBlCBIS1p9GyallFSUrnhVOFaFAdcvAE5Hk=
Received: (qmail 25420 invoked by uid 1353); 21 Jun 2019 20:47:23 -0000
Date:   Fri, 21 Jun 2019 14:47:23 -0600
From:   Alan Post <adp@prgmr.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Message-ID: <20190621204723.GU4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
 <20190619000746.GT4158@turtle.email>
 <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 19, 2019 at 08:38:02AM -0400, Benjamin Coddington wrote:
> TCP drops or overruns should not be a problem since the TCP layer will
> retransmit packets that are not acked.  The issue would be if the NFS
> server is perhaps silently dropping a response to an IO RPC.  Or, an
> intelligent middle-box that keeps its own stateful transparent TCP handling
> between client and server existed (you clearly don't have that here).
> 

My conclusion as well.  As part of debugging a complicity
of reliability issues with the cluster, we've found that
some workloads are more likely to lead to NFS client hang.
We've migrated the exports used by those workloads to dedicated
NFS servers, one of which is the server under discussion here.


> So I recall some knfsd issues dropping replies in that era of kernel
> versions when the GSS sequencing grew out of a window.  Are you using a
> sec=krb5* on these mounts, or is it all sec=sys?  Perhaps that's the problem
> you are seeing.  Again, just some guessing.
> 

We're using sec=sys for the NFS clients that hung on
wait_on_commit, but have in the past used Kerberos.  I'm still
chasing down at least intermittent, lingering issue where an
open(2) will return EIO, while on the the wire those procedures
are returning NFS4ERR_EXPIRED.  What appears to happening,
though I'm not certain yet, is that a RENEW CID is or tries to
be done with Kerberos when it was not previously, which succeeds,
but only in this degraded manner.

I cannot then rule out something of the sort you're describing.
Thank you for bringing it to my attention.


> Verifying this is the problem could be done by setting up some rolling
> network captures.. but sometimes it can be hard to not have the capture
> fill up with continuing traffic from other processes.
> 

I did go ahead and set up a rolling capture between this NFS
server and one rack of clients--I hope I can catch the event as
it happens.  Time will tell.

Regards,

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
