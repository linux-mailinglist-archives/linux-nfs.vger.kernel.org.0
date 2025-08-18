Return-Path: <linux-nfs+bounces-13748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866EFB2B1C0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 21:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FD7520ABA
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7201AAE17;
	Mon, 18 Aug 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QoRmJSTR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sw2Z+hzr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64363451DF
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545807; cv=fail; b=HKalHt7kXknEAsx9zNslzQZAyJMXzOOnPtHDXMokd2L01MZozYday1v5za/03+Ven2qQDBqxdzcwMr8LcvJzeQsrn/2QmqUxDubUjqx8poyFGGIfKTWKzQUa6Hxw0VdzNO6/63bFkTQk0Qq+TvoUxejDNyNDEx8SFDe8e0W82LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545807; c=relaxed/simple;
	bh=1PyABvHEwdKRp2ziWoIq3vddVxPgXTu3Zpal/pdN16s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M3+Xqv6lA1+Bog4IqElZm8rcOJro7VW000s4QoEX0qPynMNPkiS94dAyIBUb8p/GnDWDd5wNV/TSLGSCNOrTnptLYV/fiq8gZTzrx6emwFxj0doSRWYPORXbl6hH1yJ8CgVCDKpAlU1T6s62OuC6dTDe1nmsrmdXoavfA/Jq1LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QoRmJSTR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sw2Z+hzr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJC2s2030402;
	Mon, 18 Aug 2025 19:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/Zrxh5pbMfGmrC8Ykb+VjExGeVBQuh8JgowO3rPGPsE=; b=
	QoRmJSTRy4Tr3jbF8ie8jSoo45Sgive/q2nHITzkjSSbQQpm+29nAPVbqs9KsGnk
	Hmm2gqGbin9V+4XsOQv6j3K34s6RC2+RCix8pHZjNgVqbMW/iuyrxqUTGUFam1NU
	0eq97aiGx7kqPbzHifF/1obt3gxb33ISR41vJPLaToWh9XMll+c6GB2qUeLA0kl8
	Ag+14ktOerL9NTVe0b92oMCPKbqHoKwxEvoVbdg8LxzcjxDSfN17VxMMbmUvMtFZ
	Ui7Fppyi5ByHe5xU7m4cv2LYaChsXMn7botbEeZL+LehxHBj9cUnsxAcpiPjNdlI
	jDO5Xfyj9aTaDxqc1JVL1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhkuuu5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:36:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IIJDvR030812;
	Mon, 18 Aug 2025 19:36:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge97d93-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQqzQ3q1FlYs1bl4D1Td11kk5LH5srEYQT6Rb1Pr61lNap2kHqt8PGi0hUpKQXg27vPCSF0HOYedQ4KEm/Dp/5osWvh4DZ71skkPnKyo/oxdO2B6kpCg91SEstB3sPUSV6cXvG3lmFKTFukEejG+FKioMwwakqOR4L/eAhteitPbqENQFwXm7IIrJn0QUIE//H2Aw/r3FqfBsR+2eePVwBetIp8Er4W8mH/51ijdi2qNlP+oVMARqj9HzYqLqUVJ23YeVnUq+tvren4ju0jpdl0KQffGKB6BYT0czKtCXGrJOrpLZT+y9t6xeLlshkes69+BUaUsFMbEXOPgUB48Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zrxh5pbMfGmrC8Ykb+VjExGeVBQuh8JgowO3rPGPsE=;
 b=UKTgXP03rr/V9fBlCFIMBjqtl9Wf/FEyqQHbYdWi3CrKiC61VjskHNiUWYIXh50pE9+hqAlLMSOmqxHJLZS6Vjz2+Jf7wUWCYZFOMli296feZHTSGPsjQ3A/KQrjP+X0nC1h3WCRw7BpY4QhywqFIhMlnY3N5FA3+jDNbrZ50YkRJ1AI/DraKIK/j2D2JXWaTknVN+OcXegkhcQeyigKVU5GJYujY7SWtCdobwJPl0TWA9DvjLbxLF0Hx5+HNzkK6IELZO/PzNFOuQO08rY+dos8V+8vx+4+nlnVSKdqJDMOBXDzmajQLqb/DJUod3TBk6GbKQwcAxcyoSb0yjmh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zrxh5pbMfGmrC8Ykb+VjExGeVBQuh8JgowO3rPGPsE=;
 b=Sw2Z+hzrJMUPR3mrnjXRw5jKv9/oXa7ocz4Sol7G7u4FP8SbmrUekjqom8UydkzbYxfV2U0OeGx3ybUr2Ub8lChsNkbbjsGYi0vMF2VL3AaAzc6lHF4AJqfp1XIsSKzNMoRLT8xNM51wua/tcfJO4jSjVyv5AxJITufXj1wRkhk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 19:36:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 19:36:32 +0000
Message-ID: <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
Date: Mon, 18 Aug 2025 15:36:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a
 transport
To: Olga Kornievskaia <okorniev@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, neil@brown.name,
        Dai.Ngo@oracle.com, tom@talpey.com
References: <20250818182557.11259-1-okorniev@redhat.com>
 <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
 <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:610:b1::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: 64102388-3bf8-432c-e375-08ddde8e88f6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N0t5cEV6bTVxWWc0andIT3ZWY21wMGJFUUNsQVlHTFZtR2wxRjNKMmltOERx?=
 =?utf-8?B?VHliV2JpNWJCS3B4dHhwRlgyQklqcmN0K013VHJQa0RCSGdwUjJnSGhEVTFv?=
 =?utf-8?B?ZUtCcDVTNm5HMlI2anV1SFM2eHR4YW5nRTZ6ZjkySXFBOXlwTWVDY0lBT3ZK?=
 =?utf-8?B?NWtNRlZReGk0dzd5anA3SnBLTGNiYzNNQ3k2ek85VnorM3FNbXJ4b1RFTzNG?=
 =?utf-8?B?a08wdGF5WkNBUXBacXdkNXlGRnRLdGpHK2lEOXNLV2xGcHVlRGxESTdjNGtM?=
 =?utf-8?B?ODNKRCszSnZlZFR3ZWllSVNKY09xZjl6QkpkUmVaeFpidHJSbEZ2NjVBYWl6?=
 =?utf-8?B?VXppVzAxK1dyOHpBa2s0M1lZZmFPMGxvcDU0T3Ixbmw2dlVidzFmdHVkUks2?=
 =?utf-8?B?T2xCMkh5TWk3b0hnTXQ2T2FiczlrWUZUNlRoZFZDMVJ1akc5VW4wNlVYM2NM?=
 =?utf-8?B?WmtHMnFWWnpmMyttVG1DZk9qZ1Z5K2VLeWRQcnpVdkVNRU1xVG1ZQ0NsRC9V?=
 =?utf-8?B?TWwzeHhOTmZScTF4SEk4c0xJN0diYlFwd1lUQndvaXhJVEhTRGJIOU1kdGJ0?=
 =?utf-8?B?bFJvQlVYTWNWSkRQbzBsVEphaXFKYmZuUlV2VEpwOEFwMGtiUWpFbUJubTlt?=
 =?utf-8?B?czM2NlZOMmkvRnJMbWRaOG9NbWswVzZLemJNUDJ6QU9XbDJGcWI4UnU5NGh1?=
 =?utf-8?B?akZHR05scy9oa3Zwbk92YmR6MS93T1ZOMjFOM2ppaUJSTGxkTno4cktYWGFY?=
 =?utf-8?B?QVhtWDZmN2VBS01WV0ZUWkg3cDdUUFdHVjBIRGdsTEdhR3MyRzdpa0FQb1Yr?=
 =?utf-8?B?TlJMTit2QmhIbzFPMVQrMkdRcGUrRDd5N3lSTEhlRXp5Y09wQy9DQzNPUGo2?=
 =?utf-8?B?dXNlMURVVnRFak9ZQTY1OGtyVkE4c0hna3dWK0NCalBsVVFRZy9tT2tWR2FP?=
 =?utf-8?B?U1NzakhuNjNPRDRraTd5dFBPK0kvZCs1T2s1WVRWOGI4WTBTZDRRZ1lRWFZL?=
 =?utf-8?B?OHZ1Y2pnK3hlV2Yzbi9McS80RzhtZjRLQlhJcTZMOENjSVArLzM0NkhLWFZB?=
 =?utf-8?B?c0pNT2VUT2ZtTjRjNEFaSUlnNmRpTnhEZXZtZTJLdWQwYXNzUEt6eFZOSWxB?=
 =?utf-8?B?SFRUb2h4MWtWd1pWS2VMUjZWUjlmQXlJaWcrTGN1Z3lCOS9sWmFJTDdIQlA0?=
 =?utf-8?B?dkd5STI5L3RENW5oNlhTb0V6RlREL2dVM0hscHNVcnErYTdIc2JPcUIvNS9U?=
 =?utf-8?B?ZHVSRHBBVUdSa0VSWkV1dnBmSFhnbU1LTnhkSXFwOFBNL2pwMS9WVERVVjlm?=
 =?utf-8?B?UHloZVU3dDR0dEZ3cm9zY0RnZHQ5UnBZY2M3ZG1IQlpSUFRKQUVoZHRLU1lC?=
 =?utf-8?B?ajExY2ZBdzUySkRSWHpSSHljVDFSWlZKRUlyL1E0NGJOcUlCSktLbGlkd01o?=
 =?utf-8?B?QXBmSXc4TFFRb2FsLzRicWhEWmRTOUxyTzJ2MEFsSzZXMTlsRFRmKzJ3ejZB?=
 =?utf-8?B?WVluS0ZEUjVhTXZrTk82RGVYUW9zR1RpSmcxNEFJcVcvV3Z0OFhYaThwOWR4?=
 =?utf-8?B?QWRQUVBtMVEwb2FRWGJ2R3dGdGsxb2ZHcys4RUIvVExaTnArbnVWd0ZueTVl?=
 =?utf-8?B?ME4wRHZwWk8valpRY3lGQXdxS3JRSExqeENyRENnWGRYUDdyN3ZEQ3EyTzZm?=
 =?utf-8?B?eE5INldMOE9XTjRwZHVZS1lNbjFxdW16aUJsU3c0MDVWWmFlYkV1K3NmVUZT?=
 =?utf-8?B?a0p4elpweE5SR3Ixbkt3Smt1RHN0Qko0ekk0dmNWQ25EeitDVHpDWWVUR3Fy?=
 =?utf-8?B?b280dWFWbGQ2Ym04TlFjdFllUksxQ3MyOUFEU2RyZUVPbHRyZ1ZTcVJKbHJE?=
 =?utf-8?B?dFo5UWhrNC8zMFlFdVorbVBpYS9HUmMyTUMyTU1EZEZ3dTRGZU9iOWV6TDkv?=
 =?utf-8?Q?/uSEYNOOWM0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTFmci9LaUEwK1dncTV6S0JDLzFzUDhYdkQrWGhvZXlTT3lVVHFWL2JUbzA1?=
 =?utf-8?B?c3ZlQzZNaFc3Z1psczNYd0RKbFMzYTVRckZOZ3o3RDU2ZjJiUGkxMHVVZ0hX?=
 =?utf-8?B?Y1JyWk5oaGQ4UTJ4SEdUcHhPbTB0alZCdW5mYXhWM043SnZZRXh5eWxuOUVO?=
 =?utf-8?B?NXZ6UkVhYTBOaHRiTHAwajlqU1Z1RkNHM0JsY2JIODRLb09MbFRtWGNxaHBS?=
 =?utf-8?B?QldBQ0VQalFaM2JkQlk5V2pOSDBwNU9oSVN3TElEbXdhREpra2ZaUnNua25U?=
 =?utf-8?B?MldHdFplZUZ1a04rTjJCS3A5bGdLa0gyY3huS0dzZzVzYWh1TGpBVlZTL1Fn?=
 =?utf-8?B?U0hHQVJTSDR0cEs1Ry9OcDlXUDVrZnlpOGlxS01LRUIwOUswOXNObWdob3Uz?=
 =?utf-8?B?UlF0NEVFY2NlUHEvaHlvZHBWeUN2WGhnMTJhVGZTZnIvNCtoc1Ftbkd2Rng5?=
 =?utf-8?B?UHl0WW00SlJpbGtvSlBuMUNFbEFHOTMrMFpqRDdrNEl0Vm5vVmFoN0pRQksw?=
 =?utf-8?B?d2xtMmRZRTFKd3JBNzg2ZVRVR1FjaVRwQzZQN2JaaUxJTGt5YUtldEpuU0R3?=
 =?utf-8?B?d2V2dVlUeGcwWXZuSzJONWQ2R2Z6MlJmRWRaaDVzMEV4d0NNbWx2Z3R5dE1m?=
 =?utf-8?B?M21vUk1wNlNPUVZzOHhwckowN3g4NllnU1o0NU8vd0VTRktmRWtsTFFzUDZ6?=
 =?utf-8?B?YkdyV0RadGtlNGZUNzdmYmJaWmloWURyd3V4eFZ3dEU4T3FpNlpUMzd4QUtB?=
 =?utf-8?B?TDRTYlBBbmxmM003VStKY3JLc1RveWFxZjRlbENLcmlrdkVFd0IvaFNpR3Ba?=
 =?utf-8?B?b0RUdEhMM2lPK2VxZHNkOGVLUVFhaUFVbXlIc3BGaEQ2dU9iK2VtRzZicjV6?=
 =?utf-8?B?T0FjUWhpWU55WVdmRXBlQ2FLUUF2T3B2OWJObGdCVXNlR3g4SGhuRStlOTVt?=
 =?utf-8?B?V3JJdXpCZ3pGb1A5RzA1MHZ2dzc3emorc1IxSHRvVDhsWUVPdVpDa2hRK3JL?=
 =?utf-8?B?bUQvWlBPNDhVdXlFdk1TL1k1K1pkWXFKVHpjOFJiT1czWG0wK1BmMlNCQUFq?=
 =?utf-8?B?d21XUUtKVjNSZXlUYjhWZCtCa2ZONVU2YkZ2Ymhpd3dOd1Y0dFNtemU2QS81?=
 =?utf-8?B?VUdoN3VwZmpjTHRjZ2VGN21rRGtiaXNybEtacEdiWnVVazRuL28va0V1RHE4?=
 =?utf-8?B?Mnk5WlRkQ0tQcXU3eCtOMkswYTN2Tzl4dXc5RGRqY3hjVGE4Y2lRT0pRMDRt?=
 =?utf-8?B?OWk4eW5NN3NoUWpDMFVKT3p5SDdod2JFa1hJZGhkRVIzdGwxeS9ydHNud1la?=
 =?utf-8?B?RnFpVW13bHk3OU1EZzVucFYrOElQdk9XNUxHVXR5aklmVlBFcEk5b2JaRGQ0?=
 =?utf-8?B?MlRsMEk2WnEzdmxEVWFSdmVKamhBZ1FITHlGVFNrYmJaOHFadnRucWZBaWZo?=
 =?utf-8?B?MEhGRitXK2h2L2ZPLzZqUDIrekdQYlJHcENWL0x1Ly9XWkNUaFhQZkhibExL?=
 =?utf-8?B?bDdvamh5dzRVZmt1M1Y2MjJURy9jWnlIZnF3akFlWms3bENPU0xzVURpU05U?=
 =?utf-8?B?U2RrSE9oR09zSjZhYk5PVml3bnhacys4WEFJYmRNRGIxUnhVYkZJVGhIYUFD?=
 =?utf-8?B?WWxVZ2RCemtzMElNTHNnR2dFMnh1UU5qZkQ1THAyNUV4RlNTNGhKcHpzZ1RF?=
 =?utf-8?B?aHpiZE9BTDR2VkZsR3o1ZW1HemxEb0lYUnVHeDgyUElpc3gyVjBqS3NnLzlX?=
 =?utf-8?B?NFlrTDNSM01JeEJuVGtHWEdVblkzUU9sZDRpWmxmOWExYzZ3ZTZkeWhSSThY?=
 =?utf-8?B?eUtnQVdRWEQ0cXgrZUl3dlFQKzNwcjdYTkpDMDU5SFFNcURWNzdYTUhmRzl3?=
 =?utf-8?B?YWt5QXhzSWNIWmtxZGNpampYOGxHdHlJaEt0bmVpOXIwMVczV1RNcUdvT3ky?=
 =?utf-8?B?cWJaTFV5MUpHVkVPVkkySFVONmhPMktCdkROK3VVSHk5VXVmSmhld0hlbk9q?=
 =?utf-8?B?MHg3amdhOXNmK0NPTWFJZlZKNEdScThSeHA0MWVtWVA0SFovcXl3YU9tcVUz?=
 =?utf-8?B?RDFJYzd2ekxqZHI0VlFZV2g3L1NONEtMNm96enQyNkgvUFVQWmU0NmpQUTZ4?=
 =?utf-8?Q?pTElxhGlB2+99Fn+NYhYGaoHr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sb9W8JVHKP3D3jsSAPC+dPzyNDHqIaYycvYEekFTgzaJYSEkwtqCiivS8WcYPWkbKiH6qrmOzSyQRRXCFiDnb+CmpXWCG5ru22dExKPDr6i7x/38oGG1N/ushGQ4ZOQC3WcjlV/n/Z065netVhdkuOhys46DmBQFzq03k6QzsjRY0SVtXM0oz1LGtgpxKhxhCYWe/XArP74VAE9PRa9iMQJoF+3CerLBSmAc3OBgBJsp3dCmP9X2/6bIPj/SZd7ynAiEIBzozgdokgSEAXOujBncA7wSdYaktXyzHu7dJE0EZUVKgp846HWjG4Gomtegh05wteKSQks/bolaAOqFM9LcHf9djxl20DgDXyTaYPzkbs87FCEYstDX8BtElv0uOpjXNIjfwQHmomykZgpPl/6hFw/S+c43fi3b2McJiiAAHoc2Mk+hzA5meTQFb05CNnmv650YPKsRtjBT7eKNlSoKZX1BVextyk457UuLyRz4aei2dTMNnjqAMraHI/cwmUn9GcF5M6tdwOc47LpQPljqxmKMnQ2jIdhi8vIYXhBMkYKrmhNtPxMmziFN+qAHiMCJB/TmU2Yq1WuIYVPGtQk0jj07kOMq/K3R67ukJwc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64102388-3bf8-432c-e375-08ddde8e88f6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 19:36:32.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bu1dFLWAp6KKDO7cMrgJqW2mTN16NqZOYxWBpn27WbIIs6DNLwlggGEwvYMxtY3qra1XzYjdgyBTEU26/0lnaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180183
X-Proofpoint-GUID: 1AcCWT_rntUnGB3QwIMqc415DDuNfWSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE4MiBTYWx0ZWRfX3QZinZWBH/Bk
 z/3J5mXSjW1bgSYvvhKINnhr5UnEESFzO0fvQBCR0UAJmMjxp9USqRZ03HKCFycozgQTJdiIJTc
 a2wUQvMWo372nnmmXr08StmmhrHXhuw+Slf4Z6BJujpb3Zee8QLcUgEy2HizemWUYAvRxlfNcc0
 BsQ4YBrpSKhQQNxa6DGe3iW55sb/EkNCxonHssu0hlEClJ+cOIF364RfRLc77rLrPwFJy2wfnhm
 XbuwzJXDagthYIg7+YN7aysqgUvIEM37KBTsidz9FqFHAtUkOP92SBQmBbaSWCRMozAN6ngJNzK
 ecyJ5v5w0mxUhlCzSShR8T5AwBr//TlIDNfHln1+ri4EsNSHUsyRFfgILDu+NaJu5yVxe+ArdxY
 FwJl6sBQf6HaCmUsr60meHiXqFTqlHu8kZMTyLhGSzcuBzrSSJUUkBloyvwBC/UjDBR8pIMO
X-Proofpoint-ORIG-GUID: 1AcCWT_rntUnGB3QwIMqc415DDuNfWSj
X-Authority-Analysis: v=2.4 cv=HKzDFptv c=1 sm=1 tr=0 ts=68a380c4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=_vtpuhW3pNVvnM2qfsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069

On 8/18/25 3:04 PM, Olga Kornievskaia wrote:
> On Mon, Aug 18, 2025 at 2:55 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> On Mon, Aug 18, 2025 at 2:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> Hi Olga -
>>>
>>> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
>>>> When a listener is added, a part of creation of transport also registers
>>>> program/port with rpcbind. However, when the listener is removed,
>>>> while transport goes away, rpcbind still has the entry for that
>>>> port/type.
>>>>
>>>> When deleting the transport, unregister with rpcbind when appropriate.
>>>
>>> The patch description needs to explain why this is needed. Did you
>>> mention to me there was a crash or other malfunction?
>>
>> Malfunction is that nfsdctl removed a listener (nfsdctl listener
>> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
>> nfs).
>>
>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>> ---
>>>>  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
>>>>  1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>> index 8b1837228799..223737fac95d 100644
>>>> --- a/net/sunrpc/svc_xprt.c
>>>> +++ b/net/sunrpc/svc_xprt.c
>>>> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>>>>       struct svc_serv *serv = xprt->xpt_server;
>>>>       struct svc_deferred_req *dr;
>>>>
>>>> +     /* unregister with rpcbind for when transport type is TCP or UDP.
>>>> +      * Only TCP and RDMA sockets are marked as LISTENER sockets, so
>>>> +      * check for UDP separately.
>>>> +      */
>>>> +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
>>>> +         xprt->xpt_class->xcl_ident != XPRT_TRANSPORT_RDMA) ||
>>>> +         xprt->xpt_class->xcl_ident == XPRT_TRANSPORT_UDP) {
>>>
>>> Now I thought that UDP also had a rpcbind registration ... ?
>>
>> Correct.
>>
>>> So I don't
>>> quite understand why gating the unregistration is necessary.
>>
>> We are sending unregister for when the transport xprt is of type
>> LISTENER (which covers TCP but not UDP) so to also send unregister for
>> UDP we need to check for it separately. RDMA listener transport is
>> also marked as listener but we do not want to trigger unregister here
>> because rpcbind knows nothing about rdma type.

rpcbind is supposed to know about the "rdma" and "rdma6" netids. The
convention though is not to register them. Registering those transports
should work just fine.


>> Transports are not necessarily of listener type and thus we don't want
>> to trigger rpcbind unregister for that.

Ah. Maybe svc_delete_xprt() is not the right place for unregistration.

The "listener" check here doesn't seem like the correct approach, but
I don't know enough about how UDP set-up works to understand how that
transport is registered.

A xpo_register and a xpo_unregister method can be added to the
svc_xprt_ops structure to partially handle the differences. The question
is where should those methods be called?


> I still feel that unregistering "all" with rpcbind in nfsctl after we
> call svc_xprt_destroy_all() seems cleaner (single call vs a call per
> registered transport). But this approach would go for when listeners
> are allowed to be deleted while the server is running. Perhaps both
> patches can be considered for inclusion.

You and Jeff both seem to want to punt on this, but...

People will see that a transport can be removed, but having to shut down
the whole NFS service to do that seems... unexpected and rather useless.
At the very least, it would indicate to me as a sysadmin that the
"remove transport" feature is not finished, and is thus unusable in its
current form.

An alternative is to simply disable the "remove transport" API until it
can be implemented correctly.


>>>> +             struct svc_sock *svsk = container_of(xprt, struct svc_sock,
>>>> +                                                  sk_xprt);
>>>> +             struct socket *sock = svsk->sk_sock;
>>>> +
>>>> +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
>>>> +                              sock->sk->sk_protocol, 0) < 0)
>>>> +                     pr_warn("failed to unregister %s with rpcbind\n",
>>>> +                             xprt->xpt_class->xcl_name);
>>>> +     }
>>>> +
>>>>       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
>>>>               return;
>>>>
>>>
>>>
>>> --
>>> Chuck Lever
>>>
>>
> 


-- 
Chuck Lever

