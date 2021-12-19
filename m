Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA947A1FF
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhLSUKo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 15:10:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43948 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhLSUKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 15:10:44 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BJ930aH017335;
        Sun, 19 Dec 2021 20:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3OAXFfji3PIHIv/2rkt7LyvtPSN236z6sP+8l1Cx/mY=;
 b=X9guxAcJ7ef/e/KPXOBArdEO59ebFfREajuKJG/2jXKBoLqnS9N3vjppBA0/Yug8cm/t
 f0JORzdt7epIHjyiPHd1uFPo1Iifp8SupB+XIaZLPyqq3UQ7ptQDL4W+A/yadHYw577v
 GHXr0VPD8ZZDMhmYL6o+W4njLYd97P2TsV890vR8W815z549uE1j1nMn9sdeDz5y9N31
 gUlOflX95LOn+eFpt9yUFMU9QwShu6UGQUD1hcFSoNp/z4gqX5HJ3kmGT5OIQRWJ7TTg
 W/7qFAqweoL5fBxhvMT9OcJTreXX7rbMAo69b3ktKZNcIOKUGA137mGfF/HTgQueHnT6 Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d17h9sycd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 20:10:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BJKAHHp144206;
        Sun, 19 Dec 2021 20:10:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3020.oracle.com with ESMTP id 3d193jvadg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 20:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blbFe78i8+HnJ3rGkJNRaqWlrmrg4KnnTYV6vdONR1H/YePF884OKZX2fad6bbPB3ZPwg92joXpUaqWb84vH6SGQai88y1KXH4DTn16PwqkYkbSGzjHoNRnLn9DB0JedOqEzYuaKLyOXPh8lkuEyj64f9mz2uK1MRZ52p6c3p+e3eH4mpkbFD4lzQQV4X2iZ75F+1ewyD9x6cLU4NoHaj2JUv39ji8g42Zp77QXA32QpbU2ayKhKAEME+E/pfPVFSNXfTiundLtTQ4trp/Pq24LbLe2YPBVjY4r4c5VavkcfKalOIBeS20b6E6KzKzyrnLV21WTy4nW5pIAQ2RR/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OAXFfji3PIHIv/2rkt7LyvtPSN236z6sP+8l1Cx/mY=;
 b=K2vNkgGibXsRkslfL/lsoCFtxICVdTZ/NxzuUW6mGG7SpFlfyMdotd34hAWt87jwk67F31+6XwgbMLXnIHNnZAtxYmT4IFc9vrK9iwYjwOY3H2PbgsvpIhkF6zidgWGVZQktnh89VMi2lJpaNXvBZaLY4tjmdjEdU5rVM5eFbF0SYvmyDZGNtqeMEQvCXCrJ9ha2N/S0yghB8zCTfNBcIl35fz2r8cvZDBH0oN35yJPzhJo2mEAq6w1QMmwX7UdAbCPpvdNsDRqp15hvun9sLOktvQ/B56vW1gjKI+zdRMd4pXrUY3e12vueXb2woNkRWMU6boZmGsO9xgWazM4CVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OAXFfji3PIHIv/2rkt7LyvtPSN236z6sP+8l1Cx/mY=;
 b=NzyK1iwNqeEJrPt5c32FK/sfYTDWaKdYBTUgy4AjImPN8pMxQocDYXz62u3wTtzdnzWUgofp06jU/KJ+3zPX+cb32NegzNlsRpMt4bwtgYW0NMLOjkHtGPtfiGYvuGaeRmgZwgOzwszIS4b2sN3MCSL0LMp321dvvoBm/Rp9e3s=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4938.namprd10.prod.outlook.com (2603:10b6:610:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 20:10:36 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 20:10:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] nfsd: Distinguish between required and optional
 NFSv3 post-op attributes
Thread-Topic: [PATCH v2 04/10] nfsd: Distinguish between required and optional
 NFSv3 post-op attributes
Thread-Index: AQHX9HoHis+nI73XsEy3XV75+2rrG6w6QAKA
Date:   Sun, 19 Dec 2021 20:10:35 +0000
Message-ID: <B6B9027D-D7EB-4324-9C26-9FDADCCCEFCC@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-5-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38f453b-354b-4105-e21b-08d9c32b9e8b
x-ms-traffictypediagnostic: CH0PR10MB4938:EE_
x-microsoft-antispam-prvs: <CH0PR10MB49381B5A31E600DD30F2034A937A9@CH0PR10MB4938.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pP3CukFWbZb2wqCGL5DPtEjzGY/a/gs8/cCzJN5Sw7FuJ5uRWw1egyf6hRTQ45xbYYp/iig2fiwL47z+WT5X5vWz3ftgH2cHcSqDJ5jJURpXZ0oY0qGzc/7p0G70e+3wa0mT+UAOWV6j+Aq/iXrxhSOp1zRikTgnnjLezuYBADKe5ujcEM+X62oLRhAGfBcchGlVxx8yvBR30RkvXLUN20ahThGJqcpfZwIhJctqovXUP10S6SESqwoieBaWQhQokM311GAswm5N+0zd+M3zpmv0Ia7iM/7rljMJgLNVMy63vhJr2DpKj7YUTlIsZ5/Hu6/tAZ+8RdkWKqmXaDrDLX/Lkn4HsJMapynD5nUP9k8qyL7MnReoPrrP/+0j731DAqAc0VplpjWwWZuQuFZ65S4+ixXVvzydoV5mJKRbJxsckoFtQy4DIhqS3V/3UDajIXLlhOf/zQmgZ/wfkXyJ/FZV1W0RlDO5IbX4KEJH23OB2XdXBLqHQilczVst4Hlr2MFIAHOruU3VQPRWnKbdesJpEtxZT1+CQEtmqB0hOXFgq/41EslwxAuaiA8nKCvq6hsXoJ/pBglx9T+mwJ/ENMXEFpqK58IpKtA4ZxdJMB1mCDtIUGBHyTmfhXbN9GFFEWU7fYRc29rz+l9dCdaKeZbgfIJHWo46hlsJ8d1ljqv4hqWJ3oYvLLkXMZXJGcsxjdYMvZVSsZuhGCqUrERdv9rJy5Ub1Mbp2tIlWiSh0yBrEt2Xxpz2Fab3tNnFU5Ac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(6512007)(8676002)(54906003)(186003)(6486002)(26005)(53546011)(5660300002)(4326008)(38100700002)(66446008)(66556008)(64756008)(66946007)(66476007)(71200400001)(76116006)(8936002)(2616005)(122000001)(6506007)(316002)(36756003)(86362001)(2906002)(6916009)(33656002)(83380400001)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ocxaFRvTIdNrN9bidrjDp3WQVurLoNtQqKBmNSipDwOhoEyThBE84M4sqFNw?=
 =?us-ascii?Q?Vd/etnMHDOa1mBZ+JzyGpNw7JEJnBDyvAcQpL4mTzj9ziGeYCKeR2PoKB9uV?=
 =?us-ascii?Q?d4TIkZO35JfGGqU5w5FCkMMnto78ah2dytwbtw7bS3WYGfIie2Fr8c3ALOct?=
 =?us-ascii?Q?jSkzPzbUPkJhQ6OD54tQh2cusL0afxhQijySD7Nm6/mt1R12thsSas5R9BOr?=
 =?us-ascii?Q?VeT/D8JbAOJVyVrNAR7fZFaLszF8nUqG3dCG6qcbkVPxdciKGxbJHLkOymqk?=
 =?us-ascii?Q?DnnIHyK0R3GtETe/qQClosImxO23lPNFTgxSn1cUIvN/BWdHZlzRot1JfRHG?=
 =?us-ascii?Q?v6CXLtSPFaMzadgKAdHronA7uqlx6w0kd/v3tfvDS8sGygpmAChJrujxMONm?=
 =?us-ascii?Q?Wk6ES3lOQSLNGG81UHhKqfxu61z9Mf3jsgqEvXpYPwDkuaPVr1B4dIC/bw9Q?=
 =?us-ascii?Q?8or/isQIDIq3d1TXg7xIZWKqpCP78rXORaN3BlkVcxoS3M2JnHkTrzpQTqJW?=
 =?us-ascii?Q?o5w15dbenxhD2LvZIhkmYzoKVnVOY9LGgP1Fn5VZCADZplQZvITMV+hdHejl?=
 =?us-ascii?Q?3DoDmoJ1hH9PJTtkis5rdiArHqdmgTarZNpwH2gBRxrXws1ZRVYMB9JcDmaR?=
 =?us-ascii?Q?4OybYDj7qlmnbbockZ4hJnCRAMcNV52RSRAKHsvBsLhvVShVs1HMg767YmyF?=
 =?us-ascii?Q?2cV9ESI+oHlI4rbSyMuZb8tQW66CW39TNkyCPlwSFVGaxQ9QbKZjsGS+QLO3?=
 =?us-ascii?Q?LEqJ8ogF+Yo5hON2gQXmR8Vr8113gfM2sLnkYx5uRUM/hskGOcGGCjqiKQMY?=
 =?us-ascii?Q?+aNyGcPcBPe7HhZpRfG2irRFeWaVBYZtvcI/w0vGsMKANv6Nrr3UbWxE+sjR?=
 =?us-ascii?Q?Ig/ASZTalHRGsxk8stQyD5MKiW3ve/mDrIj4SjTWPG3RDpnsozW+Ow5NI02t?=
 =?us-ascii?Q?kWeU+pRbqsoHZufWhJQj64LOk3vI6Hwnn2S5ZYBd4ANMsGse36L8uZaLCllE?=
 =?us-ascii?Q?OZZaXWSoF6l87MaU/yqVf3VIfFt1hnPpOFuRZysahrLIzfvaUIpSixDW8gGp?=
 =?us-ascii?Q?/E9y9ov8XIaWGUH1016//5m1CYk512G1E+KD56ScyUvxy1+uLd4hRveTQTjj?=
 =?us-ascii?Q?tXH7RBm2Ny9Bx7P3H1hrvB/02WGUDeCGhbWXKx0RH2wD6yuWyHUV8arVeSeI?=
 =?us-ascii?Q?I9pw4jaZKqtXi8mQPWVdkJ456V1BcCnrfJg2OOso57jahqORvQg6KCW1T8jZ?=
 =?us-ascii?Q?+FlZplAb53r2mIEhB7QnPS3OR5ECO7ILbHEwn5pjW+jqKLk1jl3/hQ7qiDHO?=
 =?us-ascii?Q?Au5QAfuV+7Ghvtjo5mkvyFNLMsCnYWNTAR9dNZ2756B9tnHQ1LqbLuXEXIMs?=
 =?us-ascii?Q?rqk1zTbGV07UiYfQauUkFeZc/5c2/lSF2N6ghFvHbtY9VDpB5Smao2CUzfP4?=
 =?us-ascii?Q?yvPBRdEyGgVQQBA6lucDJdj+O7ieqLiUFgPjaQISA2rkHK8iLyQB00wBhSn/?=
 =?us-ascii?Q?ZKBEzafGphH49m2sqbTV+9Zi73kQ5bmwAKXzlrepqUHYU7/GKJk2mcn1RYvq?=
 =?us-ascii?Q?8Ov3Tv9jRos0UAonYaMpDVyC5pB+dkGRivrTbSz4+nxcFvigOG1ygWhuT1o9?=
 =?us-ascii?Q?7E8yZpVv3Lwe9snoX6jq8hE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE86BBBDA764D144A1EA035B1120FA19@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f453b-354b-4105-e21b-08d9c32b9e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 20:10:35.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDUs/rySKyxY8PG8fMbYCyR1H0y5lZr3dbl1neIQoXIpQqRi0RtXl6HgiS/OadvgxH6G/wyT8lKbRtwul3d35w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4938
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112190128
X-Proofpoint-GUID: CYOjLAzVl2oRZs6UnRvDVZ_HV6Lw9WCy
X-Proofpoint-ORIG-GUID: CYOjLAzVl2oRZs6UnRvDVZ_HV6Lw9WCy
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2021, at 8:37 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>=20
> The fhp->fh_no_wcc flag is automatically set in nfsd_set_fh_dentry()
> when the EXPORT_OP_NOWCC flag is set. In svcxdr_encode_post_op_attr(),
> this then causes nfsd to skip returning the post-op attributes.
>=20
> The problem is that some of these post-op attributes are not really
> optional. In particular, we do want LOOKUP to always return post-op
> attributes for the file that is being looked up.
>=20
> The solution is therefore to explicitly label the attributes that we can
> safely opt out from, and only apply the 'fhp->fh_no_wcc' test in that
> case.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfs3xdr.c | 77 +++++++++++++++++++++++++++++++----------------
> 1 file changed, 51 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index c3ac1b6aa3aa..6adfc40722fa 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -415,19 +415,9 @@ svcxdr_encode_pre_op_attr(struct xdr_stream *xdr, co=
nst struct svc_fh *fhp)
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
> 	struct kstat stat;
> @@ -437,7 +427,7 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr,
> 	 * stale file handle. In this case, no attributes are
> 	 * returned.
> 	 */
> -	if (fhp->fh_no_wcc || !dentry || !d_really_is_positive(dentry))
> +	if (!force || !dentry || !d_really_is_positive(dentry))
> 		goto no_post_op_attrs;
> 	if (fh_getattr(fhp, &stat) !=3D nfs_ok)
> 		goto no_post_op_attrs;
> @@ -454,6 +444,31 @@ svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, s=
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
> +

Thanks for splitting this out: the "why" is much clearer.

Wouldn't it be simpler to explicitly set fh_no_wcc to false
in each of the cases where you want to ensure the server
emits WCC? And perhaps that should be done in nfs3proc.c
instead of in nfs3xdr.c.


> /*
>  * Encode weak cache consistency data
>  */
> @@ -481,7 +496,7 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct=
 xdr_stream *xdr,
> neither:
> 	if (xdr_stream_encode_item_absent(xdr) < 0)
> 		return false;
> -	if (!svcxdr_encode_post_op_attr(rqstp, xdr, fhp))
> +	if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr, fhp))
> 		return false;
>=20
> 	return true;
> @@ -854,11 +869,13 @@ nfs3svc_encode_lookupres(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
> 			return false;
> 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> 			return false;
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->dirfh))
> 			return false;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->dirfh))
> 			return false;
> 	}
>=20
> @@ -875,13 +892,15 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
> 		return false;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
> 			return false;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 	}
>=20
> @@ -899,7 +918,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
> 		return false;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
> 			return false;
> @@ -908,7 +928,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
> 			return false;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 	}
>=20
> @@ -926,7 +947,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, struct=
 xdr_stream *xdr)
> 		return false;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
> 			return false;
> @@ -940,7 +962,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, struct=
 xdr_stream *xdr)
> 			return false;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 	}
>=20
> @@ -1032,7 +1055,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, s=
truct xdr_stream *xdr)
> 		return false;
> 	switch (resp->status) {
> 	case nfs_ok:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
> 			return false;
> @@ -1044,7 +1068,8 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, s=
truct xdr_stream *xdr)
> 			return false;
> 		break;
> 	default:
> -		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> +		if (!svcxdr_encode_post_op_attr_opportunistic(rqstp, xdr,
> +							      &resp->fh))
> 			return false;
> 	}
>=20
> @@ -1188,7 +1213,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *=
resp, const char *name,
> 	if (compose_entry_fh(resp, fhp, name, namlen, ino) !=3D nfs_ok)
> 		goto out_noattrs;
>=20
> -	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
> +	if (!svcxdr_encode_post_op_attr_opportunistic(resp->rqstp, xdr, fhp))
> 		goto out;
> 	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
> 		goto out;
> --=20
> 2.33.1
>=20

--
Chuck Lever



