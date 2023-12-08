Return-Path: <linux-nfs+bounces-468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7780A742
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 16:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97021F2107E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BB30329;
	Fri,  8 Dec 2023 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyohrsXu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n2/X/zeA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3181706
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 07:22:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8Esdw1021367;
	Fri, 8 Dec 2023 15:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=iT9tSiJ4Q5tmQhvsdjzBUqZDtkb57G+Dqd1LloaUk64=;
 b=FyohrsXu+Iocpx1FDRZa/cBom9zJ0TNi65XoqVt4nIrllY3/+t6aitaVNXng9Px0uX8o
 wl/b+7aSSoMtOFX7zgqNUms7uyofQM0smbiFIh+/uB4q6lBzNMXVMSKU8KAbX7h38Gq6
 VpMjU2KxyPvxMVnXz4KBIZG/pa+swE9a6UVhLYdAHra6jT7zxXD5REFsHrKsxVe6yoIB
 IK0pnAH0EBfksMrRle25xPNM4N0Jmu5Z19qLJSwQYczDUVq6nd0VCohmRb/2W58e8CTN
 L4L1nqt3t3JuUGxO9d6XXXk9E93DSgLsno/yjm0O3x1yy4lwwP6QJ563tcQ1LdNhUhp0 yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvp9y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 15:22:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8E5GHe001315;
	Fri, 8 Dec 2023 15:22:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan90pwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 15:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhc26dxBPrhmDovI0pb9vq2SugpvBdVL/oKgxJ6h2nQUpOlj9JSV3Bym2zM1Emc8gYXQ94SomJi2Z00v067Zn6riz5y14zyQWl0y+rpZaAShuc0fMVHGsqIYVpppUlrBjqcGTs+AfDu05BIVw+CbPf24BMwHUnBpgUcsPgfvyspMOLHJPTP/CturN5+C+FQcwhnoTJkIhvJ84YTzJt2IxeltPJPKm+w20CcvN/dShQ3s0UOGXgOfYN0Ng14WN0qDCPOIwsUWnHoB1y611z5m6VeK9LKUvtW6n5BETY4fpJbulrN0frAsN+9ls7rvkEhYgccfoyTknr2Cf4V/n/YKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT9tSiJ4Q5tmQhvsdjzBUqZDtkb57G+Dqd1LloaUk64=;
 b=RrB3k1C1qKwzOxTY8Xluqn68nDZwv8ZjPELAVWKQnKZqPLx43ej+4Xer1wIF2fd/bbcXs2q+ROP7UXkcLs8Ab/UOcj0Uphm9HC7C6YTFwqZR0wxw5SDNz54yjUjtyT4Z7Xkbh21IuBlRdfVdoy5Pmm0wuPxXFlSUzIs4yBnW82SBOHrIZcDKa52FI0dRdm9ysGK0IdlnYjIkLYwBV7cw5v5ke5snX27lZZlSJ+vXL7NML9XHA6/auG5OkCRyKsJf4m2Js/kw4XyydW7V5yx68KcpTxeGOOuodXkZVVN29LmVnFtUQLvGOLUoKHUVFxyx9oW2I3XXuO/946b92BXQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT9tSiJ4Q5tmQhvsdjzBUqZDtkb57G+Dqd1LloaUk64=;
 b=n2/X/zeARb5K/s+J288fnAxhgiE9xnGcdRAS6/DZML/uJBJM3OzK9esD98gg9hdFApzfd7/LVNstxn3wMadFQg5eGv7+QdPqoP65pVS7hRTPdq/s/0IkKVPdNYdC4fggVD+M2juZcIaelevpvaXsQVTCJPLc6k3tfFMueScPuHk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 15:22:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 15:22:28 +0000
Date: Fri, 8 Dec 2023 10:22:24 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Steve Dickson <steved@redhat.com>
Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
Message-ID: <ZXM0sJ7SOqlkurlf@tissot.1015granger.net>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com>
 <ZXHaTIvFruYfycsm@tissot.1015granger.net>
 <CAN-5tyFr7-eRP_wjrv_zOmsVC6ft1f1c+fNovbOXr0CVrtzfRw@mail.gmail.com>
 <ZXJG2xyFUs9pzHlq@tissot.1015granger.net>
 <CAN-5tyE_jBLJeW_JK0RScEDLF9jAZoi6upsM9aWRhtHPcYxHUQ@mail.gmail.com>
 <687d51fc-fc87-40a1-80c8-9261fcb8dd7a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <687d51fc-fc87-40a1-80c8-9261fcb8dd7a@redhat.com>
X-ClientProxiedBy: CH2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610::34)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: a705285f-9cb9-4f6a-fbb0-08dbf8017d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zcsJtjfxK6JjGwrcKCdcJG1d80lX+wFaCWUjeFHq8WdJRib7Upuw+64Jm/IQ/XRKHTcS6gswWr3w3Z3rTWTOPCpLXuPb80qP9vmaW6oD0Q7rAoQjlPN/Tl9ugFi1CpTVzgPwOunA7k1gRsuHrz9AHAsP1r+9n/L1RguQtOswfnbIH7xRNqT6e9GcJK3VBvJX5Fq762cwoZG4dj/AQmb2IyEa+rzOyjonlONxcjnvgL5a7nl7d3wEvMdnYrfb9Z6kURN/lI2EDOK9h1g1dzxCxGbjWc/JJy8EIO4FrMkPLO32ywsovrNYP1BuVYJOZ3Ad1STiSdjlBC2g4hUK33CyvWUeZWlReW4OLiFid2xl3KkkcsjEtZhuTRQH09hHadsW9KJG01gWYJlUhu+28K2dc+Zg91/igymAkpz2mZrTqftkygqZPm/50CyxRLgHQakkxIehtuK9KNLcsw0RXcc2l+bUrrmnIqGoMr5XWumawo50F/JxZlwUnHQ7T5x0fBYKyJx5yse3vzFEwXDfIBiq7M9yy3qmMkELIvt0KhnUR+nnMpxD9nZivFYWFVxR6+d5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(53546011)(6506007)(6512007)(9686003)(26005)(83380400001)(44832011)(8936002)(8676002)(41300700001)(4326008)(2906002)(5660300002)(86362001)(66556008)(66476007)(6916009)(316002)(66946007)(478600001)(6666004)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWVnNC9qbDE3RVM1cDdsUlo1OEpaMGFDeW1qL0N4TCtQcXQ2V1JJbWZKYi9s?=
 =?utf-8?B?NDRIeWJSbHdtVDR2RUt3K1dRZlBqQXRGMmNkWUFOSXRTZkpUeU5TWGVGMXR4?=
 =?utf-8?B?QVBUZkcxL2srTkQ0aU1wRWFmTEJMTVQ2eVpqTFRNNjdZQ0xobU5tVSs2ZG9w?=
 =?utf-8?B?ZzFsbkxwRFdtZUh3VVFjZ3VlMkQ3bEllbDhCNzJsaU5PalNyaVdCK2RWMEQv?=
 =?utf-8?B?VExXcnNEY1RVaFFWTVdnU1lrVjhyQy92dGNIUzd2NDMzVzdWZi9aWFpzQmF1?=
 =?utf-8?B?QXJreUtFMEU4RTcwMytoWU1YY0Nia2VlWmM3bGo2MVEwOWlNSVZCa2ROQzMz?=
 =?utf-8?B?Wk5seWZIM28xMjNoN0RMYzFDcjNUZUxEWjdkbVRUeEkxY3QrZzdMUVRiNHI3?=
 =?utf-8?B?SC9tL0Z1R2c5ZG5yUWZnSXBjeCtIR1FTcUZXWlZHdGpsRFV1UlBTYXdRWE1n?=
 =?utf-8?B?c2g5aG53SmQxaU5hSzY3bDVmenBSZGpYM1RTajhBWmhRL3NPMFZNQm1vdVlB?=
 =?utf-8?B?UmZERTV2YmxhM094Z0lXVlJTWjZLWmxMaUtCL2RkWkZHUFFNTm1ja2g3SVBp?=
 =?utf-8?B?cC9mV1ZGbjl3ZU5tdU5PNG0rNk94MENNemt4NURMTjY5VWJ1WEkwOWN6bVRK?=
 =?utf-8?B?cGowVExDdm8xMWRnZCtNQURHRGcycVNGc0F2ZVozUHJnS0dYWW5PcUh5bWJL?=
 =?utf-8?B?TmhLLzVCLzVYQ1cxdHdNMFVFVkRHd1AySDN5SXI0Uitkdm94RlYxeDkzZnVj?=
 =?utf-8?B?VTNJdmd0S01QM0pWREJnVUFrVEROakNGTXlqR0lMMGtOV2pPRzZLZ1N2VXFM?=
 =?utf-8?B?S2JmWHorOTdxb1NKSkEybmVyZUNWaVJmK2p6QmNGV0xmS2tva3NCSE1aTUQy?=
 =?utf-8?B?Q0VpeWU0b1lzUlpjRzlhNm0vTUJGVHhNQWNFOHh3b0dDbkc2MWJ3NjJ3SDZ3?=
 =?utf-8?B?ZlVwY2k4a0NwbFI5RzhsVE9zRXpFUEZxZEt1bkJCRkNXQkJhN0pWQnA2SzB2?=
 =?utf-8?B?elJKSU1IeVdjRllwVkZ0Y3pyVVVkQVJIZnYvRFpRVUIwVllhQWswSVU1c2JS?=
 =?utf-8?B?djlCOHdTZVlqY2FEbzdiS2VjdHhpa1VOVS9XUFJJcURZU0dmRDBGYXo3S3BU?=
 =?utf-8?B?TkpOY0JSK3BUZGlyalhjT3FxeHdjU0FIbFIxOFlrZkIxcTNUNlhkd1o2VC96?=
 =?utf-8?B?cjY0VWhENmI4ZUU2QmloeXM5emxaK3JwSHhnT2VoZTUvUVR0VXdwc0VVZlhj?=
 =?utf-8?B?N0NwY1p5bDFvQWpTaDNLZmlESGp3ei85Sjh1TWpIU3orWGZjM3Q0SFJTWXlk?=
 =?utf-8?B?NjBYZHFsZlJxQzBMVzNqNW8zTnFtY3RRRlBTelVISklobUExQ1ZnL1gvenhT?=
 =?utf-8?B?L3RuRVlBcnBZbElVb3pqV3VJb1l1WnhwSDBVTGo2dE5vdDVPQ2ttZTVYMUpS?=
 =?utf-8?B?RzByMnp2REExNGZhcXJHaDEwL3NEaUphNkMzazFqYWxFWXdNK0ZjNnNWcE9Q?=
 =?utf-8?B?Zk9PLy95VmtxWXJaQ1NESjRDWXRvcU1lTkRHSVZZYVN5QW51NDNxTzVWZ1Fw?=
 =?utf-8?B?OUM1cWdFbFBvaVE5OE16VXBiK3ZJb3NCUldMaUt2a2xnQ2VTRW5MUFR1WndW?=
 =?utf-8?B?aVNTZ0kvNDY1M2hoZXA4SDI3VkY0SUw2ZGthRW5kU1lSelRJLzRUMndDMnhH?=
 =?utf-8?B?ZnRyR3NMTkh0SkpBT3lWL2NFbEI4dWRHR3FhSG1EWDdlZG9KR0EvcXJYZ3F6?=
 =?utf-8?B?V0c2a3dOKzYxSCthenF2b0MxQ1dIVDBBeUJGY2pmTFYxdllCWXZsUEVESW43?=
 =?utf-8?B?YkMwbk9jZG9aSGZIeVRQcFdydEhiVUlEeFFCcm9ZUWsxakxLWDVSdTQ5ODE4?=
 =?utf-8?B?aG95SVFkOTh1QlNWaVc0TjJOOC91UURKclVtQ21PTG8rTlM3MlRDZTNXR0ZQ?=
 =?utf-8?B?NW5FampZamR0Vy9WZERxZStzSHJ2ZUpKdTkzMU95eFA0YWFDelRzbHpTdy81?=
 =?utf-8?B?ZmIwemVlaGtBSURrbFNKS1F1c05DK0lKU3NzcXpSRUEwUTZiMWpvWXdkZ0hV?=
 =?utf-8?B?UnpXK2E1bnhTek5vSFM1Ky94aStNQ1EzWWU0TWYzS3l5WFVUbVA2OGdWMEZJ?=
 =?utf-8?B?VFl5Z0lSMnYreFllYjk5T3lIQ0NZSmx1VjJKajkySGN4YVFJdU9iUnVLTC9M?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qAPHpuk8m2+wkEim6kNKNPsKM4cH6S0Dd8d6ovj1vUSAn93L2IgYWL6u5K6s7WmsA72ZUneuc0fxMHhlvMMF80Wa3W0B80q65muyy83u8MhTfVK5gZlAATP6kc5a9fYCtZw30elIwqykMXRr5fY0g7HYky1HfjjPizlKGXsc7lB6RWBHHoxa6SHUmHLz5CjPZPfqzcTm57OfsLDg+m/rW0a9E4DFO4okuHz+8WKrUl0BMmSyBkr4aFZ8dW5dM1kYfyXROZacaWeZ2AUYjNnzfik6UUGppnOyvk3Ays20zeOcGdv/fTmv4OAVQAsM9fFCM6qeMolIBBr7xcD005TjpRnYz0dP4uEUwiv30/oWSlRDD5O2efS7AoXRYmvISIT36E36UOJiOCFnf5Nw6PtPlpfXG4qrlly3RT40p2djWDRBnzCr72eaSxBWHkE9rUgvC7FVVgh3wqAXqMiC/i7pY0TulEkzR/JOO4oycxvupggLrxfs2InHaS7afSRoZUmxA3ug2mB97dWNd6BKxCPl0i+6dnm81h+6HmP8eCKkBiZoN6IujeKDRdib2UxvhlGNcrMhJMY7jVrRVP25O1RNcbU7nQ8A9wc8fA765LWBOtJMYdxs86z065oxO5c31ijwO4zhp4YAA5A3azJhsYHyAMwJsKuw50nXhJmfIRMoDgFREXPz5SiEUzW8i1+AFEQZ9NVw/v390/acd12LpHDIFFtRfIMBWAqJ7jTYivey77IyDvOogIymtAgBhbMpJMUOfWV/8JTyMv9yoXsaZpU7CLo4mQaeM4yNHRpHp6J9+N4TtNjozjr9GZvIh0TxGN4a
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a705285f-9cb9-4f6a-fbb0-08dbf8017d29
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:22:28.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOe9vr8T37NfQYAz/s7kQyT3PUs28jC8nfpll7LhFibgiqAhvGAQ4Bhdey7t0PYSraQFccTJ6i8QQtuiISOWng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080126
X-Proofpoint-GUID: 2I6nPi7M8Jlc0O5lMHaAGFhi2G4xTPhz
X-Proofpoint-ORIG-GUID: 2I6nPi7M8Jlc0O5lMHaAGFhi2G4xTPhz

On Fri, Dec 08, 2023 at 10:01:29AM -0500, Steve Dickson wrote:
> 
> 
> On 12/8/23 9:26 AM, Olga Kornievskaia wrote:
> > On Thu, Dec 7, 2023 at 5:27 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > > 
> > > On Thu, Dec 07, 2023 at 05:21:50PM -0500, Olga Kornievskaia wrote:
> > > > On Thu, Dec 7, 2023 at 9:44 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> > > > > 
> > > > > On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
> > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > 
> > > > > > If we have rpc_gss_sccreate in tirpc library define
> > > > > > HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
> > > > > > errors.
> > > > > > 
> > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > ---
> > > > > >   aclocal/libtirpc.m4 | 5 +++++
> > > > > >   1 file changed, 5 insertions(+)
> > > > > > 
> > > > > > diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> > > > > > index bddae022..ef48a2ae 100644
> > > > > > --- a/aclocal/libtirpc.m4
> > > > > > +++ b/aclocal/libtirpc.m4
> > > > > > @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
> > > > > >                                       [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
> > > > > >                            [${LIBS}])])
> > > > > > 
> > > > > > +     AS_IF([test -n "${LIBTIRPC}"],
> > > > > > +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
> > > > > > +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
> > > > > > +                                    [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
> > > > > > +                         [${LIBS}])])
> > > > > >     AC_SUBST([AM_CPPFLAGS])
> > > > > >     AC_SUBST(LIBTIRPC)
> > > > > 
> > > > > It would be better for distributors if this checked that the local
> > > > > version of libtirpc has the rpc_gss_seccreate fix that you sent.
> > > > > The PKG_CHECK_MODULES macro should work for that, once you know the
> > > > > version number of libtirpc that will have that fix.
> > > > > 
> > > > > Also, this patch should come either before "gssd: switch to using
> > > > > rpc_gss_seccreate()" or this change should be squashed into that
> > > > > patch, IMO.
> > > > 
> > > > I can certainly re-arrange the order (if Steve wants me to re-send an
> > > > ordered list).  I attempted to address your comment to  check for
> > > > existence of the function or fallback to the old way.
> > > 
> > > A comment that I made when I thought no changes to rpc_gss_seccreate(3t)
> > > would be needed.... But you found and fixed a bug there.
> > > 
> > > 
> > > > I'm not sure I'm
> > > > capable of producing something that depends on distro versioning (or
> > > > am I supposed to be)?
> > > 
> > > I think this series truly needs to check the libtirpc version.
> > > Otherwise the build will complete successfully, gssd will use
> > > rpc_gss_seccreate(), but it will be broken.
> > > 
> > > Grep for PKG_CHECK_MODULES in the other files in aclocal/ and you
> > > should find a pattern to use.
> > 
> > Yes but I won't know the version number of libtirpc (version or rpm
> > package) for which to check? It seems like libtirpc changes needs to
> > be checked in (btw I'm assuming a new version would need to be
> > generated), then (if that's it or libtirpc version and package version
> > are different things there might be more) this particular patch could
> > be generated. Isn't that correct?

1. Commit the reverts to nfs-utils, and cut a release. This enables
   nfs-utils to build everywhere again -- it addresses an immediate
   bug.

2. Commit your libtirpc patches, and cut a release. This fixes the
   ABI issue in libtirpc, and you now have a known-good library
   release version number to use.

3. Update the libtirpc aclocal check in nfs-utils to use that
   version number, and commit the rest of your fixes. This fix will
   then appear in the next nfs-utils release.


> > Steve, I could really use your guidance on steps to be done here.
> Again... The versions "on who is on first and what is on second" :-)
> Is not an upstream problem... It is a distro problem...

I think distros will be less likely to upgrade if there are LEGO
blocks laying on the floor that they accidentally step on. And my
impression is that distros want the config to break rather than
that hidden bugs leak into their production builds.

This is clearly something upstream can flag, and we should because
otherwise, the breakage can be silent or frustrating to debug. This
is a security issue, really, since it directly involves gssd.

I mean, why bother to have all of the autoconf machinery if upstream
doesn't care about checking library versions?


> Let me take a closer look...
> 
> > 
> > Thank you.
> > 
> > > 
> > > 
> > > > I think this goes back to me hoping that a
> > > > distro would create matching set of libtirpc and nfs-utils rpms...
> We do... upstream creates tar balls... distros create rpm
> that have requirements for certain versions of things.

That is typically the case. I'm concerned about the few times
it isn't, or if there are testing gaps.


-- 
Chuck Lever

