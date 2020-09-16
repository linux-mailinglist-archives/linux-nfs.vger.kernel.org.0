Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D377026CF14
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIPWsW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:48:22 -0400
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:6369
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbgIPWsU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Sep 2020 18:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPuhEarp+P8id2/L5rnrVY0A9wVMkAy2vPXm+hJ4KGh8Yt509oK8l9w0uiiU4ACcCEiZKSRSoMfYzbWUtZPMMD6WxWXY+LV+ZWKy7TYoxfMX+J44iTNk+ztFJhZYtCHlWIP7aMIFZ0aksxLUK9EY8ZGLcU9elS8TlJdsBmfJM1ifTc1X/8jtbh/Sf6x4RXHkwqzUa/INKuKwjLq6c8Jg/lbnVJKZw5YeuI8rpMQHlIaWdZPd8ftQBZL4cWEfCCGbeujENaj76ugTS59k/0Evo/IEgDLK/1RoNcj6oG81p4X4oypUC0SRhmYmh2dTcyGzmJmDvyZ5jam9luNtevfMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMfebX+g3+GRjJLekDqW+iIkkPsOCGZ2MZ3y9vlWYEI=;
 b=JVtu0QefhZfDc9Qvxn5VPZ8njRuZWb18lk+TUqfzEs9/h643FUe3xWBetmtQ1IuZ9761NI03trX7XjGy1SpdKwLh+U+Jm/xsfFg57KV6demQZD301GQbbiMNWKwQOp1CY5S+m195ACd13R7MsHFg3l3jxzvnuc5+MdJBa+1tVc126xTz3Ct4V7RdjgZW8AsC6SvuWRSJcetJO0P+f7NjDzfMVV8OYe0mDciN5A7xz4l2aJDb5oAojduGAEZ4h2Lf4bQfdhfasC8i5NnnIygKlrUI9R5vj48ogZqU6PUKoZKTemkLCatvPLnz0IMNaeqepr9EqvnLNxiSdZQHFB7FTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMfebX+g3+GRjJLekDqW+iIkkPsOCGZ2MZ3y9vlWYEI=;
 b=a0sg1sl8G0l0QokzkPwot8S5d87xTDYivHGz0zJNXuzN/6vtoN39GdnEa+ghwk7P36Z9lfSGAhqsxMFgopBGWur0M7drm2itovr4+w3KuUJC3EQuU8HlknE9TNUC8qIoBBqmEewcqK8QWAosvZcEtvkBpfcP7V7iIY9we9QKA88=
Received: from SG2P153MB0231.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::20) by
 SG2P153MB0126.APCP153.PROD.OUTLOOK.COM (2603:1096:3:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.1; Wed, 16 Sep 2020 22:48:14 +0000
Received: from SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
 ([fe80::8d7a:7c12:788:af5]) by SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
 ([fe80::8d7a:7c12:788:af5%6]) with mapi id 15.20.3412.007; Wed, 16 Sep 2020
 22:48:14 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: RE: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Topic: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Index: AdaLdYAHSfC4FmukRxSfbPzbpNbQ4QAw4uWAAAEERFAAApxggAALNM4A
Date:   Wed, 16 Sep 2020 22:48:14 +0000
Message-ID: <SG2P153MB0231CB0FE679419306303FC59E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
         <1fdce3fc0981916f8d3829933db61a3f78aebde3.camel@hammerspace.com>
         <SG2P153MB023125DD453D879416DDBA389E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
 <6c1b52e4eceba8bac7d60cc92470ae80b3846d6a.camel@hammerspace.com>
In-Reply-To: <6c1b52e4eceba8bac7d60cc92470ae80b3846d6a.camel@hammerspace.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a53ef6d6-ab21-4c94-a10c-1cd0fe2b9c61;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-16T21:57:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.179.61.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21b9206b-8def-4861-4619-08d85a9298b0
x-ms-traffictypediagnostic: SG2P153MB0126:
x-microsoft-antispam-prvs: <SG2P153MB0126ACF3C7B3582D863D80DB9E210@SG2P153MB0126.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgwHcnX1+rUMBZXoffbpRdEyL6BKPBX6Szi+Kr/3SZapNTuQki+Mw0w5EJHCaWs+OzpMOwYLK3+3BHez9lRNX/jxBfrJbQVgh4DKTkcVGOIvCFj9s9t4JfxzlV3Vkgxe1GlsRDfibDvYn928oL4ODSHWt/2yOKof8gxjaVK0j7TlaFH+kkvW0EBGRaveFjqKRpFMOhmpKJpp0x3tQ4fIRpfu8acHV8Z/roMwq0IdxuBVzdmunZb9yb1tvbxLFTtmOrJo7x+YIItfEIH5gxTGhcKVLCNV4KSoPfrrpBXRuAUJrh9TVsSnB4WhGLcu8h+up3EIW7QV8cD9UKQ5kx563zWMvXb3bSepL02g7qmbd0otyOWCla4eXzqogMTQOLjm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0231.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(76116006)(8990500004)(66946007)(9686003)(52536014)(66476007)(55016002)(66446008)(64756008)(66556008)(10290500003)(186003)(6506007)(5660300002)(86362001)(110136005)(26005)(478600001)(7696005)(82950400001)(82960400001)(8676002)(4326008)(316002)(71200400001)(33656002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 39fNOR+xpIdPE8N7shGeYozCIRifQnbdKMjQ/uxk3CEIoB8RGq+sN+yAtPdLZ86ktGWaK6AlyUxGe7uCHlgdXj2XENIDzoqQXoF+6fOaLy4oGJvJgke9kJovYuQtZu+r3eDAnMJdkQeCqCSr4jfV2g8tp7eqPBJ5mh+vgL7q80jMdbVmhJhoudqnY20geJihwFKtB1DBQOIznmThJTMnUu/zlSH35Sfk5mTGFZWx64xDChgnUWQlMQrGFDO0sVjQugR4fOiNcGeXz23mC8wT5zS2di4FJok33M0fMczXCdv0L0T4VIV5FBPghtiS4hyz6CLvwMao8Y9nsuWc1iQFBgDrIDlV2dRuylhkBxpL56NJCkmUNG8tgU6OVS0ysxmhbjpVjJYKJjVO047dDyGGYmrMv36FW22vveK1BiJpZd6HQwU55op5EjGB7gAeB/87dRgF2pouc7TqLfkHeYZHEpB/ad07Ldy7RtVP1RQzVqaYtEx2kZVw2YCUD7LjIKXDaXpVsMmqXxhUiuJVeKIooD7VWrT46rzXOEYdci650DY04lAu9NVhU4PbiReMf6Lc3tJKp68chlPQBhrvPzGXGesncPK6oWtltEV4sgHCFZ4fqSllfnXHtpMI4BXLfwpriUELz9roPA2YEhr8yHUaVA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0231.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b9206b-8def-4861-4619-08d85a9298b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 22:48:14.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXyCU5oAhKvgzFM49C0+MNxRlwqAvLbw+LvUUxvpUE6uqROC+uRQfr8eXFU2rQBK1LYdY1fGiBX422t7X0mfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBUcm9uZC4NCg0KPiBOb3RlIHRoYXQgdGhlcmUgdGhl
cmUgaXMgbm8gUkZDIDIxMTkgbm9ybWF0aXZlIE1VU1Qgb3IgZXZlbiBhIFNIT1VMRC4NCj4gV2Ug
dGhlcmVmb3JlIGV4cGVjdCB0byBiZSBhYmxlIHRvIHJldXNlIHRoZSBjb29raWUgdmVyaWZpZXIg
d2l0aCBhIHplcm8NCj4gY29va2llIGluIG9yZGVyIHRvIHZhbGlkYXRlIHRoYXQgdGhlIGNvb2tp
ZXMgdGhhdCBvdXIgY2xpZW50IG1heSBzdGlsbA0KPiBiZSBjYWNoaW5nIChlLmcuIGluIGFub3Ro
ZXIgb3BlbiBmaWxlIGNvbnRleHQpIGFyZSBnb29kLg0KPiBFaXRoZXIgd2F5LCBhcyBJIHNhaWQg
cHJldmlvdXNseSwgdGhlIHBhdGNoIGlzIGluY29ycmVjdCBzaW5jZSBpdCBpcw0KPiBzZXR0aW5n
IHRoZSB2ZXJpZmllciB0byB6ZXJvIGluIGEgY29udGV4dCB3aGVyZSBpdCBjYW5ub3QgZ3VhcmFu
dGVlDQo+IHRoYXQgdGhlIG5leHQgY29va2llIHNlbnQgaW4gYSBSRUFERElSIGNhbGwgd2lsbCBi
ZSBhIHplcm8uIA0KDQpQbHMgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIG5vdCBj
b3JyZWN0LCBidXQgc2luY2Ugd2Ugc3RvcmUgdGhlIA0KY29va2lldmVyZiBpbiB0aGUgaW5vZGUg
KHNoYXJlZCBieSBhbGwgb3BlbiBjb250ZXh0cyksIHdoaWxlIGV2ZXJ5IG9wZW4NCmNvbnRleHQg
aGFzIGl0cyBvd24gZGlyX2Nvb2tpZSwgYWxsIGNoYW5nZXMgdG8gY29va2lldmVyZiAgX2FyZV8g
YmVpbmcgZG9uZQ0KcmVnYXJkbGVzcyBvZiB0aGUgZGlyX2Nvb2tpZSB2YWx1ZSBoZWxkIGJ5IG90
aGVyIG9wZW4gY29udGV4dHMuIElmIGFmdGVyIHRoZQ0KY29va2lldmVyZiBjaGFuZ2UsIGFuIG9w
ZW4gY29udGV4dCdzIGNvb2tpdmVyZiBhbmQgY29va2llIGNvbWJpbmF0aW9uDQpiZWNvbWVzIGlu
dmFsaWQgYXQgdGhlIHNlcnZlciwgdGhhdCBvcGVuIGNvbnRleHQgZGVhbHMgd2l0aCB0aGUgRUJB
RENPT0tJRSANCmFzIGFwcHJvcHJpYXRlLg0KZi5lLiBuZnNfemFwX2NhY2hlc19sb2NrZWQoKSBh
bHNvIGNsZWFycyBjb29raWV2ZXJmIHdoZW4gdGhlIGRpciBjYWNoZSBpcw0KemFwcGVkLCBpcnJl
c3BlY3RpdmUgb2Ygb3RoZXIgb3BlbiBjb250ZXh0cy4NCg0KQWxzbywgc2luY2Ugd2UgZGlkIGlu
dGVuZCB0byBzZXQgdGhlIGNvb2tpZXZlcmYgdG8gMCBpbiBuZnNfaW52YWxpZGF0ZV9tYXBwaW5n
KCksDQpqdXN0IHRoYXQgaWYgdGhlIGRpciBjYWNoZSBoYXBwZW5zIHRvIGJlIGFscmVhZHkgcHVy
Z2VkIChzYXkgYnkgYW4gdW5yZWxhdGVkDQp2bSAgcmVjbGFpbSksIHdlIGNhbmNlbCB0aGUgaW52
YWxpZGF0aW9uLiBUaGlzIGNhdXNlcyB1cyB0byB1c2UgdGhlIG9sZA0Kbm9uLXplcm8gY29va2l2
ZXJmLCBhIGRpZmZlcmVudCBiZWhhdmlvciB0aGFuIGlmIHRoZSBkaXIgY2FjaGUgd2FzIG5vdA0K
cHVyZ2VkLg0KSXMgdGhpcyBvayA/IElzbid0IGl0IGJldHRlciB0byBjb25zaXN0ZW50bHkgdXNl
IHplcm8gY29va2lldmVyZiBpbiBib3RoIGNhc2VzID8NCg0KVGhhbmtzLA0KVG9tYXINCg0KDQo=
