Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69837FE82
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhEMUCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 16:02:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhEMUCr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 16:02:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DJwnsA103982;
        Thu, 13 May 2021 20:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=frdAsFlsjBQuEB38mROpnIneVe/gf8SkHVRv7ZJrbVM=;
 b=zX/iVVeMDCRhk24cj133lEVp6QJGQNiBqCbs5RLD2+ksQwxgaJPQae+aq7XwMEZWnm5s
 7NIc/uJbFLw3mUCU/L/wMJ9veByFbRCiS5ZY7lMiMr2XDHrgcCEQSuKBPp5qMAMT3RV8
 o6DGMVvpuqKcQqUrQPhikS4X25/1P6h5nJu/Pi0aM/aW2t18UVGvhimlACiLPzOjQBcS
 V+w6qHarOiEksVDCJDTf+q7Doe/6hltZXL7flYXJQ4sWcf4Q2yee+ESHP+/ELtyxTcpk
 N7AVZGrabzoU0tkJbPZB/b7SeknngyurPVK/uwQ4F15qNaoltAfUnh9ytyah7wSxgJBf Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38gpnujpqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 20:01:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DJnl2F023903;
        Thu, 13 May 2021 20:01:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 38gpq2cnnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 20:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E36aAxw8Ye4iutQUKu0qJeLJVm5pyk9zmNGWV6QangmZ1fQcj8W8Ji7tHJIMf0fiEpbBb1tlekDuWxLNbReC7WkFm+h58gSInCi8UshUSNMwbX60NojdCjYwJGf63pHpPkZRAZc/YhbT2FRP7GcxR7E/reXLFsx/UOEUMS0tVGut9zK2DYXpiTjAY9o2dtlfrZF4rqnN5PFNGhRBwVIvph5WOTBIvt7kn232rFPjjAmJbdcJ0t2tklSbqZE3/UYK+DnGbK8Ptli6zVcyWoexz69I0myVRxLFwW5pOUHea8FlKo+/jouj9jAJM7+XwHN23/X6fRtir+syf4y1F23xZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frdAsFlsjBQuEB38mROpnIneVe/gf8SkHVRv7ZJrbVM=;
 b=ej1fHx0C7O9Dsx9H+JU/OhdrD8/u6K+SU1f5KPgw4ry+ryVkRz6EmpiE/LcWftaWt8auCir/q12QTXUjahxm5aAqVGo6S3yz1Yqa+aAqc+z0KGo1mXjRpRs/7tF6ttjdQ140I1tlb+Gi1xEsU22ibml7aIA519rNtWnh1ICMhH4BmhTPkq0w4YRQDC0VPgOm/Rnh5A2e3E7NiEWojxpC0laIWMiDLRGLtm+SzGXzRQWYwe5az3z97JSBvoi0VHXy3aiMl9miN5YKU1vyLaUggseFx1AzDU9Ftq7LTe9KeW+0RkJIG+NHFMKhnxmYxUb/V2tcjnEWdaYmcpVEt8cugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frdAsFlsjBQuEB38mROpnIneVe/gf8SkHVRv7ZJrbVM=;
 b=z/JPxerXPnZmxq7PHV3pHcmc+iOgFrHAdUSumJFG9ANAbgaWUUE4UV9tTz18js9/h6hIwjXSVpnoqk+aS7EDsnII45CgR61yT09h7urCUfQ5KHJ85E9heW2FX8L+jWJ9yHYDtd7NKbsC+qIKro6Wcnp8gdJLOLf+E8fN9Qp42tA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 20:01:00 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 20:01:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64AgAFwTwCAAAWZAIAAO4wAgAAE14CAAAITAIAAAo6AgAAMMYA=
Date:   Thu, 13 May 2021 20:01:00 +0000
Message-ID: <5BC8482E-1902-432A-B162-774A96E4C2B7@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
 <20210512122623.79ee0dda@gandalf.local.home>
 <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
 <20210513105018.7539996a@gandalf.local.home>
 <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
 <107A51EE-E0A8-46FE-9E62-9FC586B91F19@oracle.com>
 <20210513150047.6b8ed9fb@gandalf.local.home>
 <C618B795-ED20-4BA8-9C18-333EB42AD9CD@oracle.com>
 <20210513151721.02a7fdd1@gandalf.local.home>
In-Reply-To: <20210513151721.02a7fdd1@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a202859-12d8-4891-59b7-08d91649d463
x-ms-traffictypediagnostic: BY5PR10MB4306:
x-microsoft-antispam-prvs: <BY5PR10MB4306C690E760DAC077DEB79E93519@BY5PR10MB4306.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BpshqACXm/btkION67Qh4IfXWNuncOwRa6CosFnogJ8zNq7lnxn9JGa+1jRkdnB4pJCXXrxDFGEoD/aLL+p7+sAW84jGovRby+KT3gSIaLGjBGWVg0SgpPMLrEw/SqJmfjGEMh6RJ5iPvtCaogcCiR7FaHqGx4Wlr6FXasd1P7bbm8nBrOVAacW7ieh8M51a/hYBifw2mjciGxIAAia8qQR3sp6lovms8S7Hz2FBacjpR64MHKya29IQ5f9ojPWeOvMAXDLjKMZLuoWT23stXzlYsXYU3Oxo08c2lxWzCnLK5XLxt5vMcUnkDR/J0YwtkmTt9v6NOY2+0xE1TU1Gx6Z1H9omHiyKu4u3bUryt5G+CBNtOOtONkVUwBtu1XaGKDHhITm0pdLtkNLG4t1m3pMlMo9xdohv4Mj/63Zs1oDd/8NM7L8lyo3toN+ETk94q9+bpM2fno8kMnAC0RPdthdHhsHK66c36G5Xi9YhKlmpiONmDBIw8HzeEBNb+yj4EBHoa3/gB/Q/MkIdRBSBuy9zm9Tcvk/+bKksocSOT5H0UfIpaBhEabEqBXj0v5DX1myRxpgE2uI9+3w8ETJXNPWkPYkikl8tG3mjWbwpN3ICgWiLbfQa8zhCQntz0m0EMrEAGWrSTIdY/r79x7935GqzRiZJ0sLpoaWAutWyVE4mMS9R5MiaS2HafEWgQqxSHMph9a3DsYvOnoQBvzTES4xJMGk2n/8oLbiTE6alk1Qv1BVlZfUsa9o3qKL8mi5D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(26005)(66946007)(6916009)(64756008)(38100700002)(66446008)(2906002)(33656002)(36756003)(66476007)(86362001)(5660300002)(8676002)(6486002)(122000001)(83380400001)(53546011)(6512007)(76116006)(91956017)(6506007)(8936002)(966005)(4326008)(478600001)(186003)(54906003)(71200400001)(66556008)(2616005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?24/cFtJeG59rdF2g4qe93aaBAFQmvdwmlpN32KnLKN4sFigwRFO4J0u5cFvh?=
 =?us-ascii?Q?djB3MmOPryMMvb4qWc9u3k7VjMF4AZ6GLO85TmDyT8pkZMrmjfbKtLPCJtHE?=
 =?us-ascii?Q?JKB0ZUbCMj9XbqYgWOiNfx3he4XFC58e6RF90I1wegOb7TP8fGEM9KxrokrM?=
 =?us-ascii?Q?0pbwrK99WE22W4M3+88ah4ZRfEmia5eQwU54NU8107n4iwteh370NIx+Ph7s?=
 =?us-ascii?Q?uTDuJaHEwqcHC3XpgTkglw5pNfl4XF7OiFX+OHMBcUkQwLTBDXAjtspHPQaa?=
 =?us-ascii?Q?suZoVTWvXG21HD+ZogBf1U4Aci53KiA6BysXULd/o7OqcF1u9o7+W5Skp7Mf?=
 =?us-ascii?Q?ugBVQB+on4OyAVVSEITVXm9YWdJ4qN9c6+H/2vTjWCDsOhlFYQv9oCTP+COJ?=
 =?us-ascii?Q?hk+DeVyMon78RZaNmeydqyw0ylNNIIfsDAo1zG9BieAP8GicE/5UHBDEmyIu?=
 =?us-ascii?Q?lJp1CqdY4By8/fXk8wq72wpqplXOdvafAvyNy69EiM2Sx+bVMBZBL73ZmN9h?=
 =?us-ascii?Q?O7903iq5Q9368ZyZ7jZTGdwqzur2lSbG69NLr9vOrTEme5Vyzgj4DCybNl3q?=
 =?us-ascii?Q?XuSIT1Fgyf18yVwoWOTJl15pebA2ob2vDJ5cWd9tfhAYOHw1NsBGHo5KYpN6?=
 =?us-ascii?Q?a+dWNuw7fdcOcNzBx/ryI/SJxzRuNq7gsXjQpGJLyVQZAGDaXrdXo5jjI/sX?=
 =?us-ascii?Q?97Nos85Y3mSrBcU8PTibug29JqePrH6I3Kh06ilIZuI7659OGFzMVYXFmFKh?=
 =?us-ascii?Q?c8UHpgmor1yh9pig/UubCRfQqI6RCCOiOoB7rzj3gF5JUHUHkZPdNDQUNvEE?=
 =?us-ascii?Q?RKEyt6d9RPI4+0L295XFa+DIzFD/KJ/yHUtI+9rx6oP0BvpTeWRioBhJ5WwJ?=
 =?us-ascii?Q?Hn7ltfxunBMrGA6tgvuPnZk2BqUCp5sLUxolhEt4GXVgCU9NCCGFNKeylnM7?=
 =?us-ascii?Q?/OYj7N46vCwFQMFSlNO1y8Ohxn6BUGhQkGQf1r1ZKcx9aehbrmOU3cReIuHv?=
 =?us-ascii?Q?r4Y+Rusc6pKeVNBul4aRTJW72SK+Pb1JD9p8i+3VnCQi2nCNxvpNvY0PZUUf?=
 =?us-ascii?Q?AqV0GbcEjOmF/rYE3cYMU+Gn8JefD1KvuZQGKBIcQinBQf7Ws5gYVZVkOeyY?=
 =?us-ascii?Q?jWv5iOqrYPqBPSXppkqmnMx9G/U3FvIii4h6ed3OYTg9of4/lFmEDgjhfSmj?=
 =?us-ascii?Q?mrPWAD2+Y+nGy0JqmFkvOedBQ5ixRkmc0SUO7fFYdZSwi2MXefNE4h0WXzyR?=
 =?us-ascii?Q?Fn0LenVZ58S1ERUvjRmCvjwLdFo5VIbNiLeSg9zVEAzJhkLD1d3z384Tz3Z8?=
 =?us-ascii?Q?F9dfFPvtsPfEbSAalM26pSVf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E838509F28585F459B9D2A44CE0957CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a202859-12d8-4891-59b7-08d91649d463
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 20:01:00.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqbDexOdhLHbN6yo/1c3dnrO0n77mr1yKQaiYz7lry0sXa09HbDXUzwIZSDlrcgx8nATC8QE1IrzdatcUFKMgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130139
X-Proofpoint-ORIG-GUID: WsC75f0U1fr_jZ1mFpBuNYEKWaX2xLPp
X-Proofpoint-GUID: WsC75f0U1fr_jZ1mFpBuNYEKWaX2xLPp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130140
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 13, 2021, at 3:17 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 13 May 2021 19:08:13 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> The tracepoints that currently use '%.*s' no longer work when
>> using "trace-cmd start/stop/show". They were working before
>> 9a6944fee68e, so I consider this a regression. I plan to
>> submit patches to address this for 5.13-rc. I guess they will
>> have to go without the use of the new _len macros for now,
>> and you can push the macros in v5.14.
>=20
> That's a separate bug. I'm currently running this patch through my tests,
> and will push to Linus when it completes. Feel free to test this one too.

Confirmed that applying the below patch addresses the regression.

Tested-by: Chuck Lever <chuck.lever@oracle.com>

Thanks for your quick response!


> -- Steve
>=20
> From eb01f5353bdaa59600b29d864819056a0e3de24d Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Date: Thu, 13 May 2021 12:23:24 -0400
> Subject: [PATCH] tracing: Handle %.*s in trace_check_vprintf()
>=20
> If a trace event uses the %*.s notation, the trace_check_vprintf() will
> fail and will warn about a bad processing of strings, because it does not
> take into account the length field when processing the star (*) part.
> Have it handle this case as well.
>=20
> Link: https://lore.kernel.org/linux-nfs/238C0E2D-C2A4-4578-ADD2-C565B3B99=
842@oracle.com/
>=20
> Reported-by: Chuck Lever III <chuck.lever@oracle.com>
> Fixes: 9a6944fee68e2 ("tracing: Add a verifier to check string pointers f=
or trace events")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> kernel/trace/trace.c | 31 +++++++++++++++++++++++++++----
> 1 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 560e4c8d3825..a21ef9cd2aae 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3704,6 +3704,9 @@ void trace_check_vprintf(struct trace_iterator *ite=
r, const char *fmt,
> 		goto print;
>=20
> 	while (*p) {
> +		bool star =3D false;
> +		int len =3D 0;
> +
> 		j =3D 0;
>=20
> 		/* We only care about %s and variants */
> @@ -3725,13 +3728,17 @@ void trace_check_vprintf(struct trace_iterator *i=
ter, const char *fmt,
> 				/* Need to test cases like %08.*s */
> 				for (j =3D 1; p[i+j]; j++) {
> 					if (isdigit(p[i+j]) ||
> -					    p[i+j] =3D=3D '*' ||
> 					    p[i+j] =3D=3D '.')
> 						continue;
> +					if (p[i+j] =3D=3D '*') {
> +						star =3D true;
> +						continue;
> +					}
> 					break;
> 				}
> 				if (p[i+j] =3D=3D 's')
> 					break;
> +				star =3D false;
> 			}
> 			j =3D 0;
> 		}
> @@ -3744,6 +3751,9 @@ void trace_check_vprintf(struct trace_iterator *ite=
r, const char *fmt,
> 		iter->fmt[i] =3D '\0';
> 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
>=20
> +		if (star)
> +			len =3D va_arg(ap, int);
> +
> 		/* The ap now points to the string data of the %s */
> 		str =3D va_arg(ap, const char *);
>=20
> @@ -3762,8 +3772,18 @@ void trace_check_vprintf(struct trace_iterator *it=
er, const char *fmt,
> 			int ret;
>=20
> 			/* Try to safely read the string */
> -			ret =3D strncpy_from_kernel_nofault(iter->fmt, str,
> -							  iter->fmt_size);
> +			if (star) {
> +				if (len + 1 > iter->fmt_size)
> +					len =3D iter->fmt_size - 1;
> +				if (len < 0)
> +					len =3D 0;
> +				ret =3D copy_from_kernel_nofault(iter->fmt, str, len);
> +				iter->fmt[len] =3D 0;
> +				star =3D false;
> +			} else {
> +				ret =3D strncpy_from_kernel_nofault(iter->fmt, str,
> +								  iter->fmt_size);
> +			}
> 			if (ret < 0)
> 				trace_seq_printf(&iter->seq, "(0x%px)", str);
> 			else
> @@ -3775,7 +3795,10 @@ void trace_check_vprintf(struct trace_iterator *it=
er, const char *fmt,
> 			strncpy(iter->fmt, p + i, j + 1);
> 			iter->fmt[j+1] =3D '\0';
> 		}
> -		trace_seq_printf(&iter->seq, iter->fmt, str);
> +		if (star)
> +			trace_seq_printf(&iter->seq, iter->fmt, len, str);
> +		else
> +			trace_seq_printf(&iter->seq, iter->fmt, str);
>=20
> 		p +=3D i + j + 1;
> 	}
> --=20
> 2.29.2
>=20

--
Chuck Lever



