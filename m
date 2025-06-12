Return-Path: <linux-nfs+bounces-12380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8798FAD776D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 18:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EF816129F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD92206BB;
	Thu, 12 Jun 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="COIxfA6O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zCjqHkFQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794F21B9FD;
	Thu, 12 Jun 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743962; cv=fail; b=upJHjmxU0ZsemlbjfqxhnRfCf/L7gcVb2tVdfu4KKlJbALNb1QvFlVRB8zC/xho+2uockHULZIIrzmGULiOefL3/g9PJMljLRy4Qf7B9e+FZ0NhXuroBzoHlTnHYRplTSSBH7XCwErOpPidRlyPKv0cMygRZTTqr/XGZukmbxv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743962; c=relaxed/simple;
	bh=Al4croEtB/yHmsbOKp9AGs9b+0nnVdPX5ety+CK3VNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9RgtqXssD6nf8Fib+lcDAlxtIkMRzHGvYZ+gtvRssbZNSPlaO34bh6eBGqRAioGkO+8YbckGGlBn7cW03PrXfV+v5ZgFsVBAGiX6x2KxqPBi2cihoGZOmq8O37CQcUZdzveKZc+S4w3C1fIZBWTVXTFSx2L5xlGjN8seGFajyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=COIxfA6O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zCjqHkFQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtlsr000497;
	Thu, 12 Jun 2025 15:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2iPaCwmyV8EluQl9lbz9PTWc2eX4JS9f1W4I1JI6NBM=; b=
	COIxfA6OcUnGhW4GIgTW53s/g66sXI6m712hpUS8lm7BKeHd4xLFchdx9K/ka9ia
	C3kGR/8+l1JiiMPSbwMT1jN5kkmsgDOWFipjp0N8Yh60GSb/9Jpah+wAelLkQUj9
	LkRUiftGKsByl5JSs4bdbB3l+hgWbTWrAZST61ry7+IFw6vZMxEADbzfuil7riwg
	0GHSGdolm71dJqCHsjw5xVMlfazRjc8e/Qb02BRnbDkgUxzxjQYrtHyR4YgE3ZAf
	VGLhlWv1rPmvtzueQS9zr+XZD/w4I9rMXHdEYrKTyk1P55w2UMR6CwEqtUhJIJxU
	QpHd0gJYiyfqwD+67dRZMw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1va28e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 15:59:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CFgF9a032081;
	Thu, 12 Jun 2025 15:59:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbsby9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 15:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMwt7TNjF3cKHkTGsHD/PlGM7zbM381e5F+vjeyzI0KMsYsN0ZnYVRqeupiGHsr7mplwpO/LOX9nFukCq5GJ2N7tay0H+jB5UdtDHi0MMS8awOvjCfrtn0pAjbHhX5mdyYjc0dNJLnS4S1XZFGVZzpizb8YAmFAb7YsQ6+C8Iyu2OK0JXusMRu79gYn7+UQDjg4v7DrwSf48Dg87UGdE4ro//5ho96+Onp/lcCuM6TgteS/QEB9TrFZ9WikdhdS7QEpeUOvmgBaJUeFO7SOIVyt45Wql1p9zCoj8+nfTgPzOmxHcCaSOJdlmiDn18Df5EcF+K8NxRvmEMrobN/zHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iPaCwmyV8EluQl9lbz9PTWc2eX4JS9f1W4I1JI6NBM=;
 b=FML2Ht4zfJE67t0/zsK225FLBKtOfcVQm9KrEzaUFAzdMtuiLM2VXNfn8iw4y8PVDTVySQWCxQMEkliaygYLEnSJIVstOT/yuKKl24zkdARrteAPO4avC4vy9XsXkYgEzFq+IT3gLNbNu/ZcqK4nLvNqY4bFvf5FAOeLWu/chH/2WVbF0L06igWHZhB5yyrAWXRXBH6+S5w3f4JLrHgYz6xkD5UWflS29kWuLQ93kQ0rD1YU4qo/Lt2F7jxrIAMDh7dlV1gfXpAnHv6TN3RSULTsO/Vd74TfpVkDYUa6RMEyjCcHbbv9KPX6Fjl+Q2o9hrmhc88os7FGw4P53z28fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iPaCwmyV8EluQl9lbz9PTWc2eX4JS9f1W4I1JI6NBM=;
 b=zCjqHkFQ2dXVNtLPTXnSY+FFdZXgE/HfQXloi+cYL5zKcXyKqZwQwCTJHUZOjRC3upx+W6duVhg9CF0e9VlTTF/V4iojjjA1HVYU4VjFqQggkBbzKTIKDDTYJldMsk2cic11Q2ZAXeersStV0FLLerHpnLsyUECtMcXPzOQ3XZk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6757.namprd10.prod.outlook.com (2603:10b6:208:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 15:59:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 15:59:08 +0000
Message-ID: <4d6996ac-3fed-4af0-a568-f99b9d8e07e9@oracle.com>
Date: Thu, 12 Jun 2025 11:59:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Use correct error code when decoding extents
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250611205504.19276-1-sergeybashirov@gmail.com>
 <aEp6-T8Oqe2dI7of@infradead.org>
 <1951a618-a35d-4515-b4b7-131880a780c6@oracle.com>
 <lqssee7hdp5bkty34idm6s6xz2hfxpbkthzgqgopc72vbyzrdx@egvanmm3llrg>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <lqssee7hdp5bkty34idm6s6xz2hfxpbkthzgqgopc72vbyzrdx@egvanmm3llrg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:610:53::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 81be20d3-2d5d-495c-c0e9-08dda9ca1099
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M2NqUk42Z0N1WUhRUEFwUXQvdzlsaENETE0yUXFzakFoRVl5MzlQQ1E3YmlO?=
 =?utf-8?B?UStpdHA3Mmw3QUFwRmtkZ1R4eXhsVEc2Y2dmdTFvVDFJdWttMkdxU0tONnVC?=
 =?utf-8?B?L29YZmxMMDJOdFV0UUpCL0ZtYmV0Yk53OXgxZXZXV2Y1Yys5QVNjNnJWVmNn?=
 =?utf-8?B?djRKUzlzczFhZmJXa1Y0VVZhYklkMEtUeS9DMkdVTVVHbFhNcXJlWVVSbWkw?=
 =?utf-8?B?L2p6eWoyZ1hLcDB2eVU2OTEyMjlpdkg2L1lPOHdBZjVkOXE2ZExqaTZPUVRp?=
 =?utf-8?B?bmFRaGFuTWxlY1M0b2dlM3l4RTBQU2tjUEhEQXUwOU1HMWZLdU15MEUyQWR6?=
 =?utf-8?B?eFhyMk1jKzJRMVFBN3ZwYWZ3d253cC9sSlpQd0pQQnVxdUp6THViUitYVUND?=
 =?utf-8?B?bU15aFRKRk1tQ0FVZ2w1eDJJYXoySENPQ1pld2pCaTBaZGxpRll3YVRuZ0Zs?=
 =?utf-8?B?Zm03djhBSXRZUmZvZnFYbWpRWE55cUMyZkFNaU9XaklSMEJWaEoyNVRhRG01?=
 =?utf-8?B?aGVmNFJpSFNTK0VES0lWcXowN1dVTDRxUzdZOU1POW5qZzhvaSt4cWQ3akJo?=
 =?utf-8?B?cTVHaDVNdFBBUXl6WlVRc0JPVUQya1A1dnl3ajFYK2ZTcmoyN1FEYmFrWnh1?=
 =?utf-8?B?N1JYUHFLQkhmbGVCcUwxWG41UFZaWmJWQkwrNFB5WWQxVVdHUjZtejIyWU15?=
 =?utf-8?B?andFSDZNWXVjNnZIdXRhSzZwY28vbzR1SmgwVXBRRWNPRStDWEhvVmd4NllD?=
 =?utf-8?B?ajMxUHNSSytwNEhhZldsUktyNWZFQitZc3NuRmdpNldocnVSRTRlUzZwSllq?=
 =?utf-8?B?dFFPd2YrZnpCRWxibTNIamJkUk52d0FmUHQwWHArQzk1K0o4Sk80Q0IxRXQz?=
 =?utf-8?B?WXc3ZmFlY3d0WkY4N0dvV1Y2M2I3dkN1VVJ0ZURyYlhWRGU3L20rNkRBRnZq?=
 =?utf-8?B?UE81V3F4dkhnRm1kNzFSKzFnRnZrbjQ0K0FCcWpBOW1zRHBSK2FLRE9XbWNW?=
 =?utf-8?B?Vzg4cDJsOEQwYVF3eFhYWWNXR1FxTFEwUjNZcjhUN28zVWxjcE5qM1MzYnJW?=
 =?utf-8?B?WTI4YUkrRFVKQ0Y1WnNuTkV1TEswcnM5L2JsZDZ1ODFZOXc0ZGJmRytObWth?=
 =?utf-8?B?d2wrZ0x2Y1k0bFNLODdQWnhTSlQ5QnlGd3VpUXd6VnVaZDRLYi82VCtYNHJF?=
 =?utf-8?B?Kys0S3cybmsxbVFWOVg0dXd4RnBpaXF6TG5kTzJkTDd2Y3RUTnhKV2p2ZkN2?=
 =?utf-8?B?VXlQSTE2bVdpQWR0aGxMNzBvSWZxUW0xajAyUHVSbHFaQitiMXQzSGQ2QUhh?=
 =?utf-8?B?MnptaThIYXVEQUszeGZpNXE0WlF4alpraGxMTzkvdWo2UzI4MnR2V3NQZEQy?=
 =?utf-8?B?RHBoVW50eldYeWVReFFYNlpDakxnbUdFN0MrUmZHU1F2RGJudWZSK0RjMk5E?=
 =?utf-8?B?cEFBRzVFdFdNZGFxMnNzYUtTb08yLzNGUndtQUU3UTBsWjFoZ1B4dEliQ3Na?=
 =?utf-8?B?NGlsYktzTVhoM0xrM1pGeTN6eWh4dEJHTzk4QXBta3g4Q0wweUlqcEtJSFda?=
 =?utf-8?B?NHJqRENxenVwbkttYnl0cFRQdTBVOXZlNkVDNFJRSCtmODRRNHNGaUhka1Jz?=
 =?utf-8?B?T0Fya2l6UkNVSkN3YnUvN0trVXQ5b1IvSDdPWFNHTzdJNjNuMFIzZDBsVGIx?=
 =?utf-8?B?UFk3NUNjUFVLV1QrMlRQeFJQZytISlowWlBaUUpBMXNLMXFtWlh4VlNzUzc0?=
 =?utf-8?B?M3pwenduQXZpdmUwSjljWjNFcDJRSFovcTBEN01welJUU09XRW9qd0tOUGts?=
 =?utf-8?B?OHR6ajlLYnhCU2lMdmFBL2FNbGhvNUU2V1VIenVVb1F5ejQyMlMrNlVrMUlW?=
 =?utf-8?B?TWNzaVcvT0FHZTYydzBQN0hTYy92RFV3cmN1dlg2SUh5U2Mvak1KVmZDcEZG?=
 =?utf-8?Q?2c4zzSOX58s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZDUyaFRaRFZESFZxajhISDFwTm5MdXpjaU1JMVhYZFdRNjVNbGtmL2xIRDhi?=
 =?utf-8?B?UTIrcEdVaU1WU3UwVTdWdEJYOXl0eThpdWhyTy9RL1dmeWxWZXBxUEEydVRE?=
 =?utf-8?B?d1RDb0VLZGRqUHdwcUpNQ1l0d3RkNEJzdnZ1akhqeFdlZ0I0VUNxOFI5SFN4?=
 =?utf-8?B?Y2JibGJvZUtFemtNK2lHa01MRWc3RmhqU0J6SWpBMmFlT25nNTVabHVYK2wv?=
 =?utf-8?B?Wnl4cGU3SkxXOVlkbWQ5bnFqTkJtKy9VWnBUdm1ZWnpsTWs0d1NnZzVzd1hL?=
 =?utf-8?B?YUkza3cvWVd2UkFucnZ1UWpobGo2VUtFQjFaZk9JS0dlUDF6WnRwa005N2Zy?=
 =?utf-8?B?NVVHdUt1ZGx6UEd2eDh5VUxkZmY3K2M1dllFRlFNUWNqQzJBQTh2UXE2UjRQ?=
 =?utf-8?B?bm1xZ0JjN0VuRFJ0dXJVZzEwWmFaVWNrNW8ySWdOQ3dTbVluaUdQaEdYOEdp?=
 =?utf-8?B?ZE5BNVRWNmdFVmRoVkkydnRUV3Z6cFdtSS90RW9sa1c2azM5cTF0S05pay9m?=
 =?utf-8?B?TDFqMmxFeTJsYStkdzExQ2VvbHdpZy9LVTFiWDVkUCtQTlAxMVpQTEdkNmxG?=
 =?utf-8?B?bTBtaDF3MlhQMmx2WEdNdG5LNWRGUUFDNHhibXRFQkxQZ3o2RGora29MWjJ0?=
 =?utf-8?B?REpCb2dZUE1LcyswSWNWaXloVXN2VnNFY05JVDUrZFBHZFBIL0l1TVhFeVFT?=
 =?utf-8?B?UFFpSXV1R3ArODRxU2ZJRGhGN1MxMGFSSDdPRXJhMmV0NVk3Yk5LY09NR2lq?=
 =?utf-8?B?T3NNRUtIbXpkZCtmc09DYXloeUtoL1g1VnlMRzFpeWpRRWY5SjQxMk5zYTE5?=
 =?utf-8?B?ZnpZSWZsckFCeUI5YllMTFg2cHhLNVorL2V3dTd6eXpKOTMvRWdlZnhFZ1E3?=
 =?utf-8?B?cytmcFIzSlpvZWNzSCtwYktIQ2x5QVZMMEgyTStRRU0xUGxGd1pKZkFjN0pN?=
 =?utf-8?B?dUJWT2RUclFQK2VmTGlpclZJa1AwWGNKcllXSFk3b0NmS1NUbmJYUTMveVBP?=
 =?utf-8?B?UEdwWExNK0gzbFk0YkFXeU1aTkhXdEh6ZFJvNnFTMFRQR1YzaThvNDdHZjY5?=
 =?utf-8?B?M29SS2FSVUg0VzlsajltZGFsYUZ2aXRCelIrZjBYQzlZR1pRMXFxaGRCWXFF?=
 =?utf-8?B?UlhxMHFiZXRZSmIyNkJPSWdNcmx6bCtkS2hBbHhNbGlyWnRwMEFCN1Bia2dZ?=
 =?utf-8?B?QlIxbTdKUTZEYnlwTmh1K09EQkNLemV3Y2dPc1lLOEZoUVM0bU9lTW1lNHRo?=
 =?utf-8?B?blBNQUdKL1BUSEZDV2c5SEx6OW92L3N6cTVXdk9lNjlENmpSVFo2bnpaa0NB?=
 =?utf-8?B?VG1aU2tVQ1hDRTIrRnZKemp3MnlRNWZTTS9tWjkrdWo4U2szdStDRGNoSGtI?=
 =?utf-8?B?YSt4Y0VqVTJ5THVNbGhyakNVODd6WlVQcXhPMUpqT1JvTkNzOEE1ZWpRaGR0?=
 =?utf-8?B?bkJEYXFLckZmYkNHSE91WjhodURoc21IU1BuNkVKenhTdE9qenhBbGMvQ3pu?=
 =?utf-8?B?c1BaVExtU0ZKOXVqWlZvdWdYTG1ocXhUR3FqZVNQVmg0VW53N2x2bkFOSTdx?=
 =?utf-8?B?RHVaNEFQbmR6UjBRTzY3ODZpQjk0NTl6S1NVVkRhTFBEem4za2MwV1RXeGJN?=
 =?utf-8?B?RTRxUFZ4cEx1bGYrV1RJUW0zdnNYbFBOK2hjbzViNUQ1c3dsWjhEa3dRWHJm?=
 =?utf-8?B?dHIyWnZpdzcraTgya2lmZllWM0xWMkJESXNsdDBVd1NFWTl2NkpWTFA2SFp3?=
 =?utf-8?B?VTV2ckxwTWRacmtsbkRxZ1FxNU5MTVlOK0hkNkNyZHRhMG42WkQ0eDNBeUJT?=
 =?utf-8?B?bU1jVTJQOGRQMmhCN3BiSEsvUkVsS1QyVUJGR0lnelBlWHMzVlNWUTk2ZjE0?=
 =?utf-8?B?V2c4Ym1UbHpkK084Y3hraTJjUk5qclNiUlZsc0x6Z05KeU81ODBNWXlJckxW?=
 =?utf-8?B?ak1OZkJRZWZsWjg4Nko1VTRRaVVsTGlOTHV0V0JrVHlGZmI5bTZza2V4VDlL?=
 =?utf-8?B?WUErR2NwZ05hZEsyRnRRVDlBKzZBdjNuQnJIZENlbExUOWRmTVZyeGZPNlls?=
 =?utf-8?B?K3MxN2hDNUdRdlMraGI3UWJQUGpLMDhacXl3VTMzNjRSMnZGWlBmc1dSNnJN?=
 =?utf-8?B?V0hCVklqYklRRzVHN1hqTlF3TVlKeDZaeTIyV2kvSTNJYWNQNkxpVEJiTExO?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IZlzdP/muYyjOu2DV1XQo75FR+u9VlCU8vq3cnX+FCJarbsHlKNtH02mAazkV2/Dlywk0EC1Y88e1VZq/cigex46+NfQbTkGelI6ocji3ElEdiwsdqPFQXXSUoksD4HTKAC7qBuWKVhLf1zgmajlOaN7bNomC93Jve9Y8+GAT81ZUdU/eVsYDzWTkGHGnnnxpURmILI8w6PEwqhCwcfbUSQAPcXcVNsxlyOyERGphLLdsJPt8PzGQPkl475fnwZ59hFJKddTi0RUxrhNAhbyxMEVl0BS7yHrodIbfvu6UtvhOASWyVO2VjWPYEnEfdXvSNxuApIvCoDor0+rZzHjOxoWbz6dmxhj1DnNGbFSbLMJaQVYx5s1iRd9sYX+zBje32bC8DDjNdgaCmyNIK7nVEbP3b5csjodiRYb8a+XfqmWfcHjBoyEu3+KQTBitA56Ngphgw+VN1CLrc2TbG4huYSuSeViQ3f1vbUXwGZx2AgS/T9J1PiS8k3Xrloijy2C+WorwC8Q4INDFuUZWAZ6JxtrUiWcUP5iGDaDSTT41aBbvMFIWJ0wbzDhmsoLbcI+bdG3NtEgbn8FshaxUjOvTztkne+27BD6eGYSVefWdFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be20d3-2d5d-495c-c0e9-08dda9ca1099
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:59:08.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC7tpNqKSMEhEXkt9ismWNkwyM0yAvTgbUzW6HqrIapl3nRLGF4uczBE5Qot+ZslETNeahXYqcFRIbeVavCk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=746 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120123
X-Proofpoint-GUID: 9z37v-fUwOvYafejh2kzIuc5RNdj87sB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEyMiBTYWx0ZWRfXzF7QiAwouVOA mdBijd+WFFamrWPvUJdFkZpJpV+UBsoJg1Hewxbp9W0gXkvA3zknc2Tv5ets8W5E7OCbovblfmI FbbSgd67zCSvXjpgI7opVM1hTKYPHhR9sQMeGve1fPukWtYQD/WFvxdHEONrLwpcaHBb1AHjVvH
 8GHMxpHWbdjfADe/RM5pxOBcVgfCQqD38m1rYwjKAl+8KhnzSmcYfTncUJa4hsLe8drWaX/5XFD OtTirQWBXZtr9Y97gQtC3puZqVpx4UxvJi4bVDDPg9S1FR+MelAHogmhAkyAr9JnwZUCBSA0ime DUob4KFZf1x6dm68qbVfc44VmaGljIZBTxUI9r9aaMvM8ZQDYz9yDMTDoJ2caYQ1eXa/8GenQ1h
 HUOUKJQDInoqBkkFW6yaROHO+fuoCdouiIR5qhiRafw9NZ4Bemwk8nDI2rUFvVlDxMWKs/cE
X-Proofpoint-ORIG-GUID: 9z37v-fUwOvYafejh2kzIuc5RNdj87sB
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684af950 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ibbn6770qxpZJzkn33sA:9 a=QEXdDO2ut3YA:10

On 6/12/25 11:57 AM, Sergey Bashirov wrote:
> On Thu, Jun 12, 2025 at 09:10:11AM -0400, Chuck Lever wrote:
>> On 6/12/25 3:00 AM, Christoph Hellwig wrote:
>>> On Wed, Jun 11, 2025 at 11:55:02PM +0300, Sergey Bashirov wrote:
>>>>  	if (nr_iomaps < 0)
>>>> -		return nfserrno(nr_iomaps);
>>>> +		return cpu_to_be32(-nr_iomaps);
>>>
>>> This still feels like an odd calling convention.  Maybe we should just
>>> change the calling convention to return the __be32 encoded nfs errno
>>> and have a separate output argument for the number of iomaps?
>>>
>>> Chuck, any preference?
>>>
>>
>> I thought of using an output argument. This calling convention is not
>> uncommon in NFS code, and I recall that Linus might prefer avoiding
>> output arguments?
>>
>> If I were writing fresh code, I think I would use an output argument
>> instead of folding results of two different types into a function's
>> return value.
> 
> In general, I am ok with either of these two approaches. But I agree
> with Christoph that the solution with a separate output argument seems
> more natural to me. Should I submit the v3 patch with a separate output
> argument?

Yes, thank you!


-- 
Chuck Lever

