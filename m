Return-Path: <linux-nfs+bounces-8866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013F9FF592
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 03:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F21882299
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 02:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD647A55;
	Thu,  2 Jan 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="DUpYTUYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2119.outbound.protection.outlook.com [40.107.100.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A717996
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735784325; cv=fail; b=qJN+xB6tjsUJVDHFki1RcsmNHvD0xuUVlt5/ei3zpdvQVOY3D7a02g1HxI47DkWRsSkeuCXqMTdSbWpE/nUDCSzExVJa7hkBb7IF9GE4xYbqHh6o4VOEaN8pB/aWc6cR4JVqVrmM3o5Xru3k8HgbUZ2VhNRqxwVAX9r7urD7UPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735784325; c=relaxed/simple;
	bh=l+4l0/yfjzhN8BkaYk6XF25Ox/jQDIE1t8VIs/j02w0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVlTTORsWBNxVOgA4Q5nUWLiL66mgv6ArJgz+5vDQ4TWC9ZZl0Q0bSC/0NSYg499ziFkhTdCg7Ls16hRIgOb29gB+0E5juY8R9BIW1kjYeg51YzLRMbkSHgU3ApftCTh8u9vDomC1H5Mo8yMWFvrXDYiXkltxD0QUxc3hBSLe/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=DUpYTUYx; arc=fail smtp.client-ip=40.107.100.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch7ICyr2ES2Eolg9c1muFsaCF7WoWzFPD+eQP18zuBP7aE39dr4TkbiINGTi54z7GmOy5xxbROPnec89j+/v211YoaKRgtO3zKjWDRMUmS9f2ufq2hJAoHTJjoe5bHJcJM77fASRT0rQSPp1GTM/CnNT1HCtISnVnX06hZfw4CNc9tMcCOaYv/NtcBgtOEH/bavqh50Ht1+OD5D6YY3t55jmSWRiqUQg/QBVdiqutpK8QklKW/IyDvaKPVkuWlX7HvKcoNLpNquyhh1w2yPjxmaV3XwSuIb+0L7Qi/PGur/d4rp2KPXLwNiXYNwseRosXA5/LHdIcHbccVmjV9Ya6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+4l0/yfjzhN8BkaYk6XF25Ox/jQDIE1t8VIs/j02w0=;
 b=Uxl/w6cIgy3otdpneJcvGth2lT4/qEhjD+7yTTY6dyC8br8lCldFbhTKCRSEQ8UL8oLbHuEHwim64r06fCB0MgS7tqf3XhT8hQurmKT/IIGkUK1U6T8dWtdGbSlwT6tE9VCs5hYSjtVuQB7FPnc5mDkHXIcozCDkm8nb/KhZgE+sZlaY3WFeD2ZzaEhFeCqSz1F3Zb/aWollGFot7xVKO6CUUQ/X89OHROzQyPOaYMQfY0/F1ORZop2CcRRogjNjbaJX+YF5XkxHqFoP5NcskBQpxoM9fXUtRDfgXu073U/7hl0Z4dDMQtMilaJBcZAtVuoXt0gWjbjXXiwqei5r1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+4l0/yfjzhN8BkaYk6XF25Ox/jQDIE1t8VIs/j02w0=;
 b=DUpYTUYxClv1cFxRnrzX7b6L2OGWA3xudxGArOlTjm4Mp6QotPXRtGrEvXuT9MIBpkQ1JyuWkF0DBC7X+BDM5XGIPaVUF/K89Z3rd6m9TBqzcfSNBbFdvBnFgGKRzX3c/gRd6wsz5b/gzuYQusjWlUugc2PM3ygrV0HJDA3SzKs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4663.namprd13.prod.outlook.com (2603:10b6:408:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 02:18:33 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 02:18:33 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "bfields@fieldses.org" <bfields@fieldses.org>, "Shubham.Gaikwad1@dell.com"
	<Shubham.Gaikwad1@dell.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"Ajey.Godbole@dell.com" <Ajey.Godbole@dell.com>
Subject: Re: Clarification on PyNFS Test Case Behavior for st_lookupp.testLink
 in Versions 4.0 and 4.1
Thread-Topic: Clarification on PyNFS Test Case Behavior for
 st_lookupp.testLink in Versions 4.0 and 4.1
Thread-Index: AdtcFL06/eNq/jyGQD2UjcrUFgrwSwAp+CmA
Date: Thu, 2 Jan 2025 02:18:32 +0000
Message-ID: <93be7e1a0cc5172d964f3ac65681d88b980ec3e1.camel@hammerspace.com>
References:
 <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
In-Reply-To:
 <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB4663:EE_
x-ms-office365-filtering-correlation-id: bc2b32aa-6faf-43d3-ae75-08dd2ad3c18b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUk3Snd3UUpiZG5UTnRVWEw1WkFtUWRGQk9janB0RGRpTjN3YytQTGt5UzNQ?=
 =?utf-8?B?NkFnVThLc05OUlZKakxpSzlkT2NoS1luNFRKQVMwcEVvVitOOTMvbEpXUUlw?=
 =?utf-8?B?dzFBY0d6L0pkREwzcHhKU0RMVmVDT1Q1a0RaWHV4QWdLeHdnUlkzZnM1azdB?=
 =?utf-8?B?WXIvODJ2TWlycFBvNHUrNENJWE5yT1JhdjdqcEhzUEIrMU0waENDQVBKanlK?=
 =?utf-8?B?NUhTcnJHYmxuOTlOeTBBcE9yOXRMK0twaWNHbUhzRytWeDI5UlBMdEZ4U2k5?=
 =?utf-8?B?OGQrbDMzN3Q5Rm1xeVVyM2k1RTg1TkxJRnkxcWU3OWZFdCtKZmNPbHRmR2Uz?=
 =?utf-8?B?RnhoZm9wT0puRTlmZjBvcWcvTDhSSHQ2QUN0RUJxdGl5OVM1QU10ZC9Ta1F0?=
 =?utf-8?B?dVplT00xTm5ra2hQSktJa0JsS2VnR0dqRlQzV0RESGpHRURNbVVtR1U5Q08x?=
 =?utf-8?B?K09OY1BObGJlZmRBWEZaZ0VWRkFhY3JQdEpoSW03R0RTQ3pGVUxtcFN6aW9D?=
 =?utf-8?B?czFRMDNiOGRrU2o3Y2g1MkgxZEVsUS9XT25JRHhxWlF3NndkMDZrcWo3cGJv?=
 =?utf-8?B?eXpVQjRwVUNRU3U3TGYrdjJaN1h2eDYxMVZFSVVQVWZRZ2JlZElnbVJIVkgy?=
 =?utf-8?B?WnlRZWdmWTFlUTlVMTdkYUE3bzZDVk0rRTVqbmtlaDluL2swU1hDdGJFZEYz?=
 =?utf-8?B?RlAyWVJLYVIrenV3cDdSUUQzMzlQZ0ZZNGtJQ2NnVDRXUngrcDJwRVFNSjNX?=
 =?utf-8?B?NFNJdEIrUTJBcFBXaktpNndHc3Vvb2dVbjhKYkdtUGxDYnE1cjFRNDdNZnpN?=
 =?utf-8?B?VytXeldMTzlZVUFNM3J0SW9EMVF5V2pzemtXU0htYkZLd2hBMkZtQTZKQnlU?=
 =?utf-8?B?azBqeTRPT2d3NXFvWHF3UVI2Wm9jM3dMZDBwRldhbENhWGx6NE1SalNYcUtT?=
 =?utf-8?B?eEFXVldLRHBlNk9yeFlkTytGUUVyQTV4dUorU1pobmZlb3VZTmhoZURWaEZy?=
 =?utf-8?B?bDN1aDFEU1draHgvaGYxYUhZV1V4RVBTOHdEWldTWXVMbzlOUzg3M3JkY3Jz?=
 =?utf-8?B?akV0ZkdjNFBGd2JDUE5JM3RRMEhYbDE1Wlpqc2NTY3FCYnhFVXlDVTlGM2tL?=
 =?utf-8?B?ajVXVnZxQU5Dc21PaUQ1ek1pcFhuRDdscXRONkdGNmVGQ1M2QXdVWG4yTUVs?=
 =?utf-8?B?emNQb0RhakRWOEN0UU9NSHpRQ05Ja2tOL2h0UjBsRVRWb3NuVlFrNnVnejNu?=
 =?utf-8?B?OEdSUm9OY0h2aDBpTlBRenZhVkhvVjNReFhkd2l1V3BTdUVXWk0rNHBBbEJW?=
 =?utf-8?B?a1pvNHdkd1BPUFBkOElHMzNGeUlKa2M3RjBqdXUrL1lVS2Zkdmx6RWpKckVC?=
 =?utf-8?B?bXYrNkZtUU1JV3J2cXd6RnUwY1l0YjhFRGJRNHZsNWE4T29YZ1JrREkxUzdu?=
 =?utf-8?B?aTNrZ1BMUjU5aE95ZitBRk5NRlNzRXlYbVBxS1hJV0Q0ZDNveFd2ZEZiT3dK?=
 =?utf-8?B?clBjSW9YMnUrUW9pSVB1SWRndTVoUjFwdXE1WjVQUmtEOUxUZUVBRERWS0pt?=
 =?utf-8?B?TDNCVkQ5RnlSa01WUit2a2RybGQrZ2NmTHhyL1J6OGtnOWNMQUtobjBKbElK?=
 =?utf-8?B?WnJ2ZXpEOGcwK3ZOTzQ4UEtnYlZnaVkzaFVyb2N4WGRnc2o3MFVMSVpLU0Zn?=
 =?utf-8?B?N1ZRcmtWaHM1Tkw2bWNKbld4eUZzMjVmTGd3UEZoL3pIRzkzeG9ndG9CcXB6?=
 =?utf-8?B?R2VWbEVUSG1IanpKTDdVVTR5bDhyRDI3amFpUTNlSkl3RktjbG4zcE82VUxW?=
 =?utf-8?B?aS80TFBUQnN4TmdLbXRtODJub05aVytSaUdqSUpZOFdxWlk0U2hjWUJlSmFR?=
 =?utf-8?B?OU9XbXFadmVrZml5MEJCUlRPc0JCMFM2V3E0bFFIU2pvVXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnorTFZDRThaU0VTZDlmWnhlREt0U29Hc1AvclhkN1FIaHd2c001bnBCOW1s?=
 =?utf-8?B?QmNiRDVlYW54UmFSZnE0WXpBMXV4dkVFWFlXYTVDN1AxUE5LU0lldDM1eXVO?=
 =?utf-8?B?T3ZUV2NreXA2RWNtcUR0MUJrVmpGMjl6a2hOL3h1YzZrNlNwN0pnd1VFZjVT?=
 =?utf-8?B?TENHOXFwOEVLRE1RWG5OeXRqVVM4bTBrb3pTT2xhL1F6ZlNZaUhGanJselFG?=
 =?utf-8?B?VG5hR1MydnAwMXQ1UWZzNXVuK09PNHpNV1VoVkNaNytiUHpvY0IxT3d2YkZU?=
 =?utf-8?B?eTkzRW9NT25zT2FlNVplNWhBTE9SSzlXM0pYc1V4SjJSSGtHNTdvcGNVWUtj?=
 =?utf-8?B?Y3NiZU8rTGNqRW5KakI2V0Z4NzJ6NktlUG9VZWh1UjhhaEowMnp0ZE9ld3lr?=
 =?utf-8?B?cGFRbWpuV3BYMXVSdW1HZTQ4M0ltWGJ1UWRVczVCY1JKVm5nMVJabTRJZ3di?=
 =?utf-8?B?Y1RiQTlyaDlxcjlhZ1ZlVXMrSUNlcU12QUhDZ2tMVkxjYXJPQUZQbmJGYTRa?=
 =?utf-8?B?TUcvZ1AvSjFhWVhvYzFlbmd4UFlzV3FSY29paWEwdHJ3a1NNSXUwVDRQbCt1?=
 =?utf-8?B?SVJSeDJPSFR3QVZjSnB3WkcxTk42eDI1VWFneUF3SkNldnljWVNZU3BlMnNM?=
 =?utf-8?B?cm9BY0pRdTNKVjh5YkN2Z3JIeWQrVElUTWZOemIxSjd5TVZ0SmNIUWRZNGxW?=
 =?utf-8?B?TjFsK0VYdWZTbXpEWkh3UVNSNHptSmJZMmxtZ2wxM0hablJ6Y01Zekp4SXIx?=
 =?utf-8?B?YlkyUEJIbEVteFI1cHEvWEQzMFhBVllKV0JjTnFMMzdyVk5Gc3JZTklIY1Nw?=
 =?utf-8?B?WTlJL3YwK09FcTlNM1RIZEtjU05POC91MS9pZXcwZlljYjZ6YzR0a2RNNkRR?=
 =?utf-8?B?TTNUWURrNmpabDlqVFpibXRFS20vQTQrTHFSZ1VkcmhjWE91dGJRd3RWc1Rm?=
 =?utf-8?B?UE1aUGlDMVVNVGY2WG1YV2x2cVNmRGFkY0FmNTNyN2ErN3JyODBKeTkwTEVI?=
 =?utf-8?B?SW9wTjVDZldwUXZteEd4YVRXQ0FUTGdzeENlRnlIK2twV2UvU2JXNEdXZ2Zn?=
 =?utf-8?B?Q0IzSzBjdTJIZWZhdmFQVUtBNHZWaG5KbFR1OUJZeVNLSVhINDFZa1E0Rk8r?=
 =?utf-8?B?UmFIRmU3SFg3MWVOaU1XU0R2cjRVWkpjdzlsRkQ2eHFwa1I2U1doMlo1U0M2?=
 =?utf-8?B?L280Q2htLzZXQVhqTm5qekwrUTNzM3FnM2N0elErTHhEVmFHalc3bnpSeWFR?=
 =?utf-8?B?TjdCL1VzWnJuUVd0aHZkK1U3SHo2UmgzQ0hSamlYVnpheE00QUQrWHhrenBr?=
 =?utf-8?B?R09MMEM0eVhweHpZVFMrd0U3VmpqK25kSXdGWEcxNXdzTk9RUS8wMk5PcURp?=
 =?utf-8?B?QVhjZDlleElmNWVDb2lHOGQydDhvaE5xcmJPU2libDloSmxKSnoyR2I0TmZ5?=
 =?utf-8?B?dFFOZXAwTW9YaDJ6NkthN01aMnFIdi9yUVhqaUlLZDJSMFc5VmNVMGU3Q1lp?=
 =?utf-8?B?R1pUMkt3U1A1Z1lQUTRQUWIzZXdvUEpxMjdObldVS2VWdCtNM29EVTZkSktG?=
 =?utf-8?B?TnkxRHFzSjVLcERPYWFPSHJUdU9hazdUOHpMRlNaOHVkWXhGdXBwUEFpUzRP?=
 =?utf-8?B?bTg1ajNpNGg2UXBudkJKdTRMTHJqcFR5TjZKRldIQzBUSlhhTU9oU1A5cXdM?=
 =?utf-8?B?M3BVRUYyc0JtRWlIUmc5b21EZzRqMTFJeVBiSXYyWmp1RzhVVGNudTNOaTJo?=
 =?utf-8?B?TGV0Ry92aWJ5dVlYaG44SFlTREErMEw0Rk40U1N4YUQyNzV1a3lHY0QyR3Vs?=
 =?utf-8?B?VkhQanVacGhBNE1WbStwWDNLRFBQZmNGVk80Y0p6ZFhldjFobXJSM2tncHc5?=
 =?utf-8?B?Wk1qZ0FFdUpjc242VXBCbE9CWmFFMUsxSDk3NGhWWjVMRWdsMUZuZktYN00r?=
 =?utf-8?B?QWl0K01VUXpDdkVKZzhRaUxFUXlnN3ExVmNFOE1sV0I5Slgwd01wdDZBME4w?=
 =?utf-8?B?WVg5eXhpekZqdlB1SVd4WVF2NHdRcDNRQm1nNHYrR2ZTVjYrZithWGo3bjA3?=
 =?utf-8?B?NllzYXVPdHNmdXZXRTBDU0pSeUNQSkJMRm5Ic1AvRnlQa0dzSWhpUFZEMGpV?=
 =?utf-8?B?cURWeUpaV3hxR0JyK3QycTZPM3ZpWkh0ZjRYZTZ0T3ljbEE2WlA0emNQME1H?=
 =?utf-8?B?T3RJMVVTN1h2N0FPeWhBQlpOQk1ka21PaXpqWFlNWkNPSWVIZzg5THRZUFov?=
 =?utf-8?B?Tk8yZ3l6WDR3Qi9XQWsrblVnQ1lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E0CF991972620459E057945C5C7405B@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b32aa-6faf-43d3-ae75-08dd2ad3c18b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 02:18:32.9756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d33td1iLq4bwhr8Z4UzO+0Z1bGdPzrbmiFnC+mSa8DNurSePk8CqCVryKScfuYUXniQiXBLh7ZR93u683+rE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4663

T24gV2VkLCAyMDI1LTAxLTAxIGF0IDA2OjI4ICswMDAwLCBHYWlrd2FkLCBTaHViaGFtIHdyb3Rl
Og0KPiBIaSBCcnVjZS9QeU5GUyB0ZWFtLA0KPiBJIGhvcGUgdGhpcyBlbWFpbCBmaW5kcyB5b3Ug
d2VsbC4NCj4gDQo+IEkgYW0gcmVhY2hpbmcgb3V0IHRvIHNlZWsgY2xhcmlmaWNhdGlvbiByZWdh
cmRpbmcgdGhlIFB5TkZTIHRlc3QgY2FzZQ0KPiAnc3RfbG9va3VwcC50ZXN0TGluaycgKGZsYWc6
IGxvb2t1cHAsIGNvZGU6IExPT0tQMmEvTEtQUDFhKSBpbmNsdWRlZA0KPiBpbiB0aGUgUHlORlMg
dGVzdCBzdWl0ZSBmb3IgdjQuMCBhbmQgdjQuMS4gU3BlY2lmaWNhbGx5LCBJIHdvdWxkIGxpa2UN
Cj4gdG8gdW5kZXJzdGFuZCB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IgcmVsYXRpbmcgdG8gdGhlIGVy
cm9yIGNvZGVzIGZvcg0KPiB0aGlzIHRlc3QgY2FzZS4NCj4gDQo+IEluIHRoZSBQeU5GUyB0ZXN0
IHN1aXRlIGZvciB2NC4wLCB0aGUgdGVzdCBjYXNlIExPT0tQMmEgKGxvY2F0ZWQgYXQNCj4gbmZz
NC4wL3NlcnZlcnRlc3RzL3N0X2xvb2t1cHAucHk6OnRlc3RMaW5rKSBpbml0aWFsbHkgY2hlY2tl
ZCBmb3IgdGhlDQo+IGVycm9yIGNvZGUgTkZTNEVSUl9OT1RESVIuIFN1YnNlcXVlbnRseSwgYW4g
dXBkYXRlIHdhcyBtYWRlIHRvIHRoaXMNCj4gdGVzdCBjYXNlIHRvIGFsc28gZXhwZWN0IE5GUzRF
UlJfU1lNTElOSyBpbiBhZGRpdGlvbiB0bw0KPiBORlM0RVJSX05PVERJUiBbcmVmZXJlbmNlOiBn
aXQubGludXgtbmZzLm9yZyBHaXQgLQ0KPiBiZmllbGRzL3B5bmZzLmdpdC9jb21taXRkaWZmXS4g
SG93ZXZlciwgaW4gdGhlIFB5TkZTIHRlc3Qgc3VpdGUgZm9yDQo+IHY0LjEsIHRoZSBjb3JyZXNw
b25kaW5nIHRlc3QgY2FzZSBMS1BQMWEgKGxvY2F0ZWQgYXQNCj4gbmZzNC4xL3NlcnZlcjQxdGVz
dHMvc3RfbG9va3VwcC5weTo6dGVzdExpbmspIGNvbnRpbnVlcyB0byBjaGVjayBvbmx5DQo+IGZv
ciBORlM0RVJSX1NZTUxJTksgYXMgdGhlIGV4cGVjdGVkIGVycm9yIGNvZGUuDQo+IA0KPiBHaXZl
biB0aGUgZGlzY3JlcGFuY3ksIHNob3VsZCB0aGUgdGVzdCBjYXNlIGZvciB2NC4xIChMS1BQMWEp
IGJlDQo+IHVwZGF0ZWQgdG8gYWxzbyBjaGVjayBmb3IgTkZTNEVSUl9OT1RESVIsIHNpbWlsYXIg
dG8gdGhlIG1vZGlmaWNhdGlvbg0KPiBtYWRlIGZvciB0aGUgdjQuMCB0ZXN0IGNhc2UgKExPT0tQ
MmEpPyBBZGRpdGlvbmFsbHksIHdoaWxlIHRoZSBSRkMNCj4gODg4MSBzZWN0aW9uIG9uIHRoZSBs
b29rdXBwIG9wZXJhdGlvbiBbcmVmZXJlbmNlOiBTZWN0aW9uIDE4LjE0Og0KPiBPcGVyYXRpb24g
MTY6IExPT0tVUFAgLSBMb29rdXAgUGFyZW50IERpcmVjdG9yeV0gZG9lcyBub3QgZXhwbGljaXRs
eQ0KPiBtZW50aW9uIHRoZSBlcnJvciBjb2RlIE5GUzRFUlJfU1lNTElOSywgaXQgaXMgbm90ZWQg
aW4gU2VjdGlvbnMgMTUuMg0KPiBbcmVmZXJlbmNlOiBPcGVyYXRpb25zIGFuZCBUaGVpciBWYWxp
ZCBFcnJvcnNdIGFuZCBzZWN0aW9uIDE1LjQNCj4gW3JlZmVyZW5jZTogRXJyb3JzIGFuZCB0aGUg
T3BlcmF0aW9ucyBUaGF0IFVzZSBUaGVtXS4gVGhlcmVmb3JlLA0KPiB3b3VsZCBpdCBiZSByZWFz
b25hYmxlIHRvIHVwZGF0ZSB0aGUgdGVzdCBjYXNlIExLUFAxYSB0byBhbGxvdyBib3RoDQo+IE5G
UzRFUlJfU1lNTElOSyBhbmQgTkZTNEVSUl9OT1RESVIgYXMgdmFsaWQgZXJyb3IgY29kZXMsIGVu
c3VyaW5nIHRoZQ0KPiB0ZXN0IGNhc2UgcGFzc2VzIGlmIGVpdGhlciBlcnJvciBjb2RlIGlzIHJl
Y2VpdmVkIGZyb20gdGhlIHNlcnZlcj8NCj4gDQo+IFlvdXIgaW5zaWdodCBvbiB0aGlzIG1hdHRl
ciB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLg0KPiANCj4gUmVmZXJlbmNlczoNCj4gMS4g
Z2l0LmxpbnV4LW5mcy5vcmcgR2l0IC0gYmZpZWxkcy9weW5mcy5naXQvY29tbWl0ZGlmZiAtLQ0K
PiBodHRwczovL2dpdC5saW51eC1uZnMub3JnLz9wPWJmaWVsZHMvcHluZnMuZ2l0O2E9Y29tbWl0
ZGlmZjtoPTYwNDRhZmNjOGFiN2RlZWExYmViNzdiZTUzOTU2ZmMzNjcxM2E1YjM7aHA9MTllNGM4
NzhmODUzODg4MWFmMmI2ZTgzNjcyZmI5NGQ3ODVhZWEzMw0KPiAyLiBTZWN0aW9uIDE4LjE0OiBP
cGVyYXRpb24gMTY6IExPT0tVUFAgLSBMb29rdXAgUGFyZW50IERpcmVjdG9yeSAtLQ0KPiBodHRw
czovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODg4MS5odG1sI25hbWUtb3BlcmF0aW9uLTE2
LWxvb2t1cHAtbG9va3VwDQo+IDMuIE9wZXJhdGlvbnMgYW5kIFRoZWlyIFZhbGlkIEVycm9ycyAt
LQ0KPiBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODg4MS5odG1sI25hbWUtb3Bl
cmF0aW9ucy1hbmQtdGhlaXItdmFsaWQNCj4gLQ0KPiA0LiBFcnJvcnMgYW5kIHRoZSBPcGVyYXRp
b25zIFRoYXQgVXNlIFRoZW0gLS0NCj4gaHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3Jm
Yzg4ODEuaHRtbCNuYW1lLWVycm9ycy1hbmQtdGhlLW9wZXJhdGlvbnMtdA0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBTaHViaGFtIEdhaWt3YWQNCj4gDQo+IA0KDQpCb3RoIFJGQzc1MzAgU2VjdGlv
biAxNi4xNC41IGFuZCBSRkM4ODgxIFNlY3Rpb24gMTguMTQuMyBhcmUgYWRhbWFudA0KdGhhdDoN
Cg0KICAgSWYgdGhlIGN1cnJlbnQgZmlsZWhhbmRsZSBpcyBub3QgYSBkaXJlY3Rvcnkgb3IgbmFt
ZWQgYXR0cmlidXRlDQogICBkaXJlY3RvcnksIHRoZSBlcnJvciBORlM0RVJSX05PVERJUiBpcyBy
ZXR1cm5lZC4NCg0KV2hpbGUgdGhhdCBkb2Vzbid0IHNheSBNVVNUIHJldHVybiBORlM0RVJSX05P
VERJUiwgaXQgaXMgcHJldHR5IGNsZWFyDQp0aGF0IGNvbmZvcm1pbmcgc2VydmVycyBuZWVkIHRv
IGhhdmUgYSBnb29kIHJlYXNvbiBmb3Igd2h5IHRoZXkgd291bGQNCnByZWZlciB0byByZXR1cm4g
TkZTNEVSUl9TWU1MSU5LLiBJdCdzIG5vdCBhcyBpZiB0aGUgY2xpZW50IGNhbiBoYW5kbGUNCnRo
aW5ncyBkaWZmZXJlbnRseSBpbiB0aGUgY2FzZSB3aGVyZSBpdCBrbm93cyBpdCBoYXMgYSBzeW1s
aW5rIGFzDQpvcHBvc2VkIHRvIGEgcmVndWxhciBmaWxlLg0KDQpBcyBmb3IgTE9PS1VQLCB0aGVy
ZSBhZ2FpbiwgdGhlIHNwZWMgaXMgY2xlYXIgYnV0IGZhaWxzIHRvIHVzZQ0Kbm9ybWF0aXZlIGxh
bmd1YWdlOg0KUkZDNzUzMCBTZWN0aW9uIDE2LjEzLjUgYW5kIFJGQzg4ODEgU2VjdGlvbiAxOC4x
My40IGJvdGggc3RhdGUgdGhhdA0KDQogICBJZiB0aGUgY3VycmVudCBmaWxlaGFuZGxlIHN1cHBs
aWVkIGlzIG5vdCBhIGRpcmVjdG9yeSBidXQgYSBzeW1ib2xpYw0KICAgbGluaywgdGhlIGVycm9y
IE5GUzRFUlJfU1lNTElOSyBpcyByZXR1cm5lZCBhcyB0aGUgZXJyb3IuICBGb3IgYWxsDQogICBv
dGhlciBub24tZGlyZWN0b3J5IGZpbGUgdHlwZXMsIHRoZSBlcnJvciBORlM0RVJSX05PVERJUiBp
cw0KcmV0dXJuZWQuDQoNCkhlcmUsIHRoZXJlIGlzIGEgdmVyeSBnb29kIHJlYXNvbiB0byB3YW50
IHRvIHJldHVybiBORlM0RVJSX1NZTUxJTksNCnJhdGhlciB0aGFuIE5GUzRFUlJfTk9URElSOiB0
aGUgY2xpZW50IHdpbGwgbmVlZCB0byByZXNvbHZlIHRoZSBzeW1saW5rDQp1c2luZyBSRUFETElO
SyBpbiBvcmRlciB0byByZXNvbHZlIHRoZSBwYXRoIChpLmUuIGl0IGhhbmRsZXMgdGhlDQpORlM0
RVJSX1NZTUxJTksgZXJyb3IgZGlmZmVyZW50bHkgdGhhbiBpdCB3b3VsZCByZXNvbHZlDQpORlM0
RVJSX05PVERJUikuDQpOb3RlIHRoYXQgT1BFTiBoYXMgdGhlIGV4YWN0IHNhbWUgcmVxdWlyZW1l
bnRzIGFzIExPT0tVUCBhbmQgZm9yIHRoZQ0Kc2FtZSByZWFzb24uDQoNCg0KU28gaWRlYWxseSwg
cHluZnMgc2hvdWxkIHJlZmxlY3QgYm90aCB0aGVzZSByZXF1aXJlbWVudHM6DQoNClllcywgaXQg
aXMgdHJ1ZSB0aGF0IE5GUzRFUlJfU1lNTElOSyBpcyBhbiBhbGxvd2VkIGVycm9yIGZvciBMT09L
VVBQLA0KYnV0IGl0IG1ha2VzIG5vIHNlbnNlIHRvIHJldHVybiBpdCwgc28gcHluZnMgc2hvdWxk
IGF0IGxlYXN0IHdhcm4gdGhhdA0KdGhlIHNlcnZlciBpcyBkb2luZyBzb21ldGhpbmcgc3R1cGlk
Lg0KDQpBcyBmb3IgdGhlIHJldHVybiB2YWx1ZSBmcm9tIExPT0tVUCwgaXQgc2hvdWxkIHByb2Jh
Ymx5IGRpc2FsbG93DQphbHRvZ2V0aGVyIHJldHVybmluZyBORlM0RVJSX05PVERJUiBpbiB0aGUg
Y2FzZSB3aGVyZSB0aGUgZmlsZWhhbmRsZQ0KcmVwcmVzZW50cyBhIHN5bWxpbmssIGZvciB0aGUg
YWJvdmUgbWVudGlvbmVkIHZlcnkgZ29vZCByZWFzb24uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

