Return-Path: <linux-nfs+bounces-4072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670690EFA0
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 16:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E461C20C25
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2771D1DDD1;
	Wed, 19 Jun 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gKS8SjvW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FE7CF3E
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805761; cv=fail; b=ZNGX7nzByheomyKly8F7Zf+6hZgu5EjBEDI1Ust4qP/mSBAbfsjGqyg8ZSVcqyJUZT6OhvNzSCRKxS/cP4B01q0Ct4nRPzraa+/IseNu/p747LHjlrBXgl8twvpG0denDKkKra7yv3W6AVLBc+kH9CJ1OwSKnNTNvATEt6Xa1lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805761; c=relaxed/simple;
	bh=yrm6fZJq37eRE8Tm1hbMmkhvSJejJ5selqWKWneAxDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UZSMqCup/tSaWOg0SHh3fyDilaOLoKyaK7HETtFORlX/f2I7Q9Y7Mqz2ggu+xqo55eGI9cpMFYD7y/9FT6BBhAqtdZrWzgyJRM6/6jaBC/eh+ljpzOXicO+HvqWEOeUBq08mF5oFMynrtuMtHF8KoNSMJwVMOKvHbysUzAhT1UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=gKS8SjvW; arc=fail smtp.client-ip=40.107.223.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia+NZV2B15LS8C7q0bBRHCsuAnteigQT+S2WlyimDmIjR+yP9+EKOSiSQp5D3oyT0X9G8Qyz2nu4SopzATmh5+bODB2bN4yWQrxvaRZa1ZbRqAPu9O7Sb12JcHqVOBceR06qkk8YX8J71QRGRxqw7YZekC6XMP3R0CpFEI+TilwAKOf3eceGoFe/f/8WHpaw7j/E7d7r2TCF+IFgCVVD5P3/zq2LLgzIEVmZUdG2e1YeqquZ51Gcy57/lxAq0X88Tao6NxY1jiAPQSNZqVJpv46E4dtx6Uem0aTRdgWp5CU+bncB7lJB7OVGQwHApwsqm+aVoA9skKihmXWJBYhGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrm6fZJq37eRE8Tm1hbMmkhvSJejJ5selqWKWneAxDU=;
 b=li/ejamGTixoB8N25emtGZ+5Ri4wfA5f0fnhnS7Ompz0WSK0wyNo6D3Z1bwBvMhkX/axMPm3QIxcn91Ytw994BiGpm9L5R4xMbz1JFZwnoIQ3/maVlXyWAiSpUH8up9pFWQx29+9J92juCqcG1N7SmDyW0V3u/VA1JViEbxW8asNUHvxLe7+2Gseo7x2n/Hl9r9sW2Xdil8jgZxZTGUnpoeC3VENUh5HeQvL3MAG6IcfPneey4bESGqfja2gc7B5vn1En7letvkdSsDlcdyhICns+m6olgJHnlCjQNr80tlYuiQudTSfcPve+MhaX9wGa5EMCFwlh41gu8pFisFP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrm6fZJq37eRE8Tm1hbMmkhvSJejJ5selqWKWneAxDU=;
 b=gKS8SjvWoT5zrXDu8fMSMv9Wt19pqv6e75/rP77wv8t2IktcqNJmIaWjre8uZp4oouApR8SgQy1FV75B0W+zQVqQ37g40++jbB2qDS0FwcIt3vxIO+sXfZInlq6mc3TT5IpM2nw7UCFo3i1Y01xjHz1IanqKmFFF0+6ugJrCu5w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB6599.namprd13.prod.outlook.com (2603:10b6:a03:4ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 14:02:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 14:02:36 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "snitzer@kernel.org" <snitzer@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>
CC: Mike Snitzer <snitzer@hammerspace.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"neilb@suse.de" <neilb@suse.de>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v5 00/19] nfs/nfsd: add support for localio
Thread-Index: AQHawbzjy87j4PZbxUe/QlIG3LuuB7HOlUwAgACJ5oA=
Date: Wed, 19 Jun 2024 14:02:36 +0000
Message-ID: <6bedd68e75e9ae8046bd66a3e5945305e18e058f.camel@hammerspace.com>
References: <20240618201949.81977-1-snitzer@kernel.org>
	 <ZnJxTsUuAkenmvWP@infradead.org>
In-Reply-To: <ZnJxTsUuAkenmvWP@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB6599:EE_
x-ms-office365-filtering-correlation-id: 8dd93516-6304-4a98-9e23-08dc90687926
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?MG04QzBzSFprYjBJSlY3VlRJZDY4cVlIbVhyOGc2WUVVM2dhNGQyRFRGZlhv?=
 =?utf-8?B?YVk2L1dkMVhSNnZFL0h1K0ZUZC9taUg0UFRBS3hDangyUmpOUVVOYTd6dGM0?=
 =?utf-8?B?M2ZlU1F0dy9pRU81YnVtejZJM0w1MWo2Ym1UQmtwVWZpVlFwNjNLT0VKT3Nv?=
 =?utf-8?B?TWcyNmxoOVh3ZHdMa3dBNks5aEZXNmZoVzNueExXWXlVUFAxSE5Sa2IwdWxN?=
 =?utf-8?B?TjJiUHF5WE93WVBQWU5ON203bnJDVkZ3ZlR0Tnk2YW15TlRzQTFLdWVuZEo2?=
 =?utf-8?B?MWlOZnlndVZ4UHN5d3RKaUllYXEwcEVyT2RqR3BBWncvWGJOY1FuaUZtSzl4?=
 =?utf-8?B?d2x5V2xxTFBlcS9aTTc4OXdxaVNRSnVab2M2WkJTVmd2bHhRK016MjJoa2hN?=
 =?utf-8?B?YmRmT0d3WGtja2JiMVhvRTJWN1g3NG0vM3gxeTZKQlNkRGc2cUxsUjdSNmU0?=
 =?utf-8?B?eDZ4c29yNDBEOEsvdTJENnRtM0VzSDdIajVJQTRKVUc1TXpFZTdaS001a0hj?=
 =?utf-8?B?TTBOMDQyNkFOQUdZaCtIUEpxQ1R4cGh6QWlJU0svNm44Nmh5MEFMQ3BhU2ZZ?=
 =?utf-8?B?NDkyTnJwVExIVWNlWUNZTEQxVmVhUW91VXB0YmdUTFI1YzN4RnZBVktqQ1hN?=
 =?utf-8?B?ZWJEQWtwNElqWW4vOUxsQWRNcm13NnJ2Um0vLzhPanlVa2ZpNnhyQ0wrL1ZU?=
 =?utf-8?B?VXVqTXRxUW9iMjJKSzAvZjRQbUl6eWszVm15SVpFUFk3bUtmNDFicnpPV3d6?=
 =?utf-8?B?ZndGTXIrN0hNL2MzcnhadGRNWHpudjhCNXhCc3FKOW1KNkZrb1h3eXM2UXE3?=
 =?utf-8?B?djQzZFo2UlA1MlhYdllUL2Rhb1FqcXZiakpqeEZKbk5JREdldmFab1RPV0kx?=
 =?utf-8?B?TWt3NGoreCtFYWdtWUdJei9NdEJRNG1VbWNCejBUWXN1ZUVtSGxUUXIwVjU5?=
 =?utf-8?B?WnRBZkNkREJvcm1tWEhtTUJZWVovQ3BSSkZXb1JJMy9sNEJSdGdGUC93SVhn?=
 =?utf-8?B?YkhONzdzM0hzQmo2a3ZRVUZXeWxXOFd2dVIwRk5VYW5WUGZDTWhlK1M3S2Rm?=
 =?utf-8?B?Wm0xNm05VkNZem9zSHNGbjVyTm0yc2wyTjk2S2gvZWxzRzJ0OWdiVXRGTGNp?=
 =?utf-8?B?NlJmVCtzWDYvQ2IycURnUjd2VWN1Z1kvZXpUdzdJYW9JTHJ2R2RmSjlBTkRH?=
 =?utf-8?B?bWpaRUYvSit4UEdFc0t6Snl1aWFYNmtwVmVWYjNWVHJseG5ORUthY1M4dGxD?=
 =?utf-8?B?ZURMZ0syeUdXZFFMRWRReEFrNURIbnhyaHgwcEpKSXp0cjV1c0MyUXRLMGJV?=
 =?utf-8?B?MWVrdXdUTnVja1hrY2RnNUc3blA0aUdQNVlkaWhOZXRFZFBFY2dUclRZM0wz?=
 =?utf-8?B?djJrNzlJVGc2NmQzVUE4VWdPbm8xN1F0akp3a2x1NnpWYytYTU9iVlo0K0J3?=
 =?utf-8?B?ODd1eldPeVNoWE03NVR4QzE2dm5jQnhFbTcvQ3FyU3VweUpSMnROZUdpNVFI?=
 =?utf-8?B?ZmloVlBiWDhHNGlYUU5GTmNic29UaURHR3U3c2RjQmUvQStHUG5vQnI3ZVkx?=
 =?utf-8?B?Vk5obUNQOUhHaFVtL085NEZPWThMKzEreDhmRWt0TzlvTExWSHpFeWNITjNC?=
 =?utf-8?B?RzlsRGczMUdFR0hlUytMaWpQMDBha3VFakovYmdtZTNTTmoyMUhuZW9pWWRG?=
 =?utf-8?B?MGRHbm9ZMEhSaXQwL1pEWlV3bUJaV3Z3SW1Nb2NGVzVzL0pmUmVoZ2FQWkFB?=
 =?utf-8?B?QW1EamFsTnp2TXZ5Q2VDMlhTTStuaS82NTJBeklrNnVhMXAybXFoOVo1MWEz?=
 =?utf-8?Q?FehHPfR16E9eNkBre8lW+O9MibciguwOlxdtU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3M4QnlQSmdqT3lobWphVDB0RlIxbmZyUXI2UmpSWVozZ1FUVXA4QjFEdDJG?=
 =?utf-8?B?cmNwWUd2Qzl1M2ZZTDFTM0ZSSXlLUExlZ3p1YnY5aTN5THROKzB3NG5Cay9O?=
 =?utf-8?B?L2o1TkIvRG00WVN1OVlqQkJoY0NqZUQrUktqeFp4ZU5XV01RZFJKME1GUFh5?=
 =?utf-8?B?NklFMUl3TXRLSXN6V000VE9FN0ZaeEJUS3NGbHZTcjh1MjVVMVVHdWwvSDVD?=
 =?utf-8?B?MDY1TkEvcnBoUm1VUHhMd1IrY0tvUTd3dVpIWXg5alAvOEV2SVlEZlZwQmRQ?=
 =?utf-8?B?Z29paWQvWkZxVExYbkpPOWpjWGFEQ01HdWxSOTFRNDN2a2w1d21WWThYYUg5?=
 =?utf-8?B?MXVkWkVDc1lsc3VzdmhUWjJCY1ZYQ1J2VFJCWkZ3a1ppTGlGcjZtNzBETFM1?=
 =?utf-8?B?aTg5OUplVWk4SjFTNlhZczBXOGhjZkhCRCtDcnZ0TmM2S2RsOXNDWGJ3dlNJ?=
 =?utf-8?B?U0hUY0J0czdMa3pPL1hKY0pJQk05VE5QQis5Q0Z5UHI4T2VEN2lNNlAyYjla?=
 =?utf-8?B?Q3E1ZkluYkF6bElmQS9Mc1QycUpDVVFqVkFjUVJlNDRuRW9PTU1mNGtHYWtx?=
 =?utf-8?B?MGtraTZrQWl2amp6WWp5eFNSd2RMMnAvam1pSm5abVBodnRVQVF6QzQ5T2Nn?=
 =?utf-8?B?R25BTzlYTXJCMTV2LzlWWFJsRWhKdjc3T0lyQmhZLy9ldTBHNEViMEljbjNZ?=
 =?utf-8?B?TXQ3VWYyclQ5Ui84ckNZTzBmby80bVZCbmhVb0hNTkxiWXRvSzNkbU1CTTVX?=
 =?utf-8?B?cVE5MmhKZGhUNGNITzNkYlJZOXZ3SVJXa0RXbFNnVXFjZmtYTWE1eEN4eEJs?=
 =?utf-8?B?MUpkeUIvYzA3M256QldpYWxWMzhRRUtFU3BkbWlKblowVHFOWHBKYTUySkxD?=
 =?utf-8?B?U1hJMVp0Rk9FWFNwblFBSUdOVThUNGd0V3l0S0U5MHJJUGJPaWFwV21IVDJz?=
 =?utf-8?B?dnFHMWRFelBIVVNRTksrdzRrQWcyQmI5NjV5V2pDbU5qMTY3Rm9uRk5xSGJa?=
 =?utf-8?B?ZkFwZXppalhaQ2xKNTIwMWl2eFRxNU8xd0NxMnpCM0R3L0JZV3dySkE2NDJ4?=
 =?utf-8?B?cHd5aVBNdG04M3pBUWtwUlNyUGZsNVdNa0pqMHYzYkc3ampLMG42M2haOWZI?=
 =?utf-8?B?eXBUMDlXMjBOWWR3NjNydFMvYTV5MXRyMGRiMUtmbWZNM0MrejVJTEo1OXRT?=
 =?utf-8?B?VXVJRmprMHFtdHlXZmxYWHNPZ052OFVUYm1kOGtsNlUwcVhldEJKeFhUOXBv?=
 =?utf-8?B?MkF4NEQ2Qmo5b09iNVBHOWV2QTZ2M1g5Qzh2azBDbEZXalUvbkF5alpkZnk1?=
 =?utf-8?B?eVZpcGdmRUxBSENBZ1Z5aWRZVXFZTFVXdGFYQ0tEM0l1clE3d1lsSk9XcHI4?=
 =?utf-8?B?R2pnZGtiWkRWcFlIR3hHRllRc2JiMU91NzBQc0taaWQvN2xyMExzcC94MmNX?=
 =?utf-8?B?TzdjTFVwWFB6NGFLcUUxVFVlNFkwWStpblpUOWp4bWtOM0pjY0pTb2tNNXBl?=
 =?utf-8?B?YStUMmRHN1RXOVZtQnV6aDQzaTFVTVZWOEh0VUsvQ1RpNWhxSmVoSDMwYnAv?=
 =?utf-8?B?bStRSi9SM01Wai9sMnJFSjQvR25aYTJIL1JFQmtOTUlQNDZQcUFvRUpOZVl4?=
 =?utf-8?B?czk3MFpLcUNuQ0FSb09SODVXSWZCa05mNDN3bHFUQ3FPNm14QlZ5L3hlMlNL?=
 =?utf-8?B?a0U4QUVHelhQQTlYdG1qRjZxejhhQlQzT1ZISEhWNXRWT1ZIem94cTV3bm56?=
 =?utf-8?B?TDhhK2NaUlRsVEJFdFcvZDNTUkUrV0ZhVXV6TGYzT2xGVlJaOTlCOVNuTEZZ?=
 =?utf-8?B?Vzg1ZjUxRzJVM3Z1czNGSlI3eDUzY2puZ2h3UTdzbFQ1Tkp4RVlBVXJVd3hO?=
 =?utf-8?B?dTZIektHc1R2SElIM0RiNWgwQ3hVRy81UzhZM0ZaMC9TRVNMK0dicEh4Y3kx?=
 =?utf-8?B?UlhjNnVGSDZqM3JOK0hxQW1tbUVESjdiZ2x4cy9DUzhGR0VJS1hNdmgrTVh2?=
 =?utf-8?B?bUJjajljTjhNY2FTREtDWTdvYVYyWTJzcnU4cVlrU2JNa3R0eGtHaC9kYlFP?=
 =?utf-8?B?cGlpaW9uMWMvRGRFbEphRzlrZSs0bS81SkRuc0xWMWZodWVTcGNMQVJYRnFx?=
 =?utf-8?B?UVVMUGpHM2RoTGxpWDdBSzNTODQwZ3Y2Z3VTc2VVRmE2N1NZM3VOSHV1aUUz?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF4510449330EE43A7214A0B478EE6B0@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd93516-6304-4a98-9e23-08dc90687926
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:02:36.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDM6kHB4IqIS5kKeHMMBo47dUNCZpDDxyFtgiiVxkOohtzNVeleRgZzHti4aE310CGzvLb6g1HYZezCI6lhgPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6599

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDIyOjQ5IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gV2hhdCBoYXBwZW5lZCB0byB0aGUgcmVxdWlyZW1lbnQgdGhhdCBhbGwgcHJvdG9jb2wg
ZXh0ZW5zaW9ucyBhZGRlZA0KPiB0byBMaW51eCBuZWVkIHRvIGJlIHN0YW5kYXJkaXplZCBpbiBJ
RVRGIFJGQ3M/DQo+IA0KDQpUaGUgcG9pbnQgb2YgdGhlIHNpZGUgYmFuZCBwcm90b2NvbCBoZXJl
IGlzIGxpdGVyYWxseSBqdXN0IHRvIGRpc2NvdmVyDQppZiB0aGUgc2VydmVyIG9uIHRoZSBvdGhl
ciBlbmQgb2YgdGhlIGNvbm5lY3Rpb24gaXMgbWUsIG15c2VsZiBhbmQgSS4NCklPVzogZGlkIHRo
ZSBJUCArIHBvcnQgdGhhdCB3YXMgdXNlZCB0byBzZXQgdXAgYSBjb25uZWN0aW9uIGVuZCB1cCwN
CnRocm91Z2ggdGhlIG1hZ2ljIG9mIHJvdXRpbmcsIGNvbm5lY3RpbmcgdG8gYSBrbmZzZCBzZXJ2
aWNlIHRoYXQgaXMNCnJ1bm5pbmcgb24gdGhlIHNhbWUgbWFjaGluZSBhcyB0aGUgY2xpZW50Lg0K
DQpUaGUgb25seSByZXF1aXJlbWVudCBmb3IgaW50ZXJvcGVyYWJpbGl0eSB3aXRoIG90aGVyIHNl
cnZlcnMgaXMgdGhhdCB3ZQ0KZG9uJ3QgYnJlYWsgdGhlbSB3aGVuIHByb2JpbmcuIEhlbmNlIHRo
ZSBzaWRlIGJhbmQgcHJvdG9jb2wsIHdoaWNoIHVzZXMNCnRoZSBmYWN0IHRoYXQgaXQgaXMgYW4g
UlBDIHByb2dyYW0gd2l0aCBhIHZhbHVlIHRoYXQgd2lsbCBiZSBpZ25vcmVkIGJ5DQphbGwgb3Ro
ZXIgc2VydmVycyBleGNlcHQgdGhlIExpbnV4IHNlcnZlcnMgdGhhdCBpbXBsZW1lbnQgaXQuDQpP
dGhlcndpc2UsIHRoZSBwcm90b2NvbCBpcyBwcml2YXRlIHRvIHRoZSBMaW51eCBjbGllbnQgYW5k
IGtuZnNkLg0KDQpTbywgaWYgdGhlIGNvbnNlbnN1cyBpcyB0aGF0IHRoaXMgc3RpbGwgbmVlZHMg
dG8gZ28gdGhyb3VnaCB0aGUgSUVURiwNCnRoZW4gZmluZSwgd2UgY2FuIGRvIHRoYXQsIGFuZCBy
ZWdpc3RlciB0aGUgc2lkZSBiYW5kIHByb2dyYW0gbmFtZSB3aXRoDQpJQU5BLg0KDQpJZiB0aGVy
ZSBpcyBhIGJldHRlciB3YXkgdG8gZGV0ZXJtaW5lIHRoYXQgd2UncmUgdGFsa2luZyB0byBvdXIg
b3duDQpzZXJ2ZXIgKHdoaWNoIG1heSBiZSBydW5uaW5nIGluIGEgY29udGFpbmVyIHdpdGggaXRz
IG93biBuZXR3b3JrDQpuYW1lc3BhY2UpIHRoZW4gSSdtIGFsbCBlYXJzLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

