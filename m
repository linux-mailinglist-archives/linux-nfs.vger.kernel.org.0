Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A60BCA84
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2019 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441428AbfIXOpe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Sep 2019 10:45:34 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:46450 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfIXOpe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Sep 2019 10:45:34 -0400
Received: by mail-vs1-f44.google.com with SMTP id z14so1466390vsz.13
        for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2019 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7Gf59AsD//KvucsBozJmqgsBPFWY5M9klJxC97Ln/8=;
        b=Jt/alp1xguCQBAlhn+iuXErddbbjrkjUOHPwVtB8YwsxlLJnhxGeEd1bQGOkCEtq17
         9Y7Na7LwKtq/+fXgP31NmK/a23KrZXGxHU/W4EUlRlBxxL/n972r2Aaj/9jqiiL+YF9S
         GtMBiv1+STA6EPw0bp/KXm8oVuCi8qnDfFfpkEgjjeE6KEGRAtEsQGipuaGBHpbenwM9
         wfw6uoEc0vsF+xptESs4VuPAikur+BBXMkEDo/UydewbE8jaKEnPqhK6UlL76CHnpXW7
         UfHDKYHluMB4AHi5pLIhKBassainEMmamB+hvlPLl+1sSlMH2Cyb1pb4xa53e2oK3wMW
         4MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7Gf59AsD//KvucsBozJmqgsBPFWY5M9klJxC97Ln/8=;
        b=ib6uVop/+fYk7TbCOknKGw3SOLuwYz4tu1evhd4c6YZW7onogQBq1O+6zlRuZO4zAR
         0LvkkiPaYAbKmIFd2c3blGROMeDH1fiTk0PZSW115d+clIuZ0xIdyL+KUje4jx5s7Mx4
         yN4cgx9MB9jxDdhvYb3B4XsvdkQRVvYBz8kg09tcGNw01hCemVQ4Ahg461QsU1y+zbku
         jV1d3zYmm8frF5CZs1vI+aNJIp9UuZv0K0cdXfSQsFg0RyG9XQj3F/fSS9DsBFZRctJ1
         iz/8pgF+dfJNKfqx6YshEB53rm3if0nx2ENu97lQ6I5IS7awXE6ohjcl0Ei4fK3c0JRe
         ycXg==
X-Gm-Message-State: APjAAAUDDatmJBiHBcio9kdfZljdmzwFF7X83wGD6L6c4WwhpUUnRe3g
        SDzUxj69dEbOjSH3cLG8hZogOsIkZ6d/l7WS4fQ=
X-Google-Smtp-Source: APXvYqx3/KYVkp8JkHZ6Eqeuy/zIIyNbEmKuBfooRTz9cxOumc+ReLhenalJEBdcIMSWROB+pi4br8fvXiDq41BiVkU=
X-Received: by 2002:a67:da8e:: with SMTP id w14mr1744488vsj.194.1569336332339;
 Tue, 24 Sep 2019 07:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAACwWuN6siyM9t+rCmzxYPCf777bvD_J1xQKwNb7ZzBdzvy42Q@mail.gmail.com>
 <8217416C-F3E5-4BEE-BD01-2BE19952425E@redhat.com> <CAACwWuMbB=zTaXW-fQmUYHLvx=YgE=68M96=hq201pqn2wKxBw@mail.gmail.com>
 <66D00B9D-16DC-4979-8400-457398DC4801@redhat.com> <CAN-5tyERg5kwcD2iugwPVCLDSog0ufKoRRVbC-7pQW-hqLWncQ@mail.gmail.com>
 <CAACwWuPxPmbZFTpLf0_Lsh+yJqz_JQrSGUY5_621P4MGd1H_wA@mail.gmail.com>
 <CAN-5tyHqtQMJdrm1WUSjmiT7mrRd4HDNNmvZ=fdWjOoOu54ApA@mail.gmail.com> <CAACwWuOs7SMq48C4=09afag0xmYH5U9Z9LOyVvxJfMyZzq4u9g@mail.gmail.com>
In-Reply-To: <CAACwWuOs7SMq48C4=09afag0xmYH5U9Z9LOyVvxJfMyZzq4u9g@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 24 Sep 2019 10:45:20 -0400
Message-ID: <CAN-5tyHnXiDnEspzMSpEXnx6+fOJe1a4V3V8PnYbY5B9LsfQYQ@mail.gmail.com>
Subject: Re: troubleshooting LOCK FH and NFS4ERR_BAD_SEQID
To:     Leon Kyneur <leonk@dug.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Leon,

Given this trace, I don't see anything that the client is doing wrong.
I'd say this points to the server losing track of the seqid.

On Tue, Sep 24, 2019 at 12:18 AM Leon Kyneur <leonk@dug.com> wrote:
>
> On Thu, Sep 19, 2019 at 9:36 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Hi Leon,
> >
> > Given that you have a network trace with the BAD_SEQID error can you
> > filter on the file handle and trace the operations? It should be
> > possible to tell at that point if it's the client that's sending an
> > incorrect seq or the server. I'm assuming we can either trace the
> > locking stated to a previous (successful) use or to an open.  Provided
> > tshark output isn't enough to see what was inside the packets.
> >
> > If the LOCK that's failing used a seqid that wasn't bootstrapped from
> > the open seqid, then it can't be caused by a double CLOSE problem. But
> > if this LOCK was was bootstrapped from the open stateid we need to
> > traces open owner sequencing and a double close could have been the
> > cause.
>
>
> Hi Olga
>
> I don't ever see a double close in my packet captures. Here's a more
> verbose dump, I'm not quite sure what you mean re LOCK "wasn't
> bootstrapped from the open seqid" that does seem to explain it as I
> don't see the 0x00000001 seq id on the from the OPEN call later in the
> LOCK FH call. The working example (also below) does show this.
>
> So I'm still wondering if this is the double close issue or something else?
>
> # tshark -2 -n -r ../nfs.pcap   -z
> proto,colinfo,nfs.stateid4.other,nfs.stateid4.other
> ...
>  22          3 172.27.50.222 -> 172.27.255.28 NFS 370 V4 Call (Reply
> In 23) OPEN DH: 0xbfe01adc/m.db  nfs.seqid == 0x00000022
>  23          3 172.27.255.28 -> 172.27.50.222 NFS 394 V4 Reply (Call
> In 22) OPEN StateID: 0x7999  nfs.seqid == 0x00000001
> nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:e3:02:00:00
>  24          3 172.27.50.222 -> 172.27.255.28 NFS 290 V4 Call (Reply
> In 25) OPEN_CONFIRM  nfs.seqid == 0x00000001  nfs.seqid == 0x00000023
> nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:e3:02:00:00
>  25          3 172.27.255.28 -> 172.27.50.222 NFS 138 V4 Reply (Call
> In 24) OPEN_CONFIRM  nfs.seqid == 0x00000002  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:e3:02:00:00
>  26          3 172.27.50.222 -> 172.27.255.28 NFS 370 V4 Call (Reply
> In 27) OPEN DH: 0x272b8d23/.sqliterc  nfs.seqid == 0x00000024
>  27          3 172.27.255.28 -> 172.27.50.222 NFS 122 V4 Reply (Call
> In 26) OPEN Status: NFS4ERR_NOENT
>  28          3 172.27.50.222 -> 172.27.255.28 NFS 374 V4 Call (Reply
> In 29) OPEN DH: 0x272b8d23/.sqlite_history  nfs.seqid == 0x00000025
>  29          3 172.27.255.28 -> 172.27.50.222 NFS 430 V4 Reply (Call
> In 28) OPEN StateID: 0x3203  nfs.seqid == 0x00000001  nfs.seqid ==
> 0x00000001  nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:e5:02:00:00
> nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:e6:02:00:00
>  30          3 172.27.50.222 -> 172.27.255.28 NFS 306 V4 Call (Reply
> In 31) CLOSE StateID: 0x3203  nfs.seqid == 0x00000026  nfs.seqid ==
> 0x00000001  nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:e5:02:00:00
>  31          3 172.27.255.28 -> 172.27.50.222 NFS 202 V4 Reply (Call
> In 30) CLOSE  nfs.seqid == 0x00000002  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:e5:02:00:00
>  32          3 172.27.50.222 -> 172.27.255.28 NFS 306 V4 Call (Reply
> In 33) LOOKUP DH: 0x272b8d23/.terminfo
>  33          3 172.27.255.28 -> 172.27.50.222 NFS 122 V4 Reply (Call
> In 32) LOOKUP Status: NFS4ERR_NOENT
>  34          3 172.27.50.222 -> 172.27.255.28 NFS 290 V4 Call (Reply
> In 35) ACCESS FH: 0x272b8d23, [Check: RD LU MD XT DL]
>  35          3 172.27.255.28 -> 172.27.50.222 NFS 194 V4 Reply (Call
> In 34) ACCESS, [Allowed: RD LU MD XT DL]
>  36          3 172.27.50.222 -> 172.27.255.28 NFS 282 V4 Call (Reply
> In 37) GETATTR FH: 0x272b8d23
>  37          3 172.27.255.28 -> 172.27.50.222 NFS 266 V4 Reply (Call
> In 36) GETATTR
>  38          3 172.27.50.222 -> 172.27.255.28 NFS 302 V4 Call (Reply
> In 39) LOOKUP DH: 0x272b8d23/.inputrc
>  39          3 172.27.255.28 -> 172.27.50.222 NFS 122 V4 Reply (Call
> In 38) LOOKUP Status: NFS4ERR_NOENT
>  40          3 172.27.50.222 -> 172.27.255.28 TCP 66 822 > 2049 [ACK]
> Seq=3950 Ack=2617 Win=3077 Len=0 TSval=177154789 TSecr=3474577216
>  41          5 172.27.50.222 -> 172.27.255.28 NFS 354 V4 Call (Reply
> In 42) LOCK FH: 0x80589398 Offset: 1073741824 Length: 1   nfs.seqid ==
> 0x00000027  nfs.seqid == 0x00000002  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:e3:02:00:00
>  42          5 172.27.255.28 -> 172.27.50.222 NFS 122 V4 Reply (Call
> In 41) LOCK Status: NFS4ERR_BAD_SEQID
>  43          5 172.27.50.222 -> 172.27.255.28 TCP 66 822 > 2049 [ACK]
> Seq=4238 Ack=2673 Win=3077 Len=0 TSval=177156701 TSecr=3474579167
>
>
> working:
>
>   7          2 172.27.50.222 -> 172.27.255.28 NFS 370 V4 Call (Reply
> In 8) OPEN DH: 0xbfe01adc/m.db  nfs.seqid == 0x00000017
>   8          2 172.27.255.28 -> 172.27.50.222 NFS 394 V4 Reply (Call
> In 7) OPEN StateID: 0x08c1  nfs.seqid == 0x00000001
> nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:fc:02:00:00
>   9          2 172.27.50.222 -> 172.27.255.28 NFS 374 V4 Call (Reply
> In 10) OPEN DH: 0x272b8d23/.sqlite_history  nfs.seqid == 0x00000018
>  10          2 172.27.255.28 -> 172.27.50.222 NFS 430 V4 Reply (Call
> In 9) OPEN StateID: 0x147a  nfs.seqid == 0x00000001  nfs.seqid ==
> 0x00000001  nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:fd:02:00:00
> nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:fe:02:00:00
>  11          2 172.27.50.222 -> 172.27.255.28 NFS 306 V4 Call (Reply
> In 12) CLOSE StateID: 0x147a  nfs.seqid == 0x00000019  nfs.seqid ==
> 0x00000001  nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:fd:02:00:00
>  12          2 172.27.255.28 -> 172.27.50.222 NFS 202 V4 Reply (Call
> In 11) CLOSE  nfs.seqid == 0x00000002  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:fd:02:00:00
>  13          2 172.27.50.222 -> 172.27.255.28 TCP 66 919 > 2049 [ACK]
> Seq=1293 Ack=1157 Win=40 Len=0 TSval=177379723 TSecr=3474802150
>  14          4 172.27.50.222 -> 172.27.255.28 NFS 354 V4 Call (Reply
> In 15) LOCK FH: 0x80589398 Offset: 1073741824 Length: 1   nfs.seqid ==
> 0x0000001a  nfs.seqid == 0x00000001  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:fc:02:00:00
>  15          4 172.27.255.28 -> 172.27.50.222 NFS 138 V4 Reply (Call
> In 14) LOCK  nfs.seqid == 0x00000001  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  16          4 172.27.50.222 -> 172.27.255.28 TCP 66 919 > 2049 [ACK]
> Seq=1581 Ack=1229 Win=40 Len=0 TSval=177381305 TSecr=3474803772
>  17          4 172.27.50.222 -> 172.27.255.28 NFS 318 V4 Call (Reply
> In 18) LOCK FH: 0x80589398 Offset: 1073741826 Length: 510   nfs.seqid
> == 0x00000001  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  18          4 172.27.255.28 -> 172.27.50.222 NFS 138 V4 Reply (Call
> In 17) LOCK  nfs.seqid == 0x00000002  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  19          4 172.27.50.222 -> 172.27.255.28 NFS 310 V4 Call (Reply
> In 20) LOCKU FH: 0x80589398 Offset: 1073741824 Length: 1   nfs.seqid
> == 0x00000002  nfs.seqid == 0x00000002  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  20          4 172.27.255.28 -> 172.27.50.222 NFS 138 V4 Reply (Call
> In 19) LOCKU  nfs.seqid == 0x00000003  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  21          4 172.27.50.222 -> 172.27.255.28 NFS 298 V4 Call (Reply
> In 22) READ StateID: 0x2656 Offset: 0 Len: 6144  nfs.seqid ==
> 0x00000003  nfs.stateid4.other == 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  22          4 172.27.255.28 -> 172.27.50.222 NFS 6274 V4 Reply (Call
> In 21) READ
>  23          4 172.27.50.222 -> 172.27.255.28 TCP 66 919 > 2049 [ACK]
> Seq=2309 Ack=7581 Win=40 Len=0 TSval=177381309 TSecr=3474803775
>  24          4 172.27.50.222 -> 172.27.255.28 NFS 310 V4 Call (Reply
> In 25) LOCKU FH: 0x80589398 Offset: 0 Length: <End of File>  nfs.seqid
> == 0x00000003  nfs.seqid == 0x00000003  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  25          4 172.27.255.28 -> 172.27.50.222 NFS 138 V4 Reply (Call
> In 24) LOCKU  nfs.seqid == 0x00000004  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:ff:02:00:00
>  26          4 172.27.50.222 -> 172.27.255.28 NFS 190 V4 Call (Reply
> In 28) RELEASE_LOCKOWNER
>  27          4 172.27.50.222 -> 172.27.255.28 NFS 354 V4 Call (Reply
> In 29) LOCK FH: 0x80589398 Offset: 1073741824 Length: 1   nfs.seqid ==
> 0x0000001b  nfs.seqid == 0x00000001  nfs.stateid4.other ==
> 8f:73:7b:5d:30:ab:b5:d0:fc:02:00:00
>  28          4 172.27.255.28 -> 172.27.50.222 NFS 114 V4 Reply (Call
> In 26) RELEASE_LOCKOWNER
