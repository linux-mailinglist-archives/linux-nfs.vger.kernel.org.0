Return-Path: <linux-nfs+bounces-4955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4157C932E60
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532251C21CB4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46C619AA61;
	Tue, 16 Jul 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bx6vSwCT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2123.outbound.protection.outlook.com [40.107.236.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330919A86A
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147569; cv=fail; b=VR9KZEx2t6qKl1VdgaEdtSB2VFbi0TY9cDsGR/GnAlMvYkpRvN4yknDFWjqAczbOYeQtVkL4XqJ3H2nR5NCZjF7onyQrN29xRPxvolfMa8cEU5cIaahLyYUkjZE/ZlkRsylB+PqWIvTpelmmeg2r8JuRLXQmgT9FywDdgUEmW9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147569; c=relaxed/simple;
	bh=O5Wyg7Gcrvg45kVVIvFtoRC88oDRrh15zONJZImUw2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3v+bgqT7pAyyhdE2jFs5dzwPaJIhTwQdX+02wea4KNU6fDQcURQe4LN/sAcFXdRgAzt1Tn3PLq/17YDvX3DWIiwNUt7QhuHDOoUHWxcaOySP3cngys14ayo/PnhpURx4MdIHbt776hLFFJr1oEf9YmYzSY0g9qix7hUOO0gMUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bx6vSwCT; arc=fail smtp.client-ip=40.107.236.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFiwbImtPVZ1pnS4waK7Q1vyWfhLGL/vrenhhGTRu8bQBHYcoYavEn60ssyWWDKcGyp++A4FeC0HalvrqmAN+uJ5j6amC1/xvBl2ReM+s3N3S1DayFyvvDmh9JSuNSOFiMbVpQGZovmyQHmPf6hb0Am0EEDsEx4ydYWV4fTXbvyABm+JP6Qm6YpdCXo3VXsribyoIZO+RE1yQlu7HBHy40+3F8OS/25OF7zt03/fmXH02fpz2j2Slc6vzjQz+QSMzbt8pOlQfTibDth3JXSqV626vIH7I1oUwfx/ZJGtFKeDB67OGcAbJbtOR4qzsw6pqYrvPy+vipEXM6zjdW09RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5Wyg7Gcrvg45kVVIvFtoRC88oDRrh15zONJZImUw2M=;
 b=Y9+oBZivXjL6nnyYF7sVGUCKXBD6zUvde6kw/YlSZn773IxYdhCq/a5TeR7K4nn4Um2vNvarlYbuydtgxzTwwzMlsUNCQMvLkf/S6PduC0/DIlQ1ghpUk7FlbEq6CjzjjzisXdtOIqVa7Pl/T8oo7FbOykLRcauOuL4eVjKDDfFV+m/umMyIrYKDvsrFML9N4Vt8ekjphGBYxH8ln9BHkXfwHIDw+mDNI6NUU7jM2kojP0gjo8vlJSp/5l9Odm8OSdTmCWpZvAcMv/Gplt3lBsVIyOTDPssIjqczzEqSEEfTHq0G9BhbwUyDGFNCZltNzk5ycqE25EFV/IvgprUD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5Wyg7Gcrvg45kVVIvFtoRC88oDRrh15zONJZImUw2M=;
 b=bx6vSwCT4AtHrrXD/FvZbjD/F4mtolbUzZe1ERDXjbxJv6mbGL1JVnKEzkNB9hcpKfcJXG51nFOsLQswooDyR4foXLwedCESTJpdftXHmWJujy6H+Lgpvs/1A5bTuGf3eQdAwxw/ErZD/PrG6k7LW1QKxbE4+ud/3VQjLVe0clM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5444.namprd13.prod.outlook.com (2603:10b6:806:233::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 16:32:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7784.015; Tue, 16 Jul 2024
 16:32:42 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "bcodding@redhat.com" <bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Thread-Topic: [PATCH] SUNRPC: Fix a race to wake a sync task
Thread-Index: AQHa1GMoMJaBbWI/xkiq3cOP8YqYiLH5XdyAgAAGB4CAAA6gAIAAGQ2AgAAHN4A=
Date: Tue, 16 Jul 2024 16:32:42 +0000
Message-ID: <ec46c3fd5521611241a6da493e22f2676d4d134a.camel@hammerspace.com>
References:
 <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
	 <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
	 <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
	 <b8b9fa14bce200fc65545b4c380ece3275e13677.camel@hammerspace.com>
	 <58D7782A-5CA2-4D2E-9817-28878EAECF02@redhat.com>
In-Reply-To: <58D7782A-5CA2-4D2E-9817-28878EAECF02@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5444:EE_
x-ms-office365-filtering-correlation-id: 2f9ff532-794d-4164-93f5-08dca5b4ea74
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTR0amgzWTNqaXkrbDgzUVNTcWUxSFVMb1FRakxGMTBoMFJCdWlrbkVXVXZL?=
 =?utf-8?B?b212akltZ3JHQUdkaGpiRUtEOE4rU1dPMUk5NXQwOUZ4VVFsYmlRTERaVVdw?=
 =?utf-8?B?UEw3SHVrZ2c3MENyR1NwNnRqdi9LNmo3RWJpZEFvZkt5MjFtVkMwVlJCTXht?=
 =?utf-8?B?bitGYU5pQWkvZm5wOG9Kblovc3laSFErSmY4cHZHWTdzb3RFd1VIbktOY0h3?=
 =?utf-8?B?SGp5eTVBUm9uZGJCWEFoMXd3N2UxVEFRYVV1dGh3NjQzeHFCV01SUVkwbTRv?=
 =?utf-8?B?SVlFeklDKy82MHBoR0hSamplVGJ2d3BWNFpyQThtZ2wvNjRxUGllZG1rY0pK?=
 =?utf-8?B?Wk5sYkJadmhvKzk1UUpxWnMyTzN0MjB1QUVSdEU1TXlNY1gyM25rRnl6QzBH?=
 =?utf-8?B?TVZkK3p3TWhkclBmTVB3WGpoSHY0S1BFcVIvL0FycmtKUWRWZlpvVFNvQXpT?=
 =?utf-8?B?S2k3U25aMUQxV0c4N3NXL3FLaHI3bVlXdVg5MHpSNW0yaW1Eb0pLenllOGRH?=
 =?utf-8?B?RnJ5SDNCRG5GcXplbFpFQjd1eUVCenZLUGJtSWJYM0NQVzEvaDJjU3dqOXBp?=
 =?utf-8?B?czNGbWVnbkV2RHpVdExDUUQyVm9LQkhucW5MQkNTWGNLS3ZROTNLRGV5Wk1J?=
 =?utf-8?B?OUg2c1FKbHprWGNLaDNKbjJXUFQ5a3E2Z3FObmh2TUZ1ekdveFV3U3BRMUlp?=
 =?utf-8?B?TmZGYmRBYit5RFMwb3RGcDI5VEtCN2w0aHo4VzY4OFUwYk9iZlpuM2d2SGQ4?=
 =?utf-8?B?dFRKQ3hoOW9NTGw0dTZyYTI1d2VwVHJxQm9RKzdpSWl5UGJSQjR6WW1jSDcz?=
 =?utf-8?B?amExTW50elhNSlNKK1g2NFVPalRSaEc4OUtuUW85NjJpTHFUZGY1TEN0WjJZ?=
 =?utf-8?B?QmY0L2N2N0Z3eWVZbTBKTXJBU0IvTjNCNlNMamN2S1QySlhLNlhPL3VUQzR0?=
 =?utf-8?B?dkQ1N0taVDJnQTJuZkQ1R3BlQWV2b3ZIMzBacTgwc1o0dkp4QUF2dWhuUmNH?=
 =?utf-8?B?UVg5RlVtVS9GVHZSNWVjQUJOOXo4eXhjSUdlZmc3eWQrclo5czFtZFpicG5o?=
 =?utf-8?B?aWJYTHdGVGZ4T1lWdFRIdk4zdVUxODNHY1FGVjlSNEtFNld0cVk4ZFdjdmxH?=
 =?utf-8?B?ODFJbEQzbTVnUzhYbUJzM082Tloyck44S2ZIeEJQYnh0dUh4NTZheHBrRWdm?=
 =?utf-8?B?NUU0ZTFBU21KR0NaU1o3RmZXUGc2dlg1NVo3T1VjK0JFb0FKeEdxa1VSVkh3?=
 =?utf-8?B?ZWEvT3FMRERzZFQ0czQxdTZ6VE92akxnV1ZtaHFVNTQ5TWs5U1RGQUw3cSsv?=
 =?utf-8?B?WGhmTkJVYWVuLy9KdFMvQUhUNm9GNWRGQW9ZTnV6VEZPSkkvSDd3L3BiaUdT?=
 =?utf-8?B?ZHl6WWpQMk1WK0F5TThuTnErVGdMSk8rZ3EyRE4xa3czWDFVM2psYk05Ry9z?=
 =?utf-8?B?WU4vc1p3bEtGSTJiVEs5UFphbk5jTW5PMkVuZHk0WWNzU0Q0SHJNWDcxclgv?=
 =?utf-8?B?UW9IUDZ4cjlIK3JZV1VKV2V1RExpalpDdU1tVVNjSmR6SXVtUEdwbENxbGYr?=
 =?utf-8?B?NTZZbjIvUW1KNXBtdno2NlM2MXdKNTZjNHZVZm00WFlOWVFrQUl5aVE5Vytw?=
 =?utf-8?B?eDkrMGNKWnc2ckEvQStrQWlNTFlxeUhlcVQwQ1VkeXhuYWVYUzJmL1BNcXJE?=
 =?utf-8?B?Nmo5NElCb0s4RGFua0xxbTI5UHRiRDM3U3hkQXdBV1R0c3Nmb2VGRVJiVHEy?=
 =?utf-8?B?YW1Ra0FTby9xL3hsdlJzN0Z3aXpvQUZSS3RQbFpxOUtqSzdFUG5HSGJmcGVL?=
 =?utf-8?B?MHFYK2lHZHNvVzY1Q3hWY1FRb3pJWktFRXRHelhycXh6TjBuUHppeW0zZ3Bj?=
 =?utf-8?B?OEsrTDJJbHJTKzhOcUIvNXgvbFkzZHJlSnRYQXBHMi8xNlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDk5b0t1MUFpeSt5dW5xNFRTT0NxbkJuSkpQcEdidWhNZzBZckNVVkdsTDhQ?=
 =?utf-8?B?WGR4bHZqRFRJYzNpdElWQWtnMzFYUys3VjdlcXRLMUlJVTdZNU93N2hBbnB2?=
 =?utf-8?B?eFgyYlIxMGQ3UmtMdHVnanJ3MWZsVnljYkJEOUtyalpBNmFqZnprK01wWTF0?=
 =?utf-8?B?LzRYZlVRMUo4VUhxV3dEV05RYWdRWElpVWhiTGZOWUZhaFVacXBGaEZaZzI4?=
 =?utf-8?B?STZNOVc3b2xOUW95bW1xSzNTaTJmeXd0dDFVTTZCbGF3cHl2QW5xR0x1SWZX?=
 =?utf-8?B?UmpvQ254NVpKcVl0VTVNNWx1dnNyY2w2a0xyTzlvM20xVlhnMzJ2MnZ2a0V4?=
 =?utf-8?B?Mk1lTWJ3UnZpNXZuVTc2TzM3ajVZQjRKKzVqdkFaMXlsR3JvQkJXSGRNVnpG?=
 =?utf-8?B?MEoxRDBuMGZqUGt6dzlSNzEwVmdxWTJqL1FZQjgwbHZZNzV3anY0Y2poNUFH?=
 =?utf-8?B?cWhMQi9mdkpvM2c5RTEyS3RZR0J6cjRTMFlybDNFNzRJaVg0SnBiK3dMWTZs?=
 =?utf-8?B?MmVDbERDcU1LRGtnTmVpSno2NkphVjArZWVvalkyK3JKRTV5NW9SZWJYdi9N?=
 =?utf-8?B?R1piU1N6VXpURFBjZWhrVzB0dStvdDZRTUNUL3psamp3cFhnRmdLV2FQaEd1?=
 =?utf-8?B?cGVSOGF6WkpkSk9TNnR3RGRhdTUzZnlzR3Vrb2JMRE5JSUNLVjRITFpiQ3cy?=
 =?utf-8?B?bjVIUjlZN0JObStwczQwNmxvSWR5VjZMRFdVU0JKZlJFeXI2YkVnajNHcFRa?=
 =?utf-8?B?WFNCOEczU1M1dmpXbmZNL3ZYcTI1UnllcG5OUVJjZHNBTUF4T2ZmdkJoV3Bq?=
 =?utf-8?B?RkpsQmRlWXRGK1JDdUR0MGNDenpUSTVRUDF5cHpJcTB2NXNSamd6eGpSVEYw?=
 =?utf-8?B?bVNKTk5oVDV6bjRaeW83TXpWZlUyQitkUThVN3IwM283V1c5K1NDMHJLbXFz?=
 =?utf-8?B?MGhjc1FJSUdaS05tTjhHYkJRTCtuZ29FMkhxN1RLNmUxRkZTYWFkQ0tBTjNH?=
 =?utf-8?B?eHNGWDNCOGUzUXlJV3BRYVJGcjFPa0M0dzhycTF5cXVsUnZFZ3dZSXoxSXJx?=
 =?utf-8?B?RUQ1b1JEUk1rc250aVNtQTF0MzFxQ1dna0pQeEZ2YTFnMlNOU2hWeWlsS1hT?=
 =?utf-8?B?dzJSbE5CTWVLL051bG5JWHVvMjNGRGUwd0NYNmFGbnV1NURKK3Z0K0NWRzd1?=
 =?utf-8?B?TGlmVXdaUHNsR2VyZDhtdXgzRldjbXhXTzJLNzBMZVdGWTZkQmZFQTZGL1Vi?=
 =?utf-8?B?dXFNYVlYc2UwRnJ1Y29wZzRxOHlMRHg5RDJ4a1BKdUFJbDNoMm14dmtMUXZh?=
 =?utf-8?B?ZmF1dmNvdGJDS1BqUkhQandUWm9ld0V2Y0hZM051bzdBMFJqNFZUNTlQYWIz?=
 =?utf-8?B?TkNZaGppditYbHBPbnZTN0FXTkI4SnZtZ1NGYTZnQjF5MklyUnFuaDFJcHNK?=
 =?utf-8?B?L2pRU25FNEhTbXdaaW0yNXBWKzdBazFTZmpYWXN0MDZ1cjhiSzdmNXpUaEtt?=
 =?utf-8?B?ZitpWEJHZ205RngwQm5FblhoaS9scHExZHhVdUU0cnhEZHZZMnlDNFpJOHdu?=
 =?utf-8?B?Uy9udFBaM0t3Q29xMTJFWXVmcUxLSVA4SlFzMmx2UlVtb283M2t3WUdQckNu?=
 =?utf-8?B?eEFuNi8zS1VDNVpYRjVjZkxPa0R2SEsvcEZvZkhSbzdCejB6Zk01OGY3Z1Rx?=
 =?utf-8?B?cFZFYWVuQktNSW9uMXVTQVNmVi9ZUUJrVWg1amtqSzVKUkFDeGVvdGJoeUJR?=
 =?utf-8?B?K1VKaDE2ZjlSRHBpdGZwRzJOYmQvZVZmb3lqQ0FKVnRPN3lHVW95Uk5RbG9V?=
 =?utf-8?B?Unk3Q25US3Vrek56VUdjVjZhTlA4MjVQenRxc3drTjJwdjhoVnVzaVltU2xD?=
 =?utf-8?B?L2VHNVRrVmZFbVNlbGNDMEV5Y21vQ0JSZ0YvY3E4S3FjN0RWc3dEUWY2TW05?=
 =?utf-8?B?dkVWbkNQWFBYWkl3VEJ4SWtKZjBWWWl3dWU1Zi9XNktrbHRET3IvWlh3ZURX?=
 =?utf-8?B?TTRKK3hHVEpxTUdIUmduUFZOWFB4bmlQNFQ0Vm9Qckx0R1IraTRhT1hkd3BZ?=
 =?utf-8?B?b0ZQcC9QNlgwM0p2dU5jZWZnd0grTXdha095SmdyeDU1UjNpcEZRQkR4OXp0?=
 =?utf-8?B?ZFFXUWhPTlNZQkxvNVcwdVJGSmZuWHJqY1BDTmFoYmxlK0dsVHZUb2ppRlNU?=
 =?utf-8?B?ams2MUZENFNTVkhSbW0vVXQxcXNkWWtOLzh2Q0lYRmJIckpJZVdNcFpqMkQ0?=
 =?utf-8?B?RlJwNy9RWll5Uld3bmxVbVNpREdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B14A30537CF5E43A7C4B411DB586C78@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9ff532-794d-4164-93f5-08dca5b4ea74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 16:32:42.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzCw940JxhcxqZZeCkm7zX9BwhmqfNaBUn4Vnv556U4+J1RQL5rBgpHGdBx2lMuRhWXlzr+kmeg+DVlwbtnkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5444

T24gVHVlLCAyMDI0LTA3LTE2IGF0IDEyOjA2IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBKdWwgMjAyNCwgYXQgMTA6MzcsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gVHVlLCAyMDI0LTA3LTE2IGF0IDA5OjQ0IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMTYgSnVsIDIwMjQsIGF0IDk6MjMsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiA+ID4gSG1tLi4uIFdoeSBpc24ndCBpdCBzdWZmaWNpZW50IHRvIHVz
ZSBzbXBfbWJfX2FmdGVyX2F0b21pYygpDQo+ID4gPiA+IGhlcmU/DQo+ID4gPiA+IFRoYXQncyB3
aGF0IGNsZWFyX2FuZF93YWtlX3VwX2JpdCgpIHVzZXMgaW4gdGhpcyBjYXNlLg0KPiA+ID4gDQo+
ID4gPiBHcmVhdCBxdWVzdGlvbiwgb25lIHRoYXQgSSBjYW4ndCBhbnN3ZXIgd2l0aCBjb25maWRl
bmNlICh3aGljaCBpcw0KPiA+ID4gd2h5DQo+ID4gPiBJDQo+ID4gPiBzb2xpY2l0ZWQgYWR2aWNl
IHVuZGVyIHRoZSBSRkMgcG9zdGluZykuDQo+ID4gPiANCj4gPiA+IEkgZW5kZWQgdXAgZm9sbG93
aW5nIHRoZSBndWlkYW5jZSBpbiB0aGUgY29tbWVudCBhYm92ZQ0KPiA+ID4gd2FrZV91cF9iaXQo
KSwNCj4gPiA+IHNpbmNlDQo+ID4gPiB3ZSBjbGVhciBSUENfVEFTS19SVU5OSU5HIG5vbi1hdG9t
aWNhbGx5IHdpdGhpbiB0aGUgcXVldWUncw0KPiA+ID4gc3BpbmxvY2suwqAgSXQNCj4gPiA+IHN0
YXRlcyB0aGF0IHdlJ2QgcHJvYmFibHkgbmVlZCBzbXBfbWIoKS4NCj4gPiA+IA0KPiA+ID4gSG93
ZXZlciAtIHRoaXMgcmFjZSBpc24ndCB0byB0a19ydW5zdGF0ZSwgaXRzIGFjdHVhbGx5IHRvDQo+
ID4gPiB3YWl0cXVldWVfYWN0aXZlKCkNCj4gPiA+IGJlaW5nIHRydWUvZmFsc2UuwqAgU28gLSBJ
IGJlbGlldmUgdW5sZXNzIHdlJ3JlIGNoZWNraW5nIHRoZSBiaXQNCj4gPiA+IGluDQo+ID4gPiB0
aGUNCj4gPiA+IHdhaXRlcidzIHdhaXRfYml0X2FjdGlvbiBmdW5jdGlvbiwgd2UgcmVhbGx5IG9u
bHkgd2FudCB0byBsb29rIGF0DQo+ID4gPiB0aGUNCj4gPiA+IHJhY2UNCj4gPiA+IGluIHRoZSB0
ZXJtcyBvZiBtYWtpbmcgc3VyZSB0aGUgd2FpdGVyJ3Mgc2V0dGluZyBvZiB0aGUNCj4gPiA+IHdh
aXRfcXVldWVfaGVhZCBpcw0KPiA+ID4gdmlzaWJsZSBhZnRlciB0aGUgd2FrZXIgdGVzdHNfYW5k
X3NldHMgUlBDX1RBU0tfUlVOTklORy4NCj4gPiA+IA0KPiA+IA0KPiA+IE15IHBvaW50IGlzIHRo
YXQgaWYgd2Ugd2VyZSB0byBjYWxsDQo+ID4gDQo+ID4gCWNsZWFyX2FuZF93YWtlX3VwX2JpdChS
UENfVEFTS19RVUVVRUQsICZ0YXNrLQ0KPiA+ID50a19ydW5zdGF0ZSk7DQo+ID4gDQo+ID4gdGhl
biB0aGF0IHNob3VsZCBiZSBzdWZmaWNpZW50IHRvIHJlc29sdmUgdGhlIHJhY2Ugd2l0aA0KPiA+
IA0KPiA+IAlzdGF0dXMgPSBvdXRfb2ZfbGluZV93YWl0X29uX2JpdCgmdGFzay0+dGtfcnVuc3Rh
dGUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgUlBDX1RBU0tfUVVFVUVELA0KPiA+IHJwY193YWl0X2JpdF9raWxsYWJs
ZSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBUQVNLX0tJTExBQkxFfFRBU0tfRlJFRVpBQkxFKTsNCj4gPiANCj4gPiBT
byByZWFsbHksIGFsbCB3ZSBzaG91bGQgbmVlZCB0byBkbyBpcyB0byBhZGQgaW4gdGhlDQo+ID4g
c21wX21iX19hZnRlcl9hdG9taWMoKS4gVGhpcyBpcyBjb25zaXN0ZW50IHdpdGggdGhlIGd1aWRh
bmNlIGluDQo+ID4gRG9jdW1lbnRhdGlvbi9hdG9taWNfdC50eHQgYW5kIERvY3VtZW50YXRpb24v
YXRvbWljX2JpdG9wcy50eHQuDQo+IA0KPiBQb2ludCB0YWtlbiwgYnV0IGlzbid0IGNsZWFyX2Jp
dF91bmxvY2soKSAodmlhDQo+IGNsZWFyX2FuZF93YWtlX3VwX2JpdCgpKQ0KPiBwcm92aWRpbmcg
YSByZWxlYXNlIGJhcnJpZXIgdGhhdCBjbGVhcl9iaXQoKSAodmlhDQo+IHJwY19jbGVhcl9ydW5u
aW5nKCksDQo+IHNwaW5fdW5sb2NrKCkpIGlzIG5vdCBwcm92aWRpbmc/DQoNClNvIGxldCdzIGp1
c3QgcmVwbGFjZSBycGNfY2xlYXJfcXVldWVkKCkgd2l0aCBhIGNhbGwgdG8NCmNsZWFyX2JpdF91
bmxvY2tlZCgpLiBUaGF0IHN0aWxsIGVuZHMgdXAgYmVpbmcgbGVzcyBleHBlbnNpdmUgdGhhbiB0
aGUNCmZ1bGwgbWVtb3J5IGJhcnJpZXIsIGRvZXNuJ3QgaXQ/DQoNCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

