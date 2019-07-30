Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3106D7AD51
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfG3QN6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 12:13:58 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37707 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3QN6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 12:13:58 -0400
Received: by mail-ua1-f65.google.com with SMTP id z13so25666342uaa.4
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwsxCIP3ChjSj4G1blx6VuHaJUxOLS3Jz3z+6271bLA=;
        b=XfQuDU8disUdiX5tsPDl/LmyZr9AbSoun3stZA2lV+2MAUzwfdFxD6gpzbUQRX3w4y
         mlCain3qUkbSG5eHqD9fw4Xcsgc7q4xQWrnpxW3zRMx2DqaSy8Qz5QCALPrxOX1SroJJ
         DxtZxkp3KX/hVWtNY1KQjaianh5p8Cz2p1ifNEoZk7DHOAKHee7N83R9jGbfCfTdhTVT
         5SBGvPxWgL1+/RuRQb2sefak34W46KQheQWk7WkGZFzNbCjUgcK1VMWfZcCV1MI8SLh/
         T/vgOmk8k67YV+KeHS2kiOPW26u4wHqE00ohMRDfikG2BaBGA7nx+ql+3xnpV0hnBleP
         YCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwsxCIP3ChjSj4G1blx6VuHaJUxOLS3Jz3z+6271bLA=;
        b=t7Z1gZoF5UEe5f9ujklw5ll5U+2LkAt7qletT0wsp4qQrpVz5fmicfrX6H7JX+uxdD
         HFeEVPO/i7dmrIaBFvhPEzcuj6Ym+4GqDULsfA2+2cwlzOdw9kiLzhcNwgS3dJ00vCqx
         hin13bS6II8TM/JohbqjYvwI2Q0oKjQE9qIy6AX81enQJ910ymbP8Snah0dmt0OpQ0Mw
         jaiF7DE3BRGh2YnIuMzLxhHG1/a5vT+P0cvN3Fpd4vNKVqrw5ftn0EeN2gWIDH7regf1
         WH9JOPEMnSOTJjdagv7q/MxtkqrRp2ZJVNJ/MCVaFlgoZit1uxWHwNWI+7z59YUCXiVE
         9gzQ==
X-Gm-Message-State: APjAAAURSVkFF+11mjFUcpxMRBFvtXnBWfGxHUFz+4pBwIC8FGZToGrE
        qORwJohbRSamxI1JSfMaIQdbo27Qk1qXKeJx6sX3Iw==
X-Google-Smtp-Source: APXvYqxQoVWk3Zlv9oypf6bZ09hhTP0enxto/Xx2H8VlCaxki6MHK9Exv8rxvBwkfy62D2hjqxrL4r6qoa0J8mrNvNY=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr22978758uam.81.1564503237096;
 Tue, 30 Jul 2019 09:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com> <20190717230726.GA26801@fieldses.org>
 <CAN-5tyHmODP2+nMiinTEP5WZzXz=m=j9LBSWv=b=N3C211JaLg@mail.gmail.com>
 <20190723204537.GA19559@fieldses.org> <CAN-5tyGL+BR+1E1N-HzH3-mmjze8AkBHpYAm0k3i0Dt+iP1ORQ@mail.gmail.com>
 <20190730155528.GE31707@fieldses.org>
In-Reply-To: <20190730155528.GE31707@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 30 Jul 2019 12:13:46 -0400
Message-ID: <CAN-5tyGwyasodrUe4Y+p_Er6XNOBk+mgiaXKXWSBsM5ac4areg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 30, 2019 at 11:55 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Jul 30, 2019 at 11:48:27AM -0400, Olga Kornievskaia wrote:
> > On Tue, Jul 23, 2019 at 4:46 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Jul 22, 2019 at 04:17:44PM -0400, Olga Kornievskaia wrote:
> > > > Let me see if I understand your suspicion and ask for guidance how to
> > > > resolve it as perhaps I'm misusing the function. idr_alloc_cyclic()
> > > > keeps track of the structure of the 2nd arguments with a value it
> > > > returns. How do I initiate the structure with the value of the
> > > > function without knowing the value which can only be returned when I
> > > > call the function to add it to the list? what you are suggesting is to
> > > > somehow get the value for the new_id but not associate anything then
> > > > update the copy structure with that value and then call
> > > > idr_alloc_cyclic() (or something else) to create that association of
> > > > the new_id and the structure? I don't know how to do that.
> > >
> > > You could move the initialization under the s2s_cp_lock.  But there's
> > > additional initialization that's done in the caller.
> >
> > I still don't understand what you are looking for here and why. I'm
> > following what the normal stid allocation does.  There is no extra code
> > there to see if it initiated or not. nfs4_alloc_stid() calls
> > idr_alloc_cyclic() creates an association between the stid pointer and
> > at the time uninitialized nfs4_stid structure which is then filled in
> > with the return of the idr_alloc_cyclic(). That's exactly what the new
> > code is doing (well accept that i'll change it to store the
> > stateid_t).
>
> Yes, I'm a little worried about normal stid allocation too.  It's got
> one extra safeguard because of the check for 0 sc_type in the lookup,
> I haven't yet convinced myself that's enough.
>
> The race I'm worried about is: one task does the idr allocation and
> drops locks.  Before it has the chance to finish initializing the
> object, a second task looks it up in the idr and does something with it.
> It sees the not-yet-initialized fields.

Can the spin_lock() that we call before the idr_alloc_cyclic() be held
thru the initialization of the stid then? I'm just not sure what this
idr_preload_end() with a spin_lock but otherwise I don't see why we
can't and since idr_find() takes the same spin lock before the call,
it would solve the problem.

>
> --b.
