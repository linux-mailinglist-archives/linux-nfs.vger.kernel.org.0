Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4983E0490
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhHDPm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 11:42:57 -0400
Received: from mail-eopbgr660050.outbound.protection.outlook.com ([40.107.66.50]:14304
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239134AbhHDPm4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Aug 2021 11:42:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLR2Qu7eZQTEwIL2IJJ0ClDdjD/VfMLIsaqRH/O4kIzK7GD2816uHN9mobcIVoEotM9sglmZxAuxgGoU11FqnJOOZcap/Iz/QmMvB4I5kJS5KLj+/b10ofQ3/5rwpbxNXFvkozDGRc+wv8NXo5R4FzMP6T9qSvwqI7KMX681uKHrE6+PGopAC0bBqFN3ahl4j6V6Ir2jG34NvyHX73WeYxRhKprjVsuPcOx3lhbuf2VdS6x7uwx3kPaKnJ6iQnrj7HOCCVSlY1oYkLGAUI+hSOhzZSUEF80PcH2BGBxjE5ZybIaGq/Z6SxS67+sm6KBAThKYtf4J4D7kimZyX6UdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PZCjALyxohXZ+yX9al8MJl+BM+83sdbBOvK+Oqnn9M=;
 b=eyUbgCgkHC1q6huQbnEbejaU18MI7T9iH6nu2v4Vz36X4KZ//BXuNu6qFOlzza7jlxgHmjwj2DBorpLBeFgu+8NHGhWycHf72FJn/LZF5OGyJVDl4tcTfbfuegwxW9I6hn7Hcdc0U0In3JiD3nzjsRQls2Wep0lTwRj+L96SQuTrdMxBpB0M6LJsBUzDn+dcjYs9Im7uZBe6XwzrxdXpi1jD48LsuXYDSadsBbhxgbXbK0KyUiQFSLEC6k2WSns/DudA1E52tlIdI7KzLG1khYMVEGqzCDqYhQ06aWVUykKRoWT8GKmEdRGA06b1CS9M0dbW/CE9iVFxWs9q41c6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PZCjALyxohXZ+yX9al8MJl+BM+83sdbBOvK+Oqnn9M=;
 b=c4A7ohZRK4OAR1H5k4O1vQzewmvSzTkMLhI+J0MGaDx3XHUXdWlnTPXxqUtpqyY9bvxkR32D5bNgTaT6KK0jFZ4KSr0XGgm0C9Ys703col3RfQAbVtkBXsdUzLpf6h1T+q93kH7DoSWFK6DF8MbHYcqtXsgPEuWYi3es+zC5JaYSiYaUU8LkF7IGUb7STMsufe5MwvM1W5Jnfv3bT3mTbo8piCYYHXgEdmQ258oOFp+aXNfvX7WrwsVaf8R6yAL9w3FzII6nR/2Xn/MyyG3Irt4EeTjq3XDw7osri+Vt7WjFXH19Rwew38HwWh2VxdfXRnRffczVBW/fWhyS2Ws75w==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB5497.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Wed, 4 Aug
 2021 15:42:42 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1174:bfb8:7a34:f67c]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1174:bfb8:7a34:f67c%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 15:42:42 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Patrick Goetz <pgoetz@math.utexas.edu>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
CC:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXiKZ3y2/2jpGT7EqDbEmGcjYp3qtiRcCAgAAIPwCAAETlgIAAAlaAgAAFXoCAANQRAIAACXuh
Date:   Wed, 4 Aug 2021 15:42:42 +0000
Message-ID: <YQXPR0101MB09685DB29CA5F0DB87252CC1DDF19@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
 <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
 <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
 <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>,<423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
In-Reply-To: <423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: math.utexas.edu; dkim=none (message not signed)
 header.d=none;math.utexas.edu; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb9e2148-1e4d-401a-3dcd-08d9575e7f5c
x-ms-traffictypediagnostic: YQXPR01MB5497:
x-microsoft-antispam-prvs: <YQXPR01MB5497DB13DE0738FDB405BCBADDF19@YQXPR01MB5497.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKZmVNo0x1akaAF7vxikD1YE44NWDFe+MMKEkNH/Ubdvra0MFN1caoV9KwK40M+8Klrj0m9oulAR0hIjeiuseyg8zzQqAf2C7M9e2sknIPymEWNJfOeHKhxMD47BN5Vpxr9+j+VM/HULTrCTn1kta3vn1a62kkj3xG1pHSLl2on/zS/l/SwQMEcfsJUZ0ylRkZmDo9AjoN05tLPtbrYOEapitovrI30jJYOeBk/1XglYZT7hw/pGJohpcrol5Qd4zP8ZbFDiKAO/hlWzHYqK7VslllOccIcfS8LQ2ykrjIMhjWYZ1Xdn333S0q88HtD1YLUhAhlS2olDpZAJuWjV55xp1364a06FKqDnu9qc92AnrXH6HiEM/6PZRl559ouJOZHw/faZDEWqdow6KQDHeuBxoOwcYWTwl5FGpSn7iBqeym/cf2W+bM8NYEAM9s8Bh3Xi91u2kjOZ/hgAjavKve6SDFFnFA9rNG6p8WpGD8Evr4/Yb3gZP0B8v1+Wm6zwwpQpkUtpXHOcETftXPUOy+atVgWZZocEOH1sSGLA6WFxpIIPNK2AtxVzSXkumNhkykQj0zdYlA4C3Bmm0XIy26egfV545S4VYM8UXqTctQGrY7iJII9unrKtV3xSh+l9HgE/FF4YTetRpsg5gewPd7Ew/85+uTe+v9TxAYtgBNwaC55AcYT4WudcJM1k0tEfpblQ5xc/zE/4yWmDva2DUjY66uYGyujPHyJ9XVCfnUFvPmVvef94AnUr79y2HhWS/rBYQdkXPHbV40vCeZcQuHfCQzb9Ve/3zqbhohl4bSFHYUfSM1JhbuWm9LxTXFFw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(66946007)(966005)(55016002)(9686003)(52536014)(38070700005)(19273905006)(66446008)(91956017)(64756008)(5660300002)(71200400001)(478600001)(8676002)(76116006)(66476007)(66556008)(122000001)(33656002)(38100700002)(4326008)(53546011)(186003)(6506007)(786003)(7696005)(110136005)(54906003)(2906002)(316002)(86362001)(83380400001)(563064011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i3dhJz2aBp1+JqTgolHx7fHyYY8UfUgfClbW5Q6gJkY3BFLh9aNn8wo3Xu?=
 =?iso-8859-1?Q?zMOZCfyiyBXvhUgaU9Ogz8UKuQqyXPRlOksrhnhO9MRk1nYS+J/5zupGfy?=
 =?iso-8859-1?Q?vj3mMfOvK6ZFpDURC6EPC0uoV+CZCMy93mxshzSz8kH+Z4FltxG80ZpHgl?=
 =?iso-8859-1?Q?hhj0eZVn1WSS9yA7wehh5KmtinR0LFjGTI7duiybO1lWsBsZAPp7/OGFY9?=
 =?iso-8859-1?Q?JXjiQTu+KyieZOZC24GymOM0uh2/ySuN0E5gnVEXj19/3NDOu1gTfac4wU?=
 =?iso-8859-1?Q?aK3v5MksiUvBxsxOT9vAk/EZ5/ynB0Wgc6OewGPjRFQDpvwRBykcIqQD7i?=
 =?iso-8859-1?Q?4pPzFkdlEFlNxghMATHK7pDIjMJUrLgrL1mvg0ujCZGKxhS6qOHCFtzKaJ?=
 =?iso-8859-1?Q?ktO1SK/XzeMdrMh/J5GKSAdGCk5MkYczDedS+gfWFrnXtxdoK6LAPJf7C4?=
 =?iso-8859-1?Q?lGcQu4jFexhLpz039bsmc/ShIhUXB0bUl4M8bVvHdJ15qBhxXuPA62bwhC?=
 =?iso-8859-1?Q?dkf/4uXYWu76RT2MzoPeUP0XBAO/wwXXvzP2FFWhBRkrxz+lrWatJJFzuV?=
 =?iso-8859-1?Q?mlanpCUJpv9mRJ97WSLgSD1Om0a7icZTokmnacbfNfXoTkEbesAGXZ8SV4?=
 =?iso-8859-1?Q?iF/a8+5/2BfPEoZpv9jgR0yZTOWEK+y7dT3ij8RXdQJ3M4JZw84+5Ie2KT?=
 =?iso-8859-1?Q?l3FevZMOKy5UmLBycfz6ZWi0dFpypc+otBY2Z7beGVWwvwxBR4Mw4MsOnI?=
 =?iso-8859-1?Q?17g8X+nZMchnCM5unBb73Acv6n4joVFWm78DkNUIcGn4c+wDf2JkYnfbtX?=
 =?iso-8859-1?Q?mM6auEjdSu4zI6Hbh27LKeWFcN88QDF5xaQlzl7b3c6kxugB8z3oq0WfUU?=
 =?iso-8859-1?Q?4EfUBBpG/6OU9VOAAj/G/REstdDWYST6ctvstDbOPok/JQE+ummA0q3otd?=
 =?iso-8859-1?Q?QV1mHcI822L7dvmrYsXOuoOr2wEuC8/XomDMEFCU2h43m7wGQ8YGuUJuFl?=
 =?iso-8859-1?Q?XhwD0cw98ugNnfgar1dGkppysbgYTWyJp1ERINu9oTjjjrq146UU0MovDy?=
 =?iso-8859-1?Q?OWfo1HCZJeQsxh+oIbX3Qxoww9cznqExIcBrBqqF2Bpo9akIjpHDIJ3E0m?=
 =?iso-8859-1?Q?KkUZObLNocDM0Ub93v3lfpFrTRME+el+kTgPn+INkGzQDQZYC90mta/bm2?=
 =?iso-8859-1?Q?7hy2FEIe2Nl4Soi9RhPbkcJ6V6MzHimDQYv5pl9Tf52SGMR88bn1lFcvDt?=
 =?iso-8859-1?Q?GnLB8fLy0DnPVbkjhidQGxWABiyN3QUVkhkd7OJmN7Zk3Z4r1+bJYZ9W2i?=
 =?iso-8859-1?Q?1br4arInlQcqFZOlDdLspdVaVW4rD/t4jUo/PgdF2kapYzoe7CLoNW8Rpp?=
 =?iso-8859-1?Q?NbWGJ41euVMkGvDDDc3qXGbN/BJFRFz5uYYPg3jxrjeNSs8HalGJq1gKAg?=
 =?iso-8859-1?Q?oMNoYSWuSPQOhiQJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9e2148-1e4d-401a-3dcd-08d9575e7f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 15:42:42.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3nb7Gv+WxPDkGdSUnPjtvHyTwodLuPa1EWXKFjd7krWG68fURVvZ8wX1844xaeb9pw5DLGs1R0XQLZFdJornQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5497
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Patrick Goetz wrote:=0A=
[stuff snipped]=0A=
>So, I have a naive question. When a client is writing to cache, why=0A=
>wouldn't it be possible to send an alert to the server indicating that=0A=
>the file is being changed. The server would keep track of such files=0A=
>(client cached, updated) and act accordingly; i.e. sending a request to=0A=
>the client to flush the cache for that file if another client is asking=0A=
>to open the file? The process could be bookended by the client alerting=0A=
>the server when the cached version has been fully synchronized with the=0A=
>copy on the server so that the server wouldn't serve that file until the=
=0A=
>synchronization is complete. The only problem I can see with this is the=
=0A=
>client crashing or disconnecting before the file is fully written to the=
=0A=
>server, but then some timeout condition could be set.=0A=
Well, I wouldn't call this a naive question.=0A=
=0A=
There is no notification mechanism defined for any version of NFS.=0A=
=0A=
However, although it isn't exactly a notification per se, in NFSv4=0A=
a client can exclusively lock a byte range (all bytes if desired).=0A=
The limitation is that all clients have to "play the game" and=0A=
acquire byte range locks before doing I/O on the file.=0A=
=0A=
I've always thought close-to-open consistency was sketchy=0A=
at best, and clients should use byte range locks if they care=0A=
about getting up-to-date file data for cases where other clients=0A=
might be writing the file.=0A=
=0A=
The FreeBSD client only implements close-to-open consistency=0A=
approximately. It uses cached attributes (which may not be up to=0A=
date) to re-validate cached data upon open syscalls and doesn't=0A=
worry about mtime clock resolution for NFSv3.=0A=
--> As such, the client will see data written by another client within=0A=
      a bounded time, but not necessarily immediately after the writer=0A=
      closes the file on another client.=0A=
When I work on the FreeBSD NFS client, it always seems to come=0A=
down to "correctness vs good performance via caching" or=0A=
"how incorrect can I get away with" if you prefer.=0A=
=0A=
rick, who chooses to not have an opinion w.r.t. how the Linux=0A=
        NFS client should handle close-to-open consistency=0A=
ps: I just told Bruce I wasn't going to post, but...=0A=
=0A=
>>> Matt=0A=
>>>=0A=
>>> On Tue, Aug 3, 2021 at 5:36 PM bfields@fieldses.org=0A=
>>> <bfields@fieldses.org> wrote:=0A=
>>>>=0A=
>>>> On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:=0A=
>>>>> On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:=0A=
>>>>>> On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust=0A=
>>>>>> wrote:=0A=
>>>>>>> On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington=0A=
>>>>>>> wrote:=0A=
>>>>>>>> I have some folks unhappy about behavior changes after:=0A=
>>>>>>>> 479219218fbe=0A=
>>>>>>>> NFS:=0A=
>>>>>>>> Optimise away the close-to-open GETATTR when we have=0A=
>>>>>>>> NFSv4 OPEN=0A=
>>>>>>>>=0A=
>>>>>>>> Before this change, a client holding a RO open would=0A=
>>>>>>>> invalidate=0A=
>>>>>>>> the=0A=
>>>>>>>> pagecache when doing a second RW open.=0A=
>>>>>>>>=0A=
>>>>>>>> Now the client doesn't invalidate the pagecache, though=0A=
>>>>>>>> technically=0A=
>>>>>>>> it could=0A=
>>>>>>>> because we see a changeattr update on the RW OPEN=0A=
>>>>>>>> response.=0A=
>>>>>>>>=0A=
>>>>>>>> I feel this is a grey area in CTO if we're already=0A=
>>>>>>>> holding an=0A=
>>>>>>>> open.=0A=
>>>>>>>> Do we=0A=
>>>>>>>> know how the client ought to behave in this case?  Should=0A=
>>>>>>>> the=0A=
>>>>>>>> client's open=0A=
>>>>>>>> upgrade to RW invalidate the pagecache?=0A=
>>>>>>>>=0A=
>>>>>>>=0A=
>>>>>>> It's not a "grey area in close-to-open" at all. It is very=0A=
>>>>>>> cut and=0A=
>>>>>>> dried.=0A=
>>>>>>>=0A=
>>>>>>> If you need to invalidate your page cache while the file is=0A=
>>>>>>> open,=0A=
>>>>>>> then=0A=
>>>>>>> by definition you are in a situation where there is a write=0A=
>>>>>>> by=0A=
>>>>>>> another=0A=
>>>>>>> client going on while you are reading. You're clearly not=0A=
>>>>>>> doing=0A=
>>>>>>> close-=0A=
>>>>>>> to-open.=0A=
>>>>>>=0A=
>>>>>> Documentation is really unclear about this case.  Every=0A=
>>>>>> definition of=0A=
>>>>>> close-to-open that I've seen says that it requires a cache=0A=
>>>>>> consistency=0A=
>>>>>> check on every application open.  I've never seen one that=0A=
>>>>>> says "on=0A=
>>>>>> every open that doesn't overlap with an already-existing open=0A=
>>>>>> on that=0A=
>>>>>> client".=0A=
>>>>>>=0A=
>>>>>> They *usually* also preface that by saying that this is=0A=
>>>>>> motivated by=0A=
>>>>>> the=0A=
>>>>>> use case where opens don't overlap.  But it's never made=0A=
>>>>>> clear that=0A=
>>>>>> that's part of the definition.=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> I'm not following your logic.=0A=
>>>>=0A=
>>>> It's just a question of what every source I can find says close-=0A=
>>>> to-open=0A=
>>>> means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency=0A=
>>>> provides a guarantee of cache consistency at the level of file=0A=
>>>> opens and=0A=
>>>> closes.  When a file is closed by an application, the client=0A=
>>>> flushes any=0A=
>>>> cached changs to the server.  When a file is opened, the client=0A=
>>>> ignores=0A=
>>>> any cache time remaining (if the file data are cached) and makes=0A=
>>>> an=0A=
>>>> explicit GETATTR call to the server to check the file=0A=
>>>> modification=0A=
>>>> time."=0A=
>>>>=0A=
>>>>> The close-to-open model assumes that the file is only being=0A=
>>>>> modified by=0A=
>>>>> one client at a time and it assumes that file contents may be=0A=
>>>>> cached=0A=
>>>>> while an application is holding it open.=0A=
>>>>> The point checks exist in order to detect if the file is being=0A=
>>>>> changed=0A=
>>>>> when the file is not open.=0A=
>>>>>=0A=
>>>>> Linux does not have a per-application cache. It has a page=0A=
>>>>> cache that=0A=
>>>>> is shared among all applications. It is impossible for two=0A=
>>>>> applications=0A=
>>>>> to open the same file using buffered I/O, and yet see different=0A=
>>>>> contents.=0A=
>>>>=0A=
>>>> Right, so based on the descriptions like the one above, I would=0A=
>>>> have=0A=
>>>> expected both applications to see new data at that point.=0A=
>>>>=0A=
>>>> Maybe that's not practical to implement.  It'd be nice at least=0A=
>>>> if that=0A=
>>>> was explicit in the documentation.=0A=
>>>>=0A=
>>>> --b.=0A=
>>>>=0A=
>>>=0A=
>>>=0A=
>>> --=0A=
>>>=0A=
>>> Matt Benjamin=0A=
>>> Red Hat, Inc.=0A=
>>> 315 West Huron Street, Suite 140A=0A=
>>> Ann Arbor, Michigan 48103=0A=
>>>=0A=
>>> http://www.redhat.com/en/technologies/storage=0A=
>>>=0A=
>>> tel.  734-821-5101=0A=
>>> fax.  734-769-8938=0A=
>>> cel.  734-216-5309=0A=
>>=0A=
>>=0A=
>>=0A=
>=0A=
