Return-Path: <linux-nfs+bounces-2847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDC8A73D9
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52021B23B7B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E511386B4;
	Tue, 16 Apr 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EIx1AXOg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sATSj6DM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F391384BD
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293430; cv=fail; b=GJ/+GihA2hSZxk+NovETcBY/AtRseY/J0Q/F4+UOKzv02+hdhL8eFa48rN1CJ153VewZW2vZF8ksubTNL7LPeC38hSJ+XGy6lEZf9qVVg9aozTxBNg2k+z7AV0c3O4ktYpHoZWsTD3EboNd89XudvlRlgy7hCmDQcafoyC8XQ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293430; c=relaxed/simple;
	bh=N0/dSRoHQKMvZaZJcwUnMwIh7xbNsSXeNvz8PogmWs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mED29MvQYvizYBW5yroG5csMPxSIaqJm5zKcHsc09qWUGWeE35I1FcQK3ZbIaEnXPutpncCgUiHqswoU3aJ7tvR/EfMr4g05hGp65olB/9mekWwiLWnrQF207Qwuj7LkkSgt5Nt4PaqWr7dEHVWliGziPDqhPiACkevHxvqmsLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EIx1AXOg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sATSj6DM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GHiNpx009416;
	Tue, 16 Apr 2024 18:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=HOJE8Q238E2mnLtxGyEGm/C7/iCu0epwiX/vvLSh7rk=;
 b=EIx1AXOgcTJ2SVze78z/TQ+Qyx5jyewyMuDol+/ZjbsUaIHA15pEiL6uuXKvKA7CzQoY
 DqMeAEkeRsyv7/zJM9kXooqNyB5PBEWD+Plh7BXcZodzOV127OUmgPKvIsdCQFlb5Ax1
 FAO98jqWeiL+PVK39QHynrCKGsgsY9Twk7Mc3MHYa/a0uJGMJ/TzlAiTL6jOzoLD354I
 DiYTgojENOlsBQE55E4NLvykIcP5FaxipAtjmDbo/MFZlUxe1VUopQnogZO9+62YD14w
 wy49El2gyaBEKI59JrHMVGSH6mmd0QG0kdokqVx5t8aCVag44S4+Eq3iwAVziw1HpsAL tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2p23k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 18:50:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GIaZWC014381;
	Tue, 16 Apr 2024 18:50:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggdxfmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 18:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGT11UrlwHPI2ygSFDb6LvFMYc2EUuZidRwllDziL/dslWNHAJvCJTVQPWMqbxelDTv8zdU2kkvDU8sxYQ1nbQFsN0C+DEFSFS04/CVrwuxjrS9qYCkOf3vy4gd1cvDa+lHz8q0pBExdt/54RH7xMfPFADw7ALG3VeeUfA35D2AfTIete2fG6PzdO8xRibsvoTLYrb8uI5hItd8E2T2jkl07Fit5KoPNuvpJ2EAdYar6WjgZUCZRvNvnPfk6XOqYD/wtREMJKzPIGu+olnT8LxY7YPLDASwA94mDa4o/NGMDVTjJKkJrYR1LDgB0lJc79fnb/AazZHUNg0co15H0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOJE8Q238E2mnLtxGyEGm/C7/iCu0epwiX/vvLSh7rk=;
 b=dn429FMQMXw3AOWZ6yWf6Uavg3AymquHr8n3Dg5WQ5KmS+EDnR22kjoG0MJWI8jOZkOsfRz5NsnI6w3/j7MenfNMvMRS94BAb/zWF5+XA+wwIOklOfdWunNynW7AaPSMGEP0eESAvwatrv4+4PDlGOHPQ8UGb0EZQH+3rtkviEPCAKmSXw7nMcKIn+h0VeeAPKQoGgssbRu7iHD/q5zW4HBqXJ1I8guW6wXpM7X0WsCpzqgm4k2Jc6Vr1nMHugJw4NT7CS1jYN7gZIMWWJ2Szcqc3L17tGoVU8EBwoktiaX96h6K7WAKgKTXrNtCCVC7g3ElCPStkq7+VPio9CXhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOJE8Q238E2mnLtxGyEGm/C7/iCu0epwiX/vvLSh7rk=;
 b=sATSj6DMGmGJQVKcqzOoMcNLmTlnxWsis2P0Ij34cygnxr5yJWacuRyKqE+LsGWGfho+0eoUt9YHxr3fDc1StTZos/VKAkzaL4hRt+dLReRPx4FFhuAlQlxioaPCDryxx2qEAlCC/Oe1St4WKJDYuU3/00AkboXif6LocERi0Tk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7297.namprd10.prod.outlook.com (2603:10b6:8:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 18:50:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 18:50:12 +0000
Date: Tue, 16 Apr 2024 14:50:09 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Petr Vorel <pvorel@suse.cz>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Cyril Hrubis <chrubis@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
Message-ID: <Zh7IYTE0yVc3s+7l@tissot.1015granger.net>
References: <>
 <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
 <171322513118.17212.2981486436520645718@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171322513118.17212.2981486436520645718@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 590f3153-b295-46cc-f36d-08dc5e460bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GHtRXDtP+sQVtr25actW1vnfp/YpdqBSsEhY6YmxzerABbHrNduAWGODtjZzDJioqbWVyNiGPw3qbHUSPqVR5rVdjGrEnNvCKB2HhhEyCiD2ycv8Fraig9Mrchgij2X0d88d93Sg0XnZOO10oD8rGq04VpZDecoY0qbndiLFKDAvGtEYeAaHwIDIvpRP14JtwgU47SG6YUqOQjWpuhvBCCCOq4j2eazD7XfegS5nsIh+LMU1JfWlZ9sbNtnl6SwfX9AxVnducsdSs3usU0APLYPPo8ja5DseW0/g40RWDxY1llR44Gye+RocryfrU46QypMyKAroA9l6zK/uWngxuoOVMuCRuPYRLaHH0X09QHHD9aLVEgHpgf516b1xvBc9c2q4GJE9GDxgMMQPjj0cEemZtTz4L8kNI7sd4153dtTDjF55maifN6L0gZWme7kHRw7sD0zHHmNlojP3I3qNvclIdZe0NIqi6bm+t/4DIVBhGjEwpqxaUXtoumcUEkLE4nc+PAYL0RHbsaCcdTBhHV5PhXxT1tu+0EesXsyroo6bdHzuzJgc+tvLxp4Pbwj0O4+iC6+ngmVKsSVdqpWgGjczs6o3P6VRHwOtz5Os4fo52RFClCxC+MsQ0Zznopsclrtv1YJGIm7+D2ocOF+HPDYp6RZZtax4UCcDHM7XZCM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGd0M3J3U21IeUdBNHZHekF3OGl0U2E3R1VLWStWanFKVThRamF0VFByL1F5?=
 =?utf-8?B?aXpWUHhXb3ZaM01sMk44NW9Wd3A4RWFucFFqM0JpZXA3UTVybzVnTXFuRGtZ?=
 =?utf-8?B?dlpCTitubWpwZEorYmJpTUNuN21aTyt4U3AzM1hlN3lwbnlZWUtraVAwZVBn?=
 =?utf-8?B?YzFVaiswYXI3YlBRQVFqTGdNTXBkMUVkZ0hOcHdjRWtYSG1PRGtZNGJDdVR2?=
 =?utf-8?B?T0gxeWV4bWZHUmJEaTBqbkFYU1gwZWpPQ0V5OStUUndnNjZybGxvVk1WTWJJ?=
 =?utf-8?B?SGxHU2VFR0dCa3FiL2pXSG1GRFV2aGwvWGpXd240SHRVOHE3U0Y5OEFzcWlW?=
 =?utf-8?B?SFd5NWV6YlRQQ0NtRFh4WDIzdDZueGR4bkE5TmQxd1pNbGNIWWNxRHFBUTJB?=
 =?utf-8?B?bzBXZXJFUXdEa2R2NkgycnczYk5xQzIvaXlFcEQ4WDIrcDNpeWJkbjhkVzMw?=
 =?utf-8?B?anJRdjZhUzJjY2F5WTQ1L1NBait6RnFZTjBCeUhTVzhFRjM5alVGSm9GUitv?=
 =?utf-8?B?N1JXbFl6UnFYREF3SmlDdVRIMmNQYnlMWUlMYWd5d3U0dWhiRmo5REhLQlNx?=
 =?utf-8?B?MlBZY09KNjlvS25HUGZONGg4MGdUeDBpeE9uOC9TdE0wZlpxTDRZMThWdkQ0?=
 =?utf-8?B?WVp2aXpWbHlsU2JrVzBJZkk2RE5NVDNYN2t6ZEJtQ0t2WlA5NGxSN0JvMmJn?=
 =?utf-8?B?UFBnc3NJTmZHQmYzS3MyRWJFdG5YZUFHVlYwSTVSMnhVbURodWIxRGRBK2R4?=
 =?utf-8?B?ZVJxVUJDeG9SN0Nuczg1Zy9sOE5XMEE2UkFGV291SVNwZUdjSy92VDZtMmQv?=
 =?utf-8?B?bjhpZlRPTVk1cDZSQnNSV01hNTZsQ1RweVVRbXRGb3NaWkNZZk1kazAveEdm?=
 =?utf-8?B?VHpWUEE1V3pDQ3BiTG1UdWJ3UGlYejFTbllLb3IzaVdYaWROSjc2d2xXWGpP?=
 =?utf-8?B?Sm5pcDlFNXhOd2VTRmZ2NGxmZlBOVkhYemFocHNwWDRXQ0FPbnhteFdFMW5p?=
 =?utf-8?B?VzhEWU42Z2JGellrZ3NzRzB5R1A2cmZGYjJqMEdUd0xhYU9pVytpUld0NEN1?=
 =?utf-8?B?TG5meXI2SEU4Z0FIWnBTU3dvRGNjWmZkUUZBZkc0cUVTSTN3YVRQa2RLclJ1?=
 =?utf-8?B?bjExTXdxY3RRd3ZOazlpWGwzb1FjanZScXRuMmh6c1AzaWh1UEk2dnptUEtw?=
 =?utf-8?B?ZVBTSHVVL2lDQmF3c0Q2YTdzMHFjd1N4bm8xejhWNWJuUFpqMnYvOFZKaHJJ?=
 =?utf-8?B?NlNITU9jbWw3aWY4VXRxMjdLaVl6WHhSYitZMzlncVlRbGxxaEhvMUI1TVlN?=
 =?utf-8?B?TWNEQVNPRm83S3VTQjE0a2lTNXBGbGV0cmRkNGI5N2ZscUIyQVMwczBIRFov?=
 =?utf-8?B?M0FJSkFsOEpaZUZUY01EWnRpRkdMSVJhUWptbDM3QUdvNkdBL1cweXN6SHVp?=
 =?utf-8?B?emxqaTBpanB0dU8zQnFSYnVzdDJlQlRIcy80VG1ETFhaSjFoaE84VjYvNEZ4?=
 =?utf-8?B?K2ZLbW9wNXkwS3N3S2Qzc0lrNHlOaFVPcy91RWZEVEFBcUZPSDBYc0pzVzZC?=
 =?utf-8?B?UnpJc3hRM3JGK3c5c3BjYkNRWkRkYmlCQTVIbGl0TUJyRk1TUDdnRGd2TkQ0?=
 =?utf-8?B?UnNNSFp4MWVlQ044M05GdG5BeEU5aTRaZUpjb1l6VDRjbjFLRFRGSVQyRUVk?=
 =?utf-8?B?S0JWN01zYld1WGlZakVjc3V5czkwWkFuTHlGVllxdUM1NHc3YWsvaS9uZlE0?=
 =?utf-8?B?NnBIbGpvYTY1MVBNYWFMT2Z3blNkWHNoZkwwUWZlL3Fhci9ZeVc0MEcyM1Yz?=
 =?utf-8?B?MFYrTHVGa3BmSWwvejRTaFdpRUlibG1YOHFCeEdqdTBFS25lb3JIQXJhWnFE?=
 =?utf-8?B?ZjdHc2dWWUkxNzRHM3pkT1A4U0hjVElZOGxoaXlBRkgwSll6MmJNWGUrOUJE?=
 =?utf-8?B?NnVUZ3g2Yy9GS2lKa1l1dms4ZngzalhPeFlJNlJkckIyK25ERXlyN21XNEVy?=
 =?utf-8?B?cmRBTStwcUgrazV2T1doRmJaenFuWFgxYkxoZ0hVT1pRait5bE9wODFzVUVw?=
 =?utf-8?B?Y3QrQlVzZk9Ca3BBTzZ3eCt0UmRuUXd0SzdQOTNmWW9rbE1RRkI5am1pSVlF?=
 =?utf-8?B?YXBHTm53N0tPMmpienlCVjZyQlA0NlRpWHM4RjNUVXFRWFd3cjY2Q2drSWdk?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DvmxSH476F0bHzrZ5Bu83I+uYWqhvmuukxMHXcRaGVYHoIRw4YBdacWUAfveoNKNQQxWIreGifJAyxJst/7kj33/yNUf7zHPEWwIZFgSIIz9/aLE5cPi+i4xomnza4FvHC6jHdmzq5rx3/lHa3YUZ5XZhFdoDQSf2L0Lxb8fRh+JUONfLK92CIP0+tWy3HsOM6aoH6ssaFleD6h5VsPhVcn568NqQpUkCSukkH6dras28Nwpmc1Dqq6sKx1tsgR6DSw5GUQvrKXIfF5m4WQL9uF1rFfB+TQAgySfEv0HsWGrjKH6lLLVKeiWwBBwHAkjmJCUD+NMFWSHPitDuAP0eY2r4TJkAHGzCiAseoR0wn+NyezrE3MSdtSq8xfN0Tsbbf2z/bspYW5FZ0OsJJI8jMgsjt1T332OE5hC486QPShShSUYM/qjdrjdmSKn7EbmRRb/wyRmJTEHKVB1YxDl1t1CGZ2qFxZrg6JBcjONRqcQPSn3y5ATp4SdrcBesRYwsoiXyNpWkU37j99Nf83icF+snYIhQmUFTFrI7hHtJneqVxoQ0EbOpjHQ0DmChW+nbM/jgxAFHoPs6ORB6a09YDIYC9owWm9WpYdVUcnmPFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f3153-b295-46cc-f36d-08dc5e460bd6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 18:50:12.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvsdgmuhaDf8FKSZrhvujVJBFh1+6xLdPhrBbtU0KQUpDMeR2hlZtgNgPH1gmXybTv4SXpSj6x6yWjo9XkFUfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160119
X-Proofpoint-ORIG-GUID: k1bsuQruAF4_QtEHIriVwe57PA_sSOx9
X-Proofpoint-GUID: k1bsuQruAF4_QtEHIriVwe57PA_sSOx9

On Tue, Apr 16, 2024 at 09:52:11AM +1000, NeilBrown wrote:
> On Tue, 16 Apr 2024, Chuck Lever wrote:
> > On Mon, Apr 15, 2024 at 01:43:37PM -0400, Jeff Layton wrote:
> > > On Mon, 2024-04-15 at 17:37 +0000, Chuck Lever III wrote:
> > > > 
> > > > > On Apr 15, 2024, at 1:35 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > > > 
> > > > > On Mon, 2024-04-15 at 17:27 +0000, Chuck Lever III wrote:
> > > > > > 
> > > > > > > On Apr 15, 2024, at 1:21 PM, Petr Vorel <pvorel@suse.cz> wrote:
> > > > > > > 
> > > > > > > /proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EINVAL.
> > > > > > > 
> > > > > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > > > > ---
> > > > > > > Hi,
> > > > > > > 
> > > > > > > @ Jeff, Chuck, Neil, NFS devs: The patch itself whitelist reading
> > > > > > > /proc/fs/nfsd/nfsv4recoverydir in LTP test. I suspect reading failed
> > > > > > > with EINVAL in 6.8 was a deliberate change and expected behavior when
> > > > > > > CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set:
> > > > > > 
> > > > > > I'm not sure it was deliberate. This seems like a behavior
> > > > > > regression. Jeff?
> > > > > > 
> > > > > 
> > > > > I don't think I intended to make it return -EINVAL. I guess that's what
> > > > > happens when there is no entry for it in the write_op array.
> > > > > 
> > > > > With CONFIG_NFSD_LEGACY_CLIENT_TRACKING disabled, that file has no
> > > > > meaning or value at all anymore. Maybe we should just remove the dentry
> > > > > altogether when CONFIG_NFSD_LEGACY_CLIENT_TRACKING is disabled?
> > > > 
> > > > My understanding of the rules about modifying this part of
> > > > the kernel-user interface is that the file has to stay, even
> > > > though it's now a no-op.
> > > > 
> > > 
> > > Does it?  Where are these rules written? 
> > > 
> > > What should we have it do now when read and written? Maybe EOPNOTSUPP
> > > would be better, if we can make it just return an error?
> > > 
> > > We could also make it just discard written data, and present a blank
> > > string when read. What do the rules say we are required to do here?
> > 
> > The best I could find was Documentation/process/stable-api-nonsense.rst.
> > 
> > Tell you what, you and Petr work out what you'd like to do, let's
> > figure out the right set of folks to review changes in /proc, and
> > we'll go from there. If no-one has a problem removing the file, I'm
> > not going to stand in the way.
> 
> I don't think we need any external review for this.  While the file is
> in /proc, it is not in procfs but in nfsdfs.  So people out side the
> nfsd community are unlikely to care.  And this isn't a hard removal.  It
> is just a new config option that allows a file to be removed.
> 
> I think we do want to completely remove the file, not just let it return
> an error:

'kay, no objection.

Can you send an "official" patch with a description and SOB?


> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -51,7 +51,9 @@ enum {
>  #ifdef CONFIG_NFSD_V4
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	NFSD_RecoveryDir,
> +#endif
>  	NFSD_V4EndGrace,
>  #endif
>  	NFSD_MaxReserved
> @@ -1360,7 +1362,9 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
> +#endif
>  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
>  #endif
>  		/* last one */ {""}
> 
> 
> My understand of the stability rule is "if Linus doesn't hear about it,
> then it isn't a regression".  Also known as "no harm, no foul".
> 
> So if we manage the change to everyone's satisfaction, then it is
> perfectly OK to make the change.  nfs-utils already handles a missing
> file fairly well - you get a D_GENERAL log message, but that is all.
> Petr's fix for ltp should allow it to work.  I would be greatly
> surprised if anything else (except possibly other testing code) would
> care.
> 
> NeilBrown

-- 
Chuck Lever

