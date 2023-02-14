Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2576971E0
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 00:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBNXfO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 14 Feb 2023 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBNXfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 18:35:13 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF13B30E97
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 15:34:49 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id o42so9407045qvo.13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 15:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyp/hQMx4jKPEQUseSA4tZHL1RxxMZjjWESP4JR98S8=;
        b=7X8QEsLAjb4gNVqgAr7Rt0ilOg5Cj/9rV340o1TnmYYRgF47FQrppyuc1wYzKGiu9R
         VVHJwNStx08xZAtV7Bg5hJFdlVQK/bX1+ApVaRMFYyMsnJx5s86hkclEUoqaUCoRPVN9
         KmZ/yBvr/DVrFvpH2EiZSp8PC9yccFHGJCa7rrH0KZQdGos68gG8gOYWww0ClIrP5EHQ
         sEyJcnyAHksu847lgE2XsKUf/OLbzC8fJHjaPVBC7ma9jTw5qp3pWr/QudUP/7dGxkSY
         WohUTe2cy2208zR6Gg0FFgSS2jRlkG6C1MNFmsSxTJrtHtdoUfmi3f44L+BgME/xpEFg
         oRKA==
X-Gm-Message-State: AO0yUKVo6UKxRAmngtVoA1363oJi9BM38a95GORo8uVR/+GaX20uShsh
        SM1flK85XyF68yIrMPdcuJVe1t7xUg==
X-Google-Smtp-Source: AK7set/hEwCIPP3lJlP0zkH8N0JHD/vmyKQajjEsCu/bytayIAr9gpm+9ipiUvFJYey3xaBhoonkBw==
X-Received: by 2002:a05:6214:5012:b0:56e:a274:e512 with SMTP id jo18-20020a056214501200b0056ea274e512mr636683qvb.28.1676417688229;
        Tue, 14 Feb 2023 15:34:48 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id 63-20020a370842000000b006f9f714cb6asm12525931qki.50.2023.02.14.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:34:47 -0800 (PST)
Message-ID: <813f86d8b2a6788728e1c1b8648fce4cda3c36f1.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: simplify write verifier handling
From:   Trond Myklebust <trondmy@kernel.org>
To:     Rick Macklem <rick.macklem@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, willy@infradead.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 14 Feb 2023 18:34:46 -0500
In-Reply-To: <CAM5tNy71pXhzf4wA+KuhF6kCOYspzpfNa8HR=d1XM=G_gng9dQ@mail.gmail.com>
References: <20230213211345.385005-1-jlayton@kernel.org>
         <20230213211345.385005-4-jlayton@kernel.org>
         <CAM5tNy56at7gvUBbc1T7ay=NZQ08qOaAxdux2ZB70sZdb3L0xw@mail.gmail.com>
         <5e19458b1eba1dc4c187d14ec0c74547acb6a2a2.camel@kernel.org>
         <bd23b795b30c5640a8c7ebbe98cee048cc4022be.camel@kernel.org>
         <CAM5tNy71pXhzf4wA+KuhF6kCOYspzpfNa8HR=d1XM=G_gng9dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 14:57 -0800, Rick Macklem wrote:
> On Tue, Feb 14, 2023 at 5:53 AM Jeff Layton <jlayton@kernel.org>
> wrote:
> > 
> > On Mon, 2023-02-13 at 22:28 -0500, Trond Myklebust wrote:
> > > On Mon, 2023-02-13 at 16:49 -0800, Rick Macklem wrote:
> > > > On Mon, Feb 13, 2023 at 1:14 PM Jeff Layton
> > > > <jlayton@kernel.org>
> > > > wrote:
> > > > > 
> > > > > CAUTION: This email originated from outside of the University
> > > > > of
> > > > > Guelph. Do not click links or open attachments unless you
> > > > > recognize
> > > > > the sender and know the content is safe. If in doubt, forward
> > > > > suspicious emails to IThelp@uoguelph.ca
> > > > > 
> > > > > 
> > > > > The write verifier exists to tell the client when the server
> > > > > may
> > > > > have
> > > > > forgotten some unstable writes. The typical way that this
> > > > > happens
> > > > > is if
> > > > > the server crashes, but we've also extended nfsd to change it
> > > > > when
> > > > > there
> > > > > are writeback errors as well.
> > > > > 
> > > > > The way it works today though, we call something like
> > > > > vfs_fsync
> > > > > (e.g.
> > > > > for a COMMIT call) and if we get back an error, we'll reset
> > > > > the
> > > > > write
> > > > > verifier.
> > > > > 
> > > > > This is non-optimal for a couple of reasons:
> > > > > 
> > > > > 1/ There could be significant delay between an error being
> > > > > recorded and the reset. It would be ideal if the write
> > > > > verifier
> > > > > were to
> > > > > change as soon as the error was recorded.
> > > > > 
> > > > > 2/ It's a bit of a waste, in that if we get a writeback error
> > > > > on a
> > > > > single inode, we'll end up resetting the write verifier for
> > > > > everything,
> > > > > even on inodes that may be fine (e.g. on a completely
> > > > > separate fs).
> > > > > 
> > > > Here's the snippet from RFC8881:
> > > >    The final portion of the result is the field writeverf. 
> > > > This
> > > > field
> > > >    is the write verifier and is a cookie that the client can
> > > > use to
> > > >    determine whether a server has changed instance state (e.g.,
> > > > server
> > > >    restart) between a call to WRITE and a subsequent call to
> > > > either
> > > >    WRITE or COMMIT.  This cookie MUST be unchanged during a
> > > > single
> > > >    instance of the NFSv4.1 server and MUST be unique between
> > > > instances
> > > >    of the NFSv4.1 server.  If the cookie changes, then the
> > > > client
> > > > MUST
> > > >    assume that any data written with an UNSTABLE4 value for
> > > > committed
> > > >    and an old writeverf in the reply has been lost and will
> > > > need to
> > > > be
> > > >    recovered.
> > > > 
> > > > I've always interpreted the writeverf as "per-server" and not 
> > > > "per-
> > > > file".
> > > > Although I'll admit the above does not make that crystal clear,
> > > > it
> > > > does make
> > > > it clear that the writeverf applies to a "server instance" and
> > > > not a
> > > > file or
> > > > file system on the server.
> > > > 
> > > > The FreeBSD client assumes it is "per-server" and re-writes all
> > > > uncommitted
> > > > writes for the server, not just ones for the file (or file
> > > > system)
> > > > the
> > > > writeverf is
> > > > replied with.  (I vaguely recall Solaris does the same?)
> > > > 
> > > > At the very least, I think you should run this past the IETF
> > > > working
> > > > group
> > > > (nfsv4@ietf.org) to see what they say w.r.t. the writeverf
> > > > being
> > > > "per-file" vs
> > > > "per-server".
> > > > 
> > > 
> > > As I recall, we've already had this discussion on the IETF NFSv4
> > > working group mailing list:
> > > https://mailarchive.ietf.org/arch/msg/nfsv4/99Ow2muMylXKWd9lzi9_BX2LJDY/
> > > 
> > > 
> > > That's why I kept it a global in the first place.
> > > 
> > > Now note that RFC8881 does also clarify in Section 18.3.3 that:
> > > 
> > > 
> > >    The server must vary the value of the write
> > >    verifier at each server event or instantiation that may lead
> > > to a
> > >    loss of uncommitted data.  Most commonly this occurs when the
> > > server
> > >    is restarted; however, other events at the server may result
> > > in
> > >    uncommitted data loss as well.
> > > 
> > > So I feel it is quite OK to use the verifier the way we do now in
> > > order
> > > to signify that a fatal write error has occurred and that clients
> > > must
> > > resend any data that was uncommitted.
> > > 
> > 
> > Thanks, I missed that discussion. I think you guys have convinced
> > me
> > that we have to keep this per-server. I won't bother starting a new
> > thread on it.
> > 
> > It's a pity. It would have been a lot more elegant as a per-inode
> > thing!
> > 
> If you think it is worth the effort, you could propose an extension
> to
> 4.2. Something like Write_plus, Commit_plus operations.
> 
> rick
> 
OK. Apparently some further clarification is required here.

The main reason for needing to bump the boot verifier on an error is
NFSv3. Unlike NFSv4, the NFSv3 clients are stateless, and so error
propagation using Jeff's "errseq" mechanism is inherently flawed
because it is ultimately caching the I/O errors in a file descriptor.
The fact that the file cache garbage collector can close these NFSv3
file descriptors at any time without any possibility of coordination
with the clients, and causing loss of the "errseq" cached data, means
that we must have an alternative mechanism to propagate error state for
unstable writes. Hence the use of the boot verifier.

NFSv4 does not have these limitations. The clients are required to use
stateful OPEN/CLOSE/DELEGRETURN/... operations in order to signify to
the NFSv4 server when file descriptors need to be kept open, and hence
"errseq" data needs to be preserved. The only cases where that
assumption is violated are that of a network partition and server
reboot, where it is obvious to all parties that information has been
lost.
Note: The Linux NFSv4 client does not currently assume that information
might be lost during network partition, so we might want to look into
fixing that. However it does obviously recover safely during a server
reboot thanks to the boot verifier mechanism.

IOW: there should be no need for a change in NFSv4 semantics in order
to address this issue. The problem is, as usual, mostly limited to
NFSv3.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


