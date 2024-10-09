Return-Path: <linux-nfs+bounces-6974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F546996D57
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6BB23FC8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617D199926;
	Wed,  9 Oct 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQtNW6By";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zMSTKle5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4B190059
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483082; cv=fail; b=M67EAH2gxD4YX2FnTdls+t+sigkFfIYjRAU3u8fogn5v88T3QiXMAEgT9DDtAVlTE2/YOidLV/Otb/JuqUcDa8tXeeFfNTHomqqmG02HUamasMzyJnFRUrjCFi9h5fgPMf6wUwKhU/6viqCiMog7XcUrgF5nGCT/YJCJMf7B29w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483082; c=relaxed/simple;
	bh=iWppk4mcTXnbApFOg71ltaefBpz5NoZXn+0TtjHhcig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qOMz4jU3PJd8c0w9FJYfZohInewe1Wktvj+y4La880DvQ6FtS8NCEyDuO+yj9L4jRIee+J8wQB2mIUhfxqb/hyc904kk1w81UE489OQZ+K/JTGmphYZ5QOELkVlHYMOJgPlF3QRIuuHB/STaP8bt6ZzB0GZHG+Ls3MQqMEKWSYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQtNW6By; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zMSTKle5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Dfhum022508;
	Wed, 9 Oct 2024 14:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/Fm+RVqqljE1N9mJ38
	v/ut7DRhJu5NU0v//hcoE26no=; b=jQtNW6Byiw0p2MJ9Pjp4d4BpFqPIRsk2Oi
	mOT+v+cM4XtgWZwVm3RyZdOqqAw66OnxTgXlD6oZXxzhIn6HCxehFz+II+IuNsrM
	FFTop8JvD5WlW6xYYTWFW3PHLrSeGlolR6/1UoFg2toBM7N/hFuIo65Do6yXywRo
	R3vkQm64rwzFpk3Rw5m74Va3hvFjFT1kWElud5yEOFhRMxPYkS2I+m0vmRM10wKT
	g2IaJZYFheCPqctyoJrSszfXYTM0SykrYEC1wJ7O8qBxPi1Lp1bAwppmDjmsqK4z
	IVFkWiyM2qt91k2fp81jRApzKmVHruHG5AuKclSiladBOnPF0Piw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e0f44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:11:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499CYSVf022870;
	Wed, 9 Oct 2024 14:11:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8mf5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI0hOkiEcs17lsBc8mF9G0VyllQwDiq16WVFttDbwM/Lb1H/FnuNNWTqJiMjp52ujJGSUiT5kWRWVJqHXKwJyk6QRAdZ/m8bx4uZfcQw+q1rt9zREUc8CDhfTTjCjQTXZbz7auprfYmIEv8jWxIKQDSMozX5ra2fAG3PjkBgQJDpBhy7+7v8pA29etfxCLQR43kDlM9jFEvwHerMBNHQlU9McQCOI/mT4Jde4nn4TwU8QnPAar5jACraUzK6bph/9bC3dwuDLfM5amEURea1OA/biNN50s4WmgmoysyXYNtXbWOoNXbYFEFy+PYzqJ8VXJoiar3LWUHb5jN/+nMt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fm+RVqqljE1N9mJ38v/ut7DRhJu5NU0v//hcoE26no=;
 b=IJLvZaEXzeCgYQdBq5rOTIXqUyDIXj/YDPldzQvwarsJ99w/5/TEAH8ZGac7WIpNXX1dqjySPtHoRb+1cQbTMy/VhDLn89ys1GUsewxtlfjkQ3Ns6i3kCi4wL4rbxtJY4teWJNyuF9YK7EsGaCyqDUD/ln9wR1KurSAmrpjD9OOnTh/JFVlJsn2xQ/8JV7xXsxiCnjPvq5CABvwGF6kA+qOzbB7g57Cg5UNJFArnW0p8RVvyBu2pGHjxPsnT+rLhBgiQgq60nVnKfjtKIggskz2ld3ho+MzXLFnvkrWjZ5GxewVvZeLDdLazFc2U0IlKgJG3NFJgVHHcRlkiLcQniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fm+RVqqljE1N9mJ38v/ut7DRhJu5NU0v//hcoE26no=;
 b=zMSTKle5mV9gBSPxgodTIYvLtGGEEqudVyUd6OtRbZt+vHevtcWQu5mq1l5R8WMjvAbmoYXMckvpDct3w7wGWYYPECIL7grfTv5YcXH2vE8VTobICun9cnAqjoLop8Q0qPDahB5NbG9JXNXXs1n8w3PhaVRYVWawdbfRo2oVuGg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 14:11:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:11:02 +0000
Date: Wed, 9 Oct 2024 10:10:59 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: "cel@kernel.org" <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 3/9] NFSD: Handle an NFS4ERR_DELAY response to
 CB_OFFLOAD
Message-ID: <ZwaO8zsaHrhnUJef@tissot.1015granger.net>
References: <20241008134719.116825-11-cel@kernel.org>
 <20241008134719.116825-14-cel@kernel.org>
 <172842446733.3184596.10111637311114452090@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172842446733.3184596.10111637311114452090@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: cf935a14-efda-40b1-db7f-08dce86c34b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hfgM8t2ZR7qemoJa75cqdhT/8b2C/ukdmTLIc9FfdXh6Zgn7UhH7PyglXLRs?=
 =?us-ascii?Q?tfs3sDEeBiSdj5OnHEP64MiqryeDJNS9UgrLNIb/jreeS7lIK/V90/f73tHf?=
 =?us-ascii?Q?IuWQE1Uwldv++WP9goy62865nJeDBJF/WH2bM6kiSo0n1WxPekeM97mwpFli?=
 =?us-ascii?Q?FLXjcD+cFixnLv+ji0tWCofEqhiWAMTjgsQ4h35RlC0nP3Sdmsgtd661sDq1?=
 =?us-ascii?Q?0JOsElC+nWnm8ow6B7Cpg0ZZFMBkfH2f99vcx7W16mEnbeL0P+xW970hReuq?=
 =?us-ascii?Q?xAzwcuL6N4+i9KC+SleenaXcLr0XI+pq8Y4n+XsvCkJrSYZ7Z78zJeoVX4iP?=
 =?us-ascii?Q?QLB82Ei1ci5qw6Zxr8k2Rs1hvMV4lWZyzC2ua484VekicWQ8NddVFt/t4x9d?=
 =?us-ascii?Q?QSqmnq2jEXSZVfhXiUqqVbLoBz761qr/B0Qv7cZYA6DR5UrSt6LjQdpaIiDX?=
 =?us-ascii?Q?nV115bhBBr0iP8FS+eMP+4EQXyUsDPv/JoFlyqwK3N5fuBVLELkPVLv+PxDO?=
 =?us-ascii?Q?uswuxLaVITD9wXe4cEPcsBcQXCteGsA/JYiQaFg7ov22GmzUS/FWjt35oRvd?=
 =?us-ascii?Q?mKcbKMBedZnNb1xHS7YCi1nLbAxPSoyip0K8bCbYPgNvzEQ2+eZd+JcLnDn+?=
 =?us-ascii?Q?JBrBnQF1bmDBGtr6yTvW7P1uG2k/fJSQc2U9PgBnHWbLvDnsSwQ8YYk/wIWI?=
 =?us-ascii?Q?9hKSwyql6F652EZIguV+rf06HfN+7mWycdakkBnegd74K/KPs7hnZYGq+zFh?=
 =?us-ascii?Q?HuPnlmJFokAjq+dNjO5fgVEFeTC6EKES4Yo+Ic46ZiDn92b2ifHTEzFjf3c3?=
 =?us-ascii?Q?8bhW9RIo79oM8xHWssVwAMnY/0ExvT3U8Y9rE+mHQB/ksMIfhyP1M9ozOxdx?=
 =?us-ascii?Q?AP6j7t6vYdfUdXBNrjq55/PHo00ty2SA5JyZZn8/7D5f/qaHZiNC/y6EGJrt?=
 =?us-ascii?Q?O2waypNh5fkEN+oolcUuYu8OZUzCcGPrX7vDcrkeRVlC6HdAefz10x+TSwEu?=
 =?us-ascii?Q?67UX0I+VCHBBfmeT7Y90FX4ZaEOYP2rTIgPWNL9EwwPBPiEe5vyx8j3px3pm?=
 =?us-ascii?Q?HyqpaVKDbWBoR9Tj7Mouj3dDqLcEEpfkjbaG3t9hIHneyR1QLup6c2unorR6?=
 =?us-ascii?Q?P48MYpLWRBqcYGWq5CJvQJx+OEIqoQldUk1SKh9+cc+xQDF4+zUb/mK7a1M4?=
 =?us-ascii?Q?liU+/5afb+4nMtuMp0ZYY8cEX9n+bh6Ct+Iptb1PxY+Pg0AdyG43Y+KbxwZS?=
 =?us-ascii?Q?dKrdu1WE0s5/f0zZ7F7VlkpmMBFSkiZVWng/jgU0jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgEY4lsjps2yAgOolMYpro7t+BXhUJ148keRD+JnsuxrALViisjfXpo9UJac?=
 =?us-ascii?Q?TCZ69xYPV/+vtT8boPXKhl/BuZt944AnVnPSoUnMuzSpyEsr9Fs2p7P01MRU?=
 =?us-ascii?Q?6lvu+0kdeMbmVcq1ekgaRmnGteseMjA2Zwh+cotsjd6Kqz6NziVUaW5jNfMJ?=
 =?us-ascii?Q?Fwi6yeAEDJbEI18DI0nI7agAV30j8B7PAF4xLWcMXuAeNdGv3boDu/kYbvpw?=
 =?us-ascii?Q?6F4iA3haIZwlFAiRcBLp21692rgagQRaBDW4l5Lqv3IMdanbZipo/lrDBtIp?=
 =?us-ascii?Q?AHmU+S1LHK949HdGIQm6ewwdwALC0RA36E/gFbyPEyvo59KcMxdEZSqeGlr3?=
 =?us-ascii?Q?4hx9upqVdyN9eIiqck7KRW3Y+uGrPEBzNHpEa+8F9SZ9GZlqg7Au3Ew8eIV1?=
 =?us-ascii?Q?eCZGOkIUnC6YYBdvp3mFkPrCyUy+RWdvJ0+N9LPmaVWKgTd0Lmz0KBw5J2YK?=
 =?us-ascii?Q?OKpA0tbORwx0v8k7fXY6zq4cfyOkMcaEugv81HiV18ciG7BhliQzk+UT4rFy?=
 =?us-ascii?Q?q1BKH7uERnV6HvlCq6iJPepeXsXx9Hzy9MuQ/gRvD9Iel+hqNdhUH/wMLJSV?=
 =?us-ascii?Q?mEgamZu1UQW6z7VJcjxSR1v/1fkcBmmHelONZgh2bzg06DnM8XXXxgQQVxE1?=
 =?us-ascii?Q?B0ii4aLsNWHSmzwfO3LD1qW/cUnGkEsnWaKz02M0syzTiJBwLgjtvTBO2EL8?=
 =?us-ascii?Q?FkwuJn5y8bvlA0wrq23Zpm6Ic2IdaDi0QarzeBkW6MdrZDesj0mT7f2DEYMF?=
 =?us-ascii?Q?d5lpTY6Dw2kqdVxAnAieLUIDSAvXcrKTptlOVZOxQ2bXEpebCBiSiv9JnLAp?=
 =?us-ascii?Q?qqNduniZXPfXEQsmQ/WZm5gSwmlXeRnJyt29YFbiWcTr+S+8k3z+lTAz0NyK?=
 =?us-ascii?Q?8C78q2WPFIicrvInjvzdC0yXAxWh9Av0BoAYF2nHPM+20Fuiq2hOq0oaEes3?=
 =?us-ascii?Q?2mzHwr9i5X5KjDWLwqeez3e0z+GPPTTNsW5rdkPLpHnpSLjlEGTFVLELaQBm?=
 =?us-ascii?Q?gNiQME9wFUulxTggJIMDGDY67Cl7dKf03Cm2NBDdkx0NZklj8mAixwcdW6Zg?=
 =?us-ascii?Q?xdR5odnv5Y1CqnKhRJNcvwLc3grTOuf92M0misjGTib6XSbbnwEEq0pAFtvB?=
 =?us-ascii?Q?vR/hYB/4k0KNpxq1zj9fCux8IZpJoO55misKqvGUrvd09SFw+paqFh/xqKzD?=
 =?us-ascii?Q?YU+GWn2ywgBK/wwzVlayuU3WUTmM500ngH+aItYrABy/cavFpHDLmu3+FrQF?=
 =?us-ascii?Q?/eCUf0o61OdM9or+fEQ83f9TzSY7F4nEuOjXJbY4/XCzb7rgjEk98HmgvmJv?=
 =?us-ascii?Q?0M0iVf2Ji87OeOV0zKglrbc0vB5uzqIdVSTtFlAzAMAsZCkCH1RkTaNMiA5s?=
 =?us-ascii?Q?RvkrDhYQlC9VJcv6Khg/nx1pPXgjn5SVA4n+mmNvcdJYx9NQH27IqoH9ZwQf?=
 =?us-ascii?Q?1nvNV2HYvckSSmUpSPIWy9/MuYRktdoWo324QgUjFISeQ7Ex7w8kgP+96t/B?=
 =?us-ascii?Q?ZtIsB11YVgdpzNW1kx8cIIuu79TqBMm5lqrbgxmqhLbmuzcxsxbTyEHtMkqn?=
 =?us-ascii?Q?fJaDqpjmM8ybTS+zUDQ69fnNH84/Q6brk9G5mj+1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T6E6E2rhNLwsqxyrrZpY7m259hZSBJj/Zewtmlmz+LJVxOCJdsCP+o1A9VRhpf8b8CQsfYjrbbPEE3PAPg+yIIMgrEyZSYywxASy8inZSSUtMaoSQ2/tHvEf2q1b3PDwXBV2WDV6cJRDcl3QTGspUwKFTKa3TbaEPaN233LGo710je+jR+YdjAKnAWwmSWnA2sPVjnjYiDjknRal6eHtr9wvxSdnph5IfB0oBnpv22toTsZ4skZ9rQigJhgpyu3KFCDI7+bAoT4ijd2XJvBejc6XqxPmTGKkiTBwebOIBC0bg6965tmIi/0EN4Qm7AtREStzKCwZ7XvVC35mg369Zp4y4xXCbPfSZva4ceChTSLiHBHnwkBssjQp7Yrop6wCIofmnCvma47JWTMBgDEYW/j6EId4+aGuv4wBPGLXqaxosMy+XzsvFVttmqcQ/Pfi6+xZnzEyuG/ct2KZgmFF+o/Izv+EqI0DKlTrQPHWHG/5/1j2VhbcZlFgOZaeqKhYv61errlmv6cl/xt31spwqqc0mHDVBUvzZxj49T4ECp5Rh/5n7C1uJbQHRXa6pQJYyeR5YDOXvPTzxzjotP6MnjIAXwW+xrT77VhJO+mrdLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf935a14-efda-40b1-db7f-08dce86c34b7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:11:02.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRT6p3ewE8erGErvbGcXv6NjQWCUjYfbSxrizL5FsZIDd4OEziQc96V3Q3V+XQcYie3rrA0Wky2fgmDN3PC9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090087
X-Proofpoint-GUID: ytWjUv9DM25oG9yjsRWVLd2XSt77d9-d
X-Proofpoint-ORIG-GUID: ytWjUv9DM25oG9yjsRWVLd2XSt77d9-d

On Tue, Oct 08, 2024 at 05:54:27PM -0400, NeilBrown wrote:
> On Wed, 09 Oct 2024, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > RFC 7862 permits callback services to respond to CB_OFFLOAD with
> > NFS4ERR_DELAY. Currently NFSD drops the CB_OFFLOAD in that case.
> > 
> > To improve the reliability of COPY offload, NFSD should rather send
> > another CB_OFFLOAD completion notification.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 8 ++++++++
> >  fs/nfsd/xdr4.h     | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index a3c564a9596c..02e73ebbfe5c 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1613,6 +1613,13 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
> >  		container_of(cb, struct nfsd4_cb_offload, co_cb);
> >  
> >  	trace_nfsd_cb_offload_done(&cbo->co_res.cb_stateid, task);
> > +	switch (task->tk_status) {
> > +	case -NFS4ERR_DELAY:
> > +		if (cbo->co_retries--) {
> > +			rpc_delay(task, 1 * HZ);
> > +			return 0;
> 
> Is 5 tries at 1 second interval really sufficient?

It doesn't matter, as long as the client can send an OFFLOAD_STATUS
when it hasn't seen the expected CB_OFFLOAD. In fact IMO an even
shorter delay would be better.

This is not a situation where the service endpoint is waiting for a
slow I/O device. The important part of this logic is the retry, not
the delay.


> It is common to double the delay on each retry failure, so delays of 
> 1,2,4,8,16 would give at total of 30 seconds for the client to get over
> whatever congestion is affecting it.  That seems safer.

I didn't find other callback operations in NFSD that implemented
exponential backoff.

I could compromise and do .1 sec, .2 sec, .4 sec, .8 sec, 1.6 sec.


> NeilBrown
> 
> > +		}
> > +	}
> >  	return 1;
> >  }
> >  
> > @@ -1742,6 +1749,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
> >  	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
> >  	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
> >  	cbo->co_nfserr = copy->nfserr;
> > +	cbo->co_retries = 5;
> >  
> >  	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
> >  		      NFSPROC4_CLNT_CB_OFFLOAD);
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index dec29afa43f3..cd2bf63651e3 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -675,6 +675,7 @@ struct nfsd4_cb_offload {
> >  	struct nfsd4_callback	co_cb;
> >  	struct nfsd42_write_res	co_res;
> >  	__be32			co_nfserr;
> > +	unsigned int		co_retries;
> >  	struct knfsd_fh		co_fh;
> >  };
> >  
> > -- 
> > 2.46.2
> > 
> > 
> > 
> 

-- 
Chuck Lever

