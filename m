Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF045EAFC7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIZS0j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIZS0J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A265FDE3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 11:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C99961211
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 18:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE56C433C1;
        Mon, 26 Sep 2022 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664216682;
        bh=GCcla6tHPMt/bWTKDWQf3RTkIipB9bkd+gDeNzjqBMc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=okJWC4bnFxmBEjwMYvfrktRZx9kmG/i8eyodeezOQv2H6hMW9Ffv/BpKXGeIf7XrR
         h293HC5oCP+I9r4YtVXsReXCZeZQbmiwwUerqSbBAo+8In+JpIrZ4rWYhDG/bDdBIj
         o4CGAn8/+QygRjcGlUn3FZeXR7YwsNlZQYPogrh9padhlyjqZIPc+qF5P2JDM8rbyi
         aUEOFMrZfxLxoYyQjI4A2jZVF0xkyrnb+qv0CaJog+J6k3thNqH7RKu+M3vRRD9Yne
         AHhNqCECl8O2w0x2v2raMrVxR9dIOAxB1wpQWT0WaIQXS2q14+vz5BoIsOA5FiM/At
         4brfjMZV2q3Rw==
Message-ID: <a751b036a0a46a42abe8809c340b05c093e3d148.camel@kernel.org>
Subject: Re: [PATCH 3/4] nfsd: make nfsd4_run_cb a bool return function
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 26 Sep 2022 14:24:41 -0400
In-Reply-To: <F3B08B69-F05B-4F83-B407-343884ABC263@oracle.com>
References: <20220926163847.47558-1-jlayton@kernel.org>
         <20220926163847.47558-4-jlayton@kernel.org>
         <F3B08B69-F05B-4F83-B407-343884ABC263@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-09-26 at 17:51 +0000, Chuck Lever III wrote:
>=20
> > On Sep 26, 2022, at 12:38 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > ...and mirror the semantics of queue_work. Also, queueing a delegation
> > recall should always succeed when queueing, so WARN if one ever doesn't=
.
>=20
> The description is not especially clear. It seems like the point
> of this patch is really the part after the "Also, ..." Otherwise,
> I'm not getting why this change is really needed?
>=20
> Maybe a tracepoint would be less alarming to users/administrators
> than would a WARN with a full stack trace? The kdoc comment you
> added (thank you!) suggests there are times when it is OK for the
> nfsd4_queue_cb() to fail.
>=20
>=20

Yeah, that's pretty much the case with the "also". There may be some
other cases where we ought to catch this sort of thing too. We'd likely
never see a tracepoint for this. We'd just notice that there was a
refcount leak.

queue_work can return false without queueing anything if the work is
already queued. In this case, we will have taken an extra reference to
the stid that will never get put. I think this should never happen
because of the flc_lock, but it'd be good to catch it if it does.

That said, I don't feel that strongly about the patch, so if you think
it's not worthwhile, I'm fine with holding off on it.

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4callback.c | 14 ++++++++++++--
> > fs/nfsd/nfs4state.c    |  5 ++---
> > fs/nfsd/state.h        |  2 +-
> > 3 files changed, 15 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 4ce328209f61..ba904614ebf5 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -1371,11 +1371,21 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, s=
truct nfs4_client *clp,
> > 	cb->cb_holds_slot =3D false;
> > }
> >=20
> > -void nfsd4_run_cb(struct nfsd4_callback *cb)
> > +/**
> > + * nfsd4_run_cb - queue up a callback job to run
> > + * @cb: callback to queue
> > + *
> > + * Kick off a callback to do its thing. Returns false if it was alread=
y
> > + * queued or running, true otherwise.
> > + */
> > +bool nfsd4_run_cb(struct nfsd4_callback *cb)
> > {
> > +	bool queued;
> > 	struct nfs4_client *clp =3D cb->cb_clp;
>=20
> Reverse christmas tree, please.
>=20
>=20
> >=20
> > 	nfsd41_cb_inflight_begin(clp);
> > -	if (!nfsd4_queue_cb(cb))
> > +	queued =3D nfsd4_queue_cb(cb);
> > +	if (!queued)
> > 		nfsd41_cb_inflight_end(clp);
> > +	return queued;
> > }
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 211f1af1cfb3..90533f43fea9 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4861,14 +4861,13 @@ static void nfsd_break_one_deleg(struct nfs4_de=
legation *dp)
> > 	 * we know it's safe to take a reference.
> > 	 */
> > 	refcount_inc(&dp->dl_stid.sc_count);
> > -	nfsd4_run_cb(&dp->dl_recall);
> > +	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
> > }
> >=20
> > /* Called from break_lease() with flc_lock held. */
> > static bool
> > nfsd_break_deleg_cb(struct file_lock *fl)
> > {
> > -	bool ret =3D false;
> > 	struct nfs4_delegation *dp =3D (struct nfs4_delegation *)fl->fl_owner;
> > 	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> > 	struct nfs4_client *clp =3D dp->dl_stid.sc_client;
> > @@ -4894,7 +4893,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> > 	fp->fi_had_conflict =3D true;
> > 	nfsd_break_one_deleg(dp);
> > 	spin_unlock(&fp->fi_lock);
> > -	return ret;
> > +	return false;
> > }
> >=20
> > /**
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index b3477087a9fc..e2daef3cc003 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -692,7 +692,7 @@ extern void nfsd4_probe_callback_sync(struct nfs4_c=
lient *clp);
> > extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_=
cb_conn *);
> > extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client=
 *clp,
> > 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
> > -extern void nfsd4_run_cb(struct nfsd4_callback *cb);
> > +extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
> > extern int nfsd4_create_callback_queue(void);
> > extern void nfsd4_destroy_callback_queue(void);
> > extern void nfsd4_shutdown_callback(struct nfs4_client *);
> > --=20
> > 2.37.3
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
