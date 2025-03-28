Return-Path: <linux-nfs+bounces-10947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FBA7500C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2EA1893B32
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229291DED68;
	Fri, 28 Mar 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="C/z6ZKxi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D511DE2C4
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184860; cv=fail; b=Od3dmekqZaJlWizJ5R7JAdJ8EF6jTQHPt/+CLQ/a3fEaaSwdsiPL8I9CkWSFds4lTxdw9hk5CgEoMWtIYZaYtX8pm5QCtX4j0KV3IQHFFc2lRRjmeh2Ivvdce/pAoRRy7IMOb2oxdSjVPtrQJtBB5dZiqiTPyxNrZWRRyFbIeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184860; c=relaxed/simple;
	bh=NtSr3EynLkV0999u1CSgfkx/JFrI2n3EBr1tvbMJwvc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekzSHtRI09Ew2NpSUkD2MlQwmUO2c1D+5LW7Fe8UpaXFUa8LCVQAxmvTWHvoDyaLwCWGf5pVwxzLLGBuvJCSCwYExTdaetvQRNLDo+KFqTajB0+M1PW93dY5LVEPMrD1JStYTBV/4/8Z/z4E6+cNO9taI5KqDGyKPhAfBRW+JzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=C/z6ZKxi; arc=fail smtp.client-ip=40.107.220.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM+FTshZcJR7LUYqFOu590Yh5695KQD3M3gj1NheaMYMbX2h9T9JjJUDRNuLYCNeiNFLZhZdpLLqbJNoIAoSJLD6w2n0jdPUpdImvgo/YhSwzk43Yy0aTlfxDx15DyESMrtYpKWPtyq+EhZ3CyDpzzWWhXXjGGscNSL6eETytwMuKw1gpN5e46HnBn6v9gK07dQSdOPGkkduwnedMqeexxf90NYiZ0B962siaKJH8/dzfk283EL4WEcc+JfyB1o8eDjnKkfNyxGbp64UY8e650WyyezKSuOZr/SEVeQAitt6bQi6biuo1b5imhLaiXHZRlobhHzOcuoQU5rvrmGDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtSr3EynLkV0999u1CSgfkx/JFrI2n3EBr1tvbMJwvc=;
 b=Okw5lfz3IKwXeRi9jkwP1YqC+R+TpiNyDEtA8yrBYCTMxtwxUJ0M8f/vTXhfQc+fHrO4TQQghpkGnI3dFLjW8eYe0Yle8I3py/dlpaMoGkpQ6+P92D4ejXMXruu+SL1sQT6JRz3Ms66I7gFsitCZ/rkPmy1P2O7U9mW3nXZup17oD/JgFz+OxVvkZHlSwNPk1Ty0zorf2YoXV5Evui88nA+0fou1kmtM1+0HcqSiWwL7sz7sMyZtVgtIielIyc1W3DpQ4JpVNsqC8PqiOkzle1G66uW3SzUncavZLPG3y2+SeKNSJMbv71F6hb8W9uZumAywTxL5R/isW3//CfNLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtSr3EynLkV0999u1CSgfkx/JFrI2n3EBr1tvbMJwvc=;
 b=C/z6ZKxiB7mW4tZLp8dQ5FuIMzZg+GyhL2EM4j5ghcMFZ1CQnzGgpoW3J7wnq4sCzsvK05ATLz7kpjqq8FekaPkOmoxxN35qknC3MGJh7TLDbFshwCtE5+IWUEZ335dbEZ8HbJGd81WuwY4r+02mfepVpuK97eY8D0moPh/+9H8=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by MW3PR13MB4010.namprd13.prod.outlook.com (2603:10b6:303:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.31; Fri, 28 Mar
 2025 18:00:53 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 18:00:52 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
Thread-Topic: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
Thread-Index: AQHboAiPGcKqnENVnEOPq33w2Lzm6A==
Date: Fri, 28 Mar 2025 18:00:52 +0000
Message-ID: <653869b6e69d65b0314e133b901d670968d7b345.camel@hammerspace.com>
References:
 <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
	 <26602925a3b7623c17c58cc9d5adeddde95e70d6.camel@kernel.org>
In-Reply-To: <26602925a3b7623c17c58cc9d5adeddde95e70d6.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|MW3PR13MB4010:EE_
x-ms-office365-filtering-correlation-id: 033c0cfb-c8e0-4ef4-ab97-08dd6e227ae1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFlFQjlGK0VKSW8vZXVreUtMNFpkTEdlL0lybER4bU81aW5GdnA1K1c2M1lh?=
 =?utf-8?B?dFFVZUkrTW9rU1FRZ3hKeGxqZzhzZWxTZFcvcTJocmF6OFpmVTlwNXdDeEZM?=
 =?utf-8?B?dFlXdUIwb2FVNmlNdmJ0dWN4SHg5eHV6NCs3SUdWZU1FOFdEaFJvSlQ3dFlO?=
 =?utf-8?B?ZUN0aTA2MmFFWXFwZStCWEhsOExkQkdBWnNTMWJxOWt2MHNJbEVJS0Nwekl6?=
 =?utf-8?B?eFROcEFOcDZOTUxRNkhtT0dOZW1WMytuYklQMUpBS2ltSFl4V2F1U2l4Mkpx?=
 =?utf-8?B?dWoyVXJ0TWdlb1hPa25hU2VMZWo3cjVQMmRZVHdlNUJ1TldLUENReHhFYThy?=
 =?utf-8?B?dWliK0tYalNTbURyN2tKN2UxWnYwVGM1OHBpYXoyOTdFbnh4S1JsWW8zWDBK?=
 =?utf-8?B?cWREYm55QXdnNnQyZVNuMEFWV21TZWI0ZVEvYjVDQnBKa0s2NHkwd2ZOcnVa?=
 =?utf-8?B?d25IN1VwR1RKd1FJaXlaZFkydUZ5Z2lWdkNaYmV6dmlBajZjYW5TV2xYS0Yv?=
 =?utf-8?B?Q2Nmc0pZOHdpNzBZZmt3eDdacGZkUGVybHFuWGlqVGxpK1dVbEtjQlVad05h?=
 =?utf-8?B?ak9ZYTNYa1dJbnRFNjlSQ3pNbUpNcUszdkppZkM2cWNzYjdlY245eVgxeTh2?=
 =?utf-8?B?UnVRNDZkbzFFUVduMlFHOTA5ZWQvSTk4Y0dVQittZ1NwNm5RVGc1bndobERO?=
 =?utf-8?B?a0RxdTh0azJheE11bFJFRGpqVXluS29xR0JCR29NUWkxMFRpaURUamFpYzBH?=
 =?utf-8?B?UVJFQTRvQkNWUXZMYWdoa3MrS1BQU2o1eVZFbHdvVnJpKzlyQlZFNzJMWWhN?=
 =?utf-8?B?cmtOSE04aWMxenRiWmhjL2ZnSXVueWRjaFlWbGhXcHFvY1kwMzdBVHIyUHlm?=
 =?utf-8?B?OGdlVmZ2dW55M0JVQmlrVDlhczNJUHhEKzFYek8vZ0hmMklJNjBRME9hYW1R?=
 =?utf-8?B?RWJ6Zk9FckZTVHdZRlhOWjVXaWZiOEdLR01rVHNUZEFmOTloampFbWprYXBP?=
 =?utf-8?B?U3preWwyN0JLcWZUZjZsWlNiZGV1dEZpWkcvbFNtOENZTlFCMnNzRjE4cnBH?=
 =?utf-8?B?TjRNMy9uTjRrWkw4d0ZXWVpYUXZlKzhXRWlkRThmY0xRM3pIWGdYL3pDK081?=
 =?utf-8?B?bkJVTWJvS1hnRXhKOXpIT2xpRDEvSzZqU3d5ckVna0hhSFZsN2s0eEIzemdY?=
 =?utf-8?B?WUtWRGo3YUVpNHVjd3FLMWN1SHVqUjV3MjQyNHREemJrclV0NTdjSHdqVW5w?=
 =?utf-8?B?ai9EN0pDbjM2cHdjb0JDZmRySWdsTWdnQ1d3Zi9vVDNxZy9Zd2F4NERkUTE4?=
 =?utf-8?B?U0F1ZlpjZ01UcmFXR2w2cnZUZ3JBbUxsVTR2RDA4TUxlZlo5SGNUSHhnQVNr?=
 =?utf-8?B?UjhvYVlkU1B5MEJnVllmRTg3NURsQXBoRjByR0ZzSHM0ZTRqSllmQytvL0xG?=
 =?utf-8?B?NTROTjdPVXVDano4S0cvQkxidjlwYkcvdXFjTkNZMWhLQTQxalJnTDNLME44?=
 =?utf-8?B?YU5CZm9pZmtaZm9SejQzOXJoSnFHbXV2Y1VYUEZVdnQ2ZUdCKzdtVEZFVlY3?=
 =?utf-8?B?bFIrbjN3M1RjRFJnUXhRZElaODcwUmRIdU1tZTF1T1k2TGdZeEdFK2VnRGQw?=
 =?utf-8?B?VmlWV0hGR1dVMGZOeC9EMnk5SzVXRm5kTDJoODBPdHhvVTBzVEpsZjNUWjMv?=
 =?utf-8?B?cjlVdWRTWDBoaXVLM3UyUzlBRzI2dDlXcjFlRHJheDNMWTYxVGNGMU83OGZX?=
 =?utf-8?B?c1BSZVNpaDhJQldBUTI1N0JDM24zZ0RPT1IyaGZMZ2NkbVhDbXlhUEwzSXZL?=
 =?utf-8?B?elladFNzcllFT00xK2thaFR5dWt0eEl1eHJ2dGFwQ3NyNHhBcVpHK2lIeVNT?=
 =?utf-8?B?RnF2OEhTY3JWMWw0TFdMYUZySzE4STB6d2JZeEQ2Z3B1c1J5WWN0TTlJcGtM?=
 =?utf-8?B?dkRobkRLVUVxQnFWRnUwOVNzZXRVNG9wbFRySmMwSFJHVjVCR3FpZy9TaUJI?=
 =?utf-8?B?VHhrQlJDb0JnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXhNeXNpejVnVG1zaU1TNDdyb214ZlVPTWorUzdmbElTVFZHRSt4N2MyQ04y?=
 =?utf-8?B?MlBWR29ZVHpMdnZZdjZMWFl6M0NUN1dqN09pQ2tvTUFKaW9FWm1KZG9OaGYw?=
 =?utf-8?B?RXZhcWQ4QTkrR1BUdGQvRit1cUoyR0NrOXF2bVFTOUdjNncrRlRad1ptaVA5?=
 =?utf-8?B?STBTOTREZlk4UXd3akFlalEzbkptdkdVc2pEeXh2d1JRbE83Ty8ySFk5VnA3?=
 =?utf-8?B?b3BNK3g3OFhRU0JKU2xTbkpMc0V5d2ZyODJQOFBYSWxKdXJNZk9XUUY2bWp6?=
 =?utf-8?B?NnZvb1NpODFpanlvUTVhMnJKMDJ0U1BrMVJBZG5MOFVjaEtCL2FoalNyaWph?=
 =?utf-8?B?T214clF6VWNSOE9rWWhqOTVKQXNGT0NiRDRKY0J5RGJJYjNDdHBNLzFwaVFp?=
 =?utf-8?B?ZXhtMkZVeDlyMnpNd0Y2a2RuRk9sbnJQL3ZkdFFWb1d0bFhWdGtIK1U5VUhF?=
 =?utf-8?B?U0dSaEs0Zm1oR2VUU21rUVdJQkk1RHh5M3pUU2t6RzcvQVFzSUVIY3RMdFdZ?=
 =?utf-8?B?WnhkZGRjelhwRU52YmR1dHBDVkZtYVY2S25FR20zQi9KWG15SzQxT3o1MWRY?=
 =?utf-8?B?N3JVZ2dNWVhxKytla3VhdGI3TFBWM0hib0dpZ3AzS1lMRGNCMmMzY1J2QWlZ?=
 =?utf-8?B?QUZDeU13VzZhL3M1cnZvd2poeDkzWU95bmlqTXBGMXdGN2dDNVlqUXdjdUlj?=
 =?utf-8?B?UWNuYXkzbEdhSm1tWFMzNFZXOEZKRm0xWjZ5TE1Gdml2RWJXWWFkY2FNaU9G?=
 =?utf-8?B?ZndkVTBHVEdSUElEL21qTktwQ2tRWXMwNlY0M1FrRGFGMG1UZ29OOEErTkh0?=
 =?utf-8?B?MVhmbmhJTEJtK2NyVGVXdTlKM01BOG1jWlhXRFpSYXBnSzNEb0RDT1Q4QkZJ?=
 =?utf-8?B?T2hIdWNlcGIyU1RBZ01oWFZwZ1FZWHg4cDJQMzkyQTdIM0xnazFyQ0duRHY4?=
 =?utf-8?B?Z2VHMHdyU0tjQ28zWXNqdlh5QkJpSjFIOXVBZzZWdmdmWWhCWkVCZTB3K0R4?=
 =?utf-8?B?QWQ1N3BvL2JLdjVkV2lxWmRxdGJVcTRoM2dETDRIVjB3K2ZONDVJVHE3Tldi?=
 =?utf-8?B?bzNWU0JvVjZzUVZMQlYzcFlWWlB4Tks1S0pzTms5TCtTZ1FrcGQzUkRFbk50?=
 =?utf-8?B?eWZRRFBKR3hWTFBwOWNVYjUxekxUcDl3WmtWTUZqYjNJRUpSc1lORW1OSEVP?=
 =?utf-8?B?WnQyS2lzVFBFd2NHU3BjeTk2WVBGSktGQjREWGF5aDlGQmNjMFNEM2tWbHEw?=
 =?utf-8?B?MWlFWVBGd2Via09hOC95bE0yMWYwV01wdXp6V1IxRWVyV2d1YmVJa09pM2JE?=
 =?utf-8?B?M2lHcDlBRUljZ0RXRFZxeGQ3VE5wWUdQVXVxRktaZGNLazFpLzc4Wm4vaWQ4?=
 =?utf-8?B?YWxpOXNCeVlFVnB4cmF1TEpLNWViNXNKQlF6SnpwNkpISmxrVFVmaC9GU2Vm?=
 =?utf-8?B?ektZQkpMR0wvRnZRK0hkZGtjQUlZTVg2VTd4NnZhL212cnBCaldFdlZWN1JF?=
 =?utf-8?B?YS9EcU1OK2p5K1NnL2NzeERxckFBc3VFL0hJazFJOEVkVFdkdnJTVHlxN1Ru?=
 =?utf-8?B?WVg2a1o2c0ozbnZCWUVQdDA4cVVJR0k1QmF3MW9xTnd2MEVGZ2t5bmd3T0da?=
 =?utf-8?B?UlRQQ2VRbllGY1RPdU9Cd3RKNS94djdxc0hWUjJyVVcwRmk3V1pGZWFILzhE?=
 =?utf-8?B?a3ZsbGtzWlI0TGpLaU9lOXJHbWs2bUVwS1VyelFHZTVOMFozWWJIOUZqUGNa?=
 =?utf-8?B?NlJmU3BtdkRuazI5WTkzaythSjBDdEpPaGhjN1N1K2JTdGc0L1FtdWF1MFl0?=
 =?utf-8?B?eE1QdnZzeUt2MlFYTnpJbXdzMnoyODl1VlZZSk93dGJTbEhyYkNIUGlSb212?=
 =?utf-8?B?TnNQZDNWYWZPM3p0M1BkOWEwR0htR0xLVHhuNFF0cnEwWTdPdVAyY1JPc2Vz?=
 =?utf-8?B?d2Q1RkZ3QjhlVEdQQWVweVNOY0ZWTnJxYkdoRGR0cXdiaUJBc0FYcmN0VVV3?=
 =?utf-8?B?eGdlZDFhOFNnaFJuSEpLR2Iwb2Vhc3VIQWQwdVBYUkY2VXZ3eEdsYmlQd29D?=
 =?utf-8?B?bVA3V1hTbHRWQ2pSOTlQaUFFb2tudE9XRkp5M0l0NE5oMEVrMFdYdFVLamRx?=
 =?utf-8?B?VTFZNU40Y1NPNHJEMGJxb2dFa3RObGhMSzkwaGpodmRVeWZjSXFMNzd0NE9t?=
 =?utf-8?B?aXlSZXl6T1hxbkMxS3JQN3hTbHRYc00yQjZrZEZVSmd5VlFYQ3hEVk1PTFU0?=
 =?utf-8?B?bXJOSUFZMVUvWlEwMDR0cTZxNThBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0F0C772595E74083F88A10882C08A2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033c0cfb-c8e0-4ef4-ab97-08dd6e227ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 18:00:52.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abQCNJEnuc9Pi08D2ygtdZa33vLsjW9Qw9rFZ5X78ijy6AzQRPC+htbKWgTiJ0KtEuRDI2V4QDCh3Tn5UBbuAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4010

T24gRnJpLCAyMDI1LTAzLTI4IGF0IDEzOjUzIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gRnJpLCAyMDI1LTAzLTI4IGF0IDEzOjQwIC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdy
b3RlOg0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4NCj4gPiANCj4gPiBPbmNlIGEgdGFzayBjYWxscyBleGl0X3NpZ25hbHMoKSBpdCBj
YW4gbm8gbG9uZ2VyIGJlIHNpZ25hbGxlZC4gU28NCj4gPiBkbw0KPiA+IG5vdCBhbGxvdyBpdCB0
byBkbyBraWxsYWJsZSB3YWl0cy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWts
ZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBu
ZXQvc3VucnBjL3NjaGVkLmMgfCAyICsrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvc2NoZWQuYyBiL25ldC9z
dW5ycGMvc2NoZWQuYw0KPiA+IGluZGV4IDliNDVmYmRjOTBjYS4uNzNiYzM5MjgxZWY1IDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9zdW5ycGMvc2NoZWQuYw0KPiA+ICsrKyBiL25ldC9zdW5ycGMvc2No
ZWQuYw0KPiA+IEBAIC0yNzYsNiArMjc2LDggQEAgRVhQT1JUX1NZTUJPTF9HUEwocnBjX2Rlc3Ry
b3lfd2FpdF9xdWV1ZSk7DQo+ID4gwqANCj4gPiDCoHN0YXRpYyBpbnQgcnBjX3dhaXRfYml0X2tp
bGxhYmxlKHN0cnVjdCB3YWl0X2JpdF9rZXkgKmtleSwgaW50DQo+ID4gbW9kZSkNCj4gPiDCoHsN
Cj4gPiArCWlmICh1bmxpa2VseShjdXJyZW50LT5mbGFncyAmIFBGX0VYSVRJTkcpKQ0KPiA+ICsJ
CXJldHVybiAtRUlOVFI7DQo+ID4gwqAJc2NoZWR1bGUoKTsNCj4gPiDCoAlpZiAoc2lnbmFsX3Bl
bmRpbmdfc3RhdGUobW9kZSwgY3VycmVudCkpDQo+ID4gwqAJCXJldHVybiAtRVJFU1RBUlRTWVM7
DQo+IA0KPiBXb24ndCB0aGlzIG1lYW4gdGhhdCBpZiBhIHRhc2sgaXMgc2lnbmFsbGVkIGFuZCBk
b2VzIGEgZmluYWwgZnB1dCwNCj4gdGhhdA0KPiBhIENMT1NFIHNlbnQgaW4gdGFza193b3JrIHdp
bGwgbmV2ZXIgZ2V0IHNlbnQ/DQoNCkl0IHNob3VsZCBtZWFuIHRoYXQgdGhlIGNsb3NlIGdldHMg
c2VudCwgYnV0IHRoZSB0YXNrIHdvbid0IHdhaXQgZm9yDQpjb21wbGV0aW9uLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

