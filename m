Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECA30CB75
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhBBTZe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:25:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58868 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbhBBTXI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:23:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112JEDTj120221;
        Tue, 2 Feb 2021 19:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eJwbRoFdEqKLmY1D6IC+6+t+u6dsuHFk1jw2pIbNx20=;
 b=a7K2deROYBbn/YyNsvU5+D4IOK/HsJr3cMOhGRl5+I3ZshLF/rhw+L2OKTy1nJtE3BVb
 pRQTY3GKaPQH9Pw9z5zgg6+jgYLRtHUwPRIqnPak9D4qSsh1Jqacmng39O/VdPbPk+FF
 /jlWuuQJvZhRTaVzHsmH0IRDDCO4vpxQwn2+gPFJktpEF1XSePHXWSU0GA0g59CgsX+p
 qDQ9r3SsQQWF8ZO3YLbBYDG2Y9UAOXuFCLMW23NWXhZzZ4rzLxtp6i6R9njJK3eUi6yM
 OynSodekrTx0gRQGv79dBpYGgCIk4QoI+zJ1nakB+JB/mMh4eVWJXQFbElMuUa0yvaK3 Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36dn4wjcf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 19:22:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112JKAUn125673;
        Tue, 2 Feb 2021 19:20:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 36dh7s23av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 19:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR7130doxABwJLBfgA+6OvMGoKVJs3xRL/iDntGu/WYDuhqIQhZ5oi49k+OkI5nnZrPfeCncXjtiZ+CXFyjAEkUx4OVfE2noLvkcG7eSyrc9+5w2vj/BesOtodmrVSPLeiI3QqPYEF7rlrvZJh/YsYPfea2wGY8Ma8+iJJsRnOZBhV3h8G0/uxit+ATphgWzgu/U0jj9n2Bo3Tdlu0CsvkhO3zWFWzTpWNofChCDkqFfBddF7uciaAVNxxaUk7qLG4IzHNSXoLeHTDnr8TNOg7meDM/q/2F133oNK/GxjjsI8v9HDNZQWM+LHspdrgKRhT6Qomsqi0KZrbTWC96LKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJwbRoFdEqKLmY1D6IC+6+t+u6dsuHFk1jw2pIbNx20=;
 b=Bq/h+wyGQrstIfmDmZbjo+g2jkLPrtqpZiB7jw9hE2aHPxPKFPJgkPXe71hwqTYo6fXyAb5HCxT4j2OorIWk8ovLUKaKMjil4uy2ZGXee3iMoij/3QGDF1bMwqk+fIINb4wOZ2N/v1ub2Tx7RZyDHSwGE9MABVpjtVMM/fj+AJNAFzJKIkdOi8xg2vav+reSMbUeXL7yZLIzqw8PeuwnuyHMfEzWNZPAKfqbTpmUXCs3BG22mf+YSO1+XKFfCZ1kwXBoGf8kpXwUKEjfTZ/uD5NWe3LyJVv8K2QnWzCn2ksOZfKi/KDkJyju8km+XfhDxAxKO1XUecKGf9sNwYFNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJwbRoFdEqKLmY1D6IC+6+t+u6dsuHFk1jw2pIbNx20=;
 b=tCzp9XY+P0UEpW7cFBjlFadAE/jf72NvzVdS74Y3Q5YbNADjHXl9wPva1lpX/RrSbv2AeCNVOC5bDbyIPbyQFGwIkK6o6PRA+PGPti+AzZcohlVLuqWncCj3Qpn0dxos5scjXO/Z4t1onn/8b7kjvliwPgKUdV2Aari6HPA+QHI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3857.namprd10.prod.outlook.com (2603:10b6:a03:1b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 19:20:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 19:20:13 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
Thread-Topic: [PATCH v1] xprtrdma: Simplify rpcrdma_convert_kvec() and
 frwr_map()
Thread-Index: AQHW+XI3YU9+0Px6s0a/A4oYM4MFE6pFPVyAgAAAmgA=
Date:   Tue, 2 Feb 2021 19:20:13 +0000
Message-ID: <B0EED542-086B-4E76-9348-FAB8EBA612AB@oracle.com>
References: <161227696787.3689758.305854118266206775.stgit@manet.1015granger.net>
 <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
In-Reply-To: <e53cc3c2-2209-5f35-c487-9e59b9b9e526@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb3a4bf9-d06b-4470-2d48-08d8c7af9089
x-ms-traffictypediagnostic: BY5PR10MB3857:
x-microsoft-antispam-prvs: <BY5PR10MB385735E0C4857352D1C2E39893B59@BY5PR10MB3857.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:146;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxeFV4BSulTHQJsdfTYZPbJNruFe/VROxqBiHol9KIPBlOUuxdeEAV5ZNQioBV5PY6Du+a8mnyTsAqARhGBzSV5VjzICk/1/ZhcuRpknw6FVWncBX11b0e98114FYV9ORPgyuoywE6CGaQWEHZd37ZOx2bDIOzGr28lfS/hmriAYzV/8bewZkgK3A/9vWoNueUsRvFZiTnBQsSnhiWwIJD8EQxWlmrUpFc3zLZ3NUwMifv9Lafyw9fYqXRE4baSihWEmEU+TbimHUI7WLZhZgSWUwE7e4m4DQBUAMjTgnQH5sLtjBdunkfsIhMlzrsW6eMGsPDTsnwH0zi7gbBl16lspVmkc0PT1dMXDLKmWpVWmIxc4GzWEAcrGqHF9doRPSFN2EsTiDtb5opfkoriviDWpWhZt8ki8hp5AA7msn70vec2hVmZGMWA9xVU2CGtFpTeYWehmASgMKPfRKkvbnAGY+HrsFC0GtbRpGyHKugPQD0DBnrzmaS7u8Tfqi6Dlym8a1HBdKXcSFb+taeWP+u2owMejFxR+AoWLnXcDHksig3BsiiBWrhIyiDKfffu2BYrs/r89U7mDopcCxrDg7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(8936002)(66446008)(6512007)(26005)(33656002)(66556008)(316002)(6486002)(76116006)(6916009)(64756008)(66946007)(44832011)(91956017)(66476007)(478600001)(54906003)(83380400001)(5660300002)(71200400001)(6506007)(4326008)(53546011)(8676002)(186003)(2616005)(36756003)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tH+EiSPbYgzGsE+kLvJvcoQpXWnN7fq2fQz0VxfaDdp5Ay5SJSX5aCDbvAAW?=
 =?us-ascii?Q?tXBii1T/mx4fJUKj54vfu7VLdXx33lPlJfBZnGapyWxJAA5XYdz/tar4wMH5?=
 =?us-ascii?Q?TzprBQbZif+6GQaQBJGiUhln1AdxFVz/ZKvzbtc7t4Upx65pnUT17pqHoPZE?=
 =?us-ascii?Q?PRWjUaBMZfDjMQ+hjZ/sELwEVYPSgDXiZhnz4IW4Po13AYhBX/3Uz1i2w/pQ?=
 =?us-ascii?Q?+ATKNMV2ubUCAhxAiZF7LGmZuHlxvZb6ASebBB1lBbdPBe2eEcAAjGgUB5vW?=
 =?us-ascii?Q?ahLpB5rUS/ODfP+Q5tzc8Soo38DA8tcIH6fDuTvE9rwoezm4SqP8M93X/T22?=
 =?us-ascii?Q?86y8cG7NfE7lJyCPafVLq4RCU73YEidqfVdFMFtcguli5doXAL6Anm85eM8e?=
 =?us-ascii?Q?QqFlefWDcVnEOcW9eb5Cv8JELN0g1fPF1BdzQo6GwX+scNWvJuCfsrfNxX4a?=
 =?us-ascii?Q?rwu/9NMeFmTfnGC+tsTwmjaSPa6JPPnmyCBfBhJcASh+mTAuVauLYgQU94Lf?=
 =?us-ascii?Q?B1h8Mr4NjklZ/BDqC2uVPheeJ6UhtHq8gWud5i8ifyrC5o6+BsbFNsi4bmIS?=
 =?us-ascii?Q?Bhqsp97IheyG0KbT/6XtmwMeslE9IeW5wq3Nl+FilxhjIJBo1i5HpjcdGRU0?=
 =?us-ascii?Q?jcNSHDU28fP0SyEflvKj4lQqrT3Mmgrw9SGZeiQ7zpHJFsLoTt4dp3c+nNk+?=
 =?us-ascii?Q?43n0nt17KwQBdYYFGEO7i7ETZdhazwAuYi2hGmXotIihKhImy+pDOU0h1DKy?=
 =?us-ascii?Q?hfFcvrJ2JYpD8Tc7XZqFgZz2adxnzrmk4SpeI0uVsduMCJT6XksnI56TfBHR?=
 =?us-ascii?Q?VWBn4TP3qGIsdq4eepuBfWrpzx9s6VWWOxyIvqVof96jPDBGseeaT7sVf//O?=
 =?us-ascii?Q?VbBe/qa3w9bgmJzFziAfy05zkc+vDvXVNVyvsSnjRfsvPWyeUMiV6INEMkDV?=
 =?us-ascii?Q?cR/aQ6GN1o+nqE45qxgtLXrZcoUT/RYP5tJ7N/vziYs2gqcjYKvS+8Iccaq/?=
 =?us-ascii?Q?Byv79KH3NpOi1ZOFnUTtxN2higSq6/EzSMu5mGh982TUi6yfM7obvaozvfp5?=
 =?us-ascii?Q?e3HuZOowe5Fy0wiz7y72EES0B2PCBQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <604C6183373499468683E38EA216DF73@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3a4bf9-d06b-4470-2d48-08d8c7af9089
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 19:20:13.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ys79HJ4+7gzMw1DAayug+7tb4t+ZiOtDzzL/RYEWq1cl26V3JU4S5k8iKiFaxUkYgcQZhgdjjqpKTT/60n+KbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3857
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020123
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020122
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2021, at 2:18 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> What's not to like about a log that uses the words "with aplomb"? :)
>=20
> Minor related comment/question below.
>=20
> On 2/2/2021 9:42 AM, Chuck Lever wrote:
>> Clean up.
>> Support for FMR was removed by commit ba69cd122ece ("xprtrdma:
>> Remove support for FMR memory registration") [Dec 2018]. That means
>> the buffer-splitting behavior of rpcrdma_convert_kvec(), added by
>> commit 821c791a0bde ("xprtrdma: Segment head and tail XDR buffers
>> on page boundaries") [Mar 2016], is no longer necessary. FRWR
>> memory registration handles this case with aplomb.
>> A related simplification removes an extra conditional branch from
>> the SGL set-up loop in frwr_map(): Instead of using either
>> sg_set_page() or sg_set_buf(), initialize the mr_page field properly
>> when rpcrdma_convert_kvec() converts the kvec to an SGL entry.
>> frwr_map() can then invoke sg_set_page() unconditionally.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/frwr_ops.c  |   10 ++--------
>>  net/sunrpc/xprtrdma/rpc_rdma.c  |   21 +++++----------------
>>  net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
>>  3 files changed, 8 insertions(+), 25 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_o=
ps.c
>> index baca49fe83af..5eb044a5f0be 100644
>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>> @@ -306,14 +306,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt=
 *r_xprt,
>>  	if (nsegs > ep->re_max_fr_depth)
>>  		nsegs =3D ep->re_max_fr_depth;
>>  	for (i =3D 0; i < nsegs;) {
>> -		if (seg->mr_page)
>> -			sg_set_page(&mr->mr_sg[i],
>> -				    seg->mr_page,
>> -				    seg->mr_len,
>> -				    offset_in_page(seg->mr_offset));
>> -		else
>> -			sg_set_buf(&mr->mr_sg[i], seg->mr_offset,
>> -				   seg->mr_len);
>> +		sg_set_page(&mr->mr_sg[i], seg->mr_page,
>> +			    seg->mr_len, offset_in_page(seg->mr_offset));
>>    		++seg;
>>  		++i;
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rd=
ma.c
>> index 8f5d0cb68360..529adb6ad4db 100644
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
>> -		seg->mr_page =3D NULL;
>> -		seg->mr_offset =3D base;
>> -		seg->mr_len =3D min_t(u32, PAGE_SIZE - page_offset, remaining);
>> -		remaining -=3D seg->mr_len;
>> -		base +=3D seg->mr_len;
>> +	if (vec->iov_len) {
>> +		seg->mr_page =3D virt_to_page(vec->iov_base);
>> +		seg->mr_offset =3D vec->iov_base;
>> +		seg->mr_len =3D vec->iov_len;
>>  		++seg;
>>  		++(*n);
>> -		page_offset =3D 0;
>>  	}
>>  	return seg;
>>  }
>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_=
rdma.h
>> index 94b28657aeeb..4a9fe6592795 100644
>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>> @@ -285,7 +285,7 @@ enum {
>>    struct rpcrdma_mr_seg {		/* chunk descriptors */
>>  	u32		mr_len;		/* length of chunk or segment */
>> -	struct page	*mr_page;	/* owning page, if any */
>> +	struct page	*mr_page;	/* underlying struct page */
>>  	char		*mr_offset;	/* kva if no page, else offset */
>=20
> Is this comment ("kva if no page") actually correct? The hunk just
> above is an example of a case where mr_page is set, yet mr_offset
> is an iov_base. Is iov_base not a kva?

Ah, well the "if no page" part is now obsolete.

I suppose it should be set to "offset_in_page(vec->iov_base)" ?


--
Chuck Lever



