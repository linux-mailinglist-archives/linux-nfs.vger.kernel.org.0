Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2431FB6628
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2019 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIROcZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Sep 2019 10:32:25 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33077 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfIROcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Sep 2019 10:32:25 -0400
Received: by mail-ua1-f67.google.com with SMTP id u31so2412734uah.0
        for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2019 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaVAwtCASSEd7QPomlIIpQJEaEu/lRxVzzZy3ohNUAI=;
        b=dFz2Zv/TTpBtcx56L7VAABZHiJVAKRAVfVJAVKCABMGImnPWShHKeZdiQkIOZTfK8N
         SRypz5F9j00sJWaRzmIG5mIy5DLDToT8sDrUIpD2YKmzohR+kUtRHlls4wErtm57RGzt
         hyubEoOdwxZhNSlScToNsT3GysCOvsIrl56kMGXHHmb7mt/sOJNDEvPF3PJKsAT6kkH6
         Hu4UFoezXYQZaYq5mFYu3OobGMyb1RjoaHq5wGhEZtWq4kcWkkhbB93pOIfvBPTcnozl
         0M0yE/RfsYRG68JTm44+/clzRke37pERMfivvi/kDRuY/A3tUEVAKmbThPze6kQZUz9c
         SWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaVAwtCASSEd7QPomlIIpQJEaEu/lRxVzzZy3ohNUAI=;
        b=MZRClM/or1OntJadRm1zZVwNf/1G8bEBkHMjtOj67yKSOV9V7dMPAEG/mrmJ2aCyiO
         RgmAxWmFtTy85rRcDcdvyrupOjd34tq6yxkzgrZDNNqq+5DmIGWdgCeOxL6sb7fnl0Fo
         jWnpdhW3x9KFLnBr25EAHEqYK1fZQ32XUORNJ89MqchmKyD6lzPvsy3tBe4mI3vf/YbU
         YQGnoUHrROZTYMbR9VLeKynHh9HbwmwkJIJKUGZus4iTfnVEdafRzylbgxnbY6ZkjR7r
         xrggJDcPn8RpeYQKaCVe+URB9FAgwcNK/Fy0kj9HKkqscWuFe/8hyKsVGedj6tqi8X7T
         4xmA==
X-Gm-Message-State: APjAAAXhUDREfkb8Tr/G4NUWXWnfajFhNPy+Ov9xI5WM3YTzCls04Xsj
        hl6smYzCqYXkw4w3ayUHu2INaADPUNYGpT1fZCg=
X-Google-Smtp-Source: APXvYqxBhudoGte8PkQ4YyofHCXKvH+3+5V8ndAvWNU6+oHYlTQ/ZadCXF5Bp1zSFltZgBbM6e1EcliJTqJfc/jwPk4=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr1479926uap.40.1568817144118;
 Wed, 18 Sep 2019 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAACwWuN6siyM9t+rCmzxYPCf777bvD_J1xQKwNb7ZzBdzvy42Q@mail.gmail.com>
 <8217416C-F3E5-4BEE-BD01-2BE19952425E@redhat.com> <CAACwWuMbB=zTaXW-fQmUYHLvx=YgE=68M96=hq201pqn2wKxBw@mail.gmail.com>
 <66D00B9D-16DC-4979-8400-457398DC4801@redhat.com>
In-Reply-To: <66D00B9D-16DC-4979-8400-457398DC4801@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Sep 2019 10:32:13 -0400
Message-ID: <CAN-5tyERg5kwcD2iugwPVCLDSog0ufKoRRVbC-7pQW-hqLWncQ@mail.gmail.com>
Subject: Re: troubleshooting LOCK FH and NFS4ERR_BAD_SEQID
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Leon Kyneur <leonk@dug.com>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

The bad_seqid error could have been the bug in 7.4
https://access.redhat.com/solutions/3354251. It's been fixed in
kernel-3.10.0-693.23.1.el7. Can you try to update and see if that
helps? The bug was client was sending a double close throwing off the
seqid use.

On Wed, Sep 18, 2019 at 9:07 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 17 Sep 2019, at 22:20, Leon Kyneur wrote:
>
> > On Tue, Sep 17, 2019 at 7:28 PM Benjamin Coddington
> > <bcodding@redhat.com> wrote:
> >>
> >> On 12 Sep 2019, at 4:27, Leon Kyneur wrote:
> >>
> >>> Hi
> >>>
> >>> I'm experiencing an issue on NFS 4.0 + 4.1 where we cannot call
> >>> fcntl
> >>> locks on any file on the share. The problem goes away if the share
> >>> is
> >>> umount && mount (mount -o remount does not resolve the issue)
> >>>
> >>> Client:
> >>> EL 7.4 3.10.0-693.5.2.el7.x86_64 nfs-utils-1.3.0-0.48.el7_4.x86_64
> >>>
> >>> Server:
> >>> EL 7.4 3.10.0-693.5.2.el7.x86_64  nfs-utils-1.3.0-0.48.el7_4.x86_64
> >>>
> >>> I can't figure this out but the client reports bad-sequence-id in
> >>> dupicate in the logs:
> >>> Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
> >>> sequence-id error on an unconfirmed sequence ffff881c52286220!
> >>> Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
> >>> sequence-id error on an unconfirmed sequence ffff881c52286220!
> >>> Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
> >>> sequence-id error on an unconfirmed sequence ffff8810889cb020!
> >>> Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
> >>> sequence-id error on an unconfirmed sequence ffff8810889cb020!
> >>> Sep 12 02:17:44 client kernel: NFS: v4 server returned a bad
> >>> sequence-id error on an unconfirmed sequence ffff881b414b2620!
> >>>
> >>> wireshark capture shows only 1 BAD_SEQID reply from the server:
> >>> $ tshark -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid -z
> >>> proto,colinfo,nfs.seqid,nfs.seqid -R 'rpc.xid == 0x9990c61d'
> >>> tshark: -R without -2 is deprecated. For single-pass filtering use
> >>> -Y.
> >>> 141         93 172.27.30.129 -> 172.27.255.28 NFS 352 V4 Call LOCK
> >>> FH:
> >>> 0x80589398 Offset: 0 Length: <End of File>  nfs.seqid == 0x0000004e
> >>> nfs.seqid == 0x00000002  rpc.xid == 0x9990c61d
> >>> 142         93 172.27.255.28 -> 172.27.30.129 NFS 124 V4 Reply (Call
> >>> In 141) LOCK Status: NFS4ERR_BAD_SEQID  rpc.xid == 0x9990c61d
> >>>
> >>> system call I have identified as triggering it is:
> >>> fcntl(3, F_SETLK, {type=F_RDLCK, whence=SEEK_SET, start=1073741824,
> >>> len=1}) = -1 EIO (Input/output error)
> >>
> >> Can you simplify the trigger into something repeatable?  Can you
> >> determine
> >> if the client or the server has lost track of the sequence?
> >>
> >
> > I have tried, I wrote some code to perform the fcntl RDKLCK the same
> > way and ran it accross
> > thousands of machines without any success. I am quite sure this is a
> > symptom of something
> > not the cause.
> >
> > Is there a better way of tracking sequences other than monitoring the
> > network traffic?
>
> I think that's the best way, right now.  We do have tracepoints for
> nfs4 open and close that show the sequence numbers on the client, but
> I'm
> not sure about how to get that from the server side.  I don't think we
> have
> seqid for locks in tracepoints.. I could be missing something.  Not only
> that, but you might not get tracepoint output showing the sequence
> numbers
> if you're in an error-handling path.
>
> If you have a wire capture of the event, you should be able to go
> backwards
> from the error and figure out what the sequence number on the state
> should
> be for the operation that received BAD_SEQID by finding the last
> sequence-mutating (OPEN,CLOSE,LOCK) operation for that stateid that did
> not
> return an error.
>
> Ben
