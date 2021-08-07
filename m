Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D563E327D
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Aug 2021 03:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhHGBDs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 21:03:48 -0400
Received: from mail-eopbgr660047.outbound.protection.outlook.com ([40.107.66.47]:21848
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229943AbhHGBDq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Aug 2021 21:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyLpmNaEorNqSNqAZq38nJrQci5msj6hpdAQia4RUn8rXaMgBMeIGcd2xOi+2g9ksLIqR3MiBVW1Y0GwXTlPKw7ri3QiNU+OI7pmPYvijlUTjsLvRtKw7I8YEZs+4go9OXKG+HzsWfZC32+eL5svFXFgK7I67YBLz9+IQbnlPv3cBjfV2FijYX2OidNk1If4a2TQzEQMQ/NUkcgtfwDku1FHtjNA97OOyb5ghuyulLrL4NmFYtXnqvzutgg1fwvg407p6Sp/sLO5mUxaBqTAdSmhJv1Gk86qTK7D1C1CXVavCNUauwZAHeFOaMnk5Q2C2htPmNKm8rfuWa5CcZu0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej4k4AXEQxbfoOPXgCXB9RJuq7ero7VoW4jZkFamLzk=;
 b=K2A2MCiz80JETLXQAplsS2wLMW0jXik+bQnm2362wcGxige6Ekhhy7AoIkaEi+230bwI5UwaMQzUqannhfdIliGRiInDtzBOdeXPn0C1SEMFyPZpFL+THhMSsBsCGf5pAP8ffO1+Wc5SMcu2BoYEkoLL1L62G9rOBIgLpUOacrMDVi6S/nIK0dBZRg1HxAMtYr9/F3lXxjzZeR8Ejq5i8AqBZO2472ZqGV9MHG9j15MJov3eEufi7WmdvjmgD5w/qtALnU6o/sVM38f81pvJGGosCSxBco0w7QYh97jeSxhJYMabt1/YYC+g7IRAuNEo0HGDWbxrJKk6VMzup2yi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej4k4AXEQxbfoOPXgCXB9RJuq7ero7VoW4jZkFamLzk=;
 b=qGRdDwpEPJx70POyEaac08KwChtKqrTlOsSdz5zZXwce7AWyM8lPkUWUVDzLGW0GiorIfOuUOJIrzI4Gc/RIHlBzjXTWVlEESziakNgXmyLfejLoBPQJn+3+SQ7dkCdMuFLlKou1TxHMjiCoofepVVf/5MAvwhqTkH7QZdZkaE61gbkYiZEmwty8yvEagbG4Lj30tzDFSYPQPd//gwMRJ5N9yt5H3/huty9jVNjcrVhz3qJaWOc2T0ec7Mvgvyz/2uNO2vS94+cOk8swrEGqJK/NObp16oAhn8B2eSsMD/PnJpQy38MQf+B5iM9ovmHrvbaX4dBm0nIYkwf/A32XbQ==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM (52.132.76.157) by
 YQBPR0101MB0899.CANPRD01.PROD.OUTLOOK.COM (52.132.66.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.26; Sat, 7 Aug 2021 01:03:27 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1174:bfb8:7a34:f67c]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1174:bfb8:7a34:f67c%7]) with mapi id 15.20.4394.021; Sat, 7 Aug 2021
 01:03:27 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Patrick Goetz <pgoetz@math.utexas.edu>,
        Anna Schumaker <schumaker.anna@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXiKZ3y2/2jpGT7EqDbEmGcjYp3qtiRcCAgAAIPwCAAETlgIAAAlaAgAAFXoCAANQRAIAAO/UAgAMuJQCAAF3HdQ==
Date:   Sat, 7 Aug 2021 01:03:27 +0000
Message-ID: <YQXPR0101MB0968BDAC6E52F178106A9823DDF49@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
 <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
 <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
 <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
 <423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
 <CAFX2JfkhqJK6MRFDCzE4VryBJvk1ttYQvrASugncY-_wcEb=+Q@mail.gmail.com>,<5882ecc4-c582-e7a4-4638-3c8bbb21c597@math.utexas.edu>
In-Reply-To: <5882ecc4-c582-e7a4-4638-3c8bbb21c597@math.utexas.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: math.utexas.edu; dkim=none (message not signed)
 header.d=none;math.utexas.edu; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 359fbc1f-f260-467f-42ee-08d9593f2a4c
x-ms-traffictypediagnostic: YQBPR0101MB0899:
x-microsoft-antispam-prvs: <YQBPR0101MB08998AD461D008B98308736BDDF49@YQBPR0101MB0899.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EHf2qxTEhcAbxd+WZlbSO5Xl9OBaoRM3JH7tRw4AAcW+AZyD5IBMLBzp0HoRuq2FaZx2P4jxyl2YCRIDLCSrsfw8njFFi0sdFvJ7Or25JUQoWuMUiL/x4a2c/HRnvSelnQ/uXNTHtoQ6ktwFds5Xz6MAl6u6UC85y9W9N+OETiMPjMspagnSbf4p6fKN4MHGZMdJvHlnXCPkOgfILBWz6/k0rbwR9ue7dK0MPilFhOCVrh3Jvk8UldACa/phTIJYruP357J+qgA6uV/dpRLbvQ2M3b08O4KlR2OTb9O/kl5rqHU8pJBhkTnFhWApNFuXLEwH81JK2WORquRrFt18c8cSELu8SP+FZq+MestUgemNgWVJl0haI2EJJQxFI9vAC+f4sSOYCHQgH3bV8Xy50ZKln1wKA5nnDkAbK61WVZIjlpYXvKfcea3oCHuCdQRcPu9FBs/dRw4KrXXIx5n728qpBdhkwNTPjS+eiujKziIuewg1Sq0RswGuQWKmchLwiba4/9+zYsb/IrP4opeCJCIBwod1Gdhz+NIEkIuCMnFsBWNoiAf77p4woESyjfFeH8+p4mo4UfrpXCxNvUutZ+Eo84a3B4m2fA8hjhRFpiz6Wfzw60/0V9ga89rlIwviRFnAW1nKsv9Xe896WJb5r7FGzAImJeafbEfCwYnlDTRt0LaB3WYS11aB+CiSTCDTmtIAYVI3ppzB4HzFxlfMog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(8676002)(66446008)(91956017)(64756008)(76116006)(66946007)(66476007)(66556008)(9686003)(6506007)(4326008)(186003)(5660300002)(122000001)(38100700002)(86362001)(55016002)(83380400001)(33656002)(786003)(7696005)(52536014)(316002)(110136005)(71200400001)(38070700005)(8936002)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PwiSoBQMYk8eh6k7VmjAS08a+ETThv7fRsMiGXZbfSRjG2+MRpSkSN2r8o?=
 =?iso-8859-1?Q?BcgFWKA1DR1t5eY2Gjt/SWOSqPqC9uRFHgFY4YIF0RlxZS0SYUsQJ+Ejk0?=
 =?iso-8859-1?Q?3Mzmq4/YIgv+KxwOAcHz5EJ9hLoTMpuwahl8+Fs1bG/qMX+uSUK2A4doG9?=
 =?iso-8859-1?Q?2YO6dAXNQTvUYvgzxvxsX4J4LX5Fz3HkHyLI3lUqjfY0yzBuRE1ytk9oDu?=
 =?iso-8859-1?Q?830mKJxoXaesdDeCnwqFL9k3La5b2wOHvGMzxG8zg88yEIMgr+Ny7bLbyY?=
 =?iso-8859-1?Q?yHrzzR3uQ2iTWAL/LKjLxeqQz4/vKNCYNVd2C3hCN+woEPO+4D+st9xq7L?=
 =?iso-8859-1?Q?bCVCFpzhZZ6ghQwDsHoWSU2OBG45D5EiJj4l4G1kbl9dKJyKYL/YW/k+MP?=
 =?iso-8859-1?Q?C94JKIvLS79k4wpB+vT0SHvndJt0cF5i4dooHHidjTkF/X88RlGDN0oJ04?=
 =?iso-8859-1?Q?swXdexZiW/wHJNPLhYYQtNUNLHaSHsWIMC3Rchq9zZvlRasEQ+EAnrRPQO?=
 =?iso-8859-1?Q?HvUHDEV6Z3t/uxEGhtyahOF5yzX6MYpsZKMA2yyyFPfMIBu4nlcvzt8G6s?=
 =?iso-8859-1?Q?4lvIpjhMpeQl2T7RNGh/1ikhvfxAlSEleofr/nblWQYTCDYiZVdHw9ccrm?=
 =?iso-8859-1?Q?atmizkjLZWhWI5FR9xyuoPectSu3fmAZYJB8QzP/e9aiAkfEUKPuIGBWLz?=
 =?iso-8859-1?Q?suxPNILvLVkREXdMB25GylVdTpBm48fcQLqifPZYapjBzSvCtUprBnUqXT?=
 =?iso-8859-1?Q?P/w1UXWuRj87UkqNP5Zx0qx8HGjPEgyaQGfw+j383UjRO1GwpZQI8e3qXO?=
 =?iso-8859-1?Q?gvcOcfusMNitGsotspfVZGpUr3hwW9ImKloXcEs+Wwip24w/QZgS9Vkz0T?=
 =?iso-8859-1?Q?F79HsGDvLK9MSI7xzjSXpLk+rilro3iyEkb/8Oyt/Uhxg3erISqyNeYpHt?=
 =?iso-8859-1?Q?TwBa5aGCM245dVV9NXuz6XBUSiJVp4Q2SG2EEkHFjKRF3bguhgoXTVM4Vx?=
 =?iso-8859-1?Q?w/c+/nUNl43W+oReEsfvV7kRkcgXzO2X0suIHjN19Wuh4UdjC59NZFuy/M?=
 =?iso-8859-1?Q?BBTpTagpRmshdJMpgDPPjVGXYiIJkmp2E7sRRKJdH/PeaKOwdSRO6w9R1P?=
 =?iso-8859-1?Q?no1O7x3ddHNWyeWqr6kNzq4OWPo7qBUZfBm+1LHbqsQchdpqSwuc2NPGk8?=
 =?iso-8859-1?Q?GKbu2trJxfJ0k7BW1rbgIzAgsE+ciGVoH9NfWPkqNDK73CbDZUOddn+e5D?=
 =?iso-8859-1?Q?NAjnNphl8Y14HkaiVF8lGQL9Czlgtzjn57q2umFsfqhEAyY4kUrdmWTrbI?=
 =?iso-8859-1?Q?eh7RP4MqXMtkQHTTRgIfnTLDFoUSYkYQMULVQ+ioY19uRsxihYwppPooIk?=
 =?iso-8859-1?Q?YT+qXZBkNycc2mcyLxyomvF4LtbdvoyQdd4aX71GnCMH2/Hho6Nvk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 359fbc1f-f260-467f-42ee-08d9593f2a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2021 01:03:27.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzzhNhroIVZizhc3yFeJ9rDaJc7CjvTitcUHoNu7KrtMXFErf6FY2B4+TblFMAIqbIDFPZFr8s9mAVwn6F1fSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB0899
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Patrick Goetz wrote:=0A=
>Hi -=0A=
>=0A=
>I'm having trouble reconciling this comment:=0A=
>=0A=
>On 8/4/21 1:24 PM, Anna Schumaker wrote:=0A=
>>>=0A=
>>> So, I have a naive question. When a client is writing to cache, why=0A=
>>> wouldn't it be possible to send an alert to the server indicating that=
=0A=
>>> the file is being changed. The server would keep track of such files=0A=
>>> (client cached, updated) and act accordingly; i.e. sending a request to=
=0A=
>>> the client to flush the cache for that file if another client is asking=
=0A=
>>> to open the file? The process could be bookended by the client alerting=
=0A=
>>> the server when the cached version has been fully synchronized with the=
=0A=
>>> copy on the server so that the server wouldn't serve that file until th=
e=0A=
>>> synchronization is complete. The only problem I can see with this is th=
e=0A=
>>> client crashing or disconnecting before the file is fully written to th=
e=0A=
>>> server, but then some timeout condition could be set.=0A=
>>=0A=
>> We already have this! What you're describing is almost exactly how=0A=
>> delegations work :)=0A=
>>=0A=
>=0A=
>=0A=
>with this one:=0A=
>=0A=
>On 8/4/21 10:42 AM, Rick Macklem wrote:=0A=
> >=0A=
> > There is no notification mechanism defined for any version of NFS.=0A=
>=0A=
>=0A=
>How can you do delegations if there's no notification system?=0A=
When you asked the question, there was no mention of delegations=0A=
and only a discussion of caching. Delegations deal with Opens and,=0A=
yes, can be used to maintain consistent data caches when they happen=0A=
to be issued to client(s).=0A=
=0A=
For write delegations, it works like this:=0A=
- When a client does an Open for writing, the server might choose to=0A=
   issue a write delegation to the client. (It is not required to do so and=
=0A=
   there is nothing a client can do to ensure that the server chooses to=0A=
   do so. The only rule is "no callback path-->no delegation can be issued"=
.=0A=
   - If the client happens to get a write delegation, then it can assume no=
=0A=
     other client is reading or writing the file (unless the client fails t=
o maintain=0A=
     its lease, due to network partitioning or ???).=0A=
     --> Therefore it can safely cache the file's data, unless the server a=
llow=0A=
            I/O to be done using special stateids. More on this later.=0A=
   - If the server received an Open request from another client for the fil=
e,=0A=
      then it does a CB_RECALL callback to tell the client that it must ret=
urn=0A=
      the delegation.=0A=
      --> The client can no longer safely cache file data once the delegati=
on=0A=
             is returned, since the server will then allow the other client=
 to Open=0A=
             the file.=0A=
      --> If the client fails to return the delegation for a lease duration=
, then the=0A=
             server can throw the delegation away.=0A=
             --> If the client does not maintain its lease and maintain its=
 callback=0A=
                   path, the client cannot safely cache data based on the d=
elegation,=0A=
                   since it might have been discarded by the server.=0A=
In general, a delegation allows the client to do additional Opens on a file=
=0A=
without doing an Open on the server (called level 2 OpLocks in Windows worl=
d,=0A=
I think?).=0A=
=0A=
The effect of consistent data caches depends upon two things, which a serve=
r=0A=
might or might not do:=0A=
1 - Issue delegations.=0A=
2 - Not allow I/O using special stateids. If any client can do I/O using sp=
ecial=0A=
     stateids, then the I/O can be done without having an Open or delegatio=
n for=0A=
     the file on the server.=0A=
In general, a client cannot easily tell if these are the case. I suppose it=
 could try=0A=
an I/O with a special stateid, but that really only confirms that this part=
icular client=0A=
cannot do I/O with special stateids, not that no client can do so.=0A=
A client can see that it acquired a delegation, but can do nothing if it di=
d not get one.=0A=
--> Is a client going to not cache data for every file, where the server ch=
ooses not to=0A=
       issue a delegation.=0A=
=0A=
Back to your question. You can consider the CB_RECALL callback a notificati=
on, but it=0A=
is in a sense a notification to the client that the delegation must be retu=
rned, not that file data=0A=
has changed on the server. In other words, a CB_RECALL is done when another=
 client=0A=
requests a conflicting Open, not when data on the server has been changed.=
=0A=
--> This has a similar effect to a notification that the data will/has chan=
ged, only if=0A=
       the server requires all I/O present an Open/Lock/Delegation stateid.=
=0A=
       --> No special stateids allowed and no NFSv3 I/O allowed by the serv=
er.=0A=
(The term notification is used in the NFSv4 RFCs for other things, but no C=
B_RECALL callbacks.)=0A=
=0A=
rick=0A=
=0A=
=0A=
