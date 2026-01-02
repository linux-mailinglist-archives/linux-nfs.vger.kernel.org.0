Return-Path: <linux-nfs+bounces-17397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7A3CEECB7
	for <lists+linux-nfs@lfdr.de>; Fri, 02 Jan 2026 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06CD3010993
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3D226861;
	Fri,  2 Jan 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gFOInlmD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k6rj9xe0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E3220687
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365374; cv=fail; b=s2pmcYCTWhVpQvXGoxkEmCeS7+NnxeUO+374Wa8Hd8+3h6qrK2cHYhDOV1gYaQx6Jc45ySJPvsPZ4lSfWF+9xuHWsMh5PBw/oiz+5z7briBesHmcxBUqhC0HdLTOKxHhkTcc7P5AmHInT2tYCN2Yy+iTLh7ObSDqcadE7LVgL1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365374; c=relaxed/simple;
	bh=J1ud4j/4LQ/zpSfDhey1gmUEfg0eaQslRlWIBFafdc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMYqnAiAPm4jyvFQ2Q+pJEKaLANCUu08Lemt9jKM/82orTY3BjoEU/l/PiwVXby+9CSjjVS2PWB+6Z3S6N8kh/hJzu1bNTBlMCnweiR2dcNEy/clJ2/bLehir8qKEeqiIWLIh4gBW3vQR90vu4zfnYO9HTfqgx5v3B4kdkaLEPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gFOInlmD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k6rj9xe0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602Buqtl2923649;
	Fri, 2 Jan 2026 14:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SfK3dcQkqt+4GZErjgA0qGdh1kC2Ywl1p6VLM7dKYvI=; b=
	gFOInlmDEmyIS2FcU0I0uttmqFLXRs5XwrSG8l29NmrULXeSZHlhk7Gn9sMcFAY3
	kVJtnP49Cito3aTsu39V50u6juyH5AteYEEJ8GGtf+CZ8K3CP5jDaISyOA8Qtxt9
	dV6ifrJB3xXoiT1bpc44w9rF2aG6bOyjP+6fl9Xy6XU3Y46Lo8AgvTddr/nl3X4X
	9OHc2XvWNX4SXjQBRZ1iHIIRVlnCK6P14M/UYfSkvACn1dgkhJtq0KUxdX5qzEWi
	xPwGVlwnJOtM7yU0q08Q6s0lEj2CDBVItgIcV6PW/7ZBaXMD/zYPHRtw4uMZ6Vfd
	xFbckFuxwc0TkTjLXe9vaw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba6c8w79q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 14:49:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602CgxmK012802;
	Fri, 2 Jan 2026 14:49:11 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w9wq80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 14:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzrlDd5bkt3YDTpEec6gFh/QqWNefc8VvNp0IeG2JMwFRdsrkFf1ujklkBaiJuHDKZv/ssUfEwKGIq4fo11Wp0e10wLx/aSImyJtPG6ymq4+yn98LvvJupixzAJlJ2x3NB8Dw2VSG2gR7nKgvnM1kf7B9GIfsaL+XYT3N+u+WoN1XFnPrcoaGTvHunUulPyoKmVjVXveOD6HA1ljhFaiMngIFwJBHWXcRHLzXHM5rwgyqt/pY+qBqV5fbAffRPKLUDj583oabxzUhyfmYlCR/X+lSY1w2L62lXUfKwveiJOGYLAAzc32AcAOlaur+XZ2LkdbNhan9i/KSi1SCBRhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfK3dcQkqt+4GZErjgA0qGdh1kC2Ywl1p6VLM7dKYvI=;
 b=x0HmEyK3GNxU6YGZkCU7Zul50/KOxw61b2vg3MUSERTRWF5cENP/wu82YLViVIm3Gh91pFv/0Lim/XxLMZH/X2pmWV0Xcy4DgjAyzBo/UOqK44j9SqFf4kt6oRzsHGRQ0ew5ZOckdOVx5qlkWcr1jQmho/HMautEHYjGq65gzr7A8DNFAQJ1ieKGvQXe6q2h0LFQpIjdK9UAxocOCrHjXvJVlfw/I3lypFIdE2BVjJNBGHO0bCO25lzW9zD5aFg3QJZm2fl3Pta0l0WwoNNyr55yayxXcTdTP5e5IiE8RcLPOcuN6TRbk6eKIVQWTb6Tr77mIcfW+P1yIPiVZ7Abpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfK3dcQkqt+4GZErjgA0qGdh1kC2Ywl1p6VLM7dKYvI=;
 b=k6rj9xe0qSrHxFVdYQeHD5mG7TLInJAkSsx7j686mYB05g0yC046OEgHU9mNUNOXTpdBdYi+r+xhWsPDAv4N6saY3QdPGD91SPVSDCPtpuRz/7oQpnGkzYGw+7avVlyravDxt5tifVJCEiqLPhAPLVnm6GTrqi3uM3+RqKUFlhA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPF2BC420A1B.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 14:49:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 14:49:08 +0000
Message-ID: <522f612d-e792-45c0-8bca-73eb3f075897@oracle.com>
Date: Fri, 2 Jan 2026 09:49:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: Check if we need to recalculate slack estimates
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Scott Mayhew <smayhew@redhat.com>, trondmy@kernel.org, anna@kernel.org,
        linux-nfs@vger.kernel.org
References: <20251119133231.3660975-1-smayhew@redhat.com>
 <ccd7d6aa-f307-4d4a-86fd-1920580bdd79@oracle.com>
 <aVe7TOFVxckWdF1m@eldamar.lan>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <aVe7TOFVxckWdF1m@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0055.namprd14.prod.outlook.com
 (2603:10b6:610:56::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPF2BC420A1B:EE_
X-MS-Office365-Filtering-Correlation-Id: b52696a9-758c-4b76-5a02-08de4a0e1549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUkybWR4WllUeXZLWlgxc3hwWDBRdWFUa1NCYld0WkROZmdObTl6UHkwSUlC?=
 =?utf-8?B?STZjV3RCaURpaGJNWlJDZ2hoSzNJWDNFeXQ5VVkxK21GRWZyeUJDeTVQRHdL?=
 =?utf-8?B?NnF6L1FwcG8rSi9pN3lPS3Y2akdZaERnMWovaEdnWU1CZmVwRStlMWdaZkVp?=
 =?utf-8?B?RTN3SW80b0liVWxMMGtlZEJjaWVWYjUxOTYxa3MrNXhuZEEyK2NJc3Rqcncw?=
 =?utf-8?B?YXFKTkNFdmlaSEhJVytnT0dvZHBWdEU3UjViTGFKM1lNbktvT1dXUDJyaGRT?=
 =?utf-8?B?ZCtBYXptVTFoSGVFVnRMK3dWOUljeExaTCt4OGhCbXFHMWZwNHB0S2Q5ZEpC?=
 =?utf-8?B?V29rVHN6Z3dVKy9XL01PaWQ0WEhRTytkRTg2TUgwSDlHZk1TWU1RRGQ3T3pJ?=
 =?utf-8?B?OE5ieW95cnVlUW5pUFRTUFd2bGZPTnlaelBHMngreDBFOGx1c1pDUmM3dUdy?=
 =?utf-8?B?Wnl0WWpKKzhQYnZ0cTRwZGlEa2swQURFSU0zOENUSGZGMHFJYXB6NVB4SWFE?=
 =?utf-8?B?YUI2eFlyMXBGRHBlYTFZTlJIOUc2MkJDZGhqM1QzamdvWkYxazlRakU0SXpP?=
 =?utf-8?B?Y1pKQmluaDNkdzlMcndydysxZDZwcG9CaFdlcHJnaUxzdHo2cUxxUXR5d1B3?=
 =?utf-8?B?NGhtTlZDREVFNFNjVEs1WGl3aDdEZWwrRW4zU0hjUjFsdHYyeE5mRkV4dzQ0?=
 =?utf-8?B?dCtrdFRBcUdHUys2ZjJ6RytPYnJQNmdocUkrUXV5UlRqY2Uwd3VxaGZnTTVZ?=
 =?utf-8?B?TTQ5WjlRV0lmN3F6cE5jSFZZQ1F0UHRTbm5GZFdhVWw0cVBxOTVEdmRmL3JW?=
 =?utf-8?B?Ujd1Z1dFcjdBRWJOcGlGemt2VzRLRGsxbVcrV1lwRW9TQVdCbmdhVXQvM2l1?=
 =?utf-8?B?b0grMjlTNDBKVkxieklhN2pBWkloZGdnTUtWaUsxRjhETVAvUktiMEZsRHhn?=
 =?utf-8?B?SDZNUURKRDlBZTBBVUg1RERRc2lhWWtNT3BDVFZLUTNQY1Zvb3JOWnBEanBr?=
 =?utf-8?B?SU5XL01RSGV4TlJCUFJ1Ky9ZUHA3N1BRd3NicXNmWlQrSmd0YnFXNXloUi8y?=
 =?utf-8?B?RDNFWEdJb3dLMEFTWWZDQm44dWk3UlhpK3RRcVNOd2g4TXhSaW5yb29rMmVm?=
 =?utf-8?B?dXVuZGFhSUdZWHJ1emttRWlKYlJqdlhJK3pVRUlQTHFCY1BQdzRCWUdsNWd6?=
 =?utf-8?B?RkRWbEZJMUl3M09USGpxejlha29FL3dzMVFOcGRBQUl3VFl4NmVqVStvU0F1?=
 =?utf-8?B?aVZNbnV5MXlLeFNLcGJieTFjMUhEMGR0ZXFrTkZueU9tOFQ0b2phNHNuaER4?=
 =?utf-8?B?WWxQMmM2ZmlhdExUdmtPTHFTOThtYXBSSVppTUFNL0hlTHJvdjAwRXEvNE94?=
 =?utf-8?B?eHp1NnErWmJpeEJ6a1VWODJMZ0ZsVnpvSXluVlZONEJieHMvT1VyV2xqRmpD?=
 =?utf-8?B?RTRkc2ZCcHZUazlCWkZVbnowRmxqZUhwdjNrNTVIWUZpYk5SdTZLMmExSDNK?=
 =?utf-8?B?WnFSVnk4WDN3WWRIdjFaTE1ISkRyamI5eGllNGV6N0svVXBEYzd6MitNbzFs?=
 =?utf-8?B?YzNIVFk4QkdzSXpwcmFMK29jK3BtUXdKRWMxNFV4c0lqZmsyb3pnWTYzWklH?=
 =?utf-8?B?ekNKcWJabnlBYmdsYlRuWURldUxOR3ZhYUVSMS9RcStJS0ttenJuZ3pSYmk1?=
 =?utf-8?B?dmpoQk9VdVBDbUNkVlhwYVZiSzhLSDkxQ1R1RFkwMXJZbytVeVZ6RlNQNmpi?=
 =?utf-8?B?QXpuazI0ZE1zejJtV2lHbGVvRzIvTG5IeTd6RVNnaUFTcWNiTkpnQWpaSTFX?=
 =?utf-8?B?ekYwUHBEbFRCREJGdVRtMjBsZDBKaEVzdnlzclVJUXV5K2xkYklXcDRHTkxV?=
 =?utf-8?B?aGNuemxQc2lZd0dBalJ6SmtuY283Rm9LZEtYZXEwaUR2SStqNnNmSERUSEF5?=
 =?utf-8?B?VDdqUFZ2VVYzbDEzaEpKYkdrR1RacWJaMVNqZ2MzcmdtUTVMRTBDRXpxZWYy?=
 =?utf-8?B?WUU5TXF1TVhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmQvaDZNSzQ3OHVTanY2aDNBTVQxQyt1OVVPRm83RG56dWozbDVmMjhCM3la?=
 =?utf-8?B?UUxaNVora3ZEL2tPd0d5REVrR3Z2L3VXd0gvaTFzTm9OUzBNU3NEUDN4aU45?=
 =?utf-8?B?ckUrL0tYdlZ3NnBiRWl2N2tBRGNLQi9XV25QbEh4dnllaDIzT1VoTFg2dzBs?=
 =?utf-8?B?Ti9YMG0xZEpSNTJDU0tHbjE3WmdxQlg1am9aY241OFhnNTVXYXJPZ0U2MHAw?=
 =?utf-8?B?L3ppWFlVMmZSOEJPVGNEMEt5RXFwdTdVTHNCdThUaGhOUHZuSU40YVhrZnZC?=
 =?utf-8?B?UDgrM2UvYzdDOWk0OVZSb2grUGdOYlhSSFhCMjNXTGFQRTYyZWJMVHhrYWU3?=
 =?utf-8?B?dDcxNW9ZTGR6Mk1EbGdNbExvRGJCQ3BsS3FaN0RTK0pQb2Q0cG9RSHEwMlIr?=
 =?utf-8?B?bXo0bERadFdDRkVXNitjZ0kzQTNaUXdHOUEzTDRvREhHbURxYmI0SWE2SjVD?=
 =?utf-8?B?RzJwSVFLczVXT29mdmhCYTJPeWFOdVlrL2lUOWsvVUJCZWQxUkdKTWdnN3ht?=
 =?utf-8?B?RklPbVFRK2QxQjhBekNlbTR1eW5Xd1NzejRHcnZPQkdUTXFiSjNMVUJ6Mmtz?=
 =?utf-8?B?VGlsZDZ2M0UvWVhmSUIzMEx1OUlHSjFzZXF2QUN6VURCUzRGWm0zdUZFTFRt?=
 =?utf-8?B?dzMzM2ZxciszSnR2TFpoYkw4OHh1R3NvZDNwQkdZczYxWXBzUE9IeEhyR0ov?=
 =?utf-8?B?Zzl4L0dIL243OVZPSmhSSG91QjB3L1hMQnkyc1hHanI1eWovN0JZTkZqOEtz?=
 =?utf-8?B?OFJoS2hUT1ZUckNJVnl0USs2bGp6bkg2NTVjUXVlYzg2V3VIWGViakhwa1hI?=
 =?utf-8?B?Q1RqMElvODRWVmZoMFRhNEp6dG42cWUxaFpkbTZDSXJ3TW1CcmJZSmtVWlpt?=
 =?utf-8?B?Q3JwR1NCeFlvQzE2bTZEamFJMDdGazNhYW1IKzM2VFB1VXpRVmkxdTNESzAv?=
 =?utf-8?B?QUc0NEhQUk45SjBmU0txNTB6NWlmMWhCNU80ckFXOG1tNFNmMkN1NGtxbzJT?=
 =?utf-8?B?TEFYQnR4S29NOE0xRDRsQUprVUdDaHg3WVZiQjZQWGxUS1daR2IxT3hkM3dj?=
 =?utf-8?B?RldDVHN4K2ZPNzlOWW91Vk9ML0FvWXFDc0dkSG1BMlpXaG5CRktZMHR2Qkhh?=
 =?utf-8?B?TXVRelNuMGEzNHdIbm94VDFlTklYcjBmMWlCc2hKNitFS1VwOHNrcXFFMkxM?=
 =?utf-8?B?U21xRzFLTDNvZ3pkd0Q0ZXY0d2ZCTDRWOWdGR0RDanc5dVJFRU8vQmVjQWNI?=
 =?utf-8?B?b3JPMWNqVnFaNGl0VkhYWDFUaDFQd296Y1JtdWpYTXFXdEM0Smc0TkQ0eW1X?=
 =?utf-8?B?MmtHT1Q4SjR1UGhPN3pLVzhza1c0RzRhVkVObU45MzVlYWR4TDArME1ibFFt?=
 =?utf-8?B?d1lCc2QwU1Q5aUppRXpOWUNRN2Y4dG12MFRoUmdZc1dDZjFtcWxZbmEyNFlB?=
 =?utf-8?B?N2xuTjFSZm1SSUo0TWNUWC9FYzNEYW1GZnovaFNheENRSlRXM0lzcjBYY2FN?=
 =?utf-8?B?QzcwN3pVNW1kMU5JbDUwR1VoMjV4V044ZU5DaDRLSTRrdWNRUzM0RUxLb2cx?=
 =?utf-8?B?WEYxMU5ETVgzcDhQOUhpZ1k2dG4ybjVBVDZRM2JwMWloZjYvcTdZS3dGby9v?=
 =?utf-8?B?RCt3bU5UajR4Vk5zL0xvdVhCR3k5a3JxeXpJWUFlWksvcEhkcDgyUVhGR0dV?=
 =?utf-8?B?VE02MHRzSmd4TGp4ME9QZ1NTUmx0cFJvTEwrZ01sQURieFZkaWlTOXZvVTFW?=
 =?utf-8?B?Y1NJTFpkMjlVcjdzd2JoaXBETU1EeEgzbk1Ha0VqTmNwRXVYRW4rQ1ljaUox?=
 =?utf-8?B?RW42ZWlrWHFweWpMNkYrbk5PK0Vkc2lnNUQwc3JxK3hmZ2J5cUZRd3hSTEJW?=
 =?utf-8?B?S29YQ0Z2RVZtV3NQc092NEtSbXBDYmFJL0U2cWQwbEJONmZkMW80M3BPYmxC?=
 =?utf-8?B?QTUwOEEyY1dpNXJGMW1wQS84NHlWZmR2U0JLQ1lrZHJESTFSRGliWEtQNFQz?=
 =?utf-8?B?eExKSDhOdkVFZlRIZzgxTFlJdUo1Z3ZFTUZXZG5lSzVEN0grbk93ZFFyVUsy?=
 =?utf-8?B?MHpyRloxMmZ4VjltYnhkY3pYR2xsYVpFZXJLdjQ3a2xnQUJ5dklUSk5NZktL?=
 =?utf-8?B?REJmeVpzdVlwYzNqaStyWjdyR3lzUEQrWVVNcEszcHVHU2VEd09vZjJrRlNQ?=
 =?utf-8?B?ODk4Y0h5RUFERU9KK2tKN3dMMTJhOXUyODJMdnY4aW42ZnBvM1lDL05wOG9C?=
 =?utf-8?B?NVc1NHA3Skh2dFRFMUFwZC9rdGdhM2VpaDdZNDhveHJZK2lKd0xLWldDUmp6?=
 =?utf-8?B?U1F5WEc2SlorQjNFSUU2ZTRMTUZtR2xkQ2FIa09TS05OakpaeVJIZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t3up8e883HefRK9MWKBK28OzzZDaqFTj4ttcUrCYJCRwhYMnpclhoK+BdGRuESYeNcXFBbnzcMfapoRwvh3ioY22IexTFmx2I22SV00avC3qva9RszV60zM2mul/iPa7yViSem1HOBWnrzZ2TkTKgnUhwXtfJPvHC6uyL8OP+ocLzc3JFidEwtmFQAHJMKYo3Tt7SXEMjHiE70QUXxa9uvMj+1ewAhV5vlFq/gCnXYJlUhnjsiGA9IkM6HRV0H3Wz0WM2ThxMHr1AYefOBzBKvikOXVt+Lc79wdhAZc0Sq1MDkuBZKN2TTij2ER5LRiVZo0rXgVy1Rm3Hm9Zz5cJtgf3VKrfZvMZRPjLQruY/zGLcCDgmIzSdlPAKNLxcmH1TvcrmMl98O3mvAlRvqgVazMAeNPs2V5/qwgCXNPzzAsXn2ABF8hsOxPqy7rXwmBStG0zLaMNeTdX38QYzuvYFhTKJI4VkyRwjJskbjewRZFC3zz53SoGQOweNiy5YsQEZgIzjKDVrIFhmIKthjR8C7BzKQTpgbNBF63acn7+FNmFvtf9mCAasUEBxGx6pd45YrSHsF4uIsj5drFMU0sJ4ews9dDV8zSrprtQdRYiyUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52696a9-758c-4b76-5a02-08de4a0e1549
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 14:49:08.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+hxO9MVYKrNG9IJfsVqthYkKr9+KpF7yaHljqo8Re2dlkNvsYljqS/C+gRf0+girEIvQ3Eh+4O/HZdsjsSXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BC420A1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020132
X-Authority-Analysis: v=2.4 cv=a4E9NESF c=1 sm=1 tr=0 ts=6957dae9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=20KFwNOVAAAA:8 a=_ytvnwka_SAgF55oPd8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8MQhKBovsKWFIBOR0lqAlp3A0_NZ_tNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEzMiBTYWx0ZWRfX+9M++osczx1y
 BBmx/0nJxBgWolj7ByA9hdKWJzPEopDswGCvHCTLRdXxZLC8BNRK7/JEwuS7QzYqrmHCXC6coFO
 0+3SLbMl0da7SJgYlfx5PJYvAQ2tHf8qsqRF7ydiq3l/a372RhErDwUmLvUQtg0tHu7MqMgLfQt
 CVykDZ/a8Qziee2q7myA6/F5z9SyZ8dPjDviGprUoMDbIP3BTlltkEEfxraNPXjT7hTFU9Y+Uwi
 08IBo2FXOe7puYBemRHL8pUPRPb8wZQkf4Wb7LTbOw3rV90zUU4WvF0+YbsNGKFzhutKRBtxs2i
 3Y1JiLgziUz1DcgPCOBmtxNRrOuTaq1w930s6G5QacPA5fgMuBuOP28Q+fZuyVnbuXzoBFR8oOV
 c+Q6c+KwGqdv1ULmGgjiCNQFydzyhm7L5+7OqZe98XonMHil4HizTmqlj7ubOGYR3FV0Wm47LzR
 94tc6285spmOkunz8Ug==
X-Proofpoint-ORIG-GUID: 8MQhKBovsKWFIBOR0lqAlp3A0_NZ_tNd

On 1/2/26 7:34 AM, Salvatore Bonaccorso wrote:
> Hi Chuck, Scott,
> 
> On Wed, Nov 19, 2025 at 10:48:47AM -0500, Chuck Lever wrote:
>> On 11/19/25 8:32 AM, Scott Mayhew wrote:
>>> If the incoming GSS verifier is larger than what we previously recorded
>>> on the gss_auth, that would indicate the GSS cred/context used for that
>>> RPC is using a different enctype than the one used by the machine
>>> cred/context, and we should recalculate the slack variables accordingly.
>>>
>>> Link: https://bugs.debian.org/1120598
>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>> ---
>>>  net/sunrpc/auth_gss/auth_gss.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
>>> index 5c095cb8cb20..6da9ca08370d 100644
>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>> @@ -1721,6 +1721,14 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
>>>  	if (maj_stat)
>>>  		goto bad_mic;
>>>  
>>> +	/*
>>> +	 * Normally we only recalculate the slack variables once after
>>> +	 * creating a new gss_auth, but we should also do it if the incoming
>>> +	 * verifier has a larger size than what was previously recorded.
>>
>> No quibble with the code change, but IMO the comment should work a
>> little harder to explain why the increase is needed. Something like:
>>
>> 	* When the incoming verifier is larger than expected, the
>> 	* GSS context is using a different enctype than the one used
>> 	* initially by the machine credential. Force a slack size update
>> 	* to maintain good payload alignment.
>>
>> I'm summarizing based on your commit message above...
>>
>>
>>> +	 */
>>> +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
>>> +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
>>> +
>>>  	/* We leave it to unwrap to calculate au_rslack. For now we just
>>>  	 * calculate the length of the verifier: */
>>>  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
> 
> I was looking in Debian for the state of this and noticed this was
> later on never applied/submitted to mainline, is this correct? Did it
> felt through the cracks or is it considered not to be a problem to
> further tackle?

Hello Salvatore -

After further consideration, we concluded the above change is not an
adequate repair for this issue. The winter holidays have prevented
further progress, but I expect Scott will continue looking into a better
fix starting next week.


-- 
Chuck Lever

