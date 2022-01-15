Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6D48F988
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jan 2022 22:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiAOVXw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jan 2022 16:23:52 -0500
Received: from server.atrad.com.au ([150.101.241.2]:43478 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiAOVXv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jan 2022 16:23:51 -0500
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20FLNaRI025313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 16 Jan 2022 07:53:37 +1030
Date:   Sun, 16 Jan 2022 07:53:36 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Message-ID: <20220115212336.GB30050@marvin.atrad.com.au>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jan 15, 2022 at 07:46:06PM +0000, Chuck Lever III wrote:
> > On Jan 15, 2022, at 3:14 AM, Jonathan Woithe <jwoithe@just42.net> wrote:
> > On Fri, Jan 14, 2022 at 03:18:01PM +0000, Chuck Lever III wrote:
> >>> Recently we migrated an NFS server from a 32-bit environment running 
> >>> kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration remained
> >>> unchanged between the two systems.
> >>> 
> >>> On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 Jan
> >>> under 5.15.12) the kernel has oopsed at around the time that an NFS client
> >>> machine is turned on for the day.  On both occasions the call trace was
> >>> essentially identical.  The full oops sequence is at the end of this email. 
> >>> The oops was not observed when running the 4.14.128 kernel.
> >>> 
> >>> Is there anything more I can provide to help track down the cause of the
> >>> oops?
> >> 
> >> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each
> >> nlm_file"), which was introduced in or around v5.15.  You could try a
> >> simple test and back the server down to v5.14.y to see if the problem
> >> persists.
> > 
> > I could do this, but only perhaps on Monday when I'm next on site.  It may
> > take a while to get an answer though, since it seems we hit the fault only
> > around once every 2 weeks.  Since it's a production server we are of course
> > limited in the things I can do.
> > 
> > I *may* be able to set up another system as an NFS server and hit that with
> > repeated mount requests.  That could help reduce the time we have to wait
> > for an answer.
> 
> Given the callback information you provided, I believe that the problem
> is due to a client reboot, not a mount request. The callback shows the
> crash occurs while your server is processing an SM_NOTIFY request from
> one of your clients.

FYI the situation we have is that most clients (being desktops) are shut
down (cleanly, including umount of all NFS volumes) at the end of each work
day and rebooted the following morning.  I had assumed that it would be the
mount on reboot that was the potential trigger, but it seems there might be
something else going on during the boot process before the mount if I
understand you correctly.

If that's the case it will make it a little trickier to set up a test system
since I don't think I have a second machine I can repeatedly reboot.  I'll
check.

The times of the two crashes we've seen so far do correspond to the time
when the clients tend to get turned on.  Could the problem be dependent on
the client version in any way?  We do have a little variation in this across
the network.  I could check to see which client's boot triggered the oops if
that would be useful.

> > Is it worth considering a revert of 7f024fcd5c97?  I guess it depends on how
> > many later patches depended on it.
> 
> You can try reverting 7f024fcd5c97, but as I recall there are some
> subsequent changes that depend on that one.

Right, that's what I was wondering.  Thus, it sounds like trying a 5.14.y is
perhaps the best option at this stage.

Regards
  jonathan
