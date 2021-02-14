Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F401831B252
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 20:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBNToD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 14:44:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhBNTn5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Feb 2021 14:43:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EJeHYb103595;
        Sun, 14 Feb 2021 19:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ha72N+Y0xqk/hGW+HLj/zqJ+eW23xSz6jXjyb3MRhvA=;
 b=F+mph1+4sqi0hwJseDwg40+hmvCQ8/4G+dZNf96WY9XdPbDfIC1DbV7n773k6c09BYYm
 Jsfl+NiqiN7oKPLW2xi9PmFatsI11JzTw8vLE49lttycMr7bGhejcxpvFw7kZmML+UCZ
 aMeTFt0J5KSQ/wz2eARyivTvakajCEwz+mVq7UrmQL9l19obakdkQCa80YvJI2LZbQ6x
 oin8yZjEMt2MEnl+u3Y8JjmgPixoY86xsI6cYywU4tFGYZYHtJnXJBsyr+vhUYpcFq2n
 WYEYYe+LOxcTaFFEMg3fQvnnBsOV8Op6DNHszE4lzoy76JSYwNqRDTSAjKGiMrqZ2ZuJ 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dna9c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 19:43:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EJfL0f034248;
        Sun, 14 Feb 2021 19:43:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 36prhpkup1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 19:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biHZ7QaPal90I/gi0l2L9HrYnowlAFAjSSbfGPlgp/8wi7YYAw4UmX6tYpeq8ZoXmB3m5Ft9fGPNqFZMHaG7IgmCjoCQTnhQk80F3IUfY5aKbeOFqmS9JdbKyjLNCWJzAS4RLWxFTvcFNNV7uz0vNUr9+cWiTwtIPQAC6yNmFvlKKJy1MBc/GBX0AakwgJs179VvWLg/jUqOHjPTW45fTOQEwHLpBy8XckXg5DXAGLigsbRsJTjyJ6eia9f1Si7sSSRMEn6mCyRlM96oVuSFZkyYgrrdH9Heg6/EbzAsSQr25ROP02aROUZDF1/M/60A93Eg/ethpC+IyV6MOy6Bew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha72N+Y0xqk/hGW+HLj/zqJ+eW23xSz6jXjyb3MRhvA=;
 b=nWpTYiojlcgKFBpISGO28p0AvCXX1o0sdDNmPsMT2WTDW+TEeRvaN843/G1aIvXC7fKZ7qkGREuIWaXuEzKadItMjwIQ93dVwZednWCQNo+TYeWtjpV0WHHfbzoBvFEnqCVaw8BrgOloK0R4ppPTcceW9m+QH78VRZfF+1IjRinHJG3pR0uf6OXZIv2fMpaMYz2qmFSEBuK3CVIHNC6tWJw/G17c+lieXj4ZJSmUdg0ZlFJ74HaWAL5BlyKhKvbY3w4gwR4qGJFEbSIBPh5qlgxbOaidU23GT90a/maGOSrCxUaJVdkRx5g6r0vsQY12WPGGAwTCGO2tRBDM8O5n2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha72N+Y0xqk/hGW+HLj/zqJ+eW23xSz6jXjyb3MRhvA=;
 b=OTxNcBqDCuqv7iT8n/VhfnPOk8diZu14BEK2VcaE7pKSAqCwcr4Mf+T9XNPJflzuZ6OMUucS9FSmrYBWEVK8N0QSp9iCezDKXEPl5ZdfG9XJFwRT62RS2QX0mdchZGtLUN5QXOpTL0J6a5JfziAPKRy5alx27FF9/vw2OGqGR5s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB4087.namprd10.prod.outlook.com (2603:10b6:a03:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Sun, 14 Feb
 2021 19:43:03 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.038; Sun, 14 Feb 2021
 19:43:03 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgIABGpyAgAASgACAAAO3AIAABO2AgAAFowCAABeHAA==
Date:   Sun, 14 Feb 2021 19:43:03 +0000
Message-ID: <4D4E97E3-A3C2-463B-AAC4-23197230F36E@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
 <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
 <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
 <8ce015080f2f4eb57a81e10041947ad7e6f31499.camel@hammerspace.com>
 <C3A48B63-63AF-4308-A499-15665AB2FF9C@oracle.com>
 <6f49449343dc7ee4efda1c9d9cc56d272c984502.camel@hammerspace.com>
 <BE094630-AA8E-4C7E-ACF8-B153AECA2EDA@oracle.com>
 <531d2cc4836f95c07b2a41c4bb1eb7d5306208d1.camel@hammerspace.com>
In-Reply-To: <531d2cc4836f95c07b2a41c4bb1eb7d5306208d1.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b8dd2c3-0ade-4256-2506-08d8d120be5e
x-ms-traffictypediagnostic: BYAPR10MB4087:
x-microsoft-antispam-prvs: <BYAPR10MB408761487D534D6C613116C193899@BYAPR10MB4087.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwr2iRtbjOyTQgz3DtuEqYbkNecqfwABFWqulYAMhQNr8WVwo0uHNodl7jGUtVVGwQ7xJ2HnGg8B6v2eJB8ntanlFRb2YTDdq+hC60VDHA4qm/KIEVS7kr7c50SzOiNwnJhUboNHEouYObKRyhUCC1Azzx0ZSiMJ71Aa4qJtedUvcagz9RKWiMxod9cFUcsm/w9WLUT0ebhfduRqzQmIpxjbCQtD0CQ6tgj6KNKU5JeYRAXJMPPGt3Zh3sO8HOnaTAeppg0qpDk5f/3NG1Y/KrA9dHYStke/UhFRzSWuqekoOSJuSyB+F/bCrP/mbixNz4/Rsd8VHjrOQ+ox3Y9ewdgh768MmbxDGzlq3zpdDffILw79tTdX6ixp8a3TlwvJRny4pKDe5l1SCJDYnmALbjvUfeWWnZTFCH+z6A04Vp7j8RnYaZasf+athdYJsEbYTJguWIhRvLY2dc0Hl18b42xw0qd/u7cucbCw3H+5CSGnQuZfE9TvlNstDAw0kBT22xd1LXv4Ap16A7H0ojrbsAX/64SNM04OlbIw4jjbxS7lE2SmYm9nSbTrdb6MIj8HVZzR48b6bdOs96CN3EC6QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(316002)(54906003)(8676002)(2906002)(6486002)(6916009)(8936002)(66476007)(66946007)(478600001)(64756008)(66446008)(76116006)(66556008)(91956017)(5660300002)(6506007)(53546011)(86362001)(2616005)(44832011)(83380400001)(186003)(26005)(36756003)(4326008)(6512007)(33656002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mk7waD1OJpRmmtgTTFz0b1aXBrnI5qiStNYOowVGRkB6eG0W/3H406J0q2sm?=
 =?us-ascii?Q?GWq0htfYziXWQxv6+V0ES9OcFfG4CotiI4NcD5itgaIG/qoTeFpn1v6MhlLG?=
 =?us-ascii?Q?1fThXUgmpQUBkkgPvtfPdMqJXuJo1AYFyh+kAVbgsnGmQv0nLsR2v58VsxaK?=
 =?us-ascii?Q?RVkmcp8YoDuWTxolvHrMc3rYXGX+6pA0O1ZMZaJvYvBHe3u+e6dDiRTfpU8r?=
 =?us-ascii?Q?6LK0PJ0UpPvwrWFZvVePfaP/A/wPJJ8PaLc/y/io+2GFWKCU3eDHDSBEc38r?=
 =?us-ascii?Q?UEd1Rgx4sCkUgt5sPssJbhg0+BE0MSPqcGx5g7G8rdi0nEqbKRnVOaqgaN06?=
 =?us-ascii?Q?4nwi4Wx7j6jV4Jas5MdR635P/EMxZ2fHd45lQGjTLrFdzd0fiIX1LKzR8sWd?=
 =?us-ascii?Q?cm9oiYQlFjxJxcNMmTB2NcNNrgUhmDcTUlyQWXQo7s9Hj+Lo7y0ejxVRPLOu?=
 =?us-ascii?Q?ZgyWHBzXJmyhetZn9m5V1+uJGUN/ePCs4z1CuM9hGtMcF6sp7tMXoyQkewKA?=
 =?us-ascii?Q?1C/0LhUXh61iebmsGYGNzjfrXMiu6V5hsPYzBXGTC3ZsDpulEN1cF8UDnzgC?=
 =?us-ascii?Q?Qp9h3ivDRp76IEZZ+xmFLJLnDVxkSdFQaR/7QhtfChQQJM8oBdPY0Q8bSRYK?=
 =?us-ascii?Q?MRRD+2U+KmCeSfPvIywuh6J/ZUcrW4eUM0giW5MOt68MhMpdeW/RfF62Zlrw?=
 =?us-ascii?Q?ZjrG4FNLvdBOUaE1a6+2LiQTyZR27Jh4hL4n9tCyHAnDXaUSpPhSHok36uoo?=
 =?us-ascii?Q?25uwuWSBcc9eM2XCLzsf0tU+fe12tD81BHqxladxU9pD8upTfZOwNSizUHCx?=
 =?us-ascii?Q?0xjAFqefPT6VWLR0kNoZUt3EghQIqJQ/RKItU3viFJWDqhMAa4Uuk9RRTIX9?=
 =?us-ascii?Q?SEyPQv0u//nPFjoVipuy5LUgb5I3nhHoWPQjdUhpiFFgN3G2rulRGGI/vKcO?=
 =?us-ascii?Q?HgRHLZpeOKhto1S8rdDd36ienTubjnhWzE+g/SGllA1u1TiNcjWEDWIuXLTW?=
 =?us-ascii?Q?/M0TE5d5+IZlXEAm7GN0a8F+Lvvt+1KnijZakX8Yt6b9Ql6HaCS+pf5dYYUI?=
 =?us-ascii?Q?Ce1hASRopcY9zTqrvPrqZN6vGwzVirX6fLnyRNoHlC8B6NzjMsEtv/6dOf1O?=
 =?us-ascii?Q?IaFf9Cc/7eztwXfUkWGkap3ydZMPQvgX1ZSNg/c4yJytpfCO9nYW09UZZ5Ev?=
 =?us-ascii?Q?hYVKHacc4lVQkdp8k/pKjggRQ0D6IzXkoKAY/RhU5ns2buFmlDgclr3WrtxC?=
 =?us-ascii?Q?xg7PdyglOu6xkurr4biCQinT4wbkrthHl0DeeZ7DRaF0rwzZv4sdNmMT4Cfl?=
 =?us-ascii?Q?c2eYR1tqejjVuCfJxyI87JbW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <572A6C9EEE01284298FE2D4F9744AEE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8dd2c3-0ade-4256-2506-08d8d120be5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 19:43:03.5416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3j1jSPGgy+Oq8ibosCcSr0q8DjqOKQHST5fUe7n7IKnrnl76CegGY4q0pthdsbbIbN6jUHEv1r4Dx+tpPnYosw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102140167
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102140166
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2021, at 1:18 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-02-14 at 17:58 +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 14, 2021, at 12:41 PM, Trond Myklebust <=20
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sun, 2021-02-14 at 17:27 +0000, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>> On Feb 14, 2021, at 11:21 AM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Sat, 2021-02-13 at 23:30 +0000, Chuck Lever wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Feb 13, 2021, at 5:10 PM, Trond Myklebust <
>>>>>>> trondmy@hammerspace.com> wrote:
>>>>>>>=20
>>>>>>> On Sat, 2021-02-13 at 21:53 +0000, Chuck Lever wrote:
>>>>>>>> Hi Trond-
>>>>>>>>=20
>>>>>>>>> On Feb 13, 2021, at 3:25 PM, trondmy@kernel.org wrote:
>>>>>>>>>=20
>>>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>>>=20
>>>>>>>>> Use a counter to keep track of how many requests are
>>>>>>>>> queued
>>>>>>>>> behind
>>>>>>>>> the
>>>>>>>>> xprt->xpt_mutex, and keep TCP_CORK set until the queue
>>>>>>>>> is
>>>>>>>>> empty.
>>>>>>>>=20
>>>>>>>> I'm intrigued, but IMO, the patch description needs to
>>>>>>>> explain
>>>>>>>> why this change should be made. Why abandon Nagle?
>>>>>>>>=20
>>>>>>>=20
>>>>>>> This doesn't change the Nagle/TCP_NODELAY settings. It just
>>>>>>> switches to
>>>>>>> using the new documented kernel interface.
>>>>>>>=20
>>>>>>> The only change is to use TCP_CORK so that we don't send
>>>>>>> out
>>>>>>> partially
>>>>>>> filled TCP frames, when we can see that there are other RPC
>>>>>>> replies
>>>>>>> that are queued up for transmission.
>>>>>>>=20
>>>>>>> Note the combination TCP_CORK+TCP_NODELAY is common, and
>>>>>>> the
>>>>>>> main
>>>>>>> effect of the latter is that when we turn off the TCP_CORK,
>>>>>>> then
>>>>>>> there
>>>>>>> is an immediate forced push of the TCP queue.
>>>>>>=20
>>>>>> The description above suggests the patch is just a
>>>>>> clean-up, but a forced push has potential to change
>>>>>> the server's behavior.
>>>>>=20
>>>>> Well, yes. That's very much the point.
>>>>>=20
>>>>> Right now, the TCP_NODELAY/Nagle setting means that we're doing
>>>>> that
>>>>> forced push at the end of _every_ RPC reply, whether or not
>>>>> there
>>>>> is
>>>>> more stuff that can be queued up in the socket. The MSG_MORE is
>>>>> the
>>>>> only thing that keeps us from doing the forced push on every
>>>>> sendpage()
>>>>> call.
>>>>> So the TCP_CORK is there to _further delay_ that forced push
>>>>> until
>>>>> we
>>>>> think the queue is empty.
>>>>=20
>>>> My concern is that waiting for the queue to empty before pushing
>>>> could
>>>> improve throughput at the cost of increased average round-trip
>>>> latency.
>>>> That concern is based on experience I've had attempting to batch
>>>> sends
>>>> in the RDMA transport.
>>>>=20
>>>>=20
>>>>> IOW: it attempts to optimise the scheduling of that push until
>>>>> we're
>>>>> actually done pushing more stuff into the socket.
>>>>=20
>>>> Yep, clear, thanks. It would help a lot if the above were
>>>> included in
>>>> the patch description.
>>>>=20
>>>> And, I presume that the TCP layer will push anyway if it needs to
>>>> reclaim resources to handle more queued sends.
>>>>=20
>>>> Let's also consider starvation; ie, that the server will continue
>>>> queuing replies such that it never uncorks. The logic in the
>>>> patch
>>>> appears to depend on the client stopping at some point to wait
>>>> for
>>>> the
>>>> server to catch up. There probably should be a trap door that
>>>> uncorks
>>>> after a few requests (say, 8) or certain number of bytes are
>>>> pending
>>>> without a break.
>>>=20
>>> So, firstly, the TCP layer will still push every time a frame is
>>> full,
>>> so traffic does not stop altogether while TCP_CORK is set.
>>=20
>> OK.
>>=20
>>=20
>>> Secondly, TCP will also always push on send errors (e.g. when out
>>> of free socket
>>> buffer).
>>=20
>> As I presumed. OK.
>>=20
>>=20
>>> Thirdly, it will always push after hitting the 200ms ceiling,
>>> as described in the tcp(7) manpage.
>>=20
>> That's the trap door we need to ensure no starvation or deadlock,
>> assuming there are no bugs in the TCP layer's logic.
>>=20
>> 200ms seems a long time to wait, though, when average round trip
>> latencies are usually under 1ms on typical Ethernet. It would be
>> good to know how often sending has to wait this long.
>=20
> If it does wait that long, then it would be because the system is under
> such load that scheduling the next task waiting for the xpt_mutex is
> taking more than 200ms. I don't see how this would make things any
> worse.

Sure, but I'm speculating that some kind of metric or tracepoint might
provide useful field diagnostic information. Not necessary for this
particular patch, but someday, perhaps.


>>> IOW: The TCP_CORK feature is not designed to block the socket
>>> forever.
>>> It is there to allow the application to hint to the TCP layer what
>>> it
>>> needs to do in exactly the same way that MSG_MORE does.
>>=20
>> As long as it is only a hint, then we're good.
>>=20
>> Out of interest, why not use only MSG_MORE, or remove the use
>> of MSG_MORE in favor of only cork? If these are essentially the
>> same mechanism, seems like we need only one or the other.
>>=20
>=20
> The advantage of TCP_CORK is that you can perform the queue length
> evaluation _after_ the sendmsg/sendpage/writev call. Since all of those
> can block due to memory allocation, socket buffer shortage, etc, then
> it is quite likely under many workloads that other RPC calls may have
> time to finish processing and get queued up.
>=20
> I agree that we probably could remove MSG_MORE for tcp once TCP_CORK is
> implemented. However those flags continue to be useful for udp.

On the server, the UDP path uses xprt_sock_sendmsg(). The TCP path uses
svc_tcp_sendmsg(). Separate call paths. Removing MSG_MORE only for TCP
should be a straightforward simplification to svc_tcp_sendmsg().

--
Chuck Lever



