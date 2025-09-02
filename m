Return-Path: <linux-nfs+bounces-13991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636DAB40F3F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 23:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25279176723
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D12E174D;
	Tue,  2 Sep 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="hEZbYFFf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2092.outbound.protection.outlook.com [40.107.212.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BF272E45
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847933; cv=fail; b=RaJeXwRfWmaj+y+FK4mWX/vi0ylEWIC47WYnC+8pjzhLPxAnPoCg0k0/l6omqhVrKilgkjwRC7m4YCAklVxbinAa8m9lMpOnNtEcOUmZ30/X8adFTLcl7vu5Y/jckz4rhHaRmeGzJ48J8BkJQzsLEewTE41OTnee3ABylBkue84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847933; c=relaxed/simple;
	bh=Lh2gzD2cBJD/6+gOnk/0QyK6bJsEY4XF8GwzM0DUYr4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JR6D5ncnja5LfMMvX4aYTKaM/8R6/tvvouecYQpHX1+VYxaoDwjj8H0eZvXu6WhlRY9E7GHcwPH/mJE3gz6gBeb0//i00QgeQkybVElhWMlNrqI7Uz8dtsro/r5IIjowytBcBhea5JtgFRRK2YOJAKjz+foDKO5QNFf1cL6tJfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=hEZbYFFf; arc=fail smtp.client-ip=40.107.212.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1HQgmgN4HeOOoH4EO97vI+cj4TJx0+95p/gycjLZ+ENuCj16ceaPzyfPoF9/evMoU6lEcpLqb1icnaN28QFG6DG8gakNx4LqEZ9rg8e/AeQmAue0rsku4Zxke415qZXfUebOn7xh9MwROmAoyYT+FS7kjb8po6/gisxxfesHqUc2EKjSB1xABRs9iTn8AfvY/0PqTi9rL41FB0f2FlJqyvE7TH47w6PrLRpOKVZc6K+ms8v7nfWG0egcqIYKv7RGt1/LTqGJ42//2wIqArw89mZtCbwJMPeIfRGUBY8b6TpFwgRk1Fm4WV9+/Mpf3+QOHly65VMLYWrvIl1R14dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh2gzD2cBJD/6+gOnk/0QyK6bJsEY4XF8GwzM0DUYr4=;
 b=KOopnngEldnnNsgLx9E/Z9nTc6B4lPNnEiPI+D9BP/501rWtFpF+zVhpOA6h2RIJqlKtxTg9QHB4eolWILWxlRxhSnIDtIvvoWso5wHz1+WeoVafGnAnTAZfyqD4AJ3YSGqFkar9OTSO/HCV747iNe75qQn2IOrvmrkG6LQnxAMawBRZv2+cq5/+GXB3NKihWdAT6cm4rQ8aIUnvgEka+RbNVk3TLBPp1Yr3OubYpcQL6lqw5y8ikh/UJBaPBbBuvKzIlpacw1Urb1zjG/11e/5QWgAhsyDJ5PO+djA0W4XN5ytqaR8bCjOcDATdjZDzfhcytZOJV5UIRSjqywpjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh2gzD2cBJD/6+gOnk/0QyK6bJsEY4XF8GwzM0DUYr4=;
 b=hEZbYFFfYKGhd6wGVJsvu8IrYlTeHoCM0TI7bNBqy+nP7oXbWxduYcTeOQDdik9ND29e40dQf3KObiypTqgu0Y0zoDFTn9vjX63Pqtdk+wXpvzEtBTdARWTfszmRqkdQ72YvCCrftnj189y0Mxmy26/yrlcW8e7s1w4tYF9kDck=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB6216.namprd13.prod.outlook.com (2603:10b6:a03:531::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 21:18:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:18:47 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "yanghh@gmail.com" <yanghh@gmail.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] add force_layoutcommit param
Thread-Topic: [PATCH] add force_layoutcommit param
Thread-Index: AQHcHDY00MSMGe62u0yIvaJ7P3vwI7SAZekA
Date: Tue, 2 Sep 2025 21:18:47 +0000
Message-ID: <535288ce066121be20b7c76842eb3e84d25b9d16.camel@hammerspace.com>
References: <20250902181950.2057363-1-yanghh@gmail.com>
In-Reply-To: <20250902181950.2057363-1-yanghh@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB6216:EE_
x-ms-office365-filtering-correlation-id: 9bfab332-f9cd-4c0f-6927-08ddea664e13
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjdpM1NzNEI0WXhTNGdQeUtySGhkR2NKMHl0NXd3UVJCUUpQZmt6K3BFM1JF?=
 =?utf-8?B?OG1FbFNhZFR1bUtVcjY2SDBIN1R4Q3lXZnEwYUtCVVdDUXk1aVUvNjFUN3ZD?=
 =?utf-8?B?QU5ydzR3eDZuc24wOG0vMVdHYzQ4VHozbVk4VUpGejlwMDJOWWhmb2NpdVJI?=
 =?utf-8?B?enRITXJPdHNYOVFQQncyQzFFNmJEMnlvRTRIMC92YmFpSUttOWNxMHkvaE9K?=
 =?utf-8?B?Zi9xL2JQSTJJN2sxODlyYWRZK29DWUs3OHRnSTErQk9DOTlIbjc5bG15UVQx?=
 =?utf-8?B?SmhQT044dUEyZndqNlpPNzB3VzNkT1YxTjc5OC9iQlRsb0grdEVaS0ZmdzBl?=
 =?utf-8?B?VzZGblk3M2NKdHJDYTlNOUdnbzhQYXN1c09PeDA0ZjBpdEVUVERYUEFLdUMw?=
 =?utf-8?B?YnhrRFpsSkhIaXpxTzdlSFU5Q1BGSGdZNkY4bCs0Q2xXTVRlRTBKNFM1MkIr?=
 =?utf-8?B?bG53Z3NxUDZTcmM1ZnJmeGl4Rmx3dWt0R0tmY1lRcFZFa0hPTkw2VjQ2ZWtq?=
 =?utf-8?B?Z1pBck1JYnJhN2UyeHNKN0lOL0ZvUWhCY2dIVFkyYjRhZ2UyamJOTUc2b0xO?=
 =?utf-8?B?S2pZNkVZQWpmN0pJWE0wK2t5bm5RQjhmVGFZbUNjL2VxWGMvZFAvSFZJazNP?=
 =?utf-8?B?Vlc5U1BTTjRKTk5kMTRKVGs1c1oxWVc2eVArT0ZVVytnNDQ2RHNEVzNDU0Ns?=
 =?utf-8?B?UFl1WDdKZHF4d3Y5bitENmkrWnVjYXV3cmVLZXZqcGlBekprWmxhaWlpd2ZO?=
 =?utf-8?B?RWZxMHkrblJJM0xLZi9kUkZ6VjM2N0puSG1rallFR2NQY1ZTNGo0RnFVM05v?=
 =?utf-8?B?a1RKOHNxMThmVzhJZjJ1SXJLaE5zZkRqRC94blY3WlNmaC81Mis2Tnpqa1pL?=
 =?utf-8?B?R01JN2I3YmRieUk0bzRGalFCeUlZZTFWbjlJbzRjM2U0NXYrK2ZKNEpjMGdY?=
 =?utf-8?B?b2hpV3pYS2h3Y2FrUy9IVXB4UTBTUkhxV0QzdFI1bWxIemZ3NCtkT3hzWWVa?=
 =?utf-8?B?cjQyNlJzUUVrM21TQTgzMTBkYXJSODdUbS94ZWUySG5BSEhZS3RqODY4NHU3?=
 =?utf-8?B?Q0Z2UnBva2hPSjlvYVJ6MVlObzJTK1pyaUw0UlZIRDNLaDh0MWI2UEx0aU9X?=
 =?utf-8?B?QjQ4Nkl5MHU2RWN2MGxBN3VTZkpHa2R6bzEyQ3BIbFdQOXJsWDE2alJhR3VC?=
 =?utf-8?B?cnVSS29CWVM2WStrTHp3V3Z6bDRaZy8vRTZ4OWQybHU3T01ZektoUjgvS3dL?=
 =?utf-8?B?aHhvV0tEbytlTFBxcVJEbkZxUlgyaHl6VzZ2RnE3SHdzamF6Ujl6Wjc2TGZU?=
 =?utf-8?B?SDJtMVdhSDNDajNwRzZ6SGpBbkI5NXQ0YzVzUGpiTDR2ZnB3dlB5LzZUWkEw?=
 =?utf-8?B?dTUzeGtncTY4L1VZSUV6UmFrVFBMSU04SFhDK1NkMEpQMnJmaTY0NWp6TTBY?=
 =?utf-8?B?cU5lNkxoTEpvdjFZT3Ztd0J0SGc5ckRWK0U0RmNDMzA1Q3h0OGtRL0hMZFNY?=
 =?utf-8?B?clpmOFJkUTFzWXUrN25yZkJWYlZkcGlXcHBic0d4Z1YxekxzdkZTTmtaWkJR?=
 =?utf-8?B?QXJ3ZTlUQlJkS0ZDdVpxUzRIYk9lUEkrU2s2eC95emx5RjBBWWtDQkpmQVNO?=
 =?utf-8?B?SUNkcnA2MTZKNm54a2x2cDV1MGFZQmFjV09LTUs2VFR3cTVneU9FWjRwOFZw?=
 =?utf-8?B?NVVOeWVpUmJrY2Q3d00yTm43RnZaMi9sQXVYSUMvZUtiRXZmYUJMTmFnVXY2?=
 =?utf-8?B?K08rRm1PQTNXQ0FWTFE2UnhUMGVyL0NyMmliczg5VUxleWlYWEV6Z01ZNWN6?=
 =?utf-8?B?WndaNTNYNFY2dWVMelpWaGZNMDRRRGNSczQySzV3QldXa29sT1hadjg4Vldr?=
 =?utf-8?B?YVV0QldpS29IalNLZ2ZZRS9iTmdISVhqSkNIRlVLWE9XbzFrOUJ6QmJVSmNy?=
 =?utf-8?B?QzM2WW5IZk1KM3BHUXd0YXF4NXZBYVoyL29pdWlIcFhTTXJTa05tRjVLTVJp?=
 =?utf-8?B?T1ArQUxOb29nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU4xdDE3Y0JGbEdaY1hRWm5hbVNNMmtHMVFRK2NOa2J2S0tFaEFKS01uUFBq?=
 =?utf-8?B?USswWElRck1Hck5zNHZkUGtmVG55ekRnb1ZBZkJlSUNYTnpiaUpDU2tHSHVv?=
 =?utf-8?B?eHQvS1dHN2wyeWprdTNyWGlUTHd5NHUxOVhCVXFUc2RVL2JvWFQ5V01wZ3ZQ?=
 =?utf-8?B?akh6UWx3d1pwV0o0TjRTdUREU2JmempnOEZhZjlId1kwTm9Dc1A0M2JMTmpV?=
 =?utf-8?B?UXN4OFl4cHZGUmQ4TGJaVEk2cmM1QmhKbzhTcmZ4cnhwUnZta05EN1RrRFpw?=
 =?utf-8?B?M2xxQXFCTDFLK0FDNE90SENRME1tVTNucW5qOS9iaEZGNDErT2R3ZlRHOExq?=
 =?utf-8?B?YnVIZDh3VWFJdlhlSU1aYkdkR25MRGlnMGpOQXF4UDBYaEUrR1JmajZGTEFI?=
 =?utf-8?B?RktUQlNnKzNRcWtlSjNBRjVQbmg5SHU0Y244czNKOHg0ZkhKdmFjcGNTcCtx?=
 =?utf-8?B?c2tTUm1UYUdpY1dmanpncGZuTnordUpyOUg0SHA0a1pjYUs1ZkNDemJOQUh6?=
 =?utf-8?B?NEtDSEw3bnRsM05saEdJeGdESnlHOE9JdGJ1T0t6QmJWRTU2RlNuQVlGaHl2?=
 =?utf-8?B?am4yVUNTZ2lLQm5WU081TnBLZW5ISWkxYWdXay9TaG1DTXpac2VEN1JIbTdv?=
 =?utf-8?B?TkN1RHNGRUQ2bTM1dmZvTmoxSEllWkFoQVZRR2tUWHZaZktZSFVsRlhLbUhj?=
 =?utf-8?B?TTZMZmNKVk9oYytwUXNlUDJLM3NKWWVQZnVVOWMrVDNxcUpLUWY3RVdzZU9j?=
 =?utf-8?B?SUVwdkNnOHhBdXVhcFlLTGhac0xOMUlTbVBXVThYNmxnRmdoSHpiUGlGQUxW?=
 =?utf-8?B?MTRVMDU2NytuWWhueGUveFFMeEEzcVFMRUVPODViVFVCeHRDUm1vK3JxQ1Fv?=
 =?utf-8?B?VW4yZ1hwMWx5MVlBOWtLRWRSaWNWbTRYOHBLT1J3OE5XSDNWdVQzYUIzZXlN?=
 =?utf-8?B?UEJLaHkvMGZrN3FmQi9mWVNFR0xyOTlTMjB4SUlqdENyajZqRnI1Z0Vqc2FD?=
 =?utf-8?B?WStSY2lsR2lGRGtMM3lUb29YWkZYZmZia1lDRFZTenNTQjg3SndlRFdZWXhm?=
 =?utf-8?B?VzBUWk1DTXZQYUF4SEhzbThwUCtZTFp2ZEZLcTVNMkVDaDJyc3RSZGdzUUgw?=
 =?utf-8?B?OWZGRGd6WU9oNFROUU9ybll6cCtBbUJRL1NmR1VqUHpoYnp4RDJVM1dHV3VP?=
 =?utf-8?B?OXREcVZuaDFkdTFCMVJpK2tUTjFrQU8yZTVqdXhWN3d4bkZFQk00bEZMN0o1?=
 =?utf-8?B?WGhVd0ZObTI0cmpudDJZNDZFUklmME10UFdLU09CZTJmWkd6Q0JXcWoyUWV0?=
 =?utf-8?B?dkE3ODUwL1hiMm1TdGozUm5NRXVEUHQvcWZ1NlFYT01vVTl1eVo2T2xEMGNw?=
 =?utf-8?B?bDlMZmFJU0RYbHFDNnYzTTBmS05IYWhSU25sUDdKS2VteVhMY1p4bXNxNTRp?=
 =?utf-8?B?MDc3c1BOcDA0Z25rbjlxR3l2UTZwT0hXYkYrL1dRMG50WFpwK1RaOGx0Q1RT?=
 =?utf-8?B?YldFVzNsZ053SUpxZ3ZvczBOb1RiN3NmLzUvZXhFWFo2clpTZ3RRQ2FnV2tr?=
 =?utf-8?B?dlpYTTFzK21tTXQvZkM3WHNXY3V2UStCRDNaT05zbk1HR2krUDFVbGpHRUpF?=
 =?utf-8?B?ZW05NXhEZlJXZllDNkh0Yld4S2JlU2JzSytDZVRKT0tuTkltZUZyZ29JSm93?=
 =?utf-8?B?a2ZqdnNwUlVFb1h6YzA2WnpEeUpQeThGTGtFbjFUdktJb1RTSDBicE9sMjU0?=
 =?utf-8?B?cWN2M1VjZkpyYzV4S0loZTE0MGt0NFozcURwNit3cWg5Rm4xZzNLVmNwRXZl?=
 =?utf-8?B?RXBzRGNSZWJWcjh2ODY0RzNZY2k1Y0QvQjNiTFNtb00xUDhhczk0eGFYMjVt?=
 =?utf-8?B?NGplL2gxWTFkYndxT2JJUEtOWSswSHRMTDA5U1NvK21ORUd4QTRIdjZCeWM1?=
 =?utf-8?B?Z3I5TTlWU1I4aVZrRVdQaFhGaGxsdFU0c3FjNjF1ejNhRDBLQWlMZ2MySSsr?=
 =?utf-8?B?RUw4R0RmeEJieEZXb2hCVnNGa0hKTHNJcm5NSUFGOWpBakNwMUFRenlEWmpS?=
 =?utf-8?B?bWhJRk9LNElncFVGdVVDY1lmMk5HRTVKU1NXLytHa2wwOVBxT2NjL1JYL0pv?=
 =?utf-8?B?STVrQlMweFpINjU2aEwvak5QZHc3MzhvY0NKc2l1R2xJU0E2WnZER29IU0Rj?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F814003680E2E4389E0F20D5EAFA845@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfab332-f9cd-4c0f-6927-08ddea664e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 21:18:47.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqDIl76Td68LQ3GKEE7eA+BNnM6HolP2Wa8pfbp21CueLx7R07qbjBuN5VcNszaczJqrpZWzgKEbwB2CefDdMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6216

T24gVHVlLCAyMDI1LTA5LTAyIGF0IDE4OjE5ICswMDAwLCBIYWlodWEgWWFuZyB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB5YW5naGhAZ21haWwuY29tLiBMZWFybiB3
aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRl
cklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiAtLS0NCj4gwqBmcy9uZnMvZmlsZWxheW91dC9maWxl
bGF5b3V0LmMgfCAxMiArKysrKysrKystLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9maWxlbGF5
b3V0L2ZpbGVsYXlvdXQuYw0KPiBiL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQuYw0KPiBp
bmRleCBkMzlhMWY1OGUxOGQuLjFjYjhmNDEzYTY2NSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2Zp
bGVsYXlvdXQvZmlsZWxheW91dC5jDQo+ICsrKyBiL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlv
dXQuYw0KPiBAQCAtNDgsNiArNDgsOCBAQCBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+IMKgTU9E
VUxFX0FVVEhPUigiRGVhbiBIaWxkZWJyYW5kIDxkaGlsZGViekB1bWljaC5lZHU+Iik7DQo+IMKg
TU9EVUxFX0RFU0NSSVBUSU9OKCJUaGUgTkZTdjQgZmlsZSBsYXlvdXQgZHJpdmVyIik7DQo+IA0K
PiArc3RhdGljIGJvb2wgZm9yY2VfbGF5b3V0Y29tbWl0ID0gZmFsc2U7DQo+ICsNCj4gwqAjZGVm
aW5lIEZJTEVMQVlPVVRfUE9MTF9SRVRSWV9NQVjCoMKgwqDCoCAoMTUqSFopDQo+IMKgc3RhdGlj
IGNvbnN0IHN0cnVjdCBwbmZzX2NvbW1pdF9vcHMgZmlsZWxheW91dF9jb21taXRfb3BzOw0KPiAN
Cj4gQEAgLTIzMywxMCArMjM1LDExIEBAIGZpbGVsYXlvdXRfc2V0X2xheW91dGNvbW1pdChzdHJ1
Y3QNCj4gbmZzX3BnaW9faGVhZGVyICpoZHIpDQo+IMKgew0KPiDCoMKgwqDCoMKgwqDCoCBsb2Zm
X3QgZW5kX29mZnMgPSAwOw0KPiANCj4gLcKgwqDCoMKgwqDCoCBpZiAoRklMRUxBWU9VVF9MU0VH
KGhkci0+bHNlZyktPmNvbW1pdF90aHJvdWdoX21kcyB8fA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaGRyLT5yZXMudmVyZi0+Y29tbWl0dGVkID09IE5GU19GSUxFX1NZTkMpDQo+ICvCoMKgwqDC
oMKgwqAgaWYgKCFmb3JjZV9sYXlvdXRjb21taXQgJiYgKEZJTEVMQVlPVVRfTFNFRyhoZHItPmxz
ZWcpLQ0KPiA+Y29tbWl0X3Rocm91Z2hfbWRzIHx8DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBo
ZHItPnJlcy52ZXJmLT5jb21taXR0ZWQgPT0gTkZTX0ZJTEVfU1lOQykpDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+IC3CoMKgwqDCoMKgwqAgaWYgKGhkci0+cmVz
LnZlcmYtPmNvbW1pdHRlZCA9PSBORlNfREFUQV9TWU5DKQ0KPiArwqDCoMKgwqDCoMKgIGlmICho
ZHItPnJlcy52ZXJmLT5jb21taXR0ZWQgPT0gTkZTX0RBVEFfU1lOQyB8fA0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKGZvcmNlX2xheW91dGNvbW1pdCAmJiBoZHItPnJlcy52ZXJmLT5jb21taXR0
ZWQgPT0NCj4gTkZTX0ZJTEVfU1lOQykpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlbmRfb2ZmcyA9IGhkci0+bWRzX29mZnNldCArIChsb2ZmX3QpaGRyLT5yZXMuY291bnQ7DQo+
IA0KPiDCoMKgwqDCoMKgwqDCoCAvKiBOb3RlOiBpZiB0aGUgd3JpdGUgaXMgdW5zdGFibGUsIGRv
bid0IHNldCBlbmRfb2ZmcyB1bnRpbA0KPiBjb21taXQgKi8NCj4gQEAgLTExNDksNSArMTE1Miw4
IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBuZnM0ZmlsZWxheW91dF9leGl0KHZvaWQpDQo+IA0KPiDC
oE1PRFVMRV9BTElBUygibmZzLWxheW91dHR5cGU0LTEiKTsNCj4gDQo+ICttb2R1bGVfcGFyYW0o
Zm9yY2VfbGF5b3V0Y29tbWl0LCBib29sLCAwNjQ0KTsNCj4gK01PRFVMRV9QQVJNX0RFU0MoZm9y
Y2VfbGF5b3V0Y29tbWl0LCAiRm9yY2UgTEFZT1VUQ09NTUlUIGFmdGVyIGRhdGENCj4gd2FzIHdy
aXR0ZW4gKGRlZmF1bHQ6IGZhbHNlKSIpOw0KPiArDQo+IMKgbW9kdWxlX2luaXQobmZzNGZpbGVs
YXlvdXRfaW5pdCk7DQo+IMKgbW9kdWxlX2V4aXQobmZzNGZpbGVsYXlvdXRfZXhpdCk7DQo+IC0t
DQo+IDIuNTEuMC44Ny5nMWZhNjg5NDhjMy5kaXJ0eQ0KPiANCg0KTkFDSy4NCg0KRmlyc3RseSwg
dGhlcmUgaXMgbm8gZG9jdW1lbnRhdGlvbiB0aGF0IHRlbGxzIGVpdGhlciBtZSBvciBhbnkNCnBu
ZnMvZmlsZXMgdXNlciB3aGVuIGl0IHdvdWxkIGJlIGRlc2lyYWJsZSB0byBzZXQgdGhpcyBmbGFn
LiBUaGVyZQ0KaXNuJ3QgZXZlbiBhIHJlZmVyZW5jZSB0byB3aGF0IHByb2JsZW0gaW4gUkZDODg4
MSBpdCBhZGRyZXNzZXMuDQoNClNlY29uZGx5LCBpdCBicmVha3MgdGhlIE5GU19GSUxFX1NZTkMg
Y2FzZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kbXlAa2VybmVsLm9yZywgdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0K

