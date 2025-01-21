Return-Path: <linux-nfs+bounces-9431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EBEA181F4
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 17:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B331E7A0369
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5615028C;
	Tue, 21 Jan 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="diWvkLUf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mBaE5g++"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918951F238C
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476708; cv=fail; b=QTUh0QQss/skHh0Y6QErAr+3zP+3m6MEfhEP5g4F0E9Lp0LHzEYRGCBncot8J+B/x0mLYwcVDPyuvtujpJzxFlduU8BVGuxnuORwtFoNiJGMjyBfdC/6LBHlq5Muq5wi+JQBYKfKOCch5YuR5ChT61A51ecktKuTlgzEZddNf64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476708; c=relaxed/simple;
	bh=PsU/F/bbFHbxYdB/IWH/yQKzvoROyBBPPrjDP5Zbf8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xd9IRjPQtUTF6VXYLV1MRBSvCppgOFL1wxUSspgkIXcyNXFoUrY9p7X2Otz1JkI2hjvlH0M6Apoeuofjn2ydb7uzA2fzzavPwR0JD1+wjdsACefi1z+72UX+IhtZobx6Q4Q8l5M3OIl7ut5ZmDOSVIK/FKNWwRpukllsf4seG/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=diWvkLUf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mBaE5g++; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDwgM004676;
	Tue, 21 Jan 2025 16:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YcTZC3+U67A8R5K+hBdMI5LIO0CI/pDbRBG8xGp2rgc=; b=
	diWvkLUfPU/9f59Op0Kt1T0Rk0msFkthUvX9y6x4AUSDEF6CKtgcozqFD8I8I2Yd
	0G94p2I/Jqhn/MyKjnrE16tPQ6plem+ymddbADZJk8OmNY1WGk6swjsM1hCqrB54
	a6il3YAwuDjiN4RIoAXumUy9Q85BPz2sR2p1EvbGUOkQS/pTnU25afVxMkXv1x6j
	tj+SN+TyNUXYlummfzJ6LsyTM1Jzb1PNFspU3MaH5R1yhiSpBcznQLT53nGVs46h
	sqM+1wI2e7FnFEOExCSwjwU5yAAvkHji9zh6wRFbUs9ef5EnRJSzRMtIIhlIKhVt
	vIPasP4CbTLmEuz7o+VyIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485q55xb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 16:24:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFusKL030354;
	Tue, 21 Jan 2025 16:24:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fj0n3k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 16:24:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9geIhv23PQJXket/5jxWUEPejYpdEbITZmobiBKH/3gEOfquFinOZ3XaduI+/HWWLC3Zjv7Y8dQwLFhYWh1COVJRNJs1kF32WIcCd5Lf9Ankz0DrpPnFcv8YUaU3tq+diWv0crYbJFoathutmN2yulWmYD7DkveSRi+2KrHMFC9vp3yPi53AgkZv5XFcD96Jf3xQyY6hZ8m2CTWqgOmSiY7jNVEKnUyz+iIISrMTppoDOEX99muykgLCtiNJ+cAn1F+UDksre4Dyv2/Ikgn9Xax6NmJC6+UYrWfmRcWjUJySZ2AJOQ79qitcE8grApHeyN0ZdzdtU38PnEDOkzJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcTZC3+U67A8R5K+hBdMI5LIO0CI/pDbRBG8xGp2rgc=;
 b=BXKzjb7x1sD3y9SIfk/MttEYgdDs7FojAIMaOJfekvTlEsm9AH+EFOW9Z1xuBMgS6JhUCSX8/uUCPtzkpRYktJYUqevhYss/KtSEPCLICklaYIrPt60g2NXtwCKT6Cs9LeNPomFhNn0coC3lUa+fk9WC7TEuBNfDDNdfQ9d+TzqmFOxc6bE/ue0i/pFlWMz9p9wQP5Yaj0dAmFGhSNRRnRjtiOcAVm6Fi5XZb3xq0OKdxeMQBlZeaBErHZJGnLRkEAEKq2ZYwvjohV3bcuL/80KdXikupRHBWUlBOpNyil9z+4f3dJSMOPOm7O8SFahlhY+YmqX2w/USBENTH7Q7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcTZC3+U67A8R5K+hBdMI5LIO0CI/pDbRBG8xGp2rgc=;
 b=mBaE5g++o7RRlApMobm8RE1gq28DoIUC4we01ffKS8rFqnNjuZlo3er5uHgM13SzOd51ovS5UvYVuPsOosTvh45zMswrpCUh2rGH3Fsc/Uaday0rPJhCkQEvTgft3mqeWGkuPj8HMu5MjzChf6aoTxSygr5/pF8HDzgzh/zci48=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8076.namprd10.prod.outlook.com (2603:10b6:610:247::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 16:24:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 16:24:40 +0000
Message-ID: <8e0279ae-e65b-408a-ab30-7665c2714885@oracle.com>
Date: Tue, 21 Jan 2025 11:24:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <> <a961b220-75be-4ada-b548-a87f24566f92@oracle.com>
 <173742700974.22054.17564503623784796029@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173742700974.22054.17564503623784796029@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:610:50::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec7292c-54c0-42f1-336a-08dd3a381b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkVwaEZONFEzL3g1QXFxWHRPZTc4eFBMWEVxd0x2TzljeVRjWVNpRDJTUGI4?=
 =?utf-8?B?dHI2eXBGSFJlNSs5N1V0d3ROaHk5OEFmam15SVU1U3R2Ym1rTC9XNERRNUNz?=
 =?utf-8?B?bVhmNzhhSHg4VDhNdndadGh4UVUwNlozRE5LK2QzbGZSdmV0T1VVQVU1NmlL?=
 =?utf-8?B?QXZJdUFpZVFRdFk2YlAyczBlcDJLd2tIYkdzcDZ3amtpSkh4RDhPRjhzUm0w?=
 =?utf-8?B?OVhFejhsanc4VkpDVXNVNlc3ayt0d2tiTEZvVVJHcE9WYXhPREhQYm1qT2l6?=
 =?utf-8?B?VzNOMzBFc0NkZmVJbFNiSHI3YUV3UGRSdVdLdTJhQUdYRXg4SUhLRldsbjJa?=
 =?utf-8?B?R1VNZDZISkhZZVJzMWJONUE3Y01rSFlobVkrd1o3N0VQTm5aNDl3NkpxaTlk?=
 =?utf-8?B?YUV1Rjc4aVJPUmlMbW00ZDUzV1VhcUQ3MmtHWUk1alBBT3FCbXl3UG1qZ1Fl?=
 =?utf-8?B?TDI2TGxVUW8zSG1JZjFWdnR3R0dyQTNPSHRwYW81a21zNFhRSlNBRVFZaHFD?=
 =?utf-8?B?Tmt2dWtQenRlMXoxcUNaWTkzaE5XenltdnJranNoeW1NRUVDODBRd1RVRm9r?=
 =?utf-8?B?NGVPTUZBaGtqNnk0bW04L0RxRk12OUNpNWdnVmNSUHp5VGZqQm1vWlMyODRa?=
 =?utf-8?B?L3VRMktaeWZqVnpsZGhMRXZqVHdJMGsvZXNmRDEzcWRuVDBxMXFmY0FiUE4w?=
 =?utf-8?B?ZTc1ekk5bkdrcG1hWVovN0VzY21VdmRBbFhEdk5pUnVXM2hPSlFKL2s0U1ha?=
 =?utf-8?B?OTF2Vis3L24zSjRMclo1dWJhQUhaQ0RrcjZjQXh3RTBHZXhPL0cyYnRQcWF4?=
 =?utf-8?B?QWdwa09SL3VublNHKy81SU5kZ2ZIbSt3OWdBVml2WFh2ZnphZ2ZwUXIydlV2?=
 =?utf-8?B?bWl0emlqYjVISm1XNTZ6NHR1bFMwSUdXVlVISC9Ocndod2VpeG1EL3diOW9O?=
 =?utf-8?B?VWdoTVdGNkhwRlFFOTJvTkptM3FnMHIvb2RIY3UzWmRWZE83eXNHTEZyVGFt?=
 =?utf-8?B?bnhhN3B6L1c0bzQ1VEZ4SFFVZms0NWdkNjdxMlFFWFJnWXNXYlVRbUs5SWgx?=
 =?utf-8?B?NmtkSnM0VVFpNllvdHczeG9qdDV2UE9wM2tlT085SDFDOWIwSXlxT0xvdTRo?=
 =?utf-8?B?M295QXVXelFzMVMwamthNGJEQmF1NzZRRXNDaWlaMkNwRjM3dmprb0U4SVFQ?=
 =?utf-8?B?dFhvUEl4dDhjaDNpMG5QYnpCMFROUXYrbUVHZk1sbXdUY3l4bGdkaGZ5eWRl?=
 =?utf-8?B?N0RZNWhYaXIxUlQ4WlR2NUYwY1N0cVZTZEJmNTNpaXBLWmNvVzVCUndtZFpS?=
 =?utf-8?B?K1ZjbDZKUldOL3RyUmpCdTJ6cWg3elQ1WUkzeEFBMDZKSmtxWDNWbWNvT0NB?=
 =?utf-8?B?L0RrOGVkdUlOWVNWU0poOWNtWGdpZ3V0K3JmeFBjNWozS213MklMaytGZVFw?=
 =?utf-8?B?Y1BHK3dDelVCYlhCbTdzOGN1TkN5WkxGYzVjNXE5UitxS0ZtSVRTUmMwRDBX?=
 =?utf-8?B?UDRvWEJXMk1DaTFsR2FnNWx3Mk93a290azZPYnVYNURJNC84ZXZoMWFEZi9F?=
 =?utf-8?B?RDNXaWtOMW1IaGY2VVAyVU81VXVubXYvRXR0dDNvRG0yK0ZjTVpuS0JleGY0?=
 =?utf-8?B?NFJPakdKajRESmI1MWxZeUNpRnB2RDlPczhnMURhSmtoZzBCeXllRkhudzlO?=
 =?utf-8?B?REs1cFdCTTRWeFJBc3VWOEZiVUVBSitxNmlCU25hZFVCeTc1c1BWTmRveVJz?=
 =?utf-8?B?RTV6WTB4VXluVC8zSnNQRFFYMzI0U0hVZytYNnNZWDk5UlVTeVU1UnRWa1JX?=
 =?utf-8?B?VDdCdndTRWJLY0ZOMHRmTFZpRnpKNmVZeVQ2RDJ3RjVsRGdnWGpqeW5JQkdL?=
 =?utf-8?Q?czamzBRWQpgd7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2hsL3g4Q1lVcm9pUklOVS9INUpXV0VaOUhJenhqOERWZXhLblhHMDF3MHRE?=
 =?utf-8?B?M0p2U3BrMVMvRkQwVURvTjhkQ2p4NXFYVGpBWnprYkoySVJzUFFxVXozd29t?=
 =?utf-8?B?d3pqdUtZTW5oeFRFL29neDEvWUNRSUQwb0Nhb2VlbmtUdFpHanJwSFR6M2Ji?=
 =?utf-8?B?VEZlc291cWo2Tm8yTzNqdWVDZlo3bWhWalBEaWd1Z3NmeDVCOUtIZytvWGg3?=
 =?utf-8?B?YU4vRjRXV1FlWlJLbTBIWGhQQlZIREwycXJRemRlT0t0VWlMQm9IVld4RGFa?=
 =?utf-8?B?NG05YnkrTWx0aGlPd1AxczdKdDhyYTRxOXlXanc2OEt5eW5VVmZXUHpZakZH?=
 =?utf-8?B?clBVMW5IeWxQTWF0cVpRcExNTFNPYTRlMlcrekVuelNLWDRUcmNQdDUyWm5C?=
 =?utf-8?B?L1EyWHdhNXlnRFlUV3VXVFJWZUt2NkUzeHg2TFlndFlmNEtkVUdxd2F2REts?=
 =?utf-8?B?ZktMU215ZGl2MEgyYUgrdlZ5VURGclhZNFJ6WXIvelRlVmFvVDlHWW9lZGlD?=
 =?utf-8?B?WTlvUFczMzY0cWFlbEVyMEd4d3NkeC84bXpPbSt2cUJwUTRCSVlNeHZDVzNB?=
 =?utf-8?B?VmJFS0d1SWY4VjByOFZHUWlNRDBidVZKaG5JVEJLZVorakk3cnlYQ1RxeHZI?=
 =?utf-8?B?SWJPMzE5ZGFkeTh6NjVCT1U1ZVNwQ1NPbDV5RkJBQWt0endKRmRmS3d5OEZG?=
 =?utf-8?B?ZHMyWGRGZTJCSXJGZ3pEbTducmVsa2kxaHh5NGUvRStxUVBaWHVxYlY1dU40?=
 =?utf-8?B?UTFNY2FoN2pWV0ZsaVR6REswVmZzUmFDZG40Y3VVVWdSbDNrUm82QjBCQk5V?=
 =?utf-8?B?K0RkWkNLdjZoUFc1LzFGbU85NEpobEdIMHZ6U2F4eTVvb2tXYXVtZ25QMEJN?=
 =?utf-8?B?NkgxQUYyVTkrT2dId3B4QVR6N0gwcUk1cDEwQ1VTeFlBZDdvUXF5RlVaNzJF?=
 =?utf-8?B?bjlSem5CYXFlZzFHbFdXeHhUU2tJZExIckg0WEFSR3ZEVEpDaFpETkIzSXVH?=
 =?utf-8?B?R1Nvazg3Qk0ybjZFL3JWS1IzN0Z3UzRhRG9KNUNkU2xsY3FuUnBiUGlicGxB?=
 =?utf-8?B?R2tpM01oUWZYWDJkL2RSTHlVWmNCem9TVTlqYlZSb3o2SFVmQjd4WW9rUExP?=
 =?utf-8?B?Uzl6S09mcmtZT2crb1FGYUd3Ky9QU1ViSUFCK0pJSU1mWFYyTEF0bENxeW9H?=
 =?utf-8?B?TE0vWkZxd2dSSVQ0cUI4TC9NMVpLa2IxQVpQKzZBYnBzWWIvcEk4ZUo4Y0t3?=
 =?utf-8?B?RTNDQnBjcldyU0hxaWVsYTVOeE1VdnhVQlNRWnhzcFJLMEVyNjNzZm1sVXJJ?=
 =?utf-8?B?RUVqTi94MnFBWmd5aXI2NTRBKzRLVkMxbWZlaEFOajVXNWdES2h1c2VZRExK?=
 =?utf-8?B?bEVRQzhPTlQyeEQxMDRwU3ZjTytCdFRFbWVTWXZ4cXo1MjY4cnNZa3dEZVdo?=
 =?utf-8?B?Zzk2b1BQM0p5dWNlQVJLWVdCdXhIcXlJT0xJckhIamNteHhpeFFOTkRFR295?=
 =?utf-8?B?TWhJMEVoeVkzVERlcXFIQ1ZTaDIzNlg3Z2Y1RVFOL0xjcWtoeVoxNWYyUjVX?=
 =?utf-8?B?NkNGbEc2NGJsQUQzUHBqQzdsZEFQNWRxZm8xUXBYQ25sMnlBWDd4S3VXcWUw?=
 =?utf-8?B?WEplQzZTbU04MlhTaXZQekJCUmpkR0lLTGFIR1h0SXdhdDV0bUJ3TGtIbHV0?=
 =?utf-8?B?ejAvazhkSFlLcXpXdkl2UXNlUXBHTFJWcTJ2SjRyaG53NkhkWWxOT1g4dThO?=
 =?utf-8?B?ZUc2cm43R1RMSmoyYmR2RHVEV0t6Q1NMMDROcjc3cUZyN1pjbkNyT1ZaT2lD?=
 =?utf-8?B?Tmh4bUxrN3RoZVhBbHBybVBoa01XM1gzY0ZGYzNkdE43dEF3NlgyN2laRjBZ?=
 =?utf-8?B?RTRMOENzcGRFZUI4c0ZiSGx5RGhuaXo2OGsyeU1SS1JPc2N6L2ZFUVBETDdT?=
 =?utf-8?B?WGpoaytOTFRSNUI0K01PREdYRFp4YTY1SzE1NEF4K2FvbExWK0FsVnhsSDVv?=
 =?utf-8?B?OVN6UmdIcjFKTmkvekpRMlpQbVJ1YW9uYm8wS3ZaaTdrdGYxdG1sYXBMZnI0?=
 =?utf-8?B?UEJmM2UwMm5YY1duSkptS21qMWM1d0FvOGJ3ZnBra01mRzJ0ZmtLR1dHQUhh?=
 =?utf-8?B?c3RSYXMwKzMwN3Nrd1NId3B4cGJCZW5EdXNkYzd4NkZRNjJqMGpjbUNrbnhX?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cnwH7sxCW2AwGVNKtZOftjpFpFKGn3LqnJz+/Hz5Ym0SWj8HBcz3wE9uxq+OYp0Jj9IVn+bvkJou2omXtMRR6y+40zzvQbqnDJvb1t3DdNMt33xfg/VFUItsFtZj85p+I4vHP4H7I4i4O51UReuUHnynSUyEO1krEYrtpDgN//rc4Jf4DMW2DFLpextRg15YlM3xeDv3UIxW7VmMrT3xW5p+vRq1Da9egIpR+46h4FzfC+xbSlcOlMljid6R6eP8Pp53uYero/nFYL4/5xd34AfQdHiarYlyAeUdqlAICBMSYfG8ehL1mrcDlDcpH2K+sCZW3/CMHWbTeP97kzCLzKWPc++qkaFuQjh1pO9LY7yNCfzBFmlbLxElb/TvAVIWNpPtfPKPXbjwhXLu0htjk5ahtnmGIsrpPAxHwBxaCPgjoVjoMmhQn4kudD3jQeoFwHplSUQeuXHp5eK27z4tCzwZGZIRw+G8NZhS9CsMevr5ltHAwcWuI9OB5iW0nClAZDNkOn/SC+yPeH/8dlU5nLXVX/BfwaRv2oJ3zMKrv28boQJ4QiqqNcPFxTnOESH6qpXALUKB85aVDdPPaiv7gxos363qr+0tIyb6XlpV9+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec7292c-54c0-42f1-336a-08dd3a381b16
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 16:24:40.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDJnCFiN6MX1BXeqfV5Fc8vuqAM42dR8X6oHQbVlKZuPjhEgh/Q3kCDF/Qyc4qOa0llVjfMoGoYOGF3j/UaBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210133
X-Proofpoint-GUID: iabM2FCNS3uaDRM-lDI3EGsO3cyWT5ly
X-Proofpoint-ORIG-GUID: iabM2FCNS3uaDRM-lDI3EGsO3cyWT5ly

On 1/20/25 9:36 PM, NeilBrown wrote:
> On Sun, 19 Jan 2025, Chuck Lever wrote:
>> On 12/11/24 4:47 PM, NeilBrown wrote:
>>> Reducing the number of slots in the session slot table requires
>>> confirmation from the client.  This patch adds reduce_session_slots()
>>> which starts the process of getting confirmation, but never calls it.
>>> That will come in a later patch.
>>>
>>> Before we can free a slot we need to confirm that the client won't try
>>> to use it again.  This involves returning a lower cr_maxrequests in a
>>> SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
>>> is not larger than we limit we are trying to impose.  So for each slot
>>> we need to remember that we have sent a reduced cr_maxrequests.
>>>
>>> To achieve this we introduce a concept of request "generations".  Each
>>> time we decide to reduce cr_maxrequests we increment the generation
>>> number, and record this when we return the lower cr_maxrequests to the
>>> client.  When a slot with the current generation reports a low
>>> ca_maxrequests, we commit to that level and free extra slots.
>>>
>>> We use an 16 bit generation number (64 seems wasteful) and if it cycles
>>> we iterate all slots and reset the generation number to avoid false matches.
>>>
>>> When we free a slot we store the seqid in the slot pointer so that it can
>>> be restored when we reactivate the slot.  The RFC can be read as
>>> suggesting that the slot number could restart from one after a slot is
>>> retired and reactivated, but also suggests that retiring slots is not
>>> required.  So when we reactive a slot we accept with the next seqid in
>>> sequence, or 1.
>>>
>>> When decoding sa_highest_slotid into maxslots we need to add 1 - this
>>> matches how it is encoded for the reply.
>>>
>>> se_dead is moved in struct nfsd4_session to remove a hole.
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>    fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++-----
>>>    fs/nfsd/nfs4xdr.c   |  5 ++-
>>>    fs/nfsd/state.h     |  6 ++-
>>>    fs/nfsd/xdr4.h      |  2 -
>>>    4 files changed, 92 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index fd9473d487f3..a2d1f97b8a0e 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1910,17 +1910,69 @@ gen_sessionid(struct nfsd4_session *ses)
>>>    #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
>>>    
>>>    static void
>>> -free_session_slots(struct nfsd4_session *ses)
>>> +free_session_slots(struct nfsd4_session *ses, int from)
>>>    {
>>>    	int i;
>>>    
>>> -	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
>>> +	if (from >= ses->se_fchannel.maxreqs)
>>> +		return;
>>> +
>>> +	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
>>>    		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
>>>    
>>> -		xa_erase(&ses->se_slots, i);
>>> +		/*
>>> +		 * Save the seqid in case we reactivate this slot.
>>> +		 * This will never require a memory allocation so GFP
>>> +		 * flag is irrelevant
>>> +		 */
>>> +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
>>>    		free_svc_cred(&slot->sl_cred);
>>>    		kfree(slot);
>>>    	}
>>> +	ses->se_fchannel.maxreqs = from;
>>> +	if (ses->se_target_maxslots > from)
>>> +		ses->se_target_maxslots = from;
>>> +}
>>> +
>>> +/**
>>> + * reduce_session_slots - reduce the target max-slots of a session if possible
>>> + * @ses:  The session to affect
>>> + * @dec:  how much to decrease the target by
>>> + *
>>> + * This interface can be used by a shrinker to reduce the target max-slots
>>> + * for a session so that some slots can eventually be freed.
>>> + * It uses spin_trylock() as it may be called in a context where another
>>> + * spinlock is held that has a dependency on client_lock.  As shrinkers are
>>> + * best-effort, skiping a session is client_lock is already held has no
>>> + * great coast
>>> + *
>>> + * Return value:
>>> + *   The number of slots that the target was reduced by.
>>> + */
>>> +static int __maybe_unused
>>> +reduce_session_slots(struct nfsd4_session *ses, int dec)
>>> +{
>>> +	struct nfsd_net *nn = net_generic(ses->se_client->net,
>>> +					  nfsd_net_id);
>>> +	int ret = 0;
>>> +
>>> +	if (ses->se_target_maxslots <= 1)
>>> +		return ret;
>>> +	if (!spin_trylock(&nn->client_lock))
>>> +		return ret;
>>> +	ret = min(dec, ses->se_target_maxslots-1);
>>> +	ses->se_target_maxslots -= ret;
>>> +	ses->se_slot_gen += 1;
>>> +	if (ses->se_slot_gen == 0) {
>>> +		int i;
>>> +		ses->se_slot_gen = 1;
>>> +		for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
>>> +			struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
>>> +			slot->sl_generation = 0;
>>> +		}
>>> +	}
>>> +	spin_unlock(&nn->client_lock);
>>> +	return ret;
>>>    }
>>>    
>>>    /*
>>> @@ -1968,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>>>    	}
>>>    	fattrs->maxreqs = i;
>>>    	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>>> +	new->se_target_maxslots = i;
>>>    	new->se_cb_slot_avail = ~0U;
>>>    	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
>>>    				      NFSD_BC_SLOT_TABLE_SIZE - 1);
>>> @@ -2081,7 +2134,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
>>>    
>>>    static void __free_session(struct nfsd4_session *ses)
>>>    {
>>> -	free_session_slots(ses);
>>> +	free_session_slots(ses, 0);
>>>    	xa_destroy(&ses->se_slots);
>>>    	kfree(ses);
>>>    }
>>> @@ -2684,6 +2737,9 @@ static int client_info_show(struct seq_file *m, void *v)
>>>    	seq_printf(m, "session slots:");
>>>    	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
>>>    		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
>>> +	seq_printf(m, "\nsession target slots:");
>>> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
>>> +		seq_printf(m, " %u", ses->se_target_maxslots);
>>>    	spin_unlock(&clp->cl_lock);
>>>    	seq_puts(m, "\n");
>>>    
>>> @@ -3674,10 +3730,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
>>>    	kfree(exid->server_impl_name);
>>>    }
>>>    
>>> -static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
>>> +static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
>>>    {
>>>    	/* The slot is in use, and no response has been sent. */
>>> -	if (slot_inuse) {
>>> +	if (flags & NFSD4_SLOT_INUSE) {
>>>    		if (seqid == slot_seqid)
>>>    			return nfserr_jukebox;
>>>    		else
>>> @@ -3686,6 +3742,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
>>>    	/* Note unsigned 32-bit arithmetic handles wraparound: */
>>>    	if (likely(seqid == slot_seqid + 1))
>>>    		return nfs_ok;
>>> +	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
>>> +		return nfs_ok;
>>>    	if (seqid == slot_seqid)
>>>    		return nfserr_replay_cache;
>>>    	return nfserr_seq_misordered;
>>> @@ -4236,8 +4294,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>>>    
>>>    	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>>> -	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
>>> -					slot->sl_flags & NFSD4_SLOT_INUSE);
>>> +	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>>>    	if (status == nfserr_replay_cache) {
>>>    		status = nfserr_seq_misordered;
>>>    		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
>>> @@ -4262,6 +4319,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	if (status)
>>>    		goto out_put_session;
>>>    
>>> +	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
>>> +	    slot->sl_generation == session->se_slot_gen &&
>>> +	    seq->maxslots <= session->se_target_maxslots)
>>> +		/* Client acknowledged our reduce maxreqs */
>>> +		free_session_slots(session, session->se_target_maxslots);
>>> +
>>>    	buflen = (seq->cachethis) ?
>>>    			session->se_fchannel.maxresp_cached :
>>>    			session->se_fchannel.maxresp_sz;
>>> @@ -4272,9 +4335,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	svc_reserve(rqstp, buflen);
>>>    
>>>    	status = nfs_ok;
>>> -	/* Success! bump slot seqid */
>>> +	/* Success! accept new slot seqid */
>>>    	slot->sl_seqid = seq->seqid;
>>> +	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
>>>    	slot->sl_flags |= NFSD4_SLOT_INUSE;
>>> +	slot->sl_generation = session->se_slot_gen;
>>>    	if (seq->cachethis)
>>>    		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
>>>    	else
>>> @@ -4291,9 +4356,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	 * the client might use.
>>>    	 */
>>>    	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
>>> +	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
>>>    	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
>>>    		int s = session->se_fchannel.maxreqs;
>>>    		int cnt = DIV_ROUND_UP(s, 5);
>>> +		void *prev_slot;
>>>    
>>>    		do {
>>>    			/*
>>> @@ -4303,18 +4370,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    			 */
>>>    			slot = kzalloc(slot_bytes(&session->se_fchannel),
>>>    				       GFP_NOWAIT);
>>> +			prev_slot = xa_load(&session->se_slots, s);
>>> +			if (xa_is_value(prev_slot) && slot) {
>>> +				slot->sl_seqid = xa_to_value(prev_slot);
>>> +				slot->sl_flags |= NFSD4_SLOT_REUSED;
>>> +			}
>>>    			if (slot &&
>>>    			    !xa_is_err(xa_store(&session->se_slots, s, slot,
>>>    						GFP_NOWAIT))) {
>>>    				s += 1;
>>>    				session->se_fchannel.maxreqs = s;
>>> +				session->se_target_maxslots = s;
>>>    			} else {
>>>    				kfree(slot);
>>>    				slot = NULL;
>>>    			}
>>>    		} while (slot && --cnt > 0);
>>>    	}
>>> -	seq->maxslots = session->se_fchannel.maxreqs;
>>> +	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
>>> +	seq->target_maxslots = session->se_target_maxslots;
>>>    
>>>    out:
>>>    	switch (clp->cl_cb_state) {
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 53fac037611c..4dcb03cd9292 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
>>>    		return nfserr_bad_xdr;
>>>    	seq->seqid = be32_to_cpup(p++);
>>>    	seq->slotid = be32_to_cpup(p++);
>>> -	seq->maxslots = be32_to_cpup(p++);
>>> +	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
>>> +	seq->maxslots = be32_to_cpup(p++) + 1;
>>>    	seq->cachethis = be32_to_cpup(p);
>>>    
>>>    	seq->status_flags = 0;
>>> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>    	if (nfserr != nfs_ok)
>>>    		return nfserr;
>>>    	/* sr_target_highest_slotid */
>>> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
>>> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>>>    	if (nfserr != nfs_ok)
>>>    		return nfserr;
>>>    	/* sr_status_flags */
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index aad547d3ad8b..4251ff3c5ad1 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -245,10 +245,12 @@ struct nfsd4_slot {
>>>    	struct svc_cred sl_cred;
>>>    	u32	sl_datalen;
>>>    	u16	sl_opcnt;
>>> +	u16	sl_generation;
>>>    #define NFSD4_SLOT_INUSE	(1 << 0)
>>>    #define NFSD4_SLOT_CACHETHIS	(1 << 1)
>>>    #define NFSD4_SLOT_INITIALIZED	(1 << 2)
>>>    #define NFSD4_SLOT_CACHED	(1 << 3)
>>> +#define NFSD4_SLOT_REUSED	(1 << 4)
>>>    	u8	sl_flags;
>>>    	char	sl_data[];
>>>    };
>>> @@ -321,7 +323,6 @@ struct nfsd4_session {
>>>    	u32			se_cb_slot_avail; /* bitmap of available slots */
>>>    	u32			se_cb_highest_slot;	/* highest slot client wants */
>>>    	u32			se_cb_prog;
>>> -	bool			se_dead;
>>>    	struct list_head	se_hash;	/* hash by sessionid */
>>>    	struct list_head	se_perclnt;
>>>    	struct nfs4_client	*se_client;
>>> @@ -331,6 +332,9 @@ struct nfsd4_session {
>>>    	struct list_head	se_conns;
>>>    	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
>>>    	struct xarray		se_slots;	/* forward channel slots */
>>> +	u16			se_slot_gen;
>>> +	bool			se_dead;
>>> +	u32			se_target_maxslots;
>>>    };
>>>    
>>>    /* formatted contents of nfs4_sessionid */
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index 382cc1389396..c26ba86dbdfd 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -576,9 +576,7 @@ struct nfsd4_sequence {
>>>    	u32			slotid;			/* request/response */
>>>    	u32			maxslots;		/* request/response */
>>>    	u32			cachethis;		/* request */
>>> -#if 0
>>>    	u32			target_maxslots;	/* response */
>>> -#endif /* not yet */
>>>    	u32			status_flags;		/* response */
>>>    };
>>>    
>>
>> Hi Neil -
>>
>> I've found some misbehavior which I've bisected to this commit.
>>
>> If disconnect injection is set up to break the connection every 25,000
>> RPCs or so, xfstests running on an NFSv4.1 mount will eventually stall
>> after this commit is applied.
>>
>> Network capture shows that the server eventually starts returning
>> SEQ_MISORDERED because the client has forgotten an retired slot after a
>> disconnect, and tries to use sequence number 1 for that slot with a new
>> operation.
>>
>> I've narrowed the issue down to nfs41_is_outlier_target_slotid() on the
>> client. This function uses a bit of calculus to decide when to bump the
>> slot table's generation number. In the failing case, it never bumps the
>> generation, and that results in the client freeing slots it shouldn't.
>> The server's reported { highest, target_highest } slot numbers don't
>> appear to change correctly after the client has reconnected.
>>
>> If I revert this hunk from 5/6:
>>
>> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres
>> *resp, __be32 nfserr,
>>    	if (nfserr != nfs_ok)
>>    		return nfserr;
>>    	/* sr_target_highest_slotid */
>> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
>> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>>    	if (nfserr != nfs_ok)
>>    		return nfserr;
>>    	/* sr_status_flags */
>>
>> the reproducer above runs to completion in the expected amount of time.
>>
>>
>> The high order bit here is whether I should drop these patches for
>> v6.14, or whether you believe you can come up with a narrow solution
>> during the early part of v6.14-rc that I can include in an -rc update
>> for NFSD. I can't really tell if a significant amount of surgery will
>> be necessary.
>>
>> What do you think?
> 
> I think I can fix it.
> 
> It sounds like it might be a client bug, or it might be a difference in
> interpretation of the spec, or it might be an ambiguity in the spec.

Perhaps, but consider that the Linux NFS client interoperates
successfully with v6.13 NFSD, Solaris's NFSv4.1 implementation,
NetApp's implementation, and Hammerspace, and has done for many
years.

I agree that the spec language isn't particularly transparent, but
somehow all of these implementations have interpreted it the same
way.


> But I think I can fix it by setting NFSD_SLOT_REUSED in any slots
> beyond ->target_maxslots when I reduce target_maxslots.  That makes it
> so that we accept either 1 or the next-in-sequence seqid.
> Doing that does open up a possible risk of a resend being accepted as a
> new request.  As it is a new connection, resends are a real possibility.
> I'll have to ponder that a bit more and might need to be careful about
> retiring slots with a low seqid which have been used recently.  Maybe I
> need to store the time when seqid 1 was used, and not return a slot
> until some minimum time after that timestamp.

I gathered additional information using a trace_printk() in the client's
decode_sequence() function.

In the working case, after reconnect, the server SEQUENCE response has

   sr_highest_slotid = 18
   sr_target_highest_slot = 18

IIUC 18 is the slot number of the highest slot currently in use.

In the stalling case, after reconnect, the server SEQUENCE response has

   sr_highest_slotid = 23
   sr_target_highest_slot = 63

The client heuristics decide to free slots 23 and higher, even though
one or more of those slots have been active and have sequence numbers
larger than 1.

I can provide more detailed reproducer instructions if you wish.


> I'll try to get you a patch before the end of next week.

Thanks!


-- 
Chuck Lever

