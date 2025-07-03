Return-Path: <linux-nfs+bounces-12883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2DAF843B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979B118905E0
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0B2D3753;
	Thu,  3 Jul 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVnhXEnl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DV/fzwKv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B4298CA5;
	Thu,  3 Jul 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585295; cv=fail; b=d1SwCdScSgOyhVCmYgCsD4EkLDOQ5bwAdsNyRI5THWLOWRZPNWwZxuy9Bwp0fZPQ9dAI8GhnuFNTMRY6rYJbJttqsO+1WhLT8bwf72JDkWGyCDRpHa0QyWWO+EYF5bw/Eq9k55t0Rb4/lsj0A3Hp3t3+lOC7ZguJN0XaBybtoIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585295; c=relaxed/simple;
	bh=hSqtNCMYaH31vyWqJ7BCuKimL+vOClfPNSOlMRaTlqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OG0tfI68oaVM1I3BQKjIg9Niuf+Ntbt6TozZ5GjNJS9fEjbHOiTJbrq0ETlJRoxVoVRYV7AhHr7Zp/9HQdgWxa/NADAJwCfP+vYCQNsjPjR4WQWvP1unMVAYZweEf1RwEDh72Oy+AaisJ40vtH5a4VPHT5HbyvsUU8O6qJAS6Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVnhXEnl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DV/fzwKv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563LYpUn006216;
	Thu, 3 Jul 2025 23:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sWozp4eHgN/sNPafeRwZJsALjCmOSOTv9o/3pDZA1Sg=; b=
	RVnhXEnly+Cu8W13xjYrabakvFiLCTayXQHE3UR6SjH58E6ernug6/derCF4JbX6
	3HA4SiKJCH9UxFUpGT1aIJEzQsuL5P4N61BLBbhnnU1S23jL4KaIHCaUwTLjF4IT
	CyTctDwXerg4iwzpWeTqVQ0iujoFo9FO6I69SAKDgz1mFO/9xKCnBdZxwnqK297J
	TK8xfyTRpOR1FwEAb/mT/WKpHu7hqywsLuq5Ajwz93FGwcRskKgqSsMx3vsQ95xw
	uk9DGX+mNSU6U6VK0s/8Dh2tBiZjUFv1+JwmlYpyRJPHL/Woo00u1zW4kcZ1oIQw
	UMvgb0HGnIxMrAi2NvOkww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8efa0ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 23:28:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563Lje1h018807;
	Thu, 3 Jul 2025 23:28:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ud7c19-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 23:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6xSipjxNrazUZo4EmmXgYKUSrBAp1oQJamyaxzGE7j16q7wbae9MFjuq7y/C3it1RfQFz7xhJFDhyn5lpfIJqkWKJinJkK/bgLIIobO6yqWonP6QIY5lMgILikQbIgJyzXrj+QyKl33viiYR5IsVBZMD0AJkNMiXSSXgKtm064ZoqugwDiv2kvJ9zaNf0YcZYoLTFZP4p2qbfMzA/Hif++ZsQh/icAga9n6aoJjCi1bpsZgSfr2Rd/VPzWpr66l190nZG9qRwWE46E3xs7CgUoO36n4lhA9RogNPdwAXTHD4iVT0NoeT6u7cplBqhSyOPAEd5F2xhMWiz3rmFju/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWozp4eHgN/sNPafeRwZJsALjCmOSOTv9o/3pDZA1Sg=;
 b=E9AUSf0SR4YpSZA5zkivhzmICjtxhpgemaDIZ3Z3uwGpyWo1/2nHRBiFYmqX3n7LJoXCnTiS1ex1i2oOeDuu33p7u5wx6GsCSYOMEbDOnBaSDXLPY4yruzoAbC+MeU0479n9T1NbVCdv3+BFtG7pE4rh+nfsRwmR1VFW+FPDPOo/Sxl9V3qg23/WKbVLPAkWNZBVktlkvycmQoRkYU7KZHsT7mLFm9/EY3AuKOFyl8p4MpmxqaAh1K+bqXieIPSRh8oUOYPOFYtO7dAvhLZ8MiFlDwIvtQsMpgivsAdCHJG/Bp2Seb0DSqQZnVGxaDGmWpnExjGoJA1KRVazus32gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWozp4eHgN/sNPafeRwZJsALjCmOSOTv9o/3pDZA1Sg=;
 b=DV/fzwKvtjan+8Yz8X4mkZlNlART20y+8aFyCnLvuKQ0iepBTuVt4eMJ0KBts0r7r5oMP/QdVUWFpHwAfrhz9SPN2jjLZ0uu5+XxGHoM1x5uAcXaSEz3p2ognOhRJUtIt++ygQgEEIVVj+3KD+7pJj2RHvLV4UR3pb+8sFoK4hM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7772.namprd10.prod.outlook.com (2603:10b6:408:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 3 Jul
 2025 23:28:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 23:28:03 +0000
Message-ID: <c7268db3-ee38-425a-b524-da38cceb02ff@oracle.com>
Date: Thu, 3 Jul 2025 19:28:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] nfsd: issue POSIX_FADV_DONTNEED after
 READ/WRITE/COMMIT
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
 <175158460396.565058.1455251307012063937@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175158460396.565058.1455251307012063937@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:5a::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 232bb18a-68cd-466a-c52e-08ddba89417c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T3duYUVSRzJZRGVEYml1dnU0bHlDL1pieDFEVFRUOUs1eUZaYTIraU5qSHNI?=
 =?utf-8?B?MGJIRFFkcUJab1BPeWdGcEJVendwa1diL1ExL0VqUzAycm9sYjV0a1Y5d28w?=
 =?utf-8?B?enF0bW1IU2dmcTZhV0J5cGRGTjFmY3BYNGlEZGt2c0lrWXZENlRSaVdhOGNy?=
 =?utf-8?B?ZlpDQlMwL2Zjb1hXNVVVSjVyUGN2clI0TXQ0YmRyWW81SmI0a21LNUVZeitN?=
 =?utf-8?B?VDB2cHFPUkJzWU5FSklyM1UyKzVOb1A4WUh0RFhFZFVJanVjUkhSTUUzTFVJ?=
 =?utf-8?B?SEdBUEZBRzFwVFNDRlhUa3I0RUdsUkNwUFBocjYvSHN1c3h2c3NaV2NEYlg3?=
 =?utf-8?B?SlZ4SmMyU1k2bnVxVWJHMXc0VnkxTnRzZXJXWGtIWDRFdndiOVlWWmZXSGJS?=
 =?utf-8?B?dk0wTy9pOTIwaDlmOU1wb2VZeXQwOHg4eFMvbnB0RU9XWHBWRjdEdVZnY0FD?=
 =?utf-8?B?Tkxzd25SMG14N3d6dmI3UnlBbUNhenhMMnJuaUZ1bTlBOFVERzJydFBXMkFu?=
 =?utf-8?B?OWw3U0I0dUxiemlNYnhCNnpQVG1ydHllMGVxUHoyNGZHelE1eHdrVWdnZDJF?=
 =?utf-8?B?WHJhd0hYZ1N2WTlyTXlRMVducjBzNFhjTGlsRC9UaUtlOUdaVzkrdTI3Sm9Q?=
 =?utf-8?B?SUs0MEVvakpZbXBCNHhnZHhLUVZYS3pmWk1VWkhsNFJFVnowYmtLZUNHUXBp?=
 =?utf-8?B?VVdjMlF3QVRFM2pVQWZCVFArcDJKV3BMVXZWaENHSGlvQkJIUDBmUzBXWE8v?=
 =?utf-8?B?UmtzOHJuUlNLOEVwdWFkSlFsendGTHArRzNjNHZtbUU1ZUdQMDE2Zk9DYXRk?=
 =?utf-8?B?SHFlcGZEbUxtTURjaTBXeEErUUEza3JramxGYnhkMHMxL0xhVmZsajZRU1RJ?=
 =?utf-8?B?aHVDbTBuUHN5dUlWUHpBQ3BSKzRWb2d5YnNXa04xZUVQVjU4MnlFanRFd1JU?=
 =?utf-8?B?elhmSzRNYWlMUUtVc0I3VDRVVEVRRjBWOHJuZ20xU1dMSnJCUGRUTCtQeEtP?=
 =?utf-8?B?RWlLeE04S3g0Y1BQQ3F4V3VyQUl5NS9WbC9KdGdHZ3dKQmFlbUZvUTBpSmZQ?=
 =?utf-8?B?d3ZBQXhIalJ4Y2VEKzExOE0zVGl3Wnp4TFg4TmRMcmRNMk10clA0YVVpSzM1?=
 =?utf-8?B?bG15TUZ3NjVxdTR5ejdlVG5Baks2ZTFGVWd3VHZ5d1JYbGJ6YWE1aHBYWG9a?=
 =?utf-8?B?a010Y044aHVicHVxOVR4OFJpZW1WK3VTUy9GUkhKYnVsc3VKenRDVEZiU0s0?=
 =?utf-8?B?OGo0MzBpR0dkZ0JnNENoNVpEN2ttbTFEd0owckw0MHduREVyY3NqTjFESHhT?=
 =?utf-8?B?eU9QeExxVGFNRXRILzB4bzRPc0ZxUHpnOHdLQ05kcmJlbDZGR0VGK2oyZ3Nk?=
 =?utf-8?B?Ukg0SVlid1pBTXFjMmJ4Q3N1QVZZdkJOc3RwWS9uaGFPMXljTmZ4YjhiRTh6?=
 =?utf-8?B?dTExT01zcCtjVkI1eVM3SFlHTUs4V0FWeUlFTE9DdXJiTlNBUzY5NVZwRVd0?=
 =?utf-8?B?V2JmK0o0SmFBL0dIMG8vY0lKN0J1SUFad3c2cytmMkFMaFJwZ3FwdEpaYVJn?=
 =?utf-8?B?VzdlRHJ0SlJSRG05dmhXOTBwN0hWckJsN2ZKbjNhTlh3OURVeDJEYVVQb2g3?=
 =?utf-8?B?alFOK2pKeTA0T2xNWHVwaUFiU0tXOTVFekRoaDlDZlpxU09rUE4wYmcxbXhV?=
 =?utf-8?B?eDYwbmU3ZzNyUXl4Z3JFSCtVaFlFLzJhQ0RCL2c2ejRaNGF1dG16VnRJdzl5?=
 =?utf-8?B?UmFwTFVUWW5FU2xISk5KRlhvQXNxV1RjaTh3UmRPZDJrbFB1N0JwSEVaajR6?=
 =?utf-8?B?aEpuV0MvYllrSmFZVlZ1eW5tdTI5L2Q3UE9DOEJlRkFsZFF0YkQzNlpuUkxZ?=
 =?utf-8?B?Ry92bHBJQ0wxT3BGNlhnME9tZVQvZnBlM3ZYdjVlNDJMUHloWGdRTlIrMGwz?=
 =?utf-8?Q?E9pc0iCbdQo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZXJHaWlYdmhXUmNsVlZPUjdpaEU0UEQzeGFjRzRERkNVa0ZvS2IvOGpUb05r?=
 =?utf-8?B?SC9VcDB4SWxVc1NvUFRzYWtDSStMMmdSSEdqYXgzV1U5ZzFMWHNudGNWMUVQ?=
 =?utf-8?B?LzY0U3E2U1Q5WmhBNUZwcUpRVUhiNXplZU91aTVxSW1vNmczQmtBUGtSZXRt?=
 =?utf-8?B?d1M5YzVTQ2hiVnpTV1ltOFAzQlpPSENESHpiekV5aTIzazZmVWZiR1dQUW82?=
 =?utf-8?B?ZVErb01KcTFHYUp5U3d2Z0h2WHNRQTJHb2ZOcFVwS0l4WERsL3JKVk9PNGFO?=
 =?utf-8?B?Vi9wVkVuTEt4aEd3R0lNbEUyT3ZwRENmM01nczR1bk4zZndoMnRVMDJYMTht?=
 =?utf-8?B?L0IrclpGTHlhS3BxS1QxblZhb2dDRnVqSlVpL01kT01kRXdnL1BCLzgweWxi?=
 =?utf-8?B?SW1FZXdmSXBITTV5SmZpVHE4c1p1WldSQXQ2MjVKNEZmd1NENXlBZFZzdlJo?=
 =?utf-8?B?OUdQeXpudG5Zd1RzMlBFUTRFUzVLaUQ3aEZrUDRZWXdMOWh5Z3lTSUV2ZTJ4?=
 =?utf-8?B?ZjdHK2ZDSVBNcWpDZ3dsTStEZXFSZUxHZUJDaXZtVDVIWURPRXNRdkJ5eDhU?=
 =?utf-8?B?NnVkTHVieUhSSWFaU1A2YW5keS9KRUdrZmVqQ05EcHV0YXZ0VTB3Y2x5eUlE?=
 =?utf-8?B?akN2T0hWUlhwTjlYdWhRQmhGY2NmNUJ3QnVFS3BneDhIZ0JjZG1yNHdCU21I?=
 =?utf-8?B?bTl4ZEY5YUYxcEV1OGFRNkx6OU1uSmI3UmJYcVZPaHU4bFhDK2h6c2ErdzdT?=
 =?utf-8?B?WkltdjhENEg5K1o4bnc0d2xJQmR6QjNiaXhUT3ZZR0t5V3VmZFpVSytrdDdI?=
 =?utf-8?B?K25vS3A4cUF6c2hwclJLTUIyby9zbmltdFp3bEpRZnVkQ3V4Qkp6MkpOS01p?=
 =?utf-8?B?bjFwV3BGNzBiak1Mc2R4c0xBa1dlU3JtOVMxbnI0MTR2WVVob0NpWEliZzNv?=
 =?utf-8?B?OUpBcTRIcmNjUm9FZjlUSkFKY3cvQis3Q0prQUZTckZ2bk9KQi9qSVdnajkz?=
 =?utf-8?B?dDZUN3ZRSytOVkUzOWNkVXhvWjV0dWVvQ2h3Y25mZnBRcHExNnlNQ0Y3S2Zx?=
 =?utf-8?B?UGd6UmNvdnJKcnMzaUozZk1ZQXVYR0JwYzFHcVNHOVlnU0VXc2hVdExZQjVU?=
 =?utf-8?B?L0RRQ2FGY0tPOEwvcE1DaDBWTTVkWUhud3VXbnZaa0tFUmRSU083RVBWaE9h?=
 =?utf-8?B?bitsYkh2ZVBheG9mTjl3bXh4cHNZeFJ2L1VNQXErTWNsdFNZQ2Z6SkVUSkl0?=
 =?utf-8?B?OVBISk1MSjEvNlVuN0lrS21uSjRweEx5WHU1SUJPRm5vamJMdDJOdXd3Z1RU?=
 =?utf-8?B?bGFEWGlGY2ZjSDBwcmV5WHNXMzVmN29WeE5ySzdyRXp0NWxkaVdSTmlGbWlp?=
 =?utf-8?B?UHd0eUFYNjduMUdEUlo5NS9Deld5TloyM1I0QlBkKzljcDlUL2ZyT2ZkRkVH?=
 =?utf-8?B?d0V5eGJ5emlmSjBScFlSb3JnNFFuQ3ZwRGYxUzZLRG00M08rRVdnRWxHSDQ4?=
 =?utf-8?B?c3dvelRGaEhPanJhNHZTYUQ2aEJPRXFNdkkzSFlTcG10aTJMSnhjR3pucERL?=
 =?utf-8?B?SHYrRVJiVzU2SXdIb2x0MGs2WDhWd281K2ZFUGZMUndPdWFoc0M4UjRYcGkr?=
 =?utf-8?B?bDVmZFdtY1dBOFh3NUl1OFJlY2srOFV3dHRESm9QS1V2cmJMZFBxK1pyZXk1?=
 =?utf-8?B?ZTlKYXVUNnhuYWV4dmNJenQwNUNPWUtWSHFLMnRZWkpoOWRLVGVZbDBHZWpW?=
 =?utf-8?B?aFE0cWhRcEVxbVR0eXEvUitaQ0J1VWxqWmRkbW15M3ZIc1VhNFpvck9SMU5y?=
 =?utf-8?B?c0E4SEloSmJINmhSV1p3VllVcCtGSlZNaERqUzlacXlWY0NNdVdMbjhzOWo5?=
 =?utf-8?B?d3J4ZVFWcGlmZ0JPdnlaRWhhZWdBcDg2dTlJTEdrb2paWm5OTnEwOTMwcVAr?=
 =?utf-8?B?Uzh5Q0lkOW9ST0d6aTVsdGg0cWJQbXhvT0ExZTY5YWJhbjVIZWQybExrM0tz?=
 =?utf-8?B?RG9abjRuMDZISHhXZWNSdEtPWGREVmk5UU9zYlpweGhvQ1RqZ1k2aGY3b2JV?=
 =?utf-8?B?US9HSVluSy8vSmFXWUNqa3lCOUhFd2xwb1NBMjcyN1RCM0VjWFdwcW1CczBW?=
 =?utf-8?Q?C/RX742DsC2qtjCrPjAAvR+IQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bJA3XM1ClMYzkviFy8wAHQVqpYuWJmWZEj0b1Yz197G77hfbBKszMmrp33Y4MxTQ3uA0GK/uhUSPnR0AOP2/CQmUmlwmQipK6vwA0gEQ81Ka5K84tNNwrUbYoTt//06Ywlxgk5YBeVazqYYhUHze3Q54aXL02xpVL9Rx9Sy2xvkfL5/nJycCNPsqparVpHU4gdNqA8nQKuhyyuFhjm+07Gfo2nGgjUA9yf5nCKLkNRX6qNvOeDPzgiGGEYc9goPm5ld5H0P0bH4FLwI5W5rWoXCuz5dVzh477R/KwwPAZN8+MCa8wsESE9kT+L/dD8qABFWrDVQDQJ4XwQQA0viuWcetiDm5czTAGcRlQI4biG3zXYkZn9dhRMLMa8nUcqQUKd37Q4DOi51d3gT1o8RVU/+NpJhJp6XXmapI48UAffxJFl05WmLUpxnd2RQznF0cLT8unkfm3HlXKDcOP/n6s0xjoEMaCj4IbFyqfvCkf9unzJy58QoK96cO2CUn1L+Cd6wYNUIQYUPHh5xjGrCH1qTW83TtBhz3WJ9Th1mqRv2ePgia+9JwScgzR4wpx6VMfRsIeVfZz3orT3890n1Gxri8mMnGm0XFuShAeLtdTbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232bb18a-68cd-466a-c52e-08ddba89417c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 23:28:03.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sf60LrT0k8dUwePSc3mTxW+tRHRk1admmroePuAGSb140P5iOY0PKY2nUnlQFsW2TW2sbwaqn0iXT9+DQ7qaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_06,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=917 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507030192
X-Proofpoint-GUID: wcO_V_1iFBBuHyax_xyykeZSWSNjluqJ
X-Proofpoint-ORIG-GUID: wcO_V_1iFBBuHyax_xyykeZSWSNjluqJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE5MiBTYWx0ZWRfXy6sgcZd2fOKV ZGolfuRSjZLuR4wAEcOSRydevfjqRI8pfF+ttp8AKmfLqdP5TzgEXg0VjCM+dpbeI3QGKXvtZVZ /xEldGucA+T326JFYqNCQQ8Qiq/gXQjjFzMCRTdShtgDmRLjaci3wh1jcSsNu5Wem6DG+4+z5RV
 /zTCSClR6IRTnFLIlbNmV8otkDcTxItwFltvF5IajpQpwpTHKdgycuFTbPklMRvKI+cEsyP/RW+ ojTqOQBCpglDFG20CsdVUMHqVNjFb9tJGkdua7zwG9UuhZkGrfVS9ITxR+abQPeIR07Zx97WNgC dXiIHuksbtMmBX2+BS4HEvXZMUQxcRpDrCfhlRMcurrz+/q/ziShaPaYQHOOMoAg10hjAbAIFnV
 Ow0P2eg5rGwpdYBadu4NmL0ESXbyf7/jTnz6FQwMfu/2qVEMciLfnC0cRImdDsup0311s6bi
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=68671207 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=DHYJdH0NNSlCUOi2If8A:9 a=QEXdDO2ut3YA:10

On 7/3/25 7:16 PM, NeilBrown wrote:
> On Fri, 04 Jul 2025, Jeff Layton wrote:
>> Chuck and I were discussing RWF_DONTCACHE and he suggested that this
>> might be an alternate approach. My main gripe with DONTCACHE was that it
>> kicks off writeback after every WRITE operation. With NFS, we generally
>> get a COMMIT operation at some point. Allowing us to batch up writes
>> until that point has traditionally been considered better for
>> performance.
> 
> I wonder if that traditional consideration is justified, give your
> subsequent results.  The addition of COMMIT in v3 allowed us to both:
>  - delay kicking off writes
>  - not wait for writes to complete
> 
> I think the second was always primary.  Maybe we didn't consider the
> value of the first enough.
> Obviously the client caches writes and delays the start of writeback.
> Adding another delay on the serve side does not seem to have a clear
> justification.  Maybe we *should* kick-off writeback immediately.  There
> would still be opportunity for subsequent WRITE requests to be merged
> into the writeback queue.

Dave Chinner had the same thought a while back. So I've experimented
with starting writes as part of nfsd_write(). Kicking off writes,
even without waiting, is actually pretty costly, and it resulted in
worse performance.

Now that .pc_release is called /after/ the WRITE response has been sent,
though, that might be a place where kicking off writeback could be done
without charging that latency to the client.


-- 
Chuck Lever

