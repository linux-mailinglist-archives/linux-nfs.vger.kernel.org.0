Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C091814F28B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 20:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAaTJc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 14:09:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaTJc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 14:09:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VJ3dmV074921;
        Fri, 31 Jan 2020 19:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=N939rFoLuAZbbwwmByhfiI8fkplxURBk4nWGr9qYx98=;
 b=IHOaFAobg7lev5iOpf2SDSF1W+v4Ol+xX1Lx1GxkCN4gnwbnq9GkOV+uMx6T4f+yd+qx
 EFbdRPbPZHvi2T5OL2IJKMyFbMDZQ9lAsVbMAVZcwek8M7m0oZdRSx5+Y+YCCuvGCCmw
 gtLljKPqB47ZhgU/Ppnki91Eug8Xmzt2Y6k9aEIZN9NSHiwM22RAQRlls8PlAw5DiUhr
 jg+h6ID9bJQBWtE6hWOevVPrebi36yWLmiOYyVqHLD46/dYPdZ03vW6epRd0prqUz4Gl
 0jnNmmVmqyKJUNDlOpfFnaIfj/8oWyKx8FBLZmzTq+NppTglD4gOh9dp8CwrWLheVJgv yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xrdmr4fur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 19:09:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VJ4ciQ009828;
        Fri, 31 Jan 2020 19:09:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xva6rbs2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 19:09:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00VJ9PBp018793;
        Fri, 31 Jan 2020 19:09:25 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jan 2020 11:09:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] NFSv4.0 encode nconnect-enabled client into clientid
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEFwLpWi=MM=1EetQy4+y=RB4uJ3D8dYNBQ81gr4OmyeQ@mail.gmail.com>
Date:   Fri, 31 Jan 2020 14:09:24 -0500
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8111218-B7AA-4AC7-A6E2-78BEC46D6486@oracle.com>
References: <20200131165702.1751-1-olga.kornievskaia@gmail.com>
 <45AE6B67-4B01-412B-8ABF-94E06BFB77D8@oracle.com>
 <CAN-5tyG-Mjk1pvba-9b38Nfp_jA-CUaobtLtPj1UfXyRoj-wxA@mail.gmail.com>
 <E45EBB55-7669-4E1E-9F3F-E57BFAB2B7D7@oracle.com>
 <CAN-5tyEFwLpWi=MM=1EetQy4+y=RB4uJ3D8dYNBQ81gr4OmyeQ@mail.gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310156
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2020, at 1:55 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> On Fri, Jan 31, 2020 at 1:36 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jan 31, 2020, at 12:46 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> Thanks for the discussion!
>>>=20
>>> On Fri, Jan 31, 2020 at 12:10 PM Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>>>=20
>>>> Hi Olga-
>>>>=20
>>>>> On Jan 31, 2020, at 11:57 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>>>>>=20
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>=20
>>>>> It helps some servers to be able to identify if the incoming =
client is
>>>>> doing nconnect mount or not. While creating the unique client id =
for
>>>>> the SETCLIENTID operation add nconnect=3DX to it.
>>>>=20
>>>> This makes me itch uncomfortably.
>>>=20
>>> I was asked...
>>>=20
>>>> The long-form client ID string is not supposed to be used to =
communicate
>>>> client implementation details. In fact, this string is supposed to =
be
>>>> opaque to the server -- it can only compare these strings for =
equality.
>>>=20
>>> Indeed, to servers it should only be using it for equality no =
argument
>>> there but I don't think they are prohibited from deriving info from =
it
>>> but shouldn't complain if something changed.
>>>=20
>>> My reasoning was that we are currently already putting some
>>> descriptive stuff into the clientid string. We specify what version
>>> this client is. So why not add something that speaks about its
>>> nconnect ability?
>>=20
>> RFC 7350 Section 9.1.1 discusses what belongs in the client ID =
string.
>>=20
>> - Does adding nconnect help distinguish this client from others?
>> I think that it adds no new value there.
>=20
> How does adding LinuxV4.0 helps?  I think "nconnect" servers the same
> value. It distinguishes from another linux client that doesn't do
> nconnect.

"Linux NFSv4.x" is historical. But it does distinguish between
Linux and other operating systems.

If you add nconnect to the client ID string, then most Linux
NFSv4.x mounts will have "nconnect=3Dx" where x is the default
setting. That's no better than just "Linux NFSv4.x".


>> - How do you guarantee that this client presents the same nconnect
>> setting after every reboot? If the nconnect setting varies for =
different
>> mount points, it's possible that the cl_nconnect value can be =
different
>> depending on the order the client performs the mounts.
>=20
> Different mount points share the same clientid. A submount will have
> the same nconnect as the original mount. Given existing
> implementation, we can't have different mounts with different nconnect
> values.

The nconnect value can change over a client reboot. If the
/etc/fstab or /etc/nfsmount.conf settings are changed, the
cl_nconnect value will change.

It's not OK to add a hidden dependence on lock reclaim to
the nconnect mount option.


> What reboot are we talking about server or client?
>=20
> On a client reboot, the same nconnect value is used (if say it's
> mounted from /etc/fstab). If somebody, after a client reboot, manually
> remounted and used a different nconnect value, so what, it's a
> different mount, what problem are you thinking about?
>=20
> If you are talking about a server reboot, then why would a client's
> data structure change that stores the value that created the orginal
> clientid string with the nconnect value.
>=20
>=20
>> In fact I don't see how the client is constrained to present the same
>> nconnect setting even during the same reboot, for similar reasons.
>>=20
>> That will break open/lock state reclaim, iiuc. And it will be subtle,
>> silent, non-deterministic breakage.
>=20
> I'm missing how this can be possible.

If you have multiple NFSv4 mounts in /etc/fstab and they have different
nconnect settings, then the client's cl_nconnect value will depend on
which one gets mounted first. Isn't that how it works?

That would mean that the client presents a different client ID string
to the server depending on which of these mounts happens first after a
client reboot.

We have the same problem with the sec=3D setting, which is why the =
kernel
chooses a setting mostly independently of the sec=3D mount option.


>>>> IMO you would also need to write something akin to a standard that =
describes
>>>> this convention so that servers can depend on the form of the =
string.
>>>>=20
>>>> How would a server use this information?
>>>=20
>>> The server is interested in identifying whether or not client is =
doing
>>> nconnect or not in order to decide whether or not to apply extra
>>> locking for a given client mount in order to provide best =
performance.
>>> In 4.1 spec, we clearly define how to bind connections to
>>> session/clientid so server can use that information but 4.0 is =
lacking
>>> that and a server is left to just deal with existence of multiple
>>> connection (trunking) at any give time.
>>=20
>> You can't insist that clients use NFSv4.1 in those cases?

This seems like a pertinent question. What is wrong with suggesting
the use of NFSv4.1 in such cases?


>> Seems like this is proposing that the Linux NFS client should be =
changed
>> to fix a server implementation issue for a protocol that already has =
been
>> fixed in newer versions.
>>=20
>>=20
>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>> ---
>>>>> fs/nfs/nfs4proc.c | 20 +++++++++++---------
>>>>> 1 file changed, 11 insertions(+), 9 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>> index 402410c..a90ea28 100644
>>>>> --- a/fs/nfs/nfs4proc.c
>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>> @@ -5950,7 +5950,7 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>>>             return 0;
>>>>>=20
>>>>>     rcu_read_lock();
>>>>> -     len =3D 14 +
>>>>> +     len =3D 14 + 12 +
>>>>>             strlen(clp->cl_rpcclient->cl_nodename) +
>>>>>             1 +
>>>>>             strlen(rpc_peeraddr2str(clp->cl_rpcclient, =
RPC_DISPLAY_ADDR)) +
>>>>> @@ -5972,13 +5972,15 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>>>=20
>>>>>     rcu_read_lock();
>>>>>     if (nfs4_client_id_uniquifier[0] !=3D '\0')
>>>>> -             scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
>>>>> +             scnprintf(str, len, "Linux NFSv4.0 nconnect=3D%d =
%s/%s/%s",
>>>>> +                       clp->cl_nconnect,
>>>>>                       clp->cl_rpcclient->cl_nodename,
>>>>>                       nfs4_client_id_uniquifier,
>>>>>                       rpc_peeraddr2str(clp->cl_rpcclient,
>>>>>                                        RPC_DISPLAY_ADDR));
>>>>>     else
>>>>> -             scnprintf(str, len, "Linux NFSv4.0 %s/%s",
>>>>> +             scnprintf(str, len, "Linux NFSv4.0 nconnect=3D%d =
%s/%s",
>>>>> +                       clp->cl_nconnect,
>>>>>                       clp->cl_rpcclient->cl_nodename,
>>>>>                       rpc_peeraddr2str(clp->cl_rpcclient,
>>>>>                                        RPC_DISPLAY_ADDR));
>>>>> @@ -5994,7 +5996,7 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>>>     size_t len;
>>>>>     char *str;
>>>>>=20
>>>>> -     len =3D 10 + 10 + 1 + 10 + 1 +
>>>>> +     len =3D 10 + 10 + 1 + 10 + 1 + 12 +
>>>>>             strlen(nfs4_client_id_uniquifier) + 1 +
>>>>>             strlen(clp->cl_rpcclient->cl_nodename) + 1;
>>>>>=20
>>>>> @@ -6010,9 +6012,9 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>>>     if (!str)
>>>>>             return -ENOMEM;
>>>>>=20
>>>>> -     scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
>>>>> +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=3D%d %s/%s",
>>>>>                     clp->rpc_ops->version, clp->cl_minorversion,
>>>>> -                     nfs4_client_id_uniquifier,
>>>>> +                     clp->cl_nconnect, nfs4_client_id_uniquifier,
>>>>>                     clp->cl_rpcclient->cl_nodename);
>>>>=20
>>>> Doesn't this also change the client ID string used for EXCHANGE_ID =
?
>>>=20
>>> I didn't think it would hurt there. But honestly, I just didn't know
>>> which of the 3 functions that we have to create clientid were used =
for
>>> what protocols so I added nconnect to all.
>>=20
>> non_uniform is for NFSv4.0 only. uniform can be used by any minor =
version.
>>=20
>>=20
>>>>>     clp->cl_owner_id =3D str;
>>>>>     return 0;
>>>>> @@ -6030,7 +6032,7 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>>>     if (nfs4_client_id_uniquifier[0] !=3D '\0')
>>>>>             return nfs4_init_uniquifier_client_string(clp);
>>>>>=20
>>>>> -     len =3D 10 + 10 + 1 + 10 + 1 +
>>>>> +     len =3D 10 + 10 + 1 + 10 + 1 + 12 +
>>>>>             strlen(clp->cl_rpcclient->cl_nodename) + 1;
>>>>>=20
>>>>>     if (len > NFS4_OPAQUE_LIMIT + 1)
>>>>> @@ -6045,9 +6047,9 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>>>>>     if (!str)
>>>>>             return -ENOMEM;
>>>>>=20
>>>>> -     scnprintf(str, len, "Linux NFSv%u.%u %s",
>>>>> +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=3D%d %s",
>>>>>                     clp->rpc_ops->version, clp->cl_minorversion,
>>>>> -                     clp->cl_rpcclient->cl_nodename);
>>>>> +                     clp->cl_nconnect, =
clp->cl_rpcclient->cl_nodename);
>>>>>     clp->cl_owner_id =3D str;
>>>>>     return 0;
>>>>> }
>>>>> --
>>>>> 1.8.3.1
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



