Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6304534A0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhKPOwz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:52:55 -0500
Received: from mail-co1nam11on2117.outbound.protection.outlook.com ([40.107.220.117]:29229
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237650AbhKPOwh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:52:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuyNXqsJQVft9IBGdNAO514KMdPIA902IuIx4Jd+DcaLTDsAkdkDmqiHwmehcRA+PEUUNx2qmyMc9Q1NeqN6ntMXfYAybbQqm2fBBSJ8S/S81ujVZg4494NQHjGelGhxO3POTH+8Pf3olBFkcohb4K+GQgmcWibW9240BFXeGpFp9buy+RCfklC7Mu8UrLmsbZnxSQpynpIcVrKS9orYQub3cFVnv4cZdUiUd6JePFGMbjaGvMscnOrndfx8p8CW9C18hWKZhstamBsrmo0QRVr2mHkgmhlTkNNGiNYdeUx0xdNkxdBYJClj76TuGHfzim+Xp7xzt0o5NkxX9FifDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko5Q10MnC/VpO/AQYXJZO0JAij8fTGvQ3/Pq7grpApQ=;
 b=EqhLiQ4eHHhiiw+wMRMI5WtObPhwOnmiH8rO+mNDiAM7tsmhh46BSdHZHDgZMcQ1JaoUbnMNMAGKOlsIDLGWffbkQssbQLUkdix4BJo23oow0EsRXNVVfdNGFjAxxu4uph8/98KsFwWoWwh7WIFMae2P8vi3iGjvoUljiDSFujO9aiSdAQNonWW89BiZSU8fWYldIoCGYKBZPblpSkDD4oMthsFpKG6OFzmhmsFkwHwsZH31l3Io3HA53/9EA8PxkOKdIb9/HeGDtOr9t03YSUovpT4PkMIkPkLMvhu2jBSDP50Fv2QnaRinFCiFR5ft1B5y8AgTDSV+8pveiGZEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko5Q10MnC/VpO/AQYXJZO0JAij8fTGvQ3/Pq7grpApQ=;
 b=N8WK3e+qyAJ1cIg36kwgrPy3Nm1JJ5jTktw50aZb/yMlFKTBNc5q4K9LO6FpsLPwvIzKUBg/6kJe5NMJlbKs3+77EEiN5tAwfQfH4TYdJ0kvNFQHp6QUOwPubiSYqSbSqeB/iA2wh634y3zzITZiXbzbz1COBG2nqcCvCg7v8bo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5171.namprd13.prod.outlook.com (2603:10b6:610:f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17; Tue, 16 Nov
 2021 14:49:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 14:49:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Thread-Topic: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Thread-Index: AQHX2vDLUMHGAI80skqH9d4qS3nyMKwGL5YAgAACgICAAAFwAIAABMSAgAAEKwA=
Date:   Tue, 16 Nov 2021 14:49:35 +0000
Message-ID: <c5dddaa40131e350fad249c71890ea79df9cef06.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
         <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
         <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
         <9FE34DCC-0F28-4960-B25C-B006DA6D9A38@redhat.com>
         <879b0f03b5c3b786568aaefd26bc8c714e1d7aae.camel@hammerspace.com>
         <66EE327D-C8F1-44D0-9364-573CA1208D46@redhat.com>
In-Reply-To: <66EE327D-C8F1-44D0-9364-573CA1208D46@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eef534a-ff5d-4194-a891-08d9a9104ea4
x-ms-traffictypediagnostic: CH0PR13MB5171:
x-microsoft-antispam-prvs: <CH0PR13MB5171EE7AC11531E46CC9C53BB8999@CH0PR13MB5171.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Opc4ec8KUdafeipBW7i/C+hkuRltXcp50voaVJQ7w1WD2xNdP4DH5y7FNigJ3ev0uonLkhJplcoas3rBX7S2xT6zczPepbnZhl6sthWCxtkrx6H9wRLKZL57JX/nxcRcWat/Om51Z9lEAotW77r/nf+iRiN/vHQ7q3Rqkg5B3t8eFlyZ7kHrqV5NcJxIgjaF50p1Uacj/+IFN+xWfZxYOU6bqfm90vNVHlSoSF7kB8kJgQQbWcyP5dDdBMKpr+qDBtgwZv91vwbLCkzWTaeXhpOoykj+EKnjfHI+hKYwPptE7dHZ/zIImxqcdHK2ZSljnYmVR/hREClVFKpX+7woCYGcJsph5fFSxxMDuXDUXFbJYa0RG6vJ9p9XcYs2Q7xSDR43unA663ZB1zbia6BwrkqLaubdmDuCnEFNIQRrpEOKe8QyvLQaenibsZR7icXE4KGvlqRUxPBRy1LyEJiLlIMUZjeFdDvPy1S9CApXArMwS715yIki7jYBAp7fH7OMS3ZaFhfGU71+c2V1W6ngXFlhLauOq3EQiZ3s+yczZEzgshNiDUMn0g91PhvFDwb+BbvDUrcECevqx86rmGwr7gFLopmSKGBbwvYIUl0WEiDU+1GOtn33e0g3UeHRat/vkakigctX5RWGhxhYnbg1pndtMBTvgVIF3z5DIYX1a9/rhyHMraOGxm6UHnowBbqmYEBjkis6wGQQy3mqusJ0rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39840400004)(366004)(316002)(4326008)(6916009)(38100700002)(186003)(2616005)(66476007)(5660300002)(64756008)(86362001)(66556008)(53546011)(26005)(71200400001)(6506007)(2906002)(66446008)(8936002)(8676002)(122000001)(6486002)(508600001)(54906003)(76116006)(83380400001)(36756003)(38070700005)(66946007)(4001150100001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1kTE1yaUZjOUR3SDNyakVHVURIWmRPbVlaWldqMEZqcDdwUEZadGVraHFk?=
 =?utf-8?B?UXN3VGtZTElZY0M4THozbTBhbHVDT0ZaT0oxZEs5VnVyR2pMQUcraGNtdGlQ?=
 =?utf-8?B?S3hVdnRrdTJLTnpZQk1IeFIyU2RGaWVkUU03a1lZTjRjOTRMVXhCVUs2QU5p?=
 =?utf-8?B?NkIyV0pSaGFrNVo2eDFmRStMb3A3eXlNd3JDOVNkWCtlckZSYkRjdVg0bWxW?=
 =?utf-8?B?bE1ZT0RwRi9CeE1rVlF6QUwvQnU5MkhVZEhKOFp3MlNtRGpnK3VaK29sc2dw?=
 =?utf-8?B?Y2QrejVmUlRSZ0ZRTk5aSFp0c1N4TU5iWmttMWs0ems2NVdwYjlEeTFKekZ2?=
 =?utf-8?B?Q0cyY1c3Tmt0VlZ5RW9UY1RRZURjV1lrYlBaYVA1Z0VYWFZ2ZkdoOFpwRWlK?=
 =?utf-8?B?a2FNLzRoZ3FoNjRUVXozenVTb2xRU1dTOUh6dmErS2RtbXJwRUJIRTExcWZ3?=
 =?utf-8?B?OFBEY0R0aVU4ejFoRHo2MWQ1eUFOTFF6N1RQdjI4bzdjaURIK0dwTVNJUngw?=
 =?utf-8?B?ajh5ODJlS1JYSUNWbVkxN0E5ZlA2UytyQVpaM3ZoVytIYWNMYWVsN24rS01o?=
 =?utf-8?B?UTZ0eWZEZFdzZjIxa3pwN1BLWmhHTzZwUHRqdm5KaTFXVTI0T3dIbWk2K0hM?=
 =?utf-8?B?eDNDeEExZHc3TTFHamdFK3Vqcyt2d0lDNExnQVIxdm9SQTRySVNSdUltK3JL?=
 =?utf-8?B?QXBzWU80VUNsNVBtNzRrVG9wVGhIc2c2emFQZmN4a3dUbVBHdG5oRldxSUEv?=
 =?utf-8?B?V1E1cUwyUEpsNytwditoeDQzdEplRjhFRkR5YzlGbjFuZ3NWUDlFb3VJOXhv?=
 =?utf-8?B?VnhTMTQwZEcvKy9uV1VaV1dMcEdOQ1VPUnRJMkxab0h4YlVKQ3JXNWEydy9Q?=
 =?utf-8?B?SEk0NEVZemFldE5uUDdNOTVHWnRUT3FMNHl5MHBtVjJsMEZPQlhDS2pUQll4?=
 =?utf-8?B?Rk9SSXVLamQwOE1YbjFqTFllREJNNVp2d3UrRHdzZHUrNnBJREJZQ0w5bkhF?=
 =?utf-8?B?VzhtZlFhdmFBVng1LzJ0blNTbjlhV3Voc0NGNFRNU2lmV01qQ2gxcEg1eURQ?=
 =?utf-8?B?NFNxUWc0ZFNNSi80THdKQ2FvMGQ4cmV4Qk13UTRxQktmQ3hqZ0Joci9pNERM?=
 =?utf-8?B?SG1BbERmQi9NNW81eDlXOU9lWFdpSkVPUEh6UVREdkx4NnFzL0ZNcDNIT0p4?=
 =?utf-8?B?OGpnS0h3RUxUSjFaWDhMWGMxSUlFZTlmUytBQm1uR1pXRk5rMW5CNEhmUmp1?=
 =?utf-8?B?dnJQa1cwT2hGM3gvVERhLzU4UGUxZmpzdnAyaUR4bURXWGFMZm5ML0lsS3Vo?=
 =?utf-8?B?blU1Z2ZVdWZPTFh6Y2J1V0hWYU5vcUN1eU9hQnNCQjhPa1BlRzEveTFTbEZS?=
 =?utf-8?B?NGd2UUFNNStpY1huazU4UWllbFhzMWtFVGlNVy9WSTV5ZE5seU10L0pkZ2N6?=
 =?utf-8?B?Qm96bUNvK1BiUnpCWitBanA3ZUdkMlQrVitlbGV0UlZlRnNzb3lYQ3QzMml5?=
 =?utf-8?B?Y3BYYjNuTmU1bEh1QTNLYldYNHhvSVFJU1g3MWhTYk9PVUJoNkJqS1JrdUJT?=
 =?utf-8?B?UU82dkRJdnRzdGljK1dtaXNBOXhCL3JSY0VpdS9yL1ViRzltSGdjN2tkVEdQ?=
 =?utf-8?B?d0hLaFJsL05YdXBaYWZ5WnBkZG1namRCbE9xMjRUclJ2Y2t5d2FWR1c2K095?=
 =?utf-8?B?dE9US2psQUlYc3hRalhFSnBXN2t4Q0k4d3lGNFRia1JqZ1I4ZHZwRmtOSjFK?=
 =?utf-8?B?Z1VJa2I3eG5uNy81SUkwb2E4Q1N0b0dXWWl0dlVQdEZmVi9WN1hJNnhFbHBm?=
 =?utf-8?B?R3NNbHBDM1RVWlBBZmRJU1RNWTVLQ0tBeDU1TDVWelpURUFsK1JtRmVzU0h3?=
 =?utf-8?B?a2JrTWExNzFGeGFnKzZCcHoybndKMkNpZTlOaXU0NkpvclZXNmI5SGJiSXdm?=
 =?utf-8?B?ZUdSRmFUdE1MaloyZWgzUFowZmVpUzVBN3c1bE8zL2EwN1lLRnhIYnV0SytC?=
 =?utf-8?B?VzlSdkFCSjJ4RENSbFNpWTVMV3BGQTJKQ1dOM0FJTUN6bTRWbExXQWQvZ3d0?=
 =?utf-8?B?c1oraEpHUWlPMVJWSCtDSmZOSmdsNllObC9YZHdHbmhVYXF1LzI5bWNBTlgw?=
 =?utf-8?B?alJVaStrTjIrMVROcUlFVzd1SFhNVkFRUjBzQndSeXFoc0RKMXhwMlQwbHpw?=
 =?utf-8?Q?OD6fWvsZX48CHdMeKtUKzwU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F768427D6F3C04DBD2D2A4E5737328D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eef534a-ff5d-4194-a891-08d9a9104ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:49:35.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9Ti8Qk52cKKnGFxvGId+zALXQlgN8Hkbf8AOvLsAqLzIggR92bdMhqcb7SHYBxt9u+QXzhDnbWZEAEjXhnqvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5171
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTE2IGF0IDA5OjM0IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBOb3YgMjAyMSwgYXQgOToxNywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBUdWUsIDIwMjEtMTEtMTYgYXQgMDk6MTIgLTA1MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBPbiAxNiBOb3YgMjAyMSwgYXQgOTowMywgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gPiBObywgd2UgcmVhbGx5IHNob3VsZG4ndCBuZWVkIHRvIGNhcmUg
d2hhdCB0aGUgc2VydmVyIHRoaW5rcyBvcg0KPiA+ID4gPiBkb2VzLg0KPiA+ID4gPiBUaGUgY2xp
ZW50IGlzIGF1dGhvcml0YXRpdmUgZm9yIHRoZSBjaGFuZ2UgYXR0cmlidXRlIHdoaWxlIGl0DQo+
ID4gPiA+IGhvbGRzDQo+ID4gPiA+IGENCj4gPiA+ID4gZGVsZWdhdGlvbiwgbm90IHRoZSBzZXJ2
ZXIuDQo+ID4gPiANCj4gPiA+IE15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGludGVudGlvbiBvZiB0
aGUgY29kZSAod2hpY2ggSSBoYWQgdG8NCj4gPiA+IHNvcnQgb2YNCj4gPiA+IHB1dA0KPiA+ID4g
dG9nZXRoZXIgZnJvbSBoaXN0b3JpY2FsIHBhdGNoZXMgaW4gdGhpcyBhcmVhKSBpcyB0aGF0IHdl
IHdhbnQgdG8NCj4gPiA+IHNlZQ0KPiA+ID4gY3RpbWUsDQo+ID4gPiBtdGltZSwgYW5kIGJsb2Nr
IHNpemUgdXBkYXRlcyBhZnRlciBjb3B5L2Nsb25lIGV2ZW4gaWYgd2UgaG9sZCBhDQo+ID4gPiBk
ZWxlZ2F0aW9uLA0KPiA+ID4gYnV0IHdpdGhvdXQgTkZTX0lOT19JTlZBTElEX0NIQU5HRSwgdGhl
IGNsaWVudCB3b24ndCB1cGRhdGUgdGhvc2UNCj4gPiA+IGF0dHJpYnV0ZXMuDQo+ID4gPiANCj4g
PiA+IElmIHRoYXQncyBub3QgbmVjZXNzYXJ5LCB3ZSBjYW4gZHJvcCB0aGlzIHBhdGNoLg0KPiA+
ID4gDQo+ID4gDQo+ID4gV2Ugd2lsbCBzdGlsbCBzZWUgdGhlIGN0aW1lL210aW1lL2Jsb2NrIHNp
emUgdXBkYXRlcyBldmVuIGlmDQo+ID4gTkZTX0lOT19JTlZBTElEX0NIQU5HRSBpcyBub3Qgc2V0
LiBUaG9zZSBhdHRyaWJ1dGVzJyBjYWNoZSBzdGF0dXMNCj4gPiBhcmUNCj4gPiB0cmFja2VkIHNl
cGFyYXRlbHkgdGhyb3VnaCB0aGVpciBvd24gTkZTX0lOT19JTlZBTElEXyogYml0cy4NCj4gPiAN
Cj4gPiBUaGF0IHNhaWQsIHRoZXJlIHJlYWxseSBpcyBubyByZWFzb24gd2h5IHdlIHNob3VsZG4n
dCB0cmVhdCB0aGUNCj4gPiBjb3B5DQo+ID4gYW5kIGNsb25lIGNvZGUgZXhhY3RseSB0aGUgc2Ft
ZSB3YXkgd2Ugd291bGQgdHJlYXQgYSByZWd1bGFyIHdyaXRlLg0KPiA+IFBlcmhhcHMgd2UgY2Fu
IGZpeCB1cCB0aGUgYXJndW1lbnRzIG9mIG5mc193cml0ZWJhY2tfdXBkYXRlX2lub2RlKCkNCj4g
PiBzbw0KPiA+IHRoYXQgaXQgY2FuIGJlIGNhbGxlZCBoZXJlPw0KPiANCj4gSSB3b25kZXIgaWYg
dGhhdCBqdXN0IGtpY2tzIHRoZSBwcm9ibGVtIGRvd24gdGhlIHJvYWQgdG8gd2hlbiB3ZQ0KPiBy
ZXR1cm4gdGhlDQo+IGRlbGVnYXRpb24sIGFuZCB3ZSdsbCBzZWUgY2FzZXMgd2hlcmUgY3RpbWUv
bXRpbWUgbW92ZSBiYWNrd2FyZC7CoCBBbmQNCj4gSQ0KPiBkb24ndCB0aGluayB3ZSBjYW4gZXZl
ciBiZSBhdXRob3JpdGF0aXZlIGZvciBzcGFjZV91c2VkLCBidXQgbWF5YmUgaXQNCj4gZG9lc24n
dA0KPiBtYXR0ZXIgaWYgd2UncmUgd2l0aGluIHRoZSBhdHRyaWJ1dGUgdGltZW91dHMuDQo+IA0K
DQpJIGRvbid0IHVuZGVyc3RhbmQgeW91ciBwb2ludC4gTWluZSBpcyB0aGF0IHdlIF9zaG91bGRf
IGJlIHNldHRpbmcgdGhlDQpORlNfSU5PX0lOVkFMSURfTVRJTUUsIE5GU19JTk9fSU5WQUxJRF9D
VElNRSwgTkZTX0lOT19JTlZBTElEX0JMT0NLUy4uLg0KZmxhZ3MgaGVyZSwgYW5kIGFzIGZhciBh
cyBJIGNhbiB0ZWxsLCB3ZSBhcmUgaW5kZWVkIGRvaW5nIHNvIGluDQpuZnM0Ml9jb3B5X2Rlc3Rf
ZG9uZSgpLg0KDQpBdCBsZWFzdCBmb3IgY2xvbmUoKSwgd2UncmUgdGhlbiBjYWxsaW5nIG5mc19w
b3N0X29wX3VwZGF0ZV9pbm9kZSgpLA0Kd2hpY2ggdXBkYXRlcyB0aGUgYXR0cmlidXRlcyB3aXRo
IHdoYXRldmVyIHdhcyByZXRyaWV2ZWQgaW4gdGhlIENMT05FDQpjYWxsLiBUaGF0IHdpbGwgdXN1
YWxseSBjb250YWluIG5ldyB2YWx1ZXMgZm9yIG10aW1lLCBjdGltZSBhbmQgYmxvY2tzLA0KYW5k
IHNvIHRoZSBjYWNoZSBpcyByZWZyZXNoZWQuDQoNCklmIHRoZSBjbGllbnQgZmFpbGVkIHRvIHJl
dHJpZXZlIGF0dHJpYnV0ZXMgYXMgcGFydCBvZiB0aGUgQ0xPTkUgb3INCkNPUFkgY2FsbCwgdGhl
biB3ZSBhcmUgaW5kZWVkIGtpY2tpbmcgdGhlIGNhbiBvZiByZXZhbGlkYXRpbmcgdGhlDQphdHRy
aWJ1dGVzIGRvd24gdGhlIHJvYWQsIGJ1dCBvbmx5IGFzIGZhciBhcyB1bnRpbCB0aGUgbmV4dCBj
YWxsIHRvDQpuZnNfZ2V0YXR0cigpLCBvciB0aGUgZGVsZWdhdGlvbiByZXR1cm4sIHdoaWNoZXZl
ciBjb21lcyBmaXJzdC4gVGhlDQpmYWN0IHRoYXQgd2UgZG8gc2V0IHRoZSBORlNfSU5PX0lOVkFM
SURfTVRJTUUsIC4uLiBtZWFucyB0aGF0IHdlIHdpbGwNCnVwZGF0ZSB0aG9zZSBjYWNoZWQgdmFs
dWVzIGJlZm9yZSByZXBseWluZyB0byBhIHN0YXQoKSBvciBzdGF0eCgpIGNhbGwuDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
