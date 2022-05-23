Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964B9531C4C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiEWSt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiEWSrF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 14:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2A22504
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 11:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F33F61160
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B9DC385AA;
        Mon, 23 May 2022 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653330632;
        bh=QCbYZkDZDJH9+09OuTMElQ9wRv6BKgV0OKxgw+mf4cM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S8yL17dwKSskNaWyWDhV1D2xgbg2GvaK7Qm2a/0QFjE6h1gt85Idrj9aw1FKamlpj
         DCU/ETq6AqBtcdAU120jESW828vSZOQaRyzadusgZV8aX6ITOu9Nm4QKGdPraaI04I
         EKXFSeaDUruMjK0upys4xzop0avi9CoAMRr2VKG24TbQMJwoR0UuFwZJLuFJQIG0KG
         32VKY79D5HUd5zhe3QvSNDxmcq3Sj8Ng33wrYnyjpsyZ3sd+hqdr+uTECBCncvCu2V
         PjSFqFzUAeh06uRbsT3iJxbgwWLLFQ5JGBL+RGxsO0BiiLdMN8N20uNszRbWuSheeB
         uRqURd7fkJrEw==
Message-ID: <f12bf8be7c8fe6cf1a9e6a440277a3eb8edd543a.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Mon, 23 May 2022 14:30:30 -0400
In-Reply-To: <5dfbc622c9ab70af5e4a664f9ae03b7ed659e8ac.camel@hammerspace.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
         <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
         <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
         <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
         <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
         <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
         <93d11e12532f5a10153d3702100271f70373bce6.camel@hammerspace.com>
         <a719ae7e8fb8b46f84b00b27d800330712486f40.camel@kernel.org>
         <5dfbc622c9ab70af5e4a664f9ae03b7ed659e8ac.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-05-23 at 18:21 +0000, Trond Myklebust wrote:
> On Mon, 2022-05-23 at 14:04 -0400, Jeff Layton wrote:
> > On Mon, 2022-05-23 at 17:43 +0000, Trond Myklebust wrote:
> > > On Mon, 2022-05-23 at 12:37 -0400, Jeff Layton wrote:
> > > > On Mon, 2022-05-23 at 15:41 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On May 23, 2022, at 11:26 AM, Jeff Layton
> > > > > > <jlayton@kernel.org>
> > > > > > wrote:
> > > > > >=20
> > > > > > On Mon, 2022-05-23 at 15:00 +0000, Chuck Lever III wrote:
> > > > > > >=20
> > > > > > > > On May 23, 2022, at 9:40 AM, Jeff Layton
> > > > > > > > <jlayton@kernel.org>
> > > > > > > > wrote:
> > > > > > > >=20
> > > > > > > > On Sun, 2022-05-22 at 11:38 -0400, Chuck Lever wrote:
> > > > > > > > > nfsd4_release_lockowner() holds clp->cl_lock when it
> > > > > > > > > calls
> > > > > > > > > check_for_locks(). However, check_for_locks() calls
> > > > > > > > > nfsd_file_get()
> > > > > > > > > / nfsd_file_put() to access the backing inode's
> > > > > > > > > flc_posix
> > > > > > > > > list, and
> > > > > > > > > nfsd_file_put() can sleep if the inode was recently
> > > > > > > > > removed.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > It might be good to add a might_sleep() to nfsd_file_put?
> > > > > > >=20
> > > > > > > I intend to include the patch you reviewed last week that
> > > > > > > adds the might_sleep(), as part of this series.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > > Let's instead rely on the stateowner's reference count
> > > > > > > > > to
> > > > > > > > > gate
> > > > > > > > > whether the release is permitted. This should be a
> > > > > > > > > reliable
> > > > > > > > > indication of locks-in-use since file lock operations
> > > > > > > > > and
> > > > > > > > > ->lm_get_owner take appropriate references, which are
> > > > > > > > > released
> > > > > > > > > appropriately when file locks are removed.
> > > > > > > > >=20
> > > > > > > > > Reported-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > ---
> > > > > > > > > fs/nfsd/nfs4state.c |=A0=A0=A0 9 +++------
> > > > > > > > > 1 file changed, 3 insertions(+), 6 deletions(-)
> > > > > > > > >=20
> > > > > > > > > This might be a naive approach, but let's start with
> > > > > > > > > it.
> > > > > > > > >=20
> > > > > > > > > This passes light testing, but it's not clear how much
> > > > > > > > > our
> > > > > > > > > existing
> > > > > > > > > fleet of tests exercises this area. I've locally built
> > > > > > > > > a
> > > > > > > > > couple of
> > > > > > > > > pynfs tests (one is based on the one Dai posted last
> > > > > > > > > week)
> > > > > > > > > and they
> > > > > > > > > pass too.
> > > > > > > > >=20
> > > > > > > > > I don't believe that FREE_STATEID needs the same
> > > > > > > > > simplification.
> > > > > > > > >=20
> > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > > index a280256cbb03..b77894e668a4 100644
> > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > @@ -7559,12 +7559,9 @@ nfsd4_release_lockowner(struct
> > > > > > > > > svc_rqst *rqstp,
> > > > > > > > >=20
> > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* see if=
 there are still any locks
> > > > > > > > > associated with it */
> > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lo =3D lo=
ckowner(sop);
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0list_for_ea=
ch_entry(stp, &sop-
> > > > > > > > > > so_stateids,
> > > > > > > > > st_perstateowner) {
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0if (check_for_locks(stp-
> > > > > > > > > > st_stid.sc_file, lo)) {
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0status =3D
> > > > > > > > > nfserr_locks_held;
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spin_unlock(&clp-
> > > > > > > > > > cl_lock);
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return status;
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0}
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (atomic_=
read(&sop->so_count) > 1) {
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0spin_unlock(&clp->cl_lock);
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0return nfserr_locks_held;
> > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > > > > > >=20
> > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nfs4_get_=
stateowner(sop);
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > lm_get_owner is called from locks_copy_conflock, so if
> > > > > > > > someone else
> > > > > > > > happens to be doing a LOCKT or F_GETLK call at the same
> > > > > > > > time
> > > > > > > > that
> > > > > > > > RELEASE_LOCKOWNER gets called, then this may end up
> > > > > > > > returning
> > > > > > > > an error
> > > > > > > > inappropriately.
> > > > > > >=20
> > > > > > > IMO releasing the lockowner while it's being used for
> > > > > > > _anything_
> > > > > > > seems risky and surprising. If RELEASE_LOCKOWNER succeeds
> > > > > > > while
> > > > > > > the client is still using the lockowner for any reason, a
> > > > > > > subsequent error will occur if the client tries to use it
> > > > > > > again.
> > > > > > > Heck, I can see the server failing in mid-COMPOUND with
> > > > > > > this
> > > > > > > kind
> > > > > > > of race. Better I think to just leave the lockowner in
> > > > > > > place if
> > > > > > > there's any ambiguity.
> > > > > > >=20
> > > > > >=20
> > > > > > The problem here is not the client itself calling
> > > > > > RELEASE_LOCKOWNER
> > > > > > while it's still in use, but rather a different client
> > > > > > altogether
> > > > > > calling LOCKT (or a local process does a F_GETLK) on an inode
> > > > > > where a
> > > > > > lock is held by a client. The LOCKT gets a reference to it
> > > > > > (for
> > > > > > the
> > > > > > conflock), while the client that has the lockowner releases
> > > > > > the
> > > > > > lock and
> > > > > > then the lockowner while the refcount is still high.
> > > > > >=20
> > > > > > The race window for this is probably quite small, but I think
> > > > > > it's
> > > > > > theoretically possible. The point is that an elevated
> > > > > > refcount on
> > > > > > the
> > > > > > lockowner doesn't necessarily mean that locks are actually
> > > > > > being
> > > > > > held by
> > > > > > it.
> > > > >=20
> > > > > Sure, I get that the lockowner's reference count is not 100%
> > > > > reliable. The question is whether it's good enough.
> > > > >=20
> > > > > We are looking for a mechanism that can simply count the number
> > > > > of locks held by a lockowner. It sounds like you believe that
> > > > > lm_get_owner / put_owner might not be a reliable way to do
> > > > > that.
> > > > >=20
> > > > >=20
> > > > > > > The spec language does not say RELEASE_LOCKOWNER must not
> > > > > > > return
> > > > > > > LOCKS_HELD for other reasons, and it does say that there is
> > > > > > > no
> > > > > > > choice of using another NFSERR value (RFC 7530 Section
> > > > > > > 13.2).
> > > > > > >=20
> > > > > >=20
> > > > > > What recourse does the client have if this happens? It
> > > > > > released
> > > > > > all of
> > > > > > its locks and tried to release the lockowner, but the server
> > > > > > says
> > > > > > "locks
> > > > > > held". Should it just give up at that point?
> > > > > > RELEASE_LOCKOWNER is
> > > > > > a sort
> > > > > > of a courtesy by the client, I suppose...
> > > > >=20
> > > > > RELEASE_LOCKOWNER is a courtesy for the server. Most clients
> > > > > ignore the return code IIUC.
> > > > >=20
> > > > > So the hazard caused by this race would be a small resource
> > > > > leak on the server that would go away once the client's lease
> > > > > was purged.
> > > > >=20
> > > > >=20
> > > > > > > > My guess is that that would be pretty hard to hit the
> > > > > > > > timing right, but not impossible.
> > > > > > > >=20
> > > > > > > > What we may want to do is have the kernel do this check
> > > > > > > > and
> > > > > > > > only if it
> > > > > > > > comes back >1 do the actual check for locks. That won't
> > > > > > > > fix
> > > > > > > > the original
> > > > > > > > problem though.
> > > > > > > >=20
> > > > > > > > In other places in nfsd, we've plumbed in a dispose_list
> > > > > > > > head
> > > > > > > > and
> > > > > > > > deferred the sleeping functions until the spinlock can be
> > > > > > > > dropped. I
> > > > > > > > haven't looked closely at whether that's possible here,
> > > > > > > > but
> > > > > > > > it may be a
> > > > > > > > more reliable approach.
> > > > > > >=20
> > > > > > > That was proposed by Dai last week.
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-nfs/1653079929-18283-1-git-send=
-email-dai.ngo@oracle.com/T/#u
> > > > > > >=20
> > > > > > > Trond pointed out that if two separate clients were
> > > > > > > releasing a
> > > > > > > lockowner on the same inode, there is nothing that protects
> > > > > > > the
> > > > > > > dispose_list, and it would get corrupted.
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-nfs/31E87CEF-C83D-4FA8-A774-F2C=
389011FCE@oracle.com/T/#mf1fc1ae0503815c0a36ae75a95086c3eff892614
> > > > > > >=20
> > > > > >=20
> > > > > > Yeah, that doesn't look like what's needed.
> > > > > >=20
> > > > > > What I was going to suggest is a nfsd_file_put variant that
> > > > > > takes
> > > > > > a
> > > > > > list_head. If the refcount goes to zero and the thing ends up
> > > > > > being
> > > > > > unhashed, then you put it on the dispose list rather than
> > > > > > doing
> > > > > > the
> > > > > > blocking operations, and then clean it up later.
> > > > >=20
> > > > > Trond doesn't like that approach; see the e-mail thread.
> > > > >=20
> > > >=20
> > > > I didn't see him saying that that would be wrong, per-se, but the
> > > > initial implementation was racy.
> > > >=20
> > > > His suggestion was just to keep a counter in the lockowner of how
> > > > many
> > > > locks are associated with it. That seems like a good suggestion,
> > > > though
> > > > you'd probably need to add a parameter to lm_get_owner to
> > > > indicate
> > > > whether you were adding a new lock or just doing a conflock copy.
> > >=20
> > > I don't think this should be necessary. The posix_lock code doesn't
> > > ever use a struct file_lock that it hasn't allocated itself. We
> > > should
> > > always be calling conflock to copy from whatever struct file_lock
> > > that
> > > the caller passed as an argument.
> > >=20
> > > IOW: the number of lm_get_owner and lm_put_owner calls should
> > > always be
> > > 100% balanced once all the locks belonging to a specific lock owner
> > > are
> > > removed.
> > >=20
> >=20
> > We take references to the owner when we go to add a lock record, or
> > when
> > copying a conflicting lock. You want to keep a count of the former
> > without counting the latter.
> >=20
> > lm_get_owner gets called for both though. I don't see how you can
> > disambiguate the two situations w/o some way to indicate that. Adding
> > a
> > bool argument to lm_get_owner/lm_put_owner ops would be pretty simple
> > to
> > implement, I think.
> >=20
>=20
> Hmm... That should be an extremely unlikely race, given that the
> conflicting lock reference would have to be held for long enough to
> cover the unlock + the release_lockowner / free_stateid RPC calls from
> the client initially holding the lock, however I agree it is a
> theoretical possibility.
>=20

If we want to live with the possibility of that race, then Chuck's
original patch is fine, since the object refcount would always be
equivalent to the lock count.

That said, I think it'd be better to keep an accurate count of lock
records (sans conflocks) in the owner.
--=20
Jeff Layton <jlayton@kernel.org>
