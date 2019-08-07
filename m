Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5F850AC
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2019 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbfHGQIo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Aug 2019 12:08:44 -0400
Received: from fieldses.org ([173.255.197.46]:51756 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGQIo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Aug 2019 12:08:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 427683F5; Wed,  7 Aug 2019 12:08:43 -0400 (EDT)
Date:   Wed, 7 Aug 2019 12:08:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190807160843.GD24728@fieldses.org>
References: <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org>
 <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org>
 <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
 <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
 <20190801181158.GC19461@fieldses.org>
 <CAN-5tyEiO=kBQC=pLu_aeVfV+3f3KWFbz_1ooG8qBLoBqFaehQ@mail.gmail.com>
 <20190801193654.GA12211@parsley.fieldses.org>
 <CAN-5tyFSRcnOT5kuF_1iKZDu=KyjEj+3tcq0ARSNOeuSmJMYGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFSRcnOT5kuF_1iKZDu=KyjEj+3tcq0ARSNOeuSmJMYGQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 07, 2019 at 12:02:40PM -0400, Olga Kornievskaia wrote:
> On Thu, Aug 1, 2019 at 3:36 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Thu, Aug 01, 2019 at 02:24:04PM -0400, Olga Kornievskaia wrote:
> > > i was just looking at close_lru and delegation_lru but I guess that's
> > > not a list of delegation or open stateids but rather some complex of
> > > not deleting the stateid right away but moving it to nfs4_ol_stateid
> > > and the list on the nfsd_net. Are you looking for something similar
> > > for the copy_notify state or can I just keep a global list of the
> > > nfs4_client and add and delete of that (not move to the delete later)?
> >
> > A global list seems like it should work if the locking's OK.
> 
> I'm having issues taking a reference on a parent stateid and being
> able to clean it. Let me try to explain.

With other stateid parent relationships I believe what we do is: instead
of the child taking a reference on the parent, we ensure that the child
is destroyed, and that nobody can be holding a pointer to it, before we
destroy the parent.

--b.

> Since I take a reference on the stateid, then during what would have
> been the last put (due to say a close operation), stateid isn't
> released. Now that stateid is sticking around. I personally would have
> liked on what would have been a close and release of the stateid to
> release the copy notify state(s) (which was being done before but
> having a reference makes it hard? i want to count number of copy
> notify states and if then somehow if the num_copies-1 is going to make
> it 0, then decrement by num_copies (and the normal -1) but if it's not
> the last reference then it shouldn't be decremented.
> 
> Now say no fancy logic happens on close so we have these stateids left
> over . What to do on unmount? It will error with err_client_busy since
> there are non-zero copy notify states and only after a lease period it
> will release the resources (when the close of the file should have
> removed any copy notify state)?
> 
> Question: would it be acceptable to do something like this on freeing
> of the parent stateid?
> 
> @@ -896,8 +931,12 @@ static void block_delegations(struct knfsd_fh *fh)
>         might_lock(&clp->cl_lock);
> 
>         if (!refcount_dec_and_lock(&s->sc_count, &clp->cl_lock)) {
> -               wake_up_all(&close_wq);
> -               return;
> +               if (!refcount_sub_and_test_checked(s->sc_cp_list_size,
> +                               &s->sc_count)) {
> +                       refcount_add_checked(s->sc_cp_list_size, &s->sc_count);
> +                       wake_up_all(&close_wq);
> +                       return;
> +               }
>         }
>         idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
>         spin_unlock(&clp->cl_lock);
> 
> then free the copy notify stateids associated with stateid.
> 
> Laundromat would still be checking the copy_notify stateids for
> anything that's been not active for a while (but not closed).
> 
> 
> 
> 
> 
> >
> > --b.
