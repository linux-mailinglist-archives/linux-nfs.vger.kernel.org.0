Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE05800D7
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiGYOgu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiGYOgt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 10:36:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63BDE89
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 07:36:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PEQG1T000329;
        Mon, 25 Jul 2022 14:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UTK+ROd4ZDX8znjk1hPrdO+yXNL2oJj8zb+PYBpSjxU=;
 b=unKACLY+lsleyTnv89i8JMSI8j7Km2s3Eyz+Ku10CSVci9GWGAWckLEHj5+TDmU0F/6R
 IstO2N6EPqPco/RbE1YZXWivLGAaW5LretK3ylTPPXToPnlLsBfIo3xvSPOhLXHnz50m
 PHlauBJBOpBaMoNi/tQIyLd/ghTeyROnu9iMpqpr0JnU8AvRiRQ2ZK2DI6K84nJ0TPCD
 h8mxOIKr4VEYXfEAHtaQ4j+9vj+bBg/wKrkbsGD7PwTqYOpK8f16L16XgiEMaQnvCiSN
 nITEbcxmyKAQVyDZM7hvuJpnhX0GRzFzd6SzwoxGnNLyb01mHg1lGwvdYbMlHFmp31BP mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anue4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 14:36:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PCTl3M017699;
        Mon, 25 Jul 2022 14:36:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64ya6pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 14:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRJJuCdM97Vc+xsvS1Nwb7WHE4eTtdxp9KYydBq0M8zlI194AyuoaOqkAyxj7Xh8n2SK4I9rf5h6hoRBAMd+YCXzRHYpQi7UmOa9DXEMNe9VMatkSgCNYmqNssWpHYw2UYmhBmhbV6/I7OxpIzLJa0GbWAsfHtV/vFiUwpjZcfUp99Q22DJulwM31rRkiIuRav0cN5xPUVX0sGcyeW4hqwPVixwvDNTUB4GA9EnCZBTtOuGjhREoqLyNb6Ow4LKWwEdjraLJwRIeokTof/Bqbn20vPRRCYJMKIrj4OC7xroEQsQMmqEROI9zgnR+KvCRtKumZuTVxrJLl5DsIRTNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTK+ROd4ZDX8znjk1hPrdO+yXNL2oJj8zb+PYBpSjxU=;
 b=Vv66dJUrIkz4SqjKzgYgqgx/8oANyh4CCW72MuwIa4QXq6dX59TUwbNgkaJ9PM9VRql1WgkdTEGqMzhRb8EKZQ6xxcnfWzij5R47dPONnGxc9gNMljf09BV6rs6RnYQ6pkEXek29BM37Qkm5Zs9vi4swMun0AlQ6A9XWgDLIrfz+jLHzL58cM5yNy6VZHo3Q19N66A2rCmXQQfvfka/mSdGg3wqBreICRSjF+eeTuFVICKfvzZgGNZvLAHdeRnFrCq0Hj2KCPqY+OggQNWaaxo33NSOGWON25kcwo86WNF59K38XxqHnnPwPOSlNM+RLGwf1x8/GgmEno96hnSAOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTK+ROd4ZDX8znjk1hPrdO+yXNL2oJj8zb+PYBpSjxU=;
 b=CyhLNOpyNwRq1DnmnDVLOp4nOBouD3yxuvabdziJYDQlionn9OuXO30saPW7KeW+Q4eaNN/1yCdUMq/w7hOeFQHre0GxqaZCpe7ZgkRwwmDBlUDllJY14SR77QHfyFXMlX/QILYmX3/9HxXmve8ww0uZ2d5sAjt9PiaRksvXHSA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4877.namprd10.prod.outlook.com (2603:10b6:5:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 14:36:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:36:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 01/11] NFSD: Shrink size of struct nfsd4_copy_notify
Thread-Topic: [PATCH v1 01/11] NFSD: Shrink size of struct nfsd4_copy_notify
Thread-Index: AQHYnghOCs6Zc5YR5EaPT+TIGcVtGK2PJw6AgAAExAA=
Date:   Mon, 25 Jul 2022 14:36:36 +0000
Message-ID: <92DBE2E3-ACA3-4EBF-9975-E561696CF15F@oracle.com>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
 <165852114280.11403.7277687995924103645.stgit@manet.1015granger.net>
 <CAN-5tyGJFpBum6ZtO=9r0o7yNf1tsgNSEZBPJWj_qJUyLNtBWQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGJFpBum6ZtO=9r0o7yNf1tsgNSEZBPJWj_qJUyLNtBWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80e4ca4d-a475-43dd-edc9-08da6e4b1460
x-ms-traffictypediagnostic: DS7PR10MB4877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPcvXW1EVmAKfQCCNyqIHn7nkGr68LvCjwXWGChinYWztbgH4ezbo028NMOwpH5CuLxjpTy2FqqgvBKVTS4gdr8A1InQchMBg7SZhcWquNOFFyNhM0V3QH7pxXJLp+pI9t0gRqNZPKzh4DyoVnPYBBIIB3LR/QZcff4LSK4TUh+GE7ohaylhnUpEK/9hdHExh4oXa2duA2kCyHsrs/Modzkjf1qEMWJSp5qpJr0/ooKUjLCcRaIr26lnl69Ja000acpLgHf0DQlCw/AXDNRLEIVffPehbg+VzJwiH6u8UowDL4qzHdW0OuGjDJQWManKVIrwQO8Ou01om+7V2r8F474w32GWh3Jkw4f/mvm5OWaMsCz/77yyjc/LOdnqRtUtSRdRMXCb+4hFLxdIzBuuwp5FgDUvZnkvCM91xku3rytljWlpxhPa7WvbqFphbXfgZGzGHu9maQS24/S//mTld21rG5NytpLikYiFkYg2Vtgtl8Rqz4GjVtfRYXVjeL1VzUvupdgkRLnxBaY87lGthTEsVe1luHbQ1oxHAyLcdQz4Cazkro09Ynqt2hL/Q0MQSWNbZn3jZk9PyfDIbVHAb44Vjl5EcD+R01NNWT/t3Pmf5lBWObO2KatVaPfNzjLaqvHWVY/zPyD3H3/FO0VCrEjrH66WxN7WrnMo/k4vJa1etClekknDDjbmxT4NT/TPBqlEejdI8UyBJdq6aV/2pvVQYQPGI6aPzlKEhyZvqwudj0oiKEm29XheoJ7ePeWHVV7MCeMHw+Zz+meZH4SW+REdhWmRFfCA2wBtTsCFpBFuXBadnT7Nq7UEHbGasf7YC1e+8N8RR++e9HdiBuL3pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(396003)(136003)(346002)(38100700002)(86362001)(38070700005)(122000001)(8936002)(186003)(83380400001)(2616005)(5660300002)(66556008)(64756008)(66446008)(66476007)(478600001)(33656002)(2906002)(66946007)(41300700001)(6486002)(6512007)(8676002)(91956017)(76116006)(4326008)(71200400001)(316002)(53546011)(6916009)(6506007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?etjLCSrhUsWyPWYyo/NZU4l3k9PxuEhkfa+KRqrZB2dbdlu3s8kqBaOPfauV?=
 =?us-ascii?Q?z8Re6uZIQTjL5uN8Dk2ExKOc6z+Jq733XEqhW5i0UepDwi9G2d9A0Fd6rAGR?=
 =?us-ascii?Q?k0uc09jz09FHLXXkpTWwDIro7BNGu0zX7fiQ5y72W9W08C8SdEQarxUY0nW/?=
 =?us-ascii?Q?PUwizcXdwWDw+S72FKvdtD5EBxrs0QetSamz3KBqRBBfRhhE2/w6vCjmbO7h?=
 =?us-ascii?Q?WmIooF2wdSzj4FiKNTqosR8h45xHo2RClbiyepy6gnjQIX3xEJ9yKIPpt6Cn?=
 =?us-ascii?Q?NlFFjkWPdCYgskcuhTtbIeYhHjq0JnrdxLQHQI4ld9YuCVRzLWX9mhU1JbDp?=
 =?us-ascii?Q?Oh4Oqlegsc09aGugBhepBnmowawg32zZavkuQDETXJgPNs2eKxnGrfI04+nU?=
 =?us-ascii?Q?B95kr/UZItLmUsJQ/PxThD90rz6tpRpcBmbfuc+DDuD2mLaVaZwsWsvsJ+yZ?=
 =?us-ascii?Q?Ds19/eyUnTAVTCa1oJSbIJ1Q6yBm6221qj705pVBQGhFTRliRiaScFz6LrYQ?=
 =?us-ascii?Q?ABDFHo4ILAYDKPeb+j7a7LnOMT3UBD4n9iYjFGULMzU5rfvryqeIQlrb8tTi?=
 =?us-ascii?Q?sSLaX7nz/TQSamxUC+jJPH/H/Nk8HA/6jDoK5AAFD1MtWZCIvUgA6CORshg4?=
 =?us-ascii?Q?rKTeU/KlPyRqs0AcHLuTEtF11oJKSJvCadl/hf3K5ROCGIoyoY5/flT+9suJ?=
 =?us-ascii?Q?vXOQdcD2DFXSyzjsfLhRvthPKhKqkWkUZw+6fX3aWW8gcTEu0fZ0VQJOB5kQ?=
 =?us-ascii?Q?h8+qkO4dahTnOZeUxLI6+3Vn9t2n9Z/oVHRUd3DzanGZUy9s9wKOMmTZLTwV?=
 =?us-ascii?Q?qRsFbzoju+h/wFiCIQFO1pPM++5W9aO2GQSyZaTxe/D/fQM/Pd6w+xYyKmPa?=
 =?us-ascii?Q?s8HffzGhImFKdikE+xTc2l4j1TJVzWhZrnXncybCViqiB9TyJjYK2oYOv7gJ?=
 =?us-ascii?Q?1uF+doHu5gngvgUKNr67jwZSmEawNNAHOS9bH6SHe+DV6Ti4B2LBnp3Mt8OV?=
 =?us-ascii?Q?8P+NKdU1XBTuSskNv80YpS3QCEyohK967b9njjLiHiRuGL5sBSWrbFbS+iTl?=
 =?us-ascii?Q?2WQlAD9f8lOBMcPkM26hdmZiA4OrDxbYip7NFaTVADT5GxuE/S1hGTHyJ1G1?=
 =?us-ascii?Q?gc9U+qtW4mqc7PcUpO6Ja/Xz4i/OmhRBxDwL/0Bi4wStspxpneZ45ugq3UFC?=
 =?us-ascii?Q?4K018UfWJH4qaabmlCHqcuEBNo6O3LavW1zGwJqT+PFFCNNi/j3q4R8Bksoh?=
 =?us-ascii?Q?ZESBYSVkBnhdR8GPRIW9EOafV6ZrqccgIovha3gO1JxpAqrTNQPo3m4YwgDV?=
 =?us-ascii?Q?JB0KExATq+f/CF3NI5I4zZcVduif7ZuYI5Y/24wn6/esszgokg8G9+Po7Knh?=
 =?us-ascii?Q?zC3uYK/+amSnlOG/0sqZ9O2quORtHYE/Yt6kW+rC/wDkLTOdf/HEyR0hcxUY?=
 =?us-ascii?Q?mulvmy3iIGGu8rkAslnfoIDbovi0HznfuxgPygR6Iz7LWdMmc2MfCAB/tt9V?=
 =?us-ascii?Q?PoiltB49J5LqXh3ludiVfDMgkWUpT7wscR+bXPxdZxVeSxkiva7l/z8NQ2dc?=
 =?us-ascii?Q?L6DQz4G+qvVXTVbOR+vxZYeFsjP4lmtYncLsJevjBBQa0WG/dr2AQanB72Aj?=
 =?us-ascii?Q?tnANg0Y+vSbuTODoi2d4ZgsZRUO+BwPzBcBm04ymGvXnoreEWeHHRdfGeOgF?=
 =?us-ascii?Q?tAxi7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <467C1C8FE242CF498F63CD59FEAE95C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e4ca4d-a475-43dd-edc9-08da6e4b1460
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 14:36:36.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjqZXsmWMJUrhOo8ePGpTC+JIl4bHhtTjfZcCmfJ88zEG+8uin8bZ775sdQvtPI+MOUtnxZ6TBXw56pe2pCm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_09,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250060
X-Proofpoint-ORIG-GUID: GLsyRNSeThKzWXoC5ljhLWnPupOspDxF
X-Proofpoint-GUID: GLsyRNSeThKzWXoC5ljhLWnPupOspDxF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 25, 2022, at 10:19 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Hi Chuck,
>=20
> A general question: what's the rule for deciding whether to allocate
> statically or dynamically? I thought that "small" structures it's
> better to preallocate (statically) for performance reasons. Or is the
> idea here that copy_notify/copy are rare operations that instead they
> should be allocated dynamically and so that other operations doesn't
> consume more memory in nfsd4_op structure?

tl;dr: the latter. But it's not an issue of memory consumption, it's
that this whole struct is cleared with memset(0) for each incoming
RPC.

nfsd4_op is a union -- it takes the size of the largest args struct
in that union. Before copy offload was introduced, that was about
250 bytes. After, it is ~10x larger.

There are 8 nfsd4_op structs in an array in nfsd4_compoundargs.

The nfsd4_compoundargs structure is cleared by
svc_generic_init_request() before each NFSv4 RPC is executed.

So, in this case, the problem is 8 x 2KB =3D ~17KB to clear on
each RPC call for an operation that is quite infrequently
requested.

In NFSD, typically the execution context is amenable to GFP_KERNEL,
so it's generally OK to allocate dynamically for infrequently
requested operations.


--
Chuck Lever



