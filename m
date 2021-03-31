Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A21350768
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhCaTdp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:33:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhCaTdN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:33:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VJT773097374;
        Wed, 31 Mar 2021 19:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VRMO8LrSKcF2PmvaWZ77243N3OVnOxOp2C4MZviczJM=;
 b=zy4LdFP6ds6p3gXy1zMgIwyZ7f/kljYtL40oUzTQkXz68WTfeSj09HRa8XCM6ypRamPx
 YIxK6K/30yEPuG5//GjyFZ0cBt6QxvBhkU0YxeyhvyGNa8hARryCHrsDpmm+atNzwu0l
 GnK4u/4TNNryeogbwrwXlVLVzpe3qyGMBEeKr+SzpiFJSwAHpG02cfnmf3YxDcTpgs7W
 DoheSLN5i0PUx4ou/S2cRd3iWpqZuEfFroy9OCUu5J65MV4Tu0Wk/gaE5Sp4KnJoFu+Z
 HfG85K31f6Wk2vt0IY0xn8FP2uWPV9jpR86o+XQIq9ep0VTzsYBPEtK2LRgtbjevS0GH kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37mad9ue3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 19:33:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VJPecK043808;
        Wed, 31 Mar 2021 19:33:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 37mabpt741-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 19:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW/oP29LssPUv85yeAvQU+xqdQgCj2ksfmzX1xzBoasts+su+7rWiq53KfEGDZoPqJcyYyoKxJs/huLzSyGtuAMBKZihFMgCUMJ17dR+7bG7jtviyR6wt+IMgLg441thOPF+9IR/UjgV6pOWjiD1rLNpgEer9BAGUsu6goVsdur9LfJtx/iJhqehMaGq2OFz31iR/nylYBJJC7d3K46A1lIH9QjdamASMENDxJANgAX4MLMp3VKEZYHW5vrjL3eEEv2JZ0WJ6hahgL14sGkbBRmWwbXoPukby6D7S+1H5AofM+cRFPhNJquyv0/mbujL7s1zjOChh+pTWQ7zrC6RCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRMO8LrSKcF2PmvaWZ77243N3OVnOxOp2C4MZviczJM=;
 b=Cr9yo1x4g//b11uhudnOuLtHb/cDwIRxpU71I4RJ2h8Q4ie+PEr2VPuzbkcd3ToyMJS2rDxhAS5MZCcqABFglYO6xjGDHYcNEVa6/xZd7/Q++glmvtAKzg95X318P+HQmq2bi31tvzxGvOVLPPDzNh6aDUfoumwNHfYRovhUz+8jwClYH/XRL5uKUiyQ+UMBS6xY94oKoi6I8Cu9kY+1vY6A9mKAI6RfRLPcEbEO2UoSd6oQ5gpj3AcD87O9sTrhFXpz60GLTo9tcodsvRDB9drARLxpGAePSqcrZzOkUepp55wZ5sjyFNC+V3Cykda8epdlSRe1Yo/8iiGxX6O0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRMO8LrSKcF2PmvaWZ77243N3OVnOxOp2C4MZviczJM=;
 b=ld0ugmVwBjZts9lglWbxkQLLvsi7kLDdW05GN86zEUaZUVfKaJSjSj25KSxsNURgdcvFK2ew6w484UAv5pwRz27DVOg9XF2XaCXLVC1Y1q7f7qyTa8bA43s0E3dFHKh8lbAPxn8NykhM1QyHondC6Rx0ImLmqH9CKXw93i5819E=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 19:33:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 19:33:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 3/6] svcrdma: Single-stage RDMA Read
Thread-Topic: [PATCH v1 3/6] svcrdma: Single-stage RDMA Read
Thread-Index: AQHXJKmHzjiViIH7306nqxckv08YqKqeb8AAgAAQRIA=
Date:   Wed, 31 Mar 2021 19:33:06 +0000
Message-ID: <B6AA803B-C72D-403D-A9F1-ECD887AF1D8D@oracle.com>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
 <161702880518.5937.11588469087361545361.stgit@klimt.1015granger.net>
 <42ab6f1b-8809-b20b-4a7c-aad9cfa7145e@talpey.com>
In-Reply-To: <42ab6f1b-8809-b20b-4a7c-aad9cfa7145e@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a122a82-22f1-4af2-6d31-08d8f47bcef6
x-ms-traffictypediagnostic: BY5PR10MB4147:
x-microsoft-antispam-prvs: <BY5PR10MB4147E56A86BA9E618543B4BA937C9@BY5PR10MB4147.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+b8Unl9MrVUSTE4Feh68lmX26+8DGleEUbX7d8FzpkR+G7Q9klzooVQJ72d7H6/wAuzM4sFGN2NZsv5EDmnOMF4c5oFgJJSpoPdlj++AXxu5WJ1gShVemiJ77drVrqyrJGyus7dDFVyf3j8Mb/4Gp0bdX5eEGzkxjPUrN18rfP6p9xVGq8Ce6REXips/6M7xpELA/8In/I7O5YxXP5jahr8WTM+Fv14BLplw8NOx6kNQKL3PmJovWUpIVfEshiYG//8emWTWivmcOU/cO/eYv/L++TdrSKKXbKvJzCREu8wXCjDiV+22c9GV3cW6oWdsxBmNnIDetRKW0N4u/Lfc56rQvqDfA6bUe3oiRLiwViMflpEQloniK6n6HATpwFCJiL6S7jxB+L52Ls3OkfJVWVtm/Fi8CoQ1tOtfS7B9UdF6rNsdOzcfV+9TtFsi851TbWy9jbpxIA5JcJuBraUCJMRv0cxUIVG3dO0j8DRX8DMjbLGH+7XsuQWKSQTQUIOelIha9oWpYiYeb0h5hAMDOOJuGa2/wPnVeTWPifkizTemuji5shDhpInOsIE7l7vqgvnu3ov7c862rphwSgJboDoe/FCyZx+zwWWYOJCqk+PeVqh3wL9mPJfbMj2fWkInSIcdVsT08zfs0UhckIKzx/+J8BLkLbx/Ri/U0ALhngrg5aECIp2Gsff+Cc/x3a62E/71dZfc0zPgmV7GGW0ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(33656002)(38100700001)(5660300002)(66446008)(86362001)(2906002)(8676002)(478600001)(6486002)(26005)(4326008)(6916009)(6506007)(53546011)(30864003)(71200400001)(316002)(91956017)(186003)(2616005)(66476007)(76116006)(6512007)(83380400001)(66946007)(66556008)(54906003)(64756008)(36756003)(8936002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3LJZdk9viFNdg3m0D4SRr/2ej5Si/nd+COAtSKMJ4iOCDG7dw+llVPB39wXG?=
 =?us-ascii?Q?PEamenSfaygdFSejV1KyHw40NqH3uIrcdCDvUGfBznEeA+aQ5PK59YJGRUrF?=
 =?us-ascii?Q?uB549/SA3k/oowyLIaNqbDXyRyrfxMspqWafUZTq/+967AP0lV7BZbpIQ13A?=
 =?us-ascii?Q?wsY87MmISyhVmAovaQir1GqTJt4oyqZaPp1UEUshPOSeLjr1I7Q1ZE1JaVnd?=
 =?us-ascii?Q?56xr6fklVvDf336PTHeoHLKwPTtKvQHLBozqfBoB2mRjATEHO1gBHivqPsnB?=
 =?us-ascii?Q?1nPuzmWVc49yan7TbOy/E4aIVoaGGrSZxIYgHzO2zqN+IoXn/fq33PgKFX0s?=
 =?us-ascii?Q?IQtdnTJBRNTcfQ7lox9Gi2uiAzxGlXG3KR9iVfbvf5kdkjn4V/yo/tfCXluX?=
 =?us-ascii?Q?MGjK0RAk4ZqjxnQBa6KMfIFV5OG19AOJn4EmoMCaX8PBBG4I3gbXRmW8Cixh?=
 =?us-ascii?Q?49ZifccCdpQYrOFySYXzF8b31fufK1vLnEC7R0djIC/6jSfOObjhKTjnmHE4?=
 =?us-ascii?Q?DK9FaXb+wT+YP+4IXLAggydS59z2drK4IpdI8qgSwxHWbixhJ0L2HCLUVol9?=
 =?us-ascii?Q?OXDk9MJtx8SxqbqEmWoj4DnRkCZUz2vcGI58K7+o2m90W2K2gtrer8O+cHNw?=
 =?us-ascii?Q?TfG+/Xokwnf7UDLR4X9/17JJjvI7oPJAX04fohfy2kWZ6FDnW/4e2kczAosi?=
 =?us-ascii?Q?R12PJkS/vsjpxsY9vkbyIT2NVnsp5mOJPoUA/ANmKGvmzBE3zvOh6aqvYKNs?=
 =?us-ascii?Q?QF1X/JDA4NDhx9E4nyDXJyh0ukvW3n4EHyJWTXpaC83Irgxw8eHwMFT/Y8x0?=
 =?us-ascii?Q?i7Cc3En4sCmeJ+IpWVcTn+FfVkgAqk1TvNpcfrOBERk3fvH5PXdOm6mOEKoO?=
 =?us-ascii?Q?Fh8NXywDFntqeMhZU6n53VrytSDnJU4vKGy33Q4qcMH7VrTb6Ks5oxbifQZq?=
 =?us-ascii?Q?u/KWXKoK0x4PIL6194UvRuZ3u9PBZIllbM2bdwCaebNJnK0Q8eRQpKJKFvU9?=
 =?us-ascii?Q?eOm4eKDxdZrd4zsL9CawHPfz6pS+rles/sLJ3iaf6pNo5YY2ALElJ5FiFUf9?=
 =?us-ascii?Q?NEoNIk3NYjOkPVZ+r1lJlaHY20k1o1gmmcLXmmbG4jW/8wSAJoOwu28t01al?=
 =?us-ascii?Q?4TwAAjb4dpGBvdhj8ezz/U3k14aAXeOHy+B5sZJXA8NvaWv8UX7BGctziCg4?=
 =?us-ascii?Q?V0MqI6RxyIIEhXjwgOnbJSHqsQ2eOs62MKOZFdiCZS5v8/5IFReSTYCcEEYx?=
 =?us-ascii?Q?Yct7HIx0IzJfW5MOCiJDDhSKwHFY7TJvHjncSvFFcghytD2rv9pzPm41WuUx?=
 =?us-ascii?Q?Eqv2d/XibxMFqSBwg/HIUY9H?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B1009B80B7B8843BF9B49945E2A1EBC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a122a82-22f1-4af2-6d31-08d8f47bcef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 19:33:06.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdrouLd3gJblPfLKVgEYrwY1rLjyu0FdpzWUNYLD4FIBgTr6HsDCHTkUFhbQHpkRFPpURPJ0VyK9C8jIDYB8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310133
X-Proofpoint-ORIG-GUID: IaiIKlA7_rJNVGEbGMt_6ez-q49Tdbl6
X-Proofpoint-GUID: IaiIKlA7_rJNVGEbGMt_6ez-q49Tdbl6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310133
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2021, at 2:34 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 3/29/2021 10:40 AM, Chuck Lever wrote:
>> Currently the generic RPC server layer calls svc_rdma_recvfrom()
>> twice to retrieve an RPC message that uses Read chunks. I'm not
>> exactly sure why this design was chosen originally.
>=20
> I'm not either, but remember the design was written over a decade
> ago. I vaguely recall there was some bounce buffering for strange
> memreg corner cases. The RDMA stack has improved greatly.
>=20
>> Instead, let's wait for the Read chunk completion inline in the
>> first call to svc_rdma_recvfrom().
>> The goal is to eliminate some page allocator churn.
>> rdma_read_complete() replaces pages in the second svc_rqst by
>> calling put_page() repeatedly while the upper layer waits for
>> the request to be constructed, which adds unnecessary round-
>> trip latency.
>=20
> Local API round-trip, right? Same wire traffic either way. In fact,
> I don't see any Verbs changes too.

The rdma_read_complete() latency is incurred during the second call
to svc_rdma_recvfrom().

That holds up the construction of each message with a Read chunk,
since memory free operations need to complete first before the
second svc_rdma_recvfrom() call can return.

It also holds up the next message in the queue because XPT_BUSY
is held while the Read chunk and memory allocation is being
dealt with.

Therefore it lengthens the NFS WRITE round-trip latency by
inserting memory allocation operations (put_page()) in a hot path.


> Some comments/question below.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   10 +--
>>  net/sunrpc/xprtrdma/svc_rdma_rw.c       |   96 +++++++++++-------------=
-------
>>  2 files changed, 39 insertions(+), 67 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrd=
ma/svc_rdma_recvfrom.c
>> index 9cb5a09c4a01..b857a6805e95 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -853,6 +853,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>>  	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
>>  	percpu_counter_inc(&svcrdma_stat_recv);
>>  +	/* Start receiving the next incoming message */
>=20
> This comment confused me. This call just unblocks the xprt to move
> to the next message, it does not necessarily "start". So IIUC, it
> might be clearer to state "transport processing complete" or similar.

How about "/* Unblock the transport for the next receive */" ?


>> +	svc_xprt_received(xprt);
>> +
>>  	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
>>  				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
>>  				   DMA_FROM_DEVICE);
>> @@ -884,33 +887,28 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>>  	rqstp->rq_xprt_ctxt =3D ctxt;
>>  	rqstp->rq_prot =3D IPPROTO_MAX;
>>  	svc_xprt_copy_addrs(rqstp, xprt);
>> -	svc_xprt_received(xprt);
>>  	return rqstp->rq_arg.len;
>>    out_readlist:
>>  	ret =3D svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
>>  	if (ret < 0)
>>  		goto out_readfail;
>> -	svc_xprt_received(xprt);
>> -	return 0;
>> +	goto complete;
>>    out_err:
>>  	svc_rdma_send_error(rdma_xprt, ctxt, ret);
>>  	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>> -	svc_xprt_received(xprt);
>>  	return 0;
>>    out_readfail:
>>  	if (ret =3D=3D -EINVAL)
>>  		svc_rdma_send_error(rdma_xprt, ctxt, ret);
>>  	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>> -	svc_xprt_received(xprt);
>>  	return ret;
>>    out_backchannel:
>>  	svc_rdma_handle_bc_reply(rqstp, ctxt);
>>  out_drop:
>>  	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
>> -	svc_xprt_received(xprt);
>>  	return 0;
>>  }
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc=
_rdma_rw.c
>> index d7054e3a8e33..9163ab690288 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> @@ -150,6 +150,8 @@ struct svc_rdma_chunk_ctxt {
>>  	struct svcxprt_rdma	*cc_rdma;
>>  	struct list_head	cc_rwctxts;
>>  	int			cc_sqecount;
>> +	enum ib_wc_status	cc_status;
>> +	struct completion	cc_done;
>>  };
>>    static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
>> @@ -299,29 +301,15 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq=
, struct ib_wc *wc)
>>  	struct svc_rdma_chunk_ctxt *cc =3D
>>  			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
>>  	struct svcxprt_rdma *rdma =3D cc->cc_rdma;
>> -	struct svc_rdma_read_info *info =3D
>> -			container_of(cc, struct svc_rdma_read_info, ri_cc);
>>    	trace_svcrdma_wc_read(wc, &cc->cc_cid);
>>    	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
>>  	wake_up(&rdma->sc_send_wait);
>>  -	if (unlikely(wc->status !=3D IB_WC_SUCCESS)) {
>> -		set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
>> -		svc_rdma_recv_ctxt_put(rdma, info->ri_readctxt);
>> -	} else {
>> -		spin_lock(&rdma->sc_rq_dto_lock);
>> -		list_add_tail(&info->ri_readctxt->rc_list,
>> -			      &rdma->sc_read_complete_q);
>> -		/* Note the unlock pairs with the smp_rmb in svc_xprt_ready: */
>> -		set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
>> -		spin_unlock(&rdma->sc_rq_dto_lock);
>> -
>> -		svc_xprt_enqueue(&rdma->sc_xprt);
>> -	}
>> -
>> -	svc_rdma_read_info_free(info);
>> +	cc->cc_status =3D wc->status;
>> +	complete(&cc->cc_done);
>> +	return;
>>  }
>>    /* This function sleeps when the transport's Send Queue is congested.
>> @@ -676,8 +664,8 @@ static int svc_rdma_build_read_segment(struct svc_rd=
ma_read_info *info,
>>  	struct svc_rdma_recv_ctxt *head =3D info->ri_readctxt;
>>  	struct svc_rdma_chunk_ctxt *cc =3D &info->ri_cc;
>>  	struct svc_rqst *rqstp =3D info->ri_rqst;
>> -	struct svc_rdma_rw_ctxt *ctxt;
>>  	unsigned int sge_no, seg_len, len;
>> +	struct svc_rdma_rw_ctxt *ctxt;
>>  	struct scatterlist *sg;
>>  	int ret;
>>  @@ -693,8 +681,8 @@ static int svc_rdma_build_read_segment(struct svc_r=
dma_read_info *info,
>>  		seg_len =3D min_t(unsigned int, len,
>>  				PAGE_SIZE - info->ri_pageoff);
>>  -		head->rc_arg.pages[info->ri_pageno] =3D
>> -			rqstp->rq_pages[info->ri_pageno];
>> +		/* XXX: ri_pageno and rc_page_count might be exactly the same */
>> +
>=20
> What is this comment conveying? It looks like a note-to-self that
> resulted in deleting the prior line.

Yeah, pretty much. I think it is a reminder that one of those
fields is superfluous and can be removed.


> If the "XXX" notation is
> still significant, it needs more detail on what needs to be
> fixed in future.

Or it should be removed before this patch is merged.


>>  		if (!info->ri_pageoff)
>>  			head->rc_page_count++;
>>  @@ -788,12 +776,10 @@ static int svc_rdma_copy_inline_range(struct svc_=
rdma_read_info *info,
>>  		page_len =3D min_t(unsigned int, remaining,
>>  				 PAGE_SIZE - info->ri_pageoff);
>>  -		head->rc_arg.pages[info->ri_pageno] =3D
>> -			rqstp->rq_pages[info->ri_pageno];
>>  		if (!info->ri_pageoff)
>>  			head->rc_page_count++;
>>  -		dst =3D page_address(head->rc_arg.pages[info->ri_pageno]);
>> +		dst =3D page_address(rqstp->rq_pages[info->ri_pageno]);
>>  		memcpy(dst + info->ri_pageno, src + offset, page_len);
>>    		info->ri_totalbytes +=3D page_len;
>> @@ -813,7 +799,7 @@ static int svc_rdma_copy_inline_range(struct svc_rdm=
a_read_info *info,
>>   * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data it=
em Read chunks
>>   * @info: context for RDMA Reads
>>   *
>> - * The chunk data lands in head->rc_arg as a series of contiguous pages=
,
>> + * The chunk data lands in rqstp->rq_arg as a series of contiguous page=
s,
>>   * like an incoming TCP call.
>>   *
>>   * Return values:
>> @@ -827,8 +813,8 @@ static noinline int svc_rdma_read_multiple_chunks(st=
ruct svc_rdma_read_info *inf
>>  {
>>  	struct svc_rdma_recv_ctxt *head =3D info->ri_readctxt;
>>  	const struct svc_rdma_pcl *pcl =3D &head->rc_read_pcl;
>> +	struct xdr_buf *buf =3D &info->ri_rqst->rq_arg;
>>  	struct svc_rdma_chunk *chunk, *next;
>> -	struct xdr_buf *buf =3D &head->rc_arg;
>>  	unsigned int start, length;
>>  	int ret;
>>  @@ -864,9 +850,9 @@ static noinline int svc_rdma_read_multiple_chunks(s=
truct svc_rdma_read_info *inf
>>  	buf->len +=3D info->ri_totalbytes;
>>  	buf->buflen +=3D info->ri_totalbytes;
>>  -	head->rc_hdr_count =3D 1;
>> -	buf->head[0].iov_base =3D page_address(head->rc_pages[0]);
>> +	buf->head[0].iov_base =3D page_address(info->ri_rqst->rq_pages[0]);
>>  	buf->head[0].iov_len =3D min_t(size_t, PAGE_SIZE, info->ri_totalbytes)=
;
>> +	buf->pages =3D &info->ri_rqst->rq_pages[1];
>>  	buf->page_len =3D info->ri_totalbytes - buf->head[0].iov_len;
>>  	return 0;
>>  }
>> @@ -875,9 +861,9 @@ static noinline int svc_rdma_read_multiple_chunks(st=
ruct svc_rdma_read_info *inf
>>   * svc_rdma_read_data_item - Construct RDMA Reads to pull data item Rea=
d chunks
>>   * @info: context for RDMA Reads
>>   *
>> - * The chunk data lands in the page list of head->rc_arg.pages.
>> + * The chunk data lands in the page list of rqstp->rq_arg.pages.
>>   *
>> - * Currently NFSD does not look at the head->rc_arg.tail[0] iovec.
>> + * Currently NFSD does not look at the rqstp->rq_arg.tail[0] kvec.
>>   * Therefore, XDR round-up of the Read chunk and trailing
>>   * inline content must both be added at the end of the pagelist.
>>   *
>> @@ -891,7 +877,7 @@ static noinline int svc_rdma_read_multiple_chunks(st=
ruct svc_rdma_read_info *inf
>>  static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
>>  {
>>  	struct svc_rdma_recv_ctxt *head =3D info->ri_readctxt;
>> -	struct xdr_buf *buf =3D &head->rc_arg;
>> +	struct xdr_buf *buf =3D &info->ri_rqst->rq_arg;
>>  	struct svc_rdma_chunk *chunk;
>>  	unsigned int length;
>>  	int ret;
>> @@ -901,8 +887,6 @@ static int svc_rdma_read_data_item(struct svc_rdma_r=
ead_info *info)
>>  	if (ret < 0)
>>  		goto out;
>>  -	head->rc_hdr_count =3D 0;
>> -
>>  	/* Split the Receive buffer between the head and tail
>>  	 * buffers at Read chunk's position. XDR roundup of the
>>  	 * chunk is not included in either the pagelist or in
>> @@ -921,7 +905,8 @@ static int svc_rdma_read_data_item(struct svc_rdma_r=
ead_info *info)
>>  	 * Currently these chunks always start at page offset 0,
>>  	 * thus the rounded-up length never crosses a page boundary.
>>  	 */
>> -	length =3D XDR_QUADLEN(info->ri_totalbytes) << 2;
>> +	buf->pages =3D &info->ri_rqst->rq_pages[0];
>> +	length =3D xdr_align_size(chunk->ch_length);
>>  	buf->page_len =3D length;
>>  	buf->len +=3D length;
>>  	buf->buflen +=3D length;
>> @@ -1033,8 +1018,7 @@ static int svc_rdma_read_call_chunk(struct svc_rdm=
a_read_info *info)
>>   * @info: context for RDMA Reads
>>   *
>>   * The start of the data lands in the first page just after the
>> - * Transport header, and the rest lands in the page list of
>> - * head->rc_arg.pages.
>> + * Transport header, and the rest lands in rqstp->rq_arg.pages.
>>   *
>>   * Assumptions:
>>   *	- A PZRC is never sent in an RDMA_MSG message, though it's
>> @@ -1049,8 +1033,7 @@ static int svc_rdma_read_call_chunk(struct svc_rdm=
a_read_info *info)
>>   */
>>  static noinline int svc_rdma_read_special(struct svc_rdma_read_info *in=
fo)
>>  {
>> -	struct svc_rdma_recv_ctxt *head =3D info->ri_readctxt;
>> -	struct xdr_buf *buf =3D &head->rc_arg;
>> +	struct xdr_buf *buf =3D &info->ri_rqst->rq_arg;
>>  	int ret;
>>    	ret =3D svc_rdma_read_call_chunk(info);
>> @@ -1060,35 +1043,15 @@ static noinline int svc_rdma_read_special(struct=
 svc_rdma_read_info *info)
>>  	buf->len +=3D info->ri_totalbytes;
>>  	buf->buflen +=3D info->ri_totalbytes;
>>  -	head->rc_hdr_count =3D 1;
>> -	buf->head[0].iov_base =3D page_address(head->rc_pages[0]);
>> +	buf->head[0].iov_base =3D page_address(info->ri_rqst->rq_pages[0]);
>>  	buf->head[0].iov_len =3D min_t(size_t, PAGE_SIZE, info->ri_totalbytes)=
;
>> +	buf->pages =3D &info->ri_rqst->rq_pages[1];
>>  	buf->page_len =3D info->ri_totalbytes - buf->head[0].iov_len;
>>    out:
>>  	return ret;
>>  }
>>  -/* Pages under I/O have been copied to head->rc_pages. Ensure they
>> - * are not released by svc_xprt_release() until the I/O is complete.
>> - *
>> - * This has to be done after all Read WRs are constructed to properly
>> - * handle a page that is part of I/O on behalf of two different RDMA
>> - * segments.
>> - *
>> - * Do this only if I/O has been posted. Otherwise, we do indeed want
>> - * svc_xprt_release() to clean things up properly.
>> - */
>> -static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
>> -				   const unsigned int start,
>> -				   const unsigned int num_pages)
>> -{
>> -	unsigned int i;
>> -
>> -	for (i =3D start; i < num_pages + start; i++)
>> -		rqstp->rq_pages[i] =3D NULL;
>> -}
>> -
>>  /**
>>   * svc_rdma_process_read_list - Pull list of Read chunks from the clien=
t
>>   * @rdma: controlling RDMA transport
>> @@ -1153,11 +1116,22 @@ int svc_rdma_process_read_list(struct svcxprt_rd=
ma *rdma,
>>  		goto out_err;
>>    	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
>> +	init_completion(&cc->cc_done);
>>  	ret =3D svc_rdma_post_chunk_ctxt(cc);
>>  	if (ret < 0)
>>  		goto out_err;
>> -	svc_rdma_save_io_pages(rqstp, 0, head->rc_page_count);
>> -	return 1;
>> +
>> +	ret =3D 1;
>> +	wait_for_completion(&cc->cc_done);
>> +	if (cc->cc_status !=3D IB_WC_SUCCESS)
>> +		ret =3D -EIO;
>> +
>> +	/* rq_respages starts after the last arg page */
>> +	rqstp->rq_respages =3D &rqstp->rq_pages[head->rc_page_count];
>> +	rqstp->rq_next_page =3D rqstp->rq_respages + 1;
>> +
>> +	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
>> +	head->rc_page_count =3D 0;
>>    out_err:
>>  	svc_rdma_read_info_free(info);

--
Chuck Lever



