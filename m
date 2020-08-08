Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56823F737
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Aug 2020 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHHKVW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Aug 2020 06:21:22 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:11617
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbgHHKVW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 8 Aug 2020 06:21:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joDLKQeJD6aSZGeW7p5ouk9B9FNEr3rMpbQwP7iYL9Ur8PDAJg0jtVnue7Cf3j2WlTHdftERnfDp+qzHTC5jbPZ2+gBax7Pw92owcsU1wffmC4wbfjPjwLZGhXPdCnQSki0pRKVvdH3+vByvxIaHCPNTZ7gLdfeslHpQDzZKS8Xbthn+hLL2OY2wLNXFt+ps03/BkROgxa2T/1so6800mAOll0RfSso1wrWf4TnJ4v42+egBt+OUJxiIWunbgxOy1WIv/30jfBnhu+VofQ524rSR9ndaf/nnfWPu75vXNU7kgiFV60g0o5A9n4qsOEquHto67KHH9oBaTVXYLr9ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GQ0pVd9sd9bwQKY2lTz4OcDojmCYHaWJSVKzgSpPus=;
 b=m5gmw7sTzX1GfMNJZahgev62BSGk6MwQIHaLKdeu1sij73PVEcun/lxRmxuqbQ4R8M1qbmVg65jp7EFIeAiBIRIlcoM4oRSYTZlm6IQdGDXd20a2wm2Ucvhb/RsvcXlAe2cs1yUt76xyb4/DCS2wZ2/m+NSxYw9ctpT4/fZ7XEvgUxsg7sDiYc04MzW3k6NfM37rtKC5tKDj8YHKYx0jc1GIoLTzglbLQvZ7gy48TGfa6wLaskPjdRr5fKi0sgzbuEm3nyI4dczCPCYaEOzGxkm1Lw+0MAlNM6+6C9RgvcoGzF4K+K9gnU1EEoNRcU4UJ+oNLitz4lWA8Uu9CQCv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GQ0pVd9sd9bwQKY2lTz4OcDojmCYHaWJSVKzgSpPus=;
 b=WBo9iLPD0C3luzTc6XcueZbzL6osZX+ww/mURqh8XEbWp+PCebvoNuiFfFcYGrY2dp1VzlQh7dvmFHNKZL5+iy55+XEtM1XWg7RPPRQeHvVLeXe38dpYLiKL9IGItomNyWXgw3n9Q49UZFLzUw6+Sr6oSrvt0QRSG5npu5I4wZI=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR10MB1264.namprd10.prod.outlook.com
 (2603:10b6:301:9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 10:21:20 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::ad32:3fef:28b7:2573]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::ad32:3fef:28b7:2573%2]) with mapi id 15.20.3261.020; Sat, 8 Aug 2020
 10:21:20 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: idmapd Domain issue
Thread-Topic: idmapd Domain issue
Thread-Index: AQHWbW2oNVn2R9H9LEKSBtsqgjvvRQ==
Date:   Sat, 8 Aug 2020 10:21:19 +0000
Message-ID: <80a43e48b6f0c6c8806d1f8f6ca5ed575269445f.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd16352a-a3ed-47e0-e781-08d83b84cb05
x-ms-traffictypediagnostic: MWHPR10MB1264:
x-microsoft-antispam-prvs: <MWHPR10MB126486D20DF502FB9313990FF4460@MWHPR10MB1264.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIsi6xPkiNTxt8yMmuOr5zFZ/4eJwxTSJUDgbDEfasS23zAygsuCRAUuq2r3+Qhrpnx1Ve4WzTeSBt8rrPv5JL6jq0Yx2M6bu5rzIzM8K2Tv+LtJT9EfY/kuZa27zxAh4me+Uh63azDdx7cAyb6yfUJoElcivuvkwLyEIKe5yfe9MFoomkEeBky6Lvb3fLJ6nf4IG4mMEyRqQJhKw9nd2162a4YnWTbxJd1iGAPFt9W5yn1JWLIW39mdK6ZGRhQ0dW6RnnEVlTsiVs5ToBsLVvfOTHMo5CQGCi0jUOA4hHrZC4rpZsB2HsSkltbp3kEU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(66946007)(3480700007)(71200400001)(66446008)(64756008)(66476007)(2616005)(316002)(6512007)(76116006)(66556008)(6506007)(2906002)(91956017)(36756003)(186003)(5660300002)(7116003)(6916009)(6486002)(26005)(8676002)(8936002)(86362001)(478600001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lDQ5Z+LinYgy5DgNRe+lDhhiJJgD98izrrxPRMnc+Zv6SzjAzEfc/43dAdwEOZu1d7YMBMeiqt4mcS54QbpkEQG6+2v2Jrz7ooMnzkU8nSjXy6dbAjIXbtKixqDAgthZA1DisUukOaQMU/qQ8rEnd1oJ9IvAj2sPugydNKw8+8NigtMpUSdcXCXDDy0vf3Qe95eMitF675zk8xkmxqLWmYUrFyz+xFmDZ9VLtEVA11Akd/JjM5UKKkNuqfy8tDUH73fi91HVRXuEHHzy68pqNb02VSRoSaoucWoWau/edpi7ufVYLD6TYcIpuezuJsMpJRSGMmmny0KKqKr7jyD23eGLDYlajdM1zuJVFv8Mi2lCp1hw0fsRLkvGoJZ4g32OKebP4DCVbeZaDv6xy1HkvwOMD7fcinD05sH06hO0rakSlWu8EsQA1awsnegTEN0GF+hY0VRbZThaOc+OvDg+WiPoxq5Zz/Vn1GT2OQ7cr+wQalmkLVFCBIxnWuj6o9x7QNpASSEq2H7tcJ0OWD+nwlCHz8Ca67gfc+euWXh9MHIiKKVrDgvIu0KkAWwHoBRAfjF3Dq76O3c6SuRM1UhzLFUZXAIQN5pafFbUuEar7+umweANcspNgiAGbY4Th74KsmjsUQl9a6LrzpPR9g9AsQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9292809B79B9141A9FB21639ACADD0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2190.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16352a-a3ed-47e0-e781-08d83b84cb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 10:21:19.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBm+bCY0qsO1VoS7HlJHU9b/dUpK/N14XB9kPRbejmLrHjMf9Z69BDr6G9jcIvZCO6GJElyMZkoDYqLBRtBidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1264
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

V2UgZ290IGFuIG9sZCwgbm9uIGV4aXN0aW5nLCBkb21haW4gY29uZmlndXJlZCBmb3IgaWRtYXBk
LCBsaWtlIHNvOg0KICBEb21haW4gPSB4LnkNCg0KTm93IEkgd291bGQgbGlrZSB0byBjaGFuZ2Ug
dGhhdCB0byBvdXIgbmV3IGRvbWFpbiBidXQgSSBjYW5ub3QNCmNoYW5nZSBhbGwgY29tcHV0ZXJz
IHVzaW5nIHRoZSBvbGQgZG9tYWluIGF0IHRoZSBzYW1lIHRpbWUuDQoNCklkZWFsbHkgSSB3b3Vs
ZCBsaWtlIHRvIGp1c3QgYWRkIHRoZSBuZXcgZG9tYWluIGFuZCB0aGVuIGNoYW5nZQ0KY2xpZW50
cyBncmFkdWFsbHkgYXMgdGltZSBwZXJtaXRzLg0KDQpDdXJyZW50bHkgaWRtYXBkIGRvZXMgbm90
IHNlZW1zIHRvIHN1cHBvcnQgdGhpcyA/DQpDb3VsZCBtdWx0aXBsZSBkb21haW5zIGJlIGFkZGVk
ID8NCg0KIEpvY2tlDQo=
