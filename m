Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94554490BC3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiAQPuU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 10:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiAQPuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 10:50:20 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8CC061574
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 07:50:20 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E0ACE1C1D; Mon, 17 Jan 2022 10:50:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E0ACE1C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642434619;
        bh=stta7jPT5JV6ic+zpY35IswbTVupxvGApC7RQu/DpNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVhbn3JaFvK8+yfTVBYWoUPm4S8xkhIUPJH4eV86SaGELNOiOLX86FRbCiUHjOt4n
         TuSixUnyUDt8ePx56YDQk5MTj3nIbWOPhaGZTgLNLRm23Fu+S8I78mHfRGJDakDLi6
         /FX5cSXIRTFGdsKchATMDkFnHZN3Kcm7mNhSC2aM=
Date:   Mon, 17 Jan 2022 10:50:19 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jonathan Woithe <jwoithe@just42.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Message-ID: <20220117155019.GD28708@fieldses.org>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jan 15, 2022 at 07:46:06PM +0000, Chuck Lever III wrote:
> 
> > On Jan 15, 2022, at 3:14 AM, Jonathan Woithe <jwoithe@just42.net> wrote:
> > 
> > Hi Chuck
> > 
> > Thanks for your response.
> > 
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
> 
> 
> > Is it worth considering a revert of 7f024fcd5c97?  I guess it depends on how
> > many later patches depended on it.
> 
> You can try reverting 7f024fcd5c97, but as I recall there are some
> subsequent changes that depend on that one.

NLM locking on reexports would stop working.  Which is a new (and
imperfect) feature, so less important than avoiding this NULL
dereference, if push came to shove.  But, let's see if we can just fix
it.....

--b.
