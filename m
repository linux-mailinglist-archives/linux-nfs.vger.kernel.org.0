Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC3A05CE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH1PM3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 28 Aug 2019 11:12:29 -0400
Received: from mail-eopbgr660075.outbound.protection.outlook.com ([40.107.66.75]:41560
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbfH1PM3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:12:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuxfJfzupcG5xVeQxXmfmu7BqfbiIgdXBEi6EJiyKnxWwJigR6g46IsJO84RNMKVIYJ6sn+UdOjeEF7wzjS6oGFo1LZblJY6mOAfWGO44kHm2DboX9ybZdxIQ0h7OLv/lubIoMt3sHay0dCqj3YjxMoULt/78qo80HwO0qTlYyWI6jWUV5ysj67YQjeUklUhV6XulGox2SbRTEAgKL6s3PX5kI5CKtWaakS7akPOHD4S3Qd4ocaOVJJEwDITl6OfcYpg0p5leZhNBeoY/GjLZNtTBEy5KhcxNzhW36GCzc3MC42I2ZekJHigD2tgbfx23RAeNfOqsYkKRvikMay/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adBQTdrKBmY2EGHyd4TCobBlp7Oo3I634a8/sQ2rQoM=;
 b=btICLodhwtZ7bAODeJtMbepdq/J79yz1hzkgWF3mE2wKHDb8JuTxFR+IkCIf08Q92Z81qk2dKGqa4l6ciIahzwCdgHoSegHV6yKUOxI8ZGbUe7E4HwsDHAXgmP2JGTz4zm8h1erR95j4XXsTTZjCUL4P4H3ude06Aa1S7rKj204EBQ69KbEHPWb7iBgMbLqCokyIp8PtOEdRZAdSiTVVGAzZCrAkAXMQSauAl3+V1lRfEsqZiDNEjCQ4lFtUoOiGPKwBFKz4QqMN1qsA/yBqh6eKkUyrgaeCusQ2dKjeygyQ1pK9uF/cj50rHgSUA/gmiAffJoaqgiZAwulmFxXefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM (10.255.42.216) by
 YT1PR01MB3371.CANPRD01.PROD.OUTLOOK.COM (10.255.43.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 28 Aug 2019 15:12:26 +0000
Received: from YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4031:c693:f53a:9ce3]) by YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4031:c693:f53a:9ce3%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 15:12:26 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXadOuqwLlZUn50iGFZUrgP1+r6cQlBIAgAABqoCAAADtAIAAAKOAgAADq4CAAAbPgIAABKVd
Date:   Wed, 28 Aug 2019 15:12:26 +0000
Message-ID: <YT1PR01MB29075543EF1DD94AE0101631DDA30@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
References: <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
 <20190828140044.GA14249@parsley.fieldses.org>
 <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
 <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>,<20190828144031.GB14249@parsley.fieldses.org>
In-Reply-To: <20190828144031.GB14249@parsley.fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 793871b5-93db-4255-4ffc-08d72bca22e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YT1PR01MB3371;
x-ms-traffictypediagnostic: YT1PR01MB3371:
x-microsoft-antispam-prvs: <YT1PR01MB3371931E13E53523A738DFC6DDA30@YT1PR01MB3371.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(71200400001)(71190400001)(53936002)(256004)(786003)(4326008)(52536014)(33656002)(6246003)(55016002)(2906002)(86362001)(6436002)(486006)(102836004)(6506007)(229853002)(76176011)(7696005)(476003)(11346002)(186003)(9686003)(46003)(14454004)(446003)(478600001)(8676002)(8936002)(99286004)(305945005)(81166006)(74316002)(66476007)(66946007)(66446008)(64756008)(76116006)(110136005)(54906003)(66556008)(316002)(5660300002)(25786009)(81156014)(17423001);DIR:OUT;SFP:1101;SCL:1;SRVR:YT1PR01MB3371;H:YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9l3g+qiCIPZ9XxLBp5Sw9iuf3yL3wW0m08qFUFylgZk3VQi8SjW28f7GL2/+A4p8Jb8QbGvfIl3kfdn7MgrMWnXXZE+ujoo8IKyBS0MaMYw7qjJ5hbCrNBHnPEq6FRZW7WKfwpVLn4Y9pLNdh3d9Ejj0GWaeLksUzV/6oOCSQCLQKtlUgLhEhmxLAqkQjNyefVNiWg4q15OLbhDNP6nMn/iEEHJtoGo1ucqc5Pu5EIh89phahzfxFbhs8j387xNuRMqOzd4Cyb0HZKiVs4bvZKPZKc/fafI0xUmiF7kYhmhSQ6vmZ3bEcsYhRri6Z1XRqsf/ZNQ3w5wBCQYFo2MSr0rrbYA+zwwdHOe7ka+YigI1H8axFN3wOmMQ0RazMeXr8Em/8usqvi5efcpIoYRaY0Kq1k3oIxPF/z+ATKRgXPQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 793871b5-93db-4255-4ffc-08d72bca22e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 15:12:26.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0c5UzF/HqNYrk8GjE4gphSYTfKs4gMngUNjRBlKFv8hjX/NQj8tmqjDU/uMbFmhxejhWZFT7FbUwD4eUx9kBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB3371
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

J. Bruce Fields wrote:
>On Wed, Aug 28, 2019 at 10:16:09AM -0400, Jeff Layton wrote:
>> For the most part, these sorts of errors tend to be rare. If it turns
>> out to be a problem we could consider moving the verifier into
>> svc_export or something?
>
>As Trond says, this isn't really a server implementation issue, it's a
>protocol issue.  If a client detects when to resend writes by storing a
>single verifier per server, then returning different verifiers from
>writes to different exports will have it resending every time it writes
>to one export then another.

Well, here's what RFC-1813 says about the write verifier:
         This cookie must be consistent during a single instance
         of the NFS version 3 protocol service and must be
         unique between instances of the NFS version 3 protocol
         server, where uncommitted data may be lost.
You could debate what "service" means in the above, but I'd say it isn't "per file".

However, since there is no way for an NFSv3 client to know what a "server" is,
the FreeBSD client (and maybe the other *BSD, although I haven't been involved
in them for a long time) stores the write verifier "per mount".
--> So, for the FreeBSD client, it is at the granularity of what the NFSv3 client sees as
     a single file system. (Typically a single file system on the server unless the knfsd
     plays the game of coalescing multiple file systems by uniquifying the I-node#, etc.)

It is conceivable that some other NFSv3 client might assume
"same server IP address --> same server" and store it "per server IP", but I have
no idea if any such client exists.

rick
