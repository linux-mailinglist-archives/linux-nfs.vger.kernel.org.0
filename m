Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E750B2842B0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 00:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgJEW4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Oct 2020 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEW4o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Oct 2020 18:56:44 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Oct 2020 15:56:43 PDT
Received: from act-MTAout5.csiro.au (act-mtaout5.csiro.au [IPv6:2405:b000:e00:257::7:42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFEAC0613CE
        for <linux-nfs@vger.kernel.org>; Mon,  5 Oct 2020 15:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1601938603; x=1633474603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U2sJiuwhLucSrDDhYmf+tI/EkfqJ3r40VmsRXVo8nhY=;
  b=FhXvfE5fXDi29eHGHJqTgWndSzEpZ4LOqm5Wcl7bsWdjcKiZvUpZijaa
   UnZ9KzEMVu2WZvCRMTStPUkbq8I4dIBY/5v0fQANdnQTaercBepMHEpS3
   wMGATzMNboNalZdJ1PsZYdm0qG98SWtoDLoK3F9i6DZlyyJpY0ABIsN2k
   s=;
IronPort-SDR: xhvGPpW/16BG0Hq384mZSNBVRku3z/LYtRLY//OFCBmeZWMxXodemYRrRrEz/wYOg7mJxnNuMF
 NqSxp7o+EG8g==
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3ADtyRqxFxfovbGgmtH/Du451GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401Q6bU4TW7/5fhvGQtLrvCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNFPTr3m+9jMJXB?=
 =?us-ascii?q?LlOlk9KuH8AIWHicOx2qi78IHSZAMdgj27bPtyIRy6oB+XuNMRhN5pMacrzV?=
 =?us-ascii?q?3AvyhF?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+GhAACxo3tfjACwBSSwhIATAJKcgDJ?=
 =?us-ascii?q?gHAEBAQEBAQcBARIBAQQEAQFAgU+BUlFigUkKhDODRgONcJtOA1ULAQEBDQI?=
 =?us-ascii?q?tAgQBAQKESAIXgiICJTgTAgMBAQsBAQYBAQEBAQYEAgIQAQEBJoYMDINUgQM?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBAQM?=
 =?us-ascii?q?SEREMAQE3AQ8CAQgYAgImAgICEh4VEgQOJ4MEgkwDLQEBBJ1rAoE5iVeBMoM?=
 =?us-ascii?q?BAQEFhRUYghAJCQGBBCqCcoNphlaBXT6EIT6EJYMvM4ItkCKDG5MCkRIHAyC?=
 =?us-ascii?q?CR5AXijsCDSKhH7MqAgQCBAUCDgEBBYFrgXtsgz1QFwINjh8ag1eKVnQ3AgY?=
 =?us-ascii?q?KAQEDCXyMOwGBEAEB?=
X-IPAS-Result: =?us-ascii?q?A+GhAACxo3tfjACwBSSwhIATAJKcgDJgHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgU+BUlFigUkKhDODRgONcJtOA1ULAQEBDQItAgQBAQKESAIXg?=
 =?us-ascii?q?iICJTgTAgMBAQsBAQYBAQEBAQYEAgIQAQEBJoYMDINUgQMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBAQMSEREMAQE3AQ8CA?=
 =?us-ascii?q?QgYAgImAgICEh4VEgQOJ4MEgkwDLQEBBJ1rAoE5iVeBMoMBAQEFhRUYghAJC?=
 =?us-ascii?q?QGBBCqCcoNphlaBXT6EIT6EJYMvM4ItkCKDG5MCkRIHAyCCR5AXijsCDSKhH?=
 =?us-ascii?q?7MqAgQCBAUCDgEBBYFrgXtsgz1QFwINjh8ag1eKVnQ3AgYKAQEDCXyMOwGBE?=
 =?us-ascii?q?AEB?=
Received: from exch2-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:32])
  by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 06 Oct 2020 09:55:36 +1100
Received: from exch2-cdc.nexus.csiro.au (2405:b000:601:13::247:32) by
 exch2-cdc.nexus.csiro.au (2405:b000:601:13::247:32) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 6 Oct 2020 09:55:36 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch2-cdc.nexus.csiro.au
 (152.83.247.32) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 09:55:36 +1100
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.59)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Oct 2020 09:55:30 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Yqn4Aaw2yPrCLDgJFmOprEjvRl+Tz4kZXXxZdp75BVrkC7hJjroLsNRjEGvSzi1wy9xojt90DQxwq8bPLIddt2wkzq1brLeF9nHlDaU6eukiPrZi5R081q2Oi9lClKqvvrdvF7VtR+lI1w8lHjCElQCi1rGR/gJ251KkIOIewoQLl0pEWCW7sgk3YPfTQPEZqbFv9nFqY6PZ1ipFs+hZg9AjrCJKnS+VX+2cUmFq4iTXyRj7O+1ifLbmCsEdctr8qLc8eEOwvZuSOSUsN92zO8wbHf5wd1IwsFae9kRoipopHg/wsuQSBUdCRjDfVvAvin9pY2HYQy21sIwoKTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2sJiuwhLucSrDDhYmf+tI/EkfqJ3r40VmsRXVo8nhY=;
 b=AEhRTAmCsptKhIRaclEHzlRWHcCaJFE8nelz59oeZUxlBLIBeoZUEo9cjl62fo0H76LbbHaGkK0PYAaEw8g02N2auUJwPMvZ/EmY7C2/D1B4SOzZuFfYdjGweEI2L6H97uPapH59m0Zd++mpruxh2zNfGQj5655LDwWCFo+LxjT8KddxS7nO03MCRerCXWkmOVT4ohGmOsPmLa1U5u3oZp2jfEcurtK9er9Fp6huWe7F3xomZEn/7NpgTqt0xNpkPFApkFfYkAa5xzRT0YlyQ9Pe59grCKgnOnLelXqoqwhNuSOA2ZsZnihK+hCG8JvxiLtVAs24T6EsoFPdOq97Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2sJiuwhLucSrDDhYmf+tI/EkfqJ3r40VmsRXVo8nhY=;
 b=z5FgrdiDF8TtbksHv7+d+DuGTAPmpP3BgVqNC6udm8T+ynCXgsY4118iLZI1MiZyUPVHJZk68mbDA94fes+KsfSMnpQL7YfnAKZd2Tzp3nTIH2PHvAyk1qlrNzAfHU9PeMIhfMQ58f1VvtvOoPZ7Qph4wlN+PZqOb4j0LAFki/s=
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com (2603:10c6:220:3c::18)
 by ME2PR01MB4257.ausprd01.prod.outlook.com (2603:10c6:220:1f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Mon, 5 Oct
 2020 22:55:35 +0000
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::ac28:5cc2:6ae9:4911]) by MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::ac28:5cc2:6ae9:4911%3]) with mapi id 15.20.3433.045; Mon, 5 Oct 2020
 22:55:34 +0000
From:   "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     Patrick Goetz <pgoetz@math.utexas.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rpcbind redux
Thread-Topic: rpcbind redux
Thread-Index: AQHWk0rSu/8bxo8lzk+bqWvFiQAvTKmDG1MAgAADFoCAABeVgIAAEIiAgAAKwwCAAST+AIAEoVUAgACXEgA=
Date:   Mon, 5 Oct 2020 22:55:34 +0000
Message-ID: <20201005225534.GC15895@mayhem.atnf.CSIRO.AU>
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
 <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
 <20201001200603.GH1496@fieldses.org>
 <2df155d8-2f0b-c113-5244-a09bbea370b3@math.utexas.edu>
 <20201001214344.GJ1496@fieldses.org>
 <5eae41f5-aa78-5cf4-5e39-8b39f1235a65@math.utexas.edu>
 <20201005135452.GD31739@fieldses.org>
In-Reply-To: <20201005135452.GD31739@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=csiro.au;
x-originating-ip: [130.155.194.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30899acf-36c5-4905-06bd-08d86981c4f4
x-ms-traffictypediagnostic: ME2PR01MB4257:
x-microsoft-antispam-prvs: <ME2PR01MB425738F7D716D7C01C41D445F40C0@ME2PR01MB4257.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZ5NENrNzdro3fiIFB2PRzbLOFe45omVjcZMo3/13BlLkC7kfIjiikE2qvwE4UaGL27yzMqwJAamw+VSjycuTmQIs/A7GNXJ0lzDXseu8g/3V+DkIFTteZYKlfnmo6fdWuT0A+eNi2Tsu06CR/9BhEkLbokVQv5I47YYSmOM7lr1spR5LCnuXyq8UszxvGI2t0U+D/tznC97hXupmRB8eKHxaqzZcGfqGjUi56FAPHhV/zrSUg3WsWpfZSjYZWjFMBnpCqL96+UfQHfHTeVgaxY6Zx+xdwfKbGBfbuz5YsZh1lf7ThPbfIa6k+2BhFyB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MEAPR01MB4517.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(136003)(366004)(396003)(6916009)(3480700007)(26005)(186003)(4744005)(6512007)(1076003)(71200400001)(7116003)(8936002)(2906002)(66946007)(8676002)(316002)(86362001)(6506007)(5660300002)(478600001)(66556008)(66446008)(64756008)(33656002)(54906003)(66476007)(91956017)(76116006)(6486002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +NBQmZKFyyw75zu/3Gvxfq3cZMTApFH/VmpTJSxCLK/Dhi+rqpF4OyxO/k06FBSYLBglEdNnmnnPQ7Fk4dJtfxXH/A8K1InY+RnTpyX5tuqpuqUE6yEJo1XmwzdwUNpO4WN5s+xBCM9QWzHN3j/5lGtPWMRegiSOhWllZUJ00gCbAtgETZA9lkUcIt7wpsYoN5xIYARNEKgLLSDmjLpf2/0PwJ9QQU5N6eZPnUISEOdanKBHmTcarTF43b8EKAPr0QJeytuSnz1+sphqWFnC7dSbnjuEdR6vrQ2xnC6SbzwhYO9t7FFa1XON3Uq+LdyjE+qidlkUSSIWEY4LeUWVqftaNycREcZOczHQrsOl14D7Ik+dTbKQYNje6Nxg1dC+ddBGwKmgxjhXhinpIa7POtpqJ6YSpxzbJNEZLyfUcS/PLEnOZw3OoXQdH9hxl0pN2Z8Nt133CFX4NHG+ToD25WzR/lWeFsP8B1LbbGJRUPz9MdlpEnIIjrtHLiF1qczXpcIlkQg0Mf/WuahPDR/7NNY16VSvw9p7TnamWq1Yh5izPguW4f3vhV9jZfGuHSGLvxs9Lvy43KHIH5BVZl5eRJ0/FB4Az4im5G4z+MnfX4/iRrjYEvnjv8XcPH6r8SSlKi914nJXWvO7fEbpoA8Sbw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <32A5FF97F64F7C41A4B1EEF8C30CA2E3@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEAPR01MB4517.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30899acf-36c5-4905-06bd-08d86981c4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 22:55:34.8419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf1exxCpz2qEPh59PevoCys8uDUwP6pz/+7epr20qHuNIZG0kLxLlDKCyUo0JcTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB4257
X-OriginatorOrg: csiro.au
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCBPY3QgMDUsIDIwMjAgYXQgMDk6NTQ6NTJBTSAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRz
IHdyb3RlOg0KPk9uIEZyaSwgT2N0IDAyLCAyMDIwIGF0IDEwOjEyOjI0QU0gLTA1MDAsIFBhdHJp
Y2sgR29ldHogd3JvdGU6DQo+PiBJIHRoaW5rIHdoYXQgeW91J3JlIHNheWluZyBpcyB0aGF0IEkg
bmVlZCB0byBhZGQgJFJQQ01PVU5UREFSR1MgdG8NCj4+IHRoZSBzZXJ2aWNlIGZpbGUgY29tbWFu
ZCBsaW5lIGZvciBycGMubmZzZD8NCj4NCj5Tb21laG93IHlvdSBqdXN0IG5lZWQgdG8gbWFrZSBz
dXJlIHJwYy5uZnNkIGlzIGFsc28gZ2V0dGluZyAiLU4gMiAtTiAzIg0KPmFkZGVkIHRvIGl0cyBj
b21tYW5kbGluZS4gIEknbSBub3Qgc3VyZSBvZiB0aGUgcmlnaHQgd2F5IHRvIGRvIHRoYXQgd2l0
aA0KPkRlYmlhbidzIGNvbmZpZ3VyYXRpb24uDQo+DQoNCkkgdGhpbmsgdGhlIGNhbm9uaWNhbCB3
YXkgdG8gZG8gdGhpcyBpcyB0byBlZGl0DQovZXRjL2RlZmF1bHQvbmZzLWtlcm5lbC1zZXJ2ZXIN
Cg0KYW5kIHNldA0KUlBDTkZTRE9QVFM9Ii1OIDIgLU4zIg0KDQpvciBzaW1pbGFyLg0KDQpUaGVy
ZSB3ZXJlIHNvbWUgaXNzdWVzIGluIHRoZSBwYXN0IHdpdGggdGhlIG5mcyBpbml0IHNjcmlwdHMN
Cm5vdCBwaWNraW5nIHVwIHNldHRpbmdzIGluIHRoYXQgZmlsZSBjb3JyZWN0bHksIGJ1dCBJIGJl
bGlldmUNCnRoZXkgaGF2ZSBiZWVuIGNvcnJlY3RlZC4NCg0KS2luZCByZWdhcmRz
