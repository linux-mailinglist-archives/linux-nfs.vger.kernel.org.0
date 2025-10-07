Return-Path: <linux-nfs+bounces-15022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0CBC2022
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5954E1644
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ACF2D5C97;
	Tue,  7 Oct 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M0ed3sCB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o5AR13BK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16CB20298D
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852774; cv=fail; b=hltFpN+6fIKv97UjzoMj+ozAiUP4tQlFjiqwovXoyTkVpSnW/qiwffgn8GgAEWbJ41+f5IjNK/0FwyPJRQKHiKKLHbwJMZta++iruvpP/E3J9WF0C67m5nKYMGXHQYSx+3F4Z/LwtjPCnFv/r1gRd7n3GBZMkfxyjgm1GVjQD30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852774; c=relaxed/simple;
	bh=yI+1S97FvTVHtsK2j/SPkMsk6d3BmTwU9VoClj+9jVw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+bdVY0wVn5H3mFIk0OMjVdVz+RE/RIntXf0z3+Voi9xsbcMMKjC/ia84AERGDIJPBsC6DynFcItKYMvlwHa5+6p6BXr1e1ZgQub6pzRV5m7ddp3k6T0Wmx5z4Tj5Bxhtf/T7E7N5uV5pfltfpQmQ019RdTPRZOETcZ672UNt1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M0ed3sCB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o5AR13BK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597FOp3V012764;
	Tue, 7 Oct 2025 15:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X5psB5fnfYTPH2Un77LCWbC1SBro31/f4bWuA8AE7rU=; b=
	M0ed3sCBKV0oUnDsu0Y/CYwPr5IcJlwetBv8zMvxjgLHq4ZfyQ3TlMDH184r0f76
	J3uMZx65qgfHvZqsQ0EI9vqr/IJ4j37iR1N/OqacTRPFViiugd7mXw2IDY4560cz
	OXHk/VroVWX5gzPVRs0gh/7cXBst8MEdpe41IL6UOOpa0SEWKnKrlRkLDi7n0QR6
	x2uRwar5M7U6XZIKN4oLnW3v6kforWLrPlV+6E0f4WC6s8YkgFhB0mxHfKZ4d3q2
	75hQvkWaFGNAfWrm1nl4LR/4ONRzGq6boXH4zCFIs2G6Bxaxn5VHMV2LD5qjlURU
	QHAgF/LxWHsvW9YWttZLAw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n5fq82wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 15:59:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597EY5E4028649;
	Tue, 7 Oct 2025 15:59:18 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt18dmmv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 15:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUbugxWcIQDb/Y0/PlwRsZq0N81oMsWju1kAFlKs4xi4HuG8Rxs+AOpC0DNHyue7Gwt7/peSxQTwYEzpvJqJnym/Z8ApbqhUGstB/BtSUagjWwLbClaFB4XFbtVj8GD6w7mBDxAn35MPjXRCE+rGrfxMuFAJn0pGF1WYPHGjp5TSmlSlWhkS0Dxf15FZ5pHeX8Q9OtWvYbvs6bRrFsREMl7l1p6yj/l9vlhsSj+gIk1aF8zDgcG2gcqvveQWDkW3QH21sqRC7Pj0AxVhnS72ywGzlVsNJ54HY5uRV/asAcJjway1GK7tIsN4gX6S0v9Nw4r982FwHD+amIetr87eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5psB5fnfYTPH2Un77LCWbC1SBro31/f4bWuA8AE7rU=;
 b=sDVmfVzVrKMUfDrG2Xp80ZdE8jmsbS5pXbAZAv6CIw1r/HLcaHaA1Y7403FhguqnEo+CzRMBC+MOD1XqKg6U391r/D14C4CfNtQehcB3pIjrvEOdCLxj8r+zNkHm5/aGAA1sgjwkm85vqIo+jbIBP1ZGiMWUekji+nBVOroUW5dFz/9mJPUddtjqqCEAbxbqiwiBhXNsb2bOdIMRzmklzYj4v6eF9ehxs49uKGWkbfP25dq2bbDKN9p/KuRJIKtSQ7DShsdshn09ndoX0sHz31JjieDRL6Xs9OI+DhzSGuNC8WCFYIoHbXdUUJv6XLf7TjengI3Al1LsxBmys/9m6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5psB5fnfYTPH2Un77LCWbC1SBro31/f4bWuA8AE7rU=;
 b=o5AR13BKyCqM3D4YYfk58etkNTJJ8tZ8JZ7iGEyAnwpI3OAsoOpkr2awN5+Qzc/XK9v1sqZBIeKcExvGAzB1LzsVrYyZtODhwBi+lEgA0vuj37DZX/MhPpubxSZZui2D0t+1etb6ulx0FZNkyBxIkeY7hoJYmZqMZEy5vVNcUo8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ5PPF88E71D08C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 7 Oct
 2025 15:59:13 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:59:11 +0000
Message-ID: <ddb63ff3-80cc-40b1-8e8e-f61575e85828@oracle.com>
Date: Tue, 7 Oct 2025 08:59:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
From: Dai Ngo <dai.ngo@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
        linux-nfs@vger.kernel.org
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
Content-Language: en-US
In-Reply-To: <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::7) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ5PPF88E71D08C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9603c013-ad06-4231-f543-08de05ba74df
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cGdDd1M5SnFFaUV1UDhibFNXSGQxVnJoUEx3eXVwdTFIbDV1ZG9RL3dPMlUr?=
 =?utf-8?B?TEcyQllWZVdBNVJRS3dtU1dVd1IwODE2MmJsU3o5TVFvNklvQk0vM2tRc1BR?=
 =?utf-8?B?OGp1dU1meW1XUUpKUnlMdnlTM3ZMeDMrdjJla2RodWUyRSt1Mk0xUWVBMVBG?=
 =?utf-8?B?cEswekhNZ3dCVEE2RDFOUFhOSVFQdUJYM3k2d3ErQXlPMnhlbWNINXBCUWdI?=
 =?utf-8?B?YUNoK3hpSGo5RDFVR1BpSEtOUkoza1MzRzRZbG9hRUV3R0N1T21sWXFyMkZG?=
 =?utf-8?B?S2hEY3FvZGNsYXFRa0s0TjdDTmhNZW95aENQbVpWWVZpYVZLY29mbVdZYjFh?=
 =?utf-8?B?QkhDMkVOblduQkQyUGZ6RStOeTB5UnNEOFk4bkRJS1RVTmFVM2V2c2dkZ1Qr?=
 =?utf-8?B?ZjV2VnhOZ0dkMFdVV1FVdGRQOCt4elQ3d3FFWllSd0RjYlRKRUVQZDNOMmJh?=
 =?utf-8?B?Z0cwczZrYkh6Q2I1V3RScHV2ZWwvQ1V4SzRVYjluRFdBRFFVTlJYRmRYa1pl?=
 =?utf-8?B?UkVRa2xJYUhlRFV4UGZXTmxlOTRxdDdPOVdxN054Z0U4QkNxcllwSTI5WnRj?=
 =?utf-8?B?NHB3WGZWTDY4Qk5mRTUwVG8vejZjMXZUY3ZHQXlXaWFUbStabUJTU2lWZmhS?=
 =?utf-8?B?QTdZLzZCdHRQdlR5cGFkaFBFZWluQzZIVjB6VkY5L3YzamkxZE1yNzNKQXoy?=
 =?utf-8?B?MTdoSFJ1NFBTdmYrOGRaVE1rWHVwY3V1VGtHK3hTRjlCOGwzbndsUHdHVkhK?=
 =?utf-8?B?MkhZTkFPNVMwNkFGNjhLcHhDK21vTnNiNmpiTzk5ZVJ0ZjR5Y0d2WS9KMG1u?=
 =?utf-8?B?d2JoeFN0S0g4VlhDSkZETlhjQjZKcTBPeEV0a0tSYXB1aERYdWpjY1BReHh0?=
 =?utf-8?B?TncwVHE0amYrWElmSUpCM3luZXdUVE8vV0t1V1VucDc5dDVWUDhaRDRWT0NO?=
 =?utf-8?B?UG9jeFYzOWR4KzFZRlhYN0VMTFRZUGFCYndCZy9kQTlIL3FueTl2aklYb2xO?=
 =?utf-8?B?eDJMSGNGenBUSXIrOHZTcVFPaURhdHFRRmFyb1YzNGJ3ODFzN3U1ZW1tOUgw?=
 =?utf-8?B?UC9lcWo2SEhBY3dVSTdmemhZNWJ3b3R4R2owNms5TnBWWEVtUWJtTVZFREQx?=
 =?utf-8?B?eVltRTdZTFBETXEvbWFFUTErZFhTaklNMlRuWnJKU09TaEpybEovL0NHZHdU?=
 =?utf-8?B?RGJLUzJZZkhrRmF6RDJrZ0ZLTHhrK1F3MVNKR2x6NExibUhXOTBHU256M2Qx?=
 =?utf-8?B?NnVKcnR1bU5uekladDQ1d2w3TVp0UEhoUStxMm9kS3kvYjBoczZrdmgvY2E1?=
 =?utf-8?B?eGV2RTlPOTVYcnRqbm5yQkFLYmZvRy9Pb0ZhQ052NkRjbllhL3hqa3pQS0JW?=
 =?utf-8?B?UlVGd0l6OUowdUZsc1p3TWxEUk43K28rYldicmRUa29TbE02R1RZZFlxWUc1?=
 =?utf-8?B?Zm83M3J2WGhlbFFPQ1RxQURYVzBWSVk4bm9ZbFh4eGhHREt3Z3IyMmh1TU1M?=
 =?utf-8?B?WkxUazJNclp5TnZ0MWFkSHRTeVhOOVk1UE1HeTd2eWpEVFFkRWRvYk5CQ2pZ?=
 =?utf-8?B?K3I5bUlRMzZQY2gvdXVTOEk2ZzlNVHNISExvUFY2VXdKMVpCTnYrMXIzMXFX?=
 =?utf-8?B?RXc2S3lVMTJWSVBIcHgxOTdsOURuVXMrcTN2RjBYUFZjbjB1cVRoeWRzYnZj?=
 =?utf-8?B?bWZ4TkxsWHlvSURGUVhmbU05MGgwVjZmdXZSYXdjTXFIUENQY2podnR0di9B?=
 =?utf-8?B?OEc2azg0MDZvd3llT0tadm1Sb0VVT2Z3RUJVTG1IQm1OUlMwUkkzZ1lxWjkr?=
 =?utf-8?B?b2FTeDh5UU1TTHRUZGtPLzdlZGxmNHVISitaaGlZZlZPZ2ZvM3cvRWxmb293?=
 =?utf-8?B?WU1IQkE3ekpEck1seUpaeUgzTm9jVDhHTnFRZWYzZEo3aFE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OTIxSnlzRkVDK1htVnlLVytvR1MvaXNoMEJzV0Y4KzlrQWZJem1ORUc3ai9Z?=
 =?utf-8?B?VWplK2pnTHVTYVM4VmhvVHdBQTV1ejZvWUp4ekVyMnVTcStIdFFjTWd4TENk?=
 =?utf-8?B?VUxaZ3hVVlVQc2FyTUxxOWRtVVBxcXE4ZmpoSy9MaG56TW1PR0lWdDFFL0lT?=
 =?utf-8?B?clpIdEkzZXVjVktCcnJOWnR0bnZjSkVsZGtnbkEraXFkUXR6c2c5Q08rNWdh?=
 =?utf-8?B?ZjJURFk1eWZLcUFYS1BwMkFqR1l6OFIwN0w2SGpqV1hpbWlyWjJXVU1HVFdG?=
 =?utf-8?B?S0pvQjNnWFJNdGQ4dkRwKzIvUzVRMzJ0elB4bUlJVU5DZjcySjJYazlVd0Ft?=
 =?utf-8?B?Y1lsL3docGYvbmhWSUt3eXg1V3RTR2VGc2xVTkQ4YUhYaWRNdllUVWgxN205?=
 =?utf-8?B?OElwa1BSSzBmVkdja2VBUWZkdHZ0VzZPRkpGZUJKVHZJRjJ0TmFkMTBvSmtH?=
 =?utf-8?B?dGsrMHFMQkFENE90ejVxT1ZYYXRXSWo4Q0FFeUkyWXVXMU9Pa3hwL0dSSVMy?=
 =?utf-8?B?SDI0RTI0VUNOdkc5SWpLcklxUHJCYi9zT0hST0M2bWRDa09lLzY2czRGUysr?=
 =?utf-8?B?YlJOaDZaMm9VT20zV0svWWFpVUFEdTQ1K2orV3VqZ1RXdTY1eUl1NGtyOWs1?=
 =?utf-8?B?c3pRNytMekJOQkUzbDBnL0gvd09HejFoVVJsaGczdko2TmQ2Tjl4YVNxakJJ?=
 =?utf-8?B?cXBZOVpSQ29YL0gxNHVYTDd1NnNzVWU3N2xYcXdDQmNTWkQ3U1JrbXJzZ3Qx?=
 =?utf-8?B?QkZYcU9JRXQxSmRYRUZXRHNhQkhSTmpZQ2dRUS9sYW9icUVnYmgreHNiR3pI?=
 =?utf-8?B?VWVBcEY3NEFyNlhUdU8vOVZLT29INDVEa3dETVBGN0JPQXhSWWMyTGF0a0JF?=
 =?utf-8?B?cUpicFRNdGNiWmhDU1MzNGU1SjE5ZnZjMko1Wk8wRVU3b1ExekVDbklXeWxX?=
 =?utf-8?B?VUljRDRCaWxCU3huc2hETmw2cXM4TkVXQU5oMTJvRDYySUx4a3RycWkxay96?=
 =?utf-8?B?eDMvTzdYbncwTnRyUVVtSXg0UVdHV1Bsc3htajFKUmx4VjdPbGtFUG9oMGx0?=
 =?utf-8?B?Mnpib3hlU3ZISmNnOFIxUzlyc243TG1tZXA4b2lUcm9KN2FMSytVZG9ZY3Ey?=
 =?utf-8?B?VnVhUERPcEpXcGhXbTZwUWVjQStjcVdIbTJmVVZIWnNmd0hyWjBjeDNoeDNa?=
 =?utf-8?B?KzdqNlNkTkFtS0FBcWVBTzY1NHI5QTJHRzlTRWxrSDdmODZGcDBlSGVUNFlW?=
 =?utf-8?B?SmJjZWpVSGVFWEpySndzcGVIOXRNa21KZVp5KzJiWkQvVTI1a2haaUZ2U0Jx?=
 =?utf-8?B?SUsrckhld0R2RDhBOUdiRzVLUDRvYXVaVjNlZFlCT2h1cXI3dXRsWjhmaWN5?=
 =?utf-8?B?VCtQRHV2dWc4cWJIK21OcnNhSkRZWHZQTTNqaDY5Q09HUmQyZm5CMnNaemJV?=
 =?utf-8?B?QnhoS0o3ZUs2NW5EanVpRDBkK253UFJCVHNjTkVDcWczL21BR1laVnllb3lo?=
 =?utf-8?B?b2ZmSTRneHc0NGhnMzFLc3NZdVhYREpBdFpQUkRqSFc1NGdCTmU5RjJQTUZO?=
 =?utf-8?B?SFpwelYxSndGQ1daSEZ0anZUb3g1bE15K3A1YXhuQ0o2Ty8rZXhFdEdZOVZT?=
 =?utf-8?B?NmpqMktmMksxV0NlU3hVRzlCaktpZTZRL1p3UktCa3RLdVpoRTRwRFh0dFhu?=
 =?utf-8?B?b01QdXA3WEpTRXpHeUY1dFROakFybkNwWnk0Mk5qVERNMXFTNDZ1NXJhcHkz?=
 =?utf-8?B?TklOUHFiemZmemd5SUFqUVRLaWhwRDNzcFpKdHNlWGRGNGRtWjNqemNFVVdP?=
 =?utf-8?B?ZDJEUGR2bHZZNWEwZ3cycjBSUTY2M3JXUG90dENmaFh0b3JTdWhldGQzTDQ3?=
 =?utf-8?B?ZGh6MCt4V0xoeXFIRlpBcURoTk5hOEY5ekNPZ0lubms0SnNGSG0yRk5RdHJ6?=
 =?utf-8?B?UnZkcnY2U0JWa3h0Ym5HbFFMdVlZYVR1UmxORGV3ZmxyZ1BzVTl2bWJRTTRM?=
 =?utf-8?B?R0hGdHM1VitrQ2hseHQreDY5TTFFam1SOHFIRHdsWEsxUTVma0ppdDhQbXM3?=
 =?utf-8?B?c3prQ1Q4YTN3MUlkR0NMSU5iWjRiUXBCYVErMjUrc1hiYk9kMVAvWEUyRTUv?=
 =?utf-8?B?Z3hPV1pWdzRoTVNnQ0FKdEJneXhlN0JZcEJxZndCNThGZDBMK1Z5VFNheW5h?=
 =?utf-8?Q?MQlEZuhpxrixAnObJE+MPJqDuAAPxaGahyW8RCmUINu/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yExBwenlKjyiFVE16AgZCFEMpJRQ8goEhVQawIqT07nQBjOYB/KOyhQcWPVuGw2fqw9INHNJcSqc6Jz5yOkTrT12m28AS2bvw2Hfc1lGZNEVHGr40ajIVQov6GWHnUq7OeJ2EsnDuyCLskZ13AtX/fr4ft0SB5ws5KmacNED9BT/xKv6hAZiLyaoCp+siZyfNdvt4vbgJbrTGQ4seeZBm0N2n1pIbFo9gNgS6lW/ppsVLE+EThV3wDWr75QgstjwbUcSKdBRrxvD9XScVrazt6OSkPml0BlmC+V5XvbKuiTo7VY2RyEZUiByNh/lCbPdbEOtIcc/rI5zau24MWkreh2oUp1/7LDw3Vf96plAcZ41SUNI3MKBJAKxkxAfPRIfIsSLlgwtggwDqFFIHSYM9IepfL8wCEFL+BMguPfuL4mAZa7GlmcrBIjQO3Ya9k9vt2E0MWDC3iX2bfoUrEiBld/OPwX6wvCkzqhVEtnfVGDBbUaRu28N3v8vK2CKm+GqGnQHYbZX9BnHiPm6Ze5T22qDKfMNAWiAjnqIhJgcZEp9AczkXZiilmn4I6iyPaZxQ18J3+TX7WPPi3eov4BqYXRR4JJrvwaidfHOuExDWd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9603c013-ad06-4231-f543-08de05ba74df
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:59:11.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTG2soxKQu5eJVurgE54GmR+laEPEnaI5At2/Y38HvECMyjUezmUwgMdmcfGgOlGKLPUfmIc6Bq6rmdDRwwmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF88E71D08C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510070126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEyMiBTYWx0ZWRfX1mtEhdOjFSOW
 dJA77aY6umH9eAf7QQPU/hekkXdbMLABRIJ9yHw4tts6H4PWKETMHshNBY+YpcOiRdRG670ZSlw
 JV/tZPNCxmL9kC5b/JcjSPpdpC6Qtz2att1uZA4nPzlcJzrOyPZ6cpkEuqPAHSB+mA7awlc6dhD
 owJ7eLH3iCM1AHHRxjgF18ZfheL4gKF4I/yYRkO6te0peTa0cjPKO7pCLSce9ijS5eP/pEiWdRC
 yxv/vsDS5i05Q1cG7mU3s+KK8lXj8CB56Odi9G1/gPEvyIuv6P8DxqVYbTSU54Wbscfjh+50g0q
 fhtEKZwHu36neiWxTpajqyzEhGcAE1urG10k2Ogf/e1+rsQrF/7E1JNJx/TlzeeA9lF6itwH9OB
 DHw3GlrjeagSwtMLW0UjMJ4m2UvG3g7ewQpp8OO/vXh0xCfdEj4=
X-Authority-Analysis: v=2.4 cv=Zojg6t7G c=1 sm=1 tr=0 ts=68e538d9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=JLDxV_SaAAAA:8 a=cTMn-MkfAAAA:8
 a=b2tu90C2KtMzoP-rHiYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_uzX4oWg-uDLJ6b6Md12:22 a=07REm91lqynEFC2MfXjm:22 cc=ntf awl=host:13625
X-Proofpoint-ORIG-GUID: jF9ue9DzNnDo-JCrNJ8KJ-S3bxJ2xKa5
X-Proofpoint-GUID: jF9ue9DzNnDo-JCrNJ8KJ-S3bxJ2xKa5


On 10/1/25 10:36 AM, Dai Ngo wrote:
>
> On 10/1/25 3:54 AM, Benjamin Coddington wrote:
>> On 30 Sep 2025, at 17:41, Dai Ngo wrote:
>>
>>> Hi Ben,
>>>
>>> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>>>> Hi Dai,
>>>>
>>>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>>>
>>>>> When servicing the GETDEVICEINFO call from an NFS client, the NFS 
>>>>> server
>>>>> creates a SCSI persistent reservation on the target device using the
>>>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
>>>>> device access so that only hosts registered with a reservation key 
>>>>> can
>>>>> perform read or write operations. Any unregistered initiator is 
>>>>> completely
>>>>> blocked, including standard SCSI commands such as READCAPACITY.
>>>> SBC-4, table 13 shows that READ CAPACITY should be allowed from any 
>>>> I_T
>>>> nexus, no matter the state of the reservation on the LU.
>>>>
>>>> Is it possible that your SCSI implementation might be out of the 
>>>> spec?  Also
>>>> possible that SBC-4 has been updated, I haven't been following the 
>>>> SCSI
>>>> specification updates..
>>>>
>>>> Ben
>>> I don't have access to SBC-4 spec, t10.org does not allow guest access
>>> to their docs. Can you please share the content of table 13 here?
>> The document's licensing prohibits me from doing this, I'm sorry to 
>> report.
>> I have a single-user copy that prohibits me from copying or 
>> transmitting any
>> part or whole.  Looks like you can get SBC-5 from the ANSI webstore 
>> for $60:
>>
>> https://urldefense.com/v3/__https://webstore.ansi.org/standards/incits/incits5712025__;!!ACWV5N9M2RV99hQ!N4FtetrpMVBPf88WPTlz6EuwsK0kPhNqw04MXvtXGUwMzzAf0NPkCYhL5HYx32ZZVogW2MKS0Jr8P8M$ 
>>
>>
>> The reason your patch caught my eye was because we'd previously fixed 
>> the
>> same problem in the SCSI LIO target.
>
> Thank you Ben, I'll get the spec from the ANSI webstore.

You're right Ben! The SBC-4 spec says read capacity is allowed in this
case.

The problem was caused by the DS was running an older version of the
kernel that did not have your fix:

28c58f8a0947f scsi: target: Enable READ CAPACITY for PR EARO

This fix did not include the SERVICE_ACTION_IN_16 with Service Action
READ_CAPACITY. However, the Linux client tries SERVICE_ACTION_IN_16
three times then switches to READ CAPACITY (0x25).

Thank you for pointing this out.

-Dai


