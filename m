Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5212198C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLPS6W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:58:22 -0500
Received: from mail-dm6nam12on2123.outbound.protection.outlook.com ([40.107.243.123]:15584
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbfLPS6W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Dec 2019 13:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxD1FLZqUjVHICJg9jZDAnnQH2k8JdB4PIo0IUnFBNF15T6c9vnZVbXiht+5yOK9g1NxVn6eZBkTSP7VZqOu0AMgwQcCJ91OaJILHfx0o/SAo0GCVjdk+Sd3KCf8LrWfgHZvd2S8LWB2tVBHVe6gHS5jftKCtQvL5c02rSb5nuDLgKQPQucgjLHuxI6eexdzkQlwOuFZw80oT5eq6fBu04eeuMc1Hz85F7gqo1WY+kMQwDizSkRjyZiUkwHtdVDTfKMaR9e+MYDCaBCWy9F/78or74424kG9IYU7kHDdZ1zvGGXAgqyZsnAYEFodik2mKHMiz5yHryYGE5/HvpehQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EJ5bwbuzPzNBR8xkJ1Mh2d+VX76z8Elc4YlDKRu/2M=;
 b=Cx6sqaRlGl7+UgrzzoqAOWrvX5470xxlwtLQ6GtIaEe00fGyJ+MeUJO3cIHOyx0N6yd38mqMMfLjMijBbGnsBsf37KRjk3OVIauQlT/ZzAIYWjdNfTG7ewJbnIEBpJP9Q4/lXVL+ELV6xDtDI+zg3CciAMY9LEzygOPWEFrGG7xJ4yqKlIR/7FckTT0NXeJKEISsQKqWTh0KSw7wxEd/VImW5TwYEBJUZSWaGfRNOvugZVeW8Sb8aXMVq6T59H4NP5AFZ2FvViK906hdTqNHGj/oyx3QSv7KggRbp3wTaCwxDa3OFTZOO4KjbxOemMGmAcbLHM+9sDZQyx4eOnHdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EJ5bwbuzPzNBR8xkJ1Mh2d+VX76z8Elc4YlDKRu/2M=;
 b=DzkTH8w3Ood2Te9RlGSVlpKSmL+0sg8o17U3yAbO2hUqbG7nA4ue+xdi8dUeQjZxwfdP8g+RS8aEaOfuo75W9JakoE8/nb4Sgh80RbBT8P+AK/kaT77nLQK2iladQbxHsC6WIKiGtYZ/rHUGLZyrVvvEGftxQ7db9go/WB9497w=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1900.namprd13.prod.outlook.com (10.174.184.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.12; Mon, 16 Dec 2019 18:58:19 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Mon, 16 Dec 2019
 18:58:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmilkowski@gmail.com" <rmilkowski@gmail.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Topic: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Index: AdW0MytZJzbanD9yTZ+e0zLvCdtxJAACuc6AAACqnwAAAIJigA==
Date:   Mon, 16 Dec 2019 18:58:19 +0000
Message-ID: <2d94fa3e9632c638f9e47999fd8e26cb3b34b4dc.camel@hammerspace.com>
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
         <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
         <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com>
In-Reply-To: <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db03ab79-4836-451c-502a-08d78259ea63
x-ms-traffictypediagnostic: DM5PR1301MB1900:
x-microsoft-antispam-prvs: <DM5PR1301MB190077CC7EDD93DDF01B89D5B8510@DM5PR1301MB1900.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39840400004)(396003)(199004)(189003)(64756008)(110136005)(54906003)(66556008)(66446008)(186003)(316002)(86362001)(8936002)(81166006)(8676002)(4001150100001)(81156014)(4326008)(6506007)(6486002)(26005)(66946007)(5660300002)(2906002)(66476007)(36756003)(6512007)(508600001)(4744005)(2616005)(71200400001)(76116006)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1900;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9p45gKNF0TDreVVp7TGVHYJ0BfG7KbJ8gh/3DhAzO/nPXXPOM8QkY4a9HHxP7rekftW8c6E8lbzcpHGGnlptCsRoMFknzSYAYeFZDYF4M5xQj0XxAru6a/DvKrxg5y6RQPtMk/ah74TEUqq67d5+Z33T3QyNRtxqmv0PxTJWHJTLtZNoC0vy5pdlrGgJ3VIwX7cwrCq/C0n9UGYAuQ3NFnzBwZQJURSVQNWC0SYXvPWqMzqvGbGTEgI9pPRUMf+TecmA6qwa6GHU0CGlre1tnsAXsMRYN1wRPGH4bOAYuRWhQppkY2M5aWYqd/ZjQoViCpz8onYmSLfkgNjOPDg4vOs17gU4dg12W4SXeJbf2P6l/FER5AVQTx2M+OXOaydHkX2XT9kI5m7X/i0uX5NkqiC7NGpcagPR9my4Q80wLlBhx87FGJ8lVbG6wcpRe7E4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2C7A3AC455ACB4AA9029C65D9099BF3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db03ab79-4836-451c-502a-08d78259ea63
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 18:58:19.1182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekqefYbafsGkIg/thB2pDGRYODXTYQnydAtblhHOuwT/k3JY86NaSjgdH9jhe0A6hCTtVIGVq2fZlJ/faNActw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1900
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

LU9uIE1vbiwgMjAxOS0xMi0xNiBhdCAxODo0MyArMDAwMCwgUm9iZXJ0IE1pbGtvd3NraSB3cm90
ZToNCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiAN
Cj4gLi4uDQo+ID4gTkFDSy4gVGhlIGFib3ZlIGFyZ3VtZW50IG9ubHkgYXBwbGllcyB0byBsZWdh
Y3kgbWlub3IgdmVyc2lvbiAwDQo+ID4gc2V0dXBzLCBhbmQgZG9lcyBub3QgYXBwbHkgdG8gTkZT
djQuMSBvciBuZXdlci4NCj4gDQo+IENvcnJlY3QuIEhvd2V2ZXIgbWFueSBzaXRlcyBzdGlsbCB1
c2UgdjQuMC4NCj4gDQoNClRoYXQncyBub3QgYSBnb29kIHJlYXNvbiB0byBicmVhayBjb2RlIHRo
YXQgd29ya3MganVzdCBmaW5lIGZvcg0KTkZTdjQuMS4NCg0KSXQgd291bGQgYmUgYmV0dGVyIHRv
IG1vdmUgdGhlIGluaXRpYWxpc2F0aW9uIG9mIGNscC0+Y2xfbGFzdF9yZW5ld2FsDQppbnRvIG5m
czRfaW5pdF9jbGllbnRpZCgpIGFuZCBuZnM0MV9pbml0X2NsaWVudGlkKCkgKGFmdGVyIHRoZSBj
YWxscyB0bw0KbmZzNF9wcm9jX3NldGNsaWVudGlkX2NvbmZpcm0oKSBhbmQgbmZzNF9wcm9jX2Ny
ZWF0ZV9zZXNzaW9uKCkNCnJlc3BlY3RpdmVseSkuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
