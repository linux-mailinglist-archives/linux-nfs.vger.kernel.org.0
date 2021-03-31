Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4B3504CB
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCaQju (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 12:39:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhCaQjh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 12:39:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VGTn95028082;
        Wed, 31 Mar 2021 16:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T95UIZl65W8sc5/oHroS+5/NnpW0CeYLjrGah/til/M=;
 b=aO2utzJYxircJ/eyrH//3deIfMvjHgGlsnUXlsk9FQjuIfHTcppQEvclmEL6TpFbBKrk
 mtXRJMCBSk8Y6zokYLRg8ob9JvMQ/QvwxRBbyVWX/XaIUistAp6mKnkz8ULQxR9yolCJ
 ww1TjvTfJFxhhZE80bBzNtWNvg8F1QiMrXNcifbXyUYZu6rohdvQ+ckDmh5Ie0VMMSSe
 qqtdEQivfMzJ/8XRGerT2xMcoSwWqJMZiHppMn6Xpu6AIu/W2agyOcq8EhwwnjjFcLAc
 ve9EbdjtycOMnCOenaGd1nbniwrbETg3NQjx0tSi4k4TRsnqGXqY4nNeR3sYXfP4spHN Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqtwqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 16:39:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VGVYQf105832;
        Wed, 31 Mar 2021 16:39:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 37mabmex9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 16:39:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyPHHk4BuCMEKISQsOjegA5mVKYzwD5UZ5t1iuIlKUNaVDqQhuwmMJYVKScVWpt+D5nxj+Ig4elXB7ErIco56nHvKTYoUkzDdycnYrtzPebZAAN/aY2q52xtVfssVtloHRWNu4IAtkDh3eDFESDjZ9L+zrdACmLbRrSoDBkl+LeoUkbFJ2/Gz4TfWqj6nYPVRinO7hdQkFF53evGsquDA31HlTlOOzVCSfytKsDnF73EyOODYpmbRcxQYTIV+ojmFVM3Z424EZr0w++RnzznC9sVTNEp5ud44PcHLWwsGbEO3UaNC2082C5m/qBc1ki4RIWZP8JKvzQUA9McoypaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T95UIZl65W8sc5/oHroS+5/NnpW0CeYLjrGah/til/M=;
 b=GwaMGrAckpvKoNJ7bU/gDYvPadKKZl3cRlOUTxlkHHLc0O2D/5VlCXtsdnBCi42YPsOBRF7B5CIOg36yu/nocFfgcH3+QGqKOhpRQzpy0+nLBmNcKCRTCEr/S/rQyAEZZ4Ssfw/lqOta3da1yoeuoemNMJq91rhjE/ED7r3tE2RFnkm/qt6C4i7cNXeYoWkfB9hQAZ1Lq0B3u2i/RnET43vSV7XKeSRZz0O6IBM5907PCCQi8/LS6fSkF9pF7QtKCBM9uhPWEu4qv7sseCfDVy8OPbSTJhFQG6JU64UoNj3zmZdOD5SS4hVpGzmVNwdKhP8Y6EJvLs7/+bU6PSqX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T95UIZl65W8sc5/oHroS+5/NnpW0CeYLjrGah/til/M=;
 b=OQUf7cmx6TbkEeH3RBPqnCuEoWujstSL422WXQUfnli9mQ9Q5KKZvXodOHZ5lOIf13r/7oAtqA1+R5c+3hKE79vfkT7bpHGBD4h4w9UVDjTeC4GwyYZBk6qJ4HDvacRFiw5L2Hx9EiRY1U+FhD2CLHHt1qIOhYL/KhxsX6nd7hk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 16:39:30 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 16:39:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.2: fix copy stateid copying for the async copy
Thread-Topic: [PATCH 1/1] NFSv4.2: fix copy stateid copying for the async copy
Thread-Index: AQHXJZd18veVkGmMdESYIByvSvllAaqeTagA
Date:   Wed, 31 Mar 2021 16:39:30 +0000
Message-ID: <AAB69ABA-6AD8-4623-A823-B1B3FF8BA1FB@oracle.com>
References: <20210330190359.13057-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210330190359.13057-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90419c1b-aac7-4365-45f9-08d8f4638ea1
x-ms-traffictypediagnostic: SJ0PR10MB4575:
x-microsoft-antispam-prvs: <SJ0PR10MB4575123AF62157F9C4DF6F7F937C9@SJ0PR10MB4575.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z9NAff3004DoqI14O/3+mKbzaXlY7MHIhLl+IJTmej6m6rYw8YDfbZ1x7GrQ1S/Fweyk3yJ5k0YAYkDNrsELQVCO137QDKO1x6JybTPYaYE+uU6o6/BrWvHS9c3VNeg390F7iI6gUABxkEZZzPW7oZIW8v5zw7W8W/gMQZke8mY4+PMXadeDCvSstEzwJDYiRaFATOgjFlES6v1QKAbPtoNVZIw/kGbMvktaP6HsIcR1BkFbGaBkk1FxGCXdcD6CYhvQrZn78ukKIFbJn9a3v+ygrSoStdjzOELidwviiuQWyUYXz7hlCFYnLKCnmGbWfKCqJhNPLXoZQFVFTK40Hpfs971f2wAz0eRmLey/mBpvTcd6u6Fm44T7uzSXHPhwksxA3OtUaellfnEiIFWJ3N6ezvNW1/XADkl14akGvQJBMXiljr1r/b6ryrLuhxwjxiTTN/4iGjEZwQxZNBPkl8BMyxhz3gMDwIQDoGhO3b94WGi2S+y6xD49a/XdS3FdmQhOuK+S/WMCawbo31mzcC00lFfLr9Ba9UwgfFkbWVetLre1KBDR5gFDaRCkXZRDu+gW7KU1GpyVWNvYHiRlB+b6pveKNulpAMnkGFvr2vh+kQ75z0ZVSAkDVLNzjQEgv50gN4sAX75O6sfH4UP9RlpR+aP/TLwsZ2dXKZ3tci55oqgGgGd79k/oMCxH9mn9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(396003)(366004)(8936002)(26005)(8676002)(6486002)(33656002)(478600001)(54906003)(66476007)(66946007)(64756008)(316002)(38100700001)(66556008)(86362001)(83380400001)(2906002)(2616005)(66446008)(36756003)(4326008)(71200400001)(53546011)(6512007)(6506007)(186003)(6916009)(91956017)(5660300002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oAczN/Z3a0zxCfAPi0j1ugmZDHfQX6lYYJ6oIa93Y70qlmaqcl0LCtFeDmZ9?=
 =?us-ascii?Q?wNF2N8XK9731h0PoVC1vnJ2tBbL07otw3xUtBdt/EnkoEIh7LUNQchH/h3vf?=
 =?us-ascii?Q?ydE2xJ90EZpNp5uALknlptIYytCuz2WDaa5N/RvINkVOJaTi3C9sB+fA2mtn?=
 =?us-ascii?Q?oMFUZcST8LVtRjEH39MpYYzYj+MVyu48qGt+2vzw63dQwyZu9OxlFSHwFfpm?=
 =?us-ascii?Q?96M+OQLBQ6KRPmTD45YVX8nafGy5kSiWkbWIU30KViYm60LpXIufGb59FAPQ?=
 =?us-ascii?Q?KHT38yEWkToGlM/aM2GugrfAcBkGpNU+e/Tg6X5Ng3908yaXzv8mX9mt9xwk?=
 =?us-ascii?Q?AVrHEfG1kUDeDs3g/0U7Li+LQ5A0M9UAg0OL762Q4UC5DMYQ7oUDMWociBOw?=
 =?us-ascii?Q?6fDIv3FucrmJbin5fjm8rko6xY6gF4aFHRcTfwBKU3ZIDC35i0zQEHtdvCmO?=
 =?us-ascii?Q?2WyAh6ImFSD5fI69ezPby4kNTICAGIGsnLAWM1d2vneotOnE7j2rgJWz+RJC?=
 =?us-ascii?Q?brhN1qT3hxOUTwsi9SdtF5aR4ICwWCZnyyHRjECTrNzG0OX4ploND6MBBqJS?=
 =?us-ascii?Q?KlkSL7ybJOothV1PM2ytG6HhJrFnEwPyXtlu3ddbiHwyoIx8x0cUyPUYds9S?=
 =?us-ascii?Q?ptCGtc7n6N/zMhTxhXAn4PlM35zdpuYQvTxvJDKq/gTP3sasHXF8/CLhJXDQ?=
 =?us-ascii?Q?3vL3S+xK8p6j/YytSG9dyhY8iT1tQzeltf6r3GGOmtMhJTu9OYfqqaFRx9ng?=
 =?us-ascii?Q?VaAOTJOjM63yVJ0ZB3qJV52wZIk030iLt/jp/FSdK+fGX23vkqtdt6VH4Odn?=
 =?us-ascii?Q?jdkEPjYAGxkgnr8B6E3iU2zCczKGkrKXK7ARj32JMiz+0nClhmZDtUtVjigg?=
 =?us-ascii?Q?b3oVP9gUqvNZNGBipvFRIL+mWeTHe9id2RUb7yU+4mq+TQYMOu/YSfaHNkrZ?=
 =?us-ascii?Q?gXT21W8kKGb5s/3/q3+fpGvltRB6RJYsbWquu74xuwXMJkATYAO6KcdQFqUt?=
 =?us-ascii?Q?sa9nKoo7irXWO9jSkxpX7+f4cOGGsS+TR+anP4ae5hQmzPc3p3nNLTkoE7pt?=
 =?us-ascii?Q?c7z2qiQi4/j3mYc/CnquDD9PDGE/lL4zn2dTP81chT3eiUzaAIJXCbfppuKr?=
 =?us-ascii?Q?TKbB78jvMfp8SDf8IzOyi1/lNkOmcRiUSD+ms5EARSYTnz/tpT9d9gwp6Eum?=
 =?us-ascii?Q?awgb0ukMVFl65zqgKttYl+XD8KNdb3PwWk14TAYlot7x+n5NE8NeOLCQusZq?=
 =?us-ascii?Q?a95ZVJhxAnzAubaPP8LUEtbkt0cCvxCSgBC+XoWku7fa/VOZUgUtWLYXs30T?=
 =?us-ascii?Q?uAknsXvIONKWCevUwRblYvrO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9B6A13174480E44A155D4CC6F863A57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90419c1b-aac7-4365-45f9-08d8f4638ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 16:39:30.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5npu7KvcJisSODwTy8lZ47wuEjdmmJe1humHF6w7D6w+54rYSb1PFSb44kKHzoIGmKRX9kd7oKGQPNIWQkOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310112
X-Proofpoint-ORIG-GUID: wNRR66b_r_VZ9dEvQGJP3G8fbOYmgmqf
X-Proofpoint-GUID: wNRR66b_r_VZ9dEvQGJP3G8fbOYmgmqf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310112
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Mar 30, 2021, at 3:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> This patch fixes Dan Carpenter's report that the static checker
> found a problem where memcpy() was copying into too small of a buffer.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: e0639dc5805a: "NFSD introduce async copy feature"
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Thanks! Pushed to the for-next topic branch in:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

With a Reviewed-by: from Dai.


> ---
> fs/nfsd/nfs4proc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index dd9f38d072dd..e13c4c81fb89 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1538,8 +1538,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 		if (!nfs4_init_copy_state(nn, copy))
> 			goto out_err;
> 		refcount_set(&async_copy->refcount, 1);
> -		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
> -			sizeof(copy->cp_stateid));
> +		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.stid,
> +			sizeof(copy->cp_res.cb_stateid));
> 		dup_copy_fields(copy, async_copy);
> 		async_copy->copy_task =3D kthread_create(nfsd4_do_async_copy,
> 				async_copy, "%s", "copy thread");
> --=20
> 2.18.2
>=20

--
Chuck Lever



