Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E45A1966
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiHYTVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiHYTVK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 15:21:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A49BD08A
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 12:21:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhkXd003453;
        Thu, 25 Aug 2022 19:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rvxCIS0Zc5oNRI/cw+sCjZMJ5sEhdO3mIU7jPbzfAzM=;
 b=LdNNK1BEcaFTcs4PRqMo81bIAWvDCnG8qzSPvG96K1QGo7xP8i2t0wL3VImFHHM8lne6
 PQA8il7kddrQUVZrDbIkjuBrv2auTLO7tFirEk38bEyAk66D9BoNHPBQPoyR6d++88zG
 utYmI85fYlstR6KIRe+x3JkhaCdmv36zoMnPsJGL/E2TmL3OSl0tD/7mSz/m/VwTq3mX
 xWPQ6rK6+iR23xJixj3qQxcu1YbG1x9gpe6BPz/LfrgFgGasE80AzA8AzEB2SuG3v3Kc
 BLcLAutVRi3zYoL46PtRheo7SEODshifm7VySV309PA757Tahn/g1czE6TC8U2hIzC4X 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nydvjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 19:21:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PHJvJ5039529;
        Thu, 25 Aug 2022 19:21:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4mtfup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 19:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz5wq40dOQtjZqrl+tnXR7aFKPmDi4zOrwyHupGK8UcAkmLAufqvyLjyjMLCdTatQaE96P/gb+GMQMdxiHPL3fLLCtUP5yJuTcvm+dqxq8sVSTfzTKIc6JGyfoawOl/N7wozN36qiIXW/C/4J5bmvm08SvLMqrgDAdBUUSneiUmiRSgLcuwFyAibcIsvaPPdJX5iqgCI99IT7IPDdY65qwC6ymg3HQMVSn1e+FfOyTuqs116k90+7L13vqYtcNSuA/FsEnsPZ4+g51P1yMcZW3cxmqunx8x1XzKcb0bS3BJZ0Wq/R9HCPq0+Z59O4ZtKU0WJ83XVTEtzC4dKUyjZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvxCIS0Zc5oNRI/cw+sCjZMJ5sEhdO3mIU7jPbzfAzM=;
 b=STTnsSpInCLVnvwXjRbcpH/bCKMTH6HxFjjHbmSa3R3AazRtgUDhuVSNwO/9tJiakNuebC3s8r6hs7U081i3XUQwooCBoEQLeNKV8oPlnP6O+PVV+AG/vcwu9gySN2qwXDzAATr9ZL1lj3VghO25FPHVoFO5yM8DZI7yVdFg7OecIXcZDUhQNVZtJRobxsYRgXkrUZ1FiG7u7Pj3Rd7S9btB7GGXG3W1ozO7R4on6Bl4+uPGyxSuIH7+0zR1iUEjsrAmVghEsTVojsQbee7j1HTWpVHN0Waq7fEGNuuz4X6mHSebm2yqtL07SMsPaic1R/Bu+y+thJEmLmv2jnismA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvxCIS0Zc5oNRI/cw+sCjZMJ5sEhdO3mIU7jPbzfAzM=;
 b=wefdPS34KE9WnumUJ7pqEnxzs9bVkmMgUlrMp9FORJxj3Ndkqs6hlFHrliLBTg42BVxdlvLK7THlMmC0z4NnZeg4fH+O4rGtcITUB+dH4pXyUmrDqrVbVGzPNSjc6RHcuf4j+WyFTHRY+nz1Yv4mjGhuM7hFaP3C/TYdJ6jKcG0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3592.namprd10.prod.outlook.com (2603:10b6:a03:11f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 19:21:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 19:21:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: Turn off open-by-filehandle and NFS re-export for
 NFSv4.0
Thread-Topic: [PATCH] NFSv4: Turn off open-by-filehandle and NFS re-export for
 NFSv4.0
Thread-Index: AQHYuLXU4u2NltMva0KSnHRxawuveK2//jGA
Date:   Thu, 25 Aug 2022 19:21:00 +0000
Message-ID: <CCFDB682-99B1-42A1-BB2E-69D1459B320F@oracle.com>
References: <20220825190013.578922-1-trondmy@kernel.org>
In-Reply-To: <20220825190013.578922-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72535b77-28c3-42e4-eacf-08da86cef1ed
x-ms-traffictypediagnostic: BYAPR10MB3592:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uo2o/MC9PggDdDTJWcG+Em4bMYBIvS+h+p1D7uqrJnXsGZMehE93JLYny+jODbuQELxc4LN9JXEm8/YwZ31Sx+0m5DFF6U2LG7qnma578rFR+MOKgstCitRuKIoFRU5d0JlLFj8ZSUMTd4uxGeAsJv59e0J99orjUZo62K5yofhwJY4Nf6wcB9BCtD3CTs1r06QOOuMKDebQ+rhQ96qshkatyBYwouLVRpodjbT9Le6O4h8hmeF2BgleZb2jIsjNq7lr4Z/tbsxEORw1/0wdGBqQ0IS+gpjqnxV2OU99oHP1cEBfkAyf0IU8XFlbWk9nPb12VQ3YnmwGfzUjixgRFXWOllCCuwvLhOVGzbWx6fPGTfVprmSU3HAXbkfPVn6TYCAlx2F0ke0hx/HsCdWPY9Ywv5d20q9cA1EWyVPMTwV91J3Mo2FI2Y0P3O187C9BxvVHtc4BjxNqL0+HVssX+qBh1IXAdFx9/SMkC2j5Lu0gjtzcFbyPB4ElApsIVlIgm3hrg6NeFwl4PX9+8zkl9hF8697RnKpEyqcq8iMJ3GSxEA+pH04a4V470wAY+3ElB43/edXEMxuAsx9cUUe0BpePe5OcfZr11qCnTeDvaN0Ym2IXi+TFoe4nOO0LYZoDBmOWFrMT1Zym4nF1fUg6JPJ7UThQ5unzqyx2csqNhc0lY/wpPPs6Pfw1CE/Ug1ZCuclk82jIO671pDXpJIdrGFbUfB/7ZsjYLOo0VfJLCOPI0aoQd+Dng9m91I2aLsqXa2wz1ZRt8oB2Z+EZ2eu2c+gZi1+ahuCYs0W6CcYmv1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(39860400002)(136003)(83380400001)(33656002)(186003)(2616005)(36756003)(478600001)(41300700001)(6512007)(26005)(2906002)(6506007)(53546011)(38070700005)(5660300002)(38100700002)(6486002)(8936002)(4326008)(64756008)(316002)(66446008)(122000001)(91956017)(8676002)(71200400001)(66476007)(6916009)(66556008)(66946007)(76116006)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RENOfZVJ92RgpGILy3w/45nZviE/sRwFEneu7w+tg9ELiOgs9n9pQh9ItDoj?=
 =?us-ascii?Q?+StfKvPJthqTr2AWkLXDu8Nwva915dkgSXDQ35EZWje/RX8Ta3uRT9IoW9u+?=
 =?us-ascii?Q?0mxSnXhQgXECl9cmjmIwb74/yzcMfV8pcsYVheligedogWVQ/25PT73NFdXb?=
 =?us-ascii?Q?VcoicTT4XW21knNEaZ0Kov4VPzqsUptjUy7FsiDjGzzw/BkmQQW96ks1Z+is?=
 =?us-ascii?Q?PJz/V2o6wpVgpf88owXg/cMcNgNSmV9SKeEItBdO+2Om6rmR12pD7fwgPPQ0?=
 =?us-ascii?Q?qVAFG1Ox9PJNhYYK6thsgylWI7Pm+v0nhShJuhs7KTm97+5zg5ta9O1c9FN0?=
 =?us-ascii?Q?zu8yrFssBnPXbkbuJGJfyRTUnRN+PqynMnJYb5TzVnoxLlOtzk7udyyDgDf5?=
 =?us-ascii?Q?L7RdlYErOAxzwcLsNW9QwcO73AKgYm5ClImNftxO3M0uvo/7ooMk9YrqTR0y?=
 =?us-ascii?Q?a/rE9dvwI2Fahjg3W4NcDGCyOtSLdOxa8Oqsr7eLXGUhht9UBGyk/aozUwPL?=
 =?us-ascii?Q?gxvSuqZGG2k+jG8TzoTh+mY6nWWNbFJlEaVMNzl23dqHCaoMF8dwm6O7paSS?=
 =?us-ascii?Q?hUBrAS9sVRTpxZrUz54nzZ4X0TgMXuDMx3wuKDX1BtTbJrPilZQFLc7WusS+?=
 =?us-ascii?Q?8eGSuivfKj0q8Fj5NLXUtt9sXz42X+YrSyAtUREQJSVOwGGF1+6PWKZnhxKd?=
 =?us-ascii?Q?Ei+mB9SnFSTg9xZXx18+jC/w66RGLH5HE5rnln6ql+YBYyzBeE3KJ9QWvh23?=
 =?us-ascii?Q?lZRBZUkoWxzV6sR2M5jc1+alz6++AC+w97c5rLuA61SR6Vy0u9S4HtWcx2yo?=
 =?us-ascii?Q?vzYuJbmt52l8bL0zbO1/cSagiIAWjvGrutU6drURpraJF4gUYvg7EftL3QVu?=
 =?us-ascii?Q?EUOlAEzk+ASXYlZ2MN2ty82H+mxG5AM3j0QnjvWOMxL4JfUkEtmr42ebLhnD?=
 =?us-ascii?Q?cQxe8XmOVz+RKH1oVpUNbNYwbNPwONHJYqRtMETG1uUUCW4ewpgTsJiHXthu?=
 =?us-ascii?Q?0zxjzQ1bk5zzDKWRMvncofC1phiW5ESNeSzQ23gyb6rzsmXeYtGcodptB39R?=
 =?us-ascii?Q?3qBaSUWiH/P7DVHKa9FFZTaGSl7KGc3NURR0Mt4eO4sEgQ4nIf0frDCaD4QH?=
 =?us-ascii?Q?NuTxxBiImL+Otq9PrmEJwgWzpyiF/LKqRy03AHsA3RBKoE4PsGHiJuERQPMn?=
 =?us-ascii?Q?w4lEavIzSQ4uMCM7ilC8XdpoQ+wTJ8yDFvQwLSlhEN5XDNMgEkhZwS+efQfP?=
 =?us-ascii?Q?RECuUO80vkacj2f0/kA+v2/LgStUcVMTE9qUIYXAd+GGxdIv7xKfVYk5tjaQ?=
 =?us-ascii?Q?e5cMESVMs8BFXK0AEy3TXPejh/1mm79AlQ33ZGfPAkgO1AXzVjGZrKfvnT1B?=
 =?us-ascii?Q?rfglPOWtz6V/WjJ0NkjKOXbjo8UdD7d2dclEpANXbTqTMvmhJmn8b2wIyr0s?=
 =?us-ascii?Q?oT0CbMXma/M8jNBA10wJ/mEUJ0lrm9RidxuTWxS7KHiIfWnCjAHKQxLgXasn?=
 =?us-ascii?Q?pwPpHFs6qfmKV1I+hpb95eZkwaMtFUQlBEev1Ct9wqEs8T5RI50DNw+mt6SU?=
 =?us-ascii?Q?BpoxBZnxZP0fy1pjp1lRN53q9buO+xcsum4I4f1/r8IFqmSMoMbT6y6KMSw5?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F956F6F23E63C84C8EBD3196251ED5B0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72535b77-28c3-42e4-eacf-08da86cef1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 19:21:00.6476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIWRKBeSK6A6LgVpOfk65yDmRuhUrQhpxqpQ5MnLBWkW93YdycaTUuYQuWyH6RyLqq5FqgFBsrVtbsjdjqYyUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250074
X-Proofpoint-ORIG-GUID: udi5ykI_CDZWh2aL36xTXb48-LzXp7wL
X-Proofpoint-GUID: udi5ykI_CDZWh2aL36xTXb48-LzXp7wL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 25, 2022, at 3:00 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The NFSv4.0 protocol only supports open() by name. It cannot therefore
> be used with open_by_handle() and friends, nor can it be re-exported by
> knfsd.
>=20
> Reported-by: Chuck Lever III <chuck.lever@oracle.com>
> Fixes: 20fa19027286 ("nfs: add export operations")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

No objection to this approach. You can run generic/426 as easily
as I can to test it...

Bonus points: the use of switch() here makes the code easier to
understand and modify.


> ---
> fs/nfs/super.c | 27 ++++++++++++++++++---------
> 1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 6ab5eeb000dc..5e4bacb77bfc 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1051,22 +1051,31 @@ static void nfs_fill_super(struct super_block *sb=
, struct nfs_fs_context *ctx)
> 	if (ctx->bsize)
> 		sb->s_blocksize =3D nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
>=20
> -	if (server->nfs_client->rpc_ops->version !=3D 2) {
> -		/* The VFS shouldn't apply the umask to mode bits. We will do
> -		 * so ourselves when necessary.
> +	switch (server->nfs_client->rpc_ops->version) {
> +	case 2:
> +		sb->s_time_gran =3D 1000;
> +		sb->s_time_min =3D 0;
> +		sb->s_time_max =3D U32_MAX;
> +		break;
> +	case 3:
> +		/*
> +		 * The VFS shouldn't apply the umask to mode bits.
> +		 * We will do so ourselves when necessary.
> 		 */
> 		sb->s_flags |=3D SB_POSIXACL;
> 		sb->s_time_gran =3D 1;
> -		sb->s_export_op =3D &nfs_export_ops;
> -	} else
> -		sb->s_time_gran =3D 1000;
> -
> -	if (server->nfs_client->rpc_ops->version !=3D 4) {
> 		sb->s_time_min =3D 0;
> 		sb->s_time_max =3D U32_MAX;
> -	} else {
> +		sb->s_export_op =3D &nfs_export_ops;
> +		break;
> +	case 4:
> +		sb->s_flags |=3D SB_POSIXACL;
> +		sb->s_time_gran =3D 1;
> 		sb->s_time_min =3D S64_MIN;
> 		sb->s_time_max =3D S64_MAX;
> +		if (server->caps & NFS_CAP_ATOMIC_OPEN_V1)
> +			sb->s_export_op =3D &nfs_export_ops;
> +		break;
> 	}
>=20
> 	sb->s_magic =3D NFS_SUPER_MAGIC;
> --=20
> 2.37.2
>=20

--
Chuck Lever



