Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655058C009
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2019 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHMR5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Aug 2019 13:57:51 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41281 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfHMR5v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Aug 2019 13:57:51 -0400
Received: by mail-ua1-f65.google.com with SMTP id 34so4078854uar.8
        for <linux-nfs@vger.kernel.org>; Tue, 13 Aug 2019 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpQND1XZHIiUZfGMF+NRG/FaA+qhdUEGMoPArempL90=;
        b=TAv8kzA8KIJl3z7uoFAX8gZZwNv9b4+MuZ38c8GpkQ79zEJHi0r87MxOw/0mM6FHdC
         LtY8zWjJvSIjHUI0/CN3oicxW5YGqQTc9EgNRS99bSAS1knOK68HAY+IlK2K4SNnFqR5
         xTT3uBsz6UJQAC+XXeeSWdJidQDTQbcpiXKd66xwdGeyWGn6LC7DfbB+qF7ioG8cVUxA
         qwmhTONxrCJnFB0qeablYQgIACfrMovnvXjsh7IPMQ+kjgRNvFgG4arwEk7n/GpAtUHf
         G+LBi2KlvR9yzxePuLQCsQzeqF2DYdnx3lnYtkv60ijo/qq9qfJqS3PWM9F9kBLxHNPP
         XbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpQND1XZHIiUZfGMF+NRG/FaA+qhdUEGMoPArempL90=;
        b=K/duuAAbGe3nBw2H9loDbuqgUGsoc6ZGEY+LcxcigETDaFknNZyCt/oYdoogQylaW9
         /w0hywnue6WiwNCKj0AYijp1EaSKwmggrVw0olOt0/37W5KeiLmEuB3x6BmI8MZQtLl6
         HdmvkTKQA3pIjD3rlJnXrJHJ+NEFznvgsRpkdyY/P/bPHTGUG3VY6y5ZMuO8zJ0bcUub
         s9YH8tsm1SB0EvDrpAcQrubDa/PqWpqHbFtc5NKod12vDXSPwsHvkIkQ4vFWckgjmE6H
         Iuu7FtAsQXAqthCUPNEOEnGJO16YgVz5YYuYqsgOaLp0lcoTwGhHXIRBSRVL5g/1z6nW
         JeCA==
X-Gm-Message-State: APjAAAUcQO1NyPoJR6HUHTsReXb3Ra29L/sn3fPDRW1L8LH5JVG5h1ke
        k76agyV6J9j5SSoGc7ZX9ewyi5ZHWClJclRIGO+UQsfi
X-Google-Smtp-Source: APXvYqzC+TJR0PJ9Koh5rEPa/ylpgRMhqwXFcYehwIG7udT3QzGPTG05XSx4TgH2CxUHL3nNhOj0CJQLy0T14xD3zyI=
X-Received: by 2002:a9f:2e0e:: with SMTP id t14mr25088798uaj.119.1565719070733;
 Tue, 13 Aug 2019 10:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190808201848.36640-6-olga.kornievskaia@gmail.com> <CAN-5tyF6ZMf_jiKycK1rk9v7xATDb=j_e5d0QBp9LOgdvn-utA@mail.gmail.com>
 <CAN-5tyEyvjJB+4_bKZmEYhv2KrVvk7dDvF27i6mx4naDt33Nww@mail.gmail.com> <20190812200019.GB29812@parsley.fieldses.org>
In-Reply-To: <20190812200019.GB29812@parsley.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 13 Aug 2019 13:57:39 -0400
Message-ID: <CAN-5tyFpHHsH3n8u+qGyp7POdSRHesiKgd3-YQoE9jJSPBVYRw@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 12, 2019 at 4:00 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Mon, Aug 12, 2019 at 03:16:47PM -0400, Olga Kornievskaia wrote:
> > On Mon, Aug 12, 2019 at 12:19 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > > While this passes my testing, in theory this allows for the race that
> > > we get the copy notify size but then offload_cancel arrive and change
> > > the value. Then refcount_sub_and test_check would have an incorrect
> > > value (can subtract larger than an actual reference count). I have no
> > > solution for that as there is no refcount_sub_and_lock() that will
> > > allow to decrement by a multiple under a lock. Thoughts?
> >
> > I tried not to use the client's cl_lock but instead use a specific
> > lock to protect the copy notifies stateid on the stateid list. But
> > since stateid's reference counter (sc_count) is protected by it, I
> > think by getting rid of the special lock and using cl_lock will solve
> > the problem of coordinating access between the sc_count and the
> > copy_notify stateid list. Are the any problems with using such a big
> > lock?
>
> Probably not.  But it can be confusing when a single lock is used for
> several different things.  A comment explaining why you need it might
> help.

While holding the client's cl_lock to manipulate the list of copy
notify stateids solves the refcount problem. It generates a different
problem for the laundromat thread. There, client list is traversed
already holding the cl_lock, so I can't call routines to free
copy_notify stateid because in turn it calls nfs4_put_stid() which
wants to take the cl_lock. Putting the copy_notify stateid on the
reaplist and then I lose a pointer to the client structure that I need
to take the lock. Then it seems the nfs4_cpntf_state structure would
need to keep a pointer to the client structure but then I get a
problem of making sure the nfs4_client structure isn't going away and
because it even a bigger mess.

I think I need to remove the code in the laundromat that looks for the
not referenced copy_notifies stateid and just rely on cleaning on the
removal of the stateid (basically what I originally had). Or I need to
rely on the client to always send FREE_STATEID. I don't see other
options, do you?

>
> --b.
