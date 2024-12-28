Return-Path: <linux-nfs+bounces-8834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFC9FDBC1
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E951E1882B1C
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251EB18EFC1;
	Sat, 28 Dec 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KmnDV8Su";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y92NJhBx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882D18C939
	for <linux-nfs@vger.kernel.org>; Sat, 28 Dec 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735407223; cv=fail; b=njYUiR7edzjfh1pjARkLKXMxCkw3LUWI5FWG8deDf8msepi+SjhFqJWkjr358WVPkR3dOfMcX0h9O0Qe8fwyOh51StKTFg4XBmMApkb+YbKZ7OGEqh1cPncWqleM4ALRXWVmgroFd4gocpgEQhkM9Vfu+HwLA6vHhZiQZHz+0fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735407223; c=relaxed/simple;
	bh=5drXL14jebEYngthDf3n64DgP4GnCNX2cYFyBZCAvnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WdKGyqyReTVHOWNDMxu0rJtQ4aeWwFb1Ajx53ZMGaglq9M3dKLojuL4LGDOrDX8RMF1/5AUaaJDXJ3/md4Ja3o+A4jiRJJUomcxwI3eKMGDw3mVaW/DqEtgKe+aqBzKFL8dejPtIdYvdDiO5SrW0p/3+zsNzb610CpgdDRbvfY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KmnDV8Su; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y92NJhBx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BSGTQnX019244;
	Sat, 28 Dec 2024 17:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Jh6E6huDm67WxO08+bkTjWxIbM4fmNci+QQYumsEXdM=; b=
	KmnDV8Su4eG2L4f+CzYjKEZQEJ14Bc74xmKJIPrFyXY+/aPOEnpGVUBnIQCg9EYx
	LrDrF+E3W2Kopcbp6CowOM0AzhMSJm+P1rQD7LcL8gTP3BRhDnV0exnZlfAgyVLo
	4KOtDGRFJcXvGlISXWqkSu+gFgKhjbyfOxqR0wUj1fqaPpTItZLTO4DtBK/2j0El
	sDHwKWp5iZAqQm8qbPFXJC/VIo8oGd5xcXpXCUZKS7kdm6Z/gQb3Y2fGPhQCyun5
	tTwgQNt8VNIn4gi4ZP6zb+tTtAILANiUXfFcFzhJ2jZVwc/oGn8OE1caWu8pELqw
	YG7GYc4/dvq+XQkeReltPw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9ch8d6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Dec 2024 17:33:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BSEIrFa012403;
	Sat, 28 Dec 2024 17:33:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s5b1nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Dec 2024 17:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWmUrqupT7v1+Chf+7KUD0V8Ay0eUMJaFX4sk2JSX3HJ7HUxfBelz2iL0lhNWzPwhOej0tUR0pj1+F0xCieVjWCzqJ6x2RV+a4l3/0wzKKxeHNi392jP0/3VpPS/bAkemxCujeMehTaghrjBq/QA4BW2FMC8YXLQ4PWNVFemTIFMzDD/QAFwXg6Q659kyu5UXZmW0ggT7t4CGEPX+msQcmYP+cDrNj874oyPFF8ia0IYYpqrEz9qJPOS/Jgli+t3HkKgw0pFXDAeH+KLmpCY1lHrAoBRyZnDUlccbmTEhu5W1jqxduQHZEX5uCDDIFlxSxeMCSQru5Ab6wK1NbybTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh6E6huDm67WxO08+bkTjWxIbM4fmNci+QQYumsEXdM=;
 b=ystR+7CTrH8+tznokWwAwbras93lXA6ylgSPlvaPn9+ajPRF6XbyNfDLIV45NmSPbv7hnJABivXaKF6qMssUodt9iXLYDTvO9lyCEDQMg0BSkEeXi+3dO6GKcYfpwIxn7C3UGjmXkcI/PdRk8xtBD5+nJAusuaYytxJOjuzS8X2VneiOnGgPpjgOxGhEoyVSwE+ue0Nw0kaeUy0/O7lMxlNvghGZdktP+cvNwwqDVq0lpx+gOIZGotOqs7mgxzDsOlbW5hq24iouzaLleJq4p/wOTLDyfqLBWjHWbyz18BjWA+tD+1gyz5HAVb66IFghPQGIxIE6Yzfup9R4mb+SKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh6E6huDm67WxO08+bkTjWxIbM4fmNci+QQYumsEXdM=;
 b=Y92NJhBxoZmNGEm+ACnBBkmjZO6c4tZQk88bShW1pGzCP+UEt/ezZcxXUtgTepwUNHSMFOPW80pJmKzvg+xxK1vlJ8GONbbSBBEEb+ZOz2zEVHj7AC3gcLtj1ws/5p5CQAdHep+UhUhQEiZiWCIB74KHjKrBPDywbQIqy+kPOuE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4927.namprd10.prod.outlook.com (2603:10b6:5:3a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Sat, 28 Dec
 2024 17:32:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 17:32:58 +0000
Message-ID: <eafd5b52-694c-4abb-8c2d-84094def4751@oracle.com>
Date: Sat, 28 Dec 2024 12:32:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [cel:nfsd-testing] [nfsd] ab62726202: fsmark.app_overhead 186.4%
 regression
To: kernel test robot <oliver.sang@intel.com>, NeilBrown <neilb@suse.de>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
References: <202412271641.cfba5666-lkp@intel.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <202412271641.cfba5666-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:610:32::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 27617550-4ef3-4a7f-ed06-08dd2765ab88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDZHT2NwZm9UY3pmVGVlNFdGWnhLaG1HL2pyRFlVVmZhNTBWaVg1bDUxcmhk?=
 =?utf-8?B?MGNKek1sTDBpSEJuckFva1l5WGlCMktIRDNiYzVtbG9aaUhKNW42VHBmd04v?=
 =?utf-8?B?dFdNNEo4UjJLalVHVEZzMWxMUUZudGlDNHdITnlmdGIxMjJsTytnT2tWZHNQ?=
 =?utf-8?B?aklHSTFCaHFoZHMrVG5xUWRQM0YvRTk2d1ZtS3l4aS95U1lwWU5uODI5TUtJ?=
 =?utf-8?B?b0Qva2VnUkozWkZ0bFEvMHdKMVpZTFRGNVBONEJmSk15Zm02L3JOVjZreXlt?=
 =?utf-8?B?Nk4zbWpXQXkySnE4N2d4M2xzL0hPcWlzUUZOd1ZpRGtxQ0pReGRTYkx2V0dO?=
 =?utf-8?B?WDBta0VoYlQ5dHZ5aXZRS0k4NGJoczNIRkNZNzUzamk3bU1tMVZQV1B6ZHkw?=
 =?utf-8?B?R1ppbjR0Qm1iS0xRS2tKeFpORnFVODYydXJ4aEdJUW5CUHFRWVMrTDhUTkps?=
 =?utf-8?B?TVdwSkt0b1VYYmxZWi9lVk9pa2pmOGlkbkVqQmlMQ1lXWjRSR3hILzJNUHpH?=
 =?utf-8?B?ZVIyQ0hES2N2SXdJZkxoMHFnMWxjS1MzcHhlWURlaWZBSm00Y1J4TGpoOHVx?=
 =?utf-8?B?VVlJMmtURHZWVFJGQURobElYZVhPNTJrcTFvQzZnanBmeHhvOWw3bWY0Ymwv?=
 =?utf-8?B?UlhCME81WWh3LzQzSzVPVnhORnFoN0FlRzRGYWNvdzA4bjhRMWZmL3IwVWZo?=
 =?utf-8?B?Rjk0eGxKM3hiYXBYczRBbmlvR3JGalBxZlkvWkxMaENLVUd0SitVeHdrRnZK?=
 =?utf-8?B?cFdGUERUc0dqZVZrWVlNWVlpWHBnbmg1a3FjVEI0d21Ha2dINVoxNEV2cjk0?=
 =?utf-8?B?cW1adGs0bEZWQXJQYjhnSEwzZ0YxczRJWk5qcCt6KzRBNS9kb1g2Zkt4eFl6?=
 =?utf-8?B?QkNPbTlrcjZRR0VoMUg1SGlHbkxNZmZkRmZJK1FrZnh6ZDNFODl5OGI3aEFk?=
 =?utf-8?B?Q0xGWmR5UEE5dGVKc1FaSmVJeW5iWFh4UWZsVDYycDRPSjBka3Z6R1BtVnRK?=
 =?utf-8?B?K1Rmb3ByeEdodTNPS256VlYyall4ak1OWmkyVmpzYUFOeW9SWUxuSUJRblEx?=
 =?utf-8?B?WmZyZjFsaWgyMEtad2IrMVpCOSs0ZVpBZmg4ckdtVXI3dlNnelBuMGkzL2Jq?=
 =?utf-8?B?ZWFXcW02dEpQUWN3M0F3TGlhT0p1MjJRZkRtQ2FFdWk3MUFhby9ydTlOK1Rs?=
 =?utf-8?B?SmltUlZUZEpHNGFFeFBXNEh0clRwQmg3QXVMV1hYK2Y5Q3hjTmZMUlE5WUJk?=
 =?utf-8?B?NkZNa1NXY1VVbWM5dXYxTWc4VTBTTFRTVys2dllpdGxlTUxpcDNMS2NUTGFo?=
 =?utf-8?B?Ky83bG1lQjcrZzhUZVl6MmJCUitiWGVtek5RRy8yWXRXQTJScmZHVTloMGs1?=
 =?utf-8?B?a1RSam1rVER1cmxvSTdJT2J2UDlabTIzRmZjMTRLSUFJdFRoWWR4ZVJNbmhG?=
 =?utf-8?B?MCtBaGpsOEpzRDMzdDNxenFLM1ljb3U0eVFoNVVjYWdCVHdrRllHYnNXS1VS?=
 =?utf-8?B?UTZYeHZEQmxmbUtiSitubkM2S2lIUTQvR3RLR3hsYzNRVFJEUmFqdklDRWI5?=
 =?utf-8?B?RWczTXlVL3V0Mkk2QUNqNlRNYmdBNlVOYXhqa2p4SjIwNmhWM0tiME1Sc0d1?=
 =?utf-8?B?dVRqVnR2T0VaN0loV0JZY3U4b1NXc0wreFhhZWF1ZFd6Z1IzS012QUdrbmZF?=
 =?utf-8?B?UmExcE5hT29EMksxVWdkUzRyUExFR1ZMV3pZY2owcTFFZmx4WXFxb0xDTWIr?=
 =?utf-8?B?ODIxcmlVTXFjbnI4UGs4eXdxUEtKNEZzYkt0b3NwNGcvL0JDOHZVQnBrYS93?=
 =?utf-8?B?ai9COVk0V3JWVVgwUTg1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmlNK1FOcVU0a3poUzBJdVBvL0RwWlZjOGR1VTBYdzB0VnArbm9hTklFSmJw?=
 =?utf-8?B?OVpMYmZVbzRqaDFWeHV3eGk0U2liTDdLRUdvdXJTdVlEaGIxTmVaTC96ZDM5?=
 =?utf-8?B?TDJXb2UxQ2RFQkgvcUF5cWJNcDF0WUJRWWtId3FsWTNHYXVMckVKc3I5ZmdD?=
 =?utf-8?B?OU5xQU9JNFkzU2xSUGthNE5xT3J0ZElWUXo5UkdrRWdBS1dFWGdSMWhISnkw?=
 =?utf-8?B?QzJqUVpTaDdoblZFOEIzcHl5SnpHT1ZPR2Z4c0xObFJaS3BpLzZ5K1I1OUNz?=
 =?utf-8?B?NkdUVkMxaHpzdDNuS3RXaDVwcEQ3Wkp4Q2lFYXVaNnFSanBzUUUxd3R1WURU?=
 =?utf-8?B?ekM1NkdJRm0xNVBzaDRFaGh4SmNNMFQzSjVwYXpFTnVoRXBpdFNQTnlvVDVi?=
 =?utf-8?B?eWkyNFl5SDFQSy9aa2tyR1NpUVpBdC9CR29tZ0RHbkoyWW9pd1N0ZmxYTDd5?=
 =?utf-8?B?K1krbTFwS1R0UW10aWNRYU9lZjVOYlJTYU9pNDBmbEVjWjQ0TDNXUWNaUzhZ?=
 =?utf-8?B?c1JUV016Z3RKVHA1VFRCTjlXQ3ByRGYyVHREaW9kOWZpcDFVSE0xaWJpclJt?=
 =?utf-8?B?czErajh2TE9UTnhUbVNaN1ljeURUcW9SLy81bmdjZmxRZUtOWHdiQzhTMGhC?=
 =?utf-8?B?Kyt3OXlIT3dSSFM5R2lsS01xL0ZKZW55U0RvMTZxUUU5aWZuSmtzSEt0VFU0?=
 =?utf-8?B?UGRTaE1IdFlDZU1LTUw0amZCa1loNUZBeUlWMmFYaHR0VGdMbXBnMWJHYXRK?=
 =?utf-8?B?dzdSeFo0Wms2bnRkeExGRVZNVjFVWWdLd0JxMkZZVkE3dllDbVVuMnJ6aURq?=
 =?utf-8?B?WmhYVTJoNklDNStEaHB2NEN0dTVSaE5PaXNsL1l5ZkdPVytwcCsrZERQeVF2?=
 =?utf-8?B?endvMGJzRXkyQ1ZnUGNGb2JvV3I1UHBtNW0zU2ZyUzhxeFh2WGcrZDBUd2xW?=
 =?utf-8?B?WEUySVFqR3V2aDI4UGNtZklSem00MUxjUFhySHdoajl6dWZ4WjVDY0pZMEhJ?=
 =?utf-8?B?RU80QTV5RjF3aks5N3hVT093anJVS3hxTWNqa0p4SVBKcy92N3ltaVdGQVdV?=
 =?utf-8?B?Q2ZsTjZvSFVGSkVkRHdmaHQzbEV0Smc1T1kyMXBQSm5kRWpvdW8rSkFheFkr?=
 =?utf-8?B?R1lLaWIvSzN4cm05UzM4Zkhrb3hYK3p5U1B4MHF5OXFzYWpIRjUzSC8yRkpZ?=
 =?utf-8?B?cmc4T0RONkxtN3d1VlErVmNScXpXclhGVXNSKzNRTzFKTnF1c3lrT3llRllH?=
 =?utf-8?B?VTlJbVVORFMwTUFOc0N2VEFRWVJYSHMxYUpVWWI5MXNVVmFVMEJCQ1FWMmNi?=
 =?utf-8?B?S1dGMFhWaGhnWC80ZERKRWRrSEFhNWJFdFA1aXdyOEUwOUI5VEZEeEJURzI4?=
 =?utf-8?B?ZGZMQThWTDBkd1F1djhoL3JqekVwOXpDaHBsYm9VSnQxZldJdnRBU1o5RFU4?=
 =?utf-8?B?bmpQb2tUbldFY2czR3dESWlyMGtKRkdXMlp0Zm81Wm94aTV4eVZxLzF5NEZ4?=
 =?utf-8?B?N3ZIWkI2UjhaYloyVGNiTVpTVE9XKzZ3S1c3dTc1a1RleEs5TnBFRGJDZCsy?=
 =?utf-8?B?U0lJRVBESERBS3hzcCszVSs0WVFmSHljbE8zeGNlQUovK2RrVHNManQ3Mkpz?=
 =?utf-8?B?S1VVVUhrVUJLZFNEc2VsTFdPSkpBZGlmYjVubmNiOHA2Qmw5clViNmJLQUI5?=
 =?utf-8?B?WTJxSGV6ZzBQK1pNUkVXTisySUN3Y1BOdS9CMVlmY0hLOVVnaHlaU2t0UHh6?=
 =?utf-8?B?aHVhSnhMMkN6Yk9qUWQxdXpORythUWhpVDdCNWdCcEl3R1BQZktlZkNCVVFv?=
 =?utf-8?B?WmtaQnQ2YU1xOCtQbnJaREVKMEUyRGNvSm1WNGtJNGtPT2tjemUvclIzdHJw?=
 =?utf-8?B?U1hJSTBNem42S0dBcWwyN0pXN0Q0ejVyeXhXSnM1ajB4V1Z5K3Uxd3RHMmt0?=
 =?utf-8?B?R3B1NUZPdjhHaTNVbEU4bDNHQUFMalhLOE5jSFhrblo3S01uTzZ5M0srUWhx?=
 =?utf-8?B?ZjlXTHJZZlVlRStianFnbDVzOEpjb0J3SjVMTmVFeVRTRlFSdU1vdXFuZWdp?=
 =?utf-8?B?TFFwdnBkOWhsdHFsWnczbzY1ME9TUFhOeVNjU2dCOW1hSk5paHpzSE5DcHM2?=
 =?utf-8?B?c1FLZ3hNYkw0bDRzbVB0TURhZkdjREVkS29OMjJsa3VJdnBqTEZGazRMNlNw?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1d7uF+dgQaoZr55+89pftbqbkoqNnu/pFco0oe9oPsy+5HYaPRP3DLUFtknut4NZi5DT4MbNrDsjiquJBWuwAfrHmSuI3TRcM20F0vg0vRW706MPqK1J2xGiKjQZJI6K42FCA06YLeYu5s3Y9dF//2eomjnlPoSujyyj7I8ZXdlP2DlUvfrh5RfjYdY8qBf59qYOJ3LqLKsPK77P+/P3CoQpJzaQD0SsfKDDAlvrRkOauDWUJGzRhEe7apGQEIsGLywKVFb0inFEdKwiu9Ikw40+n0sUEheOkRA3zsHWInHA76pVkcwWGzwiNPHf7qChX8Vr9jOU4vRRexlNna9sTo8KsoIWIsWR+NRMMZ09GvglNnkP1mZi6ErqSCbuWN61WEhIXDEYsIO2GeWCDkhO3uQxAlLFxWFNJ7rNYcTLxHQH1fG+FdcCBJ+C3dC1LYSK5tlw0ATtAFaxgVcyLuaEt72idiEZpmh7iPhaNCUPSs6Ngcw2O8/LzmcuUQGBFl1v1u95/RzHtFW4srknCduYvcAGEnkDUW/BK1jtPXolTC855/kZx2ASQRrVyESQ2zAr5vMY6HeYtZllsuFAaNdIlCXdsYB02S0p9UeQ7OUhJgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27617550-4ef3-4a7f-ed06-08dd2765ab88
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 17:32:58.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC0mjhALirPKbh2IXydX0LdYWCQb7PhxiJr8ThR7pgTPncqe2gph/wyxW1q1RplSUqMpCXfew5tbbhGjrzlgCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-28_04,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412280150
X-Proofpoint-GUID: YmY__AEuCpQ-8IcineVYo3kc54iagzXj
X-Proofpoint-ORIG-GUID: YmY__AEuCpQ-8IcineVYo3kc54iagzXj

On 12/27/24 4:13 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 186.4% regression of fsmark.app_overhead on:
> (but no diff for fsmark.files_per_sec as below (a))

Hello Oliver -

I have questions about this test result.

Is this https://github.com/josefbacik/fs_mark ?

I don't understand what "app_overhead" is measuring. Is this "think
time"?

A more concerning regression might be:

        13.03 ±170%    +566.0%      86.78 ± 77%

perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_tcp_sendto

But these metrics look like they improved:

         0.03 ± 56%     -73.4%       0.01 ±149%
perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
         0.05 ± 60%     -72.1%       0.02 ±165%
perf-sched.sch_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit

This is a quite mixed result, IMO -- I'm not convinced it's actionable.
Can someone help explain/analyze the metrics?


> commit: ab627262022ed8c6a68e619ed03a14e47acf2e39 ("nfsd: allocate new session-based DRC slots on demand.")
> https://git.kernel.org/cgit/linux/kernel/git/cel/linux nfsd-testing
> 
> testcase: fsmark
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	iterations: 1x
> 	nr_threads: 32t
> 	disk: 1HDD
> 	fs: btrfs
> 	fs2: nfsv4
> 	filesize: 16MB
> 	test_size: 15G
> 	sync_method: NoSync
> 	nr_directories: 16d
> 	nr_files_per_directory: 256fpd
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412271641.cfba5666-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241227/202412271641.cfba5666-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>    gcc-12/performance/1HDD/16MB/nfsv4/btrfs/1x/x86_64-rhel-9.4/16d/256fpd/32t/debian-12-x86_64-20240206.cgz/NoSync/lkp-icl-2sp7/15G/fsmark
> 
> commit:
>    ccd01c7601 ("nfsd: add session slot count to /proc/fs/nfsd/clients/*/info")
>    ab62726202 ("nfsd: allocate new session-based DRC slots on demand.")
> 
> ccd01c76017847d1 ab627262022ed8c6a68e619ed03
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>        5.48 ±  9%     +24.9%       6.85 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
>       12489           +11.1%      13876        uptime.idle
>   3.393e+08 ± 16%    +186.4%  9.717e+08 ±  9%  fsmark.app_overhead
>        6.40            +0.0%       6.40        fsmark.files_per_sec     <-------- (a)
>        6.00           +27.8%       7.67 ±  6%  fsmark.time.percent_of_cpu_this_job_got
>       72.33           +15.8%      83.79        iostat.cpu.idle
>       25.91 ±  3%     -44.3%      14.42 ± 11%  iostat.cpu.iowait
>       72.08           +11.6       83.64        mpstat.cpu.all.idle%
>       26.18 ±  3%     -11.6       14.58 ± 11%  mpstat.cpu.all.iowait%
>      153772 ±  5%     +19.1%     183126 ±  8%  meminfo.DirectMap4k
>      156099           +19.5%     186594        meminfo.Dirty
>      467358           -12.9%     406910 ±  2%  meminfo.Writeback
>       72.35           +15.8%      83.79        vmstat.cpu.id
>       25.90 ±  3%     -44.3%      14.41 ± 11%  vmstat.cpu.wa
>       17.61 ±  3%     -45.8%       9.55 ± 10%  vmstat.procs.b
>        5909 ±  2%      -6.2%       5545        vmstat.system.in
>        0.03 ± 56%     -73.4%       0.01 ±149%  perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
>        0.05 ± 60%     -72.1%       0.02 ±165%  perf-sched.sch_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_commit
>        0.07 ± 41%     +36.1%       0.10 ±  8%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
>       13.03 ±170%    +566.0%      86.78 ± 77%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_tcp_sendto
>      206.83 ± 14%     -31.5%     141.67 ±  6%  perf-sched.wait_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
>        0.30 ± 62%     -82.1%       0.05 ±110%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_check_data_free_space
>        7.37 ±  4%     -15.8%       6.20 ±  4%  perf-stat.i.MPKI
>       44.13 ±  2%      -2.9       41.25 ±  2%  perf-stat.i.cache-miss-rate%
>      103.65 ±  2%     +17.9%     122.17 ±  8%  perf-stat.i.cpu-migrations
>      627.67 ±  3%     +25.4%     787.18 ±  6%  perf-stat.i.cycles-between-cache-misses
>        0.67            +3.7%       0.70        perf-stat.i.ipc
>        1.35            +2.2%       1.38        perf-stat.overall.cpi
>      373.39            +4.1%     388.79        perf-stat.overall.cycles-between-cache-misses
>        0.74            -2.1%       0.73        perf-stat.overall.ipc
>      102.89 ±  2%     +17.9%     121.32 ±  8%  perf-stat.ps.cpu-migrations
>       39054           +19.0%      46460 ±  2%  proc-vmstat.nr_dirty
>       15139            +2.2%      15476        proc-vmstat.nr_kernel_stack
>       45710            +1.9%      46570        proc-vmstat.nr_slab_unreclaimable
>      116900           -13.5%     101162        proc-vmstat.nr_writeback
>       87038           -18.2%      71185 ±  2%  proc-vmstat.nr_zone_write_pending
>     6949807            -3.8%    6688660        proc-vmstat.numa_hit
>     6882153            -3.8%    6622312        proc-vmstat.numa_local
>    13471776            -2.0%   13204489        proc-vmstat.pgalloc_normal
>      584292            +3.8%     606391 ±  3%  proc-vmstat.pgfault
>       25859            +9.8%      28392 ±  9%  proc-vmstat.pgreuse
>        2.02 ±  8%      -0.3        1.71 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>        1.86 ±  8%      -0.3        1.58 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>        3.42 ±  5%      -0.6        2.87 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>        2.96 ±  4%      -0.4        2.55 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>        0.35 ± 45%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.khugepaged
>        0.34 ± 46%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
>        0.34 ± 46%      -0.2        0.14 ± 71%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
>        0.34 ± 47%      -0.2        0.14 ± 72%  perf-profile.children.cycles-pp.collapse_huge_page
>        1.21 ± 10%      -0.2        1.01 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>        0.82 ±  9%      -0.1        0.68 ± 10%  perf-profile.children.cycles-pp.update_process_times
>        0.41 ±  8%      -0.1        0.29 ± 22%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
>        0.21 ±  7%      -0.1        0.11 ± 73%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>        0.55 ± 11%      -0.1        0.46 ± 14%  perf-profile.children.cycles-pp.__set_extent_bit
>        0.33 ±  9%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.nfs_request_add_commit_list
>        0.17 ±  9%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.readn
>        0.08 ± 13%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.load_elf_interp
>        1.00 ± 16%      +1.2        2.18 ± 53%  perf-profile.children.cycles-pp.folio_batch_move_lru
>        0.21 ±  8%      -0.1        0.11 ± 73%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>        0.05 ± 49%      +0.1        0.15 ± 61%  perf-profile.self.cycles-pp.nfs_update_folio
>        0.94 ±  5%      +0.2        1.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        0.25 ± 17%      +0.4        0.63 ± 61%  perf-profile.self.cycles-pp.nfs_page_async_flush
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 


-- 
Chuck Lever

