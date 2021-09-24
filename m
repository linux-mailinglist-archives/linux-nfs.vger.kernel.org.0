Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C23416AB5
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhIXEPD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 00:15:03 -0400
Received: from mail-sn1anam02on2133.outbound.protection.outlook.com ([40.107.96.133]:54436
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229853AbhIXEPB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 Sep 2021 00:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdYEiSh681vvrZJS56awTkD29DuZ9lTS8m9f+sdnTYBdPYjHWXGbfgD2LfS4VEXbNnhoWULQp36M3VfLDdN1pr2lXxj4uVPWsypnw47g4in2NqAAclPp8F9tYmRJmzafBZIxcMPMoXL+Ysie8wmTEGrAMBztY0lFm1aHm2QEqvOIcP1spLQGQR0wD8CVlVnhRe6BfH3PSASXkhKxj3YvhvgS3DXWT7UDszNoJ4JKy9CBz+F+uxD2gl2DOD8F/qg7v5skng/zYo8wDwugcTRh1ZcgU+X2MITvgcwEkz4/2H+qllZ+w9eO4c/Am9A7F64wS/If2Bshc9U6tNTbMCtmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xXxzB9bs+13opTQ9/xDe7zpyutaRo0bVzwqs1DcFQQ=;
 b=KFJ9umnA+WfgFFJ7kS+kFQcSW1KcaVCfNoN+MDVvbZ0QkopoTDM3doiX0iLWd5ceEhpXmQhg6wLfdfHog0UjayczQpHSbK80+AGyGCk1HhUW/saC2DEPN7cT9LslXdHcJ/mXBwab65HguGgBo5kxpwhTIRWqPu8sjEzSsjUe3HM8WIRZ5jnrwe7RAfGiRW+sKeXP0nlE2YPD2MlJRxuFp7wm9IlB7AtM6Np4Q10qx2Nz6RDqXsvSqCMjoKd3wbWQ5SK8sH48pfUZqIi0R7wqv1a84qjjCW1SL3+lqgiY5VIXwuc/M8pYwDHwkGfXiMX390/uVCCIpiJG2Ww/WR1mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xXxzB9bs+13opTQ9/xDe7zpyutaRo0bVzwqs1DcFQQ=;
 b=XP3Xv4aiT059rGZ+A5q/rsG8RxKa6sIyFg0fapmPYaxVSgGeEJfnepc1n2KASNLYi1NBwX6/cqF57AUcVy2SUKIOB6Hu1Pf54ariaTftIqUzWCE5JThSTBJUY580NQRN3z5r05g1bdUITQuzA/z101cA1r5lVNTZ3/F7EpHZwac=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5234.namprd13.prod.outlook.com (2603:10b6:610:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7; Fri, 24 Sep
 2021 04:13:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4544.013; Fri, 24 Sep 2021
 04:13:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jra@samba.org" <jra@samba.org>, "slow@samba.org" <slow@samba.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Thread-Topic: Locking issue between NFSv4 and SMB client
Thread-Index: AQHXedODTOIDb0BSHkCFWx5UQXQvwauyloUAgABgTQCAAAMJAIAAB4QA
Date:   Fri, 24 Sep 2021 04:13:23 +0000
Message-ID: <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
         <20210923215056.GH18334@fieldses.org>
         <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
         <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
In-Reply-To: <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0be0269-6159-482a-0130-08d97f11a698
x-ms-traffictypediagnostic: CH0PR13MB5234:
x-microsoft-antispam-prvs: <CH0PR13MB5234F89ABC7E7DBB01479367B8A49@CH0PR13MB5234.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjihzrRc6gz6daeKuWXafliPyfkPp4e1XBC/Ya9+3O5kdOtm5vo0yNbOSAfGr3CcIWw3lkbL7BR6k+ji4iLDXbiClYBSRje0YoQmA3h0HirXNxvZNcgWtKmldkksrpSaWmfxPO5HUadLJaj084SWxScl5mhbvHfwba2qIMuXDpYgBc2WDVa8/hOtCoUV0Mb0BxFvBmQ8ejFBoWihWCk/oaVWtO2VjTPFqIkHp8dg0Mq9Psabgu3XAztjNPjJN46175np19VwCF0YGU2MhGR2Hu5uYfj7YgKihZzkUiHwiLhw4rVVDJxHEFin/brDqSfNfA60U/kAvRisb8l6UUW5Vi2DFEb9poU4WBRFAm6DKNKAYd35m9bceexb4r9n22YqZeM11FkbRVyWQiJ6wcbN8O+WEywmvVxQ7qNIG3k/MlkRX4V4QeHchKaad0MRRfCS7dMPCkYiIMJxrbLRGLlxeOosFMxHUEZ2lVsw2S5ydrb7lfFKYQII/vUTaXQfFKi9zsF9Ljz/cRad5PtxrBpNOMnV0TwHfLqDGC2RDUIObISCMxpoRKRtQnpEVmuixUTt/iGKE6zgPyKdrGDL9TElO09kEjnN4Yng9yGxlYCS+97v/mieaRLABhP1UK77RqGzkqquHqxXwecLT2wowtha5Ti3BzyyIZdgQ8wCBhfevTqGdvwTJWPhOPFAw5OZ2emYbV65ktA4Dl5zfY2+Vcsznw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(346002)(366004)(136003)(376002)(6512007)(66476007)(508600001)(76116006)(64756008)(86362001)(66556008)(66446008)(186003)(316002)(71200400001)(8936002)(54906003)(4326008)(66946007)(110136005)(2906002)(2616005)(5660300002)(6486002)(38070700005)(83380400001)(8676002)(122000001)(6506007)(36756003)(26005)(38100700002)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0o3bU9UL1VIR05HTmhiMDZCaWNDWXoxVTNPTDJHMUFpd1FpcnJGUzMzckpk?=
 =?utf-8?B?MmRDMC9ZRkpYc2tkano5YWtKVWNhdUVzSzFocEtpYkoxaFRiYURCWHZwdmNu?=
 =?utf-8?B?TjdEWlBGQ2FhRER3SDVSb3VvaWRkZFYwRkZ4L1czVlRLSlk0c2hhRzF5M3NL?=
 =?utf-8?B?MkN3YVdlMUtHMjdGWXdIVXZaZzlYSzJ6T05MTEhEVkN2aUVSUXdLQ0hMdnpO?=
 =?utf-8?B?S04zSFhCQnNZeEo3VVlWK1Q5aDdaMXovRFdzUmpXYzhKc0VBclFySVpCSWQ3?=
 =?utf-8?B?eWtvZHdCRU4vblNDNnliYm84UlhZOUZaY0ZWcDZKclFkQWNnb05aYm1sZGtj?=
 =?utf-8?B?dUFSbUtqaHU5YW03QVA5SkZPbHhHQnp2VUc3TDJ2dytmL2p5UXF4ZCtlbnZ6?=
 =?utf-8?B?dFZFdmdmZmxuWTdIcXlCempkS1F1QXhubUJ0ZUlpM0ZxS245NHZGa29NNEV5?=
 =?utf-8?B?Q0JiMWhRK3VKMnIwZERGTHZENTZUSVpEUzdBeHBvTnlXd0M4R2FPY0plNG9q?=
 =?utf-8?B?UzJTUWFJQllONWFaVnFBZmdtT2dmTTJZeCtURk5RK09yV05FT0xDbDdyKzZj?=
 =?utf-8?B?bHE2SDNDT2pqR3p4M0JORWxueFc5OWJPWkxuNGZlckdwMjMvWUM2UlNFQ2M2?=
 =?utf-8?B?eVR5Q2NvY1dTUWFDajJuNWxyL1JzVEdYQmY5SitrZzR4NC9QVGx4cVpBSGx5?=
 =?utf-8?B?aUE2TmpZRHllVStKSHJ2VE4raTd0aFZnMkJoWTVaVXRQdmNPS1llZ0p5M0tB?=
 =?utf-8?B?NjgyTGVpKzEzK0gwU0N6SmpEekh2dEpFM0ZjeHp3ai92ZEh5ZFZuY0NwNS9C?=
 =?utf-8?B?YStsTmF3UFo0NG5zLzl6dGVMbE9vdm94WjJNdXNXMDdWdFNvTkQwbm1nT0dy?=
 =?utf-8?B?VUhUdVpkYlNWS0JUV05uemQ4UFYwUnAvSVM5SFpsbDBwSVU0dVcwckxOUkwx?=
 =?utf-8?B?Vms2ODBFK0phRE5RcW1rVjF6V004eEpHNXJ4YU9GUjduTDJqT2d3Zmhzdk51?=
 =?utf-8?B?ak5ZZGVIQStmeDl1N3FDZUpxSllVT1pKZW9OUTFmSlU0QnN6TWxkRHlXNndT?=
 =?utf-8?B?MTdEMmZSUi9PM2xmMFB4LytmWUdua3Z6UllTZWJhNmhucW9Ic2x1T0FUaitD?=
 =?utf-8?B?em03cWx0aXVBcXB6YlRlZ3dRN3Z4Sk1MVlZRVUFaSXpWL0lXb09HTDZrajYv?=
 =?utf-8?B?cFd1L1NqK3E4eG92aGJvY0pjbzF0Zk1rN3VCVTBaUXhhcU9pZ3FaeXJOQnJE?=
 =?utf-8?B?RHlFZW1jNjlORUlHTVMrU3A0ZC9ILzBqV3J3clNlSGxDZEhFU2hUSisxV0hZ?=
 =?utf-8?B?a0JKTjRIUDJmbWhFUmNBNDc5UXcyUHdrS2NTWGl2NGxtS2Vvam1YQk9MQk9j?=
 =?utf-8?B?ckpZYSttbzJrWHd2bmUrelJsOEpxMXM0M3VvY0ZhYWdkbDZLdVlTb2RzNHRL?=
 =?utf-8?B?L1ZyRCtqUjMwNzNvb3ZHWXdsYmdFOUxNVVdBdkd4ZzZvVTQ1a210blpDTTg0?=
 =?utf-8?B?ODdUYVA0R3ZkbkhiOFFzWGZXMU1IMk1tajRuTlNrQnRZSVJDTUNYYWo0Y2t2?=
 =?utf-8?B?NFhNcmN6NmxpYWFnVjZvbmZ5S1c4aU94Ti9SQk9ITTNZb1FwbmlJbkVIUTd6?=
 =?utf-8?B?MkRRVW1GcW0wNUt4Sm9ZbDJSeFVGZ0JwVENZT08xdHVZRGltYytJRnF5ZEMy?=
 =?utf-8?B?UHFXa2d3dU85dEJxQjhNcFN3a1BCQkREY3NCTGE5QndNSThWaWJVZVYzOGdv?=
 =?utf-8?Q?01JQZp3pZpBR54SK6kY6z1B+WUhpoKu7sl4fr6c?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF1A3910EAFE5146900A59347A29F085@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0be0269-6159-482a-0130-08d97f11a698
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 04:13:23.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0b0MBfVtdq5ZH4aim+1/7aPNTVVCIDvDBVvGzAu6svWSBr1Sd3Cke6bK6hol2mRgzvE3fX9RhJeLJhosUp70xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5234
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTI0IGF0IDA1OjQ2ICswMjAwLCBSYWxwaCBCb2VobWUgd3JvdGU6DQo+
IEFtIDI0LjA5LjIxIHVtIDA1OjM1IHNjaHJpZWIgVHJvbmQgTXlrbGVidXN0Og0KPiA+IE5vdCBp
ZiB5b3Ugc2V0IHRoZSAia2VybmVsIG9wbG9ja3MiIHBhcmFtZXRlciBpbiB0aGUgc21iLmNvbmYg
ZmlsZS4NCj4gPiBXZQ0KPiA+IGp1c3QgYWRkZWQgc3VwcG9ydCBmb3IgdGhpcyBpbiB0aGUgTGlu
dXggNS4xNCBrZXJuZWwgTkZTdjQgY2xpZW50Lg0KPiA+IA0KPiA+IE5vdyB0aGF0IHNhaWQsICJr
ZXJuZWwgb3Bsb2NrcyIgd2lsbCBjdXJyZW50bHkgb25seSBzdXBwb3J0IGJhc2ljDQo+ID4gbGV2
ZWwNCj4gPiBJIG9wbG9ja3MsIGFuZCBjYW5ub3Qgc3VwcG9ydCBsZXZlbCBJSSBvciBsZWFzZXMu
IEFjY29yZGluZyB0byB0aGUNCj4gPiBzbWIuY29uZiBtYW5wYWdlLCB0aGlzIGlzIGR1ZSB0byBz
b21lIGluY29tcGxldGVuZXNzIGluIHRoZSBjdXJyZW50DQo+ID4gVkZTDQo+ID4gbGVhc2UgaW1w
bGVtZW50YXRpb24uDQo+ID4gDQo+ID4gSSdkIGxvdmUgdG8gZ2V0IHNvbWUgbW9yZSBpbmZvIGZy
b20gdGhlIFNhbWJhIHRlYW0gYWJvdXQgd2hhdCBpcw0KPiA+IG1pc3NpbmcgZnJvbSB0aGUga2Vy
bmVsIGxlYXNlIGltcGxlbWVudGF0aW9uIHRoYXQgcHJldmVudHMgdXMgZnJvbQ0KPiA+IGltcGxl
bWVudGluZyB0aGVzZSBtb3JlIGFkdmFuY2VkIG9wbG9jay9sZWFzZSBmZWF0dXJlcy4gRnJvbSB0
aGUNCj4gPiBkZXNjcmlwdGlvbiBpbiBNaWNyb3NvZnQncyBkb2NzLCBJJ20gcHJldHR5IHN1cmUg
dGhhdCBORlN2NA0KPiA+IGRlbGVnYXRpb25zDQo+ID4gc2hvdWxkIGJlIGFibGUgdG8gcHJvdmlk
ZSBhbGwgdGhlIGd1YXJhbnRlZXMgdGhhdCBhcmUgcmVxdWlyZWQuDQo+IA0KPiBsZWFzZXMgY2Fu
IGJlIHNoYXJlZCBhbW9uZyBmaWxlIGhhbmRsZXMuIFdoZW4gc29tZW9uZSByZXF1ZXN0cyBhDQo+
IGxlYXNlIA0KPiBoZSBwYXNzZXMgYSBjb29raWUuIFRoZW4gd2hlbiBoZSBvcGVucyB0aGUgc2Ft
ZSBmaWxlIHdpdGggdGhlIHNhbWUgDQo+IGNvb2tpZSB0aGUgbGVhc2UgaXMgbm90IGJyb2tlbi4N
Cg0KUmlnaHQsIGJ1dCB0aGF0IGlzIGVhc2lseSBzb2x2ZWQgaW4gdXNlciBzcGFjZSBieSBoYXZp
bmcgdGhlIGNvb2tpZSBhY3QNCmFzIGEga2V5IHRoYXQgcmVmZXJlbmNlcyB0aGUgZmlsZSBkZXNj
cmlwdG9yIHRoYXQgaG9sZHMgdGhlIGxlYXNlLiBUaGlzDQppcyBob3cgd2UgdHlwaWNhbGx5IGlt
cGxlbWVudCBORlN2NCBkZWxlZ2F0aW9ucyBhcyB3ZWxsLg0KDQo+IA0KPiBNYXliZSBvdGhlcnMg
Y2FuIGNvbW1lbnQgb24gdGhlIGxldmVsIElJIG9wbG9jayBwcm9ibGVtLiBBZmFpayB0aGlzDQo+
IHdhcyANCj4gbW9yZSBhIGxhY2sgb2YgdGVzdGluZy4NCg0KVGhhdCB3b3VsZCByZWFsbHkgYmUg
YSBiaXQgb2YgYSBzaGFtZSwgc2luY2UgdGhlIHVzZSBvZiBsZWFzZXMgb24gdG9wDQpvZiBuZXR3
b3JrZWQgb3IgY2x1c3RlcmVkIGZpbGVzeXN0ZW1zIGNvdWxkIGhlbHAgc3BlZWQgdXAgc3RhdGUN
Cm1hbmFnZW1lbnQgb3BlcmF0aW9ucyBieSBhdm9pZGluZyB0aGUgbmVlZCBmb3IgYSBzZXBhcmF0
ZSBkaXN0cmlidXRlZA0KbG9jayBtYW5hZ2VyLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
