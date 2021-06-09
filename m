Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9933A1923
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhFIPVT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 11:21:19 -0400
Received: from mail-dm6nam12on2099.outbound.protection.outlook.com ([40.107.243.99]:17185
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233849AbhFIPVL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Jun 2021 11:21:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkSkBgGVP9FwW+0zIsHfmSjIvDBVOYbQly4ISapW/rWYlRtJfaQZSFgKFs63fSZRqG9AQqvcm0CvJZCH01j0c+PKE3r/Ee6q1J/bTCzwZa1DLNf9InumVZ2xpcRrKdi+3GC3xA8TeiUNLuDKBuwehY8u9z7NLF++j8j3fvyVaocm5yIjaX3JLm4BwMc6OXJwBDkzBnRbwcLuoUZqpN5/wSLnic/YEPRuvLx2tE3skIDStGIEWG2U3VJlKFomxiO5rOz31uK8EoX7ZULjqSxHeof55SoI4kvrvPmxp9P3o1xjs47yWG51olQV/gnyk7ivepAxi/QvS19xwO47Jlq42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUAwCkmCiLOambUC64l6PcsWnGdAL0Sdj4lcKPA2rNk=;
 b=ctqXYt/Z5PcTotXFweDpPxzO89wELpTarHFO5NBY3j+zgDy71viEsFiy2++L6ooQH5BYDNSM75u8PKi8KLZPHDOFMiJ7S04Cxrfblbat+XkLZcqYZmoMYKDDuJfY1IvG9nD8BPdKYO7bXq1sBBotsQO78Vj9s1DMy/nSD6rke58QxsLvjyG87WTthshLAPg3QFvtDVOso5xLwW61HSFSRQXH/5h5YsNMPHqmVw0YyuqiEheyBOlaCdRKz8iu2Q7x5O6hxAlOyiXEOA4Wiu8AMidNNug+wGexOMzhma0g/k8CwMUblBanMmlajQGXFID8sIiBDJ90vCRRAXAnNUbj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUAwCkmCiLOambUC64l6PcsWnGdAL0Sdj4lcKPA2rNk=;
 b=ccYEtimqXBfSV0djVoheseYIem/BSkDQOz+1RpE92znYlMpQQ+zWmOliEwm0r3OMeWmeGXYrontCl3kmLE1ILppCW4zEtMv60turZ9rkGjZ5suDTeb0e1y5dD4rs7YQkNf0Ju4PcJfHmQYBY6nZ8GzLqgZObV0ZM6aA/i+/1fa4=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4688.namprd13.prod.outlook.com (2603:10b6:5:297::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12; Wed, 9 Jun
 2021 15:19:14 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.009; Wed, 9 Jun 2021
 15:19:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "mwakabayashi@vmware.com" <mwakabayashi@vmware.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAaE+IIAAD42AgAAJxACAABE5gIAACV4AgBto8YCAAHPjgIAA35YAgACW/wCAAAK2AIAABVSAgAAFRQA=
Date:   Wed, 9 Jun 2021 15:19:14 +0000
Message-ID: <ccf0a71f3e8ffb483ea8dea2d3947d833a992d18.camel@hammerspace.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
         <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
         <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
         <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
         <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
         <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
         <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
         <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
         <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
         <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
         <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
         <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
         <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
         <752114495b47624b022bb7de366c6b1771d0599a.camel@hammerspace.com>
         <443A6C4D-28EC-4866-B464-6B04EAF1CF4D@redhat.com>
In-Reply-To: <443A6C4D-28EC-4866-B464-6B04EAF1CF4D@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4da342b4-9c74-4a32-532a-08d92b59f0d3
x-ms-traffictypediagnostic: DS7PR13MB4688:
x-microsoft-antispam-prvs: <DS7PR13MB46882FC56CF00FFAD3028CB7B8369@DS7PR13MB4688.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ib5sOqTuLHLONJ71SdV4b01XRGZhhGjZZsZ2Q0FMvYCbS/6iME3k3xv6Hag5C2XfR1e8jIFQ6QwWOVU9G8wdjmpNJ44PH+SU97kPK76vurduy0ERXlBHaHuxVSe9QLAGUoauIBI5hDBmnkergUM+swWgdnZMKrwME81bbluTALKyO49YWbw347FBBVczyKn2ojdXskexXcNo6mZB5jvrva/FrZNGO0edx0BrF5ldbWaYtaXynHsU2MrjoHUAx4IawAj9dPCMkSxKM2rCU3XRh/NjayALT+B3U0wBJ/0Kmm3x5jESIdm+Bip2BQYk/3bovnHrzNxRPf9GNHUSuyiMXMoDD7c2lHVQvmqjy9jwTQbFBxEULuV3uabl5tTsxNKt80q0LTv+Gb5zdOsnQ0n0q4O14WEjxd7YtauTRVRMdrh54ysHDB8UOrxZWmCzXbWiQYr/qNKj+UvwSEYgG2nb2hOVcWutavjv13XHYAOcvvzyonWaGDE7mpt8TAc0rQ+OIBvQO646lrUS4kHebIBKuBx7/C0vYg0jgrgVWWsacvASw3ICA7oDDnMxN9uOKm3z54AOxt3KZerRgS5Uz3Y66tleczMc24cKEYAoe7rV1dhN/9Tb1aSs47dXU3B+wpvQjfnTGJAB+SbKqtmQ2SDZF3F64gx53/S68pUUoW063d3dkWSKgC6wqNS8KX2c3YO0lY/PPp4a+ONSqBAfwNI1nx6BERgEArHA7z0zxKHjmss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(396003)(346002)(136003)(316002)(86362001)(186003)(6486002)(54906003)(2906002)(36756003)(6916009)(4326008)(26005)(6512007)(6506007)(83380400001)(71200400001)(66946007)(91956017)(76116006)(64756008)(66446008)(8676002)(5660300002)(53546011)(66556008)(966005)(66476007)(478600001)(8936002)(122000001)(38100700002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkc5SzZLdXJRQktWckpSVmE4UGt5Q3RzWEJGOUlKK0gxTXVxMDZ2Zy90N09C?=
 =?utf-8?B?SmR6TDlWWTdpYlR1NVJGNk5rUUJhWDFrRjJlKzRaTldKQ2ZBWHRSOUNwMkUr?=
 =?utf-8?B?SWx5c2UwZ01EVW9nQXFvaFh3b0NsR3luVHYrT3N3MXY1eUZMcnZrU2F5N2F3?=
 =?utf-8?B?UEdMNjdyK01ZZGhpdmpFZjlteWoyUFFqYkM4M0NDYmhJVk1lK3BweUFFL1lu?=
 =?utf-8?B?Mk1MeSswblRpVlRPeW5nUzNqaElnbzl0NytBZytPQUZmQ1Q2clZKM3VwYTlH?=
 =?utf-8?B?R2pURG5IbFpnTWZzeXBqTGNCRkJiMUdIaHJ4Zzg4SmFnVjFHYVA4ak5qUzEr?=
 =?utf-8?B?cVc2cmcrR0hKTmhhTHVFaUJxSWxZY2M1SXJTazFmb215Y3lXVDA3cDhjeUlQ?=
 =?utf-8?B?MUNUZ0JuRmptcDRTNG0rbEV0WEUvVnYyam04V0g3R3EwWDJEbkF1QnNqRkx0?=
 =?utf-8?B?cmE4RzdHcjFsMTlINjB1OUsrZjg5RFlVRkVCOFNBZWV0ZllrQlJQSlZ5OWtU?=
 =?utf-8?B?TnVvaytwZFlGYU9HQXRlazF3OTRHdWhPR3d1UUVXTmZHeVJ3NmxNNDdUVVlu?=
 =?utf-8?B?U1NjbFlacnRGWmxaWWs1Wmh3YWx5Z2FtUUNlV0tsUVYwR3hub05EQjBjOEZ5?=
 =?utf-8?B?SHk2dC9XWm5NU013QVVOMFFxbk1ldTVzYmRFUlhmL2ZuVURRZGQ2NjV4cUov?=
 =?utf-8?B?cFk3UGJkdUtGT3BMcDNYQUo5Zzc4UlJ4OVdvYnJYWFlLdVJBSnk0TDFQU2pD?=
 =?utf-8?B?RUt5Qldxb0YvbENBdnc0OS9OVzlXbk5YQmJyY3J6K05LNyt5ZkpiNXcvbVkw?=
 =?utf-8?B?WGYzcHZUVEtJYWNwQjlwc0t5SHpXNjVPVG9SZGgzU3lkWDE2M2QwVEJFMHIv?=
 =?utf-8?B?ZWJka3dYekg3KzRiWnhDa2IxY3NhdDN2V2RieEc1T3E0YytwN1FuUU1OQVY4?=
 =?utf-8?B?cUFSbllSbDlBcE9XY0JLU3IxWFhsNExGK0dRTzFoaWM2YTVPRVM1Q3k1Mklm?=
 =?utf-8?B?eGlIeDh1YkRCZWRxMWlsRFhoOGY3alNkUFMrL0NHREpEVkdqSDdMOXRtYVRM?=
 =?utf-8?B?ampTYWFDSThvcVVJY2VhRlRsSWdDNkNkMlp1MDkxNzl6NUcrSkxhR3lZaExZ?=
 =?utf-8?B?dGE5WUNZOS83cmhLRTJQZkxqd2JBOFczVEd3ZlVCVk4zM2kzTGFoT1VlKzdZ?=
 =?utf-8?B?Znp4VnVvQXRDTmtSNTE0NzFpVWxDS0lZTVI2T25Tdi9WUFV2Ykhzamh1TmpP?=
 =?utf-8?B?Y08rQVdsNlUwK1ZuMld5MnBXTG1ZRnBSTy9SU0pZVUlsZ0NmcVkxOFA1cnZY?=
 =?utf-8?B?RzNQMEtFNUlxbHdZbmZsODNZekRGcTUraVF2QytreG1uVTZsaDBqdDhIOUlp?=
 =?utf-8?B?eU1JcW82ZWJqNERMZlZYa0NQNXVGRTRaTVhqSktPbytTdDgvbGV6WmhFWFJk?=
 =?utf-8?B?c213U2NPSEVoWTFVVlNhTTVkRDhhTEQ0OW5aTlVUQUo0ZDMzZDU3ZkZuT2hv?=
 =?utf-8?B?c0pDTmJ0anBMbnA3WFUxZzBCN3lxTXkvWmY1Q1BKRkFiRzlEZ2R2ZDg1R2J1?=
 =?utf-8?B?NHIzK1pnZTdCTkxrRG91eFpzcWdHdHdGbmd3a2p4S3JaV1hRTWZYQ09YYlhE?=
 =?utf-8?B?SDVYYnRjQjNXeG9SZ3NCYjFHci9IcGg5WjdZNkVma2NPTjdKV0g5blRGMmlq?=
 =?utf-8?B?TzU4MWxua0wzMllGM2I2ZFdBY09VSGJLc09BRTY4dVRXOEpBZUI3RUhTcWY0?=
 =?utf-8?B?akNOT21hcUgyRGJtUEppRnZKK2dsV3VIYjVTdXk0bmJmR3QzSTVHcGhmZWYx?=
 =?utf-8?B?WmQzWjFlOVFldkdpd2hZUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDB3B4334D915441AEA099FC6B19301D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da342b4-9c74-4a32-532a-08d92b59f0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 15:19:14.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbm3qZr/qu0CS8acM3QsYSUxgfbjJk3QKYsnRxgsZDNeiGRLKDzdB00PW87JCmN5dEtmUTrcdO50ptRgdsSmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4688
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTA5IGF0IDExOjAwIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA5IEp1biAyMDIxLCBhdCAxMDo0MSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBXZWQsIDIwMjEtMDYtMDkgYXQgMTA6MzEgLTA0MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiANCj4gPiA+IEl0J3Mgbm90IGRpc3B1dGVkIHRoYXQgbW91bnRz
IHdhaXRpbmcgb24gdGhlIHRyYW5zcG9ydCBsYXllciB3aWxsDQo+ID4gPiBibG9jaw0KPiA+ID4g
b3RoZXIgbW91bnRzLg0KPiA+ID4gDQo+ID4gPiBJdCBtaWdodCBiZSBhYmxlIHRvIGJlIGNoYW5n
ZWQ6wqAgdGhlcmUncyB0aGlzIHRvcmNoOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbmZzLzg3Mzc4b21sZDQuZnNmQG5vdGFiZW5lLm5laWwuYnJvd24ubmFtZS8NCj4gPiA+
IA0KPiA+IA0KPiA+IE5vLg0KPiA+IA0KPiA+ID4gLi5vciB0aGVyZSBtYXkgYmUgYW5vdGhlciB3
YXkgd2UgZG9uJ3QgaGF2ZSB0byB3YWl0IC4uDQo+ID4gPiANCj4gPiANCj4gPiBPSy4gU28gbGV0
J3MgbG9vayBhdCBob3cgd2UgY2FuIHNvbHZlIHRoZSBwcm9ibGVtIG9mIHRoZSBpbml0aWFsDQo+
ID4gY29ubmVjdGlvbiB0byB0aGUgc2VydmVyIHRpbWluZyBvdXQgYW5kIGNhdXNpbmcgaGFuZ3Mg
aW4NCj4gPiBuZnM0MV93YWxrX2NsaWVudF9saXN0KCksIGFuZCBsZWF2ZSBhc2lkZSBhbnkgb3Ro
ZXIgY29ybmVyIGNhc2UNCj4gPiBwcm9ibGVtcyAoc3VjaCBhcyB0aGUgc2VydmVyIGdvaW5nIGRv
d24gd2hpbGUgd2UncmUgbW91bnRpbmcpLg0KPiA+IA0KPiA+IEhvdyBhYm91dCBzb21ldGhpbmcg
bGlrZSB0aGUgZm9sbG93aW5nIChjb21waWxlIHRlc3RlZCBvbmx5KSBwYXRjaD8NCj4gDQo+IEl0
IHdvcmtzIGFzIGludGVuZGVkIGZvciB0aGlzIGNhc2UsIGJ1dCBJIGRvbid0IGhhdmUgbXkgaGVh
ZCB3cmFwcGVkDQo+IGFyb3VuZA0KPiB0aGUgaW1wbGljYXRpb25zIG9mIHRoZSBjaGFuZ2UgeWV0
Lg0KPiANCg0KVGhlIG1haW4gaW1wbGljYXRpb25zIGFyZSB0aGF0IGlmIHlvdSBoYXZlIDEwMCBt
b3VudHMgYWxsIGdvaW5nIHRvIHRoZQ0Kc2FtZSBzZXJ2ZXIgdGhhdCBpcyBkb3duLCB0aGVuIHlv
dSdsbCBnZXQgMTAwIGNvbm5lY3Rpb24gYXR0ZW1wdHMuIElmDQp0aGUgc2VydmVyIGlzIHVwLCBi
dXQgaGFzIHdvbmt5IHJwYy5nc3NkIHNlcnZpY2UsIHRoZW4geW91J2xsIGdldCAxMDANCmF0dGVt
cHRzIHRvIHNldCB1cCBrcmI1aS4uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
