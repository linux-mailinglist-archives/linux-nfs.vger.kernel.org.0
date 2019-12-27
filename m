Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5212BB1A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2019 21:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0UZF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Dec 2019 15:25:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfL0UZE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Dec 2019 15:25:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBRK4GIh073235;
        Fri, 27 Dec 2019 20:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=dqZrG8E4cu2nvkEYIOnU0WpLE4hqWx9a3Pd5wmhmErs=;
 b=W2/ZMv2ZrzeYo3Bcus+L6AAtD0KTpHO+vjXLWeacrwnSVE9P/TnV+VwIE29eDLRE3/Rx
 ppFvrJgrxpGTp5po1Zj8UnTI6fm/BdBBYEEQxNeRwD+1YyCBAvUulkV2YT9E7kITYaud
 dQkwXjWabqtgjaRLtnRSn7Da6MmXbRXbGkJimUSEBdT7FzNmeHYk4pA49XuMSKaVYM4i
 xfZXmReCACKFsCFcweOqkPJxmPGvPTB1Ns3KwHHTaKADNEdkSYtdWDq2JhLCzE8O9Apg
 OWAmKaXgjadbEK888suDvG4CasghatIacjoB3Hr9M/dlOlnOtS0ceztYYX1QJN9B/dJW LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2x1attxuf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Dec 2019 20:25:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBRK3P40181882;
        Fri, 27 Dec 2019 20:25:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2x4t40vnc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Dec 2019 20:24:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBRKOss8018407;
        Fri, 27 Dec 2019 20:24:57 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Dec 2019 12:24:53 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <015901d5bce8$d6957010$83c05030$@gmail.com>
Date:   Fri, 27 Dec 2019 15:24:52 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BCC7682-CA85-4B97-BAD4-A6A1D1DD43D9@oracle.com>
References: <001901d5ba67$8954ede0$9bfec9a0$@gmail.com>
 <594E0E04-1253-4C0D-8A58-EB4AF883B7EC@oracle.com>
 <015901d5bce8$d6957010$83c05030$@gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9483 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912270167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9483 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912270167
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 27, 2019, at 2:07 PM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
> Hi Chuck,
>=20
>>> On Dec 24, 2019, at 9:36 AM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>>>=20
>>> From: Robert Milkowski <rmilkowski@gmail.com>
>>>=20
>>> Currently, each time nfs4_do_fsinfo() is called it will do an =
implicit
>>> NFS4 lease renewal, which is not compliant with the NFS4 =
specification.
>>> This can result in a lease being expired by an NFS server.
>>=20
>> In addition to stating the bug symptoms, IMO you need
>>=20
>> Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
>>=20
>=20
> Right, makes sense. I will include it in the next patch revision.
> Thans.
>=20
>=20
>> And this description needs to explain how 83ca7f5ab31f broke things.
>=20
> Is adding the below to the previous description enough?
>=20
> The 83ca7f5ab31f introduced implicit renew operation when calling =
nfs4_do_fsinfo(),
> which is not done by NFS servers which under some circumstances =
results in nfsv4.0 lease
> to expire on a server side which then will return NFS4ERR_EXPIRED or =
NFS4ERR_STALE_CLIENTID.
> This can be easily reproduced by frequently unmounting a sub-mount =
over nfsv4.0,
> which after a grace period will result in an error returned by a =
server when accessing a file.
> This can also happen after a sub-mount is automatically unmounted due =
to inactivity
> (after nfs_mountpoint_expiry_timeout), then the sub-mount is stat'ed =
causing it to be mounted again,
> and a file is accessed shortly after (this all depends on specific =
grace time, last RENEW, etc.).
> This specific case was observed on a production systems.

Wrap at 72, but OK. Some prefer short descriptions, but I like to
have enough bread crumbs to find my way back to the purpose of a
commit when I've forgotten it 6 months from now.

A timing-related failure is obnoxious, so this explanation is going
to also help sustaining engineers locate this fix quickly if needed.


>> There are two usual practices to introduce behavior that diverges
>> amongst NFSv4 minor versions. Neither practice is followed here.
>>=20
>> - The difference is added to the XDR encoder and decoder. You could
>> do that by adding a RENEW to the COMPOUND in the NFSv4.0 case.
>>=20
>> - The function is converted to a virtual function which is added to
>> struct nfs4_minor_version_ops.
>>=20
>=20
> Thanks for the explanation, I'm learning here and really do appreciate =
any help.
> So given the above advise I ended up with the below:
>=20
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d3716..6d075f0 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4998,12 +4998,16 @@ static int nfs4_proc_statfs(struct nfs_server =
*server, struct nfs_fh *fhandle, s
> static int _nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh =
*fhandle,
>                struct nfs_fsinfo *fsinfo)
> {
> +       struct nfs_client *clp =3D server->nfs_client;
>        struct nfs4_fsinfo_arg args =3D {
>                .fh =3D fhandle,
>                .bitmask =3D server->attr_bitmask,
> +               .clientid =3D clp->cl_clientid,
> +               .renew =3D nfs4_has_session(clp) ? 0 : 1,         /* =
append RENEW */
>        };
>        struct nfs4_fsinfo_res res =3D {
>                .fsinfo =3D fsinfo,
> +               .renew =3D nfs4_has_session(clp) ? 0 : 1,

Urgh. I wish there was a better way to do this, but it will do for now.


>        };
>        struct rpc_message msg =3D {
>                .rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_FSINFO],
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 936c577..0ce9a10 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -555,11 +555,13 @@ static int decode_layoutget(struct xdr_stream =
*xdr, struct rpc_rqst *req,
> #define NFS4_enc_fsinfo_sz     (compound_encode_hdr_maxsz + \
>                                encode_sequence_maxsz + \
>                                encode_putfh_maxsz + \
> -                               encode_fsinfo_maxsz)
> +                               encode_fsinfo_maxsz + \
> +                               encode_renew_maxsz)
> #define NFS4_dec_fsinfo_sz     (compound_decode_hdr_maxsz + \
>                                decode_sequence_maxsz + \
>                                decode_putfh_maxsz + \
> -                               decode_fsinfo_maxsz)
> +                               decode_fsinfo_maxsz + \
> +                               decode_renew_maxsz)
> #define NFS4_enc_renew_sz      (compound_encode_hdr_maxsz + \
>                                encode_renew_maxsz)
> #define NFS4_dec_renew_sz      (compound_decode_hdr_maxsz + \
> @@ -2646,6 +2648,8 @@ static void nfs4_xdr_enc_fsinfo(struct rpc_rqst =
*req, struct xdr_stream *xdr,
>        encode_sequence(xdr, &args->seq_args, &hdr);
>        encode_putfh(xdr, args->fh, &hdr);
>        encode_fsinfo(xdr, args->bitmask, &hdr);
> +       if (args->renew)
> +               encode_renew(xdr, args->clientid, &hdr);
>        encode_nops(&hdr);
> }
>=20
> @@ -6778,6 +6782,11 @@ static int nfs4_xdr_dec_fsinfo(struct rpc_rqst =
*req, struct xdr_stream *xdr,
>                status =3D decode_putfh(xdr);
>        if (!status)
>                status =3D decode_fsinfo(xdr, res->fsinfo);
> +       if (status)
> +               goto out;
> +       if (res->renew)
> +               status =3D decode_renew(xdr);
> +out:
>        return status;
> }
>=20
>=20
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 72d5695..49bd673 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1025,11 +1025,14 @@ struct nfs4_fsinfo_arg {
>        struct nfs4_sequence_args       seq_args;
>        const struct nfs_fh *           fh;
>        const u32 *                     bitmask;
> +       clientid4                       clientid;
> +       unsigned char                   renew:1;
> };
>=20
> struct nfs4_fsinfo_res {
>        struct nfs4_sequence_res        seq_res;
>        struct nfs_fsinfo              *fsinfo;
> +       unsigned char                   renew:1;
> };
>=20
> struct nfs4_getattr_arg {
>=20
>=20
>=20
> Let me know if that's what you had it mind and if no further comments =
I will finish testing and submit new patch.

Interesting to test what happens if:

a) the server fails the COMPOUND before getting to the RENEW?

b) the RENEW itself fails; does the client correctly perform state
recovery in that case?


>> Prior to 83ca7f5ab31f, IIRC this function was part of a code path
>> that did actually renew the lease. It seems to me that the proper
>> fix here is to make NFSv4.0 renew the lease, not the other way
>> around. Is there a reason not to add a RENEW to the NFSv4.0 version
>> of the fsinfo COMPOUND?
>>=20
>=20
> Strictly speaking I don't think renew is required here,

That's correct, a RENEW is not required by the protocol. Our client
implementation assumes that the lease is renewed, however, and
appending a RENEW is a valid way to ensure that happens with NFSv4.0.


> but adding it as part of the compound
> operation is harmless and more in-line with how it is currently done =
for v4.1.
>=20
> Also, before the 83ca7f5ab31f, implicit lease renewal was only done in =
nfs4_proc_setclientid_confirm(),
> but the function is not called when mounting a sub-mount, and it was =
not done in nfs4_do_fsinfo() either.
> The implicit renewal in nfs4_do_fsinfo() when mounting each submount =
was introduced by the commit, before it only happened on root
> mount.
> So this particular issue I'm trying to fix here did not occur before =
the change, I think.

Does that alter your explanation in the patch description? Does 83ca7f5
make things worse?


> (btw: according to RFC7530 section 9.5. the implicit renewal in =
setclientid_confirm() wasn't correct either but I think it was
> harmless).

Indeed, the last paragraph of 16.34.5 clearly states:

> SETCLIENTID_CONFIRM does not establish or renew a lease.



--
Chuck Lever



