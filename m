Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02A314A6E4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgA0PFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:05:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58450 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0PFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:05:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RErShu144320;
        Mon, 27 Jan 2020 15:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=t4uZVQZJI21CFJZOqDbOmyx1Qi/oQ3GtQKJeg3cL1AY=;
 b=YhnxBjTGWBTxTHgMzPCMyx/U3iYAdlSvMzthViP/AM+JyVWP5oLEZnOYVHhrobjbOarF
 pM4bE9mvayegsGQEgWpPOIU4ZnxR+kv//Tar7ge9vyb1DT1/8zEy8WTG3Qd4Ud12Euhm
 vcNKBeoCUrC65VSqnC7VrjiweDceZtL+UVsENvZQc+NfonZp90N+1Yb7QUuiKjZht8WE
 KvuDSwmh+XVWs/5c+9T8/e6oJwiRFJzAd1szsJkV1gvnoCok8+HQcAYJNzgLxfyXnkbQ
 VDmyK29OdTy8AMCUIDQy1o25v2Y/u6h7sDXz9aL/XnB2ceLP80Fa4k0BkUivp9b/IbUg aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmq7w0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 15:05:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RErFUS035965;
        Mon, 27 Jan 2020 15:05:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xry6tf1hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 15:05:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00RF5ZYU030704;
        Mon, 27 Jan 2020 15:05:35 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 07:05:35 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
 renewals
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALbTx=GxuUmWu9Og_pv8TPbB0ZnOCA3vMqtyG4e18-4+zkY8=A@mail.gmail.com>
Date:   Mon, 27 Jan 2020 10:05:33 -0500
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B5432AC-73BA-465E-98FC-82BFD0E817FD@oracle.com>
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com>
 <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
 <084f01d5cfba$bc5c4d10$3514e730$@gmail.com>
 <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
 <a62e45ba968fe845fa757174efc0cab93c490d54.camel@hammerspace.com>
 <CALbTx=GxuUmWu9Og_pv8TPbB0ZnOCA3vMqtyG4e18-4+zkY8=A@mail.gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270127
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2020, at 9:45 AM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
> On Thu, 23 Jan 2020 at 19:08, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>>=20
>> On Wed, 2020-01-22 at 19:10 +0000, Schumaker, Anna wrote:
>>> Hi Robert,
>>>=20
>>> On Mon, 2020-01-20 at 17:55 +0000, Robert Milkowski wrote:
>>>>> -----Original Message-----
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>> Sent: 30 December 2019 15:37
>>>>> To: Robert Milkowski <rmilkowski@gmail.com>
>>>>> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; Trond
>>>>> Myklebust
>>>>> <trond.myklebust@hammerspace.com>; Anna Schumaker
>>>>> <anna.schumaker@netapp.com>; linux-kernel@vger.kernel.org
>>>>> Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do
>>>>> implicit
>>>>> lease renewals
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On Dec 30, 2019, at 10:20 AM, Robert Milkowski <
>>>>>> rmilkowski@gmail.com>
>>>>> wrote:
>>>>>> From: Robert Milkowski <rmilkowski@gmail.com>
>>>>>>=20
>>>>>> Currently, each time nfs4_do_fsinfo() is called it will do an
>>>>>> implicit
>>>>>> NFS4 lease renewal, which is not compliant with the NFS4
>>>>> specification.
>>>>>> This can result in a lease being expired by an NFS server.
>>>>>>=20
>>>>>> Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing
>>>>>> leases")
>>>>>> introduced implicit client lease renewal in nfs4_do_fsinfo(),
>>>>>> which
>>>>>> can result in the NFSv4.0 lease to expire on a server side, and
>>>>>> servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
>>>>>>=20
>>>>>> This can easily be reproduced by frequently unmounting a sub-
>>>>>> mount,
>>>>>> then stat'ing it to get it mounted again, which will delay or
>>>>>> even
>>>>>> completely prevent client from sending RENEW operations if no
>>>>>> other
>>>>>> NFS operations are issued. Eventually nfs server will expire
>>>>>> client's
>>>>>> lease and return an error on file access or next RENEW.
>>>>>>=20
>>>>>> This can also happen when a sub-mount is automatically
>>>>>> unmounted due
>>>>>> to inactivity (after nfs_mountpoint_expiry_timeout), then it is
>>>>>> mounted again via stat(). This can result in a short window
>>>>>> during
>>>>>> which client's lease will expire on a server but not on a
>>>>>> client.
>>>>>> This specific case was observed on production systems.
>>>>>>=20
>>>>>> This patch makes an explicit lease renewal instead of an
>>>>>> implicit one,
>>>>>> by adding RENEW to a compound operation issued by
>>>>>> nfs4_do_fsinfo(),
>>>>>> similarly to NFSv4.1 which adds SEQUENCE operation.
>>>>>>=20
>>>>>> Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing
>>>>>> leases")
>>>>>> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
>>>>>=20
>>>>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>=20
>>>>>=20
>>>>=20
>>>> How do we progress it further?
>>>=20
>>> Thanks for following up! I have the patch included in my linux-next
>>> branch for
>>> the next merge window.
>>=20
>> NACK. This is the wrong way to solve the problem. Lease renewal in
>> NFSv4 does not need to be tied to fsinfo. It creates an unnecessary
>> extra error condition that has absolutely nothing to do with the
>> functionality of retrieving per-filesystem attributes.
>=20
> Well, we also do it for NFSv4.1+ with the SEQUENCE operation being
> send by fsinfo, and as Chuck pointed out
> it makes sense to do similarly for 4.0, which is what this patch does.

I did say that.

However, I can see that for NFSv4.1+, the client code handling the
SEQUENCE response will update cl_last_renewal. It does not need to
be done in the fsinfo code.

The NFSv4.0 behavior should be correct if cl_last_renewal is not
updated. That should force the client to send a separate RENEW
operation so that both the client and server agree that the lease
is active.

If I understand Trond correctly?


> Or as per the v2 version of the patch, not do the implicit RENEW for
> 4.0, which was a simpler patch,
> but then not in-line with 4.1+.
>=20
>>=20
>> All that needs to be done here is to move the setting of clp-
>>> cl_last_renewal _out_ of nfs4_set_lease_period(), and just have
>> nfs4_proc_setclientid_confirm() and nfs4_update_session() call
>> do_renew_lease().
>>=20
>=20
> This would also require nfs4_setup_state_renewal() to call
> do_renew_lease() I think - at least it currently calls
> nfs4_set_lease_period().
> Also, iirc fsinfo() not setting cl_last_renewal leads to
> cl_last_renewal initialization issues under some circumstances.
>=20
> Then the RFC 7530 in section 16.34.5 states:
> "SETCLIENTID_CONFIRM does not establish or renew a lease.", so calling
> do_renew_lease() from nfs4_setclientid_confirm() doesn't seem to be
> ok.
>=20
> I'm not sure if is is valid to do implicit lease renewal in
> nfs4_update_session() either...
>=20
>=20
> Anyway, the patch would be something like (haven't tested it yet):
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d3716..a7af864 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5019,16 +5019,13 @@ static int nfs4_do_fsinfo(struct nfs_server
> *server, struct nfs_fh *fhandle, str
>        struct nfs4_exception exception =3D {
>                .interruptible =3D true,
>        };
> -       unsigned long now =3D jiffies;
>        int err;
>=20
>        do {
>                err =3D _nfs4_do_fsinfo(server, fhandle, fsinfo);
>                trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
>                if (err =3D=3D 0) {
> -                       nfs4_set_lease_period(server->nfs_client,
> -                                       fsinfo->lease_time * HZ,
> -                                       now);
> +                       nfs4_set_lease_period(server->nfs_client,
> fsinfo->lease_time * HZ)
>                        break;
>                }
>                err =3D nfs4_handle_exception(server, err, &exception);
> @@ -6146,6 +6143,10 @@ int nfs4_proc_setclientid_confirm(struct =
nfs_client *clp,
>                clp->cl_clientid);
>        status =3D rpc_call_sync(clp->cl_rpcclient, &msg,
>                               RPC_TASK_TIMEOUT | =
RPC_TASK_NO_ROUND_ROBIN);
> +       if(status =3D=3D 0) {
> +               unsigned long now =3D jiffies;
> +               do_renew_lease(clp, now);
> +       }
>        trace_nfs4_setclientid_confirm(clp, status);
>        dprintk("NFS reply setclientid_confirm: %d\n", status);
>        return status;
> @@ -8590,6 +8591,8 @@ static void nfs4_update_session(struct
> nfs4_session *session,
>        if (res->flags & SESSION4_BACK_CHAN)
>                memcpy(&session->bc_attrs, &res->bc_attrs,
>                                sizeof(session->bc_attrs));
> +       unsigned long now =3D jiffies;
> +       do_renew_lease(session->clp, now);
> }
>=20
> static int _nfs4_proc_create_session(struct nfs_client *clp,
> diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
> index 6ea431b..ff876dd 100644
> --- a/fs/nfs/nfs4renewd.c
> +++ b/fs/nfs/nfs4renewd.c
> @@ -138,15 +138,12 @@
>  *
>  * @clp: pointer to nfs_client
>  * @lease: new value for lease period
> - * @lastrenewed: time at which lease was last renewed
>  */
> void nfs4_set_lease_period(struct nfs_client *clp,
> -               unsigned long lease,
> -               unsigned long lastrenewed)
> +               unsigned long lease)
> {
>        spin_lock(&clp->cl_lock);
>        clp->cl_lease_time =3D lease;
> -       clp->cl_last_renewal =3D lastrenewed;
>        spin_unlock(&clp->cl_lock);
>=20
>        /* Cap maximum reconnect timeout at 1/2 lease period */
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 3455232..d7b02fd 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -102,7 +102,8 @@ static int nfs4_setup_state_renewal(struct =
nfs_client *clp)
>        now =3D jiffies;
>        status =3D nfs4_proc_get_lease_time(clp, &fsinfo);
>        if (status =3D=3D 0) {
> -               nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, =
now);
> +               nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
> +               nfs4_do_renew_lease(clp, now);
>                nfs4_schedule_state_renewal(clp);
>        }
>=20
>=20
>=20
> But it potentially has issues, as just pointed out, mainly with not
> being compliant with rfc again.
>=20
> Also see the comments above about the SEQUENCE.
> Trond - ?
>=20
> Chuck, Anna - which way do you prefer, the one proposed by Chuck or
> the one now proposed by Trond?
>=20
> Or perhaps my v2 patch which is least invasive and just stops doing
> implicit renewals for 4.0 if cl_last_renewal is already set.
>=20
> I personally think the way proposed by Chuck is fully compliant with
> RFC and in-line with what we currently do for 4.1 via SEQUENCE,
> so perhaps the best option. ?
>=20
> --=20
> Robert Milkowski

--
Chuck Lever



