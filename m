Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C438A360B8E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhDOOMm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 10:12:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45932 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhDOOMm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 10:12:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FEAhDc045547;
        Thu, 15 Apr 2021 14:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Lt3MZmyIV/sntHGcIyuIX8eoX83CukQJFlwbjclBPA8=;
 b=DbMfPYyTSGbqM1+agAHuA9gqF+H5hO9OQxKOjTex5x06M4Q+MDdvPcOtMgVZHMIhJaKz
 HNJSRPAVQZCz8vKklbnUjLdX1sO76muh1YUwOU9H1UK/hdyY0Gf2Xe7M8C2FwY3F3y3U
 T3V5G3XSU5zIxe9fx3MIILZienXmxmg6h0mbt8BH4nMCeZaBHEbrjA05cyPzsjjByOtZ
 AunnY/IFUAxbS4xEbGb+aX72c3PWkyh7ZwRD0iMLG4OwSVxFTaRMDj4J16FjH8Vy1YFP
 C5zqX+n/fespLeG70KsMu3VEdDVvpmdZNF+BmC+4P1yMZcYAGXX5NrHKr2BpvNG20Ftk AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37u3ymnyu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:12:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FEBclG042830;
        Thu, 15 Apr 2021 14:12:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 37unsvnb9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:12:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l54fv0LdBHa8oQvCYtulPxLpLmXQjV8QdqCVkWQXxk0m4CUar46R+zd9zExZLvBLMSHxvRufHCjYgRDXDah3TOBibOmEbNtsMrLGpPuoo1LQMSgBVfuVwQz/751Vk5YW7bVnHjru+NjtFrTAe9RYno5CzCDTFz3Cs1TyFMSKCGwUF++Jxas+Vb2hXiUCnyIpgcPmo+naobdT9hBdFcL6JlRgO3+e2Vr3ANBhaFkVdCNXgmy1IlXrEeg0ou9cweOS33ttfEwXWzHnI1cycVvLvzO3nd0YGWzlpc7yQqy1lXBKXiJtT3GK5vJ8h3dZcFuMtU+cXRGm6hALQvcZ9kULoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt3MZmyIV/sntHGcIyuIX8eoX83CukQJFlwbjclBPA8=;
 b=BbJB8Qpc5Vrxo9IzRPMgD7S0IyZdqnt+q6OekRNU9EtmGCITdOfAa2UwRY90RyUbR2j1cR+aS1+U5IlpxAwpyezDOwKEnVbdBrsJPGpa+swaFnH+1mCcOYixjorBddxEKZX6kQhIIv432HW9MYVinwPWe+CewV1+MmAzm/7NBM2MFScyG3Vt9rtNWQ8UqDjNmL3pBLRXX0IU+3w0Fu885nGE7GuV69mpD4uYofph48VnmZhwF8Yj2FuzR/8IC4sbaLzneuChObVHDK9ER/NXXTYGVxf4XRdxKxeyVG1EhRXIKIJrQ5Ydz2kGXODAsiSWoEVUyARtz+/O4Jc7PJrl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt3MZmyIV/sntHGcIyuIX8eoX83CukQJFlwbjclBPA8=;
 b=vnYoSgJJwD/ULjsmE6+5JnqWJmT97Dz1v4b+D0FVYAlhBZSEQdeXHdejqAGAdflN9hspwmspAAGbDtR1BIrDs2uYCST4MyO2c1QQf7ysUft7BvJ0MF55WX8XS/GRD1yRa+u9hMkQbNek1R7SvJoztX+9zAZJfz+2om+Mg2FIUIE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2967.namprd10.prod.outlook.com (2603:10b6:a03:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 14:12:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 14:12:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: removed unused argument in nfsd_startup_generic()
Thread-Topic: [PATCH] nfsd: removed unused argument in nfsd_startup_generic()
Thread-Index: AQHXMe8G5MxeFiAuPUWuuEAnCQ09caq1nswA
Date:   Thu, 15 Apr 2021 14:12:14 +0000
Message-ID: <E093C02D-1EEF-4C8D-8265-52149FAE4922@oracle.com>
References: <b77da875-4a01-3f88-ef65-26ce2394becc@virtuozzo.com>
In-Reply-To: <b77da875-4a01-3f88-ef65-26ce2394becc@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc6bb57-d556-4511-d390-08d900187868
x-ms-traffictypediagnostic: BYAPR10MB2967:
x-microsoft-antispam-prvs: <BYAPR10MB296727935874B0D38F7920FA934D9@BYAPR10MB2967.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:202;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00qHrq0mCfzbkMR8dsrWrWPDUPJM0p3OmD6EwvsrpNM84L6oSlGZ1g1i19XfjWELsIgtuVNNwnSfyjcbaiNEGoqRpJOkPIk/aSGSr97aUohQrHFEDsfCrQki+GzEAkGzI31DGEZ55iaVlfX+CrvR6PuADbztzwSNv2nkUTF+nVTe0cSUw9AEjVWhR3PMj21vy5Xcviij0PRqyVtnUAH8B6cbAHEnStgCDR6TgSY53XC7Qjc9+dfWnmWd4GV2qo56fnoP2IBUbMfcuS8YgP8gKycbENSh9uly07+raUkk8Ap5OsU4XlRuxcLZ6pIVXM7q80leU8/m+bGjKbhfCXzXLpKV4qZo8AMvZ0ORSwB7OIjzEVfGO4sNrfyd9P50OhtfrCGzijlFWYQ9SQis7nLfcggRqtE98WvCFcALPvKI5/H9xhqGyYwegdarTKg3yjBBSCjKwbbmKDgxjadmLUaGTckGe1HNUpiozzY2EeT1yH2aorXy5Q52W5Gwns1QvuU6GD+vqHsdAIfJ/u1/DbsnERVeJjLPDRZDvkakyj+doysfxZcm/5Q6lVClDiRrQ9RU3auSRbaUa3OBvPDroOJYe3Mmp5QLafUOnBQJIDL+STtRFqRabNm9Ax3ltwwui+Dru7FcbvHmYX+y6iRS0YM8or+9pOSk3IzA7c6WD//W1dvyuTco6utt7TvD0hGit6Ew
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(2906002)(6486002)(122000001)(86362001)(6506007)(33656002)(6916009)(76116006)(6512007)(83380400001)(38100700002)(53546011)(8676002)(66476007)(71200400001)(8936002)(5660300002)(4326008)(478600001)(36756003)(26005)(91956017)(54906003)(316002)(64756008)(66556008)(186003)(66946007)(66446008)(2616005)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1n/M+/W2UC3d9N7mxeNrFepWsn4rw6bDcssSHcnHcnxUTdX3WJhKqTV5QD6V?=
 =?us-ascii?Q?sRDBssXgR9zJwCt24f8tB6qTe1zNvrkxQkhhhJi4TyqwX+RpehtVnFgxnbKS?=
 =?us-ascii?Q?7ummD0lkbXfo3tLwZjwKm+KxvtcDUXWzvuawZl+5MGNcPfpqZhEz9GV6LHkl?=
 =?us-ascii?Q?yxmxVwIph0C2gG+rFzxzUBJtCuaYWsvQ4CkXy9mcHDPL7pEOK2tVcIO0GnmY?=
 =?us-ascii?Q?w03N6aGhNqSYeFqBvXLw76zgY1Y57PxgoAICYsn7nDPF9fFVTtgo5i8DaUsZ?=
 =?us-ascii?Q?QsB2eub5pC3sKsPKH/LnO4PFzUmlEQrsA+nttyL8w0Pa7FCkoxcvyogfpKK1?=
 =?us-ascii?Q?CgxIrp3rRQk8+VlsdnBACj4W3IVs0hB1lkf/RkIt0V6PboRSCi6jGSph6Q71?=
 =?us-ascii?Q?R3Vm37bNx/FNN3HENMioqwy4cIbmWc+4ElsvNmglCn/8ruijH1ASGqCjc0HN?=
 =?us-ascii?Q?fn15i3G2RRL4E2qJ/tIAoYHNsq4OfF11yv0eBHpV9hA6oxyxEKxFB17eYMJx?=
 =?us-ascii?Q?l9RxRBcJUy/UyXcz0ewnRlN57Axsemcu8n3KUY534mS6NxIPCDMMLNXleMRG?=
 =?us-ascii?Q?Cgdew5jkq7qDDngJUX9afMEDl629MAdsb2hewPuGmtoLBX3UYqVeso1MU/D7?=
 =?us-ascii?Q?ydKH4elymuzqRAgjEPttnuLUEJP6I2Pxhd6KEntWbOYoqYICxscqeWgI+4GM?=
 =?us-ascii?Q?aWeOJRkqlXrFI5wdPn8wlvZkwFkOUPvbP8jQwtwxt2LXed+pF9ll2Gw26HB2?=
 =?us-ascii?Q?XKm2gsSJxrq1Ga6xFO/JnyJX5NfMwIsU2hEvX09z6giRe//0p/FSwZ7oxdkZ?=
 =?us-ascii?Q?9b71OWtxxkyfY6qLCtiu/KRCsVJzlAoffEVlmLN6LS+EpN5bWJ90G/XsD2yB?=
 =?us-ascii?Q?jgcvHzyw+MiAwXBKtv/Kh7PYPtiGpXtkBEF0Ij9x7qaqBfy+rg0Gn5TDYuDu?=
 =?us-ascii?Q?u83KIA7lZzFsbLY2IvcR4wg6RDun3XBZvc79+MRGjPEUrSQvDG+PsaakJote?=
 =?us-ascii?Q?s76jsZK/4ZP4qyPr6wpMkFa+g1qr8Dcs1psIsVkxLuMTFHDP5tPoNy+n33o8?=
 =?us-ascii?Q?O2unYmt2eU1xHWUMF1F8Z/5z8ZBu7l7eDpLqvk6jFqN5qCirvrbp7uy0Swv/?=
 =?us-ascii?Q?tHlCTurdyhgScJpVIF80am+xI0V7Ti7nRqfHarGZfFrz7bYwtBEf2bNX1m3T?=
 =?us-ascii?Q?Fn/cZJ2oGqdc0LrUSAxrUdfjvYPRpJIjWLTw8VQ3zDXnxt9RdsFdZuU/EXq+?=
 =?us-ascii?Q?Wt+2RmdeW+/Lw9i9OQwo2075VH+59CdzzpohGbTcXVfCAT9vvAEWnB/fjkqn?=
 =?us-ascii?Q?a9WhtZGowXBZz5sGYR+gH777?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FABDC1899A4B0848A5AC974BBBE6925D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc6bb57-d556-4511-d390-08d900187868
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 14:12:14.7672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RG8HxbR/QMZXN0gQdIPChxnD0YHVFA24KsL9b2vMM5gt/s1mCbZ7G+7A063ldTOCpVehlK2r6JyZ06viI8MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2967
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150095
X-Proofpoint-GUID: 2XJ86za9yGeF4wkmUO8fMz7H0nt89-9x
X-Proofpoint-ORIG-GUID: 2XJ86za9yGeF4wkmUO8fMz7H0nt89-9x
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150095
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 15, 2021, at 8:00 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>=20
> Since commit 501cb1849f86 ("nfsd: rip out the raparms cache")
> nrservs is not used in nfsd_startup_generic()
>=20
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks for your patch. It's been added to the for-next topic branch in

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfssvc.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6de4063..1669f5b 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -308,7 +308,7 @@ static int nfsd_init_socks(struct net *net, const str=
uct cred *cred)
>=20
> static int nfsd_users =3D 0;
>=20
> -static int nfsd_startup_generic(int nrservs)
> +static int nfsd_startup_generic(void)
> {
> 	int ret;
>=20
> @@ -374,7 +374,7 @@ void nfsd_reset_boot_verifier(struct nfsd_net *nn)
> 	write_sequnlock(&nn->boot_lock);
> }
>=20
> -static int nfsd_startup_net(int nrservs, struct net *net, const struct c=
red *cred)
> +static int nfsd_startup_net(struct net *net, const struct cred *cred)
> {
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> 	int ret;
> @@ -382,7 +382,7 @@ static int nfsd_startup_net(int nrservs, struct net *=
net, const struct cred *cre
> 	if (nn->nfsd_net_up)
> 		return 0;
>=20
> -	ret =3D nfsd_startup_generic(nrservs);
> +	ret =3D nfsd_startup_generic();
> 	if (ret)
> 		return ret;
> 	ret =3D nfsd_init_socks(net, cred);
> @@ -758,7 +758,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct n=
et *net)
>=20
> 	nfsd_up_before =3D nn->nfsd_net_up;
>=20
> -	error =3D nfsd_startup_net(nrservs, net, cred);
> +	error =3D nfsd_startup_net(net, cred);
> 	if (error)
> 		goto out_destroy;
> 	error =3D nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



