Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476FDB59A3
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2019 04:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfIRCVH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Sep 2019 22:21:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39445 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIRCVH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Sep 2019 22:21:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so3067140pgi.6
        for <linux-nfs@vger.kernel.org>; Tue, 17 Sep 2019 19:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dug-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6triC5Fu9zKeUNPmjyUPzlj72xemg5GZtiq+baga8Q=;
        b=AnyYReiOyJXwfR/UzTENbGw7Xpl3mxpY9HEA9cYNfR5o5uWOGUrVInxHa5y3BqBF0G
         ySoVHRZ9e1kksVAffLfc8lO7B/NfYQAGW9dvNe92s7w2plzXSsXs8p47166aspyONtfu
         GVGCWpVJuEq/07yFqX+4sRJCi2IXGAUV1c6s29LETy/YcFntorV5LHZ/9G2Y80FPaRwm
         Bl+nFxy0usl1jEuABpAWQ/Ay4VdXm8sci/TWqQh1UEfXpIERdM1sBJccmFS1mHSq7yOQ
         x44ADXWGB9V6Av83O7jh0ASo0qFSzZeZMKKI6MpM1wz69PW/LpaKcljqRRFh0bNGup0a
         vSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6triC5Fu9zKeUNPmjyUPzlj72xemg5GZtiq+baga8Q=;
        b=TmJ6X3oeksQWMzDJTMRTX5n+KzQHJUjqhGu6g0DOtWu4ewV7aOpkfuTpVUxCXqY1VS
         HW36h2DAXwv/FJhUjIbRU0FfwSN6rzv40PykvIE/wktcczDkWCDMW1/ah/3F6wszTb1i
         5oVR1VbccsdI2alzfjdFg9OyEw51+8wkknO3ZUV40QkMx0USZLMTRNzSRI27SthrVIAm
         n3kJ1FrBdQiOkjQtgsnbm+GhvNgpCl0SICDl9za/b0F3+X81emNC4ketAQg+DU4dKzNm
         40H2WK1KZwn9W7GITTipvajm+sS2gbphsKr+BmUEhbpTlUKp0GS0RurCaYEWfbazIhLL
         0veg==
X-Gm-Message-State: APjAAAV192T/R0kFPxCRNg/YklccOx5DWIf9Dj1LDMISC8oZJMsr/6fH
        LpXsl3KFT45cBCIflWSOR3j/gmtmXvP5HqcLLZzWrw==
X-Google-Smtp-Source: APXvYqw78CPET7HqsmbBkkydmypj5JpKSw4ol1KtQp49jZcYMH1WWSc7MZR7MrITO0z12EypCRcV4Lrw9rghPfLjIqg=
X-Received: by 2002:a17:90a:a47:: with SMTP id o65mr1258794pjo.90.1568773265336;
 Tue, 17 Sep 2019 19:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAACwWuN6siyM9t+rCmzxYPCf777bvD_J1xQKwNb7ZzBdzvy42Q@mail.gmail.com>
 <8217416C-F3E5-4BEE-BD01-2BE19952425E@redhat.com>
In-Reply-To: <8217416C-F3E5-4BEE-BD01-2BE19952425E@redhat.com>
From:   Leon Kyneur <leonk@dug.com>
Date:   Wed, 18 Sep 2019 10:20:53 +0800
Message-ID: <CAACwWuMbB=zTaXW-fQmUYHLvx=YgE=68M96=hq201pqn2wKxBw@mail.gmail.com>
Subject: Re: troubleshooting LOCK FH and NFS4ERR_BAD_SEQID
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 17, 2019 at 7:28 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 12 Sep 2019, at 4:27, Leon Kyneur wrote:
>
> > Hi
> >
> > I'm experiencing an issue on NFS 4.0 + 4.1 where we cannot call fcntl
> > locks on any file on the share. The problem goes away if the share is
> > umount && mount (mount -o remount does not resolve the issue)
> >
> > Client:
> > EL 7.4 3.10.0-693.5.2.el7.x86_64 nfs-utils-1.3.0-0.48.el7_4.x86_64
> >
> > Server:
> > EL 7.4 3.10.0-693.5.2.el7.x86_64  nfs-utils-1.3.0-0.48.el7_4.x86_64
> >
> > I can't figure this out but the client reports bad-sequence-id in
> > dupicate in the logs:
> > Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
> > sequence-id error on an unconfirmed sequence ffff881c52286220!
> > Sep 12 02:16:59 client kernel: NFS: v4 server returned a bad
> > sequence-id error on an unconfirmed sequence ffff881c52286220!
> > Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
> > sequence-id error on an unconfirmed sequence ffff8810889cb020!
> > Sep 12 02:17:39 client kernel: NFS: v4 server returned a bad
> > sequence-id error on an unconfirmed sequence ffff8810889cb020!
> > Sep 12 02:17:44 client kernel: NFS: v4 server returned a bad
> > sequence-id error on an unconfirmed sequence ffff881b414b2620!
> >
> > wireshark capture shows only 1 BAD_SEQID reply from the server:
> > $ tshark -r client_broken.pcap -z proto,colinfo,rpc.xid,rpc.xid -z
> > proto,colinfo,nfs.seqid,nfs.seqid -R 'rpc.xid == 0x9990c61d'
> > tshark: -R without -2 is deprecated. For single-pass filtering use -Y.
> > 141         93 172.27.30.129 -> 172.27.255.28 NFS 352 V4 Call LOCK FH:
> > 0x80589398 Offset: 0 Length: <End of File>  nfs.seqid == 0x0000004e
> > nfs.seqid == 0x00000002  rpc.xid == 0x9990c61d
> > 142         93 172.27.255.28 -> 172.27.30.129 NFS 124 V4 Reply (Call
> > In 141) LOCK Status: NFS4ERR_BAD_SEQID  rpc.xid == 0x9990c61d
> >
> > system call I have identified as triggering it is:
> > fcntl(3, F_SETLK, {type=F_RDLCK, whence=SEEK_SET, start=1073741824,
> > len=1}) = -1 EIO (Input/output error)
>
> Can you simplify the trigger into something repeatable?  Can you determine
> if the client or the server has lost track of the sequence?
>

I have tried, I wrote some code to perform the fcntl RDKLCK the same
way and ran it accross
thousands of machines without any success. I am quite sure this is a
symptom of something
not the cause.

Is there a better way of tracking sequences other than monitoring the
network traffic?

> > The server filesystem is ZFS though NFS sharing is turned off via ZFS
> > options and it's exported using /etc/exports / nfsd...
> >
> > The BAD_SEQID error seems to be fairly random, we have over 2000
> > machines connected to the share and it's experienced frequently but
> > randomly accross our clients.
> >
> > It's worth mentioning that the majority of the clients are mounting
> > 4.0 we did try 4.1 everywhere but hit this
> > https://access.redhat.com/solutions/3146191
>
> This was fixed in kernel-3.10.0-735.el7, FWIW..
>
> Ben

Thanks good to know, am planning an update soon but have been stuck on
3.10.0-693 for other reasons.

Leon
