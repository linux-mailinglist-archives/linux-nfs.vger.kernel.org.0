Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF0587138
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiHATNi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiHATM5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 15:12:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98202BE16
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 12:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C279B81643
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 19:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFB2C433C1;
        Mon,  1 Aug 2022 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659381027;
        bh=zgdZZYGz6cZViCcQdxTRIl60ywY6hFT+8DFJ+cU81AU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oB5Dz+atsa48Y/9HmWpCysqCRXiapke65tc00w1fQwPRMzmjFiOwI88G/qAzt9YeN
         2/lEBjbYgo3WV5Pe+iO677wM5mG1exiZF7Iymbq49o9cR0vCDxArB7hubMcpmtSyVy
         yGtqOKlmvP5+stxVZ8MSd+kG9HgizKcB72lUqneXsktXANBz67nzfq+qIQPUH/gQ0S
         t+jM10CdDCsyPwWAHfORQMLLisal21vzIoN8fZcmNbJTrAvXfjCECzckDoY38GRTxk
         CBQOthGLqOGsw+yvWjk5Hhlmm5frldQSXr1TmIs8kuGS75ofy3Dy9uZgQlNkUUB3vc
         9sV6r42SDrKWQ==
Message-ID: <eec78149840c74bd7b8f2ac18c9f27efb5bcd54d.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Aug 2022 15:10:24 -0400
In-Reply-To: <c969d149-36be-a161-2b2a-469dbf7b9bcf@oracle.com>
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
         <ea6d0556198dd6b77f1ab711401ca65bc39e9912.camel@kernel.org>
         <c969d149-36be-a161-2b2a-469dbf7b9bcf@oracle.com>
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

On Mon, 2022-08-01 at 11:52 -0700, dai.ngo@oracle.com wrote:
> On 8/1/22 4:47 AM, Jeff Layton wrote:
> > On Sun, 2022-07-31 at 13:19 -0700, Dai Ngo wrote:
> > > Use-after-free occurred when the laundromat tried to free expired
> > > cpntf_state entry on the s2s_cp_stateids list after inter-server
> > > copy completed. The sc_cp_list that the expired copy state was
> > > inserted on was already freed.
> > >=20
> > > When COPY completes, the Linux client normally sends LOCKU(lock_state=
 x),
> > > FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source serv=
er.
> > > The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy sta=
te
> > > from the s2s_cp_stateids list before freeing the lock state's stid.
> > >=20
> > > However, sometimes the CLOSE was sent before the FREE_STATEID request=
.
> > > When this happens, the nfsd4_close_open_stateid call from nfsd4_close
> > > frees all lock states on its st_locks list without cleaning up the co=
py
> > > state on the sc_cp_list list. When the time the FREE_STATEID arrives =
the
> > > server returns BAD_STATEID since the lock state was freed. This cause=
s
> > > the use-after-free error to occur when the laundromat tries to free
> > > the expired cpntf_state.
> > >=20
> > > This patch adds a call to nfs4_free_cpntf_statelist in
> > > nfsd4_close_open_stateid to clean up the copy state before calling
> > > free_ol_stateid_reaplist to free the lock state's stid on the reaplis=
t.
> > >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 9409a0dc1b76..749f51dff5c7 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs=
4_ol_stateid *s)
> > >   	struct nfs4_client *clp =3D s->st_stid.sc_client;
> > >   	bool unhashed;
> > >   	LIST_HEAD(reaplist);
> > > +	struct nfs4_ol_stateid *stp;
> > >  =20
> > >   	spin_lock(&clp->cl_lock);
> > >   	unhashed =3D unhash_open_stateid(s, &reaplist);
> > > @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs=
4_ol_stateid *s)
> > >   		if (unhashed)
> > >   			put_ol_stateid_locked(s, &reaplist);
> > >   		spin_unlock(&clp->cl_lock);
> > > +		list_for_each_entry(stp, &reaplist, st_locks)
> > > +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
> > >   		free_ol_stateid_reaplist(&reaplist);
> > >   	} else {
> > >   		spin_unlock(&clp->cl_lock);
> > Nice catch.
> >=20
> > There are a number of places that call free_ol_stateid_reaplist. Is it
> > really only in nfsd4_close_open_stateid that we need to do this? I
> > wonder if it would be better to do this inside free_ol_stateid_reaplist
> > instead so that all of those callers clean up the copy states as well?
>=20
> Yes, we can do this in free_ol_stateid_reaplist too, I tested it.
>=20
> The linux client uses either delegation state or lock state to send with
> the COPY_NOTIFY to the source server. If the server grants the delegation
> in the OPEN then the client uses the delegation state, otherwise it sends
> the LOCK to the source and uses the lock state for the COPY_NOTIFY. This
> problem happens only when the lock state is used *and* the client sends
> the CLOSE and FREE_STATEID out of order.
>=20
> free_ol_stateid_reaplist is called from release_open_stateid, release_ope=
nowner,
> nfsd4_close_open_stateid and nfsd4_release_lockowner. Among these functio=
ns,
> only nfsd4_close_open_stateid deals with lock state that may have cpntf_s=
tate
> associated with it and only for the minorversion > 1 case.
>=20
> nfsd4_release_lockowner will free the lock states but if the client has
> not send LOCKU yet then put_ol_stateid_locked would fail to add the lock
> state on the reaplist.
>=20
> I'm ok to move it to free_ol_stateid_reaplist if you still think we shoul=
d
> and don't mind a little overhead on the unneeded cases.
>=20

If you think this is the only way this can happen, then the patch you
have is fine. In that case though, it might be good to have something
like this in free_ol_stateid_reaplist():

    WARN_ON(!list_empty(&stp->sc_cp_list));

...to try and catch cases where these objects slip through the cracks
after future changes.
--=20
Jeff Layton <jlayton@kernel.org>
