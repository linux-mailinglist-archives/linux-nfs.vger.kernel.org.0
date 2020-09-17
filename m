Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01826DE31
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgIQO04 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 10:26:56 -0400
Received: from mail-eopbgr760132.outbound.protection.outlook.com ([40.107.76.132]:57063
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbgIQOZt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Sep 2020 10:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4n77ICd9G+aBp4IGbgOtN8C9FRpP0amqnvxfQ512aTTeV/9tcK8c218IH4+M40MyYfx0S5vCzze8XaPtexT3mg2nM383mWAdDLo4HGbdtBdHZcl/4TgyAlSgtAkegbzAk5S12O/9cjVHHs9KCUMfraWLoEtmwcP1m3bGCBHwe7Ve/MFZ02E+SWtD6w/Vka3eNUJ1MjqPYVl+hlvYFdHldXOICewwGFYpsU2Yf91imUOFcFWmDeJyYsoftX41zrgRQ/Uqz+QAHDNpLPxtUE6i4agHnChP2P51FWshh2mP2+Lhr+BSYEb3cnJ27Pq7eamkG3hk1Vnd7tIH4mT/TTf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0NLE4cmMN5OSpR0dFtBPQCxMB7dZoTHUy5Ne8O80B8=;
 b=XrfMLsQdCjbiXKpUT6KL/Zljxa50gNoSMMemf8jfTrw9Zmi2ZV8CdsLBugwSU3L2cwXzQH4c0psAO8YCuCuiz7yO/MSfTbXc84QYdJGMX4/I7VCTma4s5pX/T56lxsGU059aa4RfsDr5XlqjP6BjiYZtQ0gGJDR/XeBkEyiYeuJ660I9c218QTq2HxraW6nMRxyRxHGIIKzA4Ghlxgt9ONdScaYSLHhrIFtDMutO1Q6J9i63DOHbWlvBpp3BehstMg6eDyqQffOqZvqk8+PvJrzHZ0GmiSCUFZRmdc//MaW9WzTBtcba9Z7zKm8dpYrvpCw72OxOSlD3xarC3BAiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0NLE4cmMN5OSpR0dFtBPQCxMB7dZoTHUy5Ne8O80B8=;
 b=GpBsy2K1wPvo7bzZKr4kKQCa8MdGCpJFWFmCUyPMkUYPVQpKpZUX2yFl8bsr8fnl30u6KPbcMw+DGPU8tayG+JIOIPyTo18wdjwydelXuhrnUdLKqcjilulkqQl7MkCuqg9fKgei53AOf6gNVSaQeSeMEEfkmijIyA01pJEnqS8=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3728.namprd13.prod.outlook.com (2603:10b6:208:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.6; Thu, 17 Sep
 2020 13:49:06 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3412.004; Thu, 17 Sep 2020
 13:49:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Nagendra.Tomar@microsoft.com" <Nagendra.Tomar@microsoft.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Topic: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Index: AdaLdYAHSfC4FmukRxSfbPzbpNbQ4QAw4uWAAAEERFAAApxggAALNM4AACE7MQA=
Date:   Thu, 17 Sep 2020 13:49:06 +0000
Message-ID: <4571fc5664fbc488d98641ccd30a868fa5a508a7.camel@hammerspace.com>
References: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
         <1fdce3fc0981916f8d3829933db61a3f78aebde3.camel@hammerspace.com>
         <SG2P153MB023125DD453D879416DDBA389E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
         <6c1b52e4eceba8bac7d60cc92470ae80b3846d6a.camel@hammerspace.com>
         <SG2P153MB0231CB0FE679419306303FC59E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0231CB0FE679419306303FC59E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46e29e7f-21b3-47d6-c538-08d85b107200
x-ms-traffictypediagnostic: MN2PR13MB3728:
x-microsoft-antispam-prvs: <MN2PR13MB37283BFDFA10CA649576D1EDB83E0@MN2PR13MB3728.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wzhqv8uL3rcLRFo3gATALduR6sFgjAXXa1NO0n3A8kbSMdVA88cDaWzlMW45YEZJHhJCnTTv4O6PLpKzNDsmUFA0bBGVPEPLL8lgWHaYfMrXW0dSJXfxHoN38zUak4duaGs4EizEGivEngHzyqFrIQIYFQ6vmfiIj+I16i/vS4cBiuqs7mhKaOzzMM4h0Zkj6DCY7jPGTMYw6IEuDB8M0Qf7Dm/194h5EG7puQFf5g5IBq+HsVF6GYOqhnZIFW2PLUtbyVprKn9sAxoqd2PuWekeMMBqjhhLSzzFDN7stIc6z0cvEfvpx/7DGXoeTzHRNPWgWRfKmYLa+oMiocZonXHa/mdDpB2rwWlx2zlZ4RmVh3P7fFmwn5qOS0cjMm17
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39840400004)(396003)(346002)(2906002)(6512007)(36756003)(316002)(8936002)(83380400001)(110136005)(4326008)(478600001)(186003)(2616005)(8676002)(86362001)(6486002)(76116006)(71200400001)(66446008)(64756008)(66556008)(66476007)(91956017)(66946007)(26005)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kCEgeYBiDmBI4dm5IVdScbyzJ6jIPKYpMZtgx5ieTiRnM3N3Jv+fl2hL+45JG+p9dIUcUz9by5QK/IpmKwStayPYjme4wXH6oKBecBqIbbEPONuRjSwHm/s3KgCVNA88xweyfKK8fMfUVRmVIwtI2eZt0Q8anPwEM5KEXfPe/0lbrGQhKP/aNkPsjpIdIKKEZ9XId3jjPfDWn8nJwGkvjXwbM1Jk1ADRf3yObNBeYYbZWgA0+WyyozwaiRmZPJEJffuiXO7oDFSLAVUNfRJFpUBjZR678D3jdiMA3DOcUX/pAdZRM5A4VpjiZZYo9OUFZ/k+jtIB5MPSAYlpFbDQauuXURWkn3fFq8QTUXqb3AGiBwRbapfoYGPNUUk/2ovfBcn52LLyNZcqiWGJBItIg5Nc2RpBJBCNncbkM+NicuiYnX+GKFZDL682vUoGHM3VZIoZKR57OIEEewmsl5lhGFSQMxu9eRo/mjKNd2z7oRpx1N3zk/FCau9WvO23uWDj2AKAVRq44ANNoH0DwdLK3tyV5B4aH5ZbjSfFHCtZ0xOwdSeMXOdAP0NffHezedlaqhEi0x0C6OoIupUHkT5H0uOCkyqhTkmwgsi1rMXkno8838SlEebkOtz5N9ds8eJLv9QGb1bG76zQxs4JNSd48A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BE48F4F8CDF354EB24F4248D3D3CC93@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e29e7f-21b3-47d6-c538-08d85b107200
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 13:49:06.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eY9+HWB1we2o9mVFpNXwSZ2WucbNuQ4T+NcAgkAxrn2kN39eFlJaWY5icECaHz4OlpbfubM8SrshJrY1RjNnJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3728
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTE2IGF0IDIyOjQ4ICswMDAwLCBOYWdlbmRyYSBUb21hciB3cm90ZToN
Cj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBUcm9uZC4NCj4gDQo+ID4gTm90ZSB0aGF0IHRo
ZXJlIHRoZXJlIGlzIG5vIFJGQyAyMTE5IG5vcm1hdGl2ZSBNVVNUIG9yIGV2ZW4gYQ0KPiA+IFNI
T1VMRC4NCj4gPiBXZSB0aGVyZWZvcmUgZXhwZWN0IHRvIGJlIGFibGUgdG8gcmV1c2UgdGhlIGNv
b2tpZSB2ZXJpZmllciB3aXRoIGENCj4gPiB6ZXJvDQo+ID4gY29va2llIGluIG9yZGVyIHRvIHZh
bGlkYXRlIHRoYXQgdGhlIGNvb2tpZXMgdGhhdCBvdXIgY2xpZW50IG1heQ0KPiA+IHN0aWxsDQo+
ID4gYmUgY2FjaGluZyAoZS5nLiBpbiBhbm90aGVyIG9wZW4gZmlsZSBjb250ZXh0KSBhcmUgZ29v
ZC4NCj4gPiBFaXRoZXIgd2F5LCBhcyBJIHNhaWQgcHJldmlvdXNseSwgdGhlIHBhdGNoIGlzIGlu
Y29ycmVjdCBzaW5jZSBpdA0KPiA+IGlzDQo+ID4gc2V0dGluZyB0aGUgdmVyaWZpZXIgdG8gemVy
byBpbiBhIGNvbnRleHQgd2hlcmUgaXQgY2Fubm90IGd1YXJhbnRlZQ0KPiA+IHRoYXQgdGhlIG5l
eHQgY29va2llIHNlbnQgaW4gYSBSRUFERElSIGNhbGwgd2lsbCBiZSBhIHplcm8uIA0KPiANCj4g
UGxzIGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBub3QgY29ycmVjdCwgYnV0IHNp
bmNlIHdlIHN0b3JlDQo+IHRoZSANCj4gY29va2lldmVyZiBpbiB0aGUgaW5vZGUgKHNoYXJlZCBi
eSBhbGwgb3BlbiBjb250ZXh0cyksIHdoaWxlIGV2ZXJ5DQo+IG9wZW4NCj4gY29udGV4dCBoYXMg
aXRzIG93biBkaXJfY29va2llLCBhbGwgY2hhbmdlcyB0byBjb29raWV2ZXJmICBfYXJlXw0KPiBi
ZWluZyBkb25lDQo+IHJlZ2FyZGxlc3Mgb2YgdGhlIGRpcl9jb29raWUgdmFsdWUgaGVsZCBieSBv
dGhlciBvcGVuIGNvbnRleHRzLg0KDQouLi5hbmQgdGhhdCB3b3VsZCBiZSBhIGJ1Zy4gVGhlIGRp
cl9jb29raWUgYXJlIHRpZWQgdG8gYSBzcGVjaWZpYyB2YWx1ZQ0Kb2YgdGhlIGNvb2tpZXZlcmYs
IHNvIHlvdSBjYW4ndCBqdXN0IGFja25vd2xlZGdlIGEgY2hhbmdlIHRvIHRoZSBsYXR0ZXINCndp
dGhvdXQgYWxzbyBjaGFuZ2luZyB0aGUgZm9ybWVyLg0KDQpXZSdyZSBub3QganVzdCBjYWNoaW5n
IHRoZSBkaXJfY29va2llcyBpbiB0aGUgcGFnZSBjYWNoZS4gV2UncmUgYWxzbw0KY2FjaGluZyB0
aGVtIGluIGFsbCB0aGUgbmZzX29wZW5fZGlyX2NvbnRleHQgdGhhdCBhcmUgYXNzb2NpYXRlZCB3
aXRoDQp0aGUgdmFyaW91cyBvcGVuIGZpbGUgZGVzY3JpcHRvcnMgZm9yIHRoYXQgZmlsZSwgYW5k
IHdlJ3JlIG5vdCBjYWNoaW5nDQphIGNvb2tpZXZlcmYgdG8gZW5zdXJlIHRoZXkgYXJlIGludmFs
aWRhdGVkIHdoZW4gdGhlIGlub2RlIGNvb2tpZXZlcmYNCmNoYW5nZXMuDQoNCj4gIElmIGFmdGVy
IHRoZQ0KPiBjb29raWV2ZXJmIGNoYW5nZSwgYW4gb3BlbiBjb250ZXh0J3MgY29va2l2ZXJmIGFu
ZCBjb29raWUgY29tYmluYXRpb24NCj4gYmVjb21lcyBpbnZhbGlkIGF0IHRoZSBzZXJ2ZXIsIHRo
YXQgb3BlbiBjb250ZXh0IGRlYWxzIHdpdGggdGhlDQo+IEVCQURDT09LSUUgDQo+IGFzIGFwcHJv
cHJpYXRlLg0KPiBmLmUuIG5mc196YXBfY2FjaGVzX2xvY2tlZCgpIGFsc28gY2xlYXJzIGNvb2tp
ZXZlcmYgd2hlbiB0aGUgZGlyDQo+IGNhY2hlIGlzDQo+IHphcHBlZCwgaXJyZXNwZWN0aXZlIG9m
IG90aGVyIG9wZW4gY29udGV4dHMuDQoNCk5vLiBTZWUgYWJvdmUuIA0KDQo+IEFsc28sIHNpbmNl
IHdlIGRpZCBpbnRlbmQgdG8gc2V0IHRoZSBjb29raWV2ZXJmIHRvIDAgaW4NCj4gbmZzX2ludmFs
aWRhdGVfbWFwcGluZygpLA0KPiBqdXN0IHRoYXQgaWYgdGhlIGRpciBjYWNoZSBoYXBwZW5zIHRv
IGJlIGFscmVhZHkgcHVyZ2VkIChzYXkgYnkgYW4NCj4gdW5yZWxhdGVkDQo+IHZtICByZWNsYWlt
KSwgd2UgY2FuY2VsIHRoZSBpbnZhbGlkYXRpb24uIFRoaXMgY2F1c2VzIHVzIHRvIHVzZSB0aGUN
Cj4gb2xkDQo+IG5vbi16ZXJvIGNvb2tpdmVyZiwgYSBkaWZmZXJlbnQgYmVoYXZpb3IgdGhhbiBp
ZiB0aGUgZGlyIGNhY2hlIHdhcw0KPiBub3QNCj4gcHVyZ2VkLg0KPiBJcyB0aGlzIG9rID8gSXNu
J3QgaXQgYmV0dGVyIHRvIGNvbnNpc3RlbnRseSB1c2UgemVybyBjb29raWV2ZXJmIGluDQo+IGJv
dGggY2FzZXMgPw0KPiANCg0KQ29tcG91bmRpbmcgdGhlIGV4aXN0aW5nIGJ1ZyBmb3IgdGhlIHNh
a2Ugb2YgY29uc2lzdGVuY3kgaXMgbm90IGENCnVzZWZ1bCBleGVyY2lzZS4NCg0KSWYgdGhlcmUg
YXJlIHNlcnZlcnMgb3V0IHRoZXJlIHRoYXQgdXNlIHRoZSBjb29raWV2ZXJmLCB0aGVuIHdlJ2Qg
YmUNCmJldHRlciBzZXJ2ZWQgYnkgZml4aW5nIHRoZSBjb2RlLiBIb3dldmVyIG5vdGUgdGhhdCBz
ZXJ2ZXJzIHRoYXQgY2hhbmdlDQpjb29raWV2ZXJmIHdpbGwgYnJlYWsgUE9TSVggcmVhZGRpciAo
YmVjYXVzZSB3ZSdyZSBubyBsb25nZXIgYWJsZSB0bw0KdXNlIGNvb2tpZXMgYXMgYSBjdXJzb3Ip
LCBzbyBJJ20gbm90IHN1cmUgdGhhdCBJIHJlYWxseSBjYXJlIHRvIHN1cHBvcnQNCnN1Y2ggc2Vy
dmVycy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
