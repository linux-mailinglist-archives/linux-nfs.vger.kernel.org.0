Return-Path: <linux-nfs+bounces-13873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29997B31B5F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E195DB270A2
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC80307ADD;
	Fri, 22 Aug 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UkQq/oPx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPz0Gtw+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDADD2561AB
	for <linux-nfs@vger.kernel.org>; Fri, 22 Aug 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872369; cv=fail; b=TRYfvi3wgRgzxZpdv0og4j+C64zu9uRtWNF+WS6W0Y8DfBRZi5CFmE/eV3IPUBczw6GmOokW//oHyjuG3NE1OGQJNDXYhB5kGnljAF5c3OxBlelhg4cAgKWGhaYuK61vU0q/A18Q4fQtwSNZ6uCrtx93Zk0L6Q/c8YyJ3w58DVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872369; c=relaxed/simple;
	bh=FI5uCVGRwoW7jZxiET99ICXydxenhBUZx2ahVBuQq5o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2sPbo6y+W8NyITrBrkbYgv0YwIQOPj/cq82MEL2+yz0Yjg1BnhtfxDNvVfn52mHY+NRri3qnNbwX5UtuGgXGkPatFAxVE9pftZzXB7HogxfoATGlWmPpF556NVVxl3qStdjS4U0AgzTzEzRk8e2SR7vIBxz0o2AIXpwZ9n2yNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UkQq/oPx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPz0Gtw+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ME3or2011613;
	Fri, 22 Aug 2025 14:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D1jP4CDhhWmU23pPg6q7N7qI/Dp4fPWk7RaY4+t3PgM=; b=
	UkQq/oPxv8d1u8TGowqu9QwdVENPBHIOL2tUfOzfdGpYi1M7nOUCaxIuQT7xANA9
	kXL1WLo0CNgUO39DCH07CRDLJLlIPFPBsnOp7z7sHeEswHkppOkOmCMyrJHqTRs+
	qVyB9SGk4rYXRp5z5M4/yTHrI4Ktm1sugdP0Nyz8CdszK8f/Jd+zUSfjXtSpW6v6
	pXUacWtNIVWipTXzlWIosSeUgROnQracUcgeTsSP8opSJFXOxbAzI3CHqumHay3T
	+OWvM48bbqaMtooiX+j+fMUTgoupROHOJ+j6BWNCN6vLv0rWH3qEn4ci2deSChL3
	hrzvgjDV0BwieQAA3N2Jng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ttnc45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:19:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57MDT8ki007265;
	Fri, 22 Aug 2025 14:19:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3te7sv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNN+OWiFHErzWVC5Enz9Y3jJlQJ6lA5cV2ciCIsZoST4Ujx3t79lfqDMIDEwhxZFlVsV44UWJlzf067MUTtWv653oK6sI5fs4DDftL8o/TxOIGjEe/y7BAx18XtjbT1bCr5V7R+bq9hEB+kztEVtvRIpL7OCQCwlDN0PlpAokHFRjaG5pnIIT/ZW3ZS5VBvoNMy1Ux9iZVAYN+MG8p/9FizCOzGsCOw8KSRyJqevdHSgcjIVU0FML+RURsT2wzTFHlYN0ru0UQ2OEV71pHfMp3/Jmu1uCzXkU6X9kCnASnYMEcDHkBmpGiPko6Kl0tp45hEKtrou3v/xOkTpBDDm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1jP4CDhhWmU23pPg6q7N7qI/Dp4fPWk7RaY4+t3PgM=;
 b=oNjNmPkvJzVeWwtHhBumR5q7l79H7ltNTOh7jfBB5x4v6I1bAwUkW0ffPmiCwo70OsA/qQynY5x53toOMFEO1+1jmyOMMZirTmxL6irmSC3BtAagPDDgezuI7akn/SwL6ELDJTzSB0BNb4zDPqNbAmvs50hNKbW3sANe4mDsjkFVCfXprBJOB8a9+eQjJKKrdEEdOyrUUCbKDrU/vxe0Vp8lg6J+OKD20uAV7S9ttnMUNKxr4QBRKAmcJyu4sdigz8HQ+kycK6dKpnQAUgwUkb8CiK8LJKxCR2K6J9yvWYTyRnUGYfoxhT1805c5cCbLdBSChXl8Vaii6eSjNeKGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1jP4CDhhWmU23pPg6q7N7qI/Dp4fPWk7RaY4+t3PgM=;
 b=XPz0Gtw+AHpYK0oC/lL0+vP7ytyLbFSW35hagw25UWo1InszFP7B/ZK+UcYfV+WJbJUZCrxcWeoKa7qL5I/P4OyOv+f73njduke+lkE5+rK9IbV2Ya6PZIHWgJJo7xbgJdMsLWziKPdsgYmOOtDlJ5EZj7X049oUGAcR1oNHnOY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 14:19:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 14:19:17 +0000
Message-ID: <86c49f0f-1ba7-414b-b4a2-5c470614b0bc@oracle.com>
Date: Fri, 22 Aug 2025 10:19:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after
 listener removal
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250821204328.89218-1-okorniev@redhat.com>
 <ab55513a-fff0-4907-98f7-716df23a1bb9@oracle.com>
Content-Language: en-US
In-Reply-To: <ab55513a-fff0-4907-98f7-716df23a1bb9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac6abc2-2efb-43e6-b3a8-08dde186e0fb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a3M0cks2ZXN4ZmxqZ2M2TkhnelFOck5jdHdnZnpOMXVFY1R3L2hDb1d5QTJI?=
 =?utf-8?B?NCtvWVRYaWlFZCtYclhmWmh2OWpPRWlnR0NUckNSMXpwdXM2bnZBM1lvd1Fl?=
 =?utf-8?B?c1VQeGJuaWRjM2ZCRmJEaklHWjdUQkxES1RvQXpzUnQ2QmZVTi9QNXI4Y3Zt?=
 =?utf-8?B?TEdvQjFPTzNwR0lRTUxTbWw4ZE9nL2pWaXNmdmhhWTU1dFlZWDdzQ0pHMmxB?=
 =?utf-8?B?ZGtCZ1hsN0VpOXkyYzhKbWRvcG9LQkNFZVJaR0taV1VFQ2Ivb1dXZTZ0RlhU?=
 =?utf-8?B?cVNSZGtWMWpqYXJsOTdzNWJoSk0vNmp6SGJZdFFZMGpPelJuL2dkMXNpZGZy?=
 =?utf-8?B?MHJ5UnVHLys5bE9yMENTRWd4bFdFVnRhclZlaUlhVnpTWE00SVFYd0lwYTA5?=
 =?utf-8?B?MnBRTHJDZWNsMEZld1phR3pWS0VSN1VpclBvVUdqU0xwYnY4NHhXeTNrU1BV?=
 =?utf-8?B?b0VZQ0FmMDdCT3puRU9FMksvcUUrYUNWOVFSd3grQmM0M05mc1M2Z1lPaWxJ?=
 =?utf-8?B?MDRnSkRlMCtqU3dNNjZjTGFUNkxuamE5NFd3amZzTkFMTHZ0VWtLQUllYU5y?=
 =?utf-8?B?WFZYS0hoT0w5dzdVbFpndFp6c2VLdm92bWVESWorellFQkdvRFkrOSt6ZnI0?=
 =?utf-8?B?RDFUVXJ3YmdwS3d0TDZlRzdVaWY0cnBrRisrWUVtWkRLNVZiQWVlam9oZS93?=
 =?utf-8?B?NmVVNHJDVXhsUG54N0E3SnZIOENNbGw1ZE1TMGR2dGJIV3grV3NLL1ZHM1B4?=
 =?utf-8?B?aEhrWGx4SFRaTVBFRVBlV3podDVUTGNqYXVkV3M4ZzVwcjhFTWZCdm5ZTjA4?=
 =?utf-8?B?cm9zWEhMYnBPVlBqaXpPRG1ISGxVTHNlcmh4RllaOFNZMDRPM0szNlpuOFlX?=
 =?utf-8?B?MVE1TmFFaGllSGVqM0U2YnJrdlpBbE9HamVwS2FXaE9QNnFLSWZTQTV1cEo1?=
 =?utf-8?B?TW43UWRLMFMyM2tlOEc5QVNqd3hjRkRhdlU2TzdOUEZYNWVDa1pJeUJ2eG1M?=
 =?utf-8?B?SVl3Wm93UjdsQ3RkVkJ5alFIWlpNdVkzMXRmVktEVGlURGNEM0RtMG11YlZ1?=
 =?utf-8?B?RjJ0QkU2Z2pNVDBlWHk4bW9yT0gxWkRNS2lUaExiam5UWmJmbHRTRmFOems3?=
 =?utf-8?B?UFFJRXVMNWlWbkRzTlJodU9JRzR1eld6aWVtcFYxR1RKUWtnNmMyRzNkZ3hQ?=
 =?utf-8?B?cEoyd2pPSHRjbXB1a1QzNDIxdklBOUlCVldVZ3NIeDlzTDBpcGp0WHJJZUdT?=
 =?utf-8?B?ZUVjc1NYTmdrYU8xWFhRbkY5WlN3WGtMZGxCZ3J6SXAwT0dZQzBlbWhBRlA4?=
 =?utf-8?B?Q1F5NmZzbDBlVE5VQUl5UmswNGxvdHVkK1M2ZkV5NHJUZVdUSjZ3Tm5yT29U?=
 =?utf-8?B?bHhFeHkxcUFCZjhqTTY4TTBTYU9rczRWUGJhcW5VcHgxSkZqeGUwR2haTTQy?=
 =?utf-8?B?RWd1SVZkWWlxMUpaRGFKeEswMWRyaHRBT2FMcTZLbUh3YmNuajhnWmRUdkpI?=
 =?utf-8?B?NzNEdUUzTXRWQlVaV04vN29qUmdUb2xENmkzTjhXUmQ1TjNDNWZ6em9LeDNw?=
 =?utf-8?B?ajhrRVRTZENuNkRDNlFqdDBvUUsvVW8ybitIWm4xSkRwKzlVd1IyTU9KR0J1?=
 =?utf-8?B?RTBWTW5wM2phNTA0MStDY2N3NHZKSTU1MGNMdW9BWDdZdHR3M2lmMlFySTBK?=
 =?utf-8?B?RjB2c3NJZWJva3llWFBPWjNmUTd1TjB3czk0ZDJ1dnJ1aUhhc09ocHlmb2I3?=
 =?utf-8?B?VVdZMG1pbU80eEJvRG1GRlNrdWZoTC8zV21jV25lZ0I1TU43R3grcStSUkxm?=
 =?utf-8?B?OUl1UEcxKy9xZUUzSWJXdEs0cjNBcHFVelVnaXRkS05uUlVnR0Vnc2RtaGFi?=
 =?utf-8?B?akNoLzhSSlhuRU1TZklvelY5bkt3Q1dhVHZXWGdxMkFPMUNXZWhmbVBXQUtM?=
 =?utf-8?Q?QLkkDevP65k=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VFVmR01HWXlONWF6bzNzaHk2U1R0LzZEem8xYTR3MkFMelZsaWVwMVBVc1VV?=
 =?utf-8?B?TnVkNUllbFJqK0g5dEVmb0RLbk1RVjZ0L1QvM2NITlllSXZOSUJkanM4YStt?=
 =?utf-8?B?Qk9YM0IrdHpBeEJiUXFpcXk0L3h2L1l3azVVWlZRdnpCNjVSWkFmZFdvSW9q?=
 =?utf-8?B?SHJqQTlxL2pPRUFsZCtVdll3d0wwc0d4M2NMVDI5KzVUUlM0ZkJ3UE45L2pa?=
 =?utf-8?B?eTNLZ0E0elhEZlJIaGRtcy9SbVh5bzUvWEUvYmxXRGt3RHlOcENDUUl6RjVD?=
 =?utf-8?B?SXcvelg2Rm9GV041c21hamJzMC9Uc3Z3UmhUR0R0SW1nZTBUWG5VTWphZ3Y2?=
 =?utf-8?B?bis3SzcrTDA5Mm9Oc0swT2IrOUJ6bjFNSTUydTdXYm1tamtpZ2F6SnpkWktz?=
 =?utf-8?B?UkEzcHE3T1NTRVN5Sm5mdHZDTkhRZm4zK2VPZUZWZFFFeTdKOTdOYmhCYkNF?=
 =?utf-8?B?M3dIdnV1RGdpM3ZPaEJJSmwwaE85K1VIbHhldEowbFRHc01ETFJBb2Q3cFVD?=
 =?utf-8?B?N0d6dzVmREJkb2dvU0NaTGVwVldUSWNDWFhiWDdjMHJYbU9SbWxCdGFLYnZn?=
 =?utf-8?B?S3RSQTgxMlpPT1Bla0x2blJDWXdNYWNhYjA2VjdqOWhrWWZQa2M5MWt6MXRp?=
 =?utf-8?B?cG9MYjhBdFBSRmwwQVh6d2JkZEhxYW1KMUJJYzZXbFJKa2pLWGk0SEIzSXVK?=
 =?utf-8?B?RGU4YmtXaW1XbVFhRlFDQjBPM0NQTmtYUTlmS0lmQ1RaZGtYbnc0WlJNMXFD?=
 =?utf-8?B?b1haZUUvS21LNk1xTVA2RDlHTUR0K2doS2JlaExXTjZNTGdKNlFqNFp0VDlP?=
 =?utf-8?B?Y2ptaWZndkJ6MGJRMGMwSzcwUDgwY01DZkl4ZW04bnl4QTduaS92a0lEaHdV?=
 =?utf-8?B?azlvNnNUU3ljUlFZVUR6ay9mMUZQYUNxK2svNzJNQzVzRVFRd24wazBMc1VS?=
 =?utf-8?B?ajA4RzMzNVBWT2tIMnlYV0wydWRSaXdVVGY3YmhhQmx4UUZobHFRd0NiQjVK?=
 =?utf-8?B?eVUyRjdSdk1IcDhqUENjU05kN0hlVmUrZEtqQi9lMFR0WXoyVGU0VjdJNThX?=
 =?utf-8?B?N21PaXl2OHpySHFWMUM3VVFyL0tkdDJEUnBoSkJWd1d5a0krOEVTSFUzdkxB?=
 =?utf-8?B?UjFOU2wyK25NVlZ1WmExMW9TM1BGMjcyS29RK0xldnJjWXJKY0RIUm1HSVhw?=
 =?utf-8?B?MHBTcUdkV1JIczJiV1d2VEo2VkxHT1BKWCsyWjEwUkVHTHBSTWxzMnRVSjIx?=
 =?utf-8?B?ZFR5dWNMS1BocGpkZ2U0TFpWRFR2YVRQQjJIVnZLbmNLZ25zSGdTM2VHTmRN?=
 =?utf-8?B?cDF4NXgyUjBDMEgwRER0WkR6YjNQSDZVM3pkUUk1SzFISDlKTUVEdVlRTDA0?=
 =?utf-8?B?WjkwMmhwNTdQRlAzdzFMNCt6aytXMmRYS0NSUkIzQXhKYmFpcWtYc21JcHNQ?=
 =?utf-8?B?N0Zzdlk0QkVyS0NrS3FSaDI5eWRlSDZLQnhpVEYxRnB3aWJibFNCNURub0FT?=
 =?utf-8?B?YjVPbFVVWlZLZEREeGxMY1RUYWFGZldDN0hhNE1MYytteTA2Z3ZCSWV5RDIx?=
 =?utf-8?B?dFp3eFZNZGdYbW15MldTTkdoZVAxYmhTZ0cyUjlKTWVJZlAyYzRtMzVLbWMz?=
 =?utf-8?B?NUZqaCtxTld5TWdOMmovMzZ0UUt3czJLcW42WEFDNytZYnlXUFJJTit2QXQr?=
 =?utf-8?B?MVFFaXNUekhGQ2RnYXdPeElkY29JMStUd1QzYlZ3bVVWemJrWXVBRzdxRlBq?=
 =?utf-8?B?OVNPMVdoSnByZjJlSDVUdTZiTUNJeGcycGl2VEw2WTROVUgrTXhLY0VqL001?=
 =?utf-8?B?UTA1Z2p2QlErY085VU9mNEM0K25XVjg5azVRNjhtd2ZCbGpTdE4yemwzNVhG?=
 =?utf-8?B?U1piby9BZnZYQTJ3M2E3c3BFUXQweWlvcUlXbDRkUXZ2YUVtdXR0N1MwWDlM?=
 =?utf-8?B?N2R4MExidVIvZUpubzdMSnZiMHRVa0Q3YU82eFQ5cVB6aWgwQlhSODVmZ3lE?=
 =?utf-8?B?eU5Jd1l5bFdoUy9odFZpL1owb1RYbjJrMHhNZGJmQ0NFaVMxMG9VaURPU0xK?=
 =?utf-8?B?N1BiMWdTK3Z2NXlZdEpUV2R6d1JhemNXUE1GLy9VSmFqd01xYWJoNnEzZi9F?=
 =?utf-8?Q?RaX2wbGv5JxndP0Eim1JnzO+L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ObuBVOLjgYDev2/qYxbjo7790Q90L/zTd4DWSqrt3I/cAlOpfsjEBxjWXreUAYV8OFyDMbnsdw3QVKwGNGMjQH6seNyvS8TfvVjWkJiSvKC+kBIjaAyb5Dzy2UALNUfvmxPiL88p+mFK9OzoLUWiUJLX0rNSu2uw9lT24uEXTApM6f9jVi2RttxVuw4Wos+qgPVT6Y0ZF8E4+/71AkrJQYXZQWTA8U/QqKr+UK+uFkH6s+D27bccAsTGaYgItiK3Tk43MyQ38BU3CvLGrM8f2WEOu0MllZN/jHaooILeYh8wwhdfDkgP0/19Fd7EqtUaYi41zb3kA2xxLFek/pFWJUr0awhBUNxA1qQn9UMAgrlVW/bP62KWYGrmilF9gbV7bRnuQtr3rHOdzY6BA3JkhLTngUNnWYpBux//FNluZINum2BB4TMQcuSAB9FEmVJiYeiOfDLAxPvkf1gVWadcYtkHR0WQFEJp2MUP81jbj7ANKc256N1flh85M/9yy3psXowgX0WBtl/Ir8UwQk4JuB4HogxrldI87NemstQXrBZnOtYNlegrIN4yq+lyZzzToUU3OL08NXd+rAmtp7LVGI3faWX1hU0aDDYfWFHCPaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6abc2-2efb-43e6-b3a8-08dde186e0fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:19:17.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6Ak7Ps9Ek6ujJISM+qtSLRc3I2CC9voEdTdWrGbGmyj748iji9tD0HhmATe+lCRqydEny/GepESNhbj6vcNMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX67QsaGLy+eKe
 jV4bi9mviiZYgc7HT/RELLi/IgX0CGiqxosC4lYcXI0BXLTtd713RZZ0ttN1gSCLzzW35stFa5X
 zTI35Ah7/JwdLX3/UT49KCuxTEGLUqq9rM1mOaXzbriuIyhjmkS2de6FQPK3w89lfEwjgHTYvJm
 S+JrqCnI3vv6F7BUKkVxhSjd/HrXZSnCKgQa4pS6r5A1JDntLVe8C7jle1IeGq/OuHahgxzDnu9
 9FuYKRLsncB0Sgbvpp9A4mAxriosCp2zAaW/X1NVR8yVdbIMlqtKMEpkr1jFCQL433KYossoLN/
 jbRw7AXwwSc6WOpa0aNO8yW+NUxXtk8os8/byS8LZx/DRBCeTy+Bl/eTQSCiDkRQbOMMowuSoe7
 kojrd6osozYSrdY3VN4MQkKy32kT5A==
X-Proofpoint-GUID: Ko3tRk-2rb_nC9x-ZwC5gHDfeAI5kliY
X-Proofpoint-ORIG-GUID: Ko3tRk-2rb_nC9x-ZwC5gHDfeAI5kliY
X-Authority-Analysis: v=2.4 cv=V94kEeni c=1 sm=1 tr=0 ts=68a87c69 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=9rDevlRzfX4xAlD7HYoA:9
 a=QEXdDO2ut3YA:10

On 8/21/25 5:01 PM, Chuck Lever wrote:
> On 8/21/25 4:43 PM, Olga Kornievskaia wrote:
>> This patch tries to address the following failure:
>> nfsdctl threads 0
>> nfsdctl listener +rdma::20049
>> nfsdctl listener +tcp::2049
>> nfsdctl listener -tcp::2049
>> nfsdctl: Error: Cannot assign requested address
>>
>> The reason for the failure is due to the fact that socket cleanup only
>> happens in __svc_rdma_free() which is a deferred work triggers when an
>> rdma transport is destroyed. To remove a listener nfsdctl is forced to
>> first remove all transports via svc_xprt_destroy_all() and then re-add
>> the ones that are left. Due to the fact that there isn't a way to
>> delete a particular entry from a list where permanent sockets are
>> stored.
> 
> The issue is specifically with llist, which does not permit the
> deletion of any entry other than the first on the list.
> 
> 
>> Going back to the deferred work done in __svc_rdma_free(), the
>> work might not get to run before nfsd_nl_listener_set_doit() creates
>> the new transports. As a result, it finds that something is still
>> listening of the rdma port and rdma_bind_addr() fails.
>>
>> Proposed solution is to add a delay after svc_xprt_destroy_all() to
>> allow for the deferred work to run.
>>
>> --- Is the chosen value of 1s enough to ensure socket goes away?
>> I can't guarantee that.
> 
> Adding a sleep and hoping it works is ... not a proper fix. The
> msleep() in svc_xprt_destroy_all() is part of a polling loop,
> and it is only waiting for the xprt lists to become empty. You're
> not polling here (ie, checking for completion before sleeping).
> 
> 
>> --- Alternatives that i can think of:
>> (1) to go back to listener removal approach that added removal of
>> entry to the llist api. That would not require a removal of all
>> transport causing this problem to occur. Earlier it was preferred
>> not to change llist api.
>> (2) some method of checking that all deferred work occuring in
>> svc_xprt_destroy_all() completed.
> 
> Jeff (and perhaps Lorenzo) need to go back to the original reasons why
> this was done and rework it. I think we were avoiding holding the
> nfsd mutex in here?
> 
> Complete shutdown of a transport always involve some deferred
> activity, and there's a reference count involved as well. I can't
> see how the current destroy/re-insert mechanism can be made reliable.

One thought is that instead of using svc_xprt_destroy_all(), can we
simply call svc_xprt_close() on the target transport?

The question about what to wait for to ensure the transport is gone
is a different problem: the memory backing the svc_xprt will be
freed, so we can't, say, "wait on bit" on one of the transport
flags.


-- 
Chuck Lever

