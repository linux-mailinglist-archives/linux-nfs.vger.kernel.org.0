Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FB2F4E52
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbhAMPRn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 10:17:43 -0500
Received: from mail-eopbgr760100.outbound.protection.outlook.com ([40.107.76.100]:7231
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbhAMPRn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Jan 2021 10:17:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do2pzhcipOKrIgJVp1NUm9MSFX72OlxAc8RYCmqPdSmCiMxXEYXNe3gpn+UxvJLZ5ZYeBeZ8E2nfrfDPruQtsiO/x7cklVngYtwMWcP0KNzHG6GNZbD9FBtvfSgP72BaEOa0FBoomlAK4o0nDF/tHsBunNnbWydzs/F4zVbjc3ZHR3GquhHL/p04kjt81sxjGAXN/YWT955JEVnblvtvb/9L3ZpjfRlGx2pC1gfm/P2tBRgzFch1fE3XRUvjhYEpGs3cMQKbGw0TyEmDRPbZnuipcloFIDCbW+gzRZZmd458FWu/N6EKf6+VHSDL8oJ9S5niUlXDxmva/xIMe+mziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFJhR7Uwr9bk/lKSadSgrEb6JrtrAx4gQ1Xs6RqHFmY=;
 b=dylV764IHlFTkwzwUGDrJK4DoGDduXU14hOYIuoLQpS7zxW0hEKmC6lsA/Zha4nV6NglGw3IRUk/bedPie+4q0QlpiCLcpCbi+lfP/OMCp8jfLNhmjJ9TaDfvKuMNNWOF01SUcDiGyQohmZAkwYmUM23Vn1b70u1XlHaiHCh1/le/bo3oHrppAeL3p1b2V9uQFnKtOmXq6Azh4zeSiQLNNFEcvabYZou+vempn0G/BkKlb3LwLJdIFrRid23mjg+F7chd7Z33NrG/zlhz4w/nzrkEuTDkV89MhtoFAO5zWRrSDTDvWRFoAc7zuSZv9hsYzmhtRzQaHrx37MWsz3RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFJhR7Uwr9bk/lKSadSgrEb6JrtrAx4gQ1Xs6RqHFmY=;
 b=JXw450wArbI/wti4J+D42dI9x5Gh2hvKTsA+2zzx/iBWSAVhMq84ZTzme6uTtlQokYVbhhTIGzs6vOvZb3C8wbgzBy9B/ld15jp3TJyfCpePVHW5u/qckIl+mkJq99ZrokAKIBDFj3xT2StI/A/eaJNr0IkwuRXzndrfArMqe/I=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3509.namprd13.prod.outlook.com (2603:10b6:610:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.6; Wed, 13 Jan
 2021 15:16:53 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.009; Wed, 13 Jan 2021
 15:16:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "pgoetz@math.utexas.edu" <pgoetz@math.utexas.edu>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "greg@kroah.com" <greg@kroah.com>, "w@1wt.eu" <w@1wt.eu>,
        "security@kernel.org" <security@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfsd vurlerability submit
Thread-Topic: nfsd vurlerability submit
Thread-Index: AQHW6PgWrSMkggXjGU6epPPdOSc+z6okNQOAgAAHfgCAAAwBAIAA7UQAgABqwQCAAAGYAIAACiqA
Date:   Wed, 13 Jan 2021 15:16:52 +0000
Message-ID: <cfe4b764e6a3a58e10d95dfe660afa12c30d8008.camel@hammerspace.com>
References: <20210108154230.GB950@1wt.eu>
         <20210111193655.GC2600@fieldses.org>
         <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
         <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
         <20210112153208.GF9248@fieldses.org>
         <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
         <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
         <20210112180326.GI9248@fieldses.org>
         <20210113081238.GA1428651@infradead.org>
         <0da3d3f1fee1a70eab3f78212f9282b03e21fc4d.camel@hammerspace.com>
         <20210113144026.GA1517953@infradead.org>
In-Reply-To: <20210113144026.GA1517953@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d56057f-9506-4c71-584b-08d8b7d641e0
x-ms-traffictypediagnostic: CH2PR13MB3509:
x-microsoft-antispam-prvs: <CH2PR13MB3509F3BEB490789F73B71F4CB8A90@CH2PR13MB3509.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBUS923D4xuHQyDaCu8SzJCQ/iEo2IDVwkh82y94J+Mmbk3sVq7+JTLzi+sQKCDfZZ4jJ2o0lAq728IJXeHeTWo4aITYyzgflQ5LKqzKk8W5bba4n0CZoBWUfSVx0hoibNNMQNglEXjDZ7VLpby1VRx7IQPLBUfzF4a3ZFW6ZNmeoq8wjDYd2HhZ4WmwP0aLpA7ELXJ/9j+yxQA4VGjywrR7CknzEGytAgwZwErSezj8wedMXrvoXiD7tO/lPRjlYC4O1dcPdfth+299MniuknDhZ5c1bnGKPwXgCl1ZwOBAPQfGfJ9xEjsuEbwGoyNPCm8nWRuESAT1JU/dgVu/UVZJlVBmh0yWwI9d4xXCBjV3yew53mvTckxc2gcnMNLeLoHXvqRgiy/0L8pBT1rlyoUNGFGfnrPrTRPDxkmM9GqEEApcYFb9lh1uLtKO4JgvMjwpSquzNXLPbD0m0aGdgL6agYwa09qVl8DUGtl2SFLaRN3G5XmU2KbkXKKLLMbkeO6Ddc5oEbyZlBw7jh5wiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(86362001)(498600001)(6512007)(8676002)(66446008)(83380400001)(66946007)(66476007)(2906002)(71200400001)(4326008)(6506007)(26005)(186003)(8936002)(6916009)(2616005)(64756008)(76116006)(66556008)(7116003)(54906003)(3480700007)(5660300002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c09CNHl0U0Nqbm9OU3puSVEzaCtVOTFxWjFLNjJXWHNkaDkvZHBxTFQvU3hW?=
 =?utf-8?B?YzNmMSs4UkJqR00rRjFwUDA5TjZVckhwZnlXN1Y2Y25WSFVxNUdVRjN3NTNG?=
 =?utf-8?B?eXdLa25xRGkzQ2dZcVp5NzRmS1hFcHg4VlZBV2xPOWRqNDc5WEs0ZHlDWDlS?=
 =?utf-8?B?Z25YWHI1VGRaVjNmamNvaVFLSlFDNEZXczhpNldvWS90MEkvVGgrTGR2WkhC?=
 =?utf-8?B?bjQxWWtHRFB0QmhvZEJuZndoR09FeEVNR0V5OWs0Ky91UW1JUnkySDUxYXYx?=
 =?utf-8?B?Tjg3Y1BOYzErc2xNckN5N25nbS9UZXpWVExsMUlUdUQ0cHRQMmNTbTU2Z1Rh?=
 =?utf-8?B?b3VzTmdjeno1QU1MNlBDelFEOC80cTAxek01K3AvTTh6YnZtTGtXd2V4a1R3?=
 =?utf-8?B?Vm8vaDdnZ2J1U2ZBSlV1ZDVYazltOEVOODFOMldYV3cyaWFPU3hENUNmMEV5?=
 =?utf-8?B?RkxtODVqVHNxM0dMRUd0TWhodlA3aUFZYlNpdFBCM1NNa0tGcGlISzlWQmtD?=
 =?utf-8?B?WmhEY3JxVS9LQThhamR2a0grL2VJWFlXMkgyVDlGV0xSRjVTTTNNZWRqNDJT?=
 =?utf-8?B?UXd4ekxOK3dTRmtPR250QUpmc2VHTmVXYUZMMFNqbVJQc0J5K2FhTmRiU2lW?=
 =?utf-8?B?RXFxNkVJR0pUMWk5bFo0bDRSd1d2Ym96Yk5scGFlMENWdEQ2Q3BvczlJVUtp?=
 =?utf-8?B?YldobTRFbFN6V1F0Vm9sU2VmSDJrbitmTzAwbFA4U3BpQ20xaWdkNzNaaEFS?=
 =?utf-8?B?cmhvR2k5M2ZTbncwOXpLN2RNZlVIZVJiUWo1bldYUnpYcFc5TnNKT3Vzems1?=
 =?utf-8?B?aExvdFQ1YTBFZ3U2dkU0a0ZuK2ZvMm04SkcwUFl1UFdpWkg1Y2FiWEFMdzZI?=
 =?utf-8?B?cWsrdk1kT2dGOStWeDc5YmJEcnZXdDRxV2ozbDltVXdWeGFtY3JxY29TWjhi?=
 =?utf-8?B?N2REamhnWGhyRmhkaTc4MDlRaTNESkIyLy84WXhwQnVVcllKOE1HUkdGMTJh?=
 =?utf-8?B?WFh5a1RFT2h0em1XZ0djMlhMVSs1SHFDUHd0NzZPMlIvSFBtbHpyNjU5bjIy?=
 =?utf-8?B?cVhLS2kzeUdqZkZ2c1pFSkVGUFhNaFErblM1K1JhbXBHOW1EK1ZRSlprMUw3?=
 =?utf-8?B?SnJKZytLRkh6TXUxelZNWEFKZWxFL0c0WGhqMnhSZEtxVE1LaDdjR0N3REhV?=
 =?utf-8?B?NEMvcXY0M3RLWk1TVlI2WlozRjBBMHFHb29ieVkvNVFveElMYi9JNGwycVkz?=
 =?utf-8?B?T3NjUW5NMnZzbHdGUThPMHREOGV0WjJqQmNnS1VkalFJVFdaMjJybzNsTWs4?=
 =?utf-8?Q?jq2ra9S616w9GInKZgIE1Ztg8rgvcdeIEi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD087FC4E83C24458AA9030D8D9C16BF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d56057f-9506-4c71-584b-08d8b7d641e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 15:16:52.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEiMWPK/MUt93+gQplo2WXcY+v2ViPnIo+lgrsJsne6k6fFW2pcqnzRZyglcS80EGaQVY3qN+5dX2Q2jEyB7+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3509
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTEzIGF0IDE0OjQwICswMDAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMDI6MzQ6NDVQTSArMDAwMCwgVHJvbmQgTXlr
bGVidXN0IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMS0wMS0xMyBhdCAwODoxMiArMDAwMCwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gPiBGWUksIGlmIHBlb3BsZSByZWFsbHkgd2FudCB0
byB1c2Ugc29tZSBzb3J0IG9mIHN1YnRyZWUgZXhwb3J0cywNCj4gPiA+IGZvcg0KPiA+ID4gWEZT
DQo+ID4gPiAoYW5kIHByb2JhYmx5IGV4dDQpIHdlIGVuY29kZSB0aGUgcHJvamVjdCBpZCBpbnRv
IHRoZSBmaWxlIGhhbmRsZQ0KPiA+ID4gYW5kDQo+ID4gPiB1c2UgdGhlIGhpZXJhcmNoaWNhbCBw
cm9qZWN0IElEIGluaGVyaXRhbmNlIHRoYXQgd2UgYWxyZWFkeSB1c2UNCj4gPiA+IGZvcg0KPiA+
ID4gcHJvamVjdCBxdW90YXMuDQo+ID4gDQo+ID4gWW91J2QgYmFzaWNhbGx5IG5lZWQgc29tZXRo
aW5nIGFsb25nIHRoZSBsaW5lcyBvZiBhIE5ldEFwcCBxdHJlZS4NCj4gPiANCj4gPiBpLmUuIGEg
cGVyc2lzdGVkIHRhZyB0aGF0IGNhbiBsYWJlbCBhbGwgdGhlIGZpbGVzIGFuZCBkaXJlY3Rvcmll
cw0KPiA+IGluIGENCj4gPiBzdWJ0cmVlLCBhbmQgdGhhdCBpcyB1c2VkIHRvIGVuZm9yY2UgYSBz
ZXQgb2YgcnVsZXMgdGhhdCBhcmUNCj4gPiBnZW5lcmFsbHkNCj4gPiBub3JtYWxseSBhc3NvY2lh
dGVkIHdpdGggZmlsZXN5c3RlbXMuIFNvIG5vIHJlbmFtZXMgZnJvbSBvYmplY3RzDQo+ID4gaW5z
aWRlDQo+ID4gdGhlIHN1YnRyZWUgdG8gZGlyZWN0b3JpZXMgdGhhdCBsaWUgb3V0c2lkZSBpdC4g
Tm8gaGFyZCBsaW5rcyB0aGF0DQo+ID4gY3Jvc3MgdGhlIHN1YnRyZWUgYm91bmRhcnkuDQo+IA0K
PiBUaGF0IGlzIHRoZSBYRlMgcHJvamVjdCBJRCwgd2hpY2ggZXh0NCBoYXMgYWxzbyBwaWNrZWQg
dXAgYSBmZXcgeWVhcnMNCj4gYWdvLg0KDQpIb3cgd291bGQgdGhhdCB3b3JrIHRoZW4/IFdvdWxk
IHlvdSBqdXN0IGxvb2sgYXQgdGhlIHByb2plY3QgSUQgb2YgdGhlDQpkaXJlY3RvcnkgaWRlbnRp
ZmllZCBieSB0aGUgZmlsZWhhbmRsZSBhcyB0aGUgZXhwb3J0IHBvaW50LCBhbmQgdGhlbg0KbWF0
Y2ggdG8gdGhlIHByb2plY3QgSUQgb24gdGhlIHRhcmdldCBpbm9kZT8gVGhhdCBzb3VuZHMgbGlr
ZSBpdA0KZG9lc24ndCBldmVuIG5lZWQgdG8gZW5jb2RlIGFueXRoaW5nIHNwZWNpYWwgaW4gdGhl
IGZpbGVoYW5kbGUuDQoNCkhvdyBkbyB5b3Ugc2V0IGEgcHJvamVjdCBJRCBpbiBYRlM/DQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
