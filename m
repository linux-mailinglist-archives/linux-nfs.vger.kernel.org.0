Return-Path: <linux-nfs+bounces-8650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D76AB9F67AB
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 14:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4427A2457
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E21ACEC1;
	Wed, 18 Dec 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SsulOY7q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qcpoOVbe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7B158853
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529881; cv=fail; b=UEpm8kf5DWS444iCZGFeAM4dHsQMfLkMKWyIi1/L96AI7nrtWaNJMyI2vg5obSgVkIIOoyfenEBe+l786eFPbAXMqBS1oJbtM08dR34LQNESZ5eRWnJcf1u1ycr29RYvI8qQU/JNJfmkPs69MFYyKXXMArgSo4/FSH53f9XiPNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529881; c=relaxed/simple;
	bh=/N9HA7b8H4qggkaqJklsc15Wc/Jb6Skp1p5Bwjwyk08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6hW49d7M5ibnJ1q444teJWp1XceeagJX0a66qSvsVDmAUKbtJI3l6Dje7WDvXu3VMT9b/fcVjmv6T4ZJ0y0hjLmPl6FDXaPTsbgCzeKTvlQXWFu64KDoq8l0al6c7yPx5ac5Z4j0XwH+1PJSSMndZ1iSLHHyagIYRkn/wrMe9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SsulOY7q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qcpoOVbe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIBmuY7011892;
	Wed, 18 Dec 2024 13:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pQozbS407BzrhMtFq4rGmZfjYSAu1S+IISUxgtyduE4=; b=
	SsulOY7q9E9TlMHIN4903Wr8NyHpw6FwDKFwFCGX1QjzRBRaVZWuVIF6I0Mg98jh
	mVtSsb+ExjLhjE77yfo3B8aR0k7F9AwCisGSjNbO+cSheuoX6hHTd1zykeNuOjhR
	+cnAk4kNDV5f1rRaZRKb9ABjSHAIArhOF7dZdYOMipcNkiRazuDV0LlQ2yMY71pc
	6MnVUBOGj1h3kJFwzbIdAkbO+3N7jF+t+KxSgdsyFONrKgDrmg7CHZMq/ub9i4xg
	KEDslz8pEc6H46f8LwYYT0OrAu951BTecGpYCjF1DEbMo3ETxuLztpGvGBwamycu
	xeZe4yweGfqAJS8smMY7fg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9gmrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 13:51:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIDbqaZ006344;
	Wed, 18 Dec 2024 13:51:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0far22h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 13:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM+UoBBZgPEy7xv12tOVO1+n8v9OqN5XyPvZ5sRc1f2Azu/IkjoBBiibuRbh5fEypOSMacl4I9ltc2r+fXtbfgKbbCWr10tl3yjhmB/X4JI1TmXqt1qe9MfTC6v8ggqYSpUHvsdorvSX0UaZOsz9z0lq4CHRrDiXapZGlOBZ5f0Pe06iIgWmVHPgoJdRd2l27RdrXMcUZavGvQH2Ga4qTN2ERArsfVLTdC968TLgqDOpKxi7Zh82Ge1ZmIrKZl5tpbD8YhwEB4p3na+v7JYWVkMh2n6coxiyDNvqUb72RplP+u4w9XlF7HwYVDbYRyBSaqz1eh0pUK8jqjK2bctmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQozbS407BzrhMtFq4rGmZfjYSAu1S+IISUxgtyduE4=;
 b=KuK4NmMr0gI+MCHh7ZaJ/9oT28TPQiOtyov9lHWFxgp+nWvHntC05ILBq3kAc3L73YvAZAc6xXs1JAytWdqFgDgdrDxDE6ctda3X4hpBLAgBOp38Y4HaC7Cdq0QwPnZWgs0uPXgzOtWETQ1OurMGEg+UavxIUr9hSdKz6QqttW2n4dJiecNzLThjLN+Pp8FnovySBOm+2HYTVxChn8oUEjoDEa5e0qzRh13mjmZApzDw/Ex8mdgYba3z4dicwYnHYKR4/6YFgevfO2pQeWO/6i8W7GNr9LybisgnLLVbCTBox3ydmFGQD5qtoYIvfyLpGZ2l0rtwuvgjPFqaF6zzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQozbS407BzrhMtFq4rGmZfjYSAu1S+IISUxgtyduE4=;
 b=qcpoOVbeve3PjvDGQADXpDzlhbwdtsJ9G+nZlyGDrg2ETTUSVNU5T96eqbkRWtQakmHNuNUHq/KB1eSiT/bpPXy5+RsEWg3+zD+Dt7nC4PLnA/tc3AK36mSEQ1HXgfEU5CWpPOeg1zrvv/Wt/1fSKiyauiz0zc+CmxGyRFMA1jc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5984.namprd10.prod.outlook.com (2603:10b6:208:3c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:51:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:51:02 +0000
Message-ID: <eaecc0e5-ff04-40ca-94c1-997cf6ab116e@oracle.com>
Date: Wed, 18 Dec 2024 08:51:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: does nfsd reset the callback client too hastily?
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <173449067508.1734440.12408545842217309424@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173449067508.1734440.12408545842217309424@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: c344f038-91bc-4ab7-4d9a-08dd1f6b0275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1Vvc0l2T045MUJ4Wk9vencwaGZ2NDdHWVdpYVcxSU5RRHpPMFZQVFVEaTRu?=
 =?utf-8?B?VkZPVWJBU3F2dEs3bWtUWkJNQytreVZjd0kzVVo1UEtuTjhwZlA2Y0VVNndn?=
 =?utf-8?B?MmlvTFREYVIyUlRtWTFWcFluMVJqQ0xwK3Bjbk5nRDVwZTVVMlo2ZCtkRU00?=
 =?utf-8?B?MXRVWlNuSk9EUm1qbnFmVDRyY2xRTUpHbUdWSmpXbStKTjJUOTExSFZqUTN3?=
 =?utf-8?B?SDluNm9xREpWUFdVcFFXWDlFZFhVdDRQL2ZGcThvekxGMmlVQWQ4Zk9ucTV4?=
 =?utf-8?B?Y0FVS2QzdURoS2NOOFNUdWlRVmhBT3dWdkgvUXIxeHd4TmhoMEMyUTNsK2tz?=
 =?utf-8?B?U0pnVlZnMDZOZno2b1lWSnlzbE04eXNVYmlJbUM5cDRNcXo1SmJLdFVCRUZX?=
 =?utf-8?B?Y3lHNlBtYlFzNXBqN0V4bDl4eHRjUUVSMHpKM3VYbEpsREZqcVpDSUg0R1lL?=
 =?utf-8?B?NExSdE5KbEJVQlVacDJXaS9NakwvQ0plb0cyakl5dVhWb0d0eTZiYnpsNm1R?=
 =?utf-8?B?WmlQbVl2UkdVOGh2UnNXUGEwdGY2UEJVcXhpekF5L3RrSldiVzZHV3dmamxI?=
 =?utf-8?B?VFViam9KRmhTN3ZvNWZ0VTd4NUdRN3pIZDZQeXN3a1ZRdngyQjc3RFYxNzA0?=
 =?utf-8?B?a29uWFBTY2dvREZSWUxpdjhTYkRoRldYNElBSUZZSnNsMjA3QVVEcjdQSjBs?=
 =?utf-8?B?NFNiWld5UkdtRmhWTDhMbUxKVE85aTRQUjFWbFRaVWFxcUhDcGR0VjNCWFBx?=
 =?utf-8?B?eGVrMno4bmZzQkkzRlZEK0ZhS0RxSFdGOVE4Tmw1OGhpZHhYUlFNUWJjOVM5?=
 =?utf-8?B?VlJpMkIrR0ZVUm5pZ1FPRmM5c2VoSjhxMVVvRzhrcFNKd0dRUzFCRDkzQm8y?=
 =?utf-8?B?UzNJYUE4Nlg3MFI1RU0zaTRKOGhPT0wwMGp6ODFRSG5vc1ZvSzhnRjF2ZjJR?=
 =?utf-8?B?RWFJQ3VHYy9ta2RMay96R3djcC9nT2hGVGpEZSt6SVhpZHBFb3BRdm5Oc0VB?=
 =?utf-8?B?Syt3TXJ4UjFqeTFnTmpBVHBkSTExbjdPbS9zbXhiNUhLYTVGUVAwUUw5Mk9s?=
 =?utf-8?B?eU4xR2hndmhOdElHa2R3NUk4aG1XR3IxWHYydGgydlJmempvM215c3J0djR6?=
 =?utf-8?B?MGVCR2xjclMyNWR0QjNSdTQ5MEFzNmwyd0lXWU5sclBSZVp6SnQzamQ0aHpI?=
 =?utf-8?B?cS8xa2FYYzBJYjFYVjlzS0tSQjNRR1JHU1F5RjhMbDBsMS9SUmIwaEp5MFRT?=
 =?utf-8?B?Q3JDZU5qdi9xcTdKbEJpWXJNRmI5aVJ2WEE3WWZZdVdaMkNGamtRdmg3UFFq?=
 =?utf-8?B?ZDloUC9jTW1Qc3cvcm5TY2Fhb3lJQlFIdktFNzlhYS9LUGJCbjVQRnNSLzAy?=
 =?utf-8?B?clFqajQyYlZOY2JIY3IvUmh0VUQyOFNnUVlrQzBQYVYzYThWZkk0RC8zbkor?=
 =?utf-8?B?Yjd6RFBPVmtURXE3NVdzWWtXVW1wbE5pQkpLNDMxcklJaUJDZk1FN05xM09F?=
 =?utf-8?B?QXM5YngyTVpDNVNjdExXNUFQMm5WdUtrcEJxMGFLZ0lldFdYL1hjU0RWdmxS?=
 =?utf-8?B?K3EwTVZFZUdBNytsdWpYT3lwcmlCeWU4R1JibHdhZS9UMWxTNlpQb0hWWTVu?=
 =?utf-8?B?Yk5QY3MyUU1pUWZvWmRYbVhNdGsrVVE1WDFoamNjYXViWHpETTJjM05QOEFx?=
 =?utf-8?B?RWZlQ05jb1N4OGoxYnNvOFU5VHVYYnN5Y1hpdjVSQmNQU0VicGhJSlZDK2tl?=
 =?utf-8?B?MzFNaWxkeWFoTEtEaHpnSEY0MDhvVWZ3aGZmWnVzZGNPK0J6eTZ4WWsvaWNN?=
 =?utf-8?B?N2hSTmZxaDlvNmgwM1EwblVRQjhxcDh1MEk4S2FOaGRmKy9FTXlDdjQwRTNQ?=
 =?utf-8?Q?l5u/iOKrg3T40?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVllQzY5eCtub1RobE1HZWFTeWxWanR2d0JtV1dETUhSVFJjQWxDeHVuOG54?=
 =?utf-8?B?ZmQwLzJsb3l0SC91UHR5UXhqZkxMZEY4UWtOK0hGcTFha3JvS0RkRWxJZ2lH?=
 =?utf-8?B?UThsaXB4UlhQZ0tKdVdmODZWUGhTVmQyMmYzTnFmVnFTa3VjODF2OE1CTDQ0?=
 =?utf-8?B?SXY3VU1BK21NbUIxekIrWjE0ajh4QmJwM3h1YjBHcnR2NCtYTXBxdFl1R3hT?=
 =?utf-8?B?SFVoc1lVTW5oMWsxS0tKenM0b2gyQVJieG43NldqcjZJbS9lR0gwYXdGTmNa?=
 =?utf-8?B?eXowU010YUpyYkNXdktXQnV2c3JrWDBXUUVSREZ0YkZLU1dOVTJGc2g0MTNk?=
 =?utf-8?B?blV4L1oxeTh1VlhIZmlwSlRTS2pVUmVockZFcW5QYWhMYUlYNUZCcFM5ajVV?=
 =?utf-8?B?WU5tRGtFMFVBN0dGZTM0OVdzeUdDdzZ6SXV5WUpScGtuUG9xTE1lZDJaNXhD?=
 =?utf-8?B?d252cW5UVDhJb2lvazBRbFZ3UWExU3EzRTdOckhPeFpmWGEzWUZmWkdIWU9Q?=
 =?utf-8?B?SHVRRzRCL011Y3ZJZWtFb1doWk9EaEhOQUJVbll1N2F0b3hoaXBZSGxpd2Zx?=
 =?utf-8?B?RlNkVWJNdFBlMWpoVFBFQ3RVckJNVTU0U1ZoRlNvMVZpN05vQUtSa0FmUE4r?=
 =?utf-8?B?ZFFGcitwR1RIYnl6VFJUZ0dlT3dIa0lwQWN0c1YrMzlOajhMbUFCb3Z5ZE8w?=
 =?utf-8?B?Njh6aWRZVmdjOTMvQTlSYkFJRTdObFlsQXkrZDNvaHk1Y1ZpVjRDbEhwUXFS?=
 =?utf-8?B?R1FKRnlKTGtXRmFXcmhtRzRyM0pnY2dRWmxVWkRVaGcrbG5ZaWJJR2E0Z2pm?=
 =?utf-8?B?bm93NFkxMlhzNHByUnp3TWtkTE4yTzdBMU9LVExicU5YakRzRTYwT21lN2Iv?=
 =?utf-8?B?WjA2WWxLaWtsKzRQdEhWbTRnSm15U2MrYW0vQWRkWlBJc2dTRjNSTHJDNk1F?=
 =?utf-8?B?Y2lKeXR6ZVorVWlYNko1Mm1DeTAyR0QyR010eE1ZRi9uSmNnc3FCRmZXM0F4?=
 =?utf-8?B?a244RksrVGM3dGM3TVVOb0JrWkFqdkdvQ0hvMlRPdy95Y2dBVFlYVmgxYnhE?=
 =?utf-8?B?bUM0YXdVa3g2Rk4wMkYyekhXTFlHRnQrd2QwUlpzQjlkcFhyWTU3K3JRS1F6?=
 =?utf-8?B?a0ZIc3ZjYWdJWGV4VVoyTXZ4Q0IrQ1lKVnBEb213NHAydVI2aWx1a2dvc3Bv?=
 =?utf-8?B?bElOMjhGa0pWNTZJb3hzRlNlMitQWFBTME9hS1lLK3FjSUpsTWpvUk1UY0wy?=
 =?utf-8?B?K0haVU9PaStTeFNocEtaYnltT0VhaW9Od09vYldmdWVoUHA2eXB2TWhId0pw?=
 =?utf-8?B?Y3ZSRzRFYXk5ajdYKzhlOUN3YXhFZ1h0R3Nhb0l6UVRQazJYUEpqWFU2dW1W?=
 =?utf-8?B?b2VVZGpFaHhVOWczTC9BRkwwQVFQbDlxMGJVQ3dxdGJPc05DNWNBTzF4eDZk?=
 =?utf-8?B?RDl1TFoyN3pycW5hUENiMnlja3FGamUwdEY1Q3dIZE9yUG1FN2JuOTI1UXc2?=
 =?utf-8?B?eVRIVEpZYVp6ME51VDZNVG9aeFR6dzU2QmkyVVlMSE8zR1VCcUJNbWIxR1Nw?=
 =?utf-8?B?WUc4eXhTeW9ja0pOTUF3UTl3UTZudm1MVHZTM0hrTE01N0hMamtjcm1TeEJh?=
 =?utf-8?B?VDFhTVpKcTRUeE5NVTkwQ0g1ZG9RMkNidXZjVnpYSGZWQkUxd3JCMk84ekkr?=
 =?utf-8?B?elVxd0wrQVJBRnhWdTR3eGx3N3RnQ2tnWWE3SkNBSS9KNmVWWjdnVzlLQ3dD?=
 =?utf-8?B?MHZZVndVYmxvNGtvL0ppT1lkQlRsbXhBYTAwYk9jeUZxSjlOa3E3bjMvYXhi?=
 =?utf-8?B?KysveUthNml0OUtYdGJxOUNFK0kzeEhIZnJSdHEzVFNZZkJjTm0ySi90RTBq?=
 =?utf-8?B?YUJnSll2VG5oT1REWVlvb0tTQnFDOU5qM2xSaThuVklyNlVuMzdsUkNLUmhL?=
 =?utf-8?B?eEdrVFVQUVRFRGhSRHJKc1luYXpyV21DQTBIWEM1b0pnbWlScFZOb2NubzRo?=
 =?utf-8?B?UDczK2grallZcThzVEtHbFQxaFFqa0tTN3VnZWNpV1NWRnNjVzVxenlGUnRT?=
 =?utf-8?B?VW9Qbi9HOTNnbnlxWWtieHhrZVdVN2FnYTI3M2RJSkVNQW0weE95ZU1sanBp?=
 =?utf-8?B?N2pnak54M0M4YjNFR04wQ0loUHhEdXY0MEdaazJNdGU0NnhXeDZPOVM2TG01?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1F8bPJs8J4mQD/pQtFCVi3Vl6hA9hp5KI2lS12p6XoMbsfofU9xIz3cUL0j8x2W6/Jg/Nw7z0zWtwrry74m2SUmlDhvAXR/MAwpyiSkK79uFGIN8dmLUzSJ2zwDHt1KEpPoInFTwsiNqGtnj5kL70WPJOTSLxYuWLOMMABvCUAeXxDk1towW9Hu4eVVdVOwLCe6+I0XfTTMGXYyiNqMERWDwZtgKemtYhSfvGujZYfwpX3OzmCRrqMo6AL9XctNwXlFsz2AUzWQIanW0wLlE6Cn5lB0Dji9h/rmeG2VVOAaQoMxCTOneRYCyOChkoUAX1YwYXSIbUmwI95bwLVKGTroqesldimICycG3jyRg9v1zeGDfO27bIzDcEFO6ey1llV24i+PDrKrppIe1FNKS2txo5RoNIMmPj7JWtO341YVS1yp/UsSPnvvJ0pw8MaAoY/QqOWi7osGVc0HW4wPtWPQhP2+mRvnC4mpXWe1CGdHjj7SI4p1TLh1Kac5x2TwyFZXFQrm1G2rlk4hx521zHtfw8T6TW3wEFdRrmtyFq5lWgZyJZD0EVfVjRKBczxqwTHdOaZpZSl/Ez/vDLZjBSKa47m72U6t0hcJfE/H/0yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c344f038-91bc-4ab7-4d9a-08dd1f6b0275
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:51:02.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGEMAFl1KEZ6BD2FICByYxCMDVsGqT68438ZCmtOUxT5In9O7ANan1hqKKT+bIGOqV1MGQULpIpiDTWr4nGwOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_04,2024-12-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180108
X-Proofpoint-GUID: 0CUPtPf7zNv8IQBitRKWV6mqZzNjLJ-Z
X-Proofpoint-ORIG-GUID: 0CUPtPf7zNv8IQBitRKWV6mqZzNjLJ-Z

On 12/17/24 9:57 PM, NeilBrown wrote:
> 
> Hi,
>   I've been pondering the messages
> 
>   receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt XXXXXXX xid XXXXXX
> 
> that turn up occasionally.  Google reports a variety of hits and I've
> seen them in a logs from a customer though I don't think they were
> directly related to the customer's problem.

That message isn't actionable by administrators, and risks filling the
server's system journal with noise. I suggest that it be removed or
turned into a trace point.


> These messages suggest a callback reply from the client which the server
> was not expecting.  I think the most likely cause that the server called
>    rpc_shutdown_client(clp->cl_cb_client);
> while there were outstanding callbacks.
> This causes rpc_killall_tasks() to be called so that the tasks stop
> waiting for a reply and are discarded.
> 
> The rpc_shutdown_client() call can come from nfsd4_process_cb_update()
> which gets runs whenever nfsd4_probe_callback() is called.  This happens
> in quite a few places including when a new connection is bound to a
> session.
> 
> So if a new connection is bound, the current callback channel is aborted
> even though it is working perfectly well.  That is particularly
> problematic as callback request are not currently retransmitted.
> 
> So I'm wondering if nfsd4_process_cb_update() should only shutdown the
> current cb client if there is evidence that it isn't work.
> 
> I'm not certain how best to do that.  One option might be to do a search
> similar to that in __nfsd4_find_backchannel() and see if the current
> session and xprt are still valid.  There might be a better way.
> 
> Thoughts?

Operating from memory, so this might be crazy talk:

The fundamental problem is lack of ability to retransmit a callback
after a reconnect. The rpc_shutdown_clnt() tosses all pending RPC
tasks, making it impossible to retransmit them.

I'd rather see the rpc_clnt be owned by the session instead of the
nfs_client. Then the rpc_clnt could be destroyed only when the session
is actually destroyed, at which point we know it is sensible and safe
to discard pending callback operations.

But the callback code is designed to handle both NFSv4.0 and NFSv4.1
callbacks, even though these are somewhat different beasts.

NFSv4.0 operates:
- on a real transport that can reestablish a connection on demand
- without a session

NFSv4.1 operates:
- on a virtual transport, and has to wait for the client to reestablish
   a connection
- within a session context that is supposed to survive multiple
   transport instances

Some reorganization is needed to successfully re-anchor the rpc_clnt.

-- 
Chuck Lever

