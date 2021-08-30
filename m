Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6063FBA79
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhH3Q62 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 12:58:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32714 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhH3Q61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 12:58:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGm3LE020110;
        Mon, 30 Aug 2021 16:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=73YqjjipJpKJ0FrjxRH4jTV+8HL0mFP6O465UU0jflk=;
 b=M9QIfdiUE0SJ8avmwmkX5w9PfOr2B9ReJ5Mgp6YEBDVL8eOEeHCoO0k2DiSWfyC0vRtQ
 hnnOYh20fEk7ea3TLLrslNI7DC5WkmaSIJVa0QWrFdK4Jky1iHk3L7xtAmLwDQumtXCC
 BymJEzhouTHiv/OzoIOdH90z1DmojDPu1UVR0JSZcVXc+ZnUdRmZkFbjijG5gWY3FmOF
 t1LarAK7P+LiS5lnH79GJ/lbqVfRuCpXlUgA9FHWWXaozqlb6kE9Ka5dowrF9759MzCG
 fVf5+ih/yn3ITJUa2TCled/22WbJ1+VpFXrPk+t+evzc0AfQkQDOhlx5qlM0+0RTsCIv Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=73YqjjipJpKJ0FrjxRH4jTV+8HL0mFP6O465UU0jflk=;
 b=J+MVwBYISgsQVT1/QNYeyAvNXHzzvXxdxFrU0XtCiOnsMnORUm1ljFO+5Pjy7itAz1hO
 sdxSih4FgHc+87Zc4ZLITSQVQfF4DEdLFnVVdkJW1Rpvm3PJDXlNDCQh6zu+/E5pnfl/
 rSGqZa0tSzFZkJraSR8WEvW+seCEugnOz1Tcwh10KFjEz3eG6UFj9FXSD6K5XKlmQyRs
 9whTWBtj46tSz+dAssy7ciWznQsfREj6RwJMV9pVbVQDN/u0WRN2yvhYMHj3cD4UG6ze
 tmUWhr+Hp8461L06IKLlh3304AJiA+clwX2Vy+HGgCLpW5KT4yZ9SlrkFwaCtR652cGP Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arcjwa42w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 16:57:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UGtaID167278;
        Mon, 30 Aug 2021 16:57:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 3aqcy34s0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 16:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOds5Mk2RxTuXGbWmitHz3QTf5jp8ffO7HchGYoU7Dq/XJIu/0nqDPbDRSOq9lyH9uEJch8M5e5W6ke9wcfpvDqQn24RdrKgRx3EhlkTj4Zn8bGvW0n4HB2PgV07jvNzlrRJYAlyK40Ult1BhAklMkGWuP1Niu0YD+uyY8fy5EdbphVbruQILPA3x4Kw0McG433N80tnxuRc7bynKxjIa5DkrM0PBQEz32aYgduKRSlM0YiQ6EUorISWJVQji2ptzklPLCUULvxwZaIb9ZpXrTX/UGf6TRy6VY2hUXMKzjPiGWdCcUNr15x8+wM0N/9McmBbcYSbntdefP070aheFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73YqjjipJpKJ0FrjxRH4jTV+8HL0mFP6O465UU0jflk=;
 b=IeWHYLKTiQXRcM9TK6IMVLlfzrckBXnJkFF7TbtyKO6WZ+R+mOnB6+WXY7v0OVICSdxR69OYp6yya80mmLWNDntTMMEZ38HIETF+0deEm/4oE0egfVxFnz5A8j1WZzOwXUzEUTpGDierDnIuhMlHkRDuzf/M+CrMRV2TSxAxEevUT1ZXKKkfnPeO8B87+Alg69e43gbaqv40Dfpmif2w7BnEjq4a1X6MqGAzveYQdFoY253JKsvR50zR9GrJjUhfOnmdIfDeXrNRRjNiR4RY4vLGB9UU9r5UrDpFUwQ4FqJM6PhEav6MMI1izvMfB81l9FNCGDc1Sb/RlPcuP/h14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73YqjjipJpKJ0FrjxRH4jTV+8HL0mFP6O465UU0jflk=;
 b=QyCP3HmpOUZ0UD3tq2eZBaNr1HWa2jfPge2YvyFeQKydKVl+S/t6kjafEzj0ir1Xahp8gCJitF1DRwXEOeMIhdr5zAnVnSn3+NJIMXHzXxoWX6vXdJqNaf2Oz4wTaM3BWvwcQyME1fGLMM7oNIYQnJa4LX2K1uy4XxGbtrHhnyE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5406.namprd10.prod.outlook.com (2603:10b6:a03:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 16:57:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 16:57:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "chuck.level@oracle.com" <chuck.level@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC 2/2] xprtrdma: remove re_implicit_roundup
 xprt_rdma_pad_optimize
Thread-Topic: [RFC 2/2] xprtrdma: remove re_implicit_roundup
 xprt_rdma_pad_optimize
Thread-Index: AQHXnb+FY8E/qRgqzkSgV7IMA6ztN6uMRLYA
Date:   Mon, 30 Aug 2021 16:57:25 +0000
Message-ID: <958545E7-7758-460C-BE3C-451DEA96969B@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-3-olga.kornievskaia@gmail.com>
In-Reply-To: <20210830165302.60225-3-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc1f969-559f-40bb-9f01-08d96bd73e6a
x-ms-traffictypediagnostic: SJ0PR10MB5406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB54067ED00B50E3BE6DBBC90893CB9@SJ0PR10MB5406.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53Va4urPVytihM6Ce14YogdCI79KRnpd+X85uyGifJu7DHVz/NY//atxsl9QVOMa1NZbv3rOSOBqc4lNLzG2b5u7B39UdI58tjsVlJ8UEfKDX892qG3YKbic3b/DhDnkh1Osxq1MSFM5bGWtOoot+1sUrpn0Np3SxVp1uZtGW0WDfFlzVL+FjE2jM/vHq/d5718kEAByzmfQ8wwh50Sj9IHpac9F89G5T86umZZYR/GxFhCshqsIIz8yLA8STH9BlRkRG2p8+Of7qyrZVC9+0KDXSSNnOTFSwfEaK7g5bAzDJiXyPQfbknyhQizij5nu1p3Xc7p9jLxpZpZZAiDWvD6v8njpEPCmvnNSYJ6MXqx/RJcw6Z5xKwTWG14mudVxEEnczTPC1TEC3p3/NzI9/1YFG/812X8v6/Bm3aSqSbg8jTaaf1nVmg6ND1AiZue+bQrduiqfzUrw3t84bEJmECqoEHThXuOXDPCkHVNkPiJjIzgBdc6bVkg3DvoAoE6Z6n09xwipMbTa145CcvQxZ0d1GL5+Cx1OGqoSeWxnw8QqGZ+Mwez5qARq2rCr0HYBO6IFPfkAcgBIcHeVqzVGOvRZZAZ8wuXEC+gisi1uyeZKnv9tBJWVuNUTxUsvsSHi6z7QtrTtKv+WWQubDpsUWx0qy+1weGRQxptymilUQsgtKTv5nTpWDgZ6y+KVn0Vd04+D7YXoIgARq0/DeiGsYj3IKK6tMgjOr0U1ZLgjXC4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39860400002)(366004)(83380400001)(66446008)(8676002)(5660300002)(38100700002)(38070700005)(2906002)(6506007)(122000001)(6916009)(6486002)(8936002)(53546011)(26005)(66476007)(66946007)(66556008)(76116006)(91956017)(6512007)(316002)(2616005)(64756008)(86362001)(33656002)(71200400001)(54906003)(186003)(4326008)(478600001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yA7T5uRaBcyFxS3Gj0xPze2jmOJzMyrAa1QQpxY0v5BG9TZlzNeXzhSr0hMp?=
 =?us-ascii?Q?HmGn5DJcoQrjlE+PYFzAfDtdb0hHlbG33Y1ovzIdsxbxdGYVw0/3kB3YWl+8?=
 =?us-ascii?Q?7+84tGyGP6zOahwNJgVAHKVEAAxGUPEcvTs1qiPwm/WtkwOktA1ZCQgKRSdr?=
 =?us-ascii?Q?S9H1ox2wFlZNS487VSh6GvU0L8MZglDNNUdUDGsTOBZaR9MiSriVQt6zXkgS?=
 =?us-ascii?Q?C5viYAxC3f9DpbbZLgXu051z3cz9e7uzbN0sFvVk6D/ssmFXspDnqBn/Mgs6?=
 =?us-ascii?Q?G4Tgvn7iBdD2u7CBo4VbFtWdlfy/DjeBr9V619u55fCqdoJncNlyQOx/80R5?=
 =?us-ascii?Q?2UqPgxW4eHbfTRbahEpXyYK57WL8AAStAu5mroYUotZBXH9OW2owZBmYEhvC?=
 =?us-ascii?Q?WoM2DNonswwq441lBqGBb7ykPKwDe1Nu/gId7gL428edrY77V/cyJtSy4c8j?=
 =?us-ascii?Q?RMf3767AnTU96twuXxbmM0aPlp8TblBDDVlP1ryIQGnELpWhrf1g257m1ekb?=
 =?us-ascii?Q?TEvf82FpeUsiVRIotsgP3YUKJIyEFia0kirgg7smu2CgmznsTVYPD0nKWiEL?=
 =?us-ascii?Q?Yz01SvhtEfqZ+IVGOSBr9wghl6R5ImMZV+mIfFGmiAnWGFn9lRSPVKiehj9J?=
 =?us-ascii?Q?Dx64lwG9smnGjKzerZfanvr/IMogLnBVXLu8DBv7iAWJ94+RCyoKz1WeceFJ?=
 =?us-ascii?Q?HC+DgM3zYGfWSfEZ0GctkwaeEOrZ+dhTsZF/aIhsa1rzfHzTekHkhMTolnvE?=
 =?us-ascii?Q?lN3IWSHwTSmNKrVbMrDekFfwqVZajMA1g4zJmq4jFbXizCA+w0j0vEu8KeJw?=
 =?us-ascii?Q?jgnKRPrm0PLvobiDz0k6e1D0xG2mqYDqWnfzY7V0mK8z72umqMKWVicLwzzt?=
 =?us-ascii?Q?fP4Tvulcszi22VKJUPk/pJaP26sVVNj6iIWHqM3wJH7uIZ1WuACXh+qC/JiJ?=
 =?us-ascii?Q?Jf/zZxYB5v1yyJGiQhLcSjTlY7BR8AjC93mvYuhtMKxqtDXegOBVWnSQAZlY?=
 =?us-ascii?Q?ydpRI9khAD7XsmQjdRwLI2uYaJGoFJp/gPg/Ssne0qFrcEC/yxVzqq/3RFv7?=
 =?us-ascii?Q?oi4VTbcALJnfnFGfW8FadRLk28cP7SWDIUUMYwIdc2xqnsqHjQwSQfoaW3Kp?=
 =?us-ascii?Q?6Lc/BKhgKUF27IlbpG9eRLhoZgPfHPiK0N7FrzkBs/QnYZ/qzl9EhxEoo6oX?=
 =?us-ascii?Q?iuu2yiuYmf8UIosnoOWBF1xg5x4V5cPgSzNyEf/ZvBNgC4l5kLlm2EPJpnat?=
 =?us-ascii?Q?CPrVyx5sYMenmnIEKgZZ/+jS8Y1fmcH8sOQ89jyMjaftoOCrrrlkTbSyNoMW?=
 =?us-ascii?Q?NPD4F2yIJcJvLedQASqW1xN3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74A18A6A4D698B47A66AFDEB77ECA360@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc1f969-559f-40bb-9f01-08d96bd73e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 16:57:25.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJT+p/TfAfENX/85rtRaTM1NZHYsa0vW5o6eOZWTA/EptLLSwt68c0PI4C+NqsG/RvU4pfIrWBZ9tjxfe479lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5406
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300116
X-Proofpoint-ORIG-GUID: dRSh7HOEv1gryhlQLKgAwvXTYgTM_ZPC
X-Proofpoint-GUID: dRSh7HOEv1gryhlQLKgAwvXTYgTM_ZPC
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Since RPC over RDMA layer no longer needs to manage XDR padding,
> remove existing code that managed whether or not client included
> extra space for the XDR padding.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> net/sunrpc/xprtrdma/transport.c | 8 --------
> net/sunrpc/xprtrdma/verbs.c     | 2 --
> net/sunrpc/xprtrdma/xprt_rdma.h | 6 ------
> 3 files changed, 16 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transp=
ort.c
> index 16e5696314a4..e7b9d88f4483 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -72,7 +72,6 @@ static unsigned int xprt_rdma_slot_table_entries =3D RP=
CRDMA_DEF_SLOT_TABLE;
> unsigned int xprt_rdma_max_inline_read =3D RPCRDMA_DEF_INLINE;
> unsigned int xprt_rdma_max_inline_write =3D RPCRDMA_DEF_INLINE;
> unsigned int xprt_rdma_memreg_strategy		=3D RPCRDMA_FRWR;
> -int xprt_rdma_pad_optimize;
> static struct xprt_class xprt_rdma;
>=20
> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> @@ -134,13 +133,6 @@ static struct ctl_table xr_tunables_table[] =3D {
> 		.extra1		=3D &min_memreg,
> 		.extra2		=3D &max_memreg,
> 	},
> -	{
> -		.procname	=3D "rdma_pad_optimize",
> -		.data		=3D &xprt_rdma_pad_optimize,
> -		.maxlen		=3D sizeof(unsigned int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec,
> -	},
> 	{ },
> };

I have to NACK at least this hunk: my understanding is we
can't just remove /proc interfaces.


> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index aaec3c9be8db..d8650a3563ef 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -205,14 +205,12 @@ static void rpcrdma_update_cm_private(struct rpcrdm=
a_ep *ep,
> 	unsigned int rsize, wsize;
>=20
> 	/* Default settings for RPC-over-RDMA Version One */
> -	ep->re_implicit_roundup =3D xprt_rdma_pad_optimize;
> 	rsize =3D RPCRDMA_V1_DEF_INLINE_SIZE;
> 	wsize =3D RPCRDMA_V1_DEF_INLINE_SIZE;
>=20
> 	if (pmsg &&
> 	    pmsg->cp_magic =3D=3D rpcrdma_cmp_magic &&
> 	    pmsg->cp_version =3D=3D RPCRDMA_CMP_VERSION) {
> -		ep->re_implicit_roundup =3D true;
> 		rsize =3D rpcrdma_decode_buffer_size(pmsg->cp_send_size);
> 		wsize =3D rpcrdma_decode_buffer_size(pmsg->cp_recv_size);
> 	}
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_r=
dma.h
> index d91f54eae00b..137866a83a3a 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -74,7 +74,6 @@ struct rpcrdma_ep {
> 	struct ib_pd		*re_pd;
> 	unsigned int		re_max_rdma_segs;
> 	unsigned int		re_max_fr_depth;
> -	bool			re_implicit_roundup;
> 	enum ib_mr_type		re_mrtype;
> 	struct completion	re_done;
> 	unsigned int		re_send_count;
> @@ -441,11 +440,6 @@ rpcrdma_portstr(const struct rpcrdma_xprt *r_xprt)
> 	return r_xprt->rx_xprt.address_strings[RPC_DISPLAY_PORT];
> }
>=20
> -/* Setting this to 0 ensures interoperability with early servers.
> - * Setting this to 1 enhances certain unaligned read/write performance.
> - * Default is 0, see sysctl entry and rpc_rdma.c rpcrdma_convert_iovs() =
*/
> -extern int xprt_rdma_pad_optimize;
> -
> /* This setting controls the hunt for a supported memory
>  * registration strategy.
>  */
> --=20
> 2.27.0
>=20

--
Chuck Lever



