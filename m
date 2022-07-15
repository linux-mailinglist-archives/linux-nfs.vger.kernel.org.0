Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C657599E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 04:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiGOCgL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 22:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCgK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 22:36:10 -0400
X-Greylist: delayed 165798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 19:36:09 PDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310C481E6
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 19:36:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 56C4C3421C;
        Fri, 15 Jul 2022 02:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657852566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTeq370Buck2vcNfS5ahEhtYIuPbL+NIU2CBIjfQihM=;
        b=hvIy5gr29afHRddoK9eWGiSeWDRCQwl2V+2OC8XYUyYfJuntV3WfKtBEJuLLf8Xz/AElUj
        6W9vIVGY4Y/E2NZYd3Jb4Os9bzK4iH8LKTj3d+SOddzwQtYqXrAYDw3rynuKyt82BbjkeM
        9HkcbRYoDkQ12AArgr1qhTdpshzqGNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657852566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTeq370Buck2vcNfS5ahEhtYIuPbL+NIU2CBIjfQihM=;
        b=/xc/Y2unUeQ7HxZeNGMzBfR2J+BRe0V7TL+mz/qIm/bJ5rWYSwq9PL6iyp3EEuplG2Shnw
        RdoAZXb7kPLUCxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BF1613A79;
        Fri, 15 Jul 2022 02:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +hknL5TS0GICLAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 15 Jul 2022 02:36:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
In-reply-to: <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>,
 <165759318889.25184.8939985512802350340@noble.neil.brown.name>,
 <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>,
 <165768676476.25184.1334928545636067316@noble.neil.brown.name>,
 <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
Date:   Fri, 15 Jul 2022 12:36:01 +1000
Message-id: <165785256143.25184.15897431161933266918@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 14 Jul 2022, Chuck Lever III wrote:
>=20
> > On Jul 13, 2022, at 12:32 AM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Wed, 13 Jul 2022, Chuck Lever III wrote:
> >>=20
> >>> On Jul 11, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
> >>>=20
> >>> On Thu, 07 Jul 2022, Chuck Lever III wrote:
> >>>>=20
> >>>>> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
> >>>>>=20
> >>>>> This series prepares NFSD to be able to adjust to work with a proposed
> >>>>> patch which allows updates to directories to happen in parallel.
> >>>>> This patch set changes the way directories are locked, so the present
> >>>>> series cleans up some locking in nfsd.
> >>>>>=20
> >>>>> Specifically we remove fh_lock() and fh_unlock().
> >>>>> These functions are problematic for a few reasons.
> >>>>> - they are deliberately idempotent - setting or clearing a flag
> >>>>> so that a second call does nothing. This makes locking errors harder,
> >>>>> but it results in code that looks wrong ... and maybe sometimes is a
> >>>>> little bit wrong.
> >>>>> Early patches clean up several places where this idempotent nature of
> >>>>> the functions is depended on, and so makes the code clearer.
> >>>>>=20
> >>>>> - they transparently call fh_fill_pre/post_attrs(), including at times
> >>>>> when this is not necessary. Having the calls only when necessary is
> >>>>> marginally more efficient, and arguably makes the code clearer.
> >>>>>=20
> >>>>> nfsd_lookup() currently always locks the directory, though often no l=
ock
> >>>>> is needed. So a patch in this series reduces this locking.
> >>>>>=20
> >>>>> There is an awkward case that could still be further improved.
> >>>>> NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
> >>>>> between the moment when the open succeeds, and a later moment when a
> >>>>> "lease" is attached to support a delegation. The handling of this lock
> >>>>> is currently untidy, particularly when creating a file.
> >>>>> It would probably be better to take a lease immediately after
> >>>>> opening the file, and then discarding if after deciding not to provid=
e a
> >>>>> delegation.
> >>>>>=20
> >>>>> I have run fstests and cthon tests on this, but I wouldn't be surpris=
ed
> >>>>> if there is a corner case that I've missed.
> >>>>=20
> >>>> Hi Neil, thanks for (re)posting.
> >>>>=20
> >>>> Let me make a few general comments here before I send out specific
> >>>> review nits.
> >>>>=20
> >>>> I'm concerned mostly with how this series can be adequately tested.
> >>>> The two particular areas I'm worried about:
> >>>>=20
> >>>> - There are some changes to NFSv2 code, which is effectively
> >>>> fallow. I think I can run v2 tests, once we decide what tests
> >>>> should be run.
> >>>=20
> >>> I hope we can still test v2... I know it is disabled by default..
> >>> If we can't test it, we should consider removing it.
> >>=20
> >> The work of deprecating and removing NFSv2 is already under way.
> >> I think what I'm asking is if /you/ have tested the NFSv2 changes.
> >=20
> > That's a question I can answer. I haven't. I will.
>=20
> Just in case it's not clear by now, NFSv2 (and NFSv3)
> stability is the reason I don't want to perturb the
> NFSD VFS API code in any significant way unless it's
> absolutely needed.

"absolutely" seems like a rather high bar.  It makes the goal of
"stability" seem more like "ossification".
Certainly we don't want to break things.  Equally certainly we will.
I don't think "hold back useful changes out of fear" is the path to
success.  Testing, review, and responding to bug reports is what we find
works best - and what we generally do.

And I wouldn't class NFSv3 at all with NFSv2 (not even in parentheses).
NFSv2 has very few (if any) users in the broad community, so bugs are
likely to go unnoticed for extended periods.  NFSv3 is, I believe, still
widely used, though not as widely as v4.  There are use-cases where I
would recommend v3.

e.g.  a case could certainly be made to not extend my directory-locking
changes to v2-specific code, but v3 should get them.

>=20
>=20
> >>>> Secondarily, the series adds more bells and whistles to the generic
> >>>> NFSD VFS APIs on behalf of NFSv4-specific requirements. In particular:
> >>>>=20
> >>>> - ("NFSD: change nfsd_create() to unlock directory before returning.")
> >>>> makes some big changes to nfsd_create(). But that helper itself
> >>>> is pretty small. Seems like cleaner code would result if NFSv4
> >>>> had its own version of nfsd_create() to deal with the post-change
> >>>> cases.
> >>>=20
> >>> I would not like that approach. Duplicating code is rarely a good idea.
> >>=20
> >> De-duplicating code /can/ be a good idea, but isn't always a good
> >> idea. If the exceptional cases add a lot of logic, that can make the
> >> de-duplicated code difficult to read and reason about, and it can
> >> make it brittle, just as it does in this case. Modifications on
> >> behalf of NFSv4 in this common piece of code is possibly hazardous
> >> to NFSv3, and navigating around the exception logic makes it
> >> difficult to understand and review.
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

Would it help to collect related details (name, type, attributes, acl,
label) into a struct and pass a reference to that around?
One awkwardness in my latest patch is that the acl and label are not set
in nfsd_create_setattr().  If they were passed around together with the
attributes, that would be a lot easier to achieve.

>=20
> You're adding that extra code in nfsd_symlink() too IIRC? And,
> this change adds a virtual function call (which has significant
> overhead these days) for reasons of convenience rather than
> necessity.

"significant"?  In context of creation a file, I don't think one more
virtual function call is all that significant?

I started writing code to avoid the function pointer, but the function
args list exploded.  If you could be happy with e.g.  a struct
nfs_create_args which contains attrs, acl, label, and was passed into
nfsd_create_setattr(), then I think that would cleanly avoid the desire
for a function pointer.

>=20
>=20
> >> IMO code duplication is not an appropriate design pattern in this
> >> specific instance.
> >=20
> > I'm guessing there is a missing negation in there.
>=20
> Yes, thanks.
>=20
>=20
> >>> Maybe, rather than passing a function and void* to nfsd_create(), we
> >>> could pass an acl and a label and do the setting in vfs.c rather then
> >>> nfs4proc.c. The difficult part of that approach is getting back the
> >>> individual error statuses. That should be solvable though.
> >>=20
> >> The bulk of the work in nfsd_create() is done by lookup_one_len()
> >> and nfsd_create_locked(), both of which are public APIs. The rest
> >> of nfsd_create() is code that appears in several other places
> >> already.
> >=20
> > "several" =3D=3D 1. The only other call site for nfsd_create_locked() is =
in
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
> >>>> - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
> >>>> nfsd_lookup() is being changed such that its semantics are
> >>>> substantially different for NFSv4 than for others. This is
> >>>> possibly an indication that nfsd_lookup() should also be
> >>>> duplicated into the NFSv4-specific code and the generic VFS
> >>>> version should be left alone.
> >>>=20
> >>> Again, I don't like duplication. In this case, I think the longer term
> >>> solution is to remove the NFSv4 specific locking differences and solve
> >>> the problem differently. i.e. don't hold the inode locked, but check
> >>> for any possible rename after getting a lease. Once that is done,
> >>> nfsd_lookup() can have saner semantics.
> >>=20
> >> Then, perhaps we should bite that bullet and do that work now.
> >=20
> > While this does have an appeal, it also looks like the start of a rabbit
> > hole where I find have to fix up a growing collection of problems before
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

The bug was exposed by the analysis required for the changes I want, but
I think that is as close as the connection goes.
To really see if it is tangential, we would need to come up with a
solution and see how easily it is ported across my patches.

As I said in a reply to Jeff, I don't think locking of the parent
directory should be part of the solution.  After getting a lease, we
repeat the lookup and see if dentry has changed.  After my patches, that
would mean calling lookup_one_len_unlocked().  Before my patches, it
would mean calling fh_unlock() earlier to ensure the directory is no
longer locked but still calling lookup_one_len_unlocked()


> Asking for bugs to be addressed before new features go in
> seems sensible to me, and is a common practice to enable the
> resulting fixes to be backported. If you don't want to address
> the bug you mentioned, then someone else will need to, and
> that's fine. I think the priority should be bug fixes first.

As a general principle I would agree.
In this case the bug is minor, long standing, and tangential.
And the series imposes enough review burden as it is.

But if Jeff can produce a fix, either to be applied before or after,
then that would be an excellent solution.

Thanks,
NeilBrown

>=20
> Just to be clear, I'm referring to this issue:
>=20
> >> NOTE: when nfsd4_open() creates a file, the directory does *NOT* remain
> >> locked and never has. So it is possible (though unlikely) for the
> >> newly created file to be renamed before a delegation is handed out,
> >> and that would be bad. This patch does *NOT* fix that, but *DOES*
> >> take the directory lock immediately after creating the file, which
> >> reduces the size of the window and ensure that the lock is held
> >> consistently. More work is needed to guarantee no rename happens
> >> before the delegation.
> >=20
> > Interesting. Maybe after taking the lock, we could re-vet the dentry vs.
> > the info in the OPEN request? That way, we'd presumably know that the
> > above race didn't occur.
>=20
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
