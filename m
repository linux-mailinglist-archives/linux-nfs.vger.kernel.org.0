Return-Path: <linux-nfs+bounces-4232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AA91355C
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2381D2845CF
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CFF17C61;
	Sat, 22 Jun 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z2SV5TSq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mPoVNFog"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E03179AF
	for <linux-nfs@vger.kernel.org>; Sat, 22 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077191; cv=fail; b=TTBU4X2a+5Dgy8djmeWoiy8AnKw3s5f3SPlh6QGvp42vLwiOzpTzdCJiP/G5PAkwMZIS/JFV67UfdB5SH2f+0me4as5EtMEGCfbm63pmiH/y03+MuaQ2FFRCID1julhXe8ohDSgcVCK7teWO70DPnQq/079MswUrWRx1AacKTq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077191; c=relaxed/simple;
	bh=OYbZaurs25ov4coA6cHmgMyPzHRSkQQBrNpukQ76zdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RESHqTd2frlrq02PlccBGw7TrlvY4d9XAzG/7vFQBpvZeOUIz58RUCqjsl0zjqNUvNVZKHxQY1OknbpzZElzbQX4Uwi4HFRT3ukbvGWiU4YwX9ThCHtGdZwFiPxmvq1IOPH+xO3z/g64vQpvrSBSVqA39vdXtmzyvME3HKw8sMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z2SV5TSq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mPoVNFog; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45MFdvW5021844;
	Sat, 22 Jun 2024 17:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=WY52xfZGx3oQjFn
	NweydL6b9xopbfzg0KO/qHQpPP9c=; b=Z2SV5TSqxlvQZMUHjbTX28/9QCyvDyq
	yAeDyUSWHqpTgAk6WhjwvZxxgDL1RI9onD5gOy+gUdHaikzM66iduTcQJIVREdxe
	th4ud1nMRyLZdDg3uIKklJb/+tVO4OUyfkVAKgNiWhw4pxkzzhcIUnR5GtpPjO/Y
	/uVlIzqFDuK9PD6SJzITZ3U2Gx2whHLPpI6VtrAOZTnZ0fEr25b5o8RcXndlKUny
	yCgyD8boj/5nh77veSm7iWUDBmOJv4tZzB6QZffRJIk0iIRQbEz0Wxa3XG0G8lTY
	KZIIhmHSX3/tBCg77gAySbbWsoXYe0PaGv90FA67z/DktF6UffUSPLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc0fp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 17:26:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45MFf2qn010827;
	Sat, 22 Jun 2024 17:26:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2axy5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 17:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CneAjqCYEzkE5y2GF0L/Xw7bLUEtDdzt2jZJ/KqUFb2KZy8WpONShodnI7EC/4MMZ/2IKMW04uh/yh0yBNMZ3giGKOzefoJ66ZvhHO5AjjhF/sXa6d76M8dvgAPDpwR5frfsxI3HiBnN1APmB3xDDf3rp66FGf4NN/gXb1vOklIkmbEPahwj6uvPW39oNxAjyAk8PkwWre1UsQ4ZY7x6hAK3IhZySaS3tsioQcKDQxrJ2LR1qjpVPglMICvdpYfG6sjqcVBCYODF/4oEgFExCxJpPEkctmMu3eZhXQbLiiD8G3kCmHR2UiWGv0hTAl6YBnrMFlpJQR0T3YH5kabECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY52xfZGx3oQjFnNweydL6b9xopbfzg0KO/qHQpPP9c=;
 b=AVTDnZLcqN7s3vvygz4X9qqC0gM9igs4SsJqrxmvIEvuoCo/f5WGh3ZAexnsHzMrpDuMta6tKmqMln6nOSgxm5hh+EmQKmiT9RyOTH8MYEQty/9vlYmRfbviINt8FyOIsISZA6DHOB96sK/UAM+1nJDP/9MnO40ja6qpMV1+zecR+3647NRViedYAkd5dB+0OG01CD+OFU9ROsXJA/PLMRLdyUpSO+6Nd1mPK0tWBeL3b1srPIqHjAuUSg3kfasP5TmKW0RUB3uwLfK+IQoLq5pQvVWwijU/9oLd9hLfnQ+g6eEJo50gYBwVH/dlH2QtxZqbCKMBGJbO4JV4L99NQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY52xfZGx3oQjFnNweydL6b9xopbfzg0KO/qHQpPP9c=;
 b=mPoVNFogLmOZZjyx/dPXpvqFjT78i7/NDphRdKzzJg5AangadFssrs4FRsosR8IY/0kHPqKvssEVp7FPIvalVB+iaDx1QfTPBEpUf3dz3+Fq2aqmxJasfWx7tcY8DggdBD7lD4b1o7Pf0Wrl9zKiZkZyq7/i3nWsq5tmtimqJug=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7357.namprd10.prod.outlook.com (2603:10b6:208:3ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Sat, 22 Jun
 2024 17:26:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.024; Sat, 22 Jun 2024
 17:26:13 +0000
Date: Sat, 22 Jun 2024 13:26:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZncJMl0eYOeLw5v9@tissot.1015granger.net>
References: <20240621162227.215412-6-cel@kernel.org>
 <20240621162227.215412-7-cel@kernel.org>
 <20240622050324.GA11110@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622050324.GA11110@lst.de>
X-ClientProxiedBy: CH2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:610:51::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 73edd487-f20a-45aa-efe4-08dc92e06a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p3ocuhPb1VE582l7woJnX8cOADx8VR33zdvk1sKoW9QVEJt5fNswsp49rKWG?=
 =?us-ascii?Q?tUPPfoQggudqaNQW2xmfaD1lJoHRfMPKyi2xkyAHoghtnewVKpRMk9mUrx1H?=
 =?us-ascii?Q?D1kROHwInhoqA+p9PNFWY01MVwjttsNfZPSOn8/yhb4DcJJk+lOAa0cMjes9?=
 =?us-ascii?Q?5FN0F33w3bZdm7TEa9CAMBixd9/9DhdDgjIgmBx2CFbW0aXJbeQifoRIcQ33?=
 =?us-ascii?Q?MzYyI0BwdC8VfjZbbriEr9+iuk8cdmABwyiBtZyEG2rxtNBUvWqZK6g9HvE+?=
 =?us-ascii?Q?57xWllhQnANsg/zCwl7LGl9gGbwscz9CM5e7trs6Czy+uxUFi9JRnyS+kzNG?=
 =?us-ascii?Q?W+0tlp8I+K1QEt/18YymvCiyIwh0y+0t9ht61ddzcgfZOt+LkS8kxfi0TmnB?=
 =?us-ascii?Q?DY1GfFbEhB1tZUwSyuccLrN55HWN364c/iCOkxQoXpkbAW2OzmH8aT6kcti2?=
 =?us-ascii?Q?rZ9HQw8GFcAqEpgkhNLLwq3iuD0rxW50KqXpjwBEc1RfT8+zh0Wef+ixNvXk?=
 =?us-ascii?Q?XhjlOVXDpE/8e2Wy/NDRbOLtxikRaelQaTVgIIuVVaW0DiPq6rnS+njazFuR?=
 =?us-ascii?Q?UM/8iD7EKq6y37gSq0cZOaO4tG69hyPdCxgLiimD0UMApjwwc5FChyZdHMS+?=
 =?us-ascii?Q?TlD5GlFzjt5Yu2/tLCSNBdKzkO83oXQnN+pqdJtkrDyAaUFC1DRQ8GVy6HIZ?=
 =?us-ascii?Q?sklRHFrFT5pkz53v5qyw9wYCHCLAmZxmgdJXxHo5yqF3FRl5FjgTlEE6Kvda?=
 =?us-ascii?Q?xhlTz81wkhRUoRF7YjTu/UadGScHN5G2PY85OVKkINclVYYLtylJIs3LmWMy?=
 =?us-ascii?Q?1jFr1miKCsIMJ8Y30gndn6Z1ctzOYqYhG2KtOHD/HZZcH9ZWay8TOfzEJxlR?=
 =?us-ascii?Q?onfpCNS9XZ8Hj1HQvgnpVwBgFO4rfX+NoqCrtjJiRE4W0ozhFS01mk+RxfAa?=
 =?us-ascii?Q?3YAh6fxkHvh8McwxpPUC8sX+5JIi8IoU9y+6VkbpE+Y/FeOENDucE5usGNw6?=
 =?us-ascii?Q?nOGJJ06JiLrA0VyBQlTdSwEQSlFPdNTFdC5oVuIydfl/ChNAb0dNkNeDQQ9H?=
 =?us-ascii?Q?dHFqPiX98/RKfhkSfvdb3u2Fb/4RjHixa863MqOCkB1CkFvESmGd8tjPmGtt?=
 =?us-ascii?Q?Ar83Dryr4l9vbXPWQ/snZ2+VAjmBfFJv8VUZv2ibfJYSLMf1tzDwZjSP2edB?=
 =?us-ascii?Q?Axw3NHoN+9UIt8wV+52n22yl8Yca9TUHOr77hWPaQnwZY5JKCfh5hFVIm/gQ?=
 =?us-ascii?Q?Lkc5nsrtueqQWB5ibJ2ui2MyFTiUNEMK3ehpDooyGVZVnStTb5cBwz8XIK5I?=
 =?us-ascii?Q?Z6NnvgupCN8Fek+LyvwvXpSf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9GkAtc2zjAYJ+K+ELgYdLiE7Gs5i0u6DWEGprFYo9SS/jmBXEKvpZBe6WeG3?=
 =?us-ascii?Q?AD7w7GhxbGzPPFtjuMCUWSJ0wJoBvfj7YaNTYrvrOXhxL2nGWyaIXj2PlIkg?=
 =?us-ascii?Q?kvPzvUVsJSjXOzHecNxhcTdyXnnNgbaXcfY9yZ6SHTp5yR/nVnVtusagixHy?=
 =?us-ascii?Q?/urAfJPQPg3UIRYnHMiWrlDO+kuA2ByMaqEXAGWJyfKUsYZKVCd+sldeLS7t?=
 =?us-ascii?Q?LR66803PVzOF+jC88CD4iuhYb775kgtqTfqtfNEjB9R4NJqNQOE2R5ZY0NfB?=
 =?us-ascii?Q?hcofvgrijFR/PhJ1lofiED7AXrEyhdv5ShhVEu/7ZFZfDWhVqxkNA99iBgo6?=
 =?us-ascii?Q?GcCLNwiB/uxMKwZoUzIK3MqfV5Uj2S2+IfVFMM98BNT+lwYluC37GJpGk6h7?=
 =?us-ascii?Q?bs98TZ4Go64z6uK770HHAo1ImFuLgv8Vz3DI0hU1NlakvbesiEaCIx2ZBz4F?=
 =?us-ascii?Q?KWBgTluT4idRCnOOz/i2yPpII95sRqsedeKUwp3P4BC3EuwO0wnYfKMs+rf4?=
 =?us-ascii?Q?aQNKnTqBYAnsUBL0tKXgrNtvqqEQ5hGgCrawC3/lGKkf1HGXClv91iNQE4v7?=
 =?us-ascii?Q?5QB4B46PD+BeB37sZxAtwQW9M0EtZCRhPPsAnOBfziuEpruRywr4eNtjHAay?=
 =?us-ascii?Q?O2+dBOcHM/UO1T2Xkc+KZ6LAgpxmzgprsvKRhxNxJ/oDVEOm3pSZWXDVu7CF?=
 =?us-ascii?Q?HpHFw+99aVwbaObYWAos1LFEQcLOcgnABBlFORkoHjFCD2XGfhRWlQDH9U6K?=
 =?us-ascii?Q?P28NuQH+JK4U+NMKE9colvxZdNnYd1XSK5D2ybvewbNpfe4tHv+ojDvpzmjm?=
 =?us-ascii?Q?Pkkl4+xW8jVd5GqCAEEPJFR6LuO+vKITy5E4xx/SA9LeD0vQkzJLtDMF3c0m?=
 =?us-ascii?Q?uU8AlEVyCcQlR2U8f319qZxLOOiMWM1ylrZ8AlAtHandt9y17Gshj2dis+CH?=
 =?us-ascii?Q?HGrCalXqwG2SPVSj1mNLCrebFBRa/SEBudypLp03thB/YDNejteySJ1tkzg8?=
 =?us-ascii?Q?ksDSnN1c4cKvCP8b5ghTK+tnqBWBLV+suEs2eIZCgRMzwt1gEWbaM1F5tQ/P?=
 =?us-ascii?Q?TWW4GlCeCPlpKryT/aRf7Gd6H5QoXaqlaj+1Q/Mb6Z4KruSduYDfTZ3ZZMxJ?=
 =?us-ascii?Q?RZdjXXbKh3a6cAvbGE8O0/dYXn2ibQ/AgO2hF0+bgXMiHC2oV27sI1NzIHAn?=
 =?us-ascii?Q?050k4fL2K7H+4nWH61hPoPPokIodrZvwJr3k+msi2OtoBwhjErCS8bvxc+2m?=
 =?us-ascii?Q?PcWwDYWQhsEt5Hu66EVqDc6i2j/9WfyIY96acVUTKu0WVnv3WZQRKt3nYh7F?=
 =?us-ascii?Q?m4LsCS57MXFwyA3VMbHIU34H46R7DSKP9eeJOaaFQJe9XeZjZWF67oGGAfyM?=
 =?us-ascii?Q?yYESPG7Vfrou2+/0Tpx0BIOas1/IgZZb7c+69usFdn0OmjtPS6W9NNiJxnr5?=
 =?us-ascii?Q?uz1VB2+YJj2hVIv3KR3Az+IxF2wz+ndk6yLrOpjOkS1u8erydUS+nI0yDkKD?=
 =?us-ascii?Q?UBcQytRNSG3QpqFs7oc2ematowOhWbu5qVYqasBUVGbYheZ5TUBATlGIebom?=
 =?us-ascii?Q?esj1YQH5P7QRWLP8dW9Xce1eq/TPyQ4Adff8FkP7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XajLMPU1FMDI0p1UOL7KZ3hQPGT5vm9eM52ttI5kv7+fxLgOyygXH6Y2nWU77LmHUf/l7CwHvaYw09l2Bw28jCY1bT0jfERGXeBFRyWZRHUI5KOuvjVpoVkjBPP3w8FDUQhJ+fmNu1AQ130zuLxFzcR98LGN6ciyx4hU6C9uZIANMG8vyMZNK9FyBLXUSEn8bSXeoagKR0kOR3w7GnRbMITtjFKDy1erRNp6U6+1bfs8hH1Jy5ak5f8KGzJZhMAaXrrVYUtFm9lnWLRk9q0kxlIB4u8g50uH6ZjdOvkHunXExE15IW/mrbrKQUDg3g1wTp1rql/vS4Srzn/6TDyJiXNl4FZptnbHQeNcF4Cnvu7UQPax5RFODnrFPyq/DVoE5V/o4qEjYw9azQFRAEbKL8k+wifkiFyOaBsxrSgboR4fAEg77FrJkrJ4RVp54n6wb9O2Wc52u8ziHlZTB6Dq1eRH56Fer2/pnu17NSWUMLvpIefCS9H5biHn93lklJ6pGrLicvxS1Ek6PU8d2anWmFuuHR+hKeAUCKGxGOLo6E+3z/8B6+1tqv7+Irh1BqWeEmGRamrurn2s2ar/7vtHhaCt2MlL8W6tJsbvj/NiSBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73edd487-f20a-45aa-efe4-08dc92e06a2a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 17:26:13.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQTa/Lsn2AclPK9WBEJ8jdDFAF5/tt+wdwVzc7+ezwNAWseTiteCdaFTV+41jg5u9iMh9mAxhiA2eEjXGSNNbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=914 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406220129
X-Proofpoint-GUID: jU_nM-iG90df0NyYvg035yfjtJam8Wl0
X-Proofpoint-ORIG-GUID: jU_nM-iG90df0NyYvg035yfjtJam8Wl0

On Sat, Jun 22, 2024 at 07:03:25AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 21, 2024 at 12:22:29PM -0400, cel@kernel.org wrote:
> > @@ -367,14 +391,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
> >  		goto out_blkdev_put;
> >  	}
> >  
> > -	error = ops->pr_register(file_bdev(d->bdev_file), 0, d->pr_key, true);
> > -	if (error) {
> > -		pr_err("pNFS: failed to register key for block device %s.",
> > -				file_bdev(d->bdev_file)->bd_disk->disk_name);
> > -		goto out_blkdev_put;
> > -	}
> > -
> > -	d->pr_registered = true;
> > +	d->pr_register = bl_pr_register_scsi;
> 
> I think this will break complex (slice, concat, stripe) volumes,
> as we'll never call ->pr_register for them at all.  We'll also need
> a register callback for them, which then calls into underlying
> volume, similar to how bl_parse_deviceid works.

This patch currently adds the pr_reg callback to
bl_find_get_deviceid(), which has no visibility of the volume
hierarchy. Where should the registration be done instead? I'm
missing something.


> That would also
> do away with the need for the d->pr_register callback, we could
> just do the swithc on the volume types which might be more
> efficient.  (the same is actually true for the ->map callback,
> but that's a separate cleanup).

-- 
Chuck Lever

