Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613015110E1
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Apr 2022 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354318AbiD0GLW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 27 Apr 2022 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiD0GLV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Apr 2022 02:11:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-oln040092073041.outbound.protection.outlook.com [40.92.73.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6895EBEA
        for <linux-nfs@vger.kernel.org>; Tue, 26 Apr 2022 23:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4LZiHYp4sqtLf8CAIlMRdBi0/ntvRM+Wyf1+/aZpUCyNTpFnicoBeT/KZN/xMJgAbGCKTWmDh8iaHB4WVK+KpdYYGDDBlK2b3EzRh7GAtnQqtF239puP6QrGFkzDBaiBzIqTzCEhvL2rj/rXCFy/hoUDgOsY4alC2pJ1GmqiQLSv3xdSmt2T6wkjZ3qrH240OdpxYyYoJeWwWw5wGWXlJgNSSY6bQ/kbIL4Zexar6DtCGtMSoyN3fFpBJQZaz4s9tumXr+vE3zsH8AWGYrnXBkDjIv2wE59cnx+WROcOFalg1+Z9+1sWz8ao1h8CHG2mkVqPlWVU5VpvAveALE/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2w46zsR+rMh2lohRZ6wCMVUp9zvj5u+Ulpj0eAH76g=;
 b=ix229vFDbQRO8AEnHS5BiPifrv33tK3G/EEi270Oi0DkkbsVHr2d8f1xGLe8LdMDU0egOFxkpJC3tx4oUCSAscn6CtQJTDeqlJGspQLmL9LYwaEQo2uof9MIOhY5v5zCyXbGU+/61l6XCc4kVuAtV/TjjgnUMKw6TQbYtNVCqSO5Qi0qBIMN+ODMUYXDyaGYKTn5tRdo7d7OW4E6Cn5bvmZz2zVwKBqnJ29RIdjYTmJNvf6ocT5FC7LyKAX+MFytnfa+frIeXSo9HEOCV6XUNsyGohKetOP0GK+MI0tco5eAw/A2LzKrki5SaidpIQuvnMB39OWCcvziJme8OTrwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by AM9P191MB1473.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:270::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 27 Apr
 2022 06:08:07 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 06:08:07 +0000
From:   "crispyduck@outlook.at" <crispyduck@outlook.at>
To:     Rick Macklem <rmacklem@uoguelph.ca>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>
Subject: AW: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw+AAMzyz4AC9oCj
Date:   Wed, 27 Apr 2022 06:08:07 +0000
Message-ID: <AM9P191MB166592CDF7C78BD68CC153498EFA9@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
 <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b7eb17e8-34ef-c033-0af7-efe86cf42618
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [EhG8cr3aMjPT1vzIh6ppN8FsGuWzyCcu]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 929a8a70-dfc8-4210-7161-08da28144c67
x-ms-traffictypediagnostic: AM9P191MB1473:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PqndRFJVf+hikf5PkZIR/nV3O4PeG0+ulbP5k/395bSN515ZN2qbbaGl/OGP3xeJXNNNVM6q8+xyZr0YxyKiHbGItGYqhfaUzTUaeXO8Tv+yqMCi4ZU5CfX1IzLINK+7W6Ncp012cic3RxsyRBMFUKHC6XWSvGfsot6AaWYsDjiGCt9s6NjgykRL0AKPpxw8qIcxqiJ8ahIAWD5nDC2iaWLmsQOpol5RiWcKP6Ze7VOu1f50RViMr9ATbTXgVJwZFTmmZlRaznDaLmgFno9VhG9RnjV19uSaM/SiDCW9+xUvNwIq/W5U4l6TC0D4x+EpFYehtAL0r0H/7OTAqcy2juw3Y7rYW9zufudiKkWP1XHxvOPz1b/zxrLhAXFVJJOwdcsvFc/YE5bOtb0Ko8w6bb4xfc8a2YlOA2coW0084d6cbHEV7YG+2tgHPgZCKqWCpfo12+wP8u4KZw+C70CbnkhJMoJZCJexwUhY99jIHqjInTCKr2wEXSz4UYNgyJbVeTNHIHAiD/cUyrXpHMRz/OTMygg0gd3kLQWe9hjXUbIFqglogH9AWVb6C82scnXwVHMjhA9aVZBKo6kVywSbsNn2mXrDp9CW8HO7o7cM2FLGj4qDdKQPd2un305DJ+Vn
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0NwoX+41skpruzf2+55tqAATuefJ1wHXtV1y25l09n5LcQFbPiAqz2a0CY?=
 =?iso-8859-1?Q?CSv6c8TUuL1SYUX2sZddAdT+/D01czoXa9c/QBXHjs3tiqZU6qXwMFd98M?=
 =?iso-8859-1?Q?vyPruskLKDz4OY67OzYnfkoNm/izcEGkwyUlmEWDmH4WKYfPSwlURVwYk9?=
 =?iso-8859-1?Q?2g5jLbTQ5D9OmUUF2zvm/PU0rgnoEZkyJ7Cytp1OCR8yySkjzA3yhCxbQ5?=
 =?iso-8859-1?Q?2PGjmxpZw0wZV/y+zyboSyeOV3qrILtHte+yJJ3Jl5WegnaaSmYFvAx08G?=
 =?iso-8859-1?Q?f3wWzhTAYlJFgtB9paMyJMTvYFpBaryKnb55DOMHZacQL3ukd8M4WipbzB?=
 =?iso-8859-1?Q?QXRPyiJFZzanPfV77ocU2a78u1iiyvO/a93oUsYfU9HXvLNkFK49LnfE03?=
 =?iso-8859-1?Q?PghGy5gtjixXxnEh8utykAldgyPniseWkEAOnr1SjzchNuA5raQyNWZF/1?=
 =?iso-8859-1?Q?uPvhg4FCqZ5I7H38dOGc3mQGbtqYa+0ef7ef1JaMaRYJcAoFdIrLmE/8gH?=
 =?iso-8859-1?Q?l5XTw7hFrNT9nqC3r6ZuBCs4lBzpGfWlHXhgG4DVGPZcVMvijwZ8Lo1QTP?=
 =?iso-8859-1?Q?fTOr1jPE8hBVdpxQ4bjsw2I1CNrKXhvCc+ClyZLGE/KZuVxLQCCJVZA9/o?=
 =?iso-8859-1?Q?ofHi5aU0IJcHHDRz4/9nn0PVA45Bw8kKujX76znuGxe/dHqk+aIqPaNxdr?=
 =?iso-8859-1?Q?wzhmfvAtPnqpdU7f/2xspK0sO4x42b82fRfwZ6yP9QZq4f1IZiNRgl7ArR?=
 =?iso-8859-1?Q?82wBaop2LUF3+xjKdbORYroDdOZEt4veH5FXnK55NGWtOhc1SUSWh16vC5?=
 =?iso-8859-1?Q?zUrmShmJ5fkuCEQA5UKrgN6u6xaaEurNIQfHQj/cIS9CETxOvdYwYu1shv?=
 =?iso-8859-1?Q?PBUHP7/g+QmF/tciaAcYDwr+snjQn+jAmII0H3kHWmGHKG/beOHETQunQe?=
 =?iso-8859-1?Q?Nx4CBt3m9NI5SdoV/jw/Uito9159oUweUYyF69eoZ/PIVuLOq3UuNIuf6U?=
 =?iso-8859-1?Q?UQEI8sK8d2GnvVSpDsWLT9N/kTreMRxe5VYomw/g/AxS2PcSINeRBx2BWl?=
 =?iso-8859-1?Q?/u+D4pX1GZs430MKpmJPJ50cR/yZiv768vgxnAoV3IJ2HyeVQJ9VGYcjI1?=
 =?iso-8859-1?Q?L1UTmnCsbX2lUJz5r6TlZlxmgB9VIOStleMqjOhjuXw79mft87UXROlgh2?=
 =?iso-8859-1?Q?a1tzS6+aEutqIplj+L4FgyblJLipWFWRWOO2OGSVLxTopMjetxYSyu1Feq?=
 =?iso-8859-1?Q?PLvUeNLvQM1d68I3oX1cR6QKlzb+7KT/oSsFCTlE9V6HDv+YVYTKiQH+/f?=
 =?iso-8859-1?Q?igIfyfOiK9u9PVA1WKPKDU9U+G+yjC8ZQfW73HHaM7FVh81jt7Mv/Ev3El?=
 =?iso-8859-1?Q?bxtI4w3zo+jAsndrsnd+hb3KYY3jQjbk4ijbn462m7mKVEkPzWq3kH5H/F?=
 =?iso-8859-1?Q?1AvYmGUUnOPflpXXlEOhqJnr+3Smk4cySolFQMa3Bv5/1r/bhp614UTuZt?=
 =?iso-8859-1?Q?4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 929a8a70-dfc8-4210-7161-08da28144c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 06:08:07.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1473
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I tried again to reproduce the "sometimes working" case, but at the moment it always fails. No Idea why it in the past sometimes worked. 
Why are this much lookups in the trace? Dont see this on other NFS clients.
 
The traces with nfs3 where it works and nfs41 where it always fails are here:
https://easyupload.io/7bt624

Both from mount till start of vm import (testvm).

exportfs -v:
/zfstank/sto1/ds110
                <world>(async,wdelay,hide,crossmnt,no_subtree_check,fsid=74345722,mountpoint,sec=sys,rw,secure,no_root_squash,no_all_squash)


I hope I can also do some tests against a FreeBSD server end of the week.

regards,
Andreas



Von: Rick Macklem <rmacklem@uoguelph.ca>
Gesendet: Sonntag, 24. April 2022 22:39
An: J. Bruce Fields <bfields@fieldses.org>
Cc: crispyduck@outlook.at <crispyduck@outlook.at>; Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Betreff: Re: Problems with NFS4.1 on ESXi 
 
Rick Macklem <rmacklem@uoguelph.ca> wrote:
[stuff snipped]
> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostly
> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that
> tries to subvert FH guessing.
Oops, this is client side, not server side. (I forgot which hat I was wearing;-)
The FreeBSD server does not keep track of parents.

rick

--b.
