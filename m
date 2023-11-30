Return-Path: <linux-nfs+bounces-230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D57FF9E7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 19:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D64FB211A1
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE3584E3;
	Thu, 30 Nov 2023 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8Y+UiNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ftkGoddq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A044170B;
	Thu, 30 Nov 2023 10:47:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUIjrue017709;
	Thu, 30 Nov 2023 18:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=8tygxHGwlX0U/EnD/tWJdQcEiEFe7ahq6LWsoXUpYgA=;
 b=m8Y+UiNpi7QUmHSS8zZ8cr6432FEgKCk6p6j+dqIDYZKILCpryifgqMq11d4kt9W1kZk
 EHDB4qOjSMs/LYykGCwaDkLhwGVlaSFFpjsV0xZ0dEkIiNm2xGJCll/3Rq4Byx57uVYV
 a7fXJDFEYF2BURO66M1jenrtIM/wpHNi6thqKyCai7x/odLM0vv3EO/yE6WCraVgAsra
 p0OwQfbncAxJWJ2Edrdqdc1XQ6aD15P9SeAPpy12v98xEal6bicM8IGzgj76mrYCxqoN
 qhKmt7PBgDr10gH4U2UjkASXLly1ZRHiyQU0QyTf+wazbdlpF4FnaNPFqihyLNs+O6kH oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upyfdr22x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 18:47:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUI2d3G012746;
	Thu, 30 Nov 2023 18:34:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cgj6bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 18:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq6i0g+njU7wUEMWMgIdsj+/15l3Qpe62nQNnQYOWcl1M/tFOKhRprhxMkzCChDLB3ACgnYWDTT/wYz3DjPNOj8/NHQLWe90XsJS4lrKQirkWHptqZjBI8qYEpbIriwW5UfGVY4c7dJ5YlZsw38zxS5usv0h0lRc8PK3O9okeI6v1z3boaNYgkJdZJ8046BhL4KFsLaQgh4YXL5mx5/YW9N3MyGMe6Fa5x2XpaN1h2YZ3fqqrgHMtcCr2MtuhAfskjBZJ5UY9PVzyoC9BmSuH/uUvDhxhQgaWOHSzC3KjWP8iIGg9mZBo5bKteLB9F7B586obrWZf7f21mYPF5l0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cnqfag+hzWnEZEgyDewxW3K/93GjDhmDiX0X4x2QI4=;
 b=ipFmtKQIczUTQQme+bntgKIo35YIj+SAAfHEQ27vi4/tHtnzH3+vPzcQ2UXou3Ek04IwvfYDJOl2jBsC9hotDYu4TUibFZoRVkcOAAPNmTU9VEN6/hqjU7wXTk0F6dcwG42f/4OgjLJMpAGbdQPGirBe3fsY6t3NPPbFlAowFLZ1VsiN/RLGucuBvPJpdNLBxLeoAgz6Ma+MMN1NlYJhN1BvJj7fpjzOcIXhkdRngof+O2TnJSSrXzqsmBWxlEQHBfGcK/4sRsEK8tzOfrwdTCVZgqYrjPW2HwQpFruEET+1bEA/6VQ68TpTohhnvUaiCfrA6u/L9IoaE/MKyo2jQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cnqfag+hzWnEZEgyDewxW3K/93GjDhmDiX0X4x2QI4=;
 b=ftkGoddqp9vTCL6m+w/1o0+kOIJz597uzpOJixmsepkc26payfewQe+HJoyXcHQeicTjv6nktkKsUhTRbsdH3BlikfjA5Sxq8H2lZTPtP/vzAsKBbtNtu3mGzlK/FkM9l4HYUf47rYS538+5srCUuDhXyOL518lBrDZoP0NNJfU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 18:34:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:34:43 +0000
Date: Thu, 30 Nov 2023 13:34:40 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v5 3/3] NFSD: convert write_ports to netlink command
Message-ID: <ZWjVwJ5kv9C2s9kg@tissot.1015granger.net>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>
 <7b21c962c2a6c552c9807d6f382e1097da4ba748.camel@kernel.org>
 <ZWhcc8384pf11sAu@lore-desk>
 <c87becd9af15ad9447030c17dee9c481a8d25442.camel@kernel.org>
 <e85381f3d7575d8784f54c5a3abdb60be190c4af.camel@kernel.org>
 <ZWjI6ppENVu2FPIo@tissot.1015granger.net>
 <0eaec872db97e1b7366fc2b673484358312404b0.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eaec872db97e1b7366fc2b673484358312404b0.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:610:cd::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e2b1ec-955d-44a6-5c98-08dbf1d30587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QOnCYIytkstkGhNWCi21aBRE3V9FFyouxmt/ftidaNRkCwrbpgGj3CQ5H86vJqhXWJ/i1ZnSN9FalPc3OrVF7yfdB6WcbRAhATAqCjYu73VSsF7Uhf3XYVZlGr4dvn2rSJI4yCOmrdUSFw2zSm/zTmuQsNy8LMOAA/EuMB3HGW5ZWMoGdue0E5Ou6hpuU62GgVj3l8i+beOlnCj1/T6xvM3l2G7lMxRJzTRM4ANDSuavJZD1xLE03l7GrfS27XyLBK/XawDMkJ5bN+4rx7ZEoZxO/VEc8L/N9xwrp4l4sfIFMZlBz8SWYMbsnSxBAZ6+wlfXDLpvYWYwXiBLOXznyCS61If/BlQ4UU7qDKUWRl96G+3TBGIfg0hLkckP6ey5f/dxL15Yd1phEoo7fU1u6WAK0oEfnP980IotUXC39U/1y770+aGzxoNMPiuRmirDChLyB0BOw8FUuPdPdlhoUCbjQAfRgFnBu3OH/KgKLzl856poKo6j8VuVRH+PSM3fG+4qK3ykGkumZzVN+7ry2qX6+UwCSPp370GRyGxDhVJZhRJ71aVazUdZuIVFOYy1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(9686003)(83380400001)(26005)(6506007)(4326008)(44832011)(8676002)(8936002)(41300700001)(5660300002)(4001150100001)(2906002)(6486002)(478600001)(66556008)(316002)(66476007)(6916009)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?ngCOgccZgG/ciWBWdVgwzLD7L1LXSfrumaLR39Gdr7ZUVNisoCsJ5p9F8t?=
 =?iso-8859-1?Q?zj4fqYWU2OZVvPQDvX1EcnmBV4BlafAdXJP9ZD2kkGQHJ2laBX5wLfby4V?=
 =?iso-8859-1?Q?efuBoMUQdoG2ucQKZzbXOLxZlnGaMkjmElPCb1hBfaLxlH74KM7tXDZaTa?=
 =?iso-8859-1?Q?Os1oiryJkN1VuITogHhJpdC60aqyFAD49/yn8XCCWp+HcWWs3HKkot6mzN?=
 =?iso-8859-1?Q?d9Y3FOkP2fQkJHaCGcW3h+JDaQyV1PblHjsDjJlMuEyBM6Ug8MPeNoqXYo?=
 =?iso-8859-1?Q?Qmc4rNi/PVczOgAHhUCwmZ+J93NArmbrl7jp9utqer4cvY0+lkPKka4dTA?=
 =?iso-8859-1?Q?DndYlk5K/w1gNVlZs052yHTxlttjmF0e9Wd9qInEKKHXOPqpITxMMwh6A6?=
 =?iso-8859-1?Q?y+aJhiccQNlyTOxKvsWesfFysG9L7/VLK7bfrsqwbQ1TrFAAKgZLZN3gc5?=
 =?iso-8859-1?Q?OvHB739EHKkcVNsz9FA79AY3vmABs+M5pFPnR7pW4It7l+lHqPZxf9Vu0b?=
 =?iso-8859-1?Q?051gcerlL10jCB5641PuDb9IP7IX/ZFyyAkyIB4VDUK0iZrcjpg+2etfDT?=
 =?iso-8859-1?Q?4BdzTocIPkzHhPKUR1q8ZD9W6MxjUFBeigt6wl/9EGFnoy2mGrOf0ENC1A?=
 =?iso-8859-1?Q?I6mWKJ3qIwm7JkyfUUzWuihswMpZHinn0iAI6eP7hBN5kldpk4o6vQtYF/?=
 =?iso-8859-1?Q?6DjfHhV6usq4/g1Nu7si9Lt4+lvr+dv00tizC601yqlE19Iq/KUC/jel5Z?=
 =?iso-8859-1?Q?zmyfAdqBjxp4gBgMuNPbUbfWd47LUf3OcE0wyqWmYdCisVtqIFX75vOaaG?=
 =?iso-8859-1?Q?PgD3Py15857nuOKWXw28WBWnsgatum0yee3vOZWEFD9KzTYtoLNDirBr87?=
 =?iso-8859-1?Q?vmMN4GzjZQMwxwB7X90vw3RiN7newCnI8QZPNVW0EAmX3F9sTtbEZ+iQCY?=
 =?iso-8859-1?Q?HW8kv8eVeUck0K6YIS8MAFWQbuICzv3pqE0p+xvrNDJawUYaTVbyQ4Xwex?=
 =?iso-8859-1?Q?JI4j+q/myOYeoaQm0wVvlwgIkoM/adT08Qe+qVYXIIwt1RhOAg8tK10jBC?=
 =?iso-8859-1?Q?5JhFhW/sN/bRoOWkeUSIw301mTMH7Wg+BqV5pq3IQPd4/tb1cGD6PwKsEL?=
 =?iso-8859-1?Q?D4Qle1Mwfw2tkZe9hGuwxQAqQOqO8qdHj/5v5oc6lLLmfDU8uaz2WamtIR?=
 =?iso-8859-1?Q?W5U9GlStAjxmQwFZmTWsd0jSw7ERWH+x4yIk0zb/2ETB5tmzP+fQPFnsMi?=
 =?iso-8859-1?Q?p+JFVE28E79Dd9seQOfz20k6j3anNKyBqHdBsnSXGfdc6EYyzkXYazRFHf?=
 =?iso-8859-1?Q?/3LiGJhIPB/bWoeqsu1VuTxJ5V6LA2Ngn9nQROL7/sjrmBFxqCX7xR4B3C?=
 =?iso-8859-1?Q?295WosYEY07kBmn66UInyS1ClDPYjjWoT3b0dCNzYkTSa6/Wz+Hbmvw2hX?=
 =?iso-8859-1?Q?M6MFbpSN7stGJNCho1HP+NpbLCNngRdsEWmw1a2A4iQKQUCMX0POL+Pz4E?=
 =?iso-8859-1?Q?D26KZfW8AHnD8Oes+t56wIMf6344WA0gVbSydhAwzsyx/mXVaz08W9jMLM?=
 =?iso-8859-1?Q?0WlZoFbHobkecUCpdD4A2Yyimx60FVqXOoun0FObrgTbktoASLbY1eOKCy?=
 =?iso-8859-1?Q?g+rlh0t+411j0KMCEXU6JOQm/vhwgnQhAEdlIENNt3zsBOjTT6H6hZAA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pZCdgQZgPaqalTbyGX0vWyBEhCD+LjvbxMmVGhp7bVHNjmpUlDVMq0xAiwpebGNHkEK3tPhHjfVS81qpYhWcklrRDLLb0FmU+MEafyo25E9b1KQbFKQzQJkKu8zJLZ4iQKNDq4sU6wTtUAHGRxtS8kMarinwpqwGFV+dQDkIuvvyVk7mYF2JKqUkuvIJztZETyMVPL9FVIWxXvyT9KkSjlEvr5Lk9VSoYz8oCjRkaC7OsHAaOi44DRDkbTyvMhSNA9Q1zk0xRiSMrwLHu+kJyHF4oMcllkoVWDyozsQ+2/id04a+kucpUjnlq/Dqn6NSyKJPZaz3cBPmplps48s2QKpsf6C5v4daiVJkn5HxLUk7AgkPAJ8C5E5V8i+zp3vGiiXBsJGvZmYTkDX5Own2vXhjXI5y79VB4dkJELxXhbhmzbPr2vaD7yyE0wHu9zzBnEbKldR03Kynt0kxgyoQUxVQn36JCwbjvHLUwaeLtJa4Bbpd+XxM1RaajJEwhu9Ahuvi2PCexEz3S7VcH4FwGmAydugKIrJ71NYreEfdIX0RHxryyD50GTf5743NtK3wo2XVoKZfE9fFH2iyGZ68P+yonYvRqB8AcfXin2URrV8JvCON5XwCTJ3sC6B346aHiwkIeZmHqlApCz0X78D1jl3Ix9bmvyEUApN2caPO3ewIThE61EP0ATgtz2KDA74IjYT6bX1TUwLDPJLfKkRD18p+9+9l6rEMtWp6m0zNsT2jHX7B8CwXBDvhwNCvc+f1qg0FZIJHhJcjAw23Kz+irxrBnjNyB57hNHdPki7BZXU9B88rj+1qp4RalzFaUf7UtH/4+2ZGR01yQj3y7bxF5A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e2b1ec-955d-44a6-5c98-08dbf1d30587
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:34:43.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWjJjAoKdKoAXrqdjKNVwwshT263UUHuekNTBEpiB5EkZ4oNf9mjo1V9LSSwznpJJA8+yWTcTeM2/PO6Y9yqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_18,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300136
X-Proofpoint-GUID: PHeKgNg0K2GC5lVBEW7gyYDXg1J8Ka1Z
X-Proofpoint-ORIG-GUID: PHeKgNg0K2GC5lVBEW7gyYDXg1J8Ka1Z

On Thu, Nov 30, 2023 at 01:01:14PM -0500, Jeff Layton wrote:
> On Thu, 2023-11-30 at 12:39 -0500, Chuck Lever wrote:
> > On Thu, Nov 30, 2023 at 11:55:29AM -0500, Jeff Layton wrote:
> > > On Thu, 2023-11-30 at 11:22 -0500, Jeff Layton wrote:
> > > > On Thu, 2023-11-30 at 10:57 +0100, Lorenzo Bianconi wrote:
> > > > > > > 
> > > > > > > +/* ============== NFSD_CMD_LISTENER_START ============== */
> > > > > > > +/* NFSD_CMD_LISTENER_START - do */
> > > > > > > +struct nfsd_listener_start_req {
> > > > > > > +	struct {
> > > > > > > +		__u32 transport_name_len;
> > > > > > > +		__u32 port:1;
> > > > > > > +	} _present;
> > > > > > > +
> > > > > > > +	char *transport_name;
> > > > > > > +	__u32 port;
> > > > > > > +};
> > > > > > 
> > > > > > How do you deconfigure a listener with this interface? i.e. suppose I
> > > > > > want to stop nfsd from listening on a particular port? I think this too
> > > > > > is a place where a declarative interface would be better:
> > > > > 
> > > > > Is it possible with current APIs? as for 2/3 so far I have just added netlink
> > > > > counter for current implementation but I am fine to change the logic here to
> > > > > better APIs.
> > > > > 
> > > > > > 
> > > > 
> > > > No, I don't think you can do this with the current API at all. I
> > > > consider it a major deficiency. I don't think we want to repeat that
> > > > mistake in the new interface.
> > > > 
> > > > > > Have userland send down a list of the ports that we should currently be
> > > > > > listening on, and let the kernel do the work to match the request. Again
> > > > > > too, an empty list could mean "close everything".
> > > 
> > > Another thought: should this interface also report and allow you to
> > > specify the address to listen on?
> > > 
> > > When the write_ports interface was first created, it lacked a field for
> > > the address to listen on. Later we added a way to just hand off a socket
> > > to the kernel to pass that info.
> > > 
> > > I think it's possible today to send down a socket that only listens on a
> > > particular address, and you have no real way to tell that with the
> > > current "ports" file.
> > 
> > All agreed, but listening on a particular address isn't something we
> > need today. (Or is it?)
> 
> It is for TCP/UDP -- see the -H option to rpc.nfsd.
> 
> > Does the socket-passing thing work for non socket-based transports
> > like RDMA? I would think that mechanism is legacy.
> 
> To the contrary actually. rpc.nfsd almost always does this today unless
> you're configuring rdma. But, that was just a convenient way to do this
> with a fd based interface.
> 
> I think with netlink, we just want to send down a list of
> (transport_name, sockaddr) pairs and let the kernel open and close the
> appropriate sockets. For RDMA, we can just fill out the sa_port field
> and ignore the rest.

Agreed, it would be cleaner to handle all transport classes the same
way and eventually deprecate the fd-passing mechanism.


> > > Should we instead plumb a complete struct sockaddr_storage (or some
> > > other suitable address structure) into this interface?
> > 
> > How difficult would it be to add this later, when we actually have a
> > specific use case?
> 
> I think we have one now. rpc.nfsd passes down sockets to the kernel for
> TCP and UDP listeners, so we need a way to send down a complete sockaddr
> for the listeners.

If we have a usage scenario, then it makes sense to try it now.


-- 
Chuck Lever

