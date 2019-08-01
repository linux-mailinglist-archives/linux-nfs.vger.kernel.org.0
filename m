Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F222F7DE83
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfHAPMk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 11:12:40 -0400
Received: from fieldses.org ([173.255.197.46]:44044 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfHAPMk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 11:12:40 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 347877CB; Thu,  1 Aug 2019 11:12:39 -0400 (EDT)
Date:   Thu, 1 Aug 2019 11:12:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190801151239.GC17654@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com>
 <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
 <20190723205846.GB19559@fieldses.org>
 <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org>
 <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 01, 2019 at 10:12:11AM -0400, Olga Kornievskaia wrote:
> On Wed, Jul 31, 2019 at 5:51 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Wed, Jul 31, 2019 at 05:10:01PM -0400, Olga Kornievskaia wrote:
> > > I'm having difficulty with this patch because there is no good way to
> > > know when the copy_notify stateid can be freed. What I can propose is
> > > to have the linux client send a FREE_STATEID with the copy_notify
> > > stateid and use that as the trigger to free the state. In that case,
> > > I'll keep a reference on the parent until the FREE_STATEID is
> > > received.
> > >
> > > This is not in the spec (though seems like a good idea to tell the
> > > source server it's ok to clean up) so other implementations might not
> > > choose this approach so we'll have problems with stateids sticking
> > > around.
> >
> > https://tools.ietf.org/html/rfc7862#page-71
> >
> >         "If the cnr_lease_time expires while the destination server is
> >         still reading the source file, the destination server is allowed
> >         to finish reading the file.  If the cnr_lease_time expires
> >         before the destination server uses READ or READ_PLUS to begin
> >         the transfer, the source server can use NFS4ERR_PARTNER_NO_AUTH
> >         to inform the destination server that the cnr_lease_time has
> >         expired."
> >
> > The spec doesn't really define what "is allowed to finish reading the
> > file" means, but I think the source server should decide somehow whether
> > the target's done.  And "hasn't sent a read in cnr_lease_time" seems
> > like a pretty good conservative definition that would be easy to
> > enforce.
> 
> "hasn't send a read in cnr_lease_time" is already enforced.
> 
> The problem is when the copy did start in normal time, it might take
> unknown time to complete. If we limit copies to all be done with in a
> cnr_lease_time or even some number of that, we'll get into problems
> when files are large enough or network is slow enough that it will
> make this method unusable.

No, I'm just suggesting that if it's been more than cnr_lease_time since
the target server last sent a read using this stateid, then we could
free the stateid.

> > Worst case, if the network goes down for a couple minutes and
> > the target tries to pick up a copy where it left off, it'll get
> > PARTNER_NO_AUTH.  I assume that results in the same error being returned
> > the client, at which point the client knows that the copy_notify stateid
> > may have installed and can do what it chooses to recover (like send a
> > new copy_notify).
> 
> Yes the client recovers but the cost of setting up the source server
> to destination is huge so any retries would kill the performance.

In the rare case when the server goes an entire cnr_lease_time between
reads, the performance hit of recovery won't be an issue.

> > The FREE_STATEID might also be a good idea, but I guess we can't count
> > on it.
> >
> > Maybe the spec could use some errata to clarify that FREE_STATEID is
> > allowed on copy_notify stateids, that clients should send it when
> > they're done, and that servers are allowed to expire copy_notify
> > stateid's even after their first use.
> 
> FREE_STATEID is for a stateid

The discussion of FREE_STATEID in 4.1 says "The FREE_STATEID operation
is used to free a stateid that no longer has any associated locks
(including opens, byte-range locks, delegations, and layouts)."  A
clarification that it can be used for any stateid would be nice.  (Is
that true?  Do we want it for COPY stateid's too?)

--b.

> which a copy_notify (or copy) stateid is so I don't see anything that
> really needs any extra stating.
>
> I think what's needed is specifying that for COPY_NOTIFY a client must
> do a FREE_STATEID when its done with a stateid.
