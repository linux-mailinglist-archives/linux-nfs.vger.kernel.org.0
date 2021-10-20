Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831BA43523D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhJTSDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhJTSC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 14:02:59 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A776C06161C
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 11:00:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EA4026C8A; Wed, 20 Oct 2021 14:00:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EA4026C8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634752843;
        bh=toabXZEV3QSOzdg1WxTHTkF1BdT9IQx1b1f2fsUlKXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIW8w1bYBrTosQ5JY3qOEn7G0bltAvcibu+R2OuQ1WfjSfOlHyA/d96hlIdMp23FB
         kPmXrG7TatckK0K6DXxF2HhPrZOheCWqb7/XL4tQPghDwB/1QBURIDGvNy++uOBQ7J
         c8Iu02qourC/odnuxnD/wPUaa/J4DoRaNtadcY+Q=
Date:   Wed, 20 Oct 2021 14:00:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211020180043.GD597@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 12:37:08PM -0400, Olga Kornievskaia wrote:
> On Wed, Oct 20, 2021 at 11:54 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > knfsd has supported server-to-server copy for a couple years (since
> > 5.5).  You have set a module parameter to enable it.  I'm getting asked
> > when we could turn that parameter on by default.
> >
> > I've got a couple vague criteria: one just general maturity, the other a
> > security question:
> >
> > 1. General maturity: the only reports I recall seeing are from testers.
> > Is anyone using this?  Does it work for them?  Do they find a benefit?
> > Maybe we could turn it on by default in one distro (Fedora?) and promote
> > it a little and see what that turns up?
> >
> > 2. Security question: with server-to-server copy enabled, you can send
> > the server a COPY call with any random address, and the server will
> > mount that address, open a file, and read from it.  Is that safe?

(Whoops, I forgot, there's no open, just reads.  And I don't know how
much actual protocol there is involved in the mount.)

> How about adding a piece then on the server (a policy) that would only
> control that? The concept behind the server-to-server was that servers
> might have a private/fast network between them that they would want to
> utilize. A more restrictive policy could be to only allow predefined
> network space to do the COPY? I know that more work. But sound like
> perhaps it might be something that provides more control to the
> server.

That sounds like a step backwards if you're trying to enable it by
default.

But in the case there's a special server-to-server network, the way to
handle that is by configuring the source server to return addresses on
that network in the cnr_source_server field of the COPY_NOTIFY reply,
right?

> But as Chuck pointed out perhaps the kerberos piece would make this
> concern irrelevant.

I don't think kerberos addresses this.  (It may make increase the attack
surface, in fact.)

> > Normally we only mount servers that were chosen by root.  Here we'll
> > mount any random server that some client told us to.  What's the worst
> > that random server can do?  Do we trust our xdr decoding?  Can it DOS us
> > by throwing the client's state recovery code into some loop with weird
> > error returns?  Etc.
> 
> Client code has been modified to know about special copy stateids that
> if the client gets BAD_STATEID it knows not to try to do recovery and
> instead it errors back to the "application", it being nfsd.

Good to know, thanks.  What are the list of rpc calls that are made to
the source server--is it just READ, or does it at least need to create a
client and a session?  Are there any other error handling paths that we
wouldn't want to go down?  Etc.

--b.

> > Maybe it's fine.  I'm OK with some level of risk.  I just want to make
> > sure somebody's thought this through.
> >
> > There's also interest in allowing unprivileged NFS mounts, but I don't
> > think we've turned that on yet, partly for similar reasons.  This is a
> > subset of that problem.
> >
> > --b.
