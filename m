Return-Path: <linux-nfs+bounces-3011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8C8B2A5F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959DC1F2470C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E6155385;
	Thu, 25 Apr 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IhK/ZXZD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NulqAz0K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CD153812;
	Thu, 25 Apr 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079146; cv=fail; b=NGp9ArS4lkk+PnXz4MwEkjnxWq4TdD0+0lObHvno0i+cTDw5+/8NIVu8Z3Js7l2WJyfmc+nlU7vSeKbNTuDuOg1JTbCAmQKwxGy3UKiHuaFWe3w+aOLIQuN7F57GnICOpDAgtHTYBfWjIEX33p3lPr8jviHfX67xubXZJwDuJR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079146; c=relaxed/simple;
	bh=hokwIXl4QVgw1IE8K6eOPRJ61fjwdd7xnoiB1s7pSoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mk9UzBCx7Z10vT7lKKhvEcy52vhW4qxQhvAjvuDgQS/aFBXxMqbdyGZxwAcv6f0/9Y9aYFvXLec8aJ7Y8q5RTWgG9C2/wJvDw8f7qeAr4vKz/s1YFOZ0/szLg71M+8VmBhr17AaeH3AAby0J3TXjHNJQ52p40E6dGE2Wu8H5E5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IhK/ZXZD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NulqAz0K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PKrecG013297;
	Thu, 25 Apr 2024 21:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hokwIXl4QVgw1IE8K6eOPRJ61fjwdd7xnoiB1s7pSoU=;
 b=IhK/ZXZDRRPuliRTF6sAVCGmG+hQMNQPHb6WCeEJQHuOu6C1fWQmLPZFyBQnrESHBVmA
 Ic3d7YJFt2gNslJUleRsm93PcPpkHXJiXdYQ2DkasrMsFTcrVuLA98KdDl5axP/enJ7M
 1uOYmmXGtlGxbFaKSNXzeFFSVBNHGtHDGzn1xzEuSKGnX5ffgPgKC2lQ/y76E19qZlyX
 v8MVX1VoXjtXv7pUw/3W3MQH2NNmVdG31apOx4ywgViwPtNrCS9Hmpzb+p+XCE4SlRgO
 xyCrSrf6w3K7OguW+u3tn1Q9tjBf2PWqXLpNTZyIwQ39Rgh0tA++ba/VjyS5+1H2U8+f 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbvpuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 21:05:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PJJGpl030813;
	Thu, 25 Apr 2024 21:05:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45ay32f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 21:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIi1uyjVPFWLhArRfol/oOsD/BjSkXO8PfA4lR0l+FHA1TXAIQiUz2IIlhnhlRSo4oZ1kSN6NdPwWk9nVztraJjk949Tn6TnnUxifIGyywGAolAZaXbRtVU/zcEhUlwhDZBpoK34O06lyr4pSHCHq/UQlGXhxik8QlL+qtFYMiuPKsZuxWgpHKcY2MPj44Dq8uAk+YmDC7pxYw3j4J7ZQ5Toz07UXQVC9/qQOa2FaeSOEtNVoS48YIVvgUKRHWhN370jNEIqJJzXma6dKXPUPs4uqxBI2zztfx0OgP3Dm8bp42gQRe4xj3mdLkaCHP6UT1Wnb3Fb+Oj8T449tVQgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hokwIXl4QVgw1IE8K6eOPRJ61fjwdd7xnoiB1s7pSoU=;
 b=cQYbqHvM3CFrvR90K9zM+akmGjSlZxj/MN/8/tjWZE8YfMhgPZ63zdjg2SW+7QaBbTf3VKbLVTsFAQalqfFxmJiCnPgEN2oNXjjxYPY4VXDZCGj0Jj7PPe29OlozgTE08GhrQ9ssaBD+YlRmjQFtUaEcFlHfmiDUimaLHRSPXDdAXp0aVyZ8u3wEADvEcGAJrjxHalimB7/oXeYGU5ahJvNti1RjHS5D51bbkgRlhQF+wtEGgeI6xqiOPW/XsHcb3OMPE52+7bE5+5Yo/x4eGRaQmGKPeRPEspBkFLhCfER4OPlXidtM6PRxf/sfCdN1akqfzybKROycjJPviV28OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hokwIXl4QVgw1IE8K6eOPRJ61fjwdd7xnoiB1s7pSoU=;
 b=NulqAz0K30ojEK3zvfSWMnsry6iWCW3EjDfzLeeoHpweskrId+QJql65bTxn3kCdDT4CAOic2xzd4GdG2nWWdZyWdNifNKY7fNAOx5DkuUBLFxBHeA9cdRk8fQSkfRDzwSG7C0YYBFhoeEwze2XYDGg4a5PWC/56Udr8xnkU3UM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 21:05:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 21:05:09 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: 
 AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkAgABlswCAAStOgIAACEqAgACgeICAAWPZgIAAA92A
Date: Thu, 25 Apr 2024 21:05:09 +0000
Message-ID: <6F1A5E20-1A0E-479C-AD5B-886D10739702@oracle.com>
References: <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
 <171400185158.7600.16163546434537681088@noble.neil.brown.name>
 <141fbaa0-f8fa-4bfe-8c2d-7749fcf78ab3@alliedtelesis.co.nz>
In-Reply-To: <141fbaa0-f8fa-4bfe-8c2d-7749fcf78ab3@alliedtelesis.co.nz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4799:EE_
x-ms-office365-filtering-correlation-id: 97c8e53a-c467-4a0d-61ed-08dc656b645a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MTI3OGZWRlcrSi9kVDJLenJrRWNXTklobVB2bFlsU1lWejdRMUF4WGpHemZC?=
 =?utf-8?B?Q0hDTmF6TGxwVFlRaHZMSGpHbjF3Q24rbjdlNmdQdW9FbzJTdzRiQmJ2SFgv?=
 =?utf-8?B?L3lTaFZXWVVONUkwb0NabElYSGhBR3RIa0wwYVJDSXE3WGxjNWRLNnBNdnQ1?=
 =?utf-8?B?UVo0ZGFyZUhzZDhhSWx3ZFNKYjU1TmxydzNacjZmc0IxVVFiekQ0S3FKb2xu?=
 =?utf-8?B?Y29UYVVkRnhPRHB0RHcrVXdiQ05sNDIxNjZaY25kbGZLY1pCTmF3STFXNklO?=
 =?utf-8?B?Z3Q5c2F2dnhHU0JiQ1dFUmE0RzBQYjJDTzhIaHZxMUd5TUNMOTJ1cFQ4RFc4?=
 =?utf-8?B?alZMNUdNU2N3VitXWlpld1hSSXZYZWpUWnpyb2V4TGNEaEF2aXE2UkFPVkxW?=
 =?utf-8?B?cmI2Ukl3K2d1K3AyYkVJRUZITlZDQzRUYVJmdGRYbUpFdERJem5icTF1dzNO?=
 =?utf-8?B?aU1qT2RLOXhQMzNDY0J4NklSMXpYTnhkMWdtS2pIY0svdkNlN0NGelJCQnB6?=
 =?utf-8?B?U256czQ4MUxmOHh2aDBZRm5jbkw2di9nS1NkdWFwRE1VemZtbmh0VEdEYU5u?=
 =?utf-8?B?Mis5UCtxOXA0TW5LWDNoVURwUlIyNGZHUmxBeUNSb04wNlVBL2pNeU5jRCsw?=
 =?utf-8?B?UnZiMEdvTEl3TXBPL080Nmk4ZllTSW85SzlIY2EyZkVucStncEtVRkRRUzF1?=
 =?utf-8?B?VGhVMkg5WEowNGtab2VTZkJuWnExV1MvUkhPbFZYaWtTUUt5OTdYeEdYb0VU?=
 =?utf-8?B?VGhIbzBxNGhQbVQzUzBpK0ZrMzE4Ymw3UEZkSEcvdUx0bTFValBFMDFCV3hL?=
 =?utf-8?B?eU5SSEZkL29vT3luYjJHa1h6dVhTczJicFAybG9rclc5b2RuWFZma29UMXJQ?=
 =?utf-8?B?SnJYVmgyY1M0QTFpaTdUYnBYOXRCNm9vWnhQMnlrdE54UExZU2ptbWRhSldG?=
 =?utf-8?B?NWQ3aEl6bjAxSkU1WHJoMDdYbmZUcUZJcjJ5NnppTzRkMUF2RmRZeWRkSy91?=
 =?utf-8?B?TkxJRHg1V3hwYXc5eVFmZldvNXZUQ2JwL0tMZHRHUjRFbmZKTFU5YURMeFNU?=
 =?utf-8?B?TGp0VFJBYk1yZUtCWUhJWDFBRHpnVTJob0V2NU9ITUpPQzYzNXI5U1lmU2d5?=
 =?utf-8?B?UGw1TkZPZ2RyTnNpenRoeUFrbUx5bjdVc3U5bytudWxLTUFvTXA3MSsrMzRz?=
 =?utf-8?B?QUM5aTRFdTFONGpZbmpDVEtDYklaVVhvM3VkdTlkQ205Yy9PREgrY1pVbnNu?=
 =?utf-8?B?bDRqS1N6T3g2Z3FucTlCbGJCUi90Zmo4SVpId09kN0dqUXJQRzJrZGFjamty?=
 =?utf-8?B?cGR3L2tuYkJTZFIxU1A3cDFYVWF3WU1tWU9LbXZLcGM0N1hGR0xISzdqMEdS?=
 =?utf-8?B?K0tBaFkvVFpWL2VHMHFYNmI0SjcxTGRrVlZ5bTVKaTJLVjBQQ2NFbnNzd2l2?=
 =?utf-8?B?WURQUnZTVlI1Q3Z4NlZkdmRweXgvaU1aRHUvZitsS21yOUdyWDFkSnFLY2cy?=
 =?utf-8?B?ejR6dXpTWHVpR3JuZ3REVW9oUEVORjU0Qi92OHhMWnBrVmJZSGQ2c2xuTWVu?=
 =?utf-8?B?N3JOK3F4d1dhUTY5c0dwZ3RxUkhpQXpiOFk5QmpVODhmL1FnWmhLMHdMSk8x?=
 =?utf-8?B?TCthdHhxa3dEVWVwQ3NlazBNQ2lLM0tIY0duTDhFampSOWd2elZFZE1NV3Jx?=
 =?utf-8?B?b0EyWDA3QTVBcnlsZFZrUVBrSWdRK1orQTJzazltWS9qUmRib3VXTjMvZzV2?=
 =?utf-8?B?dEREYm1KSUhRSmZjOVFWTVZ3VWQyVTk0ZDZLRHRLRndVZzhuV0tsNU0xaEkw?=
 =?utf-8?B?MTIwUHVIMHAwVndtWjdvZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dmNSbGVlOU50RFlWOFVieGtNTG9UaVovTEt3bUtTeitMejRtWGRKc2J2Sndp?=
 =?utf-8?B?YmxLVXFpQy9tUUZCREp6dmR4MXNwdE1NZG9jdkFCYmFkV2VGRHdoNFBvWWVX?=
 =?utf-8?B?eUhlYWhvaTFick8zcjFTdk9waEZFUDFIdFRjWHRrYk9BZHVGSU9sUjBodDgv?=
 =?utf-8?B?cmx2a3ZUVGJJZk8rZVJnWUVzMDE5OHFmRGYvekFLZFJBWVEyQmxPcnhhNmV1?=
 =?utf-8?B?ejVlVHhYK0dKSThBbGtxTW5wRkFhVHNBTGRtNFhsajZrOStNbDNDZ04wN0Vq?=
 =?utf-8?B?OTRIMEZRTERjcTR3YXpnMGYybXE2emlkQVFtU2dCWEdCV1pVUTNHU09NTFVl?=
 =?utf-8?B?bkl3MHViaEJZKzRRUVk4NHBla2hLZzZHZlpobjJqeVovNThidTk1NzVlT2hs?=
 =?utf-8?B?NDlWYk1JeHJSbncwMDhpOG5Sell4V1JDcEpkc1BaU1AzMXZUU1JyNFVNMXRU?=
 =?utf-8?B?Zm9sQzJGVkI0L2MxTGFla3NmS09qNzg2b2V2NGNuVE0zTmpkRTN5dVVRUFFv?=
 =?utf-8?B?d3psWkVVZUtCR01GMEJVeVEzeU5UQ3cyb3Z5b3RWSlJWMllkM3pmTWcrMHhN?=
 =?utf-8?B?S2gvSkV5Nm84cjdYNCt4WFlDVGJuMENxRnRvcnVxT1N4MTFYczhBL3plK0NN?=
 =?utf-8?B?UUZWcmZzQW5IOC9KSUlsdm0vNlh0RGVzZDNFNU1mUUIrUUpqRlJJRk9PWllk?=
 =?utf-8?B?bUtHa3N6WnMzNDJiOGo0a1RhSGZUbVFHWHFpRzl0SWxaQXR4ek0reCtLTTUr?=
 =?utf-8?B?M3pyQWFwWldTTFpDdjBCcXd3dnFzMWpKVWlBeHM3MDMwQUx5L3FZTXF1ak1i?=
 =?utf-8?B?SGZLbFZTM0VLY0RWelFTN1dHMi9acWxsaExZbEdib0Ztb0hHVHp4YXZvY21i?=
 =?utf-8?B?a2lHR2RDZVNWUXRFeUMwVkRyK2YzaVpZS1dyMmEydVdBcE8wTmNodnhmL3gx?=
 =?utf-8?B?ZFVkZGZiQWdrRXR4dVk5SEFLWnZGUU93cVgzTmc3Y2VsOWlvcnphenZscGNR?=
 =?utf-8?B?RmdheW5RRkxIZkc2Y211cHpkOGUydExLeHZ6T3lsS0E0d29rRDJEdkNJRXBK?=
 =?utf-8?B?dUhaVE9lNHlMOU80L3lXODJCdk5MdHV0WmZWVk9jN1R6OGswNElQV1FLRm1Q?=
 =?utf-8?B?aHZZdXZQNFRPVzBYeTRjMk1jQjJyUnhVVnRIZkp2cUN6SFc0K2JzeDg3MCsv?=
 =?utf-8?B?OGFvQWYvdEF4cXlRbXJoRmhlZVBVa2JjSDdCaDJzVy9kc3ZEalc4dlZpZ1gx?=
 =?utf-8?B?bDFPTTFSRy9OeVF6TXdEZWw4Tm4rTk1uTjlOQnhCbzg0YXBnakV2UXpTUHBu?=
 =?utf-8?B?QyttaVNMcytQZTFxWEFobVJWbGhtdS8zVlZHWnZCb0NSU015ZEQ4TTNyS1Nj?=
 =?utf-8?B?RU9teDFkK3MxSHdPOXIzL1orTmVRUVdvUUhLUWxENUxpTDQ1am1QVnlmK2dp?=
 =?utf-8?B?QTNDQVRCSjhXTXh6TlkvTzJ2Z28vbXJYUWl2ZlN4ZWxGYVRnTWtaZDFNVERI?=
 =?utf-8?B?bzRVTGNaVEQya0ZMdTNtL3RVaGwyYmd0cmd3ODEvWktuMlQyWjM3clErNmt6?=
 =?utf-8?B?MkNTc2xiQ0NwTDlUVGN5a25jM0luS2JFUXF6d2FTalE2Y1JOM0RWSS9pa2JQ?=
 =?utf-8?B?UWI0cnZDK1NOTStwd0V4TmxLanJWZEkxbUJZbTgvR1hrOFo0VytnWm1WOHBL?=
 =?utf-8?B?Qnp4cEFnUHVQdXR2ZjVuY2RPQTNGRyswMjdmS0tmTG5vemNhbUdZQjNLT05x?=
 =?utf-8?B?c09QdndXa0RSRTMxRW1TeWxaVmdOVEFJWFZHcDRKa1pyZWJZbVJtVjZxWEFn?=
 =?utf-8?B?a1VCZjNnMmU2SkZ1VUw1dDlUNS9WMHRsMGoyejB4OGNNVEh1Yk91SlZsVjNr?=
 =?utf-8?B?QjNtRkE0a1VYaHROVHM4QitMaEx6NmtvM3oyam9URnFiNHBhODcyMTNxWWpy?=
 =?utf-8?B?SUdYdU1XNzJLaVJJRGhjUkpWUERWc3ZwYUJ0UEs0Zi9MVVlLRkJpQXR2NmNX?=
 =?utf-8?B?K3VzUDZ2dk1PUFo4Vy9kTFVBQjNwL3Znbzh0TTBQM1VTc3ZJT0lXR3JlQzE5?=
 =?utf-8?B?M2U1RW5OcStSdlJDOER2SmFadldaMUxwemlEWVFsTkxxd3NGWHhydGtLejQx?=
 =?utf-8?B?ZFFHc3E2M29IWHFkMnlPajdaUzdEWkp2RGZuc3QvbGhMWHdNbzlCRzByQTJR?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01689C9B11226749A1DE261DE095F5A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lsLYCGJhY2EGrlBnbSBajlFINLfST/2i6NHoIJeFo3XPOlysvnXUBAgXxK8UYFhbTOdXNHUJUX2zrtgl8eYjCiOw1gmwgRnQa/JRZehBzwzlD0B1HVIprlAhXlE/cPshuWp4GW20in6wjccLwjhv5ILf8+/qX/WwjHGV6h2+ruiQSC8EZEQBt5ECHPksYPjq6Sy9KC62DSEIdwV2gYGSKiqSfWz/+1OQj2sC718XyAsP6rCGa87Y64Ttxax2d4KQD/a8qork8Uiaf7KZt1IrIY6IFn0F9Nu40Oez1YcdpJineM1Fzb1bzKB35PrKDLruhsaNz3voStYfdZYKabHV0QMk7IT4RUjoxjXmix/nOyRUxiv04qVhKmNNlNdsCtulUT6FKxnj46X7CDMaZgOtNAuWG/JW+eGQy5Ex1v2ZEjwRbq56FvHfUWD1Z8TUg14i/s9f7ZlLj+9WA7CBsEP65gODMU1/IJ+SMCy/8HzuqBWDaTPVeo51LD5jIeEHMKma8jeglbXRHTrKvyvWIUSDbqy4gmcg4o7KhJouRRYfFkEFSx4YQaJL26Mc3bWUF6/fgxOJRA+1HA3E8B89l4qLfMpaoJmq5S6+IISeo5zss5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c8e53a-c467-4a0d-61ed-08dc656b645a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 21:05:09.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIxw8Gt8tKMarObrIFseNrgqdx4kA+HmNZhza7E8mAZCLYhhhCfInaKFJCfznNZdnEXSlyxM4+tT70SMnAgRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250153
X-Proofpoint-GUID: H9UZXbJpAFrL2B4m_KgdyPhjmUBbV_8z
X-Proofpoint-ORIG-GUID: H9UZXbJpAFrL2B4m_KgdyPhjmUBbV_8z

DQoNCj4gT24gQXByIDI1LCAyMDI0LCBhdCA0OjUx4oCvUE0sIENocmlzIFBhY2toYW0gPENocmlz
LlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+IA0KPiANCj4gT24gMjUvMDQv
MjQgMTE6MzcsIE5laWxCcm93biB3cm90ZToNCj4+IE9uIFRodSwgMjUgQXByIDIwMjQsIENodWNr
IExldmVyIElJSSB3cm90ZToNCj4+Pj4gT24gQXByIDI0LCAyMDI0LCBhdCA5OjMz4oCvQU0sIENo
dWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+
Pj4gT24gQXByIDI0LCAyMDI0LCBhdCAzOjQy4oCvQU0sIENocmlzIFBhY2toYW0gPENocmlzLlBh
Y2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIDI0LzA0
LzI0IDEzOjM4LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+Pj4+IE9uIDI0LzA0LzI0IDEyOjU0
LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+Pj4+PiBIaSBKZWZmLCBDaHVjaywgR3JlZywNCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IEFmdGVyIHVwZGF0aW5nIG9uZSBvZiBvdXIgYnVpbGRzIGFsb25nIHRo
ZSA1LjE1LnkgTFRTIGJyYW5jaCBvdXINCj4+Pj4+Pj4gdGVzdGluZyBjYXVnaHQgYSBuZXcga2Vy
bmVsIGJ1Zy4gT3V0cHV0IGJlbG93Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSSBoYXZlbid0IGR1ZyBp
bnRvIGl0IHlldCBidXQgd29uZGVyZWQgaWYgaXQgcmFuZyBhbnkgYmVsbHMuDQo+Pj4+Pj4gQSBi
aXQgbW9yZSBpbmZvLiBUaGlzIGlzIGhhcHBlbmluZyBhdCAicmVib290IiBmb3IgdXMuIE91ciBl
bWJlZGRlZA0KPj4+Pj4+IGRldmljZXMgdXNlIGEgYml0IG9mIGEgaGFja2VkIHVwIHJlYm9vdCBw
cm9jZXNzIHNvIHRoYXQgdGhleSBjb21lIGJhY2sNCj4+Pj4+PiBmYXN0ZXIgaW4gdGhlIGNhc2Ug
b2YgYSBmYWlsdXJlLg0KPj4+Pj4+IA0KPj4+Pj4+IEl0IGRvZXNuJ3QgaGFwcGVuIHdpdGggYSBw
cm9wZXIgYHN5c3RlbWN0bCByZWJvb3RgIG9yIHdpdGggYSBTWVNSUStCDQo+Pj4+Pj4gDQo+Pj4+
Pj4gSSBjYW4gdHJpZ2dlciBpdCB3aXRoIGBraWxsYWxsIC05IG5mc2RgIHdoaWNoIEknbSBub3Qg
c3VyZSBpcyBhDQo+Pj4+Pj4gY29tcGxldGVseSBsZWdpdCB0aGluZyB0byBkbyB0byBrZXJuZWwg
dGhyZWFkcyBidXQgaXQncyBwcm9iYWJseSBjbG9zZQ0KPj4+Pj4+IHRvIHdoYXQgb3VyIGN1c3Rv
bWl6ZWQgcmVib290IGRvZXMuDQo+Pj4+PiBJJ3ZlIGJpc2VjdGVkIGJldHdlZW4gdjUuMTUuMTUz
IGFuZCB2NS4xNS4xNTUgYW5kIGlkZW50aWZpZWQgY29tbWl0DQo+Pj4+PiBkZWM2YjhiY2FjNzMg
KCJuZnNkOiBTaW1wbGlmeSBjb2RlIGFyb3VuZCBzdmNfZXhpdF90aHJlYWQoKSBjYWxsIGluDQo+
Pj4+PiBuZnNkKCkiKSBhcyB0aGUgZmlyc3QgYmFkIGNvbW1pdC4gQmFzZWQgb24gdGhlIGNvbnRl
eHQgdGhhdCBzZWVtcyB0bw0KPj4+Pj4gbGluZSB1cCB3aXRoIG15IHJlcHJvZHVjdGlvbi4gSSdt
IHdvbmRlcmluZyBpZiBwZXJoYXBzIHNvbWV0aGluZyBnb3QNCj4+Pj4+IG1pc3NlZCBvdXQgb2Yg
dGhlIHN0YWJsZSB0cmFjaz8gVW5mb3J0dW5hdGVseSBJJ20gbm90IGFibGUgdG8gcnVuIGEgbW9y
ZQ0KPj4+Pj4gcmVjZW50IGtlcm5lbCB3aXRoIGFsbCBvZiB0aGUgbmZzIHJlbGF0ZWQgc2V0dXAg
dGhhdCBpcyBiZWluZyB1c2VkIG9uDQo+Pj4+PiB0aGUgc3lzdGVtIGluIHF1ZXN0aW9uLg0KPj4+
PiBUaGFua3MgZm9yIGJpc2VjdGluZywgdGhhdCB3b3VsZCBoYXZlIGJlZW4gbXkgZmlyc3Qgc3Vn
Z2VzdGlvbi4NCj4+Pj4gDQo+Pj4+IFRoZSBiYWNrcG9ydCBpbmNsdWRlZCBhbGwgb2YgdGhlIE5G
U0QgcGF0Y2hlcyB1cCB0byB2Ni4yLCBidXQNCj4+Pj4gdGhlcmUgbWlnaHQgYmUgYSBtaXNzaW5n
IHNlcnZlci1zaWRlIFN1blJQQyBwYXRjaC4NCj4+PiBTbyBkZWM2YjhiY2FjNzMgKCJuZnNkOiBT
aW1wbGlmeSBjb2RlIGFyb3VuZCBzdmNfZXhpdF90aHJlYWQoKQ0KPj4+IGNhbGwgaW4gIG5mc2Qo
KSIpIGlzIGZyb20gdjYuNiwgc28gaXQgd2FzIGFwcGxpZWQgdG8gdjUuMTUueQ0KPj4+IG9ubHkg
dG8gZ2V0IGEgc3Vic2VxdWVudCBORlNEIGZpeCB0byBhcHBseS4NCj4+PiANCj4+PiBUaGUgaW1t
ZWRpYXRlbHkgcHJldmlvdXMgdXBzdHJlYW0gY29tbWl0IGlzIG1pc3Npbmc6DQo+Pj4gDQo+Pj4g
ICAzOTAzOTAyNDAxNDUgKCJuZnNkOiBkb24ndCBhbGxvdyBuZnNkIHRocmVhZHMgdG8gYmUgc2ln
bmFsbGVkLiIpDQo+Pj4gDQo+Pj4gRm9yIHRlc3RpbmcsIEkndmUgYXBwbGllZCB0aGlzIHRvIG15
IG5mc2QtNS4xNS55IGJyYW5jaCBoZXJlOg0KPj4+IA0KPj4+ICAgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2VsL2xpbnV4LmdpdA0KPj4+IA0KPj4+IEhv
d2V2ZXIgZXZlbiBpZiB0aGF0IGZpeGVzIHRoZSByZXBvcnRlZCBjcmFzaCwgdGhpcyBzdWdnZXN0
cw0KPj4+IHRoYXQgYWZ0ZXIgdjYuNiwgbmZzZCB0aHJlYWRzIGFyZSBub3QgZ29pbmcgdG8gcmVz
cG9uZCB0bw0KPj4+ICJraWxsYWxsIC05IG5mc2QiLg0KPj4gSSB0aGluayB0aGlzIGxpa2VseSBp
cyB0aGUgcHJvYmxlbS4gIFRoZSBuZnNkIHRocmVhZHMgbXVzdCBiZSBiZWluZw0KPj4ga2lsbGVk
IGJ5IGEgc2lnbmFsLg0KPj4gT25lIG9ubHkgb3RoZXIgY2F1c2UgZm9yIGFuIG5mc2QgdGhyZWFk
IHRvIGV4aXQgaXMgaWYNCj4+IHN2Y19zZXRfbnVtX3RocmVhZHMoKSBpcyBjYWxsZWQsIGFuZCBh
bGwgcGxhY2VzIHRoYXQgY2FsbCB0aGF0IGhvbGQgYQ0KPj4gcmVmIG9uIHRoZSBzZXJ2IHN0cnVj
dHVyZSBzbyB0aGUgZmluYWwgcHV0IHdvbid0IGhhcHBlbiB3aGVuIHRoZSB0aHJlYWQNCj4+IGV4
aXRzLg0KPj4gDQo+PiBCZWZvcmUgdGhlIHBhdGNoIHRoYXQgYmlzZWN0IGZvdW5kLCB0aGUgbmZz
ZCB0aHJlYWQgd291bGQgZXhpdCB3aXRoDQo+PiANCj4+ICBzdmNfZ2V0KCk7DQo+PiAgc3ZjX2V4
aXRfdGhyZWFkKCk7DQo+PiAgbmZzZF9wdXQoKTsNCj4+IA0KPj4gVGhpcyBhbHNvIGhvbGRzIGEg
cmVmIGFjcm9zcyB0aGUgc3ZjX2V4aXRfdGhyZWFkKCksIGFuZCBlbnN1cmVzIHRoZQ0KPj4gZmlu
YWwgJ3B1dCcgaGFwcGVucyBmcm9tIG5mc0RfcHV0KCksIG5vdCBzdmNfcHV0KCkgKGluDQo+PiBz
dmNfZXhpdF90aHJlYWQoKSkuDQo+PiANCj4+IENocmlzOiB3aGF0IHdhcyB0aGUgY29udGV4dCB3
aGVuIHRoZSBjcmFzaCBoYXBwZW5lZD8gIENvdWxkIHRoZSBuZnNkDQo+PiB0aHJlYWRzIGhhdmUg
YmVlbiBzaWduYWxsZWQ/ICBUaGF0IGhhc24ndCBiZWVuIHRoZSBzdGFuZGFyZCB3YXkgdG8gc3Rv
cA0KPj4gbmZzZCB0aHJlYWRzIGZvciBhIGxvbmcgdGltZSwgc28gSSdtIGEgbGl0dGxlIHN1cnBy
aXNlZCB0aGF0IGl0IGlzDQo+PiBoYXBwZW5pbmcuDQo+IA0KPiBXZSB1c2UgYSBoYWNrZWQgdXAg
dmVyc2lvbiBvZiBzaHV0ZG93biBmcm9tIHV0aWwtbGludXggYW5kIHdoaWNoIGRvZXMgYSANCj4g
YGtpbGwgKC0xLCBTSUdURVJNKTtgIHRoZW4gYGtpbGwgKC0xLCBTSUdLSUxMKTtgIChJIGRvbid0
IHRoaW5rIHRoYXQgDQo+IHBhcnRpY3VsYXIgYmVoYXZpb3VyIGlzIHRoZSBoYWNrZXJ5KS4gSSdt
IG5vdCBzdXJlIGlmIC0xIHdpbGwgcGljayB1cCANCj4ga2VybmVsIHRocmVhZHMgYnV0IGJhc2Vk
IG9uIHRoZSBzeW1wdG9tcyBpdCBhcHBlYXJzIHRvIGJlIGRvaW5nIHNvIChvciANCj4gbWF5YmUg
c29tZXRoaW5nIGVsc2UgaXMgaW4gaXQncyBTSUdURVJNIGhhbmRsZXIpLiBJIGRvbid0IHRoaW5r
IHdlIHdlcmUgDQo+IGV2ZXIgcmVhbGx5IGludGVuZGluZyB0byBzZW5kIHRoZSBzaWduYWxzIHRv
IG5mc2Qgc28gd2hldGhlciBpdCBhY3R1YWxseSANCj4gdGVybWluYXRlcyBvciBub3QgSSBkb24n
dCB0aGluayBpcyBhbiBpc3N1ZSBmb3IgdXMuIEkgY2FuIGNvbmZpcm0gdGhhdCANCj4gYXBwbHlp
bmcgMzkwMzkwMjQwMTQ1IHJlc29sdmVzIHRoZSBzeW1wdG9tIHdlIHdlcmUgc2VlaW5nLg0KDQpJ
J20gMi8zIG9mIHRoZSB3YXkgdGhyb3VnaCB0ZXN0aW5nIDUuMTUuMTU2IHdpdGggMzkwMzkwMjQw
MTQ1DQphcHBsaWVkLCBzbyBpdCB3b3VsZCBiZSBqdXN0IGFub3RoZXIgZGF5IGJlZm9yZSBJIGNh
biBzZW5kIGENCnBhdGNoIHRvIHN0YWJsZUAuDQoNCk1heSBJIGFkZCBUZXN0ZWQtYnk6IENocmlz
IFBhY2toYW0gPENocmlzLlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gPw0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=

