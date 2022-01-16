Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6E48FF68
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiAPWGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 17:06:43 -0500
Received: from server.atrad.com.au ([150.101.241.2]:54714 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAPWGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jan 2022 17:06:43 -0500
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20GM6R5X005681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 17 Jan 2022 08:36:29 +1030
Date:   Mon, 17 Jan 2022 08:36:27 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Message-ID: <20220116220627.GA19813@marvin.atrad.com.au>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115212336.GB30050@marvin.atrad.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 16, 2022 at 07:53:36AM +1030, Jonathan Woithe wrote:
> On Sat, Jan 15, 2022 at 07:46:06PM +0000, Chuck Lever III wrote:
> > > On Jan 15, 2022, at 3:14 AM, Jonathan Woithe <jwoithe@just42.net> wrote:
> > > On Fri, Jan 14, 2022 at 03:18:01PM +0000, Chuck Lever III wrote:
> > >>> Recently we migrated an NFS server from a 32-bit environment running 
> > >>> kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration remained
> > >>> unchanged between the two systems.
> > >>> 
> > >>> On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 Jan
> > >>> under 5.15.12) the kernel has oopsed at around the time that an NFS client
> > >>> machine is turned on for the day.  On both occasions the call trace was
> > >>> essentially identical.  The full oops sequence is at the end of this email. 
> > >>> The oops was not observed when running the 4.14.128 kernel.
> > >>> 
> > >>> Is there anything more I can provide to help track down the cause of the
> > >>> oops?
> > >> 
> > >> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each
> > >> nlm_file"), which was introduced in or around v5.15.  You could try a
> > >> simple test and back the server down to v5.14.y to see if the problem
> > >> persists.

FYI I have now put the kernel.org 5.14.21 kernel on the affected system and
booted it.  Since the oops has taken between 1 and 2 weeks to be triggered
in the past, we may have to wait a few weeks to be certain of an outcome. 
If there's anything else you need from me in the interim please ask.

Regards
  jonathan
