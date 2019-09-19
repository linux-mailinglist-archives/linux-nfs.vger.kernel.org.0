Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC9B7A9D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbfISNgu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 09:36:50 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:34916 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388819AbfISNgt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 09:36:49 -0400
Received: by mail-ua1-f54.google.com with SMTP id n63so1068449uan.2
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FKZ/yBY3OEcyKup1/TU0WQtMc2o8eT7RbRTm1tre/8=;
        b=hDFwsboAL19HVxO6WY+6I5EPA8KQvoZu1wkBWgnWqyFXIyUm+gpJ1b9Kh4dBb9PG3u
         a7TcEfQIMISl08OgTJ7Wk2KCpL7dGw89eje1/gAdoWQbTdRZcLRTU165NBuiQBlvQDn7
         4ycEUuqRaETIxCrgJyJHPENRzIzcuJqunrlCIBiBBEvc0hnewxQhcFn/zmPjR6Rfi/7w
         E9U0LGn/AKRtJZLc2/oIGuUCaUiihzle38USIRiwlEjtLdxQKbmNrV7AaRAwD3Cd4Ggj
         B2j3p1VhVXdvLXIESOOKiRxUStLjP3r/6FLjiIyXMPqBT9WA9Q0mYx5p0ERxw9D+NiR1
         OUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FKZ/yBY3OEcyKup1/TU0WQtMc2o8eT7RbRTm1tre/8=;
        b=tdzJnnntqgcQDPaHIrqWMCe7x0FH6vkpCLdTrp+GSHAjR2HWE8sHkjAxtG2yg2GuR9
         fx83mWEPN2HPbMgquHZ5rec8vzneV9X58oIjnueZrS3HlHmRmc0Ym9OR9aqONTqPOrC8
         l1YzscNOVYOJ1SNggiRs7HgafFfHkFxtIT+00G9AvJylgQDW+y4YcqPOmXfmFNbIvpH1
         3DoV6Hk/o9Ia7l5jb8rMJKihxMQxdhXcQQQ62ArGEr4pE6mUtMX0Y2fPK24oFnJJENa9
         IfLq3g0FGYYOFwnowAVwO5uHVODGgPoxNaLyOUBwDvXrffYDyRB8iXpxGly3vA7mXGvQ
         zniw==
X-Gm-Message-State: APjAAAWed/+NHxYqO5hBWmqV1j6CjULDDqhDReAsNcn0pM6WsB65NJ9Z
        2qMaHMlrk5dbqWJa8VzetrP9sE8YA9ZyOum09adbzQ==
X-Google-Smtp-Source: APXvYqy6KsPZj+i2P6pO9aJl4L6xkbbNYq/DEwTC6kOv1CknicS2ZpOrZFKHi7XxKcj70KgQpdHyqDJUH+gipPIDQrI=
X-Received: by 2002:ab0:1c0b:: with SMTP id a11mr5493153uaj.65.1568900208009;
 Thu, 19 Sep 2019 06:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAACwWuN6siyM9t+rCmzxYPCf777bvD_J1xQKwNb7ZzBdzvy42Q@mail.gmail.com>
 <8217416C-F3E5-4BEE-BD01-2BE19952425E@redhat.com> <CAACwWuMbB=zTaXW-fQmUYHLvx=YgE=68M96=hq201pqn2wKxBw@mail.gmail.com>
 <66D00B9D-16DC-4979-8400-457398DC4801@redhat.com> <CAN-5tyERg5kwcD2iugwPVCLDSog0ufKoRRVbC-7pQW-hqLWncQ@mail.gmail.com>
 <CAACwWuPxPmbZFTpLf0_Lsh+yJqz_JQrSGUY5_621P4MGd1H_wA@mail.gmail.com>
In-Reply-To: <CAACwWuPxPmbZFTpLf0_Lsh+yJqz_JQrSGUY5_621P4MGd1H_wA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 19 Sep 2019 09:36:37 -0400
Message-ID: <CAN-5tyHqtQMJdrm1WUSjmiT7mrRd4HDNNmvZ=fdWjOoOu54ApA@mail.gmail.com>
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

Given that you have a network trace with the BAD_SEQID error can you
filter on the file handle and trace the operations? It should be
possible to tell at that point if it's the client that's sending an
incorrect seq or the server. I'm assuming we can either trace the
locking stated to a previous (successful) use or to an open.  Provided
tshark output isn't enough to see what was inside the packets.

If the LOCK that's failing used a seqid that wasn't bootstrapped from
the open seqid, then it can't be caused by a double CLOSE problem. But
if this LOCK was was bootstrapped from the open stateid we need to
traces open owner sequencing and a double close could have been the
cause.

On Thu, Sep 19, 2019 at 12:23 AM Leon Kyneur <leonk@dug.com> wrote:
>
> On Wed, Sep 18, 2019 at 10:32 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Hi folks,
> >
> > The bad_seqid error could have been the bug in 7.4
> > https://access.redhat.com/solutions/3354251. It's been fixed in
> > kernel-3.10.0-693.23.1.el7. Can you try to update and see if that
> > helps? The bug was client was sending a double close throwing off the
> > seqid use.
> >
>
> Hi Olga
>
> I did see that but discounted it as I am not seeing duplicate CLOSE
> for the same StateID when the client is affected, could this happened
> at some point earlier in time to trigger the condition? I don't
> understand how I can reproduce it.
>
> When it's affected I don't see the duplicate close:
>
> $ tshark -n -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid
> |grep -E "CLOSE|BAD|LOCK|OPEN|ACCESS"
>  14         10 172.27.30.129 -> 172.27.255.28 NFS 276 V4 Call ACCESS
> FH: 0xfd9d2fb5, [Check: RD LU MD XT DL]  rpc.xid == 0x6590c61d
>  15         10 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 14) ACCESS, [Allowed: RD LU MD XT DL]  rpc.xid == 0x6590c61d
>  19         10 172.27.30.129 -> 172.27.255.28 NFS 276 V4 Call ACCESS
> FH: 0xfd9d2fb5, [Check: RD LU MD XT DL]  rpc.xid == 0x6790c61d
>  20         10 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 19) ACCESS, [Access Denied: MD XT DL], [Allowed: RD LU]  rpc.xid ==
> 0x6790c61d
>  21         10 172.27.30.129 -> 172.27.255.28 NFS 288 V4 Call ACCESS
> FH: 0x272b8d23, [Check: RD LU MD XT DL]  rpc.xid == 0x6890c61d
>  22         10 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 21) ACCESS, [Allowed: RD LU MD XT DL]  rpc.xid == 0x6890c61d
>  24         10 172.27.30.129 -> 172.27.255.28 NFS 288 V4 Call ACCESS
> FH: 0x54d7a1df, [Check: RD LU MD XT DL]  rpc.xid == 0x6990c61d
>  25         10 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 24) ACCESS, [Allowed: RD LU MD XT DL]  rpc.xid == 0x6990c61d
>  33         11 172.27.30.129 -> 172.27.255.28 NFS 372 V4 Call OPEN DH:
> 0x272b8d23/.bash_history  rpc.xid == 0x6c90c61d
>  34         11 172.27.255.28 -> 172.27.30.129 NFS 396 V4 Reply (Call
> In 33) OPEN StateID: 0x0f49  rpc.xid == 0x6c90c61d
>  36         11 172.27.30.129 -> 172.27.255.28 NFS 288 V4 Call
> OPEN_CONFIRM  rpc.xid == 0x6d90c61d
>  37         11 172.27.255.28 -> 172.27.30.129 NFS 140 V4 Reply (Call
> In 36) OPEN_CONFIRM  rpc.xid == 0x6d90c61d
>  38         11 172.27.30.129 -> 172.27.255.28 NFS 304 V4 Call CLOSE
> StateID: 0x01be  rpc.xid == 0x6e90c61d
>  39         11 172.27.255.28 -> 172.27.30.129 NFS 204 V4 Reply (Call
> In 38) CLOSE  rpc.xid == 0x6e90c61d
>  44         11 172.27.30.129 -> 172.27.255.28 NFS 364 V4 Call OPEN DH:
> 0x272b8d23/.bashrc  rpc.xid == 0x7090c61d
>  45         11 172.27.255.28 -> 172.27.30.129 NFS 432 V4 Reply (Call
> In 44) OPEN StateID: 0x13f2  rpc.xid == 0x7090c61d
>  46         11 172.27.30.129 -> 172.27.255.28 NFS 304 V4 Call CLOSE
> StateID: 0x13f2  rpc.xid == 0x7190c61d
>  47         11 172.27.255.28 -> 172.27.30.129 NFS 204 V4 Reply (Call
> In 46) CLOSE  rpc.xid == 0x7190c61d
>  48         11 172.27.30.129 -> 172.27.255.28 NFS 288 V4 Call ACCESS
> FH: 0xfb7c5154, [Check: RD MD XT XE]  rpc.xid == 0x7290c61d
>  49         11 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 48) ACCESS, [Access Denied: XE], [Allowed: RD MD XT]  rpc.xid ==
> 0x7290c61d
>  50         11 172.27.30.129 -> 172.27.255.28 NFS 364 V4 Call OPEN DH:
> 0x272b8d23/.bashenv  rpc.xid == 0x7390c61d
>  51         11 172.27.255.28 -> 172.27.30.129 NFS 432 V4 Reply (Call
> In 50) OPEN StateID: 0xca9b  rpc.xid == 0x7390c61d
>  52         11 172.27.30.129 -> 172.27.255.28 NFS 304 V4 Call CLOSE
> StateID: 0xca9b  rpc.xid == 0x7490c61d
>  53         11 172.27.255.28 -> 172.27.30.129 NFS 204 V4 Reply (Call
> In 52) CLOSE  rpc.xid == 0x7490c61d
>  55         16 172.27.30.129 -> 172.27.255.28 NFS 372 V4 Call OPEN DH:
> 0x272b8d23/.bash_history  rpc.xid == 0x7590c61d
>  56         16 172.27.255.28 -> 172.27.30.129 NFS 432 V4 Reply (Call
> In 55) OPEN StateID: 0xf3ed  rpc.xid == 0x7590c61d
>  58         16 172.27.30.129 -> 172.27.255.28 NFS 304 V4 Call CLOSE
> StateID: 0xf3ed  rpc.xid == 0x7690c61d
>  59         16 172.27.255.28 -> 172.27.30.129 NFS 204 V4 Reply (Call
> In 58) CLOSE  rpc.xid == 0x7690c61d
>  61         21 172.27.30.129 -> 172.27.255.28 NFS 288 V4 Call ACCESS
> FH: 0xa77c94de, [Check: RD LU MD XT DL]  rpc.xid == 0x7790c61d
>  62         21 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 61) ACCESS, [Allowed: RD LU MD XT DL]  rpc.xid == 0x7790c61d
>  64         21 172.27.30.129 -> 172.27.255.28 NFS 364 V4 Call OPEN DH:
> 0xa77c94de/a.out  rpc.xid == 0x7890c61d
>  65         21 172.27.255.28 -> 172.27.30.129 NFS 432 V4 Reply (Call
> In 64) OPEN StateID: 0xb877  rpc.xid == 0x7890c61d
>  66         21 172.27.30.129 -> 172.27.255.28 NFS 288 V4 Call ACCESS
> FH: 0xbfe01adc, [Check: RD LU MD XT DL]  rpc.xid == 0x7990c61d
>  67         21 172.27.255.28 -> 172.27.30.129 NFS 196 V4 Reply (Call
> In 66) ACCESS, [Allowed: RD LU MD XT DL]  rpc.xid == 0x7990c61d
>  68         21 172.27.30.129 -> 172.27.255.28 NFS 368 V4 Call OPEN DH:
> 0xbfe01adc/m.db  rpc.xid == 0x7a90c61d
>  69         21 172.27.255.28 -> 172.27.30.129 NFS 396 V4 Reply (Call
> In 68) OPEN StateID: 0x8101  rpc.xid == 0x7a90c61d
>  70         21 172.27.30.129 -> 172.27.255.28 NFS 352 V4 Call LOCK FH:
> 0x80589398 Offset: 0 Length: <End of File>  rpc.xid == 0x7b90c61d
>  71         21 172.27.255.28 -> 172.27.30.129 NFS 124 V4 Reply (Call
> In 70) LOCK Status: NFS4ERR_BAD_SEQID  rpc.xid == 0x7b90c61d
>  72         21 172.27.30.129 -> 172.27.255.28 NFS 304 V4 Call CLOSE
> StateID: 0xb877  rpc.xid == 0x7c90c61d
>  73         21 172.27.255.28 -> 172.27.30.129 NFS 204 V4 Reply (Call
> In 72) CLOSE  rpc.xid == 0x7c90c61d
>  74         21 172.27.30.129 -> 172.27.255.28 NFS 304 V4 Call CLOSE
> StateID: 0x8101  rpc.xid == 0x7d90c61d
>  75         21 172.27.255.28 -> 172.27.30.129 NFS 204 V4 Reply (Call
> In 74) CLOSE  rpc.xid == 0x7d90c61d
>
>
>
> >
> > On Wed, Sep 18, 2019 at 9:07 AM Benjamin Coddington <bcodding@redhat.com> wrote:
> > >
>
>
> > > > Is there a better way of tracking sequences other than monitoring the
> > > > network traffic?
> > >
> > > I think that's the best way, right now.  We do have tracepoints for
> > > nfs4 open and close that show the sequence numbers on the client, but
> > > I'm
> > > not sure about how to get that from the server side.  I don't think we
> > > have
> > > seqid for locks in tracepoints.. I could be missing something.  Not only
> > > that, but you might not get tracepoint output showing the sequence
> > > numbers
> > > if you're in an error-handling path.
> > >
> > > If you have a wire capture of the event, you should be able to go
> > > backwards
> > > from the error and figure out what the sequence number on the state
> > > should
> > > be for the operation that received BAD_SEQID by finding the last
> > > sequence-mutating (OPEN,CLOSE,LOCK) operation for that stateid that did
> > > not
> > > return an error.
> > >
> > > Ben
>
>
> Thanks Ben, I'll persist with the network monitoring for now. The
> sequence ids appear do appear to be sequential when it's in error
> state. I don't see it skipping any if that's what the error is
> expecting
>
>
> Client
> ~~~~~
>
> Here is the sequence-id that gets returned as bad:
>
> $ tshark -n -2 -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid
> -R 'nfs.seqid == 0x0000003c && frame.number <= 70'
>  70         21 172.27.30.129 -> 172.27.255.28 NFS 352 V4 Call LOCK FH:
> 0x80589398 Offset: 0 Length: <End of File>  rpc.xid == 0x7b90c61d
>
> prior sequence is the OPEN as expected:
>
> $ tshark -n -2 -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid
> -R 'nfs.seqid == 0x0000003b && frame.number <= 70'
>  68         21 172.27.30.129 -> 172.27.255.28 NFS 368 V4 Call OPEN DH:
> 0xbfe01adc/m.db  rpc.xid == 0x7a90c61d
>
> Server
> ~~~~~
> bad-sequence
>
> $ tshark -n -2 -r server_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid
> -R 'nfs.seqid == 0x0000003c && frame.number <= 70'
>   1         65 172.27.30.129 -> 172.27.255.28 NFS 350 V4 Call (Reply
> In 2) LOCK FH: 0x80589398 Offset: 0 Length: <End of File>  rpc.xid ==
> 0x7b90c61d
>   2         65 172.27.30.129 -> 172.27.255.28 NFS 302 V4 Call (Reply
> In 3) CLOSE StateID: 0xb877  rpc.xid == 0x7c90c61d
>
> prior sequence
>
> $ tshark -n -2 -r server_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid
> -R 'nfs.seqid == 0x0000003b && frame.number <= 70'
>   1         65 172.27.30.129 -> 172.27.255.28 NFS 366 V4 Call (Reply
> In 2) OPEN DH: 0xbfe01adc/m.db  rpc.xid == 0x7a90c61d
>
> if it is indeed Red Hat KB 3354251 then there is greater motivation to
> try a kernel upgrade again. Though just trying to confirm I have not
> hit something new here.
>
> Leon
