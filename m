Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B64499E72
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 00:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382665AbiAXWeK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 17:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584563AbiAXWVZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 17:21:25 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5915AC0424D8
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 12:50:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E6AAC6EF7; Mon, 24 Jan 2022 15:50:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E6AAC6EF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643057445;
        bh=kMJeqI0CP/y4AB+VmAmapV6G+LoxVuefctntM2q7Tag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGo0ghGhJytMAWJNrfn+K9o3N39gOdFLlXT0ntqTyqFJMXKr270M1ABT23GA6OF0G
         A+CB3vmWm9VRrkdtBdvHTF/jn8JUVxuSwks46vKW4I4d3Cab48vUafpaEb+EPHsyWR
         LbIYfKbTeRFJE/GxhV5bjA873GBrelAKxgSxosVU=
Date:   Mon, 24 Jan 2022 15:50:45 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220124205045.GB4975@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 08:10:07PM +0000, Daire Byrne wrote:
> On Mon, 24 Jan 2022 at 19:38, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Sun, Jan 23, 2022 at 11:53:08PM +0000, Daire Byrne wrote:
> > > I've been experimenting a bit more with high latency NFSv4.2 (200ms).
> > > I've noticed a difference between the file creation rates when you
> > > have parallel processes running against a single client mount creating
> > > files in multiple directories compared to in one shared directory.
> >
> > The Linux VFS requires an exclusive lock on the directory while you're
> > creating a file.
> 
> Right. So when I mounted the same server/dir multiple times using
> namespaces, all I was really doing was making the VFS *think* I wanted
> locks on different directories even though the remote server directory
> was actually the same?

In that scenario the client-side locks are probably all different, but
they'd all have to wait for the same lock on the server side, yes.

> > So, if L is the time in seconds required to create a single file, you're
> > never going to be able to create more than 1/L files per second, because
> > there's no parallelism.
> 
> And things like directory delegations can't help with this kind of
> workload? You can't batch directories locks or file creates I guess.

Alas, there are directory delegations specified in RFC 8881, but they
are read-only, and nobody's implemented them.

Directory write delegations could help a lot, if they existed.

> > So, it's not surprising you'd get a higher rate when creating in
> > multiple directories.
> >
> > Also, that lock's taken on both client and server.  So it makes sense
> > that you might get a little more parallelism from multiple clients.
> >
> > So the usual advice is just to try to get that latency number as low as
> > possible, by using a low-latency network and storage that can commit
> > very quickly.  (An NFS server isn't permitted to reply to the RPC
> > creating the new file until the new file actually hits stable storage.)
> >
> > Are you really seeing 200ms in production?
> 
> Yea, it's just a (crazy) test for now. This is the latency between two
> of our offices. Running batch jobs over this kind of latency with a
> NFS re-export server doing all the caching works surprisingly well.
> 
> It's just these file creations that's the deal breaker. A batch job
> might create 100,000+ files in a single directory across many clients.
> 
> Maybe many containerised re-export servers in round-robin with a
> common cache is the only way to get more directory locks and file
> creates in flight at the same time.

ssh into the original server and crate the files there?

I've got no help, sorry.

The client-side locking does seem redundant to some degree, but I don't
know what to do about it.

--b.
