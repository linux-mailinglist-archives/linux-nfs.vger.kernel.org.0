Return-Path: <linux-nfs+bounces-3375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F328CE89C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CD7282019
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBC12E1FE;
	Fri, 24 May 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="d7+ZZiWx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2118.outbound.protection.outlook.com [40.107.220.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B012E1F9
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567949; cv=fail; b=RE1MoNbtCzfTE8WtOVz1GrM2xXCpwCPpeVPSCD0NU5VFXxJ47W3HNqfJGX2AHn6zdJEIAMwdXUC8uQS4W9zadQ9Cj5XeF8tBIR7k1bis7JPXoqdXQqAMWrqshvKLoAJCbIQzqxju9cPSUTFZxNIY1KRaQQkGF595iulOdW87Rww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567949; c=relaxed/simple;
	bh=PRBwYe6XtXmY4nhr4c8raEmD9frFYNEUaisse2DfZgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLQjbxFw+z4KNlhUmwGkoh1CnCvjzzkDqO91hralqZoCOAwwWR0kS3OkJJlEBbsqYi8F3zmZVwINTFJBxhw2NKncrK58CWQJQRo1vp7hA0CSl0oRyr4SQ+PQRDxTQqtiCgcyO5mTj+6Ohtc/Lwjj+VgrZlDAJXOKO7MNOKbW6Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=d7+ZZiWx; arc=fail smtp.client-ip=40.107.220.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLkCw9aWfzzOm/KA77rBJIvkowh1qhSK7G8XBquj8R87PnvD2gKTxhqa/irH5eeSWzTlwASx7NwzVwVUV9H3iuMpGvlxZENq/LM87po+Cno3Vb2tGYKK7LfCY7miEP2PNtn0iHA77K+qhTCE9GYQ2Gz1UvA9TMfsHlHVi+kVTmGLSpqXErPI21KWrHd65Aq764xrQLFq2qZ50/BQpCp7ElqgLexdFsSXna95UqYaWDgFiLnijmcz17M4CBZO9xOAQ4HWSrGahO4fgPaQ8t+xXdiP4Xx/oawBOBWrkaxGF45W2r8zlXtUE3CiuWTwZzh9cBUqJ6tlLfzt2ztA77611A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRBwYe6XtXmY4nhr4c8raEmD9frFYNEUaisse2DfZgw=;
 b=RTF/zewx3Pl3ALUgot5vH1A7Q6QQyvs2k7gTalUqVXDSOFbAlKgLBg01+vmvRTBqJTdKTYEoklHkN7g0DeYbDAST6MF0f79cF6Bwkl/OVHV2sL7Ve5ryPPNY1N4tl6jP07G42RlZ9576MpB8m3W0ZFewvHGQJoQs3+KV0zZCWH+ixOofIEYl9WDJqgiqPEFiexVhqYyBHnaeVvnLMB0boFY/gSm+IODmMPM9zFOBeS6601NP+JmRUQvfRliFVe/Sc/0kKmfD/e13BZwEm6yH1b96t15NGTd+00L1xBHL2zo8hLuwAcIxfDnvU010sZyev+ruUXxo2Mz+DTvTiZEnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRBwYe6XtXmY4nhr4c8raEmD9frFYNEUaisse2DfZgw=;
 b=d7+ZZiWxQqTnt+FdnNpMnk5dnryRVMxO4FHXEcxNKWrusXFLdwwPKgwP78xxp3hb528mYB9y/wVYkMWRJzDdaQIF1/A5DWfkxns1iK0VJ96fNadM7x95fzsPAq+fu9pwB0omkk6A1rzahUwb/GCMYmWKTEAQk20oJ8izzCXsSTk=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 LV8PR13MB6624.namprd13.prod.outlook.com (2603:10b6:408:22c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.12; Fri, 24 May 2024 16:25:41 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Fri, 24 May 2024
 16:25:41 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jack@suse.cz" <jack@suse.cz>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: Avoid flushing many pages with NFS_FILE_SYNC
Thread-Topic: [PATCH] nfs: Avoid flushing many pages with NFS_FILE_SYNC
Thread-Index: AQHarfV5bu5SQHhb9UG2n9T/2YJeeLGmkh0A
Date: Fri, 24 May 2024 16:25:41 +0000
Message-ID: <16343342830b912155cf475ce8c5f2e79aaa0169.camel@hammerspace.com>
References: <20240524161419.18448-1-jack@suse.cz>
In-Reply-To: <20240524161419.18448-1-jack@suse.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|LV8PR13MB6624:EE_
x-ms-office365-filtering-correlation-id: 725348fa-8178-4ff7-905a-08dc7c0e27b5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWlRZ1hoRzRPN25rM1Bib0pTYXR5dGI0eFdLcW41L1p4RVU4VDFmN3JiMWJ6?=
 =?utf-8?B?d2lDS21mT2NtZThZN1NjWTQ0bWl1V3Z6d09obUhjQi8zSUtZcFgyMFdDcXZj?=
 =?utf-8?B?OU13QUR0Mmp2a2hUZWlDajh3RHo1MDJBSHZBS1FRNnRSNHZFTHZNUzFpaHZE?=
 =?utf-8?B?K2REWmZINnR5cGdVOHFUamxtalRteUVSaWlaOXZ0R2JoQXd6RjZZUXlpQjV6?=
 =?utf-8?B?bS9QZnhKelNDZ2wzU0VhWTc3Q3kwM0NHUUt6WklWZlhrMVV6MlgyeW5YYlF5?=
 =?utf-8?B?dE9oK3JsSzUxdkZmVGR4RVI1SWozUklGNDdCYnRxbEdKQUp1dERKcDdCQm9n?=
 =?utf-8?B?T0lONFZ1R01DWVArYzEzd3IyVlpONlRnNkl6cXpPUlhGT1A4b2dVbE9uMkJ5?=
 =?utf-8?B?eVRUb2xEcDlzejNDbXVwbWdaWEZFdzFiUWlqa0RuWDRyOFkwQmVJWVMvNVpj?=
 =?utf-8?B?bjk0WnRHVTMwMUYrMytSV1Jkakp6Mnp4TXpEcldGMjJkTFNrSHFuVnMwZ1VT?=
 =?utf-8?B?WHRGV0xNOEw1UklRU1F2NTZwNk1QSjE1RndjSWhKbGZkd3V3R1BZMFhoeGRF?=
 =?utf-8?B?NFdKK2xRM2k0ckI2dFJyVjF3bHJRd3dWWmhWSWU0Tkk4d3Y4Vk1yOXpzL0Qz?=
 =?utf-8?B?YzB1dlNQTnI1UWQxSEppcEdWUnphOERNd0tUcFJFODFsLzJhS25XcWdqcksr?=
 =?utf-8?B?cUptVEw3eVJuZ1Z2ajJRc0JmdnEyQ1Y5d1NIbDcxTG5XZVdoWmhuNXpiaXVU?=
 =?utf-8?B?Sy93R0IybERRSUVuVWpYc2lTWmVNcDQ2NEVHQXYwcHFPNU94MWpkVnZFWnky?=
 =?utf-8?B?SHlsSm5PamZ2U1p1K3VwZlBvOVVpZzh4NzBOWWpObHBYaDl3RG5oWHRXelFW?=
 =?utf-8?B?S3lzQ3c0VlpKZWtoNlR0c0JhTE5JZ3JBRGpzUEJ0UVZHYXRlRGFSSnZudk9s?=
 =?utf-8?B?UFp5a2lrdmttU3RwVWdFUkFuUmZoT2M4b3QxYVpkZDZiYlNrN3NvK3FsS3Yv?=
 =?utf-8?B?UFpod0Uxd0drZjYvaThSMXFvZjRxdHp6VUFIMktnVWNiVGJ2aUhFVjI5bDBE?=
 =?utf-8?B?WkYxcXlpakVpbWFrcWJVYkRJcWpLMGoyeFZadDBKaUIvVmI2SU9IaVNSR2FG?=
 =?utf-8?B?Rk1IVVRqaHcxQUVDTHg2dHdCeXY0YnV5OTJsMkN2QzN1Y1FibVBUc2pYdVRY?=
 =?utf-8?B?NGZFdFlvK3lJRG01cHpKV3pSVGdLeENyNWEyNGhIVm1MYk55bGpSbmQvVEtS?=
 =?utf-8?B?SFlzRVoxbW1WV3QxR3ZublpJWTQxaXVuakdKR2graHIxVkdFakhRK2RIT0xL?=
 =?utf-8?B?RHloZ1luZGpIUHArVzRQdGZqbjdORmhoTnVnQUVzdC9NUlJtOUdXczlwajBi?=
 =?utf-8?B?VHFSMWNwcm5GM3RyM0J6Y2JoWWFNTUJUSzlYa2hhTXUzcmRCWkFrM25OdHBP?=
 =?utf-8?B?RG5PWllKeDlIZnlmMnN0cm45c3J2WTA2RUxaU1RJT3lRbktWTGdRL1RVUzFy?=
 =?utf-8?B?RlM2cnAyVTRsVm15QU12VVdJWWkvd1NiRWFxdURvdzRaTmprZ1JnOUI4bzBV?=
 =?utf-8?B?eXRaUjM0MWp4b2V0WU11L2t3aHFUREl6QmhGTkg2eC9XWFB2VFkyYWdvek92?=
 =?utf-8?B?dnBSS3UwRFpBbjE3dXdaMWtJclhweC95UHp3YzJ3WVlGNG9QTkJiK2lWRFNY?=
 =?utf-8?B?SjNJc3BKcmt6V2VxL1grQXNSRFQ2T2lnaENQeW5paU14ZU41V3d4MHpVY000?=
 =?utf-8?B?MExjSkN6aE1maTU4QWM0MUdCcjdSVTZRVzBKNXZ0OWVDZFN0eHhjOTdmSTBL?=
 =?utf-8?B?UVp5RitscnFUVGJlM05adz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmZhTG5TTStJTWIvN2JSVEtQcWx5d2J0YWxxWXBTVGF2OU5QSnIxdTk5Sk1W?=
 =?utf-8?B?NGphbnR2TGZVS0tzcUx2V2k5VkZGM2ZJOHp2cklDUTV3RTFsZm5Oakx3d2Fp?=
 =?utf-8?B?MUdFY3ZDd0JrYU90MEp5ejlaOHVrVjlTZDJDWjdOZ0NtUS92dVlBU0NBaFps?=
 =?utf-8?B?bUU4RDA4aklpTkRqMy9lUzVjQ05xdWRBOE0vd3RpOVdHREt5ejRkdGUvMUNW?=
 =?utf-8?B?YUdyY2JIZk1UVERCUXdsdnlMVCtiVjJsNjZ2VHBkOW9Bb3pFM2JFSEFRZHFW?=
 =?utf-8?B?Tk9NelNTQi9La3J3SjFDV2tSNXRGSEY2U1ZKSGFnM3YzWG9tbWVYQXByZ2RD?=
 =?utf-8?B?K0tkazA0cmZjWkVVbXB1ZGxCTEgzdlUxbktNUDFESXRRL0V4WE0vNWxzbEYy?=
 =?utf-8?B?V2ZrWFA1WEdYajVZK0t5Z0hNVElRckk4VHJEOVhiZ29yekVSNzFZSWUrV2h1?=
 =?utf-8?B?YjZLZlpTTUR2Q0JTa2xKQ00zRkZJcnE0ODNNZWVrSmlzZTFndkpGYVREdXRt?=
 =?utf-8?B?dFBTWE5sYmwzdTViOHpTRmNHbEozRmtHdUNvU0pvaVh1ZXBEa1dOUVVkUThF?=
 =?utf-8?B?ZU4rSVo5em5FSjNrSmFGUUtLYVRsck11MkNnNmtaVVFBYnFkZjVqZ29laEs3?=
 =?utf-8?B?WklPcHhLeVY3eHZmdVZpNWNpSWZhVVA2cTJaMDNTcFNGUFJHSUJYRzRzMnFC?=
 =?utf-8?B?Yk1UQ0cxTEF0Rnd4TDJBVTNEMHJuTkgzcGtmVU54UDBLeWhIT0hWQU1QZ294?=
 =?utf-8?B?c0lCNnN4eCtXcTh5RUE1OFFJek9pc1Fzd1lXTUlSM2R6eHArYnNlS0xQeXNL?=
 =?utf-8?B?THhJVEtqaSt1Q0ZtVWJsb0o3V1ZSVERSUHBla3lrU3VCb3hmV3lzRmUwT0Nz?=
 =?utf-8?B?N0ExZkNTKzJ1bjVCZDVWV1VxaXNjVEFBa1M1VkJvTXhJTW5uWDNSM09nZFlZ?=
 =?utf-8?B?b1FERzdKSFNUZUVLSnpCYWdyenVPb3NaNkw1Mzd1b2p4YWVZd0FuZDQ4TXpO?=
 =?utf-8?B?OGdNQ1dTN0dlRzV6MkVUdnRoZVlBWlNMQ0wzS1VsYWRUK3lIYW9La0lXTVJx?=
 =?utf-8?B?U0taM01GdzJsa3R4SjVteGpmR2NBTk0wUjdDRzdPcFhZdWk5Zlk5dFY5YlpJ?=
 =?utf-8?B?cDdIRzNYRWRZeisyV0pBTmJ5aHRjRkV5L0NTZkRVSnIwbnVvaFNzNVNNV2th?=
 =?utf-8?B?T09vdmxPQjg5d2t5dFh3VEljQ0wra3o4QVNQNEhxbUFlYVVyVFE1ZlRBakVP?=
 =?utf-8?B?eDYyNW5aR2o3SDBBRDMvM00xZER4N0NDcDRWZ2N0UUdwSzRrbmZlWEJEWUN4?=
 =?utf-8?B?M1o4QU9JbzVoODdEa2xGOVlhRmFaaHJMZ0U5U01ZdEc3R0daSnZQZU04RXFl?=
 =?utf-8?B?QVdUazlJZm1ERU5EK2duSnhyTHFDQ2ZDQVZNL2VHQXNxOWdORHpIYnJJcERC?=
 =?utf-8?B?bWVBMndqd29mditxVmdudUtmYWlCT0VsaThOalNjSVFHcXI0TlVLQWhVTkhq?=
 =?utf-8?B?NkRRMVZwMDdoWm9ZVC8veTBDVGVlSnBodllKMFRjSUdZTm14NUVyV3NtSDZ3?=
 =?utf-8?B?ZlNoNnd2UFhoUUo0d2VYV3FzUEppTHZHREtPWUc4eFBqOWtQbVhPVVVWVzkx?=
 =?utf-8?B?SGN1UEFSRXo4MFFpQjM4Ui9hc1hlOG9jektJYjFXZmt3OFRaVkRyOGg5anJS?=
 =?utf-8?B?QTNzUllsUlM3SFJEak9ZRkxLa0JjUnB3RWRueFgyd0hlV0s5QWx5ck5BcFpa?=
 =?utf-8?B?VEtSelpSa2p0aHNiZ3A1MzB6aHBwdFBUV1oyUlA2bHA0eTYwL1BKc1lWK1Bx?=
 =?utf-8?B?ZXNzekUwbE1FbFMxVXBHWlZRclRtY1hOcWM4azdwZmtKcDFXRzhpSDJ1VGkv?=
 =?utf-8?B?eHJud2dMeW52Zy9hM21jTXFHS3dKTDVnM05kd1N3QVJ3c1BvY2VTMVU3TVlD?=
 =?utf-8?B?eWdOZjRrV3ZRdmd5VlZlRXphMlE5VXUvd0VWWGNQeFRUSmg2QVRNRnh2eGhX?=
 =?utf-8?B?Qlo2anhBSkRlZHZMWFpyOXZNamZxR0ZwNjdyVzJlRERWN2kvdDhsZHVHMmFR?=
 =?utf-8?B?djRPcStOWWFiRnBiamIrMTBQQ2FDeVRyUHBLNWRrWkcxVnppNno5ME15YWo4?=
 =?utf-8?B?YTJUaFlsN2NHRmdiQjA0NXdvWTNmZlNSTlNJM2pjaVN5ZVoxYW04c0xRNmpG?=
 =?utf-8?B?ZG1pejVoZU43czQxOW1SdWNVMmpLNG9uRVN4aTBZN3pMRmFjOTdzckNFck5T?=
 =?utf-8?B?ZDBESnBNWlBianRRbjV1dlZNQzB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F3E319DC6532C4696AC6004D6A4A2F5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725348fa-8178-4ff7-905a-08dc7c0e27b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 16:25:41.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ro4o8B8JbE9t0o0dVione5+hUBeaIKBNVLTyvh1OX5XSsHfi4CKbXC3L3vsNOyWtP+nmLqNjyWN94PsQDPidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6624

T24gRnJpLCAyMDI0LTA1LTI0IGF0IDE4OjE0ICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gV2hl
biB3ZSBhcmUgZG9pbmcgV0JfU1lOQ19BTEwgd3JpdGViYWNrLCBuZnMgc3VibWl0cyB3cml0ZSBy
ZXF1ZXN0cw0KPiB3aXRoDQo+IE5GU19GSUxFX1NZTkMgZmxhZyB0byB0aGUgc2VydmVyICh3aGlj
aCB0aGVuIGdlbmVyYWxseSB0cmVhdHMgaXQgYXMNCj4gYW4NCj4gT19TWU5DIHdyaXRlKS4gVGhp
cyBoZWxwcyB0byByZWR1Y2UgbGF0ZW5jeSBmb3Igc2luZ2xlIHJlcXVlc3RzIGJ1dA0KPiB3aGVu
DQo+IHN1Ym1pdHRpbmcgbW9yZSByZXF1ZXN0cywgYWRkaXRpb25hbCBmc3luY3Mgb24gdGhlIHNl
cnZlciBzaWRlIGh1cnQNCj4gbGF0ZW5jeS4gTkZTIGdlbmVyYWxseSBhdm9pZHMgdGhpcyBhZGRp
dGlvbmFsIG92ZXJoZWFkIGJ5IG5vdCBzZXR0aW5nDQo+IE5GU19GSUxFX1NZTkMgaWYgZGVzYy0+
cGdfbW9yZWlvIGlzIHNldC4NCj4gDQo+IEhvd2V2ZXIgdGhpcyBsb2dpYyBkb2Vzbid0IGFsd2F5
cyB3b3JrLiBXaGVuIHdlIGRvIHJhbmRvbSA0ayB3cml0ZXMNCj4gdG8gYSBodWdlDQo+IGZpbGUg
YW5kIHRoZW4gY2FsbCBmc3luYygyKSwgZWFjaCBwYWdlIHdyaXRlYmFjayBpcyBnb2luZyB0byBi
ZSBzZW50DQo+IHdpdGgNCj4gTkZTX0ZJTEVfU1lOQyBiZWNhdXNlIGFmdGVyIHByZXBhcmluZyBv
bmUgcGFnZSBmb3Igd3JpdGViYWNrLCB3ZQ0KPiBzdGFydCB3cml0aW5nDQo+IGJhY2sgbmV4dCwg
bmZzX2RvX3dyaXRlcGFnZSgpIHdpbGwgY2FsbCBuZnNfcGFnZWlvX2NvbmRfY29tcGxldGUoKQ0K
PiB3aGljaCBmaW5kcw0KPiB0aGUgcGFnZSBpcyBub3QgY29udGlndW91cyB3aXRoIHByZXZpb3Vz
bHkgcHJlcGFyZWQgSU8gYW5kIHN1Ym1pdHMgaXMNCj4gKndpdGhvdXQqDQo+IHNldHRpbmcgZGVz
Yy0+cGdfbW9yZWlvLsKgIEhlbmNlIE5GU19GSUxFX1NZTkMgaXMgdXNlZCByZXN1bHRpbmcgaW4N
Cj4gcG9vcg0KPiBwZXJmb3JtYW5jZS4NCj4gDQo+IEZpeCB0aGUgcHJvYmxlbSBieSBzZXR0aW5n
IGRlc2MtPnBnX21vcmVpbyBpbg0KPiBuZnNfcGFnZWlvX2NvbmRfY29tcGxldGUoKSBiZWZvcmUN
Cj4gc3VibWl0dGluZyBvdXRzdGFuZGluZyBJTy4gVGhpcyBpbXByb3ZlcyB0aHJvdWdocHV0IG9m
DQo+IGZzeW5jLWFmdGVyLXJhbmRvbS13cml0ZXMgb24gbXkgdGVzdCBTU0QgZnJvbSB+NzBNQi9z
IHRvIH4yNTBNQi9zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5j
ej4NCj4gLS0tDQo+IMKgZnMvbmZzL3BhZ2VsaXN0LmMgfCA1ICsrKysrDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9wYWdlbGlz
dC5jIGIvZnMvbmZzL3BhZ2VsaXN0LmMNCj4gaW5kZXggNmVmYjUwNjhjMTE2Li4wNDBiNmI3OWM3
NWUgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9wYWdlbGlzdC5jDQo+ICsrKyBiL2ZzL25mcy9wYWdl
bGlzdC5jDQo+IEBAIC0xNTQ1LDYgKzE1NDUsMTEgQEAgdm9pZCBuZnNfcGFnZWlvX2NvbmRfY29t
cGxldGUoc3RydWN0DQo+IG5mc19wYWdlaW9fZGVzY3JpcHRvciAqZGVzYywgcGdvZmZfdCBpbmRl
eCkNCj4gwqAJCQkJCWNvbnRpbnVlOw0KPiDCoAkJCX0gZWxzZSBpZiAoaW5kZXggPT0gcHJldi0+
d2JfaW5kZXggKyAxKQ0KPiDCoAkJCQljb250aW51ZTsNCj4gKwkJCS8qDQo+ICsJCQkgKiBXZSB3
aWxsIHN1Ym1pdCBtb3JlIHJlcXVlc3RzIGFmdGVyIHRoZXNlLg0KPiBJbmRpY2F0ZQ0KPiArCQkJ
ICogdGhpcyB0byB0aGUgdW5kZXJseWluZyBsYXllcnMuDQo+ICsJCQkgKi8NCj4gKwkJCWRlc2Mt
PnBnX21vcmVpbyA9IDE7DQo+IMKgCQkJbmZzX3BhZ2Vpb19jb21wbGV0ZShkZXNjKTsNCj4gwqAJ
CQlicmVhazsNCj4gwqAJCX0NCg0KVGhhbmtzIQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

