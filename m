Return-Path: <linux-nfs+bounces-15727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F324C15EB5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436DF188AFD5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C634676A;
	Tue, 28 Oct 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="WjRLix7o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021076.outbound.protection.outlook.com [52.101.52.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CE340DA0
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669725; cv=fail; b=pWkT1/1PhqcCOzFp5rBBohJ4zmpG57l8S+u8Yw4Omv8BpbN6MSJvzsAvFmjKrVI83CzRSARChG1BFQhmFe6CYmbDnPCcbpKpfQvWdms+d35cEEgrcyu6ZMziFbiKIvRoiGVSXM8Lx/t72GebEvbycBLnAl/3804FHX/etusgexM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669725; c=relaxed/simple;
	bh=2/XgnOOVYT/hmYe6JVQtm/jk0hpOBNIoU2D8pk26sW8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z1OOVc0yZZjsurBHuv4R/ZMtNURtmk2RxXaMKURHn3EHQ6tNwH/19hZNCnWswAnAxomV7o1lAzOEA0jmbElFgtjCzvpRZzPGlI6WTYOci1OCkFy0V4tLAsuQU9aikGyt6Uw9/tBq2SjFJRj7YGJSNMizFpVEaOpiArUOb5Zz/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=WjRLix7o; arc=fail smtp.client-ip=52.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiLIyfm4PKwbpwpc+4k2znacffCJrVg1T350TfftUpeLAS5eiZJNGoszeGUOrG0R+teofpaNVfjvQaILun6welLnrWe8/o1jx85ELkfygLUQaojfdO104V0YIZSD762/Atvz0OTNgW0gd3h51CFlovjP+eDuP2BYkQQKwebuWzjVCISj+E4A2457xiCBkktfwyesRfvqyos7x9dJs8R7E/SKc0XH/rcWKJhV+KvfweFRUKsboczASImuCUtuKAD0AI4037mtc47vxfuhzdbweGJYybMcfey6EPpF04Zby6OTt7rIDB9y4VxcI3yz1j+rDEuVtoly/5LkZ5KgVRgaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/XgnOOVYT/hmYe6JVQtm/jk0hpOBNIoU2D8pk26sW8=;
 b=IoLEV+FG+MLbtDLxpf6znTO7cBDhI6nVupSLH01Lwbblv9w2bC1uAkZCTuLhM7CT7Uv1sUrnbPnO7fq3GiVuVNjDDxB00/EpTOgN0rSxQGxYisutjZJWxkvGRO4LTeaMgrHoR0p3ssK3epwsa+snamrkQ5Sh0PYsL+l2x4biyINoY5UZc9UmW+1aNPQPT0Fef7dMJgn57P9wL4LvO+QyYZfUyG323MjxVFPAXoxNcW5n12uyNXQt4oahoM8QARRMjyy4IL8FGngP7xNYJUMxsafgWEwrMzqqrlSyY+wEX7+YH5GVJ5ClPTlYZ8Rl80rmtg3OVdQTnpwlijDzJfGlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/XgnOOVYT/hmYe6JVQtm/jk0hpOBNIoU2D8pk26sW8=;
 b=WjRLix7oQAfJaP2/+215/iF1jZcBY/1DvXSJxT+16kKUGQLpJdXZ6UWK6KpFAh9n18eiJn686kreoaxU5hqpMuKu5SJese4g44ViVCYzW6D2vIso68o4UPoZ77CRGYwwRW1sVXKzzqayZLgCBa9xTn1Pk4yO+uMFcaguLayexnUq+ZMQ/9na0tC2dJHy94gBu4Yr06r6mbJCPACB2pYyjZ/KWCKGlWHWA3HlMpQOHEvqvedYblx4O3ZRbhy0/BW0okMUzU9JuaPD9wfPCMe2GlYfDSz+g7R7VFrKFKxtBGpVcK48JgOy7gPs9yF57LBP0R4AuVpLw7weo1dFZMw0NA==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by BY5PR14MB3863.namprd14.prod.outlook.com (2603:10b6:a03:1d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 16:41:59 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:41:59 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFS client gets confused by two servers with the same serverid
Thread-Topic: NFS client gets confused by two servers with the same serverid
Thread-Index: AQHcSCnHfZ7YReWl9025ckgq3T0B7A==
Date: Tue, 28 Oct 2025 16:41:59 +0000
Message-ID: <fa676411-e4a9-4c1e-b2a5-3f19828c76cf@cs.rutgers.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|BY5PR14MB3863:EE_
x-ms-office365-filtering-correlation-id: 7f701a00-509e-480f-47bb-08de1640ea1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFFVTFBkK2tweFBYaFc0WVZDMThGRVJ0NThQb2ZOaG1YbXY5ZmhrU0JRd1Vs?=
 =?utf-8?B?V2xGQlhsWjlHaGZBOUZmNzZKbTBjSk5vOU9oaFFrS292R3RocVI4NmJZajdB?=
 =?utf-8?B?OEQvdDZZdnlmaVJzTk9iS1VsZnNaNlpSYm9SY2RjNUpiOHZDNm5rSzUwMTZE?=
 =?utf-8?B?cGxtNkZUN2lwd09FZGxXczhzd3VYMHFLaE51M0l0YWZZS3gyd21wTlRCa3li?=
 =?utf-8?B?amVnaG9odmhYdDd2aVUzVXR0VHViTHUzRkx3Q0FUTzNIdTJkc3QvV3M3Tk9S?=
 =?utf-8?B?UE9BdTg0S0R5R2lweGNhNU43MFhreVE4TWJmcTE4SW5VVXFGcm11UXVITENi?=
 =?utf-8?B?SWpxWnUyQ0htRm1FR2F6UkhwMDRkZ0lCajZWeVFKUDBnUU0yV1k3NWhiWUdV?=
 =?utf-8?B?SzlBRTY3cmNPRjJjZ20wcnplSGJsVmlrZ3NQbC9JSUowODJPMGJ1SkJmNjJC?=
 =?utf-8?B?RkZENm9aL1U5dG5GN3lPT2p1Ly9YOW1MRlhuOXhUejlMV1ZISS9Gd204dVJy?=
 =?utf-8?B?YytBM1QzRGdBU2F1K2FlUGxUQ25EL2ZDS3Vubjk4SWkwRGIzcDdnekp0dCtk?=
 =?utf-8?B?Q2FtR2w3ejJ4S21YeE1VYnpydnU2ejRPMEZUY2p4NHg0QWlEVGRwY3pJQU9x?=
 =?utf-8?B?Rkh3UW5sYkQyMmJqK0hHSlRxKzhiaW1JaUIxaTljWFRVcVdVYWFBRit5dHp1?=
 =?utf-8?B?aWhRYkZ1ajI1YlBlL0J6UWl1Q1M4a0V6b3lTRzdpbnc5aG54RFpnakZ5V2ht?=
 =?utf-8?B?dDJjQmFCb3hzVjIxTWM2Y29ncjNLeFIzNThybTkrbUZad3I5dXI1ZmZOdVBr?=
 =?utf-8?B?STlpMG9CRlZZUGVhUk9jTFZTbXVJUGFHWGExN1l0ekZZczdFYkJ1SUJPMmxU?=
 =?utf-8?B?M1hTdklVMGd4WWZBOWloQVhXSTZXWVhpMXYwVmVPeTVoeCt0VnN1emtod2U2?=
 =?utf-8?B?QyswSXRTU3lMQXJlbC9FdFJLVktiZ3lyK0FvQXB4Y2lmSGgxVHpXR3ArMFAx?=
 =?utf-8?B?M2R1eVk5S1dzSkZmakpDaFNRcmU5N1RFUFhiUmRGKzkzU0k3bFhDUDBsWkhu?=
 =?utf-8?B?Mjhnd2VmcCtLMHN4b0w4Z2hzVlh0RGxLVGJaVldjSGVrcFRTamxRT29SeEZB?=
 =?utf-8?B?S0xxMHo5UStQODEzck5RQ2xKQzFZaFNhTFBaeXd4blRMRjZMV25ob1lKaTRo?=
 =?utf-8?B?Q3dnYUhqVVFFc0lqRVd6bEQvMzNQVXZMbGRKYTg1eFBMVjJpbm5SOVkxUnpa?=
 =?utf-8?B?ZzRuODhuOTFQc2dOV1o5eEZGcldlTkdPcnFzTXpiRUhDSVpuMVdycXFqR2Vk?=
 =?utf-8?B?TFBPelFVcVU4cnZSVnNMc3NtT01rQnQ1Y3hQV3d5OVdVZTdodXUyd3NJaEc4?=
 =?utf-8?B?NEEvVHhZNDV1SSt1cWpHemJhN2NONzcxU0dwOXFWRWQxKzdvVmZlMWcrSzZt?=
 =?utf-8?B?aGZTZlJ5cTBFSmh2WnZ2ckVEa0kveElqbloxdHM0Vk9xc2pXdDE4U21FNHdJ?=
 =?utf-8?B?UTN3Y1FqdjVtc2NKQllkYU9NZVB1T21xT0tBQ1NmUDRlTHpJNHkzcGx1Y0di?=
 =?utf-8?B?SVFzbUtuL3UrY2R3UnRLNngxRk9ocnFVSU1IMml5bi9qZWdZTTRWMkJIaGFk?=
 =?utf-8?B?WFg4bXlGcmxRQ0ZJcmIzTkZ2NzdzN1RFajZTbXNLS1V5QkRnOHQvV3lJS0U4?=
 =?utf-8?B?ck80a0pPV2hJSGhtTWFycHMzUkE2R09IRHRNY0ZORjlmYVRvVENGNU9aTEVF?=
 =?utf-8?B?SFZLTXYxRHpOOEdBQ3RHZUJ1Ty9ETVh1Zis4WXppeXlKYyt2Z3pLcStMNVRD?=
 =?utf-8?B?UnVVMlBSVUJ3WDFxUmorY0RQcjlSTERKa1NaSWhEUkUvcGcydFgvRjRGSFRH?=
 =?utf-8?B?RDY5eUtPeXhBejRocTk5SUpXb3NDSTArdGg5ZHZCQTRoRHZjdXdxd1M2S0RC?=
 =?utf-8?B?Zi9YajkwNVpLK1RrMnVmczRVejVwTDlnZzk5YThLRk5CcVc1dnlRdzBPRlJx?=
 =?utf-8?B?WkY4R1hiZ3RWYkh2Q1FHckgvMytRYkpBVm1EMjlaUGt4QnR0Qm5BYkF4ZFBh?=
 =?utf-8?Q?55dIOy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ykd0UERGVnhlSmwyKzN4UzhaaEJzMjN5THljRFcyMzh4ZVZSTG9qZllYZmVG?=
 =?utf-8?B?TTlYYklTdUN1SzhpOHFXbjFJMmJGdStNWlBxNWxhKzhkV1RMdy90SXNHVXZp?=
 =?utf-8?B?ZmM3L0RpWGdNQ0FobnpDTzFaUm9qdUx3RkhIejVmb05NL2IrbmFOWGtHNXFs?=
 =?utf-8?B?QVByZ3NXOUt4ZFEwWVlNVkRVNUhqR3VHbE4xK0FLZDl0S0pjMmdvTXJpdnh3?=
 =?utf-8?B?ZXFicVlyaEVqLzhBRUg3bzdLOE1BUng1aWpBcndveTdZSEJuajdpbTMxN0lq?=
 =?utf-8?B?VkY0WG5rSzdydUdrc0JpeW93VXhVSHB0dWMxdmpOUHM1MXQwYmUwbkNEVEdo?=
 =?utf-8?B?a3FCVlRHVjNwK2x2TlVsbW55U3gxRDAyWm16YWVxb2M0azBZY1orRGdvNFVX?=
 =?utf-8?B?eVNIc0pucVc0dSs2WU9UYVdCK1gzSkkvSmlmQjdnR0FHaEtWaWtvTEEyYVM1?=
 =?utf-8?B?UnhiZjJQTjdId2VGMmxTRDZCK1ZOTnFOZStjdXlpTkhkS3NUcXJjY1pmNFhI?=
 =?utf-8?B?Mmd3VUo3NmsyV1J5SW1VVFhkSUQ1RmoyKy82ek9mQjZtWjdPa3hldXQ5RjN5?=
 =?utf-8?B?b09YR0tGTGFRdlpNYnJsVVBIcmg4Wi9uWkJxNHZRRUNtSU5oSHAyTDZxNERl?=
 =?utf-8?B?WUtBenEvVUtYT1NQdy9DYXloQkZKK285SEJyNjlEb3NkZXFOemg4VmFwV1pU?=
 =?utf-8?B?SytyU3BYRnZpVlllQ3BLTWRhQXA2VVZkZjdOWi9acDNpYWo1aDM3SXF2eGps?=
 =?utf-8?B?NXNZUno4cGlwTm9iTCsxck1Gd0tUeVluZWhnc3dHZUsyamUxdzQ0clJjTGxK?=
 =?utf-8?B?YWhYaW1Td0J5MDdFSkFlSWROZE9vZmV4WEVaTGVZQW5jRkl5NkxqeUU3Y05F?=
 =?utf-8?B?Q1pMNG5KbGV4cS82VlZubTNsL1c2S1o0VGJOMUlQR0FJMEROejhCQVNRdW1P?=
 =?utf-8?B?dC9MbWs1aU5lWFc1RnFqYnVmRUpwWEpya0x3MFRDa3ByZ1JjRzBNczBGNkFN?=
 =?utf-8?B?aFFZU3IwN25UUjkwbHZvU0xRNCt6VlBZVHRKYkRNRjlneXBFSmc3WVF0eVdR?=
 =?utf-8?B?OTJYaGd4Znpscnc0ZCt1ZURTanJQTnpDcXI1dkQ0TWZVNHUvWU9GNllabHkr?=
 =?utf-8?B?eXhlNjRuVFBYaDh1Tkc5VEk1N2ZXNm1kd0NRcWlIdTh5VzcyWTA5czNtYnZR?=
 =?utf-8?B?MThJNDNiQVpRckZhU25JMDlidlYzZFRNeGJhMjl2Vldpa21HVW43TUxHRXFD?=
 =?utf-8?B?MHB5UUpxK2ZDZHhMSGIrUXFCNDVlUGxIOUNXWElKRWVKeEs2V2JhL3pZdXVQ?=
 =?utf-8?B?Y2NrS1Iza09pSVRuYjF6a3dHYnYyMlVGYkxIS1NJbWJNSnhjdXRUOFExTnJB?=
 =?utf-8?B?NjhyZUJqSC9jbzE5clAvSDdYaUw2YUNOa25vYnB4ZmR6dVZCTkFUbGVscEJW?=
 =?utf-8?B?QmZDTi9lTzE4ZFIyZE01QmJNRWVCcjhVbTFtamg5Zm5mVTdPTE9EeU92b1Fo?=
 =?utf-8?B?UFVYQWVia3pGUldoclNOMnlSRXZkNFNkejhZYXBpeTE3RG44WUcvRCswQ1pZ?=
 =?utf-8?B?NHhQMkF2TXhkRTI0SFRjQUpEekFuN0xsUXpqK2NUcTZCanBRZjBBMTFWSjdl?=
 =?utf-8?B?R1JnNERKSmd5YlpKTjNHWHVFejB4TFdVVDNrNkgvRjdnNWRyZHcxRzhxb1B5?=
 =?utf-8?B?TFpDMFRYRlJKa0V3d3JRb2VFSEVHQmxhNFZPdWRDR2IvVndxNGpnd1MwTUZO?=
 =?utf-8?B?V3U1SERkYXhUSnlpVWV4SFJaS05ZZjFBRklEYnI0QUg5Szk3WXEwcFYyb0wx?=
 =?utf-8?B?ZFYvS0J4eG01OVo5SjE5dkJzbGpOaEFselNuejQwQWNaaXV1cTJOb1EvMHZz?=
 =?utf-8?B?UiswSUpobUdvSUVMaWVjMWFkdGV1THZVc1pPbEhjT2hIcHpYOVhiTFdSb0NL?=
 =?utf-8?B?UmFPaHBveFBZa2E4dnR0MnlPMTJ2VEF0eHE2ZkE5K3FScG1QNU9Id1MrRWNS?=
 =?utf-8?B?ampJYndnYnI1Y1dVWnBEOUV3RTVYMFhRcUZFMFlTQ0hSVldnazFqNUZwNkto?=
 =?utf-8?B?VVFSNXUzMm5oeVhuQjlNUC9ja2w3WnpJMWovUzcyZkhzNTlDVHVvOVVZUFBM?=
 =?utf-8?B?SzZ2MHlGamR6RUVFMThhR25GT2Q0bUkvenV5ZjRXRmxGMmlYZFg2eWFWVzlM?=
 =?utf-8?Q?MieIXHCZdGX+QWgK1MudTV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D918336E094045469C20EB4EC9A7B3DD@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f701a00-509e-480f-47bb-08de1640ea1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 16:41:59.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2Vz6wYaRGdXktEvkFhs10NYaHOJ/HHBQnrCRmm8tNGKdWAbC71zthx9e54UhrW13ZiNINB4Os/1XSTbgQVpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3863

VGhpcyBwcm9ibGVtIHNob3dlZCB1cCBiZWNhdXNlIHRoZSBzdGFydHVwIHNjcmlwdHMgaW4gUmVk
aGF0IDkuNiANCmFwcGFyZW50bHkgc3RhcnQgbmZzIHRvbyBzb29uLiBUd28gc2VydmVycyBlbmRl
ZCB1cCB3aXRoIHRoZSBzYW1lIHNlcnZlciANCmlkLiBJJ2xsIGxldCBSZWRoYXQgc3VwcG9ydCBk
ZWFsIHdpdGggdGhhdC4gQnV0IGl0IGV4cG9zZWQgYSBwcm9ibGVtLg0KDQpSRkMgODg4MSBzYXlz
DQoNCiJUaGUgcmVhZGVyIGlzIGNhdXRpb25lZCB0aGF0IG11bHRpcGxlIHNlcnZlcnMgbWF5IGRl
bGliZXJhdGVseSBvciBhY2NpZGVudGFsbHkgY2xhaW0gdG8gaGF2ZSB0aGUgc2FtZSBzb19tYWpv
cl9pZCBvciBzb19tYWpvcl9pZC9zb19taW5vcl9pZDsgdGhlIHJlYWRlciBzaG91bGQgZXhhbWlu
ZSBTZWN0aW9ucyAyLjEwLjUgYW5kIDE4LjM1IGluIG9yZGVyIHRvIGF2b2lkIGFjdGluZyBvbiBm
YWxzZWx5IG1hdGNoaW5nIHNlcnZlciBvd25lciB2YWx1ZXMuIg0KDQoxOC4zNSBzYXlzDQoNCiJU
aGUgY2xpZW50IElEIHJldHVybmVkIGJ5IEVYQ0hBTkdFX0lEIGlzIG9ubHkgdW5pcXVlIHJlbGF0
aXZlIHRvIHRoZSBjb21iaW5hdGlvbiBvZiBlaXJfc2VydmVyX293bmVyLnNvX21ham9yX2lkIGFu
ZCBlaXJfc2VydmVyX3Njb3BlLiBUaHVzLCBpZiB0d28gc2VydmVycyByZXR1cm4gdGhlIHNhbWUg
Y2xpZW50IElELCB0aGUgb251cyBpcyBvbiB0aGUgY2xpZW50IHRvIGRpc3Rpbmd1aXNoIHRoZSBj
bGllbnQgSURzIG9uIHRoZSBiYXNpcyBvZiBlaXJfc2VydmVyX293bmVyLnNvX21ham9yX2lkIGFu
ZCBlaXJfc2VydmVyX3Njb3BlLiBJbiB0aGUgZXZlbnQgdHdvIGRpZmZlcmVudCBzZXJ2ZXJzIGNs
YWltIG1hdGNoaW5nIHNlcnZlcl9vd25lci5zb19tYWpvcl9pZCBhbmQgZWlyX3NlcnZlcl9zY29w
ZSwgdGhlIGNsaWVudCBjYW4gdXNlIHRoZSB2ZXJpZmljYXRpb24gdGVjaG5pcXVlcyBkaXNjdXNz
ZWQgaW4gU2VjdGlvbiAyLjEwLjUuMSB0byBkZXRlcm1pbmUgaWYgdGhlIHNlcnZlcnMgYXJlIGRp
c3RpbmN0LiBJZiB0aGV5IGFyZSBkaXN0aW5jdCwgdGhlbiB0aGUgY2xpZW50IHdpbGwgbmVlZCB0
byBub3RlIHRoZSBkZXN0aW5hdGlvbiBuZXR3b3JrIGFkZHJlc3NlcyBvZiB0aGUgY29ubmVjdGlv
bnMgdXNlZCB3aXRoIGVhY2ggc2VydmVyIGFuZCB1c2UgdGhlIG5ldHdvcmsgYWRkcmVzcyBhcyB0
aGUgZmluYWwgZGlzY3JpbWluYXRvci4iDQoNClRoZSBMaW51eCBjbGllbnQgaXNuJ3QgZG9pbmcg
dGhpcy4gVmVyaWZpZWQgb24gdGhlIGxhdGVzdCA2LjE3IGtlcm5lbCBvbiB0aGUgY2xpZW50IHNp
ZGUuDQoNCg0K

