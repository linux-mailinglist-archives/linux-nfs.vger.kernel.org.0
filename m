Return-Path: <linux-nfs+bounces-1803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E5384A80E
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B501F227D9
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179E1EB35;
	Mon,  5 Feb 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="POc2Qedk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2117.outbound.protection.outlook.com [40.107.243.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D11350DD
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165291; cv=fail; b=WwesboVS2Ek6dtKfswiWvPKkcP3xaHkrCx/iag/Uh0s0OJU2x53UL9iUFJfer47DuMTi+wgJJL3vb6TyAqeZByjKC0WC0/A0ey2wogYpzUB5PDQljYXj73XMXcRoFff7Ec74srF3+ZosMbJy8dBAbgdD1/9L2O9z30MHFKq61iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165291; c=relaxed/simple;
	bh=EDfUDSGsxKsag/u20SxVVPOpEXFSqB5czWIjbUGVjVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iulRuqHbM0+/CzEVItthGKvHh4Y36hiaNlPiaPufv9n3sxU88rNPY1NugFNYiJ3QcfRenoJfBNqfMDe+9BjyFmRS63Th2KgiKFCIHIIPAVu+Xr4m/u+l7pTM+Ks5/6Foy5Sr1S9I6fCDoW5doxpGpw86nUx7luzyW0zXe7zTois=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=POc2Qedk; arc=fail smtp.client-ip=40.107.243.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2IFS8Ur/iExvtaHi4l4Sf/rtN5sS3YVOTg7K8Bz2PAANm1yXcy0OmyAXwOaB6QzPKmUVDJo4SFP4+y4a53y+gpY5WcjfqFgtdHIbD1HsfUFhUQC99OI/zIChzMWYaIkhxZx3tLX3LL7hs1O+ybmT6joOtXtpFHiRKNbIK/k5VvAuyDKCkWMj3L31aJ3BDcTnLg9RIHVS4ZFx4FAdfVVcp0M+d4in9vtTPESVMA+kFuLjsj5F/UEl47sHQ+HHDrmA40yFua6P/buz4uP3YT0XIpFuzx+Vs8rTFTFNENO/iai5E/dEWnilS69qWtydac6M3/F0ROjmkkYXeVRzjj2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDfUDSGsxKsag/u20SxVVPOpEXFSqB5czWIjbUGVjVE=;
 b=YQDyOTvFLrcJllntXECJetU+AnCpLZNOuYyc3cCYeSM3S7pVL9VfsBiEmHp82281sO9mBmvCeJfEedr4jRgTWZF2Y8uTq+NBmCnwYD8CYkU/0NOAj5TYHt8mYcVsv1iAjdKWQr5UnjWzWXbma/MbWgz/QMd2CbzSYJHPtxxqiomkpHZDa1vfi441Zo+cYWVtc5GGnRIr9vc1R5R953ql/hC2Ag1l7udJg6NRlFrJ+L5rtxrCy5nnJu0X3MdJ9O6Q52FGdxL7uHZXX+KjwVZKMALpk3AgB0mYbiLCkO8m7/48rR9kHcQn8fJ5urSLIlXknmjk+uRzdEmEhR1Vm0XhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDfUDSGsxKsag/u20SxVVPOpEXFSqB5czWIjbUGVjVE=;
 b=POc2Qedk6EplwRVJJdhaJ3+vakk5nvw5EiiuTOgY6Y4whObh/KFYdLklVYVRUnwPhdouEXTb2hQnk00aNL2dCd3qzh4vL2Rpq/RNQbmDtx8o4ajfa///VmZi4Vh5SpWL1NHFn6l8vcP/ZNDAvMswEaeoZ4sNAvMefiBDoh9D6xQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4979.namprd13.prod.outlook.com (2603:10b6:a03:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 20:34:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 20:34:46 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "cedric.blancher@gmail.com" <cedric.blancher@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"martin.l.wege@gmail.com" <martin.l.wege@gmail.com>, "bcodding@redhat.com"
	<bcodding@redhat.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index:
 AQHaDKLAcIkwF+UzB02k43ifG3R86rBlifCAgA2y6wCABUQoAIAAbyaAgAA1EgCAeNw+AIAKcP6AgAAR7ACAADxggIAAC3mA
Date: Mon, 5 Feb 2024 20:34:46 +0000
Message-ID: <b75b415f3b00706016454b066821bda2e4e989ac.camel@hammerspace.com>
References:
 <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
	 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
	 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
	 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
	 <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
	 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
	 <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
	 <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com>
	 <c28a3c78daa1845b8a852d910e0ea6c6bf4d63b4.camel@hammerspace.com>
	 <DA6AB3E6-F720-4679-A36B-01BEB39720BB@oracle.com>
In-Reply-To: <DA6AB3E6-F720-4679-A36B-01BEB39720BB@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4979:EE_
x-ms-office365-filtering-correlation-id: 0670c317-4284-4295-809f-08dc2689e44e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aoVYP409rGg7JLI2q6iExYcLPhU+gSbk9eSuM5dKnucsden9bVHmrb6AMFNRSWpFsokcyNC5d7vZtI0zn0VDj2KI558hPIf1+m2FHT7L+7o8kKQvGAGgzLnGBIajw9WlozqWyFw7nZacp/PaehQ4qjExSo7ICrgYwmqaCJ7EpkpIqHSn45dTEoFDohxdMhnJuQVph/nBpKkXDfOygktP8JMCwJ/Bl4A8kJJKBL+XxgbySiHqvS1P+mdzCckReNSewHPPKb6BRnvN6GZJawZjHh7d8xGxKuXf8+udqIftPoFFQgavA8mlyvNw8C05Ain3iJmg1P19r7N0kFy1LlT9W0gjXiLeEunxAejBGZwuKkd6V36i3VNGokNF8uZJDnxPhfDLuqtCFjx2iH8qLIEUug7TOy/L2iQV+hP7W2JBcvnIIcWtAnRnCpey9/wQcNQo8Az5hgqrBiAvfVEjMPFwr/8jM4dpGyJb8J+IAFSaz6VStkv6cIaK3Lny4NdiX0qWRDf6DPxV4qABcsJl5+OYJlQv29OFmYPrvik8DpdWdhEzvMpwIg8BVO/IFk6kX8XBeJQG1j76Pcg4GQi7DJneN1sQ483drlfyS1WZkjP4kiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(38070700009)(6916009)(66556008)(66946007)(54906003)(64756008)(66446008)(66476007)(76116006)(36756003)(316002)(5660300002)(2906002)(8676002)(4326008)(8936002)(38100700002)(6486002)(966005)(122000001)(6506007)(71200400001)(6512007)(53546011)(478600001)(2616005)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVM3SDRSQlQwUFR1SXFmMWsvN05jblpuQ1VvRmszenFPcllla0wwWmNLNGdy?=
 =?utf-8?B?dnE4M2hlUWdnS1hiRW5KakhNOFYvNGdmWU12T2dRNk5GREpQMklMSW1Cemlv?=
 =?utf-8?B?MWNSSWNQTTJVcmRqVG9yaHkrZ1hQZWZtbjZRMnRFaWZqc1Y2RzVKQVRXUEli?=
 =?utf-8?B?Snk1azd2ZzRRaURTUlVoNmZ2R3ozUlE3Y0VZOHkvMUhST2VvMWNxVXFZZ1RM?=
 =?utf-8?B?a0VaTTZKcHNwQ2JKcTJXdURWQ1FabDQvc3NSRVN5NlNidVF2Nk01bzFUOVBo?=
 =?utf-8?B?OFhpSzhQdWplYVRaZ29MMktnQm54T0hrcXBUS0JFY2xXbHZvVTloNHFOMFlB?=
 =?utf-8?B?TXErOENhRUNkN2VGVXRuNzV6UnhDcG1LN1ZJU0R2YnlJVjl0WHE5VWNLMk0z?=
 =?utf-8?B?ZjNUSXErSWltZnVqTFl0MlZlZjRtYmcvY3JhZW5SS2NZdEtOYUlRZVByaW1n?=
 =?utf-8?B?N0FMZGVJYnJ4RE11Z1JlUzJ1ekN5cE0vaEdldVgyaER1V0I5Zzc4b2FkSlp6?=
 =?utf-8?B?am1PRlJrcGdydDFzQ1VmWnpaYk9CeEtjUURoeUkrNmo2cUVYekdDMXR4WEdW?=
 =?utf-8?B?SEh5UmVjWjNxcUVEcUE1dENxblRwaWJJTEdEVFZYWVdoS2lMZG9vZExOdGlQ?=
 =?utf-8?B?dG5vdG81MTVwa1pTYzhob1FaYk8wdlJvWUpWbDdNVDBiWEsvamlNQUtlWHNL?=
 =?utf-8?B?b0dvWXNWV0xZRFRTb3htcEhmUEV5b1JGaFc0eXduNzB4NVF3bTZkbFlydjhQ?=
 =?utf-8?B?KzhmRFhKbmVUbUI1TDRZZEtIOTZFeFM5T29La0tOMWVXeVlGcWt1MFJVSzZ0?=
 =?utf-8?B?VlVrR1o0Vm9NbXZ3SFVSOGxrd3l0WGtTQ0tydnBoWllyNC9XZ2I0eXVFSUlu?=
 =?utf-8?B?bHJPQnlpQWUyWE05Q1lvbnNEcERQWUJITXZtcGFVSUEvL3JqUTFucVNrelBL?=
 =?utf-8?B?Vi9CUHk0bXl0dFM0Ulp6VVdPNE5TejA3YjNvVW9zd21jNmh6SWdNdHBtSmtR?=
 =?utf-8?B?RjBkMkc2MjY3Vy9WSEIvRVIvdDU0MHJPbjZ4U1pUWWl4TkwzVFVRbmtnNW5W?=
 =?utf-8?B?OHN1czN4c0lPanVOaWdoWkpSNDFDcEYzZ3JTcHZSbS9FaEJOb3VWVEJJRmFL?=
 =?utf-8?B?RkxHYVVucFpnM2hwSHBsbUN2Kzh6LzFWNmlqTkxxMHp1bkQvM24ySW43UVZh?=
 =?utf-8?B?YmhXQ0FLVW9ob1V3WE5GelZheGZCb2lhYWNqWjFqQmY4Z3lDcGwvcDdJNm5B?=
 =?utf-8?B?UW16NktBdW5CVFF2R2Z6aUZhSmF4a3ZkRFVTd0lzNmJ2QTZISTFEczZEN0N0?=
 =?utf-8?B?OUo1cHJUc1BpVU9VSjRUdU9Qelh5TG1zWEVic1RCZnVSekxSRmtPY0ptZ3Rl?=
 =?utf-8?B?Mjk4MjlTMWZ5Y3MzR1B3ZWQ5Y3RPTWEwV3VvOS9vUm4ydUVOdHZNVno4T0hP?=
 =?utf-8?B?dEpjcnBtT3RjL3AvcGhJZldZREg0OC9heUMycHQ5Ry8xNFVZeWIxSjlXRnZk?=
 =?utf-8?B?N2t4TmJpdUFrR2ZhYVBpKzVFekFWM2I0bW9xQjFzdnR2M1NtRlhkSVVQYWsv?=
 =?utf-8?B?a1YwTG4vV1dPbHNLdENiQy9PRitWb2dManYyMHQwNm1HRWoyblkwYU5hSlVG?=
 =?utf-8?B?Yy9PM28vY2ZiMk4yOGhibk9qeTRvRGI5c1VKMzM1a25UbUw1cy9yWGVnYWVV?=
 =?utf-8?B?ZlY3N0xLM1BWQ1RjSEVlSExpc21kYS94ekc2NVdsSmUyRDlNRHQ4OG5WQTVq?=
 =?utf-8?B?TUpqSXFoelRuNE0xMzBoZWIvc3B0ekVoN1BOV3FDT0JMN0ZVNlRJcEUrMVlt?=
 =?utf-8?B?bWFwRHNnL3I3N1p2bVBoRExEbEtjS2ptdXNraHVjSG5GNU9MREgydTdrSjht?=
 =?utf-8?B?MGdvNkYvOWNXVDlyaFVZZnRiYUgvZXpiN1grQlpaMFphUHBsdm13bWszYmhD?=
 =?utf-8?B?QlFrbFZuNmZ2SnFwRmRrclQyUW5UQ0dXYmlVVHRmcjZLN3YxU2s2UHpZdVJm?=
 =?utf-8?B?Tk9XUk41WFN1aFlWbXZvdVVsUVJBdWFRd25rVGxQdXBTdlU5cTJjZTgxSGVk?=
 =?utf-8?B?Mmp1NnY2WEhnMDkrK0gzUUJQa0kxOFIvTUUyVlYvUEdYYTZSZzFVNGgwUjc1?=
 =?utf-8?B?T2lyeldZTk9EYVY0RG9tY0N1VW01TzY1MXJhaW5yTWtRY0NwTWJRV0Y4aHJj?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E23048BBA228544C9A02D91EAFEE0C0A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0670c317-4284-4295-809f-08dc2689e44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 20:34:46.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QWPkxfH8uvsiP2Xe1LnhtyaohFpdYX5GrR8FUL0tio6v8lb62UO7bHFWfJEcg4/FedOo7jTvuJz/b0PZ8Gz3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4979

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDE5OjUzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgNSwgMjAyNCwgYXQgMTE6MTfigK9BTSwgVHJvbmQgTXlrbGVi
dXN0DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBN
b24sIDIwMjQtMDItMDUgYXQgMTU6MTMgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiBBIEROUyBsYWJlbCBpcyBqdXN0IGEgaG9zdG5hbWUgKGZ1bGx5
LXF1YWxpZmllZCBvciBub3QpLiBJdA0KPiA+ID4gbmV2ZXIgaW5jbHVkZXMgYSBwb3J0IG51bWJl
ci4NCj4gPiA+IA0KPiA+ID4gQWNjb3JkaW5nIHRvIFJGQyA4ODgxLCBmc19sb2NhdGlvbjQncyBz
ZXJ2ZXIgZmllbGQgY2FuIGNvbnRhaW46DQo+ID4gPiANCj4gPiA+IMKgLSBBIEROUyBsYWJlbCAo
bm8gcG9ydCBudW1iZXI7IDIwNDkgaXMgYXNzdW1lZCkNCj4gPiA+IA0KPiA+ID4gwqAtIEFuIElQ
IHByZXNlbnRhdGlvbiBhZGRyZXNzIChubyBwb3J0IG51bWJlcjsgMjA0OSBpcyBhc3N1bWVkKQ0K
PiA+ID4gDQo+ID4gPiDCoC0gYSB1bml2ZXJzYWwgYWRkcmVzcw0KPiA+ID4gDQo+ID4gPiBBIHVu
aXZlcnNhbCBhZGRyZXNzIGlzIGFuIElQIGFkZHJlc3MgcGx1cyBhIHBvcnQgbnVtYmVyLg0KPiA+
ID4gVGhlcmVmb3JlDQo+ID4gPiBhIHVuaXZlcnNhbCBhZGRyZXNzIGlzIHRoZSBvbmx5IHdheSBh
biBhbHRlcm5hdGUgcG9ydCBjYW4gYmUNCj4gPiA+IGNvbW11bmljYXRlZCBpbiBhbiBORlN2NCBy
ZWZlcnJhbC4NCj4gPiANCj4gPiBUaGF0J3Mgbm90IHN0cmljdGx5IHRydWUuIFJGQzg4ODEgaGFz
IGxpdHRsZSB0byBzYXkgYWJvdXQgaG93IHlvdQ0KPiA+IGFyZQ0KPiA+IHRvIGdvIGFib3V0IHVz
aW5nIHRoZSBETlMgaG9zdG5hbWUgcHJvdmlkZWQgYnkgZnNfbG9jYXRpb25zNC4gVGhlcmUNCj4g
PiBpcw0KPiA+IGp1c3Qgc29tZSBub24tbm9ybWF0aXZlIGFuZCB2YWd1ZSBsYW5ndWFnZSBhYm91
dCB1c2luZyBETlMgdG8gbG9vaw0KPiA+IHVwDQo+ID4gdGhlIGFkZHJlc3Nlcy4NCj4gPiANCj4g
PiBUaGUgdXNlIG9mIEROUyBzZXJ2aWNlIHJlY29yZHMgZG8gYWxsb3cgeW91IHRvIGxvb2sgdXAg
dGhlIGZ1bGwgSVANCj4gPiBhZGRyZXNzIGFuZCBwb3J0IG51bWJlciAoaS5lLiB0aGUgZXF1aXZh
bGVudCBvZiBhIHVuaXZlcnNhbA0KPiA+IGFkZHJlc3MpDQo+ID4gZ2l2ZW4gYSBmdWxseSBxdWFs
aWZpZWQgaG9zdG5hbWUgYW5kIGEgc2VydmljZS4gV2hpbGUgd2UgZG8gbm90IHVzZQ0KPiA+IHRo
ZQ0KPiA+IGhvc3RuYW1lIHRoYXQgd2F5IGluIHRoZSBMaW51eCBORlMgY2xpZW50IHRvZGF5LCBJ
IHNlZSBub3RoaW5nIGluDQo+ID4gdGhlDQo+ID4gc3BlYyB0aGF0IHdvdWxkIGFwcGVhciB0byBk
aXNhbGxvdyBpdCBhdCBzb21lIGZ1dHVyZSB0aW1lLg0KPiANCj4gV2UgYWJzb2x1dGVseSBjb3Vs
ZCBkbyB0aGF0LiBCdXQgZmlyc3QgYSBzZXJ2aWNlIG5hbWUgd291bGQgbmVlZCB0bw0KPiBiZQ0K
PiByZXNlcnZlZCwgeWVzPw0KPiANCj4gaHR0cHM6Ly93d3cuaWFuYS5vcmcvYXNzaWdubWVudHMv
c2VydmljZS1uYW1lcy1wb3J0LW51bWJlcnMvc2VydmljZS1uYW1lcy1wb3J0LW51bWJlcnMueGh0
bWw/c2VhcmNoPWRucw0KPiANCg0KV2hhdCdzIHdyb25nIHdpdGggdGhlIG9uZSB0aGF0IGlzIGFs
cmVhZHkgYXNzaWduZWQ/IEknbSB0YWxraW5nIGFib3V0Og0KDQpuZnMgICAgICAgICAgICAgICAg
MjA0OSAgICAgICAgdGNwICAgIE5ldHdvcmsgRmlsZSBTeXN0ZW0gLSBTdW4gICAgW0JyZW50X0Nh
bGxhZ2hhbl0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW0JyZW50X0NhbGxh
Z2hhbl0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRGVmaW5lZCBUWFQga2V5czogcGF0aD08cGF0aCB0
byBtb3VudCBwb2ludD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWlj
cm9zeXN0ZW1zDQpuZnMgICAgICAgICAgICAgICAgMjA0OSAgICAgICAgdWRwICAgIE5ldHdvcmsg
RmlsZSBTeXN0ZW0gLSBTdW4gICAgW0JyZW50X0NhbGxhZ2hhbl0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgW0JyZW50X0NhbGxhZ2hhbl0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
RGVmaW5lZCBUWFQga2V5czogcGF0aD08cGF0aCB0byBtb3VudCBwb2ludD4NCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTWljcm9zeXN0ZW1zDQpuZnMgICAgICAgICAgICAg
ICAgMjA0OSAgICAgICBzY3RwICAgIE5ldHdvcmsgRmlsZSBTeXN0ZW0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgW1JGQzU2NjVdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGVmaW5lZCBUWFQga2V5czogcGF0aD08cGF0
aCB0byBtb3VudCBwb2ludD4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=

