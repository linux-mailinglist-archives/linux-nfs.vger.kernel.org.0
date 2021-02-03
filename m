Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259E30DFF7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBCQqm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:46:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBCQqk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 11:46:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113GeFbM011829;
        Wed, 3 Feb 2021 16:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nwAteFyD7rR8Rjz2yi4nxqj541Vgw1R2RVNlNijdvCM=;
 b=hcWdVvrqJ1O3va9ETvkUtZYW7A6XxEfa1fdwqUyMMCMMYfqN8qNp3uWBzHaG7GRZY0rl
 IK9E5gmUIOovBTElP5GUzQmj63gY7srBP+KlpqCJJh1k09rCUr57/29zZ9EkASsqdLdh
 rdn/7na7V8IOcdmcKbEtWtoT38GIGphz0pBBVcIqOMo/2E/SgvYrLYNw4WyeQu7gxWCG
 VZk6q82AfvV6R+LSL6AZKnVmz74kZc5LPYj2RRa70BnQPddp5TYt/Do9MCHcQ6uD79NE
 6qGZBO4sViAHgYlpyUVm3T0B5msox0akwPJAlgeSxAL2anhzmfdQCASORUJwx+tgkQ4v jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvr3t58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:45:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113GecaK059885;
        Wed, 3 Feb 2021 16:45:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 36dhcyycca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 16:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnB84yxPxKdPuGmXZgFXB1vYMz/DdTisRhuuqe/VUlkJIsWLkcWE2HmR6YOUNhUTxJCekUNN/IfpneSmBzumv/ZFaR8t8kv4uyGVjIQk0cx/vx711Jl7NKBUcxWKhu6qbSaGylNQOQtShVx8q1dQnhTSipKFD/H+/zC/x96Qe9DxfjDywQi1ZnfuoRJr9y4u4fYm3kQSx4D7Pen8qzVV7d8P4VT3st/L/YLbybtp8hKWlOKW6Uqm6PY0weABDFGixvrHc9MhBgI87tKyThpYeauvPiM7H6TG3V/7qw09L+UXoSkEPQIdlHw0Ld8dOU57RADOkHPbO0xPAbawX5NTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwAteFyD7rR8Rjz2yi4nxqj541Vgw1R2RVNlNijdvCM=;
 b=RvggG/vZNg73eMpC7v1QLyQ3V+BZ/iNiQ8VrV255OzSzDGdX2I2pTxKhgyRTz59t8GAGYhIDCpweKq3zWaEm8rmTGoRH4rhvBXKnt0dEY8SYW6L/lPSj62u0rfMIXRg03rBO55yoM3Q5YKPBdp1brL+dlzFy1/W+tpWm/hcQ2O2IDSox3uBVVc2yHhRcUWNP1d2APm3ToZITedPIWshXctLoSZ8X8GXIyT+bnqZE49PbAmAsLbEINy7X5M5I8JSmVznHcGodMkxBZ81ZiQ46hYeiW27WObSIjWU1qWxRnVxRpQoqYOLGYVW5bZ4IxfLNygF/JtA8KcvRRt7fjpUrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwAteFyD7rR8Rjz2yi4nxqj541Vgw1R2RVNlNijdvCM=;
 b=uJWrB4GZ1k6CLwCs+Vn4kQtR4T0VgAtEP2nkHTPG/GxdzPJObnM6ImzoxKSbaNNKx8/4PdnwrdkIqFskUKrtP7zNeUt7YaV3t1D88mtDP4ytJoSdezJuFMAHxgL58CkQs8Mr7j8QZIRAi2qjHekCIjl3WIYrAT2sf+9HLVT4QCI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 16:45:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 16:45:56 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: register pernet ops last, unregister first
Thread-Topic: [PATCH] nfsd: register pernet ops last, unregister first
Thread-Index: AQHW+kuPqXx9ogEBD06qHoGJB6Hv2apGo34A
Date:   Wed, 3 Feb 2021 16:45:56 +0000
Message-ID: <70729484-C3C8-477F-8FE3-06B6A70510C6@oracle.com>
References: <20210203164213.GA26588@fieldses.org>
In-Reply-To: <20210203164213.GA26588@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0b10231-9085-4bab-29b2-08d8c8632dad
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-microsoft-antispam-prvs: <SJ0PR10MB4687CD1D53AA0453ABBA58CE93B49@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aGNIsPfGgLsnruEUVBFrPR0Oqengczm9+xPPeo6sCRN4vmK5E8sqviMnLWLUrKUELo+iLdKjblNW5Lk71dFto9m4/iU4nk3SMAwTXT8ugvzvYZbptWcv8cSf21m6bqNQBbokx6fqBqFle8V0ZxTONYNV0Fu2+DsOPcDzLAjOhBiEmNfjZEXm1+LyJf49ljxrCmvj0+XfBNFLrSBqxl8NqVYDPBWWbJdZ4cNdtWMbXA1x3rxKsH7Hk7gcUipSi2P79O2DbD9ZNt0JPwOdVsZaxWg0uP2SIbzFUPp3VExbnmTQ9qM7PNFBs0ji4mE6mbjgCY0AO4lLw4zEmTJclh1UQpm6a9+9V/TyhkXE+nl0xg+CYMsxx63a7TXIr73/IhhIfZTwPUq8q4R7UATL6janZg8Aea69kRP0eAsIBb8O7yNxTxC43bZ+s9swnFmsBqVe4SvZKIrD7CRpU/jimthVIwXC40//61pL9DyPUlRRN2rPCofWASRk44X5i+OjNAhxwyfNFZOsydzVGSJmiudT1M5e+Pa3sXGYxe2FE3IXdLrzGrABNtJL8x7LPSTIB24Woza9sgCnTZdNykW4iXN7sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(8936002)(53546011)(26005)(6486002)(2616005)(5660300002)(478600001)(86362001)(4326008)(71200400001)(44832011)(6512007)(6506007)(36756003)(8676002)(186003)(33656002)(91956017)(66446008)(66946007)(64756008)(83380400001)(66476007)(2906002)(76116006)(66556008)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nwDxlT7lkWo6Z2QNBWU3CdFgaQvgUc48BZvAQwPy512t5zvNkkdUhqVcnLtK?=
 =?us-ascii?Q?gvr/j/6Oll13L9qvVKMrDDX30B0DjQxZkLqGAFzvoKiRlNQhe0P6TRAxLFZR?=
 =?us-ascii?Q?+U1aFtLegUXBKqVHzEr1Kc6Cd/tpMbcRc3C2kwYyINcSa+QilHecN0kkXNi0?=
 =?us-ascii?Q?D13kLhGUiyEqOrBCABNkTLJeJORepfX0bb7fIe8sMm94WGAGruAGjwFWMVRp?=
 =?us-ascii?Q?iOqJLUD4D3wnUaDkGoo+galNwMOnoBmuhnaYIP010CAKscEGctsdcGwGHwWN?=
 =?us-ascii?Q?2yYPW2tOTvK6M4YiwXWxdE4RTw5PSkDTh/V9WgfAnKdFoBD4lyCvR7DpjJnH?=
 =?us-ascii?Q?eJgyXRz1jGVrDBZawLlnJyu0l8gcHq8f1J4PdfwIsfI/YN5EuBYLDzkz4STB?=
 =?us-ascii?Q?F2zK9mGp/sQBce2eRnQ/GPG4GmQfa43ce/bA5GdIDTTMQQYMnMGh6ux3Wp0l?=
 =?us-ascii?Q?XioOGq+IfBqFyjdTmuy9YeYuEt+gp6v4ZAg+/x+NJLBUfS3k9IIb5fvzkjfi?=
 =?us-ascii?Q?oggoSj0Uat9N/iGD0UJhXt06nFiRWZ+tYUwjrtgOzX1OOniQbi5xnRmNkj9h?=
 =?us-ascii?Q?nHIdQMdx+1vWcfM0ioRkrEHhttY/TPHs7MyPxLa/IFaepEvkaDMQfnQ7EG2t?=
 =?us-ascii?Q?dsJdglte6x+hQ9umkO9j1o7jcqde2nT7ncTBPDWDeRSg2KkDckt4Yhbypd3W?=
 =?us-ascii?Q?181c2EIFSJ6/nRJ/720XaI+d7hyDHU01kt/+rIxczXeGVpt8DXMAdzLhxU08?=
 =?us-ascii?Q?VlejfHdxhxu45OPnwBhnPKnme78c0B5BN4L8u6m+K1fuVedYwcpSFNxg6bKI?=
 =?us-ascii?Q?C3MfbNbHxYjL7Lv/QTuWghGzQ5HYcK3xwIAuZVBcRsmJxwjxgYTRJZKiqCuk?=
 =?us-ascii?Q?HkonZsBSgfWOyhqcLhPjtyXaIhY7yG5xi3MoQ4Biu0IyT5Bm9KaSECy+qj3Y?=
 =?us-ascii?Q?eMSjoUz5CEHOqj75hTrgFi+Ve+WCLT4sCt+Rn8ASvGs7yccNC1gRv6nmFPrl?=
 =?us-ascii?Q?jMcEbZ8dPMVJP5dNzITC0iSwqQ8VGhrtsvkHZeuRmYkSrXNz7JR+rch5/JuE?=
 =?us-ascii?Q?zYCYQq5q2JU6rpatufjvjfg3vyQkXA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3854ABCC37CEDC4CBE6736AB0ED62C9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b10231-9085-4bab-29b2-08d8c8632dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 16:45:56.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dt63zgI/szp1EYB/kw7r56SL5HGHLSREixEAF1/lnNChj2ilg5IEckfL+spn6VCg08jc1d2y3tArJ4cMI5O2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-


> On Feb 3, 2021, at 11:42 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> These pernet operations may depend on stuff set up or torn down in the
> module init/exit functions.  And they may be called at any time in
> between.  So it makes more sense for them to be the last to be
> registered in the init function, and the first to be unregistered in the
> exit function.
>=20
> In particular, without this, the drc slab is being destroyed before all
> the per-net drcs are shut down, resulting in an "Objects remaining in
> nfsd_drc on __kmem_cache_shutdown()" warning in exit_nfsd.
>=20
> Reported-by: Zhi Li <yieli@redhat.com>
> Fixes: 3ba75830ce17 "nfsd4: drc containerization"
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

I can't tell how urgent this is. Does it belong in 5.11-rc?


> ---
> fs/nfsd/nfsctl.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f6d5d783f4a4..0759e589ab52 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1522,12 +1522,9 @@ static int __init init_nfsd(void)
> 	int retval;
> 	printk(KERN_INFO "Installing knfsd (copyright (C) 1996 okir@monad.swb.de=
).\n");
>=20
> -	retval =3D register_pernet_subsys(&nfsd_net_ops);
> -	if (retval < 0)
> -		return retval;
> 	retval =3D register_cld_notifier();
> 	if (retval)
> -		goto out_unregister_pernet;
> +		return retval;
> 	retval =3D nfsd4_init_slabs();
> 	if (retval)
> 		goto out_unregister_notifier;
> @@ -1544,9 +1541,14 @@ static int __init init_nfsd(void)
> 		goto out_free_lockd;
> 	retval =3D register_filesystem(&nfsd_fs_type);
> 	if (retval)
> +		goto out_free_exports;
> +	retval =3D register_pernet_subsys(&nfsd_net_ops);
> +	if (retval < 0)
> 		goto out_free_all;
> 	return 0;
> out_free_all:
> +	unregister_pernet_subsys(&nfsd_net_ops);
> +out_free_exports:
> 	remove_proc_entry("fs/nfs/exports", NULL);
> 	remove_proc_entry("fs/nfs", NULL);
> out_free_lockd:
> @@ -1559,13 +1561,12 @@ static int __init init_nfsd(void)
> 	nfsd4_free_slabs();
> out_unregister_notifier:
> 	unregister_cld_notifier();
> -out_unregister_pernet:
> -	unregister_pernet_subsys(&nfsd_net_ops);
> 	return retval;
> }
>=20
> static void __exit exit_nfsd(void)
> {
> +	unregister_pernet_subsys(&nfsd_net_ops);
> 	nfsd_drc_slab_free();
> 	remove_proc_entry("fs/nfs/exports", NULL);
> 	remove_proc_entry("fs/nfs", NULL);
> @@ -1575,7 +1576,6 @@ static void __exit exit_nfsd(void)
> 	nfsd4_exit_pnfs();
> 	unregister_filesystem(&nfsd_fs_type);
> 	unregister_cld_notifier();
> -	unregister_pernet_subsys(&nfsd_net_ops);
> }
>=20
> MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> --=20
> 2.29.2
>=20

--
Chuck Lever



