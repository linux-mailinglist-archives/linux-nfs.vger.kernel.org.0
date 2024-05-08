Return-Path: <linux-nfs+bounces-3209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3848C01A8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ED71F262CB
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19C128803;
	Wed,  8 May 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bXnQbyDj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QfB1/7od"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1648120A;
	Wed,  8 May 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184289; cv=fail; b=e8IxVhxdMgnJPZZHERRmXV1gK4/Aj5n+RQb1Yt86HA11L4YleehGsadE96se5MjW6NKH9mnWuG/kC3lzYJ29pdh1tmoEWLY5u/nkluSaUEJGOdF0oli3eah7mVYBnzr77AP4ffs2EOCGydRzVA1rlw3IlwZyeKBZrHNjVQ4AgIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184289; c=relaxed/simple;
	bh=QbQvtDb5EGdOjKCSo4yT0KTeBOYMd7by2GlcfLUs+MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dggDV5pkwYzGUl6d6gUJSQSvwqk++B8pGkA8+Ch453nD+aiUwOFek+uJlK6/+3pXlDzTZL0GHmZkuoDBZZWl92aId0tumztRpCTey2usmlR8O/5wzDZ+tcbpuUyp5NcjGR+H6TTI/GvymV7uCYZ63A7oRbe5/NHvD0qLIlMowco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bXnQbyDj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QfB1/7od; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CPIo0004100;
	Wed, 8 May 2024 16:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=KkQIaN4IBDyn8VgzDaL+Ar9veLmHGHdfM2pt9yfp+V0=;
 b=bXnQbyDj/2bZQmPIcOBn8ALx6wAqamatjfADqB4XGr4Fl81RayOG178h5y+LVDK1VakI
 6LMXv0H01X5LvnbNkymtlsPpxczjumXutSlcJuK+thNc2xavVVKU0AP6M7/xmeuxiXgs
 EHj9alsjIhKSSQZIAUVOOISOA3IZXPkFdo2TkywKDo9mQ7TeQPLK1Nc9dY8mZTHwmHe1
 qa0W5hWvP5qvfkR1BL93L723uNJTP8WbSBCRfnHCSh0+aJfbsWlIsqgS76Zzlv8l7ULj
 x9ob6xRWqEikb2gT1HUPr5GYAAlGwnb6xlcIcjkg2kpX/BrfI74lu44a+03UPFbESVlW YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv25u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:04:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448EnG5l019760;
	Wed, 8 May 2024 16:04:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkueb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXlUj3TgtX4xoNQIjmZX1rpxs/6QLWKarXx6LiZ6oDy28dMbFLmhIcAe3WrY9R1k4MUa0ihV7exS8VkaoWVKywW7ePoAJb2tTqQNoqKWCD3CBWJMG0tZMaVyk9Nqaz3JntjGoIOeZH3z1N7766cFzH6CCQuOtiGWQ2bZmYij/KLhJV4xIK0h+dxdIJukVk/o3aLb/cAO0eD0cJah4rRPZkL2Hq+N0CPs15ar3LzV6SxCC0uivJmB9n/ChqaUBtIIX2erMTE95GZYqAuY7SQVeOiCrPF0NSMo1fmOXbh19v6gsFVLhHC9Bl0n6wEP7P5HnMzVpV75vN5IKVm8hOJAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkQIaN4IBDyn8VgzDaL+Ar9veLmHGHdfM2pt9yfp+V0=;
 b=E9z2piryiA8IHr6MNfKO06V1+vY61QwPwVyd4bDdoH3bB3ec6DFsmPZXmj32U0iAGZ3VaGK4D2BWrXmoRjUa0/KlsvVCdy/r3cn7HY8h1GuTZL4xFNcePpV2Bmid5PZrog5jnkc1KwS/hBBftRfWNaxlIvZtWEC74SwuuEGRBrAlPRb1yToGdAJ+BXGOQqIf6gBz6GfrWlf4+H3/wLBs/3jGYCIo1jpcgZEm6KELdYqU0yWRfTPvmYQauuxIvJxrGgPYhWOSwLGYtxVziz7X8BFhpPq+lu1nIrSE+dO3Gzll4WLfYAsqOCdumgK93WaFk+de1/mk1hpmobM3au/6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkQIaN4IBDyn8VgzDaL+Ar9veLmHGHdfM2pt9yfp+V0=;
 b=QfB1/7odS74o+EpeBDa/Oo48oJXria3I7zuTWFnj7biyPJ5OqvkmEMe680+m8LX3dOJiSBCea0EP54tzJqrQN+mEuCAkfX9OeQY6RU0PfNLekS3Ul8EYYWSOnCtdSF3ozoMOk9G391Q9A2Wrwq9nzDPbmotTIiSK8cavGzMx/Lc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7706.namprd10.prod.outlook.com (2603:10b6:a03:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 16:04:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 16:04:31 +0000
Date: Wed, 8 May 2024 12:04:28 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v1 1/1] lockd: Use *-y instead of *-objs in Makefile
Message-ID: <ZjuijMla78l+sl5S@tissot.1015granger.net>
References: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: CH5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ccd085-a37a-4eb8-fd1a-08dc6f788bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fhqnP1gYlHGfq6/GaXKtCcFaNMX6AzVRts+mu5EPyB+t2O2wwWDTm5oWbe2q?=
 =?us-ascii?Q?SNy/j/NCpISN7qdnzAkhkqBHEzck/qjQw16sQpEE8Y6dhnIFGBaZUMtIzzAJ?=
 =?us-ascii?Q?GEljoCulWuIgcvdxVypFXH6Sehd7C974cyDvZmzzeLPfYuUAeN8FkZBV4L1Q?=
 =?us-ascii?Q?+Im7KX0SS003059q0RqXuu7MXVLGFhoqOeKcuMEedSoWhnKzYW38IcF0KlY+?=
 =?us-ascii?Q?H3ptJTdoEfKpxZATwmIGYtelJyU3GZkBR5L1/BSDg8axryEzx49iENYuXXMY?=
 =?us-ascii?Q?OgrUmYA6RT8j4fWEBg9CN+2JyTDJnUOEunfqc/Hr40v6hxSfrSoN0aTuv6xs?=
 =?us-ascii?Q?LzLR9h/8YmupxbgfD4C8/IFkLNNakY2cpo1GlRR3nGQbjp60jWWfoiVjwxDo?=
 =?us-ascii?Q?WFMzxRCB3VfmGMFQQr0yFbOqYPE9fEizqRtD/PiYMlXGpT7qGv8W1g3wzbRJ?=
 =?us-ascii?Q?T6VQhstXB/YXJc/+pWV9OWe8/SwluWoB5+CnMGMAVHegJRg1MyiK3+lDpVon?=
 =?us-ascii?Q?IWmnH6bI6upYvl5sDEB98naH6wOPQ5ZKyQrkgrsgKg2NdTAk9Y3OZW1ppRSt?=
 =?us-ascii?Q?gZ3bdSJXWmaAnuGnnCL+8KwyDsvbL/dBmCQnDG3JiG2fcIzWxNEUroYTiHy/?=
 =?us-ascii?Q?xdzKboxM033XCCSfmvOvtaPPdV1hSRvNc4/XX19mbqB0rqb5SpmulHIv6MUY?=
 =?us-ascii?Q?TaRz0RdeHOup1WiCUjZbphS+GvbugNdFc427fAjLvtarh93lO4EmkQVBL8ne?=
 =?us-ascii?Q?xryq9wlyLOH+SuGRZV+GZO5FyGP64+h8bpOChWv/XAjSRByfFc78zG1obGXH?=
 =?us-ascii?Q?bYaTk+JPG94urLTsyx6zFtZhDdXqmdaAIW1hLhjwkyAm9FwrqUwxbEsB40Ib?=
 =?us-ascii?Q?UAlwnHx/ea3v0NBCFJN3Z7AAq4+IKS8sCYRAq4QpmaPK9E9bNLCG60v0uq6m?=
 =?us-ascii?Q?vEaQ75RgydliRK4lCjHKK6t5ZnkNXN/2VvTOtQNw8q3fgAZUOnFwh5Fovbvz?=
 =?us-ascii?Q?xfiJdfms9HUddOViLpmslxutNJusBiACXBos9HxwZNPWzpxa4+UtHO2tGV/f?=
 =?us-ascii?Q?ZSa8e1jSavq5n/4yP6dnVMxLOJzIRKjbsdXAyeqi0Y9RClHQLjCytGQbFi6F?=
 =?us-ascii?Q?qQg2MFY/CTH8udBjmxPIyVpWkAWHfoI7OfXtfwIW8oxiOvCOqFxUPj8uNbLx?=
 =?us-ascii?Q?JeGEnA2cozQ32yMWNjNCQD6oQg7XuGUJfRiu+wZTloOdk3OZOuEM6t681rtm?=
 =?us-ascii?Q?VXi6W66E/cngpmtQlSVe2UJeRkKaOhi8TSjrsjzGhQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n3bBodQZq94hMXz0AZ+8NHw8ZFXnbyyaOFujeBciNSsixfQwd0CN9OU1NRn5?=
 =?us-ascii?Q?hRGDlCmeruTxogmX5Eop3tJvjZBRP8QSdbS3oH13yGBzV7InmWZv6zasUjqK?=
 =?us-ascii?Q?1IEjiziioeudrP6pE1NF6/TcelOtvt+/1te7qJhOz+gsxQXSA6ESVLtYd+ky?=
 =?us-ascii?Q?QKgV1oglAvwtKwwTpT2xFGiqNS6qLGo0sfEPgzww9QikvHNDUlvvSOt2QnEq?=
 =?us-ascii?Q?LjaPlwi9mZMDYBoP+KFKQGS8vs04uxB64juBZdTwUicLez16WMCD1tub18UG?=
 =?us-ascii?Q?5Hlkb4kHsadW3Pzrs0Jzn+puPHUW2993bgumf0KovWr9LPlzGWKKtdfl6988?=
 =?us-ascii?Q?U+otXQTWtoyESjjt6gKnUY7g2TaHAEFotLXjqJSD3WmltAK1raXPcTaocQZQ?=
 =?us-ascii?Q?YLbEbgUtcEUhuBg0pNPQBpKChlaVkWU+HQNYz1P/MlvRC/9BHgcwmKIPmJ36?=
 =?us-ascii?Q?0M4w3oKFDFtbOsf1H3aET44yMZu5EQz3v8Vq5cM7/HkYYHnzGTiV2N0UlNwp?=
 =?us-ascii?Q?qPY8hnKn3nS1Frkyh/hI+ifjMOodX8oazztT/Pzqh6Ia434geoDjdAects8N?=
 =?us-ascii?Q?FJDyeyjyKmSYUrMzwOafV6HAU+KLt8P+Jzpf1oaIPgstyL0wprVlfoHCJ8+A?=
 =?us-ascii?Q?2IpPQ2tcz+Ql8XIzunGYSitXSqJZA8ShpMeKJ4P3uqHu0kkcx8bV5I7SpF1r?=
 =?us-ascii?Q?5qropHoxYsc0CWMJCCoZ9lJFj7K7zjrASG+UyqhlgTbR1jb4tttnVZThpKYg?=
 =?us-ascii?Q?rF5EHTvwVv1d+hCFhbElBXdVeqG0EvPlwWM3fvolAFhLhBTAMVOoQCF+fbGd?=
 =?us-ascii?Q?/mAlr3mZRTGg5Jq+civP/Dd+v6JU6PfSWxn+z/THdlfhKmYlJxe6TRtukkFr?=
 =?us-ascii?Q?UjNXFTv3F+fzTKQoxcO6KOAvQkuw4l0jY52vXEKmmV7n2Unxt4+DJcgydwSx?=
 =?us-ascii?Q?x8YTZy4U43P4CAniQhc/TX6SAv9bhCzTMxsiGC/azybLwiNpY40FU8D/eQrV?=
 =?us-ascii?Q?uTCsekU9zSChaoMNNnIm8y/V/oyOp9BA/b2DT2NmbjyS3stVZhRNduU+gLnC?=
 =?us-ascii?Q?9d21Z7wWdgCsZYa0d1d/azTPnZPQ46Po+ZYhz4FM2CIIXdPKSm+0pafzOlJI?=
 =?us-ascii?Q?CSzrHJgs1lsWh/99r/QVRgvgCjoFzGGDb/qvXxl4y2bN5/M4rJuNN8oGm72L?=
 =?us-ascii?Q?oRgGb0Qo3M8OpuJi93Vs19jU6icbDhqDVaS8GYSZiKI+lWYerqhOhtMjFGmp?=
 =?us-ascii?Q?a2iitFZ2gCNq7OA5zybhvrTanyCfNwr1Hv+B56gNon41tgaNEiAfbHfzxwBu?=
 =?us-ascii?Q?dp0Pi2E0lzld6Ek0eh6jMEGau1GBfOOUZfZ2EVxhttHrLtX1FcYYeJsDPpT1?=
 =?us-ascii?Q?PDI/8Fo0Bc19W3Ch+w3ZdoEkWIzwNryVTAQV3YKjZwSiRm1TitIOILwdAWhu?=
 =?us-ascii?Q?VtfjFccOo/JOHIFLJxX0jsNtTrgoQ2aZVwE81+srS6+roCCGQBeZu5O1eiT0?=
 =?us-ascii?Q?c6LiQbzmteQxqFGBeN3uGH51Fdc572HJgGwuMbmELIuJRZ1H/WqhrsUANjRG?=
 =?us-ascii?Q?CzTnPVwndE1lXT3Y/25kVE/6S+0jEvRdwqB4ZA39rqG99CUSBmDuBimiyJUl?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F9W2dGAK+cBBTXXOOnF0OehFH3t850aXdYo7geixBPgpQUtqa8cMkztpijRXiY7lsfSBM0q3Sn/OeaJPo4sNURVDqLnON8toMYXxyTi9e1+1c1zM35kA1vW9gjRHNRZLRnBJnJIY6DQgAJGV56eIgUTsXvnm4iVUFSO8M/D6jeiI3X7Yu4iJ8UZ+U2TLrf5Ow5WZfFkbFv0i1z75fQWQ3omEikZuvOS+23ZU69AWFnLBeFR9GSeCvnl8qbIfNxTwE1hHgPAHMbtPpCZFCu6koekC0wscXBTpNDI1sR+KsYm/Uxg3OwpjR+I8DwEZMf3+nNGM84F/vqxkWj6eSJ4YMCe/GqqUoOm9pmYaANX1UVOBXejKEIrbd+30Y4dX/ccDu+NI0/F9QzR3hpKxqNxI3LjC26ocPdZr6sgA1FxSs/Uidbt8qu0uH1IuCYPWE+oJvioZYmIvvmea26otnb39/2oz4lh09PHCxBfCQbdAq5hNEBI9bUGlCGeIV8onCaBJW9gyY3N/ojqT025Q5PD0VIE/jQpJ1GYz31jyml4o9I0vgLJeM+2X4rWKgC9ZC5w+tzr7A7dBn9C/XjpqIRi/GWfR9CEPml9XBwdoqextSEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ccd085-a37a-4eb8-fd1a-08dc6f788bb7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:04:31.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4Hfy6KwiOfEqVnjKqdHZ7ddrjzH/qkxux1eSITOGaMCRYX6Mhqyj25yh7mdgGmHSWb3QeTuzMs5U5Sp/C94kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080116
X-Proofpoint-GUID: GOa-uMlidoMDoy0Ryi_6_ZFUPGzuarH4
X-Proofpoint-ORIG-GUID: GOa-uMlidoMDoy0Ryi_6_ZFUPGzuarH4

On Wed, May 08, 2024 at 06:19:38PM +0300, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Note, the original approach is weirdest from the existing.
> Only a few drivers use this (-objs-y) one most likely by mistake.
> 
>  fs/lockd/Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
> index ac9f9d84510e..fe3e23dd29c3 100644
> --- a/fs/lockd/Makefile
> +++ b/fs/lockd/Makefile
> @@ -7,8 +7,7 @@ ccflags-y += -I$(src)			# needed for trace events
>  
>  obj-$(CONFIG_LOCKD) += lockd.o
>  
> -lockd-objs-y += clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
> -	        svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
> -lockd-objs-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
> -lockd-objs-$(CONFIG_PROC_FS) += procfs.o
> -lockd-objs		      := $(lockd-objs-y)
> +lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
> +	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
> +lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
> +lockd-$(CONFIG_PROC_FS) += procfs.o
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

Unless, of course, you'd like me to take this through the nfsd tree.

-- 
Chuck Lever

