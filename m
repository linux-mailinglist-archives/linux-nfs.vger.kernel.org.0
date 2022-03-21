Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2D4E352D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 01:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiCUXwa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 19:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiCUXw2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 19:52:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2103.outbound.protection.outlook.com [40.107.244.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA41905AE;
        Mon, 21 Mar 2022 16:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtlbXgVTCT6mkoUyN2mTI8TbiWnvmN5gVMeuzaRoDXehzcrZH79SB92FJ1Zu5J/XpKNcF/O0vY61N0DiXzgF+iS3kWBAa3cv5reKj/mO30bL4+zZX5Ti983HHq8/ET4XXlig0ORZpb4gtrRjB+vqCyjGpl2ne2djTQyZXRDbQB/0kikgOr4mVMA/4hKBWm011aJDJaizTUsPZbDIsvshhC60rR0leoP3FN0zdRqhRYNEyv4rHUH8z2+u6haCWTniyKSKgaiQe505l+hWfrJ9VzWdt2L1qy8MrM7In2ZfgurXfekWYjZvmutuvKniVTW9EQVy2YYrrcAJAvbfmAdd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwtrzpU645C1GzBPJ9lo4WwhWdgIh2k0wqrb61hv0Po=;
 b=jIVW4CH6dGG8AgaO6xi/9NNK9/bfO/UlHeDNEXP6pXhlqo15zBDL3fsQLP2+IRFbprlZEFc8H6MdA9qkWSQ0C/QAsX2/+iul1eU/aoG0KqN6I1R997BLge3+J7uilLT8qxq0KDJ2n/lTApNOwvCsxC68mh088So9YgsYnAxX7x8MmoqbWOybTx/6DJCDmjGF3F/jDUP2qytKqW8/qV/fQvicN/Vifa+GrUIsKUzgxTFQjKzmHAnOPeuoxYYm/ovH3EwXLVdZarXTDEZjGN6fI9VfpbK8GN71P/cisKMXrpr7ltsRPLLg1XyB9iqmnp9OrKN63besQpGBnBuKjL6UoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwtrzpU645C1GzBPJ9lo4WwhWdgIh2k0wqrb61hv0Po=;
 b=chFHEbWs1hKaZJkbFE8HVMWweFTUnei2/scXH6o4KgvVvMGHUei/nYeY51aQJkTkBEpyw9x2zpyNHUJeh8hsmhRA8ULe5dXa8sIhXLSmjIOoZfEuvqvWUJZ8kJhiZEBayfnjRQK3VgDnk1quq9t1VEngJccd1oAf0Mz/nETElTc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3135.namprd13.prod.outlook.com (2603:10b6:208:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Mon, 21 Mar
 2022 23:50:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.015; Mon, 21 Mar 2022
 23:50:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "khazhy@google.com" <khazhy@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jack@suse.cz" <jack@suse.cz>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Thread-Topic: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Thread-Index: AQHYOyajLa8/8HRLJEmjaX9teCCEe6zF3FKAgACW7ICAA0KLAIAAv/GAgAAM0gCAAAQQAA==
Date:   Mon, 21 Mar 2022 23:50:35 +0000
Message-ID: <a9cf9bcd72a187127b73042a9369e17bd5a0e93d.camel@hammerspace.com>
References: <20220319001635.4097742-1-khazhy@google.com>
         <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
         <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
         <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
         <31f7822e84583235d84b8c7be24360c46c7450f7.camel@hammerspace.com>
         <CACGdZY+3=Xraszi47K2e-Bx=3-d45=qKOgMrV3D1U3dbPjBTmg@mail.gmail.com>
In-Reply-To: <CACGdZY+3=Xraszi47K2e-Bx=3-d45=qKOgMrV3D1U3dbPjBTmg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690cbd23-29d2-4bb5-1d7b-08da0b959846
x-ms-traffictypediagnostic: MN2PR13MB3135:EE_
x-microsoft-antispam-prvs: <MN2PR13MB313578748F9E3AC21AEB0695B8169@MN2PR13MB3135.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4bOWTQr14ZQg/5rc3sQ6PnyvbrKkiX7KmzMrzO/n1PlhqHiz1YmF1Bdg0dEHmcBHhR51Rx2TOtWR7gQMUUbgYLZuvkxQM12cRnYfzioG1MyZso/okDd597nGU+AydhgjH7EqY/uEvg2v4pdQz66H4OJVntZZRqtUw2MFa8/N1K8XvTsuFVWnkJtkLnWOrACksvQjhdFBGx8eVz8g1bXprxasCW9st3GLnU6HHur2uSamhP00SZIwhWTW5FOWgDHph2BaUPABGkXyn6OF81HzDjeAobqoJQ5f4rcWf65QlepIX5293gR3UUfQvQpfB3A+Z2/mh8NacFMt2GZJhXaiY9jn9nv1l4fPrvhaHNw2DfFa0eyQT+tbf8x/FCrw5B1gWIk6K8bwaxG07Lve0DgouXwfQ1nEtyAaoZEHiiiiatft3qlfKAAjDEs6swnpzZ45c5WWT1VQzdyJbg65P12+Yd3x75WMT9wQfn+IHP51/A2/1sUtt+ybguyVBBScR9KfcNORQ+5VgnRWlTif5E6/JZk44De8JRpkQG+edw6TZ9tHj6iemIT03yOIlSV2wUZYL2kxunnph5Qe3Lgeaqwid7LMC2U6PaJ8/TmCYR8y29oGTVoVFzK4ZsT765DrwwPoQKVcZlNNzbhXdOSXVLhq+5T4Hec4bBTCGmI1Ei8X7Q1vResBauFnwzu92Xo0B9/+ThoL1ftCCUnAyeKpROj6UtjagCCVI7aTZswII0+9+LLOAXLDb8dNv5N0YHFn0YN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(76116006)(8676002)(53546011)(66556008)(66946007)(64756008)(66476007)(66446008)(4326008)(122000001)(71200400001)(6506007)(6486002)(316002)(38070700005)(110136005)(54906003)(38100700002)(508600001)(83380400001)(6512007)(26005)(2616005)(186003)(5660300002)(8936002)(36756003)(4744005)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0hwK3Y2SEE1YThGdS9CaFUyZ0hwM3hzR242aHV4ZVRudVJyUlh6NWxyYnkr?=
 =?utf-8?B?N2grTm9wcS8wQkRGR3c4aVVrWWtDd0Q0R2wvM1Q2d0IyWkNHaGJhcHBSd3RP?=
 =?utf-8?B?VENrRGxXV1NJZ1ZKSmkxZDJodzNJR05yQ0JQSUJOeGxlU2ZkamJxMTBZNTlF?=
 =?utf-8?B?VVBhbS9OYS9GWEdtQ3M1aGoxZUhKRmZVZjMvOGJzWjBiblJOTktXVVpoZ3RH?=
 =?utf-8?B?b1pHU0t2K213SUY0SllUOGJxYWtPd1IzeEpXWkswaHpZZFM0RWVCYkliVDBs?=
 =?utf-8?B?cEpQS2s4WEdGUXRRbVozWFVaQzNITHhON2xUYzV3c3gvWUZYVDVZUEQ1UU1q?=
 =?utf-8?B?akNZMXkwQklLaDJxWWZkWXpvRHJRTThDdSs4VlVyODZITWYzS0ZQdmNsWVJV?=
 =?utf-8?B?ZFhjUVRwNXNFVnAvNVFqTUo3cENMOHJ3T3JMS21vN2V5QUdqenhHMFc5OWdD?=
 =?utf-8?B?c1RMMEsrYW1qdURJcGI5OWI0TTUwbFFyTlJEaFVNdSt3NHN6R2Y3NGVWbHBW?=
 =?utf-8?B?Q0dHN0RMSlhuVmZyd1puN2hCRkU2Mk9EWEFKbkhJOCt5N2tIU0M5ejhCd2VV?=
 =?utf-8?B?dFd5MzdqYXorQnhLaTJObU1zVXlPeE9YQXVRUzFjZ1ZQSmpZL3IreUUzSFVE?=
 =?utf-8?B?ZXJNQzFpRzlpeVlxYUpFOVIwOERGTjJrODE4S0h4M0psd0ZWcTNnVTNZY2pM?=
 =?utf-8?B?MTQ4anJkWXFWZitOZUxhOXlGVVFvaDFzNDF6Z1hVTFAyL2NCU3I2eUxHWGpp?=
 =?utf-8?B?TnBUTkRZN09GOG9hSkZDV2dVVDB3d1Q3WEZ4UTh5dkFOK0R3MzAxZzJRb1RO?=
 =?utf-8?B?NzUvaUlaOXJJS2pNZEVrUnhaTGRmUkZTZVhqeW83b2VNdVJ5TlVvZnJURWRs?=
 =?utf-8?B?eE14cTFNTnlyS3lxUGY0dndKZ1BHaGtndlRaRkc0MmNKNlZtOXBJNi9oODNv?=
 =?utf-8?B?NG4zWk1TcHFUYmtuS2F5QzkzRnhnVEt5QnU1SzdPYUR6U2FZRFBZNUp2ZUlp?=
 =?utf-8?B?VkVnazJvNEtYUlNwdWhnMDNPajN5SHV1MEg3NkFnOG1UU2hyaEY2U0xNN3dr?=
 =?utf-8?B?VG5rQy9aTUNsNk96MXZOczI2TGpHUGFRclg2Q3JlOTc3OVBBc3pjRUl4RHlk?=
 =?utf-8?B?TXRRdWdreVZqNHI2L2JWQ1MvQkdrV1lOWTJwRTVMYjNRNTV5SmRsTXdQaStG?=
 =?utf-8?B?MnBuN1ZHRnBORjNLSHVkaFJFc3NiSTA5U25kdGRTV0NPSXg4c1RKd3I3U0wr?=
 =?utf-8?B?T2t2bFQzbkpWam9HSlpBYkVtbVdsVnhoZ3phMGxjSnBETHNzWmExQTZKdU1a?=
 =?utf-8?B?TWM0TW52czR2Mk9wYWlTOUNRZm9wYklxTy9GN3M1b1lhaFpFdUN2bE5uMGc2?=
 =?utf-8?B?bUxRRUtHV1lNVzJiVy9LNDRwTURJTmtiUzJDd0pybE94VWNneldwaTcxK3BM?=
 =?utf-8?B?enVLUHNtdFVRZHVYK1gzV1B5ZDJ6TFo0bFo1SHQ4T2pBL21KRmc0Y0ZZYkUw?=
 =?utf-8?B?R2g5elNKWnAzbTh3SkNkTklqTDBWOHczWEdXUHUxTTFIcUNXYTFJQjJrOUFw?=
 =?utf-8?B?OVhoR01lMnNYbmZpbkcrenJ4VjJzaUt2ZExPMXNDdHB1Smd0YnVCUnlzZTVK?=
 =?utf-8?B?eTQwUW5PV3pEVHNpSm4wVEFLOFhKSDFuVmhRMGtVOSsrZ3JrUGN0MnI4YTBt?=
 =?utf-8?B?aFd6VEh3UzFNRkpnVVV0Tzh0dXVCOXhLdTBaVWhsNjUzbTd0WFU4Y0FKOWM2?=
 =?utf-8?B?R25ScTQ5bGF1czNZbkpvTStBRDYyY3VoV1JROThzYXVkMWdLQ3NsV0lEY2FF?=
 =?utf-8?B?bEI0MzN2WlBGUHYrREJEV2FoWm1vMTBTN2JWa2RyUkFSSzNiWFZOanBXMmNE?=
 =?utf-8?B?NU9sc2lIaFVBV04ySWJtWG54WS83cE00ZGk0dUhTNi9GZ0MwZTNqdEZKbVlI?=
 =?utf-8?B?T2ZFZVhOd3RmalZPWUpmMUV5U1BGNkVzV2lQT28vbmR1K0hOZ3dueTVDYnNk?=
 =?utf-8?B?bVAyVXRPY3VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34773B91C79B434CBFDDF5C7F569E9C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690cbd23-29d2-4bb5-1d7b-08da0b959846
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 23:50:35.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NduiEGIVLJC2FRFk4Zj3sdDCyIzeQ2ZEAWPJw/jQC3EvWyYkb1fPH/2iIV17uRrqGfxaEhDn0tcVNa/Ny9oQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTIxIGF0IDE2OjM2IC0wNzAwLCBLaGF6aHkgS3VteWtvdiB3cm90ZToN
Cj4gT24gTW9uLCBNYXIgMjEsIDIwMjIgYXQgMzo1MCBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBcyBoYXMgYWxyZWFkeSBi
ZWVuIHJlcG9ydGVkLCB0aGUgcHJvYmxlbSB3YXMgZml4ZWQgaW4gTGludXggNS41IGJ5DQo+ID4g
dGhlDQo+ID4gZ2FyYmFnZSBjb2xsZWN0b3IgcmV3cml0ZSwgYW5kIHNvIHRoaXMgaXMgbm8gbG9u
Z2VyIGFuIGlzc3VlLg0KPiA+IA0KPiA5NTQyZTZhNjQzZmMgKCJuZnNkOiBDb250YWluZXJpc2Ug
ZmlsZWNhY2hlIGxhdW5kcmV0dGUiKSwNCj4gMzZlYmJkYjk2YjY5DQo+ICgibmZzZDogY2xlYW51
cCBuZnNkX2ZpbGVfbHJ1X2Rpc3Bvc2UoKSIpIGFwcGx5IGNsZWFubHkgdG8gNS40LnkgZm9yDQo+
IG1lLCB3aGljaCBpcyBzdGlsbCBMVFMuIFNpbmNlIHRoaXMgc2hvdWxkIGZpeCBhIHJlYWwgZGVh
ZGxvY2ssIHdvdWxkDQo+IGl0IGJlIGFwcHJvcHJpYXRlIHRvIGluY2x1ZGUgdGhlbSBmb3IgdGhl
IDUuNCBzdGFibGU/DQoNClRoYXQgd291bGQgYmUgT0sgd2l0aCBtZS4gSSdtIG5vdCBhd2FyZSBv
ZiBhbnkgc2lkZS1lZmZlY3RzIHRoYXQgbWlnaHQNCmJlIGEgcHJvYmxlbSBmb3IgNS40Lg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
