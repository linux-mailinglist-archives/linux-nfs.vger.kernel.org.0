Return-Path: <linux-nfs+bounces-8248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD99DB869
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D94B160F7F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB151A0AF7;
	Thu, 28 Nov 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IlvybkBE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329119884B;
	Thu, 28 Nov 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799919; cv=fail; b=b8HuTccKhxPNL3Xok3TXZj80VeYEQGBBC452HHVO+3qrKir8dZYRrmg7lBD1bbdADZ7sQal6GFjvz/8yR0WWrEV8Su5qkIbE1agKHvoW3ooD9twNOkU7uAdJDMANsT7npJR+cx41FO/dV09S+ZL09Ur/+VYT0UIPFXBRiAacmyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799919; c=relaxed/simple;
	bh=d4UvDFCWAPJThxzqN9nz6r6jG0Te45QlyR2KXCk3wZw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ODo7K4g5LA8aBl7H6tAlrPTfcgIp6T6tttdNEsnPoGwnOITQrPFbcp7u/D7HJKemdLAfC2bqbLlo9HMp2C0ca8n02Hb+66MHRYrEvsV7aZexMMVd+yk5iUn8Ij+Sxhl49I5BuGfflbYZ1xKqTaYwyS3VgcNKmFdtlbVBviMCLBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=IlvybkBE; arc=fail smtp.client-ip=40.107.223.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu3HBGQkvYnn6amE6AHTWzC0KWVq0bXAYdv222MKQ2Cicsb6NXq7oD2JeFQr7qnj4l0wFT2l+vcIVQeWgn52O9rJSFXu1lFgAfp+GwWYZjRz+YNNMAktZ1aeqqIEU7kmPUP2GTA2qa6kbGI6AHmtTGGTXS1f+4nT/E9BQicl24m/dKCbA3R9M9o9lNcVX94eSfwlQChO3KXULIa+91zRM0R7ykVK6niUUet+o+YX6sUTtwumIAyX1Oa7ynr3TfBuM5+qA+c3IyCheBVYXrHVsH7QnmSbEsigySi6Ox+8XEnF2P1t6zlzG9PrJlSt+qK5Itsddoz14oFZPCe0/gRC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4UvDFCWAPJThxzqN9nz6r6jG0Te45QlyR2KXCk3wZw=;
 b=zQjcrGbb2MArC2m6UW5LAsx/Rc29rgY9RhsXqjpDl/uz4X6ZBUiVOtduKwvXqFOfrnYUR7grDDYMJfinqunerllI/8yxSmiW28/J2DCiKOzK3ex71lGPOs3+XXNjVON/T1Z8eLwXYzh/Skyys5C9JU405ZlxLRoawsKA6lZ1ZmhdC0o/dR4Bo3/Jm0AXCPLoWY3fUSeR0ni5WjnCsGbInxW6E/s9ZIB2GJpWDUDrkzN6iUGzsS1zEU+IpRxkLtGWldzXvtNXyevjbU6rh0rduvrEGlTpwxofLyniUFvZyTaDMtXmEy636tbJQRUJUhURnYKAGZdCxhmDITPMha9/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4UvDFCWAPJThxzqN9nz6r6jG0Te45QlyR2KXCk3wZw=;
 b=IlvybkBEyERcLXsxvuO2Y2uakDyZGFY7utkeL/uZ7jGuloVABHfwNTUSr0rlTl7FbDKDPMdC1FxUdX2SNUd95W1OxkBAkzybbd55gEynN8BXe/3e9KYVsTOLSI4KY8lJMjNHoCmbVxcTjKxm1zfjbGhbc2btNmjiAN1KIa6xK6w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4458.namprd13.prod.outlook.com (2603:10b6:610:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 13:18:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 13:18:30 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client changes for 6.13
Thread-Topic: [GIT PULL] Please pull NFS client changes for 6.13
Thread-Index: AQHbQZgErDshQU1GpESqbL9T+Jev1Q==
Date: Thu, 28 Nov 2024 13:18:30 +0000
Message-ID: <5575f2c2b1e1f3ece56a28ecd5d073734797fc2a.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB4458:EE_
x-ms-office365-filtering-correlation-id: 3748f41d-35b3-4a0b-31a8-08dd0faf271b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzJockVaSWdXYW5GQ1dqbWVZUE1ueEdDMTRPZmNHWWljU2J5VWo3NXJ1Ky9X?=
 =?utf-8?B?c0puUmR5eldpNXRRTmJmcENiZWpGSitvY0NEMEJ6VnJaMXFSVElObHlVSVRZ?=
 =?utf-8?B?SThyUlg3ZmI2NklGdzhvWkRNNFppeUhtUUE4Si9ZWXRCR1RmUEwrbXhZbVNS?=
 =?utf-8?B?VFUvOTNOaVQvUS9rdWZ4V3huNHdGYW5oY2VRdnY5Q2o5a2VRbGsxUEw2SGlq?=
 =?utf-8?B?NEVSVzc5T0VsUjFNaGI4NXNnRmVOeDNONzVIZnE0SXVJbkdUL0xBM1dIYktp?=
 =?utf-8?B?TE9oRmlvazVLYUNOeWZwbE4xZWlOb2JnMkczT1BXZWV3ZVo0UjlMM0s3dkVn?=
 =?utf-8?B?czN2MFVYZ2F5UEhDd2RUcGZuTzJvSitDQ29YWm5WeEkwNjY3OXVTZDZsejNJ?=
 =?utf-8?B?MEkwZ3UwMmFGUUJ2KzBqdmF1K0VOeVZtcWU4dXVPVTFQMXdocy9jOHNTZ1hL?=
 =?utf-8?B?V0loWXFlWGFLU2xQYVhoVkZpY3pwRXBTRFVIeUlqTi92RFA3MDdYeS9zcDlv?=
 =?utf-8?B?aWdvcThjQ3o0SDljSkRSdGRVSnZjNERudWtSUWx0U0dpR1RIdWxCU2xYYy85?=
 =?utf-8?B?emNCeTlxcmh1T3N4c1V1M0FoWjFQaE12LzJmY05QQUVuekZ1MEEvWlAxMURV?=
 =?utf-8?B?M0tqNGxyR0lkQ2NhK2pCQnl3UDM1MTY2MUJmQS84cGFBeG8xMU4zUTB4Mi9n?=
 =?utf-8?B?VzNMaEJVbWhkMkhvVlVrK2pURmxOUDcrM1o3YWMyRFJjWGo1ZG1JVVlUZ1dP?=
 =?utf-8?B?cUh1TGNOWWRjdU94eDRsT3VRT0lMRmhvZXFsOHZ3S3RxYjNvUXMreGpmSDRD?=
 =?utf-8?B?QVRUTlNhQzU4TEticjRqNUJiQkhkS28yTjVsZFZBajJjQzU1R0VHME1oN0Nk?=
 =?utf-8?B?Tkg0bkh3c1VPNGVKWjFBcGt3c2dkM200ZDY4L2Qya2ExM0NZVzNhQWpGR2VB?=
 =?utf-8?B?Sy9HaUt4SnVJRlA1WnNkQWlvOWVnYjNwSlZkV2lNb3FFYTlrcXB0TDI3ODNn?=
 =?utf-8?B?OGs5RjVQVjhUNjQzcWI0Z0NsYjhjUUJVdnhaNVR3T1dVTHFUUTFBRmsveVZL?=
 =?utf-8?B?ZThRWlVTM3VVSGVTMW0xV2Jpdi9KTEh4L1FyeFlpOG5JY0NCKzl1MXZDMXg5?=
 =?utf-8?B?TWJZNlU0L1ZMajFydXJhSzdUeHpzakZTc3E3Ry92Z2hYMTc5MHJjZ1JSRUMz?=
 =?utf-8?B?MDlsRVROZXY0amZuTHp2KzRmY3MzTmsvcnBQdVJraE5Mb1hwV0U3NXBBTnd0?=
 =?utf-8?B?TDFiNkV1TlNGQndXYmxLbTVMM2t4L2lPdFN5dVM1a3NsSUlwVVYrclp5Slcz?=
 =?utf-8?B?cEJ5OHFnK1VZUjVkRGJ3NnVYaFgwS2RIUGRUcE95OTRVVFViOEh2aTBwZnd6?=
 =?utf-8?B?MlJwalR4SVpWbzdBaEFieVNEWUkya01GQ3Rzbnp0L2FJbTZ5cjhNY092aTJN?=
 =?utf-8?B?eW51L0psNXVMd3p6bVk2LzM3WE5QRkg2MDhTaGR4WkJCV3pPVDhDSWk4Y3Bi?=
 =?utf-8?B?eTZUSVJhTWtpZVdmSlpIaFMyamVkZkZvQzBPa0c0bTVwcDhiNHlUWDZDSEZD?=
 =?utf-8?B?TDhTQUhBOGwxQ2ZLR2FCMnArejNXMkRKYkpPRGs0UkxEcUEyais1Z2tiUHc5?=
 =?utf-8?B?Wm5FcnNJUXZqaWRwSEJxZktnWXBwK1F5bUg1bDM0V0V2eDVVWFlhdXh0U0pq?=
 =?utf-8?B?aGxNZ2tsendyampOTUJYUUVsUXY0cFRuNzBoOUZtVHEyY0ErUzFZbU5FNU9X?=
 =?utf-8?B?clZpdEF2UmF3S3pkQnV5bERXaW1YQ1hNaWEyVnpwa2dIN0E3bXV1bWhLbDhF?=
 =?utf-8?B?bzdZTkdGSWp5elptUlArNGhXa3NZZGVNY0VYTWRvRmJjUzhFZGlLR1JPMmZS?=
 =?utf-8?B?MXBIdCt4M3Y2SnY0ampQVEN0NVFtUVZlK3o5T3hyUlVmV3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXJ2SzZpdDhGYkYyc25CZmp2ZXlqZ0Rldk9sNkljWDNYZHpLTXJpRFhOYmp3?=
 =?utf-8?B?ZG94RmRXV29Vd0thVjlsVjlGV293R2JkMHYzbHpYUGxscUFGV2c2a2E1aUxu?=
 =?utf-8?B?QkxXV1lFU3c0TU1CV1lhZ0x4WHlOQWIrZG1qWEdITWFFa0FjVHFJT2huaGZ0?=
 =?utf-8?B?aVo4ZzZlQWFFNVk4KzJYSWI4V2hUT0VRdGdTNW0rME1idWRrWG8zZjRNYUNv?=
 =?utf-8?B?Wi9RM0tuUDc5NjZiMVRCaDJqaXdJR2R2Wk50bXJmbHBraVRwd05BbE9IQURG?=
 =?utf-8?B?WGZBL1RUUlRORFBta2p0dUdjRVV0ZzdKZTFLSytNcm14YXhXWGlmUjQ1RHV2?=
 =?utf-8?B?dTQ5Y0R3M3M5NUI5a2ZUZFY4eFlHWXBsdENsdE1QanNlUjZWYy81N2M5b283?=
 =?utf-8?B?aXBvaDVOQkNqN3JZS1l4RnN1TC9VT0Zna05IWmQvMno3T2NEL2FoSkJPdnJR?=
 =?utf-8?B?all5QnVZZUtTUFpsT0d6eHNyWkx5YmRpc3ExMERuRG9oVC9qVTRVc1l6UkNJ?=
 =?utf-8?B?NkJPTWEwdzVTZGlpakhwaFJ4c1IxREd0Z3dyWWM3Y3ZBckxuS1dKdHVHbjBY?=
 =?utf-8?B?dzExNUZGditIVDczeGdTVHBhZlkyOEt5WW5DZFFjWG56RkF1YXlkaWRrbHdG?=
 =?utf-8?B?UnI0dmlLU2ZZTURvR0paR3dkTXVJckRiUVoxVnU3bU1VUHlkYVVCRmppOFdt?=
 =?utf-8?B?NHd6ZHB1a3BnTVhwYjBXK1ptNThXaTVyLy9MbmNacjkwOFZHVGhUQnZtRGFv?=
 =?utf-8?B?bHFGb2V6L0VZMzhGaldPUk9PWlZ5WDVQRUF3eWF6cmNJYldYb25BY1FBMkFP?=
 =?utf-8?B?ZStjcjV6MkJUL3NRbFdsSTRPc1oyN2g0TThvMWJ1OXM2VWNPVVpLeXRaMWV1?=
 =?utf-8?B?YmhGNEF2UmJ3a3I5d0tDdUFsKzRyaG9UT3VCRXBRTWRzclI1UldockFEWEx4?=
 =?utf-8?B?QkozS0tGS1JPbUd5Q3ViN0VtUzJZN1dUMHp1QnRySEJHNmY4THZRYlNhTnc1?=
 =?utf-8?B?cXJVbG1kSjhvV0NwVEQrRXNGZlNKbmxRWHJxbUdDU0paQjRhbCtZZ3d2bHpn?=
 =?utf-8?B?S3h5TFU4TnYrK3pRcGZRdVBVTnRPTW9xTXJXUTYzSlRMSWZIZUt0Vm1SMDgy?=
 =?utf-8?B?YnUyZks0NmgzRjBxVnJ3VlRnQ3BRTk9iZzlNUzFaZWQ0bUU5WUVqV2taM2d5?=
 =?utf-8?B?N0Rkbm9LNDBTZkRqd2luUVJKYlBPV040QW0rbE1mYmZvNGoyQ0E5UkFEZHk3?=
 =?utf-8?B?SWtQdm9ieVJld3UwNUNhalJLay9sWFdtSGluMGl2Vm4xYmMwemlGaGhNTUhI?=
 =?utf-8?B?YnhMMHVFQWkvbzRET1hZZ0JSaVZmN0ttOUhLM2NRK2NpS2IvU2h5R0pzazBM?=
 =?utf-8?B?VkFJNnp5NjRMY0RRd0JiTHlKZVNETVZWKzlJMnlPZW5LQUNROUZ2NDZ3Qzcv?=
 =?utf-8?B?NFg1Q3F2UTdsTkdXZEdKamhvSWRMYS90UlVrcTJWRllkWVNHc3V4SWNscWVD?=
 =?utf-8?B?NDFQYmM5Y3MrWW4zeDF4TGJhWktzK0RDK21xQ05BUTR6amlFOGUzTWE0ZGRV?=
 =?utf-8?B?Z0YyVlZka3pMcFovOTkxRVU1bWt2VkZEenNwdVRMVXQ0cWdVelpQUzZvWWFo?=
 =?utf-8?B?WGxOUmQwRndFWUVJQzJWUHVDeGgrVldLelhjck1lV2NkTm83OG5keDIvUlhr?=
 =?utf-8?B?cStXYnhVUllLcTZ3SE1Gd3lGaHNRckxkMVRqcy82VCs0UVkzdmIvSURHS2wv?=
 =?utf-8?B?dytMeU5ETmt3c2tKZ0pKVzZScFNOT0VsOSt1VjBEOUFUayszT2pNZEF6RHpp?=
 =?utf-8?B?Y1g3RlY4aVlkZjhMRExMUFV3d3BWMlY5WFo4WERUY25hNDdqaVNkZjZTREh5?=
 =?utf-8?B?Wk9rV3p5UWdmTW5ZNy9POGdWTDJMeGYxMWIwOWNZSHppWVk5K1czelBYSHph?=
 =?utf-8?B?VXhGdE5jMTRmeGdFVWJqOXo3WkxhYXVMMDhDOFJPSnhWR3pUeVZNRW1HM2VN?=
 =?utf-8?B?QUZUa0IvRTlBUHpXeDdJeXdZMXR1YjBpeTBNSlBxU21MNlZmRlptSzUyd0ho?=
 =?utf-8?B?bEJ4MndJOVRxcTNtTWx1MC85TnlhMlFBdUUwWUk2M0tvdUs2S252UGU1ZjVG?=
 =?utf-8?B?UGFYQVVVZVB5eHZIY1FNU2JSbG9JanFWV3Exd2kvQnVDSUo3TlVMWUcyMXpH?=
 =?utf-8?B?WEpHZEFYK0g5bmtiTEV0R0RLODFlZmd0VmNBNUFQUkJWUWpiVWlLRHN2SDlG?=
 =?utf-8?B?RlczdTZqMncrYlpWOGx2SWp6a013PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15576368F784B742B542C7F1148EA83E@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3748f41d-35b3-4a0b-31a8-08dd0faf271b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 13:18:30.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKQvvNDypqaZzyDDMQaTJt60hrHKMtIOV91BQeEn8Fgx/BDXCd9YFnglA4E8QlYPev2pjQdCQM4FSGhEDS3V4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4458

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZmY3YWZhZWNh
MWExNWZiZWFhMmM0Nzk1ZWU4MDZjMDY2N2JkNzdiMjoNCg0KICBNZXJnZSB0YWcgJ25mcy1mb3It
Ni4xMi0zJyBvZiBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4LW5m
cyAoMjAyNC0xMS0wNiAxMzowOToyMiAtMTAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJv
bmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci02LjEzLTENCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIDIwZmRlNmMzNGQ4ZTU2YWQ2YTA4Y2JkYTE5MzQyNzY5Y2FlNmE4ZWY6
DQoNCiAgZnMvbmZzL2lvOiBtYWtlIG5mc19zdGFydF9pb18qKCkga2lsbGFibGUgKDIwMjQtMTEt
MjIgMTA6NDU6MjggLTA1MDApDQoNCkhhcHB5IFRoYW5rc2dpdmluZyENCg0KVGhhbmtzDQogIFRy
b25kDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgdXBkYXRlcyBmb3IgTGludXggNi4xMw0KDQpIaWdo
bGlnaHRzIGluY2x1ZGU6DQoNCkJ1Z2ZpeGVzOg0KLSBORlN2NC4wOiBGaXggYSB1c2UtYWZ0ZXIt
ZnJlZSBwcm9ibGVtIGluIG9wZW4oKQ0KLSBuZnMvbG9jYWxpbzogZml4IGZvciBhIG1lbW9yeSBj
b3JydXB0aW9uIGluIG5mc19sb2NhbF9yZWFkX2RvbmUNCi0gUmV2ZXJ0ICJuZnM6IGRvbid0IHJl
dXNlIHBhcnRpYWxseSBjb21wbGV0ZWQgcmVxdWVzdHMgaW4gbmZzX2xvY2tfYW5kX2pvaW5fcmVx
dWVzdHMiDQotIG5mc3Y0OiBQcm9wYWdhdGUgbW91bnQgZmxhZ3MgdG8gdGhlIHN1Ym1vdW50ZWQg
c3VwZXJibG9ja3MNCi0gbmZzdjQ6IGlnbm9yZSBTQl9SRE9OTFkgd2hlbiBtb3VudGluZyBuZnMN
Ci0gc3VucnBjOiBjbGVhciBYUFJUX1NPQ0tfVVBEX1RJTUVPVVQgd2hlbiByZXNldGluZyB0aGUg
dHJhbnNwb3J0DQotIFNVTlJQQzogdGltZW91dCBhbmQgY2FuY2VsIFRMUyBoYW5kc2hha2Ugd2l0
aCAtRVRJTUVET1VUDQotIHN1bnJwYzogZml4IG9uZSBVQUYgaXNzdWUgY2F1c2VkIGJ5IHN1bnJw
YyBrZXJuZWwgdGNwIHNvY2tldA0KLSBwTkZTL2Jsb2NrbGF5b3V0OiBGaXggZGV2aWNlIHJlZ2lz
dHJhdGlvbiBpc3N1ZXMNCi0gU1VOUlBDOiBGaXggYSBoYW5nIGluIFRMUyBzb2NrX2Nsb3NlIGlm
IHNrX3dyaXRlX3BlbmRpbmcNCg0KRmVhdHVyZXMgYW5kIGNsZWFudXBzOg0KLSBsb2NhbGlvIGNs
ZWFudXBzIGZyb20gTWlrZSBTbml0emVyDQotIENsZWFuIHVwIHJlZmNvdW50aW5nIG9uIHRoZSBu
ZnMgdmVyc2lvbiBtb2R1bGVzDQotIF9fY291bnRlZF9ieSgpIGFubm90YXRpb25zDQotIG5mczog
bWFrZSBwcm9jZXNzZXMgdGhhdCBhcmUgd2FpdGluZyBmb3IgYW4gSS9PIGxvY2sga2lsbGFibGUN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KQW5uYSBTY2h1bWFrZXIgKDUpOg0KICAgICAgTkZTOiBDbGVhbiB1cCBsb2Nr
aW5nIHRoZSBuZnNfdmVyc2lvbnMgbGlzdA0KICAgICAgTkZTOiBDb252ZXJ0IHRoZSBORlMgbW9k
dWxlIGxpc3QgaW50byBhbiBhcnJheQ0KICAgICAgTkZTOiBSZW5hbWUgZ2V0X25mc192ZXJzaW9u
KCkgLT4gZmluZF9uZnNfdmVyc2lvbigpDQogICAgICBORlM6IENsZWFuIHVwIGZpbmRfbmZzX3Zl
cnNpb24oKQ0KICAgICAgTkZTOiBJbXBsZW1lbnQgZ2V0X25mc192ZXJzaW9uKCkNCg0KQmVuamFt
aW4gQ29kZGluZ3RvbiAoNCk6DQogICAgICBTVU5SUEM6IEZpeCBhIGhhbmcgaW4gVExTIHNvY2tf
Y2xvc2UgaWYgc2tfd3JpdGVfcGVuZGluZw0KICAgICAgU1VOUlBDOiB0aW1lb3V0IGFuZCBjYW5j
ZWwgVExTIGhhbmRzaGFrZSB3aXRoIC1FVElNRURPVVQNCiAgICAgIG5mcy9ibG9ja2xheW91dDog
RG9uJ3QgYXR0ZW1wdCB1bnJlZ2lzdGVyIGZvciBpbnZhbGlkIGJsb2NrIGRldmljZQ0KICAgICAg
bmZzL2Jsb2NrbGF5b3V0OiBMaW1pdCByZXBlYXQgZGV2aWNlIHJlZ2lzdHJhdGlvbiBvbiBmYWls
dXJlDQoNCkplZmYgTGF5dG9uICgxKToNCiAgICAgIHN1bnJwYzogcmVtb3ZlIG5ld2xpbmVzIGZy
b20gdHJhY2Vwb2ludHMNCg0KTGkgTGluZ2ZlbmcgKDIpOg0KICAgICAgbmZzOiBwYXNzIGZsYWdz
IHRvIHNlY29uZCBzdXBlcmJsb2NrDQogICAgICBuZnM6IGlnbm9yZSBTQl9SRE9OTFkgd2hlbiBt
b3VudGluZyBuZnMNCg0KTGl1IEppYW4gKDIpOg0KICAgICAgc3VucnBjOiBjbGVhciBYUFJUX1NP
Q0tfVVBEX1RJTUVPVVQgd2hlbiByZXNldCB0cmFuc3BvcnQNCiAgICAgIHN1bnJwYzogZml4IG9u
ZSBVQUYgaXNzdWUgY2F1c2VkIGJ5IHN1bnJwYyBrZXJuZWwgdGNwIHNvY2tldA0KDQpNYXggS2Vs
bGVybWFubiAoMSk6DQogICAgICBmcy9uZnMvaW86IG1ha2UgbmZzX3N0YXJ0X2lvXyooKSBraWxs
YWJsZQ0KDQpNaWtlIFNuaXR6ZXIgKDQpOg0KICAgICAgbmZzL2xvY2FsaW86IHJlbW92ZSByZWR1
bmRhbnQgc3VpZC9zZ2lkIGhhbmRsaW5nDQogICAgICBuZnMvbG9jYWxpbzogZWxpbWluYXRlIHVu
bmVjZXNzYXJ5IGtyZWYgaW4gbmZzX2xvY2FsX2ZzeW5jX2N0eA0KICAgICAgbmZzL2xvY2FsaW86
IHJlbW92ZSBleHRyYSBpbmRpcmVjdCBuZnNfdG8gY2FsbCB0byBjaGVjayB7cmVhZCx3cml0ZX1f
aXRlcg0KICAgICAgbmZzL2xvY2FsaW86IGVsaW1pbmF0ZSBuZWVkIGZvciBuZnNfbG9jYWxfZnN5
bmNfd29yayBmb3J3YXJkIGRlY2xhcmF0aW9uDQoNCk5laWxCcm93biAoMSk6DQogICAgICBuZnMv
bG9jYWxpbzogbXVzdCBjbGVhciByZXMucmVwbGVuIGluIG5mc19sb2NhbF9yZWFkX2RvbmUNCg0K
VGhvcnN0ZW4gQmx1bSAoMSk6DQogICAgICBuZnM6IEFubm90YXRlIHN0cnVjdCBwbmZzX2NvbW1p
dF9hcnJheSB3aXRoIF9fY291bnRlZF9ieSgpDQoNClRyb25kIE15a2xlYnVzdCAoNCk6DQogICAg
ICBORlN2NC4wOiBGaXggdGhlIHdha2UgdXAgb2YgdGhlIG5leHQgd2FpdGVyIGluIG5mc19yZWxl
YXNlX3NlcWlkKCkNCiAgICAgIE5GU3Y0LjA6IEZpeCBhIHVzZS1hZnRlci1mcmVlIHByb2JsZW0g
aW4gdGhlIGFzeW5jaHJvbm91cyBvcGVuKCkNCiAgICAgIFJldmVydCAiZnM6IG5mczogZml4IG1p
c3NpbmcgcmVmY250IGJ5IHJlcGxhY2luZyBmb2xpb19zZXRfcHJpdmF0ZSBieSBmb2xpb19hdHRh
Y2hfcHJpdmF0ZSINCiAgICAgIFJldmVydCAibmZzOiBkb24ndCByZXVzZSBwYXJ0aWFsbHkgY29t
cGxldGVkIHJlcXVlc3RzIGluIG5mc19sb2NrX2FuZF9qb2luX3JlcXVlc3RzIg0KDQogZnMvbmZz
L2Jsb2NrbGF5b3V0L2Jsb2NrbGF5b3V0LmMgfCAxNSArKysrKystDQogZnMvbmZzL2Jsb2NrbGF5
b3V0L2Rldi5jICAgICAgICAgfCAgNiArLS0NCiBmcy9uZnMvY2xpZW50LmMgICAgICAgICAgICAg
ICAgICB8IDY0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIGZzL25mcy9kaXJlY3QuYyAg
ICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKy0tDQogZnMvbmZzL2ZpbGUuYyAgICAgICAgICAg
ICAgICAgICAgfCAxNCArKysrLS0NCiBmcy9uZnMvZnNfY29udGV4dC5jICAgICAgICAgICAgICB8
ICA2ICstLQ0KIGZzL25mcy9pbnRlcm5hbC5oICAgICAgICAgICAgICAgIHwgIDkgKystLQ0KIGZz
L25mcy9pby5jICAgICAgICAgICAgICAgICAgICAgIHwgNDQgKysrKysrKysrKysrKy0tLS0tDQog
ZnMvbmZzL2xvY2FsaW8uYyAgICAgICAgICAgICAgICAgfCA5NiArKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZnMvbmZzL25hbWVzcGFjZS5jICAgICAgICAgICAgICAg
fCAgMiArLQ0KIGZzL25mcy9uZnMuaCAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0NCiBmcy9u
ZnMvbmZzNHByb2MuYyAgICAgICAgICAgICAgICB8ICA4ICsrLS0NCiBmcy9uZnMvbmZzNHN0YXRl
LmMgICAgICAgICAgICAgICB8IDEwICsrLS0tDQogZnMvbmZzL25mczRzdXBlci5jICAgICAgICAg
ICAgICAgfCAgMSArDQogZnMvbmZzL3dyaXRlLmMgICAgICAgICAgICAgICAgICAgfCA1NSArKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvbmZzX3hkci5oICAgICAgICAgIHwg
IDIgKy0NCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaCAgICB8ICA0ICstDQogbmV0L3N1
bnJwYy9zdmNzb2NrLmMgICAgICAgICAgICAgfCAgNCArKw0KIG5ldC9zdW5ycGMveHBydHNvY2su
YyAgICAgICAgICAgIHwgMTggKysrKystLS0NCiAxOSBmaWxlcyBjaGFuZ2VkLCAyMzAgaW5zZXJ0
aW9ucygrKSwgMTUzIGRlbGV0aW9ucygtKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==

