Return-Path: <linux-nfs+bounces-8171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 873E89D451C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 01:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED867B2181E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C62309B3;
	Thu, 21 Nov 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VprnhV7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC22F3B;
	Thu, 21 Nov 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732149729; cv=fail; b=RExmLEJ6r1v9ssDTR2A5VRoFGcG9YctgNoqDsZsqFIo+E841rHgsFueBZFa4lkmNKTPvcXKjoZjQowEpnZymWKfbfdaMUGlulTynS7By4z453y91D0IpWvTb3HIm7Ocmt2I9YChsQw2+PFC12eGF2hGpHxQP1qzRJaPQneRPlP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732149729; c=relaxed/simple;
	bh=k64Nv6BXeS1u8D1h8oPLCfLY6/eLHV5JwVYHoNr/HBc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FFuzNd3Nrt006PyTlaTHOmBbitFp5w3HBOy5Os9oIbH68Ns500syu2IHdSk2B7V3bRipX1IMtrhGq2OXeU/BbiS42wHNZS8pHt9YPBxdnuXnYHSbpAXasEgaAc6fXcsNpauMv3M/rJxLA06jmyZ+3ace0xDxwGDxOVe5KRjtzbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VprnhV7l; arc=fail smtp.client-ip=40.107.237.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkEoqBfRYAFCVAaAhhCKfJskb+SHviAYzTZby2Trhpz1wupAQM6AtD/1SApdOgMKDPYqLDP5I6LwW8K0OM5MWioyCGktHaSUO2W3LnbekW9J9MjuwaAJ394nTuk1TuUI8Bnf3H4/UvfML+xCzAggZ+wNSKQngit01A4m81YInjFqU6aXwN5uphrKgMkpcu0prPcWJ/vBJd/UJcLG6BCq4vcMVCIvKCqi+jTmhPrikT4VZuGGyuBqcPFZlMl2hwDs9as2eER+D0/Wksu1+O4b//nxQ/5MX/a6m6RUAwKdmYyhon4O3x565efDjkg5h6UHSCONsp5UUSjwyeqVztnpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k64Nv6BXeS1u8D1h8oPLCfLY6/eLHV5JwVYHoNr/HBc=;
 b=mGC/NEa2Jb8U02fa9iNsp7CALYUn9QfjfxCNkgmedrn9kg9JW/2FXuZyMEQcxuDFxiszZ6KyjSnQ9Tb/sMjA4i7OHxG9eqgD41b/Iq/JM55F5TewL3cSmLDOuPKk0/J6XtnfQlrPU0BwrofEwW3RrP9VAfKOrI/bBNtMPLtL4jXNYzc1FOGZIcD3LWctLgn1itGfysUwUbCjB5YSZmWxJh8ROG+ZAZGgpKi525H/Yr6qUyPafPQDb80kKJxHOMiOKUoKvyWEUenbbig6zsT++4eUVgP9zIvkb/OJswLql3QdQCIrTEFLMDgnkt78AM/kXdesDsNFrF/UZV1+nPmqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k64Nv6BXeS1u8D1h8oPLCfLY6/eLHV5JwVYHoNr/HBc=;
 b=VprnhV7loBznQbi0XlHRs92ThXcodi5PGq9QuiHY/j8WcQyn1v5SHo+Ds+l0AMU3xCv2RgPZyZbgDz05wIDj5CUHgPcjVsYqiFy5AZUcmR5bGQMo9V8XtIMEWuOKmw4IyT7g7TcnDDV/SHq3nqyxH2HWg+f70jnavQpaSjyHrd0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB6049.namprd13.prod.outlook.com (2603:10b6:a03:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 00:42:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 00:42:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Commit b1a28f2eb9ea ("NFS: nfs_async_write_reschedule_io must not
 recurse into the writeback code")
Thread-Topic: Commit b1a28f2eb9ea ("NFS: nfs_async_write_reschedule_io must
 not recurse into the writeback code")
Thread-Index: AQHbO64uUPUA+8/ieU6jH0W6Zzgj/A==
Date: Thu, 21 Nov 2024 00:42:02 +0000
Message-ID: <d561b5f86b69970e9029697124a9581e075e2d0b.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB6049:EE_
x-ms-office365-filtering-correlation-id: 12d332bf-907f-4b55-8daf-08dd09c550e1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEZKY0xnOWxtbFY2bWxCSlhFdnlSWHdCSHZRN1Z2R1I2WXpZeFRRQmNTeDhU?=
 =?utf-8?B?M1BNRHhTT3BrbHEzK0JXK1R3V2h3OVVYd2JaMElPT1oyQUI4MXVPSXFkQkFv?=
 =?utf-8?B?Ylc4K3dCNTk5ZkFWcHNWcXVpRUh6d2ZVcDZmUm9JMUo0WjFvV0N1TTF4OXA0?=
 =?utf-8?B?NXB6M3g5VDN3dEpFZjViQ09WSy9acXd4V0xaNjVpcUlIWTQ1dStLY3EzdGhK?=
 =?utf-8?B?L2srSktaTzVPeXRvcEZnWUJRTUxPZmNCeGFBYXl1L29iZ0dyTDNta3NHRUhh?=
 =?utf-8?B?c3g1N0dhLzlHUkJQRGNKUkRVVlVLbHRBaHlONVNOM0RpWHo2MHV3Q2t3eDNV?=
 =?utf-8?B?ckFVK3ZrMjV4ZE5UajZsbmZZSHJvbW1YZzBTVENFdHgybloyL3BhQnF0SkFC?=
 =?utf-8?B?bnY4cUhxMlVHWDFZcXJQTzVvMUp0LzhBeGVpRExoQUh5VVpXcGczenJhNTRh?=
 =?utf-8?B?cUtDMlVKYWxWcGZKWUVZelB5VXVNMnRNYm9WeFozREVTNDNMWlBBcGlVNHFv?=
 =?utf-8?B?ZStGcFdvVjhXSmJwM2R6blpqUWRxWDZldkpLQzRZSTBWc0w4Szc3TkMzUWpJ?=
 =?utf-8?B?YzJkWmNtWkRuU1dQNllROEhyT0NjKzFERzdZYS9kMWlqaHJxYlVjczNhcld6?=
 =?utf-8?B?b1NOYUVpV0p3eCtyd2F2NTZwdXIrdlZJaG9laE91Y1Y5b3p6V2xURmU1QWcv?=
 =?utf-8?B?blk2M1dZdVQ3b09ZcmsyNm0vOXZzU0FvM3lYNXQyVDFpT0xRSFh2OExOeVY1?=
 =?utf-8?B?YjRtT1dvVzh6bTc0U3R0b1l4VytndHF4T2d1QnZyZ2U3eTJZaFpUNWJaYzhZ?=
 =?utf-8?B?Y3A0VGg4MFJTQmxGRmRyczdFSGgrYnRxSDh1WWliOGh1SkhucExOVHNLNHl2?=
 =?utf-8?B?elBlVU1WcllMVDNlTXZaZ0V4YlBOdDdIVTRFRkxRRGhNd3FtWlZCU0p4ZWR5?=
 =?utf-8?B?Vm5BWTVLZ0dxZXl5b0dtcmZMMUVMcWdoMEdrMEtMY2hUelN0MDhQZ2h6OE9n?=
 =?utf-8?B?ZW40L1V6OTB3ZVpEcHVXZlliTHByaVpDcEpXMUFoT1ovSjZNM0JTQlo2U09y?=
 =?utf-8?B?QlJTS3hXYklPL1o2VDNuQjgra0JLckZiV093cXQrWDk2MTVIenlYSkRJaVV0?=
 =?utf-8?B?aWpZdFpsbGtKQThKQjhnclI0U3FESTBaa2YzSWlLd2N5cUExdC9pZEJjTkhl?=
 =?utf-8?B?Rkh2QlhJSGRrOW44bjRvSVBIdUh6dG9ER05QNm5lSzV4eFh2NTFObmxQUHlm?=
 =?utf-8?B?OFdlTzdyYnlrMXVVbG0ybWFvRXRlaS8xZGVDbXVwajVNK2p0bnRvWHU0ajF6?=
 =?utf-8?B?WmVmMXo0L0pqbnhvMisrUGpKMVpQUTdwbXlON3FsbFpCeTdtL2NsUWtMSzRR?=
 =?utf-8?B?SXkyYWljWGcxWThld0VLTFAzb2twc1pCY2sweWFOdUUyZEdOUkZPbzlFM1Uz?=
 =?utf-8?B?dlBOQUFjTm4ybm1TR2dYSGFBV2dTaWsxcHVHcTRMQmNPVjRwUnluRyswQWpa?=
 =?utf-8?B?OGhYbDczSGJMdTVqTmdILzNzZUQ2SVE0ZmsvL1R2RkpDc21LaFF6WHVoSFN6?=
 =?utf-8?B?MUhISTloMzYyeFJ2RnV2dGJ4R0tBNllwUVFlVTczdUkxS3E5TTlNcVFSTzBO?=
 =?utf-8?B?SEhUdHB3SkJlamt3TDFGdUsxR2c2a2QvMkdmaFA5TTQzNjVtN1lvcnMwdm5X?=
 =?utf-8?B?akx1OHFpL1NPV3VmbVJsV2g0VkpMMWxMelNSbDJNVmVQY0tiZEIvTVE0TGF3?=
 =?utf-8?B?akJ3UVhzWmFodEN1cHo2ZFRUUGJyS2lnU0tQT3N6dWFYTUJFWHUxUnV2dXNw?=
 =?utf-8?Q?Ao43KB0xfEJ+Y94xm/H5hcu9RT1nQe9oxIfr4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d29ORzRkbm5Ha3ljQ0NOdDFEYzcvNmx0a3ZDZE0rUFFQL01TZGdGWmIyNFow?=
 =?utf-8?B?M0JBa2JEWnVMaVBSczdDcmx6UmhrZEhMYTNxWGJCaVUveGNwZGNuZ21VSXow?=
 =?utf-8?B?ci9WWlUrVVdndUVuZjlIbGZZVnBKZWd6NWdGTjdBTXNjWHMvQUdyT2NXMTFz?=
 =?utf-8?B?MHYwQ2t2czB1ZXJHTTJSMklMcTdKRnA0dlQwbmc2b3FvMWVxWEh1ZHdRNXI3?=
 =?utf-8?B?Qm1IanV0VTBFOWh3ZS9jTkUwaFVaVHdGYVVIYkllRzlOR3FMWHNFR3NEOTVC?=
 =?utf-8?B?VGdFQ3lYVms3V2xkQVNRZS82Ri94WGlaeEcrNlppVU9IanUvUUJHeS9WMzdH?=
 =?utf-8?B?UWRPcXhCZjZLWXJkbWh6ajJtRENhb0pMWWkxKzJmL2VyM0RWTDBpaWx3KzdQ?=
 =?utf-8?B?bmRFRWQyUHloemxSMmsxM1BtckhrNGgvRmlKSHd4aEJJZURNK05iWlVoQkNU?=
 =?utf-8?B?YnJPNVhWSEltTXh2VEdwNmJ0MkVGd3pINC9KUFM5M012QitrZGNMSlhob3V4?=
 =?utf-8?B?cWMyU3pZakJlUU5YWm01bE5KTkdnYVJvSzJHNkgrS1hIS3F1VERzaGMvQ1c1?=
 =?utf-8?B?V1JGSlhNdHFGdzB6WlE1bjNnVExHWnc2dmdtTC92Y3E2ZXNRbERsWlZhSndv?=
 =?utf-8?B?RFBubjdwbUgwWXNRK2o3QWQ5L3NnRUs0VzQwYUU5U2hXSDdWbU9FVlpnd2VW?=
 =?utf-8?B?ellMMm13U3RQVHJSRXpLdkR3S2xxMXl6YjNRRXJzUlhLWTdRSlZlbkQ4WlBn?=
 =?utf-8?B?TVoxbkdGSlN1dWNmSy9xWGVPUDczclo4V3UzYVA1WDBQN1VJSjdLRFhuRmNS?=
 =?utf-8?B?aEtjREhOWDlYbHVPQXJ4WFVKWm1jdDcwbVFkUTFldFFpR2FpRHgySjRleS8y?=
 =?utf-8?B?TUoyR2Y4S05PUURIWW9xYUlFbmtzdlQ1R041L0lDaGYyTGQ5TzZTbUljVzht?=
 =?utf-8?B?Y3o2SzE5ZnRCRHhiWkpUSE0yby95VEoveXRTZWNJL1I3RnZXVkE0eWsySWJR?=
 =?utf-8?B?emZtdGhSZmswdVJIZEIxaGlJckR6VTVKSkVnRzJ3YzRHZEFYN2NEcmtXU1Jl?=
 =?utf-8?B?OGU5b3Q4eGUwUnkvbDdkNGFIY2t0c1dGblJrZ2t2czl2ZWFTa0tBcURzYXNP?=
 =?utf-8?B?T1RGZEZxRUV4Y1BZVytsQW90ckhTbklWNk9lNFdQRmU3YVdWSTN0ZGtTVWJC?=
 =?utf-8?B?MUh1c1M4WUFyNkRTV2QvckNxNENWTmQxTTdRbnhFUUVzK3R1MEFFQnRzK285?=
 =?utf-8?B?OXp2UDhKNXRwZEc2d3FUd2NFTTZPRWtjZmlTT0x3c0tFM0dtVG40M2lybXQ1?=
 =?utf-8?B?cVBDQy9pZmVuSTlXdE1td0Z0ZFM2SDVHck1tQkd0T2NaMFVlZDdhWkRXY3lh?=
 =?utf-8?B?Ym1VcUd5S3RVb2hCRCtCTExSS2k3NDR3S3ZnUzY5MFltQm9XdEVaVGlNM0ti?=
 =?utf-8?B?VzlDT1NWUHpmYUNldWI5aVh4cFB4WGNQb3ppc3FmNXVYTmd5aGl4bmJ1d29N?=
 =?utf-8?B?Q3Z4ZnUxQUFpSUtLTEp2WGVEcElyTmlzTzg2dDJWalF1aFlXMlNmY0E0Vnp2?=
 =?utf-8?B?eUI5bzM4NWVLSGxYT2xJTWJRbHgrZUw0d0ZGN256TE1wV2JUek80K3A4dmts?=
 =?utf-8?B?T2pxeDdFWDlqMkpHckpOTDRBYnFnZUxZY3UxRlkvb3UrMUdYdmxIWi91ZVRD?=
 =?utf-8?B?eWI2NHR4WXNsbzlJMkZtNzZhNU5IMzZUWWhTQnczMWJuNm1tQktsWW5Na1Fv?=
 =?utf-8?B?TVR3TTZKblFxeDQ5UTVNZXNUdURDRDQ2TFphNDdzVkRDS2x3bkNpSkVOVUpw?=
 =?utf-8?B?eE1aa3l4TVdnYmZ4aTBpa25SejBuMzlHcWJHbW1vSVVObUppS3p4T1BZeWtY?=
 =?utf-8?B?Zi9hYVZTMlhZdUlKMVZPaDF2K3dkR2JGMkV0azBBcGNNOFdmdnQzRTNCR0Fs?=
 =?utf-8?B?ZUxHc1dhaTgyaGFqSDNVNVZjZjd6cFpaWmpVSW9pbEpBYzN1OTdxaTdlZUtS?=
 =?utf-8?B?cno3UHJuRXJsVTR1dFE4WUpsQzN1eXU0NTZyNlFIbzRLUm1neXFMYjV6ZjFG?=
 =?utf-8?B?UWJrZjlZUjhQekk5SkdEeGhNSDZxV1JhZ2o3T1AveFJnRTdsRXNCOVpWMzZJ?=
 =?utf-8?B?bXpZa01SNUQ2STlMRE85V2kveHhabFZYSkVBcU1xYUh2NU5Eb0lzbDNzSUJj?=
 =?utf-8?B?b2ptbmlsYW82STRBYXpxczJCZXExME00TmxQMFZJSG1kMW0wdUtHVUtlTjVW?=
 =?utf-8?B?dC85MDRUUmVURFRyMFdyVDNXTm13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F6F1C024C767248892257A05B15A362@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d332bf-907f-4b55-8daf-08dd09c550e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 00:42:02.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UafZS9h3TGMlNwRfHnkkTKX31vu0+fpmchVMEPTkyfDRiBZmmGgLoGlLU5AA1zMBUkl9MBmYPvkREe50xGbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6049

SGksDQoNCkNhbiB3ZSBwbGVhc2UgcHVzaCBjb21taXQgYjFhMjhmMmViOWVhICgiTkZTOg0KbmZz
X2FzeW5jX3dyaXRlX3Jlc2NoZWR1bGVfaW8gbXVzdCBub3QgcmVjdXJzZSBpbnRvIHRoZSB3cml0
ZWJhY2sNCmNvZGUiKSBpbnRvIHN0YWJsZSBrZXJuZWwgNS4xNS54Pw0KDQpUaGUgYnVnIGFkZHJl
c3NlZCBieSB0aGlzIHBhdGNoIGlzIGJlaW5nIHNlZW4gdG8gY2F1c2UgbG9ja3VwcyBvbiBzb21l
DQpwcm9kdWN0aW9uIHN5c3RlbXMgcnVubmluZyBrZXJuZWxzIGJhc2VkIG9uIExpbnV4IDUuMTUu
MTY3Lg0KDQpUaGFua3MhDQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

