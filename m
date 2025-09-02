Return-Path: <linux-nfs+bounces-13982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F5B40CA4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 19:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F964844BA
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150302C11C9;
	Tue,  2 Sep 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="okjD5ns1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i5IF6va6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A243594B
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835963; cv=fail; b=uo7tG4ygjKRw+WwZ1Ile939Ud+nGtFPYdtvnlUWFh4VJ4RMdX6ej1664uJmgsXKnPJ5zZZa/n1G1WwKMiN6X6hyEvVkXTUflN0sP2u8T8U0Ig4MkHnJ9I3PAM+VHFZuvW0mG9nf9pY97tQPtU6X6rBlHH/blvVdSx/rKQgY475g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835963; c=relaxed/simple;
	bh=5TCMYo/s5gk0AMxpTSQxCGO/4h09duf/DuAvRz5DcYA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGvcGYDzk2QVrmRazHTsOqfvs2Wnw8yjixCXoOfm3EWklL+s01uO1Wpyme2pulHaS++CCG+PUjoiM5JQEc34EjGg7oQpLkaFEeBnd2sU4uvElGQYzOxCBgqNpiJV20tSetsf/rItqme4ptllQasDLx0jwm5DHjAxDNMcKMeV5Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=okjD5ns1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i5IF6va6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582GfwO6002344;
	Tue, 2 Sep 2025 17:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lbeRai5YkF+k3GNFeoGabOjKAuNZakgvg9ZE9IB6+4M=; b=
	okjD5ns1Nf8hokt4LIUTGIBd52+BbbuTx7EillQwcPHvJeMSC030vMahOL9e5o+n
	an47GVL08z98FFsyVfE+fB1UVk//ZekxUChMISMLstZ9fHfkhK6iQxLjAjiTpfOl
	yYXcHP3naleGnszqZZBz10HiTToXT8PDGF4hes+G59ci09cKqPHu3EQzB49EnTqI
	L4WdoU+AAhWoRrmg0qPFc7Y3dYJmywlr+612+4sBqQdvNMDu3OfiYAzAwi5U/fnk
	azcEPgZ+7QeNHAvUTVwP42ehBjlQtKVSC7fwsgT8F6xLUS3ZrOV/hEpxN2DLrYgv
	PJf6uTMFV6HaLWhREekRFA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvvptv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 17:59:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582HEPrO032545;
	Tue, 2 Sep 2025 17:59:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrfqktb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 17:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruplz6ByKQpbweXS9hY/fmvw3dGcyoM5kVq0ze7KVyaeAXC+p6k1SvAzaMrOXS7hX0t/z7U3ANcHmugqPzIf3kf9RZo2qrSvKpAPprmhyFdCv+XjFfEeZIlnvLNszN3q3YqAWiwSNLvTobtKOOxIvflDhoLni9YiSzSeBQFDHyIkl+BxfTYmmAi5s4JGOlQaWgQzJGMwziIPJARPfwT1364l50oYnjGu+xTzyw2ryxvs+35SlYJ1ESRIfWJZnCw5ojQjwvtnDQ+TT/XCOVWpLYYY2VcV3NwrqjKeD9I7gAXuWyF+4MT/OnZXjiHJSEr7NzypcgR9XiKc6LYesvx8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbeRai5YkF+k3GNFeoGabOjKAuNZakgvg9ZE9IB6+4M=;
 b=pQfJ8orLDT4uoy4EVONt5ShFK4ZBO2iqUaAkEFRgO27tXsti6qbTnh8VMQ5QdZmP1ft8fDuSiEme58UepiWmVOmfpMs1WqaeRnS32btDqm5FhKDqtSKVDpd5Wy2D0++tNqh77AZo9nXb81YUseQggU+N9DXdKTuWKzzZCMFMCuCXmXrFlkIKs6XxsISulMGbqQn+9AUdHAPFAp2QY22uI+d9WabSb6ICJ2zly/6KIi3WqeodegG0OMj+pTCTb06Aew9sGXHYvP7vGuWQFSiMwXQE6MCl5B75LjehIPO4Q5BFbouhK9yDfsDS57v0EsGZ62FzLB+hC8gdkVls9BRvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbeRai5YkF+k3GNFeoGabOjKAuNZakgvg9ZE9IB6+4M=;
 b=i5IF6va6GYFE6hMYodrD3MZUaXK3mrmVGpnIKbJUUHLTu1MPT1aDdCcwRxG41dZ+uJhGeEYc8x3LuFKK8SQiqKvZmy833R2g9PlPB4/xvDKSgo7k+6zyjx+ym8HDVCNEuomaZGMr9+VaZTUlIJhJXiwSqMl02xISxCj6RAEBI9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPFE06E70EA4.namprd10.prod.outlook.com (2603:10b6:518:1::7d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Tue, 2 Sep
 2025 17:59:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:59:14 +0000
Message-ID: <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
Date: Tue, 2 Sep 2025 13:59:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
Content-Language: en-US
In-Reply-To: <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:610:75::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPFE06E70EA4:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fca007-7e00-4aeb-a46b-08ddea4a6d59
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGFxQWswNXlzS3kxOHNLUndxNnowZ3dHOXNxRjJIOFlaN3dDN3AwYUltNDFM?=
 =?utf-8?B?RVVHcFdJeEowalRMRGtaWWZNdnZFNEZZMnFOdlJKVElGcHNiU2ZZbFlzMVhs?=
 =?utf-8?B?WkdzVnB6UTF0b2NFbmxKVUhXa2JQZTBYMnZiQ09TTVFaMXFPM0pySzB1dWwx?=
 =?utf-8?B?SlhtTDh6KzBSNjdJUWNTS0VzMmVVK3dvU0ZieTFXYUJZT3R6akVZcXZ1U3dk?=
 =?utf-8?B?Y0JvdFhkRnU0UmFrbm0xTEdlK0VyUUlKeWZqNmR0N1lBSENLQzlKNy9abnN2?=
 =?utf-8?B?bFEwTFhodmVid3Q0UkhDVzJtQzc2ZHdtQW9lZWNrWHV2bDdacWtsRG1CTWJ1?=
 =?utf-8?B?MjFwVWg2azZZWCs2T2FXby94VFlwRjVuNGdZMXhPSUZZV0VKeUQrVEE3TVVa?=
 =?utf-8?B?OXFKUGpyQnJVT2NPVUJFQ2pvR3Y4eWp2VlczenJ6VVJIbkRDVlZYbUozT2ZW?=
 =?utf-8?B?MmNEMmZQRlIzSnRST0NnK1VyOEJ6VzBEZ2VrY3N5YW1vQ0llamJjbFMvU1cy?=
 =?utf-8?B?UVJmcUk2bVUxdDNQNUVLZUNtU204eStEcFptVW1WUytYS3d6YVhJSXZaY1Fv?=
 =?utf-8?B?bGN2MGtjUGZnQThEMWpIalJndzM1YjA4dzJkV2luR1RWL3lyK2NwblVCN1lM?=
 =?utf-8?B?S2J3a3lYcDJhTGxVU1oxS0tUODZzQlI5YXplUmVZYnZMdXJaVkdSUWZhREMz?=
 =?utf-8?B?ZFhINTg0L1QvTmdwN2FsUzZVbkFlWERiWVJtYmt2N1pPNGpMYnFRSlFDNU1M?=
 =?utf-8?B?NHBXb09ZUS9yOXJpTDFWOXNBUnFaalFqM05qQytJV0Q5dHB6bnRwbGhnLzEz?=
 =?utf-8?B?dXdCd0ZvRGh4LzFpTlg5L2NhcXhWTjVodWgwMFR5Tk5ZU0R0UXFLTE5DVHlq?=
 =?utf-8?B?cE9sU29jU0hmeTFhM2NsU1pmcWZHY1dPb3JCK1AzVnU5bkEyZXNXUCtsNUZi?=
 =?utf-8?B?M3ppWlUxWTd2NmdvQnM0YXM2dnBJbWRrNEZqZDg5aVBBamlzU2NPVUVHTFh2?=
 =?utf-8?B?WXRKY3h1cUhJZFB5K0QzUWliL3p2dlE0eFVaZzM4RGZKNmNGRFYyRE92TE13?=
 =?utf-8?B?TE1XaWNRMzVvN2ZKWVZyakwxMDZLRjc3eUtTS1cxcWJhbGNiMHppTjBNZ2Zq?=
 =?utf-8?B?d2lCZkd4TDNZdnYxUzFxcUlkbkVBdWhtbWQwNDcrUG1iYXV0SWpYRFdvZVpy?=
 =?utf-8?B?YzlvOXhES2x5bFlycGpmbEdyVlRCSm9JMFlyWStpSEVzZ09XUVBxa09HSVlD?=
 =?utf-8?B?YTR1aGN5Sk8xUDU5cXJYTDBUSFpjTTBkemFlcWo1c1Fram5oYytKeUVReWtX?=
 =?utf-8?B?dmxyd05DQmhTWHBLVjV2SFBGRUlIbkhNemF0bFVyaDVkaDluUWw0OCsyV0Ux?=
 =?utf-8?B?b2wzd3lYY0JtU0hueFF6Q2tmSUszalRjTzhIWGhDeHYzSTFnbjk0RHFHQ2xZ?=
 =?utf-8?B?a2FrU3NtWGRmdWhWaFFVakVoRVVESHY2TWlVcm5Qd0Z1djhIZWw0WVFzRFFY?=
 =?utf-8?B?ZFRsYStsWmZCc0ZHOXlnNythbTdrVVlibS9kcm9hN0UyUDVuUmxSZHhFRE12?=
 =?utf-8?B?U0M0RFR5NklCaGI1dHN3emd1NkpHb0lNUHlVajV3NUdRTjRRTnZsNVpnank4?=
 =?utf-8?B?MlVRbFRTUzhuaXp0a1VaQk4vUmE4WlhjMFBOaGZGNHVpS1VLdzVBTTc5SEgv?=
 =?utf-8?B?aEFpOHVRbUxXNHViUVkvNDVoVFA0ekxQTWp1SHV1M05kNW5lY2tVd2dHZ29H?=
 =?utf-8?B?ZVEzWEIvekFoTGp2ZmpWK0ZYcXpXdi9BZVFUTXd2bGFidm1rcWxsenhSWG5I?=
 =?utf-8?B?c2NSckFjZzdZZGpyQUVCeDdqY0ZoUi9PckJLNTZYQ3JlWU5DOEc3dG5LMDV6?=
 =?utf-8?B?VHZnbHFldmdqL1lYZWxmM3c1K1hZWVVwZm1PYit3UlZwNUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K3NqeGlGVFhiZXFBRnJrWFRwSmdLMU16d2RLNDJhTWNyZSsyTTNQOUpYSDJz?=
 =?utf-8?B?RXlxY0ZSaTZabUZOL3NuSlBsQ3QyNUVvSnFjRyt2dzJTMnlWQzVGakg5R3p4?=
 =?utf-8?B?ZjcrNkNLdzVQa214bWd1ZjVCSHJPWVBxUDNIdWFUSFRPYVVYUTRBWG5IeTZB?=
 =?utf-8?B?ZGcvenQ5SGh5NXdiR2s3U3NZMVFXQWI4R2o2NUI5cmllcVpEUkZEM0JOYkJJ?=
 =?utf-8?B?RmI0ZDIwdDdQOUpLVTdyZ1djNFJuV2ZTczZVdTBnbCt5UjZ5ZVJubGdQTGZp?=
 =?utf-8?B?OGhHMkY4eVNGZHM4VlA3MlpDTTdueWlsTGp6OFBNZ1BpNitGZGlDbERWMHFP?=
 =?utf-8?B?b2xQZWd0aEI3UlhCRzdyOTVPN3NJNTNhZ1pQUkxQNndmYm84Vk5uOXVQZXNK?=
 =?utf-8?B?bUFMSXA5dkdPSlBCR1NKZThKTHkzUVAvR3NwaHJjdmZ4aEpENVNKMTl4TGdG?=
 =?utf-8?B?RWRKeklhMmhSbVFtTjBqSURjNDhtTm9LelNRWGNWeFlkRUxETGxJSWtscW5q?=
 =?utf-8?B?Q2JSd2hjWGtLSTU2TTFhZUtUWVBlVmNHRStPRS9iYzhHeU94dFVsWE9DRUds?=
 =?utf-8?B?OWgrdytDR3QxaHpIa24vY0VueG8ya0syRUg4VGpEcVFvY3FkQ1JUK09KWkdG?=
 =?utf-8?B?MTg3TWhJWVFYSnQyYWdkK0VxdjNGZWw0NlhFUFBQdnFxNTJpNk9ib0FLc1gv?=
 =?utf-8?B?OXJHTUxZVmFicUFLS3drTXI3NHlpZ1c2aWZhLzBsOU5ld0ttZjl5MmdjTHFn?=
 =?utf-8?B?S2JmNTJTSGJEc3ljQmVsRDkwZXh5b0tIanA2YzJsWVBLa2VBMEJKV2lwQ1Bm?=
 =?utf-8?B?UklSdTY0TDdzWDdXUFQ4ems0Uks1aWVsNkN5c2V3MUYvQW1mSVRnWXhKL1R3?=
 =?utf-8?B?OENuamFOK053RU80cEV0eExBZUxYSVRTWmJvWHd6clhod0IxK3lGaDkrSjR2?=
 =?utf-8?B?MFpkd2xIbmt4TWQxeUNKT2pLSmZaV1cwMGY3VEJYcUhCVEh5KzRtdm9xNDRD?=
 =?utf-8?B?RHZIUlNGdFZhRGQyWFhUMXZMajdHRmNzSlM1V0FZdWFhVXpBV3graTdVZFMr?=
 =?utf-8?B?cDZyYU10UlB4NGVSM3JFWlRzSkhVcVBMUjRlVHd2ajlBbWdOV2pIV2hhc2hL?=
 =?utf-8?B?dlBqSUFYbnluUDRlQlk3dkpVVkl5dEVNM2Zrc0lTNG1UbCttSDBQU1o5Z055?=
 =?utf-8?B?QmVVKzd1Mjg5SDRPZkJrOVVFL2lCdEVab0xYL2JQVGdFYjVzZnBVTi8wZkg5?=
 =?utf-8?B?eHFDS3h1aUxIMXlQbkp1YmxsUGhjY01LdzVsTDFySTFrYytXbEdiRmI2Zzla?=
 =?utf-8?B?QStaN3FTVzFCdlJTOUMvZHkrQk8wd01PcmVGTU9mR0tpTUxteEdVZzFzNnJD?=
 =?utf-8?B?WVk1TG90NkQ1SW96WnBlZUlnWUxxK2ZuOElJVnJNdVpDa29kbFg0eXllV0p1?=
 =?utf-8?B?ZE16bysyUVNuS1lXdjRQM3d1aVlqSEpzb0tQRm1waERPVEt1ak52WGpqTklK?=
 =?utf-8?B?ckFhM0dRNUNEbFZqQUpCK2hxSGw1K3dHOGJpN0ZDbHNPdi9BeUJxSUkwWUJY?=
 =?utf-8?B?MUN6NjZBaFIrSlVSS2pFQ2lBU1N1SHdUdE1kZTYxem8wWER4QStBdlQwZzFZ?=
 =?utf-8?B?TGc5ZUtRZ3lBOXNTYnBXSHErWEQ4NWxxZE9JZW1DSXJOZEx1R0d4Rjh0TzVP?=
 =?utf-8?B?Qk5QaWxaTUhUQ3g4NXk3R2plbUIyQlJzZmh3YnVmaFFOWldrSXFZWmRtNWpC?=
 =?utf-8?B?Wldlc3poYTNvaVkxbWJHY1Y4U1BjVTBxQi9MN1RXdFRscDVoYjRvcFdsSjhU?=
 =?utf-8?B?MyszdmE4KzRObjYwbVBWTmJEZUZvdG40M3Z2K0JscW1zbVpsVXlTcjNxRkI0?=
 =?utf-8?B?Q0JkMlp4UXV5TGlFcjZoSXBheXZNOFFuNGpadmtQMzZKR2EzMlhJZ0NoSmJX?=
 =?utf-8?B?VSt3dzJ1QmVQWmRNTkVXWWlETllLOW5ZMWxvNXptRE92OFlBWllQeVlENDJO?=
 =?utf-8?B?Ly9YQ0NNeEh3OEdINTNOQzgvRGhpN0h4aWxrZEc1dDdkVm1QTlJQNDNnSE9s?=
 =?utf-8?B?MllITHhHa0NUa1NITTNHcGVvYldPNnZ3WmhnZ1RYdzU4Sk5VNTExYStiUEhx?=
 =?utf-8?Q?ZhncU0jGL3RDqcV7dDZ9xOe1a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fr+Ygoy8taIJa0m4R3wHpUaAT74VfpCqufPJ8nIJosHZJyDzgZ4nQw5/kuEAcUNAp+qedPysuEipUp3SvLrjQ6dhHpttAb8/mQIYxGDaUP7voRhbhJYHTnhXv1nPa68jViQ+XVvA5wXM7aioB32sPYL3FUZ5FTrPoRtevesgPKX1dE4NU/jDtUxQvlNllrhwgV6ZwE3HrKWW3i4QleJC38ydhTPPus21bzep4WIKNAqPJgItYTtCVeCMEPetqsrASJcXYKBCPmz9SOa0QnjFoJM88C+aK9FA/QGARszhJzWgcksz29qGNX9Hfbz6o7ZWfbofNKcVX7NfK9bYU8uFZg1IJUpp8K1GGbfUwFOksZm0ynGwq60rOYYPkbL83FPsAXViFKOMne6XAqmpIBdy2vOpztsX8l7io0a6ssDIPYpkokoAXPzbFirySYkEabi56lnXTQkUHGZCSGPWIrAE8kCHk0u/HAbrujnNqnXhBWe4yBFIMZAYs1YK6k0srNKPIlhLZy7mFo+pSvjitIqdKAm/Iuo2XLgBNFl6PIX0m2IWiy0OlU50mB21diou7lmBkGo6g3sQ045Ol+Hr7NJ7pTv93bmSx46p6/5Zh4J0FXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fca007-7e00-4aeb-a46b-08ddea4a6d59
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:59:14.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm0SdRvIn89PDawn/H3YOQUw5XJjX6c/le4vxK8L43avbIxsIT8r00jV49cnvMAqZayNpZJU82c0cDF8S/pm/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE06E70EA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXzO87pTY78SH2
 p7BeKMyxVTUYw1AV5clIpJ/rDrqEnU8NXW6I8+sYmunZmBOza2nEEmZKM1nKhoewoxWXGYkIi44
 VCd8YbMI1MOqxaUyflcxn3RPRVYaGTBTv2O44tZVT8SwpGIBU354wLmY9YljCm2Cm283Hi9Xr8K
 ShQvKpZ6x59DbBKpy0CWvr6UjyJSVZA5r5ZwjrCK0F8Lr8/PFmaDkBN1gDyTWTIPIWzPg+o/Yk6
 HveQtvgM8Tv6AZrWI2CeVH7tOtDB8USe2ozU7J9oqIVSFGX+X549ugi6nXyZ0vwOq8e9jfcQKQG
 nA5YCKVcGeumaU7PSJVXMUAs89mWazcfcXPProKywDsFbUMPrhUFOZ9Y3Q/obDTQegTM+McE5i9
 jdTDy2uooX6fswHJzkSTHwgh4CTk5Q==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b73075 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Lb1rMZzfAAAA:8 a=ZXzeNm7XfRyVrraW-2MA:9
 a=QEXdDO2ut3YA:10 a=8TJlWAxZIw_9ZYUv8NPp:22 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: 7nxsUiF9WFwOro2I0V5G_4b-saxcxkvB
X-Proofpoint-GUID: 7nxsUiF9WFwOro2I0V5G_4b-saxcxkvB

On 9/2/25 11:56 AM, Chuck Lever wrote:
> On 8/30/25 1:38 PM, Mike Snitzer wrote:

>> dt (j:1 t:1): File System Information:
>> dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
>> dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
>> dt (j:1 t:1):                Filesystem type: nfs4
>> dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
> 
> I haven't been able to reproduce a similar failure in my lab with
> NFSv4.2 over RDMA with FDR InfiniBand. I've run dt 6-7 times, all
> successful. Also, for shit giggles, I tried the fsx-based subtests in
> fstests, no new failures there either. The export is xfs on an NVMe
> add-on card; server uses direct I/O for READ and page cache for WRITE.
> 
> Notice the mount options for your test run: "proto=tcp" and
> "nconnect=16". Even if your network fabric is RoCE, "proto=tcp" will
> not use RDMA at all; it will use bog standard TCP/IP on your ultra
> fast Ethernet network.
> 
> What should I try next? I can apply 2/2 or add "nconnect" or move the
> testing to my RoCE fabric after lunch and keep poking at it.
> 
> Or, I could switch to TCP. Suggestions welcome.

The client is not sending any READ procedures/operations to the server.
The following is NFSv3 for clarity, but NFSv4.x results are similar:

            nfsd-1669  [003]  1466.634816: svc_process:
addr=192.168.2.67 xid=0x7b2a6274 service=nfsd vers=3 proc=NULL
            nfsd-1669  [003]  1466.635389: svc_process:
addr=192.168.2.67 xid=0x7d2a6274 service=nfsd vers=3 proc=FSINFO
            nfsd-1669  [003]  1466.635420: svc_process:
addr=192.168.2.67 xid=0x7e2a6274 service=nfsd vers=3 proc=PATHCONF
            nfsd-1669  [003]  1466.635451: svc_process:
addr=192.168.2.67 xid=0x7f2a6274 service=nfsd vers=3 proc=GETATTR
            nfsd-1669  [003]  1466.635486: svc_process:
addr=192.168.2.67 xid=0x802a6274 service=nfsacl vers=3 proc=NULL
            nfsd-1669  [003]  1466.635558: svc_process:
addr=192.168.2.67 xid=0x812a6274 service=nfsd vers=3 proc=FSINFO
            nfsd-1669  [003]  1466.635585: svc_process:
addr=192.168.2.67 xid=0x822a6274 service=nfsd vers=3 proc=GETATTR
            nfsd-1669  [003]  1470.029208: svc_process:
addr=192.168.2.67 xid=0x832a6274 service=nfsd vers=3 proc=ACCESS
            nfsd-1669  [003]  1470.029255: svc_process:
addr=192.168.2.67 xid=0x842a6274 service=nfsd vers=3 proc=LOOKUP
            nfsd-1669  [003]  1470.029296: svc_process:
addr=192.168.2.67 xid=0x852a6274 service=nfsd vers=3 proc=FSSTAT
            nfsd-1669  [003]  1470.039715: svc_process:
addr=192.168.2.67 xid=0x862a6274 service=nfsacl vers=3 proc=GETACL
            nfsd-1669  [003]  1470.039758: svc_process:
addr=192.168.2.67 xid=0x872a6274 service=nfsd vers=3 proc=CREATE
            nfsd-1669  [003]  1470.040091: svc_process:
addr=192.168.2.67 xid=0x882a6274 service=nfsd vers=3 proc=WRITE
            nfsd-1669  [003]  1470.040469: svc_process:
addr=192.168.2.67 xid=0x892a6274 service=nfsd vers=3 proc=GETATTR
            nfsd-1669  [003]  1470.040503: svc_process:
addr=192.168.2.67 xid=0x8a2a6274 service=nfsd vers=3 proc=ACCESS
            nfsd-1669  [003]  1470.041867: svc_process:
addr=192.168.2.67 xid=0x8b2a6274 service=nfsd vers=3 proc=FSSTAT
            nfsd-1669  [003]  1470.042109: svc_process:
addr=192.168.2.67 xid=0x8c2a6274 service=nfsd vers=3 proc=REMOVE

So I'm probably missing some setting on the reproducer/client.

/mnt from klimt.ib.1015granger.net:/export/fast
 Flags:	rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
  fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
  sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
  local_lock=none,addr=192.168.2.55

Linux morisot.1015granger.net 6.15.10-100.fc41.x86_64 #1 SMP
 PREEMPT_DYNAMIC Fri Aug 15 14:55:12 UTC 2025 x86_64 GNU/Linux


-- 
Chuck Lever

