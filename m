Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC6D41F1A5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354539AbhJAQBf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 12:01:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31746 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231434AbhJAQBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 12:01:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191FgBqL011126;
        Fri, 1 Oct 2021 15:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DkMZkg/1BjAKs3W70sWOOtA8r9WsQFbcHYNw87rX9Yc=;
 b=erPU/vhODgjCGHtYJC23dv3bhfvzf8Lot0IAM6WdhOVSjHgwe0SJIgTR7N8ZTCBGm6V4
 bWWPzMQqBBcgCowjBx2fI03B6+Sgp4XUTKNdQA3urJDM5klM1u09nlAm1+AhTdVrXjfv
 gp6MTU2wf5uIMqYLKuBPzWzV/BGet0YoeDzmAypOe7VdYK17BvBUHtpEvmTtgvrhnOXk
 l8YCb+Uh6GdltdcgbWxpOfkdLkC1eu3iE2utSEskrJsf8J8osjCwqFfov/AOyOvhRp3j
 Hn7byjIlvR9K5TX8J80/Sp3BpSgdEhPQZIrHIakpaLEurxEWHjqzXEh2aiLoFRQKAfEg gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3cgvs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 15:59:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191FuaEg158718;
        Fri, 1 Oct 2021 15:59:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3bc3bpcuj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 15:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AazL7gcTf6eKb5elPbcfoMnkVzFI+bzTyL9dduMCUMuMuH0/Le+nqH+CvNt1sFnLCxLn4WlDMxSGIPQCc7YmiKAwODzHIhYwzoiaTsh4Rn5dQCo5l2MnJWLwWr/oCV7o7ZR4HybMSGnleYQGdF33LGnm2DOiqHDLzyUhSA4z+fGRnpPEzIhQNqyJuDJJ8WN+i8MkIwIcuj+Mu5izZWUqENnXW/AS7apaHw65Tbu1mTHB/hHjSjQ1lWtzg0Frl+qnoUVnpQuAdoByo2MkZMfxDfyUkyTUhMX1Q0YtdAK0dzMizgh+iHLtS4pCDGxTSg2sWOUp5xFpJDNp0OVpzNh37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkMZkg/1BjAKs3W70sWOOtA8r9WsQFbcHYNw87rX9Yc=;
 b=JfUWDTNYpmfuQ7USu++aecnLh3XSpB09atiAajbFIRRnCPbYRNGfQ9HpGa3kOGZQnumvddhpEO7dnlzPkKAjwCO4/93Vs6TO6hoqnz/TWlEvumLwjha7/jC6GwFQqEeOsht6Fo/HohbYbydjOrXl429OJ0obpLotphyD4HhyoQbnvK/szi2Emmn4MuVZ6OjIsWVC4FbiPc1jI4jHEBbvUrF4wgUMmhxBDdgb+kcpljZtEkCSqaX6HZwl0U29QHOECo1d4yUc7XzNt2anhNhKULTxwYYiPJjluKNivMtKteoGs1zCK+4Ct3xjBUFiIH4jgnC6s+pfxEY+M5YsQYFTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkMZkg/1BjAKs3W70sWOOtA8r9WsQFbcHYNw87rX9Yc=;
 b=BUe/bpwuj+T3qzhjhg2dvmx8ycgf1+WXwBoUln2g+7tLUJe7rYa+PRx2yfk2Bb+VJQn42C+sMqiSr00IPrk+pEWVWJS5eqBtZX8F6QTS2yvMTuGIBnJal8NYO15q2d5CYxCbst0Pi/lu+s6QZqbbHAoauOxVM5ow9rhQNZxtxB4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 15:59:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4566.015; Fri, 1 Oct 2021
 15:59:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfsd4: Handle the NFSv4 READDIR 'dircount' hint being
 zero
Thread-Topic: [PATCH 1/2] nfsd4: Handle the NFSv4 READDIR 'dircount' hint
 being zero
Thread-Index: AQHXtjOgMzi2Ujlpq0WjAUuBQEBhX6u+TkGA
Date:   Fri, 1 Oct 2021 15:59:36 +0000
Message-ID: <C079F240-64D2-4967-BCD2-4A6C425A78DA@oracle.com>
References: <20210930194442.249907-1-trondmy@kernel.org>
In-Reply-To: <20210930194442.249907-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ce9edab-670e-4783-4145-08d984f47819
x-ms-traffictypediagnostic: SJ0PR10MB4496:
x-microsoft-antispam-prvs: <SJ0PR10MB4496CB86738608773CD61ACE93AB9@SJ0PR10MB4496.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuO01ME4VOQ2QMCUolgZ+sPVxdak5jHgX71u3zNhQGa9bgU1NmIHSSKsl0L626ddO/P8oW1tPfGYRSd7J+XPrytBVwEqOTWaKg8drGtKuw3hAsbWK33beMQUerZap6cBrFppFje50s6g4+m5sxga9pSelm7hug0ZxT9H1yikFxXOqnAj1XwxG7KDbGbM5XYkNXUyrLNNMcifNA98RO8zhDBFW7e+dbcBb9Yyapwp9W7rgej7tTr2nxKMUlsAiv+Vd59S7TJhesnkuRtC+3vz6gSpYwbrR7r3qihNrEh/xBvGMkaRKf9yDd7kWsnF+qrLaFzAo25C5t1vu0kD+AfQjYkaHQA9w/kpDUWMNBqHDcCgi3+j0n/ZEXKzlg5Jk+B7iL2q88CwxDIkfwpQjErJYL4WCB8aSG7ZMNgNmQ5XT4/Z2cvAmZYpA+luaFLb0iiSzDAOjw72J7VtsPj1L81+PwP7kueD7BheGrlgGKGeEpvnH3sIhUmvpaZTTINW8jaocGoSkBreRkc+UsRuO9+5MCxOaWzXl1WleCSBIABr+6CrBi+DixJMttLk+ieHkqSLNyUkQB5p7kwFmnRvoMgQmrwEHWD8XvIhqJWRJPVZTc3vGRf7X4uOIrY001gvapSkrNCohHAYpW9ZSISIzkmeAJ8zLm//M8NMnK5M37mDXz//tO+wkMBq7qEUUkxsr9n5nPXfvEz9/lcgLDHE5+6A/Az5tU5AVTpYoSDIhp+OWy5JDO5OQDXAnu1fkaf0bwd2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(186003)(33656002)(38100700002)(83380400001)(6486002)(4326008)(5660300002)(2616005)(86362001)(71200400001)(2906002)(316002)(91956017)(76116006)(8936002)(64756008)(66476007)(66556008)(54906003)(122000001)(66446008)(36756003)(38070700005)(508600001)(6512007)(66946007)(26005)(53546011)(6916009)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4r2ds5JDTtCnOsysaiu0hTFlyeRziowxt7TKkKicRB6yvCHy0dBHyzTghCV?=
 =?us-ascii?Q?1RrQpL0zcMGGJut+ptsXFIxBubT1sUv9qCOlPjL9B43zEkTGq38USn9EXHjx?=
 =?us-ascii?Q?pwtyoAQ4bdGuriT8U1sBY3lEybNU5ktueODLidlb3ZUicHeFCegwM75a5dmr?=
 =?us-ascii?Q?CBLS68OeIGRwHEYx33/1+fAJMNhQjTUfjRk8K3VIkLKEZtW2GPakAroyEzjb?=
 =?us-ascii?Q?10mn4dkXNnNzqnaLQGazEahNQe0lOelXeuJHZjdnlzIqIhZogP2BwkKFDyOp?=
 =?us-ascii?Q?hYGdSaz3dQxaGrUu6I+JSiOXfrn76rK59FpGGjl9XJoNeNSDyfhOy2z6fqzb?=
 =?us-ascii?Q?XKpQ78UU4ffizRLKJ9nRVlAR9bqGCmA8X1avmyh2uVyirZiaVfv2GaR1JKrL?=
 =?us-ascii?Q?D8Chf/AF6Ns4ffZaOYg8h6H8ap+AUn4Q8wox3yanPIY3ln1j9VVKjAeMZGgW?=
 =?us-ascii?Q?Fhs5okuNNGoaPbBSZ1dLGpTDsqh2NKl8HvXEZseGQ0tpZDA9cyJ02gLeqb1v?=
 =?us-ascii?Q?6Ib+lcaQ9Y/oTjWWEjvlSxGofCz2T4Gq52lv2NkPVAsNbQ9rpogoVV1fScU5?=
 =?us-ascii?Q?kq6F6FXRiQah+HOkRPs0B8AdYFHkb/1gLhtnI5LFQX2yjhBKi/EoaMc8b3C/?=
 =?us-ascii?Q?xfxuy9lXT0Z77Rl4zM4keswjzLkMhAHUVAR13EWZBPA1iDlvmS/FXZd7ImTg?=
 =?us-ascii?Q?c4QX01PZbfiWvzmFD3W9wTWSsTSYhtt36+jxh+NH22HKcgTvhwZE1xuOhtJ0?=
 =?us-ascii?Q?mtSwUd3c2dESnwrSLtUJEEaiakWolzuUR2JMwtksww7aIWl+9wK37mjZzzoV?=
 =?us-ascii?Q?WdihseKtR4HM+djc+7kAVBWvXBMep7YTMokAVu0s3kNA8Fu0+UCXJBFw3Goi?=
 =?us-ascii?Q?GaieR6BONt9afzBmwYa30HINyBwDrKjIoVsmyTXLcP9yifzIb1rZpj69Sgln?=
 =?us-ascii?Q?swd+KssAlsst5oSb8YAAygUKamnxl/3FXWYK1UxyKV94nRxfWnVQ1v9Gy1Sp?=
 =?us-ascii?Q?j7QGhY8Dld6xPxHhZ/GMoY9H27yY+toOTl/dtwAW4adloAafVW1M3PJAQ/Nr?=
 =?us-ascii?Q?wI4xSfQwBk6lyYKhiT+aIGXwj0tjZ6ySTiqGmXvYQar5Nom5iSGQ9/TZUOYF?=
 =?us-ascii?Q?YqNjOs3STW77Iq+vKMFDHHwQtUs/MTiYCF0n6WfzdHGJ5a1owHZJqmp0CJAU?=
 =?us-ascii?Q?fWhidGEGUwi4/yORv6xJJ9sn4zE9T0bsOJOt8O8P6bgffhvLWEvnU97PqHi0?=
 =?us-ascii?Q?f6WCSpeC/7sphd7mRQj09+qV7igwmSpUDV4dJbU1adOK6X3yLlFXunlzwnLr?=
 =?us-ascii?Q?B0eLb0NmMw776d7TV44frjGM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B6ED5ED6108BB45AD3B8D2F8D140482@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce9edab-670e-4783-4145-08d984f47819
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:59:36.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjMSGC5eg4453D/kSQ+Y76IGXPIa5XiFXfGfGAPahmB10xu+L3b1Y2YNMjd3BodKfLb9cGFpkFZ5GsMmtAb9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010111
X-Proofpoint-GUID: tGAyY6Odx9-9se3TOTScMEvrXVI661Aa
X-Proofpoint-ORIG-GUID: tGAyY6Odx9-9se3TOTScMEvrXVI661Aa
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 30, 2021, at 3:44 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> RFC3530 notes that the 'dircount' field may be zero, in which case the
> recommendation is to ignore it, and only enforce the 'maxcount' field.
> In RFC5661, this recommendation to ignore a zero valued field becomes a
> requirement.
>=20
> Fixes: aee377644146 ("nfsd4: fix rd_dircount enforcement")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Pulled into the next 5.15-rc for NFSD. Thanks!


> ---
> fs/nfsd/nfs4xdr.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..cf030ebe2827 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3544,15 +3544,18 @@ nfsd4_encode_dirent(void *ccdv, const char *name,=
 int namlen,
> 		goto fail;
> 	cd->rd_maxcount -=3D entry_bytes;
> 	/*
> -	 * RFC 3530 14.2.24 describes rd_dircount as only a "hint", so
> -	 * let's always let through the first entry, at least:
> +	 * RFC 3530 14.2.24 describes rd_dircount as only a "hint", and
> +	 * notes that it could be zero. If it is zero, then the server
> +	 * should enforce only the rd_maxcount value.
> 	 */
> -	if (!cd->rd_dircount)
> -		goto fail;
> -	name_and_cookie =3D 4 + 4 * XDR_QUADLEN(namlen) + 8;
> -	if (name_and_cookie > cd->rd_dircount && cd->cookie_offset)
> -		goto fail;
> -	cd->rd_dircount -=3D min(cd->rd_dircount, name_and_cookie);
> +	if (cd->rd_dircount) {
> +		name_and_cookie =3D 4 + 4 * XDR_QUADLEN(namlen) + 8;
> +		if (name_and_cookie > cd->rd_dircount && cd->cookie_offset)
> +			goto fail;
> +		cd->rd_dircount -=3D min(cd->rd_dircount, name_and_cookie);
> +		if (!cd->rd_dircount)
> +			cd->rd_maxcount =3D 0;
> +	}
>=20
> 	cd->cookie_offset =3D cookie_offset;
> skip_entry:
> --=20
> 2.31.1
>=20

--
Chuck Lever



