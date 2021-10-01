Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A267841EFB3
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354578AbhJAOkm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353844AbhJAOkm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 10:40:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483EC061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 07:38:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m3so39173019lfu.2
        for <linux-nfs@vger.kernel.org>; Fri, 01 Oct 2021 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sNoVWGy8i8D8VfNL3h31SQmyj0ARCRvO5EUltIW+aw=;
        b=g9TKQOL72tfUf1/v4I8uxUp+GoRn8DJgw4DZBI9dd/5N0HmmYI67fVwxsygA4KJl1F
         mv0d5LZ/ihjNi0PxTs0xPm2Ew+vA/5thjDpVF0fEGOk05LPsTAEg/ZbtJzUOp2N5zXej
         /mFbeO3j9M+WZddeS5dyRI8zyaCqPDsgKyrgkMFGMti/SDKVWM9/GXt4rqxkd9mJ4k+h
         1caH/+Vy0H98q/JxNSP9HTaXadJYHtEXJvEXoQSF/tdjQW+qcIHKbdeWWjsgWrkH1n6A
         VaM6ZAhegT6cI2TQyM1KNSTitX3pmeL/JqIEwWdgE7pXHJQ/T0wWmrHCI9k9FqB4pcbk
         Z5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sNoVWGy8i8D8VfNL3h31SQmyj0ARCRvO5EUltIW+aw=;
        b=OSiZ1k+lPgGoqzzTjONbzK+AasGCGEaycpUATqWiDYp78H003neamR7XBNzEPZ8LCL
         +CNeLjS+3uemfd7LfJv/lB5q1ImxMdala+yP2GPzEx18xQlCNuguKhFp9rajefCAAshQ
         wBjuL+8WlkmiOGd21X5kTRryflZ0qAY4ChNCG4u+rIVT1q9v9RYWdTg1tocCGcC1qGks
         NxzphP4jc+zhjEdcqPYoJ14S0Hb4Lmzgc64a2f7UG/CZhqZZK7qalGrvO5329egnNm8J
         qENfGkk83vSYUPw5dug/AHUnFSjQYWhvs8Pz1j3gDmWZxrb1fRKJ8CI3SKmpDsIlrFpL
         N1dQ==
X-Gm-Message-State: AOAM530i0MeLuMXE/ljZOzclQTd9xFgLRlxQo1j4Au0NJ68BNrD7D0NQ
        OJWqebLqInKcjY5+9Ywl15SaRqQZYruFT7AYAQfxtl4NwYY/Ig==
X-Google-Smtp-Source: ABdhPJyLCzPqvZH47bUkxc8K4s87c1Jj2/lZ5l+4Z4QitvIJXUFNdpu38FAV3T0tdGopuz3TZ7DuEwyp1DyKcC8sBhs=
X-Received: by 2002:ac2:5e24:: with SMTP id o4mr5706014lfg.522.1633099136144;
 Fri, 01 Oct 2021 07:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org> <CANkgweuuo7VctNLNSGyVE2Unjv_RMdG7+zPYr6_QwSZAQTbPRQ@mail.gmail.com>
 <20211001141306.GD959@fieldses.org>
In-Reply-To: <20211001141306.GD959@fieldses.org>
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Fri, 1 Oct 2021 17:38:45 +0300
Message-ID: <CANkgwevJURTVNcs8u3KS_jiZwxQZgGHX=YmU+kvbweQ0PLBHiA@mail.gmail.com>
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> The seq_num field can start at any value below MAXSEQ
Yes, that's the statement I haven't found before in RFC...
Probably we also need to write a test starting the seq_num from a big
value (more than SEQUENCE_WINDOW)
to make sure that it is really implemented properly without
'is_inited' flag (so what's the initial value?).

However I still propose to keep the default behaviour of pynfs to be
the same as for linux NFS4 client.
I think the caller can change it when needed (to 0 or whatever
needed), but the default value should be good...

volodymyr.

On Fri, Oct 1, 2021 at 5:13 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Oct 01, 2021 at 09:49:50AM +0300, Volodymyr Khomenko wrote:
> > > So, I can verify that --security=krb5 works after this patch but not
> > > before, good.  But why is that?  As you say, the server is supposed to
> > > ignore the sequence number on context creation requests.  And 0 is valid
> > > sequence number as far as I know.
> >
> > By design of RPCGSS we have a 'last seen seq_number' counter on the
> > server side per each GSS context
> > and we must not accept any packet that was already seen before (we
> > also have a bitmask of several last requests for this).
> > This 'last seen counter' is unsigned int32 (the same as seq_num) so we
> > can't just init it to -1 so next seq_num=0 will be valid.
> > The most obvious implementation is to init it last_seen_seq_num to 0
> > so the very 1st packet after NFS4 NULL must be 1 to differ from last
> > seen seq_number.
>
> Note in theory gssapi mechanisms can require multiple round trips (in
> the GSS_PROC_CONTINUE_INIT case), so this wouldn't actually avoid
> duplicate sequence numbers.
>
> In any case, the rfc is unambiguous here: "In a creation request, the
> seq_num and service fields are undefined and both must be ignored by the
> server."
>
> > A better implementation (theoretically) can set this counter to
> > 'undefined' state by additional flag, but this is  more
> > resource-consuming
> > (you need to process is_inited flag + last_seen_seq_num instead of
> > just one counter).
> > If the last seen seq_number is undefined during GSS initialization,
> > then strictly speaking we can send ANY seq_num for the very 1st
> > request after NFS4 NULL.
>
> Right, again, from RFC 2203, " The seq_num field can start at any value
> below MAXSEQ."
>
> It can be implemented without the need for an is_inited flag.
>
> The initial sequence number of 0 really did find an actual bug in the
> server, so pynfs is definitely doing its job in this case!
>
> --b.
