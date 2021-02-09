Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4756315750
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhBIUAf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 15:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233655AbhBITrq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 14:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612899956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07hMrz2JH7QjjSYxmQ6iVqH/nriv3v/7Q+e4rDzWnzs=;
        b=ZWhxl+yIXM3Z5wT5KCTZnFiR5RRe8oTkXb8ZvOuzP0PYT5R/QEcAimqDdcODJYrCNHkPe6
        OGVHa6D8MXqC4+fV5mUKvEw8KeJz/g1vz7UMe+328/ZfGryTCA214HRphBV6tMD6xahxCP
        lMGhWYcZEtf+Sr+e1brkLIzsCVMSF8I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-IWCgKxDiOKC-z4BEP1qAhw-1; Tue, 09 Feb 2021 14:45:53 -0500
X-MC-Unique: IWCgKxDiOKC-z4BEP1qAhw-1
Received: by mail-qt1-f199.google.com with SMTP id v65so12964891qtd.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Feb 2021 11:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=07hMrz2JH7QjjSYxmQ6iVqH/nriv3v/7Q+e4rDzWnzs=;
        b=pB0oGapk4Gn9QxV6A49Y1bh6Wjrge5S1JTKrri6Utt437Ph4qWX40GJBhGKaJmBThS
         0xshuO8hchGufTIidSl7RgYGlMzkPSCh1DLs2OU+6NHf/0ZYZheC0Lis7kzsOyKxf7uh
         wKE2TA67/fI5ozpOat9ViRzSM/GOBnbLjIySDWXxEpkAgUD9ERgGRKFcpCHnuYWjwApk
         eFmTDn/mi4BxPugnEC5ThsUUjFyIRKIR27dcQns0jGAaFctm8CaLBlL+uSWAxdyz1I+w
         qLuHglspx27S2225kDvCVHQ5zViopFEi85Vl/e7gCQmqB4wW0e3ECijbdmWeWuymFvB9
         e9ZA==
X-Gm-Message-State: AOAM532UYkGUq2QoTdBQFxx+cVaWrR983zTikq+ZLalIsfi8fW80lTNF
        lQ5cTS2ry9sA8Zkaa36WljiNjon2eQLHyzHUyyoyBZt1hqPhl7Z0wk5ou8ssUZtXEcbhlAmxBsB
        9hgYsJnnchyKofo5t885e
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr23988263qkb.277.1612899953138;
        Tue, 09 Feb 2021 11:45:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybD7SbuYQXGOXd3mMxVBLEZfaSpNELJGXVWAV5LvAAprhYnJ48OVnrJ8zBSJ4tAUenGug78w==
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr23988232qkb.277.1612899952938;
        Tue, 09 Feb 2021 11:45:52 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id p16sm3234618qtq.24.2021.02.09.11.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:45:52 -0800 (PST)
Message-ID: <c9d5464484dc7013eba9f49e88c19712c1276c31.camel@redhat.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper
 library
From:   Jeff Layton <jlayton@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Feb 2021 14:45:51 -0500
In-Reply-To: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
References: <591237.1612886997@warthog.procyon.org.uk>
         <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2021-02-09 at 11:06 -0800, Linus Torvalds wrote:
> So I'm looking at this early, because I have more time now than I will
> have during the merge window, and honestly, your pull requests have
> been problematic in the past.
> 
> The PG_fscache bit waiting functions are completely crazy. The comment
> about "this will wake up others" is actively wrong, and the waiting
> function looks insane, because you're mixing the two names for
> "fscache" which makes the code look totally incomprehensible. Why
> would we wait for PF_fscache, when PG_private_2 was set? Yes, I know
> why, but the code looks entirely nonsensical.
> 
> So just looking at the support infrastructure changes, I get a big "Hmm".
> 
> But the thing that makes me go "No, I won't pull this", is that it has
> all the same hallmark signs of trouble that I've complained about
> before: I see absolutely zero sign of "this has more developers
> involved".
> 
> There's not a single ack from a VM person for the VM changes. There's
> no sign that this isn't yet another "David Howells went off alone and
> did something that absolutely nobody else cared about".
> 
> See my problem? I need to be convinced that this makes sense outside
> of your world, and it's not yet another thing that will cause problems
> down the line because nobody else really ever used it or cared about
> it until we hit a snag.
> 
>                   Linus
> 

I (and several other developers) have been working with David on this
for the last year or so. Would it help if I gave this on the netfs lib
work and the fscache patches?

    Reviewed-and-tested-by: Jeff Layton <jlayton@redhat.com>

My testing has mainly been with ceph. My main interest is that this
allows us to drop a fairly significant chunk of rather nasty code from
fs/ceph. The netfs read helper infrastructure makes a _lot_ more sense
for a networked filesystem, IMO.

The legacy fscache code has some significant bugs too, and this gives it
a path to making better use of more modern kernel features. It should
also be set up so that filesystems can be converted piecemeal.

I'd really like to see this go in.

Cheers,
Jeff

