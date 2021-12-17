Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1433D478C65
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 14:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhLQNej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 08:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234307AbhLQNei (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 08:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639748078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/4V3fSn58a1gWnecg4Vr8ZqaKf1a0EGk12hvBWCTkM=;
        b=bQFKbefwUZRi7ZvmpqruxJ5vhyyhdfdCz9MVaAlaQ9SjoJ8kGAEasvwhKx0LRhHFvo77Ju
        vN/9mRzl8LFibP2iZOVLgkS+zfgLuRcij79u4iRHhXWQt/JQZfkrwgFOkAxa80ivG9Fo38
        ilHe7D35xcR5X7Zwgrilb8Yk7umF8Vk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-OPXqg972Nw60dcste79H5A-1; Fri, 17 Dec 2021 08:34:37 -0500
X-MC-Unique: OPXqg972Nw60dcste79H5A-1
Received: by mail-ed1-f71.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so1950603edw.6
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 05:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/4V3fSn58a1gWnecg4Vr8ZqaKf1a0EGk12hvBWCTkM=;
        b=ePijp0klLkbd7J2+Jdm9LiyBdwfGIxjvHnMIjxhdphBDQu54PIebZCZtvXGsoRKyJC
         fJxwVwubjRbnPxhSsrjVabWkBhXGLQKjdGLrfO+KbEYB2rCfLDZcVpH6sJhxPd7mBJQi
         60NMDnxT0xLlMeEfUrhx4zb2zpeKJsEkuVeS3pNc2Cm2cffXrY90OqfEzs5RF2Wb95/z
         qsBJHjbcyEGpl3lPQB2wfFCUiZIkTLVJlTgN+Pp3iE9lqvi494yxEvKqFnlmIBgwiuyy
         dcvQzwhagM7qrt3aCbZoWVd68kzRqJNbEQn8RolS7Xjbx/1aksDETIqOK8hK3ayvoPSo
         nMkw==
X-Gm-Message-State: AOAM533iSzbd80k5ihJiBw05ASp32mtcRuR13PEr+Qh0bdLVhau3UGfN
        9rpaTmavdPGAcmlSa2gaORP1uD1JNmIyk3Tz1IzHs582vukY7QLNpkRFuC7RdLmlVg5PJG33YMZ
        AHvZm3ddD+U2tNxO5cT0fbiC3f6xIXO2wcFHy
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr2717198ejs.540.1639748075941;
        Fri, 17 Dec 2021 05:34:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfCuAPtEgHBTr7q3MGwDVaFX/Fg0EWtDvOdr4UgrWss0B7EdpNUGmjSmVfPvodIYtapCLIGbKSCqQwhQUojqQ=
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr2717185ejs.540.1639748075730;
 Fri, 17 Dec 2021 05:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20211217113507.76f852f2@canb.auug.org.au> <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com>
 <1957083.1639746671@warthog.procyon.org.uk>
In-Reply-To: <1957083.1639746671@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Dec 2021 08:33:59 -0500
Message-ID: <CALF+zOnZ4v7DaZ6ymh28MPeeDYDLg06mWKxhB0xOVE2P8LGZ+w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the fscache tree
To:     David Howells <dhowells@redhat.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 8:11 AM David Howells <dhowells@redhat.com> wrote:
>
> David Wysochanski <dwysocha@redhat.com> wrote:
>
> > Anna, feel free to drop these from your tree to avoid the conflicts
> > with the rest of your tree and dhowells fscache-rewrite patchset.
>
> Would it help to take some bits through my tree?  (Or, at least, alter my NFS
> patches)
>

I think so.  If Anna is ok with it, she can drop them from her tree.
And I'm looking at these 7 patches to see which ones make sense on top
of your tree (the v3 patches you just sent).

Mainly my patches were cleanups, plus converting from dfprintk to tracepoints.
Some patches may no longer be needed.
As one example, this may be better done with tracepoints inside
__fscache_use_cookie and __fscache_unuse_cookie

3b779545aa01 ("NFS: Convert NFS fscache enable/disable dfprintks to
tracepoints")

