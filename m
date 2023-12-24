Return-Path: <linux-nfs+bounces-793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E414281DBA3
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579A31F218B5
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279579E3;
	Sun, 24 Dec 2023 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G40VD7bt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wj4QW3Os"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B2CA64;
	Sun, 24 Dec 2023 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BOGYwaa009606;
	Sun, 24 Dec 2023 16:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VmZk9Xt6moPoZ7LI0xDytTqHA3f8hzXaVrZShI7lm9o=;
 b=G40VD7btydTfE49sMG3z+br3eg3r59SDMljy3rBvHLdOKglubmtZZzAI3D+zVirZlJMc
 rVr0dFb2THBq8lYylasEVhhL4WdeEuOm85MqHQQBvGyYpORt08jYFrzKLgFH9IG307ZT
 DtphhoT0vLdhx1uccn7SndPDhLwPNEXgiZfFUxX5hmyJOtcutE9M29U914Z61bmTMl6h
 aROzQvu17o0C1abyj/nxhG4cxgAKBthV9f+vRwtc73lXCDdm6XqwZ7lJrEVQn/MGWoX/
 EjvLEhAuHpYrhzFPrlmMuXbc9oQjM8mHUKgQJ4uUzQ83F6MDk/PDjvPbrQrlNE64yvGx rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5p529rq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Dec 2023 16:56:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BOFjeJv029212;
	Sun, 24 Dec 2023 16:56:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p05v8kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Dec 2023 16:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTjnUT8GG512uM6vbbVIvLacj+qY7PO2zvmavaDsQvip92CJxD289/oj5PbOc9XGMriHvlF78+MLEDiS5CYmyXANtDDkuHl1cWJ8vmuRWcbDmgnNFppYd4vi5W6KwDndKUJSYrYFgni5Z4j/DybHJgYQivvl7U+QOISkGlbqL0D3GhtnpIjHkqiKAKFkAnpkH93pSZBVIBBr1dGM00ll2Eb8ObNOA2t7uPfWZppsVn390125WV9n2NpOcvvHz0rKIiwI0wGrU+Ld13FJO6t6Q0IPqFX1oRJbDoHRIAv8v/wUGGX5KISv4fyihjRLGb+3JD2PkactALxyCxj5rvx80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmZk9Xt6moPoZ7LI0xDytTqHA3f8hzXaVrZShI7lm9o=;
 b=i7kNK5GmAld+D8e+RY77pw/CwlmdQMQoCeS4q6PYJppOmgcEd23ecsI/BHsBoSw38VAKpCciCxXWE0a+8YA+T9xbd/H5k/WRa9RGjmx2q6jD0sjVuoEcQD6EM/2c8/qlufxH0C69YBeo6+aD8LEAQaNlAifbpRt7pI2xEw59FUP259di3QxoSVcFU2q27zB7/W/LqUqVBcaw8GbEr/lMz+h5bC5Zd0Rtk5GF9LwHpHa+32aeVgsiR8tI7jGaSFlH0Gn/fYZ2GQc+8sAB2tblLJaL3FDVMHOPJQHIW1aXppP32KgycGvdoxmfbwqZtJ6htFHgQHau/ZXPDAyySe+UNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmZk9Xt6moPoZ7LI0xDytTqHA3f8hzXaVrZShI7lm9o=;
 b=wj4QW3OsL0cZ3v3DwTEQq+K7OTzqsC7/CI1hjwvKMovgAx/UPG5uTBYswPgUb3nDqndOP33pwfqgtolxJEgi9oAEvG3AvRmpf5eTg3UJTuZUQeubODHWHhLRukjf9oldCTRiASN6nnvEQ8jC40XBOITI/URJ55hpJHnkuSupG/o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 16:56:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 16:56:31 +0000
Date: Sun, 24 Dec 2023 11:56:28 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simo Sorce <simo@redhat.com>,
        Steve Dickson <steved@redhat.com>, Kevin Coffman <kwc@citi.umich.edu>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: fix a memleak in gss_import_v2_context
Message-ID: <ZYhivG2MxmtePvo3@tissot.1015granger.net>
References: <20231224082035.3538560-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224082035.3538560-1-alexious@zju.edu.cn>
X-ClientProxiedBy: CH2PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:610:52::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: dcabed8c-0838-4365-1347-08dc04a14768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iW4Wpqli1dU6pVtdS/e3HXGvXR/B7xT/pru9g9LpVZylM6y9o+ba8h5DVYFRHt0KY0fAsf/H2f++WxS1NAGZJjZPY3Sh13c5Scc7wvdvChlhZQbHM62zJNaWXuncOZmiFu9CpRJVHruE2rnPmfH7SJCsqew2Rhp5723bdZJRrU1eLo8FK9pirz/KxZjmABfGVoaLCh3qWSPq8EzNm0IYDmA9x00r4qo2LKLSu4ERFz6N/ZpsMB96UKY0KfwIT5m8hrlJTCjrPVOY8lJ6ST5uBL52TJQibfYkY/GCtXoTVOi4AHPJCLEt6o75DwpVRWKLj05vpX8OfR5uMoF8ivJCeDhPtvJ/YKgibh5ROXGFhXzkXm2RO9XKYl4pFiN0e1+KUU86Najk7YBsLJN7IcnIse3d2C4+SCaefgifnaDYr57e03l/Jaaxx0D39xanmKLpcui16cTX40pBH+4gBMdV21UDPecEyU/OXWlcawvaHfu4by50soMzYXl52/1hd+CG8RFYRIs9HXch9reB6ClODvHT6NOvjFqgEbjVIg6A3a8/i36XPXDJVP5z/evCKFTh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(86362001)(26005)(83380400001)(38100700002)(9686003)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(54906003)(6512007)(6506007)(8676002)(8936002)(44832011)(7416002)(5660300002)(2906002)(4326008)(66899024)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ILvy9OmKm9mexrNrfMBW1CKRa7NtEjfGkO/5s71ozP72E+8NfXGo/4J2Nsci?=
 =?us-ascii?Q?gUX+YxSs5HoD7YuG5HoAKcW7lY/9xcDrpEg2Zh3S2yz3QAPa1wYvkaM60uUo?=
 =?us-ascii?Q?r3G+MaO7mUyX1D3v9ERJFLnpT1Evv+DT90F7kTOTw+ulHfmlVZGuwcBUP6Ko?=
 =?us-ascii?Q?5JQiR5AV2cMYLyX+XrYhPAQCl4WJeaJ+rEOhGS5EljMNt9Yg7Gr9XAWQ2g4X?=
 =?us-ascii?Q?Sfr3abj/zBvtRgKn0fvXZdS7OPD+7WkN0e1c5rgX3lGaRm2hAoispsu0XO5c?=
 =?us-ascii?Q?yjBBz14rFhjBWUE6M5+ZOvfwt4DSO3rXIN/ltKva0VmAH1RR50EsjtYxvdi4?=
 =?us-ascii?Q?agSKdMWk4lqFgmxy8GZR7N31UejJmnpLsOY8JBHZlKh2K3sGY5jU9R4GW/39?=
 =?us-ascii?Q?+o/319RV8OwvVslK54npOvWZleBQrmATsWMdAyeCBaEDpZBgpQVJ51HLLbEO?=
 =?us-ascii?Q?xihgosA7MZbcODhvVQlh+pSDg2YoJGXhEK/fqhwEkkOnRUO2uGdcOubfBPtF?=
 =?us-ascii?Q?ToMfz/Ii+AV/BQLcWAR0eIX3J2cFIK0JjETrj7rWj2ee41FB2WqFqStvTC1P?=
 =?us-ascii?Q?8t4InIJogY2GRabM3ndITerUWxshTJF+2rHgtcBFJwdKMgp9VoitJFV1XpCf?=
 =?us-ascii?Q?cXl0Z6Gi5Ico04+PC2zumQDK7xhWzedWNJDMKYmCJvT910TYIrjOx/aTXqsO?=
 =?us-ascii?Q?HLA6VoWJgQTOoz+Fx4uoz0nTk1QiCrbj+eGyvy26eNdVkulRWYHRbVCiB49M?=
 =?us-ascii?Q?jIgfw07zgwkD/RUwD+MxFhx4EUTHpKr1K0ud+IZNiS6Kqw0J3zp0MVxSn8yE?=
 =?us-ascii?Q?NVeExz/yUDB2+zudPbqVgYyewq/o0W+WGaJjLxoWwW53uMqah+breytXwvX4?=
 =?us-ascii?Q?mtCCWKA4BWVOk/dJaHjdAymhWdnLgJysH4ei8b7wAi+Q2eWsXC8bIxaVZ4ZG?=
 =?us-ascii?Q?FpU+Agib1b6CG9SO4r3nFzFmOI0DoKNtEUaF0evVFzLdDTNZXCA7/Q6sHOVH?=
 =?us-ascii?Q?IuD+6WYUC8qnOx+Qw5mrRhF74V+eZj/B44pbqGSbHbKLuC6eT83gJ/nhNq6X?=
 =?us-ascii?Q?S/5pIUMO2mbFVxE+vPlUfS3LjRv7rVaFI70FqL3c9vOMaUIfuybGFqWpIcuu?=
 =?us-ascii?Q?w81Ixq7ooxwdXKKW6EeS+vzz+U/RWYiKRaHW5K92qMET7N4ZZ5yCBJyLEb/Z?=
 =?us-ascii?Q?C+Iw6duKDGAQmlE2foqRe3ckSsifbhtRf9zlx/bkxoPm7DVNvsbu0VwmjidQ?=
 =?us-ascii?Q?w9abgyO9D1M4+WGXxbbO4seWdyiKmhYYkNrpgn9eMgYjLJRc6tgrJiQfP8EP?=
 =?us-ascii?Q?lGFX3O+XvJmhZjasF+gb9mUmyHyLL8R8S5og9gVZVZ5RHw45M2LFjZOWyLlA?=
 =?us-ascii?Q?VqpyyD1KGXI4V/NmKfO1TX/pl7Re4HOXllMc2F0FUdEeyd8FF47W40iMEtTt?=
 =?us-ascii?Q?/cKornfb2VKlNmnRVTjGumpLUcMT2/3ngLhokH9sSqEaJwXtSUN9XEIxnIys?=
 =?us-ascii?Q?gunMQJqrsR4y2cZ8RXuaZ+IXGCL5+C3e2T75pcrm2tjNalom49YLZgUd5L8K?=
 =?us-ascii?Q?ONDH3mQrzR5scr2lsZ4qb2YvaxvntIbILZANInN1ZdpfLP02uKDtqmXbAgKZ?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AETHuakHsjQQVMZodoe3jh6SqgAnr0EaYKM1IUIJGerU4RrfuSXrdp875vIAJj5lAaVU2FdNN+OhmgXmn9Nsu6oeqvnkWSJbIkYuANrzAaZzR08gG7g2QOsMp32wFXOoLAhHeJVtxSHOHtflcBr0jC9RgN7fgwx4FlUBHUoozVTjAkzpmuwCf4/p+6w0SfMAtR66EXvCGjcA0vuRCoy6nmovqad6MGzuXxlXAWGVx+FLPvLxdTEO6bllWpboTONjfcH7uimHfjymM4//cmG9Pi5hRuqoazCPBQ++JyA/LV3Xwlsaadhv795wYN3puiXFpsOmQbdDzW/GblI3ECSAhUm+UOVR/neaK5yILI7f4QRT3ubE458EB7DfVqGdzsotkMejOQxuAEkHGYYvJifnTCGjIdOUpA6wdz4MfYpgCJVYxIdzcBEB+Mp1xMvdwTA/+G18HAvcXFkH3PrIfiSsBbZV5uYYAeRT5EFtOIiFUCAoF0Uo/gFfgjcR0de6jWVDnScKJoIHgS5N9M9OSBZTVc4w9Tt8TU7+74fzDAdyeE2FIujDw6SgcFG0Qs+LSgRUuKAhiyYgXMePTK3cIpk2iC2x6hvV8C+0f1RGJP8z/u4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcabed8c-0838-4365-1347-08dc04a14768
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 16:56:31.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGPTJiJtwsVI86sJ/0lH4TZ3beUjujZh2vtpLZTY2WJP+Ies4MLFEEox3eutTAHNoLcIKsNB8SIYoYZSk/BhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-24_10,2023-12-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=852
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312240140
X-Proofpoint-GUID: ZWG56c1ulGiGJTovpud62NRL5G90g1_C
X-Proofpoint-ORIG-GUID: ZWG56c1ulGiGJTovpud62NRL5G90g1_C

On Sun, Dec 24, 2023 at 04:20:33PM +0800, Zhipeng Lu wrote:
> The ctx->mech_used.data allocated by kmemdup is not freed in neither
> gss_import_v2_context nor it only caller radeon_driver_open_kms.
> Thus, this patch reform the last call of gss_import_v2_context to the
> gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
> formation.
> 
> Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  net/sunrpc/auth_gss/gss_krb5_mech.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
> index e31cfdf7eadc..1e54bd63e3f0 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> @@ -398,6 +398,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
>  	u64 seq_send64;
>  	int keylen;
>  	u32 time32;
> +	int ret;
>  
>  	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
>  	if (IS_ERR(p))
> @@ -450,8 +451,14 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
>  	}
>  	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
>  
> -	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
> +	ret = gss_krb5_import_ctx_v2(ctx, gfp_mask);
> +	if (ret) {
> +		p = ERR_PTR(ret);
> +		goto out_free;
> +	};
>  
> +out_free:
> +	kfree(ctx->mech_used.data);

If the caller's error flow does not invoke
gss_krb5_delete_sec_context(), then I would expect more than just
mech_used.data would be leaked. What if, instead, you changed
gss_krb5_import_sec_context() like this (untested):

471         ret = gss_import_v2_context(p, end, ctx, gfp_mask);
472         memzero_explicit(&ctx->Ksess, sizeof(ctx->Ksess));
473         if (ret) {      
   -                kfree(ctx);                      
   +                gss_krb5_delete_sec_context(ctx);
475                 return ret;
476         }    

Obviously you would need to add a forward declaration of
gss_krb5_import_sec_context() to make this compile. The question
is whether gss_krb5_delete_sec_context() will deal with a partially-
initialized @ctx.

How did you find this leak, and what kind of testing was done to
confirm the fix is safe?


>  out_err:
>  	return PTR_ERR(p);
>  }
> -- 
> 2.34.1
> 

-- 
Chuck Lever

