Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049C0339356
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 17:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCLQ1k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 11:27:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCLQ1T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 11:27:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CGOdZb014743;
        Fri, 12 Mar 2021 16:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VMJduxDX9F4lJjPEjlydJ9/AZnKu237ycodx+F26rwI=;
 b=Yhz9Bbhcs5eFPzKBhiykxz/V9erm3yTX4SWTK90WYaeUhMLlJFQMIUQXpuwgVhqol1Dh
 5WrJMbzJ6wu6962mrOYAKN6HXJzA67BkuSkrYN0VC6IUt2wIf3yZqglP1SspAxwZtGwp
 toyex916VScsOjaI37hkHn8bzjD0eZzZpKT2pjSD/snfv5odnaS/FS/P6ZSo4Ln+x0DX
 vKqgRok3/dg8TL3qBjwvqQHyWBRpcQ9zMPOTi3hyXXAQvkK3IZOQHnQGQ5g7i23GbpP7
 7ZCMFYVGyZ+EJz11ov5IuF1zqLSn8B7alOXo7p1j4MeA/7XDjgEvxQ8rk+eFgHdWERXf qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37415rjf2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 16:27:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CGPenS112974;
        Fri, 12 Mar 2021 16:27:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 374katjckr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 16:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhigzZ0tvQEuedKzmlbVAMl78jOHjKKGTcs85EKBOLnJfHgWvZxsiMJBtp5yvInlJhhUVCi5FxdCvf2RrwKusrCu8WuQKP6oMAPbPybYqUlyOfqHG7snBBUWK+ojsgI4dH8/1jSlzelxNhysrNsMb4BvCsRxW+jxiQwIf78I8La6vVI1i5J/sqdjeULTp2SEWIQCoTc3TuudX0D+bpSatQL0ZhpxP0R0My7kl9K/T+G9nDMbGGVrkNXow9hHdevkU77cNMifRYVXruS9ERRWW4yZ7bOV6XXgeK9uyXgOEYviRdz9ZceknCOEGaRCXRT7WmjkKjFhK+6PpC6ZTO8OfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMJduxDX9F4lJjPEjlydJ9/AZnKu237ycodx+F26rwI=;
 b=XxUALaAB7k1tOOJimCvJuI7JyXs288KBwLdYocQhTPPUZc7+XIcl8j2QqNxEUuIfv61jYfJAaxPSIjYie8dmlvLx6Bts4Jlz2Fq4ZSFSpMgsX8oU1OeF3cHsZ+1JXMl7tXARqNnKUhw4QWNnYgpVHYjQeAMKpb/jQGCUWlE539vO52r8DPCbqZrD5h1cfCPEOp9IxSf5lJxHjRDzC4DVBSPoA7vdD+tc1HDStztgcglAnmH07Or0wy0tStxyik98IddXbrst6TleFOgLRamobpzdY6USWSsZCK5ANm1dU5VnNRKw3TzeFuvdM8o8db/k4U2wLeDQ9Ar2pbhYG7q5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMJduxDX9F4lJjPEjlydJ9/AZnKu237ycodx+F26rwI=;
 b=tusJYNqPOlxWauA4g9sdkZ1CV0qaWSgiwTY5xqqFZDsxsV7IX6D6U+ztQTZSSnwa/Lka8ontCCoBnzvGZcYJc2VJukzBlAsOCwyGRvUVZd6LrJlTSYYGAmUwZ8T79rfNmB9kVaxMe/daFoycNvqwmf7saG5pcXR2/wpA9l/5hpM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 16:16:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 16:16:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
CC:     "casey.schaufler@intel.com" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "penguin-kernel@i-love.sakura.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v25 17/25] LSM: Use lsmcontext in security_inode_getsecctx
Thread-Topic: [PATCH v25 17/25] LSM: Use lsmcontext in
 security_inode_getsecctx
Thread-Index: AQHXFPVHrl5ddq1dNk6KWoICiuTiwaqAjCCA
Date:   Fri, 12 Mar 2021 16:16:14 +0000
Message-ID: <C9F8E490-B87C-451B-A20B-CB88979CB897@oracle.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
 <20210309144243.12519-18-casey@schaufler-ca.com>
In-Reply-To: <20210309144243.12519-18-casey@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: schaufler-ca.com; dkim=none (message not signed)
 header.d=none;schaufler-ca.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8b661ea-3555-442d-0830-08d8e5722881
x-ms-traffictypediagnostic: SJ0PR10MB4525:
x-microsoft-antispam-prvs: <SJ0PR10MB452579A70B64BFE101C5E2BF936F9@SJ0PR10MB4525.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PITH6EVu88l4Dgq6q5olmsvdmJN/HbYCK8tC8dtUvBKehQeCMNO0R9qMvkaEgOwCrQmU/XgYkah/wz5y0bPoiDnoT5abxoO4UgOHlZ8eJkmjBqW7TAz5ZCxqe1/nNL92uqizZ0upbwqgoNRrRegObHvMEL7tfPEUuEClP9tr+6L+fv7K+CcWY6/T5YwjfKgpg+KuhiwFZlpz6Mm2iNej/QlBSLJayBgO9bmhtlYirlBJi1FGcAXtgg5YSyzXmuNEj7SwBtqgHWun4ZzEwQ6qEdJy4Lh+xpR043Y7Kr59Y2tDGoURibdJQZVAXKPYKdbns15WQGv8C1B+IVY4wV1O+YHVV5Jl+NwMt6///0tRlwr3mSPvOwYXePnL8VefABrQjoOIJBnFTTn/po5x3ofvb6kcRlB8NFy26XEg9wlE6zrbQbeFBXZnxOGpB4vJanKtGeAUMBvp6+ex9mlDiabJ76hxoHVo53Z73eIeE3ecG99hl/Vg3/Wk56lPgv5qnHIFGbBSwiwXxUtaeOZP2KxVyvtce6r92RNInfCwfZCPcDzPYCOKvETwoYFtGVufvSMzaFs7x0Tbd6T5O0/iIPZwRF/s3vaVbBmS4hd8Xy+Am0dWOqzhYzS4Bik4mgNCkFvR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(6916009)(66556008)(66476007)(76116006)(26005)(186003)(66446008)(64756008)(66946007)(91956017)(6486002)(7416002)(86362001)(2906002)(2616005)(478600001)(15650500001)(33656002)(8676002)(4326008)(6512007)(71200400001)(6506007)(53546011)(54906003)(316002)(36756003)(83380400001)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Aab4vVU/8G1AP9MUdWoVht9XiOQKbI/N5Kzx6RUOjE7jJR7ip8DFK0Hq3Sjy?=
 =?us-ascii?Q?Yx36RtcZkp+xKw7mIN9Tg6xRjFc4Rv2GrpzP7hptzWcFO+eu/3FdJBcW4+AM?=
 =?us-ascii?Q?uOubPoOymdlsw9S7X/xnn+qmDFuzRxNk/2j7K/PJIyz/p/Y0QNS2zaXI9sjI?=
 =?us-ascii?Q?Dvo5m5qpkZK6eHIG8u/5yKwRI43fDIYLeFcdTAF2s7FQy6EPOiO0jwW+OkCb?=
 =?us-ascii?Q?Ot5QO6EyGW/Z4TtEr7ye8JhHaxvM5lmpeayivzrQlir+W3odaI+Q66+tqu8X?=
 =?us-ascii?Q?4XFKzdQDHyfDd1RXt+Qg0B0OnJtcm/oapdMhg6H5OUekJrVSfFOrJfcE5b1o?=
 =?us-ascii?Q?I0s56QmpOj/YtwHCJ4PGfCXCcdXmqG1/GaCXD8dTbbNLuhNzuTXeFPQ5tOl1?=
 =?us-ascii?Q?mGTvNxaDSJPmlDbD3T0Bcdwouv9XJkik0EUD2GmmxyN8dl0zI/N8PvYwP3f2?=
 =?us-ascii?Q?ekFbZcTJZSmA/6PgrFx6VK7T8jIwxXk3sAtwbK5DK6Aya0DDfhMoX95sXOQ3?=
 =?us-ascii?Q?o+aDw3ziA4TSqFf6JmoIEJ9XE8ybZwOp6QbfHzLisdW0lkHiCawBqTAsQ4cI?=
 =?us-ascii?Q?hKBkaBWuL+G6M5kebvw9AcGrUTVs3mQoD+ngmmTEV2wd1JO9OJo1T2nOo4Gj?=
 =?us-ascii?Q?tsjmDZxEbQIKwXkyChBGJhLbh7VD6IBz8Z7FoUnWuJHHTmAWp8qFt5+Idhm9?=
 =?us-ascii?Q?/tSPX+9e+/IW/m56sUcqm/f6W7TTxzI9Pay7QnWhZsHFLDMo1vOykAGwX5Nq?=
 =?us-ascii?Q?WJQ9+SRyZffnVnOt5hsujWNU9FynGgX5u7dK4Ph1qgaM4xdwvklaOCH5VncG?=
 =?us-ascii?Q?xk8jhgNt3PCM8QkLvH9jTqDB1LNaXW6NsUE38g3CB16FLeVniEcUJUwbjfH+?=
 =?us-ascii?Q?MXuk45qxdV6OfgMrT3+uFkhSL++PTy5C2YtlnANnELFx0bcDlCIJV4f6Rlel?=
 =?us-ascii?Q?MzE/1KNDLuFxfQO8UUK+fPwCBmM/NGUhNl3+TpqKwWVZ7eBywcdpQ1UEfxbZ?=
 =?us-ascii?Q?uHoDIa2r/divaaZd0sMDA7g84BvLtY93z+klTVViTi9w7V8D4aH1iLRoDTKQ?=
 =?us-ascii?Q?dHVm/bvqmdZD4GjhyZGF9jxmdbZ752iG6ptVPtip7FSwMgNl9Yms6MKkDbl7?=
 =?us-ascii?Q?pwfgWT7eh/3lAVESIx+x2V+R/xLKo8+/5IltEaGVn/YONtH7lhK4smFRZTmI?=
 =?us-ascii?Q?6/zbcD2IQ8PzEmV+4ktYDb9ImX74frpnj6CM/dkXCVhfLkN1VgBYrJr7jvQ3?=
 =?us-ascii?Q?L1/6rQy7QsoMyOrFTJc3Ot7SuD/Uz3lkX7m+PO0yNqG6TjFCS+5YiTjoCkpK?=
 =?us-ascii?Q?5ZUyVUu4K/scwH490zcx1bmU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D037D391A1851E4AA66046005FC26E52@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b661ea-3555-442d-0830-08d8e5722881
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 16:16:14.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW+obUibJoh/FJUKCTiXaMiKYYE1v7PRQuEdO1Lvn/k9k9rYsUG1PB03tCbbnypks7hRuJajuUx8B9f3Vgx57A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Casey-

> On Mar 9, 2021, at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>=20
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook.
>=20
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-nfs@vger.kernel.org

For the NFSD hunks in 15/25 and 17/25:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
> include/linux/security.h |  5 +++--
> security/security.c      | 13 +++++++++++--
> 3 files changed, 23 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index afccc4f257d0..a796268ec757 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2727,11 +2727,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr,=
 u32 layout_types)
> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> static inline __be32
> nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqst=
p,
> -			    void *context, int len)
> +			    struct lsmcontext *context)
> {
> 	__be32 *p;
>=20
> -	p =3D xdr_reserve_space(xdr, len + 4 + 4 + 4);
> +	p =3D xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
> 	if (!p)
> 		return nfserr_resource;
>=20
> @@ -2741,13 +2741,13 @@ nfsd4_encode_security_label(struct xdr_stream *xd=
r, struct svc_rqst *rqstp,
> 	 */
> 	*p++ =3D cpu_to_be32(0); /* lfs */
> 	*p++ =3D cpu_to_be32(0); /* pi */
> -	p =3D xdr_encode_opaque(p, context, len);
> +	p =3D xdr_encode_opaque(p, context->context, context->len);
> 	return 0;
> }
> #else
> static inline __be32
> nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqst=
p,
> -			    void *context, int len)
> +			    struct lsmcontext *context)
> { return 0; }
> #endif
>=20
> @@ -2844,9 +2844,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
> 	int err;
> 	struct nfs4_acl *acl =3D NULL;
> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	struct lsmcontext scaff; /* scaffolding */
> -	void *context =3D NULL;
> -	int contextlen;
> +	struct lsmcontext context =3D { };
> #endif
> 	bool contextsupport =3D false;
> 	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> @@ -2904,7 +2902,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
> 	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
> 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
> 			err =3D security_inode_getsecctx(d_inode(dentry),
> -						&context, &contextlen);
> +						       &context);
> 		else
> 			err =3D -EOPNOTSUPP;
> 		contextsupport =3D (err =3D=3D 0);
> @@ -3324,8 +3322,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
>=20
> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> 	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
> -		status =3D nfsd4_encode_security_label(xdr, rqstp, context,
> -								contextlen);
> +		status =3D nfsd4_encode_security_label(xdr, rqstp, &context);
> 		if (status)
> 			goto out;
> 	}
> @@ -3346,10 +3343,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct =
svc_fh *fhp,
>=20
> out:
> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	if (context) {
> -		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
> -		security_release_secctx(&scaff);
> -	}
> +	if (context.context)
> +		security_release_secctx(&context);
> #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
> 	kfree(acl);
> 	if (tempfh) {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0e1b6ba330d..9dcc910036f4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -582,7 +582,7 @@ void security_release_secctx(struct lsmcontext *cp);
> void security_inode_invalidate_secctx(struct inode *inode);
> int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxle=
n);
> int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen=
);
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxle=
n);
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)=
;
> int security_locked_down(enum lockdown_reason what);
> #else /* CONFIG_SECURITY */
>=20
> @@ -1442,7 +1442,8 @@ static inline int security_inode_setsecctx(struct d=
entry *dentry, void *ctx, u32
> {
> 	return -EOPNOTSUPP;
> }
> -static inline int security_inode_getsecctx(struct inode *inode, void **c=
tx, u32 *ctxlen)
> +static inline int security_inode_getsecctx(struct inode *inode,
> +					   struct lsmcontext *cp)
> {
> 	return -EOPNOTSUPP;
> }
> diff --git a/security/security.c b/security/security.c
> index 73fb5c6c4cf8..b88f916e0698 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2337,9 +2337,18 @@ int security_inode_setsecctx(struct dentry *dentry=
, void *ctx, u32 ctxlen)
> }
> EXPORT_SYMBOL(security_inode_setsecctx);
>=20
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxle=
n)
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
> {
> -	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
> +	struct security_hook_list *hp;
> +
> +	memset(cp, 0, sizeof(*cp));
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
> +		cp->slot =3D hp->lsmid->slot;
> +		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
> +						&cp->len);
> +	}
> +	return -EOPNOTSUPP;
> }
> EXPORT_SYMBOL(security_inode_getsecctx);
>=20
> --=20
> 2.29.2
>=20

--
Chuck Lever



