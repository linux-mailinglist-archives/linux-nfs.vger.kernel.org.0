Return-Path: <linux-nfs+bounces-9563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E357A1ABAC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 22:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3047A28D0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7391ADC90;
	Thu, 23 Jan 2025 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loygTs4h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xurffsow"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B08BF8
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666428; cv=fail; b=Hy7YSuINAwHkJyGTz0Hy/4S+Wf4xpoGBBO27sGU2gKdfY//HT5qQlpoI1+DlD1TLdgKVrSTs+HtE6IREmDLHL/sYhRcgPN32oDahWp0K45hNznEvCUOD5/Z8pOKSrQAxXgkiCJC+qy6Pg+RWSyxgOXR9tGppGf9aGl78pU02NyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666428; c=relaxed/simple;
	bh=FCtghZBgrI8bZAvEdPlyM9lKmo4CAZ5ZhyExKsBEn24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RWuSmUA1cRf6OsP1ugBVphTP2jpzqzi0GzU05sU1P/ZqyJx1mSbkomY9kT4iPCHq1nKWE7lkxOCaZwY9pJf0nFnsVdkJeL4miLCSDtiDTJOC3kirg7rI3F699yHZEkG6DzzXa7qjr5lRFazb0W1zK93z2RX3GQ9bNkFZaOT0iCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=loygTs4h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xurffsow; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NKkG3m032083;
	Thu, 23 Jan 2025 21:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ccg163UQgoEtOk4HXGwLlc8tnZHZNsnZMU0OGQQJBOQ=; b=
	loygTs4hGbbKXl7DnJf34HyzRPGLhYlzlgTBo0tAi0mRMepF2ehgzgm8CIamINVb
	PTEIJY5lnlbEs5KiSHq58CCNrgXG45AUZlb/+Ervl39/HXEUb5JVQWa97SrEwBGQ
	U1CJVv0vCNp0KFOrbcftwVZCdsNBto5Zn2rAvlWf+pe2qecB7feZL0e6vZXajkoc
	5wdIR8vyXSdbSu7fllX9JfDFckHmLdHnjPTt2lhwvzJ3+Jr+1tRL/K4sHbweZyij
	vHIoqTL7za93Y5xoGb1P/17Yda9laQRPmvdyHbq/ssbdn4PI+UNV0t18+ngHVyP+
	ASOwfme92XgVErFRtEcmWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsjqy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 21:06:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NL5VuA018656;
	Thu, 23 Jan 2025 21:06:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c5hwbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 21:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIDq8u3WHRjWTzodu8LhfWTOKC2dnDXOtzAECMWA/PD6tOTiUzYMWLMwCmtv8halb4ydrGCt6bGaFB8oj9yw+QRfMr52YSRxtsqhJvtHESK64N34viLZ+9ksdRVMtfOoCg+0HC4MmoZxYRHIlQad70XN/SN3Ut7HZ+fSLxk0lM4iOfzck92221/LwJ4BZ+9JhfqSkpTKY+scAdOvhfXTMtNemSE350QU3Wc8i9pRcjsNDJZZ4QB0+JTBm+M/tcpP0iRUtxtC3w4pn90KyUSyFpDlb3umkxqA1Z7Gkd6Bd1e/aehAdtqKCRyVb7uvpOlE9xfLrImbKbVNVtugNuivKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccg163UQgoEtOk4HXGwLlc8tnZHZNsnZMU0OGQQJBOQ=;
 b=Iy22QR2OhonxNOKSWShGH8RopeWKf/2X9ppjcmab7BxeALRGB7HDSGFbxQcZnYT+zIjV88q7fkrNSu62wYvehmo+zjbuK4EVb6nsMZ/amRHKpLvsT/ZMbETBDCX2nxmcXCicgiHUvwKQYTXk2Nt5OZeiXWyKyf5QQ6RBl0uARMpBAa61gHg0uWW4MLtKCLhXPThEP0GKRDqvcRsLC548xl0HiNicrEQCd9aYdQUSVWQQpMoTTqLdvZh9+pogRmhvVifqE+yxLayKx2iejhbNeKIM3KuYn5U7+TtQSpq/9GKgM6nTyO11kxZ+QEua/axRz8fZXUwcjRvKu/gS1Ywtbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccg163UQgoEtOk4HXGwLlc8tnZHZNsnZMU0OGQQJBOQ=;
 b=xurffsow7Fiv+OO4VBpAQFSLZrRwUT1W6nwA8RQN0iNbS0JS2AO7t8N+a+3G3eXeFQcBPv1svQV3NUGGE1EpbeV+JMeXYkAEZ8H6APKUt+s8/z6uIv1vd4oQCgNMrAYX6nDPs1/MS09g94T51CvthcJAE5cdNlY/iO8XeqnBSEw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Thu, 23 Jan 2025 21:06:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 21:06:47 +0000
Message-ID: <2a55bf53-dc35-49bf-bcd0-b76999e1ef34@oracle.com>
Date: Thu, 23 Jan 2025 16:06:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] NFSD: Never return NFS4ERR_FILE_OPEN when
 removing a directory
To: Jeff Layton <jlayton@kernel.org>, cel@kernel.org,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@hammerspace.com>
References: <20250123195242.1378601-1-cel@kernel.org>
 <20250123195242.1378601-3-cel@kernel.org>
 <8565d8e45073f76705a23e00eedd4d911f24a360.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8565d8e45073f76705a23e00eedd4d911f24a360.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:59::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: abc1e44a-eb67-44c4-97bd-08dd3bf1d918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YisvNGRoMUdRQXA1VTB3VDlDT0lwQTFDcys2NzU1WUV4emZpN0wvdWsyR3VE?=
 =?utf-8?B?VHVYRlRZbDE1eGhXTUF1eVJzamNlVEVqTWxJMTVpblhhRzhpR2wvYnFNUXI3?=
 =?utf-8?B?WG1pbGhHVG5henRYMExGdXFsM0FVaVBXVjgwY2IySDZsc1Y0TlZYbFJocS81?=
 =?utf-8?B?RDUwSVlBNWlvNkFpNUhCcGtReUlLVzNwZkUvTktwM0JKYi9TckUrdXpNRGU4?=
 =?utf-8?B?ZWttSkNtejRxenZoZmtwSTdjWFhCbFZxNmFRNHRIK0QxU0V0OGNBR2JoU1VM?=
 =?utf-8?B?aWRWQ3NCNHdYdmtwN3JzV0xmWVZuMTkvWERlOXQ1V1YzNzJNaGQwdnFrY1JF?=
 =?utf-8?B?dUFOVGtuK0pSV0tNWEdRME5ldFk2ZVJVWHJqZWpuWkxBbnQzcWU1aEJWdVJz?=
 =?utf-8?B?dzg1VHp6K2NEK1N4ZjhYQ0lVd2JiRTdJbHkvSU5sR2kxYjJZSURFWlhtQnd2?=
 =?utf-8?B?REcxZ09WODBQNzBKZ2lRd0hJWVNXSWZTK3pwek5jUnk3eWVtenhhcnFqbU1p?=
 =?utf-8?B?VUxpeHB1TGZyOEFJcEF5ODBlOFJyNENLQmJPb2R2QVAyK2tBbE1mQXY0WlFk?=
 =?utf-8?B?d1RIbG1McmQxRDhZWTM0bTBzeGF4MGQ4THZ1VUZlTkRoMHdQWTZqZVFKQlJo?=
 =?utf-8?B?bkxHTjdwSkx6d2dEaFBXaW5ScXhoTHVMWllQN0JoUndyV1FqMCtRbkNZMmNG?=
 =?utf-8?B?YU1LUjJiNFNjd3FBMjR0R0lrUFk5UFZXVGRjUW5uMm5vYmc0TXc5YVMyWWpY?=
 =?utf-8?B?blBDZTAxcVBoQ0tTS0R6bmhBUGpMTnlybXp2dVZhK3RLRlBsY0hnbktDZUpQ?=
 =?utf-8?B?cytqbFJUYkN6V2dzdHA1b3JZcTZrRG0zMGFTNkRDRkRtOERJaTJEY2IzeW9a?=
 =?utf-8?B?S2JHYkQ4MHl6RDNRRFBnUlVDLzZHT0Z0bXRhS1l0b1ZibHZ1UXZzMVhhdEty?=
 =?utf-8?B?UGExOW13ZC9Ha1hIQWFhdnVabys5bW9oNGt1S3MyempCdnplOUNEQVFGMi9y?=
 =?utf-8?B?cXV6aVBwcS9hbmdZQitlcGJjeTZoSE5IWXZuZWNKMDhNVTFrSnNOMlhrb0o0?=
 =?utf-8?B?ZWl6b3pnbThSU1AzbXpmN0ZyY0IwellPejlEWlZIUTF5QnBZYWxab2ZjM2ts?=
 =?utf-8?B?dHhNaU9ZMDZaWkk1V2VsRjJtNkMwdzJRUzNrazR5T1RucVBsbEJGRDZPWUZo?=
 =?utf-8?B?VTBDYmIzcWJXcUlWdThGc2V4OHJlY2Z0amRCNlFQSTdCTHZPMy9lazQrN25r?=
 =?utf-8?B?Q3owNUlCZkxsVGFTbHcxV29RVVBMUGdoM3BCUm5Ec2dTS3k0cW41N2thc2Y2?=
 =?utf-8?B?TjhqOUZoOEtWWkZaaUlFcGo0MS9RVU5jT1UyR1VTOVVSOVBmNGJ5Wkl0S3JW?=
 =?utf-8?B?dHErTW56VEJWSE9CYTNKY1FYRmJZZmEwVkpKQ1d6bjRJai9HV3JaTGkxTkJa?=
 =?utf-8?B?enVyTzJVQ2pVWENQdVpHSXFpQk1PaEJESmRtK05VZFVYK0Z6My8wc2tMNlR5?=
 =?utf-8?B?a0RIWkJNZTNSd2IwNnZ2MHNDZUNRNnNuSWZnOStsK0pCckhxeGF0RkNZdDdV?=
 =?utf-8?B?RGE3YTY3WlpBeUY4cm1PaWZyT3IwYjhPWDlmM1FQQk44T3p0Tnh4ZXV6aDR0?=
 =?utf-8?B?ZVQ5YjAxTEs0bGVzYXZQV2pYZlp2eTN0OFJ4MWpmd3l6N2NmLzBzcVdQRDNs?=
 =?utf-8?B?V001Qm1SZUViZzFUaHZxQnR4bm9mZWdVeDNSNm5hQm4vVm9iQXpBNkhhb0Rr?=
 =?utf-8?B?QkpUcmRvMDVwUjhUdjg3S3k2R1M5SUlzUjFiT3NvNXpxem4zRmltSUhQek5Y?=
 =?utf-8?B?UDVLYjFhY0hsaXVqc01HWDhkWEpkeXdLSWFZaVNzV2RJcjRYNktlMWxuY1Y0?=
 =?utf-8?Q?k61lUFsu10Mwd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJIMWczU3JFOHhtYVRNdWh4R2lHOFpkRE90OTQwK3lVMlA5YlhrbVVHSEEr?=
 =?utf-8?B?d0RTRmluakZZM0ZpcXZmcVdCZGgwQllybnpOUThUaE1aeE16TktEMWI1bEx1?=
 =?utf-8?B?am9BRkJlSjQ1YjA1YUYzYm5XZEdqNWIwZ3pHSytqcHUzRW84aVZHU2FmR2FK?=
 =?utf-8?B?bGgyQ2ZOVHZLNGU1WDRNWFhTTHQveUs4TFNpV25EOWtvUUt4cDA5Y3Z2ZVMz?=
 =?utf-8?B?R3Z0QVo1N25abXhYKy9lVmlMRThyb2E1dmU2VnFSemRxWWRZeUk0dEorU0lN?=
 =?utf-8?B?N2Fwb2k2TUtoR0x4UXl2eXZrbERUbURXZnozTHBaRlRjWDl5enpiVUZPczcr?=
 =?utf-8?B?ZEZ3NlN0NFdHNWlYd09zZ3drM0ovNHBGZVpYYWRHcHl6OEd5Zit6WFR1UFpL?=
 =?utf-8?B?dFJSSklpTzZXbi9mQkd2c0lWZ1E3dkZrMmZ1SEVLOFVNRU9CUE95cmJ6QU5u?=
 =?utf-8?B?dHI5Y0NtMm1DVzVrMEh2bmdqM00vZFhQZzlCTThjNkhEMDR3VG1VREQ3c3A0?=
 =?utf-8?B?SUQrOUMyQzd6MXRMSjAwZU9wQkZzWFZFNGE5Z29oKzljMGQxajNKZUlpeEpm?=
 =?utf-8?B?YitCQnpSQ3ZMUlFQK3pGUkJMdzdqQmVXa1NKVDI1MVE5aDZTQzFXdTVuR2tk?=
 =?utf-8?B?blJLR0xPRjlJd1Bsd01qMXN3OVNrdW1RTmttY0tvQlYwdlArNEhTMVNzck15?=
 =?utf-8?B?Wnl4ckppSDNIK2czSUFEdjhCeDZNc2ZNSHlmWWxLWG1WaW9QWFgzNjQ0dFhq?=
 =?utf-8?B?VFhNV3lraE5qSnpVV0d5UHVzWnhRdVkxckFnRnkzcVZMd3Z0T2xUUmQwclUx?=
 =?utf-8?B?NUMvb3ZvTWFkR0ZBT1RUdzJ4N09McDRZcGhaYzc0enRJT01sa0UrOXVpaFg3?=
 =?utf-8?B?WHoycHZqQ0JaUytGR2tlUkNLVTNrenRIRi82NE4wZWoyZHdxMTFCTnR5ejlr?=
 =?utf-8?B?dlhiaDU5MkFjMlNicnNlbzV1ZkVpYnVzd2pwVWRJNDVWZEJDK2dVbkpyWmIz?=
 =?utf-8?B?YW5xNi93VEFhVjdYZjZKd015ekVweFNoSHJLSm1welZCZUtGVUFJRE1MQmVS?=
 =?utf-8?B?SjhyOTZXT1JISHduZ25lSmdlTUFOb0RxOG50Zm9BYjlCNWpsdnRwcUIwUmRT?=
 =?utf-8?B?ZFY0aEQ2MmpIVmdvalR1WWM1SXUwTDQ5VUZaL3NhV0RZUGtwWkxPOERwcU5j?=
 =?utf-8?B?VUR5bVZMY05YUXpqMkdrZ3FSY2NtQTB0aXU2MnBuc3dBMnNEb3Y0OUtuaGNI?=
 =?utf-8?B?aVhLWHJqbzdXTVd1L3V6bHFSZys5UFpKUTdwMmRZMXBvMW1UczlQcm9Dbk94?=
 =?utf-8?B?cUxydlRqN0tyeVFlSE5RRktlbVZmUkM2cm5GRWNIemJBM2hkZFFJTWZLNitF?=
 =?utf-8?B?WmxWdTNhd0E3dDFQSUUwZVlWQlFPdy9TOUxjWFlSUU5xVkY0cUlldjUrbUtz?=
 =?utf-8?B?QTh5dks0MjRXTnZkMWQvU1NiTmZsSDhqZHdRaDRoTVFvbUIxQlRaQUh2VkRv?=
 =?utf-8?B?UmQxaEc1dnJQc0wyREkyQVgvbGtaNWVxY0hPbkNWWjhYM092U0NuVTArODJO?=
 =?utf-8?B?MEFVQmM3T2h3dUNKU2RTeUk1UDZiMXF4RmdBZjFGSVkwZHkrQ3ovcENqZjBo?=
 =?utf-8?B?UlpaV2RaVGhMYXdOdHY5N2VIU2pMSENvbDNzYTJ4Ym4xeFRvOTVrWW1wMEN4?=
 =?utf-8?B?ZXlML1RlNFJSTUpNUW9Wd0YwUVpNMkZ4VGlJd3dPQkxRb2d2ZkZDaE1DUW9j?=
 =?utf-8?B?NHBBQWJsSkoxZEgxTzRYdGVMSXRHUC9reGlZYURydGF6cTIrRFYzUmRGQnM3?=
 =?utf-8?B?M2JLMWlDbE5xOThIR0NIS3h4Y0dqRjVyTEpRVEpIc0FkUnNPSTJJL1dWeVRH?=
 =?utf-8?B?aWhEM0gyS0VVUmVLZDM1aElHSHg3UTEzUWZTYTl1OWdSM2ZQVmFFUzhmY0NB?=
 =?utf-8?B?VUxEMzZRMjcyVzZ0QWtEOFRvZFRHaGo3aHR4M2VRTzFqOXRTSlNDYUZ6MmRB?=
 =?utf-8?B?Z3NMa2xjUXVjbm12UW5CUStabHZxVTZ6eDF3cmVRR1YzcUUvWnRrRGRuTEtw?=
 =?utf-8?B?ZXgxN0h4M3h6ODBGQ0dYNHNWQkFRUHlzSDRRRk52aWx6d0MzUHhHNDBRcWtk?=
 =?utf-8?B?RWZxZG9nb1BDaVlDbEZCTDFHaWJxQUdFbzRyRDVWV0FzVllBZzJrQVg5SkNN?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bSKveT7DuwxCvwg5K/Sj9fTP+q2ey+zXCkHjtjrFXm7zNnSyEHZvGU1iBMrjTFKFp4t2WwzoDe11k1wNVll81HswlSG+7uEn5mhsP7b79CELXb93YLXY/ERs1pP8s/ca6QrnWR+iAJ18p3jlZMdhBy9FpUV3HT+oqttCOf+3tRSYCY/WU3V9fsxKUxIoSJ+EWmhJOSWeQlJ6sW0eeb1Rt1J0OuIldnNhmUR2QaDLoA2XGP18RJNVjjVO9iqYMGDXrcY11DpUd8lnYtO29bN94AK0hNfYqsXCiCW2h9IndR8V2xKhul85sCKURwQHBwvVXeqiDZev+PsUlZKp84tGEy9T8DRWuTSppOX+etovDHvd0Ow7uFYmVd6i8CwkBCkGRzrdjmmfqbwrlm4+lUaqmYtX3gAqL1iQmb6klaGRtUqhYYtYwQ4xIosrZ4oNCEnsd9PoO5AKtAAst09no7L1rdFVO7CuphDUeH/FZJIFCLNxf6w1scp46uBu/N68rXpgBPFBHIribwIFkMQFEjflnXlNv03FFRGe7pktgJZqH27kU+udOxmEgVZOF6xqB/5bVCYqCVCHUOWlsp2rONgDEYxoG6v9Er8LXJIeEhA2voE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc1e44a-eb67-44c4-97bd-08dd3bf1d918
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:06:47.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSoMP0/oOn0emg+d1FHX9z1HQFrjI7Uw12r0EENnxgpSFikerUmV4tbywjck0eyOFaO2QIZU/c/jaj0wLCUm6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230152
X-Proofpoint-GUID: EGQfgV9gElYewupmEibzLxJxBZTrqZdg
X-Proofpoint-ORIG-GUID: EGQfgV9gElYewupmEibzLxJxBZTrqZdg

On 1/23/25 3:43 PM, Jeff Layton wrote:
> On Thu, 2025-01-23 at 14:52 -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> RFC 8881 Section 18.25.4 paragraph 5 tells us that the server
>> should return NFS4ERR_FILE_OPEN only if the target object is an
>> opened file. This suggests that returning this status when removing
>> a directory will confuse NFS clients.
>>
>> This is a version-specific issue; nfsd_proc_remove/rmdir() and
>> nfsd3_proc_remove/rmdir() already return nfserr_access as
>> appropriate.
>>
>> Unfortunately there is no quick way for nfsd4_remove() to determine
>> whether the target object is a file or not, so the check is done in
>> to nfsd_unlink() for now.
>>
>> Reported-by: Trond Myklebust <trondmy@hammerspace.com>
>> Fixes: 466e16f0920f ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/nfsd/vfs.c | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 2d8e27c225f9..3ead7fb3bf04 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1931,9 +1931,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>>   	return err;
>>   }
>>   
>> -/*
>> - * Unlink a file or directory
>> - * N.B. After this call fhp needs an fh_put
>> +/**
>> + * nfsd_unlink - remove a directory entry
>> + * @rqstp: RPC transaction context
>> + * @fhp: the file handle of the parent directory to be modified
>> + * @type: enforced file type of the object to be removed
>> + * @fname: the name of directory entry to be removed
>> + * @flen: length of @fname in octets
>> + *
>> + * After this call fhp needs an fh_put.
>> + *
>> + * Returns a generic NFS status code in network byte-order.
>>    */
>>   __be32
>>   nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>> @@ -2007,10 +2015,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>>   	fh_drop_write(fhp);
>>   out_nfserr:
>>   	if (host_err == -EBUSY) {
>> -		/* name is mounted-on. There is no perfect
>> -		 * error status.
>> +		/*
>> +		 * See RFC 8881 Section 18.25.4 para 4: NFSv4 REMOVE
>> +		 * distinguishes between reg file and dir.
>>   		 */
>> -		err = nfserr_file_open;
>> +		if (type != S_IFDIR)
> 
> Should that be "if (type == S_ISREG)" instead? What if the inode is a
> named pipe or device file? I'm not sure you can ever get EBUSY with
> those, but in case you can, what's the right error in those cases?

Check out nfsd_unlink()'s callers to see what they pass as the type
parameter. Unfortunately we have to compare against S_IFDIR here.


>> +			err = nfserr_file_open;
>> +		else
>> +			err = nfserr_acces;
>>   	}
>>   out:
>>   	return err != nfs_ok ? err : nfserrno(host_err);
> 


-- 
Chuck Lever

