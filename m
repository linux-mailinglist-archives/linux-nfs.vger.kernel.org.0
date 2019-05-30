Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA130589
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 01:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3XxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 30 May 2019 19:53:22 -0400
Received: from mail-eopbgr670050.outbound.protection.outlook.com ([40.107.67.50]:46326
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfE3XxW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 19:53:22 -0400
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM (52.132.86.223) by
 QB1PR01MB3058.CANPRD01.PROD.OUTLOOK.COM (52.132.86.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 30 May 2019 23:53:19 +0000
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a890:15d:5609:414d]) by QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a890:15d:5609:414d%3]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 23:53:19 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <aglo@umich.edu>, Tom Talpey <tom@talpey.com>
CC:     NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Topic: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Index: AQHVFwrcF45FZX1V9USc0b6Vz393HaaD6dYAgABo6rQ=
Date:   Thu, 30 May 2019 23:53:19 +0000
Message-ID: <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>,<CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
In-Reply-To: <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53891290-efd6-4ee0-000d-08d6e559fde8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:QB1PR01MB3058;
x-ms-traffictypediagnostic: QB1PR01MB3058:
x-microsoft-antispam-prvs: <QB1PR01MB3058F60313C23797A6A84F26DD180@QB1PR01MB3058.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(199004)(189003)(186003)(53546011)(14444005)(786003)(110136005)(256004)(46003)(99286004)(14454004)(229853002)(54906003)(316002)(102836004)(305945005)(6246003)(53936002)(6506007)(2171002)(55016002)(11346002)(486006)(9686003)(76176011)(4326008)(7696005)(68736007)(446003)(25786009)(478600001)(476003)(66446008)(74482002)(2906002)(81166006)(86362001)(81156014)(52536014)(8676002)(76116006)(66946007)(64756008)(66556008)(66476007)(74316002)(33656002)(91956017)(8936002)(71200400001)(73956011)(71190400001)(6436002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:QB1PR01MB3058;H:QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xxx35tqIYhyoRbno4T9Thr1E64XcNSqX8y0/1/s+5GVBVRTUGxDwHrL9OQx15us5cvBrCGUI34+MLdF8ZEnicm1qErCRHA/wev8djy9bM/8vuZoRy8z3j6qyNBfJ/Exfg3KxRGVNyl9xweDwLFiThfZmNSdkrg4w1hznQYingmqjtNJFYxaTZQwy9JoTWkc7DxYTFtBAndhM52wQgZLQKsIrPw+1nYdLx5g7ubP8+L3gGuU/cbUU6waMvv1U1QtqhRx0NWIijPST9ajlih9Ajs1H4hcQhXZls2R82uSCVlhzMM158ojsK8j8uCzeqnbbNfdjWTAI3NINqqfeaDFzJhv8PQq+42ICpnHIrZtZ5HcqBB+p+Xq233ZT4midKWH41Ic2cVq0ktwpTGct/KKISeX1IYi9N0hGTIRP31tLNqU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 53891290-efd6-4ee0-000d-08d6e559fde8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 23:53:19.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmacklem@uoguelph.ca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3058
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga Kornievskaia wrote:
>On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>
>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>> > I've also re-arrange the patches a bit, merged two, and remove the
>> > restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>> > these restrictions were not needed, I can see no need.
>>
>> I believe the need is for the correctness of retries. Because NFSv2,
>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>> duplicate request caches are important (although often imperfect).
>> These caches use client XID's, source ports and addresses, sometimes
>> in addition to other methods, to detect retry. Existing clients are
>> careful to reconnect with the same source port, to ensure this. And
>> existing servers won't change.
>
>Retries are already bound to the same connection so there shouldn't be
>an issue of a retransmission coming from a different source port.
I don't think the above is correct for NFSv4.0 (it may very well be true for NFSv3).
Here's what RFC7530 Sec. 3.1.1 says:
3.1.1.  Client Retransmission Behavior

   When processing an NFSv4 request received over a reliable transport
   such as TCP, the NFSv4 server MUST NOT silently drop the request,
   except if the established transport connection has been broken.
   Given such a contract between NFSv4 clients and servers, clients MUST
   NOT retry a request unless one or both of the following are true:

   o  The transport connection has been broken

   o  The procedure being retried is the NULL procedure

If the transport connection is broken, the retry needs to be done on a new TCP
connection, does it not? (I'm assuming you are referring to a retry of an RPC here.)
(My interpretation of "broken" is "can't be fixed, so the client must use a different
 TCP connection.)

Also, NFSv4.0 cannot use Sun RPC over UDP, whereas some DRCs only
work for UDP traffic. (The FreeBSD server does have DRC support for TCP, but
the algorithm is very different than what is used for UDP, due to the long delay
before a retried RPC request is received. This can result in significant server
overheads, so some sites choose to disable the DRC for TCP traffic or tune it
in such a way as it becomes almost useless.)
The FreeBSD DRC code for NFS over TCP expects the retry to be from a different
port# (due to a new connection re: the above) for NFSv4.0. For NFSv3, my best
recollection is that it doesn't care what the source port# is. (It basically uses a
hash on the RPC request excluding TCP/IP header to recognize possible duplicates.)

I don't know what other NFS servers choose to do w.r.t. the DRC for NFS over TCP,
however for some reason I thought that the Linux knfsd only used a DRC for UDP?
(Someone please clarify this.)

rick

> Multiple connections will result in multiple source ports, and possibly
> multiple source addresses, meaning retried client requests may be
> accepted as new, rather than having any chance of being recognized as
> retries.
>
> NFSv4.1+ don't have this issue, but removing the restrictions would
> seem to break the downlevel mounts.
>
> Tom.
>
