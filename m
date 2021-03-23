Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D2346057
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhCWNxh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 09:53:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59506 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhCWNxW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 09:53:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NDo4G2105185;
        Tue, 23 Mar 2021 13:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WbkcW33i+U1IZPdtF3Nxrtz4vYTnDyew99c2Qj7CDkE=;
 b=BQw+8BNYpd8XDwyzmXHCNMXaVAJ7AIxFz38Goeditp+3GJEAZk+zuMW6uIH+BCgDtzh6
 WeV41aLn4KBaebkNl/zSdyMxglKqMcmP8imDVRFjHSDxLrJDOpmlR0i070biYBy1Iy0L
 QEj+aPKjnsbgicmZpVB9fB9deh9gdnLa0T8X7k2Z8QRhY9n2RVlNPQjQ8TAt2yT0yXoL
 9WAHCZBwJTEsjTYNwqUjbJVp9ODjnJuzqzhFXo5weDgWG1sfURdaPqCD/s+hwA1TI2gz
 tJIZZTQBO/rS/iUdgsVspqMGsZbX1dOTsfJMwk4LtO20MdTUkkXxjzvhHP+GPT1gtWCL WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37d9pmy1n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:53:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NDkOAP193690;
        Tue, 23 Mar 2021 13:53:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 37dtxy93gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5Jbn74iPWspPToE3rEqRmRkhapom0tjxWjq1vuDksoJawAiM/aO/kgOf3alK9pOQmJSt7BG+7A3cOqKDYNcNOREYo4Pu2F984TCxmpNU3K5jkj7cNuI3+4ii7wbQvCketQVbpHBGcoDfO/8g9vQ9S8YTbWb7ZWL96gd/tvAlNazb8ExbAzYQknJIAXu/s6CrwPMZ4i4YmBK7kGPzWmjjL1hskwh8zv29S9Uf6u8rJE9NpSqC1Ey40Td96lKbxPO2u/ldQEv0i1URa0zfHc54NT8zx8TMUT37+bIBTPbHq/Wy/wna9FMtIr36xWZ3rMMRrC+O2eAxBuiosONCdPlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbkcW33i+U1IZPdtF3Nxrtz4vYTnDyew99c2Qj7CDkE=;
 b=ThLa8HnYwaHztinvICiqh/qO6mFY4OWQCJfJDcVEwMFmU1M3TtiAhnNI699r6Aja9vkrmQyUxlix8QP2hI7dnsd4T+xmXMGS7qv5xiHiFu3HvdANKHqqgu0yf4uM/HzWMYBcoa9mKocF8PSKeatdUoDvoXTAWJcLbibTzGe9F7cDyvqLFML6KDCZHrbw6CzIcyh6Ewt85blvd33lPcoALOh2Sc0zUhFmauB3xvQzJjaitRbbhTSy61rceZ+v8sIBkJvhbFe94lHefBbFXA4ca88Mx/WEcv/gw0DjPjzsi4VA/L9N1D+6Ncat8BvT5IHNnq4Uxir9R/TWEYXgj9PWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbkcW33i+U1IZPdtF3Nxrtz4vYTnDyew99c2Qj7CDkE=;
 b=OD/2Ms/HLBDZEID4o1SMDtmDoqLznvj12kkHK9trLS4k1b8b9DTwwibhDhFmJoIES2R2QhJ2n/XgOe7pOvHJOjK112PxaoHQ3K/qa01YdZZnXyQogQMsHwr2Jt5q3eDblxwT+vwOldrZXDCiPEcnua1uRtFE0e3WiEWxxuEqqfM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 13:53:11 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 13:53:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoA
Date:   Tue, 23 Mar 2021 13:53:11 +0000
Message-ID: <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a698afe4-2b01-4b2a-3aae-08d8ee02ff78
x-ms-traffictypediagnostic: BYAPR10MB2439:
x-microsoft-antispam-prvs: <BYAPR10MB2439BB6C7115D3EDA1C7B71B93649@BYAPR10MB2439.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QZ1ebM/x0CfyiHVqhwUF8IK9r2B63vwpTrUrpy8+JH7ubCk7y7jy8Q7OlwXhj/wohT3WPabgljtDFwKrzgNiTAIAnlAbbbR5NXmre/isnB7GLVfepmXGRFliFrW9J8PzILvsoFOz+jP56j2I/kyFaoH0jwawWK/KqWWb7KVURdPjR2frZB29l++F589F+U/YL9m3qUBRP1RjSXArvGZVoWCpOGJrszIAMrEyBMO6LCrVGZ0fkfUOS9fqvGbIMWgV/m2IG8fP1adj2gp9NrIE6IWE1BUxd4sRLdZUdPsi/LXYsS0dmEAwy5SNeSLCuq/SefBxX8tIpy2ouZ+hcFr7Q4Gs3WbC+r6V6U8HbfQGdHCvLYv4p1xpWoVxly36X9f+mFqeaYO0Pv1bicJ0YvNwjRoG5nGegeb4+JYk80YpWQ8eV9rSsE1e/j61MiNrwSar5jE/6aDphD3KNOuELCvzgtQeq75hPSDtyrCBM5YqsJxzgXxmw1gGapmt0FGJMZGh8Mgo7IW0DAfFFXMYDOhaGHtW86bdYcT41vwGrzWOUwJZ1Yu3tUFFRZJ9pfv9RBiCDbdhSzVoH2nG4W/CakACCZObQ7JXlLI5ceiXLAkGRHJlsmmzaECPQj+Gq//3Z4NmVYKD9lyxoFANxOGzDFEjfhoYj+SiYZihvq0menP5jrI1fPhlSUXSgk7qRvubIZN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(346002)(136003)(2616005)(71200400001)(186003)(6506007)(36756003)(53546011)(316002)(86362001)(26005)(38100700001)(91956017)(66446008)(33656002)(478600001)(66476007)(83380400001)(66556008)(64756008)(54906003)(6916009)(66946007)(2906002)(6486002)(8936002)(5660300002)(6512007)(8676002)(76116006)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?228HctjexcRt6hkfKbSQ9x8SvfUtbZ2tuyCOjcxpVydRh4Bi0lbMpLAXVYmR?=
 =?us-ascii?Q?6mpqibl3/jh14cfajJIfth2VwpsnPjYWWItaM0meEwmJ/dhNvGq0n4BRNXGa?=
 =?us-ascii?Q?rPn7CV2zOQGeA/a+J3t/btqD0LtbwiG6eVLdOoa6kzq/2c+J7cfRuvXK8n9H?=
 =?us-ascii?Q?4FOyPhNIVzNcNQwddqEy2yxzhVAZyyLk0d4ZMXho9s9KJV5YXOHB4X6y81Lx?=
 =?us-ascii?Q?8G7jy3aHScSYegFx+l6YZuqlbPI+oYY61o1HvlSI1zbSu0I4hRa8ctzdD8wF?=
 =?us-ascii?Q?zjZlC6A6YPBN+uw+LQx144CBLt7xveQnVoMADUAlQwkFLUvQ33ypOL9v7QE7?=
 =?us-ascii?Q?yTltpA8rxX+nyS2jqayXjYytD96SUwQKRdcztZp1zn34rZH04tLMj/MYfI5x?=
 =?us-ascii?Q?1xvJdhdT1eOt4v8MPWgsDIcxiwiRQOLF9fcRb19NAaiowU+kB5YZI5wdidif?=
 =?us-ascii?Q?NiF9jjot5x8jEfGueEbS4vIjPh8AiVdt38peyvDUPWd9mMwHq/0mHupdDisO?=
 =?us-ascii?Q?Pt5IyOlkplyweJylAAKE95CO0DWiPGSrYe3p1oy/htMAMu7QapS0IPyreeMy?=
 =?us-ascii?Q?xdAgZQQY6H9Bk931myy7UFVvko68xn/B4o/MIoPfdJblOXTCxyWHS5MblNW5?=
 =?us-ascii?Q?lf73XaMvm/sFUdsgeZ7qVdwEbHEvpPh87mPLPurS8a/eDLB9G5SpFZmQteQM?=
 =?us-ascii?Q?gj2pTKXi0kZb7jYtusSiuUuKVBAAbQY0zRhuZ0ziSK5P5LIp0K8B7BJItCXK?=
 =?us-ascii?Q?yygR/W3UCsw5ay/+gUgqo6wZ5CNED3ajHSbIpQuMcNzGZzaY8KqZ5Ki7HUU3?=
 =?us-ascii?Q?CnPmdiv+fTVYXZALaEZ1cwwitIM285YXXXgutGMH5WmJFWAtXPnivsp1gBrp?=
 =?us-ascii?Q?4DGvilgUz14HxM+RcAGAPw2z86SVBgBeFYBHoVmQtQaslujJ5iYrcHu3REGX?=
 =?us-ascii?Q?8Q2nYxPp6sdiW0LujHHHP8PfSYrW67DNUT3FUwGUcg0Gl3xesR0KgWgPGB31?=
 =?us-ascii?Q?Wi73CQp6hxwbqTNIdJytjs60QriDB1VCFSZXHF42j20K26ukuycTvmgMQkon?=
 =?us-ascii?Q?E9UGtBXlmuz8Pm5aUjpz1woAzNmU9QzsFycuv9iK1wRM9tbH8LSiEkPM7bG1?=
 =?us-ascii?Q?35HFlfn0Z6n/OUUQZ39J+NQ/yo8hrQfHqGIAk5VzMR913r+rIj6QgfCUcI0j?=
 =?us-ascii?Q?Gc5YjnMD452/R8WFnBGO3oZeYxemPI8Sd1S7JrzxH9FxtYiqUhsnn7DCVWKo?=
 =?us-ascii?Q?1UWfoFMLRmTMT/gO16or86bdr1ymZyRsfnTT5N4ZaMFGFe2P1nTX2hc71/ht?=
 =?us-ascii?Q?OVy/7i/PoKdUDgLmPbCi76xicMvPjBxTEhWF+KpdmgDkYA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD12772C69A1504999832464E05A457B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a698afe4-2b01-4b2a-3aae-08d8ee02ff78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 13:53:11.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gt4K35oHhzkHukE5vKA2oyqdnWgKaAqla8MDoOTtrYngMh1HU0zaso/NNgBmaMfPVNLP9/Yn9uvNfVX2wp9Fhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2021, at 1:46 AM, Nagendra Tomar <Nagendra.Tomar@microsoft.com=
> wrote:
>=20
> From: Nagendra S Tomar <natomar@microsoft.com>
>=20
> If a clustered NFS server is behind an L4 loadbalancer the default
> nconnect roundrobin policy may cause RPC requests to a file to be
> sent to different cluster nodes. This is because the source port
> would be different for all the nconnect connections.
> While this should functionally work (since the cluster will usually
> have a consistent view irrespective of which node is serving the
> request), it may not be desirable from performance pov. As an
> example we have an NFSv3 frontend to our Object store, where every
> NFSv3 file is an object. Now if writes to the same file are sent
> roundrobin to different cluster nodes, the writes become very
> inefficient due to the consistency requirement for object update
> being done from different nodes.
> Similarly each node may maintain some kind of cache to serve the file
> data/metadata requests faster and even in that case it helps to have
> a xprt affinity for a file/dir.
> In general we have seen such scheme to scale very well.
>=20
> This patch introduces a new rpc_xprt_iter_ops for using an additional
> u32 (filehandle hash) to affine RPCs to the same file to one xprt.
> It adds a new mount option "ncpolicy=3Droundrobin|hash" which can be
> used to select the nconnect multipath policy for a given mount and
> pass the selected policy to the RPC client.

This sets off my "not another administrative knob that has
to be tested and maintained, and can be abused" allergy.

Also, my "because connections are shared by mounts of the same
server, all those mounts will all adopt this behavior" rhinitis.

And my "why add a new feature to a legacy NFS version" hives.


I agree that your scenario can and should be addressed somehow.
I'd really rather see this done with pNFS.

Since you are proposing patches against the upstream NFS client,
I presume all your clients /can/ support NFSv4.1+. It's the NFS
servers that are stuck on NFSv3, correct?

The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
servers. In fact it was designed for exactly this kind of mix of
NFS versions.

No client code change will be necessary -- there are a lot more
clients than servers. The MDS can be made to work smartly in
concert with the load balancer, over time; or it can adopt other
clever strategies.

IMHO pNFS is the better long-term strategy here.


> It adds a new rpc_procinfo member p_fhhash, which can be supplied
> by the specific RPC programs to return a u32 hash of the file/dir the
> RPC is targetting, and lastly it provides p_fhhash implementation
> for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.
>=20
> Thoughts?
>=20
> Thanks,
> Tomar
>=20
> Nagendra S Tomar (5):
>  SUNRPC: Add a new multipath xprt policy for xprt selection based
>    on target filehandle hash
>  SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the nconnect
>    policy and pass it down from mount option to rpc layer
>  SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN -> RPC_TASK_USE_MAIN_XPRT
>  NFSv3: Add hash computation methods for NFSv3 RPCs
>  NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs
>=20
> fs/nfs/client.c                      |   3 +
> fs/nfs/fs_context.c                  |  26 ++
> fs/nfs/internal.h                    |   2 +
> fs/nfs/nfs3client.c                  |   4 +-
> fs/nfs/nfs3xdr.c                     | 154 +++++++++++
> fs/nfs/nfs42xdr.c                    | 112 ++++++++
> fs/nfs/nfs4client.c                  |  14 +-
> fs/nfs/nfs4proc.c                    |  18 +-
> fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++++++=
-----
> fs/nfs/super.c                       |   7 +-
> include/linux/nfs_fs_sb.h            |   1 +
> include/linux/sunrpc/clnt.h          |  15 +
> include/linux/sunrpc/sched.h         |   2 +-
> include/linux/sunrpc/xprtmultipath.h |   9 +-
> include/trace/events/sunrpc.h        |   4 +-
> net/sunrpc/clnt.c                    |  38 ++-
> net/sunrpc/xprtmultipath.c           |  91 +++++-
> 17 files changed, 913 insertions(+), 103 deletions(-)

--
Chuck Lever



