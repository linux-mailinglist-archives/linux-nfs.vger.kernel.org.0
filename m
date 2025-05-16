Return-Path: <linux-nfs+bounces-11771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C35AB9BE2
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009477ACB11
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE51547C9;
	Fri, 16 May 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJo3JbwW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LgZC2kkC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021723AE9B
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398083; cv=fail; b=cLlltRIRKU2C8ymKtvWrtIv/ZuYpPLmt6IGEZcn6DQPBMz5eqSaLDwfIDN/M0zHtZ+7HUS+ESl7hGHpW1sOZ7+T6OLOPd0e9zXZIquFlM7YbcfYNlnyWZshb6lgqtAArM51V9T3acI23D+Lsx2K3E7epBYtqwQ5sLRd1XO66KPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398083; c=relaxed/simple;
	bh=dKHaemOCJ5gUFzaDFjQ6NZehVD7YQFGAkhFEhJUWD/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=por34ncE20kQU09EzFIb4+jqogwpFkF0AEf8gqDpHUHRqFEkCWnJWeRS/IXPklGg0M4n7dL7/DbLtI08N+ISLZAl9cazswsNt7mlyK8C50EAt40iCAczPrt7EIg56nXSN61ASR4/D8+6iDUuLbV/1bV8mMgNrZJRpVvxz8f1Bm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FJo3JbwW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LgZC2kkC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAhH6A008942;
	Fri, 16 May 2025 12:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5J+U0G4dMB9i7bTNzzOKgJFpkQK656dyFU/I72HuB0w=; b=
	FJo3JbwWrKO7dQxYMUbC8s6HukaXLzbuS9pIB88kmLquZfQdksCeb1z7FdVeM8zg
	PaWH7o0IJc/0TqA/DgH1oYUa4Z3PuPCjvsJPFZqUNjMcbWCgKDYZnkf/GyK5JgHB
	rNd7raCUl/fa2/srrEaed921Ty3zpSuBOVnMgB0CVsyQ8vTDXAEbnm8mAA9wof8x
	vNXbb+fn71N8Av0F5apU7ngq1uugFlbbFrzK6i3BufLNwlB+0ZsowS686s9oO6qw
	c+9FwKABULCDona3t7o0hy73I7uRbOt6713KNaE+mUUPEidwh3jgGEqTmleL2Iag
	NuCx1zt2CLO/N/4GwBHVRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbj1876-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 12:19:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBTTtB016728;
	Fri, 16 May 2025 12:19:08 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc3619cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 12:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFFhnWuuvZh52wQTAkeXPWECw/ntVX68icn6DMn3EnxvpqN6LsygYynvYW82+dRuCKxqcPKYGPy8TuJTBoBKkiMxpDB3b/1U2nr5gIuC4XAZ2yCp2iTmcPyMin3K0ZgJRv6KLFcEmCKzJGzr8LppBvs4D3Ahdn0ajMtfezmIhn3l++El0kBrjotqQTFwSqUM9laAMjns+1PJKcVkGDjYhuWhsgeSGUIaquEDFxhX5TAug2mMT1m98MKi+0GVT8kH2/w3tWu6n4uuia249plzPPtFX8ThhX4gGT9II1IYft/zHJaPvuRxbNdmcN6N2E4d1XJSlYq+u8OdNeVJhfCH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J+U0G4dMB9i7bTNzzOKgJFpkQK656dyFU/I72HuB0w=;
 b=w7fOq3w2sbxC/5U9VYLvpip5/Ss+Lky5uONvJKhlYpOx8OP9q5h96vLL20bPOe+MubZ8Pg/F9A/qXO4D1F9Qu4Vmpq7EEAPzwa+vo+8gGgdCiquXnWYy/5Aw2cx+jyjMytvSuI58mUPQ6PQiDzg63Ny5OltenHzXjqEJx2X2Q8/CoXBtbzgoHP95ikZi/BzTh3DTDwrbWJm7rhpubGk7OWq8bhx0gndP/B7gp2gDEC5+fuJvQ9OP6RNGZOAXAFQLbtYQbOUn+U3JVJ6z3miJRwQoZGIfaJp4xifmqemz9WTi+8B6fP859/YjJvktYW5eXRsv13xrH45UpKWTny8aAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J+U0G4dMB9i7bTNzzOKgJFpkQK656dyFU/I72HuB0w=;
 b=LgZC2kkChOBLvbDh+PjEN/SD7BEIwWXRMjHmJJrta6VShY3drvcWz3f+apbTJXjL3ckIbAtRep08zf1wJREY/W/lGP90dn77ymoLeYx78zwnvHy2uCdUpuzwn+ORAaZcPE7M3twtuYOMHNJh5DLtD+YKQCGvteR34a5RV0n8SU0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 12:19:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 12:19:05 +0000
Message-ID: <3c1acadf-b2ed-42b8-926e-662df5a8aa4c@oracle.com>
Date: Fri, 16 May 2025 08:19:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Daniel Kobras <kobras@puzzle-itc.de>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
 <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
 <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
 <b8f4f808-48df-4659-9afb-2f9994b22e7b@esat.kuleuven.be>
 <8abc8a16-cbdb-4285-a2da-62f57fbbb165@esat.kuleuven.be>
 <9c446dc2-fe2e-4bd2-9ad5-f4015b0e2ffa@esat.kuleuven.be>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9c446dc2-fe2e-4bd2-9ad5-f4015b0e2ffa@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 978546d5-ca2f-4cce-8064-08dd9473d9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjN0RXM4WWMramx0eldsSzJjeDRkYlVjZEttRllvdzE1UzlORHhid1MwbUl6?=
 =?utf-8?B?eUtWOHZLbEJiMUtqZjg1c0lUSEE1am5pSmZQVzBxNlhRNE9mTHVwa2tzMjlj?=
 =?utf-8?B?RGllR3NBUTd4T25yOVlOYkhCZC9uOHk1QmhPL2tnRzZtVGpoelhCSFlyMEJQ?=
 =?utf-8?B?Z2lveXpEenVaK1daZ2NjblhEQ0Z6Sitpc05aWEJYT1JPY1VKL1dsY3hLWEIz?=
 =?utf-8?B?MUlNRTNFcS9jRkhtd0xjN2VoQnZDRWRoUm9qRXlOWGcvcVVlUU0vL0ZFY3Vj?=
 =?utf-8?B?M1pZaVhHM25haWV3VHVCV3VWeUN6Q1pKUFJhMHowYnJJbVdJTHN6ejloZmxS?=
 =?utf-8?B?bnZJemxkRmE3NTBVMXVzUzdkdDhQV0sxenVhR3FIN29PejE5VTBNZlF4K2hw?=
 =?utf-8?B?VktSTnU2aUIxelc3czc5VGNFL20zQlY5dW8wUnBmVDRGOFRWOHVCVXBMTVc0?=
 =?utf-8?B?dXdtcThCaEpCbDZ4NHNuR0tJU1R2U0tLTkMzZnMwRmFRNGlYUVJQYnFQRC9G?=
 =?utf-8?B?OGZhNFBNL1cwODIzRm96bFd1ZnMrV05FeUNqaitsZkJCUUhScWhiRzNGcFF2?=
 =?utf-8?B?MzcycFJndkxQTmErTTU3U3lkTHNqZG5XWkJGUzZMVzgzV24wRTVUVTNVcGsv?=
 =?utf-8?B?NFhucEtaajArWjFxeGQwNWtVdW5udm9qbkNDY2t0UkhYN3B4OHVDYldWbHN2?=
 =?utf-8?B?aWJGM2s2ZDZ4YTVwbWp1Vjdqdk9NSmwxbmVKMGtRZVZidHVlaWY3OVkzVW8z?=
 =?utf-8?B?RkEvMHlKaGdmY1N0ZFJzakpZcEFiU1A2SHEzdXhpTit2Ym43NUxPTnU1d1JD?=
 =?utf-8?B?WEc4MWlLSzVYUG9SeHBzL3ZxTUpoMDFrWTA0V2Vpajl2cFk1aGRBNm1GNzJm?=
 =?utf-8?B?MGpqNVlxTStJa200dTR2WUxiMDVrOHhwNENkZERuYlVJSDVjS0dUc2tBL0JW?=
 =?utf-8?B?L1B2eTlCRnJyamNEY0g1eFBMT0hFY25hSE52TVJwNGhFcm4vZ1pUeUJHMmpP?=
 =?utf-8?B?NU02RXA5NGlMbCtkT2VrQ0MySkhUUlBlVHF2bUo4MXJ3S3Z0RVBDTzhJN3cz?=
 =?utf-8?B?Y2ZEbUNNcjYydng3TkZFNEU5ZExLVktTbVM0eW02N2lmUFNTR0ZoRzJZMnVI?=
 =?utf-8?B?NGh0T3JuWUFSVU11aWdFQzRrZDF0Mk9PSzgwUFVpc3dCQ013bEZ0YWtKaFZh?=
 =?utf-8?B?aDdmT1BSSkluNUQ2a3MxcjIzSHZMeHNiam1iRFI4QkZOZGFiaG05cHFPNEp4?=
 =?utf-8?B?dTQ0NERmQkpRaVJUYklBcXpsdXZqV2dlWTVkZm5jdW40bTdzcFVaS2F6ZUEx?=
 =?utf-8?B?VTkvQkZOVmRrQnFjL1R0U0hnMEN2YURKaE8xSUtyNVUybnBJb2NQdFZJeTBt?=
 =?utf-8?B?KytRMDN1NnJkUXZNTTlxMFIvRExZWFNpQURQczlqR3pQMkZHVEVCb005Yk9O?=
 =?utf-8?B?aEJ4NmFWKzJGSVBMYmI3RTJXciszMU0rTEN4UytUZ0EySmM4NmxwbDA0OGxY?=
 =?utf-8?B?a0poWEs3eEFHaVduYlN0Zm8xd3czUFNmeGFEWis5a0dYSnBQNUJKY0NYcDM1?=
 =?utf-8?B?akN2c0x2cmtibGdTMVNGS3pGcFV2SUNobUVQTUFndHNobVBHOVByRW9Icm1R?=
 =?utf-8?B?VURPSGxLay80UC9KalJVb2ZVUXVBNno0L045eUJZcEZGY0lMM0xPZHMwbUh6?=
 =?utf-8?B?WmU2cHQxQWdmdlE3bEV1WjdVMTRScjY1R25MZnhZM1cvc1ltM0ZTeUNVSnhh?=
 =?utf-8?B?VW5iMXBZNWJvdDk5V2RwTDZrTnNrTmNpTnlWTjMvVEFwUHV4aklHd1V1K1d5?=
 =?utf-8?B?Zk1tNjFqMTVRZWRqSFQxaDlzS3laNTB5YXRONDU2Q2loQVYzOUtqN3haTWpv?=
 =?utf-8?B?SFZ5RkRhZ2pFd2RVSmJKc3phZm5QTXlvTGVNTkVBOHhwamNreHJHZkM5c0tT?=
 =?utf-8?Q?O5l6yzP9AUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUozTzFESzRDYUJSbGp1YVVPeWcxTzJsSjF6ejhuKzRQdWNUeFlOOWpNcnJD?=
 =?utf-8?B?MlpiU0pKZDZMWUQ1Z2M4UGU0UE4wR3hUSFJZMW04WHFabjh3WnFHV1lUMHpo?=
 =?utf-8?B?bzFyTFdHMFZTSlJKa2JndFk3T2ZjYXUwZWt2OHd2N0NudzdsMktoVklQTlAx?=
 =?utf-8?B?Zld3d3BaK2cwWHZIV2tXcUdZelZDTFo3TzVwcnlrTGJFZUhWNkpTQldLVGI5?=
 =?utf-8?B?TzJsd3U3SCtraTd6YzBIUFN3Z3lUSENPZExQZ2R3VS9WS24weFlOOHdxbmdi?=
 =?utf-8?B?eHRDSzBWc1RoL2NOK09JdGhyc0ZiT0FJd2x4MlNMR0paRTNlRTVNZmJvTE4x?=
 =?utf-8?B?TjJXNlVweUtJb3ljeWxSVytLQlRNTXovR250MExIekFzeTAxSkNVSGhvd1V5?=
 =?utf-8?B?bFpKanVaTzFmVUNxbFdNL211SXhhZ2dmbk1CdVRjWmxQdXYyQ1lNeVJiNllV?=
 =?utf-8?B?aTYzWnQ0cUFsdE9ua0NCMnpmU3ZHc2JLMnM3Qk1McmRPSXdrN0RIdGQzV1FG?=
 =?utf-8?B?Y0NtalhaUGZla1AxZ1BQVFBJZVZzMGNzQ243SUJCcCsxVGo3S0RjdFZWUDlB?=
 =?utf-8?B?Q3ZZMmlnUGQrbFRoT1Uxc1B0RG1ER1FDOHVOUW9rSERXWSs3SG5neEZodXlq?=
 =?utf-8?B?NDA0Z21iT2RoTTZ3cU1DZEV0YWE4ZGZ4cHhsQ2Y1MFJ6a1hGNHIzbnhTd282?=
 =?utf-8?B?a3R6WDFNTWZyZ3BqTWpMeC8xR09xRjNCUkhYTmR3ZHYyS0MvdVZtTjFlamwx?=
 =?utf-8?B?L3hEaWtidDgzTzJTSFliUzBxYjFoMmN6OVAvMDVPY1JLTllLQ3E2cDJaYmF5?=
 =?utf-8?B?ckJxWGFCMVJEMGVETDN0TXJhcFdKRkZhWWM2d25BaGpLc3l3U20rdVBhK1Nl?=
 =?utf-8?B?OTRXSTVSNnI5N3VWRzQ1Z1h6RkM0UHBkTVliVzNKQkpodDRmK051MXBJOVFo?=
 =?utf-8?B?UmFOZGNXUFBoWndCOTJEZHMwbGM0c2s1dTVLVmJWRHc5REtVc3JjeUgyVW9t?=
 =?utf-8?B?UlJRWWN4TFZhVWpZRENrS2RUWmVUWTB1UU80ZkhtUU8rK2wrc0huOHE5Zytl?=
 =?utf-8?B?TFJtZmJnWURhSlBnNWpDa3Bybmg2b0NIaitBVXdEOVNNLzVTc3YyTW51Qkhp?=
 =?utf-8?B?dkRtbjUvTC8vbnlBUE0xNGtRdkVCYkpUeHovZUFISzVSKzdKVnNTc0VlQlk4?=
 =?utf-8?B?TFlYR3E4dWEyclArdDN0WGxmUkphOHRpd0Y5YlVCSHdsMGwwUWkxSHZUWE9F?=
 =?utf-8?B?WXQ0WnY5QmVLSGE0N1E1WDdkbW8rekxSSlpCanh2N2U1N2NzK2JjZW1PMm81?=
 =?utf-8?B?Z2xhREltdXBCTm9xYWl0Zm12QW5YT1JDcG1PQ0pKUTh1bGJwbVFNdW54U1hs?=
 =?utf-8?B?bGwzQ1NCSk9WZXBwNkpmc09oRHI4Rlh5eStDS295M3BqU212N1dOT0YxK0sy?=
 =?utf-8?B?WGwzaUY1QVgyeUFJZzN0dW9jRVM5N1RveU12SCtxcFc4K3BBNTQrcWEwQVNw?=
 =?utf-8?B?a2EwcnEwOU9zam95RXpuMWRwYzVUck1Gb0NWU0hGS1dZbzR6ekc3bklGeXN6?=
 =?utf-8?B?THRWLzNJSUEyelk4bnJETkpxK0ErQUptVHRmV3pWMWVJamhXTDlCS0FSSnVE?=
 =?utf-8?B?VFJYNXJIdlZsbjFhU2lkOFFYQ0t6enk0WTlRd21BNjRIRWtlYU8wcDRtaW4v?=
 =?utf-8?B?TTZQOEZ6VzZvL0oxcDBpczkzdVBFdTZ5dUdqSmZibzl0VEYrYzN2N3d6MHls?=
 =?utf-8?B?clU4T1l5Z0hKUjJkRzdUUGMvT3FKSkhRUXJqZGlhNDZHNjJKemRTbWk2N3JG?=
 =?utf-8?B?M1FQY3RKdVFJcjYvNVB3a29wTmxPV2pUQmFqOGNFYlQyN3JBd1FOUGU4VjZQ?=
 =?utf-8?B?RytxVzlpZExoZG42bEZVR0FCZU5KcldPK3o0T2w5cFNUK0dpWWl4Vm1zMEov?=
 =?utf-8?B?TndZQjBSaUlzNGFWeHNLNDB4R1pIdzR0dzdyN3lSMy9UWSt3YS8ycVVUK1lT?=
 =?utf-8?B?Mzc4LzdNNmR6ZmFPVVNFcnRicDdpcjM2VDJvS0pkUEU0T1BZZWtHallpYnFH?=
 =?utf-8?B?Nk1kUkdXMzJzM1BUTzhod3F2SU1KdDFrWHlsQ1JTYnYyWTBjTTFDbzg1UVh6?=
 =?utf-8?B?aSsxTkltVzR6ZzZaaUgySXUydHBUMWtvTEJCc3pNeERlNFdzOHJBczY3U1pB?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QooHutLDL0EnGGgEtbo9pXRa7t4fxm6vrm0Nl7N9Cr2j/hG8uFSiHnWAhFl6b3vOJO8SoBzuPwJ3q3cElmWN6ZgbuqRKlbL/RZOGSO5mZy+uHcIItVGIBJ9UbMfPf4ID6HY7g0tXTqMfp2UxGuc25hSrNQTTE8XT+920tRW8qbAmOMZAMDVeb13oMAjw5HnpbYfsC/kB7DjNnLV6NvywYQN0IttMqy73jWZLrVRX27kqIh2bgpi2k0qtiqiTeaAtvrAdANGxiPkEbar03xq3AyI/UECzGsYEWnVjBhWWyFw4nY4kFj2j9ptqaUe+t2AA9E4MTU21f1y01Rv3k3FDq0Sw0Wgd9xHOPckoM0k+qLMztC2zW4sw5cPuySg3xniaAysXMH98kKw2AlxWsifqLR1baudD9OsQ3cbQiei/Y89Y5JaQv+bRBOFnS0xri1lo7My8K3CYbOCOVm9VQ7GA/bOTN0k05mZ6mt3ljFHB7RxH6izEfLAFeBzCUUqTSwWSx1HCYUkDg7IrbGH8FwcU4KW3BInUyTrRkqnCkYooB5sfIJmyUQCl77wv8B56a7a9+mKUEEy3genwnBNPYUfyr2HcOpZQKftp4oK/UpoOlT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978546d5-ca2f-4cce-8064-08dd9473d9fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 12:19:05.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjFRCO5uJsDwm7Mo4P+Djsz9fhZsQrL9SGhLgVN/M55bqow2ZNd6nTsLrl6XlDhm2QAlDK6VK3e8oGauw05liQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDExOCBTYWx0ZWRfX/b4mlOSgavEv rbG2rKzIHfLaXJS6el0nUwsOkbUuY28ctIDKH4tp0EoSfEy3z5SwLj6tofP/y9EPwqCQZiFIZQd xiUE4R5vNrK+HEbBlcqqpE2PK9WqyyWPwaBPxcjEmuJC+NNcWhIB3K9B/Q7vrmXxBSWLtL18PVB
 Zuz1aQaW9CfvKfGmR23J6+bTsJ09Kav4nW1uuAvkKCTyH4yTvCRpFkmiww+m7vA0T3cSQvDJOIy 1gEijC9LTpDJjOu5b+pwIs1BBolmuwa/hW+xRsYoPQXIDFpwVEUZfuyGRkyheInQwEXhuQ+V1qR WlJ3bxXun6iCtEaThNz/wHawVn2a1A3y2Zoa+Uga8ednpzCxEJqFrsMuzWsxbVPbwoMH58cZIrP
 6fsC4/f0ufil9/TqC0FpWSmCQ1fK8xAX3HB+JM79HkZVpDinRU0PazGyJBGes1Cb/u7l02Mx
X-Proofpoint-GUID: pP5aiXlQlQlDGlnNWq0cryq4Dt06Xw2E
X-Proofpoint-ORIG-GUID: pP5aiXlQlQlDGlnNWq0cryq4Dt06Xw2E
X-Authority-Analysis: v=2.4 cv=YqwPR5YX c=1 sm=1 tr=0 ts=68272d3d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ZtthW2ydPrnSKC8YAyoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 5/16/25 7:32 AM, Rik Theys wrote:
> Hi,
> 
> On 5/16/25 11:47 AM, Rik Theys wrote:
>> Hi,
>>
>> On 5/16/25 8:17 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On 5/16/25 7:51 AM, Rik Theys wrote:
>>>> Hi,
>>>>
>>>> On 4/18/25 3:31 PM, Daniel Kobras wrote:
>>>>> Hi Rik!
>>>>>
>>>>> Am 01.04.25 um 14:15 schrieb Rik Theys:
>>>>>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>>>>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>>>>>> Suddenly, a number of clients start to send an abnormal amount
>>>>>>>> of NFS traffic to the server that saturates their link and never
>>>>>>>> seems to stop. Running iotop on the clients shows kworker-
>>>>>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic.
>>>>>>>> On the server side, the system seems to process the traffic as
>>>>>>>> the disks are processing the write requests.
>>>>>>>>
>>>>>>>> This behavior continues even after stopping all user processes
>>>>>>>> on the clients and unmounting the NFS mount on the client. Is
>>>>>>>> this normal? I was under the impression that once the NFS mount
>>>>>>>> is unmounted no further traffic to the server should be visible?
>>>>>>>
>>>>>>> I'm currently looking at an issue that resembles your description
>>>>>>> above (excess traffic to the server for data that was already
>>>>>>> written and committed), and part of the packet capture also looks
>>>>>>> roughly similar to what you've sent in a followup. Before I dig
>>>>>>> any deeper: Did you manage to pinpoint or resolve the problem in
>>>>>>> the meantime?
>>>>>>
>>>>>> Our server is currently running the 6.12 LTS kernel and we haven't
>>>>>> had this specific issue any more. But we were never able to
>>>>>> reproduce it, so unfortunately I can't say for sure if it's fixed,
>>>>>> or what fixed it :-/.
>>>>>
>>>>> Thanks for the update! Indeed, in the meantime the affected
>>>>> environment here stopped showing the reported behavior as well
>>>>> after a few days, and I don't have a clear indication what might
>>>>> have been the fix, either.
>>>>>
>>>>> When the issue still occurred, it could (once) be provoked by
>>>>> dd'ing 4GB of /dev/zero to a test file on an NFSv4.2 mount. The
>>>>> network trace shows that the file is completely written at wire
>>>>> speed. But after a five second pause, the client then starts
>>>>> sending the same file again in smaller chunks of a few hundred MB
>>>>> at five second intervals. So it appears that the file's pages are
>>>>> background-flushed to storage again, even though they've already
>>>>> been written out. On the NFS layer, none of the passes look
>>>>> conspicuous to me: WRITE and COMMIT operations all get NFS4_OK'ed
>>>>> by the server.
>>>>>
>>>>>> Which kernel version(s) are your server and clients running?
>>>>>
>>>>> The systems in the affected environment run Debian-packaged
>>>>> kernels. The servers are on Debian's 6.1.0-32 which corresponds to
>>>>> upstream's 6.1.129. The issues was seen on clients running the same
>>>>> kernel version, but also on older systems running Debian's
>>>>> 5.10.0-33, corresponding to 5.10.226 upstream. I've skimmed the
>>>>> list of patches that went into either of these kernel versions, but
>>>>> nothing stood out as clearly related.
>>>>>
>>>> Our server and clients are currently showing the same behavior
>>>> again: clients are sending abnormal amounts of write traffic to the
>>>> NFS server and the server is actually processing it as the writes
>>>> end up on the disk (which fills up our replication journals). iotop
>>>> shows that the kworker-{rpciod,nfsiod,xprtiod} are responsible for
>>>> this traffic. A reboot of the server does not solve the issue. Also
>>>> rebooting individual clients that are participating in this does not
>>>> help. After a few minutes of user traffic they show the same
>>>> behavior again. We also see this on multiple clients at the same time.
>>>>
>>>> The NFS operations that are being sent are mostly putfh, sequence
>>>> and getattr.
>>>>
>>>> The server is running upstream 6.12.25 and the clients are running
>>>> Rocky 8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).
>>>>
>>>> What are some of the steps we can take to debug the root cause of
>>>> this? Any idea on how to stop this traffic flood?
>>>>
>>> I took a tcpdump on one of the clients that was doing this. The pcap
>>> was stored on the local disk of the server. When I tried to copy the
>>> pcap to our management server over scp it now hangs at 95%. The
>>> target disk on the management server is also an NFS mount of the
>>> affected server. The scp had copied 565MB and our management server
>>> has now also started to flood the server with non-stop traffic
>>> (basically saturating its link).
>>>
>>> The management server is running Debian's 6.1.135 kernel.
>>>
>>> It seems that once a client has triggered some bad state in the
>>> server, other clients that write a large file to the server also
>>> start to participate in this behavior. Rebooting the server does not
>>> seem to help as the same state is triggered almost immediately again
>>> by some client.
>>>
>> Now that the server is in this state, I can very easily reproduce this
>> on a client. I've installed the 6.14.6 kernel on a Rocky 9 client.
>>
>> 1. On a different machine, create an empty 3M file using "dd if=/dev/
>> zero of=3M bs=3M count=1"
>>
>> 2. Reboot the Rocky 9 client and log in as root. Verify that there are
>> no active NFS mounts to the server. Start dstat and watch the output.
>>
>> 3. From the machine where you created the 3M file, scp the 3M file to
>> the Rocky 9 client in a location that is an NFS mount of the server.
>> In this case it's my home directory which is automounted.
> I've reproduced the issue with rpcdebug on for rpc and nfs calls (see
> attachment).
>>
>> The file copies normally, but when you look at the amount of data
>> transferred out of the client to the server it seems more than the 3M
>> file size.
> 
> The client seems to copy the file twice in the initial copy. The first
> line on line 13623, which results in a lot of commit mismatch error
> messages.
> 
> Then again on line 13842 which results in the same commit mismatch errors.
> 
> These two attempts happen without any delay. This confirms my previous
> observation that the outbound traffic to the server is twice the file size.
> 
> Then there's an NFS release call on the file.
> 
> 30s later on line 14106, there's another attempt to write the file. This
> again results in the same commit mismatch errors.
> 
> This process repeats itself every 30s.
> 
> So it seems the server always returns a mismatch? Now, how can I solve
> this situation? I've tried rebooting the server last night, but the
> situation reappears as soon as clients start to perform writes.

Usually the write verifier will mismatch only after a server restart.

However, there are some other rare cases where NFSD will bump the
write verifier. If an error occurs when the server tries to sync
unstable NFS WRITEs to persistent storage, NFSD will change the
write verifier to force the client to send the write payloads again.

A writeback error might include a failing disk or a full file system,
so that's the first place you should look.


But why the clients don't switch to FILE_SYNC when retrying the
writes is still a mystery. When they do that, the disk errors will
be exposed to the client and application and you can figure out
immediately what is going wrong.


-- 
Chuck Lever

