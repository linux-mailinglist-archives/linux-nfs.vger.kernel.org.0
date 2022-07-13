Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F081573D07
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiGMTNT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiGMTNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECE227FCA
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58899B82127
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26DDC34114;
        Wed, 13 Jul 2022 19:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739595;
        bh=cGnmmoy035VJo5AjAdAgJfAkmvYdLE8EJYFHoMKb1t4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f2zua78yqXR5dvmi44dvAGR4WXcwFM2KdQZMcwJPQcd01QAQutZgJ62iIvjZM/Ipc
         Dabcrl5Boxy/15hBLpCWLGi0YFUmQ+P/xHZEU25BHaoc7FtMg15Injr07FrgjEQOu4
         eOIl5P0nZ5wUtjPfESf4c3sSZrRcRrtADaWBQwHO9Oot2fHIG/OulSeG6cZJeQbsVq
         MqQqGJu7SaNQSR/Y39DDhGpyiypgucRQd+GJxacbQ3RE5MlZFlFqb5EW+FNFSqLgtX
         qNqxxBsVP/BQgPb0q29ssEGzzP+h3VdbK5c092yKcfJ4eid/ts1qeQnyXgt7bfhgrI
         WGE9KiDr9ciUg==
Message-ID: <305c28b90f4d51dac01456cbb383c95999ef5f65.camel@kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 13 Jul 2022 15:13:13 -0400
In-Reply-To: <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
         <165759318889.25184.8939985512802350340@noble.neil.brown.name>
         <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
         <165768676476.25184.1334928545636067316@noble.neil.brown.name>
         <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-07-13 at 14:15 +0000, Chuck Lever III wrote:
>=20
> > On Jul 13, 2022, at 12:32 AM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Wed, 13 Jul 2022, Chuck Lever III wrote:
> > >=20
> > > > On Jul 11, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
> > > >=20
> > > > On Thu, 07 Jul 2022, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
> > > > > >=20
> > > > > > This series prepares NFSD to be able to adjust to work with a p=
roposed
> > > > > > patch which allows updates to directories to happen in parallel=
.
> > > > > > This patch set changes the way directories are locked, so the p=
resent
> > > > > > series cleans up some locking in nfsd.
> > > > > >=20
> > > > > > Specifically we remove fh_lock() and fh_unlock().
> > > > > > These functions are problematic for a few reasons.
> > > > > > - they are deliberately idempotent - setting or clearing a flag
> > > > > > so that a second call does nothing. This makes locking errors h=
arder,
> > > > > > but it results in code that looks wrong ... and maybe sometimes=
 is a
> > > > > > little bit wrong.
> > > > > > Early patches clean up several places where this idempotent nat=
ure of
> > > > > > the functions is depended on, and so makes the code clearer.
> > > > > >=20
> > > > > > - they transparently call fh_fill_pre/post_attrs(), including a=
t times
> > > > > > when this is not necessary. Having the calls only when necessar=
y is
> > > > > > marginally more efficient, and arguably makes the code clearer.
> > > > > >=20
> > > > > > nfsd_lookup() currently always locks the directory, though ofte=
n no lock
> > > > > > is needed. So a patch in this series reduces this locking.
> > > > > >=20
> > > > > > There is an awkward case that could still be further improved.
> > > > > > NFSv4 open needs to ensure the file is not renamed (or unlinked=
 etc)
> > > > > > between the moment when the open succeeds, and a later moment w=
hen a
> > > > > > "lease" is attached to support a delegation. The handling of th=
is lock
> > > > > > is currently untidy, particularly when creating a file.
> > > > > > It would probably be better to take a lease immediately after
> > > > > > opening the file, and then discarding if after deciding not to =
provide a
> > > > > > delegation.
> > > > > >=20
> > > > > > I have run fstests and cthon tests on this, but I wouldn't be s=
urprised
> > > > > > if there is a corner case that I've missed.
> > > > >=20
> > > > > Hi Neil, thanks for (re)posting.
> > > > >=20
> > > > > Let me make a few general comments here before I send out specifi=
c
> > > > > review nits.
> > > > >=20
> > > > > I'm concerned mostly with how this series can be adequately teste=
d.
> > > > > The two particular areas I'm worried about:
> > > > >=20
> > > > > - There are some changes to NFSv2 code, which is effectively
> > > > > fallow. I think I can run v2 tests, once we decide what tests
> > > > > should be run.
> > > >=20
> > > > I hope we can still test v2... I know it is disabled by default..
> > > > If we can't test it, we should consider removing it.
> > >=20
> > > The work of deprecating and removing NFSv2 is already under way.
> > > I think what I'm asking is if /you/ have tested the NFSv2 changes.
> >=20
> > That's a question I can answer. I haven't. I will.
>=20
> Just in case it's not clear by now, NFSv2 (and NFSv3)
> stability is the reason I don't want to perturb the
> NFSD VFS API code in any significant way unless it's
> absolutely needed.
>=20
>=20
> > > > > Secondarily, the series adds more bells and whistles to the gener=
ic
> > > > > NFSD VFS APIs on behalf of NFSv4-specific requirements. In partic=
ular:
> > > > >=20
> > > > > - ("NFSD: change nfsd_create() to unlock directory before returni=
ng.")
> > > > > makes some big changes to nfsd_create(). But that helper itself
> > > > > is pretty small. Seems like cleaner code would result if NFSv4
> > > > > had its own version of nfsd_create() to deal with the post-change
> > > > > cases.
> > > >=20
> > > > I would not like that approach. Duplicating code is rarely a good i=
dea.
> > >=20
> > > De-duplicating code /can/ be a good idea, but isn't always a good
> > > idea. If the exceptional cases add a lot of logic, that can make the
> > > de-duplicated code difficult to read and reason about, and it can
> > > make it brittle, just as it does in this case. Modifications on
> > > behalf of NFSv4 in this common piece of code is possibly hazardous
> > > to NFSv3, and navigating around the exception logic makes it
> > > difficult to understand and review.
> >=20
> > Are we looking at the same code?
> > The sum total of extra code needed for v4 is:
> > - two extra parameters:
> > 	 void (*post_create)(struct svc_fh *fh, void *data),
> > 	 void *data)
> > - two lines of code:
> > 	if (!err && post_create)
> > 		post_create(resfhp, data);
> >=20
> > does that really make anything hard to follow?
>=20
> The synopsis of nfsd_create() is already pretty cluttered.
>=20
> You're adding that extra code in nfsd_symlink() too IIRC? And,
> this change adds a virtual function call (which has significant
> overhead these days) for reasons of convenience rather than
> necessity.
>=20
>=20
> > > IMO code duplication is not an appropriate design pattern in this
> > > specific instance.
> >=20
> > I'm guessing there is a missing negation in there.
>=20
> Yes, thanks.
>=20
>=20
> > > > Maybe, rather than passing a function and void* to nfsd_create(), w=
e
> > > > could pass an acl and a label and do the setting in vfs.c rather th=
en
> > > > nfs4proc.c. The difficult part of that approach is getting back the
> > > > individual error statuses. That should be solvable though.
> > >=20
> > > The bulk of the work in nfsd_create() is done by lookup_one_len()
> > > and nfsd_create_locked(), both of which are public APIs. The rest
> > > of nfsd_create() is code that appears in several other places
> > > already.
> >=20
> > "several" =3D=3D 1. The only other call site for nfsd_create_locked() i=
s in
> > nfsd_proc_create()
>=20
> But there are 15 call sites under fs/nfsd/ for lookup_one_len().
> It's a pretty common trope.
>=20
>=20
> > I would say that the "bulk" of the work is the interplay between
> > locking, error checking, and these two functions you mention.
>=20
> You're looking at the details of your particular change, and
> I'm concerned about how much technical debt is going to
> continue to accrue in an area shared with legacy protocol
> implementation.
>=20
> I'm still asking myself if I can live with the extra parameters
> and virtual function call. Maybe. IMO, there are three ways
> forward:
>=20
> 1. I can merge your patch and move on.
> 2. I can merge your patch as it is and follow up with clean-up.
> 3. I can drop your patch and write it the way I prefer.
>=20
>=20
> > > > > - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
> > > > > nfsd_lookup() is being changed such that its semantics are
> > > > > substantially different for NFSv4 than for others. This is
> > > > > possibly an indication that nfsd_lookup() should also be
> > > > > duplicated into the NFSv4-specific code and the generic VFS
> > > > > version should be left alone.
> > > >=20
> > > > Again, I don't like duplication. In this case, I think the longer t=
erm
> > > > solution is to remove the NFSv4 specific locking differences and so=
lve
> > > > the problem differently. i.e. don't hold the inode locked, but chec=
k
> > > > for any possible rename after getting a lease. Once that is done,
> > > > nfsd_lookup() can have saner semantics.
> > >=20
> > > Then, perhaps we should bite that bullet and do that work now.
> >=20
> > While this does have an appeal, it also looks like the start of a rabbi=
t
> > hole where I find have to fix up a growing collection of problems befor=
e
> > my patch can land.
>=20
> That's kind of the nature of the beast.
>=20
> You are requesting changes that add technical debt with the
> promise that "sometime in the future" that debt will be
> erased. Meanwhile, nfsd_lookup() will be made harder to
> maintain, and it will continue to contain a real bug.
>=20
> I'm saying if there's a real bug here, addressing that should
> be the priority.
>=20
>=20
> > I think balance is needed - certainly asking for some preliminary
> > cleanup is appropriate. Expecting long standing and subtle issues that
> > are tangential to the main goal to be resolved first is possibly asking
> > too much.
>=20
> Fixing the bug seems to me (perhaps naively) to be directly
> related to the parallelism of directory operations. Why do
> you think it is tangential?
>=20
> Asking for bugs to be addressed before new features go in
> seems sensible to me, and is a common practice to enable the
> resulting fixes to be backported. If you don't want to address
> the bug you mentioned, then someone else will need to, and
> that's fine. I think the priority should be bug fixes first.
>=20
> Just to be clear, I'm referring to this issue:
>=20
> > > NOTE: when nfsd4_open() creates a file, the directory does *NOT* rema=
in
> > > locked and never has. So it is possible (though unlikely) for the
> > > newly created file to be renamed before a delegation is handed out,
> > > and that would be bad. This patch does *NOT* fix that, but *DOES*
> > > take the directory lock immediately after creating the file, which
> > > reduces the size of the window and ensure that the lock is held
> > > consistently. More work is needed to guarantee no rename happens
> > > before the delegation.
> >=20
> > Interesting. Maybe after taking the lock, we could re-vet the dentry vs=
.
> > the info in the OPEN request? That way, we'd presumably know that the
> > above race didn't occur.
>=20
>=20

I usually like to see bugfixes first too, but I haven't heard of anyone
ever hitting this problem in the field. We've lived with this bug for a
long time, so I don't see a problem with cleaning up the locking first
and then fixing this on top of that.

That said, if we're concerned about it, we could just add an extra check
to nfs4_set_delegation. Basically, take parent mutex, set the
delegation, walk the inode->i_dentry list and vet that one of them
matches the OPEN args. That change probably wouldn't be too invasive and
should be backportable, but it means taking that mutex twice.

The alternate idea would be to try to set the delegation a lot earlier,
while we still hold the parent mutex for the open. That makes the
cleanup trickier, but is potentially more efficient. I think it'd be=20
simpler to implement this on top of Neil's patchset since it simplifies
the locking. Backporting that by itself is probably going to be painful
though.

What should we aim for here?
--
Jeff Layton <jlayton@kernel.org>
