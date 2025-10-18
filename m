Return-Path: <linux-nfs+bounces-15370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145FBED8A2
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367C43A3D2F
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A061DE3DC;
	Sat, 18 Oct 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BishT9ST";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5uqbDEc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB71F584C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814949; cv=fail; b=HMbJwswx1fF9J5mJ+5ry18/UOo17tHvTD7a3iHWpHQehLXi1hs7iojV8VvgUbpyuGrllFFN3kRH7A4Q8QQ9d40Yv2O3upFO/Ybya4GbdGX32kZhGaUSumMs+hCuDuWgGjA05zkjyLJueSgzEup9f+YKNtyf9F2OO+SpD74L2HaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814949; c=relaxed/simple;
	bh=DpAKV5DhuGyWzbB6HaM8HSh1SaHVXNaeaVKA0/S8Nvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pn4zoZODDH/StzisK1LrVKfdZenFCsIWNK8k2z2BbCuraA35XOPvetWSjPDMWkouTDUwgAp8RUlfeyKhCq9S1I26ifzBhI2b4WI/ksGfSW5egYSIZvhjA3dGk2IRgEQxkfKvdfmaIO3dT9ZwK3bjWSThKHBpAVq02hhW91Z2V98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BishT9ST; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5uqbDEc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IDkmW7005122;
	Sat, 18 Oct 2025 19:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xDRw372jnJRHsE59Et2o3efbLZn2DEE3J/ksM/Q4MNg=; b=
	BishT9SThhhm3jNUWui7SiqVdfzx6GeHNVg1ajpkYUD6HFH1ps67wLXp0kMWbJWg
	F+C6CC2bpUpvo785/NfB9jJovqdqcJpumM1xuws/BVOTnDCJvNYgSVAy1+MiJoTQ
	7HpDWaPpixYHADRhxs1hVVWeyw5XpdIbFxnoWJHp7bQiLoEimzlPjDfVeS39gees
	elMY7cpc0kYl2WEYy/YjSZtTrKq/o2/DHEVJXnLeYfoP/jDQDlE/GnFOoxR9yArE
	8NG7OJpVoZAD70dPBIoS69f73mUnJK2NUhSmwCgqP2ZRHUWA+RvhjDtaF/L2e7/N
	5HwBLhKqhb5s1QIvqdEJug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3070fry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:15:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IDf8HV013144;
	Sat, 18 Oct 2025 19:15:41 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9fc0q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyy8vGQ2iIsRlI92NQwnsSZzfWiS8+l7uIg/imv7D0Oo7ULrHwXD/O3pbQqShmUQy/Dbkv68MLW9EhsbhEa7JklAIgVo11tSGvs+oPVUOh7QlBKIDQxOxcQN+y3hjiiIQHhE6pKjY/ud454oQKOnXtN6rxFzsmY8SkM4nKOn5GRE4eHWZ33REQC1IpoXJOvVy9Hl1HHxDjfWWyO6G0DQVS/FF3FOwjNK5LSQdsNcmaaSMm0xLZ9bHqMiuZ0WA4i5fwqbZg2xJLqxlqtgZHIa2A6NRseZDtCsiWDYaOk61hrfhNdUbOPO+cBWCoTop8J59gnsMCsWWJ8lxVrZI0v3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDRw372jnJRHsE59Et2o3efbLZn2DEE3J/ksM/Q4MNg=;
 b=y2ZAnRY7BeXqN/tRYxNF+j1574iCnGB8/zZ6CO8oWHVGO7V8Ba7VKTXkhIETg9yu6eVaCRu/q0JmWQR8r/IGIYsBlKitMnNh2gpK0oVYjpcjdIPvbamY264HoXQYUtT/0+Hx8x1L4leX3jTj62fJKNv4ijGQ+bPuLHEdqyobzHFYGAsdg5QWpgzErR5R/OCRP0Q4BoSh/PC10OVwQvpTYU8vSD3ygqPy+PBxwQPf4TsXSKpKM4muwaPrIOG4Vs7kdGrna1Ow/nUpA6V6z7C7i2IvlNqIGDe/IVvmAfs+7FY2lUj4FoDoP3Ak/V+TtWAwCP6NDMNunxE873NS7a82eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDRw372jnJRHsE59Et2o3efbLZn2DEE3J/ksM/Q4MNg=;
 b=O5uqbDEcJI0J+LosibaziJFArS/jFm1o/DZSjFuW8rBaYTcDGnrg9k3nExkZV1afzkwxwJWFC0kPaI2gFGTus4bVRrGvhmoMhdoFgqyam38/dXWFZgAnWChYKwRARSmP+zAk39b5YCtm0dbBZGuV509ZuLRfdGn0GjYMA+0KxY0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 19:15:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:15:37 +0000
Message-ID: <097f1be0-2386-4d8a-a774-d4fef5f28b3b@oracle.com>
Date: Sat, 18 Oct 2025 15:15:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] nfsd: use a bool instead of NFSD4_FH_FOREIGN
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-8-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-8-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:610:54::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: cccda91c-7168-4460-f996-08de0e7ab876
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YzdxbllJMUF1cVQ0emJQTDB4aGpNUFgwVmh3OUEzYkRyMWFjR0RQdWg1ZXdp?=
 =?utf-8?B?VUVsY2FBSy96d2hHMURFa0lNbHFQNjNSVFM4ZllLemNzMDQvaks5c09RaVpw?=
 =?utf-8?B?WTRMZnhpcWJob200QXl2QmdJSnllbEVrSndFbjR6QTdzR3pHaVN0enRqNGFa?=
 =?utf-8?B?K1VoUGNRT2w5bHFONlROUVU4Ymx6SUNOdlg4RlB6MHFxYWZ1TmtGNjFkZ3lO?=
 =?utf-8?B?b2owUGFaTVhTT1oxQ1hMWDl5eDV3VVFZcWRPQUVpSnphcSt6T0dzNGxTRVQ5?=
 =?utf-8?B?NjN2dEkxOXpvUTNIL2VNTnNOa2xsczNVM1hQMzVkS3FuRlBqVFFzS2VocFFP?=
 =?utf-8?B?ZEsrUFg1Rit1UHQ4S21RN2Q0UXU5YVdGTGlxb0tud3ZZRUdlMTJtSURhS2tr?=
 =?utf-8?B?NGF3aXZBWkhXUFkrSEkxbzdpYThsYXI1KzE1dmp0d2orRU1SUzZzTnVVNklD?=
 =?utf-8?B?UTFtNjYzWkR5TStNS1hlR1Btb21JbnA3cHpjaGFhNDdCWWtxb3o1MFFGK3VS?=
 =?utf-8?B?cXkvQUZuRXBHU2haZHZPeDY2eHI0UWRSdWV5aitFYzkxR2dWMEM2a0lwN1J2?=
 =?utf-8?B?dndRbWVGSlR1dU5qTU1LZ01OM1VYUy9ZamJnM0RCWG05OG02aFU3ajhoRUNX?=
 =?utf-8?B?QzJhd2J5dTBKQnBIaUhlYlUxWTNPZVdpalhMT0U1NEhxZjRReUFRTHgyWjFQ?=
 =?utf-8?B?Yk1Fcmk3NDh5b1p2M2doVjhCU0dCTDJDRTIxYkJmdy9TcXFwa3RIMGVHNEFB?=
 =?utf-8?B?eFFCbS9odEJ3VGdoUW01czlzZzV5NE5PWHQyb1hNQXNJT1VwS1ZDNGoxUmoy?=
 =?utf-8?B?ZW9BSWVUblI2ZHQ0ZFc4YXEwUjhWUTFtOHF3N3diY3QyelBVVk5DVnJFeS9k?=
 =?utf-8?B?TkowYmowVTR0Yzl0RGRJN2xHMUV6OVMxcklIcGtOcTliWTZ3a3YyZm11SjBx?=
 =?utf-8?B?ZFhTaXBtYzA5OHZOUjliZFlESGZISXV3TnFNQ2g4c2R3ZC9hSG9jeFljSjZx?=
 =?utf-8?B?MzdBc3Rrb3ZaMWlQcm5GaWowbU1HSWJxUzZwcVRwRmx5ZVFzbU9QVEZ6RTZh?=
 =?utf-8?B?bUpXdG5iZTVRdkRIcnNsRXJiem10YmZZYVNxajVPaXN5Wm02U1loNzZZZVV1?=
 =?utf-8?B?bHI5WXd4a2V3M0s5KzYycHUvbFU4dHdBY3F6enFZSjlwZUw0SkE3U0wyTGZp?=
 =?utf-8?B?dGo1S2J2aWFsNkpXNHRGVXhFcDFKSVI2UytQUWpseWhRdFdPVXFoNnNCbVZM?=
 =?utf-8?B?Y1ErbFpFSkNFOVBqZXQrUHdDeENvNjljaXVMWGxiSmhkUDJzS3RmdDlpRVhp?=
 =?utf-8?B?T0FNblJUSm40eDluU2d2bTRlaFhBYWlEK0tLVDZmUEJ5RjJsdXc0TUZHb1Ez?=
 =?utf-8?B?cFBLOUQyVjQ0U3hSZm1TSU9CcFZrRlVnZVNzY210a29RdTdsNUxEb3h4eTRx?=
 =?utf-8?B?VG1BYkw3a2ZiZlI1dWo5cmQvRGNSNzVUZVBsbTNUVVFlYzVvblAzaXRhVE1P?=
 =?utf-8?B?d3hTcEc3S3dDMnN4TzFlcVpWV0ZMcm5qVU9sWUNoeXR5RFBkdlExQTVFRnBX?=
 =?utf-8?B?MHBJRlNmc2RndXdOQTJoa2U0MHlCT09GYVorR1lzeTVZa0xJMzVGZlo3R3Mx?=
 =?utf-8?B?d2c5ZW5PbVYzVDc2ZUVGbi9vaU1jUCtzSlhzb2dlZjNlbzJyZFV5dEhnTnFM?=
 =?utf-8?B?QUlsVHY4RjBBRllZK21mb1pzbHFuaWUzaUJJbXZmbGtBcWlnc1JQNzJCS25t?=
 =?utf-8?B?L1dvd01NTmJPYm1mS1RlR3ZNa1pIdjhDV1g2QnEvRjlhOWdISVRka3h1bGxi?=
 =?utf-8?B?dTBtaWlVcWZTangxaUlHajUwK3dNUE1OdEY1SHluallING94SUxRWkRzemUr?=
 =?utf-8?B?S2JhRmpMVEJXVU9iQ3VWOUorZDJpd1Y1N0lFYS9CK3g3SUdTblZQU3F6Ry90?=
 =?utf-8?Q?lWOMMDwleDnw9pbHJPJ2FEoo95QuURQB?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VzN5bUhiTUt2Ylh3R1hSdDlDcmN5YURzYjVJbU8yNS96aDIzamFZWkZQanBE?=
 =?utf-8?B?bDNkWFFWcEpEQVdoSXRxd0F5alJ3UTNBOFRFYnlLSVF1a1hNRm5KKys5WnE2?=
 =?utf-8?B?a2RlOXZiZ0JlOEE1MHFHSUY2THppcUFCbVVzZm1BZzBqTFdDNjd2TjVzd3RP?=
 =?utf-8?B?dzZ5bGFVa1VWVE85a3Evc1VPeDh0WEFUU3RIL0JmQnF4MXhEdXZoK0dJZjVZ?=
 =?utf-8?B?NEpQZ1BwMlhqTWJqQ0g1VHN3Q05lZ3BZaFNpYkloWno5UTAvYmdLTkoyT1U5?=
 =?utf-8?B?UWhqQk5zSDFqaGtPd2tKNkNyTGNxWHJLMzZ6aWpYZVg5VHJXNFo1WkUwOXhK?=
 =?utf-8?B?WFRTM3hiWktkMHVqS1RsekUzWG0xSmJnVXlIQWUyZ2J5UGJXSFI1LytDRzJW?=
 =?utf-8?B?SXRXbDlaYWRjT1VZbFRIMFlBczM5WHNlMUZ3NzNsWmNTSkxCOFp0QTVwOU95?=
 =?utf-8?B?TjFZakt6OEFGaEZjamRHKzg0RW5sQzRkQnlRNnFZUHRYZUdKWTR0MVB1Ynh4?=
 =?utf-8?B?dEsyS1BodnVGUmxLK2FsWWxnUUFPNVcrQWVLYUpNeFJCUVVKWjJDKzR5WWdV?=
 =?utf-8?B?ZTk5bk50ZkxObU4wZFNqdWMrQlNGZXlxVEtqenBhei9vMmU3dU9aMnFTaVdU?=
 =?utf-8?B?bkM5citXVVhUUEVZTUhTTmNmSGFwSHNrc2RJckZkNmdGVXhabnI2V3k0VVVM?=
 =?utf-8?B?WGlHV0VxVG9heDV4cVU5clRDTUQ1ZmVRZ3RTQytNcC9LQU1CUGdVRWVqMlpQ?=
 =?utf-8?B?RUE4bFlQOWwwaTMyd00rVDlWRXVpa0V1YkduOU1RbTFGSFVaSmdJdUViSUJT?=
 =?utf-8?B?bEcrSjFlblE2djFoT2tOUis0SmxQSFZ1bWgzYmtsYTJTWUxtQ3FxSjQ0RXNH?=
 =?utf-8?B?RDd6VWYzRGVwdlBhZUdFRDZrYVNnR2pIRDgwZGJVN2liaEpMTlJmWERXQUVC?=
 =?utf-8?B?TEkybkpnYjFNTWlCQkhXWmVLUWxQNDB4ZnBMdnpITStkdEhlZVR3M1FXdTMw?=
 =?utf-8?B?TkY3bjhVYkI0UWxQOFl1TjdzcjJKOGlCdEpFdUZ2Z2FUaHJKNmgwMHkvTUlF?=
 =?utf-8?B?c3ZpV3poTmNXOGFvTXk4MEFuRFlydm9hOXQvRnN0aG1IK2tpa1JRMjc2ZWRM?=
 =?utf-8?B?TlpPdUNBa1luUkxYT3RPb25BODZTbkpQZmY2MnA2SGlLRStnYXZBbHU3R0JU?=
 =?utf-8?B?aVpLRWpJWVlWbzdndm9pT0NBdk5YQnp4M2tqbU5PRjZCbE1kbFpWaExlRkZu?=
 =?utf-8?B?aEdSWks0cm9jcW41VFZWZlZzLysrMUFiN05rSkhtaHpFK054U1NqV041Y290?=
 =?utf-8?B?WndwQUI0RlV2MVNkMTJhSW53ZG9jS1VOb3JNNWR2dlY2L2lvU3h6VFFuR1Bu?=
 =?utf-8?B?czFHT3Z1WWVvUVZoRlRiL2ZxdFVoUyt6LzN1VWZUeXhIcFJRUEJiUlVBUm4z?=
 =?utf-8?B?dnNJU3YyQmdIZVNQVjFWTUhaT3p0SXBNZkZZNUJaaGJPVVZDdmowVndNLzl3?=
 =?utf-8?B?K3RoS0wxbGhBRzF4dmhUL0ZMMU5pZUdPcVFaMzFDR2E0U2Zua0VOYVdTdEMx?=
 =?utf-8?B?WDBpMWlibkJZT0Fub3V1bkRDdHpoZTV5WTZDMUZoNitUb0JkRFBrUEpQUzlk?=
 =?utf-8?B?cVFSWlowL01FVkswOEJ2dk9iSDIyVnRXSGIyVXlEb1lnTUNuQnB6VEYxaUFV?=
 =?utf-8?B?MUxNM3J2VVpUcVorZmtkcWZ6WjdvdTNKV0lycTdQc3hLcVJQTnRnczFuNVQ2?=
 =?utf-8?B?RXFKRVZHUlBrVE9MUHF6ZzhJTGJDYlhjZXFSaXovbTRadCtONE1tV0owR0lD?=
 =?utf-8?B?cjZ1aFNrQit3STRGYzIvUE44RjB2V2xOcGxrRk11V0MvRW96YVRyK0xGYng2?=
 =?utf-8?B?d1pjWFRIZWg0cWpyZmFWSEU5YjlUNXpsVGdGRkRuTEwrR1d4VFZyek1WOU9K?=
 =?utf-8?B?Ty92cUQyUks4MGRaUmJVU1JCMkJYN0FDY1hDZ01CL2ZWbjhJZDNMejRrOHZ0?=
 =?utf-8?B?a1RHRWkyL1NtNmlNak5pT3FiOUllc0dhcUdHdlZ1NUQ4V1JLMm9PMFlTcnBz?=
 =?utf-8?B?YnRMMXRSZ2lBK2JHOXRtblFBckR0MzQxelVrR0NjY2Z4S0NTM1dORmlSSS9m?=
 =?utf-8?Q?Y2RYRdFENSsO3U7kJ+lLJiWx+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jM6IQ5n7jtpVwYX4UgIFCb3CEO5VJUfczrjGo3iWojxh4FWDZeuuDd/EvEaIIc/T0IKOB3z4D9yQOvmFNZ15ZeW3axDEMJMmlAq1XlsXPAsDITwnWuxVfbbTuu/pMTMUVzscTd3VqgwU9eZrO6O+Cr+nPeYsL2SZufBNzE5dTUglP50sJVIB/L10uyTAU0p3PTulLsd26hzleuJtisDRqgAcq2WE28TB5iZWJ5WDk5pjJOOsAhZdXU7yBlgYCPOGBo5IcMTvl9lyJXZ2AL65WneUR4TM9oH8vEZS/dS9uWJQ/ICTze6HR/vktDrTdveqDpl5s4f4Av9pYpjt1+DIClxNyDxvp7sfgKSRPbWF/ggCMqdZzbDuT/san8ZJqLxD+Vdc5niTk3c413NFKeM+2f64iLeX6kjj+bbpMHYFDuUM5lIKKY9Rk8baovqMYc2JmOdzw+TMUzm8xieXcjWudGIibybOA0UUME+ZVxfi+50dCZ5HUooG67F8JO5BLRomRb7Csx3AYm6wNFYQgAmkTqeEBnPujpjYKyNoYcKzUQz53LZQs4iVhS0/Ae+uon7vDZRGn+zbV2hT3T+idZ6isoUazKPefhurC6suLlrBzos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccda91c-7168-4460-f996-08de0e7ab876
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:15:37.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBGujkdjtjhZgN3mdXnWbBzwMuZpt/E/DL261vHY8CHDPkG5QPrDE2ZdLsTeWx/K0SVxKfFmCCJprJ4FrXjKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=957 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180139
X-Proofpoint-ORIG-GUID: tqwakMeAxnn9sl40f8uaTm6YcciyCQgg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX1CJ20DULeaGI
 XWxn1mxyqKZSM8RZoQw6HwRkFY07/gIFY1l+o22rpeGt3+SwLnbzPmDMAoq35GDeUoUDwR1pG31
 hxMvJVbRe96vI8tIwcMlaPMDy5LH0LP9y+YbcMxBrGvGLWsSaWF/3sA9dmh2mRKpRFhL/5t2sFf
 Xy1YW+uils5psfALIaIA7oKI3ixI/9E1/FU7e1UptnV2M1CJIY4Jhe5JRmRAkU/wknUGVR61deY
 +a53tSw9hCGtvlB4/JgH7zM5QlRTkFiqQbWUpolzB7Mg2Q5YT8AEskzdOkQK5y/GKLs0vrGJOMv
 8wAKm5oazIxbjkrgWE5mNAldefoPZBSE5+egugUJE3/gLipESaOUQMVRVNFJqpzpqeOO2TwIjBQ
 9SniSf63s7CU9q1xHyNGao4TGzO4bA==
X-Proofpoint-GUID: tqwakMeAxnn9sl40f8uaTm6YcciyCQgg
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f3e75e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JbFRl9UtujTbtRIn7O4A:9 a=QEXdDO2ut3YA:10

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> fh_flags only contains a single flag.  The svc_fh structure containing
> it has a bunch of other bools.  So change this one flag to a bool.
> 
> Doing that clarifies the code and makes the struct slightly smaller.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c | 5 ++---
>  fs/nfsd/nfsfh.h    | 5 +----
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index bb432b5b63ac..6e0f774f1f86 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -691,7 +691,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>  	if (ret == nfserr_stale && putfh->no_verify) {
> -		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
> +		cstate->current_fh.fh_foreign = true;
>  		ret = 0;
>  	}
>  #endif
> @@ -2889,8 +2889,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				op->status = nfsd4_open_omfg(rqstp, cstate, op);
>  			goto encode_op;
>  		}
> -		if (!current_fh->fh_dentry &&
> -				!HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN)) {
> +		if (!current_fh->fh_dentry && !current_fh->fh_foreign) {
>  			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_FH)) {
>  				op->status = nfserr_nofilehandle;
>  				goto encode_op;
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5ef7191f8ad8..85019ae58ed3 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -93,7 +93,7 @@ typedef struct svc_fh {
>  						 */
>  	bool			fh_use_wgather;	/* NFSv2 wgather option */
>  	bool			fh_64bit_cookies;/* readdir cookie size */
> -	int			fh_flags;	/* FH flags */
> +	bool			fh_foreign;
>  	bool			fh_post_saved;	/* post-op attrs saved */
>  	bool			fh_pre_saved;	/* pre-op attrs saved */
>  
> @@ -111,9 +111,6 @@ typedef struct svc_fh {
>  	struct kstat		fh_post_attr;	/* full attrs after operation */
>  	u64			fh_post_change; /* nfsv4 change; see above */
>  } svc_fh;
> -#define NFSD4_FH_FOREIGN (1<<0)
> -#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
> -#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
>  
>  enum nfsd_fsid {
>  	FSID_DEV = 0,

LGTM.

-- 
Chuck Lever

