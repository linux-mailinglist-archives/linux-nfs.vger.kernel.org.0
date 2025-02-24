Return-Path: <linux-nfs+bounces-10318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B774A42F4A
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 22:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5B83AFB9D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 21:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17A19F48D;
	Mon, 24 Feb 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owWCy1XT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ABavOERH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF8469D
	for <linux-nfs@vger.kernel.org>; Mon, 24 Feb 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433143; cv=fail; b=l+I5scb2LkYMea5ezbsc2ly5AE5YwjGC/vF+mcw/8F1g8YijsU7SmD0uxxbrpLuyf7PtKQi7Fagr2OY3P48SuhW/TUMbSVS4UuqpjL/dReaZJZcHESSvQqauf0kd35cQ8wDpLJzon8Rvd7KmCIy5HMXkkUPVQhE9/vGsPk5wHp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433143; c=relaxed/simple;
	bh=zMDMexjsjE25Ob/ZQnQjN6tBmj2oXNpugeLTg4Yof+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BbFc0v1yP9UzpQ1p8O51Mw6D4NTNYZubiiIjV0qccA1LEEgpOQsl1cJlHx3g73tYf8uPoNVS1oiTwqgjMgxwhsbZ1KZ8eE5DmDQlJ1JfgpK0kcyZqucRBAsRFlmLojLM8twKg9bylMD2zBeZoRHnZcKn+KQgNdHjWXFxfCot/bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owWCy1XT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ABavOERH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OLMet6005488;
	Mon, 24 Feb 2025 21:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N2KDjuzwuzDGXROcFdzM9oWa+e9Dd51JZx3m8hKpWe4=; b=
	owWCy1XTwKbxvkNrB4HEGfhzQNyxgRlEC9Mm8wR1lu/5NIzl3xrsaPeyK2Lu8bS5
	TTHLPGPPUfycelgdxnobW9KjqKVqu489i37poWSgwdwNmnNLM6NoFg/Txm9Y9hk4
	Ml49SwhYDPIMojnE3gnaULXdwnOUuWvz9zNrkKusZEQ/rC/wKAHYwGg5M+IF+gg4
	NdT+Up6kAsMKGP7XcxlFGx0yH1QJ8IHTIEwsB03SGa82a5nVX2KLI88RKpzkmu0z
	DLGaNWM+cQUwm8mdK1m+UNTO19JNReXrQGFAO2Hnrl9pTeF6LbBNphOTRYu1ZvFw
	Nsb0wr5CmmeJn6tFBL608w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t3n72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:38:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OLYYvl010297;
	Mon, 24 Feb 2025 21:38:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5181t6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 21:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cykt9pvlaRQCHzIPSdxdTtaOo13G8rSE6Es/yAiWDqz6gSZI/PCyc3M/xYStqf4yZF9VrQZY9umH79uDEVK/O93h6Ocd9M/zaBXIPGlgNVUhwM/qaIZC3nmSKds7I2cyi8Odxkyi98PfHcTLUQ9WSLEsjMvXrUyo8jA9kCFxikwa5xbAJP/12O8m/8W+s9oY+ZpiUUBjjALkKwMo1/zilTukGxie6MHDY3Ou3P0nLphyQWnx8drmxTM3J/bfVo+5+zlBMsSg1J94QDYpB/ZJOJiB7bOGyz6tdfGJ/ltufXmYBziXTIRSDEsmToHFk8Lnahd2ZNbjwqNlFzN68vqWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2KDjuzwuzDGXROcFdzM9oWa+e9Dd51JZx3m8hKpWe4=;
 b=oLuusChdYQRWtDpqPFs+Ouuiv6wyblT+EneVU7n9Baqf3sxysxn/pgSwcyUSxPaT1D28F9c1ZqtYulw6h6szU7zRnAfLnDjSTs3hGayQfJ+l7XDLoXXbITmBVvpVzTRsGUUiWiBoMaG+OSSeS8CfqxGIao6UIwuK5WwQgiu8DFuMpoVk/bZpYjmPY4JFi6Q1AKprCyRcTm7fLN6NEdNE2uOOkjt2cwXv3PyyvrfS8jqnk64Eipz8Dzl4mdk1m7KybWY9wrCvv2D+IsBpLXS/4xiNarqZ55Gxut9Ybwzmk857agpqPOWIw3Cc2Zn2nwoKvwLeAUvUHwEHsdFADJr/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2KDjuzwuzDGXROcFdzM9oWa+e9Dd51JZx3m8hKpWe4=;
 b=ABavOERH7HIkId8B6/lUi6VS4RhPE8SMv9MMT9GAJyXU2PBKhN9ce8woo7WsE2FEfQo0jaRyzdscej+vSc6pV2o2f2hhE1WlLhAXP8J+QBD77SDmjdvLPCwqOpmAnqIlQgmSdV6dEGHizD4UK9YfZb+IsCle1PA9ML+ncX+xjUY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 21:38:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 21:38:40 +0000
Message-ID: <30684796-eca0-4499-8b27-33edf5a8376b@oracle.com>
Date: Mon, 24 Feb 2025 16:38:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
 <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
 <4d607c89-8500-4d4a-ae42-09987b16e2d0@oracle.com>
 <34b7aa6a-e315-4fad-8fdf-1799feecb530@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <34b7aa6a-e315-4fad-8fdf-1799feecb530@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:610:57::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0582627a-fe1d-48ae-4569-08dd551b9a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THVTSXp1cFpxQmxUNm1pYkR0bElWLzZ1Q2pxcmJxb3JHVHV0YVRFOCtqVlVm?=
 =?utf-8?B?ZXdRR2RKdkQzRVVNWndXQ2YyM0dIZmRpQnhpM29CSEJWMXhrUW1LOEtyVUVG?=
 =?utf-8?B?RUJRM3NRakEzUmFTNDVORFUxOGpmWXcrd0JHaEFYc1dXaUJYZzNpM1FDaklt?=
 =?utf-8?B?S1BYdis2VytRZjRKY1c3WWFDdndocEZZcWNUcjIvRktXZWlWLzRDQ0F3cEFD?=
 =?utf-8?B?UFZPTjlmQmFhRmEyNTMyUUNSNXYwQW9KUTdkNzZ2NllFKzNVZ0RGaVBuUzll?=
 =?utf-8?B?eU1uVERHWXByTGRlVjJrRDE5R1lYdWZna21HS3BVNHlMUXVpUUJ2YVFjWGk1?=
 =?utf-8?B?SVN5KzF3Lzg3aGZBVUV4aHkrMi96SmpZcnBMalByQU9sbXRMMkovZWlDelUv?=
 =?utf-8?B?MU1ZczViMUd5RU5qOXBqRkxZTGJYQWhGV0orcFhlRkM3L2dUV1R5ZlVLdnZE?=
 =?utf-8?B?MGNNNFduWDZkUUdXTUxtbWVYNitUbEg0ZzRwQW5Qd1RPdWZnbG16OTRuMGFO?=
 =?utf-8?B?Z0I5a2dBbEdpTjhwRkpXUEtCNG9Zcmg4YUlqOVRSakduTmlOMzRkSEpYbDRO?=
 =?utf-8?B?QnBuOFJBMlBMcjJlbW85MkQ3b1VKUllWMFI5V2hzaSt0Tm0wa1hqeitRRUJx?=
 =?utf-8?B?SkZISUlUN3ZWUjYzVnpFVS82NTR2akwrdnh2U1FLcFFiTGNtenFCOW1kSSt6?=
 =?utf-8?B?dWtmT2l4OE5oUHR4Y28zMGpIT0VzK0NhSkpTRDJEbytDeGdYcy9PNlBRTVp4?=
 =?utf-8?B?dkdBc1FtamxRRk5KSlNpRkJrUXlTeWFqZ0ROdTI2dVBUSDlyQ2Z1Sk1sSkk3?=
 =?utf-8?B?NUxpSk5HUlprZmpIeVFrdkpKQWNkcmVNdk4zc3RMNWZHTEFpUExHdWdjU3Nt?=
 =?utf-8?B?QWFNWWpBODllRlhxcTFOYnNLdUVEQ05sYTY0WUJrYnhsSlp2Wm90ajlYQUtU?=
 =?utf-8?B?VHl5a0VWcHZOQVZvZVBMemFKTWRwdGlwNWp3WU0ybGl6bGVPNXM2eG5sMVd3?=
 =?utf-8?B?SGRsQ05aOTViNGY4WWVGbEl3TkVhRjV2TkRvTUw0MVRqZW1zMm5rdWNnbG5j?=
 =?utf-8?B?V2N0ZXpucGxkT3FXWlhhTHRMSTJiWnIzUzd3bFBtSU9LdWgyeFU1MjN3eVVP?=
 =?utf-8?B?NE9BWkdMUmgzYzBNZ2pqSzdDd1VaV3ZTa0RHTHcxWXJMZUdpWXBJSXpSTER4?=
 =?utf-8?B?UHh6d2t3bjF2R2UyZnBUZ2JQR1pyZk1jVlo3RmhodjUzU1JnWGh2WW9pUlJV?=
 =?utf-8?B?QnFrdGFzMm1vOFJCTk1mayt4cVo2K01EK1lNaHVoVCtaa0wyTXdpMXlPUEkr?=
 =?utf-8?B?bUZmK0p4aXhha0U5eTFDS1lTRy95SDA4Znc0Z1hVbUZJV3RMYTB2Y1V4MEJm?=
 =?utf-8?B?RGthWjJDTWRwZGhjcHQvU01jR0k3VnIzbzBYSCs5SmdGWGJkTWR3bzMzbGtv?=
 =?utf-8?B?ZmdCZFBzNFBVUk9VMFEyVk9hcDdFdVpDVjByVVZuQVVOU05xR3BHRDNYSTgw?=
 =?utf-8?B?L3p4WXBTWEFCN1U2SnpvY2VKMWFxNDR0WGx5ZW0xNUw5eVZSSFFrNXFxN2RN?=
 =?utf-8?B?NUdtcWNvTVB6UWt4cHFWTjhmbFNwS0NLcGVuQ0J4OUh0M1g4UldJVVRQR0FK?=
 =?utf-8?B?dlI4SXBwVmszb3p6ZWc5ZWNsYVBOZlBWOFVaNC9tWHpRcmZ6Q2VMZjZ0cG1h?=
 =?utf-8?B?eEo1ZVdkZXNtL0ZRaFZiNkR2VDB5ZHI4TnVUUzdnMjlVck0vU0tFajBtbFRu?=
 =?utf-8?B?UU4xaTU1VldRVCtseDFjNGFCekpFZGlPUVdzRFRWbFlRSVpiY0txcnM2ZmM4?=
 =?utf-8?B?YWNNU2xMVUFvcnJSOWVsREdNMVZBOVU5OEVGZDRuRFVjejVRVkQzUlRVdW14?=
 =?utf-8?Q?u0NThD584h5S8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0tJcURJeUJyeHY3VkZPRDkrditpVlI2L1k1U2ZscXU2VnNzVzdCN3ZJZm0x?=
 =?utf-8?B?M1ZKbWRsdGM1MHA0QWl0R0xpQm12M2NuZW5YQzE2cWIrYjA2dHU2eDZLaVJp?=
 =?utf-8?B?ZFdVT2FYRUtORzJpaTg0Z1ZRVmhyRzRDcnAwVkc5QXcvQWl2QjRubTZGK3JJ?=
 =?utf-8?B?anJ1MWxFWGF5UGQycTB3RndhaWZRMThKVkpKRGtJUURjeTNva0N3cDBlQUxZ?=
 =?utf-8?B?Q1JZNXRET1UvSXBscVVNRXY2Z1VvL1p6eTFFUFA2T1Ryb0M3ME9Tcys4d0xH?=
 =?utf-8?B?cXNPcmdhSGhEbmFmZVNUb3U5NE4vN0cwdFRlaEZaaWdvM3piUnBlWHN3Z3E2?=
 =?utf-8?B?bys4NG5EVDZneC9EaVI4ckxaQ3VzMlZYMkV5aDN3VXl5bEhmN2htUmV2TTRa?=
 =?utf-8?B?VDZFRTZEcUlhcUlUQ1V6TURaU091dStNelVwUjNWcTVyV2svM0RhOUhzQmVP?=
 =?utf-8?B?RUJ5bllTa3ZvR0taZGZ0VnROUERrbXExdXpPSENXN3laeUZlZWNtK1pidFpT?=
 =?utf-8?B?Yk5MbVduT04zRlBQa091TEVjNGFHWVZydkMxRC9scTV6UUFQdFVLKzZKTDcv?=
 =?utf-8?B?dk1ublprNHNTZUx1ZGtSeWZTcEp5OC95N1FRTTZNc0tKQ1VLblE0enVPNG1n?=
 =?utf-8?B?TzdZMFEwSzlBYTBDY3hGd1IxZUZ0Ni9CK0syNDZGNTZJTjNiRFoyYmp2eUFq?=
 =?utf-8?B?T0RZeThwVEpTaStESWNDbUgxK0VmWHRwQ0Z3bEg5R0Vza01uekxkZGVvb1ZV?=
 =?utf-8?B?ejY5cjJSR3Z3SGNUZzZ2czZIeHpvK1N3TUhPVUQyWG5HL3kxODRTbjEzeHkv?=
 =?utf-8?B?V2pwcmtzak1zeE9MM2xqU240eHVXNkpwbmZHMmdMZ1ZySGNEdVJuVVl0dG1k?=
 =?utf-8?B?R2tEa3VxVHRSMXg0aUxMZmdja1hOSVd2RzNSWjcrczFlV3BxRCtrK2R6Tmpm?=
 =?utf-8?B?c2VkT2NYalQwanhqeWhuaTZOS0pxV2lOVUIzNUw3WHVCQXJjTXBleGdmYjVk?=
 =?utf-8?B?ek0vOGxOelg1cmhSTHplMXdPTmNBQzVPRndaVWZ5cWtYZDZzRmgxSlhpYkxj?=
 =?utf-8?B?bTk3UUVUNnNPZGJaVUZnWHUrQ1Z2d1FNOCs2dVNjdHhOL2hITVR2QlE0WFR2?=
 =?utf-8?B?bEJ2S0VZM3ZyeGk2VFZMeXAyeUZzUkJMMmlQeUVBeERyTjFtMDh6eUtpcXdo?=
 =?utf-8?B?RDliWWUvNW41dEY3dGNxQTFMZk5mZ0tpOHFVZFFOc1ZvckRQRUFmOFBSaEo2?=
 =?utf-8?B?enQwTEI3L3doai9XM0xJaEE4SDZsR2FHVzJVc1VXMkc4M096VE0wOG1LeEww?=
 =?utf-8?B?UzFpa05tQXJKdmo5MlEzZFlrZUlLRjZGUWRDYXBLWk5jRHVvNkRHcTJyOTIr?=
 =?utf-8?B?eXhoMDZZSVdtRGRxUlFyYUgyZ002YWtOTGtkVmJVZUlRWUdISks0RE5vODdW?=
 =?utf-8?B?S090dmw4TGgxd3pnSDRXU2lKdW8yNG5Ua2prUng1VHE4a3E3cC9QRGVXOFYv?=
 =?utf-8?B?Q1EzZzU1VGRub21UVjVkTjBpRUdUQ2pvNXpNMWNkRjJUVWsyUmRRSWxKMUVX?=
 =?utf-8?B?VHVHNzhISjdQVnhRQ0toZFUyNEhwQmxzMUxIR2gvZ002S1FpTHJwMjBnMnR1?=
 =?utf-8?B?L2pXV3dyRWd1ZzJhNzNoSnd1ZUw0V2hhMkRGNjR4RndwOXgzeE9WK21RQ2o4?=
 =?utf-8?B?VGZKSTUvbzdRU0JQcjd3TXNEcG5PVFZjV0RmNzdOTjc0TWJOWk1CMStsd0ZC?=
 =?utf-8?B?U3FmNDlSOElwV0E4WlNuMDRHT2t0dGtocTNWS2p3cVprRnltcHdFNXJlS1lw?=
 =?utf-8?B?NHQwNDU3N3MrTHNlRXY5MkQyOFcyNFhtUHhqMFgzdXZrbjFHR2xyRWVIcnBR?=
 =?utf-8?B?WGNBc01Mb1lVSzNYSTVLNzlWWjN0S0kyWUpBL1ZMbGRDSXM3U050SkN2RWxs?=
 =?utf-8?B?OUo1Q1hkcitTdVQ1UzZ0dVd0R3lSbXhDS0laVytRVEV2ZEhOT1NQc3hTS1l2?=
 =?utf-8?B?SnBvUko1ZWVFVTVpREllMmgwZnFzdWZmM2NmMEtPZXhEaWpISEluUWc4cGJi?=
 =?utf-8?B?M3Z0NUJjMzNicFJ2NkJCbkRoeTVWTHBHU3lXQXIwczBFT0p5VE54ZUVVVENO?=
 =?utf-8?Q?6KRPRlBzxJII8XLaf3dElFWZV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jjbZVDXU2JbyEwOQP08egLb133tDeJRGyrPfcbVKPdHs4rOx1r45pvR3EHsrAgzN+FBbMVMn4NCYkuPm1R1/s5K79iJAKLOe4UaZlNul3Ks0MLerz8nvvxRZshjIwni+W2uVf1eogxO1/9gr6Pm5x7eEUvXszc7vujiOHvKOwBZLU8jmPSxegk1bCSVz4sr5RmXZLG6UFlx2+TYWwob60JVpL7558b41Q87+0YVeJSnUwVQJ1zu/vScqa04Jn5oC/RDC37v9qd+DJHl5qMbYQ2wOKE8jCrW0cipM60EqcYbsvZ3ijFMJu58hBIDK55COfVQGIwboDyxdAzfkTaVhF+mCozxRafrlft3aB8r1C20P/I9i6ojHeojcYf8oujrC9qK1t+5TH2ugJk/ITIK0vwYYki1IaKLGNQoHEXuE2tEEiC6Lbmvl2Wivk3XMKUMbdbSLErFJ6/8BwftjlDLq6Lbw/Pc8+o26csFsNJ3VIOx4h6nvQnqbXP9eZl2gkUqKJ37QHLxn7cN5F6MYL/U8feHxEAiIuVoB3B8FVUjUujo/fuZUVGvT6nptM87uP6RwpnPOOUXyztUsa4bGHvtXQx5TRyodgf/eTKEddiuzIWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0582627a-fe1d-48ae-4569-08dd551b9a82
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:38:40.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ5rSG9jUHQPmqzC4NDLWVtFHaHtjubVzoMYl5rMgQs7yRy8UpnOqupiK3SBqq1MeoumdNey5LqplkLMtbweRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240138
X-Proofpoint-GUID: SnQJEwDXXMrzsE__vtRbKc4inIgdO1HU
X-Proofpoint-ORIG-GUID: SnQJEwDXXMrzsE__vtRbKc4inIgdO1HU

On 2/24/25 4:11 PM, Dai Ngo wrote:
> 
> On 2/24/25 6:48 AM, Chuck Lever wrote:
>> On 2/21/25 6:42 PM, Dai Ngo wrote:
>>> Allow READ using write delegation stateid granted on OPENs with
>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>> implementation may unavoidably do (e.g., due to buffer cache
>>> constraints).
>>>
>>> When the server offers a write delegation for an OPEN with
>>> OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
>>> and nfs4_ol_stateid are upgraded as if the OPEN was sent with
>>> OPEN4_SHARE_ACCESS_BOTH.
>>>
>>> When this delegation is returned or revoked, the corresponding open
>>> stateid is looked up and if it's found then the file access mode,
>>> the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
>>> access.
>> I probably don't understand something. The patch description seems to
>> suggest that a WR_ONLY OPEN state ID is also granted read in this case?
> 
> Currently nfsd allows a WR_ONLY OPEN state ID to do READ. The access check
> is done in access_permit_read:
> 
> static inline int
> access_permit_read(struct nfs4_ol_stateid *stp)
> {
>         return test_access(NFS4_SHARE_ACCESS_READ, stp) ||
>                 test_access(NFS4_SHARE_ACCESS_BOTH, stp) ||
>                 test_access(NFS4_SHARE_ACCESS_WRITE, stp);       <<====
> }
> 
> Is this behavior intentional or is it a bug?

RFC 8881 Section 9.1.2 makes an exception for this case, so not a bug.

One assumes this is to permit clients to perform RMW, but a comment
above this helper would have alleviated some confusion amongst us
software historians.


> -Dai
> 
>>
>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4state.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>>   fs/nfsd/state.h     |  2 ++
>>>   2 files changed, 64 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index b533225e57cf..0c14f902c54c 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation
>>> *dp, struct svc_fh *currentfh,
>>>       return rc == 0;
>>>   }
>>>   +/*
>>> + * Upgrade file access mode to include FMODE_READ. This is called
>>> only when
>>> + * a write delegation is granted for an OPEN with
>>> OPEN4_SHARE_ACCESS_WRITE.
>>> + */
>>> +static void
>>> +nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
>>> +{
>>> +    struct nfs4_file *fp = stp->st_stid.sc_file;
>>> +    struct nfsd_file *nflp;
>>> +    struct file *file;
>>> +
>>> +    spin_lock(&fp->fi_lock);
>>> +    nflp = fp->fi_fds[O_WRONLY];
>>> +    file = nflp->nf_file;
>>> +    file->f_mode |= FMODE_READ;
>>> +    swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
>>> +    clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
>>> +    set_access(NFS4_SHARE_ACCESS_BOTH, stp);
>>> +    __nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);    /* incr
>>> fi_access[O_RDONLY] */
>>> +    spin_unlock(&fp->fi_lock);
>>> +}
>>> +
>>> +/*
>>> + * Downgrade file access mode to remove FMODE_READ. This is called when
>>> + * a write delegation, granted for an OPEN with
>>> OPEN4_SHARE_ACCESS_WRITE,
>>> + * is returned.
>>> + */
>>> +static void
>>> +nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
>>> +{
>>> +    struct nfs4_file *fp = stp->st_stid.sc_file;
>>> +    struct nfsd_file *nflp;
>>> +    struct file *file;
>>> +
>>> +    spin_lock(&fp->fi_lock);
>>> +    nflp = fp->fi_fds[O_RDWR];
>>> +    file = nflp->nf_file;
>>> +    file->f_mode &= ~FMODE_READ;
>>> +    swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
>>> +    clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
>>> +    set_access(NFS4_SHARE_ACCESS_WRITE, stp);
>>> +    spin_unlock(&fp->fi_lock);
>>> +    nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);    /* decr.
>>> fi_access[O_RDONLY] */
>>> +}
>>> +
>>>   /*
>>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>>    * clients in order to avoid conflicts between write delegations and
>>> @@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open,
>>> struct nfs4_ol_stateid *stp,
>>>           dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>>           dp->dl_cb_fattr.ncf_initial_cinfo =
>>> nfsd4_change_attribute(&stat);
>>>           trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>>> +
>>> +        if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>> NFS4_SHARE_ACCESS_WRITE) {
>>> +            dp->dl_stateid = stp->st_stid.sc_stateid;
>>> +            nfs4_upgrade_rdwr_file_access(stp);
>>> +        }
>>>       } else {
>>>           open->op_delegate_type = deleg_ts ?
>>> OPEN_DELEGATE_READ_ATTRS_DELEG :
>>>                               OPEN_DELEGATE_READ;
>>> @@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp,
>>> struct nfsd4_compound_state *cstate,
>>>       struct nfs4_stid *s;
>>>       __be32 status;
>>>       struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>> +    struct nfs4_ol_stateid *stp;
>>> +    struct nfs4_stid *stid;
>>>         if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG,
>>> 0)))
>>>           return status;
>>> @@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp,
>>> struct nfsd4_compound_state *cstate,
>>>         trace_nfsd_deleg_return(stateid);
>>>       destroy_delegation(dp);
>>> +
>>> +    if (dp->dl_stateid.si_generation && dp-
>>> >dl_stateid.si_opaque.so_id) {
>>> +        if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
>>> +                SC_TYPE_OPEN, 0, &stid, nn)) {
>>> +            stp = openlockstateid(stid);
>>> +            nfs4_downgrade_wronly_file_access(stp);
>>> +            nfs4_put_stid(stid);
>>> +        }
>>> +    }
>>> +
>>>       smp_mb__after_atomic();
>>>       wake_up_var(d_inode(cstate->current_fh.fh_dentry));
>>>   put_stateid:
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index 74d2d7b42676..3f2f1b92db66 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -207,6 +207,8 @@ struct nfs4_delegation {
>>>         /* for CB_GETATTR */
>>>       struct nfs4_cb_fattr    dl_cb_fattr;
>>> +
>>> +    stateid_t        dl_stateid;  /* open stateid */
>>>   };
>>>     static inline bool deleg_is_read(u32 dl_type)
>>


-- 
Chuck Lever

