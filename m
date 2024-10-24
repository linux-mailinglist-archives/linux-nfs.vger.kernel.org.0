Return-Path: <linux-nfs+bounces-7421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5C9AE570
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CABC1F236DC
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2851D63D6;
	Thu, 24 Oct 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Mt47f+h6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2118.outbound.protection.outlook.com [40.107.94.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B611D319B;
	Thu, 24 Oct 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774672; cv=fail; b=hPhBkmYxvk4IKd1NABlpiX3XB7Z8ZIXiWoJXgNYwOa/Or2RP9yDr399T3Ta90GqgfkkM772X4tyvRB2kfWVnXyz68VU+ctocnqlHDzCZBVAsxy1kdN5exCJe2L9qtHQLtmkYjF/OFycwiodgvN72+w/Eoy6aPeVzYWfuT5Pm6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774672; c=relaxed/simple;
	bh=SDSMlDo4KWK7znfYb4YZLWFw62LaC4Qf9TX2OeVhH/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uMAP7q/0tViHj5yuuhvwExli4vS38x51xbUCdvsrYtkQgmefFZBTOsQzwfRPBr/Xm4Hc/WfCEelYQqa31kWFnRHEEm+6vkYBSkbd8GvFSSSF37oxzl94KJAHHZO4KB0iPFw+2jMlaPTPHMp3GOOmCHIDcjo5TQ32RsHbzFI54UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Mt47f+h6; arc=fail smtp.client-ip=40.107.94.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poEciLeVxZ06Pmf8HkigPs65nt1u+LK9wRZTLanS5smo15HCGr/iaWuZyAXQFnCAYOwfgGwaJqMcSRsxmeMWh+9rN3VodST4EsO72K45ysVsfNcSAlTjz9kKSLYE4kmdyFqGg/u0eebGkWc7GFc4a8Zgvu8em1qdAsLgHwcdhVTwXZl1rWBi2GTxTySPlFuqr8WQUNeAbLJFqIeAZW2u34gSmkGRbiXeypV4Cb0F5cDmJxIYke4yALiuZkK3gH8sEzeIbD1kk+4vYjzz/B9lJmEoxzFz8YMhrxYE3pBixX2Ayb0ixezFn9V6AaeiVFo7Sy6O+vcdWZHWBdx2OJSEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDSMlDo4KWK7znfYb4YZLWFw62LaC4Qf9TX2OeVhH/8=;
 b=zQUQ5bJKLQVjlZfQIddsklXkdP4MvXq61pJMo6oLLfCh5lA999H9+CGXMvjLO0hgxeHMXCzDAIVLTyxjnud/dCFmNKWGh3Hrdxox5GITyWrQoVc6YMfcLJD9HutH8SoE9EYutmyClwlXKJk0maN+iBpq57Zz7eXhxDHpVaiWcRGXso7efC7B655AF9AoDAS2WkoykTXApTWzik30CivCVc7ua47v5fQHNtdUYxKEHhWDFJJUyH6PLDb/691Q/+6hKHRwK3Ox4YVX9Z+Ql6csMC26qNZcXsdQM07jtgvPKiHfdCfciKMKl5F40VsxSwVBaAIlC0kN7jYTLOf4pFm+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDSMlDo4KWK7znfYb4YZLWFw62LaC4Qf9TX2OeVhH/8=;
 b=Mt47f+h6xlSc7oGFnbaXj8nzmpH6BYsqKNkUJiFURnVP45EpMlP0UcmxS7XCQmITtFLU2YiZu3d6fCRB5mRqSNOQE2BrJaz0gmVYcwfgyAu3rc5Rb9N97DGygab/OiIlV7E4/M+By8DiucH2QBRwelqm7t9O/UAb+erI0iiYuUc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3757.namprd13.prod.outlook.com (2603:10b6:208:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 12:57:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 12:57:45 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "okorniev@redhat.com"
	<okorniev@redhat.com>, "anna@kernel.org" <anna@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "liujian56@huawei.com"
	<liujian56@huawei.com>, "tom@talpey.com" <tom@talpey.com>,
	"edumazet@google.com" <edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp
 socket
Thread-Topic: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
Thread-Index: AQHbJbtPJ4ryUqLRAUiLTzYVTAhYbLKV3SkA
Date: Thu, 24 Oct 2024 12:57:45 +0000
Message-ID: <1d5a4a4f728b0cd44f006d5f5b0a90cecec1271c.camel@hammerspace.com>
References: <20241024015543.568476-1-liujian56@huawei.com>
	 <65b652e60d8681b0898efcd6e020f69447b6e606.camel@hammerspace.com>
In-Reply-To: <65b652e60d8681b0898efcd6e020f69447b6e606.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3757:EE_
x-ms-office365-filtering-correlation-id: 3bfdcb57-f554-42a7-ad05-08dcf42b744b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTBaUEZUVDVIOFlpMi9GREVON3N6OVcwWHBxTVJwOXB6ZURZbkZrL2FOcWFI?=
 =?utf-8?B?ZTNBZXoyM1luellwYk11TnNRTFRDRHA4RTB4RkdBT1hTejA4UTlKdU9KT0F3?=
 =?utf-8?B?UzFQL3ZJaCtGdXhkWnRvSHlNeElLZTFhMmNtWmxPazI2aFFvZVI3VFJUQ21i?=
 =?utf-8?B?QUdvcHM0VlpkUjNyR0pBYk1wazNoZCtrelVxTnArNEMzM2VmV1FtMEQwNmo2?=
 =?utf-8?B?dHI4YVJORHkrQ1RHQzE4Ym05eHo4KzZkdHZYWk93R1c5QzZrdG5WY3lmYWtr?=
 =?utf-8?B?cGY4MWtXUG1ud1g0bkg4Wkg1eUNYTlpGejZIVTh1NGtIS005ZXkvUHpOL3k0?=
 =?utf-8?B?U215U2p2eGVxaHR2RmZrS3pVelpScjdQcmZleU4rc2o3TlF3UFdmUkhyeTN1?=
 =?utf-8?B?WGZRZVdBYjlrZG5GTDFhSkR4UlhES1ltTTlCWWZFU3lOb0lmMFgrZlJHWnRS?=
 =?utf-8?B?UGdROHdqVnkyU3l0ZkNUVHE2NWo3L1EyRFczR0tJQjJmeUJvY3N4VGFJSEVP?=
 =?utf-8?B?ZUIwclVXWnNlNWluVTdQemIxSWI0S2o2MzhaME9hNFB4dmtOTXRYR2dnZWhU?=
 =?utf-8?B?S281MEJudjRuckhMb3lxbVROUkl4ekNoY2I4NFFiTWIzL2pGeVVKczM5ZnIz?=
 =?utf-8?B?bnYrMlhGSHNoc0tuZHVTWlhjMGY5Rjhoa24wWlFiK2hCV2JLenZnbmhRNXVp?=
 =?utf-8?B?eDZxMmNDRjh1U0dEOEt2cUpUNng2TjJlb0d0NjZYNnpWY1lVcmRESDI4dlRT?=
 =?utf-8?B?elV1bFZTS3BuYlBIL3lmcHFOWjZpK3M0b0UzS2RQbS9SZmk5U05ld3dNK2dr?=
 =?utf-8?B?blp4elFVZmJTcVZWcEkrZjQ5OEdzNDdUVExYeHdsM3RVQjNoYWdnTVJMNFJZ?=
 =?utf-8?B?WXR1eUtaSTZKQ0xlK3dMOUpLcEZQcDM2QVREV3RFbTZidmg5OHpSOXdnT29a?=
 =?utf-8?B?RUZmcGFYSGZwdnQvNXllRUhoOUJtb1lyQWt3V3FoNFArMkpQVkVYZzBVeUJD?=
 =?utf-8?B?cS9ZT1ZaTEQ3WTd4ZndTWGliTHlRSFI5NkNzVlZFOFdiQllDN0ExNlR3SS9q?=
 =?utf-8?B?ZVY5YjVkR3dBS1pGVDRxdENxcjY2bHlpWCtXci9RNkNaNTJMb2t3ZVpMY2p1?=
 =?utf-8?B?bmpDNFgrVzJ2Z3grTXlEOFJxME5PSERsYzd0Q1crUXVGMTllbk55UnErcU92?=
 =?utf-8?B?ZytkSG5VRHZjTzk2ZmpNanFvZVZEM0c1a3hrdll6L1FPckVJUnYyNVc2dXhM?=
 =?utf-8?B?YzVEYlNGUlIraHRBSm9oTGlIRlE4MEtnNDREYVlvamRGTWJLYXJCYWk1REc0?=
 =?utf-8?B?RlEydUFWbXBQMDUzZzdmZHlpMUlsaVl6SWpRK0o4VFNEU0FqcFlPNUVyZFpt?=
 =?utf-8?B?VVJjVGRBa2NaOUFBK2lXR1VoY1gyK2F3RXpZUlNRb2tIQ21VSG9GK2FYRERE?=
 =?utf-8?B?Yis3eHlSb25kSWxhL2NmeGVzbXBjV2tIbEV4Y2RGQXZvSHlSTWFpdlUzMWk1?=
 =?utf-8?B?K3p5bHpiZW5zZWZXMU1RaWxjQnhVZFV6Y2JGb3dqcUFJSjNrSkhPdXZ4UFVo?=
 =?utf-8?B?UTVBVEc5QmlmK05kZm4zL2xwZDRPcFQxM3RwdTkxTlYrNXFxZS9nTUt0YnQ2?=
 =?utf-8?B?bHpOWi9qMklkcnMwd04weFladlp0UGZYWHRDcDJaK0JQY0VlV3BiVmJmTG80?=
 =?utf-8?B?bjJxZGdrVTJVTzFldHBJQzdTVFIrY1JGZHpzZzI5dGh0eU1IL0RGU0RkNE9W?=
 =?utf-8?B?d2ZEVnZ3QzhpcUFWUnVNSGd0cEwycDZlMkdkZ2J2SlpZUzdrVGVuNDZPTkdM?=
 =?utf-8?B?N0w0aG9IMGp1L1JEWVJxYjd0L3BDSm94b0E4ZmlWRjE1d0lsTEw3TWJYVlJR?=
 =?utf-8?Q?alAUAX2rjD11i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWk2UnJGb284ZjIzcFNaTGgzWVpzN3d2TG5NUUNyT2tGMEZMUi9RK3RPUnFO?=
 =?utf-8?B?U2dMVjdiZFZpZ3gwdEl5eHExWFh2anZKSDFMbkQ4T2dhYmkxRHdqRnYvZ1Fz?=
 =?utf-8?B?ZHREaWI3Uy9KS3pCRFUyeEhOZ0xza3ZXY0ZVMHk5UWpJb3dEUzJKK2VmUThD?=
 =?utf-8?B?bXpGSm9RcUFKUWdEZ0lEbzRteDdmWGdHRFJqUWxxY05aQmlGei9NSTczWmQy?=
 =?utf-8?B?TnRYMWFZQkQrUzgrUUFoV2YyWWZhQ21MSFJ3VUllRWpwVEkyd3pCbS9ZLzg1?=
 =?utf-8?B?U1MvdXQxbHhaTmNkcDBqSXlRdUFRVEo3UWpZODhMaUE3T3dqc2YzY3NzV3BK?=
 =?utf-8?B?cjFzeStPM1I3d1BXV09Tc2NXQWpUUWRXa25XaXRaZi8rR2pvVlJaU3hjYlUz?=
 =?utf-8?B?N2dmZjRDNkJlZ1pnUmdNa28yLzNud3UyVWlXOHpheEsrSmxJcm9Sd2lTZ2U5?=
 =?utf-8?B?TnpscWJnNTl3OWwwN3MwbTd2TlNWc0JBaHFMczRaSlZMdi8xWnB0YWZoT3A4?=
 =?utf-8?B?MDkvdlZEcEtTdDNUZGlpTG40N1NCT0tCVWhxZ1doUS9vdlZyeE84Q2JNU1Ux?=
 =?utf-8?B?UXJUeGtyVjRMLzh6VzhITzVLVGV1Q3FsZERvbTZUeXFlZzdQc1liT3liOGd3?=
 =?utf-8?B?WndUa3c3VkVTaC82WjA2VkI2cDhLS1VWYjZiRk9qNVl3a1RHbDVFYTRtMFFE?=
 =?utf-8?B?M3dVZUtzMXNORUwrbHBFb1ZpTWVvK0p3aWN3MnZxKzhGTnhhNW9KNXorYTVi?=
 =?utf-8?B?eUhmVkh6elEvVHZSSE9oWVVvSTlqRXhLWXc0amUvSkU0QnIzRUtsckZaUE9Y?=
 =?utf-8?B?WHVuSlc2bnlDYjdGejV5cDJXZ3RiVTQ4RDV3WEpseTZpWHZRVCtlUGthRysw?=
 =?utf-8?B?UnYzL0lYU0Y0Qmozd3JKRmR6aFB5NU40NC9vTE4vM2VPYTRrYi9tcU5rd1Y4?=
 =?utf-8?B?Vmw5cWhwYWV5KzFZVTZGQmhwaVVPRkJYV3UrUC9FKzJYZUpYVTlndFBOYUZS?=
 =?utf-8?B?SXhBanB1UVY3Qlp1SVdYeXNVQ0hJOXNzRy9sSDA3WVplc3NrQnlwS0JzS0hV?=
 =?utf-8?B?ZE9ZdllycE9KZFlIUGpONUNUSkJiYnZaM2NJS1dDeVhBSjVDY0trNVY1VWdE?=
 =?utf-8?B?eTQ5U1BJbHB2UEtBK0xYUk85eGNPMWRXMWJ3d043cUtSRnVnbVdTaExMSUZJ?=
 =?utf-8?B?YVJuTVV5Y25pdDVsZ1oxVXo0YlU1WkJTQ1ZYUWFUajVtNUU1ZStKaVlnNUhh?=
 =?utf-8?B?eDgvYzZQcmI3SDgwUkhxUS8ybllPWjJSek1iTWoxREg2UlZ5dE41WXFIMnBt?=
 =?utf-8?B?MktXYWoxcWphd2RJeE5yYlZHeXIyN0tKLzg2V21kdTBDcXdQRXFiVTd6SFN5?=
 =?utf-8?B?R0dYTDJuK0JJeFcwWk9yR2w1MDZNdlF5dFFUcHdjaDJUMHNlaVF4T2k4alhw?=
 =?utf-8?B?ZXJWcUZCQWFiRmdBNU8vZ3FkQlBVdWFXL1l6QjlLbmQyVmdydlQwMXU4bjUr?=
 =?utf-8?B?NDNuY2paL2p6SE9OcFhWSVFCaTFhdEE3UU53a0wzdDJ1UEVsL01CdTNNTURV?=
 =?utf-8?B?ZHl5WE5xbWllUlIzRmQ0bHlGNE41citLTUZGMUFOcFV0VWtCV1pENDQ0blUz?=
 =?utf-8?B?elFReVR4d3hUWEllaDAycjJLZ0JPZk9OTzNwNFJUZVpXbjkvRm5RS3FRa1dU?=
 =?utf-8?B?STRNekxsVFl1S05lRUJyRGR2Y1hQRU1tNE1HZUZxNnN5ZGlEN214VnI0ZDFN?=
 =?utf-8?B?YXg0OEJyRGN5clY3c2VXVlBJZVE0Z2UrVDRhNFpSQ083S0VUdCtUNTlZUmNE?=
 =?utf-8?B?WlVBRzNuRStoUTFZeUJWd2pMRG4ySmVFMjF4Ym8xQTRnWHhGczIrK2xSUjdx?=
 =?utf-8?B?Q3cxZHpDbHRBc1haL0NINmJRQkxDSjlIUEVrM0hCYVpkRU93dXlxZHFUNXpC?=
 =?utf-8?B?Y3VyUHJyRi9EQk1Ub0x3S01SVzlMZmF2SEhzd25sTkE0UFlIQVNJMXNmZGdO?=
 =?utf-8?B?bVNhcExMQURtQzZWdzBCUVFiVkg1M25rVE5XZWgrVjNLNlV4WktwckZKWGRa?=
 =?utf-8?B?cDBxb2FhM1BuNFJwbFd6RlBHdGNNQnVkS0g4bEJuWGFRUXJFbm9FbnYyT2xw?=
 =?utf-8?B?WjhmSHExbWs5VGdtdFlaY1dXK3JDY1ZQUjhZUEJvZUs1c3E0cUkwUUFnOW9z?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFD9E3C6E7C70841997048A056F7F137@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfdcb57-f554-42a7-ad05-08dcf42b744b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 12:57:45.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v+1dtRlLJFC5V8XxjHOYglmXc4zvz4ox0tOGQ+eYRizEY76RYVsMm2N1dWKrpIrDGyfxyhdAR3+aGvF0lDucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3757

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDAyOjIwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFRodSwgMjAyNC0xMC0yNCBhdCAwOTo1NSArMDgwMCwgTGl1IEppYW4gd3JvdGU6DQo+
ID4gQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbg0KPiA+IHRjcF93cml0ZV90aW1l
cl9oYW5kbGVyKzB4MTU2LzB4M2UwDQo+ID4gUmVhZCBvZiBzaXplIDEgYXQgYWRkciBmZmZmODg4
MTExZjMyMmNkIGJ5IHRhc2sgc3dhcHBlci8wLzANCj4gPiANCj4gPiBDUFU6IDAgVUlEOiAwIFBJ
RDogMCBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNi4xMi4wLXJjNC1kaXJ0eQ0KPiA+ICM3
DQo+ID4gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5
NiksIEJJT1MgMS4xNS4wLQ0KPiA+IDENCj4gPiBDYWxsIFRyYWNlOg0KPiA+IMKgPElSUT4NCj4g
PiDCoGR1bXBfc3RhY2tfbHZsKzB4NjgvMHhhMA0KPiA+IMKgcHJpbnRfYWRkcmVzc19kZXNjcmlw
dGlvbi5jb25zdHByb3AuMCsweDJjLzB4M2QwDQo+ID4gwqBwcmludF9yZXBvcnQrMHhiNC8weDI3
MA0KPiA+IMKga2FzYW5fcmVwb3J0KzB4YmQvMHhmMA0KPiA+IMKgdGNwX3dyaXRlX3RpbWVyX2hh
bmRsZXIrMHgxNTYvMHgzZTANCj4gPiDCoHRjcF93cml0ZV90aW1lcisweDY2LzB4MTcwDQo+ID4g
wqBjYWxsX3RpbWVyX2ZuKzB4ZmIvMHgxZDANCj4gPiDCoF9fcnVuX3RpbWVycysweDNmOC8weDQ4
MA0KPiA+IMKgcnVuX3RpbWVyX3NvZnRpcnErMHg5Yi8weDEwMA0KPiA+IMKgaGFuZGxlX3NvZnRp
cnFzKzB4MTUzLzB4MzkwDQo+ID4gwqBfX2lycV9leGl0X3JjdSsweDEwMy8weDEyMA0KPiA+IMKg
aXJxX2V4aXRfcmN1KzB4ZS8weDIwDQo+ID4gwqBzeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQr
MHg3Ni8weDkwDQo+ID4gwqA8L0lSUT4NCj4gPiDCoDxUQVNLPg0KPiA+IMKgYXNtX3N5c3ZlY19h
cGljX3RpbWVyX2ludGVycnVwdCsweDFhLzB4MjANCj4gPiBSSVA6IDAwMTA6ZGVmYXVsdF9pZGxl
KzB4Zi8weDIwDQo+ID4gQ29kZTogNGMgMDEgYzcgNGMgMjkgYzIgZTkgNzIgZmYgZmYgZmYgOTAg
OTAgOTAgOTAgOTAgOTAgOTAgOTAgOTANCj4gPiA5MA0KPiA+IDkwIDkwDQo+ID4gwqA5MCA5MCA5
MCA5MCBmMyAwZiAxZSBmYSA2NiA5MCAwZiAwMCAyZCAzMyBmOCAyNSAwMCBmYiBmNCA8ZmE+IGMz
DQo+ID4gY2MNCj4gPiBjYyBjYw0KPiA+IMKgY2MgNjYgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAg
MDAgMDAgOTAgOTAgOTAgOTAgOTANCj4gPiBSU1A6IDAwMTg6ZmZmZmZmZmZhMjAwN2UyOCBFRkxB
R1M6IDAwMDAwMjQyDQo+ID4gUkFYOiAwMDAwMDAwMDAwMGYzYjMxIFJCWDogMWZmZmZmZmZmNDQw
MGZjNyBSQ1g6IGZmZmZmZmZmYTA5YzMxOTYNCj4gPiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJ
OiAwMDAwMDAwMDAwMDAwMDAwIFJESTogZmZmZmZmZmY5ZjAwNTkwZg0KPiA+IFJCUDogMDAwMDAw
MDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmZWQxMDIzNjA4MzVkDQo+
ID4gUjEwOiBmZmZmODg4MTFiMDQxYWViIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IDAwMDAw
MDAwMDAwMDAwMDANCj4gPiBSMTM6IGZmZmZmZmZmYTIwMmQ3YzAgUjE0OiAwMDAwMDAwMDAwMDAw
MDAwIFIxNTogMDAwMDAwMDAwMDAxNDdkMA0KPiA+IMKgZGVmYXVsdF9pZGxlX2NhbGwrMHg2Yi8w
eGEwDQo+ID4gwqBjcHVpZGxlX2lkbGVfY2FsbCsweDFhZi8weDFmMA0KPiA+IMKgZG9faWRsZSsw
eGJjLzB4MTMwDQo+ID4gwqBjcHVfc3RhcnR1cF9lbnRyeSsweDMzLzB4NDANCj4gPiDCoHJlc3Rf
aW5pdCsweDExZi8weDIxMA0KPiA+IMKgc3RhcnRfa2VybmVsKzB4MzlhLzB4NDIwDQo+ID4gwqB4
ODZfNjRfc3RhcnRfcmVzZXJ2YXRpb25zKzB4MTgvMHgzMA0KPiA+IMKgeDg2XzY0X3N0YXJ0X2tl
cm5lbCsweDk3LzB4YTANCj4gPiDCoGNvbW1vbl9zdGFydHVwXzY0KzB4MTNlLzB4MTQxDQo+ID4g
wqA8L1RBU0s+DQo+ID4gDQo+ID4gQWxsb2NhdGVkIGJ5IHRhc2sgNTk1Og0KPiA+IMKga2FzYW5f
c2F2ZV9zdGFjaysweDI0LzB4NTANCj4gPiDCoGthc2FuX3NhdmVfdHJhY2srMHgxNC8weDMwDQo+
ID4gwqBfX2thc2FuX3NsYWJfYWxsb2MrMHg4Ny8weDkwDQo+ID4gwqBrbWVtX2NhY2hlX2FsbG9j
X25vcHJvZisweDEyYi8weDNmMA0KPiA+IMKgY29weV9uZXRfbnMrMHg5NC8weDM4MA0KPiA+IMKg
Y3JlYXRlX25ld19uYW1lc3BhY2VzKzB4MjRjLzB4NTAwDQo+ID4gwqB1bnNoYXJlX25zcHJveHlf
bmFtZXNwYWNlcysweDc1LzB4ZjANCj4gPiDCoGtzeXNfdW5zaGFyZSsweDI0ZS8weDRmMA0KPiA+
IMKgX194NjRfc3lzX3Vuc2hhcmUrMHgxZi8weDMwDQo+ID4gwqBkb19zeXNjYWxsXzY0KzB4NzAv
MHgxODANCj4gPiDCoGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4g
PiANCj4gPiBGcmVlZCBieSB0YXNrIDEwMDoNCj4gPiDCoGthc2FuX3NhdmVfc3RhY2srMHgyNC8w
eDUwDQo+ID4gwqBrYXNhbl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KPiA+IMKga2FzYW5fc2F2ZV9m
cmVlX2luZm8rMHgzYi8weDYwDQo+ID4gwqBfX2thc2FuX3NsYWJfZnJlZSsweDU0LzB4NzANCj4g
PiDCoGttZW1fY2FjaGVfZnJlZSsweDE1Ni8weDVkMA0KPiA+IMKgY2xlYW51cF9uZXQrMHg1ZDMv
MHg2NzANCj4gPiDCoHByb2Nlc3Nfb25lX3dvcmsrMHg3NzYvMHhhOTANCj4gPiDCoHdvcmtlcl90
aHJlYWQrMHgyZTIvMHg1NjANCj4gPiDCoGt0aHJlYWQrMHgxYTgvMHgxZjANCj4gPiDCoHJldF9m
cm9tX2ZvcmsrMHgzNC8weDYwDQo+ID4gwqByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4g
PiANCj4gPiBSZXByb2R1Y3Rpb24gc2NyaXB0Og0KPiA+IA0KPiA+IG1rZGlyIC1wIC9tbnQvbmZz
c2hhcmUNCj4gPiBta2RpciAtcCAvbW50L25mcy9uZXRuc18xDQo+ID4gbWtmcy5leHQ0IC9kZXYv
c2RiDQo+ID4gbW91bnQgL2Rldi9zZGIgL21udC9uZnNzaGFyZQ0KPiA+IHN5c3RlbWN0bCByZXN0
YXJ0IG5mcy1zZXJ2ZXINCj4gPiBjaG1vZCA3NzcgL21udC9uZnNzaGFyZQ0KPiA+IGV4cG9ydGZz
IC1pIC1vIHJ3LG5vX3Jvb3Rfc3F1YXNoICo6L21udC9uZnNzaGFyZQ0KPiA+IA0KPiA+IGlwIG5l
dG5zIGFkZCBuZXRuc18xDQo+ID4gaXAgbGluayBhZGQgbmFtZSB2ZXRoXzFfcGVlciB0eXBlIHZl
dGggcGVlciB2ZXRoXzENCj4gPiBpZmNvbmZpZyB2ZXRoXzFfcGVlciAxMS4xMS4wLjI1NCB1cA0K
PiA+IGlwIGxpbmsgc2V0IHZldGhfMSBuZXRucyBuZXRuc18xDQo+ID4gaXAgbmV0bnMgZXhlYyBu
ZXRuc18xIGlmY29uZmlnIHZldGhfMSAxMS4xMS4wLjENCj4gPiANCj4gPiBpcCBuZXRucyBleGVj
IG5ldG5zXzEgL3Jvb3QvaXB0YWJsZXMgLUEgT1VUUFVUIC1kIDExLjExLjAuMjU0IC1wDQo+ID4g
dGNwDQo+ID4gXA0KPiA+IAktLXRjcC1mbGFncyBGSU4gRklOwqAgLWogRFJPUA0KPiA+IA0KPiA+
IChub3RlOiBJbiBteSBlbnZpcm9ubWVudCwgYSBERVNUUk9ZX0NMSUVOVElEIG9wZXJhdGlvbiBp
cyBhbHdheXMNCj4gPiBzZW50DQo+ID4gwqBpbW1lZGlhdGVseSwgYnJlYWtpbmcgdGhlIG5mcyB0
Y3AgY29ubmVjdGlvbi4pDQo+ID4gaXAgbmV0bnMgZXhlYyBuZXRuc18xIHRpbWVvdXQgLXMgOSAz
MDAgbW91bnQgLXQgbmZzIC1vDQo+ID4gcHJvdG89dGNwLHZlcnM9NC4xIFwNCj4gPiAJMTEuMTEu
MC4yNTQ6L21udC9uZnNzaGFyZSAvbW50L25mcy9uZXRuc18xDQo+ID4gDQo+ID4gaXAgbmV0bnMg
ZGVsIG5ldG5zXzENCj4gPiANCj4gPiBUaGUgcmVhc29uIGhlcmUgaXMgdGhhdCB0aGUgdGNwIHNv
Y2tldCBpbiBuZXRuc18xIChuZnMgc2lkZSkgaGFzDQo+ID4gYmVlbg0KPiA+IHNodXRkb3duIGFu
ZCBjbG9zZWQgKGRvbmUgaW4geHNfZGVzdHJveSksIGJ1dCB0aGUgRklOIG1lc3NhZ2UgKHdpdGgN
Cj4gPiBhY2spDQo+ID4gaXMgZGlzY2FyZGVkLCBhbmQgdGhlIG5mc2Qgc2lkZSBrZWVwcyBzZW5k
aW5nIHJldHJhbnNtaXNzaW9uDQo+ID4gbWVzc2FnZXMuDQo+ID4gQXMgYSByZXN1bHQsIHdoZW4g
dGhlIHRjcCBzb2NrIGluIG5ldG5zXzEgcHJvY2Vzc2VzIHRoZSByZWNlaXZlZA0KPiA+IG1lc3Nh
Z2UsDQo+ID4gaXQgc2VuZHMgdGhlIG1lc3NhZ2UgKEZJTiBtZXNzYWdlKSBpbiB0aGUgc2VuZGlu
ZyBxdWV1ZSwgYW5kIHRoZQ0KPiA+IHRjcA0KPiA+IHRpbWVyDQo+ID4gaXMgcmUtZXN0YWJsaXNo
ZWQuIFdoZW4gdGhlIG5ldHdvcmsgbmFtZXNwYWNlIGlzIGRlbGV0ZWQsIHRoZSBuZXQNCj4gPiBz
dHJ1Y3R1cmUNCj4gPiBhY2Nlc3NlZCBieSB0Y3AncyB0aW1lciBoYW5kbGVyIGZ1bmN0aW9uIGNh
dXNlcyBwcm9ibGVtcy4NCj4gPiANCj4gPiBUaGUgbW9kaWZpY2F0aW9uIGhlcmUgYWJvcnRzIHRo
ZSBUQ1AgY29ubmVjdGlvbiBkaXJlY3RseSBpbg0KPiA+IHhzX2Rlc3Ryb3koKS4NCj4gPiANCj4g
PiBGaXhlczogMjZhYmUxNDM3OWY4ICgibmV0OiBNb2RpZnkgc2tfYWxsb2MgdG8gbm90IHJlZmVy
ZW5jZSBjb3VudA0KPiA+IHRoZQ0KPiA+IG5ldG5zIG9mIGtlcm5lbCBzb2NrZXRzLiIpDQo+ID4g
U2lnbmVkLW9mZi1ieTogTGl1IEppYW4gPGxpdWppYW41NkBodWF3ZWkuY29tPg0KPiA+IC0tLQ0K
PiA+IMKgbmV0L3N1bnJwYy94cHJ0c29jay5jIHwgMyArKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0
c29jay5jIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ID4gaW5kZXggMGUxNjkxMzE2ZjQyLi45
MWVlMzQ4NDE1NWEgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ID4g
KysrIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+ID4gQEAgLTEyODcsNiArMTI4Nyw5IEBAIHN0
YXRpYyB2b2lkIHhzX3Jlc2V0X3RyYW5zcG9ydChzdHJ1Y3QNCj4gPiBzb2NrX3hwcnQNCj4gPiAq
dHJhbnNwb3J0KQ0KPiA+IMKgCXJlbGVhc2Vfc29jayhzayk7DQo+ID4gwqAJbXV0ZXhfdW5sb2Nr
KCZ0cmFuc3BvcnQtPnJlY3ZfbXV0ZXgpOw0KPiA+IMKgDQo+ID4gKwlpZiAoc2stPnNrX3Byb3Qg
PT0gJnRjcF9wcm90KQ0KPiA+ICsJCXRjcF9hYm9ydChzaywgRUNPTk5BQk9SVEVEKTsNCj4gDQo+
IFdlJ3ZlIGFscmVhZHkgY2FsbGVkIGtlcm5lbF9zb2NrX3NodXRkb3duKHNvY2ssIFNIVVRfUkRX
UiksIGFuZCB3ZSdyZQ0KPiBhYm91dCB0byBjbG9zZSB0aGUgc29ja2V0LiBXaHkgb24gZWFydGgg
c2hvdWxkIHdlIG5lZWQgYSBoYWNrIGxpa2UNCj4gdGhlDQo+IGFib3ZlIGluIG9yZGVyIHRvIGFi
b3J0IHRoZSBjb25uZWN0aW9uIGF0IHRoaXMgcG9pbnQ/DQo+IA0KPiBUaGlzIHdvdWxkIGFwcGVh
ciB0byBiZSBhIG5ldHdvcmtpbmcgbGF5ZXIgYnVnLCBhbmQgbm90IGFuIFJQQyBsZXZlbA0KPiBw
cm9ibGVtLg0KPiANCg0KVG8gcHV0IHRoaXMgZGlmZmVyZW50bHk6IGlmIGEgdXNlIGFmdGVyIGZy
ZWUgY2FuIG9jY3VyIGluIHRoZSBrZXJuZWwNCndoZW4gdGhlIFJQQyBsYXllciBjbG9zZXMgYSBU
Q1Agc29ja2V0IGFuZCB0aGVuIGV4aXRzIHRoZSBuZXR3b3JrDQpuYW1lc3BhY2UsIHRoZW4gY2Fu
J3QgdGhhdCBvY2N1ciB3aGVuIGEgdXNlcmxhbmQgYXBwbGljYXRpb24gZG9lcyB0aGUNCnNhbWU/
DQoNCklmIG5vdCwgdGhlbiB3aGF0IHByZXZlbnRzIGl0IGZyb20gaGFwcGVuaW5nPw0KDQo+ID4g
Kw0KPiA+IMKgCXRyYWNlX3JwY19zb2NrZXRfY2xvc2UoeHBydCwgc29jayk7DQo+ID4gwqAJX19m
cHV0X3N5bmMoZmlscCk7DQo+ID4gwqANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=

