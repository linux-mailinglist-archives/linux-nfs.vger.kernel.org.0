Return-Path: <linux-nfs+bounces-4302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2591713C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0BB1F235DB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C2146A93;
	Tue, 25 Jun 2024 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M2m5Xa1s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ERbvZyTi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9A146A64
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344905; cv=fail; b=JhFDi5wqF/n/pQA3eHv1Wn8USG94Zq2r/dnLkhZId2JbaqS/c8BGsM11bTwN/nQQerffIxNy0FDYl8txHBq9GYND/JxoX2+W0R9TBszKPW3WMvdaUbKCv0rd4X0rlfzi7v6gC7uUTqgpUZqtxmaku3pS4tIv6kF3Qn3E9QQON8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344905; c=relaxed/simple;
	bh=fULVsGiIyiPEC6/BRzwIlkfqzFqju4A2+kcigvR1fJo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvJKWed7fPlAgT2vFy0FANHG5WhJSPRRTarOIKjvAEipgpuUULBSqKz1jwB37WkEREqYYUoZK05wde1Ew3oAKq8aFux37Gj8mWRpAhwzZywsS4yib++8qbG0gjCIeRLQw+5/knd/q0sAE0cb2o/Wk3flAb+0y8txfEBSYuR0DVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M2m5Xa1s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ERbvZyTi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfY4a009064;
	Tue, 25 Jun 2024 19:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=HNr0n8l2WGnke9/g+livl/OERtd0JYQrx3M9u2EOUrQ=; b=
	M2m5Xa1sc4cR48n7Kxo7r9e/43ZHLgOsMY08fP/nrEgwqWlnoErt8taV5xigmA1f
	378uPATGNmf7wdErkyZjZTKjA7FKIWVWMZhd2dCiuCyskptKinwfAXkniAr8wVQ6
	jrNOl9TV02sSLtObn61EmD+Jn6a0YibS0T8YekjCgjIaoPhZwxE+AbqULziJ5FZ4
	NNXPG6xbLbjNgik1PHz+zeWdly082ao8ZOScN7huLKs/JHcnmOZK31CB6fn1nz7n
	xcTFAtTWirp8seedzvy0uGNlrTiaIIm9YNDfw+bMzqhUBaUzTmFHbvlZj+ztazb2
	TyN5UVskmVl45WriXd/bHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb1mmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:48:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIlqcS001395;
	Tue, 25 Jun 2024 19:48:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn28sy99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chp0aP/chMdGXP/SJrYB1ZmGp3fE7PRdNU+51R5APTOHCxRvxSNpMPQ4TYBDN0XlD84EscmcArt6MwAUbJqyHPknHZdmjkUPcIpNuhaioOy8VyRY6HEDfgggZC6Hjh+q7qUygVKvr6raZB/hOt2WcDwbvGkdWyQwbp8HyrCtGi8z2KglgCObd/R+brW7CsCd1i+X6FRgOcFQtMGXpQDwT9XXBtWkA1XDtepLM3fo9NK1espibM7dF0sshrP+358jsn3UZP0k1/ZBwccURqMeIqf8Sx0adRr6uPytAi0V2DqrzFr4yHBoJMtrmIie2EF17gEHbDW1moefP6Ky9oYmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNr0n8l2WGnke9/g+livl/OERtd0JYQrx3M9u2EOUrQ=;
 b=AwK9eSOljqP0KMOc8A2/ymoGu352zWp6vQRXCnerBImACh4Fkc21JiSrIWSzDjSdBQIEkBzDCk9M/ZmjxgLHAkhLy+oNiJ6RQTIbATKhTMzLw+Cr3wVmDJi2zEPPXhXIiND5MXDfSGY78Hl9mtu1K7mQbnzq1GR6V/dKTnGDwSy4brTyTVhyNGsMxEn5BnnvJREFmi5HIwsGT9EBHGLH+9t7Bt4gIJlyQ0oNPQtqb4nc/oUR1kIjyafhky3BVMCdlnpHwbVATIf/zcu5Z1JEbNfNckI0XkAPpuDMJXzz9hA043YVcJSBmFYAZP+V+AiXiHcp7oGPSYt1XdUTtuu/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNr0n8l2WGnke9/g+livl/OERtd0JYQrx3M9u2EOUrQ=;
 b=ERbvZyTiiNsPyiUw5YEoOuVmncmMFAKwWNhpueJSKEf7IRobJFN+GbZ+q5q3M5Yft7BuY33DJZ9CN7TDKTkuMcaR7gH9vHfUFuutrbl5+edQjLK3ni69PLL7mHDs7whFN2SgwbqoNvw5BHIP4nOQsh+QnnlP1XFyYCdRL5ppsG8=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH7PR10MB7850.namprd10.prod.outlook.com (2603:10b6:510:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Tue, 25 Jun
 2024 19:48:15 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:48:14 +0000
Message-ID: <fdd4e4ce-65eb-438e-88c0-2688b7fa196b@oracle.com>
Date: Tue, 25 Jun 2024 20:48:11 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: ktls-utils: question about certificate verification
To: Olga Kornievskaia <aglo@umich.edu>
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
 <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com>
 <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH7PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: b220d15f-2f5e-4a3d-2490-08dc954fc088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SklWVzV0QVAyVExhUWF6aE03RVZMTFlXdHJBeHNkSFhSTThwL2xGMXFOSVg1?=
 =?utf-8?B?enZFMk1nNnVlMVhzRG1NVmMzbEtBN1Urd2h3KzZ1SjRVR0gySjF2M053UVFL?=
 =?utf-8?B?RXNMRTdwTEptYlpXWVZab1Bza29zSWljUTYyTUZxN2UwRXpueTJvMlI3czQ5?=
 =?utf-8?B?MHhITWVvQW1kY1lwb3VmRG02TnFGTHMrVFRRaW1lSUFEYmd1R3FzUlZKWDFL?=
 =?utf-8?B?TVl2VFFLN1Q0TXhaem83SThTRGZzWk1LNVdJZ3lielB3MG5MLytCZG00OEIr?=
 =?utf-8?B?ZURDdkFDaW11Z01RZS8vUEFMYkNyN1dublVzUWRpR1BLcTRxWXBRV1VJdGhu?=
 =?utf-8?B?akNlWFZCZ2FIR1AvVGdhbDYzVVdJbVFiZU54MDdINWJnWkJwT2lsQllTUFRu?=
 =?utf-8?B?SmVoV2h5MXJvOTU0RC9BcFJaZUNIYVA1SmhISWhSWXZQZk11T0FLZFpobE1D?=
 =?utf-8?B?QkJObUhKaHFyWXF0TENxa2pFKzd2SC92SzdyTC8yYW9tWHN2MERPZmQ4L1Rk?=
 =?utf-8?B?ZFc0QmVsWVpiK1BwV0pQM254VWUvdkVoUks1VDB4T2hzZmdJeUFtYmtSakM3?=
 =?utf-8?B?MmJLdEw2N2dBZWlzMkJreHJnS0pRVFY1eS9jVFQ1Y3R4eGJPYnlxSGpQOXFh?=
 =?utf-8?B?NFBET251ejlWRnZWOTd6NTR3elFRNkhQQ0piWC9sM2Noc1pnczB1SlUvRWJN?=
 =?utf-8?B?Q1Fpb3FZTjI1dlBRdFRPcCtDcG9BVmRaejFkTTQzc1lXTGtuV2ZsWXptelR4?=
 =?utf-8?B?UmRtZW0wZkRKVHR6NmY3NCtQTEhMUVVxVXdocVlDcmxLcDRVVjVMVzBsa01E?=
 =?utf-8?B?TEErT1ZTNWZ2ZC9GR1NyOGgvZGNtUjFwL3ROODhjNmNTWHJSelRwQVZ0bElQ?=
 =?utf-8?B?TDdqQnFFUmVRQzdKZG84QXRyNVIyTTNyNklZbXJGemtHaktpZDl4MGk4anBJ?=
 =?utf-8?B?aGZlNXZ1VFQ1Y2lyb1NlbkIvcHNjcVNtNGl5L2lzVVJUVitDbmVENmV5MFpB?=
 =?utf-8?B?YlVwTnZJZVpjdmxyQUpvenpTNUlYVzJuRjMyaGc2aktNK0QxVTZ5ZGhOV0hY?=
 =?utf-8?B?YnUrSDE4WklyR1BvelJIYytqS3hGdnIrNTRjQjhxVkthZkZId2k2VmJpYzdB?=
 =?utf-8?B?SC9vK3lpVWlWQXFxc3lSdERkQVJrUExRYUFYbmxnYlVwVHdkUjhoSTlNTzlq?=
 =?utf-8?B?SzRFcHN3cnoxZ2tlOEJVZ3NKZGl3Y0JmRkozUWJoL2dHRXZSdXlWdjlubzRN?=
 =?utf-8?B?cm52RmU5bS9ZMm5WeFplMEZvTTNuS0hTQVBLdnhDZlFObHFWOVUxUEE3cW03?=
 =?utf-8?B?cE53amRSTXVxdXZYVHJmMkt3NjZ6ak43QXNkTDNnb1Zvdkw1TWpaaUp1RTBO?=
 =?utf-8?B?QndSZGNBSGV4eWlPN0Y5VFI2dXJXWFE1dHlRbkpjSC82SFhhNHA2M2xqZjJZ?=
 =?utf-8?B?RWUwdzZ3RUpMNmN6ZURoR1ZCb3VmMk9QNFNMNzZ5QlRSeUIwa1A0V3E2QUFP?=
 =?utf-8?B?MWQ0ZW54S3dEZk5wWlJRUUdOYjZ4c0ZBbFVWd2thZExXR0NYb1c0TlJhRHkx?=
 =?utf-8?B?SzBnc3RKOGF6RC8xcCsxcGU0WmJmTG40VnNNNytFa1JkczRtTmxQS1J0UEx3?=
 =?utf-8?B?aDhHbmZTa2ZjRCs0eW5QUnNuWlNtb0c5Rk00UWtBV1U0cTlZRURkcGdKd3VP?=
 =?utf-8?B?aC9BNzVBZW5vQ2g0b1ZqSG01RDh1V005N1dVV2xzVlFZd0ErYngxaUNJSDdk?=
 =?utf-8?Q?eUDtRJkw5uc7O5px95YCdCSya78zXzvarc3FY6S?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXBHTlBwTXMybWVlNnNNMW1HTXhFRk1Kd3l1VUZYWG9wUkppL2NKdHNOUG4x?=
 =?utf-8?B?TVp6UFJnRTJ6OVFpM1N6NFVUTUE5clRGS29lOWRVRXBoeGNuVmJLUmkwcTN6?=
 =?utf-8?B?MlNEeXNHTGJHc3hncDdpaVZRWGF0L1liKzlZSU5iMVBoNFZiWnVWSks4Zloz?=
 =?utf-8?B?RFlOaFF0V05yZGl2S2VnL1I2TitLeG8yclpIWWJYUHRWNGx3dWtWWStPTFlm?=
 =?utf-8?B?R3c0ajJwdE1NSlNBMktjRzRSYUdXQWdqaHZNT25rYktBck5BNHRJaE9mcHN2?=
 =?utf-8?B?TDV2cHVkVWJtWDc3c215SWQ1MzN4azlpeHBYU3VrMjdaZFZkTTVsMUN2bHRp?=
 =?utf-8?B?cTFkMERnRDVHcSsyanorRkZyQjgxVzZaWkRMN3NkakY3YlFRRTllaHVTQnhz?=
 =?utf-8?B?YlVFOTZ3VDdLcnR2TTd5R3FYSmp6SjRDd3FZZWdVR2I5eGNwb01MeWZPWktQ?=
 =?utf-8?B?TFNmQ2phbmpwWS9rdkJEc0tLbVg2NFVIbUlZVHArNWNoTVNIempRN09CRWkx?=
 =?utf-8?B?SVo0SVFydlNoakhMRTc4QW9NZk5odnhSbFZQRWlDbnFmZ3EvSW5rbjhpUmZQ?=
 =?utf-8?B?eGswOTd1V1pBcVNUdWdyRGFNS3pZR2cwRE01QUNtdFdlMWtGNU9jTEoyeXhw?=
 =?utf-8?B?dU82NlhXWUk2Q2NWTjZkWmZFbnJNTjFGNzJyWlcyMXBqL3hzU3doU3RYSFMv?=
 =?utf-8?B?WGhyOWROaTI4QSsxOHMwMTRsYXFuMzVvRHo1SnpaMWV1Y2xXM3JCU3hyb3Vi?=
 =?utf-8?B?UkhGSlBvWFNKUHB3SVppaWM3UjRkUzNtV3FQTkhHOFhNM3VBZkVPMThuTVBI?=
 =?utf-8?B?eXYzZndkNUJvSk9tMXBzakxnNlhGck9SSzRQWlZnZGc5UWtVdVZ0UFZxeGJW?=
 =?utf-8?B?VkY5dFZBc3FmRUdSNWRYK3BtVDNTcEQ1Tlh0eiszOG5Fbk9jUU5XWW9EaXBj?=
 =?utf-8?B?bUN0OFFWTHI0ZkhqRXNqMHRTK3pJcTgyemEzR0tURUp3b2NCT0lkVHBmR2VC?=
 =?utf-8?B?WkZBWERGQnpzeFEvYjd4TFRGS2lhVWZQWnJkR0kxbkFtSmZGNzMzZllMYWVF?=
 =?utf-8?B?OUhFSDJOSHZvRzhqUkVBYk9FZ1BxSlBqdGRWc1lEQVhQQlJZQmNQSGVldDZs?=
 =?utf-8?B?UnVnVlN4L1RFekwvUm93dmY2eUx0WWcxZE9PdnRJcmhKVFB4VExlN09jNWFw?=
 =?utf-8?B?YzA4OVJUcFJIMWdPR0ZYdzF0VTU4TER1TjJhQ0VVNTJ1M0VsT1p1T3Z1Zkpt?=
 =?utf-8?B?K2hGOTZndko0QW52VW9LUGtlMWhIVndtVzNYa2xaQXdMT1gvRndjWDF5MHRW?=
 =?utf-8?B?VTJzb3cwMFhrNTBUdHBvb0V6Q0Vwc21VcU85enhpVndrVnlkdGd4bGpsSGZR?=
 =?utf-8?B?QXA0VXFENS9ybnFQSlpLWllpMHVMb1NqRkp1Ukc1VWE4N2FWbTg2eVh0TDVN?=
 =?utf-8?B?MnlESFQ5Qkh4VklNSkRoRC9ZVDcxODNTTXJoc0J3eDFBaEZvMUxKdXNNenN4?=
 =?utf-8?B?SnkwdVpPcHZEUU1rLzhFWVA1RlNYRTQvZDJnbmpFRWpMWEJPM1VTL1hKVzNW?=
 =?utf-8?B?Y1F2bXhMVlRVeDFFbWhNdXBzYnB1eGQ1OGtzN0RXVHB1cnRVdTR1Mm9vZU8v?=
 =?utf-8?B?clo5YjRkOGlGTHZiYUlZVEtIbmxmcUU1ZkprNXVqb0dzeUxIaStLRjdGVGNk?=
 =?utf-8?B?R3ZXeHFHOElDcFNsV1ZjVkpjc0x2aUxqcXNiQlhpVllwdUNuUGZ0NHYyZU9k?=
 =?utf-8?B?RXZ6U29JU1hRd0szUlRtL3p3RzREUjkrYktqUXBXeWg5U1ErSkZUenR2V3Ur?=
 =?utf-8?B?SUxKQ3RLSkRpcGpiZXJWT2E5MGNHd3JDb2FyUVdSQzRSRU03L1ZBS2dzOW5V?=
 =?utf-8?B?b2FtbEFZUER3cFhjTHVseFJWdkQ1SGpPa2FwaC9DdldWM0FXaXppRVozS2Zv?=
 =?utf-8?B?WUV6ZDl2aXpJWSt5ZFNaMVlSOTJBNmxFREQzUTZDaHJMUitvODRIY3ZwVTRX?=
 =?utf-8?B?S1AvbmN4OHczUnk4ZzJ2aUpiNjZyekhScEh3WW5ncUo3b3d2cXV5TFhkdEZ3?=
 =?utf-8?B?NTJDYUtUL1BnK1dMUTlqbmVBeUxLalpXQmVyKzN1NW5Ma2NBTXE3OTg1NXVa?=
 =?utf-8?B?dWJVT2g4NGtvcjNJU1dyNDBTVUQrN0tPV3MyMC9TUnpOaDVYczhaVlV0enN3?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L+wQ1s3DDmAHH+T+E3iYGMSIUMW+E955JXZWFqu4OfJUFQgNoYUgFNBz5IDgnfss66psAF07SifZyP9WsrVjCtaYGY4kuGco7B2bFmMZ2unnr51DTXCRGGfAiFB39KNS0D/jLsms0lLDUHaEhbItIvvX0EhgYnOGAvP1OvG4XXscGyjPJXBuEt6bsBIXVzwPh5475D5v247O5x/ZwtyhZxARY8XRlNNRzRvXRM6aTCgmHHDAoV7DfVBIdQsH/vIc7Qt5jydf70+xI5e1PBt9Kf+K/ODbq1q4E0vAVs36Z0K1/xIzgnRCfADiuLNqJC8ZXbJp3hPT4gbWX/SJ8vUZ6nn8x8OyYyhoKnCCnNCzSjX1AUWVvVB99HJCGR2AJp9D4l30BTN/eEBCM6LdXAn4o2ftTtKDJY67452jYEXMupn6Y/gcMmRPrVK5uAV4POpQL79A+sKqwScOo8g/Epy8bqRnUmpypea3tj9wFaU3GrraHN4H7RFvj+xU9GRtLQjQJkujcNZBVqhIVwFVlnyFiQW2WKhJToolg1KPIcUErNXfuA6L/lpDI8x/McGACmHcyVQfgOSLRMjEy1rwOQlzW6Db1dHP9tFI4yTLCp7gGuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b220d15f-2f5e-4a3d-2490-08dc954fc088
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:48:14.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyCEqOwgRhzKRsGDG3d6MHknNoGJmJg41LugCOujq9j62XE+YRHlERBj+3ws/qZV8gbgwI0Q9kkLA7W+4YLzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_15,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250145
X-Proofpoint-GUID: xwr-0sNLnZxIyHEWxOmp1h97_wxntBvw
X-Proofpoint-ORIG-GUID: xwr-0sNLnZxIyHEWxOmp1h97_wxntBvw

On 25/06/2024 6:31 pm, Olga Kornievskaia wrote:
> On Fri, Jun 21, 2024 at 1:39 PM Calum Mackay <calum.mackay@oracle.com> wrote:
>>
>> On 21/06/2024 4:33 pm, Olga Kornievskaia wrote:
>>> Hi Calum,
>>>
>>> My surprise was to find that having the DNS name in CN was not
>>> sufficient when a SAN (with IP) is present. Apparently it's the old
>>> way of automatically putting the DNS name in CN and these days it's
>>> preferred to have it in the SAN.
>>>
>>> If the infrastructure doesn't require pnfs (ie mounting by IP) then it
>>> doesn't matter where the DNS name is put in the certificate whether it
>>> is in CN or the SAN. However, I found out that for pnfs server like
>>> ONTAP, the certificate must contain SAN with ipAddress and dnsName
>>
>> Noted, thanks very much Olga, that's useful.
>>
>>> extensions regardless of having DNS in CN. I have not tried doing
>>> wildcards (in SAN for the DNS name) but I assumed gnuTLS would accept
>>> them. I should try it.
>>
>> Wildcard didn't seem to work for me in CN, but I may not have tried it
>> in SAN; I'll do that too.
> 
> I have tried to use a wildcard in the SAN and that didn't work for me.
> How about you? Specifically, I tried in the SAN
> "DS:netapp*.linux.fake" and tried to mount netapp119.linux.fake which
> failed with "certificate owner unexpected" (meaning certificate didnt
> find anything match to netapp119.linux.fake.

hi Olga, yes, exactly the same here. Wildcards don't work for me in 
either CN or SAN.

What I've been doing in my testing, when the host full DNS name is > 64 
chars, is to use the simple hostname as the CN (for ease of 
identification in e.g. "trust list") and the full DNS name in a SAN DNS: 
extension, and that is working well.

thanks,
calum.


