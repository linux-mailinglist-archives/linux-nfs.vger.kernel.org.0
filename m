Return-Path: <linux-nfs+bounces-10370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286AA467F8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096FC188811A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CD18BC3F;
	Wed, 26 Feb 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZETbUyHj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2116.outbound.protection.outlook.com [40.107.100.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EEA18859B
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590528; cv=fail; b=tjdK0yID30qSC47sKXm9e6nJSgQ6TA7s9I/gc54+63lEtEaRGXY+rTpuO4T+vKiCVOb2+pUkLqDSDTRpP0KQW9EP5kgCrv2mB0ZbWVLWPslbJ5z+KrezviQMWcv/5p7TpAQ1FuCEFxzik/KeRWQaAG2CvuNQEwZbw3Z0zftEvDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590528; c=relaxed/simple;
	bh=DIznW9Z4wsfgamekfRNRDvlmYvt4XQ+EgzULmiCZ6XU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QaUSCVYcN53g7A8vOc1HAO5IB+aWuiTyNISoIPzKIH6afgvJlIJ2yA5ROoT6uBnIOjeGtrIDyotQynMQtZJGWnq98oTscKywrN6juUBjEYEm21X4ZoaO6HiAHRfKmygUydez2TZpIdvEGcU1Sj38IkdMRa+C5W6tQDotWG88ndI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZETbUyHj; arc=fail smtp.client-ip=40.107.100.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icTcInw//NDawKjNRFAhUZWx7C7m/8t7VDFy+yKvvtOPWU8zKQbLvh1TB14oC7RBDqpsLz6QQ2998i7GPn+gNejK2Kr43zlBUQXfI5WGsp6sCCXhcEhw2ryEar509Hd50nc/Th+dGyPOnzJplRdLJZoP6LdyKZKz70uryv3n5V2N3apl9KjyPxALqw986VR5RfZnYyZHs4esF7xfvPYDR2qzyOlll/3+MBFVrKTvb5FMm5KSDTPLBClt50PQJ2Px8HlrwjsfIikm5xpPWnder8ASD5UJms7uH83t5/Vmw3CE726Fd9gRYQibs59tCndYOxvpnol1l2VV43+6RTey7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIznW9Z4wsfgamekfRNRDvlmYvt4XQ+EgzULmiCZ6XU=;
 b=afZTVR0Xa7aCXQhMbDy5bf98hTrHfYHWRqyZF6ZIfwjnPOkFvQwJ37hkcQt8bq4VQyMlnsFw2BryDBibeTBWJ7m6FaNablzvvBCcmvJLPY6pknfemb+u0ND3VEIDJT7sSlyeCW+rBcR7F+s9gsiMQ4gAZqGcklyqTJQQWCIYYIsfahCWp0dRc4SzrAFSfHCNvqgJLNNrOF3ygBSXSTkQoioLo7b9ogXocM/ZRev4n2BR/2Q4E/abBnQiXmNim6f95bMW0NeEs6GYlctVUaf/O6Ei/fG/EJ7wouGg9ZNnKyP9zdcBhHsBD0p64L+aTPtH/l5y4wx9r9msrGN6UZOa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIznW9Z4wsfgamekfRNRDvlmYvt4XQ+EgzULmiCZ6XU=;
 b=ZETbUyHjRt87X8mcsQ9vRQ4BShmvEQrR/BB6Fjwi7D46bCCn+V1zoX4oPvOfLaKz0oRSpc1rH2Bx4VjumF4kIXYzyljygU8huWn/prDrhbi0hGwXQ28VCIBxbEbmI45RVsxaR5vZ0LnVxA2IJnV4s/ZYwx/mk19Nmv/DNOeXHJ8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4072.namprd13.prod.outlook.com (2603:10b6:208:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 17:22:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:22:01 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "snitzer@kernel.org" <snitzer@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "anna.schumaker@oracle.com"
	<anna.schumaker@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to not
 call nfs_wb_folio() from kcompactd
Thread-Topic: [PATCH for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to
 not call nfs_wb_folio() from kcompactd
Thread-Index: AQHbhxzXIHk6+KEBS0ucji9owF2xnLNZr3uAgAAoLgA=
Date: Wed, 26 Feb 2025 17:22:01 +0000
Message-ID: <cdfa33c2dd7d4803382b5e03df32b09f8524c6fe.camel@hammerspace.com>
References: <20250225003301.25693-1-snitzer@kernel.org>
	 <Z78sA-7_u5SyuFSw@infradead.org>
In-Reply-To: <Z78sA-7_u5SyuFSw@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB4072:EE_
x-ms-office365-filtering-correlation-id: 66b9739d-9929-43aa-4f15-08dd568a1546
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OG1MNzRCSW1rUHY1YUhBTnVZa2JwMythSnJXNWpucUpCb1JGcTdnZjNuRXFY?=
 =?utf-8?B?dEFEWDZhQkxVdTR2SnNTRUR1WWcrOUVkNXVtanZzcWdKcE94bUI2eGFDUlIx?=
 =?utf-8?B?aUVCUyt2YXlldHRiWVZCSHBCNzlWN3Q0MWRRL084UEc1U2tDNHhpcnVWczdF?=
 =?utf-8?B?VmtYSkNldWRmRG5LbTlEeGNTUXBwQlNXc1hMU0xLOGlleWY4ZkE3ajBmZytt?=
 =?utf-8?B?WnFKVUNaMjJmeWUxT2NFUnJRbHNSbDllWnRnSUZ1QWZqaHA1OWNxcWg1cUdh?=
 =?utf-8?B?QzZxWFdiNWFLZ1l2ajNRWmpROVBjY3l4NHFaK1l1R3JvS0p3NTM2TGxGQ0g4?=
 =?utf-8?B?VWFSbFZwQ0tXOHRLQlE3N1VKT2RIU0tGVnNJaDdjS0xLcThBQnlxYkJ0ZlRT?=
 =?utf-8?B?UzVsL2U5d3g2M2hPeU43Yzl6S1Y5L3JIOEFPNW93OTZieDZLRTVDRW11UUxw?=
 =?utf-8?B?S2ROYUZpbk9Ba2dCYmlVWEZiNHdjN1FWelY5MGt5aDdBU0lSblhOMFV2NzNv?=
 =?utf-8?B?dC9UVlUyLzg5QlJ2MFNFTkovbEloUHFZbUl5YmV3Tm0veEF2eVRqTFdXR2ZF?=
 =?utf-8?B?S3Z4eXRPN2EyV0tvdkVUazFObzZLOUZEOERyL2d6WHA0TmFnRHBLdEdpWWFs?=
 =?utf-8?B?SW91Zjl2UkV1ZWxFVUEyR1IrejdXQ1puSWYzcWZpekxpMGlBTUFoeGhac2ps?=
 =?utf-8?B?N3ViWGsrWitZcmxiS09TVGlEbXB0S2J2VGtheHorNzBxOXBCNWkvRHNhRTY1?=
 =?utf-8?B?Nm5kU0Q1N0thbSt2dFFMVFV1bWVDSGxmNlJ6ZVcyd3luVW5tRGNhVjBTTGpU?=
 =?utf-8?B?WHJZTzhWUXBLQWRaWXNoeDVqemRkVWFLUXVZZVVSUmlNYjJsQk5CaXdjQ2RT?=
 =?utf-8?B?VnNKalVGTCtXUEhuMHdOUGRtVmdBY1o0eG9mMkQzaThGdXliYkVMTEgyTkRH?=
 =?utf-8?B?TkRZYnZmNHlVNktCS2l6ZzQrdVprZm1haEZGTW93TVdNaUJ5UzV0a3owZlhq?=
 =?utf-8?B?ZVZBRkFXcEhCcU45UTN1K2tTQW5MVVNIMkp6RHpMMVc2SFRlWU1KdXl3S1dz?=
 =?utf-8?B?Z0Ryb2s5M3owOWJ5YjhyZUlySk9LVllkQWlENmNxUVdsYVJtYUhFcXJSQmRj?=
 =?utf-8?B?bGZvb2FDZndla3RQc25yWldOT2I0Z0F5bEorZnNVcjA5U2ZTMmd3bC9hby9I?=
 =?utf-8?B?QUs1SHNFRiswU0hZRngrU2R6RXlUSFFNYWNrNnI3MHp5bXNRMzNPZjN3WXZv?=
 =?utf-8?B?TjFmRlF3cnl2U2diWE12NXpiTzJYZFlZdEFDZTRPMTJJbWFwVWZaenFZa2Vq?=
 =?utf-8?B?N1N0TnA5Z3lMQStKS2Y0UDRCcGF6ZEtOZndtUldMNXhPOFY0Y2gzOHF3aHhM?=
 =?utf-8?B?bE4zdWtSeHV5bklTclNKVjJMd3pEVHEwUmxoRzRSY0YyQWY5SzF4QWhZYStk?=
 =?utf-8?B?MXJuc1pLcHJJNi8wZUJwd3Nsb0dOb3JtQkRzQitSUWVHbXRqaFN1Z05vTGhQ?=
 =?utf-8?B?eHJxUjVNdWhBaURzWXlsQ21qWmRqbHlST0hGYVhuWS9iK3Z6WGp5NzZnVGtp?=
 =?utf-8?B?dkVhMEwxVE11cjN0ZmpuK0U3dUlLQmxpcVZyRGxCR2xlQUNsWVhaTHRUMUpF?=
 =?utf-8?B?ZGpNTDYvSzRZOE9EOXNwT1BydUs2WjB0VHhEZnNDaGFaSW1rcjE5UnNoNHVG?=
 =?utf-8?B?R1RCRUdPcjgwZ0tVc0liN0luK3VZcXJiTVFrMVZPQ3VINExXZGp2dzloZjRa?=
 =?utf-8?B?TVhoMHRUK0hKNFpIbEhQSXdoWmdjUitydkY5b0xDS2ltK1ZPMXNCME9vaGpm?=
 =?utf-8?B?MGVRZVJldUFkYVpJODRzZGZFcXBadlVCV3VZTnpYN01GTkZMQWVmK0E3L3Ri?=
 =?utf-8?B?MysrbGZwVkVtQ1lrZ2tkRGJoa3IydFVNY2hYc3RJRFBza09kclBMbUdWb1VW?=
 =?utf-8?Q?hr7R0pPK9+QHz0qAXgKHKd3rs3/e7D4L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnVYVnUwMGFSNnNIVVRHN0VWSnMwcHJiRTJtSDFIVHJ2MlhIMmk1NHc0ZTFk?=
 =?utf-8?B?ZTZMU1pBUjRKenA3eEZIN1JxWS9mc2E3U2w4cnZwLzFhQnlnRnI3QVpKNmh6?=
 =?utf-8?B?OXZiV0s4cmdRZFJ3NVVQV1F5Y21sN2xLbzV4bUZyL1lzYmhoMzFxOEZQazgv?=
 =?utf-8?B?RFY3aHUzN0xCd2lpZ0EzSDR2NlR0Ym5aZ2VGV2VGdjM4K09zcE5NS09xNk84?=
 =?utf-8?B?RlZDM0JFMW9Sd05XZkV0SE4zTmM1VkU0cmxDZDQzUHlrU0FwY0ZaZXhUaytJ?=
 =?utf-8?B?T3JsY3dLWVdiaGxlcmQyZkZKS3E0UTNqcEZYV0tZUnJFdUFnRER0VkMvMHpI?=
 =?utf-8?B?cVlidHJZZ3pVMlg2TktxbGR6Z0s3VW9ycUxpQUJUUVltZEZZZkVkRG5CMnhQ?=
 =?utf-8?B?Q1lHd05HcXVYZVRSTzFiTnd3TUsxdjZ6eXVMZmFqOWVVWi83dzNqY1o5Z0N5?=
 =?utf-8?B?a3V1eEY5djg5SlVlNzNRSGoxUTdJSXZSVGdtOGFQL1djWUZabkdZcDVxUTRP?=
 =?utf-8?B?TTY0NFgyanA2bDY4dDVIUi9YRjRHMkpLcmt3WnQ2V0E5WTVyUTErMmEwaEh5?=
 =?utf-8?B?Qi9ObUMyTjk3eGJYWFh6cFpVMUhnK0tnNXYvY2ZMenNlNUdtUlZpQ2w1VnFj?=
 =?utf-8?B?WXpFOUQyWllGZENDcG5WbjY1VjhITWNvVUMyS0dDZFZYemNWYlBIRkN2Z3FB?=
 =?utf-8?B?TG5YQytsMC9HUC96NlpkNkIyWkowS0UvL0VLcUo4NjhONGQ4YUNNT2RrdUQv?=
 =?utf-8?B?QUZFVmN2eUxpVFRuejhzYWZmU0dtVkdLSTlCY0FwRUo4dCs4dEk5MW1lN0ZR?=
 =?utf-8?B?WnJEUXczZ3VkOFJibWhOd1ZNMENBMmVqTVRDSWE4OHpUbndPTWtGbzE1a0RS?=
 =?utf-8?B?NEh6ZFU2Qk5RVUJ2TklXVUZnaEtXd2trMzg1L3UwRmhLaWFGS09mYmdMVjJO?=
 =?utf-8?B?VjVuaW1QcjEzSHowVlYxVmFlWVZsQ0dsSjQ5R3JlaUtONmxRVnh2Z2JsWmk2?=
 =?utf-8?B?QmlOa3hNWitueTB2VWdoVXdSL2ZSMWtrdVFFYW1BQmdZS1hqbjlFaVozTFFV?=
 =?utf-8?B?clNpMWt0K05yank1MFU1MmFnUzZnWTRHWEtzY25mMGFESzVhdFM5bHV0N016?=
 =?utf-8?B?WmVTMDF1ZkZXUDg1Z3dWYlBBdC96MlJ2dXg5NVZqZ2hOc0xLUzNocmZNeEwx?=
 =?utf-8?B?K2RrbEF0ZXJWMlVRUVBNby9sTnpCdm5SRUpHWVpFNWVEQ0p1M2NxZW1IdTlN?=
 =?utf-8?B?Nm9oVGRoUTlJMHNMMmkycTlBREMyUzBzYU1WMkYwSzgvUExES1dTcW1IL0Mx?=
 =?utf-8?B?NWdyVXl6b1dDQkgxS1JkZTBXZGVQNGFYbDFPMTZyTUJGOWlvNHlXSENYS0FO?=
 =?utf-8?B?aXd0OHdScTUyN0FFUjZ3Zm1ka2F4RFdBdzVvY1N4Uzl6Yit0K2lLMlcvSS9p?=
 =?utf-8?B?QTdWc1RRZWxHZ1JOMC9USVpSWGptTWFGMFhUNWZ2Q2szMUFCSCtaQ3R1dy9v?=
 =?utf-8?B?WEt4RW9Td2JrRy9UU1FxZWdpd2RlK0RGTW54OVgwWHBQL1V4NEh4bTRaWThL?=
 =?utf-8?B?dHhrTkFqZEsvd0RJUnJMVEE3ODFqa0M1VFhRMUxIUyttUmM2UHMxTDdJSk5x?=
 =?utf-8?B?TUpzd2Y4NHRrSy9nQzI5UXNZcThYT3V1Wm5yaTUwb1NwR3ZHbW45RmFBRjQw?=
 =?utf-8?B?YUR6ZHlzZk9pN1dtL01FSm14bEZadTVCT0xzaHovSlpxa1dpZHBOVjdPcVBn?=
 =?utf-8?B?RzBSWFJFVnp4cEdXNmNmZldzVmVOOXpxNzZhMFdpMnlUQUJtVkxYcGpjZHVa?=
 =?utf-8?B?QWR5OTQyWkl3VkRlYUF4TTNaRHNkTXZXblRJa1NyR1l1NnJCN0lOaGZQeTNt?=
 =?utf-8?B?S3MwRVlNWjBHZTJQbXFQQ2VwWnVhUkd5UDhCbitycDBKWmhlNnBaRGN5VXRC?=
 =?utf-8?B?RGs1QXNHcGdQZ3pCVjBTNjNYdlU5OENhTS82RC91b3liWis0eE8ySGdhcWVN?=
 =?utf-8?B?NVg0VG83WVI0VVlzRHhub1pIeHhLMDdvQUpacU9IMFRwaFlieERrdGQwSWJz?=
 =?utf-8?B?VlBudk1hdVQ3dEhOOFhhNy9ldGIwazI3Nkc3K0l6NkIxMDRmeG9lMEM2dGsr?=
 =?utf-8?B?RVd5YU4zZ3Nack5Ya2JqZG84d3paa2dsR2VRVnVJaURzMWRIMnhzOU9SNlcr?=
 =?utf-8?B?eVZjdzErU0Vza1lXR1dZR1BFQjd6akdzRjhXdThDR1FyZlo5cFFocW1WTFdr?=
 =?utf-8?B?YXNmK3N0b1dGR1pwcHpVZWdrM3RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37D5EF1267E2DD4C93FCDD1349579459@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b9739d-9929-43aa-4f15-08dd568a1546
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:22:01.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo95oSmpeKt9HissbtXLe2Bo+9fjJfHjRKQRJNWBRVX4ZkppjIXwvpr2h7YKETCXPeWAoK25gVSuTKqifXamoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4072

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDA2OjU4IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgMDc6MzM6MDFQTSAtMDUwMCwgTWlrZSBTbml0
emVyIHdyb3RlOg0KPiA+IEFkZCBQRl9LQ09NUEFDVEQgZmxhZyBhbmQgY3VycmVudF9pc19rY29t
cGFjdGQoKSBoZWxwZXIgdG8gY2hlY2sNCj4gPiBmb3INCj4gPiBpdCBzbyBuZnNfcmVsZWFzZV9m
b2xpbygpIGNhbiBza2lwIGNhbGxpbmcgbmZzX3diX2ZvbGlvKCkgZnJvbQ0KPiA+IGtjb21wYWN0
ZC4NCj4gPiANCj4gPiBPdGhlcndpc2UgTkZTIGNhbiBkZWFkbG9jayB3YWl0aW5nIGZvciBrY29t
cGFjdGQgZW5kdWNlZCB3cml0ZWJhY2sNCj4gPiB3aGljaCByZWN1cnNlcyBiYWNrIHRvIE5GUyAo
d2hpY2ggdHJpZ2dlcnMgd3JpdGViYWNrIHRvIE5GU0QgdmlhDQo+ID4gTkZTIGxvb3BiYWNrIG1v
dW50IG9uIHRoZSBzYW1lIGhvc3QsIE5GU0QgYmxvY2tzIHdhaXRpbmcgZm9yIFhGUydzDQo+ID4g
Y2FsbCB0byBfX2ZpbGVtYXBfZ2V0X2ZvbGlvKToNCj4gDQo+IEhhdmluZyBhIGZsYWcgZm9yIGEg
c3BlY2lmaWMga2VybmVsIHRocmVhZCBmZWVscyB3cm9uZy7CoCBJJ20gbm90IGFuDQo+IGV4cGVy
dCBpbiB0aGlzIGFyZWEsIGJ1dCBhcyBmYXN0IGFzIEkgY2FuIHRlbGwgdGhlIHByb2JsZW0gaXMg
dGhhdA0KPiBrY29tcGFjdGQgc2hvdWxkIGJlIGNhbGxpbmcgaW50byAtPnJlbGVhc2VfZm9saW8g
d2l0aG91dCBfX0dGUF9JTw0KPiBzZXQuDQoNCkkndmUgaGFkIHRoYXQgY29udmVyc2F0aW9uIGJl
Zm9yZSB3aXRoIHNldmVyYWwgbW0gZm9sa3MgYmVmb3JlIHdlIGFkZGVkDQp0aGUgUEZfS1NXQVBE
IGZsYWcsIGFuZCB0aGV5IGFwcGVhcmVkIHRvIGRpc2FncmVlLg0KSG93ZXZlciBwZXJoYXBzIHRo
ZXNlIGRhZW1vbnMgY291bGQgc2V0IFBGX01FTUFMTE9DX05PRlMgYmVmb3JlIGNhbGxpbmcNCmlu
dG8gcmVsZWFzZV9mb2xpbygpPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==

