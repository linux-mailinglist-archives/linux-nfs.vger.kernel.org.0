Return-Path: <linux-nfs+bounces-11008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E34A7CD5E
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 11:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E64188EF71
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789B188CCA;
	Sun,  6 Apr 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Fi3uczSe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA1535D8
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930304; cv=fail; b=GvZYc6oHQww2Af82nf/rSGsdVNz/KMLRoIvLcK0ybfEh1z6HZj19xc7qbtCEVcUH9ds3AqGU9emvNDCI+EBglwoeWIfx+DFbBxxJPCK+1rKM3iN+p+Pg9fT+y3Op7YpnkjCcWwVwwgrveFPQ7mZT8DjG6zknkRamtOva58/07vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930304; c=relaxed/simple;
	bh=d+kFrUZS+jV0sxEQJS7DBToKdN2vwENGQvPkMF+n7MI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlA+xy2ODlBlHgmh6Q7qksxG2ZxdDrVbdqZ5yFb7xPiim2fY43J4mtPLwgmwhViflj23RYsFX7uzagw5LkYNoy/YBVEsEMi/xGs+zaLiZ58PFuA9Xf6YYcgj0kIEaCQ6HoGD88cur0+s4QjcjzXObKjgDsolwC2sMqu9qUrZz/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Fi3uczSe; arc=fail smtp.client-ip=40.107.223.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz9ZOCcKMx/08g2gsu3rMZP6rRKj2JZ0rQ3XlCFEN8ZCQgae7MbPrUyIrpNP7/hPpETlj8zqZkdk/KbV7FsS0INBoL6xYx2PaGEqfDsDF8VxOvK9/XZLUzoHJtI1szjXYNA2a53iIxvmbXZl6IsPUTFE/PHYD1/ol/nXI+815BnxA5mvTQfkRn27xkKLL74VlORYtUoDWMfAPSgJEouWE42AxrLetJCj6ycYXgwxQ2CpnI4N2578k7tt6zPDlT1n/KbZWAB+CttVNjZq2b4S+WDBoNy9QJddS8Eaof/QgKLvY2BOkkXloSxNWhQHohnOT79qQ1YM1oJyBEAs/tTa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+kFrUZS+jV0sxEQJS7DBToKdN2vwENGQvPkMF+n7MI=;
 b=PWOiSjwfFDYp0U9GA1JHAopCHwm/JiccNAra/RfiUcWZg9RKJWnbEWHuhcdpnA0fPBw5RE0sPE8mknbXyWtY0xWth+nFyejhkOHCGaUyTo1TQugB6hsK6UjIc/VreDwRlgkZTbk3LV4ufjlj3X7iWR7IVww040iIoQf0eLaWRncPugnXyz83i6+pKROakeVvec0wql0MD18rVDFMfbRbAQ8Ab8Qi9OMqFqJq0P2iaSvWP+/fq/ZPg2LrjzPI3//j+/FkvojRLYDD3e1T4FV5UwMWAhnaqrq/7AYBYMT6N18y7vmjP/qQPj2UtamGRLnuKns22jnBXZjEVFlVtJHvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+kFrUZS+jV0sxEQJS7DBToKdN2vwENGQvPkMF+n7MI=;
 b=Fi3uczSeaXHEm5EzJoWES5vM6ULuDwzDDjz9Gqxk0byLPzDAyDAeg80F4rA1V99KwrsZuwswrDQNIPoCqgF9ascWX2fpXdyZoDpJBnHL8mqGEL1yemlflUnJ8GEPKyiXrIuePp7L7Xw/byaxQiY8+XsdoDxontzMJ8Qxolc+D+w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB5027.namprd13.prod.outlook.com (2603:10b6:a03:36c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Sun, 6 Apr
 2025 09:04:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8583.045; Sun, 6 Apr 2025
 09:04:56 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "clm@meta.com" <clm@meta.com>
Subject: Re: Leaking plh_return_segs in containerized pNFS client?
Thread-Topic: Leaking plh_return_segs in containerized pNFS client?
Thread-Index: AQHbpZN0ddfk0kRj6Ea0ZBxpTv5JYrOWWsGA
Date: Sun, 6 Apr 2025 09:04:55 +0000
Message-ID: <b53379f848a6c096f53853df6fbb2a3c63e5ef1d.camel@hammerspace.com>
References: <Z_ArpQC_vREh_hEA@telecaster>
In-Reply-To: <Z_ArpQC_vREh_hEA@telecaster>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB5027:EE_
x-ms-office365-filtering-correlation-id: 55f29e43-2f64-4b19-2638-08dd74ea19be
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEVMdmxwQlllSjlwYzB6cnJRRmxDUW9YVXhoWmtRUHlyYnRKaUkrUUFXMjhU?=
 =?utf-8?B?NmU2SGtxTDVuL3EzNHM3MWN1bTFOUXRoTjZsK3Q2TjNKbks4anRRTDBFR3VC?=
 =?utf-8?B?bEVVZk9IYWxHZHBPcDFIT2JMOVh3QU4rRW84Y0JJWGdKTk9SZjBaakxtLzBv?=
 =?utf-8?B?ZDdwM3p4TVdXQ1U3emNxcTJ4MkwvdmpHRVJ4dU5lVXdWMzlUTGVJb0IyMkh3?=
 =?utf-8?B?dWpab3ZIVXRYOElFM3A5dkVBU3JadWcwTG5USG03NmoxRnd0OGxYUDZFMGdl?=
 =?utf-8?B?UGVIT3A0ODBKdUVUck8vYmFCeXFWTGt6RktvWUhKZHpJKzJDYlVPbkpadXVa?=
 =?utf-8?B?WThNMVhHOXVCdEpuNU9wakp2aC94b0F1cWphMXZ6cDZSb1VhNGN5ZnRGZ1kw?=
 =?utf-8?B?S1BDa2RGNDFYaStqc3VLTThSSGFSQWovanFvaXN5RWQ5NkllRDhSTjFlUElv?=
 =?utf-8?B?OThub3JzVy9BM2I1TTU0bjRQNWhkclhWN3lQNlFndUMyVjdqcCtOK015YXIy?=
 =?utf-8?B?KzZoUnVFNEJiUm9wdUY3dXFqMFEvczRGTFBDVTk2WlZTMXdqK2FUaTRkZUdv?=
 =?utf-8?B?Nzl3UUFlN3VlNzI0ajJSYmN1bys5cmxGVUMyRDkyb0xBY0d3c0VVOWhUdEsx?=
 =?utf-8?B?ZnNHek9LU29kOG81SklqV1owZW00V1V0UU5lRlBQeTdMS043aERURTVpS0xa?=
 =?utf-8?B?WUtYSjhTczF3M0hkS2RSckhHTW1qR2ZpNlphNW0rTmppRWVld3NrTjZMZDBH?=
 =?utf-8?B?M3AwYnVVVWR4bVZHQW1NZTJ0aHJtUDlORHNWVE05ZmNjeEFrOTZ6ekk1aVF1?=
 =?utf-8?B?cVV1bHcrL0Q3bDBXY2tna053VVE4d3c4TjJDWkNqYk5kYW1xckVlRStFUGZU?=
 =?utf-8?B?d3lQQnlIZTk0VlBMcm5YcE9QeEhOUWV5Z24yb0dweGxrSzNQUVQvTWpMajZY?=
 =?utf-8?B?dDhLVXFMY2ZaWXlVa0NTL2hja2xIVGRXRldGQ0NKb1RJSG5RSkovY003ZzV1?=
 =?utf-8?B?Y1F5NUR1VjUxaFhBR2NzM0s4VEpXQi9VUTdIdElIWGtheFBhRFFCT2I1ak1V?=
 =?utf-8?B?R0lheEs4a2lQSXJRQXdzcEM2MmFzMTIrZVJNYWVmTUhtZDB6SzNUUG5lL3pz?=
 =?utf-8?B?WHY3Y1FpMWJZL3pYV0NyVWdTV1M1RkdjYytvd3lyeSsxVUNOS1dtTWhRL29x?=
 =?utf-8?B?bWNRMFdDUk5BTHNsdEMxT1EyWGo1RzY2NDZsSDluakJ3N1NSMWh1YzFVdmhi?=
 =?utf-8?B?Y0Q2WVFpd3VXNVVTbkxaZlJZeVlIZnNMUnJzV2VKOG5HMnpKU0FWUzJabTN6?=
 =?utf-8?B?Nys1ajN4NTQ5U1pLODB1L1J1WTJ3RzBqcnJ3Y0t1Qmw1c294WGZHdUljVVR1?=
 =?utf-8?B?VENGM2Rod3pacm9WeWw0MnJhbjkyUjNYYW5vWkNJRzRRVHMwZHV4RjJ0bmtj?=
 =?utf-8?B?NDhBSjJCdjZ1K1dtdklIbTU0MGorcFlOSDRMQ3pyd0VaaEFHQXN1MUlUSmdo?=
 =?utf-8?B?V2dxd1JLMFVMNWRpNnFXd3BKVVoyM1A3QWhWMTF0OVRjVnA3ZWlvRldrVzZw?=
 =?utf-8?B?eER5SC9aNHR0bnJ5VXhKWmVMNllJMHFPWFpaR3FmdEx4Mi9BSFgyd2VDU0U5?=
 =?utf-8?B?a2NoVDFtMFdUTFVJZ21nOUYrWGpnMWkrYWFaS3dZRkVmTERYNHJpY3FORDgy?=
 =?utf-8?B?NDR2U2hUMG9xY25reEJUU1h5alVPT05LK3RyczFab2U3WDFuYytoanlIWlhB?=
 =?utf-8?B?N0hsM2VRL25kcXNvMTAwdndvQ0ZGbzNQSmpobm1XOE12bzdjZnpYQ25TRkFk?=
 =?utf-8?B?RlZocmlNdWFzN0pIOTc2KzR4VkdidDNERDYxZG4wZ214bGpwdldnNHlNL0Iz?=
 =?utf-8?B?NEEyNU0xL0RqWjM3TDVrWFA0a0xDdUFwUHZnTXB5cHo0dG51U21pVnNyL1py?=
 =?utf-8?B?SXYvOHFZRVJYL2sxN0tscFhiaWN2VjZBbUQ5U1V3SjJXb1JTV0VQaW5xcmpG?=
 =?utf-8?B?SzdkcGwzc0FBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDhIb2ppQVorNTgvZEJJb3JsRzV1dTlOS05taTFGUG9DSjJ3d2VWM0ExMi9S?=
 =?utf-8?B?QWUvZ0hsMS9KbnpjS0tOODZtaXp1YTJ5RkdITFJVOTl3Mll5QUpmS3Q1Rjli?=
 =?utf-8?B?aGpaWHpBdjAydHBEdDlWT3hwYk9TZG52T2hQNis2RkIxTGNnQ2FTVG1xSGln?=
 =?utf-8?B?MG1CWDY1QW5rSHFDZm1GUnRVMTBtUjJIeTNtQmw5cndGV2s0bnJncUVxLzRl?=
 =?utf-8?B?SDlMMmNHQ3BvUVZHUVowd05EQWJlaC9ocWRQUk9oVkZKblJLTXZWem4yVVBG?=
 =?utf-8?B?a29oakxJaHFJcUtaczJrN0hORGNCRWV2S21oYmF6RnVwUFltZ29WL2RPWldY?=
 =?utf-8?B?MXBGNGNMQ0NqYklpdmUrN2NuYmZ5SWRHSTQ1RndDWlJTTVhZdnhtM2lQQnJr?=
 =?utf-8?B?ZzAvcExycmI3a29YQ2pYYlMzVFZnb3N0Y2E3NFRIcnU4NkgrT0tncWFuYWVk?=
 =?utf-8?B?ZTJWQUZ5WUIxbmFGbWtVS2NpTDdvREoyZitWRUpzQTN6SXhPMDhxdDh1Sml1?=
 =?utf-8?B?VzFpNzRjbHYrQWJ5WWtJdU85TFVkZlJvWWg3WlZscjQzcm1CeWlCU3FobG56?=
 =?utf-8?B?dWtxMUkzSW5BN2psZ2N4OVZKb1Y0UVhYanhRTWZaQ1drNHZIVmxWZ2todXJw?=
 =?utf-8?B?MEJUL0trK1Y4UHJqNVBXeEgzcHdHOU5mWlpOZU5zbklHMU4raW9ZUFlXV0h6?=
 =?utf-8?B?NmNhSW5iSTN2SXZMWDNFYVJZa25DN29NVHpFaXp2UkgzZDBsT3h4bTZQQVBO?=
 =?utf-8?B?czhMODUzdmh1cnhlNlExN0NCUTlsazBNTGFpVkpkbUxla21iS3c3WGp5MDVO?=
 =?utf-8?B?Nk55dkRTNzNGM1Jha1NyRE5wditveUVaSGRuaWNPZSsyU1hWTk5BNlJOK0xq?=
 =?utf-8?B?bVNPU0tTNERQa09pQVR4clAyY3RWM1lUYXZvV3hFaHhWbzVCYzZZbFZPczN1?=
 =?utf-8?B?UVY3eTA2OXdQT2syT3plNjRoOGVoamdIcXhpcFNiNzIzQW9VcFhsM1RRS243?=
 =?utf-8?B?MDZXU1lsaVVBcURUM2tBSVlKRGFLcFFIdmxieW10Mkllam96dmtYQ3RzRmRI?=
 =?utf-8?B?UnIwbGhLTUZIVWU5Mkt2Z0prdnhyVllPalpDR0FoRkpIVWcxY0RmTmc4dG5C?=
 =?utf-8?B?ZnhlL3ZncHRRaE9mdXY0bnVRU0FoOWxGL2lRZXhoS2RBZy9UeVNzSEQ4cXRq?=
 =?utf-8?B?MG9xcjEwQ2JrYk8zWUsyUDcvVHY1KzhLQUVBek9oNjdLSDFqYUprNmc2aTN3?=
 =?utf-8?B?aVFCTGNtcHZSdlBEMy9Oc3R3RGxwUTY5OG5ZS2hzQ2NVSGxMaytxNkUzRjVs?=
 =?utf-8?B?S3FnV2hsTFhMcHlWVUROM2hRUUNnTGpVRnlxa01iRm5ydWgrMktwbXFnRy9E?=
 =?utf-8?B?NllSR3k5YjY4eUxMWXBUVnR0czFJTGFhdmVEMlBWWDgrd1FzUTVaV01rZ2Yr?=
 =?utf-8?B?aDFiS0FJT0kveTdDQURmNWxVWWI2d3hCWTZNaWRuQzhFYm9qZUpaMlRLYnpD?=
 =?utf-8?B?WEdKc25Kc1ZqV2RtNElXWHEveG5lYktyRkdHNURkMm5NWTAvTXZMc2JnK21W?=
 =?utf-8?B?YXpCNFJaazZDeDltSm02TENadEZKQklVcTB0aFB2MXNHRGRvQWtScXpqVUwy?=
 =?utf-8?B?NXBMTW5sRUUxdVp2ckxzZVZUcnBZTmtWbm00MU5GaS8ydjg2V1M4UGttTk5G?=
 =?utf-8?B?S1pkbXg4Mk9nQWpkUXhPY3BYM0lNd3o2aUtwTzFOLzc2RlYyYUJ5bHI2MFdV?=
 =?utf-8?B?QVIxYXhKZ1kyTTJndUxDcXJ1cndhVDF1WG95SHNGdndpMWpZWEpLZUZwUFpM?=
 =?utf-8?B?ckliT0d0Qi9xZG0zK3dqQU56NzI4dUVGeWZJWFZ5bEhlQThzejlkc0tpV3dv?=
 =?utf-8?B?TTNpaHFqU0FzbFc5M29DcnZmKzVIb0JpZFZjK3ZDbWdNL0VUMzZyc01IQmov?=
 =?utf-8?B?S3R2RTNaYVZYSlpBL2xLdThtN1RrQTczbWZOU3pMdE1vV1JlUDN5VkFLM2JX?=
 =?utf-8?B?ZEJyREV4VmlJZ2ZaKzVPSmZWSHlzNlc2R2t2TGxodTVJTEZkTi9SY1JXTFFY?=
 =?utf-8?B?bUllZXYxeldQVmU4QVhMZ09VMC93WlYxZHFUekZpZHZjZ2t5ZTBUbStnNWF3?=
 =?utf-8?B?K05LMFRMaThBSG14ZDRjVnd1NUVvM2UyYk1LWnRuQy9ZUDVzSzRURDU2OTFC?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE456B915739F647BD7A043E186D38FF@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f29e43-2f64-4b19-2638-08dd74ea19be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2025 09:04:55.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUDgOlC+1kpeiUw/n5X+jn3G4u0LxkdtM0/DG343TBxeM+B2XswLs/bQ5GjO25Dl5NulOOudIIUX6dYlC15Ovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5027

SGkgT21hciwKCk9uIEZyaSwgMjAyNS0wNC0wNCBhdCAxMTo1NyAtMDcwMCwgT21hciBTYW5kb3Zh
bCB3cm90ZToKPiBIaSwgVHJvbmQsCj4gCj4gSSdtIGludmVzdGlnYXRpbmcgYW4gaXNzdWUgb24g
b3VyIHN5c3RlbXMgdGhhdCBhcmUgcnVubmluZyB5b3VyCj4gbGF0ZXN0Cj4gY29udGFpbmVyaXpl
ZCBORlMgY2xpZW50IHRlYXJkb3duIHBhdGNoZXMgd2hpbGUgSmVmZiBpcyBvdXQuIFdlJ3JlCj4g
bm90Cj4gc2VlaW5nIHRoZSBORlMgY2xpZW50IGdldCBzdHVjayBhbnltb3JlLCBidXQgSSdtIGRl
YnVnZ2luZyB3aGF0Cj4gYXBwZWFycwo+IHRvIGJlIGEgcmVmZXJlbmNlIGxlYWsuCj4gCj4gSmVm
ZiBub3RpY2VkIHRoYXQgdGhlcmUgYXJlIHNvbWUgbGluZ2VyaW5nIG5ldHdvcmsgbmFtZXNwYWNl
cyBub3QgaW4KPiB1c2UKPiBieSBhbnkgcHJvY2Vzc2VzIGFmdGVyIHRoZSBjb250YWluZXIgc2h1
dGRvd24uIEkgY2hhc2VkIHRoZXNlCj4gcmVmZXJlbmNlcwo+IHRocm91Z2g6Cj4gCj4gwqDCoCBu
ZXQgLT4gbmZzX2NsaWVudCAtPiBuZnM0X3BuZnNfZHMgLT4gbmZzNF9mZl9sYXlvdXRfZHMgLT4K
PiDCoMKgIG5mczRfZmZfbGF5b3V0X21pcnJvciAtPiBuZnM0X2ZmX2xheW91dF9zZWdtZW50Cj4g
Cj4gV2hhdCBJJ20gc2VlaW5nIGlzOgo+IAo+ICogVGhlIG5mczRfZmZfbGF5b3V0X3NlZ21lbnQv
cG5mc19sYXlvdXRfc2VnbWVudCBoYXMgYSBwbHNfcmVmY291bnQKPiBvZgo+IMKgIDAsIGJ1dCBo
YXNuJ3QgYmVlbiBmcmVlZC4KPiAqIEl0cyBwbHNfbGF5b3V0IGhhcyBhbHJlYWR5IGJlZW4gZnJl
ZWQsIGFuZCB0aGUgbmZzX2lub2RlCj4gwqAgYW5kIG5mc19zZXJ2ZXIgYXJlIGFsc28gbG9uZyBn
b25lLgo+ICogVGhlIHNlZ21lbnQgd2FzIG9uIHBsc19sYXlvdXRfaGRyLT5wbGhfcmV0dXJuX3Nl
Z3MuCj4gCj4gwqDCoMKgID4+PiBsc2VnCj4gwqDCoMKgICooc3RydWN0IHBuZnNfbGF5b3V0X3Nl
Z21lbnQgKikweGZmZmY4ODgxMzE0N2NhMDAgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAu
cGxzX2xpc3QgPSAoc3RydWN0IGxpc3RfaGVhZCl7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLm5leHQgPSAoc3RydWN0IGxpc3RfaGVhZCAqKTB4ZmZmZjg4ODVkNDll
MGYzOCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucHJldiA9IChz
dHJ1Y3QgbGlzdF9oZWFkICopMHhmZmZmODg4ZGVlOTE5ZjgwLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5wbHNfbGNfbGlzdCA9IChzdHJ1Y3Qg
bGlzdF9oZWFkKXsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAubmV4
dCA9IChzdHJ1Y3QgbGlzdF9oZWFkICopMHhmZmZmODg4MTMxNDdjYTEwLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5wcmV2ID0gKHN0cnVjdCBsaXN0X2hlYWQgKikw
eGZmZmY4ODgxMzE0N2NhMTAsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9LAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLnBsc19jb21taXRzID0gKHN0cnVjdCBsaXN0X2hlYWQpewo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uZXh0ID0gKHN0cnVjdCBsaXN0X2hl
YWQgKikweGZmZmY4ODgxMzE0N2NhMjAsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLnByZXYgPSAoc3RydWN0IGxpc3RfaGVhZCAqKTB4ZmZmZjg4ODEzMTQ3Y2EyMCwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucGxz
X3JhbmdlID0gKHN0cnVjdCBwbmZzX2xheW91dF9yYW5nZSl7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLmlvbW9kZSA9ICh1MzIpMSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAub2Zmc2V0ID0gKHU2NCkwLAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5sZW5ndGggPSAodTY0KTE4NDQ2NzQ0MDczNzA5NTUx
NjE1LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC5wbHNfcmVmY291bnQgPSAocmVmY291bnRfdCl7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLnJlZnMgPSAoYXRvbWljX3Qpewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuY291bnRlciA9IChpbnQpMCwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9LAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5wbHNfc2VxID0gKHUzMikyLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnBsc19mbGFncyA9ICh1bnNpZ25lZCBsb25nKTEwLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnBsc19sYXlvdXQgPSAoc3RydWN0IHBuZnNfbGF5b3V0
X2hkcgo+ICopMHhmZmZmODg4NWQ0OWUwZjAwLAo+IMKgwqDCoCB9Cj4gwqDCoMKgID4+PiBkZWNv
ZGVfZW51bV90eXBlX2ZsYWdzKGxzZWcucGxzX2ZsYWdzLAo+IHByb2dbIk5GU19MU0VHX1ZBTElE
Il0udHlwZV8pCj4gwqDCoMKgICdORlNfTFNFR19ST0N8TkZTX0xTRUdfTEFZT1VUUkVUVVJOJwo+
IMKgwqDCoCA+Pj4gbHNlZy5wbHNfbGlzdC5uZXh0ID09Cj4gbHNlZy5wbHNfbGF5b3V0LnBsaF9y
ZXR1cm5fc2Vncy5hZGRyZXNzX29mXygpCj4gwqDCoMKgIFRydWUKPiAKPiBTbyBteSBndWVzcyBp
cyB0aGF0IHRoZXJlIHdlcmUgc3RpbGwgc2VnbWVudHMgb24gcGxoX3JldHVybl9zZWdzIHdoZW4K
PiB0aGUgcG5mc19sYXlvdXRfaGRyIHdhcyBmcmVlZC4gSSB3YXNuJ3QgYWJsZSB0byBtYWtlIHNl
bnNlIG9mIGhvdyB0aGUKPiBsaWZldGltZSBvZiB0aGF0IGxpc3QgaXMgc3VwcG9zZWQgdG8gd29y
ay4gTXkgbmV4dCBzdGVwIGlzIHRvIHRlc3QKPiB3aXRoCj4gV0FSTl9PTkNFKCFsaXN0X2VtcHR5
KCZsby0+cGxoX3JldHVybl9zZWdzKSkgaW4gdGhlIGZyZWUgcGF0aCBvZgo+IHBuZnNfcHV0X2xh
eW91dF9oZHIoKS4gSW4gdGhlIG1lYW50aW1lLCBkbyB5b3UgaGF2ZSBhbnkgaWRlYXM/CgpJIHN1
c3BlY3QgdGhlc2UgbWlnaHQganVzdCBiZSBsYXlvdXQgc2VnbWVudHMgdGhhdCB3ZXJlIHF1ZXVl
ZCBmb3IKcmV0dXJuLCBidXQgYXJlIHVuYWJsZSB0byBiZSBzZW50LiBJdCBsb29rcyB0byBtZSBh
cyBpZiB0aGUKbGF5b3V0cmV0dXJuIG9uIGNsb3NlIGNvZGUgbWlnaHQgYmUgdG8gYmxhbWUuCgpJ
J2xsIHNlbmQgb3V0IGEgcGF0Y2ggc2VyaWVzIHdpdGggYSBmaXguCgo+IAo+IFRoYW5rcywKPiBP
bWFyCj4gCj4gUC5TLiBJIHNwb3R0ZWQgYSBzZXBhcmF0ZSBpc3N1ZSB0aGF0IG5mczRfZGF0YV9z
ZXJ2ZXJfY2FjaGUgaXMgb25seQo+IGtleWVkIG9uIHRoZSBzb2NrZXQgYWRkcmVzcywgbm90IHRh
a2luZyB0aGUgbmV0d29yayBuYW1lc3BhY2UgaW50bwo+IGFjY291bnQsIHdoaWNoIGNhbiByZXN1
bHQgaW4gY29ubmVjdGlvbnMgYmVpbmcgc2hhcmVkIGJldHdlZW4KPiBjb250YWluZXJzLiBUaGlz
IGxlYWsgaGFzIGEga25vY2stb24gZWZmZWN0IG9mIHBpbm5pbmcgZGVhZCBEUwo+IGNvbm5lY3Rp
b25zIGluIHRoZSBjYWNoZSwgd2hpY2ggb3RoZXIgY29udGFpbmVycyBtYXkgdHJ5IHRvIHJldXNl
Lgo+IE1heWJlCj4gdGhlIGNhY2hlIHNob3VsZCBiZSBzcGxpdCB1cCBieSBuZXRucz8KCkFncmVl
ZCwgYW5kIHRoYW5rcyBmb3Igc3BvdHRpbmcgdGhpcyEKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tCgoK

