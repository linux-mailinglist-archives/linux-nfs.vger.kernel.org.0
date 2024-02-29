Return-Path: <linux-nfs+bounces-2122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37FA86CA77
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A8F1F21CD8
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2E86245;
	Thu, 29 Feb 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Z9TcCWCZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFC15D2;
	Thu, 29 Feb 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214015; cv=fail; b=nbVCfswk4RRjiSUtofLEquOYzh1GH9pc3jKsSdtGBCTwfcxXDAuvkgkNGcWGTEaS7F2QXE8DJFhJzwx59rZwnTwKVISYYvuPOFm9dFMzC/jeCxhTOi4dzb43s9Zc7WTE2LI3zHIvwDX1wpyeC45qFy1fkT1uaF59sJT2SC/lX1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214015; c=relaxed/simple;
	bh=Lh6vVsf98lAqzcu7J4OPNZdig4gnpJINeKfAj0uYVNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7qaAY/4DlT/hrZwxXVTIJKfJxIrAlGUSIEJ0VSiLiY8vLPvW2AwLM5T/EChgAyzwA2tiFUbxycxbTx7iTJQJHZhIwYz66Od3sAxHHB9vNBHo20aIFduxkwBXu6NEy5LZMIJ5lYr/GpeOfIoX9nr/QNYE++eBmHIZ/dsmaWLwUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Z9TcCWCZ; arc=fail smtp.client-ip=40.107.94.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBcipDVsdWUZObFzpZCkuo3YraCHM49BHl/5nWENb7CieSOmX9a2fUYBrSsJAS9CWt7CsxOTBRtAi9tLJnA6HRnymsLVhIpiNr4NEyo+iAWA/9cOElm4EHM+OYRd4orxXXafB7SIOeyF5LIe/AXhkPQnZDrwH7zzgmM7+9n0pUrYduQgW5NvLe9y7ukWWo6LHXdlo0t/vuliV9hgoie8vrRaZ3TpXs+nrWUTrwmqj6WkuT90WhIrsYKXXsWpzu2iibXpG0wsxCVpU7QpIiRjRVzt/uuAHWJlyb2uaCGgptlSY4+d+/71MGAvqAhmKtwmMeTYFWeANqJ1ny9RPznRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh6vVsf98lAqzcu7J4OPNZdig4gnpJINeKfAj0uYVNo=;
 b=XcK8m6CZd4lUydL2okvf0uv2TNOgJ/0v9E1lKZxdvZiyGl2Tl7q8WBW4VjhwzCq0d0CKQiQDsmGbf1RG3ozdwrFWamPkdEe15PzDYFjS/tICqE3SemiTSNkXJNTNt7bzf0X4WU/ccmiWm1g15h9qovo6XyXgc05YxrHrAHMiES6IOiBTDJYgW+dGWVvVlKOBtGxhVufFyN5hBALqP77W+HBqCt06awcXaJ8XCezCmWtBiODEaGKtKjsaB6mscDGIconeifU2WSgZffhW53UGLY4szusrYTdp4oZBZKhJJCob6e5JdXFMies/P6mtl0bUd3u6xEBiMB9Zx+nTBIYgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh6vVsf98lAqzcu7J4OPNZdig4gnpJINeKfAj0uYVNo=;
 b=Z9TcCWCZ/YIJ6+JCywdpmXdO5h/oRKHo9R9Lmc45G4igliJqb6MkOV/Fs/ghK5LgH4kWoZ3O+XjLzr6E6UoAB00Fr6ANfJ6Cdmrpdu8pqD8t/zer93gKn7Q5fqdlPbXA8ddFosjDzrwC1ckSFiaxz4kImXdXG2V2gh9WiJmRjUw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5301.namprd13.prod.outlook.com (2603:10b6:a03:3d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 13:40:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 13:40:07 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "kunwu.chan@linux.dev"
	<kunwu.chan@linux.dev>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chentao@kylinos.cn" <chentao@kylinos.cn>
Subject: Re: [PATCH] nfs: use KMEM_CACHE() to create nfs_commit_data cache
Thread-Topic: [PATCH] nfs: use KMEM_CACHE() to create nfs_commit_data cache
Thread-Index: AQHaavOCVHZ5CVpmekSrF6Xb6VAkBrEhU7QA
Date: Thu, 29 Feb 2024 13:40:07 +0000
Message-ID: <6a1136c39cc9d8e4ae4800ad81e8e72f3b8b4516.camel@hammerspace.com>
References: <20240229094112.1154644-1-kunwu.chan@linux.dev>
In-Reply-To: <20240229094112.1154644-1-kunwu.chan@linux.dev>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5301:EE_
x-ms-office365-filtering-correlation-id: f96e90d3-426e-4ae1-51b9-08dc392bf189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vshAOq8ZvobY1lyB77/zCqb835XM9E+ro7DhzxkJMiEeedpadcGYT5pN6i0a+3fEoAuBLfIgUhzEdtNYte5lsLmhEQQl0kX6FlMMYxK+AjfKwUtYk/Hc/Og5EOBP5S5P842n+K0eG1h+qVU9tUgqiwQS3QBFmZWeouumt4TO6gS3v/FkRoWJRCjT3ajwTi7Xyuiql8/sZncZpYLrHGQdv5tw51/7BmTAMhqDudxlF9uwiwqXgdolMNTRivwpppBHDAnioMJoqSUd1KC1URpf3NOWezLng3xxRypWVvbURoVT/hCqchEdMp7TcK8sFwTy+JRZmI7y8OSs+qmcOFlQN43M4vRvoszhcYtdR3jOMaf55/OBhurOROgHQpVU5jyWVxnOsrTl4v8qx5y5kCgz4XZgiYHNI4909enGmRzaLC363WLV5d0XoE5Dk0PrUFzXtHKOb0T1m/TTSB/GduR0Xv66qsxMQ4F/XWVSqrwlysBppX8i+VHc7cljYtvTVE9JBNhEGKNcX+/saQPG0oTKybvJh1wz0QANBajf76DrvYBxSRx47G388gszZXWiPrTYpfyemZ0lXRyb7ykIG5Rp1fqzUzV/bzbKgjVyydMqQZ6KvxsBragF4DhIRkpZhfGYHPk16f25JZakDmn3vfF7uHKY3K1mpY6a80C0RD0crWxGUNzTdtxKFI/+VwgST1Y3pbqsp+9N1gCDem5CBaqIiw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjN5QWVTRlpocFZGKytHTU5jYmtpZ1BZZmM0Q2pESlVmNGJSU3NFTDI3NVZO?=
 =?utf-8?B?cXdFMFhNbUFuYmg1cFNPZi9NNTcyazRxeTNObk11STRWTUNxdmxVQ3lHSCs3?=
 =?utf-8?B?MHZRc0poY2FvTUlMS3VjSmtJeDk2aVpVUnRIYnUxWWxxZ0VSb0MzWWVOdy94?=
 =?utf-8?B?YThXZ2tMMHBEd2VtRnpucU1kOGkrNWlQVSswSytWMWRrZFRGbjJNbWRWZ0pW?=
 =?utf-8?B?dFhRaEdXN0l3dlFWRlZqWHIzdFYwek5ZK2NQTFBDWThCMFc1am9VOVB0M0NV?=
 =?utf-8?B?emROWWZCUEFYclREL2RRa2FxT2pqYzFhNkVRY2ozdGxaeThUeXNvWmNSQ2da?=
 =?utf-8?B?eTJVSXgxRXQwL3VtSVhDWVpNR2d6YzRMUlJaL2ZvOGp2RlI0aGk0b2NEb1g4?=
 =?utf-8?B?aG50R0w0OTM1UWZKRmlFMGdrZnFOMFVjMjZXVGN5SnFvSnFEMkV5OFlreWUw?=
 =?utf-8?B?dFJnQzlDWlAwZHFmMENSNjVVVnpKRTgra0QrUXFOTE9STzk4ZmQ0QkdXbUx3?=
 =?utf-8?B?V1BWY1QzY0hONksxUXlwQ3hTRktVVExWVVBEWEdaRUtkc1kzN0xybGM0WTBw?=
 =?utf-8?B?Q1k1MHpOdFFjdGF5ZlBKNE9aMFhiUGlSMFJPaUNKbEkrWWl2bW5UQk0ydHZS?=
 =?utf-8?B?ZWdySEhUUlMyVDhieGVTSTlGWEZ1aTJFOXVuM3FzbWszN05uNEVJblF1V1hX?=
 =?utf-8?B?ay9LYnJqcVh3ek5RQ3RZNlhkTEdUeFlneGJVbnFDQVoxNXA1b0U0WkxQVnFY?=
 =?utf-8?B?QkZMNUJGa2JpL1huY28zOGNTUHRIRk5HQVdzTlRpQzBIazdoQzlqczZOZlZU?=
 =?utf-8?B?SzE2Y3V1S2dFMDZEcDgyWHVzc2xpaHpadTVWNTlQVFRacW0veHY4dTdOV3Mr?=
 =?utf-8?B?b0c2UWMrMnZRMmlnNUhpUmFlaWI2TlIvazBRdUtaMktBSTdBZjR1a2xvbFU5?=
 =?utf-8?B?elZvTHYxcnpiSGIvVnJaNFYwNXdJWE9wM09NWG40WXJlR2NrWUlOY2NmRXJs?=
 =?utf-8?B?anR5U2hDR1JxVFc2UkdHL2R5SmZwOTFUaFU4cHN2cFJ5OGN4Q1RIZEltSTVt?=
 =?utf-8?B?ZW80dzk4OVcwaXNuSE9TbmwrVUJPb0tNNDV2U3QrVWxNMUo4cWpqTitHdVNM?=
 =?utf-8?B?UVZFK2l4MzNCckxHSng5Q1NDVEY3YTRpd3hPcnB3TGNtMi9GM1VPanN1dFFt?=
 =?utf-8?B?dk5Zdzk4UXBzclpTNkFLQzJmcVBJYzhCOFNoempNVGg0a2VWTGJoWDBoTUlE?=
 =?utf-8?B?NVZpWmhXZ0hnUVNldVVMNzFweit2SCsrcWxyQlFPWDVzcVZBWktkRHpFWXJG?=
 =?utf-8?B?c2NHaHNGb3gwdVpWSVlwY3g2T2xaeGdueXRSbzZFUUtpbkhlenZiMksxcHNH?=
 =?utf-8?B?MzdUd0dLVmRCbVpabTFhRjYwN1luU2NHMGQ3akRuY0puVjE3UTlRMEIvdWZJ?=
 =?utf-8?B?THlWa3JQUTJ5WXg1eWpGd0dOWlZIbkNkNFV3ZXAzMGViQmVNZk9ZdlZmVkdE?=
 =?utf-8?B?RnNheGo0aDBUVnZ2ZENUK1FWTTlwdUdaL2taZVc4ai9hTklRUnhGbmtBUzAv?=
 =?utf-8?B?MDM4RS9vKzJjWTg2dUFsUDh4YkhXc1R4aXhtWVhFWDZwdUNWeEowSzluTC9O?=
 =?utf-8?B?N1BoNVpJOUcrV3pmZlVHMkFXSFJha0g2bTBIRWxsQ0dpQTFzOG96VUFjOUJP?=
 =?utf-8?B?d3N6S2pUeFdRaUVMV3JrcEduTk5DMXp1SXMwb3VpMXJkYVhmVzhtMTJiTDRG?=
 =?utf-8?B?QURWWWsxb2tvUXBZdUFjUW5FU3d3clB5ZmNWc1ZlemMxdDIyZzQ3MXF5RVBo?=
 =?utf-8?B?c1NBM0VZZ3lPRDFRRFdGbnRDK1hIZzNKTU9RSE5aWmxmdUFDUVd4WXl5a0ox?=
 =?utf-8?B?RWcwT0lDZGpBRmlId2RmdmFHRmFwWjZTYi9iaHcvd0xBWStiUkRobjJyR1lU?=
 =?utf-8?B?WFNTV1NraHVDemcxRXhjVGFiLzJpblo2N1AvWDVTcUVXK3hEVmxSeGFTSHRS?=
 =?utf-8?B?eW8ySXBlNEdRY3dqRWx4cTNTT1I0R1RQdjVXd3hsd3BVRU9GclZScXA0cVVo?=
 =?utf-8?B?Z0J0WGhkcjBzNWRtSmVQeWdOZkE4THNIMVJaR0ZINDFITHBkdlNXd3RQNkxN?=
 =?utf-8?B?MG53YkZsZGp5QmFjV0c4YWloaDhyZmJSUXhCb0ZWblMwU3lNZmZMUFk3R24z?=
 =?utf-8?B?cUNwMk0vZ2pBWm1RaTlwVFRmZ284UVMzQmsvMnJIcHRJSTl3a1lGMFBqVFI1?=
 =?utf-8?B?TnNGbmhlK1p1b1NzOEl0ZFpMZkJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32DA5D69AE58A540A5987C7410DC9BE2@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f96e90d3-426e-4ae1-51b9-08dc392bf189
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 13:40:07.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGvAL+MstNb7GEMnI4lhZuBlO53a6HaD1O5iE4is7c/QcD1EF/+PpY+5132foVc1FVz2tcqqBQI9ZNntCdIY9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5301

T24gVGh1LCAyMDI0LTAyLTI5IGF0IDE3OjQxICswODAwLCBrdW53dS5jaGFuQGxpbnV4LmRldiB3
cm90ZToNCj4gRnJvbTogS3Vud3UgQ2hhbiA8Y2hlbnRhb0BreWxpbm9zLmNuPg0KPiANCj4gVXNl
IHRoZSBLTUVNX0NBQ0hFKCkgbWFjcm8gaW5zdGVhZCBvZiBrbWVtX2NhY2hlX2NyZWF0ZSgpIHRv
IHNpbXBsaWZ5DQo+IHRoZSBjcmVhdGlvbiBvZiBTTEFCIGNhY2hlcyB3aGVuIHRoZSBkZWZhdWx0
IHZhbHVlcyBhcmUgdXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1bnd1IENoYW4gPGNoZW50
YW9Aa3lsaW5vcy5jbj4NCj4gLS0tDQo+IMKgZnMvbmZzL3dyaXRlLmMgfCA1ICstLS0tDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2ZzL25mcy93cml0ZS5jIGIvZnMvbmZzL3dyaXRlLmMNCj4gaW5kZXggYmI3OWQz
YTg4NmFlLi42YTc1NzcyZDQ0N2YgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy93cml0ZS5jDQo+ICsr
KyBiL2ZzL25mcy93cml0ZS5jDQo+IEBAIC0yMTQ4LDEwICsyMTQ4LDcgQEAgaW50IF9faW5pdCBu
ZnNfaW5pdF93cml0ZXBhZ2VjYWNoZSh2b2lkKQ0KPiDCoAlpZiAobmZzX3dkYXRhX21lbXBvb2wg
PT0gTlVMTCkNCj4gwqAJCWdvdG8gb3V0X2Rlc3Ryb3lfd3JpdGVfY2FjaGU7DQo+IMKgDQo+IC0J
bmZzX2NkYXRhX2NhY2hlcCA9IGttZW1fY2FjaGVfY3JlYXRlKCJuZnNfY29tbWl0X2RhdGEiLA0K
PiAtCQkJCQnCoMKgwqDCoCBzaXplb2Yoc3RydWN0DQo+IG5mc19jb21taXRfZGF0YSksDQo+IC0J
CQkJCcKgwqDCoMKgIDAsIFNMQUJfSFdDQUNIRV9BTElHTiwNCj4gLQkJCQkJwqDCoMKgwqAgTlVM
TCk7DQo+ICsJbmZzX2NkYXRhX2NhY2hlcCA9IEtNRU1fQ0FDSEUobmZzX2NvbW1pdF9kYXRhLA0K
PiBTTEFCX0hXQ0FDSEVfQUxJR04pOw0KPiDCoAlpZiAobmZzX2NkYXRhX2NhY2hlcCA9PSBOVUxM
KQ0KPiDCoAkJZ290byBvdXRfZGVzdHJveV93cml0ZV9tZW1wb29sOw0KDQpJZiB0aGlzIHdlcmUg
YmVpbmcgZG9uZSBhcyBwYXJ0IG9mIGFuIGFjdHVhbCBmdW5jdGlvbmFsIGNvZGUgY2hhbmdlLA0K
dGhlbiBJJ2QgYmUgT0sgd2l0aCBpdCwgYnV0IG90aGVyd2lzZSBpdCBpcyBqdXN0IHVubmVjZXNz
YXJ5IGNodXJuIHRoYXQNCmdldHMgaW4gdGhlIHdheSBvZiBiYWNrIHBvcnRpbmcgYW55IGZ1dHVy
ZSBmaXhlcy4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==

