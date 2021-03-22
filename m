Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13E134472F
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVOag (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 10:30:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51018 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhCVOaS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 10:30:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEU91q052129;
        Mon, 22 Mar 2021 14:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Hk0BAF2g4WnECfnsnNbpBgCGDHBlVnXB9o9T9Ib61C8=;
 b=jY3LdBdmsaGh3/hFn9tx2LswXZFDZ3nWQYXkqclCrKyL/1Lb7LYstNCYsiGwNVLSczJX
 4BIJekAyFmrGzal8dZATZ5A/klkV3iLM+kOPLiK0D3bFej1HuQ7EH4f0Y9DjZ2jKq+9u
 lImxOaI7qsAPt6N0yrqsAH1yKlS7wPusVxSgzqwT+1YA34Jnd7ekcD3yqtzBZw70oU5T
 8z8z88Wd65xJq0W/+vzq+Dd0HMchvoeeD84R1gVh4IHa2kqVRTxJmKQaAgzeUQIoCf8l
 tv+KOsM2nIkgjf73U0CPYxMFmAnOsZy27nQ76XOlKb/COjlylDyIpBqPhGM4QGXVscbW MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbbss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 14:30:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEQZMG143353;
        Mon, 22 Mar 2021 14:30:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 37dtyw5g2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 14:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrOw/4bFxtg+KJx4Gq6O7TdY5b1u1gKA/JsHnKCDGP3B1LoG2OU0MKD3JsZV6cZyu0YQiZEgO+0HJxSNLl4F4fEdDp0Zu51ub+Nl5yBASB+UyqsQl/TWpQiYT4sgrXuhvTY8CsYFxxNsFF3gi4JweYL/QHEebGjmDeHzJSNe6M9Du3IvyN0FLSavGh25lLyZBp2yDN12mDntUdh0Y+xDYDKbm52UAwf3s9u8iv/7Ja6wiL6rRKxhg9/9lsjZKx1dNuztb2SZWYK5utbPKu0v19JwZNAXLxcaAAxR4WE91kzvsLbR9drGiCzv2rcobdDZJP1Wcr0lXrSNX/ar+Fd/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk0BAF2g4WnECfnsnNbpBgCGDHBlVnXB9o9T9Ib61C8=;
 b=oJTBenz0yZLq7cVGajJAIxnoyvMkgthYkhCEEe6FMLX8vS2iTZQbOULTsqEdgYZ2VCrAq700yEYYo3SkIvDi1xMXs8NA21GIOUM19HtYHy5kPVc4QFapwH8hHWbd0gbT3hxyXXhkfYgZbrmcbY6fWiomu5nzNGdyrM2rQLSv2t9pxWqLz1ElHe+GB0Fazm0eugTKElY6UNADIrgcNfsdbUtCzfUj58+IKm4UvmnOkIALhxP4YSgKSApeAaXft96S3Pq3BAGBqavWbjxTS9eoBj0hDzsx/xPbsgEorTF17q9b/Gi2A5QLaZJ11yzBquMO90WW2lB7321tWE6B30DFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk0BAF2g4WnECfnsnNbpBgCGDHBlVnXB9o9T9Ib61C8=;
 b=zJGzxuumoXlATbuLn2MqqURzqiYfj6HhI50dX6zHIEwurOMEPASxwYG6M8xj/bzUR/DsoGYMo2KfPrDjJZVopbE9ohKmYhKddjAVst1utjClLuNgiMFh9X/3ck6detaZLRwi/AyuOG5oLg9OZVdJufCcMfMeOei/BsTiGq4STvQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3857.namprd10.prod.outlook.com (2603:10b6:a03:1b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 14:30:04 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 14:30:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] mountd/exportd: only log confirmed clients, and poll
 for updates
Thread-Topic: [PATCH v2] mountd/exportd: only log confirmed clients, and poll
 for updates
Thread-Index: AQHXHRDs0zSMi+7X1kiD1aZ7IwRuNaqQFZAA
Date:   Mon, 22 Mar 2021 14:30:04 +0000
Message-ID: <AE89A418-86C1-478A-916E-DC0441ACC8E0@oracle.com>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87sg4rerta.fsf@notabene.neil.brown.name>
 <87eegaepk4.fsf@notabene.neil.brown.name>
In-Reply-To: <87eegaepk4.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8df8ed7a-9080-4504-850e-08d8ed3efc40
x-ms-traffictypediagnostic: BY5PR10MB3857:
x-microsoft-antispam-prvs: <BY5PR10MB38576D52BD8A44A34BEB4A9A93659@BY5PR10MB3857.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NizjiOfv3BWDZBBTNPGV8u8gJYbtoBeO1yx3U/JkVVRJSEM3i4dqi1U3997QZZUoUy2QuWx9e4HybAjoYwRxfNSn0WHVjX7Xf7oj9Fm794JT6bv0z0WMbwUhWMn2B/3quAyBDQA3HodO0qiwdJKlGFTZFqHHGXMb2NiWdkt2XG1iPC2vRpqJgr+X4fugwuuVMoFkKlhE35b71IVC8dciS/TgMrslDUsVd7rO5ZcFT4VkPsIoWyMPBANOslpiUd1kE1nF+bDD/5abl4FMZx92ZlyO5W8ldINjQ9FKjXktuxrCVlhmCrbTk4wRoRos6qEiXhqABzqB97FSYSrbpMqJQ7PeFJgXxRpGqH7bt1wrzpl2iry8BbibXFLu4mhNrT1+LV/xU5ocshm7bldV1QHUj48T0excqMimc+izqcvQUR0JHaGadKkDhaf9YLtDbhK48pKzXd4Qjuh3mgQvnR+iMPCvC1dPcTcQFLo6xCEd5pUivAH8w+vRzuyaonk07Q/Z76wnTSANnwiyRccPLkiaUGYGKN9HKwJzQi6r5yN2w8dTI9zXikccaSY+mmBWIRyvFHBj6n4Sr4h+lV/fecTwpvj4C/5TIs9i7Uwawqp/Ic+GEbkOLcmnUCdauvrh/8v3vEcDSuw1/kqSQDzltFFxgdNbRt8Pvx7RmZbR8VvIGp7yr11N6/kOVRFas6aLCwR/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(396003)(366004)(376002)(6486002)(6506007)(26005)(6916009)(83380400001)(86362001)(38100700001)(53546011)(66946007)(64756008)(66446008)(76116006)(316002)(91956017)(54906003)(4326008)(478600001)(5660300002)(15650500001)(8676002)(66476007)(8936002)(6512007)(2616005)(186003)(2906002)(71200400001)(33656002)(36756003)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NIL1X5GMHRR/fJIyEbRjmgMHdCeaEGpsZSdbDgo7lmOyDf+n5rDHHBBfuCHX?=
 =?us-ascii?Q?2oOAqoYlBVg2ms1gH2ibXsPu0ug/Tl7uvhIWHOtxiLdgEOj8Ht02HmcSt4z7?=
 =?us-ascii?Q?3w56cvYMTDqxnIjNgKr9MtBi9uBxVU8AL6rfN/lT4ncviWfHUJCR1c14JshY?=
 =?us-ascii?Q?1pRHnCQTqNGEI8+29QsX89dJvuYg90q0BSjqQzAGsR4TY27yVC2hY+eNVdeV?=
 =?us-ascii?Q?jtTc5znJzcu8qstyFBqmob14SBP7PzMiXKM9K3mA0tGnXAUakYeErB76Zyil?=
 =?us-ascii?Q?LEOn/lmwGVk5cDk4+gLFX9S1kMCAvSur9alkhT4u7TtMItB8bisnjZ/FLi+c?=
 =?us-ascii?Q?OOW85NroB5se4CUtkSK4AsKdSrg5+Ngx4gm5PJC/EZRwxkw0XdjB0t9iCi3P?=
 =?us-ascii?Q?wO30mNYD/IIuqMbRL13JlPchRNyKi7To5S7SnDzk7FOX1DIdbzvgWXyKsQ26?=
 =?us-ascii?Q?EkTOQ0motV5zXdM6IKsLTHxZeMKWhox9VjY15aYzphwvUhqrH5tZCJdeNhmD?=
 =?us-ascii?Q?qgUDyawvCM4TR8K1crdLoLeY82D+iGoc+7TzI5iPU+9BojiSG5OuAj1devEZ?=
 =?us-ascii?Q?f7soPjO77wZnlX8a5gyo3B+Hiw/dQhDNWyM99npgcuFUKb/hoQ3OScFg4p9n?=
 =?us-ascii?Q?Kb39JDT8qDcd2CWVdz22KAimiNvZpW08nlVnRvic7TjpNXWftjIgKAQ3UGjo?=
 =?us-ascii?Q?XEwKS+Z939wIWWI4Ii2kyAPAYOZT7zFH+fVqtcI0WciTdaw4di8ed2o6thMh?=
 =?us-ascii?Q?GULmj6wzLY1IRAvW5XBce4Q9Hl3StbgDuodBTMDwc3gNNjk7E2OmBG8oWydg?=
 =?us-ascii?Q?Wd+IsDYVuKzK7TQBgFU+TuFKsz7Nx6ptsh+vlSkROAj+9JG+g9aCnyOx2sqf?=
 =?us-ascii?Q?auhMT5jAjSanmUUqeUrGYg1xhQA0FNsMTHIjTPmVy2K1Q2sfzjgvHD9GTwUl?=
 =?us-ascii?Q?xEE3nS1s/OBa57PbP6Bf91Ku3nhROahflFXsChB7xWIiy0o8oSxg2/V3xcNN?=
 =?us-ascii?Q?OmbFYsWNqG5P+0LyIWR8tx8aHodarSrYTwqEoGnnCZHlmNyfMUC+444ME0Ee?=
 =?us-ascii?Q?kLLvaPDmYQX/R/w4/Z4YfSlH2zuIjgTQRiQZVDGcp2pHoXAhjpd7z6yxPkI/?=
 =?us-ascii?Q?Nu1YbPVRNEZVjX5xKP3FN1jfsztpDg81wWDVPALELeqD+QHf2t4xlTffqPSq?=
 =?us-ascii?Q?dkBG00SvAA8hqNvWuacW+GXCxcnRZonKw6WjZBmD9m0oY9n+TVBs+GRIvb+H?=
 =?us-ascii?Q?a7rL0W8OgbPfbSk72A51+oDACf9Pjp6qArN4nS/naDUuHzY+vGv86yxc4an/?=
 =?us-ascii?Q?AgYhLn1/+g6xwY7jd4o11O2x?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD5360E6F166984EBFAB8FB9101064A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df8ed7a-9080-4504-850e-08d8ed3efc40
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 14:30:04.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gK3FIstbWVd57NUpKdpdFCsB/J9L2niN2e6ZOHmgGn5xQ7vonAr7yfc+kviwKX+Tgqbx35mDVBIPWvsPviakSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3857
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220107
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 19, 2021, at 6:39 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> It is possible (and common with the Linux NFS client) for the nfs server
> to receive multiple SET_CLIENT_ID or EXCHANGE_ID requests when starting
> a connection.  This results in some clients appearing in
> /proc/fs/nfsd/clients
> which never get confirmed.  mountd currently logs these, but they aren't
> really helpful.
>=20
> If the kernel supports the reporting of the confirmation status of
> clients, we can suppress the message until a client is confirmed.
>=20
> With this patch we:
> - record if the client is confirmed, assuming it is if the status is
>    not reported
> - don't log unconfirmed clients
> - request MODIFY notification from unconfirmed clients.
> - recheck an info file when it is modified.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Hello Neil!

I've committed v2 of this patch to the for-next topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> support/export/v4clients.c | 86 +++++++++++++++++++++++++++++---------
> 1 file changed, 67 insertions(+), 19 deletions(-)
>=20
> diff --git a/support/export/v4clients.c b/support/export/v4clients.c
> index 056ddc9b065d..f2c9bb482ba7 100644
> --- a/support/export/v4clients.c
> +++ b/support/export/v4clients.c
> @@ -48,12 +48,15 @@ void v4clients_set_fds(fd_set *fdset)
> }
>=20
> static void *tree_root;
> +static int have_unconfirmed;
>=20
> struct ent {
> 	unsigned long num;
> 	char *clientid;
> 	char *addr;
> 	int vers;
> +	int unconfirmed;
> +	int wid;
> };
>=20
> static int ent_cmp(const void *av, const void *bv)
> @@ -89,15 +92,14 @@ static char *dup_line(char *line)
> 	return ret;
> }
>=20
> -static void add_id(int id)
> +static void read_info(struct ent *key)
> {
> 	char buf[2048];
> -	struct ent **ent;
> -	struct ent *key;
> 	char *path;
> +	int was_unconfirmed =3D key->unconfirmed;
> 	FILE *f;
>=20
> -	if (asprintf(&path, "/proc/fs/nfsd/clients/%d/info", id) < 0)
> +	if (asprintf(&path, "/proc/fs/nfsd/clients/%lu/info", key->num) < 0)
> 		return;
>=20
> 	f =3D fopen(path, "r");
> @@ -105,35 +107,64 @@ static void add_id(int id)
> 		free(path);
> 		return;
> 	}
> -	key =3D calloc(1, sizeof(*key));
> -	if (!key) {
> -		fclose(f);
> -		free(path);
> -		return;
> -	}
> -	key->num =3D id;
> +	if (key->wid < 0)
> +		key->wid =3D inotify_add_watch(clients_fd, path, IN_MODIFY);
> +
> 	while (fgets(buf, sizeof(buf), f)) {
> -		if (strncmp(buf, "clientid: ", 10) =3D=3D 0)
> +		if (strncmp(buf, "clientid: ", 10) =3D=3D 0) {
> +			free(key->clientid);
> 			key->clientid =3D dup_line(buf+10);
> -		if (strncmp(buf, "address: ", 9) =3D=3D 0)
> +		}
> +		if (strncmp(buf, "address: ", 9) =3D=3D 0) {
> +			free(key->addr);
> 			key->addr =3D dup_line(buf+9);
> +		}
> 		if (strncmp(buf, "minor version: ", 15) =3D=3D 0)
> 			key->vers =3D atoi(buf+15);
> +		if (strncmp(buf, "status: ", 8) =3D=3D 0 &&
> +		    strstr(buf, " unconfirmed") !=3D NULL) {
> +			key->unconfirmed =3D 1;
> +			have_unconfirmed =3D 1;
> +		}
> +		if (strncmp(buf, "status: ", 8) =3D=3D 0 &&
> +		    strstr(buf, " confirmed") !=3D NULL)
> +			key->unconfirmed =3D 0;
> 	}
> 	fclose(f);
> 	free(path);
>=20
> -	xlog(L_NOTICE, "v4.%d client attached: %s from %s",
> -	     key->vers, key->clientid, key->addr);
> +	if (was_unconfirmed && !key->unconfirmed)
> +		xlog(L_NOTICE, "v4.%d client attached: %s from %s",
> +		     key->vers, key->clientid ?: "-none-",
> +		     key->addr ?: "-none-");
> +	if (!key->unconfirmed && ent->wid >=3D 0) {
> +		inotify_rm_watch(clients_fd, ent->wid);
> +		ent->wid =3D -1;
> +	}
> +}
> +
> +static void add_id(int id)
> +{
> +	struct ent **ent;
> +	struct ent *key;
> +
> +	key =3D calloc(1, sizeof(*key));
> +	if (!key) {
> +		return;
> +	}
> +	key->num =3D id;
> +	key->wid =3D -1;
>=20
> 	ent =3D tsearch(key, &tree_root, ent_cmp);
>=20
> 	if (!ent || *ent !=3D key)
> 		/* Already existed, or insertion failed */
> 		free_ent(key);
> +	else
> +		read_info(key);
> }
>=20
> -static void del_id(int id)
> +static void del_id(unsigned long id)
> {
> 	struct ent key =3D {.num =3D id};
> 	struct ent **e, *ent;
> @@ -143,11 +174,27 @@ static void del_id(int id)
> 		return;
> 	ent =3D *e;
> 	tdelete(ent, &tree_root, ent_cmp);
> -	xlog(L_NOTICE, "v4.%d client detached: %s from %s",
> -	     ent->vers, ent->clientid, ent->addr);
> +	if (!ent->unconfirmed)
> +		xlog(L_NOTICE, "v4.%d client detached: %s from %s",
> +		     ent->vers, ent->clientid, ent->addr);
> +	if (ent->wid >=3D 0)
> +		inotify_rm_watch(clients_fd, ent->wid);
> 	free_ent(ent);
> }
>=20
> +static void check_id(unsigned long id)
> +{
> +	struct ent key =3D {.num =3D id};
> +	struct ent **e, *ent;
> +
> +	e =3D tfind(&key, &tree_root, ent_cmp);
> +	if (!e || !*e)
> +		return;
> +	ent =3D *e;
> +	if (ent->unconfirmed)
> +		read_info(ent);
> +}
> +
> int v4clients_process(fd_set *fdset)
> {
> 	char buf[4096] __attribute__((aligned(__alignof__(struct inotify_event))=
));
> @@ -172,8 +219,9 @@ int v4clients_process(fd_set *fdset)
> 				add_id(id);
> 			if (ev->mask & IN_DELETE)
> 				del_id(id);
> +			if (ev->mask & IN_MODIFY)
> +				check_id(id);
> 		}
> 	}
> 	return 1;
> }
> -
> --=20
> 2.30.1
>=20

--
Chuck Lever



