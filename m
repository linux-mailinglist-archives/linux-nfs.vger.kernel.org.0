Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B319B899
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2019 00:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfHWWoz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 23 Aug 2019 18:44:55 -0400
Received: from smtppost.atos.net ([193.56.114.176]:6622 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHWWoz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Aug 2019 18:44:55 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost1.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 5e85_092c_8651aabb_d3a5_4b37_88f8_b83b9412f078;
        Sat, 24 Aug 2019 00:31:20 +0200
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7NMVKqX012445
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2019 00:31:20 +0200
Received: from DEFTHW99ETTMSX.ww931.my-it-solutions.net ([10.86.142.101])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7NMVKec030662
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2019 00:31:20 +0200
Received: from DEERLM99ETWMSX.ww931.my-it-solutions.net (10.86.142.45) by
 DEFTHW99ETTMSX.ww931.my-it-solutions.net (10.86.142.101) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Sat, 24 Aug 2019 00:31:20 +0200
Received: from DEERLM99ETTMSX.ww931.my-it-solutions.net (10.86.142.105) by
 DEERLM99ETWMSX.ww931.my-it-solutions.net (10.86.142.45) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Sat, 24 Aug 2019 00:31:19 +0200
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.105) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Sat, 24 Aug 2019 00:31:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsAzAP4oqo+/B1df1VqYFzkPv6K+2zK8iF8ceaKFmg9u2q1Ra36ZNA7q7C+Lm4yLFslpWCmfbYStwihqnvkJ07PXC4pgZ34FPIaKqCGJfhjsRQYyzACaRLp9T3u71FncMPbe7nDc5peqtG4hTQfJsy47GPuGrSk2P7hE5yhL/Q1fQRfSsq3yMh5wKvnlmq/Me1UmwAyLNyCNqp5PlLOu10uz7OVczJ4XI3IjtZI6QwVLKNcKdh9e65pm6u9bDEA2TQ01qg6gct1HTDhe9Oo7O6io0/ri6Bzc3SsKnkHzPJwCnJhkzjWyoE0RWPvgjJ1kR7x1w6SBIfsohLJ7jdjKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQlfYZXNgKYnpsUi1cWqJhY4Qy09WG41hqpSEYbcIZY=;
 b=MObeBIo6UMQxQwT0JJWPOSCd2bFcHygLDNd+QcykzUJOcuj8ZLfzAzcq0yTjnHS3f7Xwz/0Juw4KRlrqsQSScsbIWzqugpE3IJbgapkQAgkplJGOtzrfju+k3cXwjgJFrcRL+fpGrOUp/Q5PqpoyuYEOPS0NqTPOPeevZWL9+yRow0BamDGEPMNOTL1zB3BtAxvQSaJqqWUjo54aVU5lQvsHolMA+7hZ4J7laPLLcrkE6vkeb2YMoiOymL06sCpp8lRL7lmbU9tSnOpI5fIjk5Fqeld2I+4IEUjDV0jCowjRfUvIU7CLjo/qZT27xdhytFEFDtB+cnrSZhg2K1uEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (10.173.88.135) by
 AM5PR0202MB2515.eurprd02.prod.outlook.com (10.173.88.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 22:31:18 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea%12]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 22:31:18 +0000
From:   "de Vandiere, Louis" <louis.devandiere@atos.net>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Maximum Number of ACL on NFSv4
Thread-Topic: Maximum Number of ACL on NFSv4
Thread-Index: AdVZ/zHAXlVbOFcuRg6ALmyIfYKMtQAAvtpw
Date:   Fri, 23 Aug 2019 22:31:17 +0000
Message-ID: <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
In-Reply-To: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=louis.devandiere@atos.net; 
x-originating-ip: [70.122.228.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f506012-9833-4642-e6e6-08d728199da8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0202MB2515;
x-ms-traffictypediagnostic: AM5PR0202MB2515:
x-microsoft-antispam-prvs: <AM5PR0202MB2515F219D59E57600CA5CE7EE7A40@AM5PR0202MB2515.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(42274003)(199004)(189003)(8676002)(81166006)(2501003)(8936002)(4744005)(3846002)(6916009)(66574012)(6116002)(2906002)(9686003)(476003)(11346002)(55016002)(5640700003)(6436002)(486006)(86362001)(25786009)(229853002)(6246003)(33656002)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(53936002)(26005)(66066001)(52536014)(76116006)(256004)(74316002)(14444005)(5660300002)(6506007)(71190400001)(71200400001)(102836004)(14454004)(446003)(2351001)(478600001)(2940100002)(99286004)(76176011)(7736002)(7696005)(316002)(305945005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0202MB2515;H:AM5PR0202MB2564.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ihBunodv6c0CbRQqPajVMwbJLTgCJbOhSKkXImmO0ElY0ysqXwkoPGxpdaiMxDtIJcroEvMsQnOZ5l+HwkyeiNCk6nnsc4R4/NBb6Nrm9Xa9FuGPI8+G0Cy91UmcnXQsiqGJDph9aQ+WjDCbd/bhQeqHi6FGLviQ0HmsV4/nXdhftlxrEM1Gqc7TWWdQdhNa/Ca4QgNrT6hwr1nI3XiAt3SZmNOzvjRouCMWlJOkegs2vUhrSfFzkriOAxP8bKi2lhyfsNsW7NYrQZ+PIwXh/aUhpxY7jbZxgCtUBc1fhQlp1ty2HIIHS2T/fgOoEDiJjzeFlWxBPd/xqR43EaOLJysAiRoKKrJVpZNo1SKPhOM72kGPbrlCZL2vExpzxTb2runKYp1P0j1tbVo89pBHgvy4OMTqul1T75M76UiByA8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f506012-9833-4642-e6e6-08d728199da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 22:31:17.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4bjB/vb+GBBhr7q5NhUL/q8Kl4JRaSWAcIvCwW5/yfzVV3IsPU6PhAv5NXtHTQTNJyNbq6kZS9CFK13A7Qy3T5oMJ7FoRrknwKl2nNEBug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0202MB2515
X-OriginatorOrg: atos.net
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I'm currently trying to apply hundreds of ACLs on file hosted on a NFSv4 server (nfs-utils-1.3.0-0.61.el7.x86_64 and nfs4-acl-tools.0.3.3-19.el7.x86_64). It appears that the limit I can apply is 207. After the limit is reached, the command "nfs4_setfacl -a" returned the error "Failed setxattr operation: File too large". The same problem happens if I use an ACL with more than 200 line in it. I did a little debugging session but I was not able to come up with an explanation on why I'm facing such an issue.

On the other hand, I can apply hundreds of ACLs on XFS without issue. Do you know if it could be a bug with the nfs4-acl-tools package?
Thank you for your support.
Best,
Louis de Vandière
