Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3171D40B48B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhINQZp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINQZn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 12:25:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A46C061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:24:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y6so25038202lje.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uU34i+EgJe3tqn17AWoGwVGTTIh0KVlY0SraTTmp6T0=;
        b=VZdty0cyn24mKo+cOeBnS1zUwWEVr/Aq14PaZvBBUD6vKS7TpA6mbyHIis/pVaXAaf
         SJ1YKxtYZYsZj/EY0JHr31tuvOq/g1o7mjxt6H1zfFHVSNCDSLB6nO1xycpBsN8+GLla
         CROAP4iHjqNA3Dw+oLPHZ225XyXcBn1WLfKpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU34i+EgJe3tqn17AWoGwVGTTIh0KVlY0SraTTmp6T0=;
        b=14TXa/XCAAUl1jcRjVzFaG+rpU6ExmY2MnOrW2NfzM/hvgq2crtqnO+LeA5mCVBOLn
         sryjVWoOk/iAS+2LQsNBITVfPFY384nSZOxvsuZfsWDLNlZsjlfQCdewLdn/dJ1kIBqS
         Gx7ac4dIgiwiBhBnBNvrfze1B3ns2Sdpxoaw06QrXqm/AZ2ZaxfkyOvsCfE7z0jyYWvk
         BgX2gL5mK1NpAdmeQDDlgExDWeaMIb2MMJvcNb6SQWgKytKbB7U+yumBbX1ul7EGHkkw
         9pEoKDm8plnCx4N+WZxzouGK+OFQC0kTLTcd9RB8XlMfdn2k0lqHCxmRauRI02DLdKor
         s0UA==
X-Gm-Message-State: AOAM530X3GckMWMUJNMwNzUov4QBtAvQsoViwXN5Io7VVtlOsJOfcrph
        Lkv0YlWCVHS9aC0zaOQIx0G4+qUZUG0LdX+zLv8=
X-Google-Smtp-Source: ABdhPJw9jCr7gHXOQlKWvF2EM5kRuUvqezW9/NtsuYSy2dQEowgQQVoSxoo/Z0jSsUYXu8dTFzK2Cw==
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr16041509ljo.288.1631636662955;
        Tue, 14 Sep 2021 09:24:22 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id b17sm1382453ljj.35.2021.09.14.09.24.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:24:22 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id g14so24984350ljk.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:24:21 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr15485756ljm.95.1631636661566;
 Tue, 14 Sep 2021 09:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
 <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
In-Reply-To: <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 09:24:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgR_unCDRZ+8iTb5gBO6bgRkuS4JYBpi25v12Yp6TzWVA@mail.gmail.com>
Message-ID: <CAHk-=wgR_unCDRZ+8iTb5gBO6bgRkuS4JYBpi25v12Yp6TzWVA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 14, 2021 at 9:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Call it "fallback" or "simple" or something that shows the intent, but
> no, I'm not taking patches that introduce a _new_ interface and call
> it "deprecated".

Put another way: to call something "deprecated", you have to already
have the replacement all ready to go.

And if you have that, then converting existing code to a deprecated
model isn't the way to go.

So in neither situation does it make any sense to convert anything to
a model that is deprecated.

          Linus
