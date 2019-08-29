Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFCA2737
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2019 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH2TXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Aug 2019 15:23:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40334 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfH2TXz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Aug 2019 15:23:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id i128so3189621vsc.7
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2019 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX7nZAwHLhviw3X+bn/byWo3/tYGyaYnRaK2qp7/2fk=;
        b=KFmONNT1pLqKJPKkk2/8g1QaCduL/jNaAWWekJYRRkuNZpGg1jCbU4YvmwaQQIMWIs
         UzkgeAFYgOGpPtgEXZKy3M+05noxWGKDOe+qxe5nKTK25qYz3TzxRbArOYqt7Mm7GUUS
         qTz+tmoSE6ZxGXTGtt1VoevkubJVIBVL6wtm34vmQ+//3J1Ye5MucT422UgOAQvd8uNy
         EorER+DW+dyf5j1F8cbZdeGe/FRVCHZYViIcYRvu9pToNM8iekHd3Yw0E1tXBK9QKZok
         oL6kLsjchIRbWYX/BfBiCluA6FhkCXxj6A2fe8BwPDTc63pz28gvDMj7W30IA+0jijR2
         tVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX7nZAwHLhviw3X+bn/byWo3/tYGyaYnRaK2qp7/2fk=;
        b=UN5edtMfbYDoDQN4vsUC/cr5/eW78aGfQhruMJ+KmNXsBl78apdPvjSO9BPJb2WM9+
         daKz2ipv62cGiu603GLtWBPimSa/65HOgib1VeQp5j0QEAPBV6jyil1uNd4NESmoF4/G
         M34J9OwXJXX7J7Q2GqOwPFM+P0ZqgN903tcgA0kxM7uq4Ytce6nQCsH5fOfHXbobTi4Y
         FW3BEfM9aFlADNSKqs5Rw9a8OCPQGlYiBE2EnkxW4dV8dE7TMy/Juq2MhaF+NjV8rERo
         sq2x+0GQEXcZDC/3+FqdncFDEAPg/6LlIVKS7ejUCkU1VL00zlfYmj0cbq1GiPe0GBMp
         bahQ==
X-Gm-Message-State: APjAAAWxZCWd7wxaxd5cHnO9hcjy7U+VLmEwfqOng5af6vDSisXnnw2d
        2UP32qCrk+XiPhJTUDYvWKnAvHFtPzpMLzR+OD0=
X-Google-Smtp-Source: APXvYqx4IvfFTFOYF9Z1oldMFyFmPMR4FT5VqJmUqASE9SsMh7Jlu0USu+ulJcrqVCCP88oLVdiJmKryEV8xM3RgQi8=
X-Received: by 2002:a67:10c6:: with SMTP id 189mr6512496vsq.194.1567106634205;
 Thu, 29 Aug 2019 12:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190808201848.36640-6-olga.kornievskaia@gmail.com> <CAN-5tyF6ZMf_jiKycK1rk9v7xATDb=j_e5d0QBp9LOgdvn-utA@mail.gmail.com>
 <CAN-5tyEyvjJB+4_bKZmEYhv2KrVvk7dDvF27i6mx4naDt33Nww@mail.gmail.com>
 <20190812200019.GB29812@parsley.fieldses.org> <CAN-5tyFpHHsH3n8u+qGyp7POdSRHesiKgd3-YQoE9jJSPBVYRw@mail.gmail.com>
 <CAN-5tyEX=4pfntZudpfkN9Pr9OpZfpvKj+NyT-bBD9YJ5fsg7Q@mail.gmail.com>
In-Reply-To: <CAN-5tyEX=4pfntZudpfkN9Pr9OpZfpvKj+NyT-bBD9YJ5fsg7Q@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 29 Aug 2019 15:23:43 -0400
Message-ID: <CAN-5tyHOr+0WVthzu6G9qOwaVG0R+yUpuh2iyaTpBkw_O5XGAA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 14, 2019 at 11:05 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Tue, Aug 13, 2019 at 1:57 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> >
> > On Mon, Aug 12, 2019 at 4:00 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >
> > > On Mon, Aug 12, 2019 at 03:16:47PM -0400, Olga Kornievskaia wrote:
> > > > On Mon, Aug 12, 2019 at 12:19 PM Olga Kornievskaia
> > > > <olga.kornievskaia@gmail.com> wrote:
> > > > > While this passes my testing, in theory this allows for the race that
> > > > > we get the copy notify size but then offload_cancel arrive and change
> > > > > the value. Then refcount_sub_and test_check would have an incorrect
> > > > > value (can subtract larger than an actual reference count). I have no
> > > > > solution for that as there is no refcount_sub_and_lock() that will
> > > > > allow to decrement by a multiple under a lock. Thoughts?
> > > >
> > > > I tried not to use the client's cl_lock but instead use a specific
> > > > lock to protect the copy notifies stateid on the stateid list. But
> > > > since stateid's reference counter (sc_count) is protected by it, I
> > > > think by getting rid of the special lock and using cl_lock will solve
> > > > the problem of coordinating access between the sc_count and the
> > > > copy_notify stateid list. Are the any problems with using such a big
> > > > lock?
> > >
> > > Probably not.  But it can be confusing when a single lock is used for
> > > several different things.  A comment explaining why you need it might
> > > help.
> >
> > While holding the client's cl_lock to manipulate the list of copy
> > notify stateids solves the refcount problem. It generates a different
> > problem for the laundromat thread. There, client list is traversed
> > already holding the cl_lock, so I can't call routines to free
> > copy_notify stateid because in turn it calls nfs4_put_stid() which
> > wants to take the cl_lock. Putting the copy_notify stateid on the
> > reaplist and then I lose a pointer to the client structure that I need
> > to take the lock. Then it seems the nfs4_cpntf_state structure would
> > need to keep a pointer to the client structure but then I get a
> > problem of making sure the nfs4_client structure isn't going away and
> > because it even a bigger mess.
> >
> > I think I need to remove the code in the laundromat that looks for the
> > not referenced copy_notifies stateid and just rely on cleaning on the
> > removal of the stateid (basically what I originally had). Or I need to
> > rely on the client to always send FREE_STATEID. I don't see other
> > options, do you?
>
> Ignore this Bruce. Trond gave me a good idea and gets me unstuck.

Hi Bruce,

I'm stuck again. The idea that Trond gave me is to instead of storing
the pointer to the stateid, (copy) store the stateid_t structure
itself and then use it to look it up the appropriate nfs4_stid.

The problem with that is when nfsd4_lookup_stateid() is called it
takes is a compound state (cstate) which has a client pointer and
during the lookup it's verified that the client looking up the stateid
is the same that generate the stateid which is not the case with copy
offload.

I tried also saving a cl_clientid and using that to lookup the
nfs4_client that's needed for the stateid lookup but I'm not sure
that's possible. lookup_clientid() calls find_client_in_id_table() and
always passes "false" for sessions args. Original client has minor
version 2 and then the check if (clp->minor_versions != sessions)
fails. I don't understand what this logic is suppose to check.

Should I be writing special version of the lookup_clientid that
ignores that check (when called in the path of the copy_notify
verification)? Or any other ideas of how to get passed this would be
appreciated it.

Thank you.


>
> >
> > >
> > > --b.
