Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99305C409D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 21:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfJATD6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 15:03:58 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39677 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJATD6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Oct 2019 15:03:58 -0400
Received: by mail-vs1-f68.google.com with SMTP id y129so9170271vsc.6
        for <linux-nfs@vger.kernel.org>; Tue, 01 Oct 2019 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Mo9BmYq6PusAxUMZDU/ZicWCa+6ALiBOufzA+jkON0=;
        b=GJNy237gEMbtSgl1Au0YHFaQ+bL3/hBmEdAb58ynN+D6uigXwi3OrHwDdngVoZJDay
         aUWCLchbP4WTXBSdhSw0zxliCaqEdS8G7Ah8vklwBZrnrtltT0C0H9yh7C6f4syF1J/Q
         ENOiXRkOpXAIeruVDgSFB/jvkMYxt+t0PRmGwLouqeimbEfmFMEb2oMdD9pMpwFXzuv1
         8vKmt8WA7itfMxsxQwZBdQLP2hm4WG5UfFU+rKMwXorheEXTAdM+tSHvY19kjhzKOryA
         /x3JKr/jvJZoe+/AHRBwg7oRr3+Q8GNul9OlF3C4aOLfh78NsnEXWpO9iHunHwl0noSr
         Uong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Mo9BmYq6PusAxUMZDU/ZicWCa+6ALiBOufzA+jkON0=;
        b=EAcdihOC+GpGZgw+XHhqxCCFgj7au+KLgnATIRbJVmveq/E3mobMMopDxf7uAbpASH
         E8DhiTXHiN/s8k4MRnQYWam3l7z5Oj33oZtrWDTpaggr6duHOOT4DNCB4p4kCiX4zk/O
         iZE0y19ZofdXKiIHLtPldB8ia+Db7/rtF+PGXaWe/MqUdUDl+vlVYmzeWWYBaKQXjQKo
         OUJuRopxEWpmvupnf9Af8n4o9qOPlofyLj0rwzzpeHtRM30u6zPwsHOYEdxCL9zOBYUv
         7w/E3G3QG9Ptd4UN2VOr2Y1L2mo6UOZ2GUH2jSrqNODc9LEsqS5eDi16azfSz6IviGa4
         mgIg==
X-Gm-Message-State: APjAAAWulWG+PrKN7w3OeMJCjx2tFGGC+6T+5220yG1it+egmYI9GudZ
        Jsvf7SxAtWqEu97T7O08316FlZfjX9QEx1AAIklmuw==
X-Google-Smtp-Source: APXvYqxBDqCNR9LQBSOFZ/v59Sm1MbWOGgJHFPQlGKej18t4WqEHltasvkGY2/LG33V8S71NYFwojRNRNzl862HsM8w=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr4328473vso.215.1569956637252;
 Tue, 01 Oct 2019 12:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHGq=4AiMuST1kqkZWOfijvuR3bUNChL+KaNnUN900cdA@mail.gmail.com>
 <20191001171355.GA2372@fieldses.org> <CAN-5tyHRKu-pYAvhW0f+t4SoDs1iMCuu4JiBaNFnZmUXso4wag@mail.gmail.com>
 <20191001175031.GA3099@pick.fieldses.org>
In-Reply-To: <20191001175031.GA3099@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 1 Oct 2019 15:03:46 -0400
Message-ID: <CAN-5tyGTTeCH-mWzT+STu=CrLPWL2Oo8611Loj866Ga7RnZS2w@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] client and server support for "inter" SSC copy
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 1, 2019 at 1:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Tue, Oct 01, 2019 at 01:47:22PM -0400, Olga Kornievskaia wrote:
> > On Tue, Oct 1, 2019 at 1:13 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Sep 30, 2019 at 03:06:11PM -0400, Olga Kornievskaia wrote:
> > > > Have you had a chance to take a look at the new patch series and have
> > > > any more comments?
> > >
> > > Honestly, last time I checked I was having trouble finding things to
> > > complain about--it looked OK to me.
> > >
> > > But I'm not sure I understood the management of copy id's, should I
> > > should give it one more read.  And then agree on how to merge it.
> >
> > Let me know what you would like to discuss about how copy ids are
> > managed on the server. I thought that cover letter plus commit
> > descriptions talk about how copy stateids and copy_notify states are
> > managed. Do you want me to cut and paste that together here? Yes I did
> > skip putting the same summary in v7 as I did in earlier submissions.
>
> You did fine, I just need to read it carefully and make sure I
> understand.

Ok.

> > > I was thinking maybe you could give us a git branch based on 5.5-rc1 or
> > > 5.5-rc2, Trond (I think it's Trond this time?) could pull the client
> > > ones into his tree, and I could pull the rest into mine.
> >
> > I do have git space on linux-nfs so I could put my patches there.
> > However, I'm confused about the ask to be based on 5.5-rc1 as we are
> > still on 5.4-rc.
>
> Whoops, sorry, just a typo, I meant 5.4-rc.

Ok.  I have them in git://git.linux-nfs.org/projects/aglo/linux.git
linux-ssc-for-5.5 branch.
>
> --b.
