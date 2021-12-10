Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76D247075A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Dec 2021 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhLJRhu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 12:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhLJRhu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 12:37:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC5C061746
        for <linux-nfs@vger.kernel.org>; Fri, 10 Dec 2021 09:34:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l25so32592028eda.11
        for <linux-nfs@vger.kernel.org>; Fri, 10 Dec 2021 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QIa6rww9jro5nDJeWJFjVScPd67gpaO9LJRBQi9fOg=;
        b=M3iMr1TySf2JhF71PNm9vqUmHaN3ndNQHG/JvqEwurXQFVAc3WLPhhZJWkmxcv/iii
         e3cwFXBPK/cCe5z8o6p2trgcoV9h7Txs5HiF7R/U4M4BIEHcWNhyWg+ifoYKoycIB0+H
         5wF+CXd7RhgARAEG0l0SAd8Fi9xRrg4j8P6mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QIa6rww9jro5nDJeWJFjVScPd67gpaO9LJRBQi9fOg=;
        b=GfcWeJXbkQIy4dwCqouCcV1MNCcTqq1U2BcbMy0xo8P1KCxQm0Oh/ruZeI0f/BArkJ
         hdUJfxdA3kg/oYUAhWLDSXFPKB2mdcXG9kAj0VppEuRDYv/7R/ju3AQCWIjYjqOSs4aa
         z1UNOVZ2OIT8cw8VNmQ2vuqqqiCrHbQlJRs7wuRMspgI2iNZP+bslsOH5TCN6SEavgM5
         Qp3DkAHylDPMj/mbF7q+19C8jYfNqCYvFhYPM8Oq+7Gmt8VGHYjMsmXEg0ChtQKV/ErW
         mxaU+ngJXskprXHrFNSEmgCPRCx3ISYHjfpTiyRKtFOKiPPETMXEf4FV6IJFJMLZTwIa
         kxPw==
X-Gm-Message-State: AOAM5334ZbdJ2bGrGhUHIpmSs427SBdnNjeOuE21A+70P7FQL/UY/Vsm
        RfWo/YxUPbeyVYvl9kxU5uPc29q5EDtwsdWshAE=
X-Google-Smtp-Source: ABdhPJwrcMFhC6h45Vzenx3HixY6vT/sXmwW4nrnWnmIPOeQAisp0AKrrTn1HvhEf9PsMkJ37C7ZBw==
X-Received: by 2002:a17:907:3e13:: with SMTP id hp19mr24796585ejc.376.1639157653036;
        Fri, 10 Dec 2021 09:34:13 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ho30sm1839204ejc.30.2021.12.10.09.34.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:34:12 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id a9so16127615wrr.8
        for <linux-nfs@vger.kernel.org>; Fri, 10 Dec 2021 09:34:11 -0800 (PST)
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr15464416wrv.442.1639157651522;
 Fri, 10 Dec 2021 09:34:11 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
 <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
 <159180.1639087053@warthog.procyon.org.uk> <CAHk-=whtkzB446+hX0zdLsdcUJsJ=8_-0S1mE_R+YurThfUbLA@mail.gmail.com>
 <288398.1639147280@warthog.procyon.org.uk>
In-Reply-To: <288398.1639147280@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 09:33:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHm-rNkeLXcOt4oV_BMzC5DeZ5FYt+yjbA_GjN2wcd5w@mail.gmail.com>
Message-ID: <CAHk-=wiHm-rNkeLXcOt4oV_BMzC5DeZ5FYt+yjbA_GjN2wcd5w@mail.gmail.com>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 10, 2021 at 6:41 AM David Howells <dhowells@redhat.com> wrote:
>
> However, since the comparator functions are only used to see if they're the
> same or different, the attached change makes them return bool instead, no
> cast or subtraction required.

Ok, thanks, that resolves my worries.

Which is not to say it all works - I obviously only scanned the
patches rather than testing anything.

                Linus
