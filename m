Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EEB30E20D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBCSKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 13:10:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhBCSKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 13:10:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113I0NUr079259;
        Wed, 3 Feb 2021 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wGh25vbvogu56APo7i42U3ULH13jzRZUyUTXQv+uNmY=;
 b=eb6QjVMQtxeQlsYFI45neezVwfjWLNVS666s6Dlr3xj/wmKUREAjj8hntrIShgjZWWiC
 3Lx3uCjefX3kVcvnKK8UTpYgn/HUPguerrrVkMK3Q7BChYs+sLwpb0ggo4MpxuovhOiw
 wi0qMPQBxep/KowEnpLM/OU11slSPXkTOkcHfthp0adKWj9uhSPPwj54aJjTeZ1WMTcl
 GnKtL6AHIxwda2hH6EJHTqiacVGsafZzMf0WjuXE6T2fCMUIFUpPee6w9o9CungGcHja
 9oOenhUaXgdeiF90qLrUzD5W/7ABg/AD9tNkgcFFG3juEi5PCM1vzJjnPbhaT8fWrZB2 SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvr46uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 18:09:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113I0Ii4118820;
        Wed, 3 Feb 2021 18:09:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 36dh7twff8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 18:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro7MWsvXT8gkv421bxkdghtuBMKmRyhxvl0vUQZLXGLD83arUeyZAu2bu8jxjzxT4beIfRJ8YZ9V1wy8O3Nb/ldB3bdAGKtd8GcRuOr1I+qEtNiexjxYoVwbNFoxcwpcCt1f+FE6qIqgsR2YMCj7ZUAf4vrLyghEzRAmDaltRgG3JMnA01Hhr9HWj3x8Nqc7s3MDnJuO58Zigw5AWzR6ZezbgWszqClr/5TWZHbT+br7p04GL1Qp58BiKf8ltk9w+7xHFxV6lns1wWO9anD1X0p6V3EkH6ItwB4cPBl4a0NjEM44BXcz3OZPtUF46s0t13e/wH/vQpEhmtCNhzFJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGh25vbvogu56APo7i42U3ULH13jzRZUyUTXQv+uNmY=;
 b=liE9EHKAYZJGZc8QCjgiE6VxkAz4nhgsfFDRMsFKDmbwgF59VEVFy6Ha8DFC8+gYCFVlEknTx77UtUyWKroWOqhrKQ0VYs6avQrnBihBfpyudOEn8MQuI5xDpspjQ08ertBFWC7w4khKAjPytt62mKKUebvvL1mt2UAL5qXJlgZtirVCLxecS2O6Puq+lLP0aL8VSDqXzUMRWgtCeXaIvWVY2F78esv5FXx8h9aIQwW+t/GWwSDvR5NORHZMKzqgWHVBPS+9QV1RvInFkkdpgxCrBox+UgBk24BV3TCL9Noi9SvOvzAjjBq15CwMkxZPKLdo9DJETuq7tf61jP/Epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGh25vbvogu56APo7i42U3ULH13jzRZUyUTXQv+uNmY=;
 b=M+23V23RJssDa63jLfF0TTTEZbzw0Jao03FZAFwRAaN0cSMdKJGByEdoMpOglDwFTWM2Z9xOFQNDPb6f+lWajmGY6XAsyY527exBUgArnb6XNGlASvFQOAE7TG+L/werfdX0hqOrUY0CriY0WI0aYDVUXIdNJPsiixHbYAkCUsE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 18:09:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 18:09:45 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] xprtrdma: Remove FMR support in
 rpcrdma_convert_iovs()
Thread-Topic: [PATCH v2 1/6] xprtrdma: Remove FMR support in
 rpcrdma_convert_iovs()
Thread-Index: AQHW+kkkB0ViIEM5jEWO7hNw7EyLY6pGuhyAgAAA0QA=
Date:   Wed, 3 Feb 2021 18:09:45 +0000
Message-ID: <13F6C716-AF73-4B45-A248-EB4BD71E7C38@oracle.com>
References: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
 <161236943446.1030487.4542967452464402073.stgit@manet.1015granger.net>
 <a2a7d8a1-9372-04ac-7ad6-f29c34ef3804@talpey.com>
In-Reply-To: <a2a7d8a1-9372-04ac-7ad6-f29c34ef3804@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45fe552-a4fb-459a-f49e-08d8c86ee311
x-ms-traffictypediagnostic: BY5PR10MB4388:
x-microsoft-antispam-prvs: <BY5PR10MB4388634BD69E851CF13520C893B49@BY5PR10MB4388.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjAoBA8oJPek5Wdn/wspZiRBSJ1uUWFrpO31qYDSUBE/RhDz038hQxKtNiLguNZR02iurw/RnLZy3kt7j1XuXqfgEYcYymdb9zdtVeGedYiQRu41VKK+Q+PzvdObY8AjNeTN1GVfpWJWPC/p9q3T1dnCpKV3k/LIo/YamiIzbWx0d4OoyJe8AshdRBzetMfwonPWuAgxso2fVPNKRNcsd2PmclnH7NbVnRAK/FN2O8Z0O1no330/iPDCbHl71b291lbNzZaLh3U7pk6iONDSIt4UbpItvUDvHtrj0dkmE8Mn+64CqY0liiFv3FWSsxJQGaGsPA8UI7YLXtfw8LeEkFpr5DDaPfMsqynhp0unhYTa8rpz+NyAbj90Yn+hwKv1XFkZ8WbWowCtsWMUq8yjIqBtnaZQgXldbrCZxmpMmqJOURvUlcacyYUKvfW14dwBdetaexfnt83l7FktgPCDblZ5yTdvhb5XULdEjJIL+jwrVhyjwSjvQd80ku2TYJ47++JQNvgC5sAdNN7uQnrKz9tFcH1rI9CdKyqXRWdu9+qYsICSNsU7OGpK94RbLslxPAW8Log/usEtmiNioHJ6gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(8676002)(66946007)(76116006)(4326008)(2616005)(478600001)(91956017)(66476007)(54906003)(2906002)(44832011)(86362001)(36756003)(316002)(5660300002)(64756008)(26005)(33656002)(66556008)(6512007)(71200400001)(186003)(6916009)(8936002)(6506007)(83380400001)(66446008)(6486002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e4ijif9oz/IITAKgIZOS/gv6ErWfpuyF2zWRl50B0TTdSsGXkUSSUBsDXD18?=
 =?us-ascii?Q?eWlcnr4bY38icF3ErqfvoZFMnkbfp3hFD9o2w4Lt0er2wuZYOyTpcP/qXZWo?=
 =?us-ascii?Q?WVchqTa9eWJikK8M/x4XJgS1exlAwvWMdxvQb4uKV1Bd8ehTjfo8RL9Opg46?=
 =?us-ascii?Q?2KotjbJETyGsSvQVFnF2G6aAGPt2k/1A9zC+8pwdW8qE0O6YDUmey5ocQf91?=
 =?us-ascii?Q?1g8QIqC1rcl6nRtP6qVomF3hL3nT7RYjS+DHItZynVJfYa7dQFmcZT2NUTGL?=
 =?us-ascii?Q?7lqg2CGTlgG0qiaN9G4vFlgAINFgdoD1ygWcJZlz3s7texGgzj2mN2RGFlWI?=
 =?us-ascii?Q?4xAWFlUDylBPvod4yocUYvUVG/1K7Gd8RP99feVm/rfPkxEKuw0vOL/SPU+d?=
 =?us-ascii?Q?v1lUtIGqYN25aQL+ey1GZuzNRvq7Zu1wtU0t0rQxnu19xDRzwUtQ7epxb6Y9?=
 =?us-ascii?Q?cMUr22J5xyn9ejRhQY+Jq7O2NZ5Tk6sE1y17L5vhjynBESWCJVMEX0kpmwa0?=
 =?us-ascii?Q?8pTQ6pidMsTQ6W6F7r2xOp6X1I76O2yGTbgupLKYXJwhdb/G/y2NxU7+4EjV?=
 =?us-ascii?Q?6tOyJ8T7pzbrn9nqnozyuxw2UlXPEGcL3vHPPKlMcE04TKAYVtMbzhc8q4B1?=
 =?us-ascii?Q?gbvcfSYT7NlPoX+q0z8CnAdmRwrXOVIEfFbWXNKmwWj2sOYQV0LBx5vdn39h?=
 =?us-ascii?Q?EPFfhIgd9e5UdA6ffr/LqKQD4PgaQPQ/54zw/YuH2D/pGbIkofxP8gbOthHf?=
 =?us-ascii?Q?GtpmawMmAtlZ268B7GFYyqne8+/wopshvMz8M+M7VRGr5kJLk1u82f673Jq1?=
 =?us-ascii?Q?fxzaCtd8neJIFWI1wwIgjIw3xj4p1CFro67rCFaSy0t/eT5jTqnrl/kp7pFL?=
 =?us-ascii?Q?zI1ioTL0U/IKdIZHOWZInbVQxaHLZCarkVLA4+ia381aa/HxlfBR5S/zuNA3?=
 =?us-ascii?Q?fjdWY+pCTx5mF/f6eP2TFjLbVdPEyJ40DAPBx8L2ree+v6ycUG3ROXYMix7V?=
 =?us-ascii?Q?+bCkR3R+LF+TJWpssXC8+Z/3c7JXsvOH5nNfdP8UYjv3RFzTUVTGom88tvMj?=
 =?us-ascii?Q?/dWjVZ94ySjmjuiGA4Vq1hslV6dUsQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFB4BFDA6B6DCC4BAD9E03253E9FC9B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45fe552-a4fb-459a-f49e-08d8c86ee311
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 18:09:45.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Omac/V59VgFhTx1awyLdtu8LwCbE81dlYGIioCrAjSFkbwcy66OwlNDa+U6K1nj/TI0mXyByoy/HTOiva9pGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 3, 2021, at 1:06 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 2/3/2021 11:23 AM, Chuck Lever wrote:
>> Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
>> Remove support for FMR memory registration") [Dec 2018]. That means
>> the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
>> commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
>> on page boundaries") [Mar 2016], is no longer necessary. FRWR
>> memory registration handles this case with aplomb.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/rpc_rdma.c |   19 ++++---------------
>>  1 file changed, 4 insertions(+), 15 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rd=
ma.c
>> index 8f5d0cb68360..832765f3ebba 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -204,9 +204,7 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
>>  	return 0;
>>  }
>>  -/* Split @vec on page boundaries into SGEs. FMR registers pages, not
>> - * a byte range. Other modes coalesce these SGEs into a single MR
>> - * when they can.
>> +/* Convert @vec to a single SGL element.
>>   *
>>   * Returns pointer to next available SGE, and bumps the total number
>>   * of SGEs consumed.
>> @@ -215,21 +213,12 @@ static struct rpcrdma_mr_seg *
>>  rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
>>  		     unsigned int *n)
>>  {
>> -	u32 remaining, page_offset;
>> -	char *base;
>> -
>> -	base =3D vec->iov_base;
>> -	page_offset =3D offset_in_page(base);
>> -	remaining =3D vec->iov_len;
>> -	while (remaining) {
>> +	if (vec->iov_len) {
>=20
> This is weird. Is it ever possible for a zero-length segment to be
> passed? If so, it's obviously wrong to return an uninitialized "seg"
> to the caller. I'd suggest simply asserting that iov_len is !=3D 0.
>=20
> I guess this was an issue in the existing code, but there, it would
> only trigger if *all* the segs were zero.

It would be a bug if head.iov_len was zero.

tail.iov_len is checked before the call. I think that means this
check is superfluous and can be removed.


>=20
>>  		seg->mr_page =3D NULL;
>> -		seg->mr_offset =3D base;
>> -		seg->mr_len =3D min_t(u32, PAGE_SIZE - page_offset, remaining);
>> -		remaining -=3D seg->mr_len;
>> -		base +=3D seg->mr_len;
>> +		seg->mr_offset =3D vec->iov_base;
>=20
> I thought the previous discussion was that this should be offset_in_page
> not the (virtual) iov_base.

Addressed in 3/6?


>=20
> Tom.
>=20
>> +		seg->mr_len =3D vec->iov_len;
>>  		++seg;
>>  		++(*n);
>> -		page_offset =3D 0;
>>  	}
>>  	return seg;
>>  }

--
Chuck Lever



