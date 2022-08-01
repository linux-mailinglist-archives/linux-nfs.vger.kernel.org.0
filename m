Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5DA587160
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiHAT0u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHAT0t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 15:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0CB71
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 12:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A93C36121A
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 19:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9666CC433D6;
        Mon,  1 Aug 2022 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659382007;
        bh=wmndtXt7Imae89rEBSzE33oohZ0t/qi67qb3KGx6taE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TeQq4dWwYmKTz2g48eF5fmnaIZ2/fsKR4yn2X4fKcZM2y1bLHBWCxaKBaiofdoYkp
         en9gZYRxNBaYdSasTzaz6OwJX4SSTM7opPDuxUgs1dPGM9X/m6cJV2XhMju0nk+n7u
         QW5KX6cgH9f7WKvr1poyVQEbSm2om6dZ2LnviKxqdS7INLG8QmTNg4ufzWhM5IkeQW
         gatVVcvRiegi9t4Z8x14w1duDWmj78iLQXwlrUm6Z/S4JEpJyh0/OAW1rDck4xZO16
         KlJkJ9mvxTNhUrXeTk3qB47r1QyjJfxvH4mfXYmtkM3sTljGEOo/teOQK0NqNPK++r
         ERZxYdT1Z7AuQ==
Message-ID: <71591d59a463ec90e5687788a6e1f9ee9c72bf1c.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Aug 2022 15:26:45 -0400
In-Reply-To: <e8bd29c6-7d68-716f-1ed0-9f58436371c5@oracle.com>
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
         <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
         <c969d149-36be-a161-2b2a-469dbf7b9bcf@oracle.com>
         <eec78149840c74bd7b8f2ac18c9f27efb5bcd54d.camel@kernel.org>
         <e8bd29c6-7d68-716f-1ed0-9f58436371c5@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-08-01 at 12:22 -0700, dai.ngo@oracle.com wrote:
> On 8/1/22 12:10 PM, Jeff Layton wrote:
> > On Mon, 2022-08-01 at 11:52 -0700, dai.ngo@oracle.com wrote:
> > > On 8/1/22 4:47 AM, Jeff Layton wrote:
> > > > On Sun, 2022-07-31 at 13:19 -0700, Dai Ngo wrote:
> > > > > Use-after-free occurred when the laundromat tried to free expired
> > > > > cpntf_state entry on the s2s_cp_stateids list after inter-server
> > > > > copy completed. The sc_cp_list that the expired copy state was
> > > > > inserted on was already freed.
> > > > >=20
> > > > > When COPY completes, the Linux client normally sends LOCKU(lock_s=
tate x),
> > > > > FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source =
server.
> > > > > The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy=
 state
> > > > > from the s2s_cp_stateids list before freeing the lock state's sti=
d.
> > > > >=20
> > > > > However, sometimes the CLOSE was sent before the FREE_STATEID req=
uest.
> > > > > When this happens, the nfsd4_close_open_stateid call from nfsd4_c=
lose
> > > > > frees all lock states on its st_locks list without cleaning up th=
e copy
> > > > > state on the sc_cp_list list. When the time the FREE_STATEID arri=
ves the
> > > > > server returns BAD_STATEID since the lock state was freed. This c=
auses
> > > > > the use-after-free error to occur when the laundromat tries to fr=
ee
> > > > > the expired cpntf_state.
> > > > >=20
> > > > > This patch adds a call to nfs4_free_cpntf_statelist in
> > > > > nfsd4_close_open_stateid to clean up the copy state before callin=
g
> > > > > free_ol_stateid_reaplist to free the lock state's stid on the rea=
plist.
> > > > >=20
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > ---
> > > > >    fs/nfsd/nfs4state.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index 9409a0dc1b76..749f51dff5c7 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct=
 nfs4_ol_stateid *s)
> > > > >    	struct nfs4_client *clp =3D s->st_stid.sc_client;
> > > > >    	bool unhashed;
> > > > >    	LIST_HEAD(reaplist);
> > > > > +	struct nfs4_ol_stateid *stp;
> > > > >   =20
> > > > >    	spin_lock(&clp->cl_lock);
> > > > >    	unhashed =3D unhash_open_stateid(s, &reaplist);
> > > > > @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct=
 nfs4_ol_stateid *s)
> > > > >    		if (unhashed)
> > > > >    			put_ol_stateid_locked(s, &reaplist);
> > > > >    		spin_unlock(&clp->cl_lock);
> > > > > +		list_for_each_entry(stp, &reaplist, st_locks)
> > > > > +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
> > > > >    		free_ol_stateid_reaplist(&reaplist);
> > > > >    	} else {
> > > > >    		spin_unlock(&clp->cl_lock);
> > > > Nice catch.
> > > >=20
> > > > There are a number of places that call free_ol_stateid_reaplist. Is=
 it
> > > > really only in nfsd4_close_open_stateid that we need to do this? I
> > > > wonder if it would be better to do this inside free_ol_stateid_reap=
list
> > > > instead so that all of those callers clean up the copy states as we=
ll?
> > > Yes, we can do this in free_ol_stateid_reaplist too, I tested it.
> > >=20
> > > The linux client uses either delegation state or lock state to send w=
ith
> > > the COPY_NOTIFY to the source server. If the server grants the delega=
tion
> > > in the OPEN then the client uses the delegation state, otherwise it s=
ends
> > > the LOCK to the source and uses the lock state for the COPY_NOTIFY. T=
his
> > > problem happens only when the lock state is used *and* the client sen=
ds
> > > the CLOSE and FREE_STATEID out of order.
> > >=20
> > > free_ol_stateid_reaplist is called from release_open_stateid, release=
_openowner,
> > > nfsd4_close_open_stateid and nfsd4_release_lockowner. Among these fun=
ctions,
> > > only nfsd4_close_open_stateid deals with lock state that may have cpn=
tf_state
> > > associated with it and only for the minorversion > 1 case.
> > >=20
> > > nfsd4_release_lockowner will free the lock states but if the client h=
as
> > > not send LOCKU yet then put_ol_stateid_locked would fail to add the l=
ock
> > > state on the reaplist.
> > >=20
> > > I'm ok to move it to free_ol_stateid_reaplist if you still think we s=
hould
> > > and don't mind a little overhead on the unneeded cases.
> > >=20
> > If you think this is the only way this can happen, then the patch you
> > have is fine. In that case though, it might be good to have something
> > like this in free_ol_stateid_reaplist():
> >=20
> >      WARN_ON(!list_empty(&stp->sc_cp_list));
> >=20
> > ...to try and catch cases where these objects slip through the cracks
> > after future changes.
>=20
> Good suggestion, I'll add it to v2.
>=20

Actually, it might be better to put it in nfs4_free_ol_stateid. If we're
freeing an open or lock stateid and this list isn't empty, then
something is wrong.

--=20
Jeff Layton <jlayton@kernel.org>
