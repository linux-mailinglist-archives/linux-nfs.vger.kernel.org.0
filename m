Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6811A14F23F
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 19:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAaSgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 13:36:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSgH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 13:36:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VIXnDF048147;
        Fri, 31 Jan 2020 18:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=C55vXFU8Vf5JDjn21XoNxZOrr1YgaY9/hv2Wijlpbuw=;
 b=NAMlVwcNbvn9u0+OGKTlBbjAx8/ROaTs3bnY1RHF6YzPdQisLGOGljsLIgGpQ0YCFvlW
 Mx9FSDru80e+p4U98lFLtna50f/qCUJHf7WC6HBeHMIODqoS6ZmlhM5RbZBCIYkxR16c
 O8TONGsQWhy2cEBFZs7secm4GmNkMVSFH0uSA/IWG5U6WBptdQxciOwN1MIumWRfDRIi
 iHD6DPTb3fbbjEHvR9NkII1U5T4yl4jouh+VRXgMJW3AMtJ0VRXcpUTBh5ZC2mkRdsn8
 cHYX5Mk98wDhf2x4elpenIzgCCD0TagQd2uDZYdEFu8AqIjJNd54D4qbZ7UrCUL1w91d 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmr49fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 18:36:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VIZpi1167142;
        Fri, 31 Jan 2020 18:36:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xv9bxcxrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 18:35:56 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00VIYYeo030092;
        Fri, 31 Jan 2020 18:34:34 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jan 2020 10:34:34 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] NFSv4.0 encode nconnect-enabled client into clientid
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyG-Mjk1pvba-9b38Nfp_jA-CUaobtLtPj1UfXyRoj-wxA@mail.gmail.com>
Date:   Fri, 31 Jan 2020 13:34:32 -0500
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E45EBB55-7669-4E1E-9F3F-E57BFAB2B7D7@oracle.com>
References: <20200131165702.1751-1-olga.kornievskaia@gmail.com>
 <45AE6B67-4B01-412B-8ABF-94E06BFB77D8@oracle.com>
 <CAN-5tyG-Mjk1pvba-9b38Nfp_jA-CUaobtLtPj1UfXyRoj-wxA@mail.gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310152
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2020, at 12:46 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> Hi Chuck,
>=20
> Thanks for the discussion!
>=20
> On Fri, Jan 31, 2020 at 12:10 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi Olga-
>>=20
>>> On Jan 31, 2020, at 11:57 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> It helps some servers to be able to identify if the incoming client =
is
>>> doing nconnect mount or not. While creating the unique client id for
>>> the SETCLIENTID operation add nconnect=3DX to it.
>>=20
>> This makes me itch uncomfortably.
>=20
> I was asked...
>=20
>> The long-form client ID string is not supposed to be used to =
communicate
>> client implementation details. In fact, this string is supposed to be
>> opaque to the server -- it can only compare these strings for =
equality.
>=20
> Indeed, to servers it should only be using it for equality no argument
> there but I don't think they are prohibited from deriving info from it
> but shouldn't complain if something changed.
>=20
> My reasoning was that we are currently already putting some
> descriptive stuff into the clientid string. We specify what version
> this client is. So why not add something that speaks about its
> nconnect ability?

RFC 7350 Section 9.1.1 discusses what belongs in the client ID string.

- Does adding nconnect help distinguish this client from others?
I think that it adds no new value there.

- How do you guarantee that this client presents the same nconnect
setting after every reboot? If the nconnect setting varies for different
mount points, it's possible that the cl_nconnect value can be different
depending on the order the client performs the mounts.

In fact I don't see how the client is constrained to present the same
nconnect setting even during the same reboot, for similar reasons.

That will break open/lock state reclaim, iiuc. And it will be subtle,
silent, non-deterministic breakage.


>> IMO you would also need to write something akin to a standard that =
describes
>> this convention so that servers can depend on the form of the string.
>>=20
>> How would a server use this information?
>=20
> The server is interested in identifying whether or not client is doing
> nconnect or not in order to decide whether or not to apply extra
> locking for a given client mount in order to provide best performance.
> In 4.1 spec, we clearly define how to bind connections to
> session/clientid so server can use that information but 4.0 is lacking
> that and a server is left to just deal with existence of multiple
> connection (trunking) at any give time.

You can't insist that clients use NFSv4.1 in those cases?

Seems like this is proposing that the Linux NFS client should be changed
to fix a server implementation issue for a protocol that already has =
been
fixed in newer versions.


>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> fs/nfs/nfs4proc.c | 20 +++++++++++---------
>>> 1 file changed, 11 insertions(+), 9 deletions(-)
>>>=20
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 402410c..a90ea28 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -5950,7 +5950,7 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>              return 0;
>>>=20
>>>      rcu_read_lock();
>>> -     len =3D 14 +
>>> +     len =3D 14 + 12 +
>>>              strlen(clp->cl_rpcclient->cl_nodename) +
>>>              1 +
>>>              strlen(rpc_peeraddr2str(clp->cl_rpcclient, =
RPC_DISPLAY_ADDR)) +
>>> @@ -5972,13 +5972,15 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>=20
>>>      rcu_read_lock();
>>>      if (nfs4_client_id_uniquifier[0] !=3D '\0')
>>> -             scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
>>> +             scnprintf(str, len, "Linux NFSv4.0 nconnect=3D%d =
%s/%s/%s",
>>> +                       clp->cl_nconnect,
>>>                        clp->cl_rpcclient->cl_nodename,
>>>                        nfs4_client_id_uniquifier,
>>>                        rpc_peeraddr2str(clp->cl_rpcclient,
>>>                                         RPC_DISPLAY_ADDR));
>>>      else
>>> -             scnprintf(str, len, "Linux NFSv4.0 %s/%s",
>>> +             scnprintf(str, len, "Linux NFSv4.0 nconnect=3D%d =
%s/%s",
>>> +                       clp->cl_nconnect,
>>>                        clp->cl_rpcclient->cl_nodename,
>>>                        rpc_peeraddr2str(clp->cl_rpcclient,
>>>                                         RPC_DISPLAY_ADDR));
>>> @@ -5994,7 +5996,7 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>      size_t len;
>>>      char *str;
>>>=20
>>> -     len =3D 10 + 10 + 1 + 10 + 1 +
>>> +     len =3D 10 + 10 + 1 + 10 + 1 + 12 +
>>>              strlen(nfs4_client_id_uniquifier) + 1 +
>>>              strlen(clp->cl_rpcclient->cl_nodename) + 1;
>>>=20
>>> @@ -6010,9 +6012,9 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>      if (!str)
>>>              return -ENOMEM;
>>>=20
>>> -     scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
>>> +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=3D%d %s/%s",
>>>                      clp->rpc_ops->version, clp->cl_minorversion,
>>> -                     nfs4_client_id_uniquifier,
>>> +                     clp->cl_nconnect, nfs4_client_id_uniquifier,
>>>                      clp->cl_rpcclient->cl_nodename);
>>=20
>> Doesn't this also change the client ID string used for EXCHANGE_ID ?
>=20
> I didn't think it would hurt there. But honestly, I just didn't know
> which of the 3 functions that we have to create clientid were used for
> what protocols so I added nconnect to all.

non_uniform is for NFSv4.0 only. uniform can be used by any minor =
version.


>>>      clp->cl_owner_id =3D str;
>>>      return 0;
>>> @@ -6030,7 +6032,7 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>      if (nfs4_client_id_uniquifier[0] !=3D '\0')
>>>              return nfs4_init_uniquifier_client_string(clp);
>>>=20
>>> -     len =3D 10 + 10 + 1 + 10 + 1 +
>>> +     len =3D 10 + 10 + 1 + 10 + 1 + 12 +
>>>              strlen(clp->cl_rpcclient->cl_nodename) + 1;
>>>=20
>>>      if (len > NFS4_OPAQUE_LIMIT + 1)
>>> @@ -6045,9 +6047,9 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>      if (!str)
>>>              return -ENOMEM;
>>>=20
>>> -     scnprintf(str, len, "Linux NFSv%u.%u %s",
>>> +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=3D%d %s",
>>>                      clp->rpc_ops->version, clp->cl_minorversion,
>>> -                     clp->cl_rpcclient->cl_nodename);
>>> +                     clp->cl_nconnect, =
clp->cl_rpcclient->cl_nodename);
>>>      clp->cl_owner_id =3D str;
>>>      return 0;
>>> }
>>> --
>>> 1.8.3.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



