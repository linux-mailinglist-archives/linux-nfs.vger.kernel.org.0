Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5CF3F4EEA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhHWRDL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 13:03:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230360AbhHWRDK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 13:03:10 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NEeVCj008489;
        Mon, 23 Aug 2021 17:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JZVxXsG/Xql0uNoSH0w6PKHIOcrEZGhLiGB2SX+i74I=;
 b=lpQuJ6AvdYzywfdxZvkUpZtscqL4qQK5wbxUxKMx9bRj3EIJTnrmWXokdzunkBSOdLfO
 6kCF9Ny9Em3S8GfjQ4yNjJbKTjx8twXQ0Q3ENeGMK+bfPk/jnTBHkjiFwjrX7FpoTJO+
 hbwbPezQzF6vkE0zO2VaWELTLHvBrhrT6RizJA5JiPJhOr09ZkORL0YiHwa2sYs4xLuB
 w7sgg5iTGUFWRT+ELcgiShbh/qrjh3aw4+WzmImvQB0N1dVrDZos9lixMoKlkjHbm11z
 wXWrz+CEdhn/bBFIwycap2LKaVaS3h9NCrX8RpnD8BbUh3ZeAsfhLFG+voWPhlYwUScV ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JZVxXsG/Xql0uNoSH0w6PKHIOcrEZGhLiGB2SX+i74I=;
 b=GksA4h777mza5v3rP9k8FmFEC6tip3la9tnGPN6tBAsSTI6xNn9V4bnavX28Hh1C7Rnm
 fZxfCMJnSroHHDaRgtEkg1ej0pguQZYsck9fpxDD8peM3KPJFs71haPSgmAf+0d5w8wS
 vu7vHbeYpYs72pFcnG86dPFnApQrkQAKs3CZ9v9Ai+1/Jm4NoOFX0oLfqwgXBnDS4aXy
 N076vdmIl5okSEa40gBTwxcFefvN+n799WIQ85XGM04VKGuv85Imuv4NaP2yjRP0Na2b
 vQN5gxZUDAPjx2t8gfAUU+cggPSkAoXNQZ/9uEw3iHxpYD+1lqXlP3mFv2FQDemkwc2U rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcfa2wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 17:02:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NH1Oax120355;
        Mon, 23 Aug 2021 17:02:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3ajqhd0frj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 17:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/5AA9ACFuH1CnWkFSHS/c8UfsZwU0UJXso39BVItcpN7aaTme5PGr3OD5mmn6g3/72c7JvnDbJx4Tk+h1JA/fFHWus4296hvA41P8wUxLRMWKfdPN4TFuhV/9kvgMv+HeqOFDooj+/Oe63+x/h0rzLOt1XkPGH4o0LSWf6Uf7FXtRWpHjVjKJ31VxGTNns0gjpktfTmBiZQWxrHp59NdA3p20L6PTfKpzE5th2u8LNBsnDvomsYupvVUIvu1Rs8RUX5Nu9N449TVLzoxM/mmCZcKEdeZKabdi8a7yw0aDbf0UlY2y5p9sJD0j1coWZgNvFVKJpEwr+lYV4bwpLIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZVxXsG/Xql0uNoSH0w6PKHIOcrEZGhLiGB2SX+i74I=;
 b=T11Xw+2xIGt8DHpdpeT2JDMbujnjpa+YETn96sl/6CEHYPWovk/Zpqla4yUY/KX9e71sXSevwxVvwpkUwKRXpvq1YrsXuxnYmm/Vnmd2kxhKZNRlTSHabsETGTL7hCXj63J4ge+O6WpNlD/mi1K+90q11S7+OV9JgmQrNOX4tXfTjbpirrUAxSdiU6JeBtPFOHvn5a6onHivZ9ISS+4JNQMmi0EIcdVlbB1trkiO2G586VoK/JV6ntKM5eN5k9RzdXVFH8PpT8FmyYxCW9KdW9089DGktCTsMOkSoETe6tWcnCoew68yE6Wv6WnVOAHbnC5A2GFsM9rzfnUlYg+0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZVxXsG/Xql0uNoSH0w6PKHIOcrEZGhLiGB2SX+i74I=;
 b=DgzW2b+1k5mAXCsZMQj4RTUJqwqwRAnzKyoCPCUcG/gO3vouo8OAMTM1DjW4MUCFWROAVTZi8ySqdffVbrZTmFmGBhM6JQW5Vw+v5cznD5KsVX3Hv54St1+d+BJwM6AFA1Q+jDsbUdCQUp7Q3CvjEfjeVqnDgDq4BscMTx3CWr4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 17:02:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 17:02:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] nlm: minor nlm_lookup_file argument change
Thread-Topic: [PATCH 2/8] nlm: minor nlm_lookup_file argument change
Thread-Index: AQHXlgarWedXlI5eD0ihs4522vEIVat+J6qAgAMcfwCAABEMAA==
Date:   Mon, 23 Aug 2021 17:02:19 +0000
Message-ID: <5375D339-E402-41E6-9EC7-0E3FFFD34D1A@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-3-git-send-email-bfields@redhat.com>
 <77E5AE14-04E1-4C54-BC3C-192FADAF7B96@oracle.com>
 <20210823160118.GD883@fieldses.org>
In-Reply-To: <20210823160118.GD883@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd7d7c91-0b89-4f29-d941-08d96657c4b2
x-ms-traffictypediagnostic: BY5PR10MB4321:
x-microsoft-antispam-prvs: <BY5PR10MB4321811169417E17ED0AE42A93C49@BY5PR10MB4321.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jiF8SJd2cBjnxmphZXGwLjPjMAN8dOE7XjhUgQi/ej2NWhzXu9efmqKX7YLakNpaj+D1tuXRA0+yFYNBFUGppyV2zUtoOnrdXIURDWrGhcFV1B/Wb+uBqZLUlLNwXPxYSqKm+vGDMl66JehcI43nen7+1uqpwlPFEnckl4VH88cjWp2tIYgFrVsHwa5kGWKc2NRJVQIq+91k+zVT3Xl5erJIIKQ3fIV6Sm4lOadZRL1CRJjCJhcXIkakpFf/Jikzx5SnCGIhoIw+QmU9XOz+CLh6q1hTTH/zosWye9u2JrMVDJia5wmh/OR+s1AlgR2SWdy5N7V9NL76DJmaq1ypY+T96YbPXs/a/GIjTrsco7pkGTlCJyzdZH8VgdKJ8+/IoKEH4dd8R/2s/+cdpX1ZBZwJbKeEw//gPRr3v8UX76YxYZvUamxML4Yp/nr19kw2S3Yi65PcAYEqfw4DJ4edlRlDo7EKnkxEKQvkSawKeBxHGhWUljZkPWbb53tFuf/ID80mO6YFHEcLHPlp+xeDGO4J8z5dGeISjv/2E/sTMH5w7vFUf4ZbBKXo80BW/RlYg0pyq3nPIJCLYC7zA8WbH8yYo9Dn89UOvX/wi9zMVnzfep1qcjZj3FNltxyIBk6F9HresB5zEmzP+EHS6GPbGco+BUWrYB00XHiUFIxDW6Un5Jk+Xg8Mz1pE8CeU/17kBNd92Q8ZNnSpwhKCHTH/8LT6DOYkNJGiVezse5n+xcs0e+zGYoa6XBkgOOgbuG+E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6916009)(86362001)(5660300002)(4326008)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(36756003)(6512007)(8936002)(6486002)(2616005)(186003)(6506007)(38100700002)(26005)(38070700005)(53546011)(122000001)(33656002)(316002)(508600001)(83380400001)(54906003)(71200400001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y00UFA5oXrh7BnPu07Uc4apflJ5gcJHYmCN/NVoy6jxOiPHcDRzOv3uqK71W?=
 =?us-ascii?Q?NRVjf5puPIt2BZ6+HtdE8m1t/Co5+nx74lLa6cw59vQwfkpiDxYLLr+04jGk?=
 =?us-ascii?Q?WwujB5n+qpcet+Z9QB/gCbsph+clMa/ITuJDnh7TARx1CwlsMKA9N6UkU6eV?=
 =?us-ascii?Q?pOOIJnLJF5YJa6UDcmP+qcGzDbiua8YvDbAqpkBMQSmNp5lvmd4aWLIJvCNp?=
 =?us-ascii?Q?2aG+PXGWn1a7ZR0KE5ZzGqWcrXLtWBqvk6p27HD8JCLM1rP8lTFahus8eXRK?=
 =?us-ascii?Q?8zsIimUjC3m0Iw24kAXmxW/AU1yiEE2fJGxTy4/RmbAtuKv1Zs+YUCb6kOKZ?=
 =?us-ascii?Q?O5SXUXj62VPCH8pjC6M5xFpsc5lCjct/w5Ibp62YUMAJLNHy4P8rk9HeGOCr?=
 =?us-ascii?Q?zn910b5FwPu7aJ9qpkRNrux6aPIF7Jwvba7tdoKnWtx+a2HKeA0wVvA6ZQrN?=
 =?us-ascii?Q?gN1ZBE3bkak3aTANUWn/sHFAxv5eyvWjqJvQf0x6s6I0ZuEB2JBYCjOlXbIY?=
 =?us-ascii?Q?ydxAAw8Er9eKFVs+VFpWksRg2dCsJDkZ3zixhv9pt47Drk4vyqcebUeOsEE7?=
 =?us-ascii?Q?ZLLG8RiTCZsYfP7J9Uf2qIbfxFX0YmN0uVG98PxrDAAKzF3EQLyNJI8oihBV?=
 =?us-ascii?Q?fHItES1xWtOljWPWh6iBYbb8jn35qYCWsMVGqsqKFQDpTim+mTwYKNujlSUQ?=
 =?us-ascii?Q?7UobBNgSgcWC8kQPsE21ZztxN45p8mi3vfO9kQjwh3fEHiSqplAyLI3sKwZe?=
 =?us-ascii?Q?i+T+u1vJsW0dfOsJ8mpNPAFM295zQ7fBQsMa3QdLjWCJygfhJ6pHvl6kVXy4?=
 =?us-ascii?Q?Rzjp/nq4sAQ9q65zLiobAN87puJ4SaoueVuS82Un+OhelkY+3mI76Z40b9qb?=
 =?us-ascii?Q?Lny+38RB8V1+nYiAQjzqb8/adfCaAyGoFgIzp1vahEd7zlBW51uejoQD/6p9?=
 =?us-ascii?Q?B3I/6HuG6flh001rziWPD2OgfnIbQp4K/jbbahXtQloKS1Y7LxXPcF9AWXY9?=
 =?us-ascii?Q?yV7V0xOd+XrmzIo59TxBZd22+VzlP7hiLFzhIQG2013DiNJQaE19Y7wUO4cD?=
 =?us-ascii?Q?kL12lVYodheh74mK58MHgUDlV6cOZKwq3mkl3g/4UwSB4RbYFiaAaZnhMXQh?=
 =?us-ascii?Q?C3YiZDmk9KTbMipS0PNTbqQ6FiplryLyyrRrfnk3Dttzju5vvkUmds0v62Cr?=
 =?us-ascii?Q?4YcV8SomP02KIZV6rEs9QOtXwQtBL2j60l2FgXssuhGwmH894iMo1S06FoS1?=
 =?us-ascii?Q?K5CkZpa2yypMc+U307ADJE2uySYj8pA8ZCtrgzb5dhurqD/73VXO1tTE9KDt?=
 =?us-ascii?Q?bFaTEX1pd3Sr7QHtTkt4iu90?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A8643DD6798F94D94435B4674EA153C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7d7c91-0b89-4f29-d941-08d96657c4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 17:02:19.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ugK+L5gzK0b3WedBJ6EQyqBixquShEdiz7vGaKijJeyRD6Aynh4tLd00RntOeCP/R6qFcBs28p9l6Fwd+WGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230117
X-Proofpoint-GUID: 9umVWUBuMpRfUAMeJvXfmxxj8fU11L8x
X-Proofpoint-ORIG-GUID: 9umVWUBuMpRfUAMeJvXfmxxj8fU11L8x
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 23, 2021, at 12:01 PM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
> Subject: [PATCH] nlm: minor style issue
>=20
> Make the assignment separate.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/lockd/svc4proc.c | 3 ++-
> fs/lockd/svcsubs.c  | 3 ++-
> 2 files changed, 4 insertions(+), 2 deletions(-)
>=20
>> Style: Replace the "assignment in if statement" in these spots,
>> bitte?
>=20
> Feel free to fold this in if you'd prefer.--b.

Squashed. However, this change conflicts with 5/8. I've fixed
that up in my tree.

There are still several outstanding inline comments for 5/8,
in case you missed those.


> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index aa8eca7c38a1..bc496bbd696b 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -40,7 +40,8 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nl=
m_args *argp,
>=20
> 	/* Obtain file pointer. Not used by FREE_ALL call. */
> 	if (filp !=3D NULL) {
> -		if ((error =3D nlm_lookup_file(rqstp, &file, lock)) !=3D 0)
> +		error =3D nlm_lookup_file(rqstp, &file, lock);
> +		if (error)
> 			goto no_locks;
> 		*filp =3D file;
>=20
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index bbd2bdde4bea..2d62633b39e5 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -117,7 +117,8 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_fi=
le **result,
> 	 * We have to make sure we have the right credential to open
> 	 * the file.
> 	 */
> -	if ((nfserr =3D nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file)) !=
=3D 0) {
> +	nfserr =3D nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file);
> +	if (nfserr) {
> 		dprintk("lockd: open failed (error %d)\n", nfserr);
> 		goto out_free;
> 	}
> --=20
> 2.31.1
>=20

--
Chuck Lever



