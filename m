Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23972372119
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhECUKs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECUKr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 May 2021 16:10:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0601C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 13:09:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BFD9E4183; Mon,  3 May 2021 16:09:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BFD9E4183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620072592;
        bh=MHFegGsp7gBkk6hj1OHeZy+/5FxuTdpXRuG55FJ0QxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGv/WlmSLraqxOCwArD52Jn2+iHY1OoYCBCB3H24jaz3619ca7A9LaZ6DKwQhdHCq
         Da7Y7c/qCTVxjhtTYyRGrPRhGCZ4pjhWV7k6eZk02V9Li1UKlOcVE7zB/J+jLcLYjJ
         6HtMgiUYAYnpFiMSH1nalJV/p/vR9hpPvN5OScH0=
Date:   Mon, 3 May 2021 16:09:52 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "fsorenso@redhat.com" <fsorenso@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "jshivers@redhat.com" <jshivers@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20210503200952.GB18779@fieldses.org>
References: <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
 <20210119222229.GA29488@fieldses.org>
 <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com>
 <20210120150737.GA17548@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120150737.GA17548@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 20, 2021 at 10:07:37AM -0500, bfields@fieldses.org wrote:
> On Tue, Jan 19, 2021 at 11:09:55PM +0000, Trond Myklebust wrote:
> > On Tue, 2021-01-19 at 17:22 -0500, bfields@fieldses.org wrote:
> > > On Wed, Oct 07, 2020 at 04:50:26PM +0000, Trond Myklebust wrote:
> > > > As far as I can tell, this thread started with a complaint that
> > > > performance suffers when we don't allow setups that hack the client
> > > > by
> > > > pretending that a multi-homed server is actually multiple different
> > > > servers.
> > > > 
> > > > AFAICS Tom Talpey's question is the relevant one. Why is there a
> > > > performance regression being seen by these setups when they share
> > > > the
> > > > same connection? Is it really the connection, or is it the fact
> > > > that
> > > > they all share the same fixed-slot session?
> > > > 
> > > > I did see Igor's claim that there is a QoS issue (which afaics
> > > > would
> > > > also affect NFSv3), but why do I care about QoS as a per-mountpoint
> > > > feature?
> > > 
> > > Sorry for being slow to get back to this.
> > > 
> > > Some more details:
> > > 
> > > Say an NFS server exports /data1 and /data2.
> > > 
> > > A client mounts both.  Process 'large' starts creating 10G+ files in
> > > /data1, queuing up a lot of nfs WRITE rpc_tasks.
> > > 
> > > Process 'small' creates a lot of small files in /data2, which
> > > requires a
> > > lot of synchronous rpc_tasks, each of which wait in line with the
> > > large
> > > WRITE tasks.
> > > 
> > > The 'small' process makes painfully slow progress.
> > > 
> > > The customer previously made things work for them by mounting two
> > > different server IP addresses, so the "small" and "large" processes
> > > effectively end up with their own queues.
> > > 
> > > Frank Sorenson has a test showing the difference; see
> > > 
> > >         https://bugzilla.redhat.com/show_bug.cgi?id=1703850#c42
> > >         https://bugzilla.redhat.com/show_bug.cgi?id=1703850#c43
> > > 
> > > In that test, the "small" process creates files at a rate thousands
> > > of
> > > times slower when the "large" process is also running.
> > > 
> > > Any suggestions?
> > > 
> > 
> > I don't see how this answers my questions above?
> 
> So mainly:
> 
> > > > Why is there a performance regression being seen by these setups
> > > > when they share the same connection? Is it really the connection,
> > > > or is it the fact that they all share the same fixed-slot session?
> 
> I don't know.  Any pointers how we might go about finding the answer?

I set this aside and then get bugged about it again.

I apologize, I don't understand what you're asking for here, but it
seemed obvious to you and Tom, so I'm sure the problem is me.  Are you
free for a call sometime maybe?  Or do you have any suggestions for how
you'd go about investigating this?

Would it be worth experimenting with giving some sort of advantage to
readers?  (E.g., reserving a few slots for reads and getattrs and such?)

--b.

> It's easy to test the case of entirely seperate state & tcp connections.
> 
> If we want to test with a shared connection but separate slots I guess
> we'd need to create a separate session for each nfs4_server, and a lot
> of functions that currently take an nfs4_client would need to take an
> nfs4_server?
> 
> --b.
