Return-Path: <linux-nfs+bounces-13516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3CCB1EE1D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D599F1C27ECE
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9B61F4621;
	Fri,  8 Aug 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BigrySiL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wlxe4UfM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB65CDF1
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675943; cv=fail; b=WaaR1kCTSHnGA5lv6/P/kRajVW7jCahkgzy6j70hswA5vtNH3jFPgde35IxJ5m6UVwLjASqA2qM+Dd9JfFBmBWS5nm0JWfTdOskNiHp3F/9NfV/RFVqpGVtFS46olFtelVa9TW5jo3XRgkrxAS3VCMcaEtCZUhbx1zMGULX1Ntw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675943; c=relaxed/simple;
	bh=C7TApsfSNM+gnEVMWG4xGUHgi9/asZjJrSXTU1YcpcI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CIh847CGQs/ox0aYifAfupo/kZ7mLCg9WgGEm9ZHCjA7AFYynQBqUB9BOYQQFPsbyhwh4wVZqjtgepYsOFsCXsGs6mVThsI2ewdAGDh4JJWZ4wO3hYVm8X5vaA8CAmG+I/3QIrKeLdyhhCtJVZlovoJ9w9XA5ygLQ808IxdBAPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BigrySiL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wlxe4UfM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578HvTLM005092;
	Fri, 8 Aug 2025 17:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+tKJBcp/TVzRKqcvrum9s9P1IFtLYcG8Q9oS9r1uDb0=; b=
	BigrySiLLJQ28n6wHxdVPS7FxkiJefLpfd+NcTwqH6DlaQznWvQLvfVXcq8+x72b
	i8MpYL0UoihiAlKCJVoIkuzJjUeW1Zc8JjOOk+fk//6OKgt4d6YLQB8+WUHRIpsd
	F+w9IctYZdD1tettnTLZDubnzjWyls2tCwevbvBzVrTfchuQuC2bSsCqcCW9ul3P
	txKhibLpkTTBideUeafgOF1L2A1lNrXvR0NBxzeP03ykBWd8vSwTrquWoC5TMBIp
	lzvsk2DjFpdeVrA+u7feMkYYCosohyd5624nb9KVDqOvsWLLD1438qubrc3rMRGS
	8WEw8gKoHWsILV2FgVoBgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgxyp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:58:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578HXxsU027065;
	Fri, 8 Aug 2025 17:58:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwr1dm0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QliqyMf49o3Ngvj1Hi0MDbqJgAzhJuaSzII69itk/8c3cTTvZxmCy5FE1Ng+nrCdmlz6RtBnBhGDM7+Wp/GjSFGM47a+3ayujAniJ+tTTQSrZJbUHm5hK+SVw55ISKoWyrzoz7cKD9B6cZTKJcbqKuRt5H+18y+JkjTHSvK25mEbOgSg5LNQkj8W3G5h6cXsGVke56gfM1+tmMHmsxJRTx5cive7h37XKU+Fh3ascQgYdNG7ioK3VI/xf0Vmuj1jcBthR8i6Xtl55K1+KC0jCN/1gQd0Jy7jipHfo1+cNjf/TXjix5s/dDMAeZInU5TK3cZjQ037ZtNkKgjFRp+CKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tKJBcp/TVzRKqcvrum9s9P1IFtLYcG8Q9oS9r1uDb0=;
 b=XaeH7GPhRx9AYrw44WWcXFA1wyFCrOLTj0wjotmGEGakrd9Ylet3EiSTBtXWkEIRiFHTbaFlq5SCMdaJSNXQrRV0eTwcVjGmv06XjxizhR6I9XJbK1AHPiOOVatbhd3W1FwXxHArw7tmE+bkWP6NPmQUYNIQq4UfdPzezmytqF1iZJaewWeh4bOjRuaDV0uEHuo1F+ISrMlbDbQuRo7hW89aX/g991eY3mn1+tg28XvJXuOumlTZjuqrQI/P3nfm7oEbzO3u5EkvVOF0bV38XlnpfAOwy5UuGVLpT9kiNPfynNqAKMr5NJfX57QAc7BUqNsZtk0hvyeDcbz4QbyUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tKJBcp/TVzRKqcvrum9s9P1IFtLYcG8Q9oS9r1uDb0=;
 b=wlxe4UfMIbkyTSWpuKMCwy3Ng2wAIdIx0J/smFIZWNP7Woe2ZMp1FUT6JCR8DuxR0rY47FwYLcg8o/6wsmI2YLN6PRVCaXfOFYpjlf0pUBHXHn9/2p4f8CfxyOQtGBTmtpFr3qgQRzIArG/SGRV2g/oTZDPUHu2vmdzJ+eXpPMo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPFA634C6E92.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 17:58:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 17:58:56 +0000
Message-ID: <bd8f7924-7d5b-431f-b90c-49f73f70619c@oracle.com>
Date: Fri, 8 Aug 2025 13:58:54 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 4/7] NFSD: add io_cache_write controls to debugfs
 interface
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-5-snitzer@kernel.org>
Content-Language: en-US
In-Reply-To: <20250807162544.17191-5-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:610:57::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPFA634C6E92:EE_
X-MS-Office365-Filtering-Correlation-Id: 4789e266-83c6-4dac-1237-08ddd6a53e4e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aDdJdHFsdzR0dFZNTkd5MStHUHVISmFKTGk5QVhEdi8yY1pBb0RiSVZEbGFm?=
 =?utf-8?B?SnFqcWYrTGN1a3pxN1BRbEJESTNZelRZU28wb1ZiL2cxeEwzemtGTjgyVGpP?=
 =?utf-8?B?QU1PVGQrTWl4OHZNbDkyWTZteEJZU1graFBESjNIT0hCa3JwTExLYW1DNzc3?=
 =?utf-8?B?M3lOSDBrRm9yaGVwNy9aUkdBSEgxUVFIM2dlN1dGdm41SjBlUGJSSFFIdnhU?=
 =?utf-8?B?NTRnOFM4UWNlQkk1azZFTHdkeElUWnhkbXRtbGdVSTZvTlVoNzBobE5FOHhF?=
 =?utf-8?B?QTB5ekd3V3RwRElkOHJhcUYxaXhzeEhHVzFSeDFxR1pscnhxdmtuRUdYQlZQ?=
 =?utf-8?B?d1gvZSt1alhHMXpwWVd4UU5aQ0tRVlNPOUFtNlBMZ3M0akY4eGRySFUyaXgv?=
 =?utf-8?B?UHdCNHFiT0JFazQ4QnFMeENGQUd1S3UzYmlra2NQOXMyMUVnWThwU1NBMXNW?=
 =?utf-8?B?V2QvM083eVd2b2NQOTNvQTZjN3pCbjZrbE1oTEpMeEN4VTZvYXhVNTQwN0ta?=
 =?utf-8?B?OWk4TUhINzNmbFNOQkc4ZXV5UDVWZDdNZTV5VlU0b0xXdXBzcTljdktGbzQw?=
 =?utf-8?B?UzhObDE4UFhReGhzdWNUVHpRTGNqNnNFRmd0Y2xBK2J5dzFJR3VNNDRsT2JE?=
 =?utf-8?B?TkdLMTJzVUhKd25yWGJKQm1mdlBwelp6QlFXNVpDUTFGMC9EVk9lSHlkdXAr?=
 =?utf-8?B?UExaRk5VYk1YaG1NaFdaT2NtVWdFV2xRanRIYmFtbU4rZjFNeHJQd0tBbVBy?=
 =?utf-8?B?d2dNNXUyOVl5b1NJNEVaTDdtbFpuYThqYTYvM1FrL0J4NHBlUEd1Wk01NWhz?=
 =?utf-8?B?YTlFQ1dNa0wwb09EZUhEMm5waUJKTEtMZFZGbEFzTEZPVmxZak5CMGFoK2My?=
 =?utf-8?B?R0RKMTRkaWFvQVFTN2JhSWo4dGlzcGc3MHprVXo0NStTMnNaR3Z5V2Frb2xn?=
 =?utf-8?B?S005WFJnUjRPZ0Q4ZDg4M3p2VnorSWRJQzQrNW5SNlV2dklHWThYaTZYSjNu?=
 =?utf-8?B?OEh2THRHaUNEcXhaMjhDMWMyYklNVzh1Z0xyV1AvWURiT0JybklFSThPMkFx?=
 =?utf-8?B?NklUT3pXV0I5c3pDanUzWFpreWovMWxqWHVkSnRONVI0OWY0WDJuZHdkS013?=
 =?utf-8?B?VnVQN2MxbTN4dmgwSnExVEdjU0NhMFFNZ3Bpck9kUHR6c0ZwcDIzb1lKZVEz?=
 =?utf-8?B?ZTFiczRQWG9oMVREUGpLRlZEWnRUaU1XUXFxY1JyR1VuVEFoc3JvOURUVmdn?=
 =?utf-8?B?VnJtZTYyUjFIVTBpa21sMmZNWWhzb1FCVmxwM0VFeWl6Z2FMK1NMY1J0Y1lI?=
 =?utf-8?B?emlCVjV5Z01vcUl3eDRISmpMVTV3YXJPU2ZmWjdMSXJJYXpRWmF4dXJva29G?=
 =?utf-8?B?bnZrTUtQaCtCSnhlRVhCS2h4RWJ4c2E2U2xybEl3QzhXVndHcnhZaC8zRldL?=
 =?utf-8?B?L2kwdG5FQ045R0U0ZnlPNG1XR0pTYS82NW9wcER1aWZSSTFMVFdUUXJidTNs?=
 =?utf-8?B?MDFDQ1FzdytXK1cxUlNlRDBYMFRLZFJtMmZUalkzU1N5ZnNKRlkramNFVnRV?=
 =?utf-8?B?SWY4UEN6MjVJR3dVTE9BYTZ5WHVKQnJxZlF6WU9LRzBCU2k4SXdzZmpYZFhZ?=
 =?utf-8?B?K0F1UG5pNGdNMHhvOEVUSndDakIwdmRkb3BMVExzb1pPbitWSzRvTWUvdVor?=
 =?utf-8?B?UTUvcXJHSjh0M0RSL0xFQXMzeDFudCtNR1EwSjhVbVRieWNwTjV5ZzBNM3VL?=
 =?utf-8?B?SWp4ZllUbFIzR2I0anY2YldxcG9EYlRRanRuNlN3U2YzcWpycEVxemlPbGk5?=
 =?utf-8?B?bnp0dUVBREsveTZyK0FpRUdic05XSm11SzVIeHNXQXNxdXk5R2F6VktIa0Mr?=
 =?utf-8?B?LzJNRHJVS3JSNzVybXFXaW5odDJUTjIzU3VMK3JSckdpMlE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VFlyWTQ2a3FVSFVRbytOMFRud0hQZ2preFJyV2w2dm0wWGhYQUV6bHQ4YmRO?=
 =?utf-8?B?QktBdE1SK1RrdUdSR1RwZUV5RlV1THE4TVJ6aTdCNFoyUVVKS0xQb1gxbHZq?=
 =?utf-8?B?RkpHUHBSQTNWdFNTRExDT2VTZHZaTTBtYzIwR05PYytHbDkwMWtRV3JSS0ds?=
 =?utf-8?B?cjRBa0pvZ1RhSlJnU2dzQ3BLb3lFL21qYzZxNlJnKzFQZG1ieEkvMlJFK1E2?=
 =?utf-8?B?YXljMkVSR0Q4L3ZiRG9ZRmxVdzJLSm1jWmVJRHcyZGJ5VVhhQ1FvZ1FaRnRK?=
 =?utf-8?B?T0IvcDFmc2pwS2JZS2gza1ZESTNZRmlzYkJMdEtpYUd1MDFuUytTTTZ2cys4?=
 =?utf-8?B?RlpDSms1Qmh1TXVjQ1YyWGFUQkdjbmp5azFMYXRUVTAyeTcydUhoOGdmZlY0?=
 =?utf-8?B?T3Bkb1o1aHFIRFpIRFBVRko3cGgyVHE1blZvUGJIOVdXYlZxQ2VRU25UMzJH?=
 =?utf-8?B?REVTWElLSzNmdnAzWHVZL0FLc3QrbU5GMkZ6NWpia2xwdlFFbEJaZ1U5blB1?=
 =?utf-8?B?SlhicnF1aDJjYStmTnh1ZjJtQnpMT3VvMTRIU09YMDZ6NTJIUGlmaENuUlE4?=
 =?utf-8?B?dlNwUzB0MXNxbEJVdE5TSktHOTNEWWNDZHZmMnM1Y0dybzdRNGIxbGp4VElQ?=
 =?utf-8?B?NEl4dnFmeDNkTnB3ZDZYVnFxeEZITU1FWnFVNDZyTmZBcFp5b05BMjJ2NXpX?=
 =?utf-8?B?ZUFZZzhHQlhRYStTdys2L25tVUtheURZYUlCYjdsTDRwQ3RxaDh1WE44cFEr?=
 =?utf-8?B?K2J5TXZYbXlicys0MnorVVcvakc3Uk5zQ1lRT3Q1M1NBa0x2U2cyTUdUeU82?=
 =?utf-8?B?UXdaaVYrK240VUFBYXRKbDFkcUVWS05idzhzM2ZPZlFJRzlDbDEwTGgwUmZx?=
 =?utf-8?B?MExNYkcxdStGeEs1YnVmQVJWbGliZnBpRWYxUnViYldEbVMxUXRKc2EwNlZv?=
 =?utf-8?B?clAyaXJzNmtsZm9xYlRVeW5VVVEyd2N4MDYrTURKUk5oc3h1SlNhM3lDZ3lk?=
 =?utf-8?B?cVc1NzlsVkV3eTkrcHZjanN6SGxGQ0FUNHNrVVNMQ3Q5WHpxMWJqNXM5QmNn?=
 =?utf-8?B?ZEdBNkRtdXlRZFhHQ2NudUt1TGhHRXZsNE9LenFjRnlvRUZFd3M2VGVaN2k0?=
 =?utf-8?B?cDQyTUtFUmlubFhLc1p5bUZjRlJ2WFpMc1cwcklkcmVaWGdxRVE3Qk5CVjMr?=
 =?utf-8?B?bUppMkdSYjZxS25Cbnp2T25KRThMbExGZWVraDcyUHViZ29lSzBCSG1QS1cy?=
 =?utf-8?B?M2FFUG1Edk1Ba1ozNG5IcHM1TjU4c0ROUkdaRWc2eHJ1YTFtMkxvNUdmUnp6?=
 =?utf-8?B?TTlVYkZ4K3NISm1OQVA0ZjdDdVYyNDVVbWdiUDBkZFdidENiSFlKTm9sdmI4?=
 =?utf-8?B?UlNhSlIvVy9xQTB4SVpsckJlSGZEelFUUlppcCttTmN5U2dZRGp1S05vMlpT?=
 =?utf-8?B?TnM1UDFPc3FWYjVIcDhqZHIweEtiNk55d2daRlRRVkxkVm5SSHVnV1lvYmlh?=
 =?utf-8?B?bU9yRG90Tms2UWQrMEZGRDNEaXJndEhsSWtPUEZGbkI2REt2alU1dXg4bzZh?=
 =?utf-8?B?UUMxaHBBY0NCZUIxN1JlNDM4eVI1MDdkMmdyL0ljcjF0L25aY0owTmw0Wm1m?=
 =?utf-8?B?N3d2c3JzQk5hZ2U3d1h1WWxJTVQ3TTg0aHhLZVlxeEV2dFBGV2JVMVlSMHBl?=
 =?utf-8?B?N3Y0MzhIU1drRmUrTWYwLzdvYklwU0dOMnEra2U3QmdpNktMREhyUkhKZW93?=
 =?utf-8?B?aXhnRlJuYXo2cUpvMVE5Yi9XN0FGa2hGbjZLeU8xbm02VkJ5eUdQYlZKa2w0?=
 =?utf-8?B?WHFCNTVpTGdRNFNublY5d3ZXODRaZ0xOVFY2Q3RsdkJnZm5oU3lUTmV1YWdZ?=
 =?utf-8?B?dXd6NiswTWcxNGx2ZzN0ZHZPZUhCbXY0OGVTa0xIZkFBZXduZFRId3M4bUhr?=
 =?utf-8?B?TDV4dTh1V2dKc1MrQWd2ejhBWU1LMStyb3VyejdtRjh1WEM4Tk5VeU91bERZ?=
 =?utf-8?B?YTlSLzVvNGZPeFZ1Y0EzaHo5NUNraURMT2pZd2RwNUl4R1Ywb2c3d2hieS9M?=
 =?utf-8?B?aWJkcXVYSG1RdkdPVEluRWd2cm9TT1Y3N25kWWlrK2FENkZOcFFRV3NlRHdO?=
 =?utf-8?B?WHhNR0UrTFQ4aVBvR21raTZsSE9JZ0RNaC9tQndMZG0zOWdvL3plazJNOFQy?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5z0fxGO7IgosYAN++n0wdkbBymxrX/sej3LZojj8Hfkh/O8sAStmLwkWltFbwu8x+Ot79BiMvoGrBtQp4eATJFzjG8yOlRKMLSvshGoOrIf1/yVL0hzeWX2QYoNl5A8THJ2yVWyVL17CgqovCp0JV+IwKCZV2QWxwg38TMypckbgdeuXjFCYnKZyaiKpSzM0PdARBmlXQezA7eFzN/cbDG1bfWw3FDLLadweSWhfGaGcoc1jSx/lcHRQ4e1QSRCzXuL4Z4Cq+yePbkNcaAjt4DwJN/L+MLRYHK+6mIeBPrGNYqxg7ThqZFroOvy0SlrCftxVaeRMLdytyw4WI9XEXc0wjhVvJjP0cbkqatZfGbIdslGwWfFrrUajYHuZ0zFZJBts2eKmz9z1SWvKpPzjG4giBYIOFLPXw7sELVsgauP0DkOIudGZPGEaCH5SfbI4Pcf/4aj1vbpJNXVqWIuRnxlbTbZI+5ZutxHQZw4C96LA/fgsslTjOkqHgzgHnRwyNFdqHxSfqx+Ntu1w908GlZSuWSqIHvf5SnE/QwKAezXGr6tleXtsElXbqqvfYvfKfqR6SO/altwticq5ontKlqqv4Qq+/hHmjWYSI94KtsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4789e266-83c6-4dac-1237-08ddd6a53e4e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:56.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MGGX7mptsvk3drNVaVIqSukhEQU1IN/LYSEyriQMaWgyhTyB2oe+ItPMolpWAvhGywN2ZZ2wx3ED/zh236krg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA634C6E92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080146
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=68963ae3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=3_-2tfhjUFWtIkyxEnoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4mEygF8GI7mKy3E9Y_ax2M7jlBBn7Eng
X-Proofpoint-ORIG-GUID: 4mEygF8GI7mKy3E9Y_ax2M7jlBBn7Eng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0NiBTYWx0ZWRfXzEdLKo6C76kX
 P1VhOcBTSO6T0OXbwGU1f5yVQhNBr6f41FVStEqSODEkURdjyvs3QE1OxXkvnMQMdFmRX5ZOK8t
 g8uTYBQEJuXJoYpy8Vcrs9AFHlaJ29BVLfAiIe06AA5OhYAPQAl7dTblc7uREhBe4GX0xPFKk3A
 zgvKdv/5mnZspWwm/A71K8bkyGbKCOxWaYoID61QrMGG/vV6Dj9mjmffwVkWsM83HYODtuPJfXy
 Z495N1O2Tiqs/1I6vlURKZrdou5OIzvGCgxa2BcYo2jjIkHnrIki/f9GO8WNXKjfaSujMcETKcC
 pEM3Rvz/YbeTtE35gGDTzMHRj3jmcrueIpR0Ei/tXgJNoT9t9Vpo5FPVjaO2WOdVoWrXzSM7n88
 JVeoX225uYTNbte4A3vVT63mzBlZy3sSbLQV10T7F59jPxXAfiKXkX0A5HWRcDmGG2LNa6kN

On 8/7/25 12:25 PM, Mike Snitzer wrote:
> Add 'io_cache_write' to NFSD's debugfs interface so that: Any data
> written by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=1)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=2).
> - not cached (NFSD_IO_DIRECT=3)
> 
> io_cache_write may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_write
> 
> If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
> advertised as supported by the underlying filesystem (e.g. XFS),
> otherwise all IO flagged with RWF_DONTCACHE will fail with
> -EOPNOTSUPP.
> 
> If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
> relative to the underlying block device's logical_block_size. Also the
> memory buffer used to store the WRITE payload must be aligned relative
> to the underlying block device's dma_alignment.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  1 +
>  fs/nfsd/vfs.c     | 16 ++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index c07f71d4e84f4..872de65f0e9ac 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -87,6 +87,47 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
>  			 nfsd_io_cache_read_set, "%llu\n");
>  
> +/*
> + * /sys/kernel/debug/nfsd/io_cache_write
> + *
> + * Contents:
> + *   %1: NFS WRITE will use buffered IO
> + *   %2: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> + *   %3: NFS WRITE will use direct IO
> + *
> + * The default value of this setting is zero (UNSPECIFIED).
> + * This setting takes immediate effect for all NFS versions,
> + * all exports, and in all NFSD net namespaces.
> + */
> +
> +static int nfsd_io_cache_write_get(void *data, u64 *val)
> +{
> +	*val = nfsd_io_cache_write;
> +	return 0;
> +}
> +
> +static int nfsd_io_cache_write_set(void *data, u64 val)
> +{
> +	int ret = 0;
> +
> +	switch (val) {
> +	case NFSD_IO_BUFFERED:
> +	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
> +		nfsd_io_cache_write = val;
> +		break;
> +	default:
> +		nfsd_io_cache_write = NFSD_IO_UNSPECIFIED;
> +		ret = -EINVAL;

I might be wrong, but an error return should leave the setting
untouched, IMO. Likewise for the read setting.


> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_write_fops, nfsd_io_cache_write_get,
> +			 nfsd_io_cache_write_set, "%llu\n");
> +
>  void nfsd_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(nfsd_top_dir);
> @@ -102,4 +143,7 @@ void nfsd_debugfs_init(void)
>  
>  	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
> +
> +	debugfs_create_file("io_cache_write", S_IWUSR | S_IRUGO,
> +			    nfsd_top_dir, NULL, &nfsd_io_cache_write_fops);
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 6ef799405145f..fe935b4cda538 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -161,6 +161,7 @@ enum {
>  };
>  
>  extern u64 nfsd_io_cache_read __read_mostly;
> +extern u64 nfsd_io_cache_write __read_mostly;
>  
>  extern int nfsd_max_blksize;
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 26b6d96258711..5768244c7a3c3 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -50,6 +50,7 @@
>  
>  bool nfsd_disable_splice_read __read_mostly;
>  u64 nfsd_io_cache_read __read_mostly;
> +u64 nfsd_io_cache_write __read_mostly;
>  
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1234,6 +1235,21 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +
> +	switch (nfsd_io_cache_write) {
> +	case NFSD_IO_DIRECT:
> +		/* direct I/O must be aligned to device logical sector size */
> +		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
> +		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0))
> +			kiocb.ki_flags |= IOCB_DIRECT;
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +		kiocb.ki_flags |= IOCB_DONTCACHE;
> +		break;
> +	case NFSD_IO_BUFFERED:
> +		break;
> +	}
> +
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);


-- 
Chuck Lever

