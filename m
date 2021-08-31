Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060093FCD84
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhHaTJV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:09:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3626 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238332AbhHaTJU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 15:09:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiL2D015208;
        Tue, 31 Aug 2021 19:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D+VI3IiUKIB3ggLLuhQXru8EGZlUGqi5jtXJF+nv9v4=;
 b=UpBqtDa/MYXhlqUJn2da01T2CgpQsDDMwVwmzUy46aeAItwBSTPZ8hj/elX9irtQs7x3
 J5IZoBt3AkAF5HChazcCs+SeAheQmuSAD+9lGJ76SZkyD/PgziVU1Zx0/U0GYNoyVLVm
 K1cff7iWuLbpCiG5OeLHKjrpdU+ztydBwrmYRyaTFXVZfOtKz3e7UQG4BoaHhnta2pKH
 I+PhFvZftLeMG+ZJFkj+GGDRPCeVR8CzL9T7Jv8oQjGVYSLRm7zf5sH4GxpDfdmK5vqg
 2LDrhSXmecCOXTK7l2JslP3CVgW5cs/YMNOPgIIU/DtVS1WJgIKhIYJQGowoz2fZBgum Ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=D+VI3IiUKIB3ggLLuhQXru8EGZlUGqi5jtXJF+nv9v4=;
 b=PbVhPc9bQQ0pq0Et28Di5FonpJSvibXuEjk8G6BsY6T5beQJaAaF5I1jZuSDCR3mO4iN
 EqBXDHHtNIUAnu9uA75Ty2DrJgkPGj63omSoqOKZIrbVynjlcpWHJ5vvGVEt4P9isa0k
 RtHfZFfTSamXZP8WidPcOjOlSeyaOKlXZX58cskMXWowVnKnt69KP0dRp2IhSAslmfjQ
 Rpw0j9uLCK2jTrnxd+wwrH72QM6dsRHH6Dul2i8aD7xc9gpX/LRszwiD0H1fhK5tqSmz
 zROnbqLA2pSyk+fGFhZ2KRin7NNlxSAYRFMOOxxSOdxa5JLLR0kv19wIjoLuHyHjA53Y 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aseedj5dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 19:08:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VJ5f2a179279;
        Tue, 31 Aug 2021 19:08:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3aqcy59e8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 19:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi8lLwe0owo1TnpSKZ3zCdmXEk1iIn5NxWT5qbhFXWJ+1gZk2pBIvQHRu9ywTc3KzwM/C0WJGcH/fXcDPprGqZcf13KHkFpNLjKtGqmgzdHpi1mXom9gkAHxhS5LRQIxH9Jpxxy1nJYv7qdjeXauBbS1X9AJEVj8mpNoWb61gOD03zNtAOqfB+zztNswAdEbgpjQA0IZ0zzg2Ucb8ahD95d9xin3vTC7evynHT7eJYpjMEOTzConoZ6arAhJbOeM7jRC81EjI3QLh2xsioCHjkqCImNPWzJw82Qpmln5QCnfNfMNkQyZ/HospITNG9F2Akk4YC+BtcBBqaAvt9SUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+VI3IiUKIB3ggLLuhQXru8EGZlUGqi5jtXJF+nv9v4=;
 b=TIEJT4FC4ktlbkbJNbIyRmqeQuDU5dNnX3eGHx4huCGiikUkTa8JqvP59jgK2y+1DlsmqrnU4uX+GDSSyyJDC4PCBW/dVRvIGtLR8mvPzIx+P9vaz0CfU7YBjebE82J9f/VXlk0NAhOyAO3h0ITA91hVXsAC1FWWvFC69IHb1MtaOzsJ3SxsdqqeYK61dnaw9vSO/4SsH47iAigi7wrUhfcEGx4+OFybk0G+ywssp5Xy7gI5h0OnxtqqtUUvROPY1bD6Vqg2vBwuh8Vp+Sh4D6zeeHplu31fs+k5XAkWpgBMklAVbOfj3pufKA6QbsxwfMsqds3bZDMayvMuI5wB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+VI3IiUKIB3ggLLuhQXru8EGZlUGqi5jtXJF+nv9v4=;
 b=vbMy+iGnbdzoPS3VTvHhOqKcBKG42FX1UzymEYZXbnpm1/ZcoAin7xI7Rz+PE+IuiDTYJTs33foKvIN5IomYB0tSdUz3wAuh1XqhFsbo0K7CAphP3EcC2vcXfKTCB3tzijDzft9FAlmlW1QqKt5uAQs2TVfQJhqgcSiuT1yei2c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3827.namprd10.prod.outlook.com (2603:10b6:a03:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 19:08:20 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 19:08:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 6/6] svcrdma: Pull Read chunks in
 ->xpo_argument_payload
Thread-Topic: [PATCH RFC 6/6] svcrdma: Pull Read chunks in
 ->xpo_argument_payload
Thread-Index: AQHXnps4mKcbfooWqUK9WcExu02iWauN+ekA
Date:   Tue, 31 Aug 2021 19:08:20 +0000
Message-ID: <82D6BF0A-3E8B-4A01-9F08-D402CDC0CB3C@oracle.com>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
 <163043674641.1415.15896010002221696600.stgit@klimt.1015granger.net>
In-Reply-To: <163043674641.1415.15896010002221696600.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17b9403-552f-4c95-e2af-08d96cb2b2a5
x-ms-traffictypediagnostic: BY5PR10MB3827:
x-microsoft-antispam-prvs: <BY5PR10MB3827D6BCA7BBABE4C8638DB093CC9@BY5PR10MB3827.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdpJnQOElAC+PYbShkJEUjyYusM1cegaMLMfmjax2OAw6g7RApJKhOgkD8OBHji2HrSD66lJoTZ2ihfE2qs97/jt95+i79PqaMJQjHZfuQ4jVOnzkhSuG3o8GPOpbJxygr4sHZfn5z5IsyRaHVdoEQfYn+M/ZvLr+LmE6Jo9ddS3NJuMBICy4LEBfru6wTTDses7z5u5O4+H5WWb5rJYTQTY+GTBDg6GtZbGIfj6WnQZoFRXEsBqsqsKVOzfyqpd2ZrY2f7baz9PRfykwjk7H46EaE/55YdvmzF5YyWbuOQLnQ5zxGwhxM0f+Bd6WB1Dp6vsq8BJmXioHE98CmkvOfQKlVHSzDTqCtxrUp4Q1fZeACgze3Y92/g39WWRNUg/V6WRj88ku7qfkrV0hdt+dBD2GHFk+nLKngf8ogQYjIoKAxmw6Pj3728AdgUgbfMujWyS7CXKxBIn1H0jO8jdP0At1opaPOu0qT2Fpwix2LIApmI2XuDIjahVpUYlekEEbh986UrZ8GTXPLQkJQ0C5t+KUCuq9/LnhJmLvatBd0ElvvUq1cZtem3tTN2l/UYbpckzdUdydxtfzT+geQdsPDsRBVe8hjN6Tu3oMCo2OLZt4rrOv11q6agRzS2xm+uOCZ/+aQSBM//9nQXZTvVu2KM0NZcz81eBIbdMUc2sw1Jw6hTLGDQYZXZOnd9dHTf8yorA9u6Btx1oQZqX4tXfux+vN/+yy93R85r7aZoET+xbz8W9bvLQEunSb1XEcAzp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(54906003)(33656002)(36756003)(6916009)(38100700002)(26005)(5660300002)(4326008)(83380400001)(316002)(30864003)(71200400001)(122000001)(2906002)(38070700005)(86362001)(6486002)(64756008)(6512007)(8936002)(66946007)(186003)(76116006)(66556008)(91956017)(66476007)(66446008)(53546011)(2616005)(478600001)(8676002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YKM0CH+oykWPHodnD3AeKaBeTb9iwsFyu64FoN2xyl6aev3ea8c5o2nqNs26?=
 =?us-ascii?Q?WYLRbYlPxr7wEQ57PndTgEyqVuInBsoL1vVHlNrg/0xbiDa5Qr/emv8Tu/qm?=
 =?us-ascii?Q?4VjAEyb8kB7RVGeXtd51fdomqkQp2weud8lCnZCBPtiI5AIB+CuszIhxbFBb?=
 =?us-ascii?Q?mbw4Rp0X6aV4cg5HDZnEvbM3opFrWTob1igtvOWVt8qzkonuFa5h+bzeoani?=
 =?us-ascii?Q?f5AAqNQmfCql7JRXII2vEO/4LNlKTF8/Tx/IyK/TC/gXubA5FjNBu/xQskX0?=
 =?us-ascii?Q?yoihC4FGFXOl2sheousxS79wXpEpq5JmPpv6m2esIagT5Kr0+bWcZ80pda8R?=
 =?us-ascii?Q?70xwMMWdhqjBRknJZGwmoiP0QOCAzFIw+oI9AB6xLZdRMnCfhRai7p+QGr01?=
 =?us-ascii?Q?xBjq6K8j3dWdJM0RsMBY/2VwnSsvzdGpCElPcOZ/9PJ0yTnEDDzwhre/ApA9?=
 =?us-ascii?Q?cv5vxyqCY3xDgTNx9VLiks0NCbT8Oi1G0KLpkQ4f9CAiOIwP+HhoLcUT5lO3?=
 =?us-ascii?Q?5e/k3xP0LYT5atDD+RoDDlaeZBCh4IL2cBWc7Pu6sv8NS7HKeXCRqwi/X/gy?=
 =?us-ascii?Q?m3WXD2nIsAYkxA4yVB76hFCeBcxj0YeOww04BKdHMIkJCteZalGaxHiFSwl6?=
 =?us-ascii?Q?SGPveKp4pdluvZGVPCd+9pC88d1i4586LIAvV83YGOVxfQM919pDWd9MqhAh?=
 =?us-ascii?Q?QlpisCGTczJxUNirYVQXFAeaDnVxuy40cfi1wnxNwjeixbll3bnNCA7SoFGR?=
 =?us-ascii?Q?L/0gqKSi9JH7pCUvtwOV24Rq5zRVLj0XqUFvsSdbqNUZNCvrOSv8eNCEcYGm?=
 =?us-ascii?Q?XtIayBfzFmm1n7sTNBM0WW7pMN8Mp7YZqI6SaZfzgA/fKmn4TXi67/YCHA7e?=
 =?us-ascii?Q?0E4rN05ykWshrULij60ckP+6n2nLVbVE9Oui1pQKvpQ34DmnelPY79CpoXvu?=
 =?us-ascii?Q?niVFrMM+UY2U9koosbHOrwW+cq10lpzTzycSF9WIu5ac1jTqJiADHXOumLOI?=
 =?us-ascii?Q?eK67t5pKnKLxKyhWSdNRapVZir9eVk/WlxqTjktSuy3KUzz7Okv1N9e9rVOw?=
 =?us-ascii?Q?LFRNfG8wE9CSXAQ5pVNdkgd6HQreGtQcdeU5zxm+UVFLN5bcMdmuArhkppbN?=
 =?us-ascii?Q?rOpWB77Q+GUgMsQsk52HgJdDP3Zuc63cE/KpDXn0OLKrDty8Is4RcGYPrrx8?=
 =?us-ascii?Q?GzH4uiKs+jZsLjzfwLRqS3O1qzUmsU2MwOp29GqDXImxqqFefXjOP2BIXAaw?=
 =?us-ascii?Q?AsspbDFlpjBqGXnyNBYQWztCm1tIC8wT1leuza2Rdf3n4pSK//N7MLqNFYId?=
 =?us-ascii?Q?X2l8O2/2Mkto5GsDk+KlG5NJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BBDD5BA8EFA984EAC03064CC04B4F02@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17b9403-552f-4c95-e2af-08d96cb2b2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 19:08:20.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYSX+0oRhDfv+/uQN15k8lt3Oa5Xcixa1t4my4HGJo/g3/2n6Rb2TVJg4lGbYPMECnMlzbrFoPCfU+MgjvZ4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3827
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310105
X-Proofpoint-ORIG-GUID: _ml-dKr-8MmMmYjurDyLv1wcHAA87hza
X-Proofpoint-GUID: _ml-dKr-8MmMmYjurDyLv1wcHAA87hza
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 31, 2021, at 3:05 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> This enables the XDR decoder to figure out how the payload sink
> buffer needs to be aligned before setting up the RDMA Reads.
> Then re-alignment of large RDMA Read payloads can be avoided.

Should say "can be avoided" but isn't yet. All of these patches
are pre-requisites to that behavior.


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> include/linux/sunrpc/svc_rdma.h         |    6 +
> include/trace/events/rpcrdma.h          |   26 ++++++
> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   17 +++-
> net/sunrpc/xprtrdma/svc_rdma_rw.c       |  139 ++++++++++++++++++++++++++=
++---
> 4 files changed, 169 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_r=
dma.h
> index f660244cc8ba..8d80a759a909 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -192,6 +192,12 @@ extern int svc_rdma_send_reply_chunk(struct svcxprt_=
rdma *rdma,
> extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
> 				      struct svc_rqst *rqstp,
> 				      struct svc_rdma_recv_ctxt *head);
> +extern void svc_rdma_prepare_read_chunk(struct svc_rqst *rqstp,
> +					struct svc_rdma_recv_ctxt *head);
> +extern int svc_rdma_pull_read_chunk(struct svcxprt_rdma *rdma,
> +				    struct svc_rqst *rqstp,
> +				    struct svc_rdma_recv_ctxt *ctxt,
> +				    unsigned int offset, unsigned int length);
>=20
> /* svc_rdma_sendto.c */
> extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdm=
a.h
> index 5954ce036173..30440cca321a 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -2136,6 +2136,32 @@ TRACE_EVENT(svcrdma_sq_post_err,
> 	)
> );
>=20
> +TRACE_EVENT(svcrdma_arg_payload,
> +	TP_PROTO(
> +		const struct svc_rqst *rqstp,
> +		unsigned int offset,
> +		unsigned int length
> +	),
> +
> +	TP_ARGS(rqstp, offset, length),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, offset)
> +		__field(u32, length)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->xid =3D __be32_to_cpu(rqstp->rq_xid);
> +		__entry->offset =3D offset_in_page(offset);
> +		__entry->length =3D length;
> +	),
> +
> +	TP_printk("xid=3D0x%08x offset=3D%u length=3D%u",
> +		__entry->xid, __entry->offset, __entry->length
> +	)
> +);
> +
> #endif /* _TRACE_RPCRDMA_H */
>=20
> #include <trace/define_trace.h>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdm=
a/svc_rdma_recvfrom.c
> index 08a620b370ae..cd9c0fb1a470 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -838,12 +838,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>=20
> 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
>=20
> -	if (!pcl_is_empty(&ctxt->rc_read_pcl) ||
> -	    !pcl_is_empty(&ctxt->rc_call_pcl)) {
> +	if (!pcl_is_empty(&ctxt->rc_call_pcl) ||
> +	    ctxt->rc_read_pcl.cl_count > 1) {
> 		ret =3D svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
> 		if (ret < 0)
> 			goto out_readfail;
> -	}
> +	} else if (ctxt->rc_read_pcl.cl_count =3D=3D 1)
> +		svc_rdma_prepare_read_chunk(rqstp, ctxt);
>=20
> 	rqstp->rq_xprt_ctxt =3D ctxt;
> 	rqstp->rq_prot =3D IPPROTO_MAX;
> @@ -887,5 +888,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
> int svc_rdma_argument_payload(struct svc_rqst *rqstp, unsigned int offset=
,
> 			      unsigned int length)
> {
> -	return 0;
> +	struct svc_rdma_recv_ctxt *ctxt =3D rqstp->rq_xprt_ctxt;
> +	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> +	struct svcxprt_rdma *rdma =3D
> +		container_of(xprt, struct svcxprt_rdma, sc_xprt);
> +
> +	if (!pcl_is_empty(&ctxt->rc_call_pcl) ||
> +	    ctxt->rc_read_pcl.cl_count !=3D 1)
> +		return 0;
> +	return svc_rdma_pull_read_chunk(rdma, rqstp, ctxt, offset, length);
> }
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_=
rdma_rw.c
> index 29b7d477891c..5f03dfd2fa03 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -707,19 +707,24 @@ static int svc_rdma_build_read_segment(struct svc_r=
dma_read_info *info,
>=20
> 	len =3D segment->rs_length;
> 	sge_no =3D PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
> +
> +	trace_printk("pageoff=3D%u len=3D%u sges=3D%u\n",
> +		info->ri_pageoff, len, sge_no);
> +
> 	ctxt =3D svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
> 	if (!ctxt)
> 		return -ENOMEM;
> 	ctxt->rw_nents =3D sge_no;
> +	head->rc_page_count +=3D sge_no;
>=20
> 	sg =3D ctxt->rw_sg_table.sgl;
> 	for (sge_no =3D 0; sge_no < ctxt->rw_nents; sge_no++) {
> 		seg_len =3D min_t(unsigned int, len,
> 				PAGE_SIZE - info->ri_pageoff);
>=20
> -		if (!info->ri_pageoff)
> -			head->rc_page_count++;
> -
> +		trace_printk("  page=3D%p seg_len=3D%u offset=3D%u\n",
> +			rqstp->rq_pages[info->ri_pageno], seg_len,
> +			info->ri_pageoff);
> 		sg_set_page(sg, rqstp->rq_pages[info->ri_pageno],
> 			    seg_len, info->ri_pageoff);
> 		sg =3D sg_next(sg);
> @@ -804,15 +809,14 @@ static int svc_rdma_copy_inline_range(struct svc_rd=
ma_read_info *info,
> 	unsigned int page_no, numpages;
>=20
> 	numpages =3D PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
> +	head->rc_page_count +=3D numpages;
> +
> 	for (page_no =3D 0; page_no < numpages; page_no++) {
> 		unsigned int page_len;
>=20
> 		page_len =3D min_t(unsigned int, remaining,
> 				 PAGE_SIZE - info->ri_pageoff);
>=20
> -		if (!info->ri_pageoff)
> -			head->rc_page_count++;
> -
> 		dst =3D page_address(rqstp->rq_pages[info->ri_pageno]);
> 		memcpy(dst + info->ri_pageno, src + offset, page_len);
>=20
> @@ -1092,15 +1096,8 @@ static noinline int svc_rdma_read_special(struct s=
vc_rdma_read_info *info)
>  * @rqstp: set of pages to use as Read sink buffers
>  * @head: pages under I/O collect here
>  *
> - * The RPC/RDMA protocol assumes that the upper layer's XDR decoders
> - * pull each Read chunk as they decode an incoming RPC message.
> - *
> - * On Linux, however, the server needs to have a fully-constructed RPC
> - * message in rqstp->rq_arg when there is a positive return code from
> - * ->xpo_recvfrom. So the Read list is safety-checked immediately when
> - * it is received, then here the whole Read list is pulled all at once.
> - * The ingress RPC message is fully reconstructed once all associated
> - * RDMA Reads have completed.
> + * Handle complex Read chunk cases fully before svc_rdma_recvfrom()
> + * returns.
>  *
>  * Return values:
>  *   %1: all needed RDMA Reads were posted successfully,
> @@ -1159,3 +1156,115 @@ int svc_rdma_process_read_list(struct svcxprt_rdm=
a *rdma,
> 	svc_rdma_read_info_free(info);
> 	return ret;
> }
> +
> +/**
> + * svc_rdma_prepare_read_chunk - Prepare rq_arg for Read chunk
> + * @rqstp: set of pages to use as Read sink buffers
> + * @head: pages under I/O collect here
> + *
> + * The Read chunk will be pulled when the upper layer's XDR
> + * decoder calls svc_decode_argument_payload(). In the meantime,
> + * fake up rq_arg.page_len and .len to reflect the size of the
> + * yet-to-be-pulled payload.
> + */
> +void svc_rdma_prepare_read_chunk(struct svc_rqst *rqstp,
> +				 struct svc_rdma_recv_ctxt *head)
> +{
> +	struct svc_rdma_chunk *chunk =3D pcl_first_chunk(&head->rc_read_pcl);
> +	unsigned int length =3D xdr_align_size(chunk->ch_length);
> +	struct xdr_buf *buf =3D &rqstp->rq_arg;
> +
> +	buf->tail[0].iov_base =3D buf->head[0].iov_base + chunk->ch_position;
> +	buf->tail[0].iov_len =3D buf->head[0].iov_len - chunk->ch_position;
> +	buf->head[0].iov_len =3D chunk->ch_position;
> +
> +	buf->page_len =3D length;
> +	buf->len +=3D length;
> +	buf->buflen +=3D length;
> +
> +	/*
> +	 * rq_respages starts after the last arg page. Note that we
> +	 * don't know the offset yet, so add an extra page as slack.
> +	 */
> +	length +=3D PAGE_SIZE * 2 - 1;
> +	rqstp->rq_respages =3D &rqstp->rq_pages[length >> PAGE_SHIFT];
> +	rqstp->rq_next_page =3D rqstp->rq_respages + 1;
> +}
> +
> +/**
> + * svc_rdma_pull_read_chunk - Pull one Read chunk from the client
> + * @rdma: controlling RDMA transport
> + * @rqstp: set of pages to use as Read sink buffers
> + * @head: pages under I/O collect here
> + * @offset: offset of payload in file's page cache
> + * @length: size of payload, in bytes
> + *
> + * Once the upper layer's XDR decoder has decoded the length of
> + * the payload and it's offset, we can be clever about setting up
> + * the RDMA Read sink buffer so that the VFS does not have to
> + * re-align the payload once it is received.
> + *
> + * Caveat: To keep things simple, this is an optimization that is
> + *	   used only when there is a single Read chunk in the Read
> + *	   list.
> + *
> + * Return values:
> + *   %0: all needed RDMA Reads were posted successfully,
> + *   %-EINVAL: client provided the wrong chunk size,
> + *   %-ENOMEM: rdma_rw context pool was exhausted,
> + *   %-ENOTCONN: posting failed (connection is lost),
> + *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
> + */
> +int svc_rdma_pull_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst =
*rqstp,
> +			     struct svc_rdma_recv_ctxt *head,
> +			     unsigned int offset, unsigned int length)
> +{
> +	struct svc_rdma_read_info *info;
> +	struct svc_rdma_chunk_ctxt *cc;
> +	struct svc_rdma_chunk *chunk;
> +	int ret;
> +
> +	trace_svcrdma_arg_payload(rqstp, offset, length);
> +
> +	/* Sanity: the Requester must have provided enough
> +	 * bytes to fill the XDR opaque.
> +	 */
> +	chunk =3D pcl_first_chunk(&head->rc_read_pcl);
> +	if (length > chunk->ch_length)
> +		return -EINVAL;
> +
> +	info =3D svc_rdma_read_info_alloc(rdma);
> +	if (!info)
> +		return -ENOMEM;
> +	cc =3D &info->ri_cc;
> +	info->ri_rqst =3D rqstp;
> +	info->ri_readctxt =3D head;
> +	info->ri_pageno =3D 0;
> +	info->ri_pageoff =3D offset_in_page(offset);
> +	info->ri_totalbytes =3D 0;
> +
> +	ret =3D svc_rdma_build_read_chunk(info, chunk);
> +	if (ret < 0)
> +		goto out_err;
> +	rqstp->rq_arg.pages =3D &info->ri_rqst->rq_pages[0];
> +	rqstp->rq_arg.page_base =3D offset_in_page(offset);
> +	rqstp->rq_arg.buflen +=3D offset_in_page(offset);
> +
> +	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
> +	init_completion(&cc->cc_done);
> +	ret =3D svc_rdma_post_chunk_ctxt(cc);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	ret =3D 0;
> +	wait_for_completion(&cc->cc_done);
> +	if (cc->cc_status !=3D IB_WC_SUCCESS)
> +		ret =3D -EIO;
> +
> +	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
> +	head->rc_page_count =3D 0;
> +
> +out_err:
> +	svc_rdma_read_info_free(info);
> +	return ret;
> +}
>=20
>=20

--
Chuck Lever



