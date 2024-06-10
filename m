Return-Path: <linux-nfs+bounces-3640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC20902CA0
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 01:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE5A284419
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC415219B;
	Mon, 10 Jun 2024 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="SOqeiObU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2100.outbound.protection.outlook.com [40.107.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902B3BB48
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063682; cv=fail; b=n2i4tFoFuqH1zI/jvmsyL+FLnBLNk7Jtp/5QhvJkpzaA0vyxcAzle4V471JJeBa5ykJiLIWfO12PsUyXl9oPpXRVowX/YulHdZ8GqNAYnidHIIIqfGYHky/e3bKG10BFyFHgm4Mnc3mo+e1tdMysyUDskz5Bu3XxCV/m60Kxguw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063682; c=relaxed/simple;
	bh=f+5HbUxlSb2PcKNzESJtUhDK8baCLvET7DuRtrP9Qm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAKXDssTpSxJ+fQaf9DoyvTHC2QD7xCpp8I+fdnOvVh1MIm/dBlNBkKg2W9ipJqHnl7/0qgtkHFBWDN1zQZMg4yPjSILVzDGGiC8JZBODJcF9y3L/lh122R76DTkf3FHyy6PhBl95z69+io5ZKdxuOnDT9/WgLBrz8IVq0a3RZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=SOqeiObU; arc=fail smtp.client-ip=40.107.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQvbAnqAr02DvQC3WsW4yhi3YJ/4I+r4JwSV2ZpPpG2lldZWraM07e6V+XNm+Jl09rAlz703OwV42br9s518E7IrA4z8uevvYJhKczsp7Ccjl60oFLixUJ7paiWybGPNPZ8LXCSZ5FHkuNHZjYSE2q2Eb1q0bSUwWPSfWqkDLK3FYsqlnh3KG/KvkEG/5vLg21v6bJjyJKshGzUCLPKUK5UXoAKwFcIor2eRj/vX9t0FmVi9jCVYm85DscYykc9eidxVJLid8Eyso07VKegcZtUuVUd52KUinI4EW6PjnOD7mgDRYcbP8Vo/BcJDFJTZW5GT/2PtWiM7c2D4XHPPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+5HbUxlSb2PcKNzESJtUhDK8baCLvET7DuRtrP9Qm8=;
 b=apPHFFz4c4zdEU4+10beRi1XqBrHjeP3Yxpyn/TbzUqBzbxX/lq7e4rv1FulYPzXJkyDUtDIo52v9L09cZ2xYXun+kP9cKbF4ZBNPfj+RfRJ2PgOG7zta53Mb7HF0mkrTApmk3vqh7UBmf2pEJRQjLrBIdQhFgmCYQl9SmhkrOb6UT9puvKnEMr+wkx0PDkx1cf1UZtZ8UNylq4oTwRJsmxLp4HnsiWDxG4w1uNgFG8bXI9lKOpvRoRVo2qWD594aToGR9Lo7Z4roUEUJRAprpzaN6TN0zJsBfFJ7jxFCtjrQTJcoZNbbb2RDUKrB7gvKoRSP3GJGGAA1ZZxY1xV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+5HbUxlSb2PcKNzESJtUhDK8baCLvET7DuRtrP9Qm8=;
 b=SOqeiObU7fy8SwNrF+4QnH9A2f8wn/1axhkTKED/8EKAlNhlZYidi9KgULTCG2oHo4oEiCTWNVIO2fuv4BMxQ/EZogkLxHorRICFvMk8Es3C01GJj1RCreo6UyZ7oM6MSZnp15ZUCsTdRzmOZ1U4RTFO9n18jByhSDB8CMx21hg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS0PR13MB6307.namprd13.prod.outlook.com (2603:10b6:8:12a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16; Mon, 10 Jun
 2024 23:54:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 23:54:36 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "cel@kernel.org" <cel@kernel.org>,
	"tom@talpey.com" <tom@talpey.com>, "kolga@netapp.com" <kolga@netapp.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"dai.ngo@oracle.com" <dai.ngo@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Topic: [RFC PATCH] NFSD: Support write delegations for pNFS LAYOUT
 operations
Thread-Index: AQHau0eXWuSoQ4zLOEupu2fJidW957HBLfMAgAAW+ACAAGedgA==
Date: Mon, 10 Jun 2024 23:54:36 +0000
Message-ID: <0f25c54fde0089aa642de9e34fed0814dac8da17.camel@hammerspace.com>
References: <20240610150448.2377-2-cel@kernel.org>
	 <30924327aaee17182a83e18bc86e6a27a19d88ab.camel@hammerspace.com>
	 <Zmc7UOSMmeGcqkBa@tissot.1015granger.net>
In-Reply-To: <Zmc7UOSMmeGcqkBa@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS0PR13MB6307:EE_
x-ms-office365-filtering-correlation-id: a2217b2c-2624-4a4f-e0df-08dc89a8af05
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWk2N1NDQmkzNUlKbDZLaGhWZE5ja3Jkd0ZycURnclF5VE1vUDBsd2dJQlVU?=
 =?utf-8?B?SlJOR1JVRXYxSGlSd2twandpVjhpTGRqZUg1QWlvbDFhK3hiS2cwTDlrVWpp?=
 =?utf-8?B?YlJ3Zkd6OG8yWno1M0wxMGx2QTZJZXFtTEYvS1JXRVQybDdhZ3ZnRUMzbHBP?=
 =?utf-8?B?THhyT2ZVbzV1YkVXQnU5bkdpMlYyV0ZTeFMwZEE5R1E5SW43VmRzSmlqVHRV?=
 =?utf-8?B?dlRCZ0dlNDZQS0VxVVJ5a01RUWw1WWl4Znk0SGZRMGkzazd3TTFjVFFjanRm?=
 =?utf-8?B?U29IdVV4RXQwVjRTemtacnB6UnBGa2VZa3llczM2ekNmYlluN1hvMnFpalJj?=
 =?utf-8?B?OGUranp0TUtTRG5GbTROajN6WXZQbTFscWUyTE9BVGxHVDVPQnQwWWpTYlBo?=
 =?utf-8?B?VVFxYmV5TVFuMHJhSVo4d2hUM2NPR2VDWDVQNUdzY0U5cmgzWjVCeUFXU1Rw?=
 =?utf-8?B?RHp0UXRtVHlPelJKOXlNL1hFaGlTak1NZmRqZFZmNUxOZnVBMG1vSjdVbHNH?=
 =?utf-8?B?SG5sMTR0WlZRUzlVeUVybG8zR1J6VTFPd0VNeGpUbEp0MjQ5RUJzTEFXbFJK?=
 =?utf-8?B?a3B0RlRqYm5aZ3JML3BQMHhhQmNPeEZvQkxQVThIY0hEWEpveGJXZHZDS1p0?=
 =?utf-8?B?dnkrMktBck5UVUU1VUI4bUhNKzBRU3FDMVh3U2RBWTdJUVY5RTRoNS9oZURW?=
 =?utf-8?B?VUdML3lDazNCR3JpbEVpTDRZZ0VmTzdncnVsRU1XRmZqTnZ5Wmk5NzJIc0dE?=
 =?utf-8?B?ZjNvRFhKWTdDZW5tVDNjNG04emxzcW9GSW1VQUVNN3ZvU0lmL1JnTDJMdjdR?=
 =?utf-8?B?ZWNpVy8rMnNEVzNwL3JzZ0NpQXFTak1jY003OTQ5ck9xU0ZSa1VaUjJpdUFl?=
 =?utf-8?B?ZWI2SUROS3kyc0d6U2prVmxoL0ZDbUx0UC9hRTRMTDNqMHlwVWlBY1VVQmQ2?=
 =?utf-8?B?dE9ub2NrY3ZyRUlOUXBVdGVGODRCZmRoOWcxODQ3cmY0cGNPWW01cUZSalh0?=
 =?utf-8?B?U1JMek94RGxhRmhVUXJHUjZ2aUZ3NzRwdFV0dVF6VGRkeHN5cjlzeFN4K1pQ?=
 =?utf-8?B?VWZ0TE5lWFVMWTMraWF0SVR3SnhVK1FyeDFZQ2dCTTJVbnFMZ0RycFZpenV0?=
 =?utf-8?B?a21tNCszNHhldEpXYTRubVA5WkRjVGRsamhoWi9oaGRBKzNQUWdsQ0tQMU9S?=
 =?utf-8?B?OXU4d2krbkVJYVc2eStrWlN2eE1JcFNkRzU2WFFVb2kxTDF2ejRkKzBUNlZi?=
 =?utf-8?B?elAyUUl1dDVFbHowUjJRL3pWWEc2Z3NOMlNkTXVYS2ZGQ1JoL0Rab0hPNElI?=
 =?utf-8?B?T0l3VEw2cllvb1VXTjJDWGxuMkwrODgxVW1RWUhvelcvbmExUXZaZmt3eDlR?=
 =?utf-8?B?cmxXakw2TVd5b1dmNEhpb2lCM2U5YnhrMThEMXBnRFcxeHBBTmVQRDJ4U29a?=
 =?utf-8?B?WHpMSVRHenhpL3p4TTFMVFhpYU41dnMyNTBNSE81ODhSWHhPbEdSRjhlM1lS?=
 =?utf-8?B?a1R2SThiR3d4WU1GMGpvOEZpUHc1b3Y1RFVQbVZlQmt2VXJCWDFSWWs3SENL?=
 =?utf-8?B?ei9id2ZTaWRqNHZnS0FxTUNIMTlJRDFXcURUcFM2U2puWUxiL0MwcDdpa25D?=
 =?utf-8?B?SDBSbWpUM0xDbzk5c1JZMmV6cUZ1SHlwSXhsUVAzSG5zMk5HTGgzQXRlYWtl?=
 =?utf-8?B?UTJnUitwNjE1WXlZSllIaTl5OGF6Q2dLczJBZXlhcFI5OHRnK2VLV0VMdnds?=
 =?utf-8?B?Qm5vaWFDYlhqNXZSUlRkZ25iNzdLUnJHaVR1bVhubFFjY2xrNnRTNHZwL1B5?=
 =?utf-8?Q?xerlmhOHDwus2dpMhhbE6NUI1jS9BVcY7BInw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWxhcm5ZTUtlZnJWY2NiSi9RQzQzTTl4ME5KbVpvelltWFk4NHJaWmFKc1VS?=
 =?utf-8?B?Y3BZem15U3RtWjF4WFJyeVI1ZHJPcDRGSkxFQTlNaTVPUDlPcXFpcFV4R0t1?=
 =?utf-8?B?Nm9ITTNvOTBVQTNWYW1LUVpuRllLVENSVytMZHFod0l4enNuMVJDU0d2MVBZ?=
 =?utf-8?B?bk5sKzhnRFd4MmNRRzdhRnBHVEp6ZmF1S04xcTZob2JXZ1RxeUxUUXdKOUF5?=
 =?utf-8?B?Rm9FblAxU1N5bDNJNUMrRHhVZlQvK0w3ZHJEcHRWbUFxOG9qYVl6YWV1NjRM?=
 =?utf-8?B?YlBCSld6c2ZRcFdqdDVoVVRoeEJVWk1XQUpOR1JHNGVQdUQ3WkxKN2NFWEFV?=
 =?utf-8?B?eEFRd3FVQTVaMnNmNzEwcmlDMjA3bWd6TFN1eVZSMFdUZGdQQ0laczMzRkRU?=
 =?utf-8?B?RSs1WjM2Ym15MjJlSEhPN1N6L3JseXNhOXczaG1BdkFlMUZENlFmL3FoTTU2?=
 =?utf-8?B?YVRwWCt0aW1UKzUyblpMM1FmQnA2MWVsb3IzNFAzYWtVbHo0U1FydCtaOEFW?=
 =?utf-8?B?MDFGK0kxTGRUWmgwYlk5SzBETC9TZlJxTFdva29KSmIvV2FQS3RXejBwbGFT?=
 =?utf-8?B?dUJ1UjkzalAwMnVQQXNmaEJZZGprWXlzaW9Nb3lZbW9OU05lcHpSN2RTSHcw?=
 =?utf-8?B?ekZlVkduOWdoelNFekFQbXJ2QWhvK3p3dFlmejdST3d1SEQ3V3F4TWJNNVlC?=
 =?utf-8?B?VFlvZ3ZqM2hja1I1Q3Y0L2laZ0Zub3hkcEhZWXp3TzJmTHAvMU93aHlHVjc4?=
 =?utf-8?B?bXI4Tkc4U3dpcFAwZldYanhBV0lmTDZ4MEprOGRPRlNTT0gvMjkrYzUyVW5t?=
 =?utf-8?B?dkc4WHlSVm5YYjBlNlhkczZNYjhsSzJ3Mnp3STFIdFh3ZDFrUkd3SGdkUGVa?=
 =?utf-8?B?RThIS3NsbngySE5qeUVSM2VUU1V3UVZLanRNeC9CUjVyVm9lVE1iR08vUTV3?=
 =?utf-8?B?TXJuUHpOYW1rVXZKTmJMTWJ4TjFBaDZXUkdvdTlhYUNmSTNrWG0rSng3S1JO?=
 =?utf-8?B?dFFFZUpvTDdndlJ0RVZSZzFGV2MvMWVsbER0ODM2aHRoRkE5YUY5clJGMnBJ?=
 =?utf-8?B?d3lMN2tKd3QzR3oxTXo5MW9CSkRQM1NxSmJtd3hraVhsMUl0dWluRS9halRV?=
 =?utf-8?B?RDBLdDlXNnVNRTFDMVNJckJrTC9qSUhZZTRoNCs4MVVOS3NKcUxsNndQREZV?=
 =?utf-8?B?MHdxOGxjMzVtMTBaN3pPSUdWYzZKbi9wVk1jYmFmTW12cmlVU1haMm5OS0NU?=
 =?utf-8?B?VTBpVUhMcUd6bTV1Q2xBNlJHM2RKUkZwT1VkbUhIQlJ2dmNDSi82R2tyTlBF?=
 =?utf-8?B?ZFpOZUxNeDZJVjJDbmlaVnA1NlJLYXZBelRBcEtsQzFFYm1WTEliQ2pFTG5S?=
 =?utf-8?B?c2p0b2RtQVhBS0UzTHdkaXhsWFBEMjBpR0M3a3JZc3R6d3pQeWhFYk5UYjRH?=
 =?utf-8?B?Q09STFpJbkpkM3lYSmJ4UnVxdEMyRGp2cnpOS0YyUXNrMmgxSmp5K0diWWo5?=
 =?utf-8?B?Znk4ajZCOEhkSzZ0KzlkT2lBSGQ0SXdmV0ppMFZEcnN0MVhSTWk2OXNYcjlx?=
 =?utf-8?B?OTcxcFJ1RTZqNGNzajEwWjZJRms0d05ZK2tRYVpaNjl2aWtHTUJjT1I3c1hi?=
 =?utf-8?B?VmpCRTVKMTBJWjZiMHN4YXQxTjZkQmYzbXpVTzRtMkVFajRHNldvV0tsT1hV?=
 =?utf-8?B?cGFhK3U3OXpNZUVNNmpsV3ZvcHpFUUloTlhIQXRrajd6TkpJaUVpbzdMc1Vp?=
 =?utf-8?B?dVZ5c0RVY2lXWSt0Rkc3MVdKeGdyOGJSdDE0b2tMRlh1NmQrNG5MVHZPeXNv?=
 =?utf-8?B?SzN6ZEtPa0xPQy9LcjQ2enQyQ2VzQWhBSG9VeU1QZnRGTXpFWmZoUzFjYkpD?=
 =?utf-8?B?WllhVTV6VWM2N1dJQzcraGxlUUVFejR5VGxiU2hvQzVpMjlVVGRJYm0wZmVU?=
 =?utf-8?B?U1ZMTGpQbnd6cWJKcEExQW15K2VuWTVIUzhRdTB6c3ZjeldscytYOHRlVWt0?=
 =?utf-8?B?SDBKODQ0Z1JZbExCNWRZcGRZSnA2RGxNa1RBNnNTMldYamZmaGNtakNlODNn?=
 =?utf-8?B?MGU2T3VaazBOZjRRalhjWDlKZnYvMytiaFVaQUN4MSs2RzlFQ2c0cE42NFpY?=
 =?utf-8?B?WUdUa0JSMXozbFIycmFlTUdnbTFqZUZNQmpobnZjU0w5NGplNEV6TXp3VXlR?=
 =?utf-8?B?U0RoK3Y4c3RuRllHSnVsQmRTaEIwbTdybm85czQwTGVvL0RCT1QvYlVDZ21P?=
 =?utf-8?B?dC9YLzRCRzM0NGhKV0Jmek9XakVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BCD99B015A8D040836B4355EC4F42CD@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2217b2c-2624-4a4f-e0df-08dc89a8af05
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 23:54:36.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jtens0INu5u8A1TUNt3z6NXRYBJHU503ZTQt1B7571dgz0EjUJNTqXiAziWNVLnlyGPdqT8x2R/cZ4Yor5Yxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6307

T24gTW9uLCAyMDI0LTA2LTEwIGF0IDEzOjQzIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gTW9uLCBKdW4gMTAsIDIwMjQgYXQgMDQ6MjE6MzNQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0wNi0xMCBhdCAxMTowNCAtMDQwMCwgY2VsQGtlcm5l
bC5vcmfCoHdyb3RlOg0KPiA+ID4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+DQo+ID4gPiANCj4gPiA+IEkgbm90aWNlZCBMQVlPVVRHRVQoTEFZT1VUSU9NT0RFNF9S
VykgcmV0dXJuaW5nIE5GUzRFUlJfQUNDRVNTDQo+ID4gPiB1bmV4cGVjdGVkbHkuIFRoZSBORlMg
Y2xpZW50IGhhZCBjcmVhdGVkIGEgZmlsZSB3aXRoIG1vZGUgMDQ0NCwNCj4gPiA+IGFuZA0KPiA+
ID4gdGhlIHNlcnZlciBoYWQgcmV0dXJuZWQgYSB3cml0ZSBkZWxlZ2F0aW9uIG9uIHRoZSBPUEVO
KENSRUFURSkuDQo+ID4gPiBUaGUNCj4gPiA+IGNsaWVudCB3YXMgcmVxdWVzdGluZyBhIFJXIGxh
eW91dCB1c2luZyB0aGUgd3JpdGUgZGVsZWdhdGlvbg0KPiA+ID4gc3RhdGVpZA0KPiA+ID4gc28g
dGhhdCBpdCBjb3VsZCBmbHVzaCBmaWxlIG1vZGlmaWNhdGlvbnMuDQo+ID4gPiANCj4gPiA+IFRo
aXMgY2xpZW50IGJlaGF2aW9yIHdhcyBwZXJtaXR0ZWQgZm9yIE5GU3Y0LjEgd2l0aG91dCBwTkZT
LCBzbyBJDQo+ID4gPiBiZWdhbiBsb29raW5nIGF0IE5GU0QncyBpbXBsZW1lbnRhdGlvbiBvZiBM
QVlPVVRHRVQuDQo+ID4gPiANCj4gPiA+IFRoZSBmYWlsdXJlIHdhcyBiZWNhdXNlIGZoX3Zlcmlm
eSgpIHdhcyBkb2luZyBhIHBlcm1pc3Npb24gY2hlY2sNCj4gPiA+IGFzDQo+ID4gPiBwYXJ0IG9m
IHZlcmlmeWluZyB0aGUgRkguIEl0IHVzZXMgdGhlIGxvZ2FfaW9tb2RlIHZhbHVlIHRvDQo+ID4g
PiBzcGVjaWZ5DQo+ID4gPiB0aGUgQGFjY21vZGUgYXJndW1lbnQuIGZoX3ZlcmlmeShNQVlfV1JJ
VEUpIG9uIGEgZmlsZSB3aG9zZSBtb2RlDQo+ID4gPiBpcw0KPiA+ID4gMDQ0NCBmYWlscyB3aXRo
IC1FQUNDRVMuDQo+ID4gPiANCj4gPiA+IFJGQyA4ODgxIFNlY3Rpb24gMTguNDMuMyBzdGF0ZXM6
DQo+ID4gPiA+IFRoZSB1c2Ugb2YgdGhlIGxvZ2FfaW9tb2RlIGZpZWxkIGRlcGVuZHMgdXBvbiB0
aGUgbGF5b3V0IHR5cGUsDQo+ID4gPiA+IGJ1dA0KPiA+ID4gPiBzaG91bGQgcmVmbGVjdCB0aGUg
Y2xpZW50J3MgZGF0YSBhY2Nlc3MgaW50ZW50Lg0KPiA+ID4gDQo+ID4gPiBGdXJ0aGVyIGRpc2N1
c3Npb24gb2YgaW9tb2RlIHZhbHVlcyBmb2N1c2VzIG9uIGhvdyB0aGUgc2VydmVyIGlzDQo+ID4g
PiBwZXJtaXR0ZWQgdG8gY2hhbmdlIHJldHVybmVkIHRoZSBpb21vZGUgd2hlbiBjb2FsZXNjaW5n
IGxheW91dHMuDQo+ID4gPiBJdCBzYXlzIG5vdGhpbmcgYWJvdXQgbWFuZGF0aW5nIHRoZSBkZW5p
YWwgb2YgTEFZT1VUR0VUIHJlcXVlc3RzDQo+ID4gPiBkdWUgdG8gZmlsZSBwZXJtaXNzaW9uIHNl
dHRpbmdzLg0KPiA+ID4gDQo+ID4gPiBBcHByb3ByaWF0ZSBwZXJtaXNzaW9uIGNoZWNraW5nIGlz
IGRvbmUgd2hlbiB0aGUgY2xpZW50IGFjcXVpcmVzDQo+ID4gPiB0aGUNCj4gPiA+IHN0YXRlaWQg
dXNlZCBpbiB0aGUgTEFZT1VUR0VUIG9wZXJhdGlvbiwgc28gcmVtb3ZlIHRoZSBwZXJtaXNzaW9u
DQo+ID4gPiBjaGVjayBmcm9tIExBWU9VVEdFVCBhbmQgTEFZT1VUQ09NTUlULCBhbmQgcmVseSBv
biBsYXlvdXQgc3RhdGVpZA0KPiA+ID4gY2hlY2tpbmcgaW5zdGVhZC4NCj4gPiANCj4gPiBIbW0u
Li4gSSdtIG5vdCBzZWVpbmcgYW55IGNoZWNraW5nIG9yIGVuZm9yY2VtZW50IG9mIHRoZQ0KPiA+
IEVYQ0hHSUQ0X0ZMQUdfQklORF9QUklOQ19TVEFURUlEIGZsYWcgaW4ga25mc2QuDQo+IA0KPiBJ
IGFwcHJlY2lhdGUgeW91ciByZXZpZXchDQo+IA0KPiBJIHNlZSB0aGF0IEJJTkRfUFJJTkNfU1RB
VEVJRCBpcyBub3Qgc2V0IGJ5IE5GU0QuIFJGQyA4ODgxIFNlY3Rpb24NCj4gMTguMTYuNCBzYXlz
Og0KPiA+IE5vdGUgdGhhdCBpZiB0aGUgY2xpZW50IElEIHdhcyBub3QgY3JlYXRlZCB3aXRoIHRo
ZQ0KPiA+IEVYQ0hHSUQ0X0ZMQUdfQklORF9QUklOQ19TVEFURUlEIGNhcGFiaWxpdHkgc2V0IGlu
IHRoZSByZXBseSB0bw0KPiA+IEVYQ0hBTkdFX0lELCB0aGVuIHRoZSBzZXJ2ZXIgTVVTVCBOT1Qg
aW1wb3NlIGFueSByZXF1aXJlbWVudCB0aGF0DQo+ID4gUkVBRHMgYW5kIFdSSVRFcyBzZW50IGZv
ciBhbiBvcGVuIGZpbGUgaGF2ZSB0aGUgc2FtZSBjcmVkZW50aWFscw0KPiA+IGFzIHRoZSBPUEVO
IGl0c2VsZiwgYW5kIHRoZSBzZXJ2ZXIgaXMgUkVRVUlSRUQgdG8gcGVyZm9ybSBhY2Nlc3MNCj4g
PiBjaGVja2luZyBvbiB0aGUgUkVBRHMgYW5kIFdSSVRFcyB0aGVtc2VsdmVzLg0KPiANCj4gDQo+
IFRyb25kOg0KPiA+IERvZXNuJ3QgdGhhdCBtZWFuIHRoYXQNCj4gPiBSRUFEIGFuZCBXUklURSBh
cmUgcmVxdWlyZWQgdG8gY2hlY2sgYWNjZXNzIHBlcm1pc3Npb25zLCBhcyBwZXINCj4gPiBSRkM4
ODgxLCBzZWN0aW9uIDEzLjkuMi4zPw0KPiANCj4gRXZlcnkgTkZTdjQgUkVBRCBhbmQgV1JJVEUg
Y2FsbHMgbmZzNF9wcmVwcm9jZXNzX3N0YXRlaWRfb3AoKSwgYW5kDQo+IG5mczRfcHJlcHJvY2Vz
c19zdGF0ZWlkX29wKCkgY2FsbHMgbmZzZF9wZXJtaXNzaW9uKCkgKGluDQo+IG5mczRfY2hlY2tf
ZmlsZSgpKS4gU2VlbXMgbGlrZSB3ZSdyZSBjb3ZlcmVkLg0KPiANCj4gDQo+IFRyb25kOg0KPiA+
IEknbSBub3Qgc2F5aW5nIHRoYXQgdGhlIHJldHVybiBvZiBhbiBBQ0NFU1MgZXJyb3IgaXMgY29y
cmVjdCBoZXJlLA0KPiA+IHNpbmNlIHRoZSBmaWxlIHdhcyBjcmVhdGVkIHVzaW5nIHRoaXMgY3Jl
ZGVudGlhbCwgYW5kIHNvIHRoZSBjYWxsZXINCj4gPiBzaG91bGQgYmVuZWZpdCBmcm9tIGhhdmlu
ZyBvd25lciBwcml2aWxlZ2VzLg0KPiANCj4gVGhlIGFsdGVybmF0aXZlIGlzIHRvIHByZXNlcnZl
IHRoZSBhY2Ntb2RlIGxvZ2ljIGJ1dCBpbnN0ZWFkIGFkZCB0aGUNCj4gTkZTRF9NQVlfT1dORVJf
T1ZFUlJJREUgZmxhZywgbWUgdGhpbmtzLCB3aGljaCBpcyBub3Qgb2JqZWN0aW9uYWJsZS4NCj4g
DQo+IA0KPiBUcm9uZDoNCj4gPiBIb3dldmVyIHRoZSBpc3N1ZSBpcyB0aGF0IGtuZnNkIHNob3Vs
ZCBiZSBlaXRoZXIgY2hlY2tpbmcgdGhhdCB0aGUNCj4gPiBjcmVkZW50aWFsIGlzIGNvcnJlY3Qg
dy5yLnQuIHRoZSBzdGF0ZWlkIChpZg0KPiA+IEVYQ0hHSUQ0X0ZMQUdfQklORF9QUklOQ19TVEFU
RUlEIGlzIHNldCBhbmQgdGhlIHN0YXRlaWQgaXMgbm90IGENCj4gPiBzcGVjaWFsIHN0YXRlaWQp
IG9yIHRoYXQgaXQgaXMgY29ycmVjdCB3LnIudC4gdGhlIGZpbGUgcGVybWlzc2lvbnMNCj4gPiAo
aWYNCj4gPiBFWENIR0lENF9GTEFHX0JJTkRfUFJJTkNfU1RBVEVJRCBpcyBub3Qgc2V0IG9yIHRo
ZSBzdGF0ZWlkIGlzIGENCj4gPiBzcGVjaWFsDQo+ID4gc3RhdGVpZCkuDQo+IA0KPiBCdXQgTEFZ
T1VUR0VUIGlzIG5vdCBhIFJFQUQgb3IgV1JJVEUuIEkgZG9uJ3Qgc2VlIGxhbmd1YWdlIHRoYXQN
Cj4gcmVxdWlyZXMgc3RhdGVpZCAvIGNyZWRlbnRpYWwgY2hlY2tpbmcgZm9yIGl0LCBidXQgaXQn
cyBhbHdheXMNCj4gcG9zc2libGUgSSBtaWdodCBoYXZlIG1pc3NlZCBzb21ldGhpbmcuDQo+IA0K
PiBBbHNvLCBSRkMgNTY2MyBoYXMgbm90aGluZyB0byBzYXkgYWJvdXQgQklORF9QUklOQ19TVEFU
RUlELiBGdXJ0aGVyLA0KPiBJJ20gbm90IHN1cmUgaG93IGEgU0NTSSBSRUFEIG9yIFdSSVRFIGNh
biBjaGVjayBjcmVkZW50aWFscyBhcyBORlMNCj4gc3RhdGVpZHMgYXJlIG5vdCBwcmVzZW50ZWQg
dG8gU0NTSS9pU0NTSSB0YXJnZXRzLg0KPiANCj4gTGlrZXdpc2UsIGhvdyB3b3VsZCB0aGlzIGlt
cGFjdCBhIGZsZXhmaWxlIGxheW91dCB0aGF0IHRhcmdldHMNCj4gYW4gTkZTdjMgRFM/DQo+IA0K
PiBJIHRoaW5rIE5GU0QgaXMgY2hlY2tpbmcgc3RhdGVpZHMgdXNlZCBmb3IgTkZTdjQgUkVBRCBh
bmQgV1JJVEUgYXMNCj4gbmVlZGVkLCBidXQgaGVscCBtZSB1bmRlcnN0YW5kIGhvdyBCSU5EX1BS
SU5DX1NUQVRFSUQgaXMgYXBwbGljYWJsZQ0KPiB0byBwTkZTIGJsb2NrIGxheW91dHMuLi4/DQo+
IA0KPiANCg0KSWYgeW91IGxvb2sgYXQgU2VjdGlvbiAxNS4yLCB0aGVuIE5GUzRFUlJfQUNDRVNT
IGlzIGRlZmluaXRlbHkgbGlzdGVkDQphcyBhIHZhbGlkIGVycm9yIGZvciBMQVlPVVRHRVQgKGlu
IGZhY3QsIHRoZSB2ZXJ5IGZpcnN0IGluIHRoZSBsaXN0KS4NCg0KRnVydGhlcm1vcmUsIHBsZWFz
ZSBzZWUgdGhlIGZvbGxvd2luZyBibGFua2V0IHN0YXRlbWVudCBpbiBSRkM4ODgxLA0Kc2VjdGlv
biAxMi41LjEuOg0KDQogICAiTGF5b3V0cyBhcmUgcHJvdmlkZWQgdG8gTkZTdjQuMSBjbGllbnRz
LCBhbmQgdXNlciBhY2Nlc3Mgc3RpbGwNCiAgIGZvbGxvd3MgdGhlIHJ1bGVzIG9mIHRoZSBwcm90
b2NvbCBhcyBpZiB0aGV5IGRpZCBub3QgZXhpc3QuIg0KDQpXaGlsZSB5b3UgY2FuIGFyZ3VlIHRo
YXQgdGhlIGFib3ZlIGxhbmd1YWdlIGlzIG5vdCBub3JtYXRpdmUsIGJlY2F1c2UNCml0IGRvZXNu
J3QgdXNlIHRoZSBvZmZpY2lhbCBJRVRGICJNVVNUIiAvICJNVVNUIE5PVCIgLy4uLiwgaXQgY2xl
YXJseQ0KZG9lcyBkZWNsYXJlIGFuIGludGVudGlvbiB0byBlbnN1cmUgdGhhdCBwTkZTIG5vdCBi
ZSBhbGxvd2VkIHRvIHdlYWtlbg0KdGhlIHByb3RvY29sLg0KDQpTbyBteSBwb2ludCB3b3VsZCBi
ZSB0aGF0IGlmIExBWU9VVEdFVCBpcyB0aGUgb25seSB0aW1lIHdoZXJlIGEgcHJvcGVyDQpjcmVk
ZW50aWFsIGNoZWNrIGNhbiBvY2N1ciwgdGhlbiBpdCBuZWVkcyB0byBoYXBwZW4gdGhlcmUuIE90
aGVyd2lzZSwNCnlvdXIgaW1wbGVtZW50YXRpb24gaXMgcmVzcG9uc2libGUgZm9yIGVuc3VyaW5n
IHRoYXQgaXQgaGFwcGVucyBhdCBzb21lDQpvdGhlciB0aW1lLCBpbiBvcmRlciB0byBlbnN1cmUg
dGhhdCB1c2VyIGFjY2VzcyBmb2xsb3dzIHRoZSBydWxlcyBvZg0KdGhlIHByb3RvY29sLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

