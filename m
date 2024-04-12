Return-Path: <linux-nfs+bounces-2792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5158A36C5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 22:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035CD28433B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0514F9DF;
	Fri, 12 Apr 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3V6iqbA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yyfxkB/V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EE482C1;
	Fri, 12 Apr 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952758; cv=fail; b=d7lyn2RVjzTzdk8LwJlPtqoIi5PKpcYuVlZHoeB9eQs+Wo6sO7AZGQuT9i7MqY1JWEJJgygNc5hTAHa4EG/uV//g3/W15eqAbPs0yt7A28PqosszAjOY8gG4mBwcbgOkw0hX/xdJZ8NsNvVPcoejDSbqi+r7/xfGZAH1EgMKbt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952758; c=relaxed/simple;
	bh=pAveY8CBr2iHHxLPu0AE3ATdlqVy/E4G2tuBxvHA6OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0jd2v7qug+eHC/us8TbGpbK9aoceaOWZgzr3xJf3xZqSqYgXNw55kTqy7VnyD758YtaZRTBL7A/YRtK3Bmw4/zboAzV9TnHgWzJ3kG1CbamR618k6+6dj5vguzzUc+P3+WY2RMxs0x6wD+qW6IbOp2lvIqTFDwyQiEWRULcu7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U3V6iqbA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yyfxkB/V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CI4Ora016708;
	Fri, 12 Apr 2024 20:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NVpy6eOWZA43IJR7IpXfEOSh0bo6qfwxHsY/diO5bes=;
 b=U3V6iqbAzI65plRK0Lz4qQr0uHBIN2YxZSBWLaSJUdHGIG60ph1WK7OcWmqwAD28cV4C
 rYg7fLch6Fjuk6H6XSXAZ+xCyiIvV+6yL/Rlk/+lF6grwpUUSmKkb7OZNFlGGeKs3VFk
 Gv5cIbezfC5U81RaaZ/FKPcfYE/3TKPud5JWymLvVjJH8dP5UDgutrs6U8MxkHl5JAmh
 BcrSqoOyDIpc6Wiyr626/KeVAOtKA9PVmqgDq3AUQB6cF/WHtaffrN/oWPi51FxqK52g
 pmWs1xqRuzxCuh23v8iYYRJndC8/tEVWGC901/Nsd/iI5zaoBKXfvtzSYIsWEczF26OI Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0uvq9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:12:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CJ2Zne040131;
	Fri, 12 Apr 2024 20:12:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuhracd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 20:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lksxgoBOJirKwDRz/Gt0/n93Qg2NERYA9GhBZbNNmtUISNNqVHOS09CjPJmemDScEra/HEJ9zdN7YlIQBngWnwkG/foJilGx5GpoUN4MC6+43z2JwxBWkfueo0aVAW+ai96j5/CvIwkJrf0tMnry/0dKD9SxJkK0DqYjzk0iW7RaBE1qifvaPL3bPSHXn716Gxw3RsKo/MJ50OzwcMtHk0KAlBO/FlaDqkPLNJMibZo/sVntnM6jJFPgfnVqyeIYyuznMwjGuyDK6hvbOQPa2A1PNQEI6CUj92wSdMRA/y7+tEuk/OghzWMmdidXisMQKFbcGjFpLo2QiTRzPipXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVpy6eOWZA43IJR7IpXfEOSh0bo6qfwxHsY/diO5bes=;
 b=I93F+yUpm0qBlc0Osc9fOgreTsCcN/P6DGLw82iEECPtGrZRvGxGGDDus4QCjY8vKEGxkN+2M6AGFy7X7LK4WM0mlOwC+YuD0aJZ/HoLCj7ydfl8OTSIuKdaP7tnncDBeaFOvKbjocm59B2UKKlIbwwvPQziqxoVCkDKb67TQdYGpDlTdaIbq7z5oM0ZSSmPzUA/24zmf8cg8ABBUHZ0zva+yICQw6ktUOxzKXr+XhYbeP/B/J/CaEkciSqCFF4h4dlCooQeOaclMwOG7HcL1CnLS0Z5AtkrPVhaymM/WSVPdYeQYh8hFJAyrfQs7JmxAeem3SH996THpmrinD5XgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVpy6eOWZA43IJR7IpXfEOSh0bo6qfwxHsY/diO5bes=;
 b=yyfxkB/V2XwwQZuo0r/IasPx0S1+uhu6Ve/uGyInCZwsE3sZ+I9NEvpiNuVWPxiX1IyclMKpvLt8AbfaL99+x/pdkqQo93A4R5oI56GGwBfLDBcvjPgUn10y3zkJCYmegaF0Ip5M9QSYWD6L+HajsRwxRvc9/50VjXKgOB+ajv4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Fri, 12 Apr
 2024 20:12:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 20:12:07 +0000
Message-ID: <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
Date: Sat, 13 Apr 2024 01:41:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Chuck Lever III <chuck.lever@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com"
 <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 473ef54e-8756-4249-1f1f-08dc5b2cd3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uEKtc0fIada6EChYgKAB505uSaHr+hsNp5ICMo1XRs4mo15g8vgCBwgcFfBcGaxRak9JM5ez/gXTcpv+84jRUR6SUoMqKM4lnxqoHuuL1f1znu6WAqxdK9dEITire/LwZQ840fLjJtTpmgvoUbJ6YfCJ2dsAo58Wu045EnwbeAxieB0z/IYNNEtPmDg5KDZ865l+IPOWlQhiSPARxsBCnNHx52l+6rziXCeVKzBmMGogNtYcTMTDNFXW3qOlZGwCwjxeyslSRf7i42X9uC9ONBZ+T02vBaus2qyUm/dXFxlDcXx+GPLRQumdyO/kroK1i5CzAd3IvlhQqT5jDj7WmXe06xuXQos0iWoh/2iCbQ001ydHuzP66hpmFZ3vEJdSJYwrP42T2puZOpXFTGSufRNXFJOk4mgDM6Sp+h5OD76czcjxXc63MpGWuVEP/gspHf0xUpaCrR2OjCr51GMeSbad8Ud7saYcCs5fn8o99Qv8zTm+en/6Br0rwQk1nPSeGdevRA1zyEXoTv886QYlIBoCoeU9kq2fsx4Wmq8DeERUV49Ky0ms7XgnH9AjtlEI4nsJb8Dv4y4uAOOJ0uttlavMJvbV/JvcaTMuM/wlSFH+KEwkNoZ12aeVrSrI7LlvmRhzX5tnsF5rP6KREm/ZMGK2AuRrsS4vvbUEZcjp5w8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEFWNitYMjlLVHZzUEVHSzNQcHE5ZmpmZ2RPU1ZzVUdJZVByS2ZsRGFIK1gz?=
 =?utf-8?B?UXk5WGhKTy84VnBLa2JLS1E1SHZoTjVjcTBKT0dzekJtdGdTS2V1SGRxS2FS?=
 =?utf-8?B?R2hyc252dUR5V0RRZm9mT0RhK1I3VzNXMS8xNXV5c3lsV1pCdFFpOGFsazF6?=
 =?utf-8?B?WkhUQmZrc2JGNTNHakdwNnFqdnJuK2k0OGh3eklsMHZWNmlxTnhjeDEvaW5M?=
 =?utf-8?B?dmswUnVTb1ZkdE9GQ25nZDZvOXQ5ekxxdzNDcThWRThGL1ZVMkxxSXJqOFdF?=
 =?utf-8?B?MFd5S0cyQVFwUjQ0Nm9DUGNKZGZyLy9EM25MamUzMzhsL3AwNCtYRVJWNng5?=
 =?utf-8?B?VEZld21aZ0UyeUlWRXIvVGYzTXp6VzJhWXl0eFFHQ1Z0aXVGUmRvUzdramFa?=
 =?utf-8?B?bmNQc1lBMmEzcnNTWDZwR3JEVHoyeGd2RWJNS1o5bWlsaFNIdXlvRVpmSmZn?=
 =?utf-8?B?U2czSGcwcXVZZ2lMdXF5MGgwNkFoZmt4SUl3MHdrNmtaUFNkcmMzdmczdWls?=
 =?utf-8?B?bzJNVmxLVFhFa2JBTnAyYnRDOFZ6eThTR0tWelhFeGtNdU1pblRDdWlQTU5a?=
 =?utf-8?B?TzgwcGt0MGdBMmI0ZnFPWTlOYjEvdzdBVWtTcXJwRmlRc1MzQnUyeTJSc2l6?=
 =?utf-8?B?eGU5REhPMEgrL052NnhQUzUzZ3MvbWNJNE9CMnhlTXc2QkM4Um5mN2VWZDNa?=
 =?utf-8?B?dGZEZG43VVlCUlN5NnhldGJoNDhEenJiS0dUNkZ3ZWZ5MmlwUXM5aytXVmFB?=
 =?utf-8?B?d1BJaG1sNUlyb2lVZUdNTGdldDFVdUFLcERZUWdTSmJ0QlVyVzRlcFIrMjdi?=
 =?utf-8?B?a0NXVlBWeG5HUEJaRjRnTDNET2JCMVFHb1pqSGFaeFFNRTZzaFloc3BYTXJu?=
 =?utf-8?B?UXZEWk1GZTF4VFZDb0VvN0gzTGRBU28zajdJMUhpQzZ3MzBrVFROM0dqdjlD?=
 =?utf-8?B?dlNMeGlBTW5tS1N4ZHErS29SYTBYY3NoUCt1dk5PaFNCbmdyNURFdldzZzhT?=
 =?utf-8?B?S1h6aUtZOTV1bG9rOVBDNjhaUFIzS0NmakZVWnBoTHZ6QUJ0R1p4ck5TU2Vm?=
 =?utf-8?B?dkY2Z3YxWitkZ3NMR3NRVlU3ejJ2ekhKb093Wmw4LzRRaVJBbTBmbDVQR21I?=
 =?utf-8?B?alp1OXR3c2UvV1VRTXBNbFdSblVxUzFRSjV5T1kyaVFiZDhyWnIrWnhFQjJu?=
 =?utf-8?B?RmNsd2xxanQ1Rnk0SXRod1RoZzUyMHJtOWE0UFNraGdRNWNRNE8zb3NZY1Vi?=
 =?utf-8?B?Z0c3cmFpTDl0QklZLzdaQ2JUTGFUU1FRWHNiZm9naVZYejBFaC95OFVsdFcx?=
 =?utf-8?B?Y2Z1RDVWWGJDV3RrSFhkQ1l0d0tEL0xTLytsWklxbXIrNzltNFMzODlodjBG?=
 =?utf-8?B?STVSZ2VzMWQ5WXNNWGFzWFlONWJNVStsT3dLZGJiUC90dVB4NDhzcm5rSDFP?=
 =?utf-8?B?WHlTdENQeXVSd0ExdjZ4dFZpU3kyVTdZMXVkUWZVbTRhckcwM0NlM2E3V0RX?=
 =?utf-8?B?ZEQ0bUhmejY1enprY1F2M015cHRhSFBCZTZKMTd5NlhyVHJGcnl5UzdrZDRw?=
 =?utf-8?B?c3pBaGsyT3pWRXZOdjduSlkwcUpROGNLR3MwalcxNXJBdURoSDZnZEFtbXpv?=
 =?utf-8?B?dzVWNzQydWR2b1k2dzJQczJ4amF6YXBHdzQ0c293VjF4R1pEdmxRdHdaeExj?=
 =?utf-8?B?VlZwRHdDVmVaRlNhaWJRcmtJMmdtYWtiV3pZME0wdVdNZmppbVA5dEdwcStv?=
 =?utf-8?B?d0Q1b1VQMC9tMHJTWTdUbmhDeDFRSGlFT0RVZWptejVOREdXcEdab0pBdHVi?=
 =?utf-8?B?cnlqNXVtdU5SNjg5dlVNWXY5Y2xmTThPYm5MN0pvUkx3Zk9NU25ydTF4YUov?=
 =?utf-8?B?S1IrY3RuelZOMmtlUWRVMDc2ekhGMTFEQ0JOVWZ1TkxnMkRCQ2RHRG5DeGN0?=
 =?utf-8?B?ZUFGV1R2eHp3bm9pQzduZ1VRRE1PUHh0ZWZSV0ZJMDZFTEY4Nk04YjRGTE1u?=
 =?utf-8?B?OEdaTmdDaTV4a2s3MHIzajQxZlA5VzhLSHZFczI0SS96ZWpjUzdDUVpSUXlG?=
 =?utf-8?B?NTYyaXFkY0N2YTRpc1VQbDFta0gxd2FFOENXSzNrQk9tYnZCQUVUTVQwZ0NE?=
 =?utf-8?B?QXJJTXBFQjRBVmJJclFPemhvZUxtWWxWUnJFYkV1M2U3cVl6MTJRRldIZEpL?=
 =?utf-8?Q?8wZ36fICAM6Hi8vKvtxXnCg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8Fjb6HXvCuM2uIvSDK7iGLaK+gM2qnpZ6v1MSPc9rppQhTeKR8K5KxMW8sqj7r1mVXOmhTpJQDxBGjL4Owxk3aIFeYD0YROF/xG76sZt7yDXO/vrUEw4qXB3jEnP+0e731alp5v+FsPbYgtru1V2qAlmdmlleZq+YwGBbd0Xt4Gpw90RSRxpJLANjYYbJS3IM0NBwpyyXZieabqB9rUNYo2Z4KxpJ7izSTD8Xn+QEl7q+tcqaLpSS2Lzv/tC+rnX+thd2soziu3zfSWU9SB8v9AR4BKAOu+2MB5JUGnu517o4BM9ezeotomIkHvnQHYNb18EAFj0ElZjUPESxNLwcua35rDWVJi/NjdfhPRxOfn9LXErfVuDkBrrWXZEsQ8x8RLi83qG2PuzoDvKnYMUeMGGTMM06n7o5TJ5s5tMCdtNJPngxBXhrxKa5UwvGwx00Y+MZEJsAlhxjyoaWRLInTMbs0QJPEtFiVwvahrXD4b5NDAr195KKAOQWz6wGIl1F/PxiWS6VySM8OKETSMSE+ATkc5LkyBAj7DzcclY7GaK5GXyASeD3dcovhbD7I21K7OuNz/GklGQ6uxXJoTHn2eXQRaN/5QG1OD63IGSXkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473ef54e-8756-4249-1f1f-08dc5b2cd3c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:12:07.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIwMi+KeJ/dYFj0+csE+7J3DnLSEvK0iuliNmQuFlTzyu1yZdXdiZzKHZ61N7kBECVn/1oY/A+r0ea09KPuZRaqkTGD4UfoQvSucTJ9xyjSpeUJ2jHjh8MC0gqEWuw1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_16,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120147
X-Proofpoint-GUID: 6hHwlSDE0FE7T9DdTP6avMalce6GNq14
X-Proofpoint-ORIG-GUID: 6hHwlSDE0FE7T9DdTP6avMalce6GNq14

Hi Greg, Chuck,

On 12/04/24 21:27, Chuck Lever III wrote:
> 
> 
>> I have noticed a regression in lts test case with nfsv4 and this was overlooked in the previous cycle(5.15.154). So the regression is from 153-->154 update. And I think that is due to nfs backports we had in 5.15.154.
>>
>> # ./runltp -d /tmpdir -s fcntl17
>>
>> <<<test_start>>>
>> tag=fcntl17 stime=1712915065
...
>> fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
>> fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes by hand
>> fcntl17     2  TPASS  :  Block 1 PASSED
>> fcntl17     0  TINFO  :  Exit block 1
>> fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir: rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed: unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed; errno=2: ENOENT
>>
>>
>> Steps used after installing latest ltp:
>>
>> $ mkdir /tmpdir
>> $ yum install nfs-utils  -y
>> $ echo "/media *(rw,no_root_squash,sync)" >/etc/exports
>> $ systemctl start nfs-server.service
>> $ mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir
>> $ cd /opt/ltp
>> $ ./runltp -d /tmpdir -s fcntl17
>>
>>
>>
>> This does not happen in 5.15.153 tag.
>>
>> Adding nfs people to the CC list
> 
> The reproducer uses NFSv3, but the bug report says NFSv4
> at the top.
> 
> I was able to reproduce this on my nfsd-5.15.y branch
> with NFSv3.
> 
> A bisect would be most helpful.
> 

I was able to bisect: here are the results:



2267b2e84593bd3d61a1188e68fba06307fa9dab is the first bad commit
commit 2267b2e84593bd3d61a1188e68fba06307fa9dab
Author: Alexander Aring <aahringo@redhat.com>
Date:   Tue Sep 12 17:53:18 2023 -0400

     lockd: introduce safe async lock op

     [ Upstream commit 2dd10de8e6bcbacf85ad758b904543c294820c63 ]

     This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
     on fs with its own ->lock") and introduces an EXPORT_OP_ASYNC_LOCK
     export flag to signal that the "own ->lock" implementation supports
     async lock requests. The only main user is DLM that is used by GFS2 and
     OCFS2 filesystem. Those implement their own lock() implementation and
     return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
     ("nfs: block notification on fs with its own ->lock") the DLM
     implementation were never updated. This patch should prepare for DLM
     to set the EXPORT_OP_ASYNC_LOCK export flag and update the DLM
     plock implementation regarding to it.

     Acked-by: Jeff Layton <jlayton@kernel.org>
     Signed-off-by: Alexander Aring <aahringo@redhat.com>
     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

  Documentation/filesystems/nfs/exporting.rst |  7 +++++++
  fs/lockd/svclock.c                          |  4 +---
  fs/nfsd/nfs4state.c                         | 10 +++++++---
  include/linux/exportfs.h                    | 14 ++++++++++++++
  4 files changed, 29 insertions(+), 6 deletions(-)

Bisect log:
==========

git bisect start
# status: waiting for both good and bad commits
# bad: [cdfd0a7f01396303e9d4fb3513a1127636f12e5e] Linux 5.15.154
git bisect bad cdfd0a7f01396303e9d4fb3513a1127636f12e5e
# status: waiting for good commit(s), bad commit known
# good: [9465fef4ae351749f7068da8c78af4ca27e61928] Linux 5.15.153
git bisect good 9465fef4ae351749f7068da8c78af4ca27e61928
# good: [4420d19ed4e4fe2adc9bed8a49bf195db1137458] NFSD: Report average 
age of filecache items
git bisect good 4420d19ed4e4fe2adc9bed8a49bf195db1137458
# good: [94e412c945e64579798204aee7bc669d0acfaf79] nfsd: fix courtesy 
client with deny mode handling in nfs4_upgrade_open
git bisect good 94e412c945e64579798204aee7bc669d0acfaf79
# bad: [254f1c2521716cafc63530750ce313059f5d5979] iwlwifi: mvm: rfi: use 
kmemdup() to replace kzalloc + memcpy
git bisect bad 254f1c2521716cafc63530750ce313059f5d5979
# bad: [e635f652696ef6f1230621cfd89c350cb5ec6169] serial: sc16is7xx: 
convert from _raw_ to _noinc_ regmap functions for FIFO
git bisect bad e635f652696ef6f1230621cfd89c350cb5ec6169
# good: [05b452e8748bcf92c00725691437e16d46af7c28] nfsd: Fix creation 
time serialization order
git bisect good 05b452e8748bcf92c00725691437e16d46af7c28
# bad: [ccd9fe71b9ee46ebcecec8aec5c4f1e1ddd35dfd] nfsd: Fix a regression 
in nfsd_setattr()
git bisect bad ccd9fe71b9ee46ebcecec8aec5c4f1e1ddd35dfd
# bad: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd: introduce safe 
async lock op
git bisect bad 2267b2e84593bd3d61a1188e68fba06307fa9dab
# good: [56e5eeff6cfa4bd6ffa2b2ae5b8bfc1c28044faf] nfsd: separate 
nfsd_last_thread() from nfsd_put()
git bisect good 56e5eeff6cfa4bd6ffa2b2ae5b8bfc1c28044faf
# good: [6e5fed48d8b7b25f8517a1292b62a3a86a5aec91] NFSD: fix possible 
oops when nfsd/pool_stats is closed.
git bisect good 6e5fed48d8b7b25f8517a1292b62a3a86a5aec91
# first bad commit: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd: 
introduce safe async lock op


Hope the above might help.

I didnot test the revert of culprit commit on top of 5.15.154 yet.

Thanks,
Harshit



