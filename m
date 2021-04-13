Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2147A35E97C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 01:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhDMXJO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 19:09:14 -0400
Received: from mail-eopbgr670089.outbound.protection.outlook.com ([40.107.67.89]:23520
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348762AbhDMXJN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 19:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQRMh5kResZ26RPtMac1QIhvnDCt3XSwD2nV6/SRJV+pQCHg7wUNB0bc7FJ4g1Z/ayKGpk5uz34jsc6HFavfnZkGH0xDMumi5eHyf8SASAd3mONHgUgBdHzfvH92nLEXAM4Xqz97PQ40GSIw52oUHnF2GwgCG55tC6yYkAj7p04rztqPKtwCShnr1iQ4XMQzsJPlGd0RLsKDmWlL4ASa/oNIK7qACgCSCXOP9QujDXpKN9+k6HsWcioqSJkjWkkSQxSmUka2B6vCoY5tGXAelQ0R0eHk9xOERWp6if2vHyE5L495CtvZ0f95iyAAYZj1+ZqUjYxZFfQs9EiefXpo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWvpppSrhmozi8wGrrkqyyCxbfEwG2HMHak/sYD+MyA=;
 b=NYwJ00k869hCPnmFl8arm2fONxfaPerxIZnaUeEUK9bM96N2wyTOa7n3UEzwnvJGxlDFMT2a9mdUMqxTNORNjVpfyZVaLRZ7uSe8yy8QZSiJJqFS7mNnASMJPAVnADksJ5XEPc3vsjQXGDFoqglYi4dX+WypiS3ZwXpUtht7FZ9GjyzhyYFpfyLdi3vIelG6U/u6liQ6PeWQpa0MEpkX3HIqQB6kWtQlb5WSFT4U8JlWF/RCvUt8CyfDr+8DKjZlGLV0HZLpaMVW2IdPMwLghB6HoeKFkHZHD5oAaKT+mJ7N8zZXrNAzXhTCs23rtsDCpoedJiLDpUzHqheJsl6UZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWvpppSrhmozi8wGrrkqyyCxbfEwG2HMHak/sYD+MyA=;
 b=XfffMR5wqkrGrbePVUoadmeajIIXlIt3Lm4hiBjDj+xG5DN6jQH5iJVpecRIp+wXiTV0nzxVMcdLQ17cXODKGMFHklqvqhmHVWNGCUvxTpSkW2QmMOU6m4feZ95MMMI3wRmzixHJ9YcTpH0SIUUToM6+gmB/FhX3oORJmHKum/elxPrr6si/meLzg3vcVWuBjYpCwbZutGq/uFgygVNUpceXiba2hjyYNrRXy8gwTqtupkMeBgngCk8T3jFg8AJkO1dlmuSVFeGcZfXm1BK3es2WxekFr9HVSpxsgtptFnhPdVUaffDQpr4T+Ugfb2etGITL+a9d8BRfh/6ArmfBng==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB3592.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 23:08:51 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.3999.037; Tue, 13 Apr 2021
 23:08:51 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
CC:     Linux-NFS <linux-nfs@vger.kernel.org>
Subject: Re: Linux NFSv4.1 client session seqid sometimes advances by 2
Thread-Topic: Linux NFSv4.1 client session seqid sometimes advances by 2
Thread-Index: AQHXL9rIYn3uMMvy90evx7HGhIWLsKqycvKAgAA/JgCAABxygIAACEwAgAAXNwCAAB/6ZA==
Date:   Tue, 13 Apr 2021 23:08:51 +0000
Message-ID: <YQXPR0101MB096851380C58EA8F671427E0DD4F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR0101MB0968E44CE6FB05F22DE27716DD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <CAN-5tyEWwAtBG41VByps+zS6Sw_z9U7Q8HZb84SqyXp4woUiPA@mail.gmail.com>
 <20210413171738.GA28230@fieldses.org>
 <CAN-5tyF=NBaZkv-CMKdK2JGMCRQ7cO2KNPTwO5KEPFG-JO4D4g@mail.gmail.com>
 <20210413192908.GD28230@fieldses.org>,<CAN-5tyEWVk9zH-aRJ7FSS5=nTLtVqfqFO9JEjQnp5PnCtmn=aQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEWVk9zH-aRJ7FSS5=nTLtVqfqFO9JEjQnp5PnCtmn=aQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da22b6e1-b4e8-41bf-3ad5-08d8fed11a51
x-ms-traffictypediagnostic: YQXPR01MB3592:
x-microsoft-antispam-prvs: <YQXPR01MB35924A24040BCBA44507FAE4DD4F9@YQXPR01MB3592.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qMqcgK1JA/Gk3fd/vj7F4Vl6gKxTiTlZFDy5X4izuXwVdwU3i8nj7Q0CPLYAEvtmMfTLYV3s7LCpyinzhFfGIubvowtbs5sIrEmBV7USM/A0UwCPIFNvyhOK3eJyUlLv+MlBrtI0Osm/r8I5j/IScllRZqgTzWQtBN65t/wENytXJUevNYY0oKD4bkVN+lVaGrw6pn4lsNlFucr4zwo5Q1CELooA9uXOuzkDcE04NN7U0nkSoOFoxL8DjLx5j+g6BXZApqxtJcfbHrPncUS0cLOvZqgg80KCm1+cplGDSAJ85NYvMhnXd7od77rWR/Ipx+gjrpIwbG+zyNOAw8HMyMKLfnm7fJFLjurRSkf7twYv+AhGiQaTSasln5An/LRbzkQYJ+588lOnlz9hVbZu2t7shLfe1a1W3GZ6Xa0r+IR6JhRyJM9r+JiMP/LggZA5KG4taJ/gfpJwPpv1BKgJYo0tmEa+w3tPz7neqKRSK/137fR2mJ1GVbyuZr1CrQMvozIhkF2V39QV1tABG7zBLERIZ8WHH45B0sp4mlLZ0rNWllcsP4r1ozousvjNE55xLX6ymvnTDprExOXYgAitLQE8wt+1VXeLuEC/xNh7F0s+Yy9a6bX7tqtTUY/ODE8mq4mEeIeqzMx4g/XSLOQLzut95r9kAAx0a6F96PicQKEe5ZOwmE1ldd6N7to9Tw0p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39850400004)(366004)(346002)(91956017)(86362001)(110136005)(66446008)(8936002)(786003)(8676002)(76116006)(71200400001)(478600001)(5660300002)(7696005)(316002)(966005)(6506007)(9686003)(66556008)(53546011)(55016002)(52536014)(38100700002)(83380400001)(64756008)(33656002)(66946007)(122000001)(26005)(4326008)(186003)(66476007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jVIhBPOm8bHm+SJb4Q6A5uo8xBUieTLD23KHX2SVh1Z5f9R9lY7cm/9jJz?=
 =?iso-8859-1?Q?DbkRbnqaHifdnPp+YkUDNgHDZWfu84CjpnxiYkDucVz8AArxjVkWGei+Nh?=
 =?iso-8859-1?Q?Vmv2svoowWpCe3VMJa8Z6i0bOUdxItuwA17hoXBI6J6FZOpIgsU5W8cFz5?=
 =?iso-8859-1?Q?yCGnXusaydulWFcqcgU+kbNjab16Hhu7Xlvfrs13PSakPuDo/8g0OOVQ8W?=
 =?iso-8859-1?Q?UaquaZMU870n8tyynrZ0c62Mv7NooWWdTPMFqKL975kev9wS3GhryZK4mX?=
 =?iso-8859-1?Q?BmDTRbMeF4z00GMIcMJnbhemKzCpXqgEyliYWkTMlUAZgEQ8Ad7uUi0N+r?=
 =?iso-8859-1?Q?DSLBdIBq78x2TPpjaY/+FctTFXBE6Y048nNgrpfzX0ROCi1ZqWhHKq5v7F?=
 =?iso-8859-1?Q?Br0oTUfjHnqoT1PvacT8rKnXn/oLDFHlqoXyX2UxMgGIo+7Hb5kIUYwREW?=
 =?iso-8859-1?Q?ReHgOiJ1YRpLN3Syp9D3R5EYuovoXH2lbM6R/aJuQyVU5Jxx7VgmgPXiFO?=
 =?iso-8859-1?Q?XdTP0Ap31OQnmZmd7uY/9RUPdmewyqGWSuUGtNfOgcVhBw6NTyRcmqt3Yb?=
 =?iso-8859-1?Q?WNR9zbeS2b9BGk4zYXsmNSd7n7F0jnyRQ1THIk9JjqUm/yoyWrcBGzEsfB?=
 =?iso-8859-1?Q?Fth3xQhbeL3A6w9zIcDU1P+gRRLbO6wZOmFit+ULPQu0X2CRW1WySMEDvP?=
 =?iso-8859-1?Q?BRHrbPBiM2L0yReqT3wazLVhQREi9YPVNwOizHHsRkbh5mRSBW/8viDPGx?=
 =?iso-8859-1?Q?I9rA/d6Hu69qiBoRRKg6LxBg6xtk87HKTq0lurYJs5K8WfeCqrylz8YhdK?=
 =?iso-8859-1?Q?+7HuWwhZqXmBNEGrC4cTtq1nHw2YowsNmAQCjxnnLsmLylF0v8rcKWvlqg?=
 =?iso-8859-1?Q?VsJmoN9QKWs7ZT6OybFiiWhDfRbUsSx7v9sHkIJXDMkCnLPv1OYhadGwJI?=
 =?iso-8859-1?Q?deY4i1WhcoYwd5ecPJZTLPn3aPX3Z90NRtZGy7Q+Gxrp0Ha5TFE5yhx9Xa?=
 =?iso-8859-1?Q?a+acHUR3A98yc9Yq/EgOkp+o+OkHORShZU5JeD+s5BjZkIFUvnEpxTyVXH?=
 =?iso-8859-1?Q?FyVuB83KZBuc8qcTnPSwEN/Dx0GDSq0rvcAsPBp6396DzbT/W9SCOZPxcW?=
 =?iso-8859-1?Q?B90x+nff9uNZdiAfP9Az6Z9ig3xWDTOzDV74iIZJL5CvyQRidnIxAiydTM?=
 =?iso-8859-1?Q?TslzOqWjtzP56RPMU0HqEi+OrXef+O8cp/vFhY8CAOaaRsS7IYx4aYwftb?=
 =?iso-8859-1?Q?joa42XYZzCGh9wrn8I4aSlrEKJwhUc1PiR/+nd0GkzErssLKkfNi+24eW2?=
 =?iso-8859-1?Q?ERVjDoe19IqeyxzLWvOVkPTAuMiaHkgb36/XA+Ov41WCYc4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da22b6e1-b4e8-41bf-3ad5-08d8fed11a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 23:08:51.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Dp5KPsMTELXCkt4I7jA/NajAKS+ILnz4G5pQK+xToV+9g2yxRzy131nhaYabxFT6AkeQURtHwNwhbQcFv+2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3592
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga Kornievskaia wrote:=0A=
>On Tue, Apr 13, 2021 at 3:29 PM J. Bruce Fields <bfields@fieldses.org> wro=
te:=0A=
>>=0A=
>> On Tue, Apr 13, 2021 at 02:59:27PM -0400, Olga Kornievskaia wrote:=0A=
>> > On Tue, Apr 13, 2021 at 1:17 PM J. Bruce Fields <bfields@fieldses.org>=
 wrote:=0A=
>> > >=0A=
>> > > On Tue, Apr 13, 2021 at 09:31:37AM -0400, Olga Kornievskaia wrote:=
=0A=
>> > > > On Tue, Apr 13, 2021 at 3:08 AM Rick Macklem <rmacklem@uoguelph.ca=
> wrote:=0A=
>> > > > >=0A=
>> > > > > Hi,=0A=
>> > > > >=0A=
>> > > > > During testing of a Fedora Core 30 (5.2.10 kernel) against a Fre=
eBSD=0A=
>> > > > > server (4.1 mount), I have been simulating a network partitionin=
g=0A=
>> > > > > for a few minutes (until the TCP connection goes to SYN_SENT on=
=0A=
>> > > > > the Linux client).=0A=
>> > > > >=0A=
>> > > > > Sometimes, after the network partition heals, the FreeBSD server=
=0A=
>> > > > > replies NFS4ERR_SEQ_MISORDERED.=0A=
>> > > > > Looking at the packet trace, the seqid for the slot has advanced=
 by=0A=
>> > > > > 2 instead of 1. An RPC request for old-seqid + 1 never seems to =
get=0A=
>> > > > > sent.=0A=
>> > > > > --> Since sending an RPC with "seqid + 2" but never sending one=
=0A=
>> > > > >        that is "seqid + 1" for a slot seems harmless, I have add=
ed an optional=0A=
>> > > > >        hack (can be turned off), to allow this case instead of r=
eplying=0A=
>> > > > >        NFS4ERR_SEQ_MISORDERED for it. The code will still reply=
=0A=
>> > > > >        NFS4ERR_SEQ_MISORDERED if an RPC for the slot with=0A=
>> > > > >        "old seqid + 1" in it.=0A=
>> > > > >        --> Yes, doing this hack is a violation of RFC5661, but I=
've=0A=
>> > > > >              done it anyhow.=0A=
>> > > > >=0A=
>> > > > > If you are interested in a packet capture with this in it:=0A=
>> > > > > fetch https://people.freebsd.org/~rmacklem/linuxtofreenfs.pcap=
=0A=
>> > > > > - then look at packet #1945 and #2072=0A=
>> > > > >   --> You'll see that slot #1 seqid goes from 4 to 6. There is n=
o=0A=
>> > > > >          slot#1 seqid 5 RPC sent on the wire.=0A=
>> > > > >          (This packet capture was taken on the Linux client usin=
g=0A=
>> > > > >           tcpdump.)=0A=
>> > > > > --> Btw, the "RST battle" you'll see in the above trace between=
=0A=
>> > > > >        #2005 and #2068 that goes on until the FreeBSD=0A=
>> > > > >        krpc/NFS times out the connection after 6min. seems to be=
 a recent=0A=
>> > > > >        FreeBSD TCP bug.=0A=
>> > > > >        I have reproduced this seqid advances by 2 on an older sy=
stem=0A=
>> > > > >        that does not "RST battle" and allows the reconnect right=
 away,=0A=
>> > > > >        once the network partition is healed, so it does seem to =
be=0A=
>> > > > >        relevant to this bug.=0A=
>> > > > >=0A=
>> > > > > Someday, I will get around to upgrading to a more recent Linux=
=0A=
>> > > > > kernel and will test to see if I can still reproduce this bug.=
=0A=
>> > > > > On 5.2.10, it is intermittent and does not occur every time I=0A=
>> > > > > do the network partitioning test.=0A=
>> > > > >=0A=
>> > > > > Mostly just fyi, rick=0A=
>> > > >=0A=
>> > > > Hi Rick,=0A=
>> > > >=0A=
>> > > > I think this is happening because slotid=3D1 had something queued =
up=0A=
>> > > > using seqid=3D5 and that was interrupted because the connection wa=
s=0A=
>> > > > RSTed. For the interrupted slot, the client would send solo SEQUEN=
CE=0A=
>> > > > with +1 seqid.=0A=
>> > >=0A=
>> > > Doesn't the client send the solo SEQUENCE with seqid 5 in that case?=
=0A=
>> >=0A=
>> > No it sends with seq+1 because NFS layer client doesn't know if seqid=
=0A=
>> > actually was actually transmitted before the connection got caught=0A=
>> > (and/or received by the server).=0A=
>>=0A=
>> But then the MISORDERED tells the client it wasn't received, so the=0A=
>> client follows up with a call with seqid 5--is that what happens?=0A=
>=0A=
>Correct. If there were no error then the server did indeed consume=0A=
>seqid. And if an error was returned then the client knows to=0A=
>decrement.=0A=
Ok. Yes. I took a closer look at the packet capture and that is what happen=
ed.=0A=
On slot#1...(server expecting seqid =3D=3D 5):=0A=
- Sequence with seqid 6=0A=
--> reply NFS4ERR_SEQ_MISORDERED=0A=
- next use of slot#1, Sequence with seqid 5=0A=
--> reply NFS_OK=0A=
- next use of slot#1, Sequence with seqid 6=0A=
--> reply NFS_OK=0A=
- then slot#1 gets used normally by other RPCs=0A=
=0A=
So it's an intentional "probe to re-synchronize the=0A=
seqid for the slot"?=0A=
Clever.=0A=
=0A=
I'll back my "hack" out, since I now see it is not necessary=0A=
(and does violate the RFC'-).=0A=
=0A=
So, is this how the Linux client deals with "soft,intr" NFSv4.1=0A=
mounts?=0A=
--> I've never solved that for FreeBSD and just note in the BUGS=0A=
       section of the man page that "soft,intr" mount options break=0A=
       an NFSv4 mount.=0A=
I might *borrow* this idea. I'll attribute it to whoever thought of=0A=
the idea, if you let me know who that is?=0A=
=0A=
Thanks for the clarification, rick=0A=
=0A=
> Sorry, I seem to recall we went through this all a couple years ago, but=
=0A=
> now I've forgotten how it works.=0A=
>=0A=
> --b.=0A=
