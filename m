Return-Path: <linux-nfs+bounces-14292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97989B534F7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AA13ADB65
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC401C695;
	Thu, 11 Sep 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hVQVhRxf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kAsf+0Op"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A251F4631
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600119; cv=fail; b=vGiivSvfmaEpj1/keyJqvpI8T1a6BVh4NVR2v8E2PFTXMLBDqejZ3ZHy7fXa1PnzVzJPrMDNz3f70Y4VEB5F9v3YFcleHjXJE+8C6Y+x1hWyxLd0Y1kT48FZx60KrULYnQ6c5kpeBeZMe/T4ES46+KBcsl/ynpRH+ekrqylvJLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600119; c=relaxed/simple;
	bh=C9lB5AWkGSwiNu+fRK+wXtwI1llATamBrctKLxzsi9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAvduhug6ZnR+gYGDulG0D0L2zrR2tvc2D8jEodS4JE1H/C7iwC8tKTynh6e69kwafLPysM3sRAu60B87dXHnhK7BvfgdCPohEWc7ileQ5BHD4wTYyvm/oRrUqpmQAnkDK3QRJCruHq4gA1SEpep8WXiy4kwFZcc2R3by+g1FXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hVQVhRxf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kAsf+0Op; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDu4J1004220;
	Thu, 11 Sep 2025 14:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qOktIp3d9+fDv2+xfeI3ne+C1z2t+YYnKNxJfNnKxZ8=; b=
	hVQVhRxfTcGFtQNrvffPf+fhv3UJ8CankvahY8gWayIOSiFLBqcA8ZSqlovTD8/s
	pC0w8fHou0ierMz4OmC7FH6cmx7nUI+h+MC+bXAXfMAByeXO1xwIBA41UOM3slpg
	KIVJHFcHThdCrOicIcrvOaDo0MWRm2yeFjcHYP61gcB6g6vsMmr6yqnRqInVE/Rq
	MRfGZvngnXFVewdr/dCcKkwtCywQjmpbmnbEj0vM+oi6joj6U1I1/0fhlNauthHb
	3hexMTd57o9/jvsf02RWTPMPgGLCBl2sstI3YbAEgmK+4jpogtWWzMrw1eY4g40X
	hhyFIgMbrTDysjeGbNvXyg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgxc9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:15:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDhubT032833;
	Thu, 11 Sep 2025 14:15:04 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddfymb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:15:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWPmteJl0BTjBVTU7XKfWlCUXUddpz6mlHl9onlaKuAJNe6Fe3ypGZuvleJwZcrdILKzvZS1ieppUEA2+1WgRNkETMtWOM/spBWUdAyOs+TiVHZ/qhz8M5UQ8p0E8dLQUQ6sotbFSXVBf3DzOwnyfvSyZuiqhK5CDQTkS4L4m2jiKUDqW8APys6DS4ZtyfJRKQ600BUDiES1S91Cyh4wFkqKi9OBSV1PyWRUpSjYvJOdHYsNqrNs/DpnFcRqjq0C+B5q8evDuL90Td4sxyEp6eUdgLXArdow5zK4ADeYq1gAl1H4ap+JAwNrPbrJgWoKcezEB8ITQE1RCJ6e6LZJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOktIp3d9+fDv2+xfeI3ne+C1z2t+YYnKNxJfNnKxZ8=;
 b=HNpSuv1V0lQNu6I7Z3tvZOEn0DF6qmpOP85p5wZu+IcCpO7IjNR+QAW6FpGZbatel4ikJpY4WFdIQD1f10CW/CH+qL9vd+rcNq966eU586waf/0XSj2/hOhibfQld3OSrC/8Wl7jIec24KCw1pvoU9XbvV/PK4tyk16QlzdJZa0ycrYoWI9d32UMCuNKipwg+UXAoAaP8a/CFazMnauzY6h2GDXI2n73KUn/gGGMS2zT9bH2jy+rVtGs4y1/iXWOt9EJxYtZO8rzwm8SMLbiTMgLcGGg7vdHD8I9kc2nE2YWjJfDIsPvQUlQdm+N0oDGIB8drRYivoX5EJhJCG4ssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOktIp3d9+fDv2+xfeI3ne+C1z2t+YYnKNxJfNnKxZ8=;
 b=kAsf+0Op+u9vUEik3G/2arPJaefhaeh/2ZmIxJDS+wSSjikCVH2blmGO7xSIR6wf6e+DEHBrC34rySsBGxrznyXbl6HOT2COrz8X9AWTjUB6cfe3UMkaACGPA84tu96Q5tqGUw0mkrBT57/PwrreNmExwGAxoORM44nRqWoHaMU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4892.namprd10.prod.outlook.com (2603:10b6:610:dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:15:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:15:00 +0000
Message-ID: <152f99b2-ba35-4dec-93a9-4690e625dccd@oracle.com>
Date: Thu, 11 Sep 2025 10:14:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd's ff_layout_ops.proc_layoutcommit is NULL
To: rtm@csail.mit.edu, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <55792.1757540847@localhost>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <55792.1757540847@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:610:58::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 67462105-88a4-452b-b200-08ddf13d985d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YkhrdEJpazBDcGgzR0RiYXdWV1QrR1pHdEdlUGtpMVJHYkFDZG1NODV2OVhz?=
 =?utf-8?B?NWhnS1d6VGhCbmpKaGNTVFp3WE80ZlA5eEx0NU9OVkxTc2t3MVhSejlvVGUx?=
 =?utf-8?B?eUZiYU5BVEZMbExOSzZvakRpTEE0aEZLWkJ6ay9IR1IxeXlsWE0yTjNUdzIv?=
 =?utf-8?B?b25KcUxVSGxPYm85RU96VDFzV3JVRXBiK0tuNXdFbDlIT3B2Rm9hTVVOb1c2?=
 =?utf-8?B?czhBeHlNako1K3hpU0Rydjk0U2x5NFhJYWVJaVprayt6Wis3VEJEY1ZaeHRh?=
 =?utf-8?B?SVNvbTAybkdOZmNnNGNKNVFiZk5yd0xGUm5FSFIyZXFpRjRYQ205OC9BdjFx?=
 =?utf-8?B?aVV6bFV5V0JEeU0xTmpOeTE5QnZ6Y0tXeGxCUWdFcXQrNDJwUThXNXlDandG?=
 =?utf-8?B?Nlc0YmZyVFdZZ0FhNlZvdlBGUXp3NUtydmxKZzRNNEtLOG80YkF3RWUzWnVG?=
 =?utf-8?B?MGYwTWhxU2s1bmdtbkJDNmxrOW1TSHF0QU1peUVvY0F0dkxHbEUrdXFPeGpZ?=
 =?utf-8?B?RGNHNm94bEx6V1V4M3dmc3hTcGMwRURKa2svNzZSRGhMU21WQTZtVEFaRHh5?=
 =?utf-8?B?Y3RoS3FmU0VxYTlXNHlwYlpodVhpdXJ5R2haQWQ3dlRGbG5MQzljYjhHdElF?=
 =?utf-8?B?RTBzdmtXbTBxSDcwT1VsNFBpR080KzNzYVN1eW1lNWNoeFZGZDMyS0dRR2Vl?=
 =?utf-8?B?dFpKMmtyTTQxVC9kVUVwVTZyRlI3L3JrVitveUJJQUZvZWNkSnA0aS9XRUdr?=
 =?utf-8?B?SkliZ3RST1oxK2tIZ0IxU2taU3FlRTU1eWZONWlEYUJUdEc4U0xVOC8wRzJP?=
 =?utf-8?B?SG9vc2dETVl5OWdEUlZaSlY5U3lZdWp1M1JaS3dURktyZHdDaldUN2dQYndZ?=
 =?utf-8?B?ZFNoTUE1OVc3ZGEvMWRQck5kcXIxRjJqNlcxWFBkaFM3TkpmZkRRa01rTWJv?=
 =?utf-8?B?UjdBMzYwSDFnZWx0amx6Y25WZkNxcVN6eWpwOGRENjVBSFhhc1BPNmZBRHBr?=
 =?utf-8?B?UEpkcUJhMzhWcjNZbGhoOVhxaTNldGhhL3l6cUJBbXM1akhWd3ZCNlF1amZt?=
 =?utf-8?B?RUVldG5wcEVmRkgvdU5aSjYrUDlpQS93bXlYMGlRdkl5Z3BseFhaMXV0aTgz?=
 =?utf-8?B?ZFByWitpc2lvZmpieUhvNVpFNmI3VWdyVVRZR1hKZmZGL0tJeGRrcmpMT3JU?=
 =?utf-8?B?UnZyV01tRGQ3dE5aajZaREVmajZzc1p3Vi9QY0VIbTNDUkphY2wvNit3bVRZ?=
 =?utf-8?B?NFd6QUZ4c3hRWXI1ekhwSzl5U21ZZVdzOWE3QlBWcEJQUlR3L3cycmdNTDc3?=
 =?utf-8?B?ZzRkYlNVODc4Z0czZGRFNjcvd0kwL3JrSjlmbFd4YzFFc1FxR00vM0VqU3p1?=
 =?utf-8?B?NTRiK0JIdmVYSm9TbEJONDl3dnA1U3FTQVdMalROS24wL08xUGplcWlleTR6?=
 =?utf-8?B?NHNVZ094bXNlbDNIMStORWtSVlNmVmQ0MXdnQ1c3YkhIYUdLbkFFYW1rOTdn?=
 =?utf-8?B?SHZDeC9yaHpab3FQdXJYN1RSa2d5Mzlia3BmdWwvVFNBMGpnSkVPMTJLTzh2?=
 =?utf-8?B?VFFxU2R0WC9keEcxckF0T1lQTXlaS3dYNk5GSXQwUlF4bVE1RXY5RGdyb2NJ?=
 =?utf-8?B?d2daVFdEcElNYmhVeGtkaGRYaUxqNjBqMlJ2RWtRTjMwZlhGeTdpVHpWenZv?=
 =?utf-8?B?TzJGZWREZ29Qbk1aS3Q4ZHVTV1N3Zi9pSXpETTEveFRYQjZWU2JBK0d5Qm9J?=
 =?utf-8?B?S0VPQ0dLWWFYTFFDZzN3bXQyTGYzQnl0cUJJOWErT3ZPTzlCcHNiNWhyb084?=
 =?utf-8?B?RERvRzF2VkUwdGZ0eWUvQVZDZHlwNE1qUUtKc3oycHR1a29jQnNxWlh3M0U2?=
 =?utf-8?B?YXJwU3lLZWJRTDJtYVpaZUJ5YWl2WE5RVFF0eDBlNkhlMDdEUlhCWGRpS2x5?=
 =?utf-8?Q?irZ84V20nXE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TWM2UFFxTjQwMk4vUWw1MUdDYU0vZmN3M2JFcDlha0RyMnF2M2dlL29DYlRG?=
 =?utf-8?B?ME5GMTc0bThFeTJheTk4RU4yRXB3UXhoY0xGUmM4anNvV211OFJWejlXdzFN?=
 =?utf-8?B?bWEwbTBPWUFVV3A0UzVlYkJtdmZPUFg4MDBUbWxHeGpaMXNPWEFDVXlIWU9i?=
 =?utf-8?B?dk0renpYS1A3bjhSSXNBWXFobUNZVHAxZU1reWhBZHpKT2tRemdzOHcwOXJo?=
 =?utf-8?B?enRFdzFQdXRwV04vQ09MdS9ZWnpEZXcwaUZ4Ty9PMkxKMXBOUzlCYjJGVFRJ?=
 =?utf-8?B?QzFSMGtlRGthZHZlYTZkc01UR3NtTjJzMGVpdkJkWTZUaXJESENRcE5PeDRq?=
 =?utf-8?B?UzErQjBRU2VpWmQydkdqREZ2TDdueEJhdnVoSms5SDNhYnN2MG15SWdncjI3?=
 =?utf-8?B?YW9vQ1M0VUxaSS94Rzc2MFRiK014RXlrZlA2US9lVVh3WDJta2IvK3RuOFhu?=
 =?utf-8?B?djNOWWdBa1hYWXdlb1UzU0xFR2RqV0JSY3Qvc1RqcUR0RXYzNW9xZUtKLzJY?=
 =?utf-8?B?VDhIQUxWVmVIbDdjeldYK0dkakRPQ0cwcFBMejhMVElRSjBPMHBVa2ExRzJm?=
 =?utf-8?B?eE5OSzVhTG5TK0phcUlSVEFSeEdWcTZsbmdqU2h2d3RKTjRxeWtlNUlobHBF?=
 =?utf-8?B?SjVEayswRVRMTU5kaWo0UGRuUGI4MXZQL1JZNzM1UGpCMVJ3TFJLRzA2b1lQ?=
 =?utf-8?B?T3BZckNLU3VQZFVUZlErbi9xNDF6dk1JL0h5SEREYTNnalhIWlBiTWVkaWwy?=
 =?utf-8?B?Z3F4cHNHcFFlOHl0bDFJWjNkSUtaQ1lMRHdNelVEQ216UWZ0Zjk4VlNGMC8v?=
 =?utf-8?B?ZVFyRG40dnk3Y1VXVG5YMTZPditES3M2VU9BclB6Y3E4bk41UUI3UG5MOVdj?=
 =?utf-8?B?M2x1ZkxxWEhNTDZmOTJ4RE1DMUdVTHhDYjhkUEQ1b3I2NkNjWkY2RFRTVjFE?=
 =?utf-8?B?UjNpTndqeFZScWlnMGZGSDFWL3ZMNm10dG9TZ2xSUkVWUkNRcitUZXBTaHNh?=
 =?utf-8?B?NnFGN0dmTEpyVFpCOEdMSWcxeThsNnk4ekd1aExDQjRHT2JKbEw2U3FXaTZ3?=
 =?utf-8?B?dUtvNXdVK2FwSlhFbVo0ZUhYb1FIWVFWR0ViWENQWWhxZHVUczFFaFVJY2M5?=
 =?utf-8?B?bTBRbm5LdWM5N2hwdnNadkoyV25JWHlZeE5RaVJ3Zkx5enNQTE9IeG1tVlZX?=
 =?utf-8?B?NlpveGJVbFF0dU1NTXNoRjZwaS9KWWkzei9UNHl6S1BKTFBiWmlSTTFGT3do?=
 =?utf-8?B?Y0w2VGlDOGpPVUkveEVFRVh5UkdPWU5GZE9nSlNNWGVBZ212VlBCOC9WaGRM?=
 =?utf-8?B?VERCRGxYZDF5Y1JDNWFjT2xKUDRJVlFTNmFMb3luTWV6SGQ3SXhOdU1nNnNr?=
 =?utf-8?B?elN6d1I4RjhySzQ1VjhzbFRESFhFMEw3SUVwVmxoVDhYUHdKeE84UGtaTHFX?=
 =?utf-8?B?V0FxS09PTnFpclVEQTNrM3orMVhlVHJXRCttQnB2czRBWURkVEdDaWNKUzFU?=
 =?utf-8?B?NFVIbUdETG5yRVhGRWFPMUJoZ01wazY4ZjlPUUM3c2pTM2Nxdld5bngzZmR6?=
 =?utf-8?B?K1dablVzeVY4bnV2NkNtWjlEZWJGczV6Y0tQS0VIaXVldDFGdG9PdnRpZVU5?=
 =?utf-8?B?TUxJcFRGVnFuWjJ3cXRNbW81Z09idlpOUGc2eEFTTFVHbmxEaDg4SmdQYXU0?=
 =?utf-8?B?ME11eDhLY1o5Y3NZMlVTci9hRGxCNXBTMHR5dzVUSmJWMjU2QUp2R1ZRYU1i?=
 =?utf-8?B?dHZzcTEvUG1pb1p1QWo2NUFvL2dLazNRQlc4V3p3U0N0MVp3VUk4RXlqMmRB?=
 =?utf-8?B?V0Z0NmgvT2NLVGRwRFp5SlVSbzRZcTRtdjgrU2JlcFBxNGlQZWVJVTVBZHRS?=
 =?utf-8?B?RFI5TW5UdEw2eVNHbzgrQ3NHZG81NExsMVZkZVRhZFRyQ2NzdXYwMC9UcUZr?=
 =?utf-8?B?bnZLVmE4Y3FQekZGeDNVOTZhVlNpUXVzaHFtMEpPK1NjT01qL0hzVHBEMGV6?=
 =?utf-8?B?TzdCaFN0ZXBVRnRuM1J2VmtldDl4N3k5enpYMGhtTGJOc0llR05lNWgwb1E4?=
 =?utf-8?B?d0RUZ0hseTFLOHVldVVaNmhaYjVqYXREYTByai9hbWlJR0pmbXpLUURrVHB5?=
 =?utf-8?Q?0DEgkRr6LlUWaw2zssYx1w1vS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0EnO4yVeRZN4IHWWhQ1kuevNUYxvuxjx+J6An0eBZTCKuZEFgFQ17rPCVKAdLz4yZxloj7aVf482h0YDw3zFRLPv4cFGveLKVcE9EwrodX/FXMtrqncuSvIn5PX4AL8XcTmdHbn1wN0qtO5fZ3NnsnN2dyYNUzCjsqZh+F2DN76GMhCAiR7TDmK0rir7IAWhUSi569gOJ7OrN5dPLFp01+6JVXqYnCKwUL6T8/DXLk1qyVL2o9QFwgqQ58ze907hFlgULn9J2YC7lP1kjnmqdDnYMJiwAz4pbXeWbZPAmep1GopFwP/MSDrhDwQwtB+/bmlyaZl7a6VOS+GtipNHDc/329s9W15Ck6d6ntjYcowE3ulQah7xqyFt3ZoEdLBck+5vuRREXLDB+19hOmQljG/YLZq3R5Jq7hwkWHmmuuygbxIl4MgKIoHo2EDxS7nDvSQhTv/WXXNtg+MJNY2porwJ5PAkrLJvjEFnIvibMXe2jR4ESfyBmYThEyYofXTcOo5CGZPANe6QqfjQPM9blhdnw+h9sgeDCHjGxo0TV0WLcy8h2CHKRgGjLgfVfE+f7ADIcQVEr9/y7C5a9Yyd6xPWSmyGXsnMj4i86k7Zi3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67462105-88a4-452b-b200-08ddf13d985d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:15:00.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnEl5/DwpNhM3N+gOLS9DupKBhdvzGQdm0/CScW1ZWapV+csV/3J40QPM+K4OnT5fy6jbGWyH9/dq46Nc0dTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=693 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110125
X-Proofpoint-ORIG-GUID: X50jOdc8hJdrXfrYRw0NBB0ZI5DQ6HkQ
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c2d969 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=FoTs_EyhagYoJnNxOoAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: X50jOdc8hJdrXfrYRw0NBB0ZI5DQ6HkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfXx+gFymi3wU2k
 nbMBgvyQQNZAQ1wKvQOZaxFi8cDRvil+L0ESh+MDtkTjVAn8uP1tXBzQvPGDE2Ep7faoQjKcaIV
 4Ss31W0i50KYU4Ydku6qIXI6fneszF0FtmfGAVkKI/B7ou0OGaDBdcgfiUs5xxuRYyDH3ABP3x+
 Laxcqc1+ZRXqJ3Bduy7cjheoRjp1snG7vr+WZ21n8e7Bh6vMXiGR0ENt7C63HVo9mYHmHZQFrFL
 nXQehPbST6CjT8f+Pmff5okf6fR8OYgGd5v8e+Ga3yyO9EU7yY9P+qP47T1efVTNAhlTvmFDmeF
 A96GHP9FWVtI5e0xgko7CA7BxYYxGDL+zDcdyn9EIPFn/tDfkknZsZVNYVJMFbpl6uEWO5TT2Jn
 7pGskQfm

On 9/10/25 5:47 PM, rtm@csail.mit.edu wrote:
> So if a client sends a flexfile LAYOUTCOMMIT to a pNFS server, it will
> crash here in nfsd4_layoutcommit():
> 
>         nfserr = ops->proc_layoutcommit(inode, lcp);
> 
> I've attached a demo:
> # cc nfsd155a.c
> # ./a.out
> ...
> [  643.202841] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  643.203679] CPU: 8 UID: 0 PID: 1115 Comm: nfsd Not tainted 6.17.0-rc4-00231-gc8ed9b5c02a5 #28 PREEMPT(voluntary)
> 
> #0  nfsd4_layoutcommit (rqstp=0xffffffd6047cd000, cstate=0xffffffd60a062028, 
>     u=0xffffffd60a022720) at fs/nfsd/nfs4proc.c:2529
> #1  0xffffffff804b9768 in nfsd4_proc_compound (rqstp=0xffffffd6047cd000)
>     at fs/nfsd/nfs4proc.c:2888
> #2  0xffffffff804a0558 in nfsd_dispatch (rqstp=0xffffffd6047cd000)
>     at fs/nfsd/nfssvc.c:991
> #3  0xffffffff81034022 in svc_process_common (
>     rqstp=rqstp@entry=0xffffffd6047cd000) at net/sunrpc/svc.c:1428
> #4  0xffffffff81034522 in svc_process (rqstp=rqstp@entry=0xffffffd6047cd000)
>     at net/sunrpc/svc.c:1568
> #5  0xffffffff810469a0 in svc_handle_xprt (xprt=0xffffffd60449d800, 
>     rqstp=0xffffffd6047cd000) at net/sunrpc/svc_xprt.c:817
> #6  svc_recv (rqstp=rqstp@entry=0xffffffd6047cd000)
>     at net/sunrpc/svc_xprt.c:874
> #7  0xffffffff8049f58c in nfsd (vrqstp=0xffffffd6047cd000)
>     at fs/nfsd/nfssvc.c:926
> 
> (gdb) print ops
> $1 = (const struct nfsd4_layout_ops *) 0xffffffff81366130 <ff_layout_ops>
> (gdb) print ops->proc_layoutcommit
> $2 = (__be32 (*)(struct inode *, struct nfsd4_layoutcommit *)) 0x0
> 
> Robert Morris
> rtm@mit.edu
> 

Right, at a guess, this is just like yesterday's -- IIUC pNFS clients
don't need to send LAYOUTCOMMIT for NFSD's degenerate FlexFile layouts,
so a FlexFile proc_layoutcommit has never been added.

Agreed, however, that NFSD should avoid crashing if it gets one of these
operations.


-- 
Chuck Lever

