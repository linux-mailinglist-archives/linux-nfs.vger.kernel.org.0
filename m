Return-Path: <linux-nfs+bounces-3066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37E8B617B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FC3280D97
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849E813AA3B;
	Mon, 29 Apr 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Vmsdgzsi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F8839FD;
	Mon, 29 Apr 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417173; cv=fail; b=rirJRfYHwBuVS3UEUZzcMjgTdEIvr/qha5M3uYeaUjb7lNf5+ors5If9GzdYQDIxUvCQbrdQzQ3W36RsEiCuUnND7q+CLuhIlCeON8f8GkWgCZcNAA1RSqEE8OW/oAf8cSugFEWkcqM6WeJXHdOUGITLBFZnYXZ5ai6r8yNmKrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417173; c=relaxed/simple;
	bh=KUq9SriG2vNDxQDhgbQ0upf5pLOqEDFI+d0vzxla6rg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JgbgO+SazRGa0T+KzavICxgoRWAardMqO2Duk63NSUw83ScWME1CPDUlofZcH+zgP+KpQoLRIEalFUpsLHq4/u86ilawfdfSETtfrOSa6aVKfrjfPuCbSD+aFeMVKKol3gcRGwvzWEahQ3oSMedXeTscYzhpRxleYppQZek+Zow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Vmsdgzsi; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmFoY45V1YQIMHyGUFexi2EDjFQlBEKYxMH8K6eSHdKLYPsYouprzEtwKgxLYLMTz7YgvHR5BDtgUIE73E+h0UD/OPXGIIT0e9yopbbxsUbqs0HttpXR1Dlu+iLO5iqkoNI+o7Xq/pewXGbSoQCsawNQOB8zDgI8Cr1AuSP2DwOnZ2B871IPClD09t+jA0LpwAlN240n3W4F+GHiRjF1qAFjzT6eiYBpDY2swQ4RAG2TF9ZD764L4/ZOmTnpTGp55KZMpGbyOF1muvS8dQoVmS+WbVjr24EAgfXm9B94I8lyY1hNaf2/NsHjokIkf/mrg6f6mAsMBgylQ2nD+NTcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUq9SriG2vNDxQDhgbQ0upf5pLOqEDFI+d0vzxla6rg=;
 b=dlJ8RoZucsV2g/9aMHJOFSkD8gkZjWxDSGVItk6CWgbMg6GcPE6R3PSdEe072k2OY9AD8T5mIIPQj/3VYBPHBixvO3EbsN8BLf/HV2IF2n9AmdlT6j3wzPlbZtX7Y8sZeXCPrzRNuN6w3NDrMxbkpAxERCjwb7uTHdUIh7v7z/QO5F7WbQY4Vf7183mcAZG7P1YNsCRr4cIu2y/3otoQn1tNb/SDIdxl0Ro/Uw+0f6VVjhJgz8VH7CKmgQibT9DnHHEd1eyuby9EWIBGNXJRhjUjdIDfPemkM3FmFbGynjHyzH8QZxyXWAcz6M/BAi6D/mjL1JaCH3/Zkr1RH96Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUq9SriG2vNDxQDhgbQ0upf5pLOqEDFI+d0vzxla6rg=;
 b=Vmsdgzsi1aLGBH9Vkt8iQIygiW9AAe6Xag+CHs9qrtKh6VaMKLUFK9YeXlFXwar5xjv5aO6ee4nhmtiY+sVfUjFF1GZnKJ0vnuV5mDBcTnhhHbKpPD9YRpWE/B4XndJ8G0AtPsTjR4+BV2Fk/HybWq23S3wvdSPgUmzxqsC/hAc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5492.namprd13.prod.outlook.com (2603:10b6:806:233::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21; Mon, 29 Apr
 2024 18:59:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7544.019; Mon, 29 Apr 2024
 18:59:26 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Bugfixes for Linux 6.9
Thread-Topic: [GIT PULL] Bugfixes for Linux 6.9
Thread-Index: AQHammdbY+zi3HePKE+q0egDb34HgA==
Date: Mon, 29 Apr 2024 18:59:26 +0000
Message-ID: <230320fbf8c4a3fe3fcce24695aa4af65875bdf3.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5492:EE_
x-ms-office365-filtering-correlation-id: 3d7cd55b-327c-4f4b-d186-08dc687e7dfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eW1ON1NrZnI5THBCSUVDZml2eGprb21XdkgweDJBMGpuZkFWVmp6U1VHc0k4?=
 =?utf-8?B?K1FuYldaUnV3M2dNVVJCNUFSQURBeE9MZGdnSWY2a2RUTURVRG4rZzFGRUF4?=
 =?utf-8?B?VHJNM3c0aXBHeVBLNW1uZDJBaEd6S0MxeGYvZEJmWC9aenFVN2JNRFY4QzJt?=
 =?utf-8?B?Rlp6dk55eUVuSW9sVDNIUlFsdkVsNm0welFLeWJvS3Z4NUpIemFLNUhqb2Ri?=
 =?utf-8?B?R012T2Jnc2FVY3UzYU9YelVGZ1psZ1ZULzB6TWhURGl0RTdQT0RHdGwrRVVi?=
 =?utf-8?B?RitUWkdkWURtZUxHSDVKc1RCdjFKM0JURHhTTzlBOVBqa0JWMEtPbmhwRE9Y?=
 =?utf-8?B?YlhOMmZ5R0l6VTBNQ01WVFoxSG9KcUUzeU5iYkZjZTBlN1FJNjRpeVNmblpw?=
 =?utf-8?B?NlZGZnJoWTJjSlZCeHZiRlBxSHU3WjZIZmxVZ0EvREprdkJtRzkzZzNSM3Ji?=
 =?utf-8?B?b3p2WnZaRHB0am5HMUIvQXBVejlnM3ovZ09MWDVFTU9lalcrbEI5ZzAwWjl4?=
 =?utf-8?B?MEJGZytERjNodVdmbnZBcmVCa0NSVWJHR2VsUmNEazhzRENSbTRjZjZKUzho?=
 =?utf-8?B?bmV2Zkhvdys0eFY5NzVKenkydHd3R0lSUWJxTUxWRC9MTHVRanN5ZGtUQ3BW?=
 =?utf-8?B?dlVLaWxtS000cW12WmY4WGd3S3NyR1UvQ3JVQVVPQi9oaFk3bW1Za1RXU2RV?=
 =?utf-8?B?Y2hNMTVNQ0VRbVBQbk1oWlZBdjRqcjROVU1jQWQ0cUdPTWIrVGRBOTRsQXpt?=
 =?utf-8?B?UHlXN0ZGVnplWWpUSDlta1pVZW1mblV3MTU2YVp0dW1ITXJCWlduV0ZmQ1dN?=
 =?utf-8?B?eG5pMlJCL3pNeS9uM0twbWdJbk81a0dEVkVCOUVPTzFyTjBBMFBSdE9QSytL?=
 =?utf-8?B?RFBGQjVVR3RiaW9scHJ0WXRWTGFhZ2hqWmRNQmtOdHpiMS9zYW8yK1pjODB6?=
 =?utf-8?B?SEVadWVxUm05RmRNbmtkai9FUVpCNElNaEZTc0tJSDV3QUl6eWY0dS9YUEx0?=
 =?utf-8?B?WUtscXFUSUNuQ3lDZnpNemlzTnpIc2NRZkhrUWdtNUxnb1Z1LzZacFVHYjFI?=
 =?utf-8?B?bjJKNW1EWFRad3IwaHVycGhTZzd2dERLYTUrNnBVTkdRMlJ1bjNTc3pIOXJY?=
 =?utf-8?B?OG1qeXlnL3ptcWhDSXpzcUxvVmcvNG5OZ2FvbS9aZ3c4WnI0Rmpra3g0WUlu?=
 =?utf-8?B?WWZpRisycDFXNE9va0JTUW9sMWZ0YkdhZnIrQllCL29pdGtldVprdkkza2Fw?=
 =?utf-8?B?bDJyQ2ppOW1hT3g4NEpoeWl2aldoNVpUc0tUWEVIL3Z6aHo4ZzkwaGV1amwv?=
 =?utf-8?B?YVlRNnhqT0EraGRJS3FFMGpqc0VSbVc1eldYTXJIaXI4MFZyR0MwdWFCR1Bq?=
 =?utf-8?B?dWZoS1M4OGVVUHNuOSsyeEpKbW8wcUt3TkpkUGpocTRNQlpoZUoySGFBNHdp?=
 =?utf-8?B?Szg0a0o0QnUxZjMzZjkrTGpFS1VGZmxiRkJzcUN3Q3ZaQmQvbG9NT20xY1dD?=
 =?utf-8?B?ck9yWE1QbnZ5MStiOHIwbzdPK1IzaUd5MkEzUlpPUXpJVkVYMFI0RlFNQlk5?=
 =?utf-8?B?Z3JrSTBncUxlWGczVmxjSlBWMHhoR09rcmhuUHNQYmd2SEJJRjhLSUdPdjZr?=
 =?utf-8?B?Rm5Zb1F3NlZqN21PVlBYM3ZCUVVzM3JnQ2FBVE11OWl6dWhCYjdOTUtGVFBx?=
 =?utf-8?B?QmRkMzdEb3VDQ01ycWR1aUc5VStpbjhyQktKTGxQVXM4UzhTc1R1NWJZbmN4?=
 =?utf-8?B?WS9EWElMQmF1d3pjT1NVdnVxKzZ3Z3FsZDFFV000SGdIcmo2MWNUNGFSUnJi?=
 =?utf-8?B?cG9ZcnZUWmxnSWhLTmJDUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2V5VWt0RndCTC83TjkyTlhKOGNqSW9OdW94aTBsN2lUd09pRmw5QStDOW1u?=
 =?utf-8?B?NkNJZm9EaSsxcS9KYkRLb1I1OThnUE9WNDlvdWh5RGFOYVJ2dE1NVGR4dmJL?=
 =?utf-8?B?U0RTaHY1djJ0QUFxdVVPZXZlNlVwNW1QbDdibkRjb3NpYUxCMEZPYzMyZDlT?=
 =?utf-8?B?MmxuQU5hZzVYc1Z6dUYwSEdRVjk2SG1kSEZWSHJVaUh4NDBsMW5LaHd2Uk1Y?=
 =?utf-8?B?T3g2Zks5NjhLSnkvYzlVaDFqYW9mNTVxSHM4TFB6a1BBVXo1QkRYM3JnVDJ1?=
 =?utf-8?B?cEp0TlJuV2xVMCsrWGpBRFhBbEpTR2ZtL0ljV1ZQWUM0V2daVjBXSjEwdjFK?=
 =?utf-8?B?NzNtVm9JZXpnb21yNWZoRXIwMDNYS3VoZ2V4VndscURreEl5WUdKM0RwSmhH?=
 =?utf-8?B?QXJtdm56M1VuMDh2czNkc3ZqSjNuSWpHdXBEeUViNEZIcjZLRzJiNDlNMHZK?=
 =?utf-8?B?aWdnY3pndE5GTTFuNklpbThXR2dVeSs5aFp0elloK1ZTclNSWGsxVjFqdGdr?=
 =?utf-8?B?THlnUzRVN2hEbkd1YWR3UU5BbXZOL0dhbVV0SEJUMUV1dGFPQ3JibGRIdkFU?=
 =?utf-8?B?TFg2dnQxWXRTbnJRZ004R091c29BRDFzYllxYXZraHlFL1NLTDRkdzVLZXNi?=
 =?utf-8?B?aTlndVVmZEpNR3NoTm5CUU8xRjRPV1dER2hPRWFkUXZIQjdnUTdMMkxXenJL?=
 =?utf-8?B?THIwejhTeHpjM1pIcVJOZkkvakVvVXNzM0l0UlNFcVo2a2J1UTNrY0pkQitJ?=
 =?utf-8?B?YUROTFhqaDVHN2ZoSVVzQm9XNzhwQUtJRGxZNUhxM01tWVZWbEZkeGR4NnpU?=
 =?utf-8?B?dlkremFpVXMwWEVmVlNkbEszTWthNWxZNnovY3ZYWE9aZndCVE9yczRCRGx5?=
 =?utf-8?B?ZERpVVg2QWNSc0NTd3dTbWxkaE1Dalp1S1dmbmxpQkROemtLSk8wUlcrWksy?=
 =?utf-8?B?T2NzOWNveE5Hb1ZJUWovS1YrMlNIMEdUVXEyK2o2Zjl4bEFPUk9oYW1YN0Ew?=
 =?utf-8?B?Z1NZZktrKzFoMGRieWg1Y0tmMVRrU1lpYXdISEhsWnR3SWM0cEFPVUw3Zm9i?=
 =?utf-8?B?R2dUdHUyaUFWNUdtSHJqcDZ1YmI1T2lQdldHRkhZeDIwM09sL3crZ1pOVVlE?=
 =?utf-8?B?OG45WjhDS0d6Y3I3bXJ6dW13ZXZobjFCWk90cjV0TUZTS2pnaGd3VDc1Z1Iy?=
 =?utf-8?B?NHVKcHE5b0gyRHVoVWNXU2xhN2NZMVRwK3BKL25wVld2Z0FxUk8yZFpSTGRJ?=
 =?utf-8?B?QUM4bkhXb3YycVVYcU42UDQ3V1o4cWpqZzV4ZTZsaStrenNoLzVxZEtidytP?=
 =?utf-8?B?WWtjU3ppdFF4SWJwdFRoWFZvQzJ0ZkV0MGxoQlRyQnM4MHRBWGwxM3BKNE1O?=
 =?utf-8?B?alQxODU0K3hrNjlZQWsza1YvWkZ5R3h6Q0ZRK1R2cUNoWTVQRHlGT28weWpL?=
 =?utf-8?B?RS80NUxUeEtlOUVZakRuOVZudWdLVUo0Q05jV1FWazJTMkZidFM2L3o4SjQ2?=
 =?utf-8?B?L2FPbkR2OU0yNDlRWFdVVWVmN2lXN0NwaXZxWUlZNG5JTE01MWhlTXpUM0h3?=
 =?utf-8?B?T01MWm0zdFRVTytFcWc2UWtsbE4vYnlnMjJtWHB5dzg5WGptV0dXL0lYWmM2?=
 =?utf-8?B?SEtJRjY5REdQQXROeHdxeDFJamI4QnNvZW5XMllXRm9hSURZTlk0WGQwdGcv?=
 =?utf-8?B?N3VEdUVZV0F6ZHZTU2FDNGc2bGV6eTBaa2d3cmxFbFRMRGVhUDhNcmJFN3Yx?=
 =?utf-8?B?anh6bDJBM2ZORmk0cWFSSEZrdWJuQld2ZHlPVGdmdDh2Yzkwb1dHZlBPaWh0?=
 =?utf-8?B?bFYyY05qaFNWY0dFSkhNY20xaWVLR3BBSnFMcU1HVi9vOUY5clRWZWFCUzhk?=
 =?utf-8?B?NnNlclBhckdLbW14MnpHN0h5SFM3eCsyNVlEV3Awd0FYYzNVbE1leFpVYkkz?=
 =?utf-8?B?MDE1YWpFb2owRm4ySVdJd3RCNnZJcU5GbXk1TGhkTjIxZEYvNmp5WDVycVlr?=
 =?utf-8?B?UG9GSDZLMTFzMkJ1N1FkUUZIdzB2SlhKU2FTUUMwV1lVd1pOOHRzL2QvdmdL?=
 =?utf-8?B?ZmZqV0s2dGxFSTJESGdkanhFSERiRFBIbGRYblBpVndEYmo3cldEYXJoZVZN?=
 =?utf-8?B?SEVOVTA0eWxYOEZPOUtsb2xqYnpNSFdwOEUrK0U2TGM1c29IVkc0Um1pZ05L?=
 =?utf-8?B?ckNOQ3lSR1FpdjlTTHIxSE9UVEZEZ3lFd2tZREhKdVFLMTh5WHhncmZBUUtM?=
 =?utf-8?B?WXMyZFZCOFJmRno2NThiMDZyeHRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD0F4186B35678429F5C19CDF9AA38FB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7cd55b-327c-4f4b-d186-08dc687e7dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 18:59:26.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUDp40wbZv0sLbJ4jZNEC3nza68W1kGmnV2OesG8FJYVdgy+K2Z3y9STOYzHs8/Rs1paqh03JSYS+HRlMCb1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5492

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNzE5ZmNhZmUw
N2MxMjY0NjY5MWJkNjJkN2Y4ZDk0ZDY1N2ZhMDc2NjoNCg0KICBuZnM6IGZpeCBwYW5pYyB3aGVu
IG5mczRfZmZfbGF5b3V0X3ByZXBhcmVfZHMoKSBmYWlscyAoMjAyNC0wMy0xNiAxMjo0MTo0NSAt
MDQwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0
Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3Mv
bmZzLWZvci02LjktMg0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMjQ0NTdmMWJl
MjlmMWU3MDQyZTUwYTc3NDlmNWMyZGRlOGM0MzNjODoNCg0KICBuZnM6IEhhbmRsZSBlcnJvciBv
ZiBycGNfcHJvY19yZWdpc3RlcigpIGluIG5mc19uZXRfaW5pdCgpLiAoMjAyNC0wNC0wNCAxODoy
NzoxMyAtMDQwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNsaWVudCBidWdmaXhlcyBmb3IgTGludXggNi45
DQoNCkJ1Z2ZpeGVzOg0KIC0gRml4IGFuIE9vcHMgaW4geHNfdGNwX3Rsc19zZXR1cF9zb2NrZXQN
CiAtIEZpeCBhbiBPb3BzIGR1ZSB0byBtaXNzaW5nIGVycm9yIGhhbmRsaW5nIGluIG5mc19uZXRf
aW5pdCgpDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCkt1bml5dWtpIEl3YXNoaW1hICgxKToNCiAgICAgIG5mczogSGFu
ZGxlIGVycm9yIG9mIHJwY19wcm9jX3JlZ2lzdGVyKCkgaW4gbmZzX25ldF9pbml0KCkuDQoNCk9s
Z2EgS29ybmlldnNrYWlhICgxKToNCiAgICAgIFNVTlJQQzogYWRkIGEgbWlzc2luZyBycGNfc3Rh
dCBmb3IgVENQIFRMUw0KDQogZnMvbmZzL2lub2RlLmMgICAgICAgIHwgNyArKysrKystDQogbmV0
L3N1bnJwYy94cHJ0c29jay5jIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=

