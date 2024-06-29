Return-Path: <linux-nfs+bounces-4408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E591CE3A
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B91C2097A
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51AA1E4AF;
	Sat, 29 Jun 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/n/m9PJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PGmqdAK4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94D1E536
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719680536; cv=fail; b=dgk4KA0cL+6S9uWmgxr78KX2lkdjFWXOWLQe0h/rmZfZd2wZiNrTpmqevXhZXUyMc0hBgkq31FU3fXlRBS3ErypiCgqFU+9ZRIrsue6k043TaXVP137LULS268z53kkknLl2012AUDWD0Iz1nmNzf7YVOVafRWJ6F2MjOaWQJmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719680536; c=relaxed/simple;
	bh=QTk1pzG/G36ZuVfMtcTOzDUWqSN/Qy+zJDimejBDyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqS8WeqTKOa53RKfGqZZ7cE3Gfmf6kTzVPvEjVsu8UjZJWY+yxNm+l3iD7UVFea69fhS9YXoQv/H7gcKS+BHf9r7kEToM2/GNP9gRtsLrtBxWgZRCOrdwzT96YpYRsPh83rKgxu5gjIjJCQnxWOyCqBNm+94i+qBtemcXZ6iZLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/n/m9PJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PGmqdAK4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TGkvJN013894;
	Sat, 29 Jun 2024 17:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=7SwNbc3PsOrt1e6K9ZTgR7NROc9ZKKnxriskFNHRahA=; b=
	T/n/m9PJzLI16n+tbW58TVfluOMcTNcJA3agUWJgXP0xC5+5q9qzwjZ2CS9MVkj3
	akDCqhnq0OW/933z7QNWtkKRNprWDEnWeA1mx4NKccPKQhIdRn5gONzqEjMourem
	MrvWlF1RS0aYh308tRikyzK8L4zqw+4ERrxjYmECtHLcg5WA7oGYEld6OikMBWmg
	qTMR73zy3EurhXXW/TJLRJK3BsAcwyQplu4o492SsMcIngsQtuH0W39aNT21oDEN
	4Yh+rxK9SL+LyyP6g0UHI0+kiR/4yeJtxMe4Dq3qHMBuITIDgLPeRQyqVt+Ph85+
	Y6/7cr9eJiQkbV2Td+yHOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsggd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 17:02:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45TGtDGk026206;
	Sat, 29 Jun 2024 17:02:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb4t0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 17:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AICKkEcrnbQDpset/OhaungbTLUIy8Gh2kropsLZWIyckVzoQKM6dLJXQCzOq5AARCaVZFMuL6L3MHlrnBzcuroopwJR4vwDccKFtpEq4K4y2U/ggsEBcgEBKIVJbZfrPIJKIckhcWVU3bxeKDb9JKdjG2Sf1rJxyUKMhDxzzfKwLDwLaBxNJOSsxfzH5cyQ8uYNSO8KS6poC0JkaGFCxzIgPhXIotV1Ew239NIlbe2//tnfUTNDzutOw2Q6D6ICtIyA3dXdIhv+UuWa7TineiYhvt+maYL1vOotfcsMblUBEqYE2E7wP8YbtZ1CI3isuBzaKqy1HBTVFaQTsKwljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SwNbc3PsOrt1e6K9ZTgR7NROc9ZKKnxriskFNHRahA=;
 b=jWBCvaR1OurjRXKFPxt0hTyOwrK+iMazVa/YSM3W0+55W7rrnZcgu3XKsMH1r6K0Iq2jlSSWWiwTAt1YJnwy0sszL33PLq1zH8SwzLdVFeplx4o1aDUhFv5U3HTxkRbluQjP8hiMxS3rJVfX/aP/Bt3kE6zRYc34bx5RaU+2e8p9evbsZiiTZKmgvqiRhk6HXV1tvlFs3L48oawnXZBOg6Ywgo/FR7Ro9yA5bvzfLdjkmYzK6ezT2dRHhBSXfr4YQL+K4vpUIfpYuarDv5cQgWhT9wWNaC8oQA9w3606M/kO6UiAaOmWBJ9+FAsQMC1hZ6nx4x/503RN15G0hudbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SwNbc3PsOrt1e6K9ZTgR7NROc9ZKKnxriskFNHRahA=;
 b=PGmqdAK4E13dFR7x8/M5ZjGr8NvpuvibMIE8nWjFBBj/ZRwKqG0Y+2+ET7V/u9PjSNk+fttLqQzv3MivBpZ7mC6M8HpfoxXs5IPpaUJRlvH25snPBOC//ze2/Z9/smrSKwKRxNnszmumNEVC5mNCnmn57bS/kT0IoFhr+e1DNWo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7557.namprd10.prod.outlook.com (2603:10b6:a03:538::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sat, 29 Jun
 2024 17:02:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 17:02:01 +0000
Date: Sat, 29 Jun 2024 13:01:57 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v9 00/19] nfs/nfsd: add support for localio
Message-ID: <ZoA+Bas+GV8lmRU7@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <577D0632-FABE-4D16-93B9-4701C051B418@oracle.com>
 <ZoAwZnuaPLSSIfon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoAwZnuaPLSSIfon@kernel.org>
X-ClientProxiedBy: CH0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:610:11a::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cc9366-4d89-44b7-3ef1-08dc985d3182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0hONU9XZzZWdWFzQ0FOdmU3YU9icFZEYlRFQStEc0NJemJkdG5NVVBEY3hL?=
 =?utf-8?B?YTVxeS8rM2hyT0dPZEhXUFRNa21UUWFNaHB2SlhSL2g2RForZ1lqbGpSVith?=
 =?utf-8?B?L0JGdmRnNEpSWUlzeHlQUXIrNzZoWFY3VkNYTmRvVWN3MXQrV0dWQXNsRFJK?=
 =?utf-8?B?MWRJM3ZKMTB6ZnpLbkNsTVNPMHdaTHpkMlkvYURhVFg0OVZSem93QmhOSWhz?=
 =?utf-8?B?cFY4TE5xK0RnaTVhdDc0RlhZbHNSSmcvcm16cy9icmtNcVBuczk3R3phc2ZI?=
 =?utf-8?B?Tllrbkp5MmEyUHN5WFN6TGViVEtmelFCU3lDRWhOblNJY3RBSnYwbjkrY2dZ?=
 =?utf-8?B?YWhvbmgzbU5XTzRHdU1TeUJ2bWt2aEtaeEk4dytNRmJmNUNMd0xnaVZvOTZV?=
 =?utf-8?B?TW1vdllzemVFdHZxSDF2TG1wSUdXNzhNaDBhUFdRanJIVUVUYVNtL2pxWVVC?=
 =?utf-8?B?RStFN1M4R05wYWlYTnZ0Wjd1OFArSlF0U21BT1JIZlVMVENnb0QzZnMzWEMy?=
 =?utf-8?B?ZW4zMkNhNklVeVcyTW03a1hsRG9ZNTh5QUdvNUJ3ZnFtbTY2QW1RSUduczBL?=
 =?utf-8?B?SklWaXhCbjNqV1pkSGUwNzd2anlMa0pLeFZJRDVLZWFkd0oyOXRLUkNJY3pB?=
 =?utf-8?B?Wnl1MkR3TjJjTWJXckhJeC9KTWRXOThWT3cyZGVxaWxsT2NTYXpmeVBtdWla?=
 =?utf-8?B?bUlFVGV0UjlYNEVqdVQ1bUQ4UHl1STUzY3VGdzhqTEpMcTNBVHN5M2RxWU40?=
 =?utf-8?B?djBWT2Zja00ySHJ4eWZtV1V1MCtrc0ZTUDBxRE03a0I4T2hwRGhseG10MEFZ?=
 =?utf-8?B?YmFXRmY4UXRXY1JpWCtaeGZvelJIODFwa1M3WTlpVFRlL2l4VTNKdm5pNHIw?=
 =?utf-8?B?dFMyWFdtaUxReTQva1dObWVtcG1KelhEdWZPU1RGdDZHNEVJbVpWUWgreEYw?=
 =?utf-8?B?NnlmMXFuVG9MWU51R1k1amtNL2Q1WkdLNEluUGZHcllnSXhBRHBvVVNQVE1Y?=
 =?utf-8?B?VDk0WGdJNk9PQ2tRTVRwekFtbE1seW80UmVXMkZ4Rk50WXpuaFhnOHBtZUh5?=
 =?utf-8?B?TGZ2V3hvS3ROeGhvNnVzSHFWdWVaQXNUT1VMUzJuTUk1ZlZieXVRYzZwaW5V?=
 =?utf-8?B?dHhuMnFFOFVCbEJZNjhidDZYUHI5d1lEMHhXODFWSHZpemhHZXdOSTE5WkdE?=
 =?utf-8?B?c3BPMTBjYWtFQ3RwSDBDeXdQQkNJaHpyZHMySmZXWUlNazVDK3RGVEQvSXho?=
 =?utf-8?B?TVlmNDBUNGljM1BDNTZGTEVuR2hLVVUrOHJVMFFaNjdQaUlSMzhiWTQ0T3hZ?=
 =?utf-8?B?aDFUSm1nRW4wWEwraHo5MEZpcDEwSEdHSFVNaVR4aVVocFlvTzlSc3hFRHdw?=
 =?utf-8?B?T2Nhb3RuVERxclE3SVFVUlZvVUpoVjNTYVE4dDlwdkpXdWd4Szl0cDlzejI0?=
 =?utf-8?B?YnFDRVBSdzBXY0Zna2Fxb2l5UTN2UkdzdWVNMXFYT3EzckRUaUtmd05Rc2xQ?=
 =?utf-8?B?eUtQT05EM0dJQW53bkVDV3kxRU5xV3pLdTg3SjZrbWNqR2N0dnE1M1F1RHhC?=
 =?utf-8?B?eWNkNUxhM1o4U1E5U0dCemNHOGlmU3NFbTYwK1o4WkpyZ0hXNUNMOXI0cVFn?=
 =?utf-8?B?cWlaUU8yNzBFMzhFL3Z0RWJ2ZjlYV2VoUlY2cnJpME5idUQ0ak05aUkwMGhi?=
 =?utf-8?B?YW54MlQyU1M1QkFiS2VsZGJ2dXFBTm9scnErZVB3UXJSOCsxWE9CdHA4cWp4?=
 =?utf-8?Q?ZgOStkwtQhmSTTEEfQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RW5jdDZnT3R0M3pDdUwwWi9GZ3MrYWRpenZzMlhKdktSQTlKcGlSV2txeGpx?=
 =?utf-8?B?UjdJRTB2UFY4bzYxRjFQQkJYSWxkbkE4YzRmbE1iK3huR3lvdSsyVHEvc2pK?=
 =?utf-8?B?UWh3VmlDblVmWTlzUUJFbXZXc2tmT3NFQzZRVnFSQVdFcHdTanFYNkhldUxI?=
 =?utf-8?B?V05ha2xLN3B0a1RyZDgwR1p2cDFsWGN4ZUZRZWRGVlpKTFQyVCszZGxqZjhS?=
 =?utf-8?B?b0pCT2phOFJyaUk2TGZ1ZlE2emdEMUhvazR1eVhhVjhEOWhLVlFiaGlKNnlL?=
 =?utf-8?B?ZU9iejdDUFpadWVrQzI4TjJPL3ZjK29lT3NEUlhjVHU1eDBDMTZwZWdwK3I3?=
 =?utf-8?B?T1BUSzFucjlXcGI1K3M3UWJRbU5ndWFSeCtoQTVNV3hRMlRoTytQbnFDWTF6?=
 =?utf-8?B?SmJ5WjhPeDE4QnVmbVVVMEFoQzJmc3I4YTVSUjNqbkNlbHhTU3FTQkJSVmdt?=
 =?utf-8?B?REU2UEZIcmxPN2RCaXYxRW9EdEdhN0M1R01HWnhGYmFpblBDNlE0d0MrT3F3?=
 =?utf-8?B?YVNnQTZyd2NIV2xFVXpDY2ViWHBXU3gvT1F2Nzgvb2g3OFNtNlZiSUUwYVZo?=
 =?utf-8?B?Z1lWNjN0TjR6RXZOMnJScWE3Vjg0SWdRTDFKTFNiamFpMEk1TkVNdFBKcVFT?=
 =?utf-8?B?Snh0MDNrVTZQZ3J5MFZZSGdzWThTUFFUTzNFRmZzdlIvZnlDdG0vNEJGV01h?=
 =?utf-8?B?bStqUytXUW5ndERUR2p3UjNOYThINzh5Z0hMekdQOWRtbnlhcTAwN0dzeDNx?=
 =?utf-8?B?VzV2RXYvNkpEN3E2dXU3Rjh5QVVBMW5EWUF6T2JENXprdlE4MFZ0QTUzbDZ0?=
 =?utf-8?B?SzlJRWhFU09vQTF4Z2dIT2ZSbGI4R2IydFJ6WVkxeW50ZENkTmg2b2dmTC9i?=
 =?utf-8?B?VGIzdzN6TmdLQ1RBckN0a3VWZkpINmNTRktSemNwRmlkV0dBMDViem8rOFpo?=
 =?utf-8?B?YkNpSVlqYks0cGRYL0hEZXdGeGlkZU9VdlZLcGppdVRaR2pxT1V3K3JCN0pJ?=
 =?utf-8?B?a0l3SkpSblVWWE8wRnh1L0FIblRaUXpNNnBHdTBjTHJVMnFFc0pZTWl0elhI?=
 =?utf-8?B?MFJ2RXJjeGcybjhsUmRLNkxadWgrNElvL1ZTdTZPbmRVNE81TG1QNGVORW8v?=
 =?utf-8?B?cnphOWNMMTFpK3I0eW8za0loTWhIOGJzbG0zaVRscld2MHNWUDRCRlcydzRa?=
 =?utf-8?B?NXkvVTdiY2NXN0cvTTNuR3d2eDlVSmdsaXRJY2p5MzVLZmFiSWdzSFhMN0ND?=
 =?utf-8?B?MyszSXBoR0JoN0FxeGNkR1gyTGNOcGMxWDlDS2JReHMrQ0JJVEdQbjF1MWV3?=
 =?utf-8?B?dWExM3p1SlBoOUsvRzJDU3YvR2NwZzNDdzdmcXJYRUo2dXVSbDRwWmpUTjk4?=
 =?utf-8?B?RXY4bEhMVm5ON3NoQjFwejB5VjJ1YWdqMENrY01pZWlhSFNwQ0htMW0yb0M4?=
 =?utf-8?B?M1ZkWnBpU0wzNVdDMFd6OVN3bjFaa2VobE9yb3IxUnlRQjVlT21WaEdVOEUy?=
 =?utf-8?B?anQzZkovZGhmU2IyUHh2OXY5VVU0Z3liQndsV2NkZkltcHM0UHhkRkV3Q013?=
 =?utf-8?B?Mms0VDhrRitScmtkbWN6ZkY5YWs1U0hIelIvM1NlUVMvSy84MnFIZit6dDZI?=
 =?utf-8?B?N1FzSmU3VlFVRW1JNFJXYjZsazh4c2RGT3lENFBLRlpvaXd3N0VuMjgzdklw?=
 =?utf-8?B?TERUOXlkanpoUUJYQjJOVEpHOUJ0OFdGemdxYm1jL3A1N0NVblZaR2E5TjU1?=
 =?utf-8?B?V2xVNk5EYXdkaVEydEs3WTNwb1BKYTExUmIwSjVyUHNnaWd0ODhvQXJ4MlYz?=
 =?utf-8?B?YUVuR2dNYkZkVGUySmtOMGpBeGdUbkU1N3R0Slh3bEJpZmJNcU9jeEdNbzBi?=
 =?utf-8?B?dkd2YmR6bFkzUUhKeHYyVWs4QnVtZUxMWVFsbXFGQVFrcStyWGVFUWtpUkZF?=
 =?utf-8?B?N2I0dzNSWXVLaDYzQmladk9JOFgrQ0FqdWpkd2I3ZUhiRDA4TnhMMW5hQk1E?=
 =?utf-8?B?NVVnaW1vem9Jb2MrSFN0QnJPYXhOSy8yTXhGTmU0VTNIZU55Q2gwdjR0R1ZT?=
 =?utf-8?B?VkREb0U4UGdWTGJGbjhPemplU0VoRllMcnMzb2p0Q2c3VUtjMDR4eVdBQUd1?=
 =?utf-8?Q?aU986s1qIJybY9fHgxRFXscKd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cwpxz5stmWG9M9qdmeaWT6MMeBEZea3XeArPn02XGdfiSPqlQvBXoCZ25vnPw8CbOQc4uj4pKcepLuUMIQC4S2mbtvb1AMkLNwvjDwWWi4xOF0ZEN2CsQgsKLNisUe9v/NfwQS5fC17pyy62eHbSWHexB51I9VirUOs0SHjNjJ3k29IRdq8Hak5z8c3/RE/aRMDwuls+C0ewNLE/Do8/p8wmo6g0LvbrnjV9teYd7lMlHNcJNBI5T9Leyp0dGwoVjT6uhdH7ksYJIECDxHqlcRbWMgprj8rk04+sdmFvyBdh9ETMwUVLEc+3kRNm6dtctRGLo91cEKM4dC9YjjFDdec+UPFMMsb53r1QW6dN/ShCW0Fs7kmlICvnNepckKH9cGRPCAd0xm1CUcYUDZaotEcLgZpzEPT9jykC27Pc4gsG856Lyf0P3bkPBgBzg4CTqPR4EsL4HUj4eSiIO/aXGi/3Cgqo4sTc5R3t/9NrKXG2SpRzq87fmNcLXcxVCJE2JB7N48NC9G33ajQV7Wo9usCkqzRKEmfIBWwpZs9RAlwM6Ik9jIPvWRpRmd6s6D6rxW9HBzLGou0ywlIwGh7t3thXmc/n2bQbmc2hl2a3TgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cc9366-4d89-44b7-3ef1-08dc985d3182
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 17:02:01.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5poBKfqmJArVaTggAvwTNpDkX34cHvmg+mV9aRpAfF/L4L0GTACyJMoJRsHL/x0bWUM3ezT/G2BtnUjYyjXbMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406290121
X-Proofpoint-GUID: VyRCz3EwMQoTaTpMGlD4krJJ81OP5t09
X-Proofpoint-ORIG-GUID: VyRCz3EwMQoTaTpMGlD4krJJ81OP5t09

On Sat, Jun 29, 2024 at 12:03:50PM -0400, Mike Snitzer wrote:
> On Sat, Jun 29, 2024 at 03:36:10PM +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Jun 28, 2024, at 5:10 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > > 
> > > Hi,
> > > 
> > > I'd prefer to see these changes land upstream for 6.11 if possible.
> > > They are adequately Kconfig'd to certainly pose no risk if disabled.
> > > And even if localio enabled it has proven to work well with increased
> > > testing.
> > 
> > Can v10 split this series into an NFS client part and an NFS
> > server part? I will need to get the NFSD changes into nfsd-next
> > in the next week or so to land in v6.11.
> 
> I forgot to mention this as a v9 improvement: I did split the series,
> but left it as one patchset.
> 
> Patches 1-12 are NFS client, Patches 13-19 are NFSD.

I didn't notice that because my MUA displayed the patches completely
out of order. Apologies!


> Here is the diffstat for NFS (patches 1 - 12):
> 
>  fs/Kconfig                                |    3
>  fs/nfs/Kconfig                            |   14
>  fs/nfs/Makefile                           |    1
>  fs/nfs/blocklayout/blocklayout.c          |    6
>  fs/nfs/client.c                           |   15
>  fs/nfs/filelayout/filelayout.c            |   16
>  fs/nfs/flexfilelayout/flexfilelayout.c    |  131 ++++
>  fs/nfs/flexfilelayout/flexfilelayout.h    |    2
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |    6
>  fs/nfs/inode.c                            |    4
>  fs/nfs/internal.h                         |   60 ++
>  fs/nfs/localio.c                          |  827 ++++++++++++++++++++++++++++++
>  fs/nfs/nfs4xdr.c                          |   13
>  fs/nfs/nfstrace.h                         |   61 ++
>  fs/nfs/pagelist.c                         |   32 -
>  fs/nfs/pnfs.c                             |   24
>  fs/nfs/pnfs.h                             |    6
>  fs/nfs/pnfs_nfs.c                         |    2
>  fs/nfs/write.c                            |   13
>  fs/nfs_common/Makefile                    |    3
>  fs/nfs_common/nfslocalio.c                |   74 ++
>  fs/nfsd/netns.h                           |    4
>  fs/nfsd/nfssvc.c                          |   12
>  include/linux/nfs.h                       |    9
>  include/linux/nfs_fs.h                    |    2
>  include/linux/nfs_fs_sb.h                 |   10
>  include/linux/nfs_xdr.h                   |   20
>  include/linux/nfslocalio.h                |   39 +
>  include/linux/sunrpc/auth.h               |    4
>  net/sunrpc/auth.c                         |   15
>  net/sunrpc/clnt.c                         |    1
>  31 files changed, 1354 insertions(+), 75 deletions(-)
> 
> Unfortunately there are the fs/nfsd/netns.h and fs/nfsd/nfssvc.c
> changes that anchor everything (patch 5).

I /did/ notice that.


> I suppose we could invert the order, such that NFSD comes before NFS
> changes.  But then the NFS tree will need to be rebased on NFSD tree.

Alternately, I can take the NFSD-related patches in 6.11, and the
client changes can go in 6.12. My impression (could be wrong) was
that the NFSD patches were nearly ready but the client side was
still churning a little.

Or we might decide that it's not worth the trouble. Anna offered to
take the whole series, or I can. If Anna takes it, I'll send
Acked-by for the NFSD patches.


> Diffstat for NFSD (patches 13 - 19):
> 
>  Documentation/filesystems/nfs/localio.rst |  135 ++++++++++++
>  fs/nfsd/Kconfig                           |   14 +
>  fs/nfsd/Makefile                          |    1 
>  fs/nfsd/filecache.c                       |    2 
>  fs/nfsd/localio.c                         |  319 ++++++++++++++++++++++++++++++
>  fs/nfsd/netns.h                           |    8 
>  fs/nfsd/nfsctl.c                          |    2 
>  fs/nfsd/nfsd.h                            |    2 
>  fs/nfsd/nfssvc.c                          |  104 +++++++--
>  fs/nfsd/trace.h                           |    3 
>  fs/nfsd/vfs.h                             |    9 
>  include/linux/nfslocalio.h                |    2 
>  include/linux/sunrpc/svc.h                |    7 
>  net/sunrpc/svc.c                          |   68 +++---
>  net/sunrpc/svc_xprt.c                     |    2 
>  net/sunrpc/svcauth_unix.c                 |    3 
>  16 files changed, 621 insertions(+), 60 deletions(-)
> 
> Happy to work it however you think is best.
> 
> > > Worked with Kent Overstreet to enable testing integration with ktest
> > > running xfstests, the dashboard is here:
> > > https://evilpiepirate.org/~testdashboard/ci?branch=snitm-nfs
> > > (it is running way more xfstests tests than is usual for nfs, would be
> > > good to reconcile that with the listing provided here:
> > > https://wiki.linux-nfs.org/wiki/index.php/Xfstests )
> > 
> > Actually, we're using kdevops for NFSD CI testing. Any possibility
> > that we can get some help setting that up? (It runs xfstests and
> > several other workflows).
> 
> Sure, I can get with you off-list if that's best?  I just need some
> pointers/access to help get it going.

Yes, off-list wfm.

Come to think of it, it might just work to point my test systems to
your git branch and let it rip, if there are no new tests. I will
try that.


-- 
Chuck Lever

