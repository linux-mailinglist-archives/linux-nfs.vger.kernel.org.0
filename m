Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCA30692
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 04:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEaCUD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 30 May 2019 22:20:03 -0400
Received: from mail-eopbgr670059.outbound.protection.outlook.com ([40.107.67.59]:15314
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfEaCUD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 22:20:03 -0400
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM (52.132.86.223) by
 QB1PR01MB3602.CANPRD01.PROD.OUTLOOK.COM (52.132.84.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 02:20:00 +0000
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a890:15d:5609:414d]) by QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a890:15d:5609:414d%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 02:20:00 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     NeilBrown <neilb@suse.com>, Olga Kornievskaia <aglo@umich.edu>,
        Tom Talpey <tom@talpey.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Topic: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Index: AQHVFwrcF45FZX1V9USc0b6Vz393HaaD6dYAgABo6rSAABf1gIAADZJ8
Date:   Fri, 31 May 2019 02:20:00 +0000
Message-ID: <QB1PR01MB2643E05DF1A13967BB21B1C3DD190@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
 <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
 <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>,<87h89bxwr2.fsf@notabene.neil.brown.name>
In-Reply-To: <87h89bxwr2.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736aa792-0581-41f9-578b-08d6e56e7bcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:QB1PR01MB3602;
x-ms-traffictypediagnostic: QB1PR01MB3602:
x-microsoft-antispam-prvs: <QB1PR01MB36026A703D8729C8DC0C0E59DD190@QB1PR01MB3602.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(14444005)(256004)(6246003)(53936002)(99286004)(25786009)(786003)(71190400001)(5660300002)(71200400001)(2171002)(316002)(68736007)(52536014)(76176011)(305945005)(74482002)(110136005)(54906003)(66446008)(66476007)(66946007)(91956017)(76116006)(73956011)(64756008)(14454004)(478600001)(7696005)(66556008)(74316002)(2906002)(46003)(186003)(6506007)(81156014)(53546011)(11346002)(446003)(6436002)(8676002)(229853002)(4326008)(33656002)(102836004)(55016002)(81166006)(476003)(486006)(9686003)(86362001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:QB1PR01MB3602;H:QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y1R8cZddt750TvcKanU6d5oid1eHY//CCRbx+WPKJXgLghDA3tWscSuSyWHdNoACz8qy8uwENhJhGAPRBU281HDV0WQGv49SVi2Me7Rr+XWm28ewOgsvgitFPt6RGkVGNiCvoEFZ4dXjhGdtV9HnlXmalCB4/tF3ZuoUT4Eo6gC2GMQ+Khw0HIxIMIJ+bWjLV2VLlfZOzPn5KohQd+PJcy229zZA3AlW3K2g58p0lcsWcpoIDsvccCZ40ak9JSJWkfOVlK69mon0ScRetMKdDGkGgUIyU+4RSkTp1atRg9VUTMMNKYud2sFyyHHUJ0+7q7redC63zcb9LqsXhcbqjeX+Iu4kLbOBzupAGkazAyQwtewK/RRR2XSfKX/V5XmseJlUIsgT26yeHexfmlF9zHbmOeVm7Au9k4SoGsdVq6k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 736aa792-0581-41f9-578b-08d6e56e7bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 02:20:00.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmacklem@uoguelph.ca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3602
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NeilBrown wrote:
>On Thu, May 30 2019, Rick Macklem wrote:
>
>> Olga Kornievskaia wrote:
>>>On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>>> > I've also re-arrange the patches a bit, merged two, and remove the
>>>> > restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>>>> > these restrictions were not needed, I can see no need.
>>>>
>>>> I believe the need is for the correctness of retries. Because NFSv2,
>>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>>> duplicate request caches are important (although often imperfect).
>>>> These caches use client XID's, source ports and addresses, sometimes
>>>> in addition to other methods, to detect retry. Existing clients are
>>>> careful to reconnect with the same source port, to ensure this. And
>>>> existing servers won't change.
>>>
>>>Retries are already bound to the same connection so there shouldn't be
>>>an issue of a retransmission coming from a different source port.
>> I don't think the above is correct for NFSv4.0 (it may very well be true for NFSv3).
>
>It is correct for the Linux implementation of NFS, though the term
>"xprt" is more accurate than "connection".
>
>A "task" is bound it a specific "xprt" which, in the case of tcp, has a
>fixed source port.  If the TCP connection breaks, a new one is created
>with the same addresses and ports, and this new connection serves the
>same xprt.
Ok, that's interesting. The FreeBSD client side krpc uses "xprt"s too
(I assume they came from some old Sun open sources for RPC)
but it just creates a new socket and binds it to any port# available.
When this happens in the FreeBSD client, the old connection is sometimes still
sitting around in some FIN_WAIT state. My TCP is pretty minimal, but I didn't
think you could safely create a new connection using the same port#s at that point,
or at least the old BSD TCP stack code won't allow it.

Anyhow, the FreeBSD client doesn't use same source port# for the new connection.

>> Here's what RFC7530 Sec. 3.1.1 says:
>> 3.1.1.  Client Retransmission Behavior
>>
>>    When processing an NFSv4 request received over a reliable transport
>>    such as TCP, the NFSv4 server MUST NOT silently drop the request,
>>    except if the established transport connection has been broken.
>>    Given such a contract between NFSv4 clients and servers, clients MUST
>>    NOT retry a request unless one or both of the following are true:
>>
>>    o  The transport connection has been broken
>>
>>    o  The procedure being retried is the NULL procedure
>>
>> If the transport connection is broken, the retry needs to be done on a new TCP
>> connection, does it not? (I'm assuming you are referring to a retry of an RPC here.)
>> (My interpretation of "broken" is "can't be fixed, so the client must use a different
>>  TCP connection.)
>
>Yes, a new connection.  But the Linux client makes sure to use the same
>source port.
Ok. I guess my DRC code that expects "different source port#" for NFSv4.0 is
broken. It will result in a DRC miss, which isn't great, but is always possible for
any DRC design. (Not nearly as bad as a false hit.)

>>
>> Also, NFSv4.0 cannot use Sun RPC over UDP, whereas some DRCs only
>> work for UDP traffic. (The FreeBSD server does have DRC support for TCP, but
>> the algorithm is very different than what is used for UDP, due to the long delay
>> before a retried RPC request is received. This can result in significant server
>> overheads, so some sites choose to disable the DRC for TCP traffic or tune it
>> in such a way as it becomes almost useless.)
>> The FreeBSD DRC code for NFS over TCP expects the retry to be from a different
>> port# (due to a new connection re: the above) for NFSv4.0. For NFSv3, my best
>> recollection is that it doesn't care what the source port# is. (It basically uses a
>> hash on the RPC request excluding TCP/IP header to recognize possible
>> duplicates.)
>
>Interesting .... hopefully the hash is sufficiently strong.
It doesn't just use the hash (it still expects same xid, etc), it just doesn't use the TCP
source port#.

To be honest, when I played with this many years ago, unless the size of the DRC
is very large and entries persist in the cache for a long time, they always fall out
of the cache before the retry happens over TCP. At least for the cases I tried back
then, where the RPC retry timeout for TCP was pretty large.
(Sites that use FreeBSD servers under heavy load usually find the DRC grows too
 large and tune it down until it no longer would work for TCP anyhow.)

My position is that this all got fixed by sessions and if someone uses NFSv4.0 instead
of NFSv4.1, they may just have to live with the limitations of no "exactly once"
semantics. (Personally, NFSv4.0 should just be deprecated. I know people still have good uses for NFSv3, but I have trouble believing NFSv4.0 is preferred over NFSv4.1,
although Bruce did note a case where there was a performance difference.)

>I think it is best to assume same source port, but there is no formal
>standard.
I'd say you can't assume "same port#" or "different port#', since there is no standard.
But I would agree that "assuming same port#" will just result in false misses for
clients that don't use the same port#.

rick

>Thanks,
>NeilBrown
>
>
>
>> I don't know what other NFS servers choose to do w.r.t. the DRC for NFS over TCP,
>> however for some reason I thought that the Linux knfsd only used a DRC for UDP?
>> (Someone please clarify this.)
>>
>> rick
>>
>>> Multiple connections will result in multiple source ports, and possibly
>>> multiple source addresses, meaning retried client requests may be
>>> accepted as new, rather than having any chance of being recognized as
>>> retries.
>>>
>>> NFSv4.1+ don't have this issue, but removing the restrictions would
>>> seem to break the downlevel mounts.
>>>
>>> Tom.
>>>
