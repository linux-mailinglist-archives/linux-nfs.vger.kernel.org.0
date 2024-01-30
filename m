Return-Path: <linux-nfs+bounces-1597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA519841DA7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 09:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125C2B23670
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659958231;
	Tue, 30 Jan 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Dc9O5VGi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C845821A
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602980; cv=fail; b=VnW+d50CFkDfpNo7x/zI+NeXujoOLTSHfmUo2jLNsSsDwRXgvFvZ9smPX0VmJ/799iomxvM4fjULwY882ibzW69hB+NFGv5c4+vtJVzeSJoAbtjUAYoW+hJqPPDHSe+B+lt6dcZc7GA7mrJaBu9U4z/Z+UOU6aYhlPDCpavhp/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602980; c=relaxed/simple;
	bh=Y9/aW+S2oRDbTz2XB+rwPzg+WcYuFun82TG199Ith9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkw+b2nvn2siV8BOV/REecpi5nL1RNniCOWMBE+5v/eiccaCBvsdu+YNikyxImo2gxjHfuJENa2lU2xKXk89JkScsN/o9CsydY6lN3Zx4eHJO5WLYBUfdQei+C8sBNitiJAiRKLH2rRJ6/5XI82SWvcj7ySUBYs+CONomKt1STI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Dc9O5VGi; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706602976; x=1738138976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y9/aW+S2oRDbTz2XB+rwPzg+WcYuFun82TG199Ith9s=;
  b=Dc9O5VGihErBtO6v6cOEShYzI4k8cIIYd7uofjLMLTTUQLQ9HERzhBdR
   AnZGZe9p6G3q5IB3sgEb1N0JVYkLlVO5/9PG6zAqXrPEPgBCK7c43iCi1
   NSa/8DJl50DnJs0H27iGq8TxJSYVYUX0nmW+bzPRtnRidg+Wv8i0UgV97
   tTycUEsuWt/SqUX/hdnTWAXOWFEB0wFYBHtS7yb+Zwj7NLSPSM98pQELM
   hun6iKXAYvaOqiv3XviSCwNQ+BJ/kzYBASd3mgXTDdsxLp2rLrvM6p+IG
   X/S3Qvjg33JqfJa8qrBD+/yCsoYf8ycA6IVD8JtfPpbcnmYke+EakQqyW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="20786448"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="20786448"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:21:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks5Wf/an8ekphBE/wsSs2dpRbHULMHbHgHYiK6AqgTTx/zPa0caMYvMrwMI3jYVHBO/zhvejYurCEqr1Fh7a0hNxFeTKJzaItqYCOMQ4hfcvsD9UlZrq7Qo840sh+BeaQgmYeHn6igY703KtdARqVQV8KAsW2TkJS0WWgAiCpXEq6TwCtgnr/mK6zQ5hpQ50QNg7zilM2lYD0+sef7wxoqVJmgi3EpaV2ORwYpy2HA5q6SoqIZYgZbwOTZ510AyDMzveM2eVB06YxZb7WmF6YaHSZ49i3voMj5jNgxQtwqDsZSnMI/3c/P4ntsuLyawaq521FsnydllWvdnA3o9xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9/aW+S2oRDbTz2XB+rwPzg+WcYuFun82TG199Ith9s=;
 b=GGd4xZwWcP7GKUw4AL8THRxF2VNgVREy7jJJoFH+8Rc+r2v+xDNqgPACPQ8rNBoHMFxVw3tbzpd+xWPYD7IpdnO9syFW8tPMht4e6Eer4IyfvIg+DoKACOe/3inX6xyI3uQyuFdVimztwjAw3f7zu1AZFxlyh5gEFB2/8n59yRIWbpGZIknu3gqdc5ok5RJo7Go2Q8E/0oK3vqt22+Ev/7OZQz6reNKt9pd7sbzFaRGExWQ2rn6cfALZtdnLqPmhYsesu4zw09Kwa8rpeaVwKszreVMOhjHOkrb997t+RaU35yXGAz4oA3Dws4f+ewXs670Z5A1quIcRaYTL+C8MUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYCPR01MB8439.jpnprd01.prod.outlook.com (2603:1096:400:159::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 08:21:41 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce%5]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 08:21:41 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
	"trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIDEvMV0gTkZTdjQuMTogYWRkIHRyYWNlcG9pbnQgdG8g?=
 =?gb2312?B?dHJ1bmtlZCBuZnM0X2V4Y2hhbmdlX2lkIGNhbGxz?=
Thread-Topic: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id
 calls
Thread-Index: AQHaUIpoYTL2Iht4z0qOA9IS/BGwjbDwkusg
Date: Tue, 30 Jan 2024 08:21:41 +0000
Message-ID:
 <TYWPR01MB120859F3CB35CAA93D3396C1BE67D2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=7202e2d4-c198-4396-a115-579a03840f75;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-01-30T08:21:14Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYCPR01MB8439:EE_
x-ms-office365-filtering-correlation-id: a6498db6-06e4-48fb-469f-08dc216c7cd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AKfCE8g6iMchL6pjsV4TeHD9L3M6d60+K2LbpZ7NWWNqESMRXVZa11ZYlF/dmiF2xvD4dvtyxs3nnw76796Kd1CibFJrimj0/qUqczSOVPKEC7CgehP8KxfNMjFr7GIQ2KQT0miz+ULhEnUZGVwezcy8e6HxfbSUHLx+HwPW3HEQxyI9x6eLIBXyi4edSsQQ/0yeO8elXqV9ooeOmuhC5xPMTakTT4NFUw+ejbPEgLOSngU3shYmdqefsZN81MhprqdlxGKc5JE7Tq2avTbuHnwzyn/1X6sEJnZ/6H9KXncUpCDKeG0arwzKYZX27r6zq3scg/IZNVv9Pytlivdijx6Svpg0ro3XDzuQfn5D8BJPfpSCRLWIYthJZmQe9lGXhK8SAc19e7qVJHO9njXbqyCGLsM7l3sk8Qt8Hl8n37q0ectwGFUFNYbXsxn6sws4/MF1GZaDxZOv+LWJ2f4e0o1/2HMVARTv8E8y0J/zhV4Mmkc7z0K48NOZ5hUSyAhyXwoDSq9m1WOa8ahoJ2Cw4T4q7/5O+7YH0x9QzEENomlMx1VSmnY7aIygAdWL2XfLdJal4zdqNZbhuMc7uFAft54XMTXJNR9bCopVmQsUd6VRNFnPShK5Hg7vt45PYczmxkc452J336jlftzVsR9cEw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(1590799021)(1800799012)(64100799003)(451199024)(186009)(1580799018)(66476007)(110136005)(64756008)(316002)(66556008)(66946007)(66446008)(76116006)(55016003)(5660300002)(122000001)(4326008)(8936002)(52536014)(71200400001)(9686003)(26005)(6506007)(7696005)(478600001)(38100700002)(86362001)(33656002)(2906002)(4744005)(82960400001)(85182001)(38070700009)(41300700001)(224303003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bXl5enBUeWVvL0o5L3djSjByWnMyWjVVcHVVbXlHaGdGejhXRTVxUFp1d1pq?=
 =?gb2312?B?V2NRaDl2Nm1PdllGSVJXanB2QTFHUmNzU1Z0ZHBTVkZGaHBxYnhZam14SnpH?=
 =?gb2312?B?M1VraGpkSzRkYTMrMGpGb1prRysxeFNzeXh0a3FaTjZqSmhBRStPU3hRcG5v?=
 =?gb2312?B?a25rQzc5MFNYeVNHZmZoM3hKVm5HNVE4V0FTM09BUU92aVE1RUN6c0N2Q0Yx?=
 =?gb2312?B?NUUwMWZRRWN3RFBid0FnVnZLN0VXR0lSaUFERUxOOW14Q29vbjJWNTBGdlNF?=
 =?gb2312?B?Z0pmRmx4cFFjdnRSY2RlMXVTNThsWmdDb2xRbUVmakRmR1Qvd3dtNkhZNUV0?=
 =?gb2312?B?bmJlQm1zYTExM3pzUGVkQThmd2JESjRZYWVpTnozNzk4YW51WHJYSDV4MmlT?=
 =?gb2312?B?RlpkQ2JDeDNvY3NtQ0RKRmlMTStqVy96Q0EvTy9lSHJWYU5PMEJXWElJOFBE?=
 =?gb2312?B?TTh3MjdJZExKdS9UcmJwQ1lOeHROSGFJamtvOWIrT2YyRmlDRzM5REhqZE1P?=
 =?gb2312?B?alRLUyttY01VWENud2V4enE0QXE4R3YxZ3MzSVdhd2pkaTlqV2FpeFF6ZjUy?=
 =?gb2312?B?c1c4azcxL2ZnTnpxdWNybUUyWnV2eTVpNkovYlQ1aEJ2SnNkei82KzZXaktU?=
 =?gb2312?B?M2FBRTY1ZlF0QnB0L1ZRUW9DNmN4bkJyQnNKRlMveEo0SXgwRG41SS95U3lH?=
 =?gb2312?B?cmFEK2dJL0ZXWVpubzlDdW9GMjBLeUZqajNjU2drL0ZaelRHTnFMaWxzRVMy?=
 =?gb2312?B?dTNESGswcUp5UmVxRDZmM215cEdsM05sREI5ZWdGellxRlhpN0YrSzR6QThp?=
 =?gb2312?B?cndKRVNhVTR2Tk93L1pLV3ZoVndGOUtUaWNxZm9FOWp6RDV0VU4rOWNyNi91?=
 =?gb2312?B?bFlyQ1lHbVZpQ0kwcW91dnAwR2UzVURlNUN3M3J6MktSSmhrVlRuYW1nQVlw?=
 =?gb2312?B?ODNXbHNxQ1ZvUGZDYXhNVmtWdmN1eGlTck1JcEs2LytxKy9OVUc1aXhJc1ZP?=
 =?gb2312?B?c1JQQUp3SW05b3BpUEswT2JETjFDTlROcE1rZjQwRmFraFZDVjdhNUtkVnN6?=
 =?gb2312?B?VWdyWWNsbHNteDEybDhYbW03am5kVGJGME85WUNOWldLVG1YNUZJSms2Zi9H?=
 =?gb2312?B?eVpWTDE0cHdMTkZOOHVBU2RPMHFTTDFnUEVGWVFQNG1DcHlLOFZwMitKc2FJ?=
 =?gb2312?B?NklHWXRja1V6TFQ0TWdZbDlXODlQSTY2bFJDbG9PSWN4QkpsTkQ5RFZwSE9D?=
 =?gb2312?B?ZFQvYThUSUFScnlhcEpob2tCY1N5aUUwK3kwK0tSU1BEYXErRzBrMHE5dmdu?=
 =?gb2312?B?b2JVME5xQVo2aDlLc2ppQXZxVEwyeGNyTEp6d1M5cUxPUzRrTzhrOUpXZVBT?=
 =?gb2312?B?anpkZXFKTXFWdWZ0YVBRNGdxRFlXMCtqRVowNmg4d0JFWk5kZXE1bDc0aktU?=
 =?gb2312?B?bmJ3S0lBZnRGWGpiZGcrb2NuMVdRa0c0MVB0RFZXSnNyTlNrV3Z2Z0lZZWk3?=
 =?gb2312?B?NHlFUnlXU2NNOVNKNXRSWk4xdmFQRWJHdytTcmV6MCtjS0hXa0pTekU3LzBn?=
 =?gb2312?B?ak05a2tyMXlvNGxZcWQrRk5zb3E1NHBiOHY2c1FFRkJ6N3BBbDJDOU9oTGFn?=
 =?gb2312?B?SjNNYjJ0SXFnT3RZWTI0eWIzd3pKczVjQjF4MmVjYUFneEhhd1c5UU5uYmhq?=
 =?gb2312?B?TjBnRkdDL1IycUI2c1pvMVZxMnBMdGczZHNKbUxHTGN6MUpjNVhkV1l1Nndo?=
 =?gb2312?B?WDNoOG51OVgvNVNSM2hHMk5iYnk3Z0J0VlJ2ZVRpSFV5MGk0dTJOb1hSS1E3?=
 =?gb2312?B?ZVhwS3hONVVmVU9yTlJoRk1nN29FVGVUWjE0RERrVEZlQVFxeW9jR2VhNzdz?=
 =?gb2312?B?YjhEeUZZV01QNVhMWVozeXpvQnA2eTNIKzBZa3I1WHYyNHZaR0J6eDkyS1lT?=
 =?gb2312?B?MmJxVXdvZFhaTTQ5Q2YrUnRhbE1takVQZ3dmUWh0V2s5cmZoczRhMENxWFBH?=
 =?gb2312?B?UFJCK2VWWnB4dlVsTnZlZWtoQkZ5cjE3aGJRTjFkZUp4R1F6cFNwQ2hzTlVk?=
 =?gb2312?B?ZGpheFpmZlZ6NXVWRmdraVYrSmtYK2laWXVqTTdmd3p1eFNsQnYrK3I5dVVo?=
 =?gb2312?Q?CAFLoLQmG/ZtwtrteP2iaMwlL?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yJoWjDjd/v0hj9aK+Ak4Fxh32odKqAcNVSeO7OM5yITENqeG1AHZxhXjOXKmEeTfdlNpOdwVhlNlU/LbI42H80FHP1bLe7o43B7YJAEvLzaK9mBPs4NV9fTOmzdVrAvnnFJwIoBfhEwym3L766E4e7ic+1AJ+A8RI4fZkJyLFO8tJZJnA8brrZ0F42wcW5PXgTfQCuzZ67egnDrOrFm87V/zi/BW0YH8MECXGMufL7J6ArDQvaB52430vju4alkUDNcyVfCVku0h60/Q8g0vAhWJ2hKcf4hqOF3KuLtW55nVH5AD+CiNJtS/8V8UpAQOyu3Cs0gpR0cXUa3GJLTvJw4OHYHRWKRU7K2MEVtY1h/RAXivgp9aCA6u4tyXDFU3Wq6BJwtMAsnBnPERQhItqhIjUlEFCort7nRtI7bwokwinFYWALxF9O7ujvCkx7kaUe8eAl1E3Qw7SBD3zXJIGaBuJX3tpE1qHhxL8R4Kexedp8TAvV3BiosxAC8I9Oz1gBbqHspMxvOtSUVG0MzwfdWjHqSrbteWQo7oD/++pdYY2AJJ4i2FdoH53Dvl2BrypNYhViWUZ9Jkfx/2PV+kciJH/IgCMtCXhzI6z+4xJ+m3TFy8YskOP8n8SolKvdqa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6498db6-06e4-48fb-469f-08dc216c7cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:21:41.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6halIjkEUg1ARCvCXb+KMaCchbbHIofh9rv0EFGPTidoRe7YbNczYCs/cZJ/ZeSocXdcovMRQLV0TS96hve6jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8439

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogT2xnYSBLb3JuaWV2c2thaWEgPG9s
Z2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjTE6jHUwjI3yNUgMzow
NA0KPiDK1bz+yMs6IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb207IGFubmEuc2NodW1h
a2VyQG5ldGFwcC5jb20NCj4gs63LzTogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiDW98zi
OiBbUEFUQ0ggMS8xXSBORlN2NC4xOiBhZGQgdHJhY2Vwb2ludCB0byB0cnVua2VkIG5mczRfZXhj
aGFuZ2VfaWQgY2FsbHMNCj4gDQo+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRh
cHAuY29tPg0KPiANCj4gQWRkIGEgdHJhY2Vwb2ludCB0byB0cmFjayB3aGVuIHRoZSBjbGllbnQg
c2VuZHMgRVhDSEFOR0VfSUQgdG8gdGVzdCBhIG5ldw0KPiB0cmFuc3BvcnQgZm9yIHNlc3Npb24g
dHJ1bmtpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FA
bmV0YXBwLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHByb2MuYyAgfCAgMyArKysNCj4gIGZz
L25mcy9uZnM0dHJhY2UuaCB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+IA0KDQpUZXN0ZWQtYnk6IENoZW4g
SGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQoNClJlZ2FyZHMsDQotIENoZW4NCg==

