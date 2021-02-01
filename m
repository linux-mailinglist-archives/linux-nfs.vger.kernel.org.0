Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B46309FAA
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Feb 2021 01:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBAAU5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 19:20:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53734 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBAAUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jan 2021 19:20:53 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1110DQHf072278;
        Mon, 1 Feb 2021 00:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T0CHm9uZ5XXiBjuzgrR9iQFsYYgA7dWnhET4MhmqPXI=;
 b=Fti+wsMCQVaC0kVqDfGaRURWh/FY6WViWSoU2mvrS+M7Vznl9X7lj0ZXrAe+ZACE9GaO
 C+dgIWf0RC9I7FCTG7FoHnIp5UB8/OhNyW6WUzxOHZ423GEw03F8lJHNL806dooPgLQu
 QUgi5vwbsQBT9iNy6q72zwe7bPAhTaER7cWKFO7BHMLL8q7zf6KiUL3EAHMB1mfn4w+B
 xq3eqVjYY1pC2dr1lyraNM52sm2sPyUfutCDdO4NE/vdf44gVZP9zwQOj6PUpzsdnDqh
 OPf4lPuHhU85XQ1+3IwJWQKBjCTkdF+w7eCreFqwJHRV3pvo/t4liUvB8zADSvrvcsNB yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36cvyak66n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 00:20:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1110K4P3045133;
        Mon, 1 Feb 2021 00:20:07 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by userp3020.oracle.com with ESMTP id 36dh7p0w5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 00:20:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuF472BltJZ21JRbPNdooxRs68G8u/w1YKWvkQy+tFeZn+nc5Qj1EtKq4OesZMnl9JIKtwEf8izq4ps2dYxkCg1BfB++M80In+pSTtiUuM8UVvOjXv69g76xcgGl6oWXi6xRhtG24PdFWRxbt7W2xFPxkhdWl+lapgoW+qN+LTeVz4qQwq8UXTcgFnaZOoJ0k2DvpkVgaD8FEkPQq/pWkVnfs3vAZW0R+XABT56wRjhJeDmG1P/Y/FXV+dIlRYjWZtbD0SQxnjlPs0rh5FXDtOyKrny8tTrGpHq4wNdvuj0N1LWipvnB7lcfUpqn4rvr8ztyc1qiCFENZdwYCUXhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0CHm9uZ5XXiBjuzgrR9iQFsYYgA7dWnhET4MhmqPXI=;
 b=cmylGoyTGt6y8kh2cWVY80yEJQVsk2UegEwMhLh24edLk1dz+9iP2YqlBf8Ch0ZGitref/OmJQfRhO6aTH7dg2fztO4UcVrZdbCxrCA6HoBMFTvfYseDdOVCU5xYUdg0IUJCEzPLqrpiG5kL7eceQ5JeNiK3pKdjKwQkZH49W0NZe9+nkE64OzMT7dx7nmCXIOcTMuXdtGGeckJ3MShB/Zu2l1vv2EqksxUY1hsQXVT/LYxQkr++YLNA2U7YRBQPlBm7ojTf/gE7bRpcNcHvIguxX5XG9RK1HCFCLW6e2MTCmJHey17HQIHo2Phc+vr5rC4JdGpDtFWnnpIG1POtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0CHm9uZ5XXiBjuzgrR9iQFsYYgA7dWnhET4MhmqPXI=;
 b=uPVkTzpuuZGMprLwArbMdaImrz88aXUXuiSX1iOsTYDqDYYGbRdbuq8LhBUNcIODweDvTVqj/NIoDNgeJygJlWAPtOxtXQ51BwQmZEymhvoIbFllA+9l6LZ5CV0wZsfz5d/ARiykOfTu/m5+gCNxfnt4pQtWAMVNC9bO6bcWY7Y=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2565.namprd10.prod.outlook.com (2603:10b6:a02:b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Mon, 1 Feb
 2021 00:19:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 00:19:58 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
Thread-Topic: releasing result pages in svc_xprt_release()
Thread-Index: AQHW9lp7CEvfS3Emm06zTXNJoADK66o/M5eAgAAGcQCAAy+VgIAACaAA
Date:   Mon, 1 Feb 2021 00:19:58 +0000
Message-ID: <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
In-Reply-To: <878s88fz6s.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2400d61-7994-4394-7e49-08d8c6471c1f
x-ms-traffictypediagnostic: BYAPR10MB2565:
x-microsoft-antispam-prvs: <BYAPR10MB2565F33B566601B2DD7CA47A93B69@BYAPR10MB2565.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdsemB6+9Nkv1FmmjjlcoBVGZ5r5q9Zfv/RY4v+F9V+faH1dVDcViq8jYye8Pfk/VEZLlbmqsr95og6IOrGsfjIWJknZ0tEMxo7Jb32XxNvKPFDwVRG3oxZfdh9J44EWKluBbMRu3It5wdXacVMjGQ0YWPAZ6LrPp6dCUvyjIDcL6kpYtNAsE1o00C/Cs9BsiNjv5UkUGR/1K3Gqa3RIAjGw40zinH6CRl0ITjiEVCAVSjUTx7+uBQ4wkIuU0RaqFLQ5Bpj/TVIKovqL3FBSpBwmeTsJHhV9QPCaIu4hlvaZf9soIQzXZzr1y8G92dOMgwnQlgc+5zpTNXZqK/5BacQjrTMMhSUf8wyP/V06z3uVgJy5SAs8JSkug62BkQgOGgqIZIdoXx3etaiX0/Ya4x1kqiJRZsfLE2J2xgE4nfRnu8/JrUq5qb2vBdPISaw0E3BKJsiYKjxFHRYeeEU8wzgSUuvbnyXwU1aEVN/acqtOpRU/LE7M4WaniDiUUkl7tOYh+41IqOXG8SgKJtKgxTuVGtntOC9SBExzjPG3ObOVZtiA4IMUos72nT7Qnca1pLrA4Dhnb6ets2CBqXZFZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(316002)(33656002)(2906002)(5660300002)(8936002)(71200400001)(44832011)(83380400001)(186003)(4326008)(36756003)(26005)(6916009)(6486002)(8676002)(64756008)(76116006)(66556008)(66946007)(66476007)(66446008)(91956017)(6506007)(6512007)(53546011)(86362001)(2616005)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7wYolVjbKo4a/nuyqcSitxKdwn3BKzV+FO6V2e4M4Dbk7bdKWLrxb9OvLrXg?=
 =?us-ascii?Q?u0rk6hECgrhWquada/qVk09UFwEsS2t9Q06YcQuz3SKBaFdH/qCY5HiMBYdg?=
 =?us-ascii?Q?4UPlfL08T1XGzbp4uKTJ89MJ2BwamvjImja0yAAapBEnQRPu53BUukostMcC?=
 =?us-ascii?Q?lw5N8STY0j/ms9Mt0/3SkXt60B7TW3LSo5MQRzjIsdlr8XM4zuZE0Ra3U9qT?=
 =?us-ascii?Q?F6uK6nwScNStsQXrSkY7RkEbiDA7yGOIB8xP4TMScDOxG6t/Pc9Q06VMK0TY?=
 =?us-ascii?Q?BIAxDipf15dsyOchrVSrvHkYzGdbiTaH6XAseqDV8aHzcZOtQQMGgsCdCQBM?=
 =?us-ascii?Q?EeUyJk1HIrpHPxvC67epRdFBNDkpqqAeP1fqVYMTqZ/zc8ox1/qdup9qdbDV?=
 =?us-ascii?Q?EbMGylJRbGzunmz2kSplhYJwaBE8cb7RpGPubzMJsT6oeEsdu5odRRnkk5hl?=
 =?us-ascii?Q?MyaG2WO6JFIPiSxScehO0Dld9F57LCWKWNGVKyu3PM6JcljMGT0UhRnLJ+lO?=
 =?us-ascii?Q?IQjTaqu9g4llQbEdeoHjVU3GRnlf/wPZTjLUz9sFlrwOflUM3koQq21asMLW?=
 =?us-ascii?Q?3af+uAYDU4XaKFNSQDGFaokL13W++TTfutXCrkyP8IPRxczDUDSrINLWjvys?=
 =?us-ascii?Q?grNJYsbMFAQ3CTiDWNgUW20XXxvbv4nD9zM1yuvzWBvE7cHsyA0WJD0Jdx7F?=
 =?us-ascii?Q?eWltTwdvHxW5n0pVzzLVCxj3xjAuFDGoeSDZz2dP/dxbfeTKfwZmZ2NqKBf+?=
 =?us-ascii?Q?Wu6iHt+yral40AFeZICh5FhmZcptY39Qpae6HKs3QXpMCYE00VR4IkXQdVdE?=
 =?us-ascii?Q?eZ7q+TZnhL5I6QIb4vY0cYiHMByDmP0zCZL+zlQbOG74rHJZN8d3WAamERww?=
 =?us-ascii?Q?+skiY0NCyL4b5uvz3Vh3hqHvyrkB+KpyA5dHx5ttPuvKcIi1DnTph+kxdChD?=
 =?us-ascii?Q?ssXvzTy7mWhKWKgis3COQQB2CY01ADSMWUt59RBkVeR0gk0QOL6vA2MR7Lxn?=
 =?us-ascii?Q?/U5IJ/zRnYLr88/7LuN+xOyxq47uUAbJUOE97dd+K3GbTRac/1RjVgtiL3w1?=
 =?us-ascii?Q?07o/0P0xEczorHRuqtaNXAJB/A+N6g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54E76EAE22AC5D44A77BD7CF3AFC1541@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2400d61-7994-4394-7e49-08d8c6471c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 00:19:58.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYTUs7LdEhU1vpBqy9PjvL0gybfBKg+Lu/qLs+C4cGsiws/Sn81pLryOrAOedP3sY8xBwCcL3TyjMrluPNpwTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2565
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010000
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2021, at 6:45 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, Jan 29 2021, Chuck Lever wrote:
>=20
>>> On Jan 29, 2021, at 5:43 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, Jan 29 2021, Chuck Lever wrote:
>>>=20
>>>> Hi Neil-
>>>>=20
>>>> I'd like to reduce the amount of page allocation that NFSD does,
>>>> and was wondering about the release and reset of pages in
>>>> svc_xprt_release(). This logic was added when the socket transport
>>>> was converted to use kernel_sendpage() back in 2002. Do you
>>>> remember why releasing the result pages is necessary?
>>>>=20
>>>=20
>>> Hi Chuck,
>>> as I recall, kernel_sendpage() (or sock->ops->sendpage() as it was
>>> then) takes a reference to the page and will hold that reference until
>>> the content has been sent and ACKed.  nfsd has no way to know when the
>>> ACK comes, so cannot know when the page can be re-used, so it must
>>> release the page and allocate a new one.
>>>=20
>>> This is the price we pay for zero-copy, and I acknowledge that it is a
>>> real price.  I wouldn't be surprised if the trade-offs between
>>> zero-copy and single-copy change over time, and between different
>>> hardware.
>>=20
>> Very interesting, thanks for the history! Two observations:
>>=20
>> - I thought without MSG_DONTWAIT, the sendpage operation would be
>> total synchronous -- when the network layer was done with retransmission=
s,
>> it would unblock the caller. But that's likely a mistaken assumption
>> on my part. That could be why sendmsg is so much slower than sendpage
>> in this particular application.
>>=20
>=20
> On the "send" side, I think MSG_DONTWAIT is primarily about memory
> allocation.  send_msg() can only return when the message is queued.  If
> it needs to allocate memory (or wait for space in a restricted queue),
> then MSG_DONTWAIT says "fail instead".  It certainly doesn't wait for
> successful xmit and ack.

Fair enough.


> On the "recv" side it is quite different of course.
>=20
>> - IIUC, nfsd_splice_read() replaces anonymous pages in rq_pages with
>> actual page cache pages. Those of course cannot be used to construct
>> subsequent RPC Replies, so that introduces a second release requirement.
>=20
> Yep.  I wonder if those pages are protected against concurrent updates
> .. so that a computed checksum will remain accurate.

That thought has been lingering in the back of my mind too. But the
server has used sendpage() for many years without a reported issue
(since RQ_SPLICE_OK was added).


>> So I have a way to make the first case unnecessary for RPC/RDMA. It
>> has a reliable Send completion mechanism. Sounds like releasing is
>> still necessary for TCP, though; maybe that could be done in the
>> xpo_release_rqst callback.
>=20
> It isn't clear to me what particular cost you are trying to reduce.  Is
> handing a page back from RDMA to nfsd cheaper than nfsd calling
> alloc_page(), or do you hope to keep batches of pages together to avoid
> multi-page overheads, or is this about cache-hot pages, or ???

RDMA gives consumers a reliable indication that the NIC is done with
each page. There's really no need to cycle the page at all (except
for the splice case).

I outline the savings below.


>> As far as nfsd_splice_read(), I had thought of moving those pages to
>> a separate array which would always be released. That would need to
>> deal with the transport requirements above.
>>=20
>> If nothing else, I would like to add mention of these requirements
>> somewhere in the code too.
>=20
> Strongly agree with that.
>=20
>>=20
>> What's your opinion?
>=20
> To form a coherent opinion, I would need to know what that problem is.
> I certainly accept that there could be performance problems in releasing
> and re-allocating pages which might be resolved by batching, or by copyin=
g,
> or by better tracking.  But without knowing what hot-spot you want to
> cool down, I cannot think about how that fits into the big picture.
> So: what exactly is the problem that you see?

The problem is that each 1MB NFS READ, for example, hands 257 pages
back to the page allocator, then allocates another 257 pages. One page
is not terrible, but 510+ allocator calls for every RPC begins to get
costly.

Also, remember that both allocating and freeing a page means an irqsave
spin lock -- that will serialize all other page allocations, including
allocation done by other nfsd threads.

So I'd like to lower page allocator contention and the rate at which
IRQs are disabled and enabled when the NFS server becomes busy, as it
might with several 25 GbE NICs, for instance.

Holding onto the same pages means we can make better use of TLB
entries -- fewer TLB flushes is always a good thing.

I know that the network folks at Red Hat have been staring hard at
reducing memory allocation in the stack for several years. I recall
that Matthew Wilcox recently made similar improvements to the block
layer.

With the advent of 100GbE and Optane-like durable storage, the balance
of memory allocation cost to device latency has shifted so that
superfluous memory allocation is noticeable.


At first I thought of creating a page allocator API that could grab
or free an array of pages while taking the allocator locks once. But
now I wonder if there are opportunities to reduce the amount of page
allocator traffic.


--
Chuck Lever



