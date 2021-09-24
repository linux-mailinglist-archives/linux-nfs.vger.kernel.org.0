Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311AC41691C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 02:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbhIXA6S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 20:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXA6S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 20:58:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87352C061574;
        Thu, 23 Sep 2021 17:56:46 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 897D932EC; Thu, 23 Sep 2021 20:56:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 897D932EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632445005;
        bh=2u0mZp0WPQZTQXLgZBw3vQsas0QI27eSYvFL9rXD2Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4Eo8vR6O3fH9TIlsLXZ/JSQy3MIOIuQZoJUIW+L23k7VD9e6gecVQqGF0ksZEsuD
         fAofUKMBm5/fwWRawSiQus87lHghMfGMgwGVftJ09dTnbuYyr6i4Qlx2/9r0858wkm
         jqw1qKS4QtiMiEtef92NmUMCxtkqSApEpi9eqrC8=
Date:   Thu, 23 Sep 2021 20:56:45 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Jeremy Allison <jra@samba.org>
Cc:     dai.ngo@oracle.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Message-ID: <20210924005645.GA28137@fieldses.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
 <YU0hAYLow+8n8siT@jeremy-acer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU0hAYLow+8n8siT@jeremy-acer>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 23, 2021 at 05:51:13PM -0700, Jeremy Allison wrote:
> On Thu, Sep 23, 2021 at 03:39:52PM -0700, dai.ngo@oracle.com wrote:
> >
> >On 9/23/21 2:50 PM, Bruce Fields wrote:
> >>On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
> >>>Hi Bruce,
> >>Oops, sorry for neglecting this.
> >>
> >>>I'm doing some locking testing between NFSv4 and SMB client and
> >>>think there are some issues on the server that allows both clients
> >>>to lock the same file at the same time.
> >>It's not too surprising to me that getting consistent locks between the
> >>two would be hard.
> >>
> >>Did you get any review from a Samba expert?  I seem to recall it having
> >>a lot of options, and I wonder if it's configured correctly for this
> >>case.
> >
> >No, I have not heard from any Samba expert.
> >
> >>
> >>It sounds like Samba may be giving out oplocks without getting a lease
> >>from the kernel.
> >
> >I will have to circle back to this when we're done with the 1st
> >phase of courteous server.
> >
> >-Dai
> >
> >>
> >>--b.
> >>
> >>>Here is what I did:
> >>>
> >>>NOTE: lck is a simple program that use lockf(3) to lock a file from
> >>>offset 0 to the length specified by '-l'.
> 
> What does lockf map to in NFS ?
> 
> Samba only uses posix fcntl byte range locks (and only when
> told to map SMB locks onto underlying posix locks), we don't use
> lockf at all.

Yeah, it's the same thing, lockf just maps to fcntl locks.

You're probably thinking of flock.

--b.
