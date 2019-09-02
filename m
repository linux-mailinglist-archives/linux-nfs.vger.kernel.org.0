Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311AAA4D0F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfIBBLo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Sep 2019 21:11:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbfIBBLn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 1 Sep 2019 21:11:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E653EAD94;
        Mon,  2 Sep 2019 01:11:41 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "schumaker.anna\@gmail.com" <schumaker.anna@gmail.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Mon, 02 Sep 2019 11:11:33 +1000
Cc:     "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call nfs4_call_sync_custom()
In-Reply-To: <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com> <20190819192900.19312-5-Anna.Schumaker@Netapp.com> <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com>
Message-ID: <87sgpfec3e.fsf@notabene.neil.brown.name>
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

On Mon, Aug 19 2019, Trond Myklebust wrote:

> On Mon, 2019-08-19 at 15:28 -0400, schumaker.anna@gmail.com wrote:
>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>=20
>> An async call followed by an rpc_wait_for_completion() is basically
>> the
>> same as a synchronous call, so we can use nfs4_call_sync_custom() to
>> keep our custom callback ops and the RPC_TASK_NO_ROUND_ROBIN flag.
>>=20
>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> ---
>>  fs/nfs/nfs4proc.c | 13 ++-----------
>>  1 file changed, 2 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index de2b3fd806ef..1b7863ec12d3 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -8857,7 +8857,6 @@ static int nfs41_proc_reclaim_complete(struct
>> nfs_client *clp,
>>  		const struct cred *cred)
>>  {
>>  	struct nfs4_reclaim_complete_data *calldata;
>> -	struct rpc_task *task;
>>  	struct rpc_message msg =3D {
>>  		.rpc_proc =3D
>> &nfs4_procedures[NFSPROC4_CLNT_RECLAIM_COMPLETE],
>>  		.rpc_cred =3D cred,
>> @@ -8866,7 +8865,7 @@ static int nfs41_proc_reclaim_complete(struct
>> nfs_client *clp,
>>  		.rpc_client =3D clp->cl_rpcclient,
>>  		.rpc_message =3D &msg,
>>  		.callback_ops =3D &nfs4_reclaim_complete_call_ops,
>> -		.flags =3D RPC_TASK_ASYNC | RPC_TASK_NO_ROUND_ROBIN,
>> +		.flags =3D RPC_TASK_NO_ROUND_ROBIN,
>>  	};
>>  	int status =3D -ENOMEM;
>>=20=20
>> @@ -8881,15 +8880,7 @@ static int nfs41_proc_reclaim_complete(struct
>> nfs_client *clp,
>>  	msg.rpc_argp =3D &calldata->arg;
>>  	msg.rpc_resp =3D &calldata->res;
>>  	task_setup_data.callback_data =3D calldata;
>> -	task =3D rpc_run_task(&task_setup_data);
>> -	if (IS_ERR(task)) {
>> -		status =3D PTR_ERR(task);
>> -		goto out;
>> -	}
>> -	status =3D rpc_wait_for_completion_task(task);
>> -	if (status =3D=3D 0)
>> -		status =3D task->tk_status;
>> -	rpc_put_task(task);
>> +	status =3D nfs4_call_sync_custom(&task_setup_data);
>>  out:
>>  	dprintk("<-- %s status=3D%d\n", __func__, status);
>>  	return status;
>
> Hmm... I'm a little confused. Why does RECLAIM_COMPLETE need
> RPC_TASK_NO_ROUND_ROBIN? It should be ordered so it is called after
> BIND_CONN_TO_SESSION in nfs4_state_manager(), so in principle it is
> supposed to be able to recover from an error like
> NFS4ERR_CONN_NOT_BOUND_TO_SESSION. Are there other situations where we
> need RPC_TASK_NO_ROUND_ROBIN?

I thought it was conceptually simpler to keep *all* state management
commands on the one connection.  It probably isn't strictly necessary as
you say, but equally there is no need to distribute them over multiple
connections.
Having them all on the one connection might make analysing a packet
trace easier...

Thanks,
NeilBrown


>
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1sbEYACgkQOeye3VZi
gbkjKg/9FEUdDMJf5OS6BagMclgknKfPCStXNxgTwA9SKClvpX6SYwDeufxr15K3
uu6zvZRpF6bxclzDeQ0fp7QLcFJSLbJRuTMXyg+33u+V/BXxWZQHQrItmFJtttmL
85f+aMFEuzC+Tl1GADzMD9+97Tjf2buCSVT7X8uY4qqE4oDV5asKv2WV58ptoCGi
ANCpS/RiPmEOJC7y6WksXR74ehR74jbnhec2deKYsONEhx9RirJZ+SXivyye7JTg
4Wlw3cHVm/g93Qpo6fFJUb/uuMcKYJv66Gd2mORTT+Y0V8FiSzB7Y9Ash++9MueG
1+og2p+pgbWUGPEGRoafY3hUQlW1GpXn3nKl9pKQU/W+GI7ulnNgNevf2Wcu9ZHQ
lL7YWc8qg0wd00tYF3qnJwFvZjzCesA2fygrxKqjsQg3MxRz0YOUjrZ6wlxc9Pg2
lycNE2BQYKbCqTkT1IpV2brRpD8Z7uepP5H8E51s+rRRJnP/GYOJ+0S2bWqxidcy
ML1z0jYSvoiNCSF1mXMcPWaxJbRtcpyvdMf+jfHI5qv6EtJNG1NXtEg77bRuiB+P
yhN5JglLVDr1+JlDbhQ6P8wPJA57pkR3rNSCSslWKMmeQa6j1oG8981g8YZA/qZB
OfgG07IWy9ClalT8MAB5MtgmABTrQyNChwE8ilsNB4eVhYCeHpM=
=jJ8F
-----END PGP SIGNATURE-----
--=-=-=--
