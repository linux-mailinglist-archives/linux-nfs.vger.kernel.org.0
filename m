Return-Path: <linux-nfs+bounces-19055-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN3WI+OMl2lv0QIAu9opvQ
	(envelope-from <linux-nfs+bounces-19055-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:21:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3A1631BE
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51A423016258
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CC92D3A93;
	Thu, 19 Feb 2026 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ID+Fu0Td";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WzQ40RBu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0354325710
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539679; cv=fail; b=SRD6s85OWXZ6g1bTqiQalU2u6wmO9vzNDoZAj7hD0WN818BgFffVSbIxmTg0oEpmw3Y4r9PxgLy4y9Hxa8DII47cHhIMGdFsji4I//bwdNqMmnsaGwSAjNO3HAMFaVS4lb7MA0SRpxCwUXayAfTPRC5381x7UkIr1OqOZPeHSi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539679; c=relaxed/simple;
	bh=PVxQ8SM+zkq0cyVsoo9vNl5hPe0e3miOwG/SjFLlORM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IruZDt1Y3uiaEjeY8RWiRZTcB9OMhnd3pIo0kKL1W9GCO/CikxrVEZTiM4jNm74JgwhfNy7yokM1xM7+hTBZZRQ0CY1+nzZt64dZwCEQkdFnSzq/BmxFEYK3+JFU34PZcbdC5VNFmQ3iSqfZ0ofUolQsRFgmhPkVaApts5lHLQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ID+Fu0Td; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WzQ40RBu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLg7gi1515988;
	Thu, 19 Feb 2026 22:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WoXqr8aYZYMLA1LzRPxMdGBSXEHvEzfDHbYvXZukKus=; b=
	ID+Fu0Td7JT6y3ipMwD1NX1TRyIbMyD5lbxNkiPIg0kG4EPGmkn7rRliY9DrZeai
	JSHPRJsgdV/5S1bV5lvNko2qXq3CiYKPLyQ7JF5E0qtMIJ5t7bEWehiJFdQeNYP9
	34YXbiVzl1JSjq9NYCincldyKLNMXzmoahbYllAhTRR2mecWBR1tJm/BYv/0U0Lc
	4/cncdCyoCsCSfS8pDViSxGBtNvTQutVKy0qCQVIdeUGZ6RAebq6GApNhsnfvqin
	q+7yn8SNEGSq8BPdqMgme1CoMO1gumcd5smau9uoqBWIFe6Cv5KAGZgmigV4N3sT
	DY0yQX1zkJLSTKZ/EFJojg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj4b0ahr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 22:21:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61JM42VG015015;
	Thu, 19 Feb 2026 22:21:11 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb259eqf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 22:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEU9U2ohLIXDCH6piYuVSuQvoQMvzim1LSRvTSxxXCCho2eDsNt2Ou/cdUMo78yDBj0ShTOUZt7l86flI/IOFaR+gauX9PSVxjOipyAwKviaRaoMFvUbFjnb+3b5+PNa8kbBI9mNpiVQF/Z/qU86GxptyKeynnWxMgt/mmfaRusPquD/2itVY/8/9U2ASFhibvn+c3yDxb4By0Coa/aXFv+sGZWgM7PmCPj1Aa9fTIRVcFSwf5ukkCOXQGb4vPaT3pDtnP8jqI/qBg5jnA3lQZ0BqG3u4FQwyJ1/SfSxaFaYwrW4fgGdM58ZzcvzZjg+tOk/oGxMhukuvuHT9Haitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoXqr8aYZYMLA1LzRPxMdGBSXEHvEzfDHbYvXZukKus=;
 b=y23bleMa77Gc22B8pOO9gH/sUBURxBqDNgLAuxRFCNBtpbm2q5mHWlZYpD453HoGTkTVVsIsjdsKSepBBGs1EUA2qogEz/vo4SSZ8aDCaPv+gCJBNq64aN+1j9IC0rBVJ2pwluCYGD7QRMb9e6YNPyAgJanypuublCwrXvl5YE6djW/z8IjqxLE0Zk6IP/PEsM75TmvpATihTBuaIFI8NR+IqT0CKjSTwY401JZmr48nQSIwHuPvljonqix4TlLBT3qrm7r0P1b+H7hNUBzh7C09m0nfq4ioNhpcK1/FztUOoIJQvKXZg3DB1Lsgi0WF6OU8krVTTqrFLFnhnXE2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoXqr8aYZYMLA1LzRPxMdGBSXEHvEzfDHbYvXZukKus=;
 b=WzQ40RBuSzogW6WN7vQ0nW9ufRQgfoBnuMtmye1gVQWkqWqjSrT5phN5ou+NryoTWm7IMWf8LGSCSIdpUXrCnmUXz959G00v/b0q8OnNOanDvAnhWwvtt7ZgMJUluxtt24XaHKfjr1gF+1kDzHjP7zRfutVXjyzYjr17f8I7kug=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 22:21:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 22:21:08 +0000
Message-ID: <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
Date: Thu, 19 Feb 2026 17:21:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20260219221352.40554-1-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:610:56::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fb72fd-c17f-42d0-38d1-08de70052de3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M0dzbDJtaE13T0ExbjBFcFNkbG1qTUU4MlhJSnh2T3NrZTlKanQ4VlN5bGlm?=
 =?utf-8?B?MHlJSmMzbldqQmgyOGlYRGh4SVpkR3ZhdXNEWjlZM05QaDg4RkwwaTVCTGpa?=
 =?utf-8?B?SzlOQjdhdkJIV1lYYkJUZG1FQWI1TUZuN1BvRTRzbEkzQ0VWc2p6bVhXZVVJ?=
 =?utf-8?B?K21FTUpTazA4Tnk1VDFFeFVySkVQc0ptejA4dTcyVnNyYk1hTHVxeUZEWjZx?=
 =?utf-8?B?aldWV0VEVUJwazRsckp1ZkUxelkxbXUyd2tPZWw2S25ia1RiZHl2YSs3YUxa?=
 =?utf-8?B?ZnVWSVRiUzkwZyt6N2gya2NEemhwVXhVdFBDSEFsWVJNRGE2bGhaWGpxcmhS?=
 =?utf-8?B?VXh4Sk5mRVBJdHZNUUlVWkNIN3M0endWN2VwL1VQMDV0OXdkZC96N3FjSTRu?=
 =?utf-8?B?ejRLeTlMNjl5dTlzRjFpTms5K3BEWDE0QVlZL2FuWDluRlhwTkt2Q3dhamxi?=
 =?utf-8?B?Snc4aWZGRzhKYjBqVlZ4b0dWMDEvVHYzTUpyTUFCTFIva0hKTnFQQ3RQOURZ?=
 =?utf-8?B?NXd1a2Zxd3JQWlErc0JOajI3YjExeVJDcHRsV3UwSzlEN3I1c2huNENBQkU5?=
 =?utf-8?B?T1VRdlRZRFRWSnRtLy9MZ2pGNzJiamlWaHlQQnorcGVvN3dHY0NhNTVIZ0du?=
 =?utf-8?B?Z3hxY2M1SklSUUJQNzdXMXRFUWpYb3N4Ny9KWnd6bE00dGxoaloyTXBGRXls?=
 =?utf-8?B?NVdyYTJCYmxoK01tU01nd25uZHNJZ3Q3Nko0WEh3MHZ0dmtOOU1ZMmlGQnhr?=
 =?utf-8?B?STZUUGM0U2NvRmtTNlBuMU1tWTdBc2FZckFJbzVhZ2JjZnpZVG1taHR5cFYy?=
 =?utf-8?B?bU1oNW1heVl1bzZSMTdNenpPK3dXcXF6MGRueXFFWWQrNVZobXcrVmF4RDMv?=
 =?utf-8?B?SDhyMlg2OXRNNUZPcUtlYlBWU09MWXowcHYxcGIrdSs1aExtbk84bmMwQVZF?=
 =?utf-8?B?d3pVZms3WTd1dnVod0JncjJ6MUh2cXpiVFVqL0lHYUxYUGplb0RCcEw1MjB4?=
 =?utf-8?B?Q0hWYVkwL0pUVHRVV3FvMnVpVkhNcU5WOEhwU0Z3QllIaUNVVW5JTC9Delpu?=
 =?utf-8?B?UFFyeUl5WlJoTCtpYmhQT2tVenJzeXhlWG16TzVFL3RLZHgwMXVKd1l5R3Ba?=
 =?utf-8?B?ZjhuTHFyS2dYZFJYRkIwUVNhZ0p5SXFmUnRGNktFYk93SkZBU29ieDQwZDE0?=
 =?utf-8?B?ZEo2UUpKejVqRDMzVllVMFh6OHQvTVBUUE5acG1wYnVhUEw3YVpUTjJWUVNH?=
 =?utf-8?B?WWdrMzNoZDcvNHQrU2J1clFZcW1PTHMwQmxvSnhtbE5OK3N3OEpTeS9hcEk2?=
 =?utf-8?B?d245enBiRVdRVk9RT1ZSaE53NWFlM0ZSLzZmNCtFd0hiRGhidm9OZW9iVVR2?=
 =?utf-8?B?c0hOSWo4c2pVUzVBWFU1RTJLWDgzOWdxOWdlQTdJTFZ5RDYrRW5MN1lMZDJJ?=
 =?utf-8?B?QXhwYmE0dEdzNHpEYmxPVUNVcC9rdDBkVmNyemo0RXJvemU1QTlWamI1cDhV?=
 =?utf-8?B?elVUci9yZXlYWUNrbXd5YThaWGlxcFNhbVhTMmlwUFpST0VwTUt1THVZb01l?=
 =?utf-8?B?ZkZiWDlSOWFPQ0VBYUN3K2lrNHVDSUxaeERwSFA1Q0VWOTk1RHFubGhnUDhI?=
 =?utf-8?B?V01kTmQvTVZVTmh2Q1k5aHVJVittd2dabmE2V2lBbThpcFo5MGk2UE1tN0oz?=
 =?utf-8?B?dlZ5ZU1XZEJyZzU3b0dGQzRuS2hYZTBHdFFNWG5JK3lYTjNLYjJVTzQvNmEz?=
 =?utf-8?B?LzNHeEN5clBObDhaNzYwRkMzSXE5Z3dOUlhoOE96OTQxc2VJOVE3bmViZ0py?=
 =?utf-8?B?NVMvbjhZYXFLeFBKa1N1NHFVa0VlUG13cUJzdmN1Mk5DUkxpWm1XTHlpUjY2?=
 =?utf-8?B?KzIwdHFoTld0OTh2eExmc2IzWXdVaFBITDU1UlE1SVN5QTducUdkUTBXbUgy?=
 =?utf-8?B?cEJZU0oxbUtwSSt6MFpRRWJvOWgyUVVQRnpRc2IvV0Z0Zi84bDMxTkVoS2ZU?=
 =?utf-8?B?NVNNVGVQQy94NThQV0FHYmNvM2EzaWROeHVYZHIxdmVpbitoYU5RNHpmU3pB?=
 =?utf-8?B?dEhnbUZFOE44WGtKM2JseHBUaHVWRm1WWEpBRUZnZEtEOHNSNGpXb2JWNVBy?=
 =?utf-8?Q?mK4s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QnpaczhFVEhOcE5adnhhY3Fod2FuZVBON2xtZG52WlZpOGcwWkd3dnUwRnhF?=
 =?utf-8?B?NTJQRkdMZk1KckFOQ0JiVk5oM0RCdklIRmQvNkxnRko2eFpIWWRJTlpkdWw4?=
 =?utf-8?B?Yk5pdVZ5WlE0SVR5QWNEWERYMGluSGlhMnpLakxJN3Q3dmduWTJBZjdiRTM3?=
 =?utf-8?B?bXljdk1mMlhZZk9iVmxORUNYTm4rbWhiMUhNak1reXBraS9MOHpFN2FXNG1s?=
 =?utf-8?B?TTFtcGdMUWlMb3kyZTJpQzlqM2NpNURudE5VcEcxWC9tejhmRG9ubXhJcCtp?=
 =?utf-8?B?eW9TbHBEbHBSemNBUytRUSt5bEFQYnk2QWNoMkEwVUNvbElRMnVXSysvYTNK?=
 =?utf-8?B?V3BNUGpoWkhEY3g4T1pYQXFSdkJJWUxrY2lYb3kzMHdjZkdmTlRhcyt5a0J3?=
 =?utf-8?B?dm12L0crcytaa0RlUVlGVE1SUTFJNUNuZTVtN2V2TzI5dDg0VHBDcU45dkUv?=
 =?utf-8?B?Tzh4bFZ6K3Y3S0VVNnFiWndmdDlWQUYxT0x4STFQc1JGL3RhN1AvbmxLYzNV?=
 =?utf-8?B?Qlo5TGU1YVVleUY2MFRPc0d6SnR1dnlrMUNCdm4xS0xzVndJV29sYkhHMGUw?=
 =?utf-8?B?cStscnBJSTQ2YjdmL3VRZ3ZVZkl2L2ZjZDdEN0VFb3pONk9MYXhOZ2hnTU0v?=
 =?utf-8?B?SVFiWk1aSDFLaUh1NnVjZUcraUcraDI3Z01NRHlOK0pKK0t6UTh1MThHQ1I1?=
 =?utf-8?B?Zmw0MzlNL0lIM1hQbkUzVmtCVW1KZmtaRGdmTHZkaHFORmhUdmE2Z1gyOEtp?=
 =?utf-8?B?RURlVVcvNmZ2TmxXTVM0UFpvemEyNUJ5NDFIdW5hOEV0eTRtWGgrNDNJWCtB?=
 =?utf-8?B?QTZzb1lJY28ybVYyUWVabUM0c3hmeEZwZ2theHkydnpNRGtHQjlLK0JoL1Vt?=
 =?utf-8?B?cFE1cERMWU14aUNudnRid2ZqdW0wTGY5eDVWSzVUZmJzV2lnRHpnSDdrQnpo?=
 =?utf-8?B?NlV5d1dKK1N1MkhlVUpnWEJOOG5YWlpnRzJFcWFsTHpka3pKNFNXUzVta1ZX?=
 =?utf-8?B?bzZ3RnRJNG9KL3ZUVFRBUDkwS2R0S0V6M3BZNmRpTmJFQ2h2M2I3UXBEMDlK?=
 =?utf-8?B?QnY4UnE2dDIrcmM5OEhDTHNIOEZyanh3OXdpUjBzcERobFdSK0ptenB5SFBT?=
 =?utf-8?B?NWcxaXBhbFNTV0JxckZFekZQNGpQMEEyK2VMOTVTOGtaRWlaMXdTYVBJU0pF?=
 =?utf-8?B?cHhCVnlsUTkxQi9YcExTdzhZbFF2QlA5bHkyUWxyTTYyK0hhb1lhZ2Qzc0Ew?=
 =?utf-8?B?bzRReHpUZ0hpNWVGcHJNSmRZTTBRZ2ZwMC9MWE96T1JzWlRTaWczUjVLVTJw?=
 =?utf-8?B?UDBLNDVKenhMY0puZzN0TEFNcFNmSjBSTGhOM2pUK2VnM3ZVMjllSlA5Njhn?=
 =?utf-8?B?bUJDaUZNVmJNdDQ2ekRaWmFiL3ZLYWUyMEF4VlB4R0U3U2YrSzlrU1ZJTk9X?=
 =?utf-8?B?RW1qZHArZzF6UStFdDFLOGtvTEJEbklnM0hYcTlKYjhWQSt1VzFvYnM4SDE3?=
 =?utf-8?B?b0EvcnJYbGIxTVZicisvcUx5dkc5RjFROEZ5Tk41SEdQbGFMeXV4bWZ3bGtM?=
 =?utf-8?B?amZkU1RFT1IxNitpSldTWkdHRC80dk9XNS9JaGlydm5PNHhRY1pFMEp1bVNT?=
 =?utf-8?B?QTV3Wm1BNGFySE0zZG9Ecm95elR3V09mc0RUTnkxeHBQNjBGWU11VzRSbHBP?=
 =?utf-8?B?eU8xYm5objBNWkYzWkdpbGZhaEdBaHBnUEJ6SmZ5M2dscXZsVWVid0x3bEFF?=
 =?utf-8?B?eVpDalZBeXdHOXJqT0d6dDBCcHcxQWR1WUIvNDlqWktGZE5XYW5hcHRVN0E5?=
 =?utf-8?B?bTJ1OThsU2RmQ0pyZ3pDUitRZDgxV2RFaUFVam0xWGYxNEE4c3NjM2lvOU55?=
 =?utf-8?B?WXFNU1ljdXhWOXR0dXJETmpRM3NFRWJEUHhSb0tOQzlsTzE2Rkp3UkRmTU1O?=
 =?utf-8?B?bDFYcEJrYUYzMG1VbDVoeWtrYXluVmZHOEFONHRsUndveDRnUnpqNjljTVZu?=
 =?utf-8?B?UzVNeWZGMDJWZENtdWFCdXMrSnBnbTlIZ0k3NVVtMUxqNHcwSlhETmgzVi9r?=
 =?utf-8?B?S1R2ZnFYWW9ZdGN5ZzFWdkI4VUc4WS9MWVJybmpPdXkvWXRSMHBHTkR1VjlB?=
 =?utf-8?B?a3BwTE5oQ3Z1SUJRYW1JV0lNemROSll0VEdIOExFb090QU5PMjR2elNrRFVB?=
 =?utf-8?B?bk1aTkFZVzRzREJ2YXN1djZFdXJWcy9RczVJaSszbE5HK3RYRDg0UFhHRkNU?=
 =?utf-8?B?WGlBNDF0anlNTjhYd0pQSWQvSDVaOS85c1NSWGtpTjZkNzZBbTdia3RBL2FJ?=
 =?utf-8?B?VkVOVlN0U05XNDNEZHpyZ3YxbURDQnBQTWtwYWd4V3FCSW9ETTRpUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sihx8cCr4L9Pisg42mZ81B0z7THNxH9sF4i1Iq+ZhQRvY22tJRGELHf12t9c/GBp/gmywci/orhMoEEqaht4GNntYlivOwvvQoQvKui1lUmipZHqjTW6c3sluv8zg0SkljMyqH3Bhq3cT+XazWgbDqc+Nit9kdOSLmZ6O4d442M4ctvK1Pck0/JuS/oJfmbVvFnz9RJ0XZWjJ/59+iUz2jyF4YqGT0knMa0jMGTT422w3JBUfOkQ5pTMVdqnw9gVDLwHnICyq+sxAxZk/UVXv6GsT9xoGbfdNtghauSreBd4qgfoPKWBEZysYgrPFOz1knWn/0OEGhC1PHOdJoJsRim7hQHqyizsYkuEUYNq3vuUyWJGYJ6uz8Fw87p/Btot7Zya+Ejfyip9+290PFG9fetSx0gsmLz7pOYgWAsfTiz7aCyEoI6KQ2V/Sh69gFzZfQTBc8F/wp47tjNNFRO1Ulee3v8/7BE8M7pzALUZOC1ZobWYisJNDYQygcXu+prvCzTWR3MQobYIoUHAaQsBDO9feZm80wKPJCjagU+ze86+W0EtmMdWBNbriW6QF6YHdQfL7qiV3Vim4YoRaQFCWNplhOdg5zeYUX/VZ+AAzdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb72fd-c17f-42d0-38d1-08de70052de3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 22:21:08.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B28jT6vETaSvhZNBmnYBxH6ipYKMh2mZNV+pkIZlW2JpTzgzYRdSBxGiJCF5aa8jiA6LUGaE5u9OEKwL8KihJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=848 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602190202
X-Proofpoint-ORIG-GUID: TF2-QrTMqRyf5kVFkJcJ3M0eyXt57mGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDIwMiBTYWx0ZWRfX7wiBYd1uAczp
 cqnM/znIBui4ueKjK5UKGy2PWUvaGNO/KtG4a4LjxiB4PZqthnhdxRBg311cbm5LEAk+HzKTtJE
 iBoxU2UUov0qhke/21IJ8JksV7/HcUgMrX2y41V9RVYq6Fh8kSkpVSkWln7n1KeEPYlkuXdhc2q
 sLnZQHrMVcJDEZMFrRE2B43LUx6eBkYJG8vrJtm3sZQD0xyOO4Gkdz8w5EJ3VyTBWHkombFQwnu
 m6Il363lPZh2TnUNVJkHwAJ7ze5eaqdSVdRavoBPFerlsEY8IdIplzYpmeWZ5BpbNoRUq52e4sk
 jY0sd2iYTkzcpJkR8SGEpcMDqHHauBG4JubkzJ+mKTucZ2g48ZIxniOYdOSYPolp+FCuqA8UHvh
 FOy/qaOfPEdMXMUsVdZGBuNhlsos8lt5XQRKK48KeGzUhICY+HGgx2IVAWFhFrwiUMXTm0tbUYp
 HGh4Hurr0Y4o2u5e4mg==
X-Authority-Analysis: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=69978cd8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=rXflUvuuMQvdAb9oJSkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TF2-QrTMqRyf5kVFkJcJ3M0eyXt57mGq
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19055-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 08B3A1631BE
X-Rspamd-Action: no action

On 2/19/26 5:13 PM, Mike Snitzer wrote:
> Hi,
> 
> This patchset aims to enable NFS v4.1 ACLs to be fully supported from
> an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
> filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).
> 
> The first 6 patches focus on nfs4_acl passthru enablement (primarily
> for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
> patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
> to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
> the corresponding required NFSv4 client changes.
> 
> This work is based on the NFS and NFSD code that has been merged
> during the 7.0 merge window.
> 
> This patchset is marked as RFC because I expect there will be
> suggestions for possible NFSD implementation improvements.

A couple of random observations:

1. I haven't been a fan of these double-subsystem patch sets. Is there
any way we can get this split into one set for NFSD and one for the NFS
client, with as little code sharing between the two as possible? Maybe a
pipe dream, I know.

2. Do you have a plan for similar passthru support for the NFSv4.2 POSIX
draft ACL extension?


> All review appreciated, thanks.
> Mike
> 
> Mike Snitzer (11):
>   exportfs: add ability to advertise NFSv4 ACL passthru support
>   NFSD: factor out nfsd_supports_nfs4_acl() to nfsd/acl.h
>   NFS/NFSD: data structure enablement for nfs4_acl passthru support
>   NFSD: prepare to support SETACL nfs4_acl passthru
>   NFSD: add NFS4 reexport support for SETACL nfs4_acl passthru
>   NFSD: add NFS4 reexport support for GETACL nfs4_acl passthru
>   NFSD: add NFS4ACL_DACL and NFS4ACL_SACL passthru support
>   NFSD: avoid extra nfs4_acl passthru work unless needed
>   NFSv4: add reexport support for SETACL nfs4_acl passthru
>   NFSv4: add reexport support for GETACL nfs4_acl passthru
>   NFSv4: set EXPORT_OP_NFSV4_ACL_PASSTHRU flag
> 
>  fs/nfs/export.c          |  23 ++++-
>  fs/nfs/nfs4proc.c        | 112 +++++++++++++++-------
>  fs/nfs/nfs4xdr.c         |   2 +-
>  fs/nfsd/acl.h            |  11 ++-
>  fs/nfsd/nfs4acl.c        |  69 +++++++++++++-
>  fs/nfsd/nfs4proc.c       |  32 +++++--
>  fs/nfsd/nfs4xdr.c        | 194 +++++++++++++++++++++++++++++++++------
>  fs/nfsd/nfsd.h           |   5 +-
>  fs/nfsd/xdr4.h           |   2 +
>  include/linux/exportfs.h |  22 +++++
>  include/linux/nfs4.h     |  23 ++++-
>  include/linux/nfs_xdr.h  |  11 +--
>  include/linux/nfsacl.h   |   7 ++
>  13 files changed, 431 insertions(+), 82 deletions(-)
> 


-- 
Chuck Lever

