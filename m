Return-Path: <linux-nfs+bounces-2004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE7859143
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31514283211
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC547D3F8;
	Sat, 17 Feb 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtjL8+7N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fSvjs17d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6379929
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708189564; cv=fail; b=kXvFTeN6DiKAGzborp2gmgnkPpX+5hQxznyjcTMyO9ECpnH4OJUUNyAiBNh0szNMDCme/cuBYC0KJjuSLCO3Om9mHPd8QHGlkkc/+wVU99IexPuIAEP76LojIC++wl7yW83YtLdml++R3LqdsWB4M0RxHBo1U0G1cZYdWNIKJDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708189564; c=relaxed/simple;
	bh=rIaTXOku4FOFTLoVEMWBOIQbOvvP/q0X20xP7igXpOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HYN9mACcrTZ5rL5eGI2scmyjx3ZLVRtxgHz3pFWKsCBqAR4yX4ZvtJmrCiZztbNhBM4Iku5MPMMTMNqN2x3YyQ9zRXPK/Y5T3+ay3XHrkhStmQ6otf/tS3fBEk5YKiWMFG2zuu/0LXX2jo9chNpHL79VSCX736dLIFveaESzop4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtjL8+7N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fSvjs17d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HCENus013800;
	Sat, 17 Feb 2024 17:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Z5hg/Mg9JpCFN/esFEZ5W1/xxKykFt/q4/+PFxlT7Ac=;
 b=jtjL8+7NVp7uIuEvqFSBX9iQksOERUTfxdIjoL4Hm1CP1izELdqYIZXtBay/mFA672v4
 A2N0frq8TN0j5e6yqDB0LNkDfjU4djdPFQD7BTORiUq3ekmH1dUJViSHZKcq3wV8y7ps
 PzrQM6fhEbecgfto0SUjzwYJsN57KgQm7iY8KvHHSQMitbz0lWzNmO0FVxemDmOjkL00
 5bYJxWP1Z8GPrA+xGZSLkg0rfEX000Hu30wBWecpyCXIHCXce7l/JiPNdtyB6N3EKrAR
 W2TLemiWnLbWPakv0CVz5J7Tifa+eLQ8rrUbdpt2nJ1A68L8xwApSPSonVh7bbezW4eR qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3s14s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 17:05:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HEPxma015908;
	Sat, 17 Feb 2024 17:05:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8441j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 17:05:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnJRgQn7rhzGXaqb2+X06tDVZvbs4MmZBBl3cUk18VIuefTBKyb1eL62YMyku4Nx5i59L9DlkUCFKmfHdUZiv65fYb8Jt7gQC+h7kg6I/kEEUbHhRMtAP9WzqC2cEJ086gr5+dUM22gtKwK6O6UxF5Ffn4KY9gzP1n334nFMHxsNfVkKKXV2C3FHJkPA16mJ+C4FbbUxco/hZ+YpBfDVEUPHUFF2Cmp/3D6misehM5Qp0y5bsH8V6Mb8jYSXjaIGXHiag293C90sIzRhcwOsB7YyTvu6P+YklPQMSJ7qJvGXSt+FKRU/JKMl7jEMX9g6WFFYxJBuXUV7M3aqKjnn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5hg/Mg9JpCFN/esFEZ5W1/xxKykFt/q4/+PFxlT7Ac=;
 b=hgxA4vW7fq2PhjznPNGxM3SRDM7EIb/m6BD8BBtzhqfjIwi86gc1W7nKwcw0fzFuWW33ovqWSxPAG5LT+Waz/8rLzrPn07ZbvubYpFi0MnyZ1LffpNIvdMqRibxqwGIakIPRgy1pUQfnNMQhdDVKr4xbohtZJqLMH62Durg1MqA1Jch11wPTBZ5R/19DKE7wmbYgzaFI+fSEv0678q+89wHZ3RjZs5EtvW2vPhDDmTtvxu0jH1T7Umksnrv/yw/o3NsV17A+kk+9bdagASJIUf/x/BMCpSBg8/Q/RBF3bYDvxxHcZcVH9k97nusX/BX4mFsN5ECdY8mpbFooONRoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5hg/Mg9JpCFN/esFEZ5W1/xxKykFt/q4/+PFxlT7Ac=;
 b=fSvjs17dDYKa9axfa2i+g8+UVgTcThIbFgzicNl5HVua1ZKk7jahdCNQ5ndIGqxRDnnG5SlbvxzqcLTGngQG5BWbnS003Mg3czXmdnafXaOjw4tTnmDdinY1UrTHBrf1QUDZzsYvRTA98LLDz1Zkqx00NEgcydg7cQW2w2ZsHZc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sat, 17 Feb
 2024 17:05:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 17:05:50 +0000
Date: Sat, 17 Feb 2024 12:05:42 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Message-ID: <ZdDnZmQ5_rAUm6fl@manet.1015granger.net>
References: <20240216012451.22725-1-trondmy@kernel.org>
 <20240216012451.22725-2-trondmy@kernel.org>
 <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
 <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
 <CFBE3BDF-E347-4273-8C7F-A57E0D353457@oracle.com>
 <756FABF8-FA78-4D16-A4B8-B47C4745868E@oracle.com>
 <5c35277cd061e16a914b94e070ea6d95a75c1342.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c35277cd061e16a914b94e070ea6d95a75c1342.camel@hammerspace.com>
X-ClientProxiedBy: CH2PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:610:60::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa89a70-9dc2-4aef-6509-08dc2fdab167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yxaE60Wh5KwjrOpU0K89Yh5pC846KHvEsi9l2qNcVDOcGCKaZJvNK/rnYLGhQ1Kbla4TkgpW54XWzBK0rA2553hDoLMb82LugsruqJ9I6X8lFdkeD7cA0IdNXmoM0GMI4VEyubQqlqvA7bVADq7K8ooIMFUVrACFgj/OaaKB67uzCFS53n8dV2jUSPw3YymYOJUIrnoGmAnl+rjC3ECEHg8+1h6Lku3ezJr1SJkP6+3ScfPT1TflJSS0SgNDOAGCWnaRDv8dy5F8hB+Eh4j2251zTZYBycoYmEEgTIsL9r4UfHCBAYu5osNEWlj6eyOup5kY0uo8JNbTu8/G0uN7gnr0IllAXawTsXcht0Nz9Gdw0/g2+GiYvn/Eh9YUHztjO1V/gyQDriGnuSKBlHeU2qWKrd5AGtGUDA+hTjN2peatU2zV3dPldqCb7MIVC/EW2I8YCMfItzvhpL4y6qApHiXb8ruryIaSFAYJjHgig5mNzqy3Nh455koIx0ogCMejZIZ2qxUCoz4LIFRBWt4r8FSrdBndAtqNGfWdhrdSbDflGI+5CIplr9DOQdZSAZIv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(38100700002)(53546011)(6486002)(6506007)(6512007)(9686003)(478600001)(316002)(6666004)(83380400001)(41300700001)(26005)(44832011)(4326008)(6916009)(2906002)(5660300002)(66946007)(66476007)(66556008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmlTZ2pPdlNnWXFtbm45bnRrUms3YkVlalBzT2lwTHFFWmtDbWN0djRFelRI?=
 =?utf-8?B?N0FDUWZEQXMzUnFxRllvNkZyYndPbXhMcE95SzQ2V2NBRHd4RWpBSmpqeWpI?=
 =?utf-8?B?cUIvUExUL2JOeFJlLzREYUJqcVRlS2NVcnJJVmNoYmpnNW0xdHJjaWJoZmFY?=
 =?utf-8?B?bWZNYmUzcFA4NmxnaG5IcHpmTHBvc1lkS3pGQ2dsdWVPOXVGbE50WGx4Yitt?=
 =?utf-8?B?bEY1T0xEVmx0V1BucDAyWTNlMmJNS1M0YzBFZ1pmd2ladHdtbEs5T05IMVh1?=
 =?utf-8?B?ekQycWVRT1R1YUJJWjJGN01BWjJvZGRjWFFsWEplMVh2eTVBMnZqdXJaZVNN?=
 =?utf-8?B?V2p0T2drV1JPMG02TnF0cmY5bFNURkdiWnViaHEyT1VGUWFMQUMwSVhLaHlh?=
 =?utf-8?B?MzhTTHdFNEdMd1dQdnpqU0xFMVBlUE90cEM0eTFNUjlhL1NPNGx1WWllakNU?=
 =?utf-8?B?SDFBajR6YitDL0xqSFNBaU5CQVkwbEVlN0xqM0VseHlUMUFXK0VzaU9TQmxY?=
 =?utf-8?B?b1g3MlBjU3A0UVdhajRjeWxRRWVDNllFRFBtWnpGazllRDQ4NCsxb1NMUm9G?=
 =?utf-8?B?RjZiSzZFOTB3MFIvUmhsWWVMNkU5aVU2MXJYSjROTUtheUgzQ0NjUjg3WG1C?=
 =?utf-8?B?bE5HSTVZNFVsWlRqZHRZeTdVZXhhcFN1dmlSNUQ2ZXJVMlRLRWRSbmVVVzZ4?=
 =?utf-8?B?WDFnbXhzSHAyQ0hrL0laWTFJaWNUbGJUSHRhVFNwM3dUdUtYbkxyandzTmEw?=
 =?utf-8?B?dEc0T2NyMnI2WjVRQzZ2TVYrWXdvQ0ZlaUFMaTVPbEg5VUViRm1Jcy9SZkxm?=
 =?utf-8?B?SHVZV1g3aFdHUEJ3Yy9Sbm5hRG0wQXBLUlZjSE5SaXhXSnVVNzRVbzY1Z3lX?=
 =?utf-8?B?WXkrSk96Sm1hNVhWdXR6Q0F6RGVQdFViNUtlVWJDYU5JZ01lWFptbEhsbHFS?=
 =?utf-8?B?NS9aMDdiT1RLMkNrU2FGdkpybHhNR0ZEK3dIcXdKbHB1UmErUE1RNjVoNXQx?=
 =?utf-8?B?QllrR1ZkNjFQTzR2M2lxZzQydlA1UDB1Q3ZwdkdGYXY0OGNtYlo5UVVoaWRp?=
 =?utf-8?B?N0M3bm4xd0VJbXJCWmJJN21ESnRxRlBuWmdvMW5WeEc4dGZnZDZFNENrY0c5?=
 =?utf-8?B?R3IrTTYyZTdqWGRDRDhTZ2J0MmRtUllnamZmanEwQmtVajh0MU1rYzM0L0V3?=
 =?utf-8?B?YU1kWm5XUTF4M2tCakd5M05nOGJYVXFKN2lIK2t4QmVodVdiSGpQS3MrV0RF?=
 =?utf-8?B?Q1Q2bWwzbnVzd0JOUzVHWlpiWTY4YTFIQ1dXalJwN1ZNUlBKL0l2OVZxa1Rl?=
 =?utf-8?B?ZitjVm1zWW1LZytuYnNZUzNqSWRCMWtVbFYzdCt2dWRpNjdva28wbnhsa0sy?=
 =?utf-8?B?MWdXUEF0L05nK0M1OXRlNWU4YzA5b3A3Y1ZiRWUvVSsyRnlzK3lmZ0R4WFNi?=
 =?utf-8?B?aWxQbXF0bG0yMERvVitFYnBPZm84endlVjZhYlFmc2J4NHhacmxCYTR4YU8v?=
 =?utf-8?B?d1hRd1EvUnBTNllhcTVIMlJHdWJRTFlFVW1xbG5ITVJLdFZ2YjB5Mm1lU0hH?=
 =?utf-8?B?dE14TzEzb2NwL2ZqbUtZQ0hyWVBpbXMvVmRJOGdvTVhPTzV0Mm1nWjVuTU9P?=
 =?utf-8?B?eEE1WmlZakg3aEpaU3hkaVdiZkJGem5wbFdpbVFmZGdPVHBBekdicnpLbHpW?=
 =?utf-8?B?eFFWeTU5REdrZ0QrcGhsc0lPWVdxdW1JMVd1bU8wUEF6dFNJNTdvdnZXOXov?=
 =?utf-8?B?ck1paU1UQXNxNkZJdUt1ZXBlSFh3Wk1rR1RvcnFOTWtkaGFVZEp1RjVSTGxk?=
 =?utf-8?B?YnJqbjJNbWRkTnU1dnhMdDVsMDArU1QrcFRLTEFBMmh3aTloeHJ2SEc3QVBV?=
 =?utf-8?B?WGNFbEN3d0s5UW5uWVczV0dlRGNtYWpiUTdpcGlob2ZiOU1Md2FNT1ZSczBB?=
 =?utf-8?B?MEZEZkN4K3dlTW9INk8rNW5tdjlsMkViYmNjdEVMUlQzaHJpMitQN2lHbkR0?=
 =?utf-8?B?Tk1QcmxTc3JCcDA4Z3lGMGt3OHYzVzhVQnA3YTM3VmR2NnlBdjFiSmE1cnpi?=
 =?utf-8?B?Ly9qVGRFUHUzNmJRazZYOW1xaDMvZGxmT1JuQWZjSFVJWmNNL0luWFRqcmJ5?=
 =?utf-8?B?MTlIU1d0eDFqNmlpYnNpek5ETURWcWhJN0MrckNEOUhJSnd6L21mVHlYamFF?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	inbrgdyi4PRf9Tz8wpwT5dewzw1hdf9cwHsllBOgGfG6NVzJsPPiedjYrbjYJ7ODiQ9tVmn4DxBxrN0XiqJM1Ux2+v+S9nwzxUZTPkFzN8e5+0/EUloYxie59Tu/+CMjVfRwJP+wTnkxD7R81o0meos7oBpWDrquRO38Nb3/v7bj+dkTHAxHPdyU0JPNBgN1ST0Eij6xJhSKIJH+81SsWUV/o+xZSb0KxFrulaTeIsEDolb7ON+vH69J6bG/UfBU5FWigGlaGTbR4eRzsPsttO2QEy406Ph1njb6imtCW6LLyzhvHSjYxb7KZyjc+8RMfs3bF/UnuRnA/CRaWfzGGSFyNEijK5Xj7/BwKFPAVTWupeuhLMOawms16+GYS5i3fbnQ0wIpMBq3umRXwgdzJAioZxGP6A95MEw43IvZTaLx4GGSbSkulzPMBEN1bOGSDA2eAKzLFqNFdT/jwUxe9BLHJ3QgsqwzW4uTduuv4ST1AgpoilvU+GleOnqI/j5EuNwE/5xRsuohBtaXcvb4/CByXW/nhI7TrOsyKM/m1nJrsCKx3nydTT445ADjprbRSDUgNgSqnVtnDo9h7zYVmr8rrZ6tS+o2MbZGDIHz5jM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa89a70-9dc2-4aef-6509-08dc2fdab167
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 17:05:50.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+fsBdJrtzA8+JveSpLLjcxD+uQbB9Z6zjXdCOA49kHeOQjTb36BTEKC9sgOI8CzfLFU/NAgij9OhQTI3212ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402170140
X-Proofpoint-ORIG-GUID: OCSbK3cY0FdtH0zUlGlHg_QC1zn2cNWS
X-Proofpoint-GUID: OCSbK3cY0FdtH0zUlGlHg_QC1zn2cNWS

On Fri, Feb 16, 2024 at 06:57:16PM +0000, Trond Myklebust wrote:
> On Fri, 2024-02-16 at 18:25 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Feb 16, 2024, at 1:19 PM, Chuck Lever III
> > > <chuck.lever@oracle.com> wrote:
> > > 
> > > 
> > > 
> > > > On Feb 16, 2024, at 1:18 PM, Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > 
> > > > On Fri, 2024-02-16 at 08:33 -0500, Chuck Lever wrote:
> > > > > On Thu, Feb 15, 2024 at 08:24:50PM -0500,
> > > > > trondmy@kernel.org wrote:
> > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > > 
> > > > > > Commit bb4d53d66e4b broke the NFSv3 pre/post op attributes
> > > > > > behaviour
> > > > > > when doing a SETATTR rpc call by stripping out the calls to
> > > > > > fh_fill_pre_attrs() and fh_fill_post_attrs().
> > > > > 
> > > > > Can you give more detail about what broke?
> > > > 
> > > > Without the calls to fh_fill_pre_attrs() and
> > > > fh_fill_post_attrs(), we
> > > > don't store any pre/post op attributes and we can't return any
> > > > such
> > > > attributes to the NFSv3 client.
> > > 
> > > I get that. Why does that matter?
> > 
> > Or, to be a little less terse... clients rely on the pre/post
> > op attributes around a SETATTR, I guess, but I don't see why.
> > I'm missing some context.
> 
>    1. SETATTR is not atomic, and is not implemented as being atomic in
>       Linux. It is perfectly possible for, say, the file to get
>       truncated, but for the other attribute changes to get dropped on
>       the floor. NFSv4 communicates that information via the bitmap.
>       NFSv3 does it using the pre/post attributes.
>    2. When doing a guarded SETATTR, if the server returns
>       NFS3ERR_NOT_SYNC, the client may want to update its cached ctime
>       and resend.

All granted, but I'm still not clear. Let me ask this a different
way.

As far as I can tell, it's always been optional for an NFSv3 server
to include pre- and post-op attributes in wcc_data. Both the
pre_op_attr and post_op_attr XDR types start with an
"attribute_follows" discriminator. Therefore clients cannot rely on
receiving those attributes.

The patch description says that "Commit bb4d53d66e4b broke the NFSv3
                                                     ^^^^^
pre/post op attributes ...". And I think you also used the word
"nasty" in an earlier email. So what is broken if the server /never/
returns those attributes? What are the application-visible effects
of the server behavior change in bb4d53d66e4b ?

I don't have a problem reverting that part of bb4d53d66e4b, but
"broke" is doing some heavy lifting here. I want to understand why
we need to revert. Because it seems to me the server's current NFSv3
SETATTR implementation is spec-compliant. As far as I can tell,
bb4d53d66e4b might result in a little more network traffic in some
cases, but it won't impact interoperability or outcome.

Do you mean that you want to restore the previous, more optimized,
server behavior to return pre- and post-op attributes when they are
available? And if so, what is the application-visible benefit?


-- 
Chuck Lever

