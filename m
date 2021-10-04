Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379BB421441
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhJDQkn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhJDQkk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Oct 2021 12:40:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDEEC061745
        for <linux-nfs@vger.kernel.org>; Mon,  4 Oct 2021 09:38:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y26so74566865lfa.11
        for <linux-nfs@vger.kernel.org>; Mon, 04 Oct 2021 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nD/CqNzR9E4HGpSddngZ7NQXINMID609Z0nuYAzxVQ=;
        b=EhHEBOBGv3jAdd0eEwTEevENTAb2AhyLvwesYd92iZLWqj7mTTdpBBgs4KL47AQ0oH
         ZwglecIE1krknfq1btMK26sMK70sIco+nuL8EtgDkDN9ePohB2tzfYyBZi//yhabNZMZ
         QP2aeujeABcZR46+NAT9doCWdbaRbYrX5zVHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nD/CqNzR9E4HGpSddngZ7NQXINMID609Z0nuYAzxVQ=;
        b=1atIopWCp9Of+78nciw8rZWYe/td558YJHD8QPGSiBMf50ZlNVOu+wQB8Mqg/uQpHk
         Y70OQrFtj7VDfvVigcVoD6ubarpwKd6jPWct5ZSXLFPCer8mV2zlZooOYtQs6HK/y+Qc
         eNFzmO7DP4TNk/12dz5jxbFIsp5W4yerHIO2w5bWIWDpnWXjo2JhuezsKHkobEtJXrPn
         3hEzi5bJ+ArOh1UjqqK/SMC5PHBejArFDQB+65e1aG5kiPx3WxUCkHIMMG+CpKCh5C4t
         bybHZYoFzCw7htSI183rt9jURX81ktsifHaro0CK1Uw1wfoEjyyY1KjnuXs5UH1XHf0E
         6I4Q==
X-Gm-Message-State: AOAM533xTp91c3KLMLdPorL2z/tmBp/wl9Ez2nH4lMGx1xei66+3uqi+
        qOAIepD3XrsZgeX6XYT7l+AaeyWNeZu7/KMy
X-Google-Smtp-Source: ABdhPJxvvRKPY4J04FtSijFvcJwtI7IepZ8ZKUn53oR2ESApsPVEMLne6TJ36EWie+2oPcukdgEOTA==
X-Received: by 2002:a2e:a22b:: with SMTP id i11mr1727761ljm.289.1633365529271;
        Mon, 04 Oct 2021 09:38:49 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c1sm832682ljr.111.2021.10.04.09.38.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g41so73976395lfv.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr16602800ljd.56.1633365528411;
 Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <270324.1633342386@warthog.procyon.org.uk>
In-Reply-To: <270324.1633342386@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Oct 2021 09:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ANpwDnAJ0HAdbwyti7Z6aBBJT6JEbkta9VjaF30Tcw@mail.gmail.com>
Message-ID: <CAHk-=wj-ANpwDnAJ0HAdbwyti7Z6aBBJT6JEbkta9VjaF30Tcw@mail.gmail.com>
Subject: Re: Do you want warning quashing patches at this point in the cycle?
To:     David Howells <dhowells@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 4, 2021 at 3:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Do you want patches that quash warnings from W=1

For W=1? No.

The kerneldoc ones might be ok, but actual code fixes have
historically been problematic because W=1 sometimes warns for
perfectly good code (and then people "fix" it to not warn, and
introduce actual bugs).

           Linus
