Return-Path: <linux-nfs+bounces-12136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DAAACF4AB
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50857AB9E2
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE42749F2;
	Thu,  5 Jun 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Xd/fuevk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC12750F8
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142091; cv=fail; b=ciVQVwA/oVBjfydfFNmBlMapuUuTHVTnyaytrNox8m1DaIFC6yhA3qVFSPFQK/5X2CNh7Kbu/n8iM+QL0lhvkEdymxOPpFIZOma2f3n6JafQqnckZEwYqDwL2om2SEyNu7Xwr4oVuII7kC7iX7iwwRQdsRQwDKhQpw8w7+NyTSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142091; c=relaxed/simple;
	bh=vHFtBPg5V89jH/dDbz4yAjntiv2aHXPOKbA+/WXpYxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uQ8/fWlrL9oOT42Lu78cTMpbp3loPwNAUx1jzQtGo5FJjUCr0ocrEKpvgRxNC02ZTbCVTb9q7C4SFMOGeJv0jsjcN3E2rhF3tSaaD1ITgg08mNwz4EXY2egsLRsoq1EPrUuG8dDIY9nyO659iX99kWTd4Cm0RSehIKlXO9vmvwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Xd/fuevk; arc=fail smtp.client-ip=40.107.244.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLERPDlGFBul8yY3+CSNaww13ZtfDk1EWcy/0D/UwT4wgkL8GeBW7TMP+wiX7OvZ5Gu5V2+MQRxprYbIL/H+1qg7yn21IOI+NaRL9zxy4uPsAoxPYqCY2CYop1kL3SVHyvTdIdWU5AA/0CCVV+/o1+xfWKcdeqjQpxnyDTrLHzxp1Qk7MrVJGRw4AIWK1AHo3B33UECBVWGNhj5/066CE+SCSsPCh692qBHeFaQ+CBXXIyaQg4X2FwJVZ0W8fEFxn0ZKjFido0j3qQ1/AyO4rExwJgqYSsm8pACJSf6U9AhDH7loZIhy5o7Bn6yhStEBs0AY8FjwMg+zCuEO+wpCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHFtBPg5V89jH/dDbz4yAjntiv2aHXPOKbA+/WXpYxQ=;
 b=atYk07SST31rPWtQo48F1SUgWW+8Wf4KwsC1PY09ojg0OuJfJ1VyRiTvw/r7GITq5gaGLpFck7f0UTX/OPz44LdmenmvreNnHptR17rX+LJr0/T18Mwo7ZL02R/pJh8OBm33CReb8LUvNF0k/mkecvdFZ4qmK+nkS2tFxbzli6XMX5+4Uzgw25ybptRasESqbuvD1R/6KLoxPGOuEdnOQhX+452MDAD/uTv79DYlUUS5Y7vC5HPaaRRfjpNfQNzl734ePSr6640uhJWnB5CTpnxwR9r4mkXaCfi29dXOJRdp3Ljl6hw3T09Kc6TbL+7YFhZ2HgjJVgsppgH1mhx4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHFtBPg5V89jH/dDbz4yAjntiv2aHXPOKbA+/WXpYxQ=;
 b=Xd/fuevkmf2kIq4xvtQfmJfaBSvrOeXWFa2t7C209lV+z0moXJVWGtx2s05BnLcUDRAcjcNy1JxAzm4NrYTmnZSi5LFzS1tBHpemJZs2GEl1+xrbjFo6BY+Mu4jvbrheKBPXtWgVZtFuhhqig0O1JrftN0Cjn+aeG2Pl/51WOp4=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 MW3PR13MB3963.namprd13.prod.outlook.com (2603:10b6:303:58::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.20; Thu, 5 Jun 2025 16:48:06 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%3]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 16:48:05 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "steved@redhat.com"
	<steved@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"loghyr@gmail.com" <loghyr@gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
Thread-Topic: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
Thread-Index: AQHbxA4BYF6lI/OArky6t+Zg31hpqbPzdEoAgAAOHYCAAAobgIABXpaA
Date: Thu, 5 Jun 2025 16:48:05 +0000
Message-ID: <c65a34cba5884a0d20fe3a9c9247919e2602fd40.camel@hammerspace.com>
References: <20250513-master-v1-1-e845fe412715@kernel.org>
	 <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
	 <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
	 <e6dbb6be-4e58-4d94-8912-05a5eee87ada@redhat.com>
In-Reply-To: <e6dbb6be-4e58-4d94-8912-05a5eee87ada@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|MW3PR13MB3963:EE_
x-ms-office365-filtering-correlation-id: b6c8f6a8-30b4-4bb9-507a-08dda450be86
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzZ2TUxrVUoxSGJYVzJZK3p4dG12U0FDTHRmR0lkLzVjMFpjcVVHUFlxZ0lW?=
 =?utf-8?B?d1Z1V05JSU5DN1lDT2RnSW5IeENWcDJNaFNlS0ZWdUE3b2VLNUVvTzR0cXo5?=
 =?utf-8?B?Z1dETWo2alkvS3I2WVBoQytzZEQvdWRmbFJqOGpPVEt6bjNQdERKUmtZRG0r?=
 =?utf-8?B?TklsYWwrcVFxSHVCeHZmOU11Z1l3SmVyVDdmUklld0h3R0IwTWtpK0ZZZnZE?=
 =?utf-8?B?MmNLWVUzZmdrMmU3U2lvWVd4RFI5QTIveDAvbElHdEZPYytaM3V4QnhiRTQ0?=
 =?utf-8?B?Yml6ZDFpS3EvTC9Bbk5ZYnVLQjFrR3JMV1RYcnhtNXR4OVROVkxDZHhmMUxO?=
 =?utf-8?B?akQ4d0NnN1JWTHQxNGdPTWtObFRrZGVxSVlGNm5RMHUya3dlcFJVZXozMFlw?=
 =?utf-8?B?Z0NRYzJrMzJHNDFRY08vdy8ydU14QXRidW1mOGk4TXVSemVmNTYrVlNNOW9L?=
 =?utf-8?B?Z1V5NmJlYVlkbWxmTFJYWHRKZG1ud29SYjRTOGRTcEdMMGxLZ0hjekwwQUNV?=
 =?utf-8?B?VWRUbEJwTW4vMWlodGdHOEZ0YlJaYXN6OGdnblJjZFV6bW96VkR5UHJQWDZS?=
 =?utf-8?B?MG9YWm1nZktReENTbHExSStXelhQdmgvZVVjZG5yVmtnNkxPUHRFY01qVS9N?=
 =?utf-8?B?M05uajViUUtsU2lUSW01ODg2S0g5K05hN3o4NjJ0QXZmcUhFL3NJRSs1dit2?=
 =?utf-8?B?WjI1NDBOZVNDdm92blg1R3RQTmVNTVBZWENGMjRzTnRFNys2ZElrWWhaaWxV?=
 =?utf-8?B?Mk1rUVJXRk1rQ3BrVStVQzRLa3hzZ1o4VzRDazVlQzFjZ1ViOTZyVlluTVZ1?=
 =?utf-8?B?cXIvWmptYUpsRlp6U2Mrdjl4K0lzT1N2aTZXSE1oWGZsc1hvY2ZKUVM4cWtE?=
 =?utf-8?B?aHVGTHYvcGRPSFFTRmZ5czZ5WUxFaTkyVi9CYXdkUzNPK0NlZFZ0eTIyL3Ax?=
 =?utf-8?B?cXkzYVpoNlVQZ3NyOThpeDVYNXNUcUtUMGVpenBqT1RKVEZteHd5ZUljUVRV?=
 =?utf-8?B?dktmS2pXMUJkWXJZcmgzVEZXUHoyYVQwUVJWYmlrLzlJZWFGL3UrQnEvY0J3?=
 =?utf-8?B?NTdZYlRjTzE5UmRQaFl2WU1hQ3pTOHYwcERQYTg2dTM4bVhUblFKU3VVRVZR?=
 =?utf-8?B?NGF0WlhFZEpNMngyL1k1T0IxanhmekNtMlAvSURaL1BZQ2RSYTZoWkdsbjZR?=
 =?utf-8?B?MlpwNVJZMnIzampZQXRwdmhUaElNUThTem9XU29Gejl1L1Jzckg5RWp0MWl4?=
 =?utf-8?B?Y2xwM1RRSml5MjJnOTJNVUVPMWZjbHRRTlZ3TnhoMDg2NUtwSmdLaGlBdlBP?=
 =?utf-8?B?K3F6Q2MvMzNUTEwvejdwVUpnbUhvdGxmQVFTL1ZKa2RZek9qbm1US2xjc2lU?=
 =?utf-8?B?QWZGSFlKZFdsT0tHWncwU1A1ak14TjIyZysveDZIUjY3SlNSR0gwaEp3dXlW?=
 =?utf-8?B?NWVGczdCdC9XZTVsQ3hqM0J2OGR3ZU4xQ1JpcGxHaVQzZk9mcVY4THNRb2FI?=
 =?utf-8?B?QmpFOHlsamhZS3QxV2ZIRERLam9qYnlMWHJLMVB1cXYybmx0dXlTclE3VGV2?=
 =?utf-8?B?dUZIamVLM2djNS9HUi9JWUdBRGZtN0FwLzNqdVc0YXR6UTNFNjZZejJVdGE4?=
 =?utf-8?B?dURKREFDKzZKdTN0eE5PdkN0d1R4RGVUZnhGVEZuMGtjdjNDY1RMa21zYjlG?=
 =?utf-8?B?TGQ2R3dpZ3BkbXJDK3VMQVJQNyt0aXpNSm9XcEVTdDFiR2t1VzRvRkhCL1F1?=
 =?utf-8?B?MHZKWHhlZm5mL2pRMEp0Q2xDWk1aTzh6RWpvNitKaXcxeHdoV0FNLzJDeEgx?=
 =?utf-8?B?Z3hvbHRwMjFzSnMyODZEcURuRGdXQUMzWDRmbk5zQ0lSOTNvY0FhVGJjb1p3?=
 =?utf-8?B?M3B1d1lwcllUVVhWOUNXL29hZTNYMVBOUlkxZUlSQ080S1JRSmJ3V1IzMXY0?=
 =?utf-8?B?b3ZzNkhQVnp5SWNPSThsNStmY0RPdnIwOFcza2srdEVLMVRBdCtoMjhINjJB?=
 =?utf-8?B?UWF5UEJ4ZUZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnRzR2JNM25GMFBFOVdYbElBVFo3dUZscGpyNUZOSXJrbnJWWFM3VEVmVGVQ?=
 =?utf-8?B?Z3NueFIwdjg3d3cwTkdVTFgwU2hINlVOQ25LRXovWEpiMGw1bUpOUmtmVTBs?=
 =?utf-8?B?SHk3dHNpNWVYRyt4TUsyd2pGTFlSTXZkZlc5MzhtL2R4L0VCazdXMXFjSjZu?=
 =?utf-8?B?ZmRHVS8xd1l5MDg2WnBIcUcvTStKYTh0U2lsdWh3ZU9QQ20yZ2ZpdlRaOERP?=
 =?utf-8?B?bG1ENmtrbEs5aytvb0xJb2JCT0RvUFQ0aGxaY09DT1Zqem5HYXM3bzlyRHlX?=
 =?utf-8?B?MnNDSmE4UVNjTFlVSFdJSXdvZXk5Um5RemdDZzlWVEZ2SG1WcDJSZEZOaG5L?=
 =?utf-8?B?RmJnd2puTXp3WFNIZy8yNTZlOW5sajR4OGZxZEFLZlJRcEdPVHhTbGdGOVVu?=
 =?utf-8?B?ekVzT0tmNGkwbmlib2RqZ214OS9PbHh5OENUbXl4ZTIrcDBFR2k5c1VNbG5t?=
 =?utf-8?B?UTNMdXcrdXF4aEpOOEtvWVlSOEJCQUY5emhIMW8rdms5TVZnVVpnZlJuWm4r?=
 =?utf-8?B?YVQxRmU3K2lLaXVqVExUbzJMVjFnU2xvcXdnUkRyVldQaDQ1TmFaTXJZSFo1?=
 =?utf-8?B?dVZScGszc1NFUnRhVHp4Z1crelhmRzBNV24zL3pnU0krV1AyRlJvQzQ1WDl5?=
 =?utf-8?B?MlRoMDlpVUdhZ2NpMjBFTEx4SUIxazJmNEZYRGZtd0xuVWxNaDJXZTB3MTJM?=
 =?utf-8?B?aUtaMUFpVWEwWU10ay8xWm5naDFCWVlmVGtGWVVqY0lROUJqT1gvYVNCSW1v?=
 =?utf-8?B?ejdpbmhaSDE1aHR4Q3JRblNPck9MWnpEZEU5dlF6RVB4aVNnQzRuSU00TDNj?=
 =?utf-8?B?TTgvam1MNmhjWlhLSzFxeGNod1Q4S3BNVzNkSUlKekF4dngyWXdZOFNNMGJm?=
 =?utf-8?B?NVdJc29tdzBYdXFnUGJGL0ZiMzFzNVFZZEJ0Z3VIejFFNHo4T1d5N3BUWUJF?=
 =?utf-8?B?M0ttWGpZekhTSjU1VnhvVGZDc3pETWpzNzA3bGIyQTNiekg4Yno0RUVpbEtX?=
 =?utf-8?B?T2Z4MUV6bUViMmtZMzJPQ05kN0hVeGgydXFISWxLWlozd3JSYmtYeXowVEs2?=
 =?utf-8?B?UmpMTW5WRm42RFRaTDNuVnBrVTZWeEZoM2lkeFBlTjYybTJWWklTeEVxTWhL?=
 =?utf-8?B?WTBmVE9QMWVKNWtKWDhjbHZvdGYvRUpSUTBoaGh2SVhTc2xXMTNHcmdxWXEx?=
 =?utf-8?B?aGhFT2tsa0doUkdPT3g4Z0twTncvbGplaytXYzcxMEdqcDNZOVZid1ZiTTdK?=
 =?utf-8?B?OFhEczMzczBpcEVxWndYaFBQWmxxQ1pNcUdsVzh2MTg2eUFHdHU1MkV2RWVY?=
 =?utf-8?B?WGozZHdrMDRkM2JkUEE4c1JxYXIxMDVNZFFTVytaMlNpOWMwZ2F3UVUwckp4?=
 =?utf-8?B?b1FQZ2JIK1JHZEYxa0pyZjBqRmZ5VFhrY2dDWVJDcGpWNmpsZXlqMzlDS0Ez?=
 =?utf-8?B?RVlZZTNid3VzamcvdEZTRTBCY3NhVkNXU0F4K2c0R3BoZ2psVXpPbUk3TXJw?=
 =?utf-8?B?ZjVLS2NBYXdIaTFxUzAzVlZMS3hqbU5BQ202SG00ZUYvcUo2TGhsL2NFU0hY?=
 =?utf-8?B?MVlRZ2hVbDhDR21EYmJRdnEwck9KbU4rUzlEMGdWbGd6YWFWaW5Vd3ZsejZE?=
 =?utf-8?B?Vjk5UCt4eEUyVVFFa2U0ZVBQMCtOZldFOVgrTXRNUU1wendrRVZUZXZpQ0tm?=
 =?utf-8?B?ZTROMGsvOXl5cWZxV1IzbEJmM2xGd0NiQkNOcGxLcUdPcUVmOHIwK2wzZkNB?=
 =?utf-8?B?b2NZejRHZFo0Tlc1OWExbWQ3QjAwZnB0cDlwWkdGUWhDTDQ0MmRyc3BxZHBM?=
 =?utf-8?B?SVRLMUlkYTk3MUZQTHVpbmpOYjIwOFpkNHp3UnExS1NKMWkwZFhTQzlJc0hN?=
 =?utf-8?B?QWQ0MHdjbXdZU3kwUEJuQ3dYOWR0K0xOeURQRVYxNW9rTWh2OTRpczhDU2tN?=
 =?utf-8?B?OUE5eWdDNmlDc1RKdnBKVEVPWjZVUHphSk1mVGFleDNTRnBtdE45TWtyT1Ay?=
 =?utf-8?B?T0lLaW9mMlFMSlVPY2pkQW1rWlZyTk84UlZzV3BqRmtuS3JiZmluWlFLVUU1?=
 =?utf-8?B?MGVBVDN6Y1BHb1VRS2toWGw1ZTZQMGF6RlY1R0dXNXE1ZDJWNC9PejJtSkxL?=
 =?utf-8?B?aHhlSEE0aGNYa09WK3NJM2hiSjhJczBuajRTblU4NzJzQU9ja205RXJzZXpj?=
 =?utf-8?B?TEhTNGJaQXZIYlJxbUxRSFBqS2JEYnUvWDQ5RUxFekpkUnNmYnprSDR2L2xY?=
 =?utf-8?B?WHk0dkhqR1ZxQ1BBeUY2eFUxSTFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6283557B76EB5A44B9FAFCA976A1C5DA@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c8f6a8-30b4-4bb9-507a-08dda450be86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 16:48:05.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCRw+tv1PWG6NToLhBvTCEiVqufgjiDlpg+UoDdmE/rP+E0ReLaIVA5xsX5tluynP/Ni8hhRBfGDc6J9Ssnlcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3963

T24gV2VkLCAyMDI1LTA2LTA0IGF0IDE1OjUzIC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDYvNC8yNSAzOjE3IFBNLCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMjUtMDYtMDQgYXQgMTQ6MjYgLTA0MDAsIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+ID4g
PiBIZWxsbyBhbGwsDQo+ID4gPiANCj4gPiA+IE9uIDUvMTMvMjUgOTo1MCBBTSwgSmVmZiBMYXl0
b24gd3JvdGU6DQo+ID4gPiA+IEJhY2sgaW4gdGhlIDgwJ3Mgc29tZW9uZSB0aG91Z2h0IGl0IHdh
cyBhIGdvb2QgaWRlYSB0byBjYXJ2ZQ0KPiA+ID4gPiBvdXQgYSBzZXQNCj4gPiA+ID4gb2YgcG9y
dHMgdGhhdCBvbmx5IHByaXZpbGVnZWQgdXNlcnMgY291bGQgdXNlLiBXaGVuIE5GUyB3YXMNCj4g
PiA+ID4gb3JpZ2luYWxseQ0KPiA+ID4gPiBjb25jZWl2ZWQsIFN1biBtYWRlIGl0cyBzZXJ2ZXIg
cmVxdWlyZSB0aGF0IGNsaWVudHMgdXNlIGxvdw0KPiA+ID4gPiBwb3J0cy4NCj4gPiA+ID4gU2lu
Y2UgTGludXggd2FzIGZvbGxvd2luZyBzdWl0IHdpdGggU3VuIGluIHRob3NlIGRheXMsIGV4cG9y
dGZzDQo+ID4gPiA+IGhhcw0KPiA+ID4gPiBhbHdheXMgZGVmYXVsdGVkIHRvIHJlcXVpcmluZyBj
b25uZWN0aW9ucyBmcm9tIGxvdyBwb3J0cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZXNlIGRheXMs
IGFueW9uZSBjYW4gYmUgcm9vdCBvbiB0aGVpciBsYXB0b3AsIHNvIGxpbWl0aW5nDQo+ID4gPiA+
IGNvbm5lY3Rpb25zDQo+ID4gPiA+IHRvIGxvdyBzb3VyY2UgcG9ydHMgaXMgb2YgbGl0dGxlIHZh
bHVlLg0KPiA+ID4gPiANCj4gPiA+ID4gTWFrZSB0aGUgZGVmYXVsdCBiZSAiaW5zZWN1cmUiIHdo
ZW4gY3JlYXRpbmcgZXhwb3J0cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpl
ZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBJbiBk
aXNjdXNzaW9uIGF0IHRoZSBCYWtlLWEtdGhvbiwgd2UgZGVjaWRlZCB0byBqdXN0IGdvIGZvcg0K
PiA+ID4gPiBtYWtpbmcNCj4gPiA+ID4gImluc2VjdXJlIiB0aGUgZGVmYXVsdCBmb3IgYWxsIGV4
cG9ydHMuDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoMKgIHN1cHBvcnQvbmZzL2V4cG9ydHMuY8Kg
wqDCoMKgwqAgfCA3ICsrKysrLS0NCj4gPiA+ID4gwqDCoCB1dGlscy9leHBvcnRmcy9leHBvcnRz
Lm1hbiB8IDQgKystLQ0KPiA+ID4gPiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3N1cHBv
cnQvbmZzL2V4cG9ydHMuYyBiL3N1cHBvcnQvbmZzL2V4cG9ydHMuYw0KPiA+ID4gPiBpbmRleA0K
PiA+ID4gPiAyMWVjNjQ4NmJhM2QzOTQ1ZGYwODAwOTcyYmExZGZkMDNiZDY1Mzc1Li42OWY4Y2E4
YjVlMmVkNTBiODM3ZWYNCj4gPiA+ID4gMjg3Y2EwNjg1YWYzZTcwZWQwYiAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvc3VwcG9ydC9uZnMvZXhwb3J0cy5jDQo+ID4gPiA+ICsrKyBiL3N1cHBvcnQvbmZz
L2V4cG9ydHMuYw0KPiA+ID4gPiBAQCAtMzQsOCArMzQsMTEgQEANCj4gPiA+ID4gwqDCoCAjaW5j
bHVkZSAicmVleHBvcnQuaCINCj4gPiA+ID4gwqDCoCAjaW5jbHVkZSAibmZzZF9wYXRoLmgiDQo+
ID4gPiA+IMKgwqAgDQo+ID4gPiA+IC0jZGVmaW5lIEVYUE9SVF9ERUZBVUxUX0ZMQUdTCVwNCj4g
PiA+ID4gLcKgDQo+ID4gPiA+IChORlNFWFBfUkVBRE9OTFl8TkZTRVhQX1JPT1RTUVVBU0h8TkZT
RVhQX0dBVEhFUkVEX1dSSVRFU3xORlNFWA0KPiA+ID4gPiBQX05PU1VCVFJFRUNIRUNLKQ0KPiA+
ID4gPiArI2RlZmluZSBFWFBPUlRfREVGQVVMVF9GTEFHUwkoTkZTRVhQX1JFQURPTkxZIHwJXA0K
PiA+ID4gPiArCQkJCSBORlNFWFBfUk9PVFNRVUFTSCB8CVwNCj4gPiA+ID4gKwkJCQkgTkZTRVhQ
X0dBVEhFUkVEX1dSSVRFUyB8XA0KPiA+ID4gPiArCQkJCSBORlNFWFBfTk9TVUJUUkVFQ0hFQ0sg
fCBcDQo+ID4gPiA+ICsJCQkJIE5GU0VYUF9JTlNFQ1VSRV9QT1JUKQ0KPiA+ID4gPiDCoMKgIA0K
PiA+ID4gPiDCoMKgIHN0cnVjdCBmbGF2X2luZm8gZmxhdl9tYXBbXSA9IHsNCj4gPiA+ID4gwqDC
oMKgCXsgImtyYjUiLAlSUENfQVVUSF9HU1NfS1JCNSwJMX0sDQo+ID4gPiA+IGRpZmYgLS1naXQg
YS91dGlscy9leHBvcnRmcy9leHBvcnRzLm1hbg0KPiA+ID4gPiBiL3V0aWxzL2V4cG9ydGZzL2V4
cG9ydHMubWFuDQo+ID4gPiA+IGluZGV4DQo+ID4gPiA+IDM5ZGMzMGZiODI5MDIxMzk5MGNhN2Ex
NGIxYjM5NzExNDBiMGQxMjAuLjBiNjJiYjNhODJiMGU3NGJjMmE3ZQ0KPiA+ID4gPiBiODQzMDFj
NGVjOTdiMTRkMDAzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS91dGlscy9leHBvcnRmcy9leHBvcnRz
Lm1hbg0KPiA+ID4gPiArKysgYi91dGlscy9leHBvcnRmcy9leHBvcnRzLm1hbg0KPiA+ID4gPiBA
QCAtMTgwLDggKzE4MCw4IEBAIHVuZGVyc3RhbmRzIHRoZSBmb2xsb3dpbmcgZXhwb3J0IG9wdGlv
bnM6DQo+ID4gPiA+IMKgwqAgLlRQDQo+ID4gPiA+IMKgwqAgLklSIHNlY3VyZQ0KPiA+ID4gPiDC
oMKgIFRoaXMgb3B0aW9uIHJlcXVpcmVzIHRoYXQgcmVxdWVzdHMgbm90IHVzaW5nIGdzcyBvcmln
aW5hdGUNCj4gPiA+ID4gb24gYW4NCj4gPiA+ID4gLUludGVybmV0IHBvcnQgbGVzcyB0aGFuIElQ
UE9SVF9SRVNFUlZFRCAoMTAyNCkuIFRoaXMgb3B0aW9uIGlzDQo+ID4gPiA+IG9uIGJ5IGRlZmF1
bHQuDQo+ID4gPiA+IC1UbyB0dXJuIGl0IG9mZiwgc3BlY2lmeQ0KPiA+ID4gPiArSW50ZXJuZXQg
cG9ydCBsZXNzIHRoYW4gSVBQT1JUX1JFU0VSVkVEICgxMDI0KS4gVGhpcyBvcHRpb24gaXMNCj4g
PiA+ID4gb2ZmIGJ5IGRlZmF1bHQNCj4gPiA+ID4gK2J1dCBjYW4gYmUgZXhwbGljaXRseSBkaXNh
YmxlZCBieSBzcGVjaWZ5aW5nDQo+ID4gPiA+IMKgwqAgLklSIGluc2VjdXJlIC4NCj4gPiA+ID4g
wqDCoCAoTk9URTogb2xkZXIga2VybmVscyAoYmVmb3JlIHVwc3RyZWFtIGtlcm5lbCB2ZXJzaW9u
IDQuMTcpDQo+ID4gPiA+IGVuZm9yY2VkIHRoaXMNCj4gPiA+ID4gwqDCoCByZXF1aXJlbWVudCBv
biBnc3MgcmVxdWVzdHMgYXMgd2VsbC4pDQo+ID4gPiA+IA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
YmFzZS1jb21taXQ6IDJjZjAxNWVhNDMxMmYzNzU5OGVmZTk3MzNmZWYzMjMyYWI2N2Y3ODQNCj4g
PiA+ID4gY2hhbmdlLWlkOiAyMDI1MDUxMy1tYXN0ZXItODk5NzQwODdiYjA0DQo+ID4gPiA+IA0K
PiA+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiBNeSBhcG9sb2dpZXMgYnV0IEkgZ290IGEgYml0
IGxvc3QgaW4gdGhlIGZhaXJseSBsYXJnZSB0aHJlYWQNCj4gPiA+IFdoYXQgYXMgaXMgY29uc2Vu
c3VzIG9uIHRoaXMgcGF0Y2g/IFRodW1icyB1cCBvciBkb3duLg0KPiA+ID4gV2lsbCB0aGVyZSBi
ZSBhIFYyPw0KPiA+ID4gDQo+ID4gPiBJJ20gd29uZGVyaW5nIHdoYXQgdHlwZSBkb2N1bWVudGF0
aW9uIGltcGFjdCB0aGlzIHdvdWxkDQo+ID4gPiBoYXZlIG9uIGFsbCBkb2NzIG91dCB0aGVyZSB0
aGF0IHNheSBvbmUgaGFzIHRvIGJlIHJvb3QNCj4gPiA+IHRvIGRvIHRoZSBtb3VudC4NCj4gPiA+
IA0KPiA+ID4gSSBndWVzcyBJJ20gbm90IGFnYWluc3QgdGhlIHBhdGNoIGJ1dCBhcyBOZWlsIHBv
aW50ZWQNCj4gPiA+IG91dCBtYWtpbmcgdGhpbmdzIGluc2VjdXJlIGlzIGEgZGlmZmVyZW50IGRp
cmVjdGlvbg0KPiA+ID4gdGhhdCB0aGUgcmVzdCBvZiB0aGUgd29ybGQgaXMgZ29pbmcuDQo+ID4g
PiANCj4gPiA+IG15IHR3byBjZW50cywNCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gVGh1bWJz
IGRvd24gZm9yIG5vdy4gTmVpbCBhcmd1ZWQgZm9yIGEgbW9yZSBtZWFzdXJlZCBhcHByb2FjaCB0
bw0KPiA+IGNoYW5naW5nIHRoaXMuDQo+ID4gDQo+ID4gSSBzdGFydGVkIHdvcmsgb24gYSBtYW5w
YWdlIHBhdGNoIGZvciBleHBvcnRzKDUpIGJ1dCBpdCdzIG5vdCBxdWl0ZQ0KPiA+IHJlYWR5IHll
dC4gSSBhbHNvIHdhbnQgdG8gbG9vayBhdCBjb252ZXJ0aW5nIHNvbWUgbWFucGFnZXMgdG8NCj4g
PiBhc2NpaWRvYw0KPiA+IGFzIHdlIGdvLCB0byBtYWtlIGZ1dHVyZSB1cGRhdGVzIGVhc2llci4N
Cj4gU291bmRzIGxpa2UgYSBwbGFuLi4uIFRoYW5rcyENCj4gDQo+IHN0ZXZlZC4NCj4gDQo+IA0K
DQpDYW4gd2UgcGxlYXNlIGFkZCBhbiBleHBsYW5hdGlvbiB0byB0aGUgbWFucGFnZSB0byBsZXQg
cGVvcGxlIGtub3cgd2h5DQp0aGlzIGRlZmF1bHQgaXMgc2V0Pw0KDQpJdCBpcyBiYXNpY2FsbHkg
aW4gb3JkZXIgdG8gcHJldmVudCBhbnkgdW50cnVzdGVkIFRvbSwgRGljayBvciBIYXJyeQ0KZnJv
bSBzcGlubmluZyB1cCBhIHVzZXJzcGFjZSBORlMgY2xpZW50IHRoYXQgc3Bvb2ZzIGEgZGlmZmVy
ZW50IHVzZXIuDQoNCklPVzogVGhlIGFzc3VtcHRpb24gaXMgdGhhdCB5b3Ugc2hvdWxkIGF0IGxl
YXN0IGJlIGFibGUgdG8gdHJ1c3QgdGhlDQprZXJuZWwgTkZTIGNsaWVudCB0byBhdCBwcm92aWRl
IHRoZSBjb3JyZWN0IGNyZWRlbnRpYWwgZm9yIGFuIHVudHJ1c3RlZA0KdXNlci4NCklmIHlvdSBj
YW4ndCBtYWtlIHRoYXQgYXNzdW1wdGlvbiwgdGhlbiB5b3VyIHNlcnZlciBzaG91bGQgcHJvYmFi
bHkgYmUNCmNvbmZpZ3VyZWQgdG8gc3F1YXNoIGFueSBBVVRIX1NZUyBjcmVkZW50aWFsIHN1cHBs
aWVkIGJ5IHRoaXMgY2xpZW50Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0K

