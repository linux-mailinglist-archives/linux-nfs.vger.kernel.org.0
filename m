Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C552FE20
	for <lists+linux-nfs@lfdr.de>; Sat, 21 May 2022 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiEUQeF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 May 2022 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiEUQeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 May 2022 12:34:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C35DD1F
        for <linux-nfs@vger.kernel.org>; Sat, 21 May 2022 09:34:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24LFMTrd008714;
        Sat, 21 May 2022 16:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2pqi6Hlcp1juVQOkcQzz1gU0Al1BAeKpJuEWkO3tQjM=;
 b=VnCzfjRlCnEPUVROxyjP6IM1LOF6DYj/ZrzaibL5LvgJMX+Tc2hhaLVirfUaU3KeAGEg
 0eDcgeyrzSyYTLrRjN9dnHZSvd7REgZq8jcJlxB3nmsXZ9Hx6pKnYwNDAWvHejN5A0YU
 WJRxH3RMAqnbF1qo77khHhUJrgu1z9V3LM4bePxi3vOqsBnMAzgH1XIztSRThpxWwRZN
 RsIEA/edpuVu4+iar3AedAEZo/b7c0/7Tqx1fUMxayHNXT7uVLDKlgW+2tQg39WRUvRe
 g8Cm1cb1sXdmWyXmEMeMZ5FI2D8J5Eusx8JFW/wn8wJxlvoQHiPy/Rk49xn2+ZL2KRZM fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbgp9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 16:33:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24LGSgvn018625;
        Sat, 21 May 2022 16:33:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph054p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 May 2022 16:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Dl4/VLUSZMEMd2ZEaEOjNUbpX8L7flRgu2dwggs4gicmI4Pc0yF7Rzj8RH3G7+98WeIPSzOLVPtDqAwvvz3lVTkR+UTbDJI5L1vieYRiEdsLwMGPyp4dUGVdM93Q+Ft1rxB1P4oQP7nY/dsXtjIez9Akt8U3bGJMV/JFPp8gtZPeaXYjwxITX/7tNEWQvtqxp+OOTT/ofaFxCOT+iDF0dZquRkPoZatgGJ4+/hjNxhHq2MzZMqsP9RS/8cnNU5j1RO02Eca/M+il1DhzYfEj+TsL7hcHs4NJKJtqVnYlkRQWA+2ITSJOtd+zIWnVU13gTbAzlQhntEGk8nlid/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pqi6Hlcp1juVQOkcQzz1gU0Al1BAeKpJuEWkO3tQjM=;
 b=Sh7X1gFS245IgXRXCG2ZcXpiKX9yhJIq2SgrR3o143ykJ3R24YlcM/UkZ+fHR8G7n4oSI0FxaUxgYgk4dwT/LCXrP3iQ5sQO9cl9VWTfIQ+5+Hzc68AgcVXY4AzSjX4KUSKGo2MKG2y35VQ5MPcN0OK+fwwUtATC7v1wSgPKV3Frx2v8n5EOafGYxTwWQ/R77+uWo9dRwsz3s8iRBtKVdpHzPkvif1sAgc2jEJXgWzXd0o/4GiYOPC8jQeDlY49Ye+GSufEfp2cNIVMcyoq/+Racfh2vfHCtIg+zLzN83eBlQn7iCaoRpk8yt9cXpoycKODWN6ByFTkYXz/acU/PKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pqi6Hlcp1juVQOkcQzz1gU0Al1BAeKpJuEWkO3tQjM=;
 b=LxvLKGZexGm144ofHkoDxUGOZRURYh7eCCM5roYFk5wGgt+6bUR6qmhxcBnExaNaMaBRvFqGAnVRn+oJlsu1oIRLR+BBMD0NucqHvvgxsDsENyrgLVeSSQgW6/C7+blPZtlJtI79mK3bhO2MO8ydTldOqFiLq2uNLW62wDq+qT8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Sat, 21 May
 2022 16:33:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.019; Sat, 21 May 2022
 16:33:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is
 NULL
Thread-Topic: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is
 NULL
Thread-Index: AQHYbPhRTH/mCNjc006EIN3BpXQOha0phy2A
Date:   Sat, 21 May 2022 16:33:54 +0000
Message-ID: <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
In-Reply-To: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8919ac2-8798-4e90-72d5-08da3b47b24b
x-ms-traffictypediagnostic: SJ0PR10MB5669:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB566906DCE2E0DAA190BD565493D29@SJ0PR10MB5669.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTCtfkmwHrhWaTMP04gIStfL581NEW0zGHUFufRjAQ7wwNQwh3Pt4jvndU3c0M4H0e+SIy55nPUIZNYTQAVaPnHjORSveZjksss9xnWZt9HLxoaU5aU9yQ+VIiXQHwuH71AOYS/wAvKyIsCGO0HsXu5Y7j33dmFFB9DP7qZZmwVbHYKLyYl+fEBMoBMxZrJfPqu8xEPFfjAUMB2IMQJBpmL6U4Y+T9grBjybcFiJJbXcBpN4IZhgHc4jFRnZEzwKWUf3ltW0nWpTqTPNJZHXE7q4GHsxi4QE3QV/KNSMr0yvpZ/XbvW/zhfyIwtnsCHj/HEoS1YfiGqXwUb47D5dIKbhZOa9PqPfhA6daCxtwOi9FiKAUOvjh3JEKyKlN5WS/SqKkDEGH80hA1nPo0SLV4WNNZOigPO9wCVkovnDUwwo+YtQ5E0S81n6VlxuU9ZQxY/ld446b8ssJ6k2UfTy387tqCjTpq7ovZZZpx5kHG/iUUrDCga38EgDvTu0shNfuAIJqhrnFWeh95tvfBuIHjND9vIcS6WhhcvfZQp3JPrvvAlbxZrMQKk/RcC1tO/wvg/uLk5+N9utGtEgVAZdvkA5zOU/15kSpleRiDuuHigTNIwG1RKyBKCERrh6P4QRZMAVe9ITjLbjStGU83agPoQclLF/+j/r9Dd89JpQEnW1LvWxo2WmvmgsNCJ3LvoI8wEMM2uhAebCFOvyphux5HFOyr70iTVGTa9K6whoSo2UkvmDKqDMJdmtZA5hsWiE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(122000001)(2906002)(6486002)(5660300002)(508600001)(8936002)(33656002)(83380400001)(66946007)(66476007)(66556008)(86362001)(26005)(6512007)(186003)(71200400001)(38100700002)(38070700005)(36756003)(6916009)(66446008)(54906003)(8676002)(64756008)(4326008)(2616005)(316002)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X1eVt7GBzCyQWB13k8Tfo2Vtz9q/kYjnq4V4wJeFSwr2G+vU6org+HJvLPEo?=
 =?us-ascii?Q?4YolgwRU+1cHxIhsyhrTzFSAq96/IfU/SeKG5omlhfetjOZVm9KVwIz846nO?=
 =?us-ascii?Q?7ch03Uc/IfIh4W5uf23CpwBjrKKkHLW+V8RV8yIgvY0Iv9rN3x5cTHZXmsRW?=
 =?us-ascii?Q?ApAN/7EqJvbHFcR0BB4DFBPVxPDmJrMUEyOC5Td4YR9cgbjmrYUh3FLj5WDv?=
 =?us-ascii?Q?IHvBsriD/ty21LDErza+crfK3Mqal5KVxq0xdTNxerwkd121y7exxwmBk8nD?=
 =?us-ascii?Q?zya6e2YWZh39RcEFnWgEFaAdrnv2mV5C3V42+dW5xhMsoAc93phGWdoCa36T?=
 =?us-ascii?Q?W5AqB/PX5yQPbYkh83ioj8dpUEWzW1ZYOdtXuzWoFHmpyCWrGuzehU49BSOI?=
 =?us-ascii?Q?1SSWNudeyIbQsQKCFM9c1NSBIxNHBAgW5/RTrSSuV3AqGpiZLuzfzpr0a1vw?=
 =?us-ascii?Q?U3Jgj0/USQdTHK7raqGVrmW6ATPsI/mxJClNA7nIUyKPCjmTcUmEqQu+6Wtt?=
 =?us-ascii?Q?JsgZ6RRxg8yrExw1bTf79kJLJKP1BWRzQL1lYpGjSM9z6DPYJutvaI9Aa+98?=
 =?us-ascii?Q?OYLXyaG8peHK7T84liP/Jckoq9/uXpa/hFJFJEv0DM5pVLbU9JpggLN5WTCl?=
 =?us-ascii?Q?BvcqPcXHoebk+zobY0sDqK4FhJ4iqirtcfzAHWeFXjasoJ67fgKCPkY0onyZ?=
 =?us-ascii?Q?AAtlRCc6SQFhBbSyH/GQVZrAUyTVe1CtNTgRFPVHsRYKzk6T/TnDt2Lr6vet?=
 =?us-ascii?Q?lwmVn/S8QfAAyBsH4WXOSS0IjK/CTqXpNeE4/MouwXQAPBvhTTaqCMUBvxPd?=
 =?us-ascii?Q?v99lWgA3vR5Zjlet6EMSedhef0RnKNpIE0KBUyHwIz2zYNhDAY3e+ff1/Cp4?=
 =?us-ascii?Q?KJT13uQ92uEok4vRNS7SfOZwZvYkft5gbtc87Z+DK9dkHAdQl+Q06xyqHoXr?=
 =?us-ascii?Q?w3LgoigLSaR3aVign7fg4sm7AifdOD/gIwZkiEgNPTd8exx84SY/hm1quUVW?=
 =?us-ascii?Q?co62fZy/QM46QCMiIKZmRRPQCNGEo0ThMj3VcidJCICy3Nc+tyk44U5hBQnA?=
 =?us-ascii?Q?jmp8JhXNKv1kJo7+2MkLepl5K2/r2ObqtDd6fS1GQUnylNZAiUFWfx5oxNeg?=
 =?us-ascii?Q?FxvE6Vk+4PzQjirQMFIJTZWfNRfV04uYocCLR0R2jxPukzzn8p/+hiMbtt9h?=
 =?us-ascii?Q?xRvT/WNBLP6JZdCW+K6zpx8/axfjrmKao7eDQqiQaW/EmThKIUYkevqCZjuw?=
 =?us-ascii?Q?dlZvvrljG4GH+yOnDL2kIfhLTFp8FxGDMLdxlanQrZGdVzFYl/GF6/Xpwb3d?=
 =?us-ascii?Q?hVhOLzpHMAe/Be+OQ8Wx/VA1E3ZEbV//8jMq/SwmF5aa9NyOLmoVC7NtXvoe?=
 =?us-ascii?Q?RxapgQ7WNcCWKlgC6nQER/gHn/IPx9mCXs+X4q36N/IBertan9jbt8rZ35iS?=
 =?us-ascii?Q?BDq276j/iPwJSl6oMCfPXGEtXAiEY+zh5DKeZWUkuX09OMwcr6axMblBoSys?=
 =?us-ascii?Q?aVeYiZIt426tLMqK8FLrRCYitaJqH42abJGIrzeVl0RZkBrt3KHMonJNzQyQ?=
 =?us-ascii?Q?LDt3K7Qf5XcyH/GCX8iVsLXXwlPIvE9C+/YNrvcYbPufGzW8xIZMxk3TCfDa?=
 =?us-ascii?Q?Wd8ehCHTYtaV6wOdsRGBm75/SLA+3B7uY5vFtK3qp2wXLxvs2V+ifg4DXgNS?=
 =?us-ascii?Q?JzrU7tkxoR5kxmmHmz1WLo4FdWYOx45El4cXAkQLbDMdX5RW7zXXfJzmmiVl?=
 =?us-ascii?Q?oOGpT5FBipG7uk98pvf5Lxzp3E4o2/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F036AF758F3C4047BE10CCE04E4C5278@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8919ac2-8798-4e90-72d5-08da3b47b24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2022 16:33:54.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYmbnAeU38NKZ0GOhUG0y16lf1RCccfPYDmq2LAg7Xz6/NTWIckE2a7aWz1xK2OKBfs5+6B5RSeoWnPcotd2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-21_06:2022-05-20,2022-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205210103
X-Proofpoint-ORIG-GUID: rK-JY8-Z9uT4EXJ4n5Png2uceMwCLiys
X-Proofpoint-GUID: rK-JY8-Z9uT4EXJ4n5Png2uceMwCLiys
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 21, 2022, at 5:51 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>=20
> When rdma server returns a fault reply, rpcrdma may treats it as a bcall.
> As using NFSv3, a bc server is never exist.
> rpcrdma_bc_receive_call will meets NULL pointer as,
>=20
> [  226.057890] BUG: unable to handle kernel NULL pointer dereference at 0=
0000000000000c8
> ...
> [  226.058704] RIP: 0010:_raw_spin_lock+0xc/0x20
> ...
> [  226.059732] Call Trace:
> [  226.059878]  rpcrdma_bc_receive_call+0x138/0x327 [rpcrdma]
> [  226.060011]  __ib_process_cq+0x89/0x170 [ib_core]
> [  226.060092]  ib_cq_poll_work+0x26/0x80 [ib_core]
> [  226.060257]  process_one_work+0x1a7/0x360
> [  226.060367]  ? create_worker+0x1a0/0x1a0
> [  226.060440]  worker_thread+0x30/0x390
> [  226.060500]  ? create_worker+0x1a0/0x1a0
> [  226.060574]  kthread+0x116/0x130
> [  226.060661]  ? kthread_flush_work_fn+0x10/0x10
> [  226.060724]  ret_from_fork+0x35/0x40
> ...
>=20
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
> net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdm=
a.c
> index 281ddb87ac8d..9486bb98eb2f 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -1121,9 +1121,14 @@ static bool
> rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> {
> +	struct rpc_xprt *xprt =3D &r_xprt->rx_xprt;
> 	struct xdr_stream *xdr =3D &rep->rr_stream;
> 	__be32 *p;
>=20
> +	/* no bc service, not a bcall. */
> +	if (xprt->bc_serv =3D=3D NULL)
> +		return false;
> +
> 	if (rep->rr_proc !=3D rdma_msg)
> 		return false;

I'm not sure what you mean above by "fault reply".

The check here for whether the RPC/RDMA procedure is an RDMA_MSG
is supposed to be enough to avoid any further processing of an
RDMA_ERR type procedure.

What kind of fault has occurred? Can you share with us the
actual RPC/RDMA transport header that triggers the BUG?

--
Chuck Lever



