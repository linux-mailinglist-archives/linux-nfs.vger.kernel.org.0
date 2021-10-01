Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EFD41F1AC
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 18:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355139AbhJAQCu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 12:02:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355130AbhJAQCt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 12:02:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191FhsNA011105;
        Fri, 1 Oct 2021 16:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wkp8HPkNFGg+ADhoSmb2oLcNSypc+UKjoc/Rd1aMxxk=;
 b=EJ0WLNiarLzD13+DMq0AR/stQFkNQX7l+ri5+P8ALCf1L+QrUsmWhO4Pp7xEWW4uaeVD
 XYMoYpDtdpqtY812vXmF/xpBHrZXqGz8jyBIVhosOfzoqBWEe0r+DjVml3n4Mmy3v2hO
 Jf4vtPRhheWmNGJeewmvpS584QLeQQurZjFBC5GF4w8eHfam/2edCxqyalLI5S5Y4gsQ
 06DI51S2ZzB9s46CrEH7tKwu7mYZcpJa3VFGazEfjlPocKFwrgldY+uArzbApBaM0lzt
 LOJ9rPjirhB3TIqX+tacdDSzU3OCcDz20dDWWEQUvBUrfoMIIKpEk4i8rHG2etKW9VCX og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3cgw33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 16:01:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191G0aG1175228;
        Fri, 1 Oct 2021 16:00:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 3bc3bpcxad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 16:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGtapUrLMVmbVijoau0PbMkYKAJ21P0870C39qnYupSyLAx9S24U/xeRSz1pZ/YWCF2N6HqCWBvC8DvaqizMoj3q3VqdAcmaPjwkC3Hgz4mRERfvWLXh8TAd7CxFL2rvoK+0F2gUvUC13lnI5WYxSyyLVposqXvlBWPQmGVQzHTFTBfv5+mtLkNfQADUZ/38pt/2BAZJPbxZ78e8XZ4zhERip9wLunfI8lleL0022hJQBl7wLrRTdDsCylFwJh7rB2dQPGLz+RXgvp/ZW8aIkjuf1RTgl4yWro+QMAhroOU7hYidHqYAs+bchKAP5TqTc11EEXPUs6AFrYqYhptL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkp8HPkNFGg+ADhoSmb2oLcNSypc+UKjoc/Rd1aMxxk=;
 b=S0VVfIehgQUDM1wMfIDPFys0xbRrGKxgmwXx0lXaata0147VPCokHkgjdIQEZUsDIv1OrP7urkizX1wU8/pPty7ViZV89SDxIkD4/cjgP71LoXtSYt+wbwQ3Q3CpuMIVe6ZO8jNrE87d2qGQWYosoopQc803WVNHgCocWulOUmTHvUASMv3riO8LCgpeT/KVtlDGNf2+J8MY/0FXwmRNjT296jZP+oCcuEkqNAfFc/gQ/6nTTq8KTzJJOh63eUsa5mXiz0YVCTmutkr+d1B8CnbqTuBH+kt4D4yDtBROov+DiIhfdUMe5DjluRGLlhN5s0qWm6Xuz7L15HtPvwwzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkp8HPkNFGg+ADhoSmb2oLcNSypc+UKjoc/Rd1aMxxk=;
 b=Mj+WrNwS3dycuN4gS735bqz+R8Fs0wTX6K6ErnSnbeYMixy3x+jiBk8g3UOuGeV4MMYivljQKLqIW78Ivm8/uILFVZrsy9OnYEEjELAMvQBrUfQvZdz+fKd+VodGaq00kzz95cCD0iHs7rDxo7VOHEp3HQxLNxXx6t7yWHhvR+I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 16:00:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4566.015; Fri, 1 Oct 2021
 16:00:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Volodymyr Khomenko <volodymyr@vastdata.com>
Subject: Re: [PATCH] SUNRPC: fix sign error causing rpcsec_gss drops
Thread-Topic: [PATCH] SUNRPC: fix sign error causing rpcsec_gss drops
Thread-Index: AQHXtsyNSqrH5UugukSsTqa/lgQ/0Ku+TW6A
Date:   Fri, 1 Oct 2021 16:00:55 +0000
Message-ID: <E80437C9-E00F-4476-BCD0-CAEAFF0528BD@oracle.com>
References: <20211001135921.GC959@fieldses.org>
In-Reply-To: <20211001135921.GC959@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fd42b52-4bac-426e-62b3-08d984f4a71d
x-ms-traffictypediagnostic: SJ0PR10MB4496:
x-microsoft-antispam-prvs: <SJ0PR10MB449684CA8C24967CFB59F34D93AB9@SJ0PR10MB4496.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dej4OtjTO+1FxYCmKcjoy3rVBz/AGQFzJUAg0ZZrLPFfveMqqR/H6sN8qNi0hqLn+FnjnsRbbzKAbb+kPCutBZWy94wKmgC0GuvoVVe78OlpOdph+j0h8q5QCN5nGfYmPiWoNFVu1sLLh9FgqRplv5m/zJR+yzLBBUSnlR+tMjLf5qjmw56ZWwfWfzfwWtD+gDFiYGOQ8bmZUqc/ILZBkhZSRZgV9uTXUwRrO2qbPulvN0Vd5UDiWXekAFiplBdu9vedMovmFgPeQfzSLhZPniyBrijmd7C2Z9mVAa5YVyGuE4v/m1+J7AZe2q+zndrxtxk5He+BohUlKvpduyKvUMg9ojXJDSq/vYRnRuiBEnDTy7X4B0T2oxskE2kOhd5n3uJUhYmkmB3iGa7hosGwI0iyVAd3VW9Y+65ORpyUdcOciwJzuP/O24cpiD2wxRaK3aD1Zv67kvLJlB6apf9vTcrmkMAZ4jz3AuqAudrA2ZF9Oz70hdvWESWMof81J1WK8MP9Cg85rncRamM1qLIG2AFiq4h36pUFcqHpiNZYBu+Tv+J/T88xhraxxJ6fc2QWK1K76WuM5TOhcO+CthuyElFHDX13H3VJZDawrlO82JPRznbaLdOTSWDdSrKKOcHiwHDTBg7JQQuJyaopt0zkQERSuKmgm+dlZ95L5ygfZHrik9gvIuiThDR4ApH+N5er7hNhvwI3z+IjfsYj9KcEmqKMaIWTeO0m3jCP9SU5my1mJ5OJEuAOg2NJKp03Bgst
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(186003)(33656002)(38100700002)(83380400001)(6486002)(4326008)(5660300002)(2616005)(86362001)(71200400001)(2906002)(316002)(91956017)(76116006)(8936002)(64756008)(66476007)(66556008)(54906003)(122000001)(66446008)(36756003)(38070700005)(508600001)(6512007)(66946007)(26005)(53546011)(6916009)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZimSn5f3M0VmbbwKNkZbZdloWwTs18UF1NkL9K2mEXYJsk+xVBrbXS5T2CnF?=
 =?us-ascii?Q?fb4sGoxP1TV+Tno1P6ekvtoyEkBaevMOOBr2OeYgNh66vqQzvresszQnsomi?=
 =?us-ascii?Q?VuQFzwnnL8AD4msJ9lHhH1yKS1ZiIhLcZJP1PaJlSgIQ4EsPnIZdevlXp5zm?=
 =?us-ascii?Q?8MYm8CIhyRvz7xxwAWHFrStmcHL5EDdPsHSUrLW5mJRcx1vskkcWfhyIzxaQ?=
 =?us-ascii?Q?Uf+B++NSdQD3X7ougvxSXF8bMpOl+2VCLtp8LKTpPoC6pKHtZC74TT2aGoAO?=
 =?us-ascii?Q?tZ7W1eJLRcL5kdOZbI3MXQ5NMZMM1Mkc1+mteLxDwqe6iyXeWWnfaxDieNw5?=
 =?us-ascii?Q?sVQOOUoqC3SmHV5tDi+x25PJTrjQQ13jsTSq1t0mMXZ6iY1JX0Zewm72AQhv?=
 =?us-ascii?Q?UP0/XqGOMcmJzsjmpVXiLaLmAkR2BuZGQAekoSlXrOk0JMJoIDESguNV3cRj?=
 =?us-ascii?Q?mDQxuRXbP6cryqLxxIhJ+FcsUvMsxVodCVIrEKZSkfLkDC9/0OzvH5xehnS9?=
 =?us-ascii?Q?DdKSw7D5MqTLg2W6WWOCpex8qbztNDL0cC/tt4xLO3My9aoVNaWqLPany3nU?=
 =?us-ascii?Q?QNQlCfLt0UJFzIykSjMDgOBtALgrBg9sCH9o4Uppix7Y9I+IlIKd9VSS1uI/?=
 =?us-ascii?Q?N2lMVNJPdRCoeukhOdzpJSGBuRm5ZjWLIsfeT33ovRrSgs66y6y/ObhGtaqk?=
 =?us-ascii?Q?4C/RVgGd2osm4ZrwUkfF1e67arbw9VC9t5tIZkuHXQZYRgiOkA2jPkJbBgiu?=
 =?us-ascii?Q?+/TVxzgspj8iaBYUyi2z7yu9z6WLUO4V09wfblk4v0LcKSF9X7fUuRDrlTae?=
 =?us-ascii?Q?CMt5tR7NVVQ3eggsN39KwLxNB6t/rvmlIBzJrUWEktfLDA+/Gi+nFAagP+Wx?=
 =?us-ascii?Q?yxn08NIDriwwVmoUZsxme4kYdcQ82fjX8hJlw79XkDIIDNy6EDJDc6yQEh44?=
 =?us-ascii?Q?vnVn3D31W2CP05U9KHnd8BYojPA8UCunVKST09TfA6GmxOpUsNwiOYUWbOSe?=
 =?us-ascii?Q?nnuFduxQQir5kb0eK3RQ9kexo+8w/kH5vCPDTyMyMBosX9Ugd2SzFmvK+krR?=
 =?us-ascii?Q?JveJJMaMPLuCYlU/RBxqA1Jrd4984MOHU71hYMa/Ithq8fSJyLNAXF1lQeIN?=
 =?us-ascii?Q?PKjRPLJaXxH24admSzmprMOkgs3fjUOVMkQgfyWCwqC67G1XpMzmVrc5QKD1?=
 =?us-ascii?Q?ph3vp2XKFrEQubK0hPyI14jkWVDYHbWxvx22UeU9ozW54vi2bvv352hyIPYO?=
 =?us-ascii?Q?BBJZoEO7WOIt4oNtRtUBtxgiHXla74VefMW9PC8/LkWVfnZu41E6p9JsdhBF?=
 =?us-ascii?Q?K2FGqqbwHTGWpKXU5Dgubc8b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3ECD7E8F91165A47B1C7464C0095E1D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd42b52-4bac-426e-62b3-08d984f4a71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 16:00:55.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFivjNwdDzULwnVXQHlG4dVZJUylR4N4ZqRKHxvgbGlKhp2BJT/bKxLfwAISRXDlI0W2f7KXSxF/TVAWrdCiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010112
X-Proofpoint-GUID: SFuQtZjs1oKo2_NkOVIss3W2zoml6nOE
X-Proofpoint-ORIG-GUID: SFuQtZjs1oKo2_NkOVIss3W2zoml6nOE
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 1, 2021, at 9:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> If sd_max is unsigned, then sd_max - GSS_SEQ_WIN is a very large number
> whenever sd_max is less than GSS_SEQ_WIN, and the comparison:
>=20
> 	seq_num <=3D sd->sd_max - GSS_SEQ_WIN
>=20
> in gss_check_seq_num is pretty much always true, even when that's
> clearly not what was intended.
>=20
> This was causing pynfs to hang when using krb5, because pynfs uses zero
> as the initial gss sequence number.  That's perfectly legal, but this
> logic error causes knfsd to drop the rpc in that case.  Out-of-order
> sequence IDs in the first GSS_SEQ_WIN (128) calls will also cause this.
>=20
> Fixes: 10b9d99a3dbb ("SUNRPC: Augment server-side rpcgss tracepoints")
> Cc: stable@vger.kernel.org
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

This will be included in the next NFSD 5.15-rc. Thanks!
See the for-next branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index 7dba6a9c213a..b87565b64928 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -645,7 +645,7 @@ static bool gss_check_seq_num(const struct svc_rqst *=
rqstp, struct rsc *rsci,
> 		}
> 		__set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win);
> 		goto ok;
> -	} else if (seq_num <=3D sd->sd_max - GSS_SEQ_WIN) {
> +	} else if (seq_num + GSS_SEQ_WIN <=3D sd->sd_max) {
> 		goto toolow;
> 	}
> 	if (__test_and_set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win))
> --=20
> 2.31.1
>=20

--
Chuck Lever



