Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1014BD2D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA1PoD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 10:44:03 -0500
Received: from mail-mw2nam12on2107.outbound.protection.outlook.com ([40.107.244.107]:15200
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgA1PoD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Jan 2020 10:44:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6Ebnqp4KBuW82BTdGGNri3L+X0LZ6GdWQoR94NLE1DLxHM8oNGBrfg68G5+BmHx96eeU9ccfWizxHiEquJlWq1Ztu+kqEXt/4lHaCDp4qnfPNet4RH/FB5jxjpAAupm0C6ZCzgJp0hvZYYnOAYn3GHASvg9EnULDypBUQm3N6NH/SArXrt5feoz4EOUFmtnibNlUCf/kaVqIr4ORfnu08wHIlun7ahbsXcJhiaGP5akQlf5o1v2LFijUwRviLz8gdx2S2728aoudPMFlhdSpeRGInSt52AQUrPO6jEc3YbwYLPZjhDLeYwOnVaj8CwsRf9OIM4Cn7ONXvDLqDWkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nER1f4bp+odQlr0YsnDZhDALJMVefFX+nj+kVsJxFg=;
 b=bSRgoPLOZ6vJvNtF5Y3y4o/8s+kXQKCzgLG90TG9k9OJhYeL2yJM6E+SkKm1Hj3lG+u2B2TkSAr0CvIlcetliYw0GQoIcsC6NYiBAi/XQ5mAYZjx8C1fCc/mqOMKU+rY4rqQFwP4zkqGd9EGXkoXBBqfJ7Wh7RMoNmR3T0o+CAxPNHenilzDeLCzo9HmDDCObQVEOLvW8ran1HtR2tcy2NYOlzPP0r+gQKaejx/3oK4yBmmnNQMbapTAiKzxy+UjV+6P0vlTr3b9W/rlFSJcgvTgqf6la+6drU6HRWYB7txSInwiaEmxjnAYWdQnjABErT2QQGJQIugmo9NeIn83LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nER1f4bp+odQlr0YsnDZhDALJMVefFX+nj+kVsJxFg=;
 b=JdrKv0mCDCfDucnsGyED8vY941Fv4mlhHaj+XwsvhHrGU2Hf75P9Hf9Me/OzPvnZLZMQ14gkHzKWtisaU6Sby9JHIlgnQE3qfbZAzWWd1k0Wa2CyXFyzAYNq0nxbgTzyiuh1aZEgP71TiMABKy+5dR22nQvasV9tQs7Z47vCfi8=
Received: from BN6PR1301MB2097.namprd13.prod.outlook.com (10.174.87.14) by
 BN6PR1301MB1889.namprd13.prod.outlook.com (10.174.89.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Tue, 28 Jan 2020 15:44:00 +0000
Received: from BN6PR1301MB2097.namprd13.prod.outlook.com
 ([fe80::40e1:9ff5:2b8c:38bf]) by BN6PR1301MB2097.namprd13.prod.outlook.com
 ([fe80::40e1:9ff5:2b8c:38bf%5]) with mapi id 15.20.2686.019; Tue, 28 Jan 2020
 15:44:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmilkowski@gmail.com" <rmilkowski@gmail.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Thread-Topic: [PATCH v3] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Thread-Index: AdXVs9KkXsilGD6+RnONAb8nbCW6uAAPe5oA
Date:   Tue, 28 Jan 2020 15:44:00 +0000
Message-ID: <27ccd9a19e663b083d5b8d3ded10a37dd316c2c6.camel@hammerspace.com>
References: <000601d5d5b6$39065c60$ab131520$@gmail.com>
In-Reply-To: <000601d5d5b6$39065c60$ab131520$@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d59625ce-9dac-4eb7-2ab8-08d7a408e4fc
x-ms-traffictypediagnostic: BN6PR1301MB1889:
x-microsoft-antispam-prvs: <BN6PR1301MB188974D68EBADADC0ABED4C4B80A0@BN6PR1301MB1889.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39830400003)(199004)(189003)(4326008)(76116006)(2906002)(36756003)(91956017)(81156014)(81166006)(478600001)(8936002)(8676002)(5660300002)(2616005)(86362001)(66446008)(110136005)(64756008)(316002)(66476007)(66946007)(66556008)(54906003)(26005)(71200400001)(186003)(6506007)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1301MB1889;H:BN6PR1301MB2097.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLY/CDbs2zNhX3dARgEdEnmZZothBv5Hdzc8TjCVHl3t6QWftImpLyO+QiFw3mpSH0vcrujGYAM1oriwt0gAt4tjNTZ6w7foViXSZHeLsinmTUeKWMZUfBP8jN+OZTDg7ERvF7qX/ZM5qaXjf5lKusqfBaFyayHBn5bmFe3YYD3Nio+NwI6Shz3pSD1GM2pq5iBQ15Mq77si0wfEyPjEbymrqfk0/KFX/iG+vfEV8UbCbptRw+6uucWL2J2WZhajqR/TEZHuy8ZDSfXqTu8xNMuUJWNGbj9GDG3qZ/uYgFjW2fdSpspmTemb90FNVfCm0BJYT9namnUCasz115mxWZhkBC97RPbSEE1lUNFo/GK5YOuF7e0BGduAnVCl9/gZoUm+Qt1bLFpF7YJSB2epzOWFdbbTGsf05b0w3+hPnY4PfnAfMtvP71Z4lPXk90PW
x-ms-exchange-antispam-messagedata: jyR6eftAQrmMKPb3mCBTxdZtx9cBYiAcZMQ8kL3t6Y+Ho1yvWlc4YPnISiDvKFw+fGweQH1tuRzDHyHC8d+Uvd3Pa/EA5kSXQFHeU5XTQ5dTLoBPHrJzEQQ08PFRyzsPSZkOncgRHdmOxSFkZDjAxg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <541DD851845843488BCC81CDDF31B4BD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59625ce-9dac-4eb7-2ab8-08d7a408e4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 15:44:00.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yh/dV2JfFdKwROW6O25bCqR14QlRotrPcEegKJur5aKscNyW86G/L580z+r1Z9rjC0rBOnPIm1oIkNYOecb7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB1889
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTI4IGF0IDA4OjM3ICswMDAwLCBSb2JlcnQgTWlsa293c2tpIHdyb3Rl
Og0KPiBGcm9tOiBSb2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4gDQo+
IEN1cnJlbnRseSwgaWYgYW4gbmZzIHNlcnZlciByZXR1cm5zIE5GUzRFUlJfRVhQSVJFRCB0byBv
cGVuKCksDQo+IHdlIHJldHVybiBFSU8gdG8gYXBwbGljYXRpb25zIHdpdGhvdXQgZXZlbiB0cnlp
bmcgdG8gcmVjb3Zlci4NCj4gDQo+IEZpeGVzOiAyNzIyODlhM2RmNzIgKCJORlN2NDogbmZzNF9k
b19oYW5kbGVfZXhjZXB0aW9uKCkgaGFuZGxlDQo+IHJldm9rZS9leHBpcnkgb2YgYSBzaW5nbGUg
c3RhdGVpZCIpDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBNaWxrb3dza2kgPHJtaWxrb3dza2lA
Z21haWwuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9uZnM0cHJvYy5jIHwgNSArKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9u
ZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5kZXggNzZkMzcxNi4uYjdjNDA0NCAx
MDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gKysrIGIvZnMvbmZzL25mczRwcm9j
LmMNCj4gQEAgLTMxODcsNiArMzE4NywxMSBAQCBzdGF0aWMgc3RydWN0IG5mczRfc3RhdGUgKm5m
czRfZG9fb3BlbihzdHJ1Y3QNCj4gaW5vZGUgKmRpciwNCj4gIAkJCWV4Y2VwdGlvbi5yZXRyeSA9
IDE7DQo+ICAJCQljb250aW51ZTsNCj4gIAkJfQ0KPiArCQlpZiAoc3RhdHVzID09IC1ORlM0RVJS
X0VYUElSRUQpIHsNCj4gKwkJCW5mczRfc2NoZWR1bGVfbGVhc2VfcmVjb3Zlcnkoc2VydmVyLQ0K
PiA+bmZzX2NsaWVudCk7DQo+ICsJCQlleGNlcHRpb24ucmV0cnkgPSAxOw0KPiArCQkJY29udGlu
dWU7DQo+ICsJCX0NCj4gIAkJaWYgKHN0YXR1cyA9PSAtRUFHQUlOKSB7DQo+ICAJCQkvKiBXZSBt
dXN0IGhhdmUgZm91bmQgYSBkZWxlZ2F0aW9uICovDQo+ICAJCQlleGNlcHRpb24ucmV0cnkgPSAx
Ow0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
