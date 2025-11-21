Return-Path: <linux-nfs+bounces-16647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C7C7B68F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 543A33654FD
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8812FCC12;
	Fri, 21 Nov 2025 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HKg4m7UB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from iad-out-009.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-009.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.198.94.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386D2FCBF0;
	Fri, 21 Nov 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.198.94.229
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751398; cv=fail; b=gRzds8w/5vuCgP3gR1i7hgoYXd1MnIRVJ6Vha1MTLNkl4mjkOGtf3W6onFoYde6wYgLDPApUvrmtPGb8HW+HFnjl+JM6fVoLslF8RNBiz6ADA3majkNLbLHR9IDpX9zFLOGZSZhTs4zCHVrpBpRpYez+4/cJMq/Brcj3QWaWqL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751398; c=relaxed/simple;
	bh=fRWzpQ1okcJAuh/cUOmi/2lDDCE5NpSKtiizvGh2s2g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mKi5JSo1dE1QNS6tU1S8tf8Pzr1CJD0H/ZShkVPjkAOqxaqVb/FYpBXNrAiRAr2TqZ5o2DUevZZVeRWBPFeqStjGb6+7NJ7J8eYA3kecFECgBcBQTEFm62O/vcbfkIWDAMPZbmzR0Wd15ZMoexBO6U/oTNqEeK0UKASkGIiTGzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HKg4m7UB; arc=fail smtp.client-ip=34.198.94.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1763751396; x=1795287396;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=fRWzpQ1okcJAuh/cUOmi/2lDDCE5NpSKtiizvGh2s2g=;
  b=HKg4m7UBie8Qkmcyz/uzGmS5U9yJAGXfJ2sCTvhJTDHegScak+r+SuK7
   gyCElDSBveSiUlyi1iGZfNURtcSTVQG0J8b+PDY4y5vttiC3ktotqFIgQ
   zcPFfE1PhbUZjfAeDWZ3bX/GOXby0FawUiXCmNHpSGAdKAyZjA+vbntQH
   6A4k3Gs/RXNFjN/lQqTBPY+udCczkor7Hzg4ocI+c2QDQICk43J4vQ49r
   uIKENP86PewhYsWSmCTA2DPg3i+sZ0nYNqDh2lOsoiTKhg4jYJC3SANiS
   AY+iWULpU55d+Aru1MHjlBjByauI5jAZUKucNsE6wWu12OjJ0IQcd/oXd
   A==;
X-CSE-ConnectionGUID: F6BRLAzIQCuNqNFVFueU1A==
X-CSE-MsgGUID: +bkrDHSHQW2UDQxj4/KKgw==
X-IronPort-AV: E=Sophos;i="6.20,216,1758585600"; 
   d="scan'208";a="6855679"
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-009.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 18:56:35 +0000
Received: from EX19MTAUEA002.ant.amazon.com [72.21.196.65:25586]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.18.7:2525] with esmtp (Farcaster)
 id 549f9155-5817-41cf-bf6b-4ac611a35fa6; Fri, 21 Nov 2025 18:56:35 +0000 (UTC)
X-Farcaster-Flow-ID: 549f9155-5817-41cf-bf6b-4ac611a35fa6
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 21 Nov 2025 18:56:34 +0000
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 21 Nov 2025 18:56:34 +0000
Received: from DM5PR08CU004.outbound.protection.outlook.com (10.252.135.42) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29
 via Frontend Transport; Fri, 21 Nov 2025 18:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ7D5Twtvn6rvhCzOON/Qwj7rF87JD2T1+pvgv2p5RThmoYmdkIQTl2SenHXVQ1HKSnM+Mt2fCr3nlQxDoMWgaheuWf+An3VIaORzSMtz0AnEpgvc+elsXc15i80Mwyim1iREQ67tkrxnPG9dwuzp3SqmrvEs/Qp6IfdXSthDKcYmTZM5VlkdZnwBjmQvQ3ieKCKHOmCtgQMbs8siwuSFAQaPFAlqoKH2DAGZiqXv+DQ4Xzg96IPachpw5RuCwXxrR3TPgX75aeb5cQYLH0Q7N3YsF8ENqPQcifprXDI9koXkPga7XFENkjKwzi/qBxfaJR6KbJhbCg24M2tGkrewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRWzpQ1okcJAuh/cUOmi/2lDDCE5NpSKtiizvGh2s2g=;
 b=Brirqs1lP/lDBB3D4hRCpZybnO/PMpej/ghz6S4xaCrR3i51VnW9j2Uteej4b3XNzvbP4shaLgaX/hXxm9UUQ88v7bWZEnfxIl+pkxG5mytVZY8GHFH6DgLs9Po4N2xrbgv9PyvtAQ7icS28lsBliHuGJ95nfA46Z/wphmVn+ls5IjtVF2hd0oO5NMHyq8hTsKAKaf7NAkDqrOdtwLbyxytwgGhWUASdLcfrHe4t/ATGSqSS0MikhjWhZ2Aax4Mkxtwnl9Tk1WY6qNNaiG15wO/BrUkIXjEl4LopVrREf0oDslc7eGUhM9AowXbm1xJPMuPEu/zaxg4z8a3WeDzkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by DM3PPF1A9A8EC9E.namprd18.prod.outlook.com (2603:10b6:f:fc00::690) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 18:56:31 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::9a58:c0fb:e29:3050]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::9a58:c0fb:e29:3050%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 18:56:31 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"trondmy@kernel.org" <trondmy@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [REGRESSION] nfs: Large amounts of GETATTR calls after file renaming
 on v5.10.241
Thread-Topic: [REGRESSION] nfs: Large amounts of GETATTR calls after file
 renaming on v5.10.241
Thread-Index: AQHcWxiMmeo0LJQemkqaW9Epcy8Gnw==
Date: Fri, 21 Nov 2025 18:56:31 +0000
Message-ID: <F84F6626-B709-4083-9512-5F48FE370977@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-11-21T17:54:40Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=a8fed289-f643-4c26-983a-abca054f4de4;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|DM3PPF1A9A8EC9E:EE_
x-ms-office365-filtering-correlation-id: 2da28c0d-adfd-41f4-bb4c-08de292faf72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aTZiVUFNYjFLLy9CQ1BKWk5FcVRINCtqVXdldzg0NkFTYjRncFNwTWFSS21y?=
 =?utf-8?B?OG85aFcreXRKalVDVHhIa3pxSkt1by9seGxBNHIrVEVCb2g4N1FxT1V5VFE2?=
 =?utf-8?B?bjk5SmVrc2ZSZzMxSDZ3Y2hVTVFEcFE4WjJpeFp4N01sRlJKVExIOTEwYU9F?=
 =?utf-8?B?cjM2R0hpelNJVVNnQlNvVGtjbHk1a1RWSkxtOXJjckpCU2ovcEhFaTcrci9D?=
 =?utf-8?B?VS9zUG41OUVQRVdHOFNNWFVzMS9VTW5aTHFabDl2YTJ0Tk1GT1lKamVBeHlv?=
 =?utf-8?B?ODUzaHhWSGthMDhkMWUrNThENEQ1dVRXMnZSclBpbkpJdktsTWx6QmlRNDN1?=
 =?utf-8?B?bmtXWk10azlPbTJ3QTY1ZlFseU54RzJRcGpXdkw1V2s2MGN3V0IwZjFjZnll?=
 =?utf-8?B?Z0g1RTFTdHN3Y2pibUxNRmUvZ1BTTEhvZlNjaEc3SkNiSkFBbzloUzM4OS8r?=
 =?utf-8?B?WU9PclpOaC84U0pOcEdYdUlJT3lwR0h5RENlckZoajNxTE9CWFRZclVVNzUw?=
 =?utf-8?B?QmtpMzloTktwWGFWZ3hxeWtnNmxzbDB2eHRWSW9ZYStZZjhmMk1GbHBVMi9L?=
 =?utf-8?B?Vm9qdUg5MFFLdkg0VWg4KzgzOTBiL0V4UlQvdDU0aEtheWxvWVNpQWVYbHZJ?=
 =?utf-8?B?MHBMSGR2RXRWeWNOYVZPeGxId2lPODZJc3ZPTnNJb2hwdUsxVGhUMmxuQmIx?=
 =?utf-8?B?bi9FTE1jazRYMkx1SGhYRXNnendUL1k0d2VWdHpRRHNUVG9NTHlnY2dMQkNp?=
 =?utf-8?B?OVlHanNBVUFBdE9HQjIzT2NFZEY1RU00NXl3Skg5cmtLRUQvV0NnZHl2VU5M?=
 =?utf-8?B?U2xvZitNd1BBNTBuUFVKa3FWUVp6dG0zT3ZXZlh3Y2F6Yno4dEU1dlRBYWVN?=
 =?utf-8?B?bk52Mk1OeHNoTUFpUlg3MkFlRStSMytrRlNheTNDM0FjbkpuZGw3dTh2UC9v?=
 =?utf-8?B?OHQ0RGhQZnJGd3VPUDhVSzJHcjQ5QXNjSmtubmlrVkxONTBncDc2NEozSzVR?=
 =?utf-8?B?Yk9WU3lURkw5OWtqWnVQZWVNR2o0VnRLWE93a25xVU1DRVNmbFh4a0FCeFdj?=
 =?utf-8?B?ZDArMEE2TWgrU2FyVWVxRUxrQzlQckR2ci9QWHFpMjBrUDdDeldzNVJmMUJ1?=
 =?utf-8?B?eGIxYlc1eVJpTjJSNzJHMEtKZXZ3TkVLNVFjMUV4NEd3b0FUS3VDS0VMVmh5?=
 =?utf-8?B?eFhsTldDY2pjTHRDUXRiL09ZaWQ3cnorbi9rM2VmaEdsdU9Qd3NQbUxEN3ZV?=
 =?utf-8?B?RnZHbmFvblJvUmtaMTZjTDdBY3ZVemNSQWJOSE5Sa0ZIWTdtVEpYMW9ydkc2?=
 =?utf-8?B?MVJQWFZJcS81SkF2b0RaNFRCOHZJVHFMRTM0dXJmbHhXajhuYzhtTEdEbXV6?=
 =?utf-8?B?MHdKb08wNzhCY2xFMUhwOVFuRUZVd0hOaFAzaXNGUjV1RG5ud2NGRUxaU3dY?=
 =?utf-8?B?TitoRXg2TG9sNWR5Zk1sR2Uvc2UzQ0tDbzBIWlRJbmgvQXVoTk1DdTB4ekdj?=
 =?utf-8?B?SDU2WDhTQkQ1aFNZVWFHMWJLU1BiMlFYTHVDZ3BpS20vYVlqZlFpVW1Zb1pn?=
 =?utf-8?B?VlBWUVJnckg2dW43L045MGYySFlJdWdjc3ZCS0hCQnJGVmsxZG9FaW0wUE5j?=
 =?utf-8?B?ZEpYMVhhRkJmdzVOWFQ0QzVTcEpEaVg3cm1NMDNZWGcySDNKeDZaUGJlTWY1?=
 =?utf-8?B?UHlYUGtaWll5K3JMY0dJN3pPU0xSTUJqVjJGMGR5c01jNlRNK0c1UTJ1eWVz?=
 =?utf-8?B?NXhqNlNtWGZzTkhCS05UN0FGT0NlNXJOaW5xMHZLSU5XMXF2ckIrY2R6eDdE?=
 =?utf-8?B?bGc2UFBFVW5qL0VqZnYzRms2UXRaYUo3V1I2VENFbDhicUZ5bDMwalB4T0NQ?=
 =?utf-8?B?cEFuWjNQREExS3dmdWduSnYxOVlxUDVMMnlBQkZDZjFOS29SeTI2dTZhTWRu?=
 =?utf-8?B?SkFrK2ZSMFJYaVFKRzFyVEdGQXgwRHgzdDFIbnVqcmorTFV1NGlXN3VONnV0?=
 =?utf-8?B?a3Blek1Odytkbi9YWU52cjdJN0liVWRsOFA0L2duWndQbkZScXJVdGcwNHZn?=
 =?utf-8?Q?nVVHvg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWg1R3hKZW9WcmVJcnh1anU0MHZYY2lYcWQycGtDYVVNa1NGNlZkUmhrZ1FW?=
 =?utf-8?B?aGdKTkNOaHRGNW14YjRZY3Y5SE9xdlRmb3RjTmVMOTl2WklEOGkzTnZXMmRL?=
 =?utf-8?B?ZFJBWnhRS2RKanZ6YUV4c3JPSHBsYXlTWHhIbk5xWG9CamJHeVRQRUtEUGM4?=
 =?utf-8?B?ZmhQR0UvNUNXelNDcXNtc1ZrMnVzT1Jobnh3T1dmZFBUZWs1c05oSURUUHZk?=
 =?utf-8?B?bmlTN25BeEZlZGY2M3RRMXRiOHppUjBPMTkrOXdqMFI5SXZLM0lUVmRXRDlR?=
 =?utf-8?B?bUliS3VVakNxNXlQY3VqTUw2NFg3MHdqVW02Ri8yOTNoeXBaMWQxMEhpVmU5?=
 =?utf-8?B?NlU0OTlGTFE0TDd5T3cxeDR4dFo1VEtKSS93QTIyOU05QWJFeW9HK2lXVjNs?=
 =?utf-8?B?WjNVRjZSckVxcGhWeENHTnlwbE8zQm5TNHlqc3lsVFlhYWh6U0NuWWtvTU9n?=
 =?utf-8?B?ZFh1empKS0l6U0VvZXZnWGlXaE1pMUUrWkU0ZDBFUzlNRWlIRFVnSnlsZGpU?=
 =?utf-8?B?TlI0bG1lSnhIM0JBQm4rTkxza2hDL0Y0YVVVcXIySDNyTmpEUmkvYjlYZXFZ?=
 =?utf-8?B?bDJwTjl4b3gvMDNOc1I5QnFrcjhEYW5ML2xxMWlreXFSM1pBeVJZVlNOcWRp?=
 =?utf-8?B?eXBIMVpJS2ZUb1dGUDhiR3hORjRramEwVmxuWE1FTkFOdlMrZlZqVCt5M0Ez?=
 =?utf-8?B?N2xjT1ZiOW5BL1ZOaDNUMkpNNVZsVmVnVDNlcDkzRGRpQ3hQMi9rWFRiVHFV?=
 =?utf-8?B?NGJxT05ka2tua0RJbXl6UE5MRFI1akF2d1gwcldzQTIwVnhoL0FPL0dXVkNX?=
 =?utf-8?B?VFhKVUtsRW1YQ1k0bUNHdlFSc252UTNRT2tWWnN3Z2FPNFZtSmYrQjVXV2ZS?=
 =?utf-8?B?YXk0TlQwODZOU1JyUUNhVGFhbE01MitCSWhZbmFHcnhHQ0IxZjRvSnFFVUU1?=
 =?utf-8?B?d3l2a2ZEZkdkRFVvOGgvd3U5cEVEc050Mngwb2ZQbW56RWdBWFZ6bFdRdkts?=
 =?utf-8?B?cHhXajZ0M1hxZUdoR1ZKbDhXVU13aE5KUlNKQkxwZmFCa1l5eE9FcHVJd2hH?=
 =?utf-8?B?b0ZaenB2OUtUQW5mOGQ0WWtHclVFOVhwVmowNU9yODd6bVZFa2VuanhuQlpV?=
 =?utf-8?B?a3J4UmczeFd1Q3FqRngrRnNQMEYxY0dvZVErZkVuSmk0S3A2MjA5RDBNclNK?=
 =?utf-8?B?OTJ5MmlqeGM2WGh5SmNIY2wyZFZJVjN5djUya29UMXZRTTlIaWI5dHZyR2VH?=
 =?utf-8?B?a1lIM1YxMW9VRlYrWUVKcXQyTkNNVms2UHF1OFJsVHpQcklYMzJIbnFlZlNi?=
 =?utf-8?B?ckZaSDBqUU5RNDBvdFlZSkhzcVFFQzlDVHJZdlEzRXFseWZDYWJkZGdTTmZo?=
 =?utf-8?B?SGMvQk5kRHBmMWhlUGp0cThXbnNWMUhPQUE2RzJtbVlNdmJZRWt4TGQvRklI?=
 =?utf-8?B?N1dXVnN2NkdZbTNBN2dLZldRZ1dvQ1ordW9sdDI2NE1wSlgyZFJtNWdDSDE4?=
 =?utf-8?B?TFhncjduVFRxWm40Z3BxLzFUa2tOMHlmeGNIL3plUHYyTlJ2N2Z6UG9ObVcr?=
 =?utf-8?B?djBRYjlVY0ZHaUdJWnRGOS96YWd0VndZSEFpM2F1YU9ZeU4xOHYzWmF2T2Nl?=
 =?utf-8?B?dXBZYnFUVkNoOHVnV2x4Y2pMc3kxMi9LM01OZkJtbzRnQ0ZJejFtZVBNYm8r?=
 =?utf-8?B?V1cyODhPU2Nnd1BDQlZCakd3VFR2c1dDVTYyRnZ5b0dFZEI1S0hKNEh5UGE0?=
 =?utf-8?B?a3pJQVVpMzMzMjNoc2JZdzlrdjEzSG80blZhbmZUTGRmQURXN1lKb0tIV0w3?=
 =?utf-8?B?cDcyQVFJUG15YlR2MVlEdmNpNGxYTVpYNWZSSm9xRFFNS3hyUEU2WWF2NXg2?=
 =?utf-8?B?ejgrR2dhOGNCRlp3ODZaSGJZQjNlTGJUZE4vaCtsbmoyK1lrWFJqRnRrSDln?=
 =?utf-8?B?ZG12Wng3ZVlBWHM0RnNpMHFVeXJaczFRLzJJdEdtdVNHdFYvRjBaem1sV3Rs?=
 =?utf-8?B?WG1rY01mTUJPUDc5SmMxSGU2d01kdDluTzR2SFhKQ1FOZVpwNThoYXgvTUgv?=
 =?utf-8?B?WXd4ZVpNSnhPUkpMOExIWkZyQUR1cW1EUlRmWWV3cnJvTGJkdDFXTnJiVmJK?=
 =?utf-8?Q?Wr3qvZXy2wmOdKcLKE6AhcdH1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A28223FAC1DF734B8F614C67024AFD7C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da28c0d-adfd-41f4-bb4c-08de292faf72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 18:56:31.6457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5muWHabH9gCRKmaG8W91sLUbmX8OQMLxQ5vRq+J9ztFPoi9aU0ZGmk5trYLkAZs5gjVvYDrx/BNCYaeczT3/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1A9A8EC9E
X-OriginatorOrg: amazon.com

SGksDQoNCldlIGhhdmUgaGFkIGN1c3RvbWVycyByZXBvcnQgYSByZWdyZXNzaW9uIG9uIGtlcm5l
bHMgdmVyc2lvbnMgNS4xMC4yNDEgYW5kIGFib3ZlIGluIHdoaWNoIGZpbGUgcmVuYW1pbmcgY2F1
c2VzIGxhcmdlIGFtb3VudHMgb2YgR0VUQVRUUiBjYWxscyB0byBtYWRlIGR1ZSB0byBpbm9kZSBy
ZXZhbGlkYXRpb24uIFRoaXMgcmVncmVzc2lvbiB3YXMgcGlucG9pbnRlZCB2aWEgYmlzZWN0ZWQg
dG8gY29tbWl0IDczNzhjN2FkZjMxZCAoIk5GUzogRG9uJ3Qgc2V0IE5GU19JTk9fUkVWQUxfUEFH
RUNBQ0hFIGluIHRoZSBpbm9kZSBjYWNoZSB2YWxpZGl0eSIpIHdoaWNoIGlzIGEgYmFja3BvcnQg
b2YgMzZhOTM0NmMyMjUyICjigJxORlM6IERvbid0IHNldCBORlNfSU5PX1JFVkFMX1BBR0VDQUNI
RSBpbiB0aGUgaW5vZGUgY2FjaGUgdmFsaWRpdHnigJ0pLiANCg0KV2Ugd2VyZSBhYmxlIHRvIHJl
cHJvZHVjZSBJdCB3aXRoIHRoaXMgc2NyaXB0Og0KUkVQUk9fUEFUSD0vbW50L2Vmcy9yZXBybw0K
ZG9fcmVhZCgpDQp7DQrCoMKgwqAgZm9yIHggaW4gezEuLjUwfQ0KwqDCoMKgIGRvDQrCoMKgwqDC
oMKgwqDCoCBjYXQgJDEgPiAvZGV2L251bGwNCsKgwqDCoCBkb25lDQrCoMKgwqAgZ3JlcCBHRVRB
VFRSIC9wcm9jL3NlbGYvbW91bnRzdGF0cw0KfQ0KDQplY2hvIGZvbyA+ICRSRVBST19QQVRIL2Jh
cg0KZWNobyAiQWZ0ZXIgY3JlYXRlLCBiZWZvcmUgcmVhZDoiDQpncmVwIEdFVEFUVFIgL3Byb2Mv
c2VsZi9tb3VudHN0YXRzDQoNCmVjaG8gIkZpcnN0IHJlYWQ6Ig0KZG9fcmVhZCAkUkVQUk9fUEFU
SC9iYXINCg0KZWNobyAiU2xlZXBpbmcgNXMsIHJlYWRpbmcgYWdhaW4gKHNob3VsZCBsb29rIHRo
ZSBzYW1lKToiDQpzbGVlcCA1DQpkb19yZWFkICRSRVBST19QQVRIL2Jhcg0KDQptdiAkUkVQUk9f
UEFUSC9iYXIgJFJFUFJPX1BBVEgvYmF6DQplY2hvICJNb3ZlZCBmaWxlLCByZWFkaW5nIGFnYWlu
OiINCmRvX3JlYWQgJFJFUFJPX1BBVEgvYmF6DQoNCmVjaG8gIkltbWVkaWF0ZWx5IHBlcmZvcm1p
bmcgYW5vdGhlciBzZXQgb2YgcmVhZHM6Ig0KZG9fcmVhZCAkUkVQUk9fUEFUSC9iYXoNCg0KZWNo
byAiQ2xlYW51cCwgcmVtb3ZpbmcgdGVzdCBmaWxlIg0Kcm0gJFJFUFJPX1BBVEgvYmF6DQp3aGlj
aCBwZXJmb3JtcyBhIGZldyByZWFkL3dyaXRlcy4gT24ga2VybmVscyB3aXRob3V0IHRoZSByZWdy
ZXNzaW9uIHRoZSBudW1iZXIgb2YgR0VUQVRUUiBjYWxscyByZW1haW5zIHRoZSBzYW1lIHdoaWxl
IG9uIGFmZmVjdGVkIGtlcm5lbHMgdGhlIGFtb3VudCBpbmNyZWFzZXMgYWZ0ZXIgcmVhZGluZyBy
ZW5hbWVkIGZpbGUuIA0KDQpUaGlzIG9yaWdpbmFsIGNvbW1pdCBjb21lcyBmcm9tIGEgc2VyaWVz
IG9mIHBhdGNoZXMgcHJvdmlkaW5nIGF0dHJpYnV0ZSByZXZhbGlkYXRpb24gdXBkYXRlcyBbMV0u
IMKgSG93ZXZlciwgbWFueSBvZiB0aGVzZSBwYXRjaGVzIGFyZSBtaXNzaW5nIGluIHYuNS4xMC4y
NDErLiBTcGVjaWZpY2FsbHksIDEzYzBiMDgyYjZhOSAo4oCcTkZTOiBSZXBsYWNlIHVzZSBvZiBO
RlNfSU5PX1JFVkFMX1BBR0VDQUNIRSB3aGVuIGNoZWNraW5nIGNhY2hlIHZhbGlkaXR54oCdKSBz
ZWVtcyBsaWtlIGEgcHJlcmVxdWlzaXRlIHBhdGNoIGFuZCB3b3VsZCBoZWxwIHJlbWVkeSB0aGUg
cmVncmVzc2lvbi4NCg0KI3JlZ3pib3QgaW50cm9kdWNlZDogNzM3OGM3YWRmMzFkDQoNClRoYW5r
cywNCkFhcm9uIEFobWVkDQoNClsxXcKgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIx
MDQxNDEzNDM1My4xMTg2MC0xLXRyb25kbXlAa2VybmVsLm9yZy8NCg0KU2lnbmVkLW9mZi1ieTog
QWFyb24gQWhtZWQgPGFhcm5oYWhtZEBhbWF6b24uY29tPg0KDQoNCg==

