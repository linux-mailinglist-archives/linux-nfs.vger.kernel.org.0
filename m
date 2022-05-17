Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96B52A3DD
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiEQNxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 May 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbiEQNxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 May 2022 09:53:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EABF6A
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 06:53:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HDktkC024633;
        Tue, 17 May 2022 13:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sBQr9Vg+UrcaBgSNkxKM4DfdXRvK/+Z1Zr/lf7AscNQ=;
 b=hbXZKCr7FbYwbHKL0bbnSSUM2LNysQjmq1yEqoQVoackgs96Io+NnJEga0dFU/SI5vDc
 dZkK5PRl66cv+j9rF3UHUfA+SzQPQQVNfbZmiM3dk0zRiy81qS/uHZhJKIiU/FdgsDtx
 YK4q493NfZ9eixUPi7IpozfX+uGpvN3evgAFOPIWy8bRcT1+PQOvz8+A69bHtkLJnYhk
 bYGLgsrSOwZIKJRlZ2MXdSdwYt2ZN9zK4V89FgVP0MWoQutt+Cz7LuXvORq8jRXtHyXS
 ymSmlyYYmr7M9q/I0yL7+TUw2aVA0ys20KwiDFCnGzQwakmq1XeKFvHJm9wuRCupHeUh XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytpbhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 13:53:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HDnvBx017720;
        Tue, 17 May 2022 13:53:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v8nyu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 13:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzF0A73q8/XJb4pkph3kFn0e+OSAV5Z+sJ0JMbYVx525TGl34a+8kvZj56JHZYJdl7rfjOOkQ82ddO2bDNKKzWHaUsH3ehHr0mYX1iem804Z37co5qkufq62UpcRiNIrOYB+kmGXgyftrmkIi8tDeHW0clvE4/GjuFEWT5N3Hy0b+wzWaf/borKbD0zpgwi/rv7yGefz38VAgNuHV5XCbsDnAIo25xr3gsK2YTcwhZt2WiE5qJAULbti3PMOMMOudoyjEX+maFeLlAKqgGhjKlhIRWBRxEXKog8OJmngB5HiOel1hYoSN9KNr8lW1u56BSgVd2E+xQI4ITl5JPiRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBQr9Vg+UrcaBgSNkxKM4DfdXRvK/+Z1Zr/lf7AscNQ=;
 b=ljHQNnvEX+Rv+00sL85AXfwTUlOwqdJ0BFfgkwn5OPdw0STHtZkmbNV4kTkNqswWAZS4GXbrSymBg1fhgN+bMZo1YOWfeF3h5iGeh229EjD5DScr6ugvO0JnKEYC45bIxx40zP2ddEpmhSGh/qVrRvHr2efM99TTw0CRNZ6QQpLK3pcwqB/ER8XiLt9uiHbPrMEVyqp1TbU9qXxrGQZQ306JyVxZIzYA2oB1pbAcgqDe9c2cKkMawJHzzkeuI7tWmC6FWidY4IfR4i0C8+A8/IIHFFL9lEHP4zQsqyz6TA1yv4CD11kX5Imy+TRvzEDIetRqfRmBAAT6DZIcSkzuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBQr9Vg+UrcaBgSNkxKM4DfdXRvK/+Z1Zr/lf7AscNQ=;
 b=hUDv3hOm+Ao6QRKDGQ5rLoyld0oooB8ehGKHB83WgydRzLaZsTzTdAztDfhXs3O1u20HXv49u37J+DHvbf69VzQtaJq5VUX4XTv604G0c3tx8JdPvA6ABbgQy9rVs/LFbsVot4FCGu095Pa84JC4JcrhMek1SzeSgpyLvEJgW/w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4027.namprd10.prod.outlook.com (2603:10b6:5:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 13:53:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 13:53:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v1 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYaWgxARJPFMcwk0mT6makjhNPcK0iB4UAgAEMnwCAAAPpAA==
Date:   Tue, 17 May 2022 13:53:07 +0000
Message-ID: <6061D3BA-A457-4CA0-9638-9A7D90379610@oracle.com>
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
 <20220516203549.2605575-7-Anna.Schumaker@Netapp.com>
 <CFB40FB8-5180-499E-93B8-0DF4C8FE8D94@oracle.com>
 <CAFX2JfnxCYF6FSk6k5gfNA+oCRSf-xfqdZY9Hcog2MaL1PdaOg@mail.gmail.com>
In-Reply-To: <CAFX2JfnxCYF6FSk6k5gfNA+oCRSf-xfqdZY9Hcog2MaL1PdaOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94cbfd4d-331c-4176-35d0-08da380c92b2
x-ms-traffictypediagnostic: DM6PR10MB4027:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4027C502CFCD28F59D198D4993CE9@DM6PR10MB4027.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZYmf+HpsenRuUO6oVwWJDEUNmmVffZsfHTRFBUB/NVRIpvQikSQgHmNatlotMChXm5AdAO6Q4Fr/m8m2Jy+kzpnl68suXCeD1Hz3oxOB4Zpn5JP/j0yRCEvkwGAwFeBXX/JkAqsx1Rp5p1R82LRP780UBC5vrQ+IWwozzpTA2AAJP2SJXGCWYRWrMeBoQug6FuGHrXg7rtKV5fjTuFuybBJ1p5WDJ2jH+lA3i99ijqX/MicOtZp+48YvSCLhKAbEl3sZjK0StidvreeKAggEQJCFzT9dNU5tx8GhybRUTiqkkDaklmTmBQGZj81s/Vb9FkE8jvVIkMcKDJ1Vs19N+ddxXPF5IrxAUqITrkN8kdCgveEP4XNeBz3/b6v3MfFhioapSSXJ1Uiy9ifYJZfVPcl+mAAdiEAp433jtfcgdOoCua5wTQSR3qYAP/fD4KoGoptYCqzgmalLt13cJvnyMFmnIH9ZwVMvCRu3GrJVRp22Hz8SHKliLTNb0A73T+4L/jY7J07jSBl0ofLvynOPE7TYYY2fQ516wQ8ODOhctDYnBlk8xRTZSB/32CYDk98Y8z4+mRhonKOZOMz+ZF6jP284ri9qrR/UknreKT1TJ7C9Lg/wAmBd9dSXiCnFKjz9wcL51BrZbN9NzJNX/qYZXdGTlS17DNbxQHRcGYj8N9onNHSwEfclBMYjbY9pyR4GkKG+eZvLQK1eh+LQDG4bv9JmaAl+Z59zX1k01LJD1CWlhGpLRbhYrAmYZJnEVH0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(64756008)(36756003)(83380400001)(4326008)(91956017)(122000001)(66946007)(66556008)(66476007)(76116006)(6506007)(66446008)(186003)(6486002)(8676002)(2906002)(8936002)(30864003)(2616005)(6916009)(26005)(54906003)(6512007)(33656002)(316002)(508600001)(86362001)(38070700005)(38100700002)(71200400001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wer1hxB8OiXfZGegUg3grvdCC7u9JY56a2cHxicHqCyGqZRY0kAQu91agAjS?=
 =?us-ascii?Q?Vo/8gXkNli0mF3FA1cI3QTUjRgbnjx0JsH63LWQHX5YxaSknCJA/auKwMFaB?=
 =?us-ascii?Q?zSkh7O6apoyQkcRniiGbKUi4tVHuDlCB0asoB4C3vBoy3PP4ZBXaiDAT5MF0?=
 =?us-ascii?Q?GofUa+uckEgr+QUg9G1fgSgODTZjJ43B7Ifl9NOhcwvBXVFD8F43HksoUdZf?=
 =?us-ascii?Q?A+4c7fMIgqjomTPLRaP4FnVg5kJ46X5flcLd1eXm3TvAk/K0kI1CQLN8HL9l?=
 =?us-ascii?Q?MdjP23j4xdl/Au55zkQy4o/MOdDFjUuzTOg/rqonLnARArBJmsJqAu1sNYa1?=
 =?us-ascii?Q?o3pMMr27Id4d6YdkZuf3M3wGsn4IaXvsDF0SqdYo+J4vR+KVR5zfyUSi1I71?=
 =?us-ascii?Q?jiKBbbqBf0iIGlsv3wPM1yp3KLYi6pGbStoVbHV93mKjegn7eiw/bSpwDsIp?=
 =?us-ascii?Q?aqkqwyw2STrtfga2qZ07EoQSPqsa0svP6btxBF2hxcowSPIAgQpdFXH2Jn9L?=
 =?us-ascii?Q?6nRv64eSTTi3VUe0jjQHAo4oEEvuQsVN1l3mPVIRbbbuXfvBaH3ZlVRFdqnl?=
 =?us-ascii?Q?jaDlFvSQ9s8v3FeOkvbXbS++Pjups3EMLzkIF6AAgUuAGl07ccajDASVqCr/?=
 =?us-ascii?Q?x6UFM16StdpMCUHsxvcHiOV2eFx2hndTMkbG+ps72y0aaCiC9P2ddraNIr/k?=
 =?us-ascii?Q?SDHzdwoBL35evRbQXFabH3oklm9wFXR22aLt0k9jg7/skK6+7rJvwo91njaO?=
 =?us-ascii?Q?F7wZTnqv/6Wx7yQ9Rsg/HYbbJz/DJz1ZJn+cg48fXgXQZQ6iJh1WHzS9mPKY?=
 =?us-ascii?Q?VhTnnlyOLB6mEpZ4H2wt0ns4/16ivLlxE5ZCjgNTOX4Z9JeD7RW1eIa8EXq0?=
 =?us-ascii?Q?88P9ocTkec0hzlslQOo7VTBfJ/qCOj5v2KQ1dSqs4ElX5Q0Fc1xKx6WOwDbs?=
 =?us-ascii?Q?nMATOR/i8obAhNfIbjRVhq+WJk1zuZCu8xfGqNtIhVurFEBhX9pmwE7IFTAR?=
 =?us-ascii?Q?UYZ3DD1mEnr3msFhurs+XkWGCc30wAYwjLLzhF0iqcpkNBIHDVIdMSwXcRih?=
 =?us-ascii?Q?xjY9h+8mVbSK7UJtLR/xEkgybczK4MOp/YBA6svYuLe7e4ZuSRVD0ssTMsxc?=
 =?us-ascii?Q?xBG+OszBHpxslZLo3T61awCyWsPDPC4eNBldzv4qsoEB4Hco0C/aVFnPCpzT?=
 =?us-ascii?Q?kF7D5f0VNEpG5i9IpKttsQF7gZ4hEdMhVTkzrMR9SmI4WfFOK7qEj8/CYusG?=
 =?us-ascii?Q?/MzqJsO+IKGcLTzQOo2fqxrZLM8aXMQLD7iRInHG6L5r8bP+l7FP4Xco4lSG?=
 =?us-ascii?Q?y6pvJ60fBr/HFqVUoB2+rs72yms9d5qh6BOr5Ftr3lAVGGu3FZMFZvQYl8Dv?=
 =?us-ascii?Q?Ocm9gMa+KQqcfXoKyx7rQoMBrw/LGQAW12SNN41fAekbxiDgeWj+ASdoHr9f?=
 =?us-ascii?Q?9+undt66RoVcpUgEURSDDo/gj3sBKDDiecbTtXwOazuAWT114YVLUD6v+tcy?=
 =?us-ascii?Q?gnZsLQokLulwGosgFnGsCSl+VTbS6g8Mpw0mcSki/+lZpvr1EX7OkcGZkYXr?=
 =?us-ascii?Q?X6xiHnfWQx1RQ/lfAelukrQNFD7lrUnd6CMSZ5GNhk+zGBTQAjxPfX+XM8c5?=
 =?us-ascii?Q?2YexP74GjHv/DRqQA7enl4gBuOAUH7bZ/GxL07F+s/ZBaM9c4xqIpuAFctOr?=
 =?us-ascii?Q?TZglM/h2tJRLFmxOvOm+CJvFCXQ8hN+7z3UOwAluOfCz4wnZ4fBSCV7211Op?=
 =?us-ascii?Q?Q9x2gaZXOD0TYkYMfRMgMpuotzjfym4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <578C196E0E746A4986294E9ECF25CE82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cbfd4d-331c-4176-35d0-08da380c92b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 13:53:07.7793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDk+HS7kXxnT9FSNhT0Q5Yf7C0fJTJ6CxoOoJ5xAYwtXxh0g9KkEkn6T6H4ZU1qg6TJNvoNxlbztVBMWal6/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4027
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170085
X-Proofpoint-GUID: nwwUCjiKMSQHNykyybThQG5JH2pv4A_V
X-Proofpoint-ORIG-GUID: nwwUCjiKMSQHNykyybThQG5JH2pv4A_V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 17, 2022, at 9:39 AM, Anna Schumaker <schumaker.anna@gmail.com> wr=
ote:
>=20
> Hi Chuck,
>=20
> On Mon, May 16, 2022 at 11:16 PM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On May 16, 2022, at 4:35 PM, Anna.Schumaker@Netapp.com wrote:
>>>=20
>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>=20
>>> Rather than relying on the underlying filesystem to tell us where hole
>>> and data segments are through vfs_llseek(), let's instead do the hole
>>> compression ourselves. This has a few advantages over the old
>>> implementation:
>>>=20
>>> 1) A single call to the underlying filesystem through nfsd_readv() mean=
s
>>>  the file can't change from underneath us in the middle of encoding.
>>> 2) A single call to the underlying filestem also means that the
>>>  underlying filesystem only needs to synchronize cached and on-disk
>>>  data one time instead of potentially many speeding up the reply.
>>> 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_D=
ATA
>>>=20
>>> I also included an optimization where we can cut down on the amount of
>>> memory being shifed around by doing the compression as (hole, data)
>>> pairs.
>>>=20
>>> This patch not only fixes xfstests generic/091 and generic/263
>>> for me but the "-g quick" group tests also finish about a minute faster=
.
>>>=20
>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>=20
>> Hi Anna, some general comments on the NFSD pieces:
>=20
> Thanks for looking over this!
>=20
>>=20
>> - Doesn't READ have the same issue that the file bytes can't change
>>  until the Reply is fully sent? I would think the payload data
>>  can't change until there is no possibility of a transport-layer
>>  retransmit. Also, special restrictions like this should be
>>  documented via code comments, IMHO.
>=20
> The problem with the current READ_PLUS code is that the first segment
> in the reply could already be stale data by the time the last segment
> has been encoded. So we're returning a view of the file from multiple
> points in time. READ only does the single call into the vfs, so it
> doesn't have the same race that's causing issues.

IIUI readv might pull the payload into a buffer, but spliced reads
don't. I realize you can't use splice here, but it seems like splice
would have to guarantee the payload data was immutable while the
Reply is transmitted... maybe that same mechanism could be used here.

Just spit-balling!


>> - David Howells might be interested in this approach, as he had some
>>  concerns about compressing files in place that would appear to
>>  apply also to READ_PLUS. Please copy David on the next round of
>>  these patches.
>=20
> Will do!
>=20
>>=20
>> - Can you say why the READ_PLUS decoder and encoder operates on
>>  struct xdr_buf instead of struct xdr_stream? I'd prefer xdr_stream
>>  if you can. You could get rid of write_bytes_to_xdr_buf,
>>  xdr_encode_word and xdr_encode_double and use the stream-based
>>  helpers.
>=20
> I think my reason was that write_bytes_to_xdr_buf() and
> xdr_encode_word() already took the xdr_buf, so I was matching the
> style. I can change everything over to xdr_stream easily enough, since
> the xdr_bufs in question are always attached to the xdr_stream. Would
> you prefer it if I rework the existing functions as part of this patch
> series, or as a separate prerequisite series?
>=20
>>=20
>> - Instead of using naked integers, please use multiples of XDR_UNIT.
>=20
> I hadn't encountered XDR_UNIT before, but I can do that.
>=20
>>=20
>>=20
>>> ---
>>> fs/nfsd/nfs4xdr.c | 202 +++++++++++++++++++++++-----------------------
>>> 1 file changed, 102 insertions(+), 100 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index da92e7d2ab6a..973b4a1e7990 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -4731,81 +4731,121 @@ nfsd4_encode_offload_status(struct nfsd4_compo=
undres *resp, __be32 nfserr,
>>>      return nfserr;
>>> }
>>>=20
>>> +struct read_plus_segment {
>>> +     enum data_content4 type;
>>> +     unsigned long offset;
>>> +     unsigned long length;
>>> +     unsigned int page_pos;
>>> +};
>>> +
>>> static __be32
>>> -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
>>> -                         struct nfsd4_read *read,
>>> -                         unsigned long *maxcount, u32 *eof,
>>> -                         loff_t *pos)
>>> +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_rea=
d *read,
>>> +                   unsigned long *maxcount, u32 *eof)
>>> {
>>>      struct xdr_stream *xdr =3D resp->xdr;
>>> -     struct file *file =3D read->rd_nf->nf_file;
>>> -     int starting_len =3D xdr->buf->len;
>>> -     loff_t hole_pos;
>>> -     __be32 nfserr;
>>> -     __be32 *p, tmp;
>>> -     __be64 tmp64;
>>> -
>>> -     hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_=
HOLE);
>>> -     if (hole_pos > read->rd_offset)
>>> -             *maxcount =3D min_t(unsigned long, *maxcount, hole_pos - =
read->rd_offset);
>>> -     *maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen -=
 xdr->buf->len));
>>> -
>>> -     /* Content type, offset, byte count */
>>> -     p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
>>> -     if (!p)
>>> -             return nfserr_resource;
>>> +     unsigned int starting_len =3D xdr->buf->len;
>>> +     __be32 nfserr, zero =3D xdr_zero;
>>> +     int pad;
>>>=20
>>> +     /* xdr_reserve_space_vec() switches us to the xdr->pages */
>>>      read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, =
*maxcount);
>>>      if (read->rd_vlen < 0)
>>>              return nfserr_resource;
>>>=20
>>> -     nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_o=
ffset,
>>> -                         resp->rqstp->rq_vec, read->rd_vlen, maxcount,=
 eof);
>>> +     nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_=
file,
>>> +                         read->rd_offset, resp->rqstp->rq_vec, read->r=
d_vlen,
>>> +                         maxcount, eof);
>>>      if (nfserr)
>>>              return nfserr;
>>> -     xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxc=
ount));
>>> +     xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount)=
);
>>>=20
>>> -     tmp =3D htonl(NFS4_CONTENT_DATA);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
>>> -     tmp64 =3D cpu_to_be64(read->rd_offset);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
>>> -     tmp =3D htonl(*maxcount);
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
>>> -
>>> -     tmp =3D xdr_zero;
>>> -     write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &=
tmp,
>>> -                            xdr_pad_size(*maxcount));
>>> +     pad =3D (*maxcount&3) ? 4 - (*maxcount&3) : 0;
>>> +     write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero,=
 pad);
>>>      return nfs_ok;
>>> }
>>>=20
>>> +static void
>>> +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
>>> +                            struct read_plus_segment *segment,
>>> +                            unsigned int *bufpos, unsigned int *segmen=
ts)
>>> +{
>>> +     struct xdr_buf *buf =3D xdr->buf;
>>> +
>>> +     xdr_encode_word(buf, *bufpos, segment->type);
>>> +     xdr_encode_double(buf, *bufpos + 4, segment->offset);
>>> +
>>> +     if (segment->type =3D=3D NFS4_CONTENT_HOLE) {
>>> +             xdr_encode_double(buf, *bufpos + 12, segment->length);
>>> +             *bufpos +=3D 4 + 8 + 8;
>>> +     } else {
>>> +             size_t align =3D xdr_align_size(segment->length);
>>> +             xdr_encode_word(buf, *bufpos + 12, segment->length);
>>> +             if (*segments =3D=3D 0)
>>> +                     xdr_buf_trim_head(buf, 4);
>>> +
>>> +             xdr_stream_move_segment(xdr,
>>> +                             buf->head[0].iov_len + segment->page_pos,
>>> +                             *bufpos + 16, align);
>>=20
>> The term "segment" is overloaded in general, and in particular
>> here. xdr_stream_move_subsegment() might be a less confusing
>> name for this helper.
>=20
> Sure, no problem.
>=20
>>=20
>> However I don't immediately see a benefit from working with the
>> xdr_buf here. Can't you do these operations entirely with the
>> passed-in xdr_stream?
>=20
> I assume so, since the xdr_buf is part of the xdr_stream
>=20
>>=20
>>=20
>>> +             *bufpos +=3D 4 + 8 + 4 + align;
>>> +     }
>>> +
>>> +     *segments +=3D 1;
>>> +}
>>> +
>>> static __be32
>>> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
>>> -                         struct nfsd4_read *read,
>>> -                         unsigned long *maxcount, u32 *eof)
>>> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
>>> +                             struct nfsd4_read *read,
>>> +                             unsigned int *segments, u32 *eof)
>>> {
>>> -     struct file *file =3D read->rd_nf->nf_file;
>>> -     loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
>>> -     loff_t f_size =3D i_size_read(file_inode(file));
>>> -     unsigned long count;
>>> -     __be32 *p;
>>> +     enum data_content4 pagetype;
>>> +     struct read_plus_segment segment;
>>> +     struct xdr_stream *xdr =3D resp->xdr;
>>> +     unsigned long offset =3D read->rd_offset;
>>> +     unsigned int bufpos =3D xdr->buf->len;
>>> +     unsigned long maxcount;
>>> +     unsigned int pagelen, i =3D 0;
>>> +     char *vpage, *p;
>>> +     __be32 nfserr;
>>>=20
>>> -     if (data_pos =3D=3D -ENXIO)
>>> -             data_pos =3D f_size;
>>> -     else if (data_pos <=3D read->rd_offset || (data_pos < f_size && d=
ata_pos % PAGE_SIZE))
>>> -             return nfsd4_encode_read_plus_data(resp, read, maxcount, =
eof, &f_size);
>>> -     count =3D data_pos - read->rd_offset;
>>> -
>>> -     /* Content type, offset, byte count */
>>> -     p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
>>> -     if (!p)
>>> +     /* enough space for a HOLE segment before we switch to the pages =
*/
>>> +     if (!xdr_reserve_space(xdr, 4 + 8 + 8))
>>>              return nfserr_resource;
>>> +     xdr_commit_encode(xdr);
>>>=20
>>> -     *p++ =3D htonl(NFS4_CONTENT_HOLE);
>>> -     p =3D xdr_encode_hyper(p, read->rd_offset);
>>> -     p =3D xdr_encode_hyper(p, count);
>>> +     maxcount =3D min_t(unsigned long, read->rd_length,
>>> +                      (xdr->buf->buflen - xdr->buf->len));
>>>=20
>>> -     *eof =3D (read->rd_offset + count) >=3D f_size;
>>> -     *maxcount =3D min_t(unsigned long, count, *maxcount);
>>> +     nfserr =3D nfsd4_read_plus_readv(resp, read, &maxcount, eof);
>>> +     if (nfserr)
>>> +             return nfserr;
>>> +
>>> +     while (maxcount > 0) {
>>> +             vpage =3D xdr_buf_nth_page_address(xdr->buf, i, &pagelen)=
;
>>> +             pagelen =3D min_t(unsigned int, pagelen, maxcount);
>>> +             if (!vpage || pagelen =3D=3D 0)
>>> +                     break;
>>> +             p =3D memchr_inv(vpage, 0, pagelen);
>>> +             pagetype =3D (p =3D=3D NULL) ? NFS4_CONTENT_HOLE : NFS4_C=
ONTENT_DATA;
>>> +
>>> +             if (pagetype !=3D segment.type || i =3D=3D 0) {
>>> +                     if (likely(i > 0)) {
>>> +                             nfsd4_encode_read_plus_segment(xdr, &segm=
ent,
>>> +                                                           &bufpos, se=
gments);
>>> +                             offset +=3D segment.length;
>>> +                     }
>>> +                     segment.type =3D pagetype;
>>> +                     segment.offset =3D offset;
>>> +                     segment.length =3D pagelen;
>>> +                     segment.page_pos =3D i * PAGE_SIZE;
>>> +             } else
>>> +                     segment.length +=3D pagelen;
>>> +
>>> +             maxcount -=3D pagelen;
>>> +             i++;
>>> +     }
>>> +
>>> +     nfsd4_encode_read_plus_segment(xdr, &segment, &bufpos, segments);
>>> +     xdr_truncate_encode(xdr, bufpos);
>>>      return nfs_ok;
>>> }
>>>=20
>>> @@ -4813,69 +4853,31 @@ static __be32
>>> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>                     struct nfsd4_read *read)
>>> {
>>> -     unsigned long maxcount, count;
>>>      struct xdr_stream *xdr =3D resp->xdr;
>>> -     struct file *file;
>>>      int starting_len =3D xdr->buf->len;
>>> -     int last_segment =3D xdr->buf->len;
>>> -     int segments =3D 0;
>>> -     __be32 *p, tmp;
>>> -     bool is_data;
>>> -     loff_t pos;
>>> +     unsigned int segments =3D 0;
>>>      u32 eof;
>>>=20
>>>      if (nfserr)
>>>              return nfserr;
>>> -     file =3D read->rd_nf->nf_file;
>>>=20
>>>      /* eof flag, segment count */
>>> -     p =3D xdr_reserve_space(xdr, 4 + 4);
>>> -     if (!p)
>>> +     if (!xdr_reserve_space(xdr, 4 + 4))
>>>              return nfserr_resource;
>>>      xdr_commit_encode(xdr);
>>>=20
>>> -     maxcount =3D min_t(unsigned long, read->rd_length,
>>> -                      (xdr->buf->buflen - xdr->buf->len));
>>> -     count    =3D maxcount;
>>> -
>>> -     eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
>>> +     eof =3D read->rd_offset >=3D i_size_read(file_inode(read->rd_nf->=
nf_file));
>>>      if (eof)
>>>              goto out;
>>>=20
>>> -     pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
>>> -     is_data =3D pos > read->rd_offset;
>>> -
>>> -     while (count > 0 && !eof) {
>>> -             maxcount =3D count;
>>> -             if (is_data)
>>> -                     nfserr =3D nfsd4_encode_read_plus_data(resp, read=
, &maxcount, &eof,
>>> -                                             segments =3D=3D 0 ? &pos =
: NULL);
>>> -             else
>>> -                     nfserr =3D nfsd4_encode_read_plus_hole(resp, read=
, &maxcount, &eof);
>>> -             if (nfserr)
>>> -                     goto out;
>>> -             count -=3D maxcount;
>>> -             read->rd_offset +=3D maxcount;
>>> -             is_data =3D !is_data;
>>> -             last_segment =3D xdr->buf->len;
>>> -             segments++;
>>> -     }
>>> -
>>> +     nfserr =3D nfsd4_encode_read_plus_segments(resp, read, &segments,=
 &eof);
>>> out:
>>> -     if (nfserr && segments =3D=3D 0)
>>> +     if (nfserr)
>>>              xdr_truncate_encode(xdr, starting_len);
>>>      else {
>>> -             if (nfserr) {
>>> -                     xdr_truncate_encode(xdr, last_segment);
>>> -                     nfserr =3D nfs_ok;
>>> -                     eof =3D 0;
>>> -             }
>>> -             tmp =3D htonl(eof);
>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, =
4);
>>> -             tmp =3D htonl(segments);
>>> -             write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, =
4);
>>> +             xdr_encode_word(xdr->buf, starting_len,     eof);
>>> +             xdr_encode_word(xdr->buf, starting_len + 4, segments);
>>>      }
>>> -
>>>      return nfserr;
>>> }
>>>=20
>>> --
>>> 2.36.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



