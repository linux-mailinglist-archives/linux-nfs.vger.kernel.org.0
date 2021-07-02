Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5D3BA431
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jul 2021 21:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGBTGp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jul 2021 15:06:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13900 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229794AbhGBTGp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jul 2021 15:06:45 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162ItUjM004350;
        Fri, 2 Jul 2021 19:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gyG+s/y/021YgIjLL7qf/d0Uxa9sGQCbZkAH1SheWYQ=;
 b=H57D1AjyYfx+0bIrfV3Y6GL3rHWgLTvySyqi1yMl9Mew0B6ePk5DwiCh+7W0/j99rfHe
 fY3smZP9U1iyzReZwuTAXIywMpMd4AwqPr6F+kBc/RMs5YTU8GX0iFP2xKZOn4LBfvYJ
 rd6BRZBrDEbRSvOWqBsqPo/QtyXBRNEQaG6xOx+WRIirvJFhlTvk8XlpBlMX/uvEduGD
 iTMHBbQyHf7SUzJdmSguNXYeAbbalrbKQGjY/gIxZEbIvUSlrPXVb1mLsjd0JYSQb2ln
 kDeYObuJdOaIK0ejSUW1nrUmFaEonuDSHbo1VnnTD0+bGVytJKT+m4isTvpudB9c+HGG Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39htf6sgcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 19:04:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162Iu4aq158873;
        Fri, 2 Jul 2021 19:04:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 39dv2d81ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 19:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Tc6KhCtSmgRSi2HuVFN56VuNvY3mDDaLGG5YuPLUYV8xLF4MOdQ+xAGX6GY+RoDD5OvvQGXuwjMoyeWu1LkJBUyXbC/4eJ7J1KGyjecg6LKg+tn7x+AMXPFPn4gS5KSjnt0pCAxr+fv232g0K3dCo+TPpXqnpyNirKxw8U7LEDcj7zyQLYJZCTpmTYNNWSerZ5MQCzMXBiBSsdq+st9lMF+Iv+OU5ZjftpdpeLZxNeGtF/7D2dkHCQBDDeCUfheEB6DSFPyuAHWmGlUGA32BMrnRZABrhiUa1aCcf/dSCS/IrQpI2iI2Vopb8Jmv83i4xGSbVBEzVa9zmGsoTV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyG+s/y/021YgIjLL7qf/d0Uxa9sGQCbZkAH1SheWYQ=;
 b=hZwwhM5+kEoe/Ge3NkZL9dDFszK0K7l19jkyolQl0belvJkRQKjxDm6pEzziQx2rLxULNyyC1phU6j+5pdPF9407NY3R3GE9GDX71i5ASrOvbQJfjN3bCjcuUHqAXkXPD36a/WnDePWxpzg4jQNSw6vkw9unpfivoIfGVSxWwwoq533XO1A8MPiGR50i22UmQWHulMWhis6t4oIugvDMx0QkDSlVrYCLtnGRXqfS/3qAT/tVPvvPhq8jbHiptIvy8MN5LxyyrViY50BA/2iQ62HRoqUfqUtRpKFLEWYZBP+//NJWL8otkKHeJcGD6U1A812NXoaPmrLWQ0A8cZ36Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyG+s/y/021YgIjLL7qf/d0Uxa9sGQCbZkAH1SheWYQ=;
 b=VcPtAs4MPG87YNdL4FFdVRmMYZ8SQUTlT9P+ZACJY7GLhdiU2DuqJVznWucj/HSWrH7Ow9RxE7G57gqYufwP/xxCZu1el8QoTeVrloIVeU8PQPTATemZXrJvWABGYu4lI4VMVricc4HsgMPJm21+TbO7neQqKGXfoKqIzSavjXU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 2 Jul
 2021 19:04:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4287.031; Fri, 2 Jul 2021
 19:04:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix NULL dereference in nfs3svc_encode_getaclres
Thread-Topic: [PATCH] nfsd: fix NULL dereference in nfs3svc_encode_getaclres
Thread-Index: AQHXb1g9rry/qWwViESBGsAmTSv7g6swC2EA
Date:   Fri, 2 Jul 2021 19:04:09 +0000
Message-ID: <19495FB8-43F1-465E-AABE-E0049F578D22@oracle.com>
References: <20210702153751.GA29685@fieldses.org>
In-Reply-To: <20210702153751.GA29685@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e08513fe-1f9e-471c-978d-08d93d8c2bf9
x-ms-traffictypediagnostic: SJ0PR10MB4527:
x-microsoft-antispam-prvs: <SJ0PR10MB452783C2F51758C6F7A3ADDD931F9@SJ0PR10MB4527.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJehCQgAw3RcrXZYlxmkIg2073ftIk1kHH8tXcqAGVkIMXJP8Y/VfmztCBNuuoM9IQQOkzsIAE7VPGsDfk9jc30r2gBlakodf13AYFjBN4a/OXAnjWDK6y2Lu8hrC8ib4D4CndR8Dv825L3Vt0rN1vkcHG5pwd/fHeKvpBpV5kkutvraXl93zBGV0qSYmS6Nt5FSUGn3NNZzTUOEAY2YrKyWbFzJ7Iw8Mfm5BTH6vXelcE2o7p+FKA006R2RW62iTrD2zPxaSgrPNPl4qUYdKRhjiy+jcR2uZX9Ks2Y5GcJepEAbzNIFeOWmj9YzzD4za9yOJgDK1o6QA9i1+0GuBh2IMAVn/1CMxq09ju7zpOeZZI43DR4JxNcOyVB0Y3R0VcpPbBgEN1TwN9m824QxSAfgeNF/tjyuu024p+27i0liIVq0LmeCaFIU7oXBk1d1PzEOAZOJwkAJSNRHLxHfck92/IFUP6FqPYDn4MYMc7gxJCamAcVwMCvIihEXLQjd5+DIVghHbxt+rGJVT7N0ADuBxFuBRJkv/eZBF2aUztbd5HwCXXCoKDiQ/y/0ff6fQkqYa52vbA4bePJ25bv/coTbN6WyOUT+aHPR4TxOZ0Ny+ZK+OGkC/qOe0wnmBNfpxZpagjG2faeZvyIQkgh8F8t2nMtrT2ncFdaTFOmYwB7RgOrk3fdoiVTcMXIppHrKYYfbvp3EHegB1VKYjp4DGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(66946007)(2616005)(66476007)(6916009)(83380400001)(66556008)(64756008)(66446008)(6506007)(53546011)(5660300002)(8936002)(91956017)(316002)(76116006)(26005)(4326008)(8676002)(186003)(6486002)(2906002)(6512007)(36756003)(478600001)(86362001)(33656002)(122000001)(38100700002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oCQUH+J1t+ph2eRgB0Z2koomIjOPj4N3yaAFGGMx4jYk/QdHOtSxkewdNykG?=
 =?us-ascii?Q?zVRHy/zR+GF3vVyeT2BtGGM9U3OubX5osC1w9BfR0+ZHUCo9GuztOhdlFh6f?=
 =?us-ascii?Q?D3sEI0EBTlka7uBZJAtswT89mI8GcqT0qiguHm/x7TrJjTJvGksJwDN+e7sg?=
 =?us-ascii?Q?vTu6Fxq2wulNCRWNSzo/FGFGuhcKz35gMjUTd3k7y0w6o/qyiV53u7toqY9f?=
 =?us-ascii?Q?ALitdQXrzhrsRU2WXer9LoVspRxMOl/vAnRs1bXtIMhTiClATyMd5z0iRnp4?=
 =?us-ascii?Q?0dTg2+BerCPDpU10gAJPEcahiyW1pUf4TJlv+lhLjiLQ3g3jUx3UqMvidvZd?=
 =?us-ascii?Q?EjKZEd5JnZv5Ao0CTZc4I4/BbQlrEn7KMSJpLpspiI320xl3eihQqkk5zHaK?=
 =?us-ascii?Q?PkHpjLoeZpWi3YA2P6uyJeg73kPZ2GQ/gUK8hlTLmZIxaIGOExnoQVmN6296?=
 =?us-ascii?Q?13gqTZk4OJ8n06iCHZQq0x5O0AafvDBUkGUikhNNHbeVKIQDW4eudvaNKHYZ?=
 =?us-ascii?Q?fAaStsaVP3LQP7006UQNqMaCx63xfkvOJaBNK25xykcPXzDAVAMQBgf2LoO0?=
 =?us-ascii?Q?NYCMz24WPq5ST5d13WtzaZj/VfE/N8d9pT7HewxcIthNX2GgKM8+n0qTrROI?=
 =?us-ascii?Q?4Ktyp5drg+z3P3jFm2F4zEkWsOOnZ88XLC4c4HapaSHx/qkiiZxbR4n8pDfL?=
 =?us-ascii?Q?wYXAG9OThR0MqF9UgwyW8yD5oU0gffRBXWF+SpFKEITWHC053jrtO6sMGJpJ?=
 =?us-ascii?Q?us188oozprutxxF1x+qsBXZgrz5mhSGlxpi6ELylr7Nfm/Xe7AuB0hJj40W4?=
 =?us-ascii?Q?QeS6+zyfBORSQinbUbnHjonDr7nTUoPkjacU6crvFgmwo7BoFqdUQubJhiIU?=
 =?us-ascii?Q?Q8uteGfNRkn4B1T/7MXFTL0AwpCPXhrU3IaFNKPN6ENL3BdnP+yGivwkv746?=
 =?us-ascii?Q?zCBYlR+goyLWy4VCA6fifbWa0b8xtheWrfhvt0VCN1vwdCXOxDDpoOSkpdM2?=
 =?us-ascii?Q?ll6WlRT1x/taCQrZRSkQnJ5CUq6U18KxRC6LCfjyLC8qh7ithNHgfiCOG2US?=
 =?us-ascii?Q?W5wK4swiNRYRgtubl6O8x3tnH+d662QiRuqNpIGXt02h/s+tHcz95bttK21Q?=
 =?us-ascii?Q?WByMV9kND5C+a9sDSMhi2av8AczLqsaR1M2j/pmPuiE0YFtF/VDX2YD2RHK3?=
 =?us-ascii?Q?rsRqe3c/EoBhFnlQMC6xDXjQl/zYHEgTKOc+EHj9gWr9F/25GAa2z3iBkxD6?=
 =?us-ascii?Q?einYeq+DS8sM+7xUj9yFBsY7a+GiCd0X/IG+6Zd/oPaUVX4gEFC2oi14u8x2?=
 =?us-ascii?Q?Cz2FaLeOTKhG27waJF+0EM16?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CB662F62E5B4145B9E710DF5540B3F4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08513fe-1f9e-471c-978d-08d93d8c2bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 19:04:09.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXMoq2cmiVCu7UTeFgWewIdH3Gmd1VxRGmJNbgfuwfPGgm+peM8CryotAQKcpq49XlqYHTobdgLCcxoDTyqaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107020098
X-Proofpoint-GUID: uJQdcUKavc7uKNWwaHDi5Je3yX1aEjii
X-Proofpoint-ORIG-GUID: uJQdcUKavc7uKNWwaHDi5Je3yX1aEjii
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 2, 2021, at 11:37 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> In error cases the dentry may be NULL.
>=20
> Before 20798dfe249a, the encoder also checked dentry and
> d_really_is_positive(dentry), but that looks like overkill to me--zero
> status should be enough to guarantee a positive dentry.
>=20
> This isn't the first time we've seen an error-case NULL dereference
> hidden in the initialization of a local variable in an xdr encoder.  But
> I went back through the other recent rewrites and didn't spot any
> similar bugs.
>=20
> Reported-by: JianHong Yin <jiyin@redhat.com>
> Fixes: 20798dfe249a ("NFSD: Update the NFSv3 GETACL result encoder...")
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/nfs3acl.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index a1591feeea22..5dfe7644a517 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -172,7 +172,7 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *=
rqstp, __be32 *p)
> 	struct nfsd3_getaclres *resp =3D rqstp->rq_resp;
> 	struct dentry *dentry =3D resp->fh.fh_dentry;
> 	struct kvec *head =3D rqstp->rq_res.head;
> -	struct inode *inode =3D d_inode(dentry);
> +	struct inode *inode;
> 	unsigned int base;
> 	int n;
> 	int w;
> @@ -181,6 +181,7 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *=
rqstp, __be32 *p)
> 		return 0;
> 	switch (resp->status) {
> 	case nfs_ok:
> +		inode =3D d_inode(dentry);
> 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
> 			return 0;
> 		if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
> --=20
> 2.31.1
>=20

--
Chuck Lever



