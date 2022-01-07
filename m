Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC85F487BB0
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348655AbiAGR7h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 12:59:37 -0500
Received: from mail-eopbgr660052.outbound.protection.outlook.com ([40.107.66.52]:19328
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348668AbiAGR7g (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 Jan 2022 12:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFB+idRj4qYkhDU9SJUQ5OfOBsPBuKWHiYn/5ZMjE/tO4iWDT7Kl5FudJPvHyCvQmLsj4yzYYqz87ZJAhkdYDoUT8h8B9943QZ1CO/cQMiy1l0VWaTph8NwbPWlOD51Gi6ziDho/IAEcPJiPF+mTwvK8BRU4vapg4wdLkhgr9nNu9rTc16Tmsz8kIHsYIsjRni6QkQ3Rm+btm0iauFr6hVHGKKwqZYRTfvpZYS/Ncs0r8SLOqzXtwTpz8T/uZU6g3U2N5EjItzUX7iYYvgispNG1EeHqv+54gGTtVUO11u3r666nhpOKLIBTYBsSgFuq+vMf/wjUYVM74u6VHD/ZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjOnZWDuxYCIew55SmVWVVTHrmh8JC83u7VYZBepY5o=;
 b=MdXbTw7yAJ9AlpfOihZ5gWvcOUIvpm8AVdAuRbXHlXUgBtHNz6mFDvZ1iTR5hQTttXMfhygaMKqEa5RBaeqxPNvjrbeoQAeY+1QlHtC8WKiKROIUoyyp5IlYR6o0akSoIKCNvqJii5qwmWxTwzqFdkLAZCEAyHsuyBAVnRAJ8EmzRLCRaHJ9Aj/uIKPDol3f65KSjJYw74awmdhVntW/faI3KFk4nLxzT1U9oH4yaoZbtRDUvKu39ZUut8pe+oooaZU9msuqDCd2culyzkkl71joSQw++RtU44AwX9G2pkZ1GQuQXjyd2z1thIYBiTYvLEy0AiU+WQZMs2eNEEMZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjOnZWDuxYCIew55SmVWVVTHrmh8JC83u7VYZBepY5o=;
 b=a1Np8wUKbkWnmM/SL2GlFBthYS900RYlWvLCEuPLrvDRhhTofxUvcqguiNDfPuuvsC+UYcO0rRaVLup5T72gRapMgDE3Udvn5CGSR5uNkn9ULYOqMoNEg79ishyxW5G3vTxevFHbpc2cLFSQu+kvdfdJCSrI674mwZu40o1TUqfoWkiKhgk7oGxsBGdYUepFxZzd05FyoU5f4SdKQigR4n6Sjxsl1N/8sPvA2Hk3Du7cvIVu/7NOXvgZzUou6jdYBmEg3gy7ZVnfpTqd5Fd5HEporZItyY/Hibo+H5v24qopdJk65KXeVcbQ44kfrtADED+LjASj0HieYA+zg8hyjA==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQBPR0101MB6136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 17:59:33 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c9d2:bf41:eeca:90aa]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c9d2:bf41:eeca:90aa%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 17:59:33 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Daire Byrne <daire@dneg.com>
CC:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Thread-Topic: nconnect & repeating BIND_CONN_TO_SESSION?
Thread-Index: AQHYA+qGtKjQ36YDnk+o8Fd3U+OlSqxX1gOe
Date:   Fri, 7 Jan 2022 17:59:33 +0000
Message-ID: <YQXPR0101MB0968DEDAB6EC20BB11BF7D6ADD4D9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
In-Reply-To: <20220107171755.GD26961@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 733d83c3-6e7d-ff19-f40e-47cabaf4151e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66df8ac-ef1d-4468-82c6-08d9d207761c
x-ms-traffictypediagnostic: YQBPR0101MB6136:EE_
x-microsoft-antispam-prvs: <YQBPR0101MB613681DE480A7B193F4166C5DD4D9@YQBPR0101MB6136.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+CvwHwYaV33uETsGLwKmg07JUMZF7iVHkeAv0keqv1vqTklYIYvAP6kn6fP9nC6boF3a2MU8CuKDAYmKZh13lm5ahqJ3Mw5dlbj4IeL/Kv2H1x5VTV/7fVnIEGlYN1+Gm/EHqtjAPdH2DKQP+MEv9DX5D6k8uH7i86NbzxLA6clwVctXmPZdu7AMTuaY0pL4WP/fhwiBU2SwUzauqvT1H1N2vHI34hD1i/kAmPACd+XMvL009VgYak0UOJZLLWNzZG0Wgfdg4V03gZPndrNmHpuwNWQLz4euObVU7pkey6I25nYI1ka5p+xLXLECyjyXkKt9X5+4jTRID+2AWvnX0L7MVQhJaiJ6lIKywbluP63Wy51q5PzQ+OaYYLx3BuUrVmscnYRUTg0hpqRtBypr3wFdAlqhxzzx+qlsHR+DDAzLmyk1kIyS0jegjODZ27Y2323OsJGRrU7+78rVEnI5DhlvRQP6ZMydQEKzbro8tjdK69ooMELYiOPi4H8yu2CboJdCBmIJvC666xTJ3edL08tpVmKsAwmRPXoUozzqupMaoL5jMCs3ym5McRZ3ZOWprU7tXdjM3+4ngtLL9mdgMFcWv/g5HYrAcxSZvhz7QNoMY7oK/C+SAcT7iFtJKh57jgezGZvoQmatStil//hNKc6pisSWpF5sAFcEJ30lFIF+my81GIF1TKVDvfWcWk6FPlNAxCnNvxrA92/CD1AvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8676002)(7696005)(8936002)(9686003)(508600001)(38100700002)(110136005)(52536014)(55016003)(186003)(91956017)(316002)(66476007)(2906002)(5660300002)(66446008)(66946007)(86362001)(64756008)(53546011)(6506007)(66556008)(76116006)(786003)(38070700005)(71200400001)(122000001)(4326008)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1JrQaBqCPmsAUjN3SlyU5/Tw0NsdsQDQwwltOOpgsuAUXNTNunrVKufHa3YW?=
 =?us-ascii?Q?JJn70uywibjdyba5Dh1gTlL165XqEsoPkfRyW5Aatl99UsGmhRlFVx5G82Gw?=
 =?us-ascii?Q?WtYb2L5G25T8l8OR7coldeU1R4ACoAF8YXjlR3yLrbGMShmWCeBo0pRR0vmm?=
 =?us-ascii?Q?vWmF2NulaoBmtrPDqL/ulMisTcEj2KkRosdkO94DutJ0mRWY7R4DnTvLKvDE?=
 =?us-ascii?Q?B8pwuwcIPuGVXRGKd4Crv8BtWL+p7Bn3xwt5RmEov1DIVzrcNXFECJm0YmGh?=
 =?us-ascii?Q?f9oq2X0xyLC2LmlzfXeM+cHWAB/W2CuG8+f+qoAqIEW6C4CSyy2yykgQxSL6?=
 =?us-ascii?Q?JGuCDWj34wtC5oxaXehqJXk5EPUceErWGCeZ9+nAJG2YfsCN0ZaGHJcbvwzF?=
 =?us-ascii?Q?9cWhVwcwx6uVVL7YxVaejuEGeqrwUGV+yvnyYoa6IwT8QuSw7pbHY8E6GcTJ?=
 =?us-ascii?Q?qclpmBi7sHI/uEaAdLoGtfnHj/7AGb83J0kuvrSonuwxBAUpI3EvRzrH2HH0?=
 =?us-ascii?Q?6Xt6Se9gWtD9r82OqpnUVsEYABkxoR6h0J9u9jdGqa9erTp1XN+etyN3+4/G?=
 =?us-ascii?Q?n9z0vSzag/bapJ5L/3f9VFMKaJW3qlyDl7dRw9L8yYd8zaQ9h54MaSxrjefe?=
 =?us-ascii?Q?yFsShtzORXMeQqEqxWJFbYMrRTg0U2w7wnwjSD9x5NobrJgF9FPQVYH209B9?=
 =?us-ascii?Q?B3FlwsgmeCJsvU+tX5zn/4rIR8fmZcqg+DCW/DfWm0E4FS33FbQPi8oYP7u7?=
 =?us-ascii?Q?7UhzMTsKJZgrMHrRA5viwujZxpWoM/I6jfmXeKgTyBHIZz1t40ySYeXFA2sZ?=
 =?us-ascii?Q?Jvy2xoQzfmmSoLXLW/dcMZwf775hpKZVcK4yn9SoXJkPQHOlV8uaWDozRrjj?=
 =?us-ascii?Q?f4/HJzX0aBUlxCYflhVBO/XXF/60O5HtvLoeZwWwbVg2DMKH25pCJ8MYKxus?=
 =?us-ascii?Q?7cW7Ode7a5043JKK6cJuHO8YWe9yi+08aXr3bHt9Yt6Li488VawjhCWKJVFg?=
 =?us-ascii?Q?22wssV7tSLR9BnVmM2Mrf01jBfpyfh1CjvZWZCgGtvwzLmS8WXYtf6Hz9xM0?=
 =?us-ascii?Q?ZcN5hz1ySyNWQ1isKHkLr+5yZusWXJ1vrH8VzhKD7RM9jb6BICl44+o+qRy4?=
 =?us-ascii?Q?G6M+z29tGp529GyllCLwezsaJDFB7smtiuuW0XBCSn2skE4hFutBwdqKT4gJ?=
 =?us-ascii?Q?k1M2Fz/BYm22FH5NtxrQ3lxsZZtF0APn8C6HnM0jeoFmw9vol06a6OpmJpU0?=
 =?us-ascii?Q?gQ1Umt0tm/9A2YQEBon1CHBxrFjS9IgmAZgxReuQgiA6DfGYZ5Ll2N+KZwnO?=
 =?us-ascii?Q?aYpEncpkCYc43lITYZ4JS9z6U1AyralV9rax8Mvsv6CT06kmlpYnbIjYvpwN?=
 =?us-ascii?Q?6CDPH5/CnuLVSO/vSCmjn1Y03YTTjnf0FACn35mBkLaxfbbKMzmUiN1n5bCt?=
 =?us-ascii?Q?uaoHyNrctv+fpsh9pl6X+rma/tsIfXaZbgNuZl3PzLyGx5PKV7lipo1NBEtB?=
 =?us-ascii?Q?AuqLikxNpmlqt4VTyiK6vdq5NwZLvxVUDYP1oYKjgJmte/c0ZBmB2X/OLtmQ?=
 =?us-ascii?Q?IPbyjljRWmZ7m88rAcoqejBKmqgvnnxUF0HpEqf5hecxaS+R1ZB0gZtRJCjx?=
 =?us-ascii?Q?mwSFFS8HR1+DmWpUbCRlMaCPNYYOe2z37XTRG+y9vFUWo2M+yuS55N3qEmTL?=
 =?us-ascii?Q?HvaNfw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e66df8ac-ef1d-4468-82c6-08d9d207761c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 17:59:33.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XNIw78rTYlv8TiWfDew+AVNWnZxKIOIRxkExlleJRu/JBP9oOPrgnQPQVqy39L3AjcPiJ+0N64kFo1ZdKVfaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6136
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hope you don't mind a top post...

If you capture packets, you will probably see a
callback_down flag in the reply to Sequence for
RPC(s) just before the BindConnectionToSession.
(This is what normally triggers them.)

The question then becomes "why is the server
setting the ..callback_down flag?".

One possibility might be a timeout on a callback
attempt that is too agressive?
--> You should be able to see the callbacks in the
      packet trace.

Another might the server attempting the callbacks on
the wrong TCP connection.
--> The FreeBSD server was broken until recently and
      would use any TCP connection to the client and not
      just the one where the Session had enabled the
      backchannel.
      --> If you happen to be mounting a FreeBSD server,
             you cannot use "nconnect" unless it is very
            up-to-date (the fix was done 10months ago, but
             it takes quite a while to get out in releases).
Look for the CreateSession RPCs when the mount was
first done and see which ones have a backchannel.

Btw, unless the client establishes a new TCP connection
(SYN, SYN/ACK,...) before doing the BindConnectionToSession,
the server might reply NFS4ER_INVAL. The RFC says this is
to be done, but I'll admit the FreeBSD server doesn't bother.

Good luck with it, rick


________________________________________
From: J. Bruce Fields <bfields@fieldses.org>
Sent: Friday, January 7, 2022 12:17 PM
To: Daire Byrne
Cc: linux-nfs
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?

CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca


On Fri, Jan 07, 2022 at 12:26:07PM +0000, Daire Byrne wrote:
> Hi,
>
> I have been playing around with NFSv4.2 over very high latency
> networks (200ms - nocto,actimeo=3D3600,nconnect) and I noticed that
> lookups were much slower than expected.
>
> Looking at a normal stat, at first with simple workloads, I see the
> expected LOOKUP/ACCESS pairs for each directory and file in a path.
> But after some period of time and with extra load on the client host
> (I am also re-exporting these mounts but I don't think that's
> relevant), I start to see a BIND_CONN_TO_SESSION call for every
> nconnect connection before every LOOKUP & ACCESS. In the case of a
> high latency network, these extra roundtrips kill performance.
>
> I am using nconnect because it has some clear performance benefits
> when doing sequential reads and writes over high latency connections.
> If I use nconnect=3D16 then I end up with an extra 16
> BIND_CONN_TO_SESSION roundtrips before every operation. And once it
> gets into this state, there seems to be no way to stop it.
>
> Now this client is actually mounting ~22 servers all with nconnect and
> if I reduce the nconnect for all of them to "8" then I am less likely
> to see these repeating BIND_CONN_TO_SESSION calls (although I still
> see some). If I reduce the nconnect for each mount to 4, then I don't
> see the BIND_CONN_TO_SESSION appear (yet) with our workloads. So I'm
> wondering if there is some limit like the number of client mounts of
> unique server (22) times the total number of TCP connections to each?
> So in this case 22 servers x nconnect=3D8 =3D 176 client connections.

Hm, doesn't each of these use up a reserved port on the client by
default?  I forget the details of that.  Does "noresvport" help?

On the server (if Linux) there are maximums on the number of
connections.  It should be logging "too many open connections" if you're
hitting that.

--b.

> Or are there some sequence errors that trigger a BIND_CONN_TO_SESSION
> and increasing the number of nconnect threads increases the chances of
> triggering it? The remote servers are a mix of RHEL7 and RHEL8 and
> seem to show the same behaviour.
>
> I tried watching the rpcdebug stream but I'll admit I wasn't really
> sure what to look for. I see the same thing on a bunch of recent
> kernels (I've only tested from 5.12 upwards). This has probably been
> happening for our workloads for quite some time but it's only when the
> latency became so large that I noticed all these extra round trips.
>
> Any pointers as to why this might be happening?
>
> Cheers,
>
> Daire

