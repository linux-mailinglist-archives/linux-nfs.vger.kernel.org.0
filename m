Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1AF3A0586
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhFHVIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:08:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3104 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhFHVIi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 17:08:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158L6gah009308;
        Tue, 8 Jun 2021 21:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wun/b2xCHWu2ZNcnfFBD0VWpOR4HFHTUuXOFo9Cxv5s=;
 b=w11ZMoj3iLBcnwt6oRs3T98GA203aGX7VwkeQ3UNfU9LAHliWnOQ/MOYJbONvdh5JPYu
 ALv7OaCGL4h3B6QvFt+z3X4PpOm5V0bp3L4h7pbgzxiQPNG9KrCw/3hK2xP1Yi15qIp9
 46k78FE5/YzVuG87WuznJWeRULb/cxr5Qh2e2fUwRdFjQLuM/gDo4cQ7ewvg29ILp980
 hOE4FGxq9MZBXuNkHX/R42XoJoesukCmI979dJziR0TA2xnfUWQESb8ETYU1bFya9PXM
 Yf0Nv0CecdUPrgdb+fynub9GVY36SOsLJn8Ag0wLOkMa7AiiFRSPeldHwLOfsJzE6iXt 3Q== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3926dh86nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 21:06:41 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 158L4i2u044099;
        Tue, 8 Jun 2021 21:06:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by aserp3020.oracle.com with ESMTP id 3922wt2h62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 21:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv6/7kItUNokhXv+tRSR5DVYGVETZ2jVNWqwb8+3jC0ieE/Oc7J3w9sWkBA+wfZJ3aV1QpbxYbgWXQ/LYaWl1C3ns0nSYCuy4ms+fX1RS40Q6cs4uSfYTLBC1vNI8I8fcfWCQuFxXkVxVYl2ivSnkhSWDxwC7c+EGZye8EL1sbhT9Xtf/bblFS9QTYwSx/r23Ax6awV9eG9fDL+/iOuP23AymbQgOrA/CRod3HvHneYfMhGSCQ3A+p5prYXElN9Uo8ME+SNCrttGFUbJuirBoHsYCo+HnE6K5Kc4nH4b86euY87Ag+jrjl/M71VF4gmByKvxSI0zj+2hVTGrtnSlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wun/b2xCHWu2ZNcnfFBD0VWpOR4HFHTUuXOFo9Cxv5s=;
 b=OPoeNMoQ74Al7AR6TUffQdFIbKiCwSk/pwBJadJPz5AF1HW7b+32KD12GRKFecCHmerWFgNkB/6pybWxGToR/efwHvsitn87gYpQQ5ca49sLHV4M7Y5+YEIUa1VHmJ3X6D26W592jxgmL80rS7VS3sMsCtOtAGC1KsmP1oZPMQ21jyRhiJNIi49dUblWlOHDB1Bl/wzQ3e8+ezQcr4TdNIGWDe83W4tH5ZQoTOao0OaiedhKxsvBaE+xOXv/QqUpUrEShu5eJo46rq3Pq0yPicm/qi7wCt2Lj5AkHr0+n0vQDrspjIfXDxNDEoYgfF2OYEGy7bc77qgRZD/tPRBfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wun/b2xCHWu2ZNcnfFBD0VWpOR4HFHTUuXOFo9Cxv5s=;
 b=C6Y14AeKX5DsDB+nqk02e3J6AGGO93hN20GrqPkI9GnfEy/6I0VhqvqJf9nEt0PQqfMcsNBAge2+GqRbuE0SiA12bWC7RRMHbSS8tojVquJSypXOCVGJhEkFeB2PqtYYgYS0oHse5DmEiwx4xlOEZMlD1JTZj9aqnIQ7vRMhUOE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3671.namprd10.prod.outlook.com (2603:10b6:a03:11c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 21:06:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:06:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJcuZUvoeConRke8rYs7QSDzPasKlDQAgAAEK4CAAALJgA==
Date:   Tue, 8 Jun 2021 21:06:38 +0000
Message-ID: <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
 <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
In-Reply-To: <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7596fc8e-5fef-45c1-515e-08d92ac14e97
x-ms-traffictypediagnostic: BYAPR10MB3671:
x-microsoft-antispam-prvs: <BYAPR10MB3671E940C0827F154F79E62F93379@BYAPR10MB3671.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aq5r5zduE1ZXV/7oaX7ZL5fzlk4wiDrtgUOIipZmegbUbP3JKDllIHDo/wOIxPBN2EGAiEzl5DGfA0Ru1rJxbplkMHcUP5JDBGQpsG+u8aJAWxLodl5oZuNrCJewtZQSx10lPagttdhG+ef3L73g522WLWraMFpfYw/9ai2oIxGnB7dUPuLrF1ZZ0dRFV9NJG/XwAPIAkg5wcwOEi1jBphlrBMQ1mf1EMee5H5YKl7b3QrT7CoX2foe12MrDGLepcAi2PvJDfOg79xzI3kacax5PslOkosUbjUy8QZ7A9SLnckkDEshyz5p4Lf8M8qxEpQ32zZ53tLSyJZRPbD5Uidao0MonvcawtapY/QArHKTgiyBaO8ndSnHSsWYO2+dro+chBc5oqjqifxRyEZzoeHd0yDGNIE1IxfEx88krTMO4i+5TdfHjzH2lZLkY+zKIHk8tyYfDNNNJbevspuiyV+9oqawDLZB/fomNvSXVs0PiJtoQx9TCtyAhi9TImW0mbNv5Ma4qEOtxHh/mKewNLa9BYPCAL4/fPh0gKpL7/vPcvWDBkXadg1pdskQZZ1s62FW0DhqM5mIaJYykCVBIuaGy68/VFfU/8rXUTeeEfDtJwu6LTVpVZYMKVDgps0q3d3qjyDkoxHKs86zXkgFAva2YfwmDdqk7vjE6cc17liI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(8936002)(83380400001)(38100700002)(4326008)(6916009)(2616005)(478600001)(316002)(66946007)(86362001)(91956017)(76116006)(71200400001)(66476007)(2906002)(64756008)(8676002)(66446008)(26005)(6512007)(186003)(6486002)(54906003)(36756003)(5660300002)(122000001)(66556008)(53546011)(6506007)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?242yTiGSiS+xfXQbST/1nn2gv7d2TjMTNPBcpyMpC1M//DxUXATjRayRnUYg?=
 =?us-ascii?Q?ftNOvPWxyYK3VFzA6EzChG8WTK1y1M5owcJx9pNMCmxPVJBlkPSE5AyNDe6v?=
 =?us-ascii?Q?e16GaFPaxQc/wRwCaRkUFa1hLvw0Zjt3UuZPqacEiNr6eeeNgs8BlLDZX5hQ?=
 =?us-ascii?Q?w3Gn527GyMXwSnwO5ykHT5wLoJsuB8DH/3K2sN34UpMZ7odM8mi/VwwMW/AX?=
 =?us-ascii?Q?zcKbzvfkzahBc2LHOJqiS/W0FuN2Vs9eiRHknDBKk+Qp7MGkjX9tetv+wzXo?=
 =?us-ascii?Q?vi4SulLmqqyLFfZ12dUJwwBxmfTq0gKzHlqGkPnmmWqR0dzJ93ozK9PQNGrf?=
 =?us-ascii?Q?blrdbAXV4I1nU6kn2S3Gyyq/9P0XUwbdVx7yvBQW+PQ0+vyi0ZpMEOY34TML?=
 =?us-ascii?Q?q0bu9U4ZrW/NGcmAWUNe2Nc+v63QK2W/IK6VlT4gQpUQThaW9girDoTVPguB?=
 =?us-ascii?Q?OZSLGiHkG5LZN+SEegHydSQEUApmCMr6ldxCi1Xf+8vPGTfAhRoTpyR/B0Yn?=
 =?us-ascii?Q?AaaW9f30w6pFDyiPTDR2mPVPoKZ1AsAzLLkVI3Sv59vpG580tDUt+W/l/rkm?=
 =?us-ascii?Q?Co6RLVZr20CLuuKDUXcCenkozSg5EBV/IngXqSAmnaj2Ak8R4xJCi49zneE6?=
 =?us-ascii?Q?DU9vzFyHjSZg1/J4iKNrGTucZ0iecsOuvEhNgt5y1eA7wgW6mIzqypoIsHFf?=
 =?us-ascii?Q?Jt+HfmEqBS7QVV1pC1vBw/+8I3m8cLPWWoBeNdIOJJE3tYlX7Bpn+E/c5yw7?=
 =?us-ascii?Q?K0RDNC1ujmlDucDOiW4ze3w+AhYHahcYymoGbzLmg1mjWNOL9YNd9z8lRsti?=
 =?us-ascii?Q?yxVKZgZ1/mIe01Z0T6QH0v7BohKMp95xR5b25ifVmG4IbxZ5YpSVptQwAss6?=
 =?us-ascii?Q?jrgqigNNyCwPX61y8DHsmUnIBdZwriLAGXcGyeDaydHAci09FMOR8TT8YIBg?=
 =?us-ascii?Q?47UPDV8v52h6t3uLr5gflmAEVBX0T8QrfgpW0wX+wkmkJYGeHphhePgW0syo?=
 =?us-ascii?Q?R4GQwWn5WRx8/X2IwxyqtxS2xwpuBeRVUUdng9sgouu6K6ml7u2i3Ceopdht?=
 =?us-ascii?Q?eR4kZahBLYuwhbREdWgU6fHS6IYds9YTcmdt8OcFnyQmU4R0Z2QtmPvLa9ZE?=
 =?us-ascii?Q?d1lRtAXK/Xvq0tgUMtloUWkERihf+0VchPU0fy9tTJqkkuTGl+gyaMK68BJK?=
 =?us-ascii?Q?blbExTUiblnuKoFu/m4FE81C+SgznDLFuOcApcWCDU4102gbEyWS6hLY6rIT?=
 =?us-ascii?Q?LwhIsPATM+d9ealYxsbIbOlo1CJ7TU9XA7c4M1r1DuRu7uvzwrUojx8bojMG?=
 =?us-ascii?Q?y/8BsuAQ/QmSEIV0VlHT1w3z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <026B0FB123FC8D4A991D63028CD71E22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7596fc8e-5fef-45c1-515e-08d92ac14e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 21:06:38.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uKDY3UfniSnSYrfDIg/kQ2n3sr2YuvQ1mWRD0pCZIO2srscqGGgVqaC6JMSZOdVdqtPSiFoDS2abikP00odpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3671
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080135
X-Proofpoint-ORIG-GUID: muq8xcFZyvTh0RHmyPM_ggNOUUABJ7qX
X-Proofpoint-GUID: muq8xcFZyvTh0RHmyPM_ggNOUUABJ7qX
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 8, 2021, at 4:56 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> On Tue, Jun 8, 2021 at 4:41 PM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> After trunking is discovered in nfs4_discover_server_trunking(),
>>> add the transport to the old client structure before destroying
>>> the new client structure (along with its transport).
>>>=20
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> fs/nfs/nfs4client.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 40 insertions(+)
>>>=20
>>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>>> index 42719384e25f..984c851844d8 100644
>>> --- a/fs/nfs/nfs4client.c
>>> +++ b/fs/nfs/nfs4client.c
>>> @@ -361,6 +361,44 @@ static int nfs4_init_client_minor_version(struct n=
fs_client *clp)
>>>      return nfs4_init_callback(clp);
>>> }
>>>=20
>>> +static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *=
old)
>>> +{
>>> +     struct sockaddr_storage clp_addr, old_addr;
>>> +     struct sockaddr *clp_sap =3D (struct sockaddr *)&clp_addr;
>>> +     struct sockaddr *old_sap =3D (struct sockaddr *)&old_addr;
>>> +     size_t clp_salen, old_salen;
>>> +     struct xprt_create xprt_args =3D {
>>> +             .ident =3D old->cl_proto,
>>> +             .net =3D old->cl_net,
>>> +             .servername =3D old->cl_hostname,
>>> +     };
>>> +     struct nfs4_add_xprt_data xprtdata =3D {
>>> +             .clp =3D old,
>>> +     };
>>> +     struct rpc_add_xprt_test rpcdata =3D {
>>> +             .add_xprt_test =3D old->cl_mvops->session_trunk,
>>> +             .data =3D &xprtdata,
>>> +     };
>>> +
>>> +     if (clp->cl_proto !=3D old->cl_proto)
>>> +             return;
>>> +     clp_salen =3D rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp=
_addr));
>>> +     old_salen =3D rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old=
_addr));
>>> +
>>> +     if (clp_addr.ss_family !=3D old_addr.ss_family)
>>> +             return;
>>> +
>>> +     xprt_args.dstaddr =3D clp_sap;
>>> +     xprt_args.addrlen =3D clp_salen;
>>> +
>>> +     xprtdata.cred =3D nfs4_get_clid_cred(old);
>>> +     rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
>>> +                       rpc_clnt_setup_test_and_add_xprt, &rpcdata);
>>=20
>> Is there an upper bound on the number of transports that
>> are added to the NFS client's switch?
>=20
> I don't believe any limits exist right now. Why should there be a
> limit? Are you saying that the client should limit trunking? While
> this is not what's happening here, but say FS_LOCATION returned 100
> ips for the server. Are you saying the client should be limiting how
> many trunkable connections it would be establishing and picking just a
> few addresses to try? What's happening with this patch is that say
> there are 100mounts to 100 ips (each representing the same server or
> trunkable server(s)), without this patch a single connection is kept,
> with this patch we'll have 100 connections.

The patch description needs to make this behavior more clear. It
needs to explain "why" -- the body of the patch already explains
"what". Can you include your last sentence in the description as
a use case?

As for the behavior... Seems to me that there are going to be only
infinitesimal gains after the first few connections, and after
that, it's going to be a lot for both sides to manage for no real
gain. I think you do want to cap the total number of connections
at a reasonable number, even in the FS_LOCATIONS case.


>>> +
>>> +     if (xprtdata.cred)
>>> +             put_cred(xprtdata.cred);
>>> +}
>>> +
>>> /**
>>> * nfs4_init_client - Initialise an NFS4 client record
>>> *
>>> @@ -434,6 +472,8 @@ struct nfs_client *nfs4_init_client(struct nfs_clie=
nt *clp,
>>>               * won't try to use it.
>>>               */
>>>              nfs_mark_client_ready(clp, -EPERM);
>>> +             if (old->cl_mvops->session_trunk)
>>> +                     nfs4_add_trunk(clp, old);
>>>      }
>>>      clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
>>>      nfs_put_client(clp);
>>> --
>>> 2.27.0
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



