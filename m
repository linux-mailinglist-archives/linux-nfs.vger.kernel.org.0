Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1600D413835
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhIURXN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 13:23:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9936 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhIURXL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Sep 2021 13:23:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LH5GTp004106;
        Tue, 21 Sep 2021 17:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wI0BtQK/3Z2xuEUdxRwxcTVrZc4A2YuwLSE9PcWKHSk=;
 b=OzbwSJoZg1E8ycSODcqvK5LpQ2A36VVMkvzJ9TS39I4ZSFN3R41sMhMTd6Rq7REcyDFm
 U5xbxv9RStfj1k5+nvXhxpr5woXIVlPoZn33I/AF84SMCYU52hVajmgnhm9Psr54W4LL
 kMmaDfPNYAY/D0vLwdK7v7gcAKksR9uV6zI0Fb+odHWA8qIsQOB8xsMnTpDz3gn8nBHK
 4a6obN0/65tCnGHz4bEERAIEubQyJEz5pNwm8FMSiJOE3erKuz8cpDUlgkdinLRcvbtv
 Ils+MrhkSXoaR0BUaZ6FEgPNpVbONSFjVRYTSfpGmN60HzJ3uLD+zYGJlU39Z+EHSGlx rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b757vux3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 17:21:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LHLZZZ174382;
        Tue, 21 Sep 2021 17:21:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3b557xc65f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 17:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krU1+WhuuvKQem9oVQGxYuAxyiPDJqZWWoocWEm0WWlZSzt/K0wmsOv8xfM3PoDczx3HiUwNaTfoaX2rM+LWUT3/Amwth6XhOKgDVbxOfQMQy/vWpQUDIpAcMBYqsdKwZfbhSzSPZpD3LErurT5s3VR8ug71uLCaLTfTJjAO46mNJ22re+h3ZMJp4cdHb8FZz/aLrQlnDpzNYx4mcPgVxyOK/UogpZ5ukY6y0oE0piewVm+mJH1dk/Yu+IDKf+U+zT4p8jsOKF8gwpZwf3km9pZggE6Jd3Bq8OAcE1BMXjf3nVDGNBsiU/4FZM4xhfLr617b7gHOUWz0bL6xGgPwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wI0BtQK/3Z2xuEUdxRwxcTVrZc4A2YuwLSE9PcWKHSk=;
 b=a0Pby146WG1A7Db9GeFyYult+cygVOYJ1NNpqf781WziPHDeqU6fC5QMDD1UjcfslAZWTniiOFRMQo4/wDCqMU3/RyGEVZ7CapMV6SWqCXdAlEzQK9rFTl3RGJt0FcA+FGgnj0k5LWUeliQ7WbFrqMfuHHYoyPB113eysd9vKcCVz6CtaNWEaKTFefEQBFjcip+7ic09b1IT5w5WJ/D4gaBf2gPNttfgYaO0JrHVAVgatoaPyMeCt/eiuB2ax6vwHTldnlQpt547Hhc0NJKE1AGQkc4X9HMKZNdFp+VOupHIpffDP/s00dO5kpewDKScLh6Egj+QAb4oxMvnTNeP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI0BtQK/3Z2xuEUdxRwxcTVrZc4A2YuwLSE9PcWKHSk=;
 b=l5gOxJGeXwAAAPZ7ZLjWuGFyHyxgqxQkXdMC/C7cd8HBsuyMD7+mL5v3q0fGSSws4767qqWpSapQN2Neb9nS8apH330RJmWph7BfHc+VvyTNLkk+cdyaB8S9fzj6aL/iKavytxEJQtb/8aJklpFcCfKxlIJjOUUaVI/eC+9EVYs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 17:21:31 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 17:21:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
Thread-Topic: [PATCH v2] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
Thread-Index: AQHXrKoH6xzONa4SrUyyn/8X0ldtpKuuumkAgAAGfgA=
Date:   Tue, 21 Sep 2021 17:21:31 +0000
Message-ID: <BAFA239A-2F60-4163-AB20-046AFE6B6F7D@oracle.com>
References: <163198229142.4159.3151965308454175921.stgit@morisot.1015granger.net>
 <d69234ec-4688-e5d1-17c3-247841d47d16@talpey.com>
In-Reply-To: <d69234ec-4688-e5d1-17c3-247841d47d16@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23e5546e-7f01-4442-4627-08d97d24412a
x-ms-traffictypediagnostic: BY5PR10MB4212:
x-microsoft-antispam-prvs: <BY5PR10MB42121E49C07445AB40B0E9A693A19@BY5PR10MB4212.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUb8tl6MQiYz6THG/zF1m7vWtCNlbkmIRGMeoaJuEhOrrzqyQclDXgu/UV9IboEmYKlZWRP3tp9nCa4K/2C63LE36RvUIfZ6QAf+5Q4RLSHkxtrYxSjn2J+4lvXgXfTLPX5lRofmypRbm/KurAnVSpJSZ+gTqHx2Xi4rZ7dQ6YBGjIJ1eLIUt4VbZH6pcPswg5hkdjRgub8RBtp/TvL89EG3uehaAWg9/6wYLTcHQR840HQjIfAYUYqmWkoKt/kYxR+5XecVGwAcoRmGIK5S4TCV/9W1WYHeAsy3G8UDaUXNEcM7Pn4f5aucHpCfqDEJbAAtOofy4WfnuwDfbZWDevLEf44VIL+hqqBgR9rLsnE3ssotLhAdKAUFXE57AM42tXJzGxvwX2c5piHXdxVzRPyZcFTYGPBryLP7MUVxYYOFt9JQdcuHndsvV//oZ+OZJVitQswoQyzXhzsJ6msYY0L28rwa3nn2+AyyKVJzRuhPE5pQnmT3qByICcufMyY6LWE083pH44hkJoMX24/3GEosrjzNRNz24TvIMf0JoNxWsf6/ID7oNyprt7jjau2GtdVVb6ZOwVuOhJtO36UEIEkSrECCGdW9PrEjJZ92YuUPRXZhMqe7Y8uflQRb+wrCnXrMj72bbsHSrKp7d+rFERHXjAMZbLNDQMqo79mz/NVrMHDAT+HQfH4ZpIAJKXEZm+rwQxrtjXQAm2VjjtL2IcCAG4V/5MbF78WFunvzZa6q+d9NZ/n7IXtex1U/+IR2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(36756003)(4326008)(6916009)(91956017)(26005)(2906002)(8936002)(8676002)(6486002)(33656002)(5660300002)(54906003)(83380400001)(122000001)(316002)(38100700002)(186003)(71200400001)(6506007)(86362001)(66476007)(508600001)(66556008)(76116006)(66946007)(38070700005)(66446008)(53546011)(64756008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pmbbufuki8w+njbvKo3hbQX//33NkdPWYiPhwSqnzkYCF9/OJs90Wb9Oh8e+?=
 =?us-ascii?Q?o92yG8fbytE/odtX6IXOpltbw1K2XLkErrAYm7N0MRMp+bc1p9TexFGFKJ+d?=
 =?us-ascii?Q?ArgJXeKLxwcgvEyH+7yPcJdbg1Q27FPUqys7UUD9GcaKX9Svrt2+sD/aBRTH?=
 =?us-ascii?Q?c+/kUHW6TJYCHgq3u/2DxzPh0uUk76+u6Ylt4jQKTCG14i3GZC+rhG7UTuRc?=
 =?us-ascii?Q?8MxtPeuVp8kG3gp73tBFWBDe7aIjBrAoQLJeEXiTRpLxsQ40sDXnezlCxgUR?=
 =?us-ascii?Q?xNZqnBQhcXUI5jhJ/0TVooYUhtu+KlublO8BxfIyn/ZDKzjSi3CYtH/aJ1ot?=
 =?us-ascii?Q?V15rqGLyrhA4S5kudPL+FYoBxKmNcgQZkQNXI855HNeEhtzgY9b5JrlrLUoZ?=
 =?us-ascii?Q?RPsa5DeRmuTPKegOXbd12XnYDkI8Tss0NvkYtSMatC8Ci4CFIvuDARBUZ9iI?=
 =?us-ascii?Q?ynX7BSSVix7rgUclZdaqP/1Lwpwi8pZ0En1IzRVGT1mYmQX0ZMH6KyTcB9MF?=
 =?us-ascii?Q?xj7bHRWFt9G1KOZh1vC/FfNSaAfZ2xfrRT/ks3uWdBtZv8EsjA+hxFASyjnV?=
 =?us-ascii?Q?pqA8x/ICulx/k+ToTVJWxreOLd/8kY2MvYpTTRIG3axunXRiMrlbMj5TAVv5?=
 =?us-ascii?Q?0lLnTdn0tr1vIat/qVT8H2SM027oym84nD7PKbhMR6Qjl0Ws4Ca+Xq5FwpGo?=
 =?us-ascii?Q?u7tj910KsHhLvgbwPi8hVoahj9eFQFrks7jZ/SirbZtusO4ovVzHscH5tSIT?=
 =?us-ascii?Q?9w0SDubKYQT+Od7aC/srDqhGYviJVjOCLJCvvXM9EkdhnmrvF+f04g23qHRG?=
 =?us-ascii?Q?8HqiBe3Cu6921Ig9sGaaCDyJ1O1JMaVmf4+Z4QoM0QA+hZ2eM04ynZbj6Phb?=
 =?us-ascii?Q?OACqFmWpJNhy/uZkgMvc3G5YqCh+dFfRZG0EX90T+Uu8Wl5l3oKzbddA4e+v?=
 =?us-ascii?Q?elf75ovOaDWdN1diTZchBIRXBqkP/nVodek2GFvPbvDxgqakVdJpOy3F4/P1?=
 =?us-ascii?Q?1g29L95/2sXqtY0cal5bml9V6Z0Pdy8L2TvZJ0Lb0zrYlHWSJHbxWOneKZRP?=
 =?us-ascii?Q?IcTLQ8GtkF/U8hWXGK5Fc0sqDrVbPYUed9JdTU3gSxPXrIF7xe27zijM/fAU?=
 =?us-ascii?Q?3UEBUPqgGns3GQe8+AdkFeruxjUwObyG8v3ii45fVKSzHgWaESpZUVDsFc0/?=
 =?us-ascii?Q?MtSO6eoVAKxUXuWQnUG0iDHUE/J8VkedhYZfnVbh0YqI0qUlpiYECTJSD4Xm?=
 =?us-ascii?Q?HVmE70CH2REJx9q+M+3AD3kkFJXmQIndROBGcDY1pJ4cYZBlGS3Q9fXzC8to?=
 =?us-ascii?Q?KOUCg8QFJ+/wIH3IOCMamDws?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92A81B9CA1B2514B887023FD9E932A20@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e5546e-7f01-4442-4627-08d97d24412a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 17:21:31.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLNhuHCoeaGyZuSEtH5+YWYwCZGbIMod5elT39mhfNa6z96wkO5WSkqj5+Fu+tJ2GtNO58VMh03ZK4NtWX89+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210103
X-Proofpoint-GUID: xacz2XqQRC6xoSSin1VX4ccmTVDZEat3
X-Proofpoint-ORIG-GUID: xacz2XqQRC6xoSSin1VX4ccmTVDZEat3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 21, 2021, at 12:58 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 9/18/2021 12:26 PM, Chuck Lever wrote:
>> This is a buffer to be left persistently registered while a
>> connection is up. Connection tear-down will automatically DMA-unmap,
>> invalidate, and dereg the MR. A persistently registered buffer has
>> no-cost to provide, and it can never be elided into the RDMA segment
>> that backs the data payload.
>=20
> I'm confused by this last sentence. Why is "no-cost" important?

Today, the client turns off this XDR pad when it can because it
is registered and invalidated for every Write chunk with non-
aligned length. That adds a cost to providing it.

No-cost means we don't need to worry about optimizing it away;
it can be provided all the time, if we like, because there's no
additional per-RPC registration/invalidation cost.


> And, "elided" means to omit, so the word "into" is unexpected.

How about "coalesced"?


> Why not just say it's a small preregistered buffer of zero bytes,
> to be used when padding is required for rpc's on this connection?
>=20
> I do have one additional question below.
>=20
> Fix otherwise looks good, you can add my R-B
> Reviewed-By: Tom Talpey <tom@talpey.com>

Thanks for having a look!


>> An RPC that provisions a Write chunk with a non-aligned length now
>> uses this MR rather than the tail buffer of the RPC's rq_rcv_buf.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/trace/events/rpcrdma.h  |   13 ++++++++++---
>>  net/sunrpc/xprtrdma/frwr_ops.c  |   35 ++++++++++++++++++++++++++++++++=
+++
>>  net/sunrpc/xprtrdma/rpc_rdma.c  |   32 +++++++++++++++++++++++---------
>>  net/sunrpc/xprtrdma/verbs.c     |    1 +
>>  net/sunrpc/xprtrdma/xprt_rdma.h |    5 +++++
>>  5 files changed, 74 insertions(+), 12 deletions(-)
>> Changes since v1:
>> - Reverse the sense of the new re_implicit_roundup check
>> - Simplify the hunk in rpcrdma_convert_iovs()
>> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrd=
ma.h
>> index bd55908c1bef..c71e106c9cd4 100644
>> --- a/include/trace/events/rpcrdma.h
>> +++ b/include/trace/events/rpcrdma.h
>> @@ -375,10 +375,16 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
>>    	TP_fast_assign(
>>  		const struct rpcrdma_req *req =3D mr->mr_req;
>> -		const struct rpc_task *task =3D req->rl_slot.rq_task;
>>  -		__entry->task_id =3D task->tk_pid;
>> -		__entry->client_id =3D task->tk_client->cl_clid;
>> +		if (req) {
>> +			const struct rpc_task *task =3D req->rl_slot.rq_task;
>> +
>> +			__entry->task_id =3D task->tk_pid;
>> +			__entry->client_id =3D task->tk_client->cl_clid;
>> +		} else {
>> +			__entry->task_id =3D 0;
>> +			__entry->client_id =3D -1;
>> +		}
>>  		__entry->mr_id  =3D mr->mr_ibmr->res.id;
>>  		__entry->nents  =3D mr->mr_nents;
>>  		__entry->handle =3D mr->mr_handle;
>> @@ -639,6 +645,7 @@ TRACE_EVENT(xprtrdma_nomrs_err,
>>  DEFINE_RDCH_EVENT(read);
>>  DEFINE_WRCH_EVENT(write);
>>  DEFINE_WRCH_EVENT(reply);
>> +DEFINE_WRCH_EVENT(wp);
>>    TRACE_DEFINE_ENUM(rpcrdma_noch);
>>  TRACE_DEFINE_ENUM(rpcrdma_noch_pullup);
>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_o=
ps.c
>> index 229fcc9a9064..6726fbbdd4a3 100644
>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>> @@ -654,3 +654,38 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, =
struct rpcrdma_req *req)
>>  	 */
>>  	rpcrdma_unpin_rqst(req->rl_reply);
>>  }
>> +
>> +/**
>> + * frwr_wp_create - Create an MR for padding Write chunks
>> + * @r_xprt: transport resources to use
>> + *
>> + * Return 0 on success, negative errno on failure.
>> + */
>> +int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
>> +{
>> +	struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
>> +	struct rpcrdma_mr_seg seg;
>> +	struct rpcrdma_mr *mr;
>> +
>> +	mr =3D rpcrdma_mr_get(r_xprt);
>> +	if (!mr)
>> +		return -EAGAIN;
>> +	mr->mr_req =3D NULL;
>> +	ep->re_write_pad_mr =3D mr;
>> +
>> +	seg.mr_len =3D XDR_UNIT;
>> +	seg.mr_page =3D virt_to_page(ep->re_write_pad);
>> +	seg.mr_offset =3D offset_in_page(ep->re_write_pad);
>> +	if (IS_ERR(frwr_map(r_xprt, &seg, 1, true, xdr_zero, mr)))
>> +		return -EIO;
>> +	trace_xprtrdma_mr_fastreg(mr);
>> +
>> +	mr->mr_cqe.done =3D frwr_wc_fastreg;
>> +	mr->mr_regwr.wr.next =3D NULL;
>> +	mr->mr_regwr.wr.wr_cqe =3D &mr->mr_cqe;
>> +	mr->mr_regwr.wr.num_sge =3D 0;
>> +	mr->mr_regwr.wr.opcode =3D IB_WR_REG_MR;
>> +	mr->mr_regwr.wr.send_flags =3D 0;
>> +
>> +	return ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
>> +}
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rd=
ma.c
>> index c335c1361564..678586cb2328 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -255,15 +255,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, s=
truct xdr_buf *xdrbuf,
>>  		page_base =3D 0;
>>  	}
>>  -	if (type =3D=3D rpcrdma_readch)
>> -		goto out;
>> -
>> -	/* When encoding a Write chunk, some servers need to see an
>> -	 * extra segment for non-XDR-aligned Write chunks. The upper
>> -	 * layer provides space in the tail iovec that may be used
>> -	 * for this purpose.
>> -	 */
>> -	if (type =3D=3D rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
>> +	if (type =3D=3D rpcrdma_readch || type =3D=3D rpcrdma_writech)
>>  		goto out;
>>    	if (xdrbuf->tail[0].iov_len)
>> @@ -405,6 +397,7 @@ static int rpcrdma_encode_write_list(struct rpcrdma_=
xprt *r_xprt,
>>  				     enum rpcrdma_chunktype wtype)
>>  {
>>  	struct xdr_stream *xdr =3D &req->rl_stream;
>> +	struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
>>  	struct rpcrdma_mr_seg *seg;
>>  	struct rpcrdma_mr *mr;
>>  	int nsegs, nchunks;
>> @@ -443,6 +436,27 @@ static int rpcrdma_encode_write_list(struct rpcrdma=
_xprt *r_xprt,
>>  		nsegs -=3D mr->mr_nents;
>>  	} while (nsegs);
>>  +	/* The pad MR is already registered, and is not chained on
>> +	 * rl_registered. Thus the Reply handler does not invalidate it.
>> +	 *
>> +	 * To avoid accidental remote invalidation of this MR, it is
>> +	 * not used when remote invalidation is enabled. Servers that
>> +	 * support remote invalidation are known not to write into
>> +	 * Write chunk pad segments.
>> +	 */
>=20
> The words "known not to write" sound ominous. Why not simply register
> the pad MR as remote read, without remote write, and close the door?

RPC/RDMA v1 remote invalidation is "responder's choice", meaning
that the server is allowed to select this segment to be invalidated
remotely. We need to prevent that possibility because invalidating
it will break subsequent writes into the pad. (Or, we can allow it,
and suffer the occasional spurious disconnect -- the client will
set up a fresh MR in that case).

But v1 servers that support remote invalidation also don't write into
XDR pads at all, because those servers comply fully with RFC 8166.
So it's safe not simply to provide this segment to those servers.

I guess I can remove the comment and the !ep->re_implicit_roundup
check.


> Tom.
>=20
>> +	if (!ep->re_implicit_roundup &&
>> +	    xdr_pad_size(rqst->rq_rcv_buf.page_len)) {
>> +		if (encode_rdma_segment(xdr, ep->re_write_pad_mr) < 0)
>> +			return -EMSGSIZE;
>> +
>> +		trace_xprtrdma_chunk_wp(rqst->rq_task, ep->re_write_pad_mr,
>> +					nsegs);
>> +		r_xprt->rx_stats.write_chunk_count++;
>> +		r_xprt->rx_stats.total_rdma_request +=3D mr->mr_length;
>> +		nchunks++;
>> +		nsegs -=3D mr->mr_nents;
>> +	}
>> +
>>  	/* Update count of segments in this Write chunk */
>>  	*segcount =3D cpu_to_be32(nchunks);
>>  diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>> index 649c23518ec0..7fa55f219638 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -551,6 +551,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt=
)
>>  		goto out;
>>  	}
>>  	rpcrdma_mrs_create(r_xprt);
>> +	frwr_wp_create(r_xprt);
>>    out:
>>  	trace_xprtrdma_connect(r_xprt, rc);
>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_=
rdma.h
>> index 5d231d94e944..c71e6e1b82b9 100644
>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>> @@ -68,12 +68,14 @@
>>  /*
>>   * RDMA Endpoint -- connection endpoint details
>>   */
>> +struct rpcrdma_mr;
>>  struct rpcrdma_ep {
>>  	struct kref		re_kref;
>>  	struct rdma_cm_id 	*re_id;
>>  	struct ib_pd		*re_pd;
>>  	unsigned int		re_max_rdma_segs;
>>  	unsigned int		re_max_fr_depth;
>> +	struct rpcrdma_mr	*re_write_pad_mr;
>>  	bool			re_implicit_roundup;
>>  	enum ib_mr_type		re_mrtype;
>>  	struct completion	re_done;
>> @@ -97,6 +99,8 @@ struct rpcrdma_ep {
>>  	unsigned int		re_inline_recv;	/* negotiated */
>>    	atomic_t		re_completion_ids;
>> +
>> +	char			re_write_pad[XDR_UNIT];
>>  };
>>    /* Pre-allocate extra Work Requests for handling reverse-direction
>> @@ -535,6 +539,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rp=
crdma_req *req);
>>  void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
>>  void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *r=
eq);
>>  void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *=
req);
>> +int frwr_wp_create(struct rpcrdma_xprt *r_xprt);
>>    /*
>>   * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c

--
Chuck Lever



