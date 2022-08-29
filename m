Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD35A4ECE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiH2OHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiH2OHR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 10:07:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7507E817
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 07:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD4ECB81091
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 14:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9505C433D6;
        Mon, 29 Aug 2022 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661782033;
        bh=wOGVo/ncM0Ih336XZ0rMSPGRZ0sG/3LIxXvbzU8l+Ro=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GvNRdacXLhVSQjlJ8x61/A3FmBqQVHgMxKQVUtUXo9fbClekEWqiLz5xzp72MejBq
         gJnsy4lCmffO6iZjbr9oOJpE+rkAIQMe302c3EbvH7Qkm2rbo4rl5JNkdbw5Qf4F0v
         FdNYp6rTKLdm5RTRFs2KQar08V9FJ6aS5uXlhHukALHUtE3cgQHIYyGCaJnAT6Jl1S
         OWAvjAO+1zMreirfd0ki23k6r1ASS8BDBhMTuz3rx/C/qvHbXVsnZufovS+GAHa09V
         xw9k5uFgY2sAfzAdJey1AjV6iXu/1JMohgxRxixSouKFiINNKUb7fAyV0HKPaIINLv
         iAzuz89q6Gm+Q==
Message-ID: <22601f2b7ced45d3b5f44951970f79c22490aced.camel@kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Date:   Mon, 29 Aug 2022 10:07:11 -0400
In-Reply-To: <166172952853.27490.16907220841440758560@noble.neil.brown.name>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
        , <165274590805.17247.12823419181284113076@noble.neil.brown.name>
        , <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
        , <165274805538.17247.18045261877097040122@noble.neil.brown.name>
        , <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
        , <165274950799.17247.7605561502483278140@noble.neil.brown.name>
        , <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
        , <165275056203.17247.1826100963816464474@noble.neil.brown.name>
        , <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
        , <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
        , <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
        , <166155716162.27490.17801636432417958045@noble.neil.brown.name>
        , <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>
         <166172952853.27490.16907220841440758560@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-08-29 at 09:32 +1000, NeilBrown wrote:
> On Sat, 27 Aug 2022, Trond Myklebust wrote:
> > On Sat, 2022-08-27 at 09:39 +1000, NeilBrown wrote:
> > > On Sat, 27 Aug 2022, Trond Myklebust wrote:
> > > > On Fri, 2022-08-26 at 10:59 -0400, Benjamin Coddington wrote:
> > > > > On 16 May 2022, at 21:36, Trond Myklebust wrote:
> > > > > > So until you have a different solution that doesn't impact the
> > > > > > client's
> > > > > > ability to cache permissions, then the answer is going to be
> > > > > > "no"
> > > > > > to
> > > > > > these patches.
> > > > >=20
> > > > > Hi Trond,
> > > > >=20
> > > > > We have some folks negatively impacted by this issue as well.=A0
> > > > > Are
> > > > > you
> > > > > willing to consider this via a mount option?
> > > > >=20
> > > > > Ben
> > > > >=20
> > > >=20
> > > > I don't see how that answers my concern.
> > >=20
> > > Could you please spell out again what your concerns are?=A0 I still
> > > don't
> > > understand.=20
> > > The only performance impact is when a permission test fails.=A0 In wh=
at
> > > circumstance is permission failure expected on a fast-path?
> > >=20
> >=20
> > You're treating the problem as if it were a timeout issue, when clearly
> > it has nothing at all to do with timeouts. There is no problem of
> > 'group membership changes on a regular basis' to be solved.
>=20
> You are the one who suggested a timeout.  I quote:
>=20
> > That way, you have a mechanism that serves all purposes: it can do an
> > immediate one-time only flush, or you can set up a userspace job that
> > issues a global flush once every so often, e.g. using a cron job.
>=20
> "every so often" =3D=3D "timeout".  I thought that maybe this was somewhe=
re
> that we could find some agreement.  As I said, I would set the timeout
> to zero.  I don't really want the timeout - not more than the ac
> timeouts we already have.
>=20
> >=20
> > The problem to be solved is that on the very rare occasion when a group
> > membership does change, then the server and the client may update their
> > view of that membership at completely different times. In the
> > particular case when the client updates its view of the group
> > membership before the server does, then the access cache is polluted,
> > and there is no remedy.
>=20
> Agreed.
>=20
> >=20
> > So my concerns are around the mismatch of problem and solution. I see
> > multiple issues.
> >=20
> >    1. Your timeouts are per inode. That means that if inode A sees the
> >       problem being solved, then there is no guarantee that inode B
> >       sees the same problem as being solved (and the converse is true
> >       as well).
>=20
> Is that a problem?  Is that even anything new?
> If I chmod file A and file B on the server, then the client may see
> the change to file A before the change to file B (or vice-versa).
> i.e.  the inconsistent-cache problem might be solved for one but not the
> other.  It has always been this way.
>=20
> >    2. There is no quick on-the-spot solution. If your admin updates the
> >       group membership, then you are only guaranteed that the client
> >       and server are in sync once the server has picked up the solution
> >       (however you arrange that), and the client cache has expired.
> >       IOW: your only solution is to wait 1 client cache expiration
> >       period after the server is known to be fixed (or to reboot the
> >       client).
>=20
> This is also the only solution to seeing other changes that have been
> made to inodes.
> For file/directory content you can open the file/directory and this
> triggers CTO consistency checks.  But stat() or access() doesn't.
>=20
> Hmmm.. What if we add an ACCESS check to the OPEN request for files, and
> the equivalent GETATTR for directories?  That would provide a direct
> way to force a refresh without adding any extra RPC requests??
>=20
> >    3. There is no solution at all for the positive cache case. If your
> >       sysadmin is trying to revoke an access due to a group membership
> >       change, their only solution is to reboot the client.
>=20
> Yes.  Revoking read/execute access that you have already granted is not
> really possible.  The application may have already read the file.  It
> might even have emailed the content to $BLACKHAT.  Even rebooting the
> client isn't really a solution.
> Revoking write access already works fine as does revoking read access to
> a file before putting new content in it - the new content is safe.
>=20
> >    4. You are tying the access cache timeout to the completely
> >       unrelated 'acregmin' and 'acdirmin' values. Not only does that
> >       mean that the default values for regular files are extremely
> >       small (3 seconds), meaning that we have to refresh extremely
> >       often. However it also means that you have to explain why
> >       directories behave differently (longer default timeouts) despite
> >       the fact that the group membership changed at exactly the same
> >       time for both types of object.
> >          1. Bonus points for explaining why our default values are desi=
gned
> >             for a group membership that changes every 3 seconds.
>=20
> I don't see why you treat the access information as different from all
> the other attributes.  "bob has group x access to the directory" and
> "file size if 42000 bytes" are just attributes of the inode.  We collect
> them different ways, but they are not deeply different.
>=20
> The odd thing here is that we cache these "access" attributes
> indefinitely when ctime doesn't change - even though there is no
> guarantee that ctime captures access changes.  I think that choice needs
> to be justified.

Maybe I'm being pedantic, but I don't see the first as an inode
attribute. There are really 2 pieces to that access control example:

- bob is a member of group x
- group x has access to the directory

The first has nothing directly to do with the inode and so it's no
surprise that its ctime and i_version aren't affected when group
membership changes.

> Using the cached value indefinitely when it grants access is defensible
> because it is a frequent operation (checking x access in a directory
> while following a patch).  I think that adequately justifies the choice.
> I cannot see the justification when the access is denied by the cache.
>=20
> >    5. 'noac' suddenly now turns off access caching, but only for
> >       negative cached values.
>=20
> Is this a surprise?
>=20
> But what do you think of adding an ACCESS check when opening a dir/file?
> At least for NFSv4?

--=20
Jeff Layton <jlayton@kernel.org>
