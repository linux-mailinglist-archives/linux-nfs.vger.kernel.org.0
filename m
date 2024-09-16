Return-Path: <linux-nfs+bounces-6517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135597A59E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8BE1C24CC1
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA615AD9B;
	Mon, 16 Sep 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HL4GmZEC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PsScL6Yq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2F15ADA1
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502412; cv=fail; b=CXq/lOgTdxNaa9T91kI+YnIYHAgnhKPPrke92eHvfOxvMLj+VkMRy1G+SmqAdJoXVajrpdIfLFyIeATVTGyOdKm2iSeElvo27Z/MgvlydxcqIuqtgyBnGcjcaL4fC+qkjnCFMS5wsGuKz5G5HMeHwhGHgEguHmTEJnOyMplNTEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502412; c=relaxed/simple;
	bh=7nWrzhJdDl7WUVVc3e7XJxTKplpJTWXxKRkIPyszM/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kUuF8lyGQtuTLQBUor5gN9YPm2CqHIvYYpy5WvNqeWqMT3y0bzI68UCg4rsCj15Yt27ihWhf5CE/MCaH6gLc7U06pPVPi4aqkV6nfTp8KaauO6xH3FwEDsPdwSTqoHWUQDnIA3W5iEyB3Vgj0+yGdAukICk6Ti/bfxs67nP+3IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HL4GmZEC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PsScL6Yq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMYMS030175;
	Mon, 16 Sep 2024 16:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tOJO9Yh4FIjoJMx
	MqLn6mGQLcIeNPaAOXeBfkK3g4j4=; b=HL4GmZECGnZ9f+tuntVmwzFMKKEyyoD
	V9Kx3/zuZn4RITFITUYGWodcTpySs4XEKerJGpCOVDYs31LGEUfRrrFS2sYjiuec
	HWhTeJq8+TG/wTz7JlZ4q/S8MPeTL6W6O6Im+f7piMItb/hLd5KRKq4oAyhLJEoW
	2Jmi39HMHGmSdre51mMXLVIBIS8QIt3BhqFMR9o039aoP3mk326tkxKpvSrOPyDm
	/+GZ2EYmcA3TgcezTXYbU4mDFMgQlgHdau3aueKbSvda37e+94qm0A+mdAuAs0uX
	nR4u7LQcxL7O29bzpzcxTLqyB++cL4BTjUv5e4q9oFmoIBk+bcAKC/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3bsj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 16:00:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEqeXE034104;
	Mon, 16 Sep 2024 16:00:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycfm8xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 16:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZNBYEjObzzMtZKiM3YyuNwrdMTYcevEbb2Kvi23b/Hv1sQjDQzS/3OYFhtaukNV0UFTwxO1jTX7K8XxzCV22NAe9YgtlcBFQEMlGNygtba1PD7a7i9MSPZSttnFfV1bfbHMyXDgMl+HItPz/nRU4OEtYfLQCbIpEHQPyve50XQjXyUUy07K+NZTe9RAYmeV9JQvn028zJs2rnHsHYIYL8OVtch6IviFLwSpxyLjNKZFmV5sKrtT6YRGhy0L8SDQnaemmadmLG6zebs0fATaY6wailuaq/L5jr5FPHxoyYGM1g6f+urSYYPk6Ct4npdkWOXbY+Twn3AfXUyxGST+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOJO9Yh4FIjoJMxMqLn6mGQLcIeNPaAOXeBfkK3g4j4=;
 b=gHUShI4COjKG9Wf6g08cu0LMOKruJH6HIYLM2LVYkMlhOdLxk/IEKMGjtlj2W2/kBgiJ7Ps9pbhvzNN5QDLLgtrNduXLiWKCxmT6Q9sFm9Eku9MOJ8j6uyp65iqBTwo8ZS2zhqoFTVHRcIh0jVTampy5zMxi984EsB3sh6tgucB5UuqkMMlhmP+PE0JuyX5CX+kjn/u37ehDjd7qpkRo5Cas15QupArCwElBtlSTyRIQxkeY/RK6mLqlIobgqYIsijuS2/mUIzcJkrcDZtHKiR58m0FD+jTDTC5LN0vhL2V8hX7z7exOwF0WxGsWKm47yNYrqiXAR15uzAb7v+vLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOJO9Yh4FIjoJMxMqLn6mGQLcIeNPaAOXeBfkK3g4j4=;
 b=PsScL6Yq3gHJPfDJmzPvc22Mneh2BtPSNloN/CfXlGNmOVM3fJ6sDB07B0bn14Ix5sijra6QgbFRy3ZgpWeZ0Z/+rBV1jHe7oWSj+IGL8UWSEe6XkVCP9rV1gl+WtABui3qVq3koHUf4vy98Mt7Bvo53fxVSgLNH1uS5HtIezNs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 16:00:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 16:00:04 +0000
Date: Mon, 16 Sep 2024 12:00:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] SUNRPC: Convert unwrap_integ_data() to use
 xdr_stream
Message-ID: <ZuhWAX8IrPEHtU8o@tissot.1015granger.net>
References: <9084882e-0fa6-4426-bc4d-fb20e86eeead@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9084882e-0fa6-4426-bc4d-fb20e86eeead@stanley.mountain>
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3618ef-9b20-47db-17e9-08dcd668a05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fWTiOfQaLNSpwaMOvkmfsPitTkIyzoTT1O7UCAtvuVdEe7DMfO0d/7vDp0HH?=
 =?us-ascii?Q?TVQdaEW84xNIujV+JcuhN9Rjv0HkqBsPYAlAy8klXFpTHhaFn6lG8Ay69kOs?=
 =?us-ascii?Q?8FvAw7ze2nPIToqfQlKmFC0vqqQlXmrte8x3Zx6QwaRpMOMDl0qtWrUf2JI/?=
 =?us-ascii?Q?yhwPt1kwzIlXwUsNb//3pxPjaOkcf4CgKnyCyPF/ZPauXkBwVDZBdNTXdFYj?=
 =?us-ascii?Q?PTidkdN3FsBNxuFbz4wgI/7tFnjAPHeLQtuPrbjfqmFrQ7dp6c8LG7Xs0STM?=
 =?us-ascii?Q?vmjePjWquRpBeihJy9lXzdyAsHSNRP98hxiesVpF4WgzzpatqFyhxbeRNbUv?=
 =?us-ascii?Q?hxikMVH9qIaMGCgS3AvwlC/B+DiDswjRjkRDybpf4OhgzTIMb+6XUqjJmemJ?=
 =?us-ascii?Q?MD9+W7C+06gVrtRDvfw5++RD1GY23wMQWiYe15hImiFMTNF1/vn8aAJdrcKd?=
 =?us-ascii?Q?bGfnELQ0bca4EghtSNGI8nFbvlNqZp6kbKXfmDVSdZQP6ImHIFJ8QOPzys3m?=
 =?us-ascii?Q?eiSOSGHTCTv7lvys+JoHVuPsMeRb6Uslb1v3vPjQxCD3B4zKiwr9DCexCzWR?=
 =?us-ascii?Q?25/KNFVH1Vs3k7Up6ZTJ60SmQsL9YMtDW14SARIhm5lc4E8s1iOuXGri/IQ2?=
 =?us-ascii?Q?jNpARziyK7AP4qcE1Gz+34j0viqWJNSLT1wVI1Y5mQCWq/fXSs+gtyxNUX7a?=
 =?us-ascii?Q?9/QjidTxnVXU8JDfC/TlC9Ls8E9PoNMFI8VZMof7QHrVUinmWBBte4i9Syr4?=
 =?us-ascii?Q?VdJ1Ag6ESezzBYJSu+DS/ah/+FRywdgFwy6kDBjO0/Bs5J1GOIDX+hpzDVdD?=
 =?us-ascii?Q?ncIJJJQRcFRw8MCyILzbYAZDbt3ZuBEGb0cTurw7vneSLu2xFFFgEdvdFq+0?=
 =?us-ascii?Q?PbYNtAuBkr5eb7KSzvun0PtnfLsgjTiCUjioxi9D8S4AsnKWkaGhXczuGfjo?=
 =?us-ascii?Q?jaylHrbgBhcMN5oGAhITd+SBQ4hqTJ44aWP7//+qjVKY3htRgEvzL1y1rhs3?=
 =?us-ascii?Q?Bpy4OUq5rJjj3LCHBXakBKrew12/FYwQ8VzaHquTJwpGQHSHWQzE1RMhua8m?=
 =?us-ascii?Q?TvIpa95ZNtgjMeAhtGiVjIl4QjO1rmUuV68BU1BcBh13XV0cB24fMpRNqSSA?=
 =?us-ascii?Q?1emMHfcRCqSfegGoxcy82MuLvi9YRVbTwUKc7BHmazNeTiL99WIytIfd6Aye?=
 =?us-ascii?Q?M3DEVpxwI3OHDkmhY9e2kMghijh77ngpBLni4lqNkGKs31Z5alUp+//xFupa?=
 =?us-ascii?Q?cKiK391rbmbKg1KpkUjmX71e2DM9H2WWnoBKDyuielLRzbk3bSOEkWYHxcsy?=
 =?us-ascii?Q?4nyaNZwigksbkTIfxO0CkIF719PswVTg7byrcykY0sHg2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7mCIJb7Hm5f8SFvGDraiAcLQmGdwAo9Pzz+0Xdirz36FJlPbGMheaoFVuta?=
 =?us-ascii?Q?8MmzOdZG+K6Ni9Rfe/we+K/w8ekXjXl/Erg7cGMtre9DLVhsdh6uRY215pGb?=
 =?us-ascii?Q?Ck+b8RCqtOb59QdOOA1TjvHm7yGOgJGbDhbaJRWpV2zGGk7swaRTOTXcQ+5v?=
 =?us-ascii?Q?7Zx+cLH78dpVwmDdafM3SQrlhLCvE5kSYm4g2ujQoA3zLWQEFJjwauNUg5YG?=
 =?us-ascii?Q?x0jFU1uPOvbikbH9/lPKF6oe8QsBR5tYs8/Yx7fXQmtCaXCO1P2DAzndcAIH?=
 =?us-ascii?Q?75oMwwdb9W58o7K/LrJzdWnrQqslm+1fn3+2mONHeGX3xEKuwpV4ep/MGz2z?=
 =?us-ascii?Q?KVIyHfiSoQPZ6NHd46iTxTK8jxMo95i7L0rVfkHlZLGfqTRv4cWYn5ZZhWI3?=
 =?us-ascii?Q?Jl49Z7WjhzvOXlKnPl52ms3TSA0+zEDevxL/UbybL/2CpQGqR0ClmCOICn2i?=
 =?us-ascii?Q?SOgBdFvhMDcWyybGxU9LlNIl/TytAMbJpGvkw0aIyoiLa2OAP4c9TYZg2FQL?=
 =?us-ascii?Q?0gWqrXwYRyUUotmdI6uhacVTR+Ej10A30UcFprlObZy6XkKMt16B5QHO3jnV?=
 =?us-ascii?Q?lZpiZTssBf867/+w0WzhjrbWq5JipHsv66IfC66ct5xbzp6S7cgTEmO1AbJr?=
 =?us-ascii?Q?l/+mom2YB/PQ20CZLZGqjCVJONB7d3nsGG6q1b6XiuVYgm88N8pLwk4RzBr4?=
 =?us-ascii?Q?/y0h5aK+Uq8yQQVZ0v4mII+0vM2H7cF0GJmVA1c3QAnESz3DrhH5rHOl3wKt?=
 =?us-ascii?Q?Znivx9NUE38oVy0wv7eUH/YbS4+Q6PRhUqbZGfefu1YTU5q36FXm3dIci67r?=
 =?us-ascii?Q?XifKg8ieKKWsk8jPMrp+Q2FquQ6K5edRuxxISWyHE8+aNeHx7TkxDJa5GOva?=
 =?us-ascii?Q?JbxSPhwnf7aaRq8xKKTehSXXiJKUvMg1T8JqL5C4+xx2cYJhFLWGLYESPcGw?=
 =?us-ascii?Q?hgdnOx4waFp1C7AIKQuTiOtsXg28iIAtCnnys9kk1Rr0eg1wP3P4DevDt8Ok?=
 =?us-ascii?Q?Svx5oGU5M1aNm9ymXrDXvmUvEv9naKQD5IkQcb9KwSeJ3SNIxo9FA0zrFPVM?=
 =?us-ascii?Q?ny1CeWfZ/0mhuVeCD5sMvmYjCtnhSlHDJCN4VAzG6gjSGKxlAfqMpIBC29+H?=
 =?us-ascii?Q?U3CfsYnwM5r/sk6SCWKFmUQYNPIJDMwX+HaaUsEW/YJoOPZWl0jZjOv4ULKo?=
 =?us-ascii?Q?f09QKw5s03uN0evBp1I/tiwolG21Mf+TpoC+eIrS4hEKMW4LT/HT3vyUgnW9?=
 =?us-ascii?Q?2r/s3un0okAkva/ze4J0bWeL9pQrAwFhzPmDoTkBdUayxYEK6rR/oMM2No1s?=
 =?us-ascii?Q?deNnB4Nr8Eeoop71szlev3/PilSqAQ/fbhIp9h4HELwDwRtT6ARNet2PpKkz?=
 =?us-ascii?Q?uCWfCU61edMz1NH+TL5dK7CFObP7REsCt3ouz28wkjrrg+SE7AOTxbPCrtIn?=
 =?us-ascii?Q?vcLtkjcT91DHX4rfwKOC/2NdX640CbNMHwE8f7GAlH7qqdlhZbbIG0Htf5yp?=
 =?us-ascii?Q?0EmfM7/+B6Jg40D7nti+vCQUAPmFuT4QavHkrclUDZKJCcgal1OOijEZO4Mq?=
 =?us-ascii?Q?FtrhQgVTBueRmf4XWi6DdNbP8biHth06fotfDP2u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qbm0m0CzhZFtLR33M+zLWKPRq5vyCw2Cp9GFdxA9cXBQxT/d6iKgtuZsZGv6356AqsZCoyo9/1ITVK3jbsHlR6O6L608ymbtrK1ITWqEf0C1Fn9pxoPiNxMDLo5LYRFm/AJgsJDhAe/C+4Dy7AUuH4oyC0jTkWGtwSa+sSP6KfgWV7izYq66UaixIPY/hYfaeKV2H/SORi/EDHv3cqyb2gtinop+23AXLTX5Hnj6XwZCBm2R+//8yttUxmwJ670RLQTNHgLuExMkvg5d+sYU7FNI9tjw19JyOGYg10UB9QseaRh1MUgI4wrk3VsLlvmC8KeTOdr9m+RZlz3/R3eMY2SFktkPefAp4xDPwk9tgCxPSbn6FqKXIkTtMLh2DMhWQOpa9kfZJz3kO8DTsWN3g4cBoU8T9f36OWsF/byM2E+o4cewWJeNsZ7QyWPJWjYk92/H5dv+/IaAmyRw242ptHfZYrsAxFfwm57RxvECpjC9xX26d2hWWL2oP6ftCy2u3PYGSWyDn5bLPflivaA3kRY0HKVFaHi535ONiJRkvjtIOThkekqvwNjrdF5gRo+RAO/koyV2sCWQqDoWTKastB7uenwdU88Vj4guifUsIEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3618ef-9b20-47db-17e9-08dcd668a05c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:00:04.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDtS6ak/JvfR25vv2xmvYSMakptUvpxRsAC5TTMzRCp/eMiG7GrH/xT8Lkawh7uXGedYCEMj+eQ7QYKdd/j2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160104
X-Proofpoint-GUID: 7OA4E7y1UiwlfvRGCmbmb-JSpy2zSNi8
X-Proofpoint-ORIG-GUID: 7OA4E7y1UiwlfvRGCmbmb-JSpy2zSNi8

On Mon, Sep 16, 2024 at 06:14:31PM +0300, Dan Carpenter wrote:
> Hello Chuck Lever,
> 
> Commit b68e4c5c3227 ("SUNRPC: Convert unwrap_integ_data() to use
> xdr_stream") from Jan 2, 2023 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	net/sunrpc/auth_gss/svcauth_gss.c:895 svcauth_gss_unwrap_integ()
> 	warn: potential user controlled sizeof overflow 'offset + 4'
> 
> net/sunrpc/auth_gss/svcauth_gss.c
>     859 static noinline_for_stack int
>     860 svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
>     861 {
>     862         struct gss_svc_data *gsd = rqstp->rq_auth_data;
>     863         struct xdr_stream *xdr = &rqstp->rq_arg_stream;
>     864         u32 len, offset, seq_num, maj_stat;
>     865         struct xdr_buf *buf = xdr->buf;
>     866         struct xdr_buf databody_integ;
>     867         struct xdr_netobj checksum;
>     868 
>     869         /* Did we already verify the signature on the original pass through? */
>     870         if (rqstp->rq_deferred)
>     871                 return 0;
>     872 
>     873         if (xdr_stream_decode_u32(xdr, &len) < 0)
>                                                ^^^^
>     874                 goto unwrap_failed;
>     875         if (len & 3)
> 
> There used a if (len > buf->len) here but it was deleted.

True, there is no /explicit/ bounds check, but AFAICT,
xdr_buf_subsegment() will return -1 if the value of @len is larger
than the remaining space in @buf.


>     876                 goto unwrap_failed;
>     877         offset = xdr_stream_pos(xdr);
>     878         if (xdr_buf_subsegment(buf, &databody_integ, offset, len))
> 
> I don't see any bounds checking in here but I might have missed it
> 
>     879                 goto unwrap_failed;
>     880 
>     881         /*
>     882          * The xdr_stream now points to the @seq_num field. The next
>     883          * XDR data item is the @arg field, which contains the clear
>     884          * text RPC program payload. The checksum, which follows the
>     885          * @arg field, is located and decoded without updating the
>     886          * xdr_stream.
>     887          */
>     888 
>     889         offset += len;
>                 ^^^^^^^^^^^^^
> This could be an integer overflow?

Unlikely, if @len has been properly bounds-checked above. These
values will never be larger than a megabyte or two.


>     890         if (xdr_decode_word(buf, offset, &checksum.len))
>     891                 goto unwrap_failed;
>     892         if (checksum.len > sizeof(gsd->gsd_scratch))
>     893                 goto unwrap_failed;
>     894         checksum.data = gsd->gsd_scratch;
> --> 895         if (read_bytes_from_xdr_buf(buf, offset + XDR_UNIT, checksum.data,
>                                                  ^^^^^^^^^^^^^^^^^
> This integer overflow warning is only about foo + sizeof() to cut down on false
> positives.
> 
>     896                                     checksum.len))
>     897                 goto unwrap_failed;
>     898 
>     899         maj_stat = gss_verify_mic(ctx, &databody_integ, &checksum);
>     900         if (maj_stat != GSS_S_COMPLETE)
>     901                 goto bad_mic;
>     902 
>     903         /* The received seqno is protected by the checksum. */
>     904         if (xdr_stream_decode_u32(xdr, &seq_num) < 0)
>     905                 goto unwrap_failed;
>     906         if (seq_num != seq)
>     907                 goto bad_seqno;
>     908 
>     909         xdr_truncate_decode(xdr, XDR_UNIT + checksum.len);
>     910         return 0;
>     911 
>     912 unwrap_failed:
>     913         trace_rpcgss_svc_unwrap_failed(rqstp);
>     914         return -EINVAL;
>     915 bad_seqno:
>     916         trace_rpcgss_svc_seqno_bad(rqstp, seq, seq_num);
>     917         return -EINVAL;
>     918 bad_mic:
>     919         trace_rpcgss_svc_mic(rqstp, maj_stat);
>     920         return -EINVAL;
>     921 }
> 
> regards,
> dan carpenter

-- 
Chuck Lever

