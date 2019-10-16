Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D69D888F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 08:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJPGWp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 16 Oct 2019 02:22:45 -0400
Received: from mail-eopbgr670043.outbound.protection.outlook.com ([40.107.67.43]:10734
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbfJPGWp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 02:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqkiVwnpiialhbx/JYhAKTw7JDdTwRnoW2RNASTKy/seaMsw/ufEQjpvV1PKFQK6XQJLloCC/8HLt5CgIbRMBMxEA7DF9OQzI8MPZmm3p61H+WQsTRpWJPeqz0MA/gTHrwe9ov5OcirzNGLVXIwWN6+sseA1TsJ9EirhWc7/IcHR417Mqns1blpKnhnNy/3wglYEr8UamHD1l5gEeCsE0HUEBMG05biRUXL6h0dQwSO5Mbwsj54RBh/mu4+QWsk2Yax6fNX/2Vf01ZtWpN3vFSsIRZf9Sw5GwbZ+ErKPwzHy+dy0r+ptUeIMz0IwCh/OpZhnmyeVh1vLX4aQyY6KLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP5tdt+GdS9V8fu7uj1Fis001sllFHIOTds1KjaorIk=;
 b=KfG/KS+85Z2c1MmVXPLhCQ7fOkTxMlnehqGXuNKQ3A3SstZVxLQ/HitCM/cHtNsbSRg6nMUwZLV8NMkZaVaY/2YhiQWPBXO3hA6kKx3SfLbKqB4VMrIxW1g1emmcJk7UF56SKK0kPxt8kWmFRUvOxYHk3F6RGQMzu/8nB6SRp8yOo8CiBEgYydIi/7D6dLK9OeoMuG6LEK3z2vY0JD5u6AYKaVX6XrObtDZkYie76XzuWIsIDDXI1zRU12+CviI2OeUb3e4IoKc6wYufWlvJzH9oMS3t3F0BpYiwpamFg1+hlFBTlQEN8rJsge9jRQcHWYYRByQN0Z+Iwqx3JOR0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM (52.132.66.144) by
 YQBPR0101MB1474.CANPRD01.PROD.OUTLOOK.COM (52.132.69.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 06:22:42 +0000
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3]) by YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 06:22:42 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Thread-Topic: NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVg8vy6XBow5lmmE6IMuCp/6tuzqdcytI+
Date:   Wed, 16 Oct 2019 06:22:42 +0000
Message-ID: <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f81e6548-0c13-4d27-0170-08d752014063
x-ms-traffictypediagnostic: YQBPR0101MB1474:
x-microsoft-antispam-prvs: <YQBPR0101MB1474EB9D49B1BB40FBB8DC69DD920@YQBPR0101MB1474.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(5024004)(74316002)(14444005)(7696005)(316002)(305945005)(256004)(2501003)(33656002)(86362001)(786003)(102836004)(25786009)(229853002)(8676002)(2940100002)(81156014)(81166006)(6246003)(8936002)(186003)(5660300002)(5640700003)(6436002)(6506007)(66446008)(2906002)(76176011)(486006)(476003)(71190400001)(71200400001)(446003)(52536014)(2351001)(11346002)(99286004)(6916009)(53546011)(66556008)(66946007)(55016002)(46003)(66476007)(14454004)(64756008)(478600001)(76116006)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:YQBPR0101MB1474;H:YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7emAHP9Bcr74IDvP8c1kzFA9owRFfEJVoq07BqbV16rHrcOJhA2TWIasRV+0tImqO0ostWtj2/t9xuQPAyTygE1Dp73y07/yoMgkg8ANbt8FEOx+78rd4Nvs/+Mlv8zaG6r4T03wA70BmNkkQ+X7sbVmTlsbIiIepf/VU9aExj72e93baeKgeQ1IivT0t7YFpSS8IM1G2yKwYZMbn+h51deM5xWOvhrHQSP2aKoDunq5xbSA07MjTRc56rMUrV66oDU/QHJdRsLocCmhNNGV5EzpA2usT8ji0uzww9XrqieQkYwGzPxsNwLeUXeJC9N3xtb5I8dj5/nxQYjN/lr5pUBQmuD1/8l164K7VmYssBWcytkexdMY9099i+odXBxzi2sh5LY6tCTL3T3nI5xHQ6o4hx7BFlW3Q/bwUNIZ71g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: f81e6548-0c13-4d27-0170-08d752014063
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 06:22:42.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXMh4s2nLDc839Hs+4Bc9MjH012Tv4licRjF3FUfJZZevvYiwZ7xcVXiN8zlMkChutxOggnwas8WrB7b76ygwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1474
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It seems that the Copy reply with wr_count == 0 occurs when the client
sends a Copy request with ca_src_offset beyond EOF in the input file.
(It happened because I was testing an old/broken version of my client,
 but I can reproduce it, if you need a bugfix to be tested. I don't know if
 the case of ca_src_offset+ca_count beyond EOF behaves the same?)
--> The RFC seems to require a reply of NFS4ERR_INVAL for this case.

rick

________________________________________
From: linux-nfs-owner@vger.kernel.org <linux-nfs-owner@vger.kernel.org> on behalf of Rick Macklem <rmacklem@uoguelph.ca>
Sent: Tuesday, October 15, 2019 10:50 PM
To: linux-nfs@vger.kernel.org
Subject: NFSv4.2 server replies to Copy with length == 0

During interop testing (FreeBSD client->Linux server) of NFSv4.2, my
client got into a loop. It was because the reply to Copy was NFS_OK,
but the length in the reply is 0.
(I'll fix the client to fail for this case so it doesn't loop, but...)

The server is Fedora 30 (5.2.18-200 kernel version).
It you think this might be fixed in a newer kernel or you'd like me to do
something with it to get more info, just let me know.

I've attached a snippet of the packet trace. (If the list strips it off, just email
me and I'll send it to you.)

rick
