Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC5048F5F2
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jan 2022 09:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiAOIOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jan 2022 03:14:47 -0500
Received: from server.atrad.com.au ([150.101.241.2]:43476 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiAOIOr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jan 2022 03:14:47 -0500
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20F8EKPv029479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 15 Jan 2022 18:44:22 +1030
Date:   Sat, 15 Jan 2022 18:44:20 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Message-ID: <20220115081420.GB8808@marvin.atrad.com.au>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck

Thanks for your response.

On Fri, Jan 14, 2022 at 03:18:01PM +0000, Chuck Lever III wrote:
> > Recently we migrated an NFS server from a 32-bit environment running 
> > kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration remained
> > unchanged between the two systems.
> > 
> > On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 Jan
> > under 5.15.12) the kernel has oopsed at around the time that an NFS client
> > machine is turned on for the day.  On both occasions the call trace was
> > essentially identical.  The full oops sequence is at the end of this email. 
> > The oops was not observed when running the 4.14.128 kernel.
> > 
> > Is there anything more I can provide to help track down the cause of the
> > oops?
> 
> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each
> nlm_file"), which was introduced in or around v5.15.  You could try a
> simple test and back the server down to v5.14.y to see if the problem
> persists.

I could do this, but only perhaps on Monday when I'm next on site.  It may
take a while to get an answer though, since it seems we hit the fault only
around once every 2 weeks.  Since it's a production server we are of course
limited in the things I can do.

I *may* be able to set up another system as an NFS server and hit that with
repeated mount requests.  That could help reduce the time we have to wait
for an answer.

Is it worth considering a revert of 7f024fcd5c97?  I guess it depends on how
many later patches depended on it.

> Otherwise, Bruce, can you have a look at this?

Regards
  jonathan
