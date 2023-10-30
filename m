Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47507DC204
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 22:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjJ3Vn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 17:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3VnZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 17:43:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1D2ED;
        Mon, 30 Oct 2023 14:43:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB864C433C7;
        Mon, 30 Oct 2023 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698702202;
        bh=/svlhgW2EBgQT4jY1UxMOTeXcZ2x9WOxUbhSqvff7ZI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KT5BM+DI1M8lQqbC/0EmiWFnfCYSI7Z/ld0vCmYTJ5jk1b4MkWnSk+Gc68C+LnzKF
         JlJ98cCuRZ9flWAbDhnlVc2h5JpGpwXb74bCmN0kfbi6XGA3RRlQbX57n+wCIbqcvf
         nj3KL5DxO2ZDBHMoIemnRrYZDNuqtyKa1lUB3E8UEu2IpL1ADLjFGho0Dk+sEjECH7
         GtsACTmRHZrD3s8q1cg64Adoig+JoDC1Y3oPSB1MG0Oz+Bm9itbfpRb9J1DcDkQAp3
         WUF2zf/wfs35VSd8YQDmUSnUUNvPzN5/FXeQW415oCt3UCV7GGbBTA+G0AtXVOAyPh
         bL9h9QI0KGe7w==
Message-ID: <cc7bce0a257fa433fd059e341d12460116df5e82.camel@kernel.org>
Subject: Re: [PATCH RFC] nfsd: fix error handling in nfsd_svc
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>
Date:   Mon, 30 Oct 2023 17:43:20 -0400
In-Reply-To: <169870163037.24305.14020614041859684912@noble.neil.brown.name>
References: <20231030-kdevops-v1-1-bae6baf62c69@kernel.org>
         <169870163037.24305.14020614041859684912@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-10-31 at 08:33 +1100, NeilBrown wrote:
> On Tue, 31 Oct 2023, Jeff Layton wrote:
> > Once we've set the nfsd_serv pointer in nfsd_svc, we still need to call
> > nfsd_last_thread if the server fails to be started. Remove the special
> > casing for nfsd_up_before case since shutting down the per-net stuff is
> > also handled by nfsd_last_thread.
> >=20
> > Finally, add a new special case at the start and skip doing anything if
> > the service already exists, 0 threads were requested and
> > serv->sv_nrthreads is 0.
>=20
> This is very similar to my=20
>   Commit bf32075256e9 ("NFSD: simplify error paths in nfsd_svc()")
>=20
> The main difference being that special case you mention.  I don't like
> that bit.
> If I run "rpc.nfsd 0" then I want the nfsd_svc to be destroyed, whether
> there were threads running or not.
>=20
> Is there a reason my patch isn't sufficient?
>=20

Ok, I wasn't sure whether that was the desired behavior or not. Your
patch should be fine actually, and it has already had some testing, so
let's just mark that for stable?


> Thanks,
> NeilBrown
>=20
>=20
> >=20
> > Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()=
")
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Here's what I was thinking for a targeted patch for stable. Testing it
> > now, but I won't have results until tomorrow.
> > ---
> >  fs/nfsd/nfssvc.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 3deef000afa9..187b68769815 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -787,7 +787,6 @@ int
> >  nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
> >  {
> >  	int	error;
> > -	bool	nfsd_up_before;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv;
> > =20
> > @@ -797,8 +796,9 @@ nfsd_svc(int nrservs, struct net *net, const struct=
 cred *cred)
> >  	nrservs =3D max(nrservs, 0);
> >  	nrservs =3D min(nrservs, NFSD_MAXSERVS);
> >  	error =3D 0;
> > +	serv =3D nn->nfsd_serv;
> > =20
> > -	if (nrservs =3D=3D 0 && nn->nfsd_serv =3D=3D NULL)
> > +	if (nrservs =3D=3D 0 && (serv =3D=3D NULL || serv->sv_nrthreads =3D=
=3D 0))
> >  		goto out;
> > =20
> >  	strscpy(nn->nfsd_name, utsname()->nodename,
> > @@ -808,22 +808,17 @@ nfsd_svc(int nrservs, struct net *net, const stru=
ct cred *cred)
> >  	if (error)
> >  		goto out;
> > =20
> > -	nfsd_up_before =3D nn->nfsd_net_up;
> >  	serv =3D nn->nfsd_serv;
> > =20
> >  	error =3D nfsd_startup_net(net, cred);
> >  	if (error)
> >  		goto out_put;
> >  	error =3D svc_set_num_threads(serv, NULL, nrservs);
> > -	if (error)
> > -		goto out_shutdown;
> > -	error =3D serv->sv_nrthreads;
> >  	if (error =3D=3D 0)
> > -		nfsd_last_thread(net);
> > -out_shutdown:
> > -	if (error < 0 && !nfsd_up_before)
> > -		nfsd_shutdown_net(net);
> > +		error =3D serv->sv_nrthreads;
> >  out_put:
> > +	if (serv->sv_nrthreads =3D=3D 0)
> > +		nfsd_last_thread(net);
> >  	/* Threads now hold service active */
> >  	if (xchg(&nn->keep_active, 0))
> >  		svc_put(serv);
> >=20
> > ---
> > base-commit: 31b5a36c4b88b44c91cdd523997b1e86fb47339d
> > change-id: 20231030-kdevops-5f7366897ef4
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
