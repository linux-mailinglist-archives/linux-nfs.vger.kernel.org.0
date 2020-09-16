Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006E26CDAA
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIPVDT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 17:03:19 -0400
Received: from mail-eopbgr1310134.outbound.protection.outlook.com ([40.107.131.134]:37515
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgIPQPD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLw9oOZSd69TDu1T52StBW9Gyl/DtsNPPa5gsCmVx9emDls2QOP+AEx4qoZOiV5OBG3JIMiEpOLpZAU8M/raDaiFaABQxEu7UBOEQ/8fGl3jje8fl2y/Pv1LPkcXIucUyamvdQ6Sru4HfvxMlhgfdEDSKVfCfPfk/KkoVjpXRYB79Qeh52jxUh3BiD44out+9dCG3I4NMAgoN5VnMKuFVwZW3wY6o1vP3HXaKOksjRpl6qsS7roNz6O2iwbyTYzBVE+zHnAhV7Ji5Mvomo42jU5fyJD1xmhlYVJHPRLKZh3pGHUy2ro5wdKMeG5b8lK4nCOW5HK8S9jzdSei66Z87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpuJKWQ9ZKOOEC+rjXetyAbZgrOf2QJzeUNh0SOYo4c=;
 b=YzMfY1XvujJ5eniU9trx1+z1JFm7ZkW+MrZfz6mlwSvwQ6uGm6K94LXKJRRGklrS/MDJ/rq0+WozxQ4rUcG2GST04EVSBHOod5FNvoA9fiksnwQYd3M/jpabzxTXk9T80H+huNSXRh2A3dsj5Ov5MSngGgnOGJNQYDKIgjdqXwUx0VxKCoN5PKIfWVcRL1a6hQOqw/QHdZ/7fDfmPawakZB5BYHLwFMJM/npfNN5tAm1wxVubrikIcYNEMjDzxt5j1el7PRFK8tGjrWdaytQzJi/xdpAYo66vk/RPm1c9oEbPbraN6riKHJEwxKk8YY0cfM2p1JZj759L0voyOnXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpuJKWQ9ZKOOEC+rjXetyAbZgrOf2QJzeUNh0SOYo4c=;
 b=E3v6MeWyV8OFe8wLF+j3/Ldd6GYk9pRO20cmX4VABXCZWAkILWtcGZjBEsrMg0iI8dJwmr6f0NT54umAwtrwcbopKRdAtYApgpq960AHfNoZDm68P4qUXdv3C4I63N0RBB3KPYK3JJrwCyxqmblcPeoILHKafOVEtaMep6YUEhE=
Received: from SG2P153MB0231.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::20) by
 SG2P153MB0253.APCP153.PROD.OUTLOOK.COM (2603:1096:4:df::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.3; Wed, 16 Sep 2020 15:58:15 +0000
Received: from SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
 ([fe80::8d7a:7c12:788:af5]) by SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
 ([fe80::8d7a:7c12:788:af5%6]) with mapi id 15.20.3412.003; Wed, 16 Sep 2020
 15:58:15 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: RE: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Topic: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Index: AdaLdYAHSfC4FmukRxSfbPzbpNbQ4QAw4uWAAAEERFA=
Date:   Wed, 16 Sep 2020 15:58:14 +0000
Message-ID: <SG2P153MB023125DD453D879416DDBA389E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
 <1fdce3fc0981916f8d3829933db61a3f78aebde3.camel@hammerspace.com>
In-Reply-To: <1fdce3fc0981916f8d3829933db61a3f78aebde3.camel@hammerspace.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42a4dd77-58b5-4f31-b5a0-7a65a5d6a6e8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-16T15:21:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.179.61.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4a10c4a-b1cc-4352-c31c-08d85a59525c
x-ms-traffictypediagnostic: SG2P153MB0253:
x-microsoft-antispam-prvs: <SG2P153MB0253939ABFF653B5793DA13F9E210@SG2P153MB0253.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqXSGm0akN2n8afU6mimTICTRI4PcAI2vD2ePzdB3u08MeTsEMn8MCzS4sPsgHnwJOXOnUNPjR0XYNq6FSFia+Vn/4Riz6LP5NH/4hOYyi2xSeYgsXdtDkyToPblg9FRlCUE7fifq4Lzjqea1YlXhit+Pbp5aG2bXFk5C1UmwdNnEMgBQs+Q9REGB9qxWlZe8iQQicJHjZp+YBgdv9gDt3qz2cJLrIT89EmMmhb1CbLgEr3ZFK9SW7trkwgVRI79YC/5m6nBJqkvKXeYttm9HBn+7qcUlJxBs8S/sRkDuiEovJYNgMrs+MW6YBXeKoB0/o4TrzRT3yqbVtDdJDsdG+ZZXhNsUkHoijM6r6zk/ucL105XFx3Xcf+/gYZuNQoH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0231.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(186003)(8676002)(55016002)(64756008)(66446008)(9686003)(71200400001)(66476007)(66556008)(478600001)(316002)(2906002)(66946007)(86362001)(52536014)(8990500004)(4326008)(10290500003)(8936002)(82960400001)(5660300002)(83380400001)(110136005)(7696005)(82950400001)(53546011)(6506007)(26005)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GI28lOXDxhUlbM4XMg2VMAMTZEoSLqyiq9lbXTU7alqsMyhD2KoUEsriL4NEVRajtjYeAfYEtELZhG9pkJXOWHkvr1N1bKFOt1ed0t2WdZV4D0z9sC8l9WlXcLLOrVlgighGdbh1Q6xJ7cGqqMwUrXKmQ43Equr+j2ietiabPmiysx5wskyEYDcgNwqTGQWcrzVaIOQSwJmay4Nrl3hOCuN9mYICczPgtQZlvbNh55caDkvfnugPYEbo0sJPfIOISO5Nuffua1vKdAdeSmzOuZzH2YWr3tTnE732Cof2VfKROwTX8mCJBt4CCyrxCmuSaHGOl1veYUMuuy/rVJQXckfz9V95bFtLK5ecPXxKNr/+ZbNLqRCc10N7sifvT0+jjc3IofA62P6yLVbXnxYbxSMkIXcZb9YN9WYaGTZu8gs6CGlEou69LeW7fnsu94wMNeMHFIaEV1pjXfmNJt+TufIEbDLz5AvwPnQ+NCo8Cw5mugCezpM+VqQIPQZhe2Ub/sXdvnUIMOBrIqoMxQBKFi6cSUAzBXPauNsIkYLj/ZKusbm8dWBs9flv9t8YoOWH8p2Gnv1gxuNdAm+LaZwhLOIdKtT/P1ZzyURqzBS2FIsKoZZpa6R7aM3x9bFUyS2bsqC5+2hqyiamek9BPwhrDQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a10c4a-b1cc-4352-c31c-08d85a59525c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 15:58:14.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/2rjyLoe5wsVuD0S+sPUldFF7YgmO0+mtZQS0VFN51Xxuh2MDqZ//mXMO7P5830oqk7Xno+7qaBGGEMNRAY4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0253
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBUcm9uZC4NCg0KVGhpcyBpcyB3aGF0IGhhcHBlbnMg
dy9vIHRoaXMgcGF0Y2guIExldHMgdGFrZSB0aGUgY2FzZSBvZiBuZXcgZmlsZSBiZWluZyANCmNy
ZWF0ZWQuICANCg0KbmZzM19kb19jcmVhdGUoKS0+DQpuZnNfcG9zdF9vcF91cGRhdGVfaW5vZGUo
KS0+DQpuZnNfcG9zdF9vcF91cGRhdGVfaW5vZGVfbG9ja2VkKCksIHNldHMgTkZTX0lOT19JTlZB
TElEX0RBVEEgdG8NCm1hcmsgdGhlIGNhY2hlZCBkaXJlY3RvcnkgZGF0YSBhcyBpbnZhbGlkLCBz
byB0aGF0IGxhdGVyIHdoZW4gd2UgZG8gYSByZWFkZGlyLCANCg0KbmZzX3JlYWRkaXIoKS0+DQpu
ZnNfcmV2YWxpZGF0ZV9tYXBwaW5nKCktPg0KbmZzX2ludmFsaWRhdGVfbWFwcGluZygpLCB1bm1h
cHMgdGhlIG1hcHBpbmcgKmFuZCogcmVzZXRzIHRoZSBjb29raWV2ZXJmLg0KDQpUaGlzIGNhdXNl
cyB1cyB0byBjb3JyZWN0bHkgYXNrIGZvciBmcmVzaCBkaXIgY29udGVudHMgdXNpbmcgYSBjb29r
aWV2ZXJmPTANCmFuZCBjb29raWU9MCAoZXhhY3RseSB3aGF0IHRoZSBSRkMgZXhwZWN0cyB1cyB0
byBkbykuIEFsbCBnb29kIHRpbGwgaGVyZS4NCk5vdyBjb25zaWRlciB0aGUgY2FzZSB3aGVyZSAN
Cm5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9sb2NrZWQoKS0+bmZzX3NldF9jYWNoZV9pbnZhbGlk
KCkgZm91bmQgdGhhdCBkaXINCnBhZ2VzIGFyZSBhbHJlYWR5IHVubWFwcGVkLiBUb2RheSB3ZSBq
dXN0IGNsZWFyIHRoZSBORlNfSU5PX0lOVkFMSURfREFUQQ0KZmxhZyBzaW5jZSB3ZSBub3RlIHRo
YXQgbm8gY2FjaGVkIGRpciBwYWdlcyBhbmQgaGVuY2Ugbm8gaW52YWxpZGF0aW9uIG5lZWRlZC4g
DQpXaXRob3V0IHRoZSBORlNfSU5PX0lOVkFMSURfREFUQSwgbmZzX3JlYWRkaXIoKSBub3cgbWFr
ZXMgYSBSRUFERElSIFJQQw0Kd2l0aCBhIG5vbi16ZXJvIGNvb2tpZXZlcmYgYW5kIGNvb2tpZT0w
LiBUaGlzIGlzIG5vbi1zdGFuZGFyZCBjb21iaW5hdGlvbiBvZiANCmNvb2tpdmVyZiBhbmQgY29v
a2llIGZvciBhc2tpbmcgZnJlc2ggZGlyIGNvbnRlbnRzLg0KTm90ZSB0aGF0IHNlcnZlcnMgdGhh
dCBkb24ndCBjYXJlIGFib3V0IHRoZSBjb29raWV2ZXJmIGRvIG5vdCBjYXJlIGFib3V0IHRoaXMN
Cm5vbi1zdGFuZGFyZCBjb21iaW5hdGlvbiBhbmQgdGhleSB3b3JrIGZpbmUgdy9vIHRoZSBwYXRj
aCwgYnV0IHNlcnZlcnMgdGhhdA0Kd2FudCBjb29raWV2ZXJmIHRvIGJlIDAgdG8gc2lnbmFsIGZy
ZXNoIGRpciByZWFkIG1heSBub3QgdHJlYXQgaXQgd2VsbC4NCg0KVGhlIHBhdGNoIHRyaWVzIHRv
IG1ha2Ugc3VyZSB0aGF0IHdlIHJlc2V0IHRoZSBjb29raWV2ZXJmIGV2ZW4gZm9yIHRoZSBjYXNl
DQp3aGVyZSBkaXIgcGFnZXMgc29tZWhvdyBnb3QgcHVyZ2VkIHdoZW4gd2UgcmVhY2hlZCBuZnNf
c2V0X2NhY2hlX2ludmFsaWQoKQ0KYWJvdmUuDQpJIGZlbHQgbmZzX3NldF9jYWNoZV9pbnZhbGlk
KCkgaXMgdGhlIHJpZ2h0IHBsYWNlIHRvIHJlc2V0IHRoZSBjb29raXZlcmYsIGFzIA0Kd2hlbmV2
ZXIgIHdlIHNldCBkaXIgY2FjaGUgYXMgaW52YWxpZCwgb24gbmV4dCByZWFkZGlyIHdlIHdvdWxk
IGxpa2UgdG8gcmVhZCANCnRoZSBlbnRpcmUgZGlyICBmcm9tIHRoZSBzZXJ2ZXIgYW5kIGZvciB0
aGF0IHdlIG5lZWQgdG8gc2VuZCBjb29raWV2ZXJmPTAuDQoNCj4gU28gdGhlIHJpZ2h0IHBsYWNl
IHRvIGRvIHRoaXMgc2V0L3Jlc2V0IG9mIHRoZSB2ZXJpZmllciBpcyBpbiB0aGUgcmVhZGRpciBj
b2RlDQoNClllcywgYnV0IHdlIGRvbid0IGRvIHRoYXQgaWYgdGhlIE5GU19JTk9fSU5WQUxJRF9E
QVRBIGlzIG5vdCBzZXQuDQoNClRoYW5rcywNClRvbWFyDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiAN
ClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE2LCAyMDIwIDg6MjMgUE0NClRvOiBsaW51eC1u
ZnNAdmdlci5rZXJuZWwub3JnOyBOYWdlbmRyYSBUb21hciA8TmFnZW5kcmEuVG9tYXJAbWljcm9z
b2Z0LmNvbT4NCkNjOiBhbm5hLnNjaHVtYWtlckBuZXRhcHAuY29tDQpTdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiBbUEFUQ0hdIG5mczogcmVzZXQgY29va2lldmVyZiBldmVuIHdoZW4gbm8gY2FjaGVk
IHBhZ2VzDQoNCk9uIFR1ZSwgMjAyMC0wOS0xNSBhdCAxNTozMyArMDAwMCwgTmFnZW5kcmEgVG9t
YXIgd3JvdGU6DQo+IEZyb206IE5hZ2VuZHJhIFMgVG9tYXIgPG5hdG9tYXJAbWljcm9zb2Z0LmNv
bT4NCj4gDQo+IElmIE5GU19JTk9fSU5WQUxJRF9EQVRBIGNhY2hlX3ZhbGlkaXR5IGZsYWcgaXMg
c2V0LCBhIHN1YnNlcXVlbnQgY2FsbA0KPiB0byBuZnNfaW52YWxpZGF0ZV9tYXBwaW5nKCkgZG9l
cyB0aGUgZm9sbG93aW5nIHR3byB0aGluZ3M6DQo+IA0KPiAgMS4gQ2xlYXJzIG1hcHBpbmcuDQo+
ICAyLiBSZXNldHMgY29va2lldmVyZiB0byAwLCBpZiBpbm9kZSByZWZlcnMgdG8gYSBkaXJlY3Rv
cnkuDQo+IA0KPiBJZiB0aGVyZSBhcmUgbm8gbWFwcGVkIHBhZ2VzLCB3ZSBkb24ndCBuZWVkICMx
LCBidXQgd2Ugc3RpbGwgbmVlZCAjMi4NCg0KSSBkb24ndCB0aGluayB0aGlzIHBhdGNoIGlzIGNv
cnJlY3QuDQoNCkZpcnN0bHksIHdlIGRvbid0IHN1cHBvcnQgc2VydmVycyB0aGF0IHVzZSBub24t
cGVyc2lzdGVudCByZWFkZGlyDQpjb29raWVzLCBzbyBpZiB0aGUgY29va2lldmVyZiBjaGFuZ2Vz
IG9uIHRoZSBzZXJ2ZXIsIHRoZW4gd2UncmUgbm90DQpnb2luZyB0byBiZWhhdmUgY29ycmVjdGx5
IHcuci50LiBleHBlY3RlZCBQT1NJWCByZWFkZGlyKCkgYmVoYXZpb3VyLg0KDQpTZWNvbmRseSwg
ZXZlbiBpZiB3ZSBkaWQgc3VwcG9ydCBub24tcGVyc2lzdGVudCBjb29raWVzLCB0aGVuIHRoZSBO
RlMNCnNwZWMgc2F5cyB0aGF0IHdlIG5lZWQgdG8gc2V0IHRoZSB2ZXJpZmllciB0byB6ZXJvIHdo
ZW4gd2UgYXJlIGNhY2hpbmcNCm5vIHJlYWRkaXIgY29va2llcyB0aGF0IG5lZWQgdmFsaWRhdGlv
biwgYW5kIHdlIGFyZSByZWFkaW5nIHRoZSBlbnRpcmUNCmRpcmVjdG9yeSBiYWNrIGZyb20gc2Ny
YXRjaCAoaS5lLiB3ZSdyZSBhbHNvIHN1cHBseWluZyBhIHplcm8NCmRpcl9jb29raWUpLiBTbyB0
aGUgcmlnaHQgcGxhY2UgdG8gZG8gdGhpcyBzZXQvcmVzZXQgb2YgdGhlIHZlcmlmaWVyIGlzDQpp
biB0aGUgcmVhZGRpciBjb2RlLCB3aGljaCBrbm93cyBub3Qgb25seSB0aGUgc3RhdGUgb2Ygb3Vy
IGNhY2hlLCBidXQNCmFsc28ga25vdyB3aGF0IHdlJ3JlIHNlbmRpbmcgYXMgUlBDIGNhbGwgYXJn
dW1lbnRzLg0KDQpDaGVlcnMNCiAgVHJvbmQNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
