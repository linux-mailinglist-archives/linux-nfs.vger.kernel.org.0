Return-Path: <linux-nfs+bounces-9306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A65A13CF8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1243A0755
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64119ABD1;
	Thu, 16 Jan 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3jattYM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928822A7E7
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039289; cv=none; b=KjNMuOPZbpl1O6jbZhb1dAjRtsLUsGLogGxhL2v8+4wX9xDO3kWWtERL1a70DRnR/DIodohpwZE/mGi0ZJwHznGkJSZ4wDoiaFHd9ViuKkk9JmbIulYA8qgoJ3pb81ot//PFHxKE85k3nRWoFsblGKQaNBVFClbZ8DNoo1RO2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039289; c=relaxed/simple;
	bh=aX2rJ4YNcDzRVPdO0lUO6DL+X4MrUyqmsclR+5E15e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meToJNlHvajW2VbvSrmFpdJ6DKPFBXfUH8RhLqiHFjEovOpJZxHHrSVYcwQrk775OgMPVixCf7iM13hmHiAOAz2IybipU6ZhRBTn7eOaeubtJAtfexSsxnsrP6Z6ufaddVv5AWX5+0eMoSKM78Nf49eZPRT4yUNnKIhKvVXObxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3jattYM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737039286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCh8Li4PNDoeDiXJBZ/OmUp7XmAhBuakXgqjYBAGEZg=;
	b=h3jattYMKDnvYuLXiNB1HoKissNHvJeN117OcDqX46U+Vz23KUO554eo89LKRYRUuDq7KV
	eZuGy0Yfqx7x2pka2iwBHwCvGxdqf0BIl0MaPgyGqIzzJ6U6BTsrgy5mH4o/+EkkFcOL0G
	UgPqRP4NUlTyBOf5PBk/mWtdsytFEwc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-Jq-SXutHOu6AndqAkmYA2Q-1; Thu, 16 Jan 2025 09:54:45 -0500
X-MC-Unique: Jq-SXutHOu6AndqAkmYA2Q-1
X-Mimecast-MFC-AGG-ID: Jq-SXutHOu6AndqAkmYA2Q
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so1476097a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 06:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737039284; x=1737644084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCh8Li4PNDoeDiXJBZ/OmUp7XmAhBuakXgqjYBAGEZg=;
        b=dSPnztCCTGOsotVSc6x5bBc81W4wK3lwdv7A1QbJG54YJnMnc3DJmHgiYdr16ocAKz
         IeXiGs5zIjM4qcGqw2uO44BnmwULrFZ8jFrpvG7fJ+JUdNFSxnXCPVVEHp+4HRIsokfZ
         o+IDnivIBveQygjJz64mXXl5W2Ut4BVF+G6IvU+YyeH1V7MnqQcJ+F6W4hW/YW4lKFFr
         +nhZHS5L2MEtwvyQYGaaleJWQMJ0xYqQH+qCVbKjZ+y8d7D5xw6YLCRgb9PsLC0Ga7ax
         VQ5OUsaL3YIYFx8NRbtR5nVDTNctC6yQwd0YpS96Hh7fg3wXtUVxiUHnBmj6DtHfV/9K
         rL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyzvI9Cz04IKmVuvCTlRkKzQjPH/3ptZXjn0vscIV2Lf5AX+ECSveGDVxZ3GwNyRXX3OMnMyo1UVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnLuA6Y14i6ya/XFPoYvv2ZO5yE4nEYixyPg9Vci0m4rY1CgJ
	tp9i6cz7M5iqZ5SOao4Aq5V0dizgYxo6jyLpqYRxHKrVr40gTTO1p/hsLor8uRt7SC3qQV+0GEO
	uAs6boXH0f1mbroxLNnwzKegPDhhRIxvohUGJL4b+Ly2fzriT9OodRsFvWeh7n7AI3O1vnTdPy0
	K3yu31JFQuBh1InLDvSs1EXVEqYnuOMuK8v13j6+Aou5c=
X-Gm-Gg: ASbGnctHHVCSbDrn3TZIT0vt4lqNTuyjKIRNBpvBxKAs55sAbV1udbDZdhSEzgdgI85
	HfVtmhnjrs/UHq/gguEuQsBP6SG1UEiHATYfTdw7Ec9jko1ruozOrskSt+ZRi6nfrrDD45QbX
X-Received: by 2002:a05:6402:2814:b0:5d9:a91:3382 with SMTP id 4fb4d7f45d1cf-5d972e4ee02mr28090228a12.21.1737039284066;
        Thu, 16 Jan 2025 06:54:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENhp1D56S7v9rJqZ8Hj79qFCch3d98eqKU5uSZkyAVWiC/DHAGSEl8W7cW3KrvU4DWPt5OOnloczSEdRsaGrU=
X-Received: by 2002:a05:6402:2814:b0:5d9:a91:3382 with SMTP id
 4fb4d7f45d1cf-5d972e4ee02mr28090202a12.21.1737039283725; Thu, 16 Jan 2025
 06:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115232406.44815-1-okorniev@redhat.com> <20250115232406.44815-2-okorniev@redhat.com>
 <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
In-Reply-To: <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 16 Jan 2025 09:54:33 -0500
X-Gm-Features: AbW1kvZebWLbwHW8hY0IyelvLar_YgMRBSBB5hcOabY9SMBwgf4CrAWaUlLUpII
Message-ID: <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 9:27=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
> > nfsd stores its network transports in a lwq (which is a lockless list)
> > llist has no ability to remove a particular entry which nfsd needs
> > to remove a listener thread.
>
> Note that scripts/get_maintainer.pl says that the maintainer of this
> file is:
>
>    linux-kernel@vger.kernel.org
>
> so that address should appear on the cc: list of this series. So
> should the list of reviewers for NFSD that appear in MAINTAINERS.

I will resend and include the mentioned list.

> ISTR Neil found the same gap in the llist API. I don't think it's
> possible to safely remove an item from the middle of an llist. Much
> of the complexity of the current svc thread scheduler is due to this
> complication.
>
> I think you will need to mark the listener as dead and find some
> way of safely dealing with it later.

A listener can only be removed if there are no active threads. This
code in nfsd_nl_listener_set_doit()  won't allow it which happens
before we are manipulating the listener:
        /* For now, no removing old sockets while server is running */
        if (serv->sv_nrthreads && !list_empty(&permsocks)) {
                list_splice_init(&permsocks, &serv->sv_permsocks);
                spin_unlock_bh(&serv->sv_lock);
                err =3D -EBUSY;
                goto out_unlock_mtx;
        }


>
>
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >   include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 36 insertions(+)
> >
> > diff --git a/include/linux/llist.h b/include/linux/llist.h
> > index 2c982ff7475a..fe6be21897d9 100644
> > --- a/include/linux/llist.h
> > +++ b/include/linux/llist.h
> > @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_node *=
new, struct llist_head *head)
> >       return __llist_add_batch(new, new, head);
> >   }
> >
> > +/**
> > + * llist_del_entry - remove a particular entry from a lock-less list
> > + * @head: head of the list to remove the entry from
> > + * @entry: entry to be removed from the list
> > + *
> > + * Walk the list, find the given entry and remove it from the list.
> > + * The caller must ensure that nothing can race in and change the
> > + * list while this is running.
> > + *
> > + * Returns true if the entry was found and removed.
> > + */
> > +static inline bool llist_del_entry(struct llist_head *head, struct lli=
st_node *entry)
> > +{
> > +     struct llist_node *pos;
> > +
> > +     if (!head->first)
> > +             return false;
> > +
> > +     /* Is it the first entry? */
> > +     if (head->first =3D=3D entry) {
> > +             head->first =3D entry->next;
> > +             entry->next =3D entry;
> > +             return true;
> > +     }
> > +
> > +     /* Find it in the list */
> > +     llist_for_each(head->first, pos) {
> > +             if (pos->next =3D=3D entry) {
> > +                     pos->next =3D entry->next;
> > +                     entry->next =3D entry;
> > +                     return true;
> > +             }
> > +     }
> > +     return false;
> > +}
> > +
> >   /**
> >    * llist_del_all - delete all entries from lock-less list
> >    * @head:   the head of lock-less list to delete all entries
>
>
> --
> Chuck Lever
>


