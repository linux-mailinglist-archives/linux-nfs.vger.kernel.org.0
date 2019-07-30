Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFE7AF39
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfG3RKo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 13:10:44 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45343 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbfG3RKU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 13:10:20 -0400
Received: by mail-vk1-f194.google.com with SMTP id e83so12912919vke.12
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7w3jabGisruvUIuF8lyTl7ouhEetjcBJThcSAhc5qM=;
        b=uf6e8P5DVOms+z+RdFmpOkF867l9fBxYmX8e4nl3TeLuhoSMFUZmNW6dxcZVbboqGM
         /TlH9r9VDMf6zKkRWvFU2Or9yhY9Os0yp74LMyzNXFJa8/TJ9Wv/WfElTNMnVDP22UUj
         zEXHCW7zMe5/txG5M0TZYJnHL6SgVM2CAZ5KkztASe1IMYNDn1IVBG42bXUVK1/Aj7+w
         x9WwBx83PBmpiiBHU0CWAGqTLi2jQiRYR/Sad7H5fHsdh8yPsseJp0Uu0rQ16vfe8QB4
         hFePBKvT14661HGpw6/QUM0v8AQ1dbmjWYfEQEUviRHDSpOSSejyhTEbfVnkB7xmnWw2
         V35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7w3jabGisruvUIuF8lyTl7ouhEetjcBJThcSAhc5qM=;
        b=GGXrmoWCupwXuAUhhYHSvS58h9cI6fESVNO+hSICsIb0nb1wDiMTA/ID3OH4cHXgQ/
         ekz8OpMN+kotfq9v5XyvViWJbzDWET71W70/AVsX1qSuijKraJn/buw3g1AmSN6wIWKX
         NJNuJwahiACCmDz1xADWok6PzY0sUVc+xQow0VbqK+jY8eANEWbiiTlxDrvGTUMNVli2
         /CyxfsOLQTLafSXT5JVs1Gg+HkRb+dUODXbbr77dERjxasocEHAGFFDuy+QuLFzyzy/p
         eoSnz2fKthJ2/G1XIi8TC4Ox6sQy4XpGmnjMHdaZ64HxsROT6NKSeELrwpwkW0acm30U
         RFsg==
X-Gm-Message-State: APjAAAV2t9KbaWc/tL63ihaXWNUee//27yesD536G7/z/SLs/xJ4nVXj
        ZRbmP+PTb9p0uS0b8pCTLM53L4tg9WmhVjY6QtZ+gA==
X-Google-Smtp-Source: APXvYqy3WndQ0pLxR0Fa2Xapv5Q1J8Fl9pDgR9j7kK2KzRjhHPyeQv/xTobUAMLja6Z+QQfVdVGNLk/y0WuSsUbCeXc=
X-Received: by 2002:a1f:4107:: with SMTP id o7mr45077857vka.34.1564506618489;
 Tue, 30 Jul 2019 10:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com> <20190717230726.GA26801@fieldses.org>
 <CAN-5tyHmODP2+nMiinTEP5WZzXz=m=j9LBSWv=b=N3C211JaLg@mail.gmail.com>
 <20190723204537.GA19559@fieldses.org> <CAN-5tyGL+BR+1E1N-HzH3-mmjze8AkBHpYAm0k3i0Dt+iP1ORQ@mail.gmail.com>
 <20190730155528.GE31707@fieldses.org> <CAN-5tyGwyasodrUe4Y+p_Er6XNOBk+mgiaXKXWSBsM5ac4areg@mail.gmail.com>
In-Reply-To: <CAN-5tyGwyasodrUe4Y+p_Er6XNOBk+mgiaXKXWSBsM5ac4areg@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 30 Jul 2019 13:10:07 -0400
Message-ID: <CAN-5tyErgJ6TFLJzmRypmfqObPoA7-LEvFJ0iC4ky=yXyeRBGw@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 30, 2019 at 12:13 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Tue, Jul 30, 2019 at 11:55 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Tue, Jul 30, 2019 at 11:48:27AM -0400, Olga Kornievskaia wrote:
> > > On Tue, Jul 23, 2019 at 4:46 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > > >
> > > > On Mon, Jul 22, 2019 at 04:17:44PM -0400, Olga Kornievskaia wrote:
> > > > > Let me see if I understand your suspicion and ask for guidance how to
> > > > > resolve it as perhaps I'm misusing the function. idr_alloc_cyclic()
> > > > > keeps track of the structure of the 2nd arguments with a value it
> > > > > returns. How do I initiate the structure with the value of the
> > > > > function without knowing the value which can only be returned when I
> > > > > call the function to add it to the list? what you are suggesting is to
> > > > > somehow get the value for the new_id but not associate anything then
> > > > > update the copy structure with that value and then call
> > > > > idr_alloc_cyclic() (or something else) to create that association of
> > > > > the new_id and the structure? I don't know how to do that.
> > > >
> > > > You could move the initialization under the s2s_cp_lock.  But there's
> > > > additional initialization that's done in the caller.
> > >
> > > I still don't understand what you are looking for here and why. I'm
> > > following what the normal stid allocation does.  There is no extra code
> > > there to see if it initiated or not. nfs4_alloc_stid() calls
> > > idr_alloc_cyclic() creates an association between the stid pointer and
> > > at the time uninitialized nfs4_stid structure which is then filled in
> > > with the return of the idr_alloc_cyclic(). That's exactly what the new
> > > code is doing (well accept that i'll change it to store the
> > > stateid_t).
> >
> > Yes, I'm a little worried about normal stid allocation too.  It's got
> > one extra safeguard because of the check for 0 sc_type in the lookup,
> > I haven't yet convinced myself that's enough.
> >
> > The race I'm worried about is: one task does the idr allocation and
> > drops locks.  Before it has the chance to finish initializing the
> > object, a second task looks it up in the idr and does something with it.
> > It sees the not-yet-initialized fields.
>
> Can the spin_lock() that we call before the idr_alloc_cyclic() be held
> thru the initialization of the stid then? I'm just not sure what this
> idr_preload_end() with a spin_lock but otherwise I don't see why we
> can't and since idr_find() takes the same spin lock before the call,
> it would solve the problem.

actually instead moving initialization of other stid fields prior to
calling the idr_alloc_cycle would never expose the un-initialized
value so

stid->..cl_boot = nn->boot_time
stid->.. cl_id = nn->..id
..
spinlock()
newid = idr_alloc_cycle(stid)
stid->..id = newid
unlock()


>
> >
> > --b.
