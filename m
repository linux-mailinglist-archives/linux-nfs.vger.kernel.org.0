Return-Path: <linux-nfs+bounces-15581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F08C06917
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EA31C05546
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328F12D1F1;
	Fri, 24 Oct 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W46o9PWt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kmdoVulJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F47640E
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313775; cv=fail; b=Vfc3qWjnk3FfQbF7LAd7ajksRxMko1wjipisT3E3No9LytUNfQZDtKhccSsIxCRaGcYvHewMjdVxgu0KbiCQgZ1CjLXdbHI/c2bKNb7jNpEN333QF66vhkUu2OJA3cgYag/GX3vV9q5RbtjXKR1NztytPBF9k7R53Yufs/B3mQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313775; c=relaxed/simple;
	bh=rzhJtziQc0kwFvjJsOKma8CqFZ8cVVz+F5z/b/6zN60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJd7gQvCDyRbvaz/oduJK3flffVPkI2UUceL3mNJ2QsNuWk89S2BBhT4gtFajqZy8beaNzwGKSuhHcdbpzcX9GSbrVrIpA30gnGM6R1tZltNPxrZElT5Yywk89qNjGHj3UgrEJhCrIHA0LP04DvpvN/zlFILRtFYUtella4xn8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W46o9PWt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kmdoVulJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3OFoI020773;
	Fri, 24 Oct 2025 13:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2iHCpyRvt4DbPrZOiCj5ggZgFhENERpwhs97bf/FySQ=; b=
	W46o9PWtPboeBmdJmHYqCVfoWnBRmcGqWBOFhmcXp6BOGHms7pOF/iXXtIR/U5g2
	kwBaqZYm9V+29h+G1RL7uQOD8PU0PhubQZSLmAbqVIQjTR4KwdAQggmPIp0MNZy4
	lI0isE0BH2N/iIuRN/7q6v/2IFu8trCWxgtDu8HNwL3NfglJ2uOWaqRqMkg7d12c
	XBf30Tbza02UQhMjoEaUNj8HsOELtxxbPeYF0eJiGM5rrKdvGiIunLfczq4D/ydk
	zNw6LX1+pxSOj41iDAViaijl9LhsGocYIKJur0+BBxZoY/Hkm3ndnq/yBAFme8DZ
	PEB/9MEaEBCLGoJNPqKvdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw3yx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:49:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OC6K8e023245;
	Fri, 24 Oct 2025 13:49:28 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgy5sd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epczmMxc48ILK+tnXvr5MUzposFfvodElEBxR67AhJ5961t5TuLSlDzI5Tn7+WWKt2rBo1WTD6cyLxeZSSnG+tJ4+pjjt/wshSajAP+DBmAGqJyRjHvPRfVrrV6MUDk64xuHQLoKyUyZxfMVj4MPJ7a0VlshsvGdN0/fU5J90jAor6nKcvlcVJTLxZW4fJkEVHGyRHyoq781Tl3jTb7A3zpDjmRe9FOWTOXJWFLZTOMF/6KXwSZQlbZw1YtwKBvrnyMuS4xB/IXN9tVNatmdT2JyOhjde1mP7fPSKLcuqBVJkM7foznMzLZFOMMGz79+by0QZmVGg4jYNqWh4d/gMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iHCpyRvt4DbPrZOiCj5ggZgFhENERpwhs97bf/FySQ=;
 b=L0W7wRqAH7Uc9biC7goh+fZeulpNb3t8dOp874b1dmivcPkuUwvIVUudmP9kZVfP1BvLpkH0zn2zpHvUUvpTjc710ftc/Mq6IySU+4fRDE/McUjdoh/H+4CZEhYn4Om0O1tEpjm5tk5B/TEl2aMVhRgwVhUGyJP/LqkL+yy0X2fu9Y5OmyW4PMX2ZNc/o/Enqp2uNG+wZyxtFmM4RhUSDk6IJobA5e1gJ2SMGDHyoZNePyxOFXl26hlO4qBJYy1KhXrqKuSM/DuisT33WGYcJQ6wudlKThNj6uiuDSopZPGZMyvP1/GzCg80UZTbG9xDHjIZY/E47r3WiyAJcltDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iHCpyRvt4DbPrZOiCj5ggZgFhENERpwhs97bf/FySQ=;
 b=kmdoVulJl2O1K9AQkEO+cBMxSKkfLzlnsdYKIlRX7/rbNn8yjs2nW2saYaTnEqtJ6hCESTP2YwOeg3IC27fcNr1yKKmWcIt8xL9zJWWV3FGs3L7w9lCqxDU+th1htFdO26VYNEB7YA2WJiaORWjA7R98AdXHDcPxFDf1z7eaNPw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:49:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Fri, 24 Oct 2025
 13:49:26 +0000
Message-ID: <1750de3c-5a06-40e9-9dea-b753c8047cf0@oracle.com>
Date: Fri, 24 Oct 2025 09:49:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] nfsd: revise names of special stateid, and
 predicate functions.
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <20251022223713.1217694-1-neilb@ownmail.net>
 <20251022223713.1217694-2-neilb@ownmail.net>
 <fe0c00c8-88aa-445d-a13d-9d41e69e8362@oracle.com>
 <176125961826.1793333.1976179461197405160@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176125961826.1793333.1976179461197405160@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:b0::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 20da885c-e152-4e22-b1aa-08de13042537
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M1VJK2t5bnZQUXM5MTJhdElsVHNtWk84TSsrdEFvUjM4NGgwSG5DeVFoaGww?=
 =?utf-8?B?WXFGN0w0TmhyS0crU1U1Y1dsNk9SZTM0VHZ1VG04Y2RSand2QlcwNW5tR0ht?=
 =?utf-8?B?VlhBNTJvYTNKbnBsZy8zYW1WcWNPV0ZkdCt6Y3VUNW51UnFxWDRvVkV5OE9R?=
 =?utf-8?B?bHdyOGJWQVhTQ3A1M2N2QzhlSEwwQUs1TzkzY0xiWUJBSWhmSHNKQ2Z4eXFQ?=
 =?utf-8?B?UnZqQjRjTmFnSU9iZVBYMk1UZ0hTQTR1ZjNGME1hY2pCOEFJUEtIVmZ5b2Fk?=
 =?utf-8?B?TWNnY0RkOFhOL1ZtVCt4NGY0azdTU2ZveHNBa1hNcVhsY09Xb1NqYWo0MFI1?=
 =?utf-8?B?c29ZMjlBUEd5ejNDSEsvTUNxRGlEQ2pTeGcvM0N1QVgweDk1R1Jmd0xuZVpq?=
 =?utf-8?B?LzZ3b0EyeUIyQWFOQjJOYmwrWm5UQS9TclBqdit0SklBUHRvbk5OMXRNcGZL?=
 =?utf-8?B?Z1ZLeHJ5T0VQTDVRZW9yQkdPWkZzV3JCdVVQR25PdnZxMkRocmVSRnhnd3Na?=
 =?utf-8?B?ZXNQdFl4Y0xKaEFkOXVCWkJWK1h5bC9zR2JFNXFWT0JtMVZzT2tpaEpZZUc0?=
 =?utf-8?B?UnIydDhSSk04QjVlaFJ3amdFU3pjYVA1NUhpa3RNdU05SVp4L0FhQXZwVG9j?=
 =?utf-8?B?c0hvVnJZY29hNU9SR1hkeEM0eitueFhuQjVFNTloMjhpdURsMHM3dktDd2Vx?=
 =?utf-8?B?YU5yWjJYMVArQWRYSXpaZ1JZUFJNeTh6OFJKT3FGQkx0TVl0WE1ScDI1aW5B?=
 =?utf-8?B?OXBWRFNKbm9UZHM5TUU3Ti9Qc3hQREkrOGJFMjVDNU5DZmFSZmlWUlUxa3pO?=
 =?utf-8?B?WUpDWUlEVUJCM0s2aTI1ZDAxSTRzWW52UGE0cHZYb2hYTldMbWRwUkZuZHFs?=
 =?utf-8?B?TU5vdk9WR0I5c3NPZ2VLZ3Zway9lT2t2Yi9EQTZxL1YzdTgxbVdsY00rN2pk?=
 =?utf-8?B?b25CZjVPQjg4Rm1tY0s4dWxJa1ZSWlo3bWU4eU85cTBGWk9jQ0dTSnNxN3Rv?=
 =?utf-8?B?bW1mb3Zpdk1ZaHNKNWpPOU00MWRXalphVGpDeWJQUFNDOVlJcDhtWkoxM0dV?=
 =?utf-8?B?NkZDcWhtckI1UFpPOTl5eXQrNm04WnlpemwvOWpSNG1IK29zMnRtQ2I2Y2dh?=
 =?utf-8?B?YXl4cnk2WWtPQklFMHZoanlIZndaUmtpd2ZOeXRzelN5dnNTQ1hxZVkwSFhN?=
 =?utf-8?B?UzNieGJoT2dHS2J3dDBFTnBXVkpvUkxBV0wrdGFpdEZSaXh1Mzl2VnJvME54?=
 =?utf-8?B?NUg5TzNRdklrcWhza3FvQWk2Zmp2VTQ1cXpXOXJYK1dBWXpsY3hmMEJ6MDBG?=
 =?utf-8?B?ZXdJMjY4cWZLNXp3eGFhNG1xR252ak5hTG56K1dFaVBuMTFXa1Y3N0NuRkVO?=
 =?utf-8?B?TXZWby8yUzlDNVFVWnVFbGJYMVJnWFZ2YmoyM1o0VHI1UXlPdjJKWjFSaHlt?=
 =?utf-8?B?UlIrZ1VaeHlDcm5aN01IQWlXZUh0a0RhdlZOVVNuc1F6MHBWNHJMM2VTTWp4?=
 =?utf-8?B?VkNPOUJkTUtObkhKZDAwNExDSlpTcHlFa1VvTm5KOHFpZHhhWXVUaEIvUjRQ?=
 =?utf-8?B?WHJoODdINnRhMzZUSXhadVE0TXZTUE5rL083ZHVkUXVqayszTXZmTUZmWThs?=
 =?utf-8?B?Mlk5OGlCYjhFSFhXK0F3UU9ZZmh5SlhSbkpQVjRUSzhOOVVxMXlVR2ZpQ2tt?=
 =?utf-8?B?MWx6VDlFVW0wRkJYTmdxWTdhWG56d3ZzRk1kK3VPZHJrMGpJSkxZMk1NR0cv?=
 =?utf-8?B?YVk3dlFjVXFIWXhmdWFCRmRxU2NnZzl5MzBodlBxMlBsQ0VzVDk3a1hzNkhx?=
 =?utf-8?B?K1d0aTJDR3RVeEVFaTNSUmVRb2ZPRVFKWC82UW15NkN1U1NBUEdHWjdnZm56?=
 =?utf-8?B?YllDRkR6Z00zYml1VnVSa0w0SVY2WGNuTC90Vm9VcGlwN0lDT2Y2SCt5a2NG?=
 =?utf-8?Q?Fl7B77tBn5Fu9IWSi+XPgBFCwyCR2t2N?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZkNTQ053N1QxNTE5L1FweUVvNWJvWFhXSWJ3TXZ1M3B1RVZkeUtCRlIxV0o2?=
 =?utf-8?B?T29OcTltWGs0UytMK202L0FUSkJOVHlHcTZHNitsQjBEaTJnU21tZlliWVlq?=
 =?utf-8?B?ZGhGNGNPU3FwU2lKQkxUNUE2MzMvcHQ0dE92U3ZGRzhXZWJhTkh3SVdXOXRG?=
 =?utf-8?B?UHBab1JGRXRWQnRVeThyakV4ZVdYYnYxK0QvQkdwcG45d3Z0b2pPT0hEOG43?=
 =?utf-8?B?ZWtnNmNvTXQvbHIwSUdpMGhHazJNSE50QkRDUXdjd2cySSs3RXYrbHJVK3dC?=
 =?utf-8?B?aEt5ZzI2RHZVMDZvaG1IUWdSRmRiS2JKLzUvTFlNSFZEMjRSd25mQ3lWbUJw?=
 =?utf-8?B?UHBlYk9KWVNSWklZMkJsOUx5clFJK2gvQU9zL3pkK3JLSXBQY2pyNnBSbmZV?=
 =?utf-8?B?QXl2VDgyd0d6d0pheEQ2b2lOdmtsQ01ON2dsQ05WQWhRZEZCaWJFeGU0c3g1?=
 =?utf-8?B?bGRoaWFVcjBES2FPSEV6UmJ4RDVmeDl5QlRxWXZxNHAybml0OW5WTUEvc2dD?=
 =?utf-8?B?Z2xVWVBERUxLNjZkYjlWREs3c21SZjlrTW5KTzdlNkwwWTN0Uml1ZUs3TkFq?=
 =?utf-8?B?d29NR2NwRk5TK05LWms1ZSt2UUUrK1FSdUdFcHM1WkJuMjkvSXlQVmsvNjRs?=
 =?utf-8?B?b09QNkF6UTY2MzFBbHVuRDlsTUdiZFE4YnlHTEdUa1NoR0duaVR0eXNpR1la?=
 =?utf-8?B?Mm5NdHBOdkZUQWsrNVZqeDllUW13enZwcnlvZ2w2aEhKYmhMTVNNUkJVT2FZ?=
 =?utf-8?B?VE5JN2gyaG1PelkrbGJTSnIxblU1dmhuVnhCSzgwOWQvUDc4WVN0NjNIbmFQ?=
 =?utf-8?B?Tm5xdkFLSDdKY3E2d1gyT0Y5Ky9lYWVzRW9tTzhBSm5DLzJqSXJsT1ZyVkli?=
 =?utf-8?B?OEwxUmdZRUhuenpVbFAybGQ2N3dIMEpNamNOZHhvbVQwcktEelRyM1RsMnFV?=
 =?utf-8?B?cUxMd3MzSGNOUnVlTlY2eFAxNERXNU0yUWN4ZEIvdS8zT0EzQllQOVRTeEpK?=
 =?utf-8?B?U2d4YUxHblhUVTMyY0EvVzBlUmZqaDN6VVlYSFFZZ2lZbWtkeHdyR0QydTNR?=
 =?utf-8?B?a2VtNmFrQk16UG1XeWk5NDBRZm0xT1dqb1dMSFdqWGZoeUJET2hTbGR5aERS?=
 =?utf-8?B?bEJ2WUtxZXNUZ0FFd05qVTFRM0JER2RzS0poUVlJak1mNVk5R2hJZG5RZ0xQ?=
 =?utf-8?B?NysrTXd5S3BiR2N1NmVNL0VsbXlaZ3lTeGU4bjdxTHR0VzNpSnU3UFhSLzlU?=
 =?utf-8?B?M2o4ZWxBYnczV1RxQTJuQVVJWCtzNmw5V1ZwbG8yL0I4T3hyQ0Q5MUNRSGN1?=
 =?utf-8?B?ZkNkcmMzT1hCU0hQRzE2MVdwdFhvVnlhdmhMSmxoSlZMMXl6MXJObXBIUDVy?=
 =?utf-8?B?QnlCSzYwd3ppT2g2UFZvRkJUM3VibVYvb1pPbndaTHJFOG1EcW9LOEFyMjFN?=
 =?utf-8?B?ZFZUY1ZwZm9TYnA2QXRZREVkd0JtenJuWWZjQUs1UlRwYU9PVzBUOUdQcC93?=
 =?utf-8?B?UmtLUFFheWNOc0xEU1dxcDR3Kzc5Sk0xakFBRC84Z1BiSExyQjRPUTAzQW5W?=
 =?utf-8?B?N21RRmhKdHA4ZlBnUzQ3NEFLc0RxeVY0dHlYajlQVndGY2tkdmQ2dFl4QUdj?=
 =?utf-8?B?eXJoRThjMUVURDYrbnVoZHJqYUUzYVV5S2VlSEFtdlJBVlpyQUZxdDhwdGxo?=
 =?utf-8?B?L3QzcXFaS0dUdUdBTDlnUjVWYXJFSmFEZDU5OGhZbndKWW5XNnJvMWZBVndz?=
 =?utf-8?B?WDRMUFpxOVh4RmRxN3JrL0pxT2svaTFNaTl5Zy9RLzFyT2daekVlZHBUN3hN?=
 =?utf-8?B?U0F3dENid29oN1pXMmxQUUNLOHptNWx1MkZzRmxPdWdoZ2ZvYjNWcHhsMEpU?=
 =?utf-8?B?WU02U1g5RGpCRUdoSURpdFU2aTNTQnNtM05tczlWRGs3Uzk4NFdkVjVKdTZC?=
 =?utf-8?B?VWRKdDVHRDJWN0xyb3ptcnpWOFUrRU5vb1hxRnZhbE9mNDVOaDJ0UXBpbjFF?=
 =?utf-8?B?YWhNMFdJSGYwblFuenhkN0pDYzdLNEFuSXFEQi9YWElhVzZHM0RwcERZbEh5?=
 =?utf-8?B?RXd1OTZ2WXlFblBoUnU4SWNWMGZ2cEtGU0l4cWE0bjFmN1E2dWlpMVpPZjJ1?=
 =?utf-8?Q?vW85EQYHVJ3beX72lcEQEoiYp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zfcHIJsQXz+/jcYlC/N5Vk6FZEbQrx/Xtg5dtwQyZqmUuBAeeyB5EY7AzCL1zoWivnAfdgspSNKa10SvJ6CEfXf6aIEbRAEy/nlrrOgXp8KL3suOow68WWt7gKD07h+0Q2WeMZo01Ygp6Y4QJdm8BdaSUFXFaqC5miyS5g89UQtSl0hcMIZD9kI38PkSZJquhsVqNzXcO0h9kE3V32J6BLvRlGOQAShUAgi0aLMbcsG4sJxRNJ4wKTrM/JOcCD+Mb61NTbruEf6TVNpGF6M+IKxaOXUb2i2aBOboXt9NgeP5T1Ebz8MM6GZUXSDqAms4Yn3PASHlhUsC9sAHYTDuV0cZ3IN7Rb1uRZdFRdQ2zBPFdageX6OgeqFGud6PZj0WOiDXaheLZ5ZZmLBMgetc+vy/FSgd04fCSjl9zT5tZCs8sFNU/w5n20KXLNAFE3W0NhIG5uokki/NGc2mqgFOJ+bVEYccvsM4crV6HU2by8Jku4McqJ2WhRhDo0UcH5JnwZFcIggwM/LwytLGEAFB4USNBLrQjoFYUl67BdUTBpP0MwI3mKkOJt+cLL1aMQpsNZx0l31BAhkyatx82hX/EcCwvMfoEVLf+1Hu0fn9XNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20da885c-e152-4e22-b1aa-08de13042537
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:49:26.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtEuZkKtU7KeN9ryAzDCMY6r9o8HFikkNTgb+sNtAC4qOAVXpHFgeFqF+taZGOgOCK3bYtkOECqQUqTbG4Uc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=993 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXz1INfOyi/6u2
 hGB/HuOtwyA6jFoXH1OXJVkrQNmemcDsvUhr1HuPtHSEgg5PzjThDAdPc1kmM/Qs1kYhrb5u9c+
 +H8c+N3UHau1gnFhh99I/wbxc8nGbqE1c2Ei8j6xKLLLyPAtCOyUtlHhXTPjM1v3RsaONc/C4wv
 KIvFvpZPiFGg9RF1GlGSVfeBV+ETuvHPcSCNCA/0i+qOr9fVYnPsMTTMtIQTEz4410itlXI53q0
 ZpVZEuwMyTYqO3dWANslxsEh5iEN+R2PE7vj6TjPCeCjhMImf/0VfQ1ZFkPscTJGgjlbm6evkl3
 j/0rMJVfQg6sJOhjszCFW8rKK3xVzohKZb/tzNhA/fNhLtOd8EavLF4NY7YnVOIIiVhXpXjWlaC
 PSKZLCP+EP7eow5w2NiNusjsPMrC+Elq1X9Kmf+bS3HUaVOPPl4=
X-Proofpoint-ORIG-GUID: MY6O6XQz4jYMpic48Uaqr0tMsR1Ot7Sn
X-Proofpoint-GUID: MY6O6XQz4jYMpic48Uaqr0tMsR1Ot7Sn
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fb83e9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gHTk4C8CYOikJd48dToA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091

On 10/23/25 6:46 PM, NeilBrown wrote:
> On Fri, 24 Oct 2025, Chuck Lever wrote:
>> On 10/22/25 6:34 PM, NeilBrown wrote:
>>> When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
>>> is testing the stateid to see if it is a special stateid.  I find that
>>> IS_CURRENT_STATEID(foo) is clearer.
>>>
>>> There are other special stateid which are described in RFC 8881 Section
>>> 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
>>> currently names them "zero", "one" and "close" which doesn't help with
>>> comparing the code to the RFC.
>>>
>>> So this patch changes the names of those special stateids, adds "IS_" to
>>> the front of the predicates, and introduces IS_SPECIAL_STATEID() which
>>> tests if a given stateid is any of those listed in 8.2.3.
>>>
>>> I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
>>> it IS_READ_STATEID().
>>
>> IMHO IS_BYPASS_STATEID would be a more purpose-specific name.
>>
> 
> I particularly liked how
> 
> +	if (IS_READ_STATEID(stateid) && (flags & RD_STATE))
> 
> looked, but I agree that "bypass" is more important.
> 
> 
>>
>>> Places where we now use IS_SPECIAL_STATEID() didn't previously check for
>>> "current_stateid", but I think they should.  I don't think that change
>>> actually affects behaviour.
>>
>> This needs expansion, it's a little hand-wavy. How are you certain that
>> including IS_CURRENT_STATEID in some of these checks is OK?
> 
> Fair critique..
> 
> IS_CURRENT_STATEID() is used in two places.
> In practice it isn't needed as in both cases there is a subsequent call
> to find_stateid_XXX which will fail for these stateid, resulting in the
> same error.  However:
> 
> In one case it is called (in nfsd4_validate_stateid() from
> nfsd4_test_stateid()) to validate a stateid in the TEST_STATEID v4.1 op.
> RFC8881 explicitly says: "Special stateids are always considered
> invalid" and in that context this can only mean all 4 special stateid.
> 
> The other case is in nfsd4_lookup_stateid() which is called in multiple
> places where a stateid appears in a request.
> It is always *after* op_set_currentstateid has been called to use
> put_stateid() to replace the CURRENT_STATEID special value with whatever
> is the current stateid, so the ......
> 
> Uhm, it appears that the code doesn't match RFC8881 (or RFC5661).
> Section 16.2.3.1.2 suggests that there should *always* be a
> current_stateid, but it might be anon_stateid after e.g. a PUTFH op.
> Our code will invalidate the current stateid after OP_PUTFH, thanks to
> OP_CLEAR_STATEID.
> 
> If we implemented the spec, then I would be able to say that where
> IS_SPECIAL_STATEID() is called in nfsd4_lookup_stateid is always after
> put_stateid() was called, so the value current_stateid is not possible.
> 
> I wonder if I should just remove the test from nfsd4_lookup_stateid().
> It seems pointless as the lookup will always fail.

Sounds like we need a patch 0.5/8 in this series.


>>> -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
>>> -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
>>> -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
>>> -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
>>
>> A comment here that directs the reader to Section 8.2.3 of RFC 8881
>> would be nice.
> 
> Yep.
> 
>>
>>
>>> +#define IS_ANON_STATEID(stateid) (!memcmp((stateid), &anon_stateid, sizeof(stateid_t)))
>>> +#define IS_READ_STATEID(stateid)  (!memcmp((stateid), &read_bypass_stateid, sizeof(stateid_t)))
>>> +#define IS_CURRENT_STATEID(stateid) (!memcmp((stateid), &current_stateid, sizeof(stateid_t)))
>>> +#define IS_INVALID_STATEID(stateid)  (!memcmp((stateid), &invalid_stateid, sizeof(stateid_t)))
>>> +
>>> +static inline bool IS_SPECIAL_STATEID(stateid_t *stateid)
>>> +{
>>> +	return IS_ANON_STATEID(stateid) ||
>>> +		IS_READ_STATEID(stateid) ||
>>> +		IS_CURRENT_STATEID(stateid) ||
>>> +		IS_INVALID_STATEID(stateid);
>>> +}
>>
>> Might be nicer overall if these were static inline functions rather than
>> pre-processor macros.
> 
> In general I would agree.  In this case it would turn 4 lines into 20 if we
> used standard formatting.
> 
> What would you think of this 12 line version?

Yes, that should be fine. A single comment that cites Section 8.2.3
over this raft of inline functions will be sufficient.

Would lower-case names be OK with you?


> static inline bool IS_ANON_STATEID(stateid_t *stateid) {
> 	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
> }
> static inline bool IS_BYPASS_STATEID(stateid_t *stateid) {
> 	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
> }
> static inline bool IS_CURRENT_STATEID(stateid_t *stateid) {
> 	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
> }
> static inline bool IS_INVALID_STATEID(stateid_t *stateid) {
> 	return memcmp(stateid, &read_invalid_stateid, sizeof(stateid_t));
> }
> 
>>
>> The other patches in the series LGTM.
> 
> Thanks,
> NeilBrown


-- 
Chuck Lever

