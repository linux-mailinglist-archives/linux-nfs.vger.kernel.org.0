Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5AE140CEC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAQOnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 09:43:40 -0500
Received: from mail-eopbgr750102.outbound.protection.outlook.com ([40.107.75.102]:45454
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbgAQOnj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:43:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAHFuICaYNRRR76EW0T+/DpVOSJ5R9l3fjR+nVoED3tb+KCgfokUmwvrsSUT5kUbIQu8nOn2gjPSadLuo46HYAV8imR85P8/kPzZ7VlbuE/O8vSm2Pbt1wuHyqRP9Fmnvy3sT8AKZSypiaRDr5z69qxhY28+2bSrxKfXE4JZF2AOF4HchYghHTx6Ir5iSgvBis0eNYVdYqV7fyk/fSDe1yGfpDOgZiQhoJtVXAOVk3in8ma0aYWiIRcrfvKzUdaqDl62Y2MGs3SC/13EHYGbGo5xf5KlZ7oTibdQjWhuOYNsTcdMNYtRssypEdfEizAlGZ5LlMIMaZj5lDxU2khg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZZvHLel1hEI0KIEWApvB7Kcr7H3q0l5tbOP+eZRn5A=;
 b=CV1s6YwaRhIrYp5KKxOWFsyzOBYRbWDNWw5OOCZ/419vUXPLGThc5v4Jf9VgPVL5eJ/Bc8FKu/Yp+/QOPCqYogrcme5igCdNnw1sG5GZpwCHLBAOSSQ5V/71dHH8iNVzWJTTwzRCnPO9b6UFmabLJwYjRZObLq27X0oetQso+rKjG//YP9qjlcaOCWP/+cFyZmxHeHEBI7EN2wwSThWAsN4oz1lThnR9ERq8aYZxVX18Q0Iv0h6ZjdFiMKQ56lmSREMn43IPNz8AYq/MCXEGWNc5Ub9hwxH0IKDxL/PB8QvWdL7HKFtEHtyjGCrHFT+IN7+z8dPqz2OKbRQnqkON6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZZvHLel1hEI0KIEWApvB7Kcr7H3q0l5tbOP+eZRn5A=;
 b=NDmz+sA1mxnlyzkB8kAVswPtsM3wM1FVG2Hk6/PZGeHIHg+SpXPCGW8YRGLwzAys9XX8KyjG7JeNL2+tWSUJHueqyz4XqfRAhjEHK8uLVlVb+ii1O2P1MO0rRt5gtYQeCVdUuxEvHbZRfxZMLGT7+nFT0RPG0+bbih03tPlJ4i0=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2154.namprd13.prod.outlook.com (10.174.185.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.15; Fri, 17 Jan 2020 14:43:36 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 14:43:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "SteveD@redhat.com" <SteveD@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: nfs-utils tag
Thread-Topic: nfs-utils tag
Thread-Index: AQHVzUR/j6tFgvuHjEyT0pzmDTFaaA==
Date:   Fri, 17 Jan 2020 14:43:35 +0000
Message-ID: <d64033ad7277ce26e328d1b5c7b85050c201beb7.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a74be4a6-a232-48ee-461a-08d79b5ba221
x-ms-traffictypediagnostic: DM5PR1301MB2154:
x-microsoft-antispam-prvs: <DM5PR1301MB215445F8AF33A294FEA3A278B8310@DM5PR1301MB2154.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(39830400003)(346002)(189003)(199004)(186003)(316002)(86362001)(36756003)(478600001)(5660300002)(6916009)(66946007)(6512007)(81166006)(76116006)(64756008)(8936002)(66446008)(91956017)(81156014)(3480700007)(66476007)(66556008)(8676002)(6486002)(6506007)(2616005)(26005)(71200400001)(4744005)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2154;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbx+gEA5iq5JVzrZkZWNPS53UuZRvnS6q1bqoN6HAoVoJ6urBIjIMZHTtKcFUxfCUHpnOhVqafPLkzqmbE+GPWkKjGWIgIZUH+fLkvhajtbcvUa25mMqTzOkbyszInTv5cLxlIAD15cgf6OklgzybRhRzV8FguUGm24Olj5+wB78Sa5AQeki0Ze64qQvMoWAcG+XPlhMcccob8kc3hksngic4C5l3I9LLpwkIRChSm2TMT+UiQ8JpcY6JV0x3fBqfeWrZ9rIqtJExti/cv6UqsTSU3czLAQJ4SxTDAzy7UZxDg88IK9gcGpujxC4guoncQ9dlPJd9omtZUNEZtrTDR/c20pQlCNJQKF9siYK4XkV+XWFrF5ubaErCl0k8fGhrUy+2MvN9HpFi4Qja2SiudYWDddPX/cxvpAWwucyP8e1cVRn4rpncSLs5k5MrAwF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D66BBDB3B7AF541A24E14BB1A74DF3C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74be4a6-a232-48ee-461a-08d79b5ba221
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 14:43:35.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvmAoO5W+dugW4Gs1YWX6fG73DwjvTzmSUXAg7K+mHj547whTO/5Wl8GtfjLBavrCkdlmLS2UA90tcx5kuS56w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2154
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgU3RldmUNCg0KSXQgbG9va3MgbGlrZSB0aGUgbmZzLXV0aWxzLTItNC0zLXJjNSB0YWcgd2Fz
IG1vZGlmaWVkIGFmdGVyIGl0IHdhcw0KcHVzaGVkIG91dDoNCg0KRmV0Y2hpbmcgb3JpZ2luDQpG
cm9tIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL3N0ZXZlZC9uZnMtdXRpbHMNCiAh
IFtyZWplY3RlZF0gICAgICAgICAgICAgICAgICBuZnMtdXRpbHMtMi00LTMtcmM1IC0+IG5mcy11
dGlscy0yLTQtMy1yYzUgICh3b3VsZCBjbG9iYmVyIGV4aXN0aW5nIHRhZykNCmVycm9yOiBDb3Vs
ZCBub3QgZmV0Y2ggb3JpZ2luDQoNCg0KV2FzIHRoYXQgaW50ZW50aW9uYWw/IEkgZG9uJ3QgdXN1
YWxseSBkbyBhIGZvcmNlLXB1bGwgb2YgdGhlIHRhZ3MgKGFuZA0KSSBzdXNwZWN0IG1vc3Qgb3Ro
ZXIgcGVvcGxlIGRvIG5vdCBlaXRoZXIpIHNvIGl0IGlzIGVhc3kgdG8gbWlzcyB0aGF0DQp0YWcg
Y2hhbmdlLg0KDQpDaGVlcnMNCiAgVHJvbmQNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
