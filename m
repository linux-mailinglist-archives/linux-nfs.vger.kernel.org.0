Return-Path: <linux-nfs+bounces-3132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066A8B9FD1
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 19:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BAB1C20BF0
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0E16D4FC;
	Thu,  2 May 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxlTb052";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q92Imjfh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E11553BB
	for <linux-nfs@vger.kernel.org>; Thu,  2 May 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672330; cv=fail; b=lN6n17I8cp7v9Az1TvyVUB3SEacXSy5vCxmV/WRccwpn2ES6wizX2fL/SjZ/A9CC6Pt9ctrgpj/rP8qWJ7+egcRE862/iG6+k529gd+5cB932/9NxBuZZ037OZ3cZObNfbYcfT4pu/x7ysBys/JSxOQdioCVSFCZ+OghXA4BMdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672330; c=relaxed/simple;
	bh=/4osNOf03mp1q39881iv3LUut92Th0iAw//Z8B96Kws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goQbst0NvJJBOSiupEmO0nZyzkVlgUQp1Mj2PTJ++bNekNuyauQWlnBglIAw/GQVmrwGsHMtIQvmX9QDHASYi27zwlJzj+RJFKZB1Q/Z/1Q7g0mmTT5KTADLIrvxyWlrbEOKTJmp8EEtalqeMw2mj3YeysFXhGVrRjROjAuydEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RxlTb052; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q92Imjfh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HH79j011946;
	Thu, 2 May 2024 17:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/4osNOf03mp1q39881iv3LUut92Th0iAw//Z8B96Kws=;
 b=RxlTb052cMU/d/pfZ8Gbk7GFtTovF3C2/6fHz6MwzGsuReZwuw2ZQhtnm0OW7GmOt1fr
 fwmJBpXOO3tHhfaEHLVpP1vlAjJrna/Pp45oJmqlGq6boyAh/GaddantkpPtyCY5iqru
 irBlzxJgGINOgP+N+OtDL4bx3fWalOy+gL13JN6K7oDdwkAjPNMMuI1Ob3nGFAbdOHoE
 Itb/jQFoOZjaEFKMrdf+HbwlspOTFlquQie3Li1xSjxBAUCbXobX2Z3geCnWE6VeyNC/
 Qsd9Uf/dgJfCH6bp+RW6RfMiq+i3x5gKpRibhlIGSo8SDDT/0+vRMXOQw6pHabSPyCLZ pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdf05rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 17:52:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442HX3ii020063;
	Thu, 2 May 2024 17:52:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtas860-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 17:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtcVzGT3viQ8UvU+cce+E5D2Pj482IpkBNYf/etRJUnVMeFIAApr3ZvXZb7T9KQpqvRqSaKNvZzNgCciizGNNPxruQi6ywtVS44ZISloG14BTMv7NfzJ9qLSCvb1UyQmgSzExEA1SAl1FDoJ7Oes8/4QLuMsjIWNRmM2sKKrSSrGAmM4Wnr5/1Ay85vV7aIr5TT+uFk4kkepp1PrWiyIAfxJn8fikJlOpOQZ4TW13UJuh/XVdgJH5Cipj/FrEMEhHEpq2vTa9E+BsJOT/Q4gp029mi0xueI7nGeGw5CKa+D2MH9HwtPmJaxwdBVynnf2UGSv1jgQyEPz4D9HbL4TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4osNOf03mp1q39881iv3LUut92Th0iAw//Z8B96Kws=;
 b=b0KZhtUhTg6R0OpdR0DLJJ8hBTLmAz9MDNDho6d7p1TkVoFRYfgEQGBNeO0t0bifhO7aHTC4gEGvA276JupD7pBDFRAbl5ppTtgEGXr28IGVnNZTwINpMndSckF5uAyFD/Bi+8gFDRTP+R56uJDdq2E0lqywQ8k0j3elvahLP/qzQNlh6w8U+LAYWGjn+dQ0iMTzDLkvotbMSyr3Dh15NK99V2va0xIftfjZKq7AMXdLAKsInlCcWTFHBhtjb9fnKuoqtiDrMiI035l1Klp43RBg7/VmYcjlyi58lrqjGbcue7MS+8UDphxTbPCqFY+iz7JFK9zc5zv9JJZtFqVHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4osNOf03mp1q39881iv3LUut92Th0iAw//Z8B96Kws=;
 b=Q92ImjfhrX1aI0iEA4izE8djMUs1tOIMyM4VTs537njt5oltx/TbpJYSKVf6yZwkkCmMKg3t78Lv/6x0pbAR9O/lloPbr9fVqzyxni2bEd3TfFRMuroAtls5icOvYZLRHZNplv5Vbv0MHW2TMdFKsE2R8EjXHFwkVIKuC33XFSs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 17:51:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 17:51:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Scott Mayhew <smayhew@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Thread-Topic: NFSv3 and xprtsec policies
Thread-Index: AQHanKkgYmL3FNy2y0KXK2o88GsYY7GEHpAAgAAW/ACAAAPvgA==
Date: Thu, 2 May 2024 17:51:57 +0000
Message-ID: <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
References: <ZjO3Qwf_G87yNXb2@aion>
 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com> <ZjPPZmBZJZVmBuA6@aion>
In-Reply-To: <ZjPPZmBZJZVmBuA6@aion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6560:EE_
x-ms-office365-filtering-correlation-id: de37b3f6-6ff3-4f4a-9d15-08dc6ad08fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VVJheW5UNmNMNC9pdDlLdjRlUE90RWdmUG5nMkpLYXJqSFprWHl0M0N2NENK?=
 =?utf-8?B?NjRxNU9YNG9VWjR4VVlaY1d2THlxZndNNWFEd2htODlJS0tQSnlMb0xqTDNl?=
 =?utf-8?B?WHdvRm5aVlR3REFmWVlsMkhoZ3E4Qk5oQWhvcUxWRE9MV08yanVyVVA0M0VP?=
 =?utf-8?B?TjB4enhxREI3RDdhMnAwcDhVTDZGTkJTaGthTDhPWGR5aE5JNk5FSy9wZExz?=
 =?utf-8?B?U2I5UlFORVRVSEh4azQ1aXhqYkZJWEdPNFZDV1JyS0NjMm85UitseWVKdmVQ?=
 =?utf-8?B?aWlNTFNuRTJQa3Vjc2ZzcEx5U0NEV3ZyMWVFMkdybzRBWCtIUG9DQmlWbnVy?=
 =?utf-8?B?clVpQVhPbVJQTTdDSlYxbGtBU1VUL0xKL3h0aE1Qa2VWWXpWWHZreXBLcEtL?=
 =?utf-8?B?eE9Ga003TGhzcnkzd1Y1MFJNazlocS9PdzhsaHlPRlhWM2FIZDNiNkJxUktk?=
 =?utf-8?B?N3lhZ3lmV1RTdHpHK1JvaGFOVzZodVhNR2dSV01EVUM3Y09IS2l6bi9rdEV3?=
 =?utf-8?B?RDlPNkI4bjNuK1luMFMydDVvYzVGV2JiU3pNME51bkwrdG9abDh4dGV2VWp4?=
 =?utf-8?B?T2JOM1ZXL2FaS0FSSGFEUXpKL0g5aHZuMjNib2RaNUEyTGhBS1BOM2N3K2V6?=
 =?utf-8?B?NzM3QlFYM0lMckZFRTJVeklNbmVxZzZHWGlpbzMvSzR4MGRtSjM1OGQxUHNi?=
 =?utf-8?B?LzJsN0RHVGtTckpIMHRZOHZVdkRWcnZ0YVdnaHRtWVMzVG1oTzJ2N2V1TjNY?=
 =?utf-8?B?SEMxb3lGSENyeUpzSCsrZ0pZbWgyYzNUaENxYnJYUGlCS0JDcXQ2NS93dmtM?=
 =?utf-8?B?WHFpcThJclNOWDBOSWVwU1hEenc5QnpiVHJTNDlWTlErZXUvcDFZMVg5eVlk?=
 =?utf-8?B?RU00SHlTVGZxczdYVTloNFRESnl1YnVNSm9TYzlIdHR3TjlnbGRudFBMWDNJ?=
 =?utf-8?B?WUFHTHo3VEs5MG4vaUVqWlE3RStBZ0c5TUc4WldHOVhNTktYcnllWEcwLzJJ?=
 =?utf-8?B?Z1V2WlVKaktEcHdjZHlWZW1VeFhxZW5mZHRKUUJjcitOSUVvMnRJTzRvaVdt?=
 =?utf-8?B?S011WEd4cTRIUUt3c3JYanYrYTg1SDNBZjNDOVFmM1lLTUpLUE9XemlYanlI?=
 =?utf-8?B?dER4dE1wVThva0YzK05JVjRaQTRyRk0ydG0wc1lBekZ1eGVyeDI5cnRybExn?=
 =?utf-8?B?YXBRZW1vS1VzNlhnOXU3eSs1ejR5V0tLWGVRbjVrMG5QTExmSGxVcEVqQUI3?=
 =?utf-8?B?cjNmbjdWSHQwRk4yMXNXTi9DNm5pK1JKeXBHRlVWd3hvdU43dUE3SXptKzF4?=
 =?utf-8?B?ODViWTVHR3Z1TkRZNEpuVTVHTFlMTHhKN3ZiTjZvSWMvQ2pNZElMcUZ3WW5h?=
 =?utf-8?B?N1JBZFRidTgxc2MxWHFNZTVkWDZabDdrTU8zQ05ZZWdrS2tOMjZHSEg2cmwx?=
 =?utf-8?B?UUZmdU5BUW9tbGpCSXIwRnhYaEthOFA3RDRHUnc5N0RNTytkM3c5NEpML29P?=
 =?utf-8?B?T1pkQ2xnRFQzbEhYV3h2YitpZHV6OCs3M2JsL1BiYkVCRVFubmV1OW1iMGF4?=
 =?utf-8?B?NVFMcFFvTllibm9FRDlwZi9zUVovRDRaM2t0TjhRNzVUTHk4QzhjeDkxbytq?=
 =?utf-8?B?Q2V5dFh1Umw2bU9lQWdqT3NmdDdHeFl0WFNnaG1MWlN4TkJyNkc0UHNWS0pU?=
 =?utf-8?B?M2d0M1ZrMUJWTWZDZDRoYWM1aDdLSEZ1MDJ1S3YrQ3hBMjVQSDFQSkFIa3Bq?=
 =?utf-8?Q?bbBoFqPsFw58DIBjZs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dG5GaXFZRWZXQUV3R0tYdm9idHJDZ2prSmZZa2M5d2xTYVBTZ0syZEdEeXhB?=
 =?utf-8?B?Mks0RmgwZ29tcno2REVnTWEyUCsyd3RBUW5iaS9JWlFsRFdVVFJGRTVDK1Nl?=
 =?utf-8?B?UFA3WXB1RTROeC9UcWpsb2RkdUZ3SVQvOFZvUGNjay9yZEZPRmtXL29aUlhl?=
 =?utf-8?B?b21Od0E3UU9DQkZNd25zMkFPSC9mM1B0NlZVTUJBOC80Z0oxRnc0NGppQmNv?=
 =?utf-8?B?bFVMcFJzMmdLa0g5M1J2RENpdTgzaFF6bnRDNXc1K0xTeGRmaE9EejI0a202?=
 =?utf-8?B?ZlZUU1BhYnlTSnN2cENncUIyamN1U0NSTVczRVhDZDZETDJhc3BXMCtLRWVa?=
 =?utf-8?B?Vnl2eENZYTRsY3U0RDRNekp1SExnZXF1K2dyUkYzN25iVzNKVFF1U1VJN1Fy?=
 =?utf-8?B?alphZzlVTmNVWWw2SDIvTG0raGJhb3Vwa2JHakZZR1F0Zm5IdTVPSlY3WlRH?=
 =?utf-8?B?MXNTKzlqWFFyckJUV2o1SndJMlRLOE9keU9jU2RZeit3T1lzUUJUQ25TMyt0?=
 =?utf-8?B?TUc3VjVOZWRCK2I3VTF4K0pzRU9HK2tiS21wRlRxb05wT1dHalg3K3N5VWp2?=
 =?utf-8?B?U2E3dkpNTnlONlFGaHN0SGVHTU5qdHcwekJoV0dCWGhTL0FaRlZycmxIWUsv?=
 =?utf-8?B?YUVOcTVBcFlqYWkvRFQ2UXVKcTJuWnhJaktyQ0h3MThTVU54WnpRRzBuL1Bn?=
 =?utf-8?B?Nm1FcHRDSUhrcmVhV24rVHYvc1J2MXoxT0wvb1pvMGk5SjZyMEwybk1aTDcr?=
 =?utf-8?B?MElBc0w1WkFwQzZTaXBoSnZTKytOaUJKU0xqeGVwd3Qyc3VlVHBvbmFjajAz?=
 =?utf-8?B?MWtRK3o3MFFSUlFSbEtSUVJOYmk4MUNWK2t5ZFBVMVBNRHlTVGh1TmhndDQ0?=
 =?utf-8?B?ejNNWGo4U0tFSENoQUIzZ0NXcVhOdERFSjBLWUhaOW1yOGVpNzB3RkJoL3Zy?=
 =?utf-8?B?RE1NemFrRWhhZmRWWC81SVZwdHA4eCt6ZHB2ckxBTnpQQzVtOHNkUnJENmJy?=
 =?utf-8?B?U0I0L3d4MnVSa3dwU0xpMzM5eVk5YmdrTlUwOUVvZkorcTYzVHRzWEhEeFZ4?=
 =?utf-8?B?MDFxRSt5dFdNZXcxcko3ZXdoTDZUM3l3T0J3Z3l2bzgvZXlnRkZKeWFsWXh5?=
 =?utf-8?B?QzhOcGhZZUVOR2pONGNiV05YdlZJYUVvVm1SK3BUMFR2bW9yaHNwWlc2OWRD?=
 =?utf-8?B?NzNYMnpWUFhzRkVuU0dId2dqZzJFYXYzZzlYbnFLekRqOEFSYUhIa05wNnV3?=
 =?utf-8?B?bWNnUFY3WHhqdWQvTWFkcXZFeUw0cExkUGVHMG9od2Fqd3hiWERaVVlaZXN2?=
 =?utf-8?B?aHNtVWJnQnFTWnBYeElhUXA1dnc1MitzMFM4VDR4UUMyajFGaVQ5R3pVdkdv?=
 =?utf-8?B?VVFWSFRRdG13Vmo4cVMrdjNaN2pJakNTVWNIU28wR1d1NzBTd3Y2aW5SMFFN?=
 =?utf-8?B?QWFjeGl5NXdOZlVWY3Fkc2M4ZGhCQWtzTG5jNWdjWWFxSDNBN2VWOCtBa1NZ?=
 =?utf-8?B?cTJOZi9UU2R1N3h3YUtmVjhseFpDbnNueHRvM0JxS0d3MVR2L0cyUGRZdnlp?=
 =?utf-8?B?c0lCT1RDc3VjR2RHOXZyTjJ6M0xKeUNCbFVkWnJSVGsxWUx1NGlMeUJpc0Nj?=
 =?utf-8?B?SmN0ak9oc1Fic1N6NFo4MjBFTVFld1lOS0ZiRE0xY1psejVteEdoVDZpdzJa?=
 =?utf-8?B?dk9GaXJvMU4vb25PdG54dU1vaTZhT2tMZjRhM0NVQVRyQS83TkZHRHVzSE8w?=
 =?utf-8?B?L3lodjRXLy9xVkljaU1nZ2pXL2NieisxbURvU2RSVVBTelhSallwb3F1cVA4?=
 =?utf-8?B?eHJLNXEvMDBudzFlQ3dOd2tyUEhjU04waEtBVHFBbmltMGZPbC9ucDBudnRY?=
 =?utf-8?B?UUc0SGNVckhsVm1TbWJLalpHWjdvemlxSExHUXZrZ1ZWQm5FYk9NeGJucTJy?=
 =?utf-8?B?b3hXYWVZYzhNdG56ZE9aWjB4dWNYakhFNDRFelB2cGNRT3h5S0l1KzUrVFYr?=
 =?utf-8?B?eWNsV2RUSWRGOE9pNytLaXdNRDV0bTB2QjNZbUViSmxYNnVwdFdXc3ZWbkZG?=
 =?utf-8?B?cmhoa1JyYzlZSTBYcGMzTTVIUHhXTWw2c3c3dzgyYXFxaXNRKzlGYlMxWFR5?=
 =?utf-8?B?Y1hCWDNUNVdVZ3Z3MS9iUWd4Nms5Z0dGck9ZdTJuY1dOcG5Wd1lQT1pKTXNU?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <842BFF8FF0272B44A99F5FA736D5F823@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1KCFmuq0u3+CzV4p17iGwcVxQmplC9GUvQlIbRAQ42xrhtISc0z18fVZbo2L70oCKAcjV7p+grMlKN7FNwtXMvBkwbfPEjZa7DXZhJfqI+5pX9j4QDVOVHpvzz4iFoBh/J5QKdSJNrrSf5terwuVvQGbAmnLxRjISevY+/+9j9Y+a4PkbHaLx9v+1KK55F1xNocZ9mloEo6M4QkJn8s4Z5He6kR6hZCxMA9soNmN1wBJSc8T/t1C1axf21JciN9OjT9I4/81trs93Uo4fcab6W4GYWeDevrauunH2RpiwcmfrUuews7/h42gU+E/xAEXk8YPfk1r1RI5+PELozlTiJoWHqXV2EA+RI3GsS+Tx/68+Y9OWLBiLteUi21S0QUkTfZPr85LqwhQtNtEiDTdtf95HCLkNNou+krJ71mXGb3TzktBco8ez3nrG0Rzjeb8RT33vcZRU1z9pWa430ldSvVH0maii9+p/HrXWlHgBEa88S+odImLYUNTpgnjJEkacOfzm7gKBYQBXECkI8YyrR0Fj3mlMDK5PP9v7YiHb8ykx3GQQ4v+wdnOo9bs2d38FTXDhRo8zyT2k/uRshxJI8Wak06WGS+Q4y+u5VuL5+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de37b3f6-6ff3-4f4a-9d15-08dc6ad08fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 17:51:57.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhHRfEBTZBCMqPi4PVSKs/l56/dK/nHg6JTGxwfGn3SobdlysEfW7B6kY5sQn60XM1pA/3+J/Yi12VVUlFclKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_09,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020117
X-Proofpoint-GUID: HweizWitXKjncb2ooDPsN4uZcExCAlPA
X-Proofpoint-ORIG-GUID: HweizWitXKjncb2ooDPsN4uZcExCAlPA

DQoNCj4gT24gTWF5IDIsIDIwMjQsIGF0IDE6MzfigK9QTSwgU2NvdHQgTWF5aGV3IDxzbWF5aGV3
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAwMiBNYXkgMjAyNCwgQ2h1Y2sgTGV2
ZXIgSUlJIHdyb3RlOg0KPiANCj4+PiBPbiBNYXkgMiwgMjAyNCwgYXQgMTE6NTTigK9BTSwgU2Nv
dHQgTWF5aGV3IDxzbWF5aGV3QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFJlZCBIYXQg
UUUgaWRlbnRpZmllZCBhbiAiaW50ZXJlc3RpbmciIGlzc3VlIHdpdGggTkZTdjMgYW5kIFRMUywg
aW4gdGhhdCBhbg0KPj4+IE5GU3YzIGNsaWVudCBjYW4gbW91bnQgd2l0aCAieHBydHNlYz1ub25l
IiBhIGZpbGVzeXN0ZW0gZXhwb3J0ZWQgd2l0aA0KPj4+ICJ4cHJ0c2VjPXRsczptdGxzIiAoaW4g
dGhlIHNlbnNlIHRoYXQgdGhlIGNsaWVudCBnZXRzIHRoZSBmaWxlaGFuZGxlIGFuZCBhZGRzIGEN
Cj4+PiBtb3VudCB0byBpdHMgbW91bnQgdGFibGUgLSBpdCBjYW4ndCBhY3R1YWxseSBhY2Nlc3Mg
dGhlIG1vdW50KS4NCj4+PiANCj4+PiBIZXJlJ3MgYW4gZXhhbXBsZSB1c2luZyBtYWNoaW5lcyBm
cm9tIHRoZSByZWNlbnQgQmFrZWF0aG9uLg0KPj4+IA0KPj4+IE1vdW50aW5nIGEgc2VydmVyIHdp
dGggVExTIGVuYWJsZWQ6DQo+Pj4gDQo+Pj4gIyBtb3VudCAtbyB2NC4yLHNlYz1zeXMseHBydHNl
Yz10bHMgb3JhY2xlLTEwMi5jaHVjay5sZXZlci5vcmFjbGUuY29tLm5mc3Y0LmRldjovZXhwb3J0
L3RscyAvbW50DQo+Pj4gIyB1bW91bnQgL21udA0KPj4+IA0KPj4+IFRyeWluZyB0byBtb3VudCB3
aXRob3V0ICJ4cHJ0c2VjPXRscyIgc2hvd3MgdGhhdCB0aGUgZmlsZXN5c3RlbSBpcyBub3QgZXhw
b3J0ZWQgd2l0aCAieHBydHNlYz1ub25lIjoNCj4+PiANCj4+PiAjIG1vdW50IC1vIHY0LjIsc2Vj
PXN5cyBvcmFjbGUtMTAyLmNodWNrLmxldmVyLm9yYWNsZS5jb20ubmZzdjQuZGV2Oi9leHBvcnQv
dGxzIC9tbnQNCj4+PiBtb3VudC5uZnM6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkIGZvciBvcmFj
bGUtMTAyLmNodWNrLmxldmVyLm9yYWNsZS5jb20ubmZzdjQuZGV2Oi9leHBvcnQvdGxzIG9uIC9t
bnQNCj4+PiANCj4+PiBZZXQgYSB2MyBtb3VudCB3aXRob3V0ICJ4cHJ0c2VjPXRscyIgd29ya3M6
DQo+Pj4gDQo+Pj4gIyBtb3VudCAtbyB2MyxzZWM9c3lzIG9yYWNsZS0xMDIuY2h1Y2subGV2ZXIu
b3JhY2xlLmNvbS5uZnN2NC5kZXY6L2V4cG9ydC90bHMgL21udA0KPj4+ICMgdW1vdW50IC9tbnQN
Cj4+PiANCj4+PiBhbmQgYSBtb3VudCB3aXRoIG5vIGV4cGxpY2l0IHZlcnNpb24gYW5kIHdpdGhv
dXQgInhwcnRzZWM9dGxzIiBmYWxscyBiYWNrIHRvDQo+Pj4gdjMgYW5kIGFsc28gIndvcmtzIjoN
Cj4+PiANCj4+PiAjIG1vdW50IC1vIHNlYz1zeXMgb3JhY2xlLTEwMi5jaHVjay5sZXZlci5vcmFj
bGUuY29tLm5mc3Y0LmRldjovZXhwb3J0L3RscyAvbW50DQo+Pj4gIyBncmVwIG9yYSAvcHJvYy9t
b3VudHMNCj4+PiBvcmFjbGUtMTAyLmNodWNrLmxldmVyLm9yYWNsZS5jb20ubmZzdjQuZGV2Oi9l
eHBvcnQvdGxzIC9tbnQgbmZzDQo+Pj4gK3J3LHJlbGF0aW1lLHZlcnM9Myxyc2l6ZT01MjQyODgs
d3NpemU9NTI0Mjg4LG5hbWxlbj0yNTUsaGFyZCxwcm90bz10Y3AsdGltZW89NjAwLHJldHJhbnM9
MixzZWM9c3lzLG1vdW50YWRkcj0xMDAuNjQuMC40OSxtb3VudHZlcnM9Myxtb3VudHBvcnQ9MjAw
NDgsbW91bnRwcm90bz11ZHAsbG9jYWxfbG9jaz1ub25lLGFkZHI9MTAwLjY0LjAuNDkgMCAwDQo+
Pj4gDQo+Pj4gRXZlbiB0aG91Z2ggdGhlIGZpbGVzeXN0ZW0gaXMgbW91bnRlZCwgdGhlIGNsaWVu
dCBjYW4ndCBkbyBhbnl0aGluZyB3aXRoIGl0Og0KPj4+IA0KPj4+ICMgbHMgL21udA0KPj4+IGxz
OiBjYW5ub3Qgb3BlbiBkaXJlY3RvcnkgJy9tbnQnOiBQZXJtaXNzaW9uIGRlbmllZA0KPj4+IA0K
Pj4+IFdoZW4ga3JiNSBpcyB1c2VkIHdpdGggTkZTdjMsIHRoZSBzZXJ2ZXIgcmV0dXJucyBhIGxp
c3Qgb2YgcHNldWRvZmxhdm9ycyBpbg0KPj4+IG1vdW50cmVzM19vayAoaHR0cHM6Ly9kYXRhdHJh
Y2tlci5pZXRmLm9yZy9kb2MvaHRtbC9yZmMxODEzI3NlY3Rpb24tNS4yLjEpLg0KPj4+IFRoZSBj
bGllbnQgY29tcGFyZXMgdGhhdCBsaXN0IHdpdGggaXRzIG93biBsaXN0IG9mIGF1dGggZmxhdm9y
cyBwYXJzZWQgZnJvbSB0aGUNCj4+PiBtb3VudCByZXF1ZXN0IGFuZCByZXR1cm5zIC1FQUNDRVMg
aWYgbm8gbWF0Y2ggaXMgZm91bmQgKHNlZQ0KPj4+IG5mc192ZXJpZnlfYXV0aGZsYXZvcnMoKSku
DQo+Pj4gDQo+Pj4gUGVyaGFwcyB3ZSBzaG91bGQgYmUgZG9pbmcgc29tZXRoaW5nIHNpbWlsYXIg
d2l0aCB4cHJ0c2VjIHBvbGljaWVzPw0KPj4gDQo+PiBUaGUgcHJvYmxlbSBtaWdodCBiZSBpbiBo
b3cgeW91J3ZlIHNldCB1cCB0aGUgZXhwb3J0cy4gV2l0aCBORlN2MywNCj4+IHRoZSBwYXJlbnQg
ZXhwb3J0IG5lZWRzIHRoZSAiY3Jvc3NtbnQiIGV4cG9ydCBvcHRpb24gaW4gb3JkZXIgZm9yDQo+
PiBORlN2MyB0byBiZWhhdmUgbGlrZSBORlN2NCBpbiB0aGlzIHJlZ2FyZCwgYWx0aG91Z2ggSSBj
b3VsZCBoYXZlDQo+PiBtaXNzZWQgc29tZXRoaW5nLg0KPiANCj4gSSB3YXMgbW91bnRpbmcgeW91
ciBzZXJ2ZXIgdGhvdWdoIDopDQoNCk9LLCB0aGVuIG5vdCB0aGUgc2FtZSBidWcgdGhhdCBPbGdh
IGZvdW5kIGxhc3QgeWVhci4NCg0KV2Ugc2hvdWxkIGZpbmQgb3V0IHdoYXQgRnJlZUJTRCBkb2Vz
IGluIHRoaXMgY2FzZS4NCg0KDQo+Pj4gU2hvdWxkDQo+Pj4gdGhlcmUgYmUgYW4gZXJyYXRhIHRv
IFJGQyA5Mjg5IGFuZCBhIHJlcXVlc3QgZnJvbSBJQU5BIGZvciBhc3NpZ25lZCBudW1iZXJzIGZv
cg0KPj4+IHBzZXVkby1mbGF2b3JzIGNvcnJlc3BvbmRpbmcgdG8geHBydHNlYyBwb2xpY2llcz8N
Cj4+IA0KPj4gTm8uIFRyYW5zcG9ydC1sYXllciBzZWN1cml0eSBpcyBub3QgYW4gUlBDIHNlY3Vy
aXR5IGZsYXZvciBvcg0KPj4gcHNldWRvLWZsYXZvci4gVGhlc2UgdHdvIHRoaW5ncyBhcmUgbm90
IHJlbGF0ZWQuDQo+PiANCj4+IChBbmQgaW4gZmFjdCwgSSBwcm9wb3NlZCBzb21ldGhpbmcgbGlr
ZSB0aGlzIGZvciBORlN2NCBTRUNJTkZPLA0KPj4gYnV0IGl0IHdhcyByZWplY3RlZCkuDQo+IA0K
PiBJIHRob3VnaHQgaXQgbWlnaHQgYmUgYSBzdHJldGNoIHRvIHRyeSB0byB1c2UgbW91bnRyZXMz
LmF1dGhfZmxhdm9ycyBmb3INCj4gdGhpcywgYnV0IHNpbmNlIFJGQyA5Mjg5IGRvZXMgcmVmZXIg
dG8gQVVUSF9UTFMgYXMgYW4gYXV0aGVudGljYXRpb24NCj4gZmxhdm9yIGFuZCBodHRwczovL3d3
dy5pYW5hLm9yZy9hc3NpZ25tZW50cy9ycGMtYXV0aGVudGljYXRpb24tbnVtYmVycy9ycGMtYXV0
aGVudGljYXRpb24tbnVtYmVycy54aHRtbA0KPiBhbHNvIGxpc3RzIFRMUyB1bmRlciB0aGUgRmxh
dm9yIE5hbWUgY29sdW1uIEkgdGhvdWdodCBpdCBtaWdodCBtYWtlDQo+IHNlbnNlIHRvIHRyZWF0
IHhwcnRzZWMgcG9saWNpZXMgYXMgaWYgdGhleSB3ZXJlIHBzZXVkby1mbGF2b3JzIGV2ZW4NCj4g
dGhvdWdoIHRoZXkncmUgbm90LCBpZiBvbmx5IHRvIGdpdmUgdGhlIGNsaWVudCBhIHdheSB0byBk
ZXRlcm1pbmUgdGhhdA0KPiB0aGUgbW91bnQgc2hvdWxkIGZhaWwuDQoNClJQQ19BVVRIX1RMUyBp
cyB1c2VkIG9ubHkgd2hlbiBhIGNsaWVudCBwcm9iZXMgYSBzZXJ2ZXIgdG8gc2VlIGlmDQppdCBz
dXBwb3J0cyBSUEMtd2l0aC1UTFMuIEF0IGFsbCBvdGhlciB0aW1lcywgdGhlIGNsaWVudCB1c2Vz
IG9uZQ0Kb2YgdGhlIG5vcm1hbCwgbGVnaXRpbWF0ZSBmbGF2b3JzLiBJdCBkb2VzIG5vdCByZXBy
ZXNlbnQgYSBzZWN1cml0eQ0KZmxhdm9yIHRoYXQgY2FuIGJlIHVzZWQgZHVyaW5nIHJlZ3VsYXIg
b3BlcmF0aW9uLg0KDQpORlN2MyBtb3VudCBmYWlsb3ZlciBsb2dpYyBpcyBzdGlsbCBvcGVuIGZv
ciBkaXNjdXNzaW9uIChpZSwgaW5jb21wbGV0ZSkuDQoNCldvdWxkIGl0IGhlbHAgaWYgcnBjLm1v
dW50ZCBzdHVjayBSUENfQVVUSF9UTFMgaW4gdGhlIGF1dGhfZmxhdm9ycw0KbGlzdD8gSSB0aGlu
ayBjbGllbnRzIHRoYXQgZG9uJ3QgcmVjb2duaXplIGl0IHNob3VsZCBpZ25vcmUgaXQsDQpidXQg
SSdtIG5vdCBzdXJlLiBXaGF0IHNob3VsZCBhIGNsaWVudCBkbyBpZiBpdCBzZWVzIHRoYXQgZmxh
dm9yIGluDQp0aGUgbGlzdD8gSXQncyBub3Qgb25lIHRoYXQgY2FuIGJlIHVzZWQgZm9yIGFueSBv
dGhlciBwcm9jZWR1cmUgdGhhbg0KYSBOVUxMIFJQQy4NCg0KDQo+Pj4gSWYgbm90LCB0aGlzIGJl
aGF2aW9yIHNob3VsZCBhdCBsZWFzdCBiZSBkb2N1bWVudGVkIGluIHRoZSBtYW4gcGFnZXMuDQo+
PiANCj4+ICJjcm9zc21udCIsIGFuZCBpdCdzIGtpbiAibm9oaWRlIiwgYXJlIGV4cGxhaW5lZCBp
biBleHBvcnRzKDUpLg0KPiANCj4gcnBjLm1vdW50ZCBkb2Vzbid0IGRvIGFueSBhY2Nlc3MgY2hl
Y2tpbmcgYmFzZWQgb24geHBydHNlYyBwb2xpY2llcyBvbg0KPiB0aGUgZXhwb3J0IChvciBrcmI1
IHBzZXVkby1mbGF2b3JzLCBmb3IgdGhhdCBtYXR0ZXIpLCBzbyBJIGRvbid0IHNlZSBob3cNCj4g
ImNyb3NzbW91bnQiIG9yICJub2hpZGUiIHdvdWxkIGhhdmUgYW55IGVmZmVjdCBoZXJlLg0KDQpO
bywgdGhleSBkb24ndCwgeW91IGFyZSBjb3JyZWN0Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

