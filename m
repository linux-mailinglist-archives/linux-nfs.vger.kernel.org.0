Return-Path: <linux-nfs+bounces-5804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525D960D84
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21BF1F23D01
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368871A0721;
	Tue, 27 Aug 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfbWngID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W81bGVDp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189B1BB6B7;
	Tue, 27 Aug 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768731; cv=fail; b=Px0MEg5BlxSdDles1EYb08dYqyoRt46R6NuFemSqKFwn2L5ZKzLT/A3FumIKXdFGo9lsmcXAPIRBQUms3s9s6AW+oUGKphDdP/v6+uRDnX+WoZ7ALWbyPl48JX3qwM/WmZuwqJ3At3+OlcENDVwgISUM+H3Rgqc0n4+qU56J4xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768731; c=relaxed/simple;
	bh=iF8FCLm9uGDYcB41zeBBkEQMJaRxMttWscniA8jd4Qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJsqCcaDj6qNz7EBrY+u0GBGZ+0K0oLNJeGy49QcIIVhnHFN4RYLzz4siye2R1RQVwNkvVRguhc/oKQ0YsGopcYXi2a/E/7ZbpLnR/EnJTSZPTMRqjPqgEotyjLMlPpFV+f5Plyn/j9KUArmAkpuL4VJDU26EZEhQz/wHrfojL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KfbWngID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W81bGVDp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RCBWbX030963;
	Tue, 27 Aug 2024 14:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=iF8FCLm9uGDYcB41zeBBkEQMJaRxMttWscniA8jd4
	Qc=; b=KfbWngID87K6nAYv0kvj1+oDoJhhAVI/Roq+XvUvPuDO+Qq6KGOhl7fma
	gU1tnKMoxXsDrsY7AbJ/BHxB9fJBUQ6zFQkkLfFZfa6IReFEtmYXkdaexUwCasq6
	fwdIuRdCX5f9KO2l9j9A/dXLvBKOSPcDim/qgJO6HBPck9kKTMXisNjzeXlRUlBJ
	OwmHK36cgx0jgVu012keZrqhDN3TyJHS/7iGBVf0ivk3VP5p5cFUXLAMhFyblF/Z
	DBPmoKjoCXpMQ0lTYSs44F6mS0EQ5TntbRrGHxnH4rgHHpubmMAmTHI/r3VmM8co
	8LSav3veqqgKXTNdle0jEpr5MinmA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177kswmxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 14:25:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RD1etR035389;
	Tue, 27 Aug 2024 14:25:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189st3pm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 14:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2adQ2HwsiIiDKsNpgXSQnecVuw96a/9G+NiKNuclR2ezW6LE9mwuWkwUbSm0YrmQa1rCK0VhI3atfz3hF1IEMsh3vt6Q1SXvK5pI28Wd8SI+8NFHdkTHz1HqH0bcYoB1H2Qzz3iQJ45+3hbNLHu9G+22TPRhI07nul6mls8fPQwTBFDhuOAgb5V0kBlcX3RJOPkXLoTflB/nuSmXmERsox4xY+CnhvUYodncflCDb64yZkhTfZR4CcdhkaZyneT2qQfgmidV6YznnpHfLwUCnOxKFoJ1Nnv/3BsjwlBZnBqOj3rh6Rs5bXAJ6rz821IwMuR9BYLdWc90sDzZ9nQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF8FCLm9uGDYcB41zeBBkEQMJaRxMttWscniA8jd4Qc=;
 b=mfxssy+VlgvKXK7mGdsOPR/ih/QqVdZrFsRvLoO3Q9w66d+/dl3s2fW1susvNrcsdHsm/zt+FDz0CySF3KMuLcrmOz4kh174KIFOfMYCk7CecHZ/wU+hm5ZydK1H0HOEz3lKF9eF3J3d2nqybT4qxNJdA+r8x5D4FplJGMDeFdvN1+qs7M4s6lEeol8++QWCyZvF8Pl9lXWwzHxITOHtzo+DEWeQBr3IOs4+bLOLPXiBWz2LG2x19veesKw/jJl8T8XCgfkA7w4N1o5ZYM+sSXsN2vyiQwdvEdH0Sj2CZ7DW+wIjMGAHaF3FH8pmUc973u4IqmmTPXmSwjnMH7XWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF8FCLm9uGDYcB41zeBBkEQMJaRxMttWscniA8jd4Qc=;
 b=W81bGVDpebww4p7lvbXYDID1zgXFXIF105ATmD0jOT5RGZkPr23XjMnJIi9WEdskbk6NnKJ/aCklYf284jUdvfq0OxQGVlu06w2zLb9CQ4iuKkpoyalGqhqwEgA24YQt3orJb65PolnknftQdeO6Ob7MesfKYkFZ8vZF8RHGCkY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Tue, 27 Aug
 2024 14:25:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 14:25:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <greg@kroah.com>
CC: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Li Lingfeng
	<lilingfeng3@huawei.com>, Neil Brown <neilb@suse.de>,
        Jeff Layton
	<jlayton@kernel.org>
Subject: Re: [PATCH 6.6.y] NFSD: simplify error paths in nfsd_svc()
Thread-Topic: [PATCH 6.6.y] NFSD: simplify error paths in nfsd_svc()
Thread-Index: AQHa9kG8VWLO16vpF0ygIv0VvHErA7I7EbuAgAAbhAA=
Date: Tue, 27 Aug 2024 14:25:03 +0000
Message-ID: <3C709C8F-8708-4434-8E64-41931DC5C753@oracle.com>
References: <20240824162137.2157-1-cel@kernel.org>
 <2024082712-haiku-take-ef45@gregkh>
In-Reply-To: <2024082712-haiku-take-ef45@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6689:EE_
x-ms-office365-filtering-correlation-id: d1d87f2f-9a24-403c-0038-08dcc6a40aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2htMEgyZHpHNDNrcDNaYkE3WERsVkVuZDRDZzFySzl2UXc0MUovNnZXWGtK?=
 =?utf-8?B?VjBKb1cvNnJKS096WkFFbFB0WHZaNW5LNnB2TnlsZmVLUmR2UFRzQkxsTEdK?=
 =?utf-8?B?dFQzL3dKQ1VVazdpQkFEaEhnNnhrR0htNW9HeGNqM1BDUFJET1RvQ1BmUVpI?=
 =?utf-8?B?ajZ1b0xxYkcwYXNhc3BPNjZXWFI3Q2pJamwyT1VmbE5JRkZGeU9TQ1Uxb1dI?=
 =?utf-8?B?UnY3eU4xMUFrM3dSeFRaOEFEWitpcEFFVXVRT3QzckdlMEUyMmdtWnF5eXBk?=
 =?utf-8?B?S293UkZlQWF4ODVub1V3ekN1NEdTRE9SN0RUYVU1TFppU3VvZTFhMEFBZU9V?=
 =?utf-8?B?TUxjQytOSE9sMjRaWmNIOXd1Y244bFBsVEVQb09MdFdtSmx4aWN4aENvQWZj?=
 =?utf-8?B?dHVibUFzb2wvckNMM25DUm5CekN3NkxMaUx2a3Z1MG1GdUp5dTdZeHFqMXh1?=
 =?utf-8?B?aEY4eXZrUXVteElpT0ZKMEdiOUhGOTc4UWpIZFI3WjVGRHQ1cFU5QURWb3Rz?=
 =?utf-8?B?OG81S1d0a2ZGMzBhemsvT2xkbklDbWtzMnB5RklYVlhrcjlPMmtsYVEyd0dF?=
 =?utf-8?B?UDZEbldkalJZaWZuVFM4dHd6Nk1kenlyNElQN0JJZzk2T1ZzL1M5QmtzalQ1?=
 =?utf-8?B?c1VuU3ExdldPdzdsSnRxRDNpRlExUzVHNmx6dEQwb2RyaHlZa0VvbG5WNVBR?=
 =?utf-8?B?Tk1WNXlZRHNGdnE0Z21ISlJ6ZXVkOC9WalVnMlJYMm1GOHFyeWd4SHVSTU5o?=
 =?utf-8?B?WTIzclBFeENNMk9GVmtQeG81S0gxWkZ2Y0dVcXpVeGk2VityWTE3TkxRU1Vz?=
 =?utf-8?B?TlJma0g5dm9NWVl5T3c3bHNteVdURHZuYk1PUzVNdi8wbSs5YUFRTWhuTG1D?=
 =?utf-8?B?WGlwK3ZkRlFxNVdQdzlNcDlHZjJaQlhzSEpIYmRNM1IrM2c3K0FSWk5jSlJD?=
 =?utf-8?B?dEYrWFFLMjFaL1cwTFdWblZvZGtYOXhqOG1RbGZOOHlzK0NGRWdxSVFJeGpw?=
 =?utf-8?B?ZUtOMVFDN1Q1QUdUZlUrL3VDZ1NUS01DQVpHVXlJTUNPTGZjSGNhREpNWlVB?=
 =?utf-8?B?c0VkditzQXlXTG0ySXRKS0k1VDBJcFZmUGlMK3FCWEs5ZnZWczRWOVNKQ2cy?=
 =?utf-8?B?a3hIVFNEVm5LWHk5OFViSHg2UkZHUDJ0SGZxUm0yWWN5M2NodWthSDdHVTZT?=
 =?utf-8?B?aXlQVnM2YjBoNStPemhTSHJiVGdSNzV3SVVCK1Vtcy9wTWlZM3ZiNkFpZnRR?=
 =?utf-8?B?ZU9Ia2ZvUjV3N01JYVpSRHlMODRPRGtRSklhaHBuVUNUYjFaRTE5djViQmI2?=
 =?utf-8?B?MVRJQW5GeThDYkdzZ09sWCthNFhzNUxwOTRwOUNSR09TOUpBOU1lU2s1VUFq?=
 =?utf-8?B?ei9PMzdXNmUydzlaL2d4TldWYUJFQU5QV240eGlScy9aSU1lNGNXK3FiaUFo?=
 =?utf-8?B?NDh3V3M1VU5KRk01M3MzR1BZbDlSQnNTR0poQVVmbEV4ZlBoREg4NE44d1p4?=
 =?utf-8?B?V2MrUWRZN0NvQkJqNWJIYkpmWHlZclU0NTltREZwdmhsdU1pUDVPOGNtaW53?=
 =?utf-8?B?RkprZkRzbm1aZ0ZBVVNGbWJhRElJbG56Sk9tVVNTRE1NQW1EUHFKc3VidHVO?=
 =?utf-8?B?MW92aVM5TThJeUNzZGo3WnpWdmhQNU9TbnFSeG93YWlid29laDlxSllPYnI0?=
 =?utf-8?B?YXNCaTNVQ3M5N3E1N0hHZldLb3BPSlczWEZPcGlWenc3YlM3M3RpRnNXcmRK?=
 =?utf-8?B?WmNaZExLRTcxNlI1MmNIb21FMGsyWXpUWER3UmNFVUIyN0ViNDZZNVNnbXRr?=
 =?utf-8?B?UFppNjk2MUVmOVZsUXl2TDVDemt0bWRvcGR1TytXaERsVytSQVg5Tjg1Uzk2?=
 =?utf-8?B?ODRIUEx2OW1iNmJ6a3pOajQzOUhrcUdRbXdLYmhLVFJxY2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlRDZzB4MTVQWXFBU3hIYWZNa0VKblBvWjFpbWhYY3RZUS9RdHFRTUpreDFh?=
 =?utf-8?B?YTNDTGVsaVlwNGsrRUc0ejBnZFNadDZLNVV3OHhKVGpSUnFaZkR1NU9uU25h?=
 =?utf-8?B?ZWtTMjZ5eHBxWktEOFpsRzNFYU1xSHNhTUh6YnlJaFhpZFhNQmFsb2Uva0hW?=
 =?utf-8?B?cFJva3EwWVBXNWUvdEpMSFl5R2U4VEtISXpmancxZlA4OXM0QzJXNjJrNFlH?=
 =?utf-8?B?VFdMMVBpRzZpOEZXeXhHUXA2a2NnTkcwZzR0UElFT29UL2VWY3lSd2pkQm1t?=
 =?utf-8?B?dFVzSno2eW1DNEpMK1J6SnlPa2ZVNEZHUEg4TTdmWnJ1dEIybkVNYngwajVL?=
 =?utf-8?B?UGxnK0x2Q2hmckwrMVNRVzZWamViQzBxSVIyWTZsNXE5L0t4L1NQWEFORnZT?=
 =?utf-8?B?L2xwYWYxWmdkVTN4UkpVZCs1TWNZQlhBUHlLdVdZWllpT3NMenhidVUrVURT?=
 =?utf-8?B?Y1FsT0h6cTZKeFVqTDRzQnc3dnhXY0NURFZ6OHRJY0ppa2M3OXljRCtGTU9C?=
 =?utf-8?B?TzA5TW04c0pXVGlsUER2RnVTMk1lWVh4NTVKbHV1YjR4Nzl2amdMNjhPN3U5?=
 =?utf-8?B?M0hZSWpSS2V4NjF1cnp4Rk5KL2R5NWlJNjlmTjlUbUhieG51endGV3l4RmNE?=
 =?utf-8?B?UkVzR2IrZndyY2M2TjgyT0VvRWp1dUs5dGtGN0pGem92WmZNMWt4ck1rWFQx?=
 =?utf-8?B?Y3ZudGIrc01nZlFKM093N1YvOERGY1B2VE1mRmZ0Sm1obDBkUW5mWUJmcHdG?=
 =?utf-8?B?YVJ2V3Q2WVpzd1cxazZwRFZpMHVNTHRJakRhL0tHem9rc2pheHpjTCtnZWRC?=
 =?utf-8?B?Mmh1eUdEMCtXeHN1NlYrVnBVVzVsWWZNSFVzRXpMM1ZTTUdKcThWOG0rcXpK?=
 =?utf-8?B?QVZNdU9Fc0Zxem9kQ20vOGVLbWRDSlpOQVRGMnlRQkZlR2p1dGFua0RDcGFo?=
 =?utf-8?B?TGdpRTVuRENjTUJUOEJmN0pRT01ob3JUV0U2SnZJaXZVM3VvVHBIYUxRUEpw?=
 =?utf-8?B?OXU1NlhzSW5ZQVlkQVBJZGk1SGU1d2gzMUlaSU12ODZvL0g3S0FNblhESmQ3?=
 =?utf-8?B?ZDh6MHY5UXRzY3FYOWZsWkpFU0hpVTRlYkttQUtDSXg3OFFFN201Z01jV0RX?=
 =?utf-8?B?UVFOajdNbjFYWVVXUEx0em1NTnRJeFo1bWtqMmk2cnUzNUZyTHFVK2VXR1Vr?=
 =?utf-8?B?NzcrdWJ2T05GVkdLOUU4TzlESmVJdzNoMmFFTGF1VWQ3WjBYdkRGV2ZYbVVZ?=
 =?utf-8?B?Y1dGeC9DaDFZbjdhbzQyUTVEdWNqVjZkd0EremNVOWovNVNveEpVWXdwOFVK?=
 =?utf-8?B?TFBic3J5NXl0Z2x0NFhZSEN6V0pkaHJHWFZsdy85ZmVBakhHOFlKMGhOa2tK?=
 =?utf-8?B?cVZBMFpBUnAzbVNZSERHMGI3ajBVQUNJbC9LZGc0bE5ZaTVVKzg5UitXaUFq?=
 =?utf-8?B?RXdnZGFTZkwxdU1BbFA2alE4RDdkdUlqVzBpYVZ3b3F0Z1N0czB3NnBycVZm?=
 =?utf-8?B?SE9LSm1yYTEvSzN4azgzL0pRZlJsa2dnNWc4b2F5Ti9NOTNub3E1N0JiMlJn?=
 =?utf-8?B?V2t0Z09VZFBzNWQweTA3OEtrN0FyMCtaMVYwODl1TWg3R2dLQWtyTzNXUEFy?=
 =?utf-8?B?RUVJOEpDci9VSGNmWXNMZVRUNHVPaXlEdFFiZzNaN3d0NUJhdGxLNVMraVR0?=
 =?utf-8?B?a21sVC9WdUNtUHVYVFhMVTRtdE1IVTIzTXNMcXhYVGNkdkd4dlZlc0pqR3ZO?=
 =?utf-8?B?K3BZSmVPdytTb2pIcUwwdFduUThuMUVhK1Z3Q28rSDVoZWMxVGM4YVNzamc3?=
 =?utf-8?B?NEN6UllsQXRJZXc4eUlSdGk0c2VZS05XK29TUTBCL3RiaEwraGdVVGJGcy9n?=
 =?utf-8?B?V1c5ZDZmay81cWlaWVJqODZ5U2VsTlh6b1lXT0U4enExaW1PUGRvYUd5R21O?=
 =?utf-8?B?L1JSTENQamFaTkU3N21JRnM4enRvUEl6aFEyM2ZJNHZkanpNM0ExNk5CL250?=
 =?utf-8?B?WWFXdklyZ3lVby9udW90Y3ROMUNESm9FRzFHSzdBWVpFdVZMUytrMEZXZFpI?=
 =?utf-8?B?RTFOeEp1cVR3WnFpUWlRcDZvUWo3dmtKR1lybUFUWVN1RS82bkdHdGY1aEFo?=
 =?utf-8?B?YnFHQUg5Vld4ZGs5RUx0Q3c1QjNwRGt2NDdLNnhtZE1MM1hGOXptY0tDZmtV?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D9BBA009A1FE42A42C15E7F552B284@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ozll5dgW7zgc6FkmbTtalWZs9ed/I5g2nr8vhJHHrQwc+EYpP+vA/bH848GQ1wLRq9GsrB0C5SEnUUhQ7kMbCeCCCzEfuR5q1XC7DVhfKyCQL/z2NxnZD6a0hw0qY50ZlQqda1MZcvwECxP54J++dQMXjwcy9AV+XJ17zP06gm/TIvqmRCtwEJ9AV3AYhelqAuoGmQ9mpl75dFpSDpbxg3D/GsqNiVz2czn7uluYwti3IyseqK+F4A8JEfd+R+oXTrTpOUqlnwgdwc26JHShWc9es7tWROdCJN+sdKHIiyOwABnzEACV72JZoQdnWqB2cF5owsqE0uDuZALvnoQzutpRbFBzOOlyewacQOall4LOclJQYc9A0jVLT6jbCIJtB4EUMdP2ZFoKtf2/Wsc2C/ByAyr7cxUh+XzwrbTMdhYXQpoWpt8o8hS/d9Q8aE3nm4sx7g8TRVU4R3T0m66UM2fmyiZDRXmWdn1DxAji35zrd/gkfvzNkgwPjPTM1I0KAtDFb1mSufU1tvOtKVs+y8r8D2xOcfSMR/sR/UcmEPuElSzUZbvuilo4Es59Oigid2/a95w0VvWJ/KnhzDDCWcA/7bZrGm9K32aklvN2xDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d87f2f-9a24-403c-0038-08dcc6a40aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 14:25:03.5583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8/4++rd+PWZL4749mFNK5mJrA3wjPxZbYEqHBUe2j3IGcDDqi8/0TzVID2v6lcitikrH143I9oYGs7G+Zqgdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270107
X-Proofpoint-ORIG-GUID: fYclx_0yx9AKjZEQinOGk0xbbwdzGn26
X-Proofpoint-GUID: fYclx_0yx9AKjZEQinOGk0xbbwdzGn26

DQoNCj4gT24gQXVnIDI3LCAyMDI0LCBhdCA4OjQ24oCvQU0sIEdyZWcgS0ggPGdyZWdAa3JvYWgu
Y29tPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgQXVnIDI0LCAyMDI0IGF0IDEyOjIxOjM3UE0gLTA0
MDAsIGNlbEBrZXJuZWwub3JnIHdyb3RlOg0KPj4gRnJvbTogTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPg0KPj4gDQo+PiBbIFVwc3RyZWFtIGNvbW1pdCBiZjMyMDc1MjU2ZTlkZDljNmI3MzY4NTll
MmM1ODEzOTgxMzM5OTA4IF0NCj4+IA0KPj4gVGhlIGVycm9yIHBhdGhzIGluIG5mc2Rfc3ZjKCkg
YXJlIG5lZWRsZXNzbHkgY29tcGxleCBhbmQgY2FuIHJlc3VsdCBpbiBhDQo+PiBmaW5hbCBjYWxs
IHRvIHN2Y19wdXQoKSB3aXRob3V0IG5mc2RfbGFzdF90aHJlYWQoKSBiZWluZyBjYWxsZWQuICBU
aGlzDQo+PiByZXN1bHRzIGluIHRoZSBsaXN0ZW5pbmcgc29ja2V0cyBub3QgYmVpbmcgY2xvc2Vk
IHByb3Blcmx5Lg0KPj4gDQo+PiBUaGUgcGVyLW5ldG5zIHNldHVwIHByb3ZpZGVkIGJ5IG5mc2Rf
c3RhcnR1cF9uZXcoKSBhbmQgcmVtb3ZlZCBieQ0KPj4gbmZzZF9zaHV0ZG93bl9uZXQoKSBpcyBu
ZWVkZWQgcHJlY2lzZWx5IHdoZW4gdGhlcmUgYXJlIHJ1bm5pbmcgdGhyZWFkcy4NCj4+IFNvIHdl
IGRvbid0IG5lZWQgbmZzZF91cF9iZWZvcmUuICBXZSBkb24ndCBuZWVkIHRvIGtub3cgaWYgaXQg
KndhcyogdXAuDQo+PiBXZSBvbmx5IG5lZWQgdG8ga25vdyBpZiBhbnkgdGhyZWFkcyBhcmUgbGVm
dC4gIElmIG5vbmUgYXJlLCB0aGVuIHdlIG11c3QNCj4+IGNhbGwgbmZzZF9zaHV0ZG93bl9uZXQo
KS4gIEJ1dCB3ZSBkb24ndCBuZWVkIHRvIGRvIHRoYXQgZXhwbGljaXRseSBhcw0KPj4gbmZzZF9s
YXN0X3RocmVhZCgpIGRvZXMgdGhhdCBmb3IgdXMuDQo+PiANCj4+IFNvIHNpbXBseSBjYWxsIG5m
c2RfbGFzdF90aHJlYWQoKSBiZWZvcmUgdGhlIGxhc3Qgc3ZjX3B1dCgpIGlmIHRoZXJlIGFyZQ0K
Pj4gbm8gcnVubmluZyB0aHJlYWRzLiAgVGhhdCB3aWxsIGFsd2F5cyBkbyB0aGUgcmlnaHQgdGhp
bmcuDQo+PiANCj4+IEFsc28gZGlzY2FyZDoNCj4+IHByX2luZm8oIm5mc2Q6IGxhc3Qgc2VydmVy
IGhhcyBleGl0ZWQsIGZsdXNoaW5nIGV4cG9ydCBjYWNoZVxuIik7DQo+PiBJdCBtYXkgbm90IGJl
IHRydWUgaWYgYW4gYXR0ZW1wdCB0byBzdGFydCB0aGUgZmlyc3Qgc2VydmVyIGZhaWxlZCwgYW5k
DQo+PiBpdCBpc24ndCBwYXJ0aWN1bGFybHkgaGVscGZ1bCBhbmQgaXQgc2ltcGx5IHJlcG9ydHMg
bm9ybWFsIGJlaGF2aW91ci4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogTmVpbEJyb3duIDxuZWls
YkBzdXNlLmRlPg0KPj4gUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5v
cmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNv
bT4NCj4+IC0tLQ0KPj4gZnMvbmZzZC9uZnNzdmMuYyB8IDE0ICsrKystLS0tLS0tLS0tDQo+PiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+IA0KPj4g
UmVwb3J0ZWQtYnk6IExpIExpbmdmZW5nIDxsaWxpbmdmZW5nM0BodWF3ZWkuY29tPg0KPj4gU3Vn
Z2VzdGVkLWJ5OiBMaSBMaW5nZmVuZyA8bGlsaW5nZmVuZzNAaHVhd2VpLmNvbT4NCj4+IFRlc3Rl
ZC1ieTogTGkgTGluZ2ZlbmcgPGxpbGluZ2ZlbmczQGh1YXdlaS5jb20+DQo+IA0KPiBPZGQgcGxh
Y2VtZW50IG9mIHRoZXNlIDopDQoNCldhc24ndCBzdXJlIEkgd2FzIHN1cHBvc2VkIHRvIGFkZCB0
aGVtIHRvIHRoZSBhY3R1YWwNCnBhdGNoIGRlc2NyaXB0aW9uIGJlY2F1c2UgdGhleSB3ZXJlbid0
IHBhcnQgb2YgdGhlDQpvcmlnaW5hbCB1cHN0cmVhbSBjb21taXQuDQoNCkJ1dCBpZiB0aGF0J3Mg
T0sgdG8gZG8gZm9yIHN0YWJsZSBwYXRjaGVzLCBJIHdpbGwNCmFkZCB0aGVtIGluIHRoZSB1c3Vh
bCBzcG90IG5leHQgdGltZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

