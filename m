Return-Path: <linux-nfs+bounces-10489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB9AA50CE2
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347F8171C51
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 21:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417D256C64;
	Wed,  5 Mar 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwRJH5Bw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gzrQDkjK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3B2561CD
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208394; cv=fail; b=X2ari3NPnEBX/Hr/G5RK5eOxIx66i5wEfAEN2pUjTldd8bTXZoofiqaWATKm/zMXKwb4Ui4+LsofSEbuq3SR+Za/nIGaD3juFFhxUqbIHiBmf2wXH47pVt8CAyNEz2J90tQHfE0QkNjnJPtMYYiOUYeE94kXpm9/1yul8vOW2wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208394; c=relaxed/simple;
	bh=g4OpjI2Nph+/lh2xN+jlf4zqE1Bc9M0lFqMzwavfZEw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H1A6m3GCnvtWJgXasPyHpbsRWPKVJwdAvxJ/JPwRHfsVJtvAnke1vy52uUxC67iWWEe2KQZzN8NnNElO47lF22WAbBNNdiWHxrO7oc6AyVcFgLS8siKQECOJzlmGOTlyIIS4XZ6j+PwssR+4CzSSr3cB8D2gW9IsZN0m7YSwurU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DwRJH5Bw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gzrQDkjK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMf5V005759;
	Wed, 5 Mar 2025 20:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V1b9cC3d5VgLEJpmYogN8Q2Kj0XLL07W5xFceZzFi8w=; b=
	DwRJH5BwhIPBNjMzzLts/dhIVTyI3AshhlJaw9QF67w3z+KWQFsJ5UQoA7XfZFOs
	5cCWa+4ZUcLCSwOO0p6bfZ1fNk8puU7qtxmoqJJ+ZQttnqBwLuZlTrD4xGmHaaTF
	dXgCslBx6eqZw6bBNMz4M2twYze3Ocxnue5O5opv68uVpbjNwNkxhXZwSHYEJ/Is
	SIashwP/XptvPihNWB82nHE+jWQ45QxPekm7Yf1WBIrw2eZyMqF673m/EjatLuFc
	8abhXWQhfTo1T7zNghzwycsN9sV1D1NlXykHTJgvgQEsFw6F6++OtzwR+7Jfm3Ul
	zZPdFwZjiRCJKMt80Gdzmg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wrkvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 20:59:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525K4r1o003168;
	Wed, 5 Mar 2025 20:59:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpb0akc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 20:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P74Dd7aiXB7c8T2DzQr3ZAGF23g1P6Is4HodfxD65y1OrDTYgS6N5twYHZ+wwHxHkw/0eiYkXGgSn9D0sfPq9BilTRlHHlkr3iSQYzQ4O/Db4VzsIB/GBl6HVjBKhS798AlVMpi0mTA3Eon7R/3jus2BNdPwmrewRp5JENNuqr32cCx5Bgrpbb+x/DDVB5B0q22jbfdWDisIjbx4cZoln7q8daFJrUxROpeAxSI+PAYH6h1YwjRMxtSEYn+KNSBRa4zPbFqlB4zfFHf0+CjMuazeJrgLeBqxvHFzCGRlvDrE67CVMfT62onLrF65rBCOsFkfO9fcp4cuSVAdi3TWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1b9cC3d5VgLEJpmYogN8Q2Kj0XLL07W5xFceZzFi8w=;
 b=KrZfnMWtt8b0RQCtGKjPGklFP+mvmrebeEGBCt84ddVLPmjYKOW3ueqY8XiyxcRsLIXVGr6zFEu0YU9KM6jgoF1T/535q+ufwSNRO4fBmiW4XUnKcqzqqqz83A/PNCOpiaYFSJmHgz2sJCVJ7BfLf0T+BWrR27R6lWv0LcgstfWTp2aE+0nT9n/yhKCB4iimF1GTLMT7930cZ/KcDgBxtNiOtOyOFOs+hdR5FhBMVByvAxePuLu8aaFt329wqQuvTc3+rWsISMAWhm42bqfvMRZC5YT17ajlmD0mXpzlVKdxwUiFR6DkOn7jHEA6m4SOkuvk7jIPimt41iJcXa/bXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1b9cC3d5VgLEJpmYogN8Q2Kj0XLL07W5xFceZzFi8w=;
 b=gzrQDkjKp8vcT7EMcmsuMeypBZMa+HAppO/JENyThPUQk/kQQtgHnpfRHroGPUleFugwAodRPCEqPpLIUXVB3zZRAuRnMGaHzst4pU7IbrCrO7kC7s+l2f15lLz51PK+X5MTffD7DK8hO+Hv2sV4myc+4j8N63OyNm3o3NX1Fxk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 20:59:35 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 20:59:35 +0000
Message-ID: <deb67458-fe9e-4303-b310-587b404c9d80@oracle.com>
Date: Wed, 5 Mar 2025 12:59:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation stateid
 for READ
From: Dai Ngo <dai.ngo@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
 <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
 <ac7d9408-c1fd-4f4b-88a3-162a9f3cf176@oracle.com>
 <24582f1bb0778852feea0e676b7db163019c1b4b.camel@kernel.org>
 <96135388-c965-45b0-8c81-03b680136757@oracle.com>
Content-Language: en-US
In-Reply-To: <96135388-c965-45b0-8c81-03b680136757@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:208:23b::24) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: a002dc76-7cc9-48bb-4ce6-08dd5c28a24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVpUMWUwOXpTVEYzN2gyN1pCUVNoRnd4NkdXV05aSmc5dzBOOHRaSmZYM0tI?=
 =?utf-8?B?R0lxaUlNTHYvaEVHQ1pFNW0wMzlvYkFOR0RpUGJCTUpmaGFhRjhaQjdRajY0?=
 =?utf-8?B?R3VOeWZHbXRqMTl4MUFhVk44Z01rSER1RCtwRGI2MmF4WjYwR28wMVZuN0N3?=
 =?utf-8?B?a1Vtb2MrOUo3S3pEY0VoY09hY0F1Ni9MSStUekkrNlhoWDdNRi90Ti9STFls?=
 =?utf-8?B?bzlDTUlYeEpCOVNsWlNmSEdLMDVIK1dvbDE4NVhkTDNuVHdXL2REeG1rOUNn?=
 =?utf-8?B?ODFjVDJnY1VKOXVJN0U5MmkySjBqSGZjeTFYQytjYU9PS1dzcVZkT3lpK0h3?=
 =?utf-8?B?eEE5bHRrZGMvd0tyMkJGY3BKbkEyNW1GUGR5SmRLVFdyRzQrcmVxd2JvMzU4?=
 =?utf-8?B?YnpUNlpIZXllTUVvNnhjZ3kyQmg5aVRWRGQ4UkdjMXZyL0ZsY2hVZmdPYXdj?=
 =?utf-8?B?anRFSVdmWTJGWTk2c3RoV2tlSVBBbGdnL3RGLzhBRUpoS1hySHEyd1EwNDdT?=
 =?utf-8?B?Nk5UWDJ6c0RCZWlzYVA2K0k2cHdWN1Q1UXp1bS9XVVNhUGpJZ2xleFV5MXM5?=
 =?utf-8?B?OUVYUERZRUo3cUhhdjZkWG9UelE0U2h4Z0w2b29XVjR6S1VHS3p5dFpNWWxB?=
 =?utf-8?B?TGRSTi9nSytoYXVCUU9CN3ZFR0VYdG1ha0QzUXhWSTRCSnI2YlRjTUVqNk1D?=
 =?utf-8?B?MklBMGR4YkVFRXZaM3J1ZGJUL1R0aEFtWGRlUXNWamg4R3JHZk9pRXhjR0Nv?=
 =?utf-8?B?RVVWcHpXcXhtYUN6ajc3M1NJSzNHcVQrTW1mVjlWWmM0cE5iUVpOMnRpNlY1?=
 =?utf-8?B?ZWZ2MS85MU45ZHVPSHd3dHZrY0xSalRXK0MzT1o2a016UzI0Z1B0YXJHRENn?=
 =?utf-8?B?MUI3THVsVDZJeFIzSEZ0eXNQUGJmejFMWTVQeXBNelduNTNLOXZ6ZWhiVHVN?=
 =?utf-8?B?WGhKcHAwcTlDTVIraTByMVlLTEdXYmRCUVViMkpTL2FlY1orcVoxaEQvS1U0?=
 =?utf-8?B?Qy96STBkVlBrdjlHNDBMa0FQNEtTekJ6SXl5WGN5aWZENzZDN1pLa2JNLy9U?=
 =?utf-8?B?MzB4NEw4eDgwVlZ0RnQrSG13K0l5Nkhra0sraWVwdFZUZVg0bkFIczl6Zm12?=
 =?utf-8?B?NlFwZFkwS2ZRU2tkdTNlUUtrWjhGK0dOUjN2TndsQXg0c2paejBnL21Mb0Ry?=
 =?utf-8?B?QXlyeUs2VEowL1I5bkNVYTl1dUs0RU55OFV5T1FwRlkrZnF2THNPeEYzNFAr?=
 =?utf-8?B?MFJKakk2c2ZLQmRCQ0QxQVJtSkVGdWZnaGloRzlKUE5SQUhYdFBpUHR1YlN2?=
 =?utf-8?B?YXhvb0U3cytLT21SZk9MN1k1Vm9ja3hkSWhHaC9na0IzbjhYNXkxVTYwVmxq?=
 =?utf-8?B?Qmk4RHFEeVJxd2EreG9mRExISGJidTlsWjhNQ2NmSmh2UlUrcXozbXl6ZFdK?=
 =?utf-8?B?ek9vRTVFSEgwQ0tCSGgxcTkxelBFamtmeTRBR2xRa1hsUkYzRnVWZmZ4bitq?=
 =?utf-8?B?Z2dYKyszdGJPTGFEa1NPZmpMZUpMMnBGOFdNekY0aFFjZVNQVlJXdmFLL25K?=
 =?utf-8?B?MFRuY1IrOWx3WkJIUk5SbktmVGFmdmpqVkN4MUg4ZGR6WU1xbm9DMEpTZ2FJ?=
 =?utf-8?B?enU3V0orTks2T1c5dHo1MW9GakplNjFmQTc0MU5BS011bzhySHk0RzRtaDZr?=
 =?utf-8?B?YklOMks3MDFyNzBObWZJQzRnRHRUZEt4eXpiY3hYbkNXVUlTZXNIMzBEQlJs?=
 =?utf-8?B?cEhFcFZTR2pZVGVjL0lYRHc2cGwwMi8yUFBNZThPUFM5bmVWRmVaVXBiaXNq?=
 =?utf-8?B?clRtRW1kZHM1a3NWYmlnUGRMNjlkb2hlM05jbXF3T0dZQWh1MENDQnZ1L3U2?=
 =?utf-8?Q?QkNML72Pz2/0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXd2MXdFblFkK0tJbC9VeHRrWWMxUzBaU1hTKzlOYmlyVVZMaXdCREVSajln?=
 =?utf-8?B?dlk2aVZkNEtpYVZabngrK2t0OTFDYnRlckViRXNyVWZWSmVlTVg1V2lNczZP?=
 =?utf-8?B?dFRxbGlZMVpTT2d4NmlQTjFzU01jb09yTmZkdk1aSkpWV2MrT3Bla01pTWJF?=
 =?utf-8?B?Wm1NYXNiaVYwcU5ULzJzaUNOZXpuU3lqSnRnV1diT3B2MzdMU3QzUU5qUDJu?=
 =?utf-8?B?T1Z6MFI2UDJYbWFlOFlGQWVleDI0T2pZTFdsVkRhWTl0Rk53TWVmS0FZSHdr?=
 =?utf-8?B?RHZlYmdvYnA1ZTJ5WC9PYkk1OTVpWnNSU3BscUlzU0o1eTN1dXdqa1RrMkh3?=
 =?utf-8?B?NUQxMjRDOW03TGdENHlwdFZyYlZJSXBYTEVJa0JjL01wT1hTdkNUM0dMRzNY?=
 =?utf-8?B?YzdkQ0ttZEhHakxlZjNrNE0vcUJsazhQZ1VSTVJWaXNVS0ttYlA0QjRGRWxr?=
 =?utf-8?B?dXpEUFVFUlJJMEh3UEpaQm1jTnh2b3JNTWV1K0E5U3RFOE00T0pVZWt1Qzdi?=
 =?utf-8?B?dVRjc0V2b1AzK3hDYzdaK1VBcXNFZFhvcjBycTlOc2dPekFlK0RlVCtrdUpx?=
 =?utf-8?B?eEdibEdrTE9rQUZyamtVM3czdjRTYlpCR1Z4Q1hHTEwxYmJJSUNGLzV6aVRZ?=
 =?utf-8?B?M2FOWVB1T0cwT25aTGhDZjhuZHZEMVhiU3M4OUN6YXpid3UxaDFhVWNDTnNU?=
 =?utf-8?B?VDllNHFvK3RodTZnWDdKM0lyQ2JOU0NOaE5CSVE4VmVzWjhyYm83d3BxUytP?=
 =?utf-8?B?Z0ZzdHpBTWxlUFkrekVHRkUwdW9ZbDhNeTR0VDNFZCtSNXNYbGRWZFdhS3dC?=
 =?utf-8?B?RURDc0g3UVRTQVpicEJib253dGRzSndaWXdUN3oyN2IvVExUYVkwaU9NVVRn?=
 =?utf-8?B?VndBZmdPZjdZR2lwM21DOFRDNUpDTVYzUGxIbklmQUVaV3NOU0tjaVhPSTY2?=
 =?utf-8?B?Z3VxdXZCWTEvajVSeHlubktMUENMSDZyQnBvTGRSNnN4UFZFYjZuVmFiUXVn?=
 =?utf-8?B?OG16WFNVN1B0YWpIRnN1WUJ1NE5hSWtVYU1sa2QzTGlTbHZVa05DeklyUGZX?=
 =?utf-8?B?OEVmWUFVeHc2Mm9aSmpNUEVQZW12Z0ZBTlVZSTUxby84Z3c4OS9QQTdvUUo0?=
 =?utf-8?B?N1N2dENXWW9WOXYzcEdaSWFsZXJTSHF6dDhiN0gycXVvS0kyWEYzZ0ZSN0FS?=
 =?utf-8?B?bWVYY3JpVHloa2V4M29oVnYwZUxZaEZiZS9NRER1bmw5aDVRY3BWRWozTUJJ?=
 =?utf-8?B?bEdBekJiL0lXeDkzQWM4MElFRWFMU081VVN5WmIyWU04NytIaHBhTFdNM0hG?=
 =?utf-8?B?bEhJR3RKanY5dnYvQlFOY3hwRTN4VHdYUkI3dEFzL2tVRzNVVVFQbHMzeEJj?=
 =?utf-8?B?VHNXbWhXNndBcnI4bWJwSzJ4ejRvWGJxOWhLejZObjBXeEJXZGcxWDZKdXVD?=
 =?utf-8?B?Vm10WU5meW1XUmF6MGpBV3NOSXJMYWZJMVFEVU13Wm41eS9lbEV2SlRyZGor?=
 =?utf-8?B?TSt4Sjc5M2Z3aEtFSUZuR3orVWhIdmluZHlKWjZBeUYvak5hd2NhOHYvSzE4?=
 =?utf-8?B?ZFdjNlpiOFg1VnJISzlrWkNhbXVnZnNJTGcrYWQ5a3liU1A4dGZYOXlGelZV?=
 =?utf-8?B?MzFPdURrNkxNOSs5aFJjUXZjQXlpdUcwYU9ISDZwOHBHU2E3OTV0RDBwTE5V?=
 =?utf-8?B?bzVCL3JGZGtxYXlmamV0Q3d4UURDREpZQ1BnNkwzbEhyMDR6VDNRT3BPVllR?=
 =?utf-8?B?OW91SUdFVFFwaVlnS3puUjgrY0FJUEd3RGhTTWV4b3o3ekZZNWJMUkpxUVlX?=
 =?utf-8?B?amRhY0MrYWdTQnp0WWNQRFFuK1g3V2Q3b0dZZC9KWCsyRG1Jc2gyVnZFYVVh?=
 =?utf-8?B?Y2M3RWFQaGFXNDNrK3dQM0NMUHNYYkltWExQMUpjUmxyNVVIdjBGaEJRQWxP?=
 =?utf-8?B?K2pEVTh2WFJnZ1VpWnBrSkRTa1dWcU1tUnFEc1NMdWhEcUZmazlucFpyY21v?=
 =?utf-8?B?U3hXZDBuR2ozYkJibkFHZ2NJZ3MrcWlrUG52c3pCd3hzZFN6amYra0pBMldZ?=
 =?utf-8?B?WW54ZVFIRjEyNWx0ZkJqd0ltaVJsVXIzajdRVng2N1FyV3VTa2hkUW4xTkhw?=
 =?utf-8?Q?H6CRf1NUDPZIkOuj0ChQ0Gwul?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hn5vZbPBwWKxHTGSeDS7kNv//BgHYhX7xvfRnUQEb/yyuwpUduzMuAj2L0oy8axAlMYGyf/SOStQK5rJiRimF7Lqc8pyi77giFusS50W2OViWBl7ce0gnfpUQH1akhPSolA8KIWe8HmEL0Bo0YK9IopUIRKo1XovJpA2dFmEOp0nFa5PLH+ksyLF5nDS1zRwGUsZ18laB1ZB8BVuhduEVurDYpgHmAsRd1jaY7iMCG2ZEi1/i+iNkBFIo9JdQuOGMxDdlOo1zUGmTWz2IsWGA3gUYvAMnMY30e03MOAign17Ke+c8h1qET0WbXeos9+gLeOeyY4/vMyaKecinrs4MzCyyrNyYOtkq4IwkQuu6JortrdWkODQFgj/ROZ1RSpyVylItJ5FPHoqBkZ9e7ecXHCxUvNZIo8+TJqVye3J2gP819i1u+CDsm+jdQYnUDBnNqfzX+ocmQTzvMNgUTV3z435lZsZ36UpyT4f7zJSYK3dxWxcHYB514Q3mY5xlAY4fCx958ZJheXK1kw4gQ+V2CaYO2BerhCXnFZjFoQj4GpivZ5XuHT34tItzds1FDeH2B+ReWAmrnZnnElgcEPEx9FHxH2ZCwL+Ji2DO29G/xk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a002dc76-7cc9-48bb-4ce6-08dd5c28a24b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:59:34.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K287inGQ9EabxevjTrx0BzKBIZz1xeCIH1GAqapDCGWBUUqOaTFoEWsQtaHQGDAIAHdQ4eGcGbTJ1HLYpsVIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050161
X-Proofpoint-ORIG-GUID: RftBkMYi0RzII2epG0lVFqhkcUoRB-UH
X-Proofpoint-GUID: RftBkMYi0RzII2epG0lVFqhkcUoRB-UH


On 3/5/25 12:47 PM, Dai Ngo wrote:
>
> On 3/5/25 8:08 AM, Jeff Layton wrote:
>> On Wed, 2025-03-05 at 09:46 -0500, Chuck Lever wrote:
>>> On 3/5/25 9:34 AM, Jeff Layton wrote:
>>>> On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
>>>>> Allow READ using write delegation stateid granted on OPENs with
>>>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>>> constraints).
>>>>>
>>>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>>>> a new nfsd_file and a struct file are allocated to use for reads.
>>>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>   fs/nfsd/nfs4state.c | 44 
>>>>> ++++++++++++++++++++++++++++++++++++--------
>>>>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index b533225e57cf..35018af4e7fb 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation 
>>>>> *dp, struct svc_fh *currentfh,
>>>>>       return rc == 0;
>>>>>   }
>>>>>   +/*
>>>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on 
>>>>> OPEN
>>>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>>>> + * struct file to be used for read with delegation stateid.
>>>>> + *
>>>>> + */
>>>>> +static bool
>>>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct 
>>>>> nfsd4_open *open,
>>>>> +                  struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>>>> +{
>>>>> +    struct nfs4_file *fp;
>>>>> +    struct nfsd_file *nf = NULL;
>>>>> +
>>>>> +    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>>> +            NFS4_SHARE_ACCESS_WRITE) {
>>>>> +        if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, 
>>>>> NULL, &nf))
>>>>> +            return (false);
>>>>> +        fp = stp->st_stid.sc_file;
>>>>> +        spin_lock(&fp->fi_lock);
>>>>> +        __nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>>>> +        set_access(NFS4_SHARE_ACCESS_READ, stp);
>> The only other (minor) issue is that this might be problematic vs.
>> DENY_READ modes:
>>
>> Suppose someone opens the file SHARE_ACCESS_WRITE and gets back a r/w
>> delegation. Then someone else tries to open the file
>> SHARE_ACCESS_READ|SHARE_DENY_READ. That should succeed, AFAICT, but I
>> think with this patch that would fail because we check the deny mode
>> before doing the open (and revoking the delegation).
>>
>> It'd be good to test and see if that's the case.
>
> Yes, you're correct. The 2nd OPEN fails due to the read access set
> to the file in nfsd4_add_rdaccess_to_wrdeleg().
>
> I think the deny mode is used only by SMB and not Linux client, not
> sure though. What should we do about this, any thought?

Without this patch, nfsd does not hand out the write delegation and don't
set the read access so the 2nd OPEN would work. But is that the correct
behavior because the open stateid of the 1st OPEN is allowed to do read?

-Dai

>
>>
>>
>>>>> +        fp = stp->st_stid.sc_file;
>>>>> +        fp->fi_fds[O_RDONLY] = nf;
>>>>> +        spin_unlock(&fp->fi_lock);
>>>>> +    }
>>>>> +    return (true);
>>>> no need for parenthesis here ^^^
>
> Fixed.
>
>>>>
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>>    * clients in order to avoid conflicts between write delegations 
>>>>> and
>>>>> @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation 
>>>>> *dp, struct svc_fh *currentfh,
>>>>>    * open or lock state.
>>>>>    */
>>>>>   static void
>>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct 
>>>>> nfs4_ol_stateid *stp,
>>>>> -             struct svc_fh *currentfh)
>>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open 
>>>>> *open,
>>>>> +             struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>>>> +             struct svc_fh *fh)
>>>>>   {
>>>>>       bool deleg_ts = open->op_deleg_want & 
>>>>> OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>>>       struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>>>> @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open 
>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>       memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, 
>>>>> sizeof(dp->dl_stid.sc_stateid));
>>>>>         if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>> -        if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>> +        if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, 
>>>>> stp)) ||
>>>> extra set of parens above too ^^^
>
> Fixed.
>
>>>>
>>>>> + !nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>>               nfs4_put_stid(&dp->dl_stid);
>>>>>               destroy_delegation(dp);
>>>>>               goto out_no_deleg;
>>>>> @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, 
>>>>> struct svc_fh *current_fh, struct nf
>>>>>       * Attempt to hand out a delegation. No error return, because 
>>>>> the
>>>>>       * OPEN succeeds even if we fail.
>>>>>       */
>>>>> -    nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>>>> +    nfs4_open_delegation(rqstp, open, stp,
>>>>> +        &resp->cstate.current_fh, current_fh);
>>>>>         /*
>>>>>        * If there is an existing open stateid, it must be updated and
>>>>> @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>>>         switch (s->sc_type) {
>>>>>       case SC_TYPE_DELEG:
>>>>> -        spin_lock(&s->sc_file->fi_lock);
>>>>> -        ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>>>> -        spin_unlock(&s->sc_file->fi_lock);
>>>>> -        break;
>>>>>       case SC_TYPE_OPEN:
>>>>>       case SC_TYPE_LOCK:
>>>>>           if (flags & RD_STATE)
>>>>> @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst 
>>>>> *rqstp,
>>>>>           status = find_cpntf_state(nn, stateid, &s);
>>>>>       if (status)
>>>>>           return status;
>>>>> +
>>>>>       status = nfsd4_stid_check_stateid_generation(stateid, s,
>>>>>               nfsd4_has_session(cstate));
>>>>>       if (status)
>>>> Patch itself looks good though, so with the nits fixed up, you can 
>>>> add:
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Dai, I can fix the parentheses in my tree, no need for a v5.
>
> Thanks Chuck, I will fold these patches into one to avoid potential
> bisect issue before sending out v5.
>
> -Dai
>
>>>
>>>
>

