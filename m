Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6974C8508C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2019 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHGQCx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Aug 2019 12:02:53 -0400
Received: from mail-vk1-f179.google.com ([209.85.221.179]:43053 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGQCw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Aug 2019 12:02:52 -0400
Received: by mail-vk1-f179.google.com with SMTP id b200so18128165vkf.10
        for <linux-nfs@vger.kernel.org>; Wed, 07 Aug 2019 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBszmlteBVRLK66/tIhFYd2NKWwV40ynlEYx/Scr1rc=;
        b=VjnglCMox2FE49Rs6QirZEvIQOQT8u0Yt2zOT616uFSh6J8oM29mw/oGTp6kzOT/XB
         VwmjWCMLGWcfhiBkuPe/E0zMbE/4bIW5QapoGP8vD2tb/t0ll4yEt2mHwoBCvCem8cHR
         WqVrv6w6ZhxRhXElQt883exzuCOAs7jbZts4/NrQg2mCp99lKTOPl6M79aVABtXVA8ql
         6kmsx/DdesiE0sryfxP3cIqLTKAY4vT3Cqp2WlK4ZYnJqrM2lqMprrxFaB5iQoJ4q91f
         2XJHSbDKTWlrVRXJnO9sEycPeOXy0XfyU4EBuQ6Pm15ON/ebJRFyG7CZ7FwArBYSr5B+
         qAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBszmlteBVRLK66/tIhFYd2NKWwV40ynlEYx/Scr1rc=;
        b=Tvq/ZW+388G26pusaZlxgaX22plRwf8We1tfyIM/JQLDa+6zTWRx03XqqGvEAEVW58
         +qIp8z4Mm7WR7C7NJnKJvlIWRinJL0bq7CSEcllsC5JCebl1HQHuJ0gSkwD1mXdMJRxC
         TM71KCjmEng1PsRHth6FAcYAe98mGQIWb/83uVpds1dRq521wj652BA9H8TVPg4PPNY2
         TlmwAJTD+3kWGTc/MPuizXrs9xs2tuFhoSwDBi+e74k5sEmWcncBMbDeEh/xmDBREZZ1
         MAWD9PUxP2f4bTzpSk5jEBT8LCKSntxGrZYBxorAxy5nJDIzFy1xRBjRWFRF9uZR7yg6
         OprQ==
X-Gm-Message-State: APjAAAUK7qhjbnC7UyvvUXxQgqWrAok08TwAxmbQKkSzIKEdeNtV3xAc
        xGqyHlN/a/oaDOuFRo5OwB9X58tOcAwD6EohfELLXdom
X-Google-Smtp-Source: APXvYqz0wH9uEvzmVqItw027ax0JYTK+1XVz4hG09cV9t3z42l0u1z5cRkWfK4/tloEOcykL1mYf8rCd0mex6IKoA8o=
X-Received: by 2002:a1f:5285:: with SMTP id g127mr801781vkb.83.1565193771702;
 Wed, 07 Aug 2019 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190723205846.GB19559@fieldses.org> <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org> <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org> <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
 <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
 <20190801181158.GC19461@fieldses.org> <CAN-5tyEiO=kBQC=pLu_aeVfV+3f3KWFbz_1ooG8qBLoBqFaehQ@mail.gmail.com>
 <20190801193654.GA12211@parsley.fieldses.org>
In-Reply-To: <20190801193654.GA12211@parsley.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 7 Aug 2019 12:02:40 -0400
Message-ID: <CAN-5tyFSRcnOT5kuF_1iKZDu=KyjEj+3tcq0ARSNOeuSmJMYGQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 1, 2019 at 3:36 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Thu, Aug 01, 2019 at 02:24:04PM -0400, Olga Kornievskaia wrote:
> > i was just looking at close_lru and delegation_lru but I guess that's
> > not a list of delegation or open stateids but rather some complex of
> > not deleting the stateid right away but moving it to nfs4_ol_stateid
> > and the list on the nfsd_net. Are you looking for something similar
> > for the copy_notify state or can I just keep a global list of the
> > nfs4_client and add and delete of that (not move to the delete later)?
>
> A global list seems like it should work if the locking's OK.

I'm having issues taking a reference on a parent stateid and being
able to clean it. Let me try to explain.

Since I take a reference on the stateid, then during what would have
been the last put (due to say a close operation), stateid isn't
released. Now that stateid is sticking around. I personally would have
liked on what would have been a close and release of the stateid to
release the copy notify state(s) (which was being done before but
having a reference makes it hard? i want to count number of copy
notify states and if then somehow if the num_copies-1 is going to make
it 0, then decrement by num_copies (and the normal -1) but if it's not
the last reference then it shouldn't be decremented.

Now say no fancy logic happens on close so we have these stateids left
over . What to do on unmount? It will error with err_client_busy since
there are non-zero copy notify states and only after a lease period it
will release the resources (when the close of the file should have
removed any copy notify state)?

Question: would it be acceptable to do something like this on freeing
of the parent stateid?

@@ -896,8 +931,12 @@ static void block_delegations(struct knfsd_fh *fh)
        might_lock(&clp->cl_lock);

        if (!refcount_dec_and_lock(&s->sc_count, &clp->cl_lock)) {
-               wake_up_all(&close_wq);
-               return;
+               if (!refcount_sub_and_test_checked(s->sc_cp_list_size,
+                               &s->sc_count)) {
+                       refcount_add_checked(s->sc_cp_list_size, &s->sc_count);
+                       wake_up_all(&close_wq);
+                       return;
+               }
        }
        idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
        spin_unlock(&clp->cl_lock);

then free the copy notify stateids associated with stateid.

Laundromat would still be checking the copy_notify stateids for
anything that's been not active for a while (but not closed).





>
> --b.
