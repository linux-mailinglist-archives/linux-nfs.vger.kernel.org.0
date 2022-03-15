Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F24DA06B
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiCOQvl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCOQvk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:51:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212D517D0
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 09:50:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFRT6E026512;
        Tue, 15 Mar 2022 16:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XH9vrYqiqaqCztirAcCkgYqcI+o7vixftGmxiBwaaDQ=;
 b=ET5Ry2dWSL0+DkrEIofbJKThF1F4ojMJYjCZobh57NLjEt9rHz1uHKhiU2mWy04Iw7Zj
 ka9szGQhMs93eyVmgV4FvMyLkAqjci4tk4KUu9kfJiu0DrOb71IKqAnp/qhgZGVmVyZB
 iIyeVRZG20EifGyZvg5AQLxbpKsz6lwRimUXCMr2nJ8Sv5DFTdtifUqHj15nYAFYN3ai
 YFohDsAKcNVEetFglQVTKeF6+znkEg/A6vCH/nAX6FVNKOftJIHerFRi27spaQ8HSeKT
 W8hV5huBfBaY1YmLC0Z+o7uUEt7D+NnaW1a6nkaOezAkJLmPIzkgbUBWFgdQWnaMkoQ/ eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rks7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:50:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FGlBHb106173;
        Tue, 15 Mar 2022 16:50:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3et657vudc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU8BTtBHyPSeIemymWSw0qKGRE24Sd92dGfReHOWoWP26BYd6UZ30m0V2TqmUEIJiji5W8hwuDzda6hkIGuiM7vMyF33lq+OlCEB0vOAcHTf8ktqDPVuOQJrih3CyWOSyV+QVe/GGkFSqS5dbYdlUSWmZW0l1eRCdH8wefwwvZl0t2XN5wcLHyxyyIMkUExbgnhqi9m0xiyjC0JGbiCXQDVmoMBt3L3rJAa0PaDwjfo6M+0GDPUtsX2h5gEES2hdczuThEhtxs/bAQIkMHdq2qra7FQfQ3AK1AojgujHEUYaVqRAFa/h7rl+cN9eCYD7DFrSurgN32M1WLgElC3JuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH9vrYqiqaqCztirAcCkgYqcI+o7vixftGmxiBwaaDQ=;
 b=P6GPSyaWv9pwbDoN6H6V7WSpLld2lOvmZWik9fGvxn86BYjb57KnjwimPYmzdoHGdIvRRntPlekCNj3vtrVxIqf8tQgPJvwoB8tfHkOofVmabSIwtvqqSqrILGdWJuRYRFrk9XK+ekCxvlDV1LmVI3N7HfYYeqQBrn13EJVd88GiNPMIbXowsNPrToKnRt9OEp5QxW2r9bN95zkN5Ftj19nvgIs4Ip2v4KQapVxThZMxLOcPhNl0O1oZO8jAzwUFO8C+CvOdhjbhYWYvweJX7kl4TF1KrdVF3W4BnErD5fUg2A0RpfWbu1jZVNBpXOwjhdscvVPTh2cmbO7Yo3VgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH9vrYqiqaqCztirAcCkgYqcI+o7vixftGmxiBwaaDQ=;
 b=K8vRO0lvQMqd4gOt71sdW0oMp+K8TASVIPSjrkrEQk0V8XAxjeNcbYMtIMbDIX6+ua7T4dPG2hQhTruXPeCVk9N+YGlDnQblsttvuWXZJhgT7KS/wpnPskMAMIlIWUW/JeFd4EmAXHbGPOUILN0KKObdrPn0JOBm+tPVk8HcgqM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 16:50:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 16:50:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Thread-Topic: [PATCH] NFS: Fix memory allocation in rpc_malloc()
Thread-Index: AQHYOImRcbIFM6tnnUSmsc4OQKLzSqzAqG6A
Date:   Tue, 15 Mar 2022 16:50:19 +0000
Message-ID: <74453705-B296-4992-921B-68D287ECA4D1@oracle.com>
References: <20220315162052.570677-1-trondmy@kernel.org>
In-Reply-To: <20220315162052.570677-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c90ea06-0310-4fd4-2e69-08da06a3e3f7
x-ms-traffictypediagnostic: SJ0PR10MB4544:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB45440EE775A9E335DCF43F9893109@SJ0PR10MB4544.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXqQ40UdOibIG+xvkBTKznBz1+jry80/7AvaaD0DqXAC1TafgP7m3UuUCr+j//qki2kxkWr/6X/MjCa9E6SJP6Kuhr9KCob37J0HiPViJCSbk+nYHi38og9Yn7T2PVxR8gJsDwbN/SgHcSDtON7ASxko0nsyCL52B4mHh98IwI8nx7scUOOrq2SrrL1mLN86Wc8yaq2lIq5HmhC7fwoLKrE6Kc3VrxtA0us4JWYX4ar0Blc4XhPknVLf1ilmjDw6PxfdC00x7fZyw/QDyDwBfQSo+989nbpPRW3vWHcjwJ4fJA+V8IMHm0+Pf7WdxQK6PuQSHSavwsNu1DyC68zWsqjcCtuy1TnYjoxumG+Scf3J/C2gnKcvCQaJyS7lImk3Eki37P8iH7S79xeLt+2Z+YtiC1CR4J57Ifrl3EIOjPtC/OqcBWHEUZMzrrL8ZW78cfdlPsajukTrUxKzkwrVDXHM2y4O/ixaCggQ5HUQKkiJ1YuHBNeIL+N2lZt2AwYoloSEdc+Fpf2Ko+zLyjnR4sF580AIGKZTtKS/3CEiASkVqYvQZM8WTMoNGojsw6yeUxpFTY7Ml9m2u8OM6OoCsVac3vGqOfW8e7v1dqNMupqVgAsBfFVY9JftOnIzkMrey5JLbcF/L6DVLuAit0o6kETeuky+ZNSOmwHykrcCel0lRr97gHsdq3JBHCUMJfBYHd3l6knRZuiwXNxFcObKl0tZ1oiwmSrKoFswynO6ZY4rxF28/kejIUvH7fC7IjLa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(8936002)(71200400001)(38100700002)(64756008)(66476007)(66556008)(53546011)(508600001)(6506007)(186003)(26005)(33656002)(5660300002)(76116006)(66446008)(66946007)(6916009)(122000001)(6486002)(36756003)(6512007)(83380400001)(316002)(91956017)(8676002)(4326008)(38070700005)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uL5XCMEDEVwhvp34MUkfdqXbGJ8ZFkBfvnkzPi51S4+ZwscjuhI4xKAKAAzt?=
 =?us-ascii?Q?VRoFzql/o/DA1ShkvwbWmrZAlljR/W8Xu1pQh1yHnREM3YLEnlVo/B2rrx3r?=
 =?us-ascii?Q?l5ZGzyJ5BOh2Y1/JlJUSMhYIPbPW8eGNYyvEiz14fKnYeAqG12A7QpSPOZaP?=
 =?us-ascii?Q?3EKnM/jd3bam2ZJEnjnn5QbEytoapuwLh2hOUMaPOV3IrmH35btsBFzSprEK?=
 =?us-ascii?Q?PfaSjBYxp3yHdOTYkDnl9zzwB3EOoLgB5vuaA9lFjMahmS7cGrPoP8Hbld5n?=
 =?us-ascii?Q?d2UKBcdWjFLntlc5FxmOrf5A+7+XkFHYcO+0tCgLPmpFYDYx8fxniFDl5nu7?=
 =?us-ascii?Q?yiFj9+GTxZA4pP1+ohmnEmwBzenYIixTR5+f07CSnei4AX0BTkhviSwBBspl?=
 =?us-ascii?Q?vD4DGMzXwtSITYU7gC2WkOq0aYYK1sNjeNY60K9ygfFoa913uFAPqLq7t2uw?=
 =?us-ascii?Q?HRZNu5q+Wh4W+qOT3OcaIcW4quZn34kQe5u8fKXVFV0o/f/0SU959UH7U4RG?=
 =?us-ascii?Q?P4I99iPu6MyflvXkeyV6Yr0jwf3gMIDZDg6BAHhLm05gXGGEgXalkYAZ/XSm?=
 =?us-ascii?Q?HfOi7zD2ml17TizMaMH2QR7XJXRWqiG5ZzdZ81Pm/opgM5fJU5O8JMNBaeJZ?=
 =?us-ascii?Q?fvNSBJuoERqvstuBfGkXvqL4hJXrt0Q9XXC3PMzz32XWh2K8C4+3mri50RsE?=
 =?us-ascii?Q?DtWZwZh2HcNILvJEsdWTEv3YZ+PsF+6nU1AUnt3E67JTbjT4zfvfDTpcfsZn?=
 =?us-ascii?Q?6A7dpQlX/OhtzmUjB1S6VHFJf534vx83oQb4TBmJG8+QjVDIEXdQINTG2zrE?=
 =?us-ascii?Q?OdmnPKW8N/tj3JSuSrAEwyIrxr7Fj4Iho2mbdN2YzzzRuZA1BE7T2psZqdSP?=
 =?us-ascii?Q?TL7OfttsyFIXiT+5TChbQxBmKpwoK3ceiCsHydMqwkEpnjIZwmT+sRT2kyTA?=
 =?us-ascii?Q?8hs+NfV9g5NyZ3GI9Gx7YE0IXUE4A3hNo6Fv0Rv2x7p170k6Thk5wAvnhkgu?=
 =?us-ascii?Q?hrmMXRhfuSedwfvMb3hnqHzi96D9mNVilLXkIggnc9adHvkXAmhrIKrqCprU?=
 =?us-ascii?Q?eZny/01OrNeqyLlbtHqAGHbCnEFv06evgmWSVwSTzHnZ6yBad5/OeBflxhSW?=
 =?us-ascii?Q?dAKyxHGgZ564Ye3MxgGtSprjfOUC1SvZFuNu34tKWAHHiLky3ek7/Zil8ADe?=
 =?us-ascii?Q?O454wNRwdPKwlcvwUhlMUrYSb9OgyImRj7uUr9w7oGMBSudP/mKERHgCT41p?=
 =?us-ascii?Q?KENyINGR9Xmpr9gwmTzs/dsVPDL4J+8WFk+PMMTvG8Fy7c1buA73XL+pMuGk?=
 =?us-ascii?Q?yW3YrSlNJT2rIE/e4067AXH2DVbd70USKmD/eEXaQsrLuN7yJIlBs/rPGi8m?=
 =?us-ascii?Q?kLB0W3dIpvAW6a3skOIWgrAfXawya/eVIkGQkkNBQkkHhYiE1dDimK+ce1HR?=
 =?us-ascii?Q?JJKkcBS2b7AyhVS85De5ocHrbf91k4ek9ibRykn/0V5Vr0RB8ieM9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3DC9266D929A4409903885856B75CA9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c90ea06-0310-4fd4-2e69-08da06a3e3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 16:50:19.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WCYWMJwUkx8YlRGEli+6o8/L3p7PkEE5CvN53J5WjpSIpDbMyjDHTb9UA41z0nKhIdxagNfjf1G3bQICCkKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150104
X-Proofpoint-ORIG-GUID: VOi2j0bV974Y_6eWdDPn75CjyKu8DI5T
X-Proofpoint-GUID: VOi2j0bV974Y_6eWdDPn75CjyKu8DI5T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 15, 2022, at 12:20 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> When allocating memory, it should be safe to always use GFP_KERNEL,
> since both swap tasks and asynchronous tasks will regulate the
> allocation mode through the struct task flags.

Is a similar change necessary in xprt_rdma_allocate() ?


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/sched.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 7c8f87ebdbc0..c62fcacf7366 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -1030,16 +1030,12 @@ int rpc_malloc(struct rpc_task *task)
> 	struct rpc_rqst *rqst =3D task->tk_rqstp;
> 	size_t size =3D rqst->rq_callsize + rqst->rq_rcvsize;
> 	struct rpc_buffer *buf;
> -	gfp_t gfp =3D GFP_KERNEL;
> -
> -	if (RPC_IS_ASYNC(task))
> -		gfp =3D GFP_NOWAIT | __GFP_NOWARN;
>=20
> 	size +=3D sizeof(struct rpc_buffer);
> 	if (size <=3D RPC_BUFFER_MAXSIZE)
> -		buf =3D mempool_alloc(rpc_buffer_mempool, gfp);
> +		buf =3D mempool_alloc(rpc_buffer_mempool, GFP_KERNEL);
> 	else
> -		buf =3D kmalloc(size, gfp);
> +		buf =3D kmalloc(size, GFP_KERNEL);
>=20
> 	if (!buf)
> 		return -ENOMEM;
> --=20
> 2.35.1
>=20

--
Chuck Lever



