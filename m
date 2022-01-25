Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE449BC1A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiAYTaK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:30:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbiAYTaJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:30:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJCSJe024955;
        Tue, 25 Jan 2022 19:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dfTWMnh4+4PsbvUwmV+Ewa0gMbnbuass7KI4L6xALqw=;
 b=Ha3i9d0D3L7SS5TV8mc+7jFdpYa3LFmo6u3TwDRAVBKXGUkqqDxPR3+i3CoY09YZmuZj
 VBVJY6qlzXUBgg2xz1xckaKOcal9fQ4jcCDFhEKDdd8jgX6e7zOTbHC49ilQ+5otXTtp
 OaBy1IqUqh0T+B7LdMKFMj0Svv/72ynNz4aC2ZCFAEP5DvaJi+hlZWoYy4OM1AQ0v8Og
 17MhwhlYEY4PWjV9f7m9eYpYOBZ1RmXmNEKGnIELPKNJlDsZPM4yZj0/Zgk+dUKLcAls
 jUg9S1t7SfYgjTDPDkNS0OM42WjIDb1lY81/LRx/fOhCxmhxh/H38IyX/zrZ8ICvhw2D rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7av74u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 19:30:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PJGm4I127568;
        Tue, 25 Jan 2022 19:30:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3dtax73r05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 19:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUQ7dBN+DDfuiybos/DkbOBIkOpsGE+VGyw2WAKwgddcT4/F3IbDfO0C19xgdWznJ4q7nKvfwlTuUSN6u7h4zcQRdslDSvYHILURa1xMCFdNUjbA3sMrUBB8Yz0MjpntS1m+DfKoYxz8t89mc0rYd6Y31u21yNYcItC7ohF4mbhIoa2Q4xa81h+BhEJETQFqplj8gyppU1NnGl+1As0tch+PuPNS9R2dyCrCznKuPnAN+1RS9liTcjhyijJCd/ktN4/T2NIzNnxk9hXQMnMEblubQVq4Ts35wsFNm1ZlLYR6nXWfgmEL7+77h1MoI4G2uymzbe2OFr1vKa27nyUWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfTWMnh4+4PsbvUwmV+Ewa0gMbnbuass7KI4L6xALqw=;
 b=idaZ8stH3gDCJV0gEHV8om/lxHmNgv5GRROrIYxlH9kDy5RqKCS95XOy4/H236tpEN8Pq5PNUZb8p8fGjyZksGrAXXuu2I2Did8sAVBmXZzCA4tQ7RToXy2VsK2hYYmuXHtM5o+y3zW86z8gqXxL2srV+6iFo44xJi3yvZaIDjrULx1c7RsfRvDS0wGIJPjELvIbew6G0c2brnRfWAge/aOMKxRatkyZXzT/6uYxcdadYbcpmkRHjTiZMCOfHgZ6X6gr0N+iEzDO7rW+g0jDm0x0v5nNXLXainfyHLpWIAF1aV2884my5pCbsITqIlndkCGYGn3MRR+0o7wR20gyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfTWMnh4+4PsbvUwmV+Ewa0gMbnbuass7KI4L6xALqw=;
 b=sjuPL1Ec6FgdeqNpb2VUVX0oxQyYhlqxCsQ8Q++CiHrKl9ZSg1JOOqAxXw+ibSMKukQ8tdpogwA0ZmzTRaA9CNWC83q/72Xjj60wN5zW9AKvVod24wGpRd2VWJFsqi/UCK//JXT5Qu9xS8px9u5REsyHE3VpCqdFT8bwDBK5xZg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CY4PR10MB1446.namprd10.prod.outlook.com (2603:10b6:903:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 19:30:05 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 19:30:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xrpcrdma: add missing error checks in rpcrdma_ep_destroy
Thread-Topic: [PATCH] xrpcrdma: add missing error checks in rpcrdma_ep_destroy
Thread-Index: AQHYEiAwt1EtoHCja0CB2nUoSwjaSKx0H6cA
Date:   Tue, 25 Jan 2022 19:30:05 +0000
Message-ID: <48846140-72B7-4B4A-8948-6F35F1670FCD@oracle.com>
References: <20220125191717.2945308-1-dan.aloni@vastdata.com>
In-Reply-To: <20220125191717.2945308-1-dan.aloni@vastdata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ecc4e6a-1f2f-4a1f-670f-08d9e039171a
x-ms-traffictypediagnostic: CY4PR10MB1446:EE_
x-microsoft-antispam-prvs: <CY4PR10MB14460974BCA1282EA73F9F5A935F9@CY4PR10MB1446.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dY3AJuvS5xjblPZGzX5KNoywLNEG99i+moG468CgsMtFLmU1MLWeoxb1gSnPm5+SFX9rjfIli/JZztPKBGUgWfKgigX0uw7RP7skQF9M4tiQ/j8jkqkqsWUBjbyXNLrvY+sghElFEg2fYJjGSuTRHACtexIWuqMBa89YZRGIq54SmsVaVHRnGSaGGHDk/KzaWaLzPf5oRGFU1RJm5uV37heaMqo6ceYDP0VOl8w/jIg5zaMUv1/PP9V8XY4zybE+F9hsmCuNjbgLYvKRoc+hQjGU6pxTF0fQkrDjMCagBGVcXje2aoib09ZbNaXO4zR+i7OYbnxJzfB88LijkRWbxYbkcouMb2fr3nnBDi5J+Wz6VoDkYFozjE7xK4x8+/usKhD733Xqz/3U8gNIAaZtIbsCxNtrt+kKvHgslgtd5Q/mZrKfU9f5u1K5GGCWXljRIHoDwBkhXYQUhrYB7XCHcPJpbx17nXngoktxrFkHuqFmax7NXyLKG65QGdtK+y7u5n4LszljyDnZe/U8FmiKGpgPgkksS6zHVrvwejyRXn7MSr4RDLsDjFV1v5ldeqvvB3w2RxqOlLcjpFV3uDEvQTG/v7cPGrwOXRf7fe0PdOkrTe9Fz1zci0r+bNa69WjHFHp8X7PvBfHpYt21UvI+nMzpdv7C8VgZ075h8k7RxR/UfE4FDnVaCWKsaJZdep8fQ64kMzVhzAXgmgeJZHjpboNPtjSH9o2BWlzzhjdZwA4DTnavhuwjG2eJRZaj+Yp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(76116006)(83380400001)(6486002)(53546011)(8676002)(4326008)(6512007)(186003)(33656002)(66446008)(38070700005)(64756008)(5660300002)(66946007)(316002)(86362001)(6916009)(8936002)(66476007)(508600001)(2906002)(26005)(66556008)(122000001)(71200400001)(6506007)(2616005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KS/X6GuuRAVp9XvK4JXFMhAx13TEIX/DkIP6KzL37ndrQE5fKLWRH4OW8dy0?=
 =?us-ascii?Q?c2uXtXKdNBq3Tw0yr2z0RvCrxDFjwk2nxw/uxSsT5xRzCCX666k5oTHdiCqb?=
 =?us-ascii?Q?Uxzlz9Snopc1zbxdjEmBMadtYoa6g0T4x6YvPkhJqPNdSy8IoyNbTDdj3bN0?=
 =?us-ascii?Q?ZTmkYAhim2g/0Vv7WRjkYDdKRm3u48yNmwtyvFt/0kT+EItOF6ChKjDdfvvM?=
 =?us-ascii?Q?D387q2ebdC6mXqKpNxrTK98mgGiLPVXafNuJmWRqHpcpKJoP2VfcSQQQYED1?=
 =?us-ascii?Q?bBvvKzi1ZcxtYpjvxgzZsIrLCqW1Vk5n0J7XUzayhkj5gZSghOHMzVZsKo51?=
 =?us-ascii?Q?LD+bQQJIX8TjPYAJBfcIvz168i6b0GqIH2ZuV+vdmf1pZ6ACpZShzROqKkQb?=
 =?us-ascii?Q?7SsweVqPHSpyMkJ45SIR5lLLvLkmPqjHnTl6E8IsD/OZK9AlxJJF5XnbM3LW?=
 =?us-ascii?Q?bl+JKDIJ/rfVsPhJKwHhdVajXvDhejixXFhFHeSMPKaacYP82TMXnNJ4L3Vo?=
 =?us-ascii?Q?JYW+Z3sCO5ArwoWBfhFH8Ubg5ui9H7tjsiFKdhTpS45MLdCeAF2BgZM7TKOw?=
 =?us-ascii?Q?D4Imn0Ro8TBPeeC9UGME3jaXy8RYu5MTZigbrAfGiPlRPWKSzE8S0dPqxlbO?=
 =?us-ascii?Q?gLYPIwsggx6ZQdB+pQWrfN4ReJMZgmN3fvIGNAo3WQdWDfc4i4mdPbWTSJyM?=
 =?us-ascii?Q?lmgAVtT1k6LY9FbVbGTcid3xaxB039O5n1ynyxJZK0W25R66BL6zn84wm/Wv?=
 =?us-ascii?Q?YKviFXcD3BygZAuXIzHwhl01C/CKfDpLehjd8em9MIgYogVfxhhW3Lg96MOV?=
 =?us-ascii?Q?RlfO4E62zTyNISpiymqCdkbqv4/ngZZqzYAjr/LzJ6Km++m5fEe5aYAZZyTR?=
 =?us-ascii?Q?cujwyR61cyf1U2SRhTc7b8UX/jmWbU1J1Je1QAYut6NP5zUm2HlIvl0/rEIi?=
 =?us-ascii?Q?L/p8P4IQFlXSNH0V1Q2H0V+bGj+hPiJiLInbcqnn4kRN3wz+CKiJ4Xt6OCLM?=
 =?us-ascii?Q?58i7bClbkDgY2pp2h2AZJhwpgGqBtvizJwrGy6cwqX1AEQPOdyoYdrcsveOP?=
 =?us-ascii?Q?QFWs2Fx2JyLvA/diUDte5HJtT3MHU1sxfIEM+cNAEM4jwcoMGRmDwOGaj8UW?=
 =?us-ascii?Q?hWOJXtHT5VEBFBd/YoqU10N3yTAmgTrCi5c6EmMh5Xn9n/LlEiW3jDGI3MWd?=
 =?us-ascii?Q?gBaliJau7WIQxh1VlnaK424B/GUolfSIgkejV0Fy4+Au0XlQ/2hd/jE2vOVG?=
 =?us-ascii?Q?kgfy+zlGtiEuUX+F4Qkh8tk5m6Ej128vuAu0wP43CixZhh2ZQwpjMJvoPKII?=
 =?us-ascii?Q?vtCuW0ZOUxao1CVa9WkdH/cJCX/uCK43ENoBMSraGCATN9a02SZin9aD/HWs?=
 =?us-ascii?Q?NmaVeu4eeafmloVm/iTbvoHvoBjv3tG7zXLCtkJwHJ6nNmUAvdmqPTtE/EPR?=
 =?us-ascii?Q?BP27iltw7vVxQuDF1IWMimJQk3Ss4krhPx9rMlRh62/sdGF3x4NK+tP2aeNg?=
 =?us-ascii?Q?l1Q5qykO8gAI/M/cAqrzrw/FNZC2ByvoR05Vfl8XIyQ4CEV9UDSHYPI5iNEj?=
 =?us-ascii?Q?umi3TCIoIubs7fUONo8mOPFrjVYWVLrHp3/mlgZN0e6XjCLixKC9jiDFa6HT?=
 =?us-ascii?Q?2n9iyRIH+VRLTA/52dZ8JcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EF341A4CC3C454AA4F90ABC5172C969@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecc4e6a-1f2f-4a1f-670f-08d9e039171a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 19:30:05.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSdLhOFgEPaMjt1KeB7c+bxCumq/a1ZooSirqHCJYcL6eakjTiv73cQFpzU6G94zBYGgi8f6yZozLrNKQsDdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1446
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250118
X-Proofpoint-GUID: 45ECDakKF6hUtVo87ZFnAykVnrOmm-YX
X-Proofpoint-ORIG-GUID: 45ECDakKF6hUtVo87ZFnAykVnrOmm-YX
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 2:17 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> These pointers can be non-NULL and contain errors if initialization is
> aborted early.  This is similar to how `__svc_rdma_free` takes care of
> it.

IIUC the only place that can set these values to an
ERR_PTR is rpcrdma_ep_create() ? I think I'd rather
have rpcrdma_ep_create() set the fields to NULL in
the error cases.

Good catch. I'm afraid to ask how you found this.

> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
> net/sunrpc/xprtrdma/verbs.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index f172d1298013..7f3173073e72 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -336,14 +336,14 @@ static void rpcrdma_ep_destroy(struct kref *kref)
> 		ep->re_id->qp =3D NULL;
> 	}
>=20
> -	if (ep->re_attr.recv_cq)
> +	if (ep->re_attr.recv_cq && !IS_ERR(ep->re_attr.recv_cq))
> 		ib_free_cq(ep->re_attr.recv_cq);
> 	ep->re_attr.recv_cq =3D NULL;
> -	if (ep->re_attr.send_cq)
> +	if (ep->re_attr.send_cq && !IS_ERR(ep->re_attr.send_cq))
> 		ib_free_cq(ep->re_attr.send_cq);
> 	ep->re_attr.send_cq =3D NULL;
>=20
> -	if (ep->re_pd)
> +	if (ep->re_pd && !IS_ERR(ep->re_pd))
> 		ib_dealloc_pd(ep->re_pd);
> 	ep->re_pd =3D NULL;
>=20
> --=20
> 2.23.0
>=20

--
Chuck Lever



