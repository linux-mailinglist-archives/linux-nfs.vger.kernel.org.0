Return-Path: <linux-nfs+bounces-9534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174AA1A5AF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE6F18844AA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BF320F96B;
	Thu, 23 Jan 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cm8Z9Aml";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fo9v2/mT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804113212A
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642179; cv=fail; b=Cm+zwNssCSBQo9UF63FyHQcdrQl0Ceky0cVyYxJw/xEQURsV1Q07t7skLHeFs6MtXBGq8lDf+qTID6+Cko77Ba84DWvR8R34Uz1w+l5XnyBog2z6V4//kiGhVlrDoQxD/oes0hCp/mYR/IYXARH1ynTjLeo+9qKD+rdPWugDS24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642179; c=relaxed/simple;
	bh=6Lw95zy/fbcRb3hGaTER5XAHGNi/BLeUXUfbtE1xuD4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EuU7ugJuQaPjOzoTu5wmNZZ4Gv5NxCUEZopScfit0CE/VIeeukmrSdHVd6Bwn9fBW5Om35YWo/r1G2PguS2c9B6lG+mk33YHxYwXQVAy/Fv/uDUbyIMx2SCGavCRsziChIiFwkfZSK1i3JQtUXM5u0c184vD9fOuLvrlH9jh0i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cm8Z9Aml; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fo9v2/mT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaL9K030484;
	Thu, 23 Jan 2025 14:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IkBbbn9L8VSkajCIMeQ4WdP1+sd82ou7YuQtnLKU/Zk=; b=
	Cm8Z9Aml6fxl0d5exmourEV1V9KKGaOZRJwbUA25xaRSRMI0HFw4VJTgRjcSnyUk
	fl6UozR+CmtmwP+SceY8j5k+OUxhMqYkmsZH58r2lOQZ2h77hcKxfc4P+ksoo7Qh
	nAWi/CeushGu4jcxqUFZ1yr4BK/yx/F/gXdF6smdrTbf+Gsbg33yf1fFhx2544fg
	+5ULbS6rR8ReYJZABEfLQT/1bvYDvIlfOVxrj0kGbj/ymbNsszzwM4gSrnos6Kzx
	4Tt/Hnl8yVfYeWZOuzwSIVwTJ6w4LpjIe+ZVaRr4rVw5u2CSwBoYu86LBNeJ21bq
	7ghxtbWvgWDqH5323jCaAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96ah6nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:22:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDrUpq019489;
	Thu, 23 Jan 2025 14:22:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c50wvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phR260ZwdmuyN1bDiSxHuRFYz4OhEjPtV7bOHhMpMIdJXxVALzVy4/dejx/fOvLZ9V+y5Q/2RNxRtrurkGa/0cdtPGxDZmge5dwRAY/+mPh5WhQiAQ5dD6J5zTYd4/FTPbHJwwSoWeIjkLf5698tfuimN2OQid9L/d/CW7vbH7I6Q8RApAPrJDfztmhYJV+Rh8C09ItezpNdUQgZvitNtoEoZu2ZuHiq5W5puWIlwSdrNAWniiAR3kuxakBDxuk5NClFXx9nMFJRZhQWQatO3eaFFmkM0S/pYZAanCOrEcEHFASfb87P7fUe+ZefKOWpDKav1LtxCgOb8WN+2XhKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkBbbn9L8VSkajCIMeQ4WdP1+sd82ou7YuQtnLKU/Zk=;
 b=yv2U3yYk/FvBrl8tPHvn2p3+w8k+x56cB1pXl/P/QabMCsWI0nTYWJ3epo7lE8ylC6RtX0ElEufYyQ6Uc7K27QGWl6e9EymejUB3kbnBjI5KLw1rqfRdZsde2y5J3feLaexcoy4Ya0Vq0bgTEFPvpWgn6k31Kej2Iwvq1dQhb5OgPL33KALpTfzfdmvRgjEluqdJojTl8zPK88x7Rjo0MQhxdrJMDnRfphwosLsqjpFfppkcyEv9t9TuVJ4Bjlo0+KtUpykIK19XfsjzQMjYdYjuhUQn2lqJW3BzeGE3o3zyTjgFuxDYv4Wk0JpfmA3L5WAIfs2U3x7qrYc3ydEqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkBbbn9L8VSkajCIMeQ4WdP1+sd82ou7YuQtnLKU/Zk=;
 b=Fo9v2/mTqGykOQBAZ+yvozO2/XPhqlDcqX+XvX0qhJlGjF6RUtspDNDbZXM/kdcE5i9i9APayeVN3wSAdxZm4JMsLOw+UsWiKz+YHqZD8Te9norZnDaP6lEAwZCM0ayaojmfJJndz6gN91+fa6mg8aNrEfkdiIwqTvzVJ0mC0IQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 14:22:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:22:32 +0000
Message-ID: <2f9248c9-77c9-4a99-82db-6cedfb3161b9@oracle.com>
Date: Thu, 23 Jan 2025 09:22:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD threads hang when destroying a session or client ID
To: Jeff Layton via Bugspray Bot <bugbot@kernel.org>,
        linux-nfs@vger.kernel.org, jlayton@kernel.org, herzog@phys.ethz.ch,
        tom@talpey.com, carnil@debian.org, anna@kernel.org,
        benoit.gschwind@minesparis.psl.eu, trondmy@kernel.org,
        harald.dunkel@aixigo.com, cel@kernel.org,
        baptiste.pellegrin@ac-grenoble.fr
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
 <20250123-b219710c18-e354a69e709a@bugzilla.kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250123-b219710c18-e354a69e709a@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: d136190d-dee2-4d10-e528-08dd3bb95fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZC9SemdDdVJ0Z3JYK1QwV3ZnbVRENmx0QlJzZTdGeVdFQ1R0QzJYbm04aUJV?=
 =?utf-8?B?d0k2Sms5MFh1RHVzZTZLTDBXMnJmYktLcEljaEVOd3RVUHNKb0dzSlphUFhh?=
 =?utf-8?B?Q1ZDb1gwcEhmTGdpelhqcWowRnpLL0VITGZpUVJLbHVvWW1wTE8rTGJlVUFB?=
 =?utf-8?B?RHpNWTQ2a2NyL0hDbVByNGhlZlh5cW40TDhONDRuY2prMXBGWlZqVmJzVGxv?=
 =?utf-8?B?bm9naFlVcnVHM04yNlltWHYzeSszTHZZb0NYTXhNbGJDY0N3ZzhLY2NJenoz?=
 =?utf-8?B?cVZZV250WnRxeXBJTlNFb1pNSFh2dGVUREY3YWZCQitqVisyQXppYll0RXI3?=
 =?utf-8?B?OEpCRURaV1ByOWZ6bWFFNVZFcTBwV2Mrc1RLYU4raE9odVpiUnB3Mms3TkdB?=
 =?utf-8?B?QWFCdXVwVGxkdnlRdllPT0pDZWIzZkhpaE1wUXp6bURnOVpacWZWVGE2MVFR?=
 =?utf-8?B?V3BKcjNJTXZPcCtYRGVpMGxGQXYrOTdYT2duRWd5QnFtTXNwcXFJT1BkcXZi?=
 =?utf-8?B?Ujg3V1FETTFHOEpISktmR0tNaFROYUtoRFVQeDlja29hUGQzbGJOZTQ1ajhI?=
 =?utf-8?B?YWk0MzZiL0tyQVJaUFhORE1jZSsxTW1TU3NmTTZyY2xhdThjQy9qdEo2UnU0?=
 =?utf-8?B?Y2JFQkV6RUxjMWhER0tpUW80czFlekdEZmpoS0NmczBXTjdidEV5aU1kOHp6?=
 =?utf-8?B?NnQrdUQ3Z29DSFc5ZG4xOU5aTkRWcjUwYjBPUlpRdG81RklWSWNuaG5pZWhF?=
 =?utf-8?B?L1M5aC9ENHJHdzF6V3hkbXpwb1dTN1FtaDNMQjNYUUwzQU5Ha2JRNEN0WTZQ?=
 =?utf-8?B?TldyQ0NGbk1FZVppVGhWclJzR2R0dFFvaklYNDduUTUvWDBpcHNUWDZrUjlL?=
 =?utf-8?B?RGZtd1dmYlV3eTdsSmFWNVJiK1BvVEl2SWhPVUU5TXp3aENOSW54Ulp1T2hs?=
 =?utf-8?B?dWVTclR1dk5sMWpmMnBaRHptcnR1a1U0RlRsSG9nelNxRkdjbVRlVTBabTJw?=
 =?utf-8?B?RC9OcUs4TjJTNTg5TW9yUWd4dDlQM3d2Z3ZaY3EvZnlnSnJIRXJLazdqNUFQ?=
 =?utf-8?B?UllValkwUDhEYVlTZXlGTkxPRnNzVmlLV1pmZXh5TElLWElubUZ2T0x2bTk1?=
 =?utf-8?B?WS9IOGZRa1JBRnMwemxUQzNPNno3aDJ5N0hBWi9nampsTzFzazRpU2ljMkRC?=
 =?utf-8?B?TG9zRzk4Ylcwd2VDN0d6VDRTNE1QSk45Vy9oL3M2UzVySldJRVpvL001SjdY?=
 =?utf-8?B?OUFhUnBrRE5yREZNcytLTytOZms5WEtRZmhuMW53NE5NUjVmYjU1Vi9OMExX?=
 =?utf-8?B?VlM3V1h0bi9QTGUxamZxNk43d0g4ZU13b3IxbDI0RmFiYlhhbHlRMmFrTCt4?=
 =?utf-8?B?dllqUlJtUm0yV3kzOUtCMXd5MDFiVDdLUVUzdUdremU4YTAzMVU0aGVZdHlz?=
 =?utf-8?B?NmVFQWN1WGhkcXR4OXMxZGhEVjJOeGZaYjEwSW45YXB2bzNZV3RRNXJYMWg0?=
 =?utf-8?B?d0FXbStybnhDOHVXMnNlYVN4d3k2M1NLWjkyVmJ3SmZ4RnBWZldlV3hsamdZ?=
 =?utf-8?B?enhnd2Q2SVU1UTVQZ1ViT1hZQXpSS2Y2ejRNV0I5L0QydHdkL05PY0xraEs2?=
 =?utf-8?B?akRnRHRaVy9KOXhqVkpmenhqc0x4blNGMXRnQVBPYzdzZ1prTmtZSFlvTm9v?=
 =?utf-8?B?ODlTOHhFY0NwNnBOM1hRMEdwNm1wSncrSkE4SE0raFVYUmxWZUE0Z1BUNVBm?=
 =?utf-8?B?aUZZRFo4Z09qbEoyVHRTVTEyVHh1V2xKYXZSN2xpYmY4Ukt2OThaS2RxS0ZJ?=
 =?utf-8?B?RGxQQ1JWWjI1cWZJa2x5aUZUaDVGU3dMUDZUNnRtaFZONW9KdVJ3R1l5RjJD?=
 =?utf-8?B?OGZwa2F3YmhuTWY1K2kyMDArTzZXUmViNENoNjdnVUJNeUl3MkVNUlYvZG5S?=
 =?utf-8?Q?WKYekAfVx2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFHbE5Wc2l5Q05pWWU2Z3gxQ3VjT0l6QnU4TEpnVDFxeW8zeGtYcWhMZUh2?=
 =?utf-8?B?Q285RTRrb1FndnlnNGsybzh4OXVWbmlMbDBtcVpzeXhFOWc5RytjRWJQcXhO?=
 =?utf-8?B?Y0luYWdOMTFaeFVLL1JtZ01UVW44WHFxZ0hoWUNkaWZmTldjR1NIKzlzTUVw?=
 =?utf-8?B?cmJqUHd2UlpQZ0dsSU1nWFd4N01RQ21WTDJ3UE01TERtbnJhM1lvaER6SXhO?=
 =?utf-8?B?U01FMnZtNFVjSDVsQ1RVSE5rNFI2Tk5hR3ZXRU5ySjdoVEkyRjMrVnQ5M0l1?=
 =?utf-8?B?ZGUvODEzR0pQek5aUEdtcVJuZmF1N1M3a0JMZjJpcklFcFgvNkZ0eVZUQ05m?=
 =?utf-8?B?YkF6YTNoN3lHOGV4N25qcDZGNnBqeE9VazUrVXVUbFJmeXlwWVQwTUc2ZkZP?=
 =?utf-8?B?UDVPT0lnalBZQUFEYmwzY1BtV2JyNHV2MHpZdDI5VjcyRTU3dU9QT283YkdK?=
 =?utf-8?B?eTFKSW5RQ3FYWUdFQWlzS1hGelZwZ25oMXBOcklSZ2s1N3ppSnZXT1FDWVJp?=
 =?utf-8?B?RG9RV3E0eW9vR2FoOGJaTGt3aWN0bEdZUm1oVmo1RnA1YTVVL3Y0R040Yko5?=
 =?utf-8?B?TlJxbHc2UTJ2VUFacUhnbjB1SzZIbjBydkNLMFlPb2Y3THpHdG5sYzRhTHUw?=
 =?utf-8?B?SThJSkJjR00rZ29mYTdyaVBXS281Zy9wNXZTL1pCNXB1MGFMUGFLQTVPRmRW?=
 =?utf-8?B?SzIrd2dkR3Y1ZXB3MGg5SVVaS1pZdU1BZWxaQ2F5QXJGS3ZIUTAzeWNESGlS?=
 =?utf-8?B?dGJmc0dJeGI3bW54R3ZsZVo1MHlMWFBRMmtCOHlselpxb3R0RUJtQWVzQkt4?=
 =?utf-8?B?aUh0Q1F2dzNHMnpuMENIQkNOWmRhcVB2SDZSVEw2a1NPSWtvalVnRlUzRlY1?=
 =?utf-8?B?ckF2aDF6THE2cFZOc21scnFtM2pTenNGc3oreVRJUTRDKzdhUnI5NC9ZWkZ1?=
 =?utf-8?B?YlgvemwwNjd0TlVRNTJmaHFuVEV5K0NpM0EwYTlzRkRjNmdYd1hUcEdnVENk?=
 =?utf-8?B?ZjBtMGZDMHpGV2ZmUzZWbDk2UVMyVEZYSGFldWZzU2E5d3VZbkxGaXh3blFQ?=
 =?utf-8?B?bXZjbVRKZXE1bkZLTklqczIxYVFMVzl2VmloazhXQnd4WXpOOFJWaVJPVlVV?=
 =?utf-8?B?U2lKcVNEc2prZkRLa1NldkhvdDR2UCtkUkx1TlJtT1RSa0ZOOFc2Q3N1M29D?=
 =?utf-8?B?NkU1MW9SM0VmUHR4bWhrcGN0M3doY05nSDkxT1Jub0pZZlZPeE1mZCtnaFNw?=
 =?utf-8?B?U2FaU0lCTHJFUC9vcjJpSDArWWdBRG4vRU4wbndOZTE3NkttV1JKakdDLzlk?=
 =?utf-8?B?NWF2K29pYU5vZ0xubG55Y3k4TFhPR3ZZRzd6YzdwRFNwMTBkT2pxQVVpMElt?=
 =?utf-8?B?WUIyenNyT2lTMGx3dklYT094V2FKckQ2V21sRDMvbi94V1lhMm5aTFBVVjZy?=
 =?utf-8?B?YUJEYWlBcTJVMjJMbDF6VWR6aWcvV2lHc0p5U2d4c3liSGJzYWJXZWNZQi9O?=
 =?utf-8?B?THYxUzU2cVFEN3B2Y3dlanpBWnErVlhEa1RzSnlwb0VRdkJSMkFaTDQ1VUV0?=
 =?utf-8?B?UkFLTklOaHVhakYwQUpDRGIvNHNmUEZOVDU2ZkFZTDRvbDkyZWdoN1VXdExa?=
 =?utf-8?B?M1RHTlN5VFVJSS9sY0E5NytLUWlmdmMrcXMyZFRrREE5bVR3OExEUUp6Mytk?=
 =?utf-8?B?dFpWM2ZXRFBidTZseXI1N0FLUENtanp4Z3VrbGQzS2NpVGpDajk2QkpwNEIv?=
 =?utf-8?B?Yk9WWnl5TFZyd09LdUhQMkVmTGdIdjExZlU3bGp1VVdjOGxMQ2Rrd1RCd3FJ?=
 =?utf-8?B?U0ZwQ3NyVjdMVEs1d1RoZlc5YzVmZmcrSmNzM2hnV2xaT2FLSEhDMG5IbHVL?=
 =?utf-8?B?bkJKNTBBWXE0Zm5sV0NnTlRzZjZtK2IydktLZEl6Ry83QUliakJ4R05VQldw?=
 =?utf-8?B?OGNDalZYMG5PQVJlL3pXTS9SMVYzVWh2Q0tSQ1RURUxQbDJ5dS9qZHpkbWlL?=
 =?utf-8?B?NkNNeFBWN3c2VGg2QVdUYkZNSFg1NzZvQVZyZGFGQUg5cUtFQlZnbk9TYTZh?=
 =?utf-8?B?LzhUMGVDZUpzZEF4MlZkb1gyMm52bnlJVnRrZXk1Q01nc0NaNEpwYXlOVWtI?=
 =?utf-8?B?T3JjeDQ4NnlRTUxjMCt4U1ZGaFl4WjJ4YUF2ZTNCVUtwcXZZY3M4V2ZVR21q?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4drfj9t/6D2zBgXvO5PUtkHyW9SQltru+C4xK4wW865AFbnmKRCJrEjURKbhmsiXXpMFTVto1PPslntbqsxkdlJ816ZZqEIr12OEF5Uo/o+UoS+0j0tOWIt5yjvj2tGqv2nPRKVclI43yc+37HI5X3gLfb5MmNVcujznzpucNqL85yk5b/wiYoLw68rksxCn0KH10qDE6v0/L2jf/qD/yMM6sg4g1IMERuT1csxOOc/Hcl97cUDWeYCliQU6lSQdfpoYvRPVI2u+qbcsymbwzhVELEs7n4LN/P9+ImU4Chl4ek3LZLP54mP3BlfUm//Bx1v5i6uJq4ZMsa8iZavCsdqF+Qgse7uQbG2ZKu3Cz306NVH0zJtZ29jB+/Lbtr5HmTiBVGLHTZNf2T6VChbYP1PE8W41THjOxuX9jA7q0OaQCyEGrSbsHFnIamFfU9rS0Feuo9tvSY+CcrVYmsBy1NBnsBAptGSP9LqJV4Cwo2tnN+EuuqBurjLPUJV9ZHr526lhXNVSyd/fJq5aNZtQcbSZFCp5RJjb0YjL2gfyXBJw+kuCJeozywdADxF56wsM+lz4GCcNGLBWxlEfm+D25HhDj140UFI+y5MD2H2GvIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d136190d-dee2-4d10-e528-08dd3bb95fd3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:22:32.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OA+7yfOmJOfUOyrNbkspTKzuE/nVPCPIpBSEytRT+X89rnC6aLGPR2re9BgntBWMrT5IrNVo/Af9dUouHkv8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230107
X-Proofpoint-GUID: Xo6qxfZBnaL0x3_KyWfBr1S7Zx_jgdYz
X-Proofpoint-ORIG-GUID: Xo6qxfZBnaL0x3_KyWfBr1S7Zx_jgdYz

On 1/23/25 8:50 AM, Jeff Layton via Bugspray Bot wrote:
> Jeff Layton writes via Kernel.org Bugzilla:
> 
> There is another scenario that could explain a hang here. From nfsd4_cb_sequence_done():
> 
> ------------------8<---------------------
>          case -NFS4ERR_BADSLOT:
>                  goto retry_nowait;
>          case -NFS4ERR_SEQ_MISORDERED:
>                  if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>                          session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>                          goto retry_nowait;
>                  }
>                  break;
>          default:
>                  nfsd4_mark_cb_fault(cb->cb_clp);
>          }
>          trace_nfsd_cb_free_slot(task, cb);
>          nfsd41_cb_release_slot(cb);
>                   
>          if (RPC_SIGNALLED(task))
>                  goto need_restart;
> out:
>          return ret;
> retry_nowait:
>          if (rpc_restart_call_prepare(task))
>                  ret = false;
>          goto out;
> ------------------8<---------------------
> 
> Since it doesn't check RPC_SIGNALLED in the v4.1+ case until very late in the function, it's possible to get a BADSLOT or SEQ_MISORDERED error that causes the callback client to immediately resubmit the rpc_task to the RPC engine without resubmitting to the callback workqueue.
> 
> I think that we should assume that when RPC_SIGNALLED returns true that the result is suspect, and that we should halt further processing into the CB_SEQUENCE response and restart the callback.

When cb->cb_seq_status is set to any value other than 1, that means the
client replied successfully. RPC_SIGNALLED has nothing to do with
whether a reply is suspect, it means only that the rpc_clnt has been
asked to terminate.

The potential loop you noticed is concerning, but I haven't seen
evidence in the "echo t > sysrq-trigger" output that there is a running
RPC such as you described here.

-- 
Chuck Lever

