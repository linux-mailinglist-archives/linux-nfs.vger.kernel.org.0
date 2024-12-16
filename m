Return-Path: <linux-nfs+bounces-8574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01E9F3218
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA78166AAD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9B205AA8;
	Mon, 16 Dec 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwzWqcch";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vpSQupQ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DE29CA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357554; cv=fail; b=DYejbZP329/OehP7iJGk2d1Ixv7ExjfW3FfTiFjj2nqVkpOVK53Fp9zTdeYWQffxdDXjLXGkSVvb9/dCxA3XZM6oi1dwQ8rg8+2+WncpXouV9pe/c9ij9hJc67/0gLwZ2q0FMXmDo9mvKUaxUxDKomgKpapjpiLoJjO1V4Ba8To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357554; c=relaxed/simple;
	bh=QelJ+D5s9zpri0fFJS8/8XmaZKe5JHnioeLam2t4Q98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FW6bmCenlEfwgPB0dGJ/hL8PskyJCmsfy4Y+EhjsdEBwK1jp7DPcb5JbKjZv7BMqJKPekKNqnfOKmRVhXJA7k98+8TWCpK709ACTXOc+p4G4JWH+mzn75poYc307l/OQ9FfRlVCOgdAoLN+zvjsDxBCPDVrHVobCU+8JDwySjA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mwzWqcch; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vpSQupQ1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9Mqtp003964;
	Mon, 16 Dec 2024 13:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tZ5OeNih1InIxLD9enUl3sNk8Nb0ScdFMvYvidcJ7nE=; b=
	mwzWqcchCOYTBw96FjoAY7moRibcqbBsSjwH2yEPuCa+vzOPoV4R4diJbYpZLDE+
	fM7p49QOpNawE/RWv1q6c1UmknH3MXJf3QOjlqitNNpV0IrW3dA0uX0NZ8NzzmdR
	Qau8KcjVNrzO/jA4UzH2RGkQZ7iH8z6uZjCxEvvRuSf5ZpdOT9EG5oRPNbxw+kuQ
	ePUcMdgZhil6dl/GW/Gg9A5JeM3jjppWB5xrWPhu4XKoHVj4Y5KOKuknVJ50icEK
	IWvdM41uyKHJTw0qqe5nk7es1DxRhwzisCnxmsmOYObmp9BHUouI6aCtYGhLGQj2
	5D+TZSjxS/1uRomwDqAZwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj593w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 13:48:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCrTYg032586;
	Mon, 16 Dec 2024 13:48:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fda209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 13:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsppNrzUNVmLAX6nD14ciZsc+w7q2HZ2jojfL5C9LkRN2XWudQnDFiN+4mKP1PO45r0twv8Jw2+GPucH2dqkKHz+2FPWUx8Qzfn8mHuFei7yWsAB/iLJEQ9sJ4ZVRVUeWUVSg6nf8l44lQTfMWHzMd3jDApcCnhMZ0ozDkEHFFvZkhJCF3DjtOR8FhQFUEty9WTB6ksqABfmwflBPKJnEZ7DxVgB+lJc0d/p95BDZK4UkEkmz4Afe9OCaSQU/jgOOs68G7W40HWSdRJpd7y+cxvLr/HWD6YNt13aBnC410sWqxDLThmNKDYLkHHgCxqJ3r3dFPHUzCPAlv5jTD2Wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ5OeNih1InIxLD9enUl3sNk8Nb0ScdFMvYvidcJ7nE=;
 b=Tn7fSfV8ORq2QKavHC3ggNpnKKp06VTRV3uxy7CCd6CsypEY+QQrgc5s26qJhCXflpiVWO0IywgX1xNIminE8UUP9pDlNcyLv3FIIl2KhmBS4iScXccnCSc0MhHpxkKbbjXqVQ36BRPCrmm1WNqy158X+vm/bS0mSdCjeiZnTiHiFuuPPsZtGpv3HiH45/apQrSgGp5sjp6OspkirB3g0VK8KuirA/zcp7bNd8zmpNOKENVet/Zx1hNw3fjpH0EPwudr34BO7H2Sw6FxT1vsCO3nszDZRF7fdjTeweJDJco8JYoy46Pjm3N+XO/Y0ge3CVdkyhPaLnCzfsrLzNzgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ5OeNih1InIxLD9enUl3sNk8Nb0ScdFMvYvidcJ7nE=;
 b=vpSQupQ1isLrXjy0gq5O1N74TTQZd/g0GwWgnx7oG2IRFwqe2ockHaF5eLju7oBVpZtpljyFhDuWXmU+FiMg9mfA3m8QZoYinhxORzd8X5u2wjMHM7l8yQrRhdxtedJfV0NhVUlwMSunN54ziq2MfNVY70N/208+kl6Pc+GHeAk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6176.namprd10.prod.outlook.com (2603:10b6:8:c0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Mon, 16 Dec 2024 13:48:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:48:44 +0000
Message-ID: <c210fba1-181f-4e5a-adf1-4305c7f01ac8@oracle.com>
Date: Mon, 16 Dec 2024 08:48:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: do not use async mode when not in rcu context
To: yangerkun <yangerkun@huaweicloud.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Cc: yangerkun@huawei.com, liumingrui@huawei.com
References: <20241214134916.422488-1-yangerkun@huaweicloud.com>
 <eb4a56e2-d6d2-0491-fcf5-95d5c29cd7ab@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <eb4a56e2-d6d2-0491-fcf5-95d5c29cd7ab@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:610:76::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 918d5daf-208d-4fb7-7087-08dd1dd85b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0MzMXM0WEkrU0hBV2czcVdLUkhmTzYxeXBKeXQxUTBFaGJHOGQ2eVVod3pT?=
 =?utf-8?B?Vnp6eE9aNXJzMjhhQXR4MUk3bXVXandsUW91WHMrUTlnS0lIbFZVV252dVhF?=
 =?utf-8?B?dC9MNzBwWTBWRHN3MUpaWHpEa3hXSytmeWZBcE5uRWdrWjBZVWJIR1NqQy9M?=
 =?utf-8?B?UCtmcldLOVFqR3k5VUtZampLcmRaYTNaWmVwYzZLYWtlSG9xUDdhcVkxTVBP?=
 =?utf-8?B?ZzI5VS80UktNYTZtUXBKa0pTZUtRS29OK25xa3NuaW5DU21SOVU5T004WVFu?=
 =?utf-8?B?eDJqRGlraUhCdmpmWFlzamJvT2djdHd1aUVRQ29WUklCeEgycHlBYVh1akxj?=
 =?utf-8?B?aVVlU0pIV3NXY1JrZTBqVXlVZXJmdnhGclAxSzBhME5tTUYxWmZxZ0R1YVNS?=
 =?utf-8?B?dzg3QmZpc2IyTXpMT2YvaHlIU1pJeHM1Z29JRGRVK3h3dnMyUFNabVVPYkg2?=
 =?utf-8?B?UkxQOUVBWS9YOE9QcHdObFU5NktaOGhnMXc2NTJmajIyQkZ5Tm9Id251d3hp?=
 =?utf-8?B?S291ZjN6ZVYvUXJ0KzJVd0lhTU1XejlCbVR0MkxHa0h3d2N5NGpZcDVKMUJj?=
 =?utf-8?B?YlF1MUxGR2hXVlEvZS9vNTZuKzFLWUJjRkpmMTBiT1ltTEpKR1JOazFGbjAx?=
 =?utf-8?B?elBYUjArT055N1U5ZDhTeEdoV1ZsL3Rsc2VNNVdpdDcvaXkrZnpYOHFUNEIw?=
 =?utf-8?B?V09pb2QvbWg4NFFqYzdCN1dKeWVtSklJeWpoM2I0Q1g2NU5GamtoWlFTcWcv?=
 =?utf-8?B?T1lyVHdQWll2REdtY0kwWW9NTjNrOEVlM2ZrdVNEL3B1aXhManRuSGIwL0xv?=
 =?utf-8?B?SHJpM1Uzemk1VVRMWm5pV1RhQzl2b3pLc1d2RSthQWREVmlXYm8xcjN1eEdV?=
 =?utf-8?B?WnlYS2ZPck9jOGFyUE03OFdQdzg1SXMya3o5aSswS2pjOURHVVl5em9ralc4?=
 =?utf-8?B?VmJDYkNYNWFHSmhuZTNyNVVQUjk1S0ZGRGNyNEwwQWtUNU1HZi91T2NlUFMv?=
 =?utf-8?B?Ykdud0hERUZ6YSt4NnRUaW5hOVRRVTNFMGV4dVl6OXhoZVJKcDByM3pJelF1?=
 =?utf-8?B?OEhVSG93V080OEpHR3JuRFNqZWVQT0luRGQxREFSa2tVcnNpMXJBN3RJZWl5?=
 =?utf-8?B?Vi9jOUtxQTk3UjNsMUN6d0dpeWFXVm5UenBBMnUxTTFhYzRDdDZ0empOVVpF?=
 =?utf-8?B?R2pxT0pGdDlmYy8rbndCcGU0UFFQT2xubEtEa3ZWOHBjYVYvRmhLYW4veUVn?=
 =?utf-8?B?OEZMTTFLNFZtTlFUeFYyL2E1b3F3bW5WY2kwN3Yxeld3cnhwWFNkNkdxbXVQ?=
 =?utf-8?B?WDNiODI2d1ZkSW1oblRMNGl3NXY3QU9zbzgrd2lsWW5OM3dpOWwweXB4c0VI?=
 =?utf-8?B?SWVXMkNNK0d5T0hkQTYrWWlicUFhNTlKdk56eUJXMUk4bmUwQ0Fyekwwbmp6?=
 =?utf-8?B?Y2FnUnQvNHpiL0FzVGtGSFNpUXd3SWVGZDdkNVA2TWZjZGNSTWdiZ2NEL2Zh?=
 =?utf-8?B?c2llek0za1FHUnRmSHZLUC9acXQwTllDeitOeEZZMjhJMkkrSVBya0J0WVNK?=
 =?utf-8?B?UlVCYVpQM1JUdXR6RHcvQ1Vsd214cEVKR3JYZGVzbHNZWWNCRHRlSmZyWVh5?=
 =?utf-8?B?NkxSbURpNWM3ZGJzWThkWWcwRHF1amdIaEs1a25WK1Jxdi9HTFZHeGtYSWRH?=
 =?utf-8?B?WExHSy9mZzNPT1I2MFVMRi9FU3Z0aXJrQkdVN2ZOV0Zjbmk3OUFvMGtNVFpJ?=
 =?utf-8?B?b0RXU0VDc1U1UG4yNnJTV3lqdTVwbnI0cmRtYlpKd2ZSWGd1VndFazlqYjlx?=
 =?utf-8?B?TGZSSDAzMzJmQmNoSERmR0dhVjFQU1lianE1bGtyL0YvdlVqRC9GZENOS3Z4?=
 =?utf-8?Q?mm4ACRVCwhgcL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm8xOFRkMGNOb0k0bW1uc2dOSVNDaTJ1UGd6aEdaWkM4TU9DV01hZVZKODd1?=
 =?utf-8?B?WUdLWC9HN3MyOFFoYTZwbmZSbHRUUnVvYmpUcWQxRkhJUldGcDg2dUtvUGU0?=
 =?utf-8?B?UlY1OU4vblROSmlmOXREaCtadEhCUjFXbHJneDRqVzJ1MUViRFFEWE5Bb2Zm?=
 =?utf-8?B?RXM0ajdkbkM4OFRmMUJ4RHVjbHAzMGlnbmdhckkxeGJLVU85OXROa1BIUGRM?=
 =?utf-8?B?aGdkSm4vME9MNmlKQ3ZEQ1A2cmN1SHFyMnVxRVBLY3NKc2ZycXRYRGpCTGJW?=
 =?utf-8?B?NjVTYS8zbXNIV2FOYlVjTUtvQ1BxUXJUL256NEtXZnVzMHQ0UXN1Qm81aHQv?=
 =?utf-8?B?M2NGSVpoMmlUMFE2T1l1SEI3aDZVK3dyeitnL3dkWURBazdJOVcyaTcyM29j?=
 =?utf-8?B?cHp4SWFRMG5WbGpid0dKRmpWd3AwNWJoVkV3aFNJVzRKNVhtREdiTk9ONE15?=
 =?utf-8?B?dTZKU2NiT3BVcHdod1RRUjdGQjYzZFNsSlZCM2k2MnBGaGtuQ1drSVc1Tldu?=
 =?utf-8?B?UDBqZDIvbU5QS1BtSkd5S2QyMGwzTGxXMG5VRVFqNll1dWRCakxVRzR3dW5w?=
 =?utf-8?B?NW9mVE9BNHg2NFl1NlJyd2trbW1aV2F0ZjB6MzNqcHVGL1diU1I4VDJyNVhD?=
 =?utf-8?B?UFlHMnVHS25DeVJ6di9qZURicFNLZS92d2tSdU1iNGxvREtoRWlna2JTSzU4?=
 =?utf-8?B?T1VvQ3pzYW1sN2RzWTFyZnV3bys5Sml3d0F2aTA2dlQzV01yUzNXS2pLWWZn?=
 =?utf-8?B?bUdlYVBKWWZ2d2l3S3NwLzhGUGNtOGpzSmd1NkwyVTZWRVdhdGJ0ZW1sazdl?=
 =?utf-8?B?cTBVSWdOV1FJM1dPbWkzczdIc0xmNlBBMFRhQlVxazF2MXdkSGI2YXBCTWZn?=
 =?utf-8?B?UFRKNXRIVWhqVVhKYUhUOU5nWW0xWXlzamVLN3FIdmJBelpPbHFCOG90bW8r?=
 =?utf-8?B?WXBFUGtOb1FFMkNIalVWbE0xR1JFV3RCbERvMGFoc2p4cEtaazQvejNmRzd1?=
 =?utf-8?B?VmJzZHluRmE4VEdDR0dyZHJ6bWpBTlFETVBUb3RJVkw0TUN1VGZDWDJaalNY?=
 =?utf-8?B?RFRHTk9jNis4Slh1cFNnaFRvVkNraDNzR2NQSmdJRUlLOUxJMCtXcXRuUU1E?=
 =?utf-8?B?Sk9tRStjSVNkUzIxalg0YW9BcTlyOStDWjRwRFVncGZHZlRCQkZrS0QzTHh2?=
 =?utf-8?B?dGZ5MHlWd3kxdHZWRW43YkhmTDJDcVlkNE9CV0IxSk1UdW0raG91VmVleHJy?=
 =?utf-8?B?cG82UGxZT052Tk0zMVpGVUFLdTk4ZnBaM3prVWZUREc5aVpYWXZGakV0RnFM?=
 =?utf-8?B?VWpUUkpYVlJhMG1jZkdTMEUyeDRPUGpzczBxY1JlWHc0Zk9nd0gvWFY2d2ds?=
 =?utf-8?B?T0lZaGp6eEZjb0lycjNrUVZFcUlmR0hsbG9kWXpPenNHRnZpdFpKZEdBeW1N?=
 =?utf-8?B?UUFoY2lsSXMxOVdWR3BJTjJGV2t2eXRlNnd0LzNxd1VyT3B2RnpzT3dVRXVY?=
 =?utf-8?B?dVlxZjZTMEoyOUtYOGZxTjc0czVUMkg0dXpVcmJESmRrc1JXVlNuNnlsZEhr?=
 =?utf-8?B?dGxQTXBOL1VUOEU5QlJPTit5ZEUrdXZtUnVLclROclgzUUZLYUdsaHd3aHQ2?=
 =?utf-8?B?MWZEbFNnMHFFRFFuTkJkQ1RHVHBEMVNJVE85bnBJUm5VZXA2VnloWWFSZE5N?=
 =?utf-8?B?RnFXY2t1QW04MG5BOTM0WUpLODlOeWlkTGdPYkpjcktwTWovVG4xRWk3ZGo1?=
 =?utf-8?B?UTlMZVc3WWxodmtKWDY4RXhXWVdLaFRFQ3NNUjV2dktjUnNmeXdSRjk3S0Zv?=
 =?utf-8?B?ZEJ4WUN3UzZuYXJkakVhcGRFWVV2Z3ZtS0VWK3cxQ0JhTVN5THNWYnpmcDlC?=
 =?utf-8?B?dHFoSnhQQy9KcWxLd0ptQ1A4TGg3SjlOdStPU1AwRllSbkZsNmpJOWdROEZi?=
 =?utf-8?B?VFNhcGdqNjAxMGNVbEFZM0sxUVE5V01rMFBIMnNLZmpxVEFHNE11ZWJITndx?=
 =?utf-8?B?Y0t0VTBMZUlSWnJQOE1DeUh2eTB5OEJFcm42cHJSV0JCMWNQV1JRd2ZXdHRp?=
 =?utf-8?B?aGlXK0xvSWw1RUNvaGJUaGUwcDNvVnJNdmxEek5FQ2g1MkxBaVZSY2VkNmZ6?=
 =?utf-8?Q?iM+5P7AcywwTbnnzI5xsHh6Gk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Npe13I1il/CWNNXPShbnQmis33+l9Z6ot5HENh7OhFlPpxBaZiJ7qe+q/ZzXgDhojHmWUIS2w1ikkLYkORXWOtEvqddjLIqvzOEaIeejaDVdTTrr+TS97L2W4Ym/+aeRgA0u3tCW8HfXVqOEJmOTNtm6yWmrXFv0bOEJmqnDglqKeJz5N7zcwoRLqAX+vBTAkHaq8iO4yPXl+f19dwiWiUR66Gvorru6hLp35DrcAlonpUwfWbxVw1KOsH3DmeMVj+Im7+ojR1vpIB+0Bn5AUG0+Js2atHQSmbOBVbzOwRuANPiK8UfhArdMMLJljR4cAjocGRUF4IidJ5i13P0RO7Qqo7168FHwcu27BA+1EAaCeFjjU3eiGWxDjT/ms+mCsnumVBe3wURCgr4VWtZ/ZTgflIke4iva8Q0gi6WvqDnZ/43NP4WKgt7G/owf6FLeKwMOwsUMv63s9GP/L4IJARWi9TSBeWUemdQsRqeJVeGqjtDG+MzJ1FiN1iPnqBo/g/S5JigiIDeBaMq/lg9BTVpb/gAbEo6CxSd9h0/lskvi/ltO1eSGFgUoHuFwN1hAD+jPdNvzSSFuncYcdnMTc4Q3uuY7YVWSOrdDbvIZ4i0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918d5daf-208d-4fb7-7087-08dd1dd85b80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:48:44.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThriRGBqVXCpDEZa+N/a2eTcxMXUoXRZ8gHXjY3yBwNOh4aByvA9Ccjm9ziXA+IL4Erb37EmoHdU/6O71kr4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_05,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160117
X-Proofpoint-GUID: nx9Q4dAZ8eKSN9GOJljh3vAMHAPGmyb2
X-Proofpoint-ORIG-GUID: nx9Q4dAZ8eKSN9GOJljh3vAMHAPGmyb2

On 12/15/24 10:18 PM, yangerkun wrote:
> 
> 
> 在 2024/12/14 21:49, Yang Erkun 写道:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> shell:
>>
>> mkfs.xfs -f /dev/sda
>> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
>> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
>> exportfs -ra
>> service nfs-server start
>> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
>> mount /dev/sda /mnt/sda
>> touch /mnt1/sda/file
>> exportfs -r
>> umount /mnt/sda
>>
>> Commit f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
>> describe that when we call e_show/c_show, the last reference can down to
>> 0, and we will call expkey_put/svc_export_put with rcu context, this may
>> lead uaf or sleep in atomic bug. Finally, we introduce async mode to the
>> release and fix the bug. However, some other command may also finally 
>> call
>> expkey_put/svc_export_put without rcu context, but expect that the sync
>> mode for the resource release. Like upper shell, before that commit,
>> exportfs -r will remove all entry with sync mode, and the last umount
>> /mnt/sda will always success. But after this commit, the umount will 
>> always
>> fail, after we add some delay, they will success again. Personally, I 
>> think
>> is actually a bug, and need be fixed.
>>
>> Use rcu_read_lock_any_held to distinguish does we really under rcu 
>> context,
>> and if no, release resource with sync mode.
>>
>> Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with rcu_work")
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/export.c | 44 ++++++++++++++++++++++++++++++++------------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index eacafe46e3b6..25f13e877c2f 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -40,11 +40,8 @@
>>   #define    EXPKEY_HASHMAX        (1 << EXPKEY_HASHBITS)
>>   #define    EXPKEY_HASHMASK        (EXPKEY_HASHMAX -1)
>> -static void expkey_put_work(struct work_struct *work)
>> +static void expkey_release(struct svc_expkey *key)
>>   {
>> -    struct svc_expkey *key =
>> -        container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
>> -
>>       if (test_bit(CACHE_VALID, &key->h.flags) &&
>>           !test_bit(CACHE_NEGATIVE, &key->h.flags))
>>           path_put(&key->ek_path);
>> @@ -52,12 +49,25 @@ static void expkey_put_work(struct work_struct *work)
>>       kfree(key);
>>   }
>> +static void expkey_put_work(struct work_struct *work)
>> +{
>> +    struct svc_expkey *key =
>> +        container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
>> +
>> +    expkey_release(key);
>> +}
>> +
>>   static void expkey_put(struct kref *ref)
>>   {
>>       struct svc_expkey *key = container_of(ref, struct svc_expkey, 
>> h.ref);
>> -    INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
>> -    queue_rcu_work(system_wq, &key->ek_rcu_work);
>> +    if (rcu_read_lock_any_held()) {
> 
> Emm...
> 
> This api won't work when we disable CONFIG_PREEMPT_COUNT...

OK, I assume you will send a v2 :-)

Can you include the reviewers listed in MAINTAINERS on the To: line?

R:      Neil Brown <neilb@suse.de>
R:      Olga Kornievskaia <okorniev@redhat.com>
R:      Dai Ngo <Dai.Ngo@oracle.com>
R:      Tom Talpey <tom@talpey.com>

Thanks!


>> +        INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
>> +        queue_rcu_work(system_wq, &key->ek_rcu_work);
>> +    } else {
>> +        synchronize_rcu();
>> +        expkey_release(key);
>> +    }
>>   }
>>   static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
>> @@ -364,11 +374,8 @@ static void export_stats_destroy(struct 
>> export_stats *stats)
>>                           EXP_STATS_COUNTERS_NUM);
>>   }
>> -static void svc_export_put_work(struct work_struct *work)
>> +static void svc_export_release(struct svc_export *exp)
>>   {
>> -    struct svc_export *exp =
>> -        container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
>> -
>>       path_put(&exp->ex_path);
>>       auth_domain_put(exp->ex_client);
>>       nfsd4_fslocs_free(&exp->ex_fslocs);
>> @@ -378,12 +385,25 @@ static void svc_export_put_work(struct 
>> work_struct *work)
>>       kfree(exp);
>>   }
>> +static void svc_export_put_work(struct work_struct *work)
>> +{
>> +    struct svc_export *exp =
>> +        container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
>> +
>> +    svc_export_release(exp);
>> +}
>> +
>>   static void svc_export_put(struct kref *ref)
>>   {
>>       struct svc_export *exp = container_of(ref, struct svc_export, 
>> h.ref);
>> -    INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
>> -    queue_rcu_work(system_wq, &exp->ex_rcu_work);
>> +    if (rcu_read_lock_any_held()) {
>> +        INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
>> +        queue_rcu_work(system_wq, &exp->ex_rcu_work);
>> +    } else {
>> +        synchronize_rcu();
>> +        svc_export_release(exp);
>> +    }
>>   }
>>   static int svc_export_upcall(struct cache_detail *cd, struct 
>> cache_head *h)
> 


-- 
Chuck Lever

