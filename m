Return-Path: <linux-nfs+bounces-13341-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2FB175F9
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C001D584F48
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61923E325;
	Thu, 31 Jul 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YNEQzc/g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="APEx054m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60781632DF
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985422; cv=fail; b=ICkzWEZOk+JiMfaoDzFZ3cjPF1q2HHxDOtZ5fr8ZXTrZaPi1TNgD9Y2xFuAPc+Ene2b8YVxTq2kx2QaFLZj6GvDRqWl9M/O1lhm7AK6OvQf1/Zzo+JFXguJAOC3bDph9bctlCyeXcMIHOZm78P5piQnq0BbC7VhPWTKorEawYro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985422; c=relaxed/simple;
	bh=ZRyBkFatWBZ4GY7OSObTUpcx/4iz5F5g0DacM9Zl2pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/bez9xoIgt5s6eZ3HZHFxWqBV/MOcDqb4Dhr+OEO1sPtfLa0oKg3ysIaRlFue/k+o5G/CX+82PAqu+fX5baAzSHvLZuWXIezMpOzNHS4YalAvljbNNeVeSRK8WCubUk4Uh19CR+AHLvkjdGu+NQIpYKFfN+DdEJnpq+oMFLghM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YNEQzc/g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=APEx054m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VHg1Hj008040;
	Thu, 31 Jul 2025 18:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oVIqvu1Ft2MR10f4A+REZTRLjkocZ2RuL4Kg7Ork2cs=; b=
	YNEQzc/gU54IRxSDkUqG4S8sFWtnFPRZYU4KeYRwXv7BcRWAEeaPb9IpabJYIFm2
	mlbvDJA/rISOCFTg/Jk/FZfTTXFmjOrOI68IbzOE+ZEQbl7JnL3x7ABStP5XnYC6
	2/4WLCb0oFwnaEgZjZyJU3N4WJyOKcH73XXRGVCP1nmkxIbT5goU9rJIgZlY1RCT
	y0MJvgoSNR19Ym54niYCCXn/5i9RCKBF4DfmSBTb2uV8O+Gd+Pk5HTZO7SicZAPf
	fHaS9T6soh3cQap0V6VeSFf4FhY13OS1Q0cGleqvgYq8wNCUPT14M9ByMoq2mO/2
	Fmp8LrEb4jdJlXqn6OIuRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ymp4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 18:10:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VHvpDk034533;
	Thu, 31 Jul 2025 18:10:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfd1qqs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 18:10:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPvOFp9Dd4baubz/USwUW2293h4GPOo4hntNnB/+RFagaBMdvtJfwcfnncBf1YuvhaguMXDpwpzRf7ZY+0vpjWArtL/HTi5IqwSXKtW1q8B/1dY06FgzrTvmtXfL1GnDWlQHqHxpwag85b2SfawlRe7t4m0uLWNzflUfPosLlpS1OzQWtTIJrToTEOwKNBnWJPe0GDrGb7PIh4BRU+d42J9kA4duHUy5c1VE2IUSfLu35pljVD2KBaruwtoKdR3aBI8u7tCP2d6xlnRGHcYRAcvMN1CPyqokn2R25/E3a99TMyA2iJpRg2I1eB8qltICZNtBxWq3N8psNlHqYQ5+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVIqvu1Ft2MR10f4A+REZTRLjkocZ2RuL4Kg7Ork2cs=;
 b=OyoFZLjs41jFHMZtUMnYWCuypbos7toVU9KZ4i0n+3rvFmCEDCGdk43vvVIaC1ldcfFpuP//WI7+PQRGSR841VxBaAMv4HoN6fFLgnqdz/vqhOeVXwMuqUauTVI93ipkeZr9QC6Jn/AD2SXP/23sYJJbKp+oYD4R56W1/Tu++BtU3/1BI98qO3JLpYRIwKpEYaHoxf8alB5fbNjfcyeP5g9N1otHG/zyRHMTwngnUdwP3idWGmITJ+/PSDzvqotUZjwFmBGXMkIbYDT4QIeaJou/9HjwZFqVjU5ijtDPe09NGa/97UnWzyZvugzpgLsOP/FtUykQp8xm/PeZ+mcVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVIqvu1Ft2MR10f4A+REZTRLjkocZ2RuL4Kg7Ork2cs=;
 b=APEx054mAWAoI6+OYhLHnqXqIOBPNyo10Nm0M7PdrKfzPYGBZp7lSx4O0VfVGvQU7qDAU29T0XxHuOBEZ+HYF7ENP1pMgeZi6n2x7pupMOp81H/oH8KaHfU2iTCMluE11GB5v/oPxdir1VjnhfTxnYAyvOOuIpTmptrEE0xP1ZY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Thu, 31 Jul
 2025 18:10:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.015; Thu, 31 Jul 2025
 18:10:11 +0000
Message-ID: <bc045a5f-c99f-47f2-8d48-ffce7befc7ab@oracle.com>
Date: Thu, 31 Jul 2025 14:10:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] NFSD: rename and update nfsd_read_vector_dio trace
 event to nfsd_analyze_dio
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250730230524.84976-1-snitzer@kernel.org>
 <20250730230524.84976-2-snitzer@kernel.org>
 <19f157f743681fe8bb28279747248b0c3ca7b81c.camel@kernel.org>
 <aIuiK06UZpIlklFN@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aIuiK06UZpIlklFN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 799b9ec5-4c96-420c-46c5-08ddd05d7d5d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SDhIdDVhZ1ZtUkE2RjZtSHdWSFZtOWd4ZFBWb1crYVhUOUtsdFJKL01laW10?=
 =?utf-8?B?NCtpSzJsVFJUZXhjUk1HbllFY3o0WFdReE5wU1h4eHJCSm81eVFzU082Zi9Y?=
 =?utf-8?B?bUk1bit5WW1aay9SaktERXhUQTFvUlJ3WGNnQitObEh3K3VYemRIanhZbHEx?=
 =?utf-8?B?MmEyN1dwODFLRTFSNGoxNWlxWkgwS2E2ZStIeHR1eHE5L3pwZHNtVWduTm90?=
 =?utf-8?B?T3NFRVlIRHBsbmNMc2UvUEtWd3FMTG5FeGJoMG1DOGVCTlBlSVp4ek1tL1Rm?=
 =?utf-8?B?ODRyN1l1UEQ3cDBPNnhGd1V0Yi8rSmVPMUFYV1REcTU0NzZWTk5zTGdYaUd5?=
 =?utf-8?B?VXNCVjM5ditTQk1qekpYKzVBNFZLQUZJdHpsVjdEMlJRbmwrNVZNK0RWSHVM?=
 =?utf-8?B?WkJTVmpiTHZYZU5UNllqRUdYOW90SnlOcWFrZTVYRS96cXJTNHBWNkRyM3Fs?=
 =?utf-8?B?UkxRUTF1ejBMQ2p6TU9SQWVVY2hadG5yeVQ0YTlldVRWck1VSlFzZWtDbEg2?=
 =?utf-8?B?VXZLMWYyNVBvSnBoTkZITnNJOHpJNWVybWY1WVgweGRoSm5Jd2twSHFtcDhP?=
 =?utf-8?B?L0pIUHdQWURQbEJJV0NZZUVtK2NzYVdVVERiaFhmVjhHa3U1Y0JzcXBQbVdm?=
 =?utf-8?B?NkhuWDZWUk9SWmNtYmN3ajRwTVdhbWJLNUt5S3NDc1A3c1lyaGpzK3JubW1q?=
 =?utf-8?B?VldGNGM1TytnS2hOZnR1RUY2RWlHd3JQYVpDVXNlekNRQVlCS3VGd28ya1JO?=
 =?utf-8?B?cmJvSENqdG1ITXh6MWhJRDl0Sjg0L1ZCbUEwZXA1WndZZ1dRejFFUTRqMkg3?=
 =?utf-8?B?RXdGdjhUSUh4M3YxaVE3MnNLcldxbFlDZTVkMlFvQjFldjF3NW5IajVoQURJ?=
 =?utf-8?B?WFd5Ri9QZmlpVGF4Uk5OY3l5a1paeEJKTDlHS1pDUUdWdE9WcGJtbVQ3T1ZC?=
 =?utf-8?B?Y0g4LzVHSnI5cEpEZ014L0RjOEN3bVRkUWYySGxVM3NaTlJaL0xlSk1mUFZV?=
 =?utf-8?B?dkV6bU1INXoxa0kzMEx2U3lyVmJBZ1N3bndlbEJHRy9KZittaUNySTc1QnlJ?=
 =?utf-8?B?N2w5MTVyaisrUW9EZyt1cmxmQ1hBbEVUWTZOZ0pJN2VkaHpzZ2pHeW5FR1c2?=
 =?utf-8?B?ODBVSXVEcFpESUFWS0wzSDduR1M5VWRSVVNHeTBNRWdDS1haQW4zMVI0dE1X?=
 =?utf-8?B?YVJiZm1nTDVWV0dBaDhmWkdvNnBRMnZ2Y3lDY2t1SldtNDg2YzMwVkN6L3gw?=
 =?utf-8?B?a25kM3JCR292ZnFQQmdmSWU5SGRuMGFtS0xISnpJY1dxOUI0MEhwZnFwQWd6?=
 =?utf-8?B?RHljR3ZOenhzditDeHZoNXVIY0drR0JFTTg1VXpMNk92UjdVT05GN0g5cjd2?=
 =?utf-8?B?SVpYYUJHdVRsZHBwMTB0THM4TU5PSnU4WWlSYWVDZmdmU0huTm9ySjJOb1ZZ?=
 =?utf-8?B?NGc0ZjdZMDRCbWpWSm91K0Yxak5ySHFOMzBjNFRNY1dIOXhicHdrZG1wQ1NK?=
 =?utf-8?B?a09UN2kzRDBORHhFKzMxR1FzVVpBVlFxQmpERFRyT1d4d3h5NWJ2L0NLcWtw?=
 =?utf-8?B?M2JOY0hJdStwSnU2VHNrOXU0NkUzOXY4WVo0YnBpWFlTOUo4OWxjaXc1L0tw?=
 =?utf-8?B?UzFIUU50dWphRkVrTm5jWThUcWt3aFljNS9iUVMrMGQxMXBsNlNiK2Fma2py?=
 =?utf-8?B?T0lPd1VQNlNGMGppZHlOdW1ZdzBYL1lYclFsZ2oxWncwU3FWOU1wRjNTcVZJ?=
 =?utf-8?B?UFZoMTlVd3JnSjc0UzVMTUlSQmE3ODh5ZUxyczMvUG16VVI4OFh4aUpkcGZn?=
 =?utf-8?B?R0lobWREcURHYmE2b3JNOVZQQXVvZzUzbXlQdEtqSno1Ty9ucUh0QnFId1FF?=
 =?utf-8?B?K1hZOVBsUHFEelJhSmRndTkrUU10WjMyUG1RVTJZQ0dpMUhBMk1XeUVjazJM?=
 =?utf-8?Q?D3xUZVrp+UU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cmNKakRlODhCTmUzWFR6c2lRL1NnN2pDcklvN1huMlpDRWh1RURqeE94VVJX?=
 =?utf-8?B?Z2pWVGZyZXRUVWFTRU9rZFhUWUNKc2xnY3hoY1ptWkpyOG9TOUVUSldyMkpC?=
 =?utf-8?B?RzZVcy9GTndNb0hvajIrdGw1R2RkZE1YbmFzRmRhc1AwY2tHZ2NsM3RiMUJ4?=
 =?utf-8?B?NmdUOXBvbTdNZnUzTWVSQm9vWXZRSENDK0FPUFFCVXdYTlhHVWtoUmNjSjVt?=
 =?utf-8?B?OGY0bW0rRTlsOWRiY1JGb2RndlZLeFAxRFRMaXNHSUtxM09GdWczMHVuTmZ6?=
 =?utf-8?B?Z1RUZmNydlNTRUlVOEViVTRYbXRHYWE5RHI4VXd1bWRmcjZnY2V1RlhZY2Nk?=
 =?utf-8?B?Rm1rZjJPdkZKOUl1bU4zbWc4ejJJR1ZpdTlDWm1DQ2xSZzN6Zkg2Q2EralpK?=
 =?utf-8?B?NkhoeVB6ZXp2OXFHVHVrd0xaR3h4VTMrQmlIclIwMVh1ampWeUNUL2RTNFRE?=
 =?utf-8?B?M1JnYlNDejFBY2RJZWpsazd1L2k5akYxbG5mejVQbWNZbWNuZ0dLOVFvYnB3?=
 =?utf-8?B?NDVtY2tpcjBGWjFBSmVDMEFUOVE0ZWEwVVFTWFdVNUVYaHFCNVhwKzZFOFZN?=
 =?utf-8?B?aXZ0cnFLRTBlUm5zRTNUWmVpVm1NbENlMDNiV3FpMnJudW5UNlh4VHFTM3M3?=
 =?utf-8?B?Z0xQUm9Dd1lQNWIzeUgvWkJROGoyRmJOYzdadmp0a3FqNW5GNS9NQ2Z0Ujlt?=
 =?utf-8?B?c1haMjZrK1lISTVFcndnVUlpM2FvaHhGRXRMV2QwRHRhRDBGZ0szeW5USHZM?=
 =?utf-8?B?V3hla2dyUjNsbWdCLzdUalN2R1dCK2p2UnM0UEpNYWxIMGs1dVBoZVBsRTU4?=
 =?utf-8?B?OGs4MVFOYk54Tkd0eW83UnRnRlBWNEhpdDlXMklPZTRrUm8wK0F1MVAzMEpm?=
 =?utf-8?B?SmVVL2U0YmdnQkhpbmx3SkV2TzU3cFFlK1pnbDcxNTJkalpjRzhvVnBEeUlq?=
 =?utf-8?B?djR2ejhVL256RDdUWGtzMTdHZlFvTjlDTjV4NkorMm4yUC81d3JtY09BSzZM?=
 =?utf-8?B?Mk9icFV2NUZPK2RwREpTaWhEVGhaTFBjQk50bFFiUDBIcm9GTWdPd2luSnFR?=
 =?utf-8?B?OFVaU2kydzBUNzZxWVFQekg0djNXN0FCVjVyQmtVTWNzVTVCZ2IzTzhhN1d5?=
 =?utf-8?B?ckthMVRGSkxUNnNpUk5qdE1pNHlqbmtMZ01kZlRKajFsNTB1eWh1aGNndTcx?=
 =?utf-8?B?VHRTMEtkNThQeEVJVGVqUEtoZ2J2VEVuQ3dVeXdVanpOOWZyOVVkM2VnT0lz?=
 =?utf-8?B?YkRiMWRadmJsbjk4RHVPZGVDaDE5NVV6MTJ5NHBOcFYzUDFxZHcyQ0gvSjlM?=
 =?utf-8?B?RHdGelNVcDc2aExwR3JCRUhwNURZUXFzaVpXMHdaUzFtSzVqREhibjFyU2I3?=
 =?utf-8?B?ZjFPVS9VRHNEZm4xNEprL2RyQTFyandROWhoMFJzNUhBaGhOV2N2LzFwUlZ0?=
 =?utf-8?B?RW1hWkNySmIzemN2UUNBekI0dzQ0QzBaQWw1cmNUaERLRzF2UVJnSGZ3Z29B?=
 =?utf-8?B?ZUJDWXlBZWh6M1RUMjNxWlorMWp3VjhUZzU2a1k0a3lEMzdKRzFHZ0prbXN2?=
 =?utf-8?B?Q250UnliQ1RtdklKbDBuNUZCNG1jRjRYeWllR3Q5TWR4Q1A0RlZzMzdlQzZF?=
 =?utf-8?B?ZGVSbWlxOFJydkdPZ1FySHNjMnBkN0ZiM3p2bnFmY0s5RFJ5K0dhZGJqWXBJ?=
 =?utf-8?B?eGFKcVAwL1NmeGhtU1V0V0IyVCs2b1EwWGhrZ2ZMR2l5U043ZUpTUTQ4cENo?=
 =?utf-8?B?Z295eHRUVTBoZlhlM1gxMjczdTRsYnFORW5xeCtsenNiT1FVQTlmcEp4MVZT?=
 =?utf-8?B?Sk1nVldwcVFMMHp4cTRRYnpkYndXMkNyektYS29acnRtZHQ3T1duenF4SEdN?=
 =?utf-8?B?ZFFVakxPL0dWaE8rMDU3cDh1UnZsc1VFQ0xhd0lsdWoxRmRhc09hdWlqVWd1?=
 =?utf-8?B?WGJHM2hBZ0JQc1JvMlpQU3NWd0p1bFROMTBWeXM0c2FzbkFISnc3U2tIcEhV?=
 =?utf-8?B?ODJMQXBVMlZna1ZuVUNzalVlck9IMkFqZjRHVGN4REhtZ3NvNi94dkF4SW5k?=
 =?utf-8?B?SVE2OU43YitlNnovcEZsWktsMzQ1WjBGTUdGL3JPR2NnSHc5eWdSYWNqY0ZN?=
 =?utf-8?Q?2eGz4PCbeHvRULBlCSetxmjDr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AGNmqfunjGtndVYH3A4ufIsHzkbjQx+TkBaf7r7cGHfHfWNsKkui/FK4OJnJZhUghKc4ujuq2yc651NBW+KglG4CEDzjBdtJNYS6Oom+WVP8h34lr1SLY5HpaO6kUSx+OnjJSTN09I7ckzToVdyBmF+NaK4ZuINZUdwOJL8/NxGH/kKvTAsN3/KManJ800eWewOb/hQMP4fLZuFqar9p7LriHCiy0RoWKoQJV/+D1Q6vUQIfyI+86rm/yiqkCVkAG5WKLW/ZaC2wEc0BCHq4mIujoY4VVR3GydvLlKN7ojePo/cnNKkiFmSh/hbs2Dp+PdbyAcf6LLq9mnUZcPVqNaMRdBEeH814syM1JGyNfttdGWVqPRGwePIddkLD57ooKtR9mHarLdiY747J+93aEkAqVOLgsyLyiHManNSZLiqWbdAPAC5pcSnUUvXqkAZh088SaAKxCXThV4zrRTbOuLkNTHhRHBhDD6plbV+G79O9Se27oIr+4q3aU1fYR4YzviQ8UALVxSVIdHjhWUwOREFg4EkI9lqhBOamWK0awLBLUrrGWhlO5ZqU0ZIRdEL4KjY6+EbMGo0m7Fh2dnHVIAqxVt9QNEugxLzjPxF/O6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799b9ec5-4c96-420c-46c5-08ddd05d7d5d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 18:10:11.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuIQq6aZRx9F9mgcPCqnU0kARewe4tiMOsuW52ebC23ecTEGS+K3yEfqoBsWS1mssA5anN4AkWb4cFDMDczSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310128
X-Proofpoint-GUID: fUaELljBd3JV8Z_g3WbCBBH7sLYv7E7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEyOCBTYWx0ZWRfX5xD8KRXzrlB0
 FckYtUCDsaG9nR3hYL00+M8NlEguzeIMyKLV/rGYZoFsnJaVEbJ6y2OCtveJE16HvuJxQw9MgyR
 tkl330UW6ZqzE6GCtfW46CCrnO+fSY8GiVmxCMXE3ga3VS/mafsOGdqJg8nEtrAluRy3xBwEQER
 AKgqY8kzyoLM92Ok5+ZXJwtg22W3zmHdkKPSke3FxzrSFnDBpFN4Wbv3P+P9G5JG9J/0Iy7OXdt
 ZlCLSEjVQ0OorpDhCFoFPPGCcNkkdWj5O47kro0EDmX01HuHNHSX6FEGRIQSF1dy3vfaFZM/cgu
 ctcyt8OimGyO7CNgNU0ht4LLvynPbKdWy0fmy/fuy6xyaPB1AJJi5zyal994WDByzx8XF+eJkOg
 JhNhV91KEREPMqI9S3O7iktlPgUqmp3NiQbwYHgg6qqisr8UrH6QTPXnuxVGG69jBRSHL0y/
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688bb187 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=wBKtno0RcdvzKBhnjBMA:9
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-ORIG-GUID: fUaELljBd3JV8Z_g3WbCBBH7sLYv7E7k

On 7/31/25 1:04 PM, Mike Snitzer wrote:
> On Thu, Jul 31, 2025 at 11:31:29AM -0400, Jeff Layton wrote:
>> On Wed, 2025-07-30 at 19:05 -0400, Mike Snitzer wrote:
>>> From: Mike Snitzer <snitzer@hammerspace.com>
>>>
>>> Rename nfsd_read_vector_dio trace event to nfsd_analyze_dio and update
>>> it so that it provides useful tracing for both READ and WRITE.  This
>>> prepares for nfsd_vfs_write() to also make use of it when handling
>>> misaligned WRITEs.
>>>
>>> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
>>> ---
>>>  fs/nfsd/trace.h | 37 ++++++++++++++++++++++++-------------
>>>  fs/nfsd/vfs.c   | 11 ++++++-----
>>>  2 files changed, 30 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 55055482f8a8..51b47fd041a8 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -473,41 +473,52 @@ DEFINE_NFSD_IO_EVENT(write_done);
>>>  DEFINE_NFSD_IO_EVENT(commit_start);
>>>  DEFINE_NFSD_IO_EVENT(commit_done);
>>>  
>>> -TRACE_EVENT(nfsd_read_vector_dio,
>>> +TRACE_EVENT(nfsd_analyze_dio,
>>>  	TP_PROTO(struct svc_rqst *rqstp,
>>>  		 struct svc_fh	*fhp,
>>> +		 u32		rw,
>>
>> I would do this a bit differently. You're hardcoding READ and WRITE
>> into both tracepoints. I would turn this trace event into a class a'la
>> DECLARE_EVENT_CLASS, and then just define two different tracepoints
>> (maybe trace_nfsd_analyze_read/write_dio). Then you can just drop the
>> above u32 field, and it'll still be evident whether it's a read or
>> write in the log.
> 
> Seems overkill to me, and also forces the need for user to enable
> discrete tracepoints.

Users can enable trace points with globs, so that's not a big deal in
most cases. What is more important is that, when you define individual
trace points, you can enable tracing for only reads or only writes.

The common trope is to define a class, as Jeff suggested. The I/O
direction is then recorded in the trace point and the extra field
is no longer necessary.


-- 
Chuck Lever

