Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC62CADE6
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 22:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgLAU7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 15:59:55 -0500
Received: from mail-bn8nam11on2133.outbound.protection.outlook.com ([40.107.236.133]:5856
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgLAU7y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Dec 2020 15:59:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBh66j/01ON7yB3HowbPGOI9UEFb2WH6aNLyquNsUc99v9txtsS9+rBbgxvb/LJVnm2lOPIP6CfkEWTLzANKOi1+5oAJyp25urKCEioSxSQTt7aK79xM0u4nNYLO7H2FsP9b7Ci9eAfuVe2IWwIpcKPy0/qpCumkIx8ahkv0BiYG2ov3CqzBCBfbg3z4MaHQa+0RW9dDKimNHZtY8R6gobtirDbbuhlOzK6UBRiCxaEsP/sKN77bj0PP/7vzbCAGP+ZSomfpeJg9q+FFNxN2BAaAZ/VayJIcXxp82OLDphADnEnuTtymEVYmFRLTDrGEM7rMkiRxWKlC2HU2qQl7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rZS8ngZAn/Q9EWpjjXFuvrlSDQi9f9QQccS1iqdoms=;
 b=Gsam6sfw1uFNTgzt5OTYsoLpUCwU+IwMsNwedhuFW9U55zJMAF9O8y7sxthiZl16dXGFySjzeokNrhsFarEp2lxgal0CVIrn5tlv43znLDUV05ZBSjKMwlqtwofD9aTD5xkQhOxsq5OzrUKPEVpTjTr+/wHfqNhv8iLZ4ya0A/49ZI2Px/ZRVDFcYVHlmdJKNxx1VETKPUUXDMc4BKk/Cdrgmc/0CR9isAbsxAkfVCHzccwZimVEVpDrwdA6+KI+YB9k+cdeVlZdWbtDr7L25fiG5MNSCYxHmQbgGPhhhnAOn5+F4ZrmEp43xljVj2VkF9PEnM3TNQJJ5cP0HR2LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rZS8ngZAn/Q9EWpjjXFuvrlSDQi9f9QQccS1iqdoms=;
 b=b9PWM3miogcmmdsqON9o+v6ntEtLWyG9PCp1ehEl+CX4/JIyQFbp8+mFhzL7zK1COxzLWIoMXJFMQ+tQskEVnlsEdNBlH5Si7OgapaWNJp2WePRxgUyeZDOyK2Gg9heygUcu40e2aiZMT9rq575jZy421rVx/4D5fiKAZQtYEM4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3712.namprd13.prod.outlook.com (2603:10b6:208:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Tue, 1 Dec
 2020 20:59:01 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 20:59:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Thread-Topic: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Thread-Index: AQHWx5izYc2p09we50GI2WLg2u+XVqniowSAgAAMEQCAAAKKgIAAB16AgAABVAA=
Date:   Tue, 1 Dec 2020 20:59:00 +0000
Message-ID: <34503d767cffb6b8ffc94dc80ae7632d38a7d68f.camel@hammerspace.com>
References: <20201201041427.756749-1-trondmy@kernel.org>
         <20201201041427.756749-2-trondmy@kernel.org>
         <20201201193521.GA21355@fieldses.org>
         <63eaf3aab8814b2d65998123b6ba2e5b979a48d9.camel@hammerspace.com>
         <7181b1e7290dcfe4f92d9a8b00117a81b30f0cce.camel@hammerspace.com>
         <20201201205359.GC21355@fieldses.org>
In-Reply-To: <20201201205359.GC21355@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e5281a7-4186-4878-5fbf-08d8963beddc
x-ms-traffictypediagnostic: MN2PR13MB3712:
x-microsoft-antispam-prvs: <MN2PR13MB3712F7E80788C31743A133B2B8F40@MN2PR13MB3712.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPktdUc5pQnngZ6q/f8zDxzQBjgSxgQx5KaTmvf3mVolXIw8gbLgaNSVoFdSbokFAg1werqaydfqQXmoETHAv0uYQD5AmD6oTD/JmaalrPyIwxNYcY32x44kKOfAjE72H8vIBDGbzVyBX4T2xMY1QJoV7A2k3Fs8EQsRcTPVsenZskZvLZF6lmD42ja9MhNs0DCpjPJ+hmS7BaOwaITR93WLG+jvQVO8FTexo+bU4Yt1cqZ9oqk8n/Mopd/rOncR5/NSEBuw4invdwBd1nUJwAMPZ0BY6OUxI1q1TZIWNzZXKllCHRMZ2iZ4YLdsu14nTBnEjTaXbcP9yCTlV9+SKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39830400003)(366004)(396003)(186003)(54906003)(5660300002)(36756003)(83380400001)(478600001)(66556008)(4744005)(66446008)(66946007)(66476007)(64756008)(76116006)(2616005)(8676002)(6506007)(8936002)(6916009)(86362001)(316002)(6486002)(26005)(91956017)(4326008)(71200400001)(2906002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?enFxaFZTeHpIdm9XcmRENXRJWXd3L2ZCcjNoZVdJM0xkT3ZhR3hkS0twM25h?=
 =?utf-8?B?bVlSTVd3WHRhOGU2b1dLNDFWV0wvVjdzZjBmYmNzcUlHR1YxQjlSd3EycEZn?=
 =?utf-8?B?TDlmdDlXS0JvKzJmSnhQTDJCaStoOXlrU1VFVldKSFhxTzJqRUNTdWZGbVJx?=
 =?utf-8?B?WDR2b254SkFJRnNjamNXK2pya2dzNWYwVlA4amJxckErdkJhNEpxbTFycjU5?=
 =?utf-8?B?YkoxUVJyTW5HMllGVDArQ042c3JpS3o3SlRvRkpObFBXNHVwekIwbXMyZ2FD?=
 =?utf-8?B?enVQWjJzaWVyTVJ4bWN0ejhXRnBZakV4c1o3UnRDTG1ITXZWZDFlckhmYURE?=
 =?utf-8?B?TWFCUEVaT3cwQWVrV1ViWVpDUzRTbFB2K2NwSjFoZm9oaUkrWTI5a0ttTUJV?=
 =?utf-8?B?YWNjdGZwRjFIZHkwUlY4dUZXOWZ0Vk4wb1I0V3E0aWR6MHVmYWpMLzEzT0ZF?=
 =?utf-8?B?dnc4YXhYajRURittTDBaZkpXM0FLaDFNc1huQ3BqWDVyNzdNR1h2VlF1RlhY?=
 =?utf-8?B?ZkJOaURZUkszbjl1U3lBdzJSbVpoRWFTd1lRcGQ4YUgxeUcyVnBEM2Q1NDVR?=
 =?utf-8?B?UU5UVW1pLzVuR3hMMlVHVm9pcGphNDVwdEluN3kzNTlvVTRKSkV5Rm9DZHhu?=
 =?utf-8?B?SzJBV1VIVFhHOUZZNlhJVkRkSnZ5QnRjQUlVSW03SUV0ekNJYi9aMEJQdHNS?=
 =?utf-8?B?eTBZaThkUGhZQ3J4NGhmRUl2djZOU3pZcmxyUC8zYU5UaTE2K3lHVzRPOXp3?=
 =?utf-8?B?eDMvOVppVnZUOGl5ZzIveTErYWlhSzJsUUQxU211bzRLNW1PcEhnS2ZLZDc3?=
 =?utf-8?B?R0p6bnp6eXMwUit3dVdIb3p6eGwza0s2VmNhaWhHc2s1cXU2V2xzaDR2bGtr?=
 =?utf-8?B?Q1B4enFPWjU4czJadnVjdmVBZkJldFlUT1BDWTJHMlpZWnk5bnRRVStFb0ty?=
 =?utf-8?B?L1k2RG1RdVRmK2ZMV1lUdnlpYkZXSCtnM1V5MDE2cU5TR25yYVZUY0RVWVN6?=
 =?utf-8?B?cGNUUjVLNUltVjlwaEZrNXpidDh3eVNUQXlwWHpZaG5VU3lWM3JDKzVRaXgy?=
 =?utf-8?B?alVIU0JrYlh5M0IyNS9wclhSWkE0SzdJekF4V2ZLbkd6Mjd6c3pqakFMZVh5?=
 =?utf-8?B?MEsxZG91cW9yMXl5bWRvdjJFVmduRkdHc1RjaUd4N0ZmOVhubGcrOC9TemJw?=
 =?utf-8?B?YnhRU3ZDYnZyN2NVVHdBUTN1SzlyK2x5aXFFR1JSeFNnbHVmWGtLK2dOUHhM?=
 =?utf-8?B?YUhWODZUVDJvUWtDWGVvUTRPNUV5SWhUMjIwQzNZek5YaDNRQzRPZ3BIL0Zv?=
 =?utf-8?Q?GpjWZzqtG2N6c0BF2o6WuvFhmjyr0pRrxV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A30B99E52DA07949A816D47A7D7C7914@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5281a7-4186-4878-5fbf-08d8963beddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 20:59:00.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBkMm5mvSFCxC8wLmr8c0Ej6SnX0iIS+OQ47g0F1hIpvJjlXWzbwC13gNhibmI2KfVkNDO5WwyIcptai6paZig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3712
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDE1OjUzIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBEZWMgMDEsIDIwMjAgYXQgMDg6Mjc6MzhQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGVyZSBpcyBubyBu
ZWVkIGZvciBpdCBhdCBhbGwsIHNpbmNlIGJvdGgNCj4gPiB0aGUNCj4gPiBORlN2MyBhbmQgTkZT
djQgY2xpZW50IGNhbiBzdXBwbHkgYXRvbWljIHN0cnVjdCBjaGFuZ2VfaW5mbzQgaW4gdGhlDQo+
ID4gY2FzZXMgd2hlcmUgaXQgaXMgcmVsZXZhbnQgKHRob3NlIGNhc2VzIGJlaW5nIHJlY29yZGlu
ZyB0aGUgY2hhbmdlcw0KPiA+IHRvDQo+ID4gdGhlIHBhcmVudCBkaXJlY3RvcnkvaWVzIHdoZW4g
ZG9pbmcgQ1JFQVRFLCBPUEVOKE9fQ1JFQVQpLCBMSU5LLA0KPiA+IFJFTU9WRQ0KPiA+IGFuZCBS
RU5BTUUpLg0KPiANCj4gSSB3YXMgd29uZGVyaW5nIGFib3V0IHRoYXQuwqAgV2UnZCBuZWVkIHNv
bWUgYWRkaXRpb25hbCBpbnRlcmZhY2UgdG8NCj4gYWxsb3cgbmZzIHRvIHN1cHBseSB0aGF0IHN0
dWZmIHRvIG5mc2QsIHJpZ2h0Pw0KDQpUaGUgb25seSBwcm9ibGVtIGlzIHRoZSBwcmUtb3AgYXR0
cmlidXRlcywgc2luY2UgdGhvc2UgYXJlIHN1cHBsaWVkIGJ5DQp0aGUgc2VydmVyIGJ1dCBuZXZl
ciByZWNvcmRlZCBhbnl3aGVyZS4gT3RoZXJ3aXNlLCBhbGwgeW91IHJlYWxseSBuZWVkDQppcyB0
byBob2xkIHRoZSBpbm9kZSBsb2NrIG9uIHRoZSBkaXJlY3RvcnkgdG8gcHJldmVudCB0aGUgY2xp
ZW50IGZyb20NCm1ha2luZyB1cGRhdGVzIGFmdGVyIHRoZSBvcGVyYXRpb24gaXMgZG9uZS4NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
