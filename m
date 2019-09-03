Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417EFA5F28
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2019 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfICCHq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 22:07:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:32908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfICCHq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Sep 2019 22:07:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C00CACC4;
        Tue,  3 Sep 2019 02:07:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna\@gmail.com" <schumaker.anna@gmail.com>
Date:   Tue, 03 Sep 2019 12:07:37 +1000
Cc:     "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call nfs4_call_sync_custom()
In-Reply-To: <68876eaa4fc3f387ea7e3329af9f3b520ef96c5c.camel@hammerspace.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com> <20190819192900.19312-5-Anna.Schumaker@Netapp.com> <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com> <87sgpfec3e.fsf@notabene.neil.brown.name> <68876eaa4fc3f387ea7e3329af9f3b520ef96c5c.camel@hammerspace.com>
Message-ID: <878sr6dtee.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02 2019, Trond Myklebust wrote:

> On Mon, 2019-09-02 at 11:11 +1000, NeilBrown wrote:
>> On Mon, Aug 19 2019, Trond Myklebust wrote:
>>=20
>> > On Mon, 2019-08-19 at 15:28 -0400, schumaker.anna@gmail.com wrote:
>> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> > >=20
>> > > An async call followed by an rpc_wait_for_completion() is
>> > > basically
>> > > the
>> > > same as a synchronous call, so we can use nfs4_call_sync_custom()
>> > > to
>> > > keep our custom callback ops and the RPC_TASK_NO_ROUND_ROBIN
>> > > flag.
>> > >=20
>> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> > > ---
>> > >  fs/nfs/nfs4proc.c | 13 ++-----------
>> > >  1 file changed, 2 insertions(+), 11 deletions(-)
>> > >=20
>> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> > > index de2b3fd806ef..1b7863ec12d3 100644
>> > > --- a/fs/nfs/nfs4proc.c
>> > > +++ b/fs/nfs/nfs4proc.c
>> > > @@ -8857,7 +8857,6 @@ static int
>> > > nfs41_proc_reclaim_complete(struct
>> > > nfs_client *clp,
>> > >  		const struct cred *cred)
>> > >  {
>> > >  	struct nfs4_reclaim_complete_data *calldata;
>> > > -	struct rpc_task *task;
>> > >  	struct rpc_message msg =3D {
>> > >  		.rpc_proc =3D
>> > > &nfs4_procedures[NFSPROC4_CLNT_RECLAIM_COMPLETE],
>> > >  		.rpc_cred =3D cred,
>> > > @@ -8866,7 +8865,7 @@ static int
>> > > nfs41_proc_reclaim_complete(struct
>> > > nfs_client *clp,
>> > >  		.rpc_client =3D clp->cl_rpcclient,
>> > >  		.rpc_message =3D &msg,
>> > >  		.callback_ops =3D &nfs4_reclaim_complete_call_ops,
>> > > -		.flags =3D RPC_TASK_ASYNC | RPC_TASK_NO_ROUND_ROBIN,
>> > > +		.flags =3D RPC_TASK_NO_ROUND_ROBIN,
>> > >  	};
>> > >  	int status =3D -ENOMEM;
>> > >=20=20
>> > > @@ -8881,15 +8880,7 @@ static int
>> > > nfs41_proc_reclaim_complete(struct
>> > > nfs_client *clp,
>> > >  	msg.rpc_argp =3D &calldata->arg;
>> > >  	msg.rpc_resp =3D &calldata->res;
>> > >  	task_setup_data.callback_data =3D calldata;
>> > > -	task =3D rpc_run_task(&task_setup_data);
>> > > -	if (IS_ERR(task)) {
>> > > -		status =3D PTR_ERR(task);
>> > > -		goto out;
>> > > -	}
>> > > -	status =3D rpc_wait_for_completion_task(task);
>> > > -	if (status =3D=3D 0)
>> > > -		status =3D task->tk_status;
>> > > -	rpc_put_task(task);
>> > > +	status =3D nfs4_call_sync_custom(&task_setup_data);
>> > >  out:
>> > >  	dprintk("<-- %s status=3D%d\n", __func__, status);
>> > >  	return status;
>> >=20
>> > Hmm... I'm a little confused. Why does RECLAIM_COMPLETE need
>> > RPC_TASK_NO_ROUND_ROBIN? It should be ordered so it is called after
>> > BIND_CONN_TO_SESSION in nfs4_state_manager(), so in principle it is
>> > supposed to be able to recover from an error like
>> > NFS4ERR_CONN_NOT_BOUND_TO_SESSION. Are there other situations where
>> > we
>> > need RPC_TASK_NO_ROUND_ROBIN?
>>=20
>> I thought it was conceptually simpler to keep *all* state management
>> commands on the one connection.  It probably isn't strictly necessary
>> as
>> you say, but equally there is no need to distribute them over
>> multiple
>> connections.
>> Having them all on the one connection might make analysing a packet
>> trace easier...
>>=20
>
> We do want BIND_CONN_TO_SESSION to be a part of the recovery process
> where and when it is needed. If not, we end up having to catch a load
> of NFS4ERR_CONN_NOT_BOUND_TO_SESSION errors once the recovery thread is
> done, and having to then kick off a second recovery just to handle
> those errors.
>
> IOW: Deliberately suppressing those errors by trying to route all the
> recovery through a single connection is actually not helpful.
> Right now, we will catch those errors in the case where there is state
> recovery to be performed (since those calls are allowed to be routed
> through all connections) but it might be nice to also use
> RECLAIM_COMPLETE as a canary for connection binding.
>

Sounds reasonable.  Thanks for the explanation.  I certainly have no
objection.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1tyukACgkQOeye3VZi
gbmmCxAAhw1mBtmkb35BVXIvvy1WoB9FOdqJAM66+Tl5CV639xPOVGw0pyzdMb1c
9WeyHYin5clyDfgOhIiP8wimr7rXIkAib4XM1n7GjudB8rvFVQGz3MpofVPZOF+j
Bje9FA/ClsYASmVTh+wXGntoIE70mz3RwOf36tjO5l+Z8Nj4ABbBCrqu7b7nk3yz
HIMZHkaXNJyr1BdMMEMnpW8O/GbCXR0Rh9Q39WiE4nt2R5L0K9BJnwgVgaWy6P9k
27TqIYvCvqaarY+fC1Ry1iuG0zbpAsGsv9TvpyrkiICU1ChsbRANEjqZSTtTE4YI
YcTo2R1sFYb6L3mNsfMzlOyVVTTbbCU41dGEaI2OVOjy3G8E0y0DvzIbR3Ifumzx
y/YhZVkYaLxpaeNUwWPbljBijjlpQZSiKm5ddrN3kH0GekFJj0KYIW75Cjh/DZpu
erusMPPQ+kqFGtfPHjXEV7TEPMVjHbQ2JwHmqoGpo1xKCV36aKpZiqVIv9apZcLm
8QzUD5aDWqfC3XNgddj8gPUkiqG9NbF1bcJovI6O1GIaVPIdbnzqK93OX4TnHN3h
J1CrtGdCL5sai1uFCVUerzzOKtORJHZlF7lcsD76t93Zr2Jqcmwf8PFfk7yzybFM
sLAf2h9R5e3B2oWyBlxLl6HKLGEKYq9HUrefQ6AD/2hCAKHjnBE=
=Rrxt
-----END PGP SIGNATURE-----
--=-=-=--
