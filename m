Return-Path: <linux-nfs+bounces-8969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE28A05D03
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E23A6A62
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FDB1FC105;
	Wed,  8 Jan 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k8ms5TgE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0BnMZv2m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCD1FC10A
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343590; cv=fail; b=pzYcb+OC1lOr3TE513CGJEM8aMjUH1GOUihRYyWP8SvUV1COTWVYctPnyJEI0kf4OEcDBOqIosFEBTFiu6bDPJykb+/lJEYsZla70CoqGE7rFJ39+mr/ECtHOCnmMQ53HCo7yRt9LeV9iB87H8dRhja6Tx39PNSv0EdBbajxtSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343590; c=relaxed/simple;
	bh=/HeRAMlb5jt7hhfTpwtIMSP1QV8/a1Cs5AeaYOH04og=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYBGXt6LY+CEISjNz4QYsefraGmDRSc0SjtcWP7B2Mo3L8/MoCIUg9CDgdTiyUr7XYc9qiwTgeFxZZnjBECIE1jw/6bnwYKRJCt2teOu+dlRfW5bz7J0hynMLSLDgGFCgGD7t1z/y5WAhs39K4zCGlJw7VeZH7qgMTUpvkXjZFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k8ms5TgE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0BnMZv2m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5083kRBl015482;
	Wed, 8 Jan 2025 13:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IoiVWZoh/mb2RX7FqQinUkDY3S8hONkE9ZlQynJ0U5c=; b=
	k8ms5TgEQmqfOcTLhSJBzrToBuHmaCbUzEUs9Q/QS22T3oZJKT69q6mbpCdKgCwZ
	4jWYXKlbjUdNUvH+KEmEmG6IqIlWtAUu8m0YxApAxGd48YXRxz7uroEAxi0/ChQ/
	KCI9mBCKeVdH/NkhuOw9/8UjLQ6M4WKyvhSpHHjtD7xf3cjP+2q9M74PlmRwCNKt
	KTqTgl1VoJrKQphc9GgDh6IUX7E8myFwn8K9pGx2oDzAhJDGZY3eD179CPFn1/kB
	ZZYv3NnubMDEy/btAscZL5Z9ZT3IwKOvF8Eoc5b7YrlTSL2X/Z+4Olz1RYmqRdBK
	AGHguvPqQJV3ypb08PUTVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc70g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:39:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508Bf13b021260;
	Wed, 8 Jan 2025 13:39:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9rxy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agFEX+W/JdS0DXpCxADhUUZo/CLGKMTvNJXPdjtN2N1sUlcj3247+sIVy7jHhOTdn3Uxj4BcZj5dB+Ad8SOci9oIHyOi+B7xyNdwfh73GubPZzsB9BvUsJr0tH9xhuBaa2m3+HZTHi2L/Z46xcS94WRjKyyHlK2CS6u/lMZA/DG9eTKMBM2hTmF7zd2g92f1SDIZ9ATCzXRpSgHiy8pBtev7hRnNrnZ6MV4hgpbcGQsp9JaqYb2Yzx7vvUtVMgKW/7iH8Ni0KvUsU5QksDjz5mCc7VWmDplVBRBxzVRKd7douGU5YPY4YImJhNaw8vWFBzbrPScrOMWAQesys800Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoiVWZoh/mb2RX7FqQinUkDY3S8hONkE9ZlQynJ0U5c=;
 b=j7gqe9nXMo8QIsPDkE3sHBbeWksXNY8wQSm8B8L8JR6bNRqrmzJtkLWzLdYEG0n9skkySuD5txKii6XWIDYPlL2V+qf4f6+y6OaPCxjMvpO5jQujsL87jJtY6GXC/SvP294+dH+YuikKoy2yPx0xNpgSzpqT2vsga/XAI1qm9gsYtWpwgdOx72njpwVquvSaVGrKeYOBAhuARItEKasXib3zN4eKrCIBvv1fy0TgHiQ3Wbi0wV9VEfdpAv+/VOwaWxiAUvFuePxGaBACTg3FkkoG0ZzTrTMO7shuojdMxll4OKl+Dp/K/xCPHe3Hpt1dufvndtkSaBHVKb6yXqH8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoiVWZoh/mb2RX7FqQinUkDY3S8hONkE9ZlQynJ0U5c=;
 b=0BnMZv2mtT8slFkiW/8GML/qzB5scXtDG6Jy9DL3jot6q+g2s6Ht9+8MirFxKrUbqnNz/VWh57I4qJ/yzJEYAfV3wkXkfjFgvVUTZUJD2Ggiz1S4bOqfHQ9mIeC0ADdsIKuuNCcLOqW3ezVt2vwjR+DzUZmymO2aF6BIA03uU8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6977.namprd10.prod.outlook.com (2603:10b6:806:344::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 13:39:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 13:39:29 +0000
Message-ID: <c205384d-cf12-4dde-8875-e826e4a7c2f6@oracle.com>
Date: Wed, 8 Jan 2025 08:39:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: add scheduling point in nfsd_file_gc()
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <> <e8eda0b1-c55f-4f86-8f7e-3c6a50dacac8@oracle.com>
 <173629091812.22054.10406068450776372683@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173629091812.22054.10406068450776372683@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:610:75::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b7907b-ca47-4143-0adc-08dd2fe9e06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0lLVWVUQzNEb1U5ZG5UWHFJbEdGbEFUY21GQVdHZkV2OGxTZjhLMjVpd2Rl?=
 =?utf-8?B?OTlWV0djM2tKUTRhSFRzeW1KTnNRNVNhK2NTcDJ0MzllV2YrYjltNjY5WmpK?=
 =?utf-8?B?aC9sZnlDenAvUmRHOHMwQ3daRFB1bDRxcnJPMHlVaWtib2FJcTZhcGpITlFH?=
 =?utf-8?B?RmNKRVp2c216SkozM20vbnpTYmt1ZURWZ2hNL2I0Y2dKSFdiUGtjMkxnUVcr?=
 =?utf-8?B?VHEvd2h6OXlsQ1FCTHVuWWtRcTlZZGVpVXVUS0xZVXdzMktBblZPc2J0RjM4?=
 =?utf-8?B?M1NFWnFrbGdnU09zOXFlOHFuUkQvSWNUU3pqYmkvQ2NSM0Z3cXpQSGt3R0hS?=
 =?utf-8?B?Uk4zUVdMSEJmWXY4dUZnYnhrRzR3Qk9XY1RiT0Q5K1hXYnZMYnhCc2hDTTJV?=
 =?utf-8?B?bVN6RlBQRHdPZTJ3WDdHYVlkaXNXai91a2NWZWNIK2tDUjFVckNINlUrNkZx?=
 =?utf-8?B?U09sN1VSRlVNNGh3K2JxbnZMY2dkWDBTeGJBS3ZXQlowT0hoS3BubVJjTSs2?=
 =?utf-8?B?YVdNbDA3L25vN21BdWF3VnNLczBORnFwV3hDU084S20wQklTMXBVblpLYU04?=
 =?utf-8?B?N3VXdEE4UDFZUmhoMktEUzRMQm1mRFlET3ozRXMxbmNvdGttSFlPc2JUSWdJ?=
 =?utf-8?B?SG1kYnNVVStCNFRKQlRUYVhoZDJaSzVlU2FIOGl0bWdsOEo0aUxWOWMreVRM?=
 =?utf-8?B?bG5VR2JDU0VQUllxb0lDbTMxWGt3Sk1EWEd4QzdNMStmNzlBSGpXK0xoZU1V?=
 =?utf-8?B?bGhKdGxzM1dPU25kZVE0VWo0Zis1MEdYY25ESmg1SDdPaFBYR1QwWHlwNTNY?=
 =?utf-8?B?YVBCUTNSa24vNjhrYWk2TmlVY1hBWmFHOVowVisxV1Y3R2F2bXV5NjhTL3Ry?=
 =?utf-8?B?L3dMcWtJNzBNenVIakdyQXZnZTdPbFByaGxNRi9ZVUV5M2lKS0FEc3lOZWRG?=
 =?utf-8?B?SDFMTFZXWWhYbWNWbzhGYlZONksxSTl4dzRud2laeVF0NUtVOUlJV3VzMFFQ?=
 =?utf-8?B?ZnFDdkFoUDJrcXhCNGZSNFpLTTRYek50VlBFMUxxSGFGMldNN0pNNTc0VEdY?=
 =?utf-8?B?VU9JQUY0WjlSSnRXbzBNYTlJT3AvbVdqWU5qNU84RVBLMUEvTWFJU0VkZkEy?=
 =?utf-8?B?OHBSeTFqSkpkcDEya2dYbHdaNTlidDNmd0dWd1dtYnpnQSt6bkFnM3E4WG0y?=
 =?utf-8?B?ZnJDaTA0YyswUzBad1Zjay9DRGhnSTNUMGdyeWFRWnc0U25aTno4b3ZkVjRm?=
 =?utf-8?B?WHNMVWJua0o3cm1aUGRpY3FMVnBpVVc0dk1wRzZyM0R0Ny8yb1BvNmRJMkY2?=
 =?utf-8?B?SDN4cE5kdjVrWjBTcm9RdVUwUWJwSGUxdHBJMmVLZ0NHdUxCdExQWFM3bCtL?=
 =?utf-8?B?NUZlQTRhdzVkVDlwdnp3LzRQUzV0L1dma1AycldsN05mQ1NKRllZZ1E4ZHNO?=
 =?utf-8?B?RHAzbUFISjVSZkhicVZONk9jVnRCeTkzT052c2Q2QThwRFJPeWlhNDdQNzA5?=
 =?utf-8?B?bndPMkJ0SEduT0Y1ZjVScDR3K1hZQVRKTmFuYkl2ZXdTdWdqaHdKSzB4Y3pK?=
 =?utf-8?B?TTR0UU9oUXREZWpMTnBhVlF3MWtqME1XbEcyZVNBUGlZbmRDb3JIc3M5TU94?=
 =?utf-8?B?ekR5VjJoZWVBOU95cW1FQ1FTZWljMXBxakcwN050dTViaWZXYS9YVWY3WEs0?=
 =?utf-8?B?N1J2UDgxVzRsWlRjWno1UWZkRVhBVzhkWUVSRWVSVzNsQ25hUFJHS1NkYWlz?=
 =?utf-8?B?ejVWdUNqRnZyZUxNSGYrdW1SMlJhOXNhbG9JMjVCMGFIL3RZckZtTGYvanhz?=
 =?utf-8?B?Z3BEdXlLSU9jeVp3SjM5YXo3bFBVL0kwY2U5RVpvZ0NTb0IzaWx0MkpIcCtK?=
 =?utf-8?Q?nZ1olAgaQjq9P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWxNSUlwbWF0SW1rSXJKMmFZK0xuTldVN01tcnUwbFcrcEtDSG85bXRiaWR1?=
 =?utf-8?B?d1g2N0dKZXNrcHBybUNvOTVCRGR4TzJSZGdZN2NTR1BHOFBxcnJndDl1eXBz?=
 =?utf-8?B?QWxPRUhQaWo0QUx2OWhUWE5lUzVQT3Z3MXZXWXFhOGhiR1lBUjNMdU5WMDdD?=
 =?utf-8?B?MVFoeGovYzM1MjFPQzVQRFlyVEpsaHh2ekNBRitXVW83Z2trRXBUazk1UFlJ?=
 =?utf-8?B?bFZCUjNoaFErbUF4a2ttc1JER25XclNuYXVmRUkvNTgyN2xUc3YzQm9EdVN6?=
 =?utf-8?B?VVcvYThwMmdBc3NqNDBTalQxVndiT2hET052S1ZyUEpka0EwcHFoc0d1bzhV?=
 =?utf-8?B?U01KcXhzeExteHNvcHoxRklBc0JwZ293OWFobTh5OEs1V1hEdmw3aTMvc0pD?=
 =?utf-8?B?V2RKZmZFRnliREJIMmxkTGJpMGdZOEhnQXliQm8zUmdOY2hNNUw1WUdlcE5q?=
 =?utf-8?B?RFJod21TRDZMRUZENE1MNk1TazFhU3R0cG93cmthd3BmcmVkN2UxU0F1WFZE?=
 =?utf-8?B?dmJORnFTRXJlSUtZU0ZVVlJVbkRlZmViQ2tHd21QZHFxNjZsNU1ZdHZsVXNa?=
 =?utf-8?B?RDF1dHczN0xTc25BTzZwU3NDWjZNZ0Vra3RZRUxmT0xpaXpZMnprR1hsZ0hZ?=
 =?utf-8?B?TVFWdGNEQWViMFIzdDRvcGQ3NnhxN25hZFZjSmlaem81b01LRXlRTUlRLy9O?=
 =?utf-8?B?Z1VwVmluYm5LVFJuZmp4OWtVbTdETkhuelNFYW4reEozdTV1dmZNNW1VNFFO?=
 =?utf-8?B?NkpNajJENFgwUnVBWGJDVzdGV09ZS09rRkZVcWYyd0tlUTFGT2dmTzFYT2py?=
 =?utf-8?B?OE04bExSUzBCTG5ONUp3SkZSdFpVQzkweUhiTGhUYVdmSjdxRmJTdWFUa1Jo?=
 =?utf-8?B?d1p5QlZVY1JmMWxOZEpEakJMQWpYNkYwbGxDSDhDNFRmT1lTT0xJajcwQ1FP?=
 =?utf-8?B?N3BSZHpqNURwNjJjNHZLaE1iOXEyd0xoQnBMNG4xOThDUzdyTmVEVXhGblhn?=
 =?utf-8?B?M21IZzJLZitEeTdVTHhLTHpNT241TjlIbFMxcld3dVpsWmlKdjk3YzZ5ZC9i?=
 =?utf-8?B?L0Vyd2Fsb0dJYUxPdVhjT1BlYVB2WldTOHBrQjdyUFFBb0FONGwwcHR1UDJY?=
 =?utf-8?B?N3BnMnJZcDYvci9sVTRscUJKSGx2Skc1ZHFObFNOQys2T0Y4cHh6d2JSbVF4?=
 =?utf-8?B?VW04eGZORktnYitKUGJaZ1Y1RlZyRHp5MFFLUExGSU55V3lnV2hpQWtxNSs3?=
 =?utf-8?B?SjRoWGx1a2xBKy9DRDh0ZGtWRlFFYXFZOU56QjR4c3dVM0ZUYkhDQVpKcXdi?=
 =?utf-8?B?VzQ5VEwxNGFibFIzZ0RJTXJOZmRQMjZ4d2pteEErSUpRaVBDYTR3SzM3a2JE?=
 =?utf-8?B?SEFXdHpQdXhVU28xbk9rcEI4bm43WHl5LzZidE1LQnZuaDNMNnJOT3JnZHRB?=
 =?utf-8?B?UlQ5WTVkOUVzMEJaNzNLc2x2ZUN4OGE2SDUrdzZBTTdyTTMxMWVTUGhUM2Zy?=
 =?utf-8?B?N3pwRE5aU3h6NXJqZi9BWkRmWHIzZWlkenJ3eWFTNmVmQzVIOW9ld1NNbHRn?=
 =?utf-8?B?aEhPN3o3dk9MS093VXFUL2JIMHFGUGd1WmppbnVZVTFrOWZ5YkZ5THFxZGhR?=
 =?utf-8?B?ZmFhTUZSMWJpdG5xSnJnUkxzanlkdHl5aG5xOTB1TG44ZEs0MmEyZ3U1OUZE?=
 =?utf-8?B?TVNqQnBkZk5XaHFtdi8rVkpQSy9MTXF5S2NZM3AzeUtLcnF0dUY0UjZUc3R2?=
 =?utf-8?B?NzBGRGRPYUxCMTE4Ym1kMDZzcWFUNFZNaUFMUTVBS3NuQ3dYYUNmVDNTSjlV?=
 =?utf-8?B?T0Z4NG1Zc05WK1htQVhJVEptR2NpRVliNnk0dGJKMnBLVzcwb0ZnWTdvK2Nn?=
 =?utf-8?B?TVJhMkpwWVFDZVlWYnV0TXVoS3FWNzlNbjRKUFRCQlhoQVlsS1AzaElVK2xS?=
 =?utf-8?B?bzdIYlE1NWhkU3UxbDU3U0w2Q2F5ckRVVnZBak83TWF4Y1R6TzkvNmZhRjZH?=
 =?utf-8?B?T2ViUmJ5THdTbnAwbUVRSi9pRkpXQW9SVm5rRmw4UEFHMHM1eEg1RGZwNHY4?=
 =?utf-8?B?TFUyeGM0UmRtRVh2Ym1PckxIUnhLTEs0RndyNGV1Nml5cHM2ZDg5QVdOVThR?=
 =?utf-8?B?bnYrME9ZU2NwUW9VcHFtbGRHZDR4SWU1MHIyMXBadm5XM292bk90RjN0VU9h?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G70zNc5gBaaZZHf9AjVK+Ps1Xiysl27Z6eDDnt5JBJvSZ3Eo8lE+GRoyj+k2WXehyCRM6q3qh70lccNTmHkwHDDtDNqGzsDW+JKd8B287Jce5TTZKNcJJ6/bj3m2ReOzKs/VFBnLg2322hytBB5PbE90uyY6zjk7xtR/VIVxLEDG14Fyrl3nVV5ABchKI2gCFbJ+oC0QeaXdN+LJE2yMJtQ1cUlSHBZUeNnULxQpvhrIFni2kBpyf+DC6RD6ss4zy061uCvzt0sEr4wBqRXpOfj2P/tC9macVbTBZ+Pw7RD3+T9pHEUymkh5J5Z5fUSULbzEqI09onPOLDFUVI7wCMN8LybVzne+dz8u3gOhkvCsl4WCYIzDqx9nlkIoKxllsiRmuRTum63QzvhXhLnRKuC13Vd5lLqDdD0xfprMzIlXDrOgQfdhcXd098ZftPaz3sx+F39WBsws5Cwf4Xn7ncYLh4kMdJsE/p4qDjCDgk5onoQH5BvserHDWLRaVlrjBMXIpjf/mATdvs0yibfn/3puh8+HFryKDLHQk9zdnO+N81dsQvYw93QjKD5d0nMhncDWPpiNqedSr4WxL44VyRWn7cEYuZ+dMMWYkF/Dnpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b7907b-ca47-4143-0adc-08dd2fe9e06a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 13:39:29.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0s5lTWLV1JA/5WJ7zFYpN/EnnjZNbB49+ncFaEOpBMmc6lyjEoDpTTZdEsQwqFYgQtFMhTbPbEfejHYTXs2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_03,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080113
X-Proofpoint-ORIG-GUID: g8xBPjWEZ779YY8agBoF7ZccF3u93Glk
X-Proofpoint-GUID: g8xBPjWEZ779YY8agBoF7ZccF3u93Glk

On 1/7/25 6:01 PM, NeilBrown wrote:
> On Tue, 07 Jan 2025, Chuck Lever wrote:
>> On 1/5/25 10:02 PM, NeilBrown wrote:
>>> On Mon, 06 Jan 2025, Chuck Lever wrote:
>>>> On 1/5/25 6:11 PM, NeilBrown wrote:
>>
>>>>> +		unsigned long num_to_scan = min(cnt, 1024UL);
>>>>
>>>> I see long delays with fewer than 1024 items on the list. I might
>>>> drop this number by one or two orders of magnitude. And make it a
>>>> symbolic constant.
>>>
>>> In that case I seriously wonder if this is where the delays are coming
>>> from.
>>>
>>> nfsd_file_dispose_list_delayed() does take and drop a spinlock
>>> repeatedly (though it may not always be the same lock) and call
>>> svc_wake_up() repeatedly - although the head of the queue might already
>>> be woken.  We could optimise that to detect runs with the same nn and
>>> only take the lock once, and only wake_up once.
>>>
>>>>
>>>> There's another naked integer (8) in nfsd_file_net_dispose() -- how does
>>>> that relate to this new cap? Should that also be a symbolic constant?
>>>
>>> I don't think they relate.
>>> The trade-off with "8" is:
>>>     a bigger number might block an nfsd thread for longer,
>>>       forcing serialising when the work can usefully be done in parallel.
>>>     a smaller number might needlessly wake lots of threads
>>>       to share out a tiny amount of work.
>>>
>>> The 1024 is simply about "don't hold a spinlock for too long".
>>
>> By that, I think you mean list_lru_walk() takes &l->lock for the
>> duration of the scan? For a long scan, that would effectively block
>> adding or removing LRU items for quite some time.
>>
>> So here's a typical excerpt from a common test:
>>
>> kworker/u80:7-206   [003]   266.985735: nfsd_file_unhash: ...
>>
>> kworker/u80:7-206   [003]   266.987723: nfsd_file_gc_removed: 1309
>> entries removed, 2972 remaining
>>
>> nfsd-1532  [015]   266.988626: nfsd_file_free: ...
>>
>> Here, the nfsd_file_unhash record marks the beginning of the LRU
>> walk, and the nfsd_file_gc_removed record marks the end. The
>> timestamps indicate the walk took two milliseconds.
>>
>> The nfsd_file_free record above marks the last disposal activity.
>> That takes almost a millisecond, but as far as I can tell, it
>> does not hold any locks for long.
>>
>> This seems to me like a strong argument for cutting the scan size
>> down to no more than 32-64 items. Ideally spin locks are supposed
>> to be held only for simple operations (eg, list_add); this seems a
>> little outside that window (hence your remark that "a large
>> nr_to_walk is always a bad idea" -- I now see what you meant).
> 
> This is useful - thanks.
> So the problem seems to be that holding the list_lru while canning the
> whole list can block all incoming NFSv3 for a noticeable amount of time
> - 2 msecs above.  That makes perfect sense and as you say it suggests
> that the lack of scheduling points isn't really the issue.
> 
> This confirms for me that the list_lru approach is no a good fit for
> this problem.  I have written a patch which replaces it with a pair of
> simple lists as I described in my cover letter.

Before proceeding with replacement of the LRU, is there interest in
addressing this issue in LTS kernels as well? If so, then IMO the
better approach would be to take a variant of your narrower fix for
v6.14, and then visit the deeper LRU changes for v6.15ff.


> It is a bit large and needs careful review.  In particular I haven't
> given thought to the tracepoints which might need to be moved or changed
> or discarded.

Some of those trace points are specific to the state machine that is
part of the list_lru scan. Those should be removed if we replace that
state machine.


-- 
Chuck Lever

