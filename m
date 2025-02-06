Return-Path: <linux-nfs+bounces-9893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB885A29F1D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 04:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEBD1889265
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E86AA32;
	Thu,  6 Feb 2025 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MeE8hseZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dl/VB/uV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE028634E
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810968; cv=fail; b=J/UgeYPhBoBq1tBrHi7qafGF6vf4PtHGq7ktFaMCFx8HRkPAqg8SsutL+nmuZAmKAJJoK8TwTbhht9qejoiUFCLFwZacJ5k5WekRaBOIKb6XvPcUfqRZkKt22zc8DWjoPgyltRat7PaMdB1cpTY4YCLgi2fnSoLLdmV4aDntHq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810968; c=relaxed/simple;
	bh=n7ETiHSqE4E2j8FwedlYnwuK9Zytua0DzuGm5YFNl9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmyMKSWkV+eVdDZeYTb6cFGJoolsOFqZuB94L+qeGrSlqQBmXMvDojKmPxZtzxlEg0r1+zm+RUekSCU5udDazk4plrvWY83eV0eU8CzAnBlVsJuHBzpGa/IPGbmSdD95E7RvwqQELskWoVkRja+GUM3ILYCJyNqqyUyRmnVFIr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MeE8hseZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dl/VB/uV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gif7004131;
	Thu, 6 Feb 2025 03:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=a+wuju2itepjpcXdUvaFl6NCJAno7mvOXaOMrdWUnGU=; b=
	MeE8hseZdX4u5EjKFPR09U6v9wBVElz7jjQnVIW1ZqC0cKM3QRwZ2FuOSoDdJY+3
	EXwtz2AZ8c425Ac5cKnfAHLpMTSGGvI3PchCm4+IAHubirIfAPjP4+0ErJaGN0yY
	ImA5Oc/8q6lA/kK3xCiWFWgadTX+M15OdpgDbwqFX7XNtr3KrzKvM8KJU2+hfO7j
	mtdV9eCEJJ0e3pZUg48dLsr0uIb3DZCpk+/bzX0Av7koIoAIr7GMYDPYVo46y0nC
	0ROHgH47xjzWjlg/95oE9qatY7wE8S0uIcSuBzXluVL/i6BQtUD4FFXasrxJGO+3
	0UwCxzxmTLn926mdaUanoQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxmcar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 03:02:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5160Bq6b022524;
	Thu, 6 Feb 2025 03:02:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e9wmxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 03:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy6E9WT0tT+TrvgAQf1xeEVzJvXyLYt39Z3PY02AD7POBAgJTfN0XLtsJONxi/wb2hW3PxgaQa3YYzWa77w+uuCIxSxlZfv8JdcJhM3GRu5aPUA29ZCLwcDQ3NKzE/DBfydEgguRG4i/pGuBX7eAIyoKRbEYgUop6qk5ZhCcPsBxfUEkC/CJjvSNvGLWPlKa7p3zSI7kNl0gyhKa65nYDGV/AWV8mFwA9mmR1DqCahXaaCPbDzCxfhM6CY1YKA1XVQZf1WeACWHFNwQufC5p/rCqciMvhUpRTyI3zjeZhLCUozV8YToHLA7xMpcdakFgz+kWygF9pziyZytCQIa8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+wuju2itepjpcXdUvaFl6NCJAno7mvOXaOMrdWUnGU=;
 b=F2bJL6dWwfVcYVu5LkheXyDodnvuWC9pGFJHiwO7FJWSrRZeN0FnOmgeVl36c89yjMGmyFlmcAil1uOhnABfVcTQXl1jMYLHqj9XbXNxGxXtIIzAJlMEIfSfAjqb93IcZPUVyC3TuXdBxwRaHmWOPONgWrVaihuLYnAjLqMdqcdlyUHeCpzhfrQ3NEx8CnYYn5Oj3aoi6kYBmMi7ckxvNq2kWm0Gs59GWL60vqH9k2aHdv5LO2CXOCBKAZrnoPq4jmmBhgPzf9pMSyoWTl6dc/2kR/rVWNI/3QmjGeU7AAzQACeI3vF8WncYQ2+msfYh9joZ4zt701c0e6iYiAgHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+wuju2itepjpcXdUvaFl6NCJAno7mvOXaOMrdWUnGU=;
 b=Dl/VB/uVAubOeOHLvOdXMYKurC6NpRTBMlKdhyq6YEAlLqaTdvty6cafRywo66BpehGpRKAzZWPL0ApyPbyLM3VtkbZaCuJRhdt8Dm99eB6Yuv/E2i4e5n0rUlUHtld1ep5Ckgx+3a064U3PpRiuGbEXD5Rh03mesFgsFRZ7TQ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 03:02:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 03:02:30 +0000
Message-ID: <c7463ab4-a437-456c-b14f-30d1e018f799@oracle.com>
Date: Wed, 5 Feb 2025 22:02:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Dave Chinner <david@fromorbit.com>
References: <20250127012257.1803314-1-neilb@suse.de>
 <173879666534.22054.7515430207159287196@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173879666534.22054.7515430207159287196@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0039.namprd18.prod.outlook.com
 (2603:10b6:610:55::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: b559bb10-8cb4-4f63-21ff-08dd465ab1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlHZkJQRUZUeGwxemw3TkkvYzJnajV6Vi9WS1dpOVdTK0EzbXg4d09USXNq?=
 =?utf-8?B?N3VwSDVURW81Z1NhS29CZG81eTBEOXp4TThmSXlQYUhzVHgxZk93NWtmYlFI?=
 =?utf-8?B?SGozQ2pKdit6OHdqeWo4SnNCVENEQkVQNmxuWlAwenlHYjY1VHJST0dZN2Zi?=
 =?utf-8?B?OHFqNkdTMFlQVVRVc0JUbFhnNnhTNkRDYUJVMU4xakk0cm9WbjFMY21KUDIy?=
 =?utf-8?B?eVBTTDhMK3d2NVFkZ05rTzRYZFZPakFIN0RMQjBzWk1Yb1BGWndQKzg0aTJH?=
 =?utf-8?B?SmlnWDlhZEN2YUZNN3JWWU0wRnhueXYwdDN5R2p6RnlHSm9MUXhHLzlxeFl6?=
 =?utf-8?B?WVExZDZBNGk1RWdoR1p3Y1RtSzVEMnRmL2FBSmhQL1R0MVp5bTlhcnZOQ0NN?=
 =?utf-8?B?WFVLOFJCR251Mi96VlppNnk4SFJPSWttclJWaGl0L1BaVDJqRVZXbXVxUEk5?=
 =?utf-8?B?TDVldi8zck1qK2IvVTFLbEdNblJNVHAwaVhpYUsrTmJSVTk0R3pBK3BGRHNI?=
 =?utf-8?B?NEFHZWlPSjlhU2Y2TXJTTHRyK21EcDA1WkhGNmhWNTJ3VVFrL2xVWCtlaWti?=
 =?utf-8?B?UCtQaDNMMHV2aFI3d3E2cEw4dk9jMzJtd01WanQ1UHVWaEdvVUVrQ3NOZENF?=
 =?utf-8?B?QTNrT2djNTdPemlkVFhjVVhNazQ0Z0czdVdvamd1aDEzR2V4ckN1b0FnNVJO?=
 =?utf-8?B?dENUSmxEVXdTcVd0RkF4RVlBMi9oWTVlUWdFSDJFTG8xUVJvNGlWL3h2WnF5?=
 =?utf-8?B?YlFsL3lrYWVWWGZVZXppYVF3end5WFJiMDlSZXFWRG1DV0dPcmxNdkJ5dUd6?=
 =?utf-8?B?UEs0d0pOa09sNGtNVjdYT1RoS0oyQUpjZGg0YXlVcW5SNnRBYTkxSENKRnRt?=
 =?utf-8?B?WithcHllWEphQ1YzRjFzVllJNGNOdloxNzJBNnhXZmdwc2UxQmkxRHJJd01Z?=
 =?utf-8?B?Z2drT3dpREdGUzE1Yy9pdDRMZ3ZxeUFaUlQ5a1ZFeXUzQmU4dzJkVVBOUndJ?=
 =?utf-8?B?ZkliU1VSdWQvWWlIRWFWWHp0d045aW1ZczVwUmdNaERuQVJnUHh3eTlVM0dC?=
 =?utf-8?B?Z3laQmhnQTV1eTU3bU9RNDU1eHRLNkFGRjJTNzE0QWh2WGg1VHpDaDEwQ01w?=
 =?utf-8?B?aGwrWVhhamh5WEt3VXNINUhCbVdyOTF4ZEd1RnFJWVk5MFptRlo4MW9zbDRO?=
 =?utf-8?B?TzI1NEN3bHVpSC83bXpzZ3JyS2lCQ3NXSG4yWFlwSk5jdWxyQzRiamVCQ2Mx?=
 =?utf-8?B?U3JCaW9DMkloSTNUTVFyQWFCVVRJWTZidmg1bWVYcEZwck5UdGNadmZzd2J0?=
 =?utf-8?B?N3NiMjU3ampkNEpXeFV1Y2NJR1BGbXhmSWE0Tm5MYlgzUGJQT3RMOWIzMTFr?=
 =?utf-8?B?T2pGWFNvSUhZZEFTRUdrMGNUMEFVMFN2MUEwSDFNcjczeGFBdjQ4eUVYVWJu?=
 =?utf-8?B?SWF6OEthMWQyRnpXeVVYbVBJRUtEYklOUURaZ0xaeldyUzVMWVNnemhIdG8y?=
 =?utf-8?B?all4WWk3MHhKLzJVcGdsWUtnaDBxdUZVNUltRUFxdjk0WitsTHN0V0Q5Q1ow?=
 =?utf-8?B?ZjBkRFVpWmFjMndETFdkN3luNUVWR1hTOFVqeHp2WUEycWl0WDdxMzl2eHdh?=
 =?utf-8?B?ZVlUbVVXa2JzOEdjK0tCdHZTdVd5c1JjSWNZTWRoTlVpd3pCbDlIRXBaMDJk?=
 =?utf-8?B?YlRlSkpXejRIZHQwOE5QSW1XV2VWOFdNQ0l6WFdPQWJVOThIMEZ4azZhQXJ2?=
 =?utf-8?B?UEh5R3Jad3hteEJBb202VHhHTDB4UUlZVGZ5M0pVazd4NHBETzdUVzR2Z2ZF?=
 =?utf-8?B?TE1DVHpBbmFHUWk5Skk2SHlHcGMzK0VlR1ZjUHdjZzcvS01DSklmbDd3OTdu?=
 =?utf-8?Q?TCDK8ahxlEbYn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZlZ2Z1Z3E5ZmtVOG5NZGl4TWwxUW8xNUtWNml0MkdzWS8vbW1PVHJPNzhp?=
 =?utf-8?B?bVVjM0tXU3hzYmlnWmd6R3l3ejYvd0xxUElpMFk1b2RnS3hlUTg1M3NaMEVG?=
 =?utf-8?B?TXgrYTBzb3FGbnFYTXpOdVNrQ25EUlp6SmR3V0tOTHZJQ3NhNjB3V0Y3YnVX?=
 =?utf-8?B?WkxKaXVJdmsyamU5NGdPcVY2TURpUGRvZVhqWC85cUQ2UjBSSS91ZUdOckNo?=
 =?utf-8?B?YWo4OG5NZUN3SEVHWDhGcGFOcnMyL1F5L2FJYnkrS0xVTnoxbVNaTWZGNE1L?=
 =?utf-8?B?cHBBZ1AwS2NuY054Z3dGQlFmRjVKZ0FEOUZBNzJNWVNqY2pydmRObG5nOWVH?=
 =?utf-8?B?emR3UFdiM2F0OEtWU0s0bzdRa1NBaGI3UEd4N2wwMis0YkhLdVl5eGVONi9G?=
 =?utf-8?B?Skw4NDNPaEpUWHltdUFGNTZQQ3o1QTdRMnFaWkJ6UzNwdXQybHY5OVlJU2l0?=
 =?utf-8?B?dmx3MGpPYkQvazJiaUNYNzY3RnFlT1VhSEVaakxJQkVlNWNqUDRQbmNhbmFp?=
 =?utf-8?B?V2t4MC9jMWl1cEJFUVE2QUVoMjJFbUYvN3BXMkJrQ3BGdy9qcUsvNUMxOFdj?=
 =?utf-8?B?Qmw0YVRqUWVibmR6Qm5ueHVIZVJWeHJYQStNWXBpcFJtWmtZNXN4RUJFcDMx?=
 =?utf-8?B?N2pDd2NuSVJlZVFrRTN0NWZNN1k5WE5rWUlrT2NVcGNtcTJQMXkzTk9aZUhj?=
 =?utf-8?B?OXlxenR1UzFjY0IwUG9LWWcvcnNnSmkxSHVCUE5sWWdKTkhxOWR6N1JxU21B?=
 =?utf-8?B?eDgrclcwTkVSdWE5TDRBQ0VUNFNkRG93ZFdnVUNkTTFrS0ZtVW5UclhKYXNl?=
 =?utf-8?B?cFRhWFVTeUNlY05UZGl4dytyTWtPd0VKMitET2ErSGIwUnd2K2JBb3FTOTBk?=
 =?utf-8?B?L3V5S0VwOEswZ2grdk4rRGxwUzNGaG5QelZBL1JIN2NId1hhKzd0ejRnVXFi?=
 =?utf-8?B?SHNyVW5Ua0JqZTdzNGhUTG53NHF1eVh2VWl5bjdzZ2REbnJiM3VibmQ3QnBk?=
 =?utf-8?B?WkJRVXZlaGtIYzlwdjY0MlkwUmF1L2tFWU1rL2kxT2I1b2RqelBjV245cENQ?=
 =?utf-8?B?cjdzUktCcXFTa0ExUlBNSzYzUXpabDYwRUVuUmZzc21hck41U2J1ZDh0ZmZy?=
 =?utf-8?B?V3NuNCtHRW1odnFydExxQWZPZ3hyZEpIMEN4WkRtNmh6MXo2cDh0Z2s5aitm?=
 =?utf-8?B?MCtTTlZaQk5KdlBvYzJDeGNkU3NGTnA2cmI4SGlFdnk2STcwZU9XRTJOQWZV?=
 =?utf-8?B?NmF6aFNqNDBQc3I0Q2tqSmpLcU42R3R6ZVVvOGhoSjlPNEQ4THZia1pvVTZH?=
 =?utf-8?B?dzdqYU5EeUFQeWVCTHRTMFJCYVRWdUx6TVRMQ3RjendBbzBUeWRzOUlGUVhZ?=
 =?utf-8?B?MUx2TEFYbmw3bnp0TTRJRXd0bm5ZcTJheXZiMm1zNWd0TnZQUkRVclNWcG92?=
 =?utf-8?B?UUZZR0pmUmV6K3g3ZDBCTlBZa1QrVmF4bktYbDJQUkg2S2UxQnFvRDlSRjRM?=
 =?utf-8?B?NXhsam5nKzU0cFFWVXN1Yy9PRFBhVmtzREZualM2V2JobTRycFNlYTJoWmhn?=
 =?utf-8?B?MmZOVm4zZ1h4QmhJamRUVU9JbTFOSDFrMlEyMURrYTMrd3BLTFMvbzhOazVB?=
 =?utf-8?B?cWZoM0o2czYxa3pvaWU4WlZ1aDBSaWt1YkZtMnB2M200UXBIR2NzZ1BRbSt5?=
 =?utf-8?B?eXZOOXVPc21RMmlybFV3alBvSndZTXBrT0NrdDJYRm5sS0UyR0ppcGRES1pa?=
 =?utf-8?B?Y1lMdUNPRmx1QVI3SFhkN2F3VXBFdkNjbWdTMkJCQzd2WGJjUFJFU2s5VGx2?=
 =?utf-8?B?VmExV0xwOGtTSk1tbFVXYWV2Nm45UDRHRlpOaUtDMnpYbXNsQW90SkpHKzN6?=
 =?utf-8?B?L3JKbkJmVkl2RGM0OG1RMlZrcm9YTXg1dlhyVGYyQUJUQy9ZU001Tnp5cFZn?=
 =?utf-8?B?b3FHbDRNdWZ3c0V1UWI2MjN6eC9PQkZtN3locitIbnV4akMrNTRxTUs0VmFE?=
 =?utf-8?B?RkptQ0NSRkdnSmIySXpyclYrWDRxQUZweHJ0UWhUNDZxUndoZU5jYXdSYWdo?=
 =?utf-8?B?QzA0UzJUTXhReWVVWXdFWXlVUzNEK2c3aGZMYmVQMVhoUitKSmdkK2g4aXYr?=
 =?utf-8?B?RjN3ZlB5K1BMT2tpc2t5dEhISTdEQU92MG1IN0NhZWtjZCtkdEptSkRzcDhD?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QXtMScqYO42pI7+8hg4zIXZ4JEzH/g2xSHJdLDGmTjuLxNutLzOAwGSLLhRrF936pNoJqV3vkX2jMuuLY/INEWFs9LNz4j2JymBiyZONPcW4eKp8g8dTNpkMs0NgA7NYbaONKBlVMu3+2SZItDp4Vqh/H5lcV4vJQi5XHkbtAkSl5ZSWrnrDPZlh7GFW0wkfkGX70lFzTgBCGRLMFw1hMMJNM7fs1/kxR47Kxjeglm9pdnMStLfg5sfBWj55fGd9FuAAFxkmqBweI+bEDW1bO4QTee55wyhSOHKKUA2Ta6JSesagxvUxrgE5iNz/qSElNSXU+7h7TcDRVBM8Hc4q2HBTD/XJo5K6hFKSb+ile4UmFH0uk1rxUg+w1UfCfSTibqcfTpnkxie8br4CbqbOVR8RUdR9PItfGxRSnbcFvuwQSI2AYMu+57T566Cr9ffEgqzpseA5usGnXx34mOAavsXfRtcNAXV2C+CCuK4ZeQjJS9NyUp6WyD7UbIebpviLQ39JM0p15rQzfn/r0N2EwY8RuMJSmSuTSNQnAiTjRLXJptcrPcbjzvnvcdWwhvSNkFodEb6sfKcfBQSwHX1ysIfUpdIaBDpuah8LClmQiZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b559bb10-8cb4-4f63-21ff-08dd465ab1ce
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 03:02:30.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol3lyQAc8aV3bq8BdBXF56TVQoIkJ2DLsZuyuukjKt7IgGmD2668qSWGUjZjzx8CQLSdY9lD4hIV2P8dnJRbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502060022
X-Proofpoint-GUID: TdG_i2_ic2lzwhb9LMPl71z65lrW36aC
X-Proofpoint-ORIG-GUID: TdG_i2_ic2lzwhb9LMPl71z65lrW36aC

Howdy Neil -

On 2/5/25 6:04 PM, NeilBrown wrote:
> 
> Hi Chuck,
>  what are you current thoughts on merging this series?

I think NFSD is better off trying to make list_lru work, as that is a
broadly shared mechanism that has had a lot of review and testing. So
far there hasn't been a lot of evidence that the proposed replacement
is significantly more efficient; it's just different. I generally agree
with Dave's sentiment:

> Using common infrastructure, even when it's not an exact perfect
> fit, holds a lot more value to the wider community than a one-off
> special snowflake implementation that only one or two people
> understand....

LRU for the NFSD filecache is a case where IMO code re-use /is/
valuable.

One of my peeves about the filecache is that it is buried inside of NFSD
so deeply that it is well-nigh impossible to build unit testing for it.
I'd rather not add more special cases in this area of the code unless
there is a palpable benefit.


>  One of my thoughts is that I now realise that
> 
> Commit 0758a7212628 ("nfsd: drop the lock during filecache LRU scans")
> 
> in nfsd-next is bad.  If there are multiple nodes (and so multiple
> sublits in the list_lru) and if there are more than a few dozen files in
> the lru, then that patch results in the first sublist being completely
> freed before anything is done to the next.
> I think the best fix for backporting to -stable is to wrap a
> for_each_node_state((nid) around the while loop and using
> list_lru_count_node() and list_lru_walk_node().
> 
> I could send a SQUASH patch for that and rebase this series on it.

Yeah, proper NUMA sensitivity is important, I feel. Please post a full
replacement. nfsd-testing is a topic branch, so the current revision of
0758a7212628 can be replaced wholesale.


> Thanks,
> NeilBrown
> 
> 
> On Mon, 27 Jan 2025, NeilBrown wrote:
>> [
>> davec added to cc incase I've said something incorrect about list_lru
>>
>> Changes in this version:
>>   - no _bh locking
>>   - add name for a magic constant
>>   - remove unnecessary race-handling code
>>   - give a more meaningfule name for a lock for /proc/lock_stat
>>   - minor cleanups suggested by Jeff
>>
>> ]
>>
>> The nfsd filecache currently uses  list_lru for tracking files recently
>> used in NFSv3 requests which need to be "garbage collected" when they
>> have becoming idle - unused for 2-4 seconds.
>>
>> I do not believe list_lru is a good tool for this.  It does not allow
>> the timeout which filecache requires so we have to add a timeout
>> mechanism which holds the list_lru lock while the whole list is scanned
>> looking for entries that haven't been recently accessed.  When the list
>> is largish (even a few hundred) this can block new requests noticably
>> which need the lock to remove a file to access it.
>>
>> This patch removes the list_lru and instead uses 2 simple linked lists.
>> When a file is accessed it is removed from whichever list it is on,
>> then added to the tail of the first list.  Every 2 seconds the second
>> list is moved to the "freeme" list and the first list is moved to the
>> second list.  This avoids any need to walk a list to find old entries.
>>
>> These lists are per-netns rather than global as the freeme list is
>> per-netns as the actual freeing is done in nfsd threads which are
>> per-netns.
>>
>> Thanks,
>> NeilBrown
>>
>>  [PATCH 1/7] nfsd: filecache: remove race handling.
>>  [PATCH 2/7] nfsd: filecache: use nfsd_file_dispose_list() in
>>  [PATCH 3/7] nfsd: filecache: move globals nfsd_file_lru and
>>  [PATCH 4/7] nfsd: filecache: change garbage collection list
>>  [PATCH 5/7] nfsd: filecache: document the arbitrary limit on
>>  [PATCH 6/7] nfsd: filecache: change garbage collection to a timer.
>>  [PATCH 7/7] nfsd: filecache: give disposal lock a unique class name.
>>
>>
>>
> 


-- 
Chuck Lever

