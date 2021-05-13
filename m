Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0011937FDD7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEMTJ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 15:09:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36824 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhEMTJ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 15:09:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DJ5SlQ049698;
        Thu, 13 May 2021 19:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vS4yuPZsrVSGbiBDBS3A2HUHsRMkBZmicTq5tt2/0rk=;
 b=hXeIHITq/UGOXMMfKXNoTt6IXGGmfGqIX2yEkFbbaGqn7zTTiBim3fnc40taEJUEmVpG
 kMiFvGggwUn+7EELiE1u4F18Vl83y+ZjeqgZ+KzFhRW5vk6CHic+iDJdoHxDJA75RIJn
 /3I4Ug/pNjIfCe5/kCiiBXcdVJWWk49vHU8HCMS1koDltKLG2BZb/PknsoeGCMaS1ESB
 smq6zXVyL7RhBAH66pjiA7O2vATW+SrEk+oKFY7gqUafYT/1g4U2ytil19OGbaTLErSJ
 obBZcRhWXAyUFxnCrcGtlxWutSShIn52Lznu+t+1YWyfRyJPBM0GLpQkct3fkx/PvnXB ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38gpndajyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 19:08:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DJ68Fo031768;
        Thu, 13 May 2021 19:08:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by userp3020.oracle.com with ESMTP id 38gppggewr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 19:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjoCiVsczDnzKyzY42eOn+4R8IFx0Nt7FlrKT3H2PT1ZKBE8s8QL7lsr7OFeH3ysv9G7GH/FA579TqoJ4kR2PfG0ivBISzQ6qjiLBGUGHgxxqX9MWr+Uj7uWon+OpBTMYWD+c2qY9mwuBpKan956mrCtMnW9od6WDAOl2d/TI6ZOUwqSXRRPsVpb1930y+zhL/CNztFCzwf+QwCMjsfUK+qa/qt3SaZxquJCL6H3QyDKtZ3IZRkpTvFPYWeAPxZaHkEhv2RnPnul7Lm6OTxZHLwXFYuOl67dN6FVddL3gFqWg7s+MF0ZmuJV1vYIfvFSBfeEWk65f3YLWTUcPzDPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS4yuPZsrVSGbiBDBS3A2HUHsRMkBZmicTq5tt2/0rk=;
 b=ka0k6+ViPB9EDFElfxuyCii+cYwOb+JzUCtuKegpjdug6ybPbzN8tGUz9sZfdFXI+0rQ6NMSvUik5yorhBm8uuihvMrLz3Hq6UvJjzpEbGjPqog5LUrpw6XcTxJ/2sfINtYinSsSZ/q6G4v9+QkekCetkz8a1lHEb2XXgXVRTbfK/nnhG5IjaST1cgrh9zN92hK09O/J05ZZ/tuPWUj5y3RHTVa6H1JeXlPx2OVC3clkonPozjr0fH3Hik7l0W4RsmKnGBKxs5M2NVb12yfgyeXJiztcf9cmEeI/8kd7YUCOApzFueje+DmQGntEj1uNUtWx6F+bqh7eYy2KpPvLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS4yuPZsrVSGbiBDBS3A2HUHsRMkBZmicTq5tt2/0rk=;
 b=HXHhBRXDHnB8NdK8LUbD9m1ruQLztAxj8KIbPbpdCrez9C6KT+Rh5V9H6rcyuQCV2IiCbpYECxlrYGUlFD524D47Azxdqpl9Z/k5zG5CDGzTAwNyQDXGDbEQ+yv1C/DaljhLUplLQpg864G/dfMy6TKCVFogLxKDTOa1TDocxhE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 19:08:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 19:08:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64AgAFwTwCAAAWZAIAAO4wAgAAE14CAAAITAA==
Date:   Thu, 13 May 2021 19:08:13 +0000
Message-ID: <C618B795-ED20-4BA8-9C18-333EB42AD9CD@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
 <20210512122623.79ee0dda@gandalf.local.home>
 <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
 <20210513105018.7539996a@gandalf.local.home>
 <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
 <107A51EE-E0A8-46FE-9E62-9FC586B91F19@oracle.com>
 <20210513150047.6b8ed9fb@gandalf.local.home>
In-Reply-To: <20210513150047.6b8ed9fb@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deec6e21-3304-4137-798e-08d9164274b7
x-ms-traffictypediagnostic: SJ0PR10MB4637:
x-microsoft-antispam-prvs: <SJ0PR10MB4637B85A5A896082416FA2BD93519@SJ0PR10MB4637.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dihsFLHOlPPusN1pt5YVulKA7koyGsuTle8UTkTNc+ZPdBT4T+/GUD4j1XqCZdrE839qPoY+xDg2i6/c65Fk/2U6zOAdD3CJF/vDpvtIjlhRb17yVGoWP5UYNE7XvT+OoG9N26qsJxW1VRR7/c6qhT3GrZupDSQ3IfCG7a3x7c0HU0od61kcba5kjYXpUsRI6gSZgfahv0tXzMqQfUzUrgHjMEIifFNuzlxutKeuYejHitZLMUIICaTdUV15QXtfQRDLyrX47yh9PVWYKPsEb0UEe9/DiX9FSxb4PipbOpdT5aYtFWOzESp22iayhAn4QVpP7qxyGXetYYvehnOYrEWEIVEv6KRZ+mPdnSdmxD52SV88KV/evmEYqGmqpVmF4oz0NL7krdPapei7p2g46gsQo/RNnSeAKEjZKIMC1tsuRGRsb3qyhWyyFHj7pqiXe7lHQJKwS8SG+8/dcB9YVCnha1bnqryo1B+UPJKxuuwsQFNcCSG3RrRrQUhJB0T7ccIz8n4vc92+ccrcnxThy84OKQbqsEOCZ99Elu7L5Bs6An9Qui0nReaqWE467CnOhJ6N4D3WhujtvVnr60eqV/1LQvKEKx01ClwmTgMvzcMA5gdR7esolTt+Vec9FpjebrpL+/KUnAu0l21VLXetm0GL3lGIwsiJEa9EKCcuGlA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(6512007)(36756003)(4326008)(5660300002)(33656002)(2906002)(478600001)(86362001)(38100700002)(66446008)(2616005)(54906003)(91956017)(53546011)(6506007)(6916009)(71200400001)(186003)(316002)(66556008)(6486002)(66476007)(4744005)(26005)(64756008)(76116006)(122000001)(8936002)(66946007)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9AugBUm9/HieCE+RA+UzK0DgytYbAX2KwgyEUI2vZu46H/4CmKx6qxLtUZzP?=
 =?us-ascii?Q?oTM7jq9lUwhIZazViZe9M2LPauxKpJxvbNcxuMFAdu5zM8/rnRj2EIyofW0h?=
 =?us-ascii?Q?9W0rwvXrzPNZFgqEzm7dcbc6fM7F9d1MOIsEYd/HrAJGajwaReHpxM4ZpROo?=
 =?us-ascii?Q?GX+cuKcd+aA5QY3rS96peAxCyVD+1BWF6HGhWKrWFv03gOOi+Yo4REg64udy?=
 =?us-ascii?Q?imt2TsOIwlXwmWPAPrhJmQgwAVO2BapcwP6Y6Y+irpp80ngVb/iym1U86adS?=
 =?us-ascii?Q?IRlL/t53jhejs6MEW0B9ibBxzY7uTY1s/8ozIlGagwBsufkysNBn9ELNylEB?=
 =?us-ascii?Q?+AAEqDdW4N1OM1TW18qAA6vp3J5P4TANKmguhRpHDiov1huiR4M0ead6ZcgH?=
 =?us-ascii?Q?kSBNy9lrY7cGMmFFzRuZyaPArqC1IqFbjei50R351yN/yM1B+8pk4A9v6YcK?=
 =?us-ascii?Q?KFJ30IZJFEkeeI0/VMfzTJ4botPwD7bb1BAm7iLfd7RHDh+GPqjyNV1Db3up?=
 =?us-ascii?Q?M+NW6b5TsqNUwDfpwCqQcn8jEhBUasl6E89+CyFASEWXum8Q44zzwt2NMtYp?=
 =?us-ascii?Q?tKi5OhoBE1kj43uJ16yqUeliucZiq2EPs8SEj7E/DdTgWU+TNOWc9BuHD3gg?=
 =?us-ascii?Q?FlUvQloCAIM2vjtk9HHzYvae29gXiKg/tIEeWTQym8KQ7Iu6BYgaq8WuW7F9?=
 =?us-ascii?Q?G3pcuK6vn11iNf7f3DReIv+ED53ai534oShzg19nWA8QRLJvfhkgARs0twlL?=
 =?us-ascii?Q?cKbWLMFAmhOnFVqXB3vHqpv4JzYEpU8nwvH2ksA2AzLqPg/sFECwO7NUr81F?=
 =?us-ascii?Q?HaMPzuyBnzkVU0tNG39d3FXjfrbe94bJVxWMxl+5PV6iSYD9OQlj11axs7z5?=
 =?us-ascii?Q?WL/jtUOLRGcAX/0MfMrPxUfMyb0+3uzcCQPSzO3FKdXBZzjCDM2eGjEHRcWP?=
 =?us-ascii?Q?ACObttfKyEwF3kC5noSLV66yDRUXs2MNarU4OkeG86iQKD8Tg69qqoBfomYX?=
 =?us-ascii?Q?L4Zy5hpthcipH0uINIWXjOD2nWw/sQhlt6aA/MYUrzu/6c9YyfvjwQUOspb8?=
 =?us-ascii?Q?G37NZn9fk6KOjEsJdW5roZyFuFamqcnIWkXaKY323xDosFXNnG/gTnbRqT21?=
 =?us-ascii?Q?t2GsNM5J7O/aPAnkrX5fwZuPisdJBWnFuF9vCRO+P7mUESjqKPdQt0mGVG1M?=
 =?us-ascii?Q?RzsTMvNWnCMz+d/SmuyX/3pzJbn4tCddUYwOjFbiGcQ/SSnG8B/xMQ+74iq3?=
 =?us-ascii?Q?DGYiLdZ1vH3kAQt1CMVccN3t2oSTPdtAlmUXSfPDt8LQFictgf2PYKwbbtHI?=
 =?us-ascii?Q?+l9b3pav2GxaUG1AuswuEezQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AD8980EFFD57542836482EEBD008EC2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deec6e21-3304-4137-798e-08d9164274b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 19:08:13.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0LE86lJM2H8EhCSNVO72sjeF6ErHQH7bYh7MtYb4t0FarIfxNl1FXovQQCT7mqqsIhTe6QtU18wG+NBYJWPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130132
X-Proofpoint-ORIG-GUID: ekOsarwckn7ZUmXiBJzARZk0TnZafsK4
X-Proofpoint-GUID: ekOsarwckn7ZUmXiBJzARZk0TnZafsK4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130132
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2021, at 3:00 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 13 May 2021 18:43:29 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>>> Would something like that work? =20
>>>=20
>>> I will test later today and let you know in this thread. =20
>>=20
>> All good.
>>=20
>> Tested-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> Thanks, since this is an enhancement and not a fix, it will need to wait
> till the next merge window to go in.
>=20
> I can write up a formal patch and let you add it to this patch set as the
> first patch, or I can add it to my tree if you don't expect this to get
> into the next merge window.

The tracepoints that currently use '%.*s' no longer work when
using "trace-cmd start/stop/show". They were working before
9a6944fee68e, so I consider this a regression. I plan to
submit patches to address this for 5.13-rc. I guess they will
have to go without the use of the new _len macros for now,
and you can push the macros in v5.14.


--
Chuck Lever



