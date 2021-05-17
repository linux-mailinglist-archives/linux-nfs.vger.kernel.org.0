Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067823839CA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 18:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbhEQQ27 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 12:28:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbhEQQ2z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 12:28:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HGP8Tc076953;
        Mon, 17 May 2021 16:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yvMtZz+5uXuxi93VLb1ruknj3vebDajCwhaGmKwmzBE=;
 b=mf8tx21IwNyFeAizccicdLR8MQpe/qDZXi+GJHPJbOtGSv3GG1OzfZ18PzH+r0SpcZg6
 3TjB1GAP8RbAe6grN/FA4ewpWEvEYidlcs/lBV5Vi+sJtVw7o5AYSobDN5q+P8Et4fSt
 K3AVfFfFkIbnI44oID9d4I21Ecxu9S9Q55YDRcDLp6qBHFEhrMNYKj1PybWoOFG99qS1
 DiBuTa9vEBlag60NJGzlg+f4M6oaO/DrBxsS+iqggHi70yMGYKI7jdlO11hQXQcMA0GU
 cNL+jXFs1hNB37kMXT4cBw86A0uALR1iLw4FgcFzzZXpBrFf8lRYGPnwHMwBmFJcphJn QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38j6xnbqtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 16:27:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HGK0sE110803;
        Mon, 17 May 2021 16:27:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 38j3dtfspr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 16:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL0MzODsPtcCdtRU9WuVEA7S/8yroNA8yWo8LNBZoP+nDE/SikhE7NGmP2ke65k8sBPYNKceyeIqK+EZ16lG8gKHk33CLpVI7oawAt40JLN838fUSk30gZPb32jWA2B6cPA/2ZBFrpecAt4dhgN7JioSQl1utyWhLSiEPgVEAAGvTEQ9u/XiTcq/LH8HMKR2qeDvHpGhcc5yqWU3MSXMUHXnXk/ptBVUt/R2q85MSfrFqd8ChNF0rSIgd4tjMVy8x2FuATqY0nf0FRfIFvP/eUXXHB+E2WLegCAawEtemAtbEt+VWN53p07Pi7+itVS4KbvhojCRgYNcx04iTtj1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvMtZz+5uXuxi93VLb1ruknj3vebDajCwhaGmKwmzBE=;
 b=BNqoP2J8qVYCn5ZCdEqao0MNYo1hrkybJuRKUBVetXjX56Chpm2OoxlLyNeJq4yXvGl+4xpTQFTjQFXPL0byIWSyutsOfw/NcoghZGrZ9MiNKwNe9pM9MCe2auFbfSqz5Re0QknDIMlNxchWcD7xHbCax6clqp8Rq5xZLHnoFH9BVg8fBZWFIPpvkme7RkvtHL2QJFLerx2Iey2FVbA4btjnTYAvS40s+vhSaseVj/gRnlOJotZ+CRzoR1LV4jUB+kpigurxJALu/jmp2ihxiYM7qu+9tB6nZBxv141gHPbq5J9oqhHx0liH8BpkYaNdqZfbPWejStgmaZAXT9ahtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvMtZz+5uXuxi93VLb1ruknj3vebDajCwhaGmKwmzBE=;
 b=o213b99jKuKiGZUQbrxKynJU544kdjEwEOAzWLgYP575564lLrgKbDx9gvPdOta+CbWROrdrZZdCOCuqC4pmWJomkDSH2iiA3MMsW3gtZfn4lQqCEdyNtWEdOQGs6sNKp9Y2BAUjQz3FzJI3btIiJRHoVsnkFMAlukvbeH0I4MQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3858.namprd10.prod.outlook.com (2603:10b6:a03:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 16:27:29 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:27:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgA
Date:   Mon, 17 May 2021 16:27:29 +0000
Message-ID: <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
In-Reply-To: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 098cfa39-0491-466a-fc8e-08d91950aa38
x-ms-traffictypediagnostic: BY5PR10MB3858:
x-microsoft-antispam-prvs: <BY5PR10MB38588838BA6FCAAF11BB7EB2932D9@BY5PR10MB3858.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbfqrCyqiFrT4lz3SrXSkFw+1yYz5y1QZzKnsl51miNqcBSeuQoRYvaVZh7AE8BRryJiUbOXl6TvB+ITQKbiCkeMVB5x/3FpL2XdN5bfBJxkjy550cdoaHMuECmrI4gDQCBzVAMNACB6DG/EJnPpr/02hMedHhnBS65ybmHRGXe5A4LShmjcryGD8E3mt8AeQJqmOqNvL2S2vdx/vWRCu4/8j9HuYKsPbVFYKRl64Y0Fa3Ty8SpFK2S0PVoQXb7v9yuxRdaV0RMZTGOEEdpeuBBH3GLUFuuJ+GZB5lkyhyUWWEeBplH/hQo0/KKVSCvzqf9Hlx3YklouQKFizuJmQI8SuN6Yj7rOi1Gt8oFfw9EFUhdg2RmUoMBUpGW3kX+cdQoxirP1l8VtKDOMNJgIPI4t5SRq49hanKtv5feuFBODiOJfYJkopNfF0dvMthfwaUjFSQGvRcCLSPiBCuOyPqoAcsQ2I/8zmEVncaJV2CPSGRGxyi45yOHLCl5UjOpOaaPLSeq1WYbdwhE+KqvTiFl1weDmZlXrpaIFt9+p4TJWXrvwSB0ug96ahFO1uAkKNMKLOeTkDi8Vow5RNzGPTG6aV9N5Vzqoo2K/CnfEDYuF2ct3Jtj0Iq7t6utwhVP62Z4C/xZJt9vQONdYUBa1wxs4emOEHQnuoJoiRbc1XucMAaOErzLpfRzSQLJWRCPw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(346002)(366004)(122000001)(316002)(54906003)(38100700002)(5660300002)(4326008)(53546011)(66446008)(64756008)(6506007)(66556008)(478600001)(76116006)(8676002)(91956017)(66946007)(86362001)(8936002)(186003)(71200400001)(36756003)(6512007)(33656002)(2616005)(2906002)(83380400001)(66476007)(26005)(6916009)(6486002)(45980500001)(505234006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jnhpCbpswChZssYVdRgsT+dvciwLJ58sXnwHyCKcanXDkL82PeXYvF1J5VsX?=
 =?us-ascii?Q?iZW7OQPPYXq0V9sWew2SP1e5/FV7EofaoRNlu4LO/oWYO55R4RDKY7jzXGMW?=
 =?us-ascii?Q?0G4T6xJk4uvFN9gFEwV9+2KEpCir3P2fuv0E30u4VNEehxG2M1RXXjJtaJax?=
 =?us-ascii?Q?YZSUca+U4RpZt9xPva/kud9BHO086atVJrWctPoZBIP7toPNKnZ+/QO9eZr2?=
 =?us-ascii?Q?TMSZRABaCG583qOrkxZWttqrkDZe0LVOZCCUgCrNB1z2MYtEv6ZDTqLR7byq?=
 =?us-ascii?Q?2FnWUzs/2eeDCbGvVzLSk1N+KImfACi1Pv54H9x1B0Mi059JUyQW2R/svVb/?=
 =?us-ascii?Q?8PhV76zAVImnzd914o9xgI27S97ztZHzbWtBmYj7oT7fifEJPJWxBVjZtgpN?=
 =?us-ascii?Q?WAuqRAeIOzurz405Jqr2yY0OL/FsXmW0hKT3ggstUllhOGmxV4D7h5UJqPzl?=
 =?us-ascii?Q?qXKh4oB3OX8t7Fe4F7rIOaGsVTxx9AugMR9oaZTJwKHJsLBoCI2x7ub0njKV?=
 =?us-ascii?Q?wGP3uXR8phdrFCGn2iLmf3BT/wLB1SO8gPxHDdRbRIKw7IdlZqwq+qpPdr0X?=
 =?us-ascii?Q?HDfcb+zyJclxdjpNN53nQfnCAlTtyG4o+kxTxrnAiyO4OQrh3NdR6QZx8e9+?=
 =?us-ascii?Q?PmdntbeHo+byknxa3h3GeidXhvOWgMiw6Vq91i/SMvwlnzgmFlS/1uoilMPR?=
 =?us-ascii?Q?KyQ2jSe+JpQ7LrFWQ0lJgmIuo3EpflGFJU3YcdYco9zVuuArTBlTouSiR6Wf?=
 =?us-ascii?Q?q+8ZSHUeQtesZvIX6S33z0NzNzq286J78YiSyUcEuSaGKloVU6ZfxFNr2+fF?=
 =?us-ascii?Q?P3UxvQzl1Gpn6BoLE/VJcLMyZw/VlQfoL06qRUjO7Cja/qIkbFNLpcJlQQfy?=
 =?us-ascii?Q?aIx/R3Laldn+gVEy7DGivnbFfMjBvbeXj9g1qSbWjyOj07iyRyzYxmS4Sq78?=
 =?us-ascii?Q?XJPuFwtIHCylokPCqy5stGIuwAtq9tB75mHqtUjel89R08JZIRfV1INJvfd3?=
 =?us-ascii?Q?jSFLKNNwPeQPuqi/1aZkvLle0lZo06OVg4hvzgMLnNdPqagjcx7CMuWSy6eY?=
 =?us-ascii?Q?dyZtM6+LVkH9MEHLTlexP/T8BL8746ZZfBxflgkFlz56hzE6k+9Wqp0x8l/z?=
 =?us-ascii?Q?Wh9we7sMGsLxxPLLkS8VBPpbxhvzI8vFx6Q2PldhOULpbWPCVHM5tp0R4R8q?=
 =?us-ascii?Q?rIaPJYwGteWOKsoXH6e6p1GZxh4S9D0BCtKOpWuQ21jjVxY8TkImGtUuiKjM?=
 =?us-ascii?Q?8BpFF7NKL6nD/l+bQTOZ8gRMka0qB5czTxhVVZcG+BSw/K7+HiLdmYZ9v8pc?=
 =?us-ascii?Q?+c4SXOELvWqo7BbJMAjiy7F3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BED40FAF015D84A8849A3BC764A6702@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098cfa39-0491-466a-fc8e-08d91950aa38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 16:27:29.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mn1xZlKX7gagQbKmCAs0lZzWNM+Un4MRhGpoL6oQtnCxOtre4rtCjaPcDLtdn/7VQPxUnsR4N3Dgo6R+pn8oAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3858
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170112
X-Proofpoint-GUID: cHUM_DF5WyaNyN-UWV00_vzVVVritOC7
X-Proofpoint-ORIG-GUID: cHUM_DF5WyaNyN-UWV00_vzVVVritOC7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170112
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Timo-

> On May 16, 2021, at 1:29 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> This has happened 3 times so far over the last couple months, and I do no=
t have a clear way to reproduce it.
> It happens under moderate load, when lots of nodes read and write from th=
e server. Though not in any super intense way. Just normal program executio=
n, writing of light logs, and other standard tasks.
>=20
> The issues on the clients manifest in a multitude of ways. Most of the ti=
me, random IO operations just fail, rarely hang indefinitely and make the p=
rocess unkillable.
> Another example would be: "Failed to remove '.../.nfs00000000007b03af0000=
0001': Device or resource busy"
>=20
> Once a client is in that state, the only way to get it back into order is=
 a reboot.
>=20
> On the server side, a single error cqe is dumped each time this problem h=
appened. So far, I always rebooted the server as well, to make sure everyth=
ing is back in order. Not sure if that is strictly necessary.
>=20
>> [561889.198889] infiniband mlx5_0: dump_cqe:272:(pid 709): dump error cq=
e
>> [561889.198945] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> [561889.198984] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> [561889.199023] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> [561889.199061] 00000030: 00 00 00 00 00 00 88 13 08 00 01 13 07 47 67 d=
2
>=20
>> [985074.602880] infiniband mlx5_0: dump_cqe:272:(pid 599): dump error cq=
e
>> [985074.602921] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> [985074.602946] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> [985074.602970] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> [985074.602994] 00000030: 00 00 00 00 00 00 88 13 08 00 01 46 f2 93 0b d=
3
>=20
>> [1648894.168819] infiniband ibp1s0: dump_cqe:272:(pid 696): dump error c=
qe
>> [1648894.168853] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
>> [1648894.168878] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
>> [1648894.168903] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
>> [1648894.168928] 00000030: 00 00 00 00 00 00 88 13 08 00 01 08 6b d2 b9 =
d3

I'm hoping Leon can get out his magic decoder ring and tell us if
these CQE dumps contain a useful WC status code.

Meanwhile, you could try 5.11 or 5.12 on your NFS server to see if
the problem persists.


> These all happened under different Versions of the 5.10 Kernel. The last =
one under 5.10.32 today.
>=20
> Switching all clients to TCP seems to make NFS works perfectly reliable.
>=20
> I'm not sure how to read those error dumps, so help there would be apprec=
iated.
>=20
> Could this be similar to spurious issues you get with UDP, where dropped =
packages cause havoc? Though I would not expect heavy load on IB to cause a=
n error cqe to be logged.

The underlying RDMA connection for RPC/RDMA is reliable (lossless),
so I don't see an immediate relation to how RPC/UDP might behave.


--
Chuck Lever



