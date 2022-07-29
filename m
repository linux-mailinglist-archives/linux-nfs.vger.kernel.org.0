Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76045854B2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiG2Rqy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiG2Rqw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 13:46:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73C384EF3
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 10:46:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THcH22020928;
        Fri, 29 Jul 2022 17:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xECCYoMTkwEcnyG2DHcsBPBXccIjnvxgT5pEovOEFZs=;
 b=eYQ1/QjPfKzrQolmNAcz2FVT4MuP7K16cCiRH48/I8qRk13GpEvk9m3fjpHdCni3hPnM
 fzRCbqjVJgz/1yMhBBPFE1cb6RG+MLZRENFlHkUaBbMEUEELd7mr3IIcbovYKOTIwalu
 slDjRLw1Qjt14Hl3+fUY/DzgWfZYeL+dW8mBYE2N/0bgzDvf95NJWO7CMYTGmxwAn8hC
 5gkmrRhTMfaKpm2476Emru3Xs7hPSG7c+eBoub55/a43FuDOKZX4z8QGPS30Xn5Cg2iZ
 XNhX/G9/Bp2PhE2vsVFyoKMxB/D462dBwBtqVgz9/wJqZTSf4tOpAL0wEnibYN7Aghg0 FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gqum6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:46:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TFB6ms009109;
        Fri, 29 Jul 2022 17:46:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hm888s380-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 17:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbKhY1pGh9EhRBA/R7I4IFHjVGLJeRtDUsC6T5EF6uigblF/qhoaUKTKs3cr6EYDkgR7fJWzMyuCt73vbdHXiYSTGBhKFzLGJ4abQ9tVZCm6pxEZvZrqgSZbuuArjmQ68a0BjbDG4PK367l03QBJ2w4WPdGos/RRoP8nTdOuE0cv0YiNkpRHvfA4C8tUb7g4X0H2Tli5Gfk+3WFy4V70GlMOLIebgbzFOnNnDXkKPLsozTW+Sq21bELzB4vOu+lSBjlN9LlDVvnc8uJaM7JW1ntAST5bqW8VWNk9c0OBf41NST6PIldyPK9DjQtvXexRsdRPwGlKtjNa1ZOtdS+0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xECCYoMTkwEcnyG2DHcsBPBXccIjnvxgT5pEovOEFZs=;
 b=KMqz/AV/udsWaxJLblEtWe/5IxEz3zhlxzMp85wntB9WVWgxmHMyzVeo4QdbBYxo3wZvVj1QjFvEBbvNeT7Vi6rxfB/L2TnJ+2wzdbBa2tNwr3jhnjWacLFqldVFdduxt7B6GWjWsE2y60BTYk3FK2GRpjodxYYrc6afu8baDex9yRE2AqCiU3+ILNkpgAVUs5FIkeEVnsOSl6NVSdXqFetkwPYCfnmA18donbqJhp9PPbpnJDhOuZYLv32E2mqdJoOtQUWvV4CjcF8Y1GH1VaBy3HHQsy5br7s+NEEbgOrrAqr+UhYhrmh/BCAuiTSPXh0ouegRGh0G7CTocDwkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xECCYoMTkwEcnyG2DHcsBPBXccIjnvxgT5pEovOEFZs=;
 b=L/KB0HESQEc3Tnrmi0xiehnr4XuxeZ//IuCHC36Uf3+EAmmXZW2QWZrsFFqtDQ4PTRzwQnuTcNdGoR5IEJZ6lCkBJZZjWGQVYQS0XBMZk6Irk42yu2VZwJ0tE3uxPXZ27Yac32ubtdJW11GdxTb6wQiH1fxbFTMw/TZgm1WRPR0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5279.namprd10.prod.outlook.com (2603:10b6:5:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 17:46:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 17:46:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Topic: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Index: AQHYo2rgY8a6WWViM0iW0L8RSDO/l62VmE8AgAAD4gCAAANOAA==
Date:   Fri, 29 Jul 2022 17:46:44 +0000
Message-ID: <84AC7FA4-9DED-4435-8504-310F6F41C130@oracle.com>
References: <20220729164715.75702-1-jlayton@kernel.org>
 <20220729164715.75702-3-jlayton@kernel.org>
 <5B5182C2-2B5D-4863-A6A4-8F3A6098A9AC@oracle.com>
 <de316707b0bb7e73d16acf717253367578e7f05d.camel@kernel.org>
In-Reply-To: <de316707b0bb7e73d16acf717253367578e7f05d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30f2e6c-df32-4957-2c4a-08da718a4db3
x-ms-traffictypediagnostic: DS7PR10MB5279:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjGWaYqks/DJ/xjnmVmUtZLFZ8swb7xaGNPqN0AxJ50XoVvvLfK2L713rVTrSMUYcV8JjhpuqXMTVURey28Q+UxhBi9eHHxyGhtgfcX2abH1TM7ASE+/tGPCBHFkntw1aoP8nOwekkaPZu1APs7Td3EaQLg+IpTBOmTMFJiThj9CbCovp7P4ZfSLQsOSlfwB5jiAUAa6BVIRVqgNHHhsLllX2G/gFIvHSr4b1IRJGD1Vi+5Dozj2ePr62vZ18rwfNebXnSrNA7kbIpYkl/kS8QIzs9kHVcLHmaUfY6TldNC/nazHGSiiw/noSea34U6Fuqyve/VckhjCRqEHFDZf3CspNDwTIijl642QHOa/Jiwq6Rki/YeUIJyokfngjozazI6tvU16ICzhPxKK2YekZHZ/9rLNy6g7qRIzaxNzNAbHPRW8CUKhY5YqVKQfuMTRnsTbVyGo6thX6S/2Z9KrMZFfyPx1b+k/G/aiEFxDsg4N4t4irCjO7ajOu4z+oT/r8Uz/OWRAkoJQnXfJdzdkDqEdE8rEYi4+m/opwHoJtU4C++nV+c5gQeEaiexuy0hP8ZW3Ua+ShEJX5p8IsFgMH1O5729qLDe7o48y5qrTWv/MF94+5iDeUz7HVyy5xuuEc4xFhVbwlyIo6piU25EOV8K9e+jXC1hsorQQvfbGeb6bOVG/eWUVVGPEcwM72+7VD94VdXDsQvVJjV7/ir1KOnH+PiRaUDeA+kpv5FZIqsgOj/Ix0mdn2Qp5PzuRsXUHzLzAsC0MmH9fLsXikC1jAFXaD4I2zyZses8CrHVaLMbwY7TH0sgBgLpMuIHRwe8wQwQ+f/OgodFRHpqPiVb7H52AYXrrLUJTH5S36i/dNGomFhyHRGIuGrSfna4KysgI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(376002)(346002)(478600001)(83380400001)(6506007)(71200400001)(966005)(53546011)(2616005)(41300700001)(6486002)(186003)(26005)(6512007)(2906002)(8936002)(5660300002)(54906003)(66446008)(66556008)(76116006)(91956017)(66946007)(64756008)(66476007)(4326008)(8676002)(316002)(122000001)(33656002)(38100700002)(86362001)(36756003)(6916009)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07H9qN/s3K7K5oT1kTMx9lZVksRdnhf+CqE3g66kS4MxzGmISrDoJHynjn8c?=
 =?us-ascii?Q?VE6QsKxZVgZSklHfLW+yrVMMCm0kF12NIke/m7a0qjSeGrzPNhsEl7pqrAue?=
 =?us-ascii?Q?mH0Not+4hLNcJL+PJt0QvTlPhTAhCKC/z0eJs54cpUlRLiTX5LO2wzVs+2AL?=
 =?us-ascii?Q?W55kH+H2drElLBGAm5ztSRtAA8yWtsYI61cVPD1AHZ9k787e6QoU3NFt8zGw?=
 =?us-ascii?Q?F0uJwyDQaRFjLcaqc47Q3Ohwd2Jpm4iVo+Op+UZ686GJFIOjv1GLoF1e6qNw?=
 =?us-ascii?Q?YmtTunsogCDcT5VwJLVWb2xavL2VtJNX8IueMoap5egyVRdI+Vu76NjMtyXZ?=
 =?us-ascii?Q?oJvTD1IaZGe0AkkZhNh0kqeCEUxWt6gRvpI19sq4ZZo3ayrOwCNJ2r7XMLXd?=
 =?us-ascii?Q?ZMCbcFEY3nP8sLpNSYCgnXr/57BIED+Uiv+7nZxcbdmihbRXHHSi8NEGtKeC?=
 =?us-ascii?Q?eU8uR7uHZLLVd15lX0ykp4+6HpsZu8JgiFhT+9oNgEH6mR4eG9T+8KMmq4pq?=
 =?us-ascii?Q?E8GaVJhZOlN/9gUc4d/wY8pT/YY36ujCS5Qbb6yASgU+3sOLjaB0CWwzRMN0?=
 =?us-ascii?Q?ByP7X1jfH1qHwZQXM56F3BVz4Fc1vGIqSjTJnah0P4iQKmVvHiWwkDLWZvUb?=
 =?us-ascii?Q?El7gywKL+4/XmFMU+8+8dvAonfg2eOM6Q3zNv9HW3blzdaPB4onHJHDyM/a7?=
 =?us-ascii?Q?OV3SHnMkdaCKvPE0IchC9IDwCtNnGqWJ/gTiZkZhdcBgXVyvWSLwNeIa4Tyj?=
 =?us-ascii?Q?n+yH7tNCXIjWCuXOIA8vDBBKptAFsN5SkMcHkjsFiQQ1gXzYaNL5ZgR91Nt4?=
 =?us-ascii?Q?tyZIO5rWBQQ3OpL8ZnLEuOPyC5PP5G8rKtDZoMFby8/tjZwXUB1Zjv2Wdi4/?=
 =?us-ascii?Q?6097Kz8KaMqF63WVY3v6oa97cb2rS3mlpiF6a54Lc/FmOW6YmR3/dSOXH3nJ?=
 =?us-ascii?Q?hFEN1Jjhr9f8kpTwIb6i9n/F69n6v1NKuC6YSTANmWEao+5z8TPEZFAn0UKf?=
 =?us-ascii?Q?eccTiFmD6iY8+Frqh/feL8j+WXoUvIYAlzTpWc/GBdulxluqujtWz9jWPnbG?=
 =?us-ascii?Q?XS7m/+75dztxfCRM58nAXmd59AJy1b+X0/03K3Dgo8nsmJfMB+l0j/HR74M0?=
 =?us-ascii?Q?sXCK2H/UOqAHO6LhulBqBRbfm2RujeVFSZJLWpT3tTe6J7Jsg+xrGHnPl02y?=
 =?us-ascii?Q?Gjs51g0kLB4iNSuOThwXDmK3dhX2kEon8HH34scuV8X/Ji37/yvhpw5YBVK3?=
 =?us-ascii?Q?rh14kjvuDsMpzgC/hzlqahcAFr3sFEE8roRDhloPYMobQPdQWHKBFTDokSPj?=
 =?us-ascii?Q?OHRfAFmAPhdGtPYAcEQbsOIfho5L7BRXj+QRIL0UF6FNHPF5N7Old+51pGGT?=
 =?us-ascii?Q?wM5hDyZcWEoxBH8k+/xoZmxzwuHiGcmyKoCF307rb1tVGJaaTA3Kno6w3xHG?=
 =?us-ascii?Q?BpgVOw9UDSLldiz0EHOcS4FmwSy9X01lW+IQBguzmoKCidWCqNynSHMrfRq/?=
 =?us-ascii?Q?XWIvzAO2OGhmgdATgwldVRD8xWOyX+BIeod+AcJD8EFz9HEZaK4y6AK3SbQb?=
 =?us-ascii?Q?Ct5CuPz/y7epEdxYPY5UDM+3dp6rD8wOCBR9Ufce8DhxSDBzZfoxrc+anpxt?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FD76AE47699754899DBA3A6ABDD99B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f2e6c-df32-4957-2c4a-08da718a4db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 17:46:44.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtRgGf2fi40jmx6fuCJkWqdNzLg9dafg6AcFvJRL2PnCxR41uXxxffKMbk2Ryp7RBRKq9VjlpjTgSHVoacRxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_18,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290075
X-Proofpoint-GUID: XH7kD5NhsLwtDlJ7S0z9K_TsHZ8hwxZG
X-Proofpoint-ORIG-GUID: XH7kD5NhsLwtDlJ7S0z9K_TsHZ8hwxZG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2022, at 1:34 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-07-29 at 17:21 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 29, 2022, at 12:47 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> We had a report from the spring Bake-a-thon of data corruption in some
>>> nfstest_interop tests. Looking at the traces showed the NFS server
>>> allowing a v3 WRITE to proceed while a read delegation was still
>>> outstanding.
>>>=20
>>> Currently, we only set NFSD_FILE_BREAK_* flags if
>>> NFSD_MAY_NOT_BREAK_LEASE was set when we call nfsd_file_alloc.
>>> NFSD_MAY_NOT_BREAK_LEASE was intended to be set when finding files for
>>> COMMIT ops, where we need a writeable filehandle but don't need to
>>> break read leases.
>>>=20
>>> It doesn't make any sense to consult that flag when allocating a file
>>> since the file may be used on subsequent calls where we do want to brea=
k
>>> the lease (and the usage of it here seems to be reverse from what it
>>> should be anyway).
>>>=20
>>> Also, after calling nfsd_open_break_lease, we don't want to clear the
>>> BREAK_* bits. A lease could end up being set on it later (more than
>>> once) and we need to be able to break those leases as well.
>>>=20
>>> This means that the NFSD_FILE_BREAK_* flags now just mirror
>>> NFSD_MAY_{READ,WRITE} flags, so there's no need for them at all. Just
>>> drop those flags and unconditionally call nfsd_open_break_lease every
>>> time.
>>>=20
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107360
>>> Fixes: 65294c1f2c5e (nfsd: add a new struct file caching facility to nf=
sd)
>>> Reported-by: Olga Kornieskaia <kolga@netapp.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> I'm going to go out on a limb and predict this will conflict
>> heavily with the filecache overhaul patches I have queued for
>> next. :-)
>>=20
>> Do you believe this is something that urgently needs to be
>> backported to stable kernels, or can it be rebased on top of
>> the filecache overhaul work?
>>=20
>>=20
>=20
> I based this on top of your for-next branch and I think the filecache is
> already in there.
>=20
> It's a pretty nasty bug that we probably will want backported, so it
> might make sense to respin this on top of mainline and put it in ahead
> of the filecache overhaul.

I am a generally a proponent of enabling fix backports.

I encourage you to test the respin on 5.19 and 5.18 at least
because the moment that patch hits upstream, Sasha and Greg
will pull it into stable. I don't relish the idea of having
to fix the fix, if you catch my drift.

And perhaps when you repost, the fix should be reordered
before the patches that add the tracepoints.


> Thoughts?

Rebasing all that is mechanically straightforward to do.

The only issue is that the filecache work and the first PR
tag is already in my for-next branch. If you don't think it
will trigger massive heartburn for Linus and Stephen, I can
pull that stuff out now, and postpone my first PR until the
second week of the merge window.


>>> ---
>>> fs/nfsd/filecache.c | 26 +++-----------------------
>>> fs/nfsd/filecache.h |  4 +---
>>> fs/nfsd/trace.h     |  2 --
>>> 3 files changed, 4 insertions(+), 28 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 4758c2a3fcf8..7e566ddca388 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -283,7 +283,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf,=
 struct inode *inode)
>>> }
>>>=20
>>> static struct nfsd_file *
>>> -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
>>> +nfsd_file_alloc(struct nfsd_file_lookup_key *key)
>>> {
>>> 	struct nfsd_file *nf;
>>>=20
>>> @@ -301,12 +301,6 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, =
unsigned int may)
>>> 		/* nf_ref is pre-incremented for hash table */
>>> 		refcount_set(&nf->nf_ref, 2);
>>> 		nf->nf_may =3D key->need;
>>> -		if (may & NFSD_MAY_NOT_BREAK_LEASE) {
>>> -			if (may & NFSD_MAY_WRITE)
>>> -				__set_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags);
>>> -			if (may & NFSD_MAY_READ)
>>> -				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
>>> -		}
>>> 		nf->nf_mark =3D NULL;
>>> 	}
>>> 	return nf;
>>> @@ -1090,7 +1084,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> 	if (nf)
>>> 		goto wait_for_construction;
>>>=20
>>> -	new =3D nfsd_file_alloc(&key, may_flags);
>>> +	new =3D nfsd_file_alloc(&key);
>>> 	if (!new) {
>>> 		status =3D nfserr_jukebox;
>>> 		goto out_status;
>>> @@ -1130,21 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>> 	nfsd_file_lru_remove(nf);
>>> 	this_cpu_inc(nfsd_file_cache_hits);
>>>=20
>>> -	if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
>>> -		bool write =3D (may_flags & NFSD_MAY_WRITE);
>>> -
>>> -		if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
>>> -		    (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
>>> -			status =3D nfserrno(nfsd_open_break_lease(
>>> -					file_inode(nf->nf_file), may_flags));
>>> -			if (status =3D=3D nfs_ok) {
>>> -				clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
>>> -				if (write)
>>> -					clear_bit(NFSD_FILE_BREAK_WRITE,
>>> -						  &nf->nf_flags);
>>> -			}
>>> -		}
>>> -	}
>>> +	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), ma=
y_flags));
>>> out:
>>> 	if (status =3D=3D nfs_ok) {
>>> 		if (open)
>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>> index d534b76cb65b..8e8c0c47d67d 100644
>>> --- a/fs/nfsd/filecache.h
>>> +++ b/fs/nfsd/filecache.h
>>> @@ -37,9 +37,7 @@ struct nfsd_file {
>>> 	struct net		*nf_net;
>>> #define NFSD_FILE_HASHED	(0)
>>> #define NFSD_FILE_PENDING	(1)
>>> -#define NFSD_FILE_BREAK_READ	(2)
>>> -#define NFSD_FILE_BREAK_WRITE	(3)
>>> -#define NFSD_FILE_REFERENCED	(4)
>>> +#define NFSD_FILE_REFERENCED	(2)
>>> 	unsigned long		nf_flags;
>>> 	struct inode		*nf_inode;	/* don't deref */
>>> 	refcount_t		nf_ref;
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index e9c5d0f56977..2bd867a96eba 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -758,8 +758,6 @@ DEFINE_CLID_EVENT(confirmed_r);
>>> 	__print_flags(val, "|",						\
>>> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>>> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>>> -		{ 1 << NFSD_FILE_BREAK_READ,	"BREAK_READ" },		\
>>> -		{ 1 << NFSD_FILE_BREAK_WRITE,	"BREAK_WRITE" },	\
>>> 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>>>=20
>>> DECLARE_EVENT_CLASS(nfsd_file_class,
>>> --=20
>>> 2.37.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



