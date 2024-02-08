Return-Path: <linux-nfs+bounces-1866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C890884EACB
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 22:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D031F22EA8
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9204F1F9;
	Thu,  8 Feb 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="PgwVeip8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB84F888
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428711; cv=fail; b=ezi1w3nVwZC4ZJ7WGgKLgFFkgCd6mF0CVOmASp9Ftx3h2qJ5/6iEyQA8ReAWm+MfLqEw+xY+fS+ehBsK9BNVI+pCGPF6XGQ4wJgiA3VEyTmAxzkH5JBT5XRUWoqxFNd/10YnKoNcRrDMJ18Mvj2usInBfEf+/PcDx1OtyPT7Vhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428711; c=relaxed/simple;
	bh=thwWREB+K50OINjGQA6WZ0x29QttxzfoelO80AlBlZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BP9dkR5id8O2lzYC6fGvwRXt93mbFroUX3XIrmcj2h7LnKDdUNxDE/hceLf18OcVeoaudAo40zp+Mb2OiXCfzP1RogYiuYNu+nix00zo22wUNLbmcmM905x8uRg9+1Plw1olZDEbooGwFjLjWJwJQGHCUDbRAHhsGWrHfVMf3eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=PgwVeip8; arc=fail smtp.client-ip=40.107.244.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/ohsTOw5ZTAF53GaKH0rlDmkujcGX8thDxCFSLZTa0pH4d6iiGqcy/m8jYdPuAVT2GNhEE1zpZHtR+7ROQaI/a+nWMmOCYVG7Cp0vD+PxooxGnmEyS4q1w1Mu+kMQoWL9vjINjJ6gRLk5DjpL+B4H/CV+/qzXhbEjJZEU9AqJZo6ILh6D3fpRxcfkNblzGUdQrc7ryTGlA9slBPDwIdSfJRBseKok9cz7ES4bq0AMnT43YBKcPB6XM0ptbmAFet6z2lJj+JWD2ExxiBpl/N5M0F4Xuy1HG4GFFWmQZjKGPPG3hbLfiReIjd1Nrgqom8gbdJi/7WTzVKax5021n3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thwWREB+K50OINjGQA6WZ0x29QttxzfoelO80AlBlZ0=;
 b=gDPB1taDa5yVWmsjMIPeH/vSers3fr/oSEQwXMpZgLo050YS+nad10p0Q9PeGlonENj7r53LOpWSAlsBqmd83fogNe74UHKnh0cSXrkyI6upuIbwEHwlCtPOCWqyUGlYg84kHhAn9+JxRLm8kx29SijdnJF90VHGypE1Ahzc09d7pqvQYKarIYi9XYhYk2S3jWmt4f71L6i/i8NknuDwHUhtv/UyxT3iao8kvamoPlvOzkufDaprw2BU1PFS9TsxXyicm3ZTMhnVd0SVaha4QnCb/uXbGC7QKwYdR0A2KEBPt/5ejpt8/oXo7TXgpRBkeUYITcdHGqN+tFe0vIBYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thwWREB+K50OINjGQA6WZ0x29QttxzfoelO80AlBlZ0=;
 b=PgwVeip8mVw4UgauGCVEQD+VP+dVmd0Y8S3J7+Zb4yrCCKRVW8CoLZ1A3j3IsrNNVsoeasko32TM9934wld5+Or3w52wsP+p+lfUw/Z0k2aAStvG1gUW/r/isPO8TnjutJ0IyDeUbQ79qYzotHJR3WCPKGSstv9r36KEAc24g7jVWFfp9al9hR8ptL63YPEGrN/nfLA/fyknGXeM+f/FFB6UCz3sLABe63xc9jmvO2pjY4b5m691Mh5gUz4kdWCNsEqi+6S32Ds0DyGytCa2iPrLSojMmLIYciHaNK9auPpu2cnH0Wd4uH1fYToPkB2V5c7SMRZNumIPt9zPr8ap5Q==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by DS0PR14MB7356.namprd14.prod.outlook.com (2603:10b6:8:156::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 21:45:07 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::9fcf:bc98:5558:c857]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::9fcf:bc98:5558:c857%5]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 21:45:07 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: apparent scaling problem with delegations
Thread-Topic: apparent scaling problem with delegations
Thread-Index: AQHaWstcr/sBhJW1c0inPGg6Tk9HQbEA8OqAgAAGWvM=
Date: Thu, 8 Feb 2024 21:45:07 +0000
Message-ID:
 <PH0PR14MB5493D4DF2877FDD93BB49AF4AA442@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
 <1AF9A62E-55BE-4A08-95D6-26784218C940@oracle.com>
In-Reply-To: <1AF9A62E-55BE-4A08-95D6-26784218C940@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|DS0PR14MB7356:EE_
x-ms-office365-filtering-correlation-id: 894f1a04-0ae7-47d7-aa98-08dc28ef375b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z8yNiDOVH0tPfU4B87rmb67ZBauPZGiZL/L4xtX0TNwp/zV1WUaFt9p6pb4yVin/gbskEREk/pRYfkq4iV4PWkk6bIcJ+igMtafY0k3pOIR6h7/sWY/gN9P+oOTdQxQ8o+P8uGWXP2+dY2a6PMS7zHQGAJoWw0hiR+ue24ZCSs+B0xWrwdU3H7jpQnAiKxn9Cy4DaxljEF7FHlCd3tQ6dflUcwqxzJiIGvma2nQsDrxmadomLd0pPPriUc4jXVXDV3Aacdj8oRtf+TEUoqJS0xNvhWRfBvxzHancurLArxTb9gELv0gwAynIt0NXSHxa+Y5Vn/zO7I/9leHePWOM0tc/kTbqK+oMymmnfRnWrtNEW9jtGfV91MdCe8gXCxW0nGbhSOPFq4lAFtytI/Nn/ZBweixYLiy0Eeby09ANVd6wPMEixgPz5TN9gjZg6prKP/ITnmxo/bZNPQM+JczSXn8aD+L8Sos5JcGNdHOShZkDkdZgqdFGyEoPTCP7bwP7j3fBF1Bjjh2n0w5jfriSG07QgdpZEhQ11u75AZPRTKhgbzu6GYuk7oxrUy8nMDmYIZoGgSdfz3dzXHeT5C43FnXTXPL+M0TpYndfH7ZBbO7fOrTSCQoV9GZBKHI0iSSJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(5660300002)(41300700001)(86362001)(91956017)(7696005)(6506007)(9686003)(53546011)(786003)(4326008)(6916009)(2906002)(316002)(76116006)(71200400001)(66556008)(66476007)(52536014)(66446008)(66946007)(8676002)(478600001)(122000001)(8936002)(64756008)(83380400001)(38070700009)(55016003)(33656002)(75432002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2FIbFp5TXpIalFVRkZ2ZWZEU3lxRi9YMzdCZEpjNWNkckkrZ1p6UkNIeGxv?=
 =?utf-8?B?T3N0S2owMzFXRTNIQ0ZQdHFKRWxGQW4xMDNuNWxJNTk4NEV5S25SVm9PaXBX?=
 =?utf-8?B?b3hOaUFBQjAyditHT1h6S2JIeEFLRU5CNFRZTDd2eGx3Q3lEWC9peUl4UlU4?=
 =?utf-8?B?OHhlNXM5Zmc5TUtHYUU5TU96a0RWK0pPYlN0RTB5bjlsaXp0QTYzRWc2dnNI?=
 =?utf-8?B?S1hkNUFrMThhb2U2N2ZYNE9SM3RncUQ1YXJoaExRZThoVWJ5TzJKRVF2bGpi?=
 =?utf-8?B?LzNqU1ErU25zTmZNUUtySzVMQjRHeWRnMDlQMy8rU29wVXIwbTRHRXJHSU9s?=
 =?utf-8?B?UUlFTlpiTTlQdmhYMVZKYUhmMFd0cW41bzYzN0JJZXhCblJuNUFnOE9aOUxM?=
 =?utf-8?B?cU9mMzhpL0dBekxVaTlqblYraEk5d1lCV045YlpPWlo1R2RFYThsOHFObDJV?=
 =?utf-8?B?Z1E3dzNQd056bHp2Zis5RDVPUWRTdDN2SVFIa0JVRkVsRjFaSXJsSkozMUpV?=
 =?utf-8?B?dVFOenlEY25IcnpURXJULzNlaGo1cVpIczhhR0V0VFhLRURHN0xJdXVhaW1L?=
 =?utf-8?B?ZTIvQ1VQWWxUK0lxb3lOOVVBM1FVSnZub0IwUTgrUElpTDFpcGFkWkFEaEY2?=
 =?utf-8?B?MVVQSS95eWl1bEVLZWFvT0RBRVpwVCtuaHRoQTk0S09vNzMvaEJLL2laY2J5?=
 =?utf-8?B?blpyTlJRL00rajcyMC9WdDd4S0d6RVIxWjBhcEhVNlZodWlPNDBnTEpJd3dk?=
 =?utf-8?B?M05Tb0M3enFSNmFYOVhMWUpyU1dTRkp3WmVQaENteUxWcW55QlpXd2dMaGVt?=
 =?utf-8?B?dHoxSnFOeHZleVZDMHlmUU5WYUh1dXpOMGJ3NGVGaDlCckk4T2p5N2lWTVdk?=
 =?utf-8?B?aUdWRHptV0hKeEI0ZVJ4UzR3U01yVDhXNWZST1FpYzA0Mm5rMFU4dm5idmlH?=
 =?utf-8?B?eFVjaWJCU3pMamtiWGczaUM1clFHbldVK0R4eGRBRmhWLzh4aUdQdWVpR2pS?=
 =?utf-8?B?aUIvbGJiZyttTlNnQUNsTWp3cHJPdmFuUCt1a2wxR1JLdnNkTXVnTzhzYUtm?=
 =?utf-8?B?TkllYnZQbjJoTlJZRXFGUHVXZlZQVVFJa0s1bXBWR3F3NnZkR013ei9ESHFy?=
 =?utf-8?B?aWJnbVVvQzJKcjlwQVRDZDg4cTRFTWt4eC9Za1gzMElEMm9LMGNpemZ1NGt1?=
 =?utf-8?B?QjljZ1h4cFV1UWcxSFVoTVI1MHFjTWtHUmRFNXdSMlNSc2JLdC91dFV5aU9t?=
 =?utf-8?B?YkhlUFR5U2l2UGRzSld6dWo5NGJua21GbWhmb3VqUHBOUHFMNWFkQXRtT0dK?=
 =?utf-8?B?RWV0NE01VWRrdnpaTTRGR3dnYUZiSDBxQ2RQYUJGUWtUL2RWWlBKN2dsOWdj?=
 =?utf-8?B?cGE2UDJMSE9RR1V4SlhGTDBOQmNDU0IvM20wMFk3R0ZjNThIaHBJd0c3cnVL?=
 =?utf-8?B?RDYwSHdwdHhPdVoxRy9ndHFYWkNMQ1hIZGEydXl6RFMxZFhEa2NFaHpMeURF?=
 =?utf-8?B?dFVxS0xQb0txdXNrRVpicFpwdDEvRVN5Vm1ienF4bjFraElZczZwUU1TT2FH?=
 =?utf-8?B?YkRpLzIwYjROUkVaeVM5ai9Hc2Qyc01NWVM4ckJrOW9KVjN5L0ZUaFI3RTNB?=
 =?utf-8?B?aUgxblVKbkYyTG1OakpLWi9CUUhBeHVXUEZwV0RVa2VVRndJaCtUdkgvZ0Rx?=
 =?utf-8?B?S201RGg3ZENHOEFYM2d5VU9OT2NyUG1Ia0svcnduaHc3dWdQdFZvd2FyZGhD?=
 =?utf-8?B?SjB4Qm1DVzU4WEVlYnZBTjdwQm8vZHJUWjFTWUJYNWw0U3JlVjRPUTg0cng1?=
 =?utf-8?B?T1JEZDlLV2YxUmJwd3hKYm50M1BTWGE3ZittTk5vYmg5L0N0M2owOFhaZm50?=
 =?utf-8?B?SmVwOFpyMlduaWh1NU5BWFBRRXlzOGU2bS93MXIxdEpyU3V3OEVMUnJLbGZO?=
 =?utf-8?B?MHd2N0w3aEovTVpoY3dlMlBLYmxUUkJBNGRaeHdydzlzUVdHOWtxd29YVzhy?=
 =?utf-8?B?VGtZVXpTUFVnSUdPMmEvMjlRRG5OR21jK1l6VVBMa1d0bGJMOU1ibGphQ1N1?=
 =?utf-8?B?Z2JJa0kvVFNrb3gxdG5FOE5tVW5FNkFpSUlVK1ZVaFVKejU0amN6c1JQTDBl?=
 =?utf-8?B?UHUzalcvbmJkdFBnZmdZVTJWV1MvaU9wT20vZkpMMXJEc1lTUmJUM3ZsaGFr?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894f1a04-0ae7-47d7-aa98-08dc28ef375b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 21:45:07.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MK5U9Ct11lfJQxNeddV688lwrvbuId+qV6btgATX1hjyjHA3Abow37ghzDNy4038nOFb07pSRrNxnRejEHtIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB7356

PkZyb206wqBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+Cj4+IE9uIEZl
YiA4LCAyMDI0LCBhdCAzOjI24oCvUE0sIENoYXJsZXMgSGVkcmljayA8aGVkcmlja0BydXRnZXJz
LmVkdT4gd3JvdGU6Cj4+Cj4+IFdlIGp1c3QgdHVybmVkIGRlbGVnYXRpb25zIG9uIGZvciB0d28g
YmlnIE5GUyBzZXJ2ZXJzLiBPbmUgY2hhcmFjdGVyaXN0aWMgCj4+IG9mIG91ciBzaXRlIGlzIHRo
YXQgd2UgaGF2ZSBsb3RzIG9mIHNtYWxsIGZpbGVzIGFuZCBsb3RzIG9mIGZpbGVzIG9wZW4uCj4+
Cj4+IE9uIG9uZSBzZXJ2ZXIsIENQVSBpbiBzeXN0ZW0gc3RhdGUgd2VudCB0byAzMCUsIGFuZCBO
RlMgcGVyZm9ybWFuY2UgZ3JvdW5kIAo+PiB0byBhIGhhbHQuIFdoZW4gSSBkaXNhYmxlZCBkZWxl
Z2F0aW9ucyBpdCBjYW1lIGJhY2suIFRoZSBvdGhlciBzZXJ2ZXIgd2FzIAo+PiBzaG93aW5nIGhp
Z2ggQ1BVIG9uIG5mc2QsIGJ1dCBub3QgZW5vdWdoIHRvIGRpc2FibGUgdGhlIHNlcnZlciwgc28g
SSBsb29rZWQgCj4+IGFyb3VuZC4gVGhlIHNlcnZlciB3aGVyZSBkZWxlZ2F0aW9ucyBhcmUgc3Rp
bGwgb24gaXMgc3BlbmRpbmcgbW9zdCBvZiBpdHMgdGltZSAKPj4gaW4gbmZzZF9maWxlX2xydV9j
Yi4gVGhhdCdzIG5vdCB0aGUgY2FzZSB3aXRoIHRoZSBzZXJ2ZXIgd2hlcmUgd2UndmUgZGlzYWJs
ZWQKPj4gZGVsZWdhdGlvbnMuIEhlcmUncyBhIHR5cGljYWwgcGVyZiB0b3AKPj4KPj4gT3Zlcmhl
YWTCoCBTaGFyZWQgT2JqZWN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTeW1ib2wKPj7CoMKgIDQ0Ljg3JcKgIFtrZXJuZWxd
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgW2tdIF9fbGlzdF9scnVfd2Fsa19vbmUKPj7CoMKgIDEzLjE4JcKg
IFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIG5hdGl2ZV9xdWV1ZWRfc3Bpbl9sb2NrX3Ns
b3dwYXRoLnBhcnQuMMKgCj4+wqDCoMKgIDcuMjQlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBba10gbmZzZF9maWxlX2xydV9jYgo+PsKgwqDCoCAyLjYxJcKgIFtrZXJuZWxdwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgW2tdIHNoYTFfdHJhbnNmb3JtCj4+wqDCoMKgIDAuOTklwqAgW2tlcm5lbF3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBba10gX19jcnlwdG9fYWxnX2xvb2t1cAo+PsKgwqDCoCAwLjk1JcKgIFtr
ZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIF9yYXdfc3Bpbl9sb2NrCj4+wqDCoMKgIDAuODkl
wqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gbWVtY3B5X2VybXMKPj7CoMKgwqAgMC43
NyXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBtdXRleF9sb2NrwqAKPj7CoMKgwqAg
MC42NSXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBzdmNfdGNwX3JlY3Zmcm9twqDC
oMKgCj4+Cj4+IEkgbG9va2VkIGF0IHRoZSBjb2RlLiBJJ20gbm90IGNsZWFyIHdoZXRoZXIgdGhl
cmUncyBhIHByb2JsZW0gd2l0aCBHQydpbmcgdGhlIAo+PmVudHJpZXMsIG9yIGl0J3MganVzdCBi
ZWluZyBjYWxsZWQgdG9vIG9mdGVuIChtYXliZSBhIHRhYmxlIGlzIHRvbyBzbWFsbD8pCj4+Cj4+
IFdoZW4gSSBkaXNhYmxlZCBkZWxlZ2F0aW9ucywgaXQgaW1tZWRpYXRlbHkgc3RvcHBlZCBzcGVu
ZGluZyBhbGwgdGhhdCB0aW1lIAo+PiBpbiBuZnNkX2ZpbGVfbHJ1X2NiLiBUaGUgbnVtYmVyIG9m
IGRlbGVnYXRpb25zIHN0YXJ0aW5nIGdvaW5nIGRvd24gc2xvd2x5LiAKPj4gSSBzdXNwZWN0IG91
ciBzeXN0ZW0gbmVlZHMgYSBsb3QgbW9yZSBkZWxlZ2F0aW9ucyB0aGFuIHRoZSBtYXhpbXVtIHRh
YmxlIAo+PiBzaXplLCBhbmQgaXQncyB0aHJhc2hpbmcuIFRoZSBzaXplcyB3ZXJlIGFib3V0IDQw
LDAwMCBhbmQKPj4gNjAsMDAwIG9uIHRoZSB0d28gbWFjaGluZXMuwqAgU3lzdGVtcyBhcmUgMzg0
IEcgYW5kIDc2OCBHLCByZXNwZWN0aXZlbHkuIAo+PiBUaGUgbWF4aW11bSBudW1iZXIgb2YgZGVs
ZWdhdGlvbnMgaXMgc21hbGxlciB0aGFuIEkgd291bGQgaGF2ZSBleHBlY3RlZAo+PiBiYXNlZCBv
biBjb21tZW50cyBpbiB0aGUgY29kZS4KCj5XaGVuIHJlcG9ydGluZyBzdWNoIHByb2JsZW1zLCBw
bGVhc2UgaW5jbHVkZSB0aGUga2VybmVsIHZlcnNpb24KPm9uIHlvdXIgTkZTIHNlcnZlcnMuIFNv
bWUgbGF0ZSA1Lngga2VybmVscyBoYXZlIGtub3duIHByb2JsZW1zCj4gd2l0aCB0aGUgTkZTRCBm
aWxlIGNhY2hlLgoKTXkgYXBvbG9naWVzLlVidW50dSA1LjE1LjAtOTEtZ2VuZXJpYyAsIHdoaWNo
IGlzIDUuMTUuMTMxLg==

