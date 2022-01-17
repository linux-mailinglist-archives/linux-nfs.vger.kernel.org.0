Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99A49119B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 23:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbiAQWJK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 17:09:10 -0500
Received: from server.atrad.com.au ([150.101.241.2]:41370 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiAQWJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 17:09:08 -0500
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20HM8qtp007107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 18 Jan 2022 08:38:53 +1030
Date:   Tue, 18 Jan 2022 08:38:52 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Message-ID: <20220117220851.GA8494@marvin.atrad.com.au>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117074430.GA22026@marvin.atrad.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 17, 2022 at 06:14:30PM +1030, Jonathan Woithe wrote:
> > >>>>> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each
> > >>>>> nlm_file"), which was introduced in or around v5.15.  You could try a
> > >>>>> simple test and back the server down to v5.14.y to see if the problem
> > >>>>> persists.
> > > 
> > > FYI I have now put the kernel.org 5.14.21 kernel on the affected system and
> > > booted it.  Since the oops has taken between 1 and 2 weeks to be triggered
> > > in the past, we may have to wait a few weeks to be certain of an outcome. 
> > > If there's anything else you need from me in the interim please ask.
> > 
> > If you identify a particular client that triggers the issue, it would be
> > helpful to know:
> > 
> > - The client's kernel version
> > - What was running on the client before it was shut down
> > - Whether the application and client shut down was clean
> 
> I have been able to identify the client involved.  It was the same client
> on both occasions.  That client is running the 4.4.14 kernel.
> :
> I will ask the user if they remember anything happening differently on the
> days of the server oops.

I have asked the user, and certainly in the case of the most recent oops the
previous day's usage (that is, the day of the unclean shutdown, the day
before the boot which triggered the server oops) was nothing out of the
ordinary.  Firefox, thunderbird and libreoffice were the only applications
used, with the desktop file browser also getting an outing.  The desktop is
xfce4.  These programs would have been used variously over the course of the
day (roughly 7.5 hours on this particular date).

> With the server running 5.14.21, I did a reset of the client (that is,
> unclean shutdown) just before I left this evening.  The server did not oops
> when the client was rebooted a minute or so later.  I will see if I can
> repeat the test with 5.15.12 tomorrow morning before others get in if you
> think that will be helpful in light of the above observations.

I did this test this morning before others came in.  The server (with
5.15.12 running) did not oops.  However, with the recent mention of locking
this may not be surprising since no NFS locking had been attempted on the
client during the test (mainly because I had no easy way to elicit a lock). 
I merely booted the client, reset it and let it boot again.

During the course of the day the client will run firefox, thunderbird and
libreoffice, all of which probably involve locking of various descriptions. 
Thus a test without locking is perhaps not perfect.

I am happy to run further tests if it will help.  Let me know if I can do
anything else.

Regards
  jonathan
