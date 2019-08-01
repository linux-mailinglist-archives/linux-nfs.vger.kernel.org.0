Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA37E1FC
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfHASL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 14:11:58 -0400
Received: from fieldses.org ([173.255.197.46]:44232 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732012AbfHASL6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 14:11:58 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 480BD7CB; Thu,  1 Aug 2019 14:11:58 -0400 (EDT)
Date:   Thu, 1 Aug 2019 14:11:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190801181158.GC19461@fieldses.org>
References: <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
 <20190723205846.GB19559@fieldses.org>
 <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org>
 <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org>
 <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
 <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 01, 2019 at 02:06:46PM -0400, Olga Kornievskaia wrote:
> On Thu, Aug 1, 2019 at 11:41 AM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> >
> > On Thu, Aug 1, 2019 at 11:13 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Thu, Aug 01, 2019 at 10:12:11AM -0400, Olga Kornievskaia wrote:
> > > > On Wed, Jul 31, 2019 at 5:51 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2019 at 05:10:01PM -0400, Olga Kornievskaia wrote:
> > > > > > I'm having difficulty with this patch because there is no good way to
> > > > > > know when the copy_notify stateid can be freed. What I can propose is
> > > > > > to have the linux client send a FREE_STATEID with the copy_notify
> > > > > > stateid and use that as the trigger to free the state. In that case,
> > > > > > I'll keep a reference on the parent until the FREE_STATEID is
> > > > > > received.
> > > > > >
> > > > > > This is not in the spec (though seems like a good idea to tell the
> > > > > > source server it's ok to clean up) so other implementations might not
> > > > > > choose this approach so we'll have problems with stateids sticking
> > > > > > around.
> > > > >
> > > > > https://tools.ietf.org/html/rfc7862#page-71
> > > > >
> > > > >         "If the cnr_lease_time expires while the destination server is
> > > > >         still reading the source file, the destination server is allowed
> > > > >         to finish reading the file.  If the cnr_lease_time expires
> > > > >         before the destination server uses READ or READ_PLUS to begin
> > > > >         the transfer, the source server can use NFS4ERR_PARTNER_NO_AUTH
> > > > >         to inform the destination server that the cnr_lease_time has
> > > > >         expired."
> > > > >
> > > > > The spec doesn't really define what "is allowed to finish reading the
> > > > > file" means, but I think the source server should decide somehow whether
> > > > > the target's done.  And "hasn't sent a read in cnr_lease_time" seems
> > > > > like a pretty good conservative definition that would be easy to
> > > > > enforce.
> > > >
> > > > "hasn't send a read in cnr_lease_time" is already enforced.
> > > >
> > > > The problem is when the copy did start in normal time, it might take
> > > > unknown time to complete. If we limit copies to all be done with in a
> > > > cnr_lease_time or even some number of that, we'll get into problems
> > > > when files are large enough or network is slow enough that it will
> > > > make this method unusable.
> > >
> > > No, I'm just suggesting that if it's been more than cnr_lease_time since
> > > the target server last sent a read using this stateid, then we could
> > > free the stateid.
> >
> > That's reasonable. Let me do that.
> 
> Now that I need a global list for the copy_notify stateids, do you
> have a preference for either to keep it of the nfs4_client structure
> or the nfsd_net structure? I store async copies under the nfs4_client
> structure but the laundromat traverses things in nfsd_net structure.

If copy_notify stateids are associated with a client, then they must
already be reachable from the client somehow so they can be destroyed at
the time the client is, right?  I'm saying that without looking at the
code....

--b.
