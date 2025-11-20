Return-Path: <linux-nfs+bounces-16640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4949BC76710
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 22:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 962042B856
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0F30C377;
	Thu, 20 Nov 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BjQaJX8/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aO4Aqx15"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4F303A16
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763675915; cv=fail; b=YnWv+slMw5d1RORHL+fsN5/xE9vC6B4VMpI8dwlbqRjDIQjOFNs4iMJXrs/P/kfLll3E1oTm5WfrDDYMWo84/0VsgIQUIhKFVWGyU12XHV/laAfEon6f9rMErooc+NVza+HloI4Q4Z7aYlG1vfjqgRnOCIjO1g48aS9DPLwDDBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763675915; c=relaxed/simple;
	bh=ApkixfnMM4R3zzTgzHhd2oGNaboY5q4HB0E7vR6WbVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oU9N1Ck2tjiJQ9WQUMV7RknDwLJcOdUzDG/WzhqWcXWE5ubODOeMGiiMeVMShN2a23tELRK3Bn+MPAC+MQRg6PWlEm1OdJIR8q4hLw0tU532TEEgw8wPi1UuJ4zqPztDv58sz5+ibEp87XMKF/NmvN1mqAgbfl7xK5155q73MN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BjQaJX8/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aO4Aqx15; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJgOM5009110;
	Thu, 20 Nov 2025 21:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ds7cuu3DG6/uxkvTOpNX7bRriAUJIVHEh1J93abUBb8=; b=
	BjQaJX8/qB7qwJl7TFgVsoRG9YP85UVXbtcJ+wckbD6FWQuCWRQMCTeQdiMUCJtU
	pcwLxkHZF0PL3MgayZi4RM4dr2r5atvow3xcJXDcS4TS2tVtfPKVbb3RgMuc/45y
	8v4iEEVwqboEWnCaYL2hLUPSO9R5bKtn15DLoHPgpw+fLlGi2U1LkIxsnWtAg/hl
	RpcRT2INe98K2aEJwImJzSqAlwHD9OO6fZ2Ns6p95lEVnGRtamDKOMtIw60t5sRl
	qytSf0JTnHhlOxAp8XSsBiWulmYIIqg3WTD+cN9SE/T0g4FqC6On496W3lw6TNl/
	EF7xAh9k+eKZTUt5LSlzag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1j20e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 21:58:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKLqYRx035868;
	Thu, 20 Nov 2025 21:58:25 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyq2g17-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 21:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUq5ZWoWbCkoQI7eAjlMWz6Jjx06M17sCwO6zE2FgCOQItXs4FWhA0y7+IuBFWdI8alxN5js6SWgNdq5MNXTyGOq7Fti1O0FcZKQkKb4lucsRJX87GQ6NVEVPnv51gV1ewIDWesd4MkZWjJUWa/mYRvbkWWzANj0jkVzhMZFx8RQyJei0DMSB5AnpmiZMiwnLGfdcf5HH30XjUS9Ka0aIt71f6Sm1qwySYBYq1ElmaRL8+m9lpFxp6P1O777kbZTUUpGPffa8WCQzg4sjFEOwkMrZCMkZrO4+/1TbFgZWPg3HRvt6iLItmctjiGkiETXlplRjK0wPiEROtues0EQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds7cuu3DG6/uxkvTOpNX7bRriAUJIVHEh1J93abUBb8=;
 b=St5NRgrvmIOVJrAeyvvMNc56W0Aq+sImKbOhDEQ49/oORAbMJe9fHop7lVoPNl5rWC6LvO1c+UJ1QqxSQut/daHXq+87R9FFhG4ZnaMswjSUVZrAW3dOzOq4S6Fwm7cU/kSSTnM8luR7pdBDhNpbvnaZILQT2im5H2ijrw+bKV4grL9cpbWbn8yPxuiReiwHZazTWim3Kl0sauog4pFj2EXpgXEJ5NPo3caaXKzl0+bwVsWia76Qu7WYegsgNp0usr3p6zM78G68yRlNgL1mvy/euj5bqbRRaWf8HYkCfjMkPI28sZ7xRkECDaTSkcBEBwWu23tt9x30qNxgJvDrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds7cuu3DG6/uxkvTOpNX7bRriAUJIVHEh1J93abUBb8=;
 b=aO4Aqx15lLuUfbcyYVYige5eflZEVpXgI7D74OUHQHPptCZtrnk7hz94+Ndrjl1vaUqYni8z0VC3JYOHKN2LbPvnmyJ/utnWCAIMSdgy5s/2XAevwTspHKs7nzMuvQM5uQC97gF7SSew7Kuh2ICQ4PTQLTZFyUQ6avEFB7sebNE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:58:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 21:58:13 +0000
Message-ID: <6c346369-b39f-4b7e-b8c4-eff687304ccf@oracle.com>
Date: Thu, 20 Nov 2025 16:58:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] nfsd: simplify foreign-filehandle handling to
 better match RFC-7862
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-4-neilb@ownmail.net>
 <3097252a-8071-49ef-ad2d-1e9733540913@oracle.com>
 <176358832223.634289.3617743312148292910@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176358832223.634289.3617743312148292910@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:610:60::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 664b0a6f-5a1a-4a76-761f-08de287fe6d8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WVp2UHNKSGdVZDEzbExRcFN3K2tabkptV25jaWpKMlRRdG95ZzlsVnU5ZnNu?=
 =?utf-8?B?UlVHNGpHUWloUktOWmNwU2RoNElZczBaYk9vMDRIOGR6VTNRVkJ0S2E0NEd1?=
 =?utf-8?B?eVB0dWlLRXFRSWpVTjN0V3RaQVpKMGlOeVdlZWNZZVY0WXA3TWJaNm5HN3h2?=
 =?utf-8?B?TXFaUHAxNVN0SDgzMWF3ejRDMnROU212ZytucHlmdGtZTzVQWG4ydWl2cEdN?=
 =?utf-8?B?d05NdXU4MzYzUk40eTFvN04vZ0d4ODhHSUdhZ3pDdFlVT00xaERTdGw1N0tY?=
 =?utf-8?B?c2hKU05haCtQYk01WHBDNlVYWlQzNHlNU0hzUHFmL1dVZnJpY2lnUGpCVFBB?=
 =?utf-8?B?THFsK1VhZWI5bWl2UVpCYy92ellCVEpabG02bkV0eXFWQU1kNEwxVXpzS21O?=
 =?utf-8?B?b21FZC80UTFKZ0RLcHF6cFVKd0JWTWc2N2x2bUNFTXkwUkI3MEUxdUJZS0J1?=
 =?utf-8?B?VHZpa2ZFU2NmZkkzMmFOLzB5S0FwSVdrOEJ3ejVOdHg1UTVVNUgwaGdWcDMv?=
 =?utf-8?B?QnBaWnR1alN5TUZjcW8zalJFdVd2c0sxY2JBYllldWN6b080d3UrQSs5c3Vl?=
 =?utf-8?B?ZWJIdDZnb3JkL2dvU1kvUCtneVlBdHJ0TUJ5c2JmVTdOVjR3Nys1eCtQakh6?=
 =?utf-8?B?aG1neHJBUk9oSlVhclAwUTROVXY0NDdkZzdIMmswcUVPUklRbzdTRHAwNVgv?=
 =?utf-8?B?ZUE3N2tVM0c1Y3MraG9JZXB1RzNQTEVHQWpMemJudElGa3d1dllMb29hZzV5?=
 =?utf-8?B?Zm42eERUV3ByVk5VUVBrZUdtMEpPZVAxbWZJYkUwK3RDWlJRYk9qTU1iRXJY?=
 =?utf-8?B?TjNBdEVNdWtNMEQ1N2hDNGMweEFxaTFXby9aV1hvTkF6akh6bnl2Rk1nYStj?=
 =?utf-8?B?ampOU1BiaEp6L3J6T3B0RUFLdWFNSzB3Uit5bGFwTUdNVnNYTTlIWDdQMEwz?=
 =?utf-8?B?ekN0SWxaU2RLaDNKZHkrZHVUVW9ZUXFxd21selVIZzJPR3F1RSsyOTRKWjdh?=
 =?utf-8?B?QWQzVytOUEZRcVFkbUxZWmhybWpDWmRpRFVabzcvUVF3WUlISysyU2pMRnZh?=
 =?utf-8?B?KzY3NmZxc28xaXdSOHdSWmo1LzJSdloyQ3VPUEhqVzE1RVlzU05qcENKTkFO?=
 =?utf-8?B?U1Y1cURpbHl0MzdWajVCSktCK05HTDdzS0tsc2JkN0JHYjZlUGdUZHl0cDF5?=
 =?utf-8?B?UWkyZjQ3MWJ5VWVtUC9LZ0lKOVhxQmozekZvWVJuT0JiWlc2UkY5ZEZ3SStE?=
 =?utf-8?B?MzMydWJQZlcxcHY3bHZGYzRKUFBPT3JrWmpiblhXREdPR1lpNWpjWXFtcVp3?=
 =?utf-8?B?U0s4dEZFakxqdUFQSk9rMDNvNndVYnR1OVAwUzZYZlFsakVQVVBGS0pCZEwx?=
 =?utf-8?B?Q0V0RlpsRXJsbFFkZmNocjZtVHN2Y0MzbmFJMGQ2S1dSdVUvUUpoRkdYcHB0?=
 =?utf-8?B?c2dSeWhTOXZ6ZDJsZDZ6YXVjUklaaSs5Y0Jtbk9Ra0tnUnBOejByM3g2WStG?=
 =?utf-8?B?dTRNTTl4WGN4bDM3NjFxSWp2WWduWkpudEJ0bk1wSm15VkFaSXBTR2M5bmpy?=
 =?utf-8?B?bTB5b0VOQU5RdVRNSXY5Ym82RWNVbHFUYWZudjBEUHZ3Z3A2eU56a0tNUDFv?=
 =?utf-8?B?QkdGanBGM2dxUWNYVFcyOGZlOXMzaGF0aWk1OTNrK0hta21uVFhSWTRESnh2?=
 =?utf-8?B?SkNLWW5TWnB4SzhDRUw1UkdTdE8wajJnRFEralFyRjFsY21GQXdXRllFbmRQ?=
 =?utf-8?B?S1h2N09keHBiYVJVWGJlUGErRnVtTzZ2eXdLRSs0dHRHUC9CTUJwcTRlQmd1?=
 =?utf-8?B?SDRFYTU1ZXhhczlHWktvd3BuYno0OU41Tm84VHgrUXQ5a0srMUcrZXJoNHgw?=
 =?utf-8?B?K0lZOHNkd0N3VHhKOXhTbEpmK2UxUXJhN3RKMHJUd0h5NUl1cWlyZ3hlQjE2?=
 =?utf-8?Q?2DNkpKMD3mbaJXQarhmzVGxCdD7jVTMb?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aytOaEFuNzFKblNSWWhzYmFwZE9SZytyUkZrZzBuUWFhQzdqNUVobUY1a2xF?=
 =?utf-8?B?SVZINW9RTHNub25KWlAybUdueDhpVVhsOVA2c2t1WUxNVHAwTUNwUWlwNlVi?=
 =?utf-8?B?b3pTNXk1alVxOUVNaTlFN1FreVQ4SVZaMFZIWXNkZVFyY3Y1Vkp1aFp0UHFp?=
 =?utf-8?B?cUpBcHlzRGZjbW9ibkVQTDRYdW0yV1hwYWtSbmwxN2ZaQ0VWbEFwOStVWjBK?=
 =?utf-8?B?dVRPV0pIQktNbVJlVHQ4U0M0Y1BhNTJVbFVINkRSZHhUV2xmRW1QQ0grbkRk?=
 =?utf-8?B?WWJhL2lvVjRpRmZNQ2N2U29RUThGS0lvNjR4ZE45c25Lb0h5OWNjRDArVTJD?=
 =?utf-8?B?SXU4MnJqV3NkSm5nbjR0c1E4eUtDSUlCUTNvQ3hJQUYwRTlJMEtLcXl0d2E5?=
 =?utf-8?B?Mit3aE81b1RUalFwVnh6T3lRaGRvbEFxbThGdTJleU82dEU3R3NFdlNXaUFt?=
 =?utf-8?B?SXBuay8ydUZxN1BJR09zQU5USlFpY0FkOCtoYW9TakYxLzRoODk1MUFtWnYz?=
 =?utf-8?B?d0pwMEt5YWFSRmp6SVA5bVhvVDQrd0cvZDhnMTc4dlN0YjBRd0dlSm9YTmMw?=
 =?utf-8?B?c1k2dHkzUHM1OVl2MmUzeHlYZnRaQStJRXQ5QjZhcytwNExLbE5tWHRsdVc4?=
 =?utf-8?B?bmQyaHJkQXJpVy8zeStwZ2l1KzRxNEtacS96ekRqdzd1NmIzSzF5R3dyS1NY?=
 =?utf-8?B?RGFxOXcvdzJEVjhuRG1iRUxmdGEyTzNBMDVreUdXNy9RTzhvbFd4TWlpdzBY?=
 =?utf-8?B?RDNudmRTcUpOTWc4enhsSGdtSHZyaVRJUE1kVjRSdEhYeGxkU3lTNUdLZ2hk?=
 =?utf-8?B?VFJXd0pLaW1RV1hjZGtwOW1jL0VDNU9QU21GbFA5VzZRYjh2ZWZqVGl2cWZa?=
 =?utf-8?B?aUdXdWpsY1VXTmNNbWl1Z3JtVHo0Zlp1Nll4NmozanlocFh2ZVpMNWdlNld4?=
 =?utf-8?B?c0wrMnRyYjRsL09XWEJDNHh1VU1nYm16WjY1dU04d2syZVp0cFZzNUxIaW9H?=
 =?utf-8?B?ZTN1UW5VbFVnYThHeGh4cFpCSkRZNTZrREF4TWFHUFp4bmhac2FIbHA4TGNv?=
 =?utf-8?B?TWFHSVdaWURFTDlXZVFXNlRCeENVcEVNc1J2djdVMXN0WlFmaWljNDVUbm1n?=
 =?utf-8?B?OE1SRVo0amxMTmU4UURxY211cG4xOURjVk93M21kWndxYzNObWNvbFdxNUZx?=
 =?utf-8?B?d2RaVS9WbDF3V0haaXB0Nit3NENMa2RlZTkrVCtFdWdMdWF6QmlqbXZVTVV2?=
 =?utf-8?B?aGlIR3lRa3E0MmJXRVN6NjRDYzUrOEFjcDU2WHFSN3JoZ0Q3UEhiOGt0dEVP?=
 =?utf-8?B?NWpMcmRnZzV4dm1DSm5sTVM5cVduZ3o4RFpTdnJudzhVeDBYbE5zR1lvUE5Y?=
 =?utf-8?B?U0lGTXNoS1NDSENuZXhEbVVGc2lWM2V6WEUxT3lLTUtTdlNOc29JR2JRV0dz?=
 =?utf-8?B?ZlczanlkV29YdEQ5ZWJVTmVqRUxoVi9UUGFscVBNL1lqbUIvb2ZQalhwV2c0?=
 =?utf-8?B?R2phWEMycHYrMm9uZEZDU0Rub3RUVUZDN2t0WUZUTnBYTXk3WGpJSEdUNEt0?=
 =?utf-8?B?MlNVaE1CN2VJVnVQa0tOREIzNElCRGRLb3J3ajhCc0dpeXR3MWl5bnlkNWF2?=
 =?utf-8?B?MUsvUTJDcUFDalJ1L0gxVG5KYkdySC9KL1pCNlNaY3dKeU1MOGp6VUkvMG42?=
 =?utf-8?B?T0JiQ29ITnZZNmVWMTNCT243TGh3MnZLN0l2UkRMTUZVdmFud3hzU0FZTysr?=
 =?utf-8?B?N0ZQRmF1RlZ3NWExWjVGaEJsYVRaVzV3L3ZOZWVLSXVUd3Y5ek1leUNkMHo2?=
 =?utf-8?B?WGRzVStXL3UxVWQ5UjA4UkNaR04vbllRaUV0eXJYN0h3K1JBL0ZLQkZMS2R3?=
 =?utf-8?B?TzhQY2NEV041Y0tZQ2pPdXB0czJSejlsWFdwSnZsMzN3UzltZE9iZkJqaFZ4?=
 =?utf-8?B?bE1RZGcreVhOOG9hL2pUZVpHcjcrZUlNd1o1U0pRWEJ0VEZSZXJCb2dtV3JH?=
 =?utf-8?B?WmlsMUFiRWFiN0xEanB6TU1lQk5sRG50SkhMWHh6MkRnaVNYbjUya05iZ0FW?=
 =?utf-8?B?dUlVS0RWdnBBRzdNeFZOeTNISzJ0VHp6TzNtSHhNL01yQUlXNUtXaVJhbjh2?=
 =?utf-8?B?RGF2cmNNVGZDZEJPZ1ZPTy90UnVEQllnWUhWSFpWYU1JMlFrTUlYRE1FaXQ4?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YOf54Wlv6oYSfn4kAufKykTdjUrPWp9QmAjLmnTw23KbxJUPmfHx/bHdXeMy4mtNg+fQJHUYqkdmPAYbgQYUx7eJ0ODMwwjUNSm8cLRusNcC6rJlHyNTDKcKzvShuEKyAyhbUh0ewf9XVjAKfR/RYBWRvipLmYZCle1VL2UyiorU9hANZG/hEAMo30iy4Ou90DS/A458Jq2rgW4GJP+7UmhueENkHwsvDpZkbnDGdAWp9fitjxYmrSciUUWk/yciruwjSpVVPSCBS8Q5HWCnuT2SK+uJY61zK5LiReUOGQ3OntXkw9UtED0qxMta7O9JvC8TmYF8GXWkVbXiIeKYJgd/wNAfISjO5bBnSnj1bc5YEZi1mtp7itLhpWlfwYi5QdR1No/rehqowbCeMz364Sv0hNOUnaEK1BFGV/pcnTgFj1/CuAcJ4dr4CSAtaRVT1glKzB1EMahTfyHeJ59VIbJVFN98/e62k9Zo5ILbk01sNsW1RRNKYU26c0bUYICQrzAR6rBefLjJC96EKrZzkAIig8y8H3icRRLHsHB67Bw9SxPyDndPQ/EcuLsLmJdxgxvUN0Tdis+Vee9d3xi5U7ZzOXVyYHOVlni4S+Dg06k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664b0a6f-5a1a-4a76-761f-08de287fe6d8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:58:13.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU71fLvPBrn0Z16ns6SSJqgLPfG8puaIWO36/tU5uN5wbWkSlMvmqFQZ21X0ulp35zEZlrjFIoBY3ptc//iXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=886 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200154
X-Proofpoint-GUID: P6hms4vnmva8OX-oeJtpP-wLZ6n7Euv3
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691f8f03 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xrEQMDsYkhffntMIkekA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX2IZrzcVC4b0h
 7lSR+x6ufX1eevW9rKsg4h8WOIAN2EwbUXLgGiRpSnTcVZN9WNYxO8MWZ7mK9FOiSxKyBCv2dwR
 /+Q9uXh6pwjxopYQD7LaTgX5oMksPDLb0YZDWwSY8bAyo2LblwdZFPaPrLHITL9Wr4skluclzr9
 nPZLkmaGjL+8yaitRExowvQcBR432rvx55BZSpzyo8R4t0Er0L6qsY54/4DE48M/spTtZVfjrBw
 im4n/gl8BWggsfmc5ewfIyPqPNcfyc339SygvInLu0UzwoiDOG2ZN9uFGcq1wPkjFbzuhDCdF6o
 JLa31Rkk27fVI7hz8mrDzRY9gxoOYUvjFhhvMHNRxRDTtOJ5Y3lSwDPBCeBnQRdsgyZ6FdV7o2i
 jwfSeplUXg4gFjH9tKpLPVCey1PoH9nV1JID0H9lYs1IyvoJoeY=
X-Proofpoint-ORIG-GUID: P6hms4vnmva8OX-oeJtpP-wLZ6n7Euv3

On 11/19/25 4:38 PM, NeilBrown wrote:
>> Extending to match NFS4ERR_BADHANDLE as well explicitly does /not/
>> comply with RFC 7862, as you say above. So the short description is
>> misleading.
> Does:
> 			/*
> 			 * RFC 7862 section 15.2.3 says:
> 			 *  If a server supports the inter-server copy
> 			 *  feature, a PUTFH followed by a SAVEFH MUST
> 			 *  NOT return NFS4ERR_STALE for either
> 			 *  operation.
> 			 * We limit this to when there is a COPY
> 			 * in the COMPOUND, and extend it to
> 			 * also ignore NFS4ERR_BADHANDLE despite the
> 			 * RFC not requiring this.  If the remote
> 			 * server is running a different NFS implementation,
> 			 * NFS4ERR_BADHANDLE is a likely error.
> 			 */
> 
> resolve your concern?

Well the concern was mostly about the mismatch between the intent of the
patch, as stated in the short description, and this comment.

But, without elaborating, the RFC does not place any mandate on
NFS4ERR_BADHANDLE. It's hard to say whether ignoring that status code is
going to be consequential. I'll have to study up.


-- 
Chuck Lever

