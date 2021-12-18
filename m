Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA6479CCC
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Dec 2021 22:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhLRVQz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 16:16:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49242 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhLRVQz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 16:16:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BI9nFMF010644;
        Sat, 18 Dec 2021 21:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qHpt/bxJD76+c1IvzD7qcb9D6by3gwY//jiU6v0mgo8=;
 b=CcUUmRQ80wzqEo8LULVeMSjyvHHC6A+Fuyt4QFuto3fQ5d0N1VBsNRbOjSmOvCBC2Rkz
 lcgJZyoRQ4rOX6pSDOsZw051eSXXymh6FBwP0RdIvKHanraXElPClXQ38eC6DaSI4YV0
 TR0Z/0kPvixHdI5hGFyyEB191WtpHZjlYWuHJlmCWDLfM6uDfJ+mXM4gTUfS3fjCpkgX
 US00b+NQP5XTeuXgLgKm8B99ThJAxqWeDb/4VW0X5LoGGhYuOEXAgneyYk3+/hhyGfbF
 cgi4Z5MoSMIKPPitcM2xxArbV9X+UCKFgu9v3AR3mHRfy6ePZnFvH2Al6vB6HvJfUosZ VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d16e28x27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 21:16:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BILAt1s093899;
        Sat, 18 Dec 2021 21:16:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by userp3030.oracle.com with ESMTP id 3d14rsp9fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 21:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DloqAmiTGkrMIhMxbz/8TKf0ZyF43QpBakUWg4zOqn31zPjZRCI/uRcSDLEbxJUNCvFdEckX85wrKRNKt1u/KFFV3VVZYesa9tHJwSBSzBULXYvos/NWH/CQhJCNtEstBgj80KmYaX2ArNw07lCfd7GgeoKcrgJidgQucUrGlwowc1xVL/iHVgVAawGEnThiYPFM/nhOjqfwgQQVhcP/TjIxqY5a/D4bh9jl5cg1WHHbwT5AnGu+vtVGoYi1dd6rvKGbI5xkNXEBYA3nKCXrgkggEOqrPH8ELmGrEmlACZyajxnp0cMnfZBi3q2pFlG+ztyP+FQmsA1OwKsBmYygqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHpt/bxJD76+c1IvzD7qcb9D6by3gwY//jiU6v0mgo8=;
 b=H8dwRhGXSkT72BXKAw929jxDG+i2WS/2ZEBMJliDIeJLELjpid4NJyJra7Qxswq9tmZqUhJ9gvAWOIlPYgtaImv6L2BFDDcrnkhlZpDgVRgixAvBwJYPiHWAF4TTCjUzhc10rzHX9YQot4VvqUToxteFkSBIn8wobGJ73VxtPxr4YHoMgcjf2oVkQ1+rNDxQd2oWG09xeNpcmkOU1BA143zJt2f+pvqWlyb99XOeG6Mf6Mn+gf1rVYz6xA7IEhxUSL1FgAelH3KJuc/vDhEyDQB8gqCMDKLMXkJV/QhIr6Mgo8HOU93WAvpgFpi4bzpwHEC3S0yyC+bPP/pMMCdgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHpt/bxJD76+c1IvzD7qcb9D6by3gwY//jiU6v0mgo8=;
 b=HQMnJfLAaziqEcuyK6GG89CNWTaJ+Ow7NaFEok/mxYKfuss1ECgOxrA8YbfNFYtsyRp1GBcFrb/sbKvU+tFoK9F0aDY/Syt2JZkO5zS7SuG9I9lt8ivLsKUBYl9lCPgVfEM/fvrXss7va5Mlc7YdR55l7bSpjUgfL7ehXDyAT7k=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Sat, 18 Dec
 2021 21:16:47 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 21:16:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/9] nfs: Add export support for weak cache consistency
 attributes
Thread-Topic: [PATCH 4/9] nfs: Add export support for weak cache consistency
 attributes
Thread-Index: AQHX85EPDkLj9K7UokKc8Jn2/4fx5Kw4wf0A
Date:   Sat, 18 Dec 2021 21:16:47 +0000
Message-ID: <01D9E7C4-25F2-4C99-A4FE-2741A5722F58@oracle.com>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org>
In-Reply-To: <20211217215046.40316-5-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 090baf2a-3b25-4c2d-7312-08d9c26bb337
x-ms-traffictypediagnostic: CH0PR10MB5067:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5067631B44EC1D5E6FE9C67793799@CH0PR10MB5067.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXNJMPSOJTqixEdY/S00NAVRm9mqXP221VA+BVSwQo35W6q21MHMeHtAlXMiyLWCkdru0F4PRuHZoC5hzodqgS3gnPPPx3LYFblUkp273JZUjeiNH1Y56UfMbf93O7jRofJ0pY56aV2MlBEexvVZG7nBdlXhSNEAjrVSETW75gmt4BvmPi/C+7U1PJzTInqffzg2Jm6BDKrJQ45hS0XReAEEVkuOgCemiLfSp94HQ6N9cnEKEvoO21v1BbReBim6fq//LVj1taY29M34tAbsFgF1xFvHtffSlhSROXJPiVG/1aOB5MnIO9st7ikfhxSV4iqW4iz9woIC00KEAsQNLvSD7qO0NTYUob0ctOyxshaie3C1asHHGa0gLWJUJhEIWoX6jF5zMdM3I3LMSLBLmVG/SwJybuDmbk5a5RSqevxoh2r7+FSJZgx+99dLutUp4vnNeJlas9/r7Cfd/5PC9vaq1A7eti7WMC1rhe6MTAyqCnJT/TejVFl1Cq+clZDqF3Y//zn9RB+t4+/+yNNtmGEbjb6pVQJoWRpQhWJd7EOokfUMACHgLCFmuxemAWfNF6mG2CRDSAaElUjR7KkgoQjUUJHbt4LIBPyfzzR13IxBzTCbhbIa98k5yoQHftMaRnb2mdMpKK0pH7bl+Yh40OVWhELw9yTvKn+9lEzPRtBLpcgO83O8acMU6G10lrKijdS5+gPlBFxKysfi+38VoeYEQW0LDVk/txWTFTrn/n7oaBtJknBvDTZo4qjugjDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(83380400001)(33656002)(38070700005)(30864003)(71200400001)(36756003)(38100700002)(6512007)(86362001)(122000001)(6486002)(6506007)(6916009)(66476007)(66556008)(64756008)(54906003)(53546011)(66946007)(316002)(26005)(8936002)(76116006)(5660300002)(8676002)(2616005)(2906002)(66446008)(186003)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IoxFSqYwF5ZkEGEauC0M2RL99kTZ2zbhYUrd0707G9A8UzYjASl9YSdPt+bA?=
 =?us-ascii?Q?1yERcy3bpaJrfMlYk7H8/py4uzsAf+UWJQ8FkFUCZQAXHbIaOGydYXSNU+27?=
 =?us-ascii?Q?I18N3SwsL+TDY4m/kSOGmQBNT8cg2PHPV0kxHmrpPY7luapj9NqiBQ+4jMO7?=
 =?us-ascii?Q?avHavLZnphpgg2K/jO/yWs4AKezEdqLHHtUOBC+LTf3IbY8dFjhciG6x3Kum?=
 =?us-ascii?Q?b9woVeUfyK9R4+Xbi7zSlCMbhjwUkv1FnsTkHRWAHyIAxyccQLpTG507Jzdx?=
 =?us-ascii?Q?jiMwZ6wlZPM/IJT5HBV1tojv0KjYPDkTLrwa0inlS8WQtn5qS2os5toL1E6+?=
 =?us-ascii?Q?2q+V5P3GiapIY6qCGGy94i73+6pUtmNYwgE16IPhLKQWlY1VJ1gHOAcxvBXd?=
 =?us-ascii?Q?V+yXkqh/9Zd6Pos8c8d3yyPz3HTYIzLLTCtQVisVLPwdsSWIDyEuR+rVKKJO?=
 =?us-ascii?Q?ELqlID16xmduwdnj+fKDpGylc8XHEBeISwwkFHklHsOlvvmV6axvpHnSW+QD?=
 =?us-ascii?Q?Hoo+y/6fLFBLseUxHDrojMuF4DwZSTxsC5PO25fPC10BecHqJQJw0ttDJkpE?=
 =?us-ascii?Q?tjbZKELMxve4X0MPCxNWzOzmiBB6vy2DTH4gzxwRh9lpTjdENhFCiEyG2L2i?=
 =?us-ascii?Q?BzhCZOmJVLpx9IWaKzQPlH51Cb9ZHJx2ocHQ+ne6q2gw3A94kYMIPLzKM0/x?=
 =?us-ascii?Q?Fb+GPz6g2hYLt1sEFORUwVUnPodLG+8jdTNUvdL+wfIUiuRDXhPLUh0RjRZN?=
 =?us-ascii?Q?YUo83sIbnh1PSz6fb4pF/+XE+DtEUJeRmpvyDveZd3zLdHO/iqOGOdYbG8mV?=
 =?us-ascii?Q?Z0FlvcTczDbMCe2R5xhwLLHD2csZOWoKrY/coLy2R3KVJ2LlG9su9o0hfdu8?=
 =?us-ascii?Q?xWyVWavBPULp1kWez5ofnPfzVeVVB83L5UFqwarwt4meDuF3fQNpU45oJUBh?=
 =?us-ascii?Q?uw/QHdRmgIBoWmSGWbCFDit7n6RrIsYeq8+Xn1Yo52BOqcNNbS6137r6A19g?=
 =?us-ascii?Q?Dug8Jk7dsTzAsmCuEr9ymcvYBTEzSNjg0ep1Pbd+4ogqvQB71XE1BMMb58NZ?=
 =?us-ascii?Q?YWiEfLyYTGZLPOWvc6Ei24nuIOXjlwq0Fj0O49shLWjAK+CK/1p3L0PXVYLi?=
 =?us-ascii?Q?8TMZCSzTZFSXdpfQOEUzCvzBzrp2VyDQAbLuL1o9opZ24MwA1AyYxtH8Avyl?=
 =?us-ascii?Q?2eiExmOANHuMl4uHksPFfJZYQiGcPOs7lbh7qk97FPV3EOfWvcBEoQYqXNXI?=
 =?us-ascii?Q?rmGIsgjlbsEFqZAmM1iamOKfHNJlML+efpxPWxmkux0EtMKoltAeXHH1fZ2n?=
 =?us-ascii?Q?0r7VM11bHiZbwufmGFFmqK9RatMo7XMWMxFVOtOb+rVJNyH5JVo3gsVUuspp?=
 =?us-ascii?Q?K1yHIgaRmkPPntiD9uNlZktxVlX+m8VwaexLbfgvS91nV15JacR2kR/EGNxh?=
 =?us-ascii?Q?s7A5jVlPxNc8KMCuOKeZjWhjIZppLz2bheZ/4NISPg5Z9OS2R4u1f8l+0TvD?=
 =?us-ascii?Q?FRihuqiGtZg/5SMZfNeYUhKsM3WmHVtsaRKVDZKmeepPmOA1blwISRYxyAJ9?=
 =?us-ascii?Q?Ml7Y4R9Q2DW69PmsNjTBHRVasfTApfIrfY6YMWE/0mzJ+7IjEa2UlV0xpCZK?=
 =?us-ascii?Q?6sELRFt1ZG46mdDEJQGGxYM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D08262CB4BFD947A53C67D4960E05D2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090baf2a-3b25-4c2d-7312-08d9c26bb337
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 21:16:47.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwdGBcUppfVQYrApwbo5bD5P6P5kQ6o4ZpL0SWTseNuwWVDWNZhDb6lkXcih6N0NXvIPY+OKP2qVoyCU4RjEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10202 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112180129
X-Proofpoint-ORIG-GUID: zWe-ynFmt259n5ygF_0gpMB0vsTbGjYH
X-Proofpoint-GUID: zWe-ynFmt259n5ygF_0gpMB0vsTbGjYH
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Dec 17, 2021, at 4:50 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>=20
> Allow knfsd to request weak cache consistency attributes on files that
> have delegations and/or have up to date attribute caches.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

This one does not apply to v5.16-rc. Please rebase this series
and resend.

More below:


> ---
> fs/nfs/export.c          | 24 ++++++++++++
> fs/nfsd/nfs3xdr.c        | 83 +++++++++++++++++++++++++++-------------
> fs/nfsd/nfs4xdr.c        |  6 +--
> fs/nfsd/vfs.c            | 14 +++++++
> fs/nfsd/vfs.h            |  5 ++-
> include/linux/exportfs.h |  3 ++
> 6 files changed, 103 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 171c424cb6d5..967f8902c49b 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -151,10 +151,34 @@ static u64 nfs_fetch_iversion(struct inode *inode)
> 	return inode_peek_iversion_raw(inode);
> }
>=20
> +static int nfs_exp_getattr(struct path *path, struct kstat *stat, bool f=
orce)
> +{
> +	const unsigned long check_valid =3D
> +		NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_ATIME |
> +		NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME |
> +		NFS_INO_INVALID_SIZE | /* NFS_INO_INVALID_BLOCKS | */
> +		NFS_INO_INVALID_OTHER | NFS_INO_INVALID_NLINK;
> +	struct inode *inode =3D d_inode(path->dentry);
> +	int flags =3D force ? AT_STATX_SYNC_AS_STAT : AT_STATX_DONT_SYNC;
> +	int ret, ret2 =3D 0;
> +
> +	if (!force && nfs_check_cache_invalid(inode, check_valid))
> +		ret2 =3D -EAGAIN;
> +	ret =3D vfs_getattr(path, stat, STATX_BASIC_STATS & ~STATX_BLOCKS, flag=
s);
> +	if (ret < 0)
> +		return ret;
> +	stat->blocks =3D nfs_calc_block_size(stat->size);
> +	if (S_ISDIR(inode->i_mode))
> +		stat->blksize =3D NFS_SERVER(inode)->dtsize;
> +	stat->result_mask |=3D STATX_BLOCKS;
> +	return ret2;
> +}
> +
> const struct export_operations nfs_export_ops =3D {
> 	.encode_fh =3D nfs_encode_fh,
> 	.fh_to_dentry =3D nfs_fh_to_dentry,
> 	.get_parent =3D nfs_get_parent,
> +	.getattr =3D nfs_exp_getattr,
> 	.fetch_iversion =3D nfs_fetch_iversion,
> 	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 0a5ebc52e6a9..81b6cf228517 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -415,21 +415,14 @@ svcxdr_encode_pre_op_attr(struct xdr_stream *xdr, c=
onst struct svc_fh *fhp)
> 	return svcxdr_encode_wcc_attr(xdr, fhp);
> }
>=20
> -/**
> - * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
> - * @rqstp: Context of a completed RPC transaction
> - * @xdr: XDR stream
> - * @fhp: File handle to encode
> - *
> - * Return values:
> - *   %false: Send buffer space was exhausted
> - *   %true: Success
> - */
> -bool
> -svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xd=
r,
> -			   const struct svc_fh *fhp)
> +static bool
> +__svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *=
xdr,
> +			     const struct svc_fh *fhp, bool force)
> {
> 	struct dentry *dentry =3D fhp->fh_dentry;
> +	struct path path =3D {
> +		.dentry =3D dentry,
> +	};
> 	struct kstat stat;
>=20
> 	/*
> @@ -437,9 +430,10 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, s=
truct xdr_stream *xdr,
> 	 * stale file handle. In this case, no attributes are
> 	 * returned.
> 	 */
> -	if (fhp->fh_no_wcc || !dentry || !d_really_is_positive(dentry))
> +	if (!dentry || !d_really_is_positive(dentry))
> 		goto no_post_op_attrs;
> -	if (fh_getattr(fhp, &stat) !=3D nfs_ok)
> +	path.mnt =3D fhp->fh_export->ex_path.mnt;
> +	if (nfsd_getattr(&path, &stat, force) !=3D nfs_ok)
> 		goto no_post_op_attrs;
>=20
> 	if (xdr_stream_encode_item_present(xdr) < 0)
> @@ -454,6 +448,31 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, s=
truct xdr_stream *xdr,
> 	return xdr_stream_encode_item_absent(xdr) > 0;
> }
>=20
> +/**
> + * svcxdr_encode_post_op_attr - Encode NFSv3 post-op attributes
> + * @rqstp: Context of a completed RPC transaction
> + * @xdr: XDR stream
> + * @fhp: File handle to encode
> + *
> + * Return values:
> + *   %false: Send buffer space was exhausted
> + *   %true: Success
> + */
> +bool
> +svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xd=
r,
> +			   const struct svc_fh *fhp)
> +{
> +	return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, true);
> +}
> +
> +static bool
> +svcxdr_encode_post_op_attr_opportunistic(struct svc_rqst *rqstp,
> +					 struct xdr_stream *xdr,
> +					 const struct svc_fh *fhp)
> +{
> +	return __svcxdr_encode_post_op_attr(rqstp, xdr, fhp, !fhp->fh_no_wcc);
> +}

I don't quite understand the need for splitting encode_post_op_attr.
At the least, more commentary in the patch description would help.
For now, I will study this and get back to you.


> +
> /*
>  * Encode weak cache consistency data
>  */
> @@ -481,7 +500,7 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct=
 xdr_stream *xdr,
> neither:
> 	if (xdr_stream_encode_item_absent(xdr) < 0)
> 		return false;
> -	if (!svcxdr_encode_post_op_attr(rqstp, xdr, fhp))
> +	if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr, fhp))
> 		return false;
>=20
> 	return true;
> @@ -879,11 +898,13 @@ int nfs3svc_encode_lookupres(struct svc_rqst *rqstp=
, __be32 *p)
> 			return 0;
> 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> 			return 0;
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->dirfh))
> 			return 0;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->dirfh))
> 			return 0;
> 	}
>=20
> @@ -901,13 +922,15 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __=
be32 *p)
> 		return 0;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
> 			return 0;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 	}
>=20
> @@ -926,7 +949,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __=
be32 *p)
> 		return 0;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
> 			return 0;
> @@ -935,7 +959,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __=
be32 *p)
> 			return 0;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 	}
>=20
> @@ -954,7 +979,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32=
 *p)
> 		return 0;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
> 			return 0;
> @@ -968,7 +994,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32=
 *p)
> 			return 0;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 	}
>=20
> @@ -1065,7 +1092,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, _=
_be32 *p)
> 		return 0;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
> 			return 0;
> @@ -1077,7 +1105,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, _=
_be32 *p)
> 			return 0;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return 0;
> 	}
>=20
> @@ -1221,7 +1250,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *=
resp, const char *name,
> 	if (compose_entry_fh(resp, fhp, name, namlen, ino) !=3D nfs_ok)
> 		goto out_noattrs;
>=20
> -	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
> +	if (!svcxdr_encode_post_op_attr_opportunistic(resp->rqstp, xdr, fhp))
> 		goto out;
> 	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
> 		goto out;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..e14af0383b70 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2865,9 +2865,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
> 			goto out;
> 	}
>=20
> -	err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_S=
TAT);
> -	if (err)
> -		goto out_nfserr;
> +	status =3D nfsd_getattr(&path, &stat, true);
> +	if (status)
> +		goto out;
> 	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
> 			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
> 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a90cc08211a3..4d57befdac6e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2412,3 +2412,17 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc=
_export *exp,
>=20
> 	return err? nfserrno(err) : 0;
> }
> +
> +
> +__be32
> +nfsd_getattr(struct path *p, struct kstat *stat, bool force)
> +{
> +	const struct export_operations *ops =3D p->dentry->d_sb->s_export_op;
> +	int err;
> +
> +	if (ops->getattr)
> +		err =3D ops->getattr(p, stat, force);
> +	else
> +		err =3D vfs_getattr(p, stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT)=
;
> +	return err ? nfserrno(err) : 0;
> +}

Please add nfsd_getattr() in a separate patch ("Refactor:").
And please include a kerneldoc comment for it.


> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index b21b76e6b9a8..6edae1b9a96e 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -132,6 +132,8 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh =
*,
> __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
> 				struct dentry *, int);
>=20
> +__be32		nfsd_getattr(struct path *p, struct kstat *, bool);
> +
> static inline int fh_want_write(struct svc_fh *fh)
> {
> 	int ret;
> @@ -156,8 +158,7 @@ static inline __be32 fh_getattr(const struct svc_fh *=
fh, struct kstat *stat)
> {
> 	struct path p =3D {.mnt =3D fh->fh_export->ex_path.mnt,
> 			 .dentry =3D fh->fh_dentry};
> -	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
> -				    AT_STATX_SYNC_AS_STAT));
> +	return nfsd_getattr(&p, stat, true);
> }
>=20
> static inline int nfsd_create_is_exclusive(int createmode)
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 3260fe714846..58f36022787e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -10,6 +10,8 @@ struct inode;
> struct iomap;
> struct super_block;
> struct vfsmount;
> +struct path;
> +struct kstat;
>=20
> /* limit the handle size to NFSv4 handle size now */
> #define MAX_HANDLE_SZ 128
> @@ -224,6 +226,7 @@ struct export_operations {
> #define EXPORT_OP_SYNC_LOCKS		(0x20) /* Filesystem can't do
> 						  asychronous blocking locks */
> 	unsigned long	flags;
> +	int (*getattr)(struct path *, struct kstat *, bool);
> };
>=20
> extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> --=20
> 2.33.1
>=20

--
Chuck Lever



