Return-Path: <linux-nfs+bounces-20442-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNACGifyxWkkEgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20442-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 03:57:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF233E9BE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 03:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE1C6301DD85
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E333F8D4;
	Fri, 27 Mar 2026 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e06McZJM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wonVAgzO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097A33F8BC
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580259; cv=fail; b=H/78t7yuFZnIXowzOgWDDZaYyCb/unn1t8Mutge+VpBw2kOWFNP4zUIDEyO1joxk55+u+MUa2mKEWW7dIEnJH6ZeT6YQAImIy8e5h1xB8SnadXOv4CU2jInj65l8fjEnWxeRzccQR/xuZXOfe/kTgknzszCRo7oZ3r/vPl16PUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580259; c=relaxed/simple;
	bh=qQucRrDoI1CGOcc9cLBm4KLHE0Rqt0ZCVKClzFL0KlE=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=WEPe56pHseuVlZFuCUZMSHbBj4U1pG9XU20HCFLz73VJV7RGbJMqXC/LeeS90yngFbO0cithhbops7KYpL3k3/WliolyG0toIYUZO4V3VGhLH5fKWrkUdHWxU+Tki4SFx5uSdsS+oD+C3a8YEnvgwBnBuPRXBi33UsiwyTcMWh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e06McZJM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wonVAgzO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFtv2N2588402
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 02:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=c3EknkTZ3IB8ufR8
	7imT0A319Z6/XPWQ3DlzEkIE3mM=; b=e06McZJMdX0hMOhhggdgztaJF8ii45c+
	yJDaAKQ+9R+P0ChZsqbAdIRBCG7iygZhugOfp7ZUIOJ6eepj19kSoOABsyfaZ6vv
	BQNH85UTUpnjCb4Q0RLd/FMzLFKssZUNqMIBBs0rGJqeZm5de1S08cfY78UfRPB2
	0oSAQe4b1JFqEGXlWc8LAVozOw0cU4d5VlE5vnE2+dh14LrAvbbD+zt5Hx0TUrbd
	e+Zc73NBedVKbbTeWA3r29MMyBYprRnuQVeTuB9IxIAX6v4ZnQ4ozpvmJ/NlX0ru
	/jAtENW/jU2IHsE5aXzbQ0e0Y2FaJaEkb+oNzVqFnLaDCwASoXQqfA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja9e06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 02:57:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62R1KkQ9029099
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 02:57:35 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsdu6hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 02:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrRQtpbCr4WeLqyJvUcpkHS9sXjB3iB6yyAc4pCfsJg4LqA+vVopR7ebhCnBF7FDWOdRcg3VpCd8DxHGzUGex/PnRIUCeqUQoP7xvMzBHBoYPAGGsRYh5yFX6QbpGS+9qWICkZp1ht9Y8W7tB70BhR4Fm3b5LRmHLFS1aoPUnq9PV3hfu+aQ8kXQtDR1zlT3dH/Jtn3hFHCL7iCaMbCM/zKcRdzt8+yWvM8w+1/aa0Gh0htA83HnEwBtRhZ02uAQjpKPyk2h31lTCctNN5EWbACs/ymriJFe4kfbVcDehWcst1dJtXG7NdrMFAdcQ9AATQhRmJ1AbPi96OsGlHuh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3EknkTZ3IB8ufR87imT0A319Z6/XPWQ3DlzEkIE3mM=;
 b=gLQEIcCDIi9KRcfbv+wkcItsuzboOYHHWOQRVqbRHpO51Lfi0Uz98OKltQDEMpGdvyyYdN5VhW312iB5VFVwXAeG3D/K0U0dy40EDxtEA9WjwvIkNzoUJqunslBCMVUyc7kgltm3B5ew0CzZnPKgZZOKCPykwtaIGBwix/iK1gZwUDSYw0v5oSI7gsPZiUGev3EA0XN4HaHxK4gaZdpk7hjAW8mQZc07Y9J23He3JYLxwLY4oJUlYZjO1FLIzT1k0gFVY7cCrGE/6/ou5cPHWGe64+Y5rl1ubGQDcPkZeJFD+o8qZC1MBMLw+nqZ7L6mtvPu1fRyVNC9ZAq6FIML+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3EknkTZ3IB8ufR87imT0A319Z6/XPWQ3DlzEkIE3mM=;
 b=wonVAgzO5dJTXmaE8Owz5K2tGB3kRMl2tM/nlDDyMJcf8AS9BldQI/PhL/vojVT+PdOW3ODFjJAQLjPJlUb1aGt+OXN2xqFfcS2JXbEcrgHdPVkeV9Cf3hzyHQ/sgr0/N/cOdI8VG1Lu3wWEHroKqqxamz3SVUIW16gIgGgcyy4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH3PPF61A2638A8.namprd10.prod.outlook.com (2603:10b6:518:1::7a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 02:57:33 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 02:57:33 +0000
Message-ID: <33de50bc-5cca-4071-ad32-05a82da89c77@oracle.com>
Date: Fri, 27 Mar 2026 02:57:31 +0000
User-Agent: Thunderbird Daily
To: linux-nfs@vger.kernel.org
Cc: Calum Mackay <calum.mackay@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Subject: pynfs-0.5 tagged and pushed
Organization: Oracle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::23) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH3PPF61A2638A8:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c1ac97-c17d-4427-7e82-08de8bac979c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yNREwaAjw3aFpeeVjN9UMyAHxYxzU3dGPLLx/xkARh4vIDVBvJK2oNJPVLwX/FC1NJ5c3NbCW11nEA3FTQ51WDE6emSk/Ee4w/bAHXId+91WcJTieMMKPp9Ti7qime9CN9ZTMjQ64ryn6BGrsEmzT4TmawSb/obkx+l3yMB9FFdfFteh49EMXmFqrZX2ddQaTsBO9bVdJCDcbMGn4j8/SOwqjg/AVcXTQsDb2EIGlX7qvo2GXdb6UkDWAvfS2ExNL1q+gcEcX8BX/V2xSLJxc2R+SW+My0v2CV0OXZ97+aMurUIUbLCwru8/UhdWbZRGceFn8FZy+J1Zz61owUZ2v6ohh289ibECIyhmTvOWgkG/i1M0cBnSlQhluXYS/0GmeD9oiiTL+Pe9j1d218zT7h1ZOAtnvnlcFkNjhTuktK0kx5DeEtR1/eREJeM+nSYXayB+r37e+jfHnB3xBNtGMQhCey1lwLRLNYvqCPB/QoYA2TPE12JvKsocdneCzXHc8PSKXd3kasAF40ki3ZaBmtUsqmUcY5LSjc4lC2jbd9VTQ6QGY4rKGnyxg8DgUtn537LzbPX7Obzh5Z6eJ7xO2ta0Xx7OI2V0xKtFd1PH5JMs6U+wY4VhM4qzPI8EeVRmf1W0K34g63pfNbU7OFO55sQSb7gwJTr6QCtabKWlzvUSEMLPTRQbz9hdU9v1R+cz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS9qdG9Da1c0cjBlVE01b055K0JFanh2Ly8xdWZTcnVEYTkvemY4enZxaXNy?=
 =?utf-8?B?SXNnTnJ3Z3NuTG5UOFBQUUlqZklyTXhKQk5rUnBaMklrejBFaDhSbTRRbExF?=
 =?utf-8?B?WjJnM3NKTVN0Mlg5OFZrVyt4WE5FdTlPUGJ5V3dSOWZ5QzQ4a0NOZi8yKzJK?=
 =?utf-8?B?MDJwVW95NW5jZXlzL3FwaVR1OHpFdE82YzZFSmgxTUdIVS8zaG5LZlI0cWhH?=
 =?utf-8?B?WFNGRUh1VU1lZEdYcWRGdFpJakROR0RyTVVBWHdUdlF5Zzl6T1hjYVhLUk9n?=
 =?utf-8?B?ejNRZ0VxTUtXdnhsVmFiUkhuaVAxTncrNEpQTzJaRi9vOXg0QzB1VUdxSHI4?=
 =?utf-8?B?Tmh6OVFQbTRTbDd4eWlYREtFZjNhdFpxTjBRWnd4MU5TTnk5cEVZNnROcUkr?=
 =?utf-8?B?NUZjTjllazEvUTZ1bTFzWTBNdk41Q09sR3pReDkwQkU5Q0E4UG0rRGkrYjlX?=
 =?utf-8?B?Vk1BbEpDUEVYa29VZkpESUxPTEx2dElFTXRwcWdhRUVkT1JKUTU2TFFzWUlr?=
 =?utf-8?B?QlZTbmxoSDdxV01FdXgrQ0JxVmZLbWE4dGQ5bW1tY0NqMDV6RC9ZYkJsVDVk?=
 =?utf-8?B?SGtWTjdKRDlVT1B1SHBKUkFGcGNiLzdNb0IwRW5PZXdwREMwTHd6SHQwNmdZ?=
 =?utf-8?B?SnpCTzZ4cm1obzFaekNRTExOSnFHZXhBOFRGQ1dHdkd1OWJtWkhWcXlxLzdp?=
 =?utf-8?B?QjNqZStJZ3ROL2JwcTJQNFFpWER5dW5OUkhKS1ViMEUyTDhUSHRUaS81WU1x?=
 =?utf-8?B?M0hRa1JNQXZDRk5DSGJkaERYQnJzYkJ5OWhkZzNCOG92MHdONjZYeDVMcm50?=
 =?utf-8?B?QnNpWU9kZDZQWnR0aGF0bURHM2gvMHRCY09wenJ3UVdFVXl1UHpscDFnMTB2?=
 =?utf-8?B?ZktzZUs5K2hZR1FXS0lRdnRHamtXcEYwejRFTVVBdFZBbndzYnkzL0ZsSk8y?=
 =?utf-8?B?SG93WHJPMFVMS1ozR25uekhlR1NzeXBrSVdPMW9GNG5KaVZPUVM4UWkyNVhF?=
 =?utf-8?B?eEttQlhSSXJyYXdVR2ZUcndKdnVvMFZLOWVub2I1WWN4ZWZBWExRZUJqMUc5?=
 =?utf-8?B?VVJpRndNamc5alduOVVvUGxBVkFNZ2JWWUdmSHNVUmhzMzUzVEJSWjFjanVO?=
 =?utf-8?B?UlRaSm9Wd1k0ZmJ4bVpzVG9BbXJFR2NjZnRzVk11dC9ZV3ZMdkRGQWxlNC9F?=
 =?utf-8?B?R2VaTGhQYWZBOURnTlJ1K1JydVdZU1hPRWp1Yll2WXJNR3JsMytHT2gxbVJK?=
 =?utf-8?B?S0kwMVlTZ09LU1E3S1FrR3Y5WGlxQVFCSGVsdjFOYXVyUXNCN1VURm44RDZO?=
 =?utf-8?B?TmIrbFpXSTBZV3FPeWlFaXB3YzFhWWlxSFNQVzNlWkN1c0Q3Z05ZS3ZLSUZk?=
 =?utf-8?B?WXdmTURGcW5Va2FacXoxNHhnWEFLdlFyZXMxU3lnUW5lR1RhV1BrNHM3WHdj?=
 =?utf-8?B?Z0dQc3FXcjU0dTdDdWt6eHgvOUVkY2tJVVdXc1M4Nm4vU3pXNG9hdVpvNlVT?=
 =?utf-8?B?ZTlWYzZVNkdubzQ1ZHRlTUV4TzF6OE1IeHRoTGFlYnJZQVJzZDljQ056YjBB?=
 =?utf-8?B?c1lsNElId08vTWJvUnV5M0JTUFk0VVpFYmFvaHB0U2N0bkIwK29GM0JFVGVv?=
 =?utf-8?B?cXhUU25DZTFHR2laaG5kM0JrcDlrV3BjZjY4bkY1R2N4aVo1ZnkwdkNBaHFl?=
 =?utf-8?B?VThVMjJXa0IxNWdDS2NYSGVkVlRhRnlwK21CaUpxNEhGZmJjZnpGU0hBVnln?=
 =?utf-8?B?M045WU5ZTlNqWXgwR3Z1YzI1Q0txMm5QVmNPeitiMkNPYVM2K1FWUmt6Z3Ev?=
 =?utf-8?B?Q1E0ZUtDWUZvOTljNS9FYXdIcjVKN3lqZlBzM05hd25oUmV3bUcxS2JPM3V4?=
 =?utf-8?B?cHVTdTNpRU1BRE9hdUdsQmtNMGdFclNyUzh4ZjRPZmQ0WGNOU0FjR3lvb05C?=
 =?utf-8?B?ZHpKNnZ1b2FZWVFZdVZjT0RPcG5IYnZlN1hydDc4ZjhVMGx6S05NMGY1WWdk?=
 =?utf-8?B?amZOUTN5M1l4WC9YTDlzK1RWM1hkbkN3a3VxNURjM1JYOVhHa1c2a0VnQ1Nh?=
 =?utf-8?B?RStuZmEvRlpJMkozRU5BTnNQMHB6SHVRc0RHYWRTeGVjV1l4Y1JYVmRIeFhW?=
 =?utf-8?B?MTBBTldUZUhoNjRaVVpNUXROb1h4cy9aWkJjQmg5bFM3SGtKQUVFYTNUYTJr?=
 =?utf-8?B?TmxBMzVsSnhBaDJUbXVuZ05lMURHdWdEb2pTRHJSRTgxeWJUNDdWaHE3bGZ1?=
 =?utf-8?B?bmMwM3NRdUoxemk3aE0wNXZTTmwzVVpEMjF5QW5WNVlEeFhubmRBVGRkTnhz?=
 =?utf-8?B?TTkrNmFnL3pyQjRQWnBRSkhIQ0V6VlRFZkJjRVN2M0lyTWRFd2s2UT09?=
X-Exchange-RoutingPolicyChecked:
	NLd4Reea8Ol1+//PgK86ri5NY+jBnr+fbiW+kVFn9fKi9ogwfx6oe9w67gQerVZksGuoqbfhX0BVmO9bNomghhCamm+euRmwEDqb/pvocEgRgs0cZupqg/7HX9QPcKvBs+nt9wXOYJra43jEgcghxv4WDuuZpvo9eFSOGo0E5CoPzFniLkoKzKPC7B3iJxO+5j/yAP4deJ3w43J0azwurW+ZN97VHRYvzljLhm8gabJ3rd8fMzaHA7MybMv4tdrabr2CXGTYjpbJklZzW3gHxBrJENvwthQI4y0ZeD6p9d7ltVD7sfkz228uXIl1FAJiTD+SCCkBmRpuXXbC0FoNCw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o4vuVvoMg4qu/YtP6kSiE2kDmxwc8xgxImpMw3ThD96Yu67UNfW+MpzoDmEjan8fASFhXewQkjTlG0USb74QWdzS7nTeGnmSeGl6JhmMTINxN1a9XTG7Prm2JFhExC/DsOoSB2Eo0oxDgpBpBKyJJU2IaQzDeOSpzcurHXvAviZ/kIngq3ycH0fmvTe4bS6ffKUOenkS9CJbPqSNLUsblyU/zG4zsZcN0kj1KXKdMdjJ1umOnHb6fjPhwIFkVHMcQTBg0FFuJIVlGn0pSZ2JnGAh38X+x2otd2uK7uqfhj2NPNOnKecvqXrFAD7v+TkELeUltf0FdwT9bGEyN8grKtFN9ODNUNUYLrII+FdYh3ReaTSmEtseoBuk0qFQvG6sIhtdAx+/P2rHCFVV+ypsbwDw4MMhkQlR2zYBZOd+WsLU9oXC+8Oi7L1dX7RIrhl5JEVFCsAPU58ZFdqEUpR6Ohnp8mj3+XRw0AeoRd5kQgtNBqtmJueXkFmW3x5gNHftU2mSmR9IYKAB8GTUd2powA3x3BiM5indtojJVQZBuMIZ9cxXg4fUJEkfjoj/zFjO8ogcATuH2NbwVFX2NKS9DQPJf7dlBlpc6oYZq4Fdl5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c1ac97-c17d-4427-7e82-08de8bac979c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 02:57:32.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aDdgEzYAKW7LUmDuQpLN+flqkCw6IGiLFY+TMtuV3T3Hb8HTi4LgAHYB9gX+Gb0i6k6+faNL0v3WHNOM8lCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF61A2638A8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603270020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAyMSBTYWx0ZWRfX302unBrJDRJP
 qdLfIlJpBHDV0vKpa5qNJowiBwf+cId3ix2yEewCPtIo9zXO49e23tVON2RzrVvyo3DSt8PM2qc
 wCkJtymNAmsLwW21BTZFgYsSocWJA+ewvVKb8mEKMV0I7f6e3QKojTW0azKNvqmgMgi3BdDyee1
 06Y3hXUlyeaFVomPD45s1dalHvv8CQ85tcho10oxgpHE3yNqhtcUS2WWUvr9EP24sYK9kdGRJ+M
 6konraSahax9ijGVEAdutIeScTNkBO0z90RRNQ0HXBDUsiFRLKZpzIrmFpiJjuvHhUHZm8+6xnp
 pgIqPUSIsPeBr82vVVH5xAk9SNQgCIes3WixFz5shmnbape/35hUcXp0SSpieL0LN1x2dFEhSvr
 9ox7sPOaiTH0LJhQnKKXMyymp1lPz0l0x4KfEwSkvB3GkuT6msIXauHTB/A8wn/1HKTro9VCGLj
 SLmk+mMD73TpV6j4EFw==
X-Proofpoint-GUID: 9rRUpiv8-Opf_yUEcMuquniQCF51j4u0
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c5f220 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=P6JkxrBpAAAA:8
 a=F-a7W6U8YhPLQpv7Om4A:9 a=QEXdDO2ut3YA:10 a=dwOG0T2NmQ8MtARghG3a:22
X-Proofpoint-ORIG-GUID: 9rRUpiv8-Opf_yUEcMuquniQCF51j4u0
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20442-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-nfs.org:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D9FF233E9BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I've applied most of the outstanding pynfs patches, and tagged and 
pushed pynfs-0.5

There were a couple of patches with which I'm having difficulties in 
testing, and I've emailed the authors.

If you have submitted a pynfs patch which doesn't appear below, and I've 
not contacted you, apologies, and would you please let me know.


Thanks very much indeed.

cheers,
calum.


https://git.linux-nfs.org/?p=cdmackay/pynfs.git

Bryan Schmersal (5):
       Actually reuse the slot only when the sequence op gets an 
NFS4ERR_DELAY status. Before this patch, any NFS4ERR_DELAY would consume 
a new slot even when the sequence op was not the culprit.
       Replace references of non-existant StandardError with Exception
       Use constants generated from the .x file for NFS_PROGRAM and 
versions.
       Add the ability to have NFS3Client connect using a secure port.
       Allow max_retries and delay_time to be passed as arguments to 
compound()

Chuck Lever (1):
       Add some tests for unsupported fattr4 attributes

Scott Mayhew (4):
       nfs4.1: make serverhelper() deal with "bytes" objects
       pynfs: add an option to forcibly expire clients to the 
serverhelper scripts
       rudimentary CB_NOTIFY_LOCK support
       4.1 server tests: add test for CB_NOTIFY_LOCK with an expired client

Tigran Mkrtchyan (2):
       pynfs: add test for read with delegation stateid after close
       nfs4.1: mark slot free after compound op complete

