Return-Path: <linux-nfs+bounces-1791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA3849F5D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 17:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAA128323A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32939ADE;
	Mon,  5 Feb 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YyTctKY1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2112.outbound.protection.outlook.com [40.107.244.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528D32C96
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149863; cv=fail; b=h+EZ4vntEQLEi+gePaYheW9UQ1rDpeftmReR8Gl5NIB1zf1F7bq2pPdMzWhnLt9E8L9VvCa55aXdKvPUtScxAfjsKzQMDRuDyXhOTcx0O2noFH46b3M+UiMOhD2swb1MQsewuuTA8aaNR2i5reJP7oZqH30g1glqE/KEJ0x29NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149863; c=relaxed/simple;
	bh=vovQsLhwu00JyUFl1bO7FT/17v2cVnJywdAiYzV5M8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sfxf/ocoLB6hFIy/YL1kZ5G8kAa3WIqzV2G/TlArpaRFkIdcusx6UNoTUlvFvfW0BrWRJcc8NK4CMfBkh1x7ND3UHC1jDt5OyJlLXYxTWJGttVYUETeMMKzK7tF/RUQbHCDS8NwvZVmvj8z1vP7doWsBxqeYgjR6Ng529vAJNLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=YyTctKY1; arc=fail smtp.client-ip=40.107.244.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAlIEA6p/B/agV4DpriZqFpIwK8zB64L5Y4Z6QDly7U7L5tnqs9IjXVYBcqspJ9HvBf+gTV00l+pehQtfGEEmw5cTI+j/yza3nGdwc4/eJm2HHjsXpVwqcPJMoInP/XrKjGCNeR+XMHLCBxzwZfqsbAspsseg6YLIlCq16OIWGFw7X5gNmnL5l2OPxo7EH/kdUduI6s1Yp8E+BnSOWsa6w15BcgX1u+CTyY1YQu3Zt6pPt29DbsWj1Bst4iNZ4ddLY66zicL7fJVDJbwavscFa+WbmGkEsNxGRK1CFZa4c7pXJ0gBkIhk4pMMfzzw1KL/hZCoalMH3Y9YEnL/lV4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vovQsLhwu00JyUFl1bO7FT/17v2cVnJywdAiYzV5M8M=;
 b=f99Y/HotCzqZh2IewYmAusz+KfxeMDxFD6Wc9WhkDPmDbMbFUfW5GoeuTky09s1zB5/gMJR5oMhBpzm9jQjwfFf/5v3lBYV7hyD/y1B/8og5at6SSIOEW/x7zuw/meNeY2m/0EP3Yrca7XgVTjRg/UttiYdw1lFsKSLF/jPM1ywpMp449oRdFOXHKrf8ssSPrisPZc3ijNR59gLN2F2eklRDyipS/OLD7gOH/2L72r81bQe8viTNMaUtMGZ0xgjZmWNDLIRxOgWd5m0aTx/DvIWa/+iHYEsZb/KxpuCK0cGuUn/LrBOuViQl/x92XJhAL5QQ+uaYuLpr3+P39DBn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vovQsLhwu00JyUFl1bO7FT/17v2cVnJywdAiYzV5M8M=;
 b=YyTctKY1rQXal9UIM38FFT2MXA1+iRzoo86zEtXaRs1xZjZaRIz2Zengo7iwWpY3WVQa8JoSV/mQtrJ0vVvqkADKdNZnrIrY062gHJa/2sYveH8B3S/V83iN7hJvKXOqJ/nEh5w3N5Zb9j8MEAhwaw32J6Qbg22xmyRtzUX1JAI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BLAPR13MB4642.namprd13.prod.outlook.com (2603:10b6:208:30d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 16:17:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 16:17:38 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "martin.l.wege@gmail.com" <martin.l.wege@gmail.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "cedric.blancher@gmail.com" <cedric.blancher@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index:
 AQHaDKLAcIkwF+UzB02k43ifG3R86rBlifCAgA2y6wCABUQoAIAAbyaAgAA1EgCAeNw+AIAKcP6AgAAR7AA=
Date: Mon, 5 Feb 2024 16:17:37 +0000
Message-ID: <c28a3c78daa1845b8a852d910e0ea6c6bf4d63b4.camel@hammerspace.com>
References:
 <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
	 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
	 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
	 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
	 <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
	 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
	 <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
	 <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com>
In-Reply-To: <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BLAPR13MB4642:EE_
x-ms-office365-filtering-correlation-id: 9c4092e2-677b-439a-2b83-08dc2665f861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GeJczKXU1a2ELoD/Ebp8ParUk0CZo7AV7aEn9OvvXaV3QvC3gqnwinek3GETDTBxPA+AAGr8V5Pancui7Hj8lnUZbiimyBUaLUNv1ht4EKzl58sO4k8iVex4JvVXebHBDjhhO4EvoBKRtfRznRJOB1qOK8d+G4gPOTYZ+/W7qGsnO4Sd2f3HruOKYgiVY51qVUTKDbc0Ii/cxwhbD8/ZcuDkgXX1q9DFgmXugf+hvrsiJELhSBfAzMYQKFxiughKk7C6cI+0xq+NyUSwt8tHrlBTlE5T5KzdNxI1xgLNjwRMZQ+FySrhimGb3EJqEEEcOsHElrHo2QNeotq21HxnbmqPXR2MAtLW3hY4HxWV3mxf3S+clkrbRxYCQB8LBtILabNRuxgkY8Zq+EzVeSbC/MJ9Y/ij99v+6pwkqUhBQczWCI21XGmLFhm3XKhfSuSsWATUCwDXpmGqRACO2rGvO9rX/wd/ozjRf0AM5WE84ryBtS8v95CCUUXPpWzqHuOGTpkWHyktaqdPTOY/B1ELkd6FmBHvGqyPxgZc9/jvvqaH/rVdkcUnV0blJTMnK8Yth0ux+5ZGdy2F5WJh0moUE2cfCN1dj/sMSM/O5cpx6se6zMjiDq/rEwatXZzsZsZ8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(4326008)(36756003)(66476007)(66556008)(64756008)(66446008)(66946007)(54906003)(110136005)(76116006)(478600001)(6486002)(6512007)(6506007)(71200400001)(38070700009)(122000001)(8676002)(316002)(8936002)(38100700002)(26005)(83380400001)(2616005)(86362001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enl0NHJZWE56aTFvRGV6cVREOHAwanhmVUdsd01nZE5YKzZSb1Jzell6UlYr?=
 =?utf-8?B?b2N1N3huNVFPVnZsYzFJWG9qV2hnRzFaZTRxbVVzN0ZrZXZLeHlaTzdzQ044?=
 =?utf-8?B?RnpJTVJmOXVVekhEaXl5eUw5UzNCZ1F6Z1ZhM1BZV0R1dGM3K2VYMm1mRGh2?=
 =?utf-8?B?T3I4UjlMQW8rNlhrUGVZUU5VMHppZkp0YllmUHhDVEVRSnNZN053MlNNYUhh?=
 =?utf-8?B?c2RGekVSYlNyQ3lGK1k1NUV6bUh2cFNtSVN2SWpvZER2ODR4YnQ1RTVpYnFU?=
 =?utf-8?B?aTlvU1E1N1dycFJQVFhOemNucmFscFdmcmhRUElDZDlvK0RnUkJXekExeGpO?=
 =?utf-8?B?bGNOUmNkdTl0MDdCQWNTckZTT2FhUWVnSy85Y2U5LzJxU2gwZVlITW45Ym9h?=
 =?utf-8?B?dzRKckJwT25ndGhYZXhqL28vVVZYUVFGNGVHZ3J4WXVaeUlsTS9PV3BBR29Q?=
 =?utf-8?B?SUxvazVvYURoTW5FUW5hMDlVZlZibmpEakRzRVJaZVM5RHdFb0JyME1FWHZ0?=
 =?utf-8?B?TEQwU01NcVBkZEV0SWh1YmtqemhFcjhJYUJpUm9MS3pIQlpmOVNGbG51SjBC?=
 =?utf-8?B?dXJqUWhUenRXUnNFK0NXZmZVMFJvSVpmd3hZUVhQWDFkYmFBYktIUzhyRHRy?=
 =?utf-8?B?Y2grSFZWS1h4UFFzTEtZTkJHT0pYaU0rbWYrY0xSY2ZaWFBQdkhsR3Rnd0Nw?=
 =?utf-8?B?NC9sc2ljNlJBSy9iNndYVWlwTnZMREhoUmVGZTkveFVxMnpxRGRKc3o3WmRI?=
 =?utf-8?B?UzhQSnFvN1haVWk1eGpnZjBORnozdTA5NFlwK2x4cG9wNFFaZnlvdWtodWpZ?=
 =?utf-8?B?c0NVai9PRWUzT2JmVWV3WEVJR1pHdUhlWTAwZ0pIWkw0TVR5ZElwYSs4cTVT?=
 =?utf-8?B?TlRWNEtiamRzcVloYk83d000M3hKVEdBQWc5UzZvS1hOMFQ4empaS3RCeUhW?=
 =?utf-8?B?YXpNT0pja1gwdWswcVRXT0tlamNHdVhHQ04yajVPUmc2bU10ZHlVMldnQ0Q0?=
 =?utf-8?B?OWhodEtzRElwSUtkS0hGMzZYNVBWL0lqdzB4UGZxbzR2d0pmdVZsMWNad1B4?=
 =?utf-8?B?eDhmWTNXTWdQaVFuQjV0OVZndU9GdlpCdVg5WGNtdFl0WFZzNFRvVFVCRi9y?=
 =?utf-8?B?YTYvaEFLNzVjWXRURGpmcEJjdHI4a2lMMHRvLzFrZ2Y0VUxCVnFaUUs3amZW?=
 =?utf-8?B?UUhPR2pmM0lCcEF1VWRYaEthZHFnK0UwTkxOUDVwVGdpME5MQVdWd29OOHIz?=
 =?utf-8?B?ZFN1elRob3F2RzNiSkQ3NmNTbXVMR3VJZmVOOFJCZkxSZlhONjdyWGUrNHIx?=
 =?utf-8?B?REFWZ3hHSnRxSVd2TDczN0tuVFdmODVzRHdLVHBEdHBKWHhWVlJWeW1wU2k0?=
 =?utf-8?B?VVQ2K0pKNEphWVQ3dnl6MU1tZzZkNXpyRXczbXNuUFpxeFBIbXl1aVhqNTRn?=
 =?utf-8?B?Q0k1dmdHM1RBNTg5UGMvRERETS85YjRzdDl2dTFCYmt1YlhCb0lheEtsT2M3?=
 =?utf-8?B?OXRTTVVEbTR6bjR1dkRDNjN2Rk5icnUwQ2ZERjhYdDY1QXI0bGg5bDVBa1cw?=
 =?utf-8?B?S1d1RjY1SzYyZExGOHIvQjFCbWpKWm5ONUdiVmxqSDQ0ZXVWVHpUME93ZzRU?=
 =?utf-8?B?TGsrY0NGTkNjS1ZEWjZ2UnNtV1lqNWU5TUxIandST3pMdVFzWm10TTJSamRG?=
 =?utf-8?B?b0dIZHhTTndqOHZZSEdORUk1aEF5akhFUjExRk93K3ZNK1YxR0k3MGxBMXJC?=
 =?utf-8?B?OHlwcFBaSzFoTmQrT0VvdGg2T08wTUlhd0M3VjhXQ3NlT3RxMzhqNlF3dnJ1?=
 =?utf-8?B?QVpOamFKK0NVODR6SW1kNkxEN2U5SWhvbkNhWUpvYzVMYitxN1U4QXdrYWtr?=
 =?utf-8?B?UXlTRkhIUkYwZGNWMitqS3pDbFVmOEh1VmVZZ3ZpY3g1eFdmTXJDVzZyeGsv?=
 =?utf-8?B?azlzVUNRcmhnVk8xS09MQ3VIVm41VzJacGI0V1Iydk0xNExYd29hTDZ0WUFp?=
 =?utf-8?B?WWZKNkE5b3JsSVJFbStCbitjM0JKZU15U3lkdVhEeDdQU3FmWHNHaHozZEtS?=
 =?utf-8?B?UDlFTFAvYzF5UDZSM2lpQWw1V0VZVGc5WFNuTXBLZnhEOFpZa29JZ3FGT1NX?=
 =?utf-8?B?aXpoTWh6WGNPU1UvU2FBaytKU0FQRGJwVE5VM0RMWnFma2txOCs0eEhoaG13?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBF15B0A54833843B1926B0752AAA39F@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4092e2-677b-439a-2b83-08dc2665f861
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 16:17:38.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ldGEY50nzmAAlgzpltkYN/pKOh42fTab4dvc6AAIERDnOfcRHfIUs+xUADl4h548Y5V1UdeZuUhdfkQmpKOUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4642

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDE1OjEzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gQSBETlMgbGFiZWwgaXMganVzdCBhIGhvc3RuYW1lIChmdWxseS1xdWFsaWZp
ZWQgb3Igbm90KS4gSXQNCj4gbmV2ZXIgaW5jbHVkZXMgYSBwb3J0IG51bWJlci4NCj4gDQo+IEFj
Y29yZGluZyB0byBSRkMgODg4MSwgZnNfbG9jYXRpb240J3Mgc2VydmVyIGZpZWxkIGNhbiBjb250
YWluOg0KPiANCj4gwqAtIEEgRE5TIGxhYmVsIChubyBwb3J0IG51bWJlcjsgMjA0OSBpcyBhc3N1
bWVkKQ0KPiANCj4gwqAtIEFuIElQIHByZXNlbnRhdGlvbiBhZGRyZXNzIChubyBwb3J0IG51bWJl
cjsgMjA0OSBpcyBhc3N1bWVkKQ0KPiANCj4gwqAtIGEgdW5pdmVyc2FsIGFkZHJlc3MNCj4gDQo+
IEEgdW5pdmVyc2FsIGFkZHJlc3MgaXMgYW4gSVAgYWRkcmVzcyBwbHVzIGEgcG9ydCBudW1iZXIu
IFRoZXJlZm9yZQ0KPiBhIHVuaXZlcnNhbCBhZGRyZXNzIGlzIHRoZSBvbmx5IHdheSBhbiBhbHRl
cm5hdGUgcG9ydCBjYW4gYmUNCj4gY29tbXVuaWNhdGVkIGluIGFuIE5GU3Y0IHJlZmVycmFsLg0K
DQpUaGF0J3Mgbm90IHN0cmljdGx5IHRydWUuIFJGQzg4ODEgaGFzIGxpdHRsZSB0byBzYXkgYWJv
dXQgaG93IHlvdSBhcmUNCnRvIGdvIGFib3V0IHVzaW5nIHRoZSBETlMgaG9zdG5hbWUgcHJvdmlk
ZWQgYnkgZnNfbG9jYXRpb25zNC4gVGhlcmUgaXMNCmp1c3Qgc29tZSBub24tbm9ybWF0aXZlIGFu
ZCB2YWd1ZSBsYW5ndWFnZSBhYm91dCB1c2luZyBETlMgdG8gbG9vayB1cA0KdGhlIGFkZHJlc3Nl
cy4NCg0KVGhlIHVzZSBvZiBETlMgc2VydmljZSByZWNvcmRzIGRvIGFsbG93IHlvdSB0byBsb29r
IHVwIHRoZSBmdWxsIElQDQphZGRyZXNzIGFuZCBwb3J0IG51bWJlciAoaS5lLiB0aGUgZXF1aXZh
bGVudCBvZiBhIHVuaXZlcnNhbCBhZGRyZXNzKQ0KZ2l2ZW4gYSBmdWxseSBxdWFsaWZpZWQgaG9z
dG5hbWUgYW5kIGEgc2VydmljZS4gV2hpbGUgd2UgZG8gbm90IHVzZSB0aGUNCmhvc3RuYW1lIHRo
YXQgd2F5IGluIHRoZSBMaW51eCBORlMgY2xpZW50IHRvZGF5LCBJIHNlZSBub3RoaW5nIGluIHRo
ZQ0Kc3BlYyB0aGF0IHdvdWxkIGFwcGVhciB0byBkaXNhbGxvdyBpdCBhdCBzb21lIGZ1dHVyZSB0
aW1lLg0KDQo+IFRoZSBSRkMgaXMgb25seSBhYm91dCB3aXJlIHByb3RvY29sLiBJdCBzYXlzIG5v
dGhpbmcgYWJvdXQgdGhlDQo+IHNlcnZlcidzIGFkbWluaXN0cmF0aXZlIGludGVyZmFjZXM7IHRo
b3NlIGFyZSBhbHdheXMgdXAgdG8gdGhlDQo+IHdoaW0gb2Ygc2VydmVyIGRldmVsb3BlcnMuDQo+
IA0KPiBJbiBORlNEJ3MgY2FzZSwgcmVmZXI9IGNhbiBzcGVjaWZ5IGEgRE5TIGxhYmVsIChubyBw
b3J0KSwgYW4gSVB2NA0KPiBvciBJUHY2IGFkZHJlc3MgKG5vIHBvcnQpLCBvciBhbiBJUHY0IHVu
aXZlcnNhbCBhZGRyZXNzLiBUaGlzDQo+IGlzIGJlY2F1c2Ugb2YgdGhlIHB1bmN0dWF0aW9uIGlu
dm9sdmVkIHdpdGggc2VwYXJhdGluZyB0aGUgbGlzdA0KPiBvZiBleHBvcnQgb3B0aW9ucywgYW5k
IHRoZSBwdW5jdHVhdGlvbiB1c2VkIGludGVybmFsbHkgaW4gRE5TDQo+IGxhYmVscyBhbmQgSVAg
YWRkcmVzc2VzLg0KPiANCj4gVG8gYWRkIHN1cHBvcnQgZm9yIG90aGVyIGNvbWJpbmF0aW9ucyB3
b3VsZCByZXF1aXJlIGNvZGUgY2hhbmdlcy4NCg0KQWdyZWVkLCBhbmQgdGhlcmUgd291bGQgYWxz
byBiZSB0aGUgbWFqb3IgaXNzdWUgb2YgdHJ5aW5nIHRvIGVuc3VyZQ0KYmFja3dhcmQgY29tcGF0
aWJpbGl0eSBpZiB5b3Ugd2VyZSB0byByZWx5IG9uIGNsaWVudCBiZWhhdmlvdXIgdGhhdA0KZGlm
ZmVycyBmcm9tIHRvZGF5Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

