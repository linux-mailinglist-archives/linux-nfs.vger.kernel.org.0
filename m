Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D613159C3
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBIWz1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 17:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhBIW1n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 17:27:43 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D574DC061225
        for <linux-nfs@vger.kernel.org>; Tue,  9 Feb 2021 13:27:18 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a25so100033ljn.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Feb 2021 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NXrj70SaJJJRtMQWC0+3w4cmGywCfZjtndBL9rb8Bo=;
        b=g8n7RWB/hph+MNS6KsfC0GffC4feoLtbwfzXkMDO5VGlvyK682yT02RPRIOW6hieUR
         nxG1Mlzbyp5mtI1Do4dwBB4pr2NfNtLSNxuXGIfX+Az+7iAT6uxAH+/kuEuPZoNDiHrT
         JX8A9+J4I4DIw7KDC1ACDk8XTP+nwuXWBZL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NXrj70SaJJJRtMQWC0+3w4cmGywCfZjtndBL9rb8Bo=;
        b=m6bpadRk96R4GcMMj6UPx3ysGKDdqyp6LqE3x50NWzSxyZLSheKMMLymyC9Uo4bXIs
         3C0paAjE156RkO2YzdzFHLhzthzSvNqUjcoCGnyDtkkjMrk3LS4EHZ66LGOVGTVwyJhE
         dozod/zbbq03MnSIDelAhMjcUtigklM2raIDX6XwkpbFs1X4iQVw1R821Sukr3Wbhy44
         UroeYJfo8dyRCszwp+iV9A4y0bySueq1aT8s0WNRX7CCU92V0f48Gu1/E77y1G6JUeKx
         1CXU/XUF1/KvRXhets8vXl0vOM+s05PJUb2bdIDmkhtNRGdDZhk6SS6qT7ff4YSGh/2p
         T7gQ==
X-Gm-Message-State: AOAM533maNFz9GzUGXpT5Wf0qWCkS/+NvJDfl3AoHuGlyM51mq/kkDV7
        vn2p/e+UXJNgV0Kk9R2T99b9dnUvChHhvw==
X-Google-Smtp-Source: ABdhPJz9Csl7PwOZh/I1hupbSnHHa+EGmC7BKOC/J6VJoovrhhco8mUVyVmjg/41E6LNL0ZS5IzHig==
X-Received: by 2002:a2e:145d:: with SMTP id 29mr15526830lju.391.1612906037034;
        Tue, 09 Feb 2021 13:27:17 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y10sm2693270lji.107.2021.02.09.13.27.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 13:27:16 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id f23so13528085lfk.9
        for <linux-nfs@vger.kernel.org>; Tue, 09 Feb 2021 13:27:16 -0800 (PST)
X-Received: by 2002:a2e:b1c8:: with SMTP id e8mr15253931lja.251.1612905557284;
 Tue, 09 Feb 2021 13:19:17 -0800 (PST)
MIME-Version: 1.0
References: <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <20210209202134.GA308988@casper.infradead.org>
In-Reply-To: <20210209202134.GA308988@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 13:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
Message-ID: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
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

On Tue, Feb 9, 2021 at 12:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Yeah, I have trouble with the private2 vs fscache bit too.  I've been
> trying to persuade David that he doesn't actually need an fscache
> bit at all; he can just increment the page's refcount to prevent it
> from being freed while he writes data to the cache.

Does the code not hold a refcount already?

Honestly, the fact that writeback doesn't take a refcount, and then
has magic "if writeback is set, don't free" code in other parts of the
VM layer has been a problem already, when the wakeup ended up
"leaking" from a previous page to a new allocation.

I very much hope the fscache bit does not make similar mistakes,
because the rest of the VM will _not_ have special "if fscache is set,
then we won't do X" the way we do for writeback.

So I think the fscache code needs to hold a refcount regardless, and
that the fscache bit is set the page has to have a reference.

So what are the current lifetime rules for the fscache bit?

             Linus
