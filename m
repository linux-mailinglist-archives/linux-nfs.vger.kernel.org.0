Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68E631B1BC
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBNR7a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Feb 2021 12:59:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59712 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBNR72 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Feb 2021 12:59:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EHt2pA132481;
        Sun, 14 Feb 2021 17:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=euIygGKwq3FihN1gfq1fXcmNGbUfsoPhu4tPGZwUT3o=;
 b=E/pQFoYqYDPa0vsxtRV3cLC9raJCb/UFbuFdHtk0oP5LTNvQ58W1yV3PdsR1qnY4K9PB
 19TU64Yw69p4QtpiXTuaz8rvXbdN5aCVQ1TKnQfrUuT+Z4xVCDM3apIvscMbEnGZursU
 Dq/qubkqrMdbH05K1eeApAGRFYH12MjaDjaQfddfmgjYbLqDQ8p1xmI1Hb2bUiKNglOf
 j7I/pzmuur4SxIMUhBj3+HXQvUK/Ghfm3mHniCHcPJRnoyFhxAihT6dzWFt+Oh22YgMc
 g09mf5hUhkBYU245dMjykXbtTMcZc0i5FjB6g7x1ZCASjbrXO4JnXSAGVlIxDmRRw2Kb Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36p49b2e8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 17:58:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11EHuBxV174096;
        Sun, 14 Feb 2021 17:58:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3030.oracle.com with ESMTP id 36prbk9ru4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 17:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dpow5BgXbnWiKLRzCHoVMDJItK+XZqBjxn504iQwHgeVYAPC89izuuAWJzcB+6P7+ae1VHHeYUhf1vfBAevSHyQ3D3Klpn+Dy/k+uh7dwpDJZYwVq9YqCJQuOlAMKj9snQ7VocTh28wd7ljkVh6/7otaFHn3CfKKBtB/RitxIyl56mXwn8bPVQtpfIb5ZKfmE80ExNV4yCViu0gd5SflEs2odw+Z6W/piNuwxw66O1B/QZfKCKtW0RyULh0AAqKgltnwlt2I/fhb9blvjMvR4j503U9re7tBFZnC/A9KH2sWU5eNZp4WmWpYKqLAKJQm9ByW5rQyOEqnk+KmAUCJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euIygGKwq3FihN1gfq1fXcmNGbUfsoPhu4tPGZwUT3o=;
 b=AdXapLsnXVcwJ9spEGLbC4Ed6opWM7ZI3p6HlACTo9T8e7st9NcKylAlT64bIKerT4yjXP2tKaD9TWkF0kb7iV+vqlFwxtaMdUO5zmtnLWpuQ7dl6dNR/RbhIcYZs5JZkotmSoaVPs4a/I8CuqiSupNw4zrA1mdfQmMMVRsuLy4R3JPfwquiS+gRmfuJt2KVIO7aq+3uIRfQuJ8KV2rwvx7HkhZxVmNP0cAG1taUZlkDJ6C+B1K+bYX88mSnBsVRWYZjz909pmpcrOJTpB69DPaTRUlz4DXgNq30aIv5YgYatcpAts88miHRn0P4jcvggaoukirrQ9j+lUXojmF5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euIygGKwq3FihN1gfq1fXcmNGbUfsoPhu4tPGZwUT3o=;
 b=weVyreAv/n1qjXQvByqFNTeHukBHeUJ+nquaFu5TkTbnXymLt2dIDeU9XZ0MFjlCsg4aMUIggPzFanxayitv8ReC2to1pCUkBO0cgLn2T5V5hmY32RB96uMu2i6z5eWLcb0KylBj1oER2N8M56cxoNqENaU3QM41fqBS3WTkeec=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sun, 14 Feb
 2021 17:58:39 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.038; Sun, 14 Feb 2021
 17:58:39 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgIABGpyAgAASgACAAAO3AIAABO2A
Date:   Sun, 14 Feb 2021 17:58:39 +0000
Message-ID: <BE094630-AA8E-4C7E-ACF8-B153AECA2EDA@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
 <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
 <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
 <8ce015080f2f4eb57a81e10041947ad7e6f31499.camel@hammerspace.com>
 <C3A48B63-63AF-4308-A499-15665AB2FF9C@oracle.com>
 <6f49449343dc7ee4efda1c9d9cc56d272c984502.camel@hammerspace.com>
In-Reply-To: <6f49449343dc7ee4efda1c9d9cc56d272c984502.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f06196-0e2b-4058-69e1-08d8d11228e6
x-ms-traffictypediagnostic: SJ0PR10MB4814:
x-microsoft-antispam-prvs: <SJ0PR10MB4814D91323577EE6B7E4151593899@SJ0PR10MB4814.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9revc06OeVhWSKvSBYHC7ZEwS+u04AKwpP9iRomEToSfTUUO5Y4Q/P47q4X+8zews34jhRw0dc7z8j5v3lfIN/qWjuaMTgVFl8xTNcEqx5zLnwFaj/7JaFtkAWl62U+dvKce8KBjRr+eTAO58ppLVp21jF1qGOdEmfmhxx4LJvX7AFiuRpNy5qHVEl65U8/sZUkAYKN8D8/6An0Tiv5dHtKijgtlyJfv7Y+koOYL/Bd8qIw+2dIQqdV9ZOGJz1PltRlF8qGKYU2SsqzaxALCZ+q2FK8rYJoVfu8ZrXTn6KV3reJF/bpU0NcCQ5MQ6Cpdd+XKVQFEIeeiipNi9mBafWYN+PZ1NuoDApmjWf5FXuxuqAR0d4fbp/17Ti3+nM4d+i+GwY8FFurIbbjNWRLvnUcVAHpKTOjqNkmL6XvclVLodxR+NmhFNLO+mVGwAA0IP9X1iIdiRsHN6EImq3j8tecQ5jqQLbY/mUcRGXHmRquWJopq3COCkffzEeoPYEo0jccLUZ5/H1J+ldPq8MjZQ3y8cPkMw6l6Ib7t+r6sDhuMGO3Gbr/4dyTngcet2E54WnWm6LfwQe0mDpuLQCbVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(33656002)(6506007)(8936002)(53546011)(86362001)(6486002)(316002)(5660300002)(6512007)(66556008)(2906002)(2616005)(66946007)(66446008)(8676002)(36756003)(4326008)(478600001)(66476007)(26005)(44832011)(83380400001)(6916009)(54906003)(186003)(76116006)(64756008)(71200400001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VW2nY3cR41aGpkYTCeQhsjAhf6RBlfw1Tt6sWueer9JSKTEBtkCvZtnZaw6k?=
 =?us-ascii?Q?9TYib6I9edQPOWY5zNZNIs8cRAqGNV35BSXh3JIn87qCgKz8q4oN2/+9vTA6?=
 =?us-ascii?Q?2HQl7zWB36Mez5uJCqejRe6rcURfoPUFyAN8jQKRUF87JESOwVblRwpTziE4?=
 =?us-ascii?Q?p00uNxvhu63t/L3Ltnu6hvUE34zUAAgMRlEv+dBhfjjSGSXN/nUC2sloxqmn?=
 =?us-ascii?Q?3tpsF6x2ZsCJO+m5BkEYjkSGgWRzjXs79GioIM74jPXsGiLgCCutEQT8Txlg?=
 =?us-ascii?Q?UBEniZXl7Zmv4j/nVcfE4x0AHHl9QPoGnjGuBBgBsBPNyd09yOcb+aJbeWQW?=
 =?us-ascii?Q?JLQ4iJcMfTTTVhMvKbRLOdIiSN2YW3npjq7L1oX6RUGJw6DJWSfn5fcgz5TR?=
 =?us-ascii?Q?AcSVXIeo8xUtzHp+zr4Ii7twTqNYMRT4sITA2eVOy/nOWP0gbcUXZFhS9s1n?=
 =?us-ascii?Q?2q5VkqcCacUyW6H0/OBhH+OW+7iqulKKhVauULhnbUqoPVNaDOTiPrGZa8f/?=
 =?us-ascii?Q?rhUW55+U8C8trAg2aAgYj2SZXvE3Z/c3RYAA1ucmhyL4DRw3JSztnSrXSE+m?=
 =?us-ascii?Q?4adQYx674h0DCbM8EKkw34nt6qRNVi/5LKDvEq+tKsr83bnaDLd0mGCevnnZ?=
 =?us-ascii?Q?wGOrcnTlJYTPDoal2BuSyG+7BfvFb5zzDnz7QHtCFteJIkByYxh6OT+ZyfVM?=
 =?us-ascii?Q?8vC4zF9GAL0czRl1LrY5mM0A8GIRBiqP+D/loIvQLIW4jeTYtVOfKr0MHGMb?=
 =?us-ascii?Q?wTqelRxF71njrmyOQKQ3O/vGdDuY/lzVvroPbVr191DlYifJ8hDD50dw9oOl?=
 =?us-ascii?Q?XH4HqlUKN+mRIjZZkk5XqkAUjy4JV7dQ03DLYbqqtFHlW3TKKIZTv5/qy8eu?=
 =?us-ascii?Q?I2YXgHgFUgNN1x4XAG54tpGYUCmBA40ZmiqNhnhFd9JQB8JnRgz27A0UN0Td?=
 =?us-ascii?Q?cUAmIdZZf/GK905k1vy/Plg4nl/E4TnV9mP+wyNjL+8ztdAY5NRLjKV3jXo7?=
 =?us-ascii?Q?GuMAtLqeu17+hw32bZoTJpH4PjKhGflivfOoNRO4PLqPjfQ3J4Tdss4z1Fgi?=
 =?us-ascii?Q?W/sDbAH+fcgVEGvmqv+Gb8X2t3oRHKzn6EmpA5+mOg0DzFFjt0oShQFjeLFj?=
 =?us-ascii?Q?yaUWATTeTIegHTRagOC3immeCeBG70gsLTFyJadFy5sfjiLxDyYPuUaZMiGa?=
 =?us-ascii?Q?/zmLzboL3nOdhR4LPfbmfnox9F2+tsuqiKFDISHAj3r/KVr4qRoevFuo7lVu?=
 =?us-ascii?Q?EMiqtHrpFjW2wUGtI38cHtRA98dtP9GaDkkxtJF9rA9IBrZIjVMd0TehAkjI?=
 =?us-ascii?Q?rYlmYV5RJuKoy3ToMdcaNwGD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82C8B654732E19458A0390DEBB1CF832@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f06196-0e2b-4058-69e1-08d8d11228e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2021 17:58:39.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elrjlCZRUY15V6rv1/60VSVtSQeCwX8DfCcHAX3Ng0wiJvXSZEtb4gtzQXZOCf9107XmgDdEd9saSr+KkGSzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102140155
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140155
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2021, at 12:41 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Sun, 2021-02-14 at 17:27 +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 14, 2021, at 11:21 AM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sat, 2021-02-13 at 23:30 +0000, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>> On Feb 13, 2021, at 5:10 PM, Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Sat, 2021-02-13 at 21:53 +0000, Chuck Lever wrote:
>>>>>> Hi Trond-
>>>>>>=20
>>>>>>> On Feb 13, 2021, at 3:25 PM, trondmy@kernel.org wrote:
>>>>>>>=20
>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>=20
>>>>>>> Use a counter to keep track of how many requests are queued
>>>>>>> behind
>>>>>>> the
>>>>>>> xprt->xpt_mutex, and keep TCP_CORK set until the queue is
>>>>>>> empty.
>>>>>>=20
>>>>>> I'm intrigued, but IMO, the patch description needs to
>>>>>> explain
>>>>>> why this change should be made. Why abandon Nagle?
>>>>>>=20
>>>>>=20
>>>>> This doesn't change the Nagle/TCP_NODELAY settings. It just
>>>>> switches to
>>>>> using the new documented kernel interface.
>>>>>=20
>>>>> The only change is to use TCP_CORK so that we don't send out
>>>>> partially
>>>>> filled TCP frames, when we can see that there are other RPC
>>>>> replies
>>>>> that are queued up for transmission.
>>>>>=20
>>>>> Note the combination TCP_CORK+TCP_NODELAY is common, and the
>>>>> main
>>>>> effect of the latter is that when we turn off the TCP_CORK,
>>>>> then
>>>>> there
>>>>> is an immediate forced push of the TCP queue.
>>>>=20
>>>> The description above suggests the patch is just a
>>>> clean-up, but a forced push has potential to change
>>>> the server's behavior.
>>>=20
>>> Well, yes. That's very much the point.
>>>=20
>>> Right now, the TCP_NODELAY/Nagle setting means that we're doing
>>> that
>>> forced push at the end of _every_ RPC reply, whether or not there
>>> is
>>> more stuff that can be queued up in the socket. The MSG_MORE is the
>>> only thing that keeps us from doing the forced push on every
>>> sendpage()
>>> call.
>>> So the TCP_CORK is there to _further delay_ that forced push until
>>> we
>>> think the queue is empty.
>>=20
>> My concern is that waiting for the queue to empty before pushing
>> could
>> improve throughput at the cost of increased average round-trip
>> latency.
>> That concern is based on experience I've had attempting to batch
>> sends
>> in the RDMA transport.
>>=20
>>=20
>>> IOW: it attempts to optimise the scheduling of that push until
>>> we're
>>> actually done pushing more stuff into the socket.
>>=20
>> Yep, clear, thanks. It would help a lot if the above were included in
>> the patch description.
>>=20
>> And, I presume that the TCP layer will push anyway if it needs to
>> reclaim resources to handle more queued sends.
>>=20
>> Let's also consider starvation; ie, that the server will continue
>> queuing replies such that it never uncorks. The logic in the patch
>> appears to depend on the client stopping at some point to wait for
>> the
>> server to catch up. There probably should be a trap door that uncorks
>> after a few requests (say, 8) or certain number of bytes are pending
>> without a break.
>=20
> So, firstly, the TCP layer will still push every time a frame is full,
> so traffic does not stop altogether while TCP_CORK is set.

OK.


> Secondly, TCP will also always push on send errors (e.g. when out of free=
 socket
> buffer).

As I presumed. OK.


> Thirdly, it will always push after hitting the 200ms ceiling,
> as described in the tcp(7) manpage.

That's the trap door we need to ensure no starvation or deadlock,
assuming there are no bugs in the TCP layer's logic.

200ms seems a long time to wait, though, when average round trip
latencies are usually under 1ms on typical Ethernet. It would be
good to know how often sending has to wait this long.


> IOW: The TCP_CORK feature is not designed to block the socket forever.
> It is there to allow the application to hint to the TCP layer what it
> needs to do in exactly the same way that MSG_MORE does.

As long as it is only a hint, then we're good.

Out of interest, why not use only MSG_MORE, or remove the use
of MSG_MORE in favor of only cork? If these are essentially the
same mechanism, seems like we need only one or the other.


--
Chuck Lever



