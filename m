Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFE3464A9
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 17:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhCWQO7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 12:14:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40632 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhCWQOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 12:14:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NG4vlV035551;
        Tue, 23 Mar 2021 16:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mzghtBC1c7jBeoapZIr+uKoD3WTeWa7+SpEGdg1IZpU=;
 b=TBdlWtO7/Zdz53ghYNGOFhVieqehwiyLrYNwOsB4QH3l6i8G30AwNO9/1miug/OyEBYk
 HxBcsD2Mwhn0g7dLx7C25AhmheN8CnjrbgTHqsiamEZ38ZjUiAfuKFgZ3yiUt6V4AkZ8
 vXvUwx5L2EA5zW+FdhTwjB8Yqs6M+MOcgW3dJCWM8jd/hXiKtsqL1Mc1poT0FsxYyClS
 2j8Ez/yj1BfQF8rK52LNi4hott0oSbcm4x2m3K9HpmZMaQXZhTI0++RiLQjLllnzFC55
 mylxmSD+3k2p9RKHuKQCpAYwyHWNhCNUWfeWQ+CfE8HPY5809st6M/GYkNLNNGqBfU/i Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8fr7pn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 16:14:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NG0lBx112741;
        Tue, 23 Mar 2021 16:14:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 37dtyxn9bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 16:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buZNYYdCntM/7tbxKtqwLWey4+uY9gd2DKV10wkqGTE+IkElqsj1+xlbpRRpAzyVY99JwZq+ZfZqLnwkIq9DpgIdv4q8dSXeIDzwoV8iUD4l1sCKYhQkKv3BP8HyZnMglsD0MS74sme4J26aB5Kj4dlntHV6ccFxXKy2eLos0Yiik0WUFWph0TIIhX89AhsE6lJXk9ZbMDpmFWCQvpJLXH9jZUoIKfS++X8lqCPhI8LinzFbBHLJN5WRCcEC1ZaJHWOCbaUg9XzgBJuuD8bkwRvuJ/g0H6rln+89enCl1n90Kg+aMN5enFPIwGwBn6ixoHVdwJ71mK3JOrveHlqeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzghtBC1c7jBeoapZIr+uKoD3WTeWa7+SpEGdg1IZpU=;
 b=kT2huQv4UTuBpcprtpuzXMkv8pB6T4rNeC6cO73U3Blh/M7VYq3MBNWLbKfm2XlCBrl95Zh8sSB4YskQtj5LciJQLIRRtjB9Fca4CItB6aEMr1InGMWdmhNwaaHBFho9/nTz+dfgayIN16UMIOQ9BUB6EIug+SA4TL83cgatgAz6DdyILBdZRb/X/IrDCvD2okqu22W+a8Ui07S75IXFeVbzPlQGvJ2yIMrHYsecpmhUgo9V2Z6pmYNeHWw34veBvCe3OZqEeC3Bk3U7hmlwHv0Nii/oE/tXCMRnCxRIBkOYxNlAaPGaZUPyQlyK880lXZ/GMvjgxOm8XSEnPi6kHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzghtBC1c7jBeoapZIr+uKoD3WTeWa7+SpEGdg1IZpU=;
 b=t3TaspQEbPZxmHDxBNA0iGJ4t25Zt9kLUBYxNSJPpVpMJ/qhZIofM/YOqrkVW9bC8r4sOx/bCl7mfSApkP3jG6/aQlXCSKYA3rvYalt51UFRwMklrbjKMLD1hR2rNFztE11BV1ZxCBtV+xo0PYtVdMCS4uVuN8C8U3DUSfGaOcE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 16:14:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 16:14:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AA==
Date:   Tue, 23 Mar 2021 16:14:37 +0000
Message-ID: <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0fa8fce-f2d7-4313-1cbd-08d8ee16c181
x-ms-traffictypediagnostic: BY5PR10MB4386:
x-microsoft-antispam-prvs: <BY5PR10MB438637159F7CEF4B5DAC7B2893649@BY5PR10MB4386.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrbBOZJbvsQDTdBwlXNF5u8T79Wga1ofGDCAgIQy3ptAYHy40a1SM8vIFZgG2yHJcbCttixvC1G+ua3f1dCm6b7cydKkSL/pgJTzAF/4YaXGXxxjn2NkP1neDuyE/8hzWGbkLeSWEFDKafUbkR06VCwbs+VhSGZvF48l0KqzCwWxXdrSCJjWUlOObPne+alzBh9oTvFda665yH66NSiyyfd9WmoFTBCoH0TYNZztjnahcztoq81RT9TZZ9lDpnMRKDBhaq2vwZUqTn8fTMq0jvcHY2BQ8KQ5oKMZXSQlMfDllJcF9F6r82IFkbukInva2zfa2DcKO/GrQdj1l+pGCPmtBiWsyNOLi7/Mkvdr02vBolFfvhKuzPEvE0rJyjr7FpwSG+6g2eYG+lnrLAEpGWabf8RuObHg2bomfByextF42QDWaGGoh2i00/sZ3qzr69ureAjWoeKfHu1kQPyUa5zAXVLxPRE7UOOz3Moexvun0ihLcErwkQxMcc1fomBA1V52oUH4Vhblbp7iNOMwqfDiScZMGcUR190EfzN09efBF4omqPICD0UcqxMy54sCkADIOnNbxaqmUCrdQ5FJaiuaa8UR5cGwtPQRUn4p5q6UCmutYmj1N9GGVNRFs3vyBUbUA8Bha4Jsn96MdsNM17zQ+4iU2tEvCzYVlJ+Xhl/O5G12eL5ZUkLnkAMHTUTm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(66446008)(66946007)(91956017)(186003)(76116006)(26005)(71200400001)(64756008)(36756003)(54906003)(4326008)(66476007)(66556008)(5660300002)(33656002)(6486002)(83380400001)(316002)(38100700001)(6512007)(478600001)(86362001)(2616005)(6506007)(6916009)(8936002)(53546011)(2906002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xzdeQEqo42RIoRJlshhyYLBLBmWiplZm+QflJg8iMsMTtJbzAC/xQT3ki4pp?=
 =?us-ascii?Q?ZHtfnQJWlo2cWAJbkzIbP9wHkku4lg5cL4VlEFBkP2LaX1i5flzgSR3NX4yP?=
 =?us-ascii?Q?11zRATGx4p7vabfer/zIc1v7VUDr8KgTZIPmA720yuLyccbhX2lgicWMpAap?=
 =?us-ascii?Q?Kuhm1vvWsHg/J02yyDrJHAc/8vgTfIpWz4XeG1e/XicAR/Sfgj1kIe61/kG1?=
 =?us-ascii?Q?f18M3VnGN/mR/enmymBak1YYvMrYIwSju7D4gYJFhfayo2DupKhvQ5IWp8tJ?=
 =?us-ascii?Q?JfB5LWECE33Z4qNoEYpnrc7bJVdM3GEFIKaDBcsRnnADKrsLZpGtDSJ5tBjD?=
 =?us-ascii?Q?/8CXAl7xp8iUqI/XeDGRdgIL7SLPy4ozC5Izrt7pzBtqBNxxfZQj/7NOjuuO?=
 =?us-ascii?Q?UeiVMxrQqtDOz1qJP4XVjWOpUPK9/tMneTB+27z26cibFvRU+2r8l6Y7KGlZ?=
 =?us-ascii?Q?Q4GukTMj0n4sT2Rm2H2AwGLGaRHvIgZYOOtxnutimpwlAAj6DMp3gHsyhFuh?=
 =?us-ascii?Q?4r5g6pb/KZUROUnkAsN58O79ISvVAglmDhOoK51wZHfvhKoumiBh9vKm++sw?=
 =?us-ascii?Q?tKYfWqmsLaiLdbmi4ap52w/LuHgT/0wfc93Fo9Y0ghZErHutt4Q6WfhmMBC/?=
 =?us-ascii?Q?ngXGLFgQUnl06ZKiM3EO7oC91iQyerHo+yj86qZtfzGmQcnwVdrpURAEB4cj?=
 =?us-ascii?Q?dYVybZsGuWYmUoPLVAdvIydoBA6nScQb/PYy+V+kL9XVN3DuOR7y0PBD/WYt?=
 =?us-ascii?Q?B0h7CMXmhFFjAYD97XGYV9C03EpaW9gMorKmkR4PQ2K1zaAqBpZuCaSqI4Uh?=
 =?us-ascii?Q?sZ0yH88GkMQqaE+MNMo1nh8AWaio7U3Js6wWrV8dl9zurqBrU6M0c+jJ1Y1R?=
 =?us-ascii?Q?of7/riabA7xp7E56xSnww7vAMTgJ1/FT9cl4yDpZguiu67JOmU7lbXW3k5hu?=
 =?us-ascii?Q?SwqU6/V04jRuF9cxKrStcxeneOT8qzfDqie+MWNJbud77dDf5btjVdURcveX?=
 =?us-ascii?Q?EaX6uXnQW2yBLJYMVEAJBIruPdXL/6GHXJyeDWISH+BrUWc8FeEbKf326/lu?=
 =?us-ascii?Q?B89KF4pfI4WGnm92TbAJSAwLEIZCIlGqEikOC6UeFQ3GIpoDezE/ORp1+K5h?=
 =?us-ascii?Q?2az4+FswG4YMBg3lFNolm7+IsXnHCgV3R9ge5LQ05TScfuo8anyTLrJPD3wC?=
 =?us-ascii?Q?W2XrSv8ECJpq1uXCQtlmCTmDNnuYjcJPyfNXfiaiQRPi5QQ67tq4QfaffiP1?=
 =?us-ascii?Q?zMKsI0YVznSRpT0aDJQpIteXgAUnCFx7Rmz+4jahMJJNP4g4hafjIx2Kd4X3?=
 =?us-ascii?Q?N2GNcoGGGxaJ4GQW7xEUkRO9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D9704D763ED454BBFE796B2F1602DA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fa8fce-f2d7-4313-1cbd-08d8ee16c181
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 16:14:37.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjbCWG/NNxU2LFIPjpibVR3/1xNetgLHW5b0CRQmaGzEbYFqShsu8TejANjcnTfHjhC5dJ7KEHgIDmbXqKKvpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2021, at 11:57 AM, Nagendra Tomar <Nagendra.Tomar@microsoft.co=
m> wrote:
>=20
>>> On Mar 23, 2021, at 1:46 AM, Nagendra Tomar
>> <Nagendra.Tomar@microsoft.com> wrote:
>>>=20
>>> From: Nagendra S Tomar <natomar@microsoft.com>
>>>=20
>>> If a clustered NFS server is behind an L4 loadbalancer the default
>>> nconnect roundrobin policy may cause RPC requests to a file to be
>>> sent to different cluster nodes. This is because the source port
>>> would be different for all the nconnect connections.
>>> While this should functionally work (since the cluster will usually
>>> have a consistent view irrespective of which node is serving the
>>> request), it may not be desirable from performance pov. As an
>>> example we have an NFSv3 frontend to our Object store, where every
>>> NFSv3 file is an object. Now if writes to the same file are sent
>>> roundrobin to different cluster nodes, the writes become very
>>> inefficient due to the consistency requirement for object update
>>> being done from different nodes.
>>> Similarly each node may maintain some kind of cache to serve the file
>>> data/metadata requests faster and even in that case it helps to have
>>> a xprt affinity for a file/dir.
>>> In general we have seen such scheme to scale very well.
>>>=20
>>> This patch introduces a new rpc_xprt_iter_ops for using an additional
>>> u32 (filehandle hash) to affine RPCs to the same file to one xprt.
>>> It adds a new mount option "ncpolicy=3Droundrobin|hash" which can be
>>> used to select the nconnect multipath policy for a given mount and
>>> pass the selected policy to the RPC client.
>>=20
>> This sets off my "not another administrative knob that has
>> to be tested and maintained, and can be abused" allergy.
>>=20
>> Also, my "because connections are shared by mounts of the same
>> server, all those mounts will all adopt this behavior" rhinitis.
>=20
> Yes, it's fair to call this out, but ncpolicy behaves like the nconnect
> parameter in this regards.
>=20
>> And my "why add a new feature to a legacy NFS version" hives.
>>=20
>>=20
>> I agree that your scenario can and should be addressed somehow.
>> I'd really rather see this done with pNFS.
>>=20
>> Since you are proposing patches against the upstream NFS client,
>> I presume all your clients /can/ support NFSv4.1+. It's the NFS
>> servers that are stuck on NFSv3, correct?
>=20
> Yes.
>=20
>>=20
>> The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
>> servers. In fact it was designed for exactly this kind of mix of
>> NFS versions.
>>=20
>> No client code change will be necessary -- there are a lot more
>> clients than servers. The MDS can be made to work smartly in
>> concert with the load balancer, over time; or it can adopt other
>> clever strategies.
>>=20
>> IMHO pNFS is the better long-term strategy here.
>=20
> The fundamental difference here is that the clustered NFSv3 server
> is available over a single virtual IP, so IIUC even if we were to use
> NFSv41 with flexfiles layout, all it can handover to the client is that s=
ingle
> (load-balanced) virtual IP and now when the clients do connect to the
> NFSv3 DS we still have the same issue. Am I understanding you right?
> Can you pls elaborate what you mean by "MDS can be made to work
> smartly in concert with the load balancer"?

I had thought there were multiple NFSv3 server targets in play.

If the load balancer is making them look like a single IP address,
then take it out of the equation: expose all the NFSv3 servers to
the clients and let the MDS direct operations to each data server.

AIUI this is the approach (without the use of NFSv3) taken by
NetApp next generation clusters.


>>> It adds a new rpc_procinfo member p_fhhash, which can be supplied
>>> by the specific RPC programs to return a u32 hash of the file/dir the
>>> RPC is targetting, and lastly it provides p_fhhash implementation
>>> for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.
>>>=20
>>> Thoughts?
>>>=20
>>> Thanks,
>>> Tomar
>>>=20
>>> Nagendra S Tomar (5):
>>> SUNRPC: Add a new multipath xprt policy for xprt selection based
>>>   on target filehandle hash
>>> SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the
>> nconnect
>>>   policy and pass it down from mount option to rpc layer
>>> SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN ->
>> RPC_TASK_USE_MAIN_XPRT
>>> NFSv3: Add hash computation methods for NFSv3 RPCs
>>> NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs
>>>=20
>>> fs/nfs/client.c                      |   3 +
>>> fs/nfs/fs_context.c                  |  26 ++
>>> fs/nfs/internal.h                    |   2 +
>>> fs/nfs/nfs3client.c                  |   4 +-
>>> fs/nfs/nfs3xdr.c                     | 154 +++++++++++
>>> fs/nfs/nfs42xdr.c                    | 112 ++++++++
>>> fs/nfs/nfs4client.c                  |  14 +-
>>> fs/nfs/nfs4proc.c                    |  18 +-
>>> fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++++=
++-----
>>> fs/nfs/super.c                       |   7 +-
>>> include/linux/nfs_fs_sb.h            |   1 +
>>> include/linux/sunrpc/clnt.h          |  15 +
>>> include/linux/sunrpc/sched.h         |   2 +-
>>> include/linux/sunrpc/xprtmultipath.h |   9 +-
>>> include/trace/events/sunrpc.h        |   4 +-
>>> net/sunrpc/clnt.c                    |  38 ++-
>>> net/sunrpc/xprtmultipath.c           |  91 +++++-
>>> 17 files changed, 913 insertions(+), 103 deletions(-)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



