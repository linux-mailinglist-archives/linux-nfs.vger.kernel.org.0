Return-Path: <linux-nfs+bounces-9319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8EA13F82
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72DC188D799
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962041C6A;
	Thu, 16 Jan 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcXwGtc4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C826AE4
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045091; cv=none; b=ZSnef2XDRfoy79kpiXC6W8oa+66ewp/oqs7dDFXmTiyjj6tgoGRUEY14uKfziibQEvgFckJIWrnNPac+95PMnBfPcLNDDuq6meL6YEz4DvW6c0T8wY19O+Li3f+M7cUk7PEzdufSQtAKPCYqZUkQjkEhW3oc6o9jFDTezT+8sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045091; c=relaxed/simple;
	bh=0o9FnbXedyvO1VGBNlLd75bZ12kQ8ZoC1OFKIUhY3iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIcZq/KALjH8WepREJGNE1TINKAMyYu6o+oTUBU/bAePOd0fj/4NLjGeVnS/+G7mVGjioj7DcgSXMBt/jHxdPhy99QEzShUeodAZxFOThF+jRdNf/uLqxXY3clRpMhBmsOTTGVXHHXcPjnlsSz2UxGtKJ/yMxPlVKuklV507L9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcXwGtc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737045088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDdUOcZmYALt3VM45eWY1kydhQIlm+CJxwTbbHEfqKM=;
	b=gcXwGtc432P3kQJBiSV2xKOyCJfOrhBUZbCmwxO763JY4mDKy2AhhUayqbUxqDqgQ4t3pE
	GtFiicfq6Vfx+kgCEsqomhjDewHHVM0ASA688aEM6mdtxAJyk2HTq3ID9Wqk+xgf2dwdV2
	bBrSqsSJQ+K4u8don2wlJxbtjL+6t8I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-MW3m78PZPXCMuY7WHxMQ5Q-1; Thu, 16 Jan 2025 11:31:27 -0500
X-MC-Unique: MW3m78PZPXCMuY7WHxMQ5Q-1
X-Mimecast-MFC-AGG-ID: MW3m78PZPXCMuY7WHxMQ5Q
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d90a59999aso1267556a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 08:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737045086; x=1737649886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDdUOcZmYALt3VM45eWY1kydhQIlm+CJxwTbbHEfqKM=;
        b=fJKKyDgVGij/6xi00JB4YoWh/ywW8O/bZoHuDoTVuUGx2FeyNd3USXy3ZRuqHc3FFW
         KL6d8+nDknsYHESMZrVYLTyI1Nu9A0th+0nwvrJOiIy0n0zzleBHxkwc/mDFj3QWUtgC
         rkZPyDyNASRq0pJTnMNxfKOVGjzgCZf6VKGu5RciGC8PkE+/KAFy+CZH1B4JA+g8ZcY7
         CZ7HCfpofuXsG07ytynySBtgBs/XeX8b8ennp/d/cySWokYBbdQwKB6Z0twssJxwer3K
         dIyqh/nQICl1ZI+92phtc1Dn3SZfggdTI4N/lYd/iUTK+jOvzViv5ocrN8V2yhPSxbsy
         DqhA==
X-Forwarded-Encrypted: i=1; AJvYcCWBy+2HI7ebmovtj1uP9jvl8yTR+nA3MvNeOUNawNCh2fztNSI1YZ6h1lTbRS78StY5vvg+aylsd74=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTdGbNYa8c1niLlsgOakh6lOumYZ7gfMZoUdeenegGwmzP9VH
	9z9EbPk5qFtRTd0FV7bLgk9GN7K1Z/lMUoKHpQN3JY2RnfG+49CCgnHVLozLPhezjskWHgQd2jN
	MBwrRplsGIv2sq3f1DD61+N2zGUHHt9WR3it+W381rQ55maPemErekc/zRJB28ypSOx/p6Fv8kN
	1+VuRLgxQs22ozOTi1ASn5v7rWXs5bGifA
X-Gm-Gg: ASbGncuPkObOMdcCuMatD77CRbxiyjE9AYlHD2eOiIYtfxE5JNE1Pb7IyJ/iQnQ478E
	bxbzPAMLU1yg75yn8L5rPo+TIWh8ZGba24fsn3Ao5kozKSuIeVJsDaL5VOjvdO3vz8leZ6DIB
X-Received: by 2002:a05:6402:430c:b0:5d3:e45d:ba7c with SMTP id 4fb4d7f45d1cf-5d972e7148bmr30673042a12.29.1737045085686;
        Thu, 16 Jan 2025 08:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmTN+PwyIWquGs7sPEh99V582rqupxtgVWMS0juqLP85NkzGp0PuV7MH02Iv10g9LPQoYj6XiKtUq9IEzuUyo=
X-Received: by 2002:a05:6402:430c:b0:5d3:e45d:ba7c with SMTP id
 4fb4d7f45d1cf-5d972e7148bmr30672991a12.29.1737045085156; Thu, 16 Jan 2025
 08:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115232406.44815-1-okorniev@redhat.com> <20250115232406.44815-2-okorniev@redhat.com>
 <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com> <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
 <f2c87e35-2ce4-455b-bd1b-e567123b368f@oracle.com> <9757da07ce21d1c1275c637ae49cbe69a9c83a71.camel@kernel.org>
 <b4b38fc9-3a0a-4324-b7c9-5e080ef492a6@oracle.com>
In-Reply-To: <b4b38fc9-3a0a-4324-b7c9-5e080ef492a6@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 16 Jan 2025 11:31:14 -0500
X-Gm-Features: AbW1kvbGYyGH564rovxM9SWoSq7VPP1fKRUCGKDhkFCiIgaycpt9ijWtuOead9Q
Message-ID: <CACSpFtB-uLB0kTvggQ6KvEMQe7xKP04SkzaAfcadQkFsMBtgQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:00=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 1/16/25 10:42 AM, Jeff Layton wrote:
> > On Thu, 2025-01-16 at 10:33 -0500, Chuck Lever wrote:
> >> On 1/16/25 9:54 AM, Olga Kornievskaia wrote:
> >>> On Thu, Jan 16, 2025 at 9:27=E2=80=AFAM Chuck Lever <chuck.lever@orac=
le.com> wrote:
> >>>>
> >>>> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
> >>>>> nfsd stores its network transports in a lwq (which is a lockless li=
st)
> >>>>> llist has no ability to remove a particular entry which nfsd needs
> >>>>> to remove a listener thread.
> >>>>
> >>>> Note that scripts/get_maintainer.pl says that the maintainer of this
> >>>> file is:
> >>>>
> >>>>      linux-kernel@vger.kernel.org
> >>>>
> >>>> so that address should appear on the cc: list of this series. So
> >>>> should the list of reviewers for NFSD that appear in MAINTAINERS.
> >>>
> >>> I will resend and include the mentioned list.
> >>>
> >>>> ISTR Neil found the same gap in the llist API. I don't think it's
> >>>> possible to safely remove an item from the middle of an llist. Much
> >>>> of the complexity of the current svc thread scheduler is due to this
> >>>> complication.
> >>>>
> >>>> I think you will need to mark the listener as dead and find some
> >>>> way of safely dealing with it later.
> >>>
> >>> A listener can only be removed if there are no active threads. This
> >>> code in nfsd_nl_listener_set_doit()  won't allow it which happens
> >>> before we are manipulating the listener:
> >>>           /* For now, no removing old sockets while server is running=
 */
> >>>           if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> >>>                   list_splice_init(&permsocks, &serv->sv_permsocks);
> >>>                   spin_unlock_bh(&serv->sv_lock);
> >>>                   err =3D -EBUSY;
> >>>                   goto out_unlock_mtx;
> >>>           }
> >>
> >> Got it.
> >>
> >> I'm splitting hairs, but this seems like a special case that might be
> >> true only for NFSD and could be abused by other API consumers.
> >>
> >> At the least, the opening block comment in llist.h should be updated
> >> to include del_entry in the locking table.
> >>
> >> I would be more comfortable with a solution that works in alignment wi=
th
> >> the current llist API, but if others are fine with this solution, then=
 I
> >> won't object strenuously.
> >>
> >> (And to be clear, I agree that there is a bug in set_doit() that needs
> >> to be addressed quickly -- it's the specific fix that I'm queasy about=
).
> >>
> >
> > Yeah, it would be good to address it quickly since you can crash the
> > box with this right now.
>
> I'm asking myself why this isn't a problem during server shutdown or
> when removing just one listener -- with rpc.nfsd. Have we never done
> this before we had netlink?

Removing a single listener was never been an option before. Shutdown
removes listeners and then frees the net, serv. proc fs only allowed
to view listeners. To change them, you had to change nfs.conf and
restart the server.

The problem here is new code that didn't handle a single entry removal
correctly.

> > I'm not thrilled with adding the llist_del_entry() footgun either, but
> > it should work.
>
> I would like to see one or two alternatives before sticking with this
> llist_del_entry() idea.
>
>
> > Another approach we could consider instead would be to delay queueing
> > all of these sockets to the lwq until after the sv_permsocks list is
> > settled. You could even just queue up the whole sv_permsocks list at
> > the end of this. If there's no work there, then there's no real harm.
> > That is a bit more surgery, however, since you'd have to lift
> > svc_xprt_received() handling out of svc_xprt_create_from_sa().
>
> Handling the list once instead of adding and/or removing one at a time
> seems like a better plan to me (IIUC).

I'll attempt an alternative that creates anew. I don't understand this
suggestion to "wait for sv_permsock to be settled". How can you know
when nfsdctl is done adding/removing listeners?

> Also, nit: the use of the term "sockets" throughout this code is
> confusing. We're dealing with RDMA endpoints as well in here. We can't
> easily rename the structure fields, true, but the comments could be more
> helpful.
>
>
> >>>>> Suggested-by: Jeff Layton <jlayton@kernel.org>
> >>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>> ---
> >>>>>     include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
> >>>>>     1 file changed, 36 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/llist.h b/include/linux/llist.h
> >>>>> index 2c982ff7475a..fe6be21897d9 100644
> >>>>> --- a/include/linux/llist.h
> >>>>> +++ b/include/linux/llist.h
> >>>>> @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_no=
de *new, struct llist_head *head)
> >>>>>         return __llist_add_batch(new, new, head);
> >>>>>     }
> >>>>>
> >>>>> +/**
> >>>>> + * llist_del_entry - remove a particular entry from a lock-less li=
st
> >>>>> + * @head: head of the list to remove the entry from
> >>>>> + * @entry: entry to be removed from the list
> >>>>> + *
> >>>>> + * Walk the list, find the given entry and remove it from the list=
.
> >>
> >> The above sentence repeats the comments in the code and the code itsel=
f.
> >> It visually obscures the next, much more important, sentence.
> >>
> >>
> >>>>> + * The caller must ensure that nothing can race in and change the
> >>>>> + * list while this is running.
> >>>>> + *
> >>>>> + * Returns true if the entry was found and removed.
> >>>>> + */
> >>>>> +static inline bool llist_del_entry(struct llist_head *head, struct=
 llist_node *entry)
> >>>>> +{
> >>>>> +     struct llist_node *pos;
> >>>>> +
> >>>>> +     if (!head->first)
> >>>>> +             return false;
> >>
> >> if (llist_empty()) ?
> >>
> >>
> >>>>> +
> >>>>> +     /* Is it the first entry? */
> >>>>> +     if (head->first =3D=3D entry) {
> >>>>> +             head->first =3D entry->next;
> >>>>> +             entry->next =3D entry;
> >>>>> +             return true;
> >>
> >> llist_del_first() or even llist_del_first_this()
> >>
> >> Basically I would avoid open-coding this logic and use the existing
> >> helpers where possible. The new code doesn't provide memory release
> >> semantics that would ensure the next access of the llist sees these
> >> updates.
> >>
> >>
> >>>>> +     }
> >>>>> +
> >>>>> +     /* Find it in the list */
> >>>>> +     llist_for_each(head->first, pos) {
> >>>>> +             if (pos->next =3D=3D entry) {
> >>>>> +                     pos->next =3D entry->next;
> >>>>> +                     entry->next =3D entry;
> >>>>> +                     return true;
> >>>>> +             }
> >>>>> +     }
> >>>>> +     return false;
> >>>>> +}
> >>>>> +
> >>>>>     /**
> >>>>>      * llist_del_all - delete all entries from lock-less list
> >>>>>      * @head:   the head of lock-less list to delete all entries
> >>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>>>
> >>>
> >>
> >>
> >
>
>
> --
> Chuck Lever
>


