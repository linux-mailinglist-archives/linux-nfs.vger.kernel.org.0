Return-Path: <linux-nfs+bounces-3478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B888D3D30
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6556F289E5A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CAC1591FC;
	Wed, 29 May 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Jbhgnfxv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2139.outbound.protection.outlook.com [40.107.236.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F52A55
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002333; cv=fail; b=l1z5HH2WSep8W9q1wyPHckP19wi5fGE5P478xzavpNScEO3QJYY2w0IUEPuotr0oImaaieaFAYeghDPPqZ46n3AKTZiCP2uHqUm2VS1pDqDwBdvCcM4LvVG37dxsb9SCm1gGCPiekHwZpG2AMiav/uUxWTmwl0JUWYqqqJh1aW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002333; c=relaxed/simple;
	bh=ZKXLCx9QEb+h9bfpq2w9Ky5pUEXZYiFjaFOjoSd2Wyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STSrcxGFq8onGA7UxmzU5JsyrYYPhHEUBnNJggg+aTr5nfQD3RRmI/IEV9wXYUuowUJJ8Hb368H4hZDNBfwd3IgTWfYqAFedRu1DrQYptjAQNeBeWNq1aWFhFbxDE0ZARnA+Lj9D8kriW/Pzff4r7/ms5/cdMs5w/YWPVlwJx5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Jbhgnfxv; arc=fail smtp.client-ip=40.107.236.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8lcbmOfBCSCznLGu/CvV2Q7DGvZwKc3H9qKuBIZ6uxylbpjiYaquSg0lgn2ggoqPOMexMJ/F4WQ1VuTFOw0lmidrWwXMiLqIUNrkoL7nX322CVldGxMfXOJ3Y0iNCza3Hziprtb91Ojf793+lK6P95Mi9ofPhTZzPIzcqhjxeSBhFr0hGh1DvSDKkpVhHq1yDFHX82v0RZGv6ElqFv+VUFPNYrCe4BrWGPDcI1LQJQ3npBiT7WMIRd9pMUBZvPOxkijcnpYzSog7FRk+13aSvncbSELx0sfncN54ud3xENYpP85JnzHZeOvfAjI2vRB58YLRZkbP+5jhKYDjl8rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKXLCx9QEb+h9bfpq2w9Ky5pUEXZYiFjaFOjoSd2Wyo=;
 b=W0XJwoHwOWAp/wIgnKyQdrhM4/1omHAYyynXJMah8ccBrHz6msfZO6x91H3gM1dbnLt0aYtCmBOveKk8tBevCWINcv7T48Bo3iNcvgR8com1zw4EYRhaJukxz5pJIp1pBZMD8nQrWzE/kUBb/mbIhmOVhLTMx3asrV0N0WLKQvwBmA+QgNcXqQSxeXdMtJfW4J5cjmctbOrd8JfNoaBNSpLzUttDSMIFXEzSHI7qVVgw2t9+BxrDVyRLIO7A0lI6vbt5aHFtUamVGgfJZv6bxZmoV05hq/0Xo1/9cVfIs7NQ+VngVD2Z091F2UzNScqodQy1XhNcrAgYPbZ2MQpLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKXLCx9QEb+h9bfpq2w9Ky5pUEXZYiFjaFOjoSd2Wyo=;
 b=JbhgnfxvW/PXGh5WSm/9MD2yjb98DpGeijrtYOQ1NS8ZItfIpyo+BXXVP5p632UWCd2D+wHRknJBCsZdnJIDv7IVL+AetIzEuxE6naUQuGoVLeXf290RR9KtM5QQQN9mzuk4IIbpvDjld+aSA1Bhiizedo98ABOphcXBpe28HFQ=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CO6PR13MB5260.namprd13.prod.outlook.com (2603:10b6:303:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:05:27 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 17:05:26 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jack@suse.cz" <jack@suse.cz>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
CC: "anna@kernel.org" <anna@kernel.org>, "nfbrown@suse.com" <nfbrown@suse.com>
Subject: Re: NFS write congestion size
Thread-Topic: NFS write congestion size
Thread-Index: AQHaseLWUtYvGxwZV0aUK4XVeNkc4rGucQaA
Date: Wed, 29 May 2024 17:05:26 +0000
Message-ID: <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>
In-Reply-To: <20240529161102.5x3hhnbz32lwjcej@quack3>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|CO6PR13MB5260:EE_
x-ms-office365-filtering-correlation-id: d26a842b-9906-4dc3-e6f8-08dc80018950
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UW5rU1hHTEphR202L1pTeTF2NFEvbjRIUitOVk1QZjJZczJ3dVNjRnI1bjNP?=
 =?utf-8?B?d292cHZMKy9mcVZvdjhWZXdNSjNzOHQ3UkQ1YXBsa2wyTmtLNWRMUCt4OEFE?=
 =?utf-8?B?MXF1RFRNdGo3bzNXTytGKy9pdkwvL0RjMEg3ZkQvVUJVNzMrelZ1dFg5T3cy?=
 =?utf-8?B?UGNLWnpIR3htQSsrRlZDMmhDVE5MazJHNS9SYjdka0JkQjd5L1lWN0hwQ1Fv?=
 =?utf-8?B?UFBXeDNzclFjK05YQVhOVU8zUEJ5UlU1YlVvbUwxdW42ckpHcVJMMWUwMW5Y?=
 =?utf-8?B?clNnaFdXWWt3S2lqcUM3RFhlcXhWWVhKY25RWVczbDB0c25XNXZ2bjdVRnky?=
 =?utf-8?B?d21uTUYxYlo4blczTEd5TlQweld6TG9keXJ5Y29QaGJZYnpWd2pzc2JmaHd4?=
 =?utf-8?B?Q0hGRjluOEc0WGpDVTRvZDAzNFhadFRsMVF1bGdraUtzUDQzcjZyOGk0WUhL?=
 =?utf-8?B?NElaRHc0MUhUcG1rWW1nUzNtUy9LczFuZDhmL0JuUmVnd1d3RG0rSUpqVGR6?=
 =?utf-8?B?OUUyVXV5UGY4dDdhSFNkR29GS2lEWXltR3lOS28rRy9zMkxLT2tCa3N3ZjRk?=
 =?utf-8?B?Y0VOcmQ3R25ja3E0M2RPSjRiZW9Mc25jUEE2NnZoKzQwdDhCRFVLUnZTLzV2?=
 =?utf-8?B?ZnVyM3dYQ3VsMW9tZmZBUkhRdkp0ZDZjd3UzOUdJclpEbHcrMEJCellVdlVv?=
 =?utf-8?B?bEE5bXJWcTNPVG13Y3psYWZ3OC9hZ1orWndacENzSkhaSzRBdDBLNmVLa0Fr?=
 =?utf-8?B?b2E4WnI2ZWlWQnRkTnJSdTZoS25CdkM3eDJjSXovM1NSaGxwSVpXbnVoeW00?=
 =?utf-8?B?Zkg0b2ZkS3YxTGFmS21iZDNDcTBMTFh2YW1OSkMyYTdPdGxwc1J6TFVlZEFw?=
 =?utf-8?B?M2xHSHc5M3B1emkwckFYQVF1ZEN0ZDRNZ3JoMm81cXpsRVIwVStUbi81OWgx?=
 =?utf-8?B?SExUa1VQU2pza1NIM3dFS2dsbU9UQitJM3lCS2J1dWs0TVg5cGVvazBiMFhK?=
 =?utf-8?B?T2l0Z09JRDBrM0tDQTI5UHgrb3RkdDY4b0F5am12bzdZYmJMT2JIWkxKaWU2?=
 =?utf-8?B?WFJJUkVtanNKaHcxNHl1alNiWkk5dWJEUDd6ZTIvaG5zSkJzZHZuSHZoZ2ps?=
 =?utf-8?B?a0NvN3dvaERpQ3FGdUt6aXRWT2YyeHBZN1ZhR2x1cWo5SG1maGJiS1c2QVhi?=
 =?utf-8?B?ZW5GZkJLYUNRQm5Ub3hOUjBUdlBsTjBaRWZJZExGTERYNXQzVlpmVUhXbXV3?=
 =?utf-8?B?V0N4MzdOOXJiRW1WRitCUFlSeG90REVjbEp0bkY5MVQ5eG1UNWxRV1ltSXp3?=
 =?utf-8?B?VmhvcVNUMjF6clBUWklBTXhzS01CbTJXZkFGVjEwM1VhYlpPQnJDWDc3M2R0?=
 =?utf-8?B?elN6TEpMcWZHQnJjelFhUXVVQlJxL1B3cDhpY0xYS3k5YXB3bVNVK1NkVHh0?=
 =?utf-8?B?RVBQSUNlQ0xUb29WYkxVbXF0NDZjYitoL1J1cHM5aDcvb2h0MTg2RGd3Tlp0?=
 =?utf-8?B?M05SMDZTdWovbUVIc0NTUFVBNlZOZHp2bG1ybWNhOWhzcXFITlhoVVkvaFVh?=
 =?utf-8?B?dG1WTmRGNkRlaGpJbmUwelNRYk1hY3REOHdZY0NJSkJpc0N1Y3VEUHJ2c1U1?=
 =?utf-8?B?ejlNMnNsQnhZYUNyY1NhZXRNRXVXamJLT25MMG0zamZNMTZGZ2g3L09WcFFB?=
 =?utf-8?B?empQNzdCTmM4TmQrQnhyYjBKNmpVTStrSVU5UmVlUDZjMDBaUU9paVpPMXBR?=
 =?utf-8?B?cVNCZHdXVkhRcWFwS01XV3BTVWNwUE5Fb3JzYkUxWUFqczdHTnEwTEpjaHYz?=
 =?utf-8?B?TnFrVURkV0QxV1IrUEgvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmhXMTdwRmNGT3JEQlNTZGdmdGFpZ3YyUHRvbVZPbExIOG1kQ0NZalhpQjBo?=
 =?utf-8?B?TGR0SEtoN0w4RUFJZHo1U1VEcGJYWnFPNmFLTUIxTnYzS0YrU216TkZaYUFW?=
 =?utf-8?B?dW1MYmZaeGg0em1oRXZVSEZXMTM4cVljVUpzc2NVeTNHVS9QRzdTck5iL2ZR?=
 =?utf-8?B?NXEwZHZFNHcyMXJNcUhaQ1d6aEZ0ODEvRVJ1cTlmYk9tMDQ0Uk9leVJkM2tl?=
 =?utf-8?B?NTNKbm5FYUdzeVd4YVEwQlNoaFVKUW1DcnhEcUlacnlKMGdWWVFXTGxmK0FK?=
 =?utf-8?B?eTRmc2lmSTVzbnk0ZVYyekxxajFXRVRiYW4veUVyczI5RWp3UkR6dmtrU0NK?=
 =?utf-8?B?K1lPZ0FOa1RrMUFTRHpIY3ZxZEduMlIza0lMc1FsbmdUZzNTQm5CZnVxWmJj?=
 =?utf-8?B?RkwzN3RWN3hnNE4wUTJwTmU0RjB4Y1gvR0I5RDU1L05KaGt3MUpZTzFJaCtC?=
 =?utf-8?B?REk0blBweDIxRWhIRURLQ1k4Vmo3M0phSFZaTWpzRlRmQWpLaDRyS2dzY2lQ?=
 =?utf-8?B?VERhS1Z0MDM5MUM4OEk1QWs2RnlaSDkyZHpuOW9iZlVvd1dzckdkdlRTTGxk?=
 =?utf-8?B?Sm0rOGFLTkJLNldSZXhlaUV5YTJXSmdGdElWUWNPRUtrbllKNDJ2aEpESFE4?=
 =?utf-8?B?ODhEb2UwVVVqNndIc3Z3SC9hZ3NPVm9qRG5PdTFQYVU5S0JPSW5MVVg2bk1K?=
 =?utf-8?B?T2Z5UGE1YmI1U0V3R2greHZZQ3JGeTU0NndRcDZZenYwUG9VbHpHMTAxb2Jn?=
 =?utf-8?B?OGIzdkxGMUVQZEF6YVFGQU5LWGd3akFoOHZtOFYxKzZKTE1YNDgraTUvTks1?=
 =?utf-8?B?alBrWTdNMVBhY3YzSC9FdndTV3NYWElVZXNwcDBtTmZRZWRiUm5RMklJSUxj?=
 =?utf-8?B?VVJocGVxOE5vNnFub093SDc0b1EzQVQyY3ZxYkN0K1FBdXpTZm5OaVExTUhW?=
 =?utf-8?B?dHlXN0Q3VHZsY0k0aWkvak55aWVEb1ViK1JITWUwaUhXZE51bC9YWTNwYjk3?=
 =?utf-8?B?NEdpNk13K3BzZmx2cFlPRG1FYkhlVGI3WGwzdjBGenVDZWR4Q3FzaTBJRHRl?=
 =?utf-8?B?VVhBZzR4aTNEK1A5RzNaVlByUGZxT05QUFlESk9lQnA2MGlTU0MvajMya0Vj?=
 =?utf-8?B?L2FLa3JCTitpUUNJeU1tSXRkaFRVS3drZWtBVERyZ3QwcDQ0bCtBb2R1d1J0?=
 =?utf-8?B?QzZNa1lYSmZNNXp6bW5CS0hrVE9iSHRmaXBvd0pCcFVNN1VDNERsSzlQOSs1?=
 =?utf-8?B?ajFSVDhkSHZEelVpTnRJT0Y4UnB0YzFmTytpb3FNejI0RWlVcnJTeEpZellu?=
 =?utf-8?B?VTFpMUgwMS92NkRocjVCb0Z5a0F2N2pWVWRuTkxVQ2d4TS9YYTBlVzV4MVBL?=
 =?utf-8?B?bkdZODI0YVp3TXFIdzk3dHZJMzN5UjdoaHNpR0JyM1lFTjNNTFlqMjJWOXE3?=
 =?utf-8?B?ai9lTjhOcExGL0FnbnNLUWNSNWRUdWdhbUF0MG1CSUVoUmRKM0Vvck51Tk84?=
 =?utf-8?B?d1NZTHBIV0FuekFkOUZsVFJrWGs3YUtyV2JGV2dVZURMQVl3THdXanM0d3pZ?=
 =?utf-8?B?eWZSUm1Tb0pwUlZTY0xvbVU5ZitZclh3alc1a24wUmF3Mmg5KzhUQ0RmWllO?=
 =?utf-8?B?dUo0SW5HaDRGNlMrcXFhSldBQzlMd3hQWE40aXhqZmZ4T08rRVRNUEdFaUlE?=
 =?utf-8?B?Q1lTTHJ4R0xBbHY2Z1EwVlcyS1hzOUkyU1dTY3IvMFhqSzVyOXB3dlRmb0Z3?=
 =?utf-8?B?T0JoQ2ZLY1NlZFFseHNpK3ZFYm4xVlN5ZFBPcWZrd3FTaGJuZXRtb0lWVmVr?=
 =?utf-8?B?eStNTElZYjNWNFpHakZHSXZYME96RCtQT25hSmZuQ1pBSmtRYnhwdzJ2NkVH?=
 =?utf-8?B?RTJ2c1V1RXJOcUlqejNaYnZ6djc1Y1dmSHRYOGFEUVlHRi9YZVBLdUpkTkZH?=
 =?utf-8?B?N01tdGFRK1VuV2hlRE1sSE5TSEx2aFlpUnNUV2s3TTJvaXR6c0UwQkN3WE9T?=
 =?utf-8?B?czF1SG40M0tzS3FRVDR4OURGRkZ1R2NsTWhOVUtSTFRPSTd6SEttWkVVbU83?=
 =?utf-8?B?UGlyYlVORCtNWDExU3Qwbnk0SDYrVGtzMHA2TGE4YWJvZjEwVVREWlZ0cEZa?=
 =?utf-8?B?U2FMSkxTK292MFhVc0s3VHQ3d2NkaWFqYmV3VnNmOFB2SmtwMkZRcGw4Z3Q5?=
 =?utf-8?B?a0JBK004UzBJbEJXSzlmZnhPRThiUVJzd1VVTWZuS1lGVEMwRmJOS25RRDJw?=
 =?utf-8?B?bVF5RWcxaE1Kb25xamQ5VHRDSUpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <319F8FB6717D494B86859560219E90B3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d26a842b-9906-4dc3-e6f8-08dc80018950
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 17:05:26.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nt3D0rGjZERIz8L4mf+JLalkdHjjGfEE2rqSQHHhuzsANhhwd2HajFDdjoqMl2Hhj5js7RldGcgc/L+hCJZfaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5260

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDE4OjExICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gSGVs
bG8sDQo+IA0KPiBzbyBJIHdhcyBpbnZlc3RpZ2F0aW5nIHdoeSByYW5kb20gd3JpdGVzIHRvIGEg
bGFyZ2UgZmlsZSBvdmVyIE5GUyBnb3QNCj4gbm90aWNlYWJseSBzbG93ZXIuIFRoZSB3b3JrbG9h
ZCB3ZSB1c2UgdG8gdGVzdCB0aGlzIGlzIHRoaXMgZmlvDQo+IGNvbW1hbmQ6DQo+IA0KPiBmaW8g
LS1kaXJlY3Q9MCAtLWlvZW5naW5lPXN5bmMgLS10aHJlYWQgLS1kaXJlY3Rvcnk9L21udCAtLQ0K
PiBpbnZhbGlkYXRlPTEgXA0KPiDCoMKgwqAgLS1ncm91cF9yZXBvcnRpbmc9MSAtLXJ1bnRpbWU9
MzAwIC0tZmFsbG9jYXRlPXBvc2l4IC0tDQo+IHJhbXBfdGltZT0xMCBcDQo+IMKgwqDCoCAtLW5h
bWU9UmFuZG9tV3JpdGVzLWFzeW5jLTI1NzAyNC00ay00IC0tbmV3X2dyb3VwIC0tcnc9cmFuZHdy
aXRlDQo+IFwNCj4gwqDCoMKgIC0tc2l6ZT0zMjAwMG0gLS1udW1qb2JzPTQgLS1icz00ayAtLWZz
eW5jX29uX2Nsb3NlPTEgLS0NCj4gZW5kX2ZzeW5jPTEgXA0KPiDCoMKgwqAgLS1maWxlbmFtZV9m
b3JtYXQ9J0Zpb1dvcmtsb2Fkcy4kam9ibnVtJw0KPiANCj4gRXZlbnR1YWxseSBJJ3ZlIHRyYWNr
ZWQgZG93biB0aGUgcmVncmVzc2lvbiB0byBiZSBjYXVzZWQgYnkNCj4gNmRmMjVlNTg1MzJiDQo+
ICgibmZzOiByZW1vdmUgcmVsaWFuY2Ugb24gYmRpIGNvbmdlc3Rpb24iKSB3aGljaCBjaGFuZ2Vk
IHRoZQ0KPiBjb25nZXN0aW9uDQo+IG1lY2hhbmlzbSBmcm9tIGEgZ2VuZXJpYyBiZGkgY29uZ2Vz
dGlvbiBoYW5kbGluZyB0byBORlMgcHJpdmF0ZSBvbmUuDQo+IEJlZm9yZQ0KPiB0aGlzIGNvbW1p
dCB0aGUgZmlvIGFjaGlldmVkIHRocm91Z2hwdXQgb2YgMTgwIE1CL3MsIGFmdGVyIHRoaXMNCj4g
Y29tbWl0IG9ubHkNCj4gMTIwIE1CL3MuIE5vdyBwYXJ0IG9mIHRoZSByZWdyZXNzaW9uIHdhcyBh
Y3R1YWxseSBjYXVzZWQgYnkNCj4gaW5lZmZpY2llbnQNCj4gZnN5bmMoMikgYW5kIHRoZSBmYWN0
IHRoYXQgbW9yZSBkaXJ0eSBkYXRhIHdhcyBjYWNoZWQgYXQgdGhlIHRpbWUgb2YNCj4gdGhlDQo+
IGxhc3QgZnN5bmMgYWZ0ZXIgY29tbWl0IDZkZjI1ZTU4NTMyYi4gQWZ0ZXIgZml4aW5nIGZzeW5j
IFsxXSwgdGhlDQo+IHRocm91Z2hwdXQgZ290IHRvIDE1MCBNQi9zIHNvIGJldHRlciBidXQgc3Rp
bGwgbm90IHF1aXRlIHRoZQ0KPiB0aHJvdWdocHV0DQo+IGJlZm9yZSA2ZGYyNWU1ODUzMmIuDQo+
IA0KPiBUaGUgcmVhc29uIGZvciByZW1haW5pbmcgcmVncmVzc2lvbiBpcyB0aGF0IGJkaSBjb25n
ZXN0aW9uIGhhbmRsaW5nDQo+IHdhcw0KPiBicm9rZW4gYW5kIHRoZSBjbGllbnQgaGFkIGhhcHBp
bHkgfjhHQiBvZiBvdXRzdGFuZGluZyBJTyBhZ2FpbnN0IHRoZQ0KPiBzZXJ2ZXINCj4gZGVzcGl0
ZSB0aGUgY29uZ2VzdGlvbiBsaW1pdCB3YXMgMjU2IE1CLiBUaGUgbmV3IGNvbmdlc3Rpb24gaGFu
ZGxpbmcNCj4gYWN0dWFsbHkgd29ya3MgYnV0IGFzIGEgcmVzdWx0IHRoZSBzZXJ2ZXIgZG9lcyBu
b3QgaGF2ZSBlbm91Z2ggZGlydHkNCj4gZGF0YQ0KPiB0byBlZmZpY2llbnRseSBvcGVyYXRlIG9u
IGFuZCB0aGUgc2VydmVyIGRpc2sgb2Z0ZW4gZ2V0cyBpZGxlIGJlZm9yZQ0KPiB0aGUNCj4gY2xp
ZW50IGNhbiBzZW5kIG1vcmUuDQo+IA0KPiBJIHdhbnRlZCB0byBkaXNjdXNzIHBvc3NpYmxlIHNv
bHV0aW9ucyBoZXJlLg0KPiANCj4gR2VuZXJhbGx5IDI1Nk1CIGlzIG5vdCBlbm91Z2ggZXZlbiBm
b3IgY29uc3VtZXIgZ3JhZGUgY29udGVtcG9yYXJ5DQo+IGRpc2tzIHRvDQo+IG1heCBvdXQgdGhy
b3VnaHB1dC4gVGhlcmUgaXMgdHVuYWJsZQ0KPiAvcHJvYy9zeXMvZnMvbmZzL25mc19jb25nZXN0
aW9uX2tiLg0KPiBJZiBJIHR3ZWFrIGl0IHRvIHNheSAxR0IsIHRoYXQgaXMgZW5vdWdoIHRvIGdp
dmUgdGhlIHNlcnZlciBlbm91Z2gNCj4gZGF0YSB0bw0KPiBzYXR1cmF0ZSB0aGUgZGlzayAobW9z
dCBvZiB0aGUgdGltZSkgYW5kIGZpbyByZWFjaGVzIDE4ME1CL3MgYXMNCj4gYmVmb3JlDQo+IGNv
bW1pdCA2ZGYyNWU1ODUzMmIuIFNvIG9uZSBzb2x1dGlvbiB0byB0aGUgcHJvYmxlbSB3b3VsZCBi
ZSB0bw0KPiBjaGFuZ2UgdGhlDQo+IGRlZmF1bHQgb2YgbmZzX2Nvbmdlc3Rpb25fa2IgdG8gMUdC
Lg0KPiANCj4gR2VuZXJhbGx5IHRoZSBwcm9ibGVtIHdpdGggdGhpcyB0dW5pbmcgaXMgdGhhdCBm
YXN0ZXIgZGlza3MgbWF5IG5lZWQNCj4gZXZlbg0KPiBsYXJnZXIgbmZzX2Nvbmdlc3Rpb25fa2Is
IHRoZSBORlMgY2xpZW50IGhhcyBubyB3YXkgb2Yga25vd2luZyB3aGF0DQo+IHRoZQ0KPiByaWdo
dCB2YWx1ZSBvZiBuZnNfY29uZ2VzdGlvbl9rYiBpcy4gSSBwZXJzb25hbGx5IGZpbmQgdGhlIGNv
bmNlcHQgb2YNCj4gY2xpZW50IHRocm90dGxpbmcgd3JpdGVzIHRvIHRoZSBzZXJ2ZXIgZmxhd2Vk
LiBUaGUgKnNlcnZlciogc2hvdWxkDQo+IHB1c2gNCj4gYmFjayAob3IgdGhyb3R0bGUpIGlmIHRo
ZSBjbGllbnQgaXMgdG9vIGFnZ3Jlc3NpdmVseSBwdXNoaW5nIG91dCB0aGUNCj4gZGF0YQ0KPiBh
bmQgdGhlbiB0aGUgY2xpZW50IGNhbiByZWFjdCB0byB0aGlzIGJhY2twcmVzc3VyZS4gQmVjYXVz
ZSBvbmx5IHRoZQ0KPiBzZXJ2ZXINCj4ga25vd3MgaG93IG11Y2ggaXQgY2FuIGhhbmRsZSAoYWxz
byBnaXZlbiB0aGUgbG9hZCBmcm9tIG90aGVyDQo+IGNsaWVudHMpLiBBbmQNCj4gSSBiZWxpZXZl
IHRoaXMgaXMgYWN0dWFsbHkgd2hhdCBpcyBoYXBwZW5pbmcgaW4gcHJhY3RpY2UgKGUuZy4gd2hl
biBJDQo+IHR1bmUNCj4gbmZzX2Nvbmdlc3Rpb25fa2IgdG8gcmVhbGx5IGhpZ2ggbnVtYmVyKS4g
U28gSSB0aGluayBldmVuIGJldHRlcg0KPiBzb2x1dGlvbg0KPiBtYXkgYmUgdG8ganVzdCByZW1v
dmUgdGhlIHdyaXRlIGNvbmdlc3Rpb24gaGFuZGxpbmcgZnJvbSB0aGUgY2xpZW50DQo+IGNvbXBs
ZXRlbHkuIFRoZSBoaXN0b3J5IGJlZm9yZSBjb21taXQgNmRmMjVlNTg1MzJiLCB3aGVuIGNvbmdl
c3Rpb24NCj4gd2FzDQo+IGVmZmVjdGl2ZWx5IGlnbm9yZWQsIHNob3dzIHRoYXQgdGhpcyBpcyB1
bmxpa2VseSB0byBjYXVzZSBhbnkNCj4gcHJhY3RpY2FsDQo+IHByb2JsZW1zLiBXaGF0IGRvIHBl
b3BsZSB0aGluaz8NCg0KSSB0aGluayB3ZSBkbyBzdGlsbCBuZWVkIGEgbWVjaGFuaXNtIHRvIHBy
ZXZlbnQgdGhlIGNsaWVudCBmcm9tIHB1c2hpbmcNCm1vcmUgd3JpdGViYWNrcyBpbnRvIHRoZSBS
UEMgbGF5ZXIgd2hlbiB0aGUgc2VydmVyIHRocm90dGxpbmcgaXMNCmNhdXNpbmcgUlBDIHRyYW5z
bWlzc2lvbiBxdWV1ZXMgdG8gYnVpbGQgdXAuIE90aGVyd2lzZSB3ZSBlbmQgdXANCmluY3JlYXNp
bmcgdGhlIGxhdGVuY3kgd2hlbiB0aGUgYXBwbGljYXRpb24gaXMgdHJ5aW5nIHRvIGRvIG1vcmUg
SS9PIHRvDQpwYWdlcyB0aGF0IGFyZSBxdWV1ZWQgdXAgZm9yIHdyaXRlYmFjayBpbiB0aGUgUlBD
IGxheWVyIChzaW5jZSB0aGUNCmxhdHRlciB3aWxsIGJlIHdyaXRlIGxvY2tlZCkuDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

