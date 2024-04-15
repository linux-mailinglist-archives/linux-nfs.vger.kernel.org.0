Return-Path: <linux-nfs+bounces-2828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C98A5CA3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089072848FA
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C115697D;
	Mon, 15 Apr 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GRNeGsNi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wUvIHdFW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1A156981
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215254; cv=fail; b=cvQvZnN6G/IqJzi+aEWeIL6qesW8UPOwuf2zUkCLjCmOBBME5xrZgTRi85z4JxWVj4jzGh531NyBpV9k/OH7Zf+dXWTLlOZgpFDNtw9dhFW5F2JbsGwyPMcYnc9bv1yQxy5A+PbSMX0JGB4qNCkOOa5Z+nzLg3wDv/HHjS8+NjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215254; c=relaxed/simple;
	bh=fBRX3+D9oa8lrmE6vmc9pGxFArd+qOf8JqPDLTYV2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DQA3o0rlC04mAkQYk7BztUVik2VwNzlx5Fh+UziroqKSKLxmrv8cCoWj5pW62iEzQU+8k2kkR7/Ukm9tIV919zdo5Bkua/Gx+XJnj+5ncn+LHyIH7bAtffK9OTx99vqZbuSRBkh9A3/ySLqIfqWTLzKIt4vQ/c90Gby6kV4isoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GRNeGsNi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wUvIHdFW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FKmqBC019069;
	Mon, 15 Apr 2024 21:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=RWKjeDS/S30bpJUxKdDQbir5FA4CZJE3hSOclIENrU4=;
 b=GRNeGsNicvaksdQRXd/OU/NkfeCAOHSOPMXkURQzHwpQ/iAoPhOpb+KW5SH2gcMSdAIx
 W72SruvnczulKjzAtteER7/BTUGkt8uP58l5dGk1wTl6NFterKcfZbPzs4qDO/2QxZgg
 8axTJIanby8Me6Ak+UfAs432/IoAzgh91BSs3CjvvdFJWlYwoe1GBqJq8RdN4hSxrBm0
 cOFdF9EKTyTmK7xaHO8Gn62ehOLitnFBBt+ey2NL315jh5HWr4MJkphtuZeZPoyg5Isc
 4RUm9DMBqiLpH+P1ZlOzEKDqZFopPiAO+7lf8fBeI50boKhoD4mgaruZYthYVDQ/ke5/ 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujkvjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 21:07:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FKWqXn021762;
	Mon, 15 Apr 2024 21:07:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggcm6b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 21:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Van726O2MZC13kraNHAFT5h0brvYHlP62o3vR56qidVHlAtJnG631j0W7HdOIodDQVa9IBYAfHkNl/HZpEPvbbUDk6DscU3UXiLE1Q6S+egh1SsUFyozErL1xCSn2E/NCEzZQc2dLfsZ4vC5OVjqg3HHHFuxgiVp6cO9gNCUnhzAPBCX4N7YdBmYAbS8mKRAXrEAl6y+qBICC2hxjLETQk522mU+MnXeIoNLW5YfYqfImLrxI3eVPIy044OUSMvE8q4VVXg1K8JH8eKnGoCChcl3urpgHWLz7MSZBqbGTciu2VQdQb0ob99aqBbD0F34MDuEFKFCRW5XTiqawiqU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWKjeDS/S30bpJUxKdDQbir5FA4CZJE3hSOclIENrU4=;
 b=aZ0dTkVpRIAamctZDmihuZNRY0GoATiNldNZQEKFSMcaE4tgvusBrJMMkNdp6jzxlDgu19SJPdfp4YLE0VfaZGTHTwuk14H5iBct1AjahVxMMEYoqcZyE/G94VhEFM+tnf2KpyESY9PVOSi66jxn2puZj+bmUpniHKjl7B77dZwTkiTwCva2xA6Ode2oY9akpIvrfOKG2smRo8D8kvNgjA+PRr4QNZCtLR4IgwZ2unLEwVbBV/ZBy29PhuHfkBmSR91hCPo/hGQq9reT2EAudIi+LFm5OluDB5NroC6vBmohBhdBI1swRb+L1gZpAj7b7pAWflcoeFMd8WHJgQEvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWKjeDS/S30bpJUxKdDQbir5FA4CZJE3hSOclIENrU4=;
 b=wUvIHdFWYEsB35Tsnh5vs9pkMg3+4FWcZrbjhv+pmUufqqjmLGcsWEKb0Jnq6TeZZRjQwsYQFbeo6a6MQl+vPFLXFC1YuCS/UkvpnuCVCYreoCh/qKcl7KDz9FEREUwPuyeksXCRB6YbuF3GywdpNwlwThe2r8lI9ssZ0uZFj1A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 21:07:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 21:07:19 +0000
Date: Mon, 15 Apr 2024 17:07:17 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Neil Brown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
Message-ID: <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
References: <20240415172133.553441-1-pvorel@suse.cz>
 <7A48C70E-BAAB-4A1C-A41B-ABC30287D8B7@oracle.com>
 <d895ad115632912df228913d4a86e7f597b22599.camel@kernel.org>
 <6820832A-9F38-4DE7-8EE4-7AAC8CF06FD4@oracle.com>
 <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:610:74::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: b5954170-07b0-4428-85b3-08dc5d90099d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWpwMC85MEtKQmRhWURmciswY0hNMkVqTmhaS3VncGhBWlpkdDFGUXhXKzRV?=
 =?utf-8?B?TCtoV3BkR3ppUjUxdzJpNlQxNGtGNzMrUnRSckd2bk9OeHErcmtkTnJiazBt?=
 =?utf-8?B?bHBoQ1dkOXc5eGRWNzFTYnZJN2hLMG1qVFZING94TU84SzhDWUV5Tk4xMnIx?=
 =?utf-8?B?VnRRZS9aR015Q2ZRRlRtTlhYRkZ1TjZLbUtuM1ExeW9IWlBDcHI1Q1NPZmJu?=
 =?utf-8?B?WTd4b29JbGg2dm5QSU5nSXlNbnloc0V6cmZVcCtsSjFSMUtLMTZBWW13MVFJ?=
 =?utf-8?B?TlIwR2Z0WDNPR0JSb0NsdUJPMFdEUFV6a3p4Y2dMc3ArOG5Ob3VTK1JkWktW?=
 =?utf-8?B?ajRPRnAwN3c0bDF5NnBlWnA3QzkrZjFEZkhpWlhiUU9MNWZuM2FBSThNVmZM?=
 =?utf-8?B?WHhkYlJwTy9YdWkvcnVwTlk5SUR3Y0ppOEdORnRKV3JndHJndWlUMmJPZTJO?=
 =?utf-8?B?cnhOS0tLWUhBcHVQYW02UlNiV3k0eE9LYy9LVTRZaGYvNUllTndMQTR1R1pB?=
 =?utf-8?B?enRBYWZCdldxS0JxRnhhZVBMWkdUTDl1NWZVRkcwbVRHdWVoUk10UHpsRnJ5?=
 =?utf-8?B?dCt4TzEzVHZpQ3UwZVdrQ3ZkOXBqVFp5aDFNWXVmS252c2dRV2RvREl5TWhL?=
 =?utf-8?B?elowRnlpZ3A3ZE92NmFBWEEzRnFYRFNJbnFPRG1nYzl4MEhVMzBKeDQ4a1M4?=
 =?utf-8?B?TnpKWm55dllOTUdwVFcxdGRDdWhnT0pHKzhMMkMzbWVvMVUwaEU2ejAxaDFu?=
 =?utf-8?B?VlhvUk40U2N3NXp3aC9TSkFIREpEeWE5UDV1c1BoeXF1eDhOY2VBSzNHNDdD?=
 =?utf-8?B?aWU4K3QwWW1qbmRRWnV5U1JxdFhSRnFZZVI1c3Byd2QrUW9nSExVdnNEMTBk?=
 =?utf-8?B?TUV6d216Wm96MHdDMmtWUlVDSzVYZGRoeHVYTzF3UzdNc0lDTjEzRjFkeldw?=
 =?utf-8?B?OXNkNjVVZDkyZ0tKVThrdnpxWmNidFpzb1hmWmYrR3ZsWktpMWtGaGlBYm1i?=
 =?utf-8?B?Nm15ZWJBSDZvNmczbUxvUTBSS3Y3OHlrWllaVGhlNjZPNmFzQlhmL29nRzU0?=
 =?utf-8?B?NHVqL3BNWG9Da3BGQ0hya21RQ1FycHY2czJCaWd1N0xSaHh2cEl4TWVRd1p1?=
 =?utf-8?B?WFU3ZmhGZzlYVjd0TlkvYlRFcWg1czJ5QTh2RGNWMFlZNWh3cHQ3NkMyVTJR?=
 =?utf-8?B?eUR4bjhVL08ySFJJOVJ4TndEdXBWSHFUMW1DMDMrMnV3ZGxGUUMrelM1Z1d5?=
 =?utf-8?B?OTNNbm1tcWFTQXZFNndJRmc4aGhmSkhpUmZzU1lNUkNOd0djSE5nWXFwdEVq?=
 =?utf-8?B?bWh4MVpSMWRMRHBQcnRCUzRJVTlYT042Ym8rUjBZdVJBSjduSkxWMzRhTTlT?=
 =?utf-8?B?K2ZWek9kcG43elpweFhnb0FYc1BqMFBZSmhlOEtXQWs3TEtnMmlTNnIvVVYy?=
 =?utf-8?B?a1JxaWloNTNPMEtxdGJyWWVMZ0RsWmV1bFBWa3ZIMGx4SzhDVG5FOEhkNUVm?=
 =?utf-8?B?QjlMa0R4N1BxNm5Ob2JScnpzNnoyWmozOHVtVXRrUHBPaFp1eE45N3NNYWpB?=
 =?utf-8?B?NTRvc0NVQUtJcFJ6eEw4TnltWmtPa0NnSEg3c2J1eFlqQnN0S1RyU0VaVDY5?=
 =?utf-8?B?Y05VdjFOdkNLbUhWUFdoSmRqNUJFQjV5NEYyZ3FuSVFKWkkyWDhZV0ZJQnRH?=
 =?utf-8?B?eXBqd2RCaThrTzJSQXFQZkhHd29GZE1laFdyZEgyUERSalpUZFNONFdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVc1TS9iK3JmT2Z5ajFrcVE5Mmo3RzBXR1A4WnRuQ2p2N0VNSmM0dFZEQ2Vi?=
 =?utf-8?B?Mzl3cGpqb0hSejloc1RFTklSak1XZXJzTGZ4bUk1d0RvL3dWcUpYZjEra1do?=
 =?utf-8?B?cEdDQVViRFB5NWJESHFXbGM5ZmozbUU0QWZUUUdFNjZaVmY1UUxyQnFMLzRR?=
 =?utf-8?B?MmlYQlJFa3hvNGZSZGNLMENOV0dpR0xpQ0s0a2FZbE52QnNIL3M3OERobWo0?=
 =?utf-8?B?Q3VSVGVxcE95aW1qYTlUVlk2M3lWQ08yOFA1NXM3bndzbisxMXBDSDFOMHJW?=
 =?utf-8?B?VTVhbXljNHAwRENGM0tJZEFTcU12d1pHcDRrNGI1QzI0TlpUaXZYWVkzSjlW?=
 =?utf-8?B?dC9vNUNNOGFtVUN3V1BVTHNIeXJ2OFAyakJETGZETmhvMjNER0duaTZoQVVy?=
 =?utf-8?B?cnpBRk1XN3NrTy9QMEhaeWk1cGFrbTRjc2E2RnZSYmlnVGVsUnVzN3lkTXNy?=
 =?utf-8?B?dDJNclhGaFJ4S0dIY0lIV3BjTS9LdU5zQ1JqZVo0UEw0K21WdUo2VDFXdlhX?=
 =?utf-8?B?aXAzSmlKQStUUE5aRkVKNncybXp5MG9tZ3V4K0l5WEdvZjBaWWVyVHl4dHBh?=
 =?utf-8?B?aW44T2JQaElvVHlEcS93ODBlSHhPK0JkdVNQRVdzaU8xb3pobVhRNDQwNmkv?=
 =?utf-8?B?Qy96MDZ4a3FwYXk2aVh3ZktVN1BvV1diVHBHMkptMTJRWm11YTcvNnRhQk92?=
 =?utf-8?B?YkxXU0Vta0UwaEt1UERlT245VWF1c0Fvbjk5SzhZaWVNcDFsZk4xTUo5ckF2?=
 =?utf-8?B?NXBmR0MzdjFrTFkxSjFXUDVMZm85ZkFRdW9oV2FhK2RMdHloRmFUckRiYW9h?=
 =?utf-8?B?amx2STF5YjZFSGxIY2IrTTlaSG1NNXJkLzdvNDVwS1R5ei9BN2FsbDRxands?=
 =?utf-8?B?d000WDROb3JIck9FTk1wZ1ZCR21NRzRBdGpYT1FReDFQZ3BJRW9JY2dFRFZi?=
 =?utf-8?B?VTFIT2g5RjFqRC8zbnpTY2I2QUo5ODArcjduYnFNOW1FcldzZTg5M2hYVG9y?=
 =?utf-8?B?SFdkSEFoRzYxMndJcUhpRkF3aWZtc3daQm8wTFlFdzgxL0VXaVkyWWpmS2pX?=
 =?utf-8?B?Y3I3RkEvVHpqZ3NYUFJJTmwrM0E2bDBGQnoySGpucU83VFpObE1TZ25FQXVp?=
 =?utf-8?B?dm5Fb3VvYXVtL1poWUJsWlF2V3R1S09EcW9Mb0VHVnUwM1hYRk8vcWdJaHhR?=
 =?utf-8?B?QWdrYTJKRjh2UFRjMFdtM1RzRlZ3YjBEYjBPci9TWWtQM1g1aWlwb0FPVmQr?=
 =?utf-8?B?MmdqWGZjeVllZm81aEJyelpLM3h0WCtjc2RMLzArYmRFL090ZkNnUTdBNnRu?=
 =?utf-8?B?NW1HRlhtNWNBbkxmYzF4UEIzM3R3TlBjcEhlTGIzMTlORnRydGMrUS9xWnFr?=
 =?utf-8?B?eitZekpjQkJCTnA0aDJ3SDVJMjBwWmtKejNGNldPZXhQZXNkQ3lwd2UwazJr?=
 =?utf-8?B?NFI1SGlOT3NkanNLZlBmQTlXZnA5ZFBmTWVYdFFVR0xFdzJHL2U5TlRDSVpj?=
 =?utf-8?B?RFB3VUdjN1NENHRWR3BISmhaaENIRkJ2VGp2emxLWWhvMVNDS01yaUNlSkpl?=
 =?utf-8?B?c0tudmFrNW9nZC9NQjcrR09Rc1JrbCttczZkUmtFYjJ0K0JzQ1lGMVZweXpK?=
 =?utf-8?B?ZEVWS1VpckpUU3VJc3lheXV1UDJXSW95VkZLTWZ2ZWdPTGVoWkJrTXlpcDZh?=
 =?utf-8?B?SjBJamcvY0VDMUtjRVpUSk9rSHRhQVVKUytJOXdQVzROaFhhc1lpUVBFQmZX?=
 =?utf-8?B?ZkxHMjJFREFyeFJTcXZKbXNNUnFNeFhmejN2TVY3MVlVU3pWYkhrcHluVTc3?=
 =?utf-8?B?TnBRa2ZlVm5Qbk1QWm4vWFRKMzhUbWQyMklaMDlYRmZQNkJRaEpYZ3VsaVMx?=
 =?utf-8?B?WFc2OC9SdFNTNkUwSWtlT25IWXVXQ3I5SkVmN3JCNm5wSHc3eUE3RmtGUlpY?=
 =?utf-8?B?RGVIM3VMUG8xUVBHbzIyT3U0aUx4djZHbXk5RzFCamhIWDJJTmx2K0tYTW9W?=
 =?utf-8?B?RXNYL0RNRGZ5SWU5WDkyQndRS3JtTGNXTTRzMGRZZi9GNyt6QjlrYUphbXRB?=
 =?utf-8?B?T3lFcElFM2ZYUjdESFdQQTgxZC9IZ1locHkyZ0Y3dXVpTFpNU3dhMHZDUlpF?=
 =?utf-8?B?VWxUZUpQN1prWjJzdzg0cnFYUkhiWVVya1pBMUZUU2xnZlB5b3NJTmQvQ3VZ?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XFTPo068ME79LlAOWUg6xft57k9y4xScY6O4Toj4OKkP1TAA0kJwkW+IcXj7+ISJ5A8/8oinUGiYctbBpYqrhGo3gknYn/gS4ZCYA9OcwWVpQLXKFTBhRciyDbnIMDw6faioLQz4HdUhQjvwDunVQxel/NybsUMw3pxY3uBrk2CYiv9lrQGp8ubhto5OiaA2ikdLAfyPiZQTBzWMHYnf+oOt0FlmdZGY7V4sUYA8PlEbpPuxZktKAbXiD0zIPIzHfvfQFzRPlY2V2IFoek5OzXCkKH017fOaOfxHf0iD8rleWNnrjIy867rHFiNS3kFnN0s+3e6GklQpyPjjedbWCkadENV9qzJNO9BMM7iKBaEsNC6JQoFl2rsm4x0/VBUDJOex1HH38MNmiQHdrSSe3ypad/NzdlLVqdyySBrt1Q+0P0WJCUyxyxrdomk0UCvzVqvDnn6wDzJ5V+orQ8qPxWBCKdxIF5cNJ4leGJ5pY5rpJ+gGDvfKH4LELoNlH0wRXd/j8hy6OHGV8sLp6y58HsdFCZt/HeLnN1odicsIjhRrBTbrFpu8RH2VdBbp5+hb7v3w7uq6QDIDQZeDq5t5jsste2EQJyS1XjzomPLWEnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5954170-07b0-4428-85b3-08dc5d90099d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:07:19.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZAsKGQQ8xw/+3/Xgf3tcq+Ce/yacQ6qvLCzT/EjQd9P005eRe1pd0kn/OayA6odr+pgeTXq2BNHWmf748jBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=654
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150140
X-Proofpoint-ORIG-GUID: eyMWa24Ig0zbLzlkgIwpzHOP7h0WA2vj
X-Proofpoint-GUID: eyMWa24Ig0zbLzlkgIwpzHOP7h0WA2vj

On Mon, Apr 15, 2024 at 01:43:37PM -0400, Jeff Layton wrote:
> On Mon, 2024-04-15 at 17:37 +0000, Chuck Lever III wrote:
> > 
> > > On Apr 15, 2024, at 1:35 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > On Mon, 2024-04-15 at 17:27 +0000, Chuck Lever III wrote:
> > > > 
> > > > > On Apr 15, 2024, at 1:21 PM, Petr Vorel <pvorel@suse.cz> wrote:
> > > > > 
> > > > > /proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EINVAL.
> > > > > 
> > > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > > ---
> > > > > Hi,
> > > > > 
> > > > > @ Jeff, Chuck, Neil, NFS devs: The patch itself whitelist reading
> > > > > /proc/fs/nfsd/nfsv4recoverydir in LTP test. I suspect reading failed
> > > > > with EINVAL in 6.8 was a deliberate change and expected behavior when
> > > > > CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set:
> > > > 
> > > > I'm not sure it was deliberate. This seems like a behavior
> > > > regression. Jeff?
> > > > 
> > > 
> > > I don't think I intended to make it return -EINVAL. I guess that's what
> > > happens when there is no entry for it in the write_op array.
> > > 
> > > With CONFIG_NFSD_LEGACY_CLIENT_TRACKING disabled, that file has no
> > > meaning or value at all anymore. Maybe we should just remove the dentry
> > > altogether when CONFIG_NFSD_LEGACY_CLIENT_TRACKING is disabled?
> > 
> > My understanding of the rules about modifying this part of
> > the kernel-user interface is that the file has to stay, even
> > though it's now a no-op.
> > 
> 
> Does it?  Where are these rules written? 
> 
> What should we have it do now when read and written? Maybe EOPNOTSUPP
> would be better, if we can make it just return an error?
> 
> We could also make it just discard written data, and present a blank
> string when read. What do the rules say we are required to do here?

The best I could find was Documentation/process/stable-api-nonsense.rst.

Tell you what, you and Petr work out what you'd like to do, let's
figure out the right set of folks to review changes in /proc, and
we'll go from there. If no-one has a problem removing the file, I'm
not going to stand in the way.


-- 
Chuck Lever

