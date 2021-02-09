Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844583156B1
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 20:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhBITTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 14:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhBITIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 14:08:02 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11654C06121D
        for <linux-nfs@vger.kernel.org>; Tue,  9 Feb 2021 11:07:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s18so23857517ljg.7
        for <linux-nfs@vger.kernel.org>; Tue, 09 Feb 2021 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tHDrQ7k7QBExa6hxOU6qMztojmSPjc893LQ4fde7dg=;
        b=akIN38EhQAi1EJYSeLBzpY86D4HcP1JFpL9GOZ+0RTnCkorkEfcVrIAVKTL3jMnG1S
         wB2qolfwaFv21H7u2zEEkvnFpGX1nEHeJ1S4J1sfz5c5YnXEdHBQ4kH64G0jT9/l9/e6
         eD4OPnbfiSTjG9KsSbeEkIcjaKRrzYZYK/x80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tHDrQ7k7QBExa6hxOU6qMztojmSPjc893LQ4fde7dg=;
        b=n4kYC4yy1Od1IQUbQneJtpU/Y2XWbG09zMRRWCVKXABWzher9XG8B7o2IWR/29M3nX
         fN1YikvKpVLQ/bsEJJGMnS5k0RsZ95fL4zuVe9mxKWDIZU0SoqGRqRtyxd00uz54QbXJ
         OapMnQZ097oBj7VzGRmjgTYKY72edrjsXV4gzz2/Jti5GcjYZU8btI6nzvD83XCPCzgP
         ds4yiwF/qwGImPLus/BBFb5ZThHL4FM3FqNbNS/7VZWPvAKmNj2pe8nPNn+X+zqM7juS
         0kdlIMCJu9FoRSC5TKWKnkdeX7QLh/5m+tq4sD6e5Ak5gLqIwhuECAeRZuqQlX/eTlCv
         OngA==
X-Gm-Message-State: AOAM531LK34V0ZrQ6X/xYP44WnoB0mMuFJaMB68WYEbMr4jsK1W8rLBE
        p/Ucr/Tv1w8xOOjrX3rDjIZn8U/W7/nWQA==
X-Google-Smtp-Source: ABdhPJyMjz8oYFXhB5BBno2avtubhF1WG8+BNIqELYpUwFAlwbFTUplCTte2Ux1nseoRDQMdjQ116w==
X-Received: by 2002:a2e:9055:: with SMTP id n21mr15713082ljg.377.1612897618696;
        Tue, 09 Feb 2021 11:06:58 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u23sm362489lfo.22.2021.02.09.11.06.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:06:57 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id f1so30076526lfu.3
        for <linux-nfs@vger.kernel.org>; Tue, 09 Feb 2021 11:06:57 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr13646015lff.201.1612897616810;
 Tue, 09 Feb 2021 11:06:56 -0800 (PST)
MIME-Version: 1.0
References: <591237.1612886997@warthog.procyon.org.uk>
In-Reply-To: <591237.1612886997@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 11:06:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
Message-ID: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

So I'm looking at this early, because I have more time now than I will
have during the merge window, and honestly, your pull requests have
been problematic in the past.

The PG_fscache bit waiting functions are completely crazy. The comment
about "this will wake up others" is actively wrong, and the waiting
function looks insane, because you're mixing the two names for
"fscache" which makes the code look totally incomprehensible. Why
would we wait for PF_fscache, when PG_private_2 was set? Yes, I know
why, but the code looks entirely nonsensical.

So just looking at the support infrastructure changes, I get a big "Hmm".

But the thing that makes me go "No, I won't pull this", is that it has
all the same hallmark signs of trouble that I've complained about
before: I see absolutely zero sign of "this has more developers
involved".

There's not a single ack from a VM person for the VM changes. There's
no sign that this isn't yet another "David Howells went off alone and
did something that absolutely nobody else cared about".

See my problem? I need to be convinced that this makes sense outside
of your world, and it's not yet another thing that will cause problems
down the line because nobody else really ever used it or cared about
it until we hit a snag.

                  Linus
