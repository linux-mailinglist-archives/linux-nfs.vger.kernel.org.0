Return-Path: <linux-nfs+bounces-42-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4007F6915
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 23:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1948C2811AC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A56179BF;
	Thu, 23 Nov 2023 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnW2LDum"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC61B2
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:42:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so913293b3a.1
        for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700779338; x=1701384138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN6oiXJBkSzY08hCjgjfEshPABMkCrQmo3pI9rTbniI=;
        b=nnW2LDumsr8y+QiRDeIlDURu+/aQm4dC0PBTXjv1Kvl/wa+5GN6pXALg6S0dh9kBU+
         MrgCcD8/Kgu2/rgjpHwYIHYvCzQjxTOb1mPh46SQD+1ka8NxPqhWffne92k8YSJhQGED
         gMXyUlhppIyJdX4d+rFZI/+Fbi/wqZypHabSvfCgPLUtCYi94bI3/Euok6kNaf/YCnoW
         SH8MHGFlp6Vuek7wPNlqKzExA0009TiINvJVwXfVzrqHMLMNygrYGTFX2clpJBAoz80J
         nX/uAzRhlqwvgbtXpNAmUk8wSYGU/30E6N/4dMV9WWzd59U10x656SJ5EYcM4wW/3IQD
         hvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700779338; x=1701384138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN6oiXJBkSzY08hCjgjfEshPABMkCrQmo3pI9rTbniI=;
        b=pRDArH/ia/rUxsgu6LNkPllU86bbRiL2MrZm81ecPFN6nPwGc15bsHzZLq2FRFLofY
         tswRVgGPRae1a73rfhs5IwgyVSGWOawvZ6oJbjpr94BbZpxON01YW1fed0nxSozhfvj2
         1/wYmTCzk8ztPX7w8HHSJBvWri2FKTvTvvfFHo2/areqO9gyLUf0qMEIuSZUmp8L8f0/
         HzjCR/PHxJtzTvR9H7rJAkdban8dU6/jrC9ETGP40AU5qDJnP/48RrQPaRXbQEnjLw3u
         4vWVT8Gml4L8Tvd+w8/dBVKmotdrqmR+RSE+uLRpvF6dodKRML548EXNoTTgfLDE9X3j
         mYqQ==
X-Gm-Message-State: AOJu0YxX3cNHQoWgI8VIyQY4pcF2Un45x4HsccBZDTHehv8vyJ4C7GdL
	Vgng4aj1Nb8vdtWqkDPz2LpPT8k6J44YrVo746TRUiOsqg==
X-Google-Smtp-Source: AGHT+IHxu3yA5Oy/Xy8vZIY8rArZag8pCGalLkNGnapNh/LQR/nUKmDuANy9+vM9raQQ8LCKAS4AbeUF+kLe0SsV4v8=
X-Received: by 2002:a05:6a20:8f19:b0:188:39e:9054 with SMTP id
 b25-20020a056a208f1900b00188039e9054mr1215301pzk.6.1700779338264; Thu, 23 Nov
 2023 14:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
 <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
 <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com>
 <CAFX2JfnDC1xZvuuUiHe8_RpBehwCZriZ13yYPk6pQSPSV4V-qQ@mail.gmail.com>
 <CALXu0UevOCU0dm-0WUEZZFCV=V8jQxmy2OQYhtptVyVAZeWs3g@mail.gmail.com>
 <CAM5tNy7QYgMUo_tTSPQ6hqxO8WrscBn1O2XpeJVK67OCQMu+2w@mail.gmail.com> <CALXu0Ue6d7Z+gh5VS_64scjUwPA_-PVKmsv0W+uEx93vbf6dgw@mail.gmail.com>
In-Reply-To: <CALXu0Ue6d7Z+gh5VS_64scjUwPA_-PVKmsv0W+uEx93vbf6dgw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 23 Nov 2023 14:42:07 -0800
Message-ID: <CAM5tNy4h8__9Xu1nEx3akLb_qZo-5XfgoT9M=fRYfZt6N2AcrQ@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 2:14=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Thu, 23 Nov 2023 at 00:19, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Wed, Nov 22, 2023 at 2:48=E2=80=AFPM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> > >
> > > On Sun, 19 Nov 2023 at 19:02, Anna Schumaker <schumaker.anna@gmail.co=
m> wrote:
> > > >
> > > > On Sun, Nov 19, 2023 at 12:59=E2=80=AFPM Cedric Blancher
> > > > <cedric.blancher@gmail.com> wrote:
> > > > >
> > > > > On Sun, 19 Nov 2023 at 18:48, Anna Schumaker <schumaker.anna@gmai=
l.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
> > > > > > <cedric.blancher@gmail.com> wrote:
> > > > > > >
> > > > > > > Good evening!
> > > > > > >
> > > > > > > How does READ_PLUS differ from READ? Has anyone made a simple=
r
> > > > > > > presentation (PowerPoint slides) than the RFCs?
> > > > > >
> > > > > > No slides, but at a high level READ_PLUS can compress out long =
ranges
> > > > > > of zeroes in a read reply by returning a HOLE segment instead o=
f the
> > > > > > actual zeroes. It's perfectly valid for the server to skip the =
zero
> > > > > > detection and return everything as a data segment, however.
> > > > >
> > > > > So how do you differ between
> > > > > 1. a hole, aka no filesystem blocks allocated
> > > > > 2. a long sequence of valid data with all zero bytes in them
> > > >
> > > > That's up to the server! It could use something like fiemap or lsee=
k
> > > > with SEEK_HOLE or SEEK_DATA. It could also scan the data to see if
> > > > there are any zeroes that could be compressed out.
> > >
> > > How can the client figure out whether the data in a READ_PLUS reply
> > > are zeros of data, or zeros from a hole?
> > As I understand the RFC, it cannot. Or put another way "a hole is a
> > region that reads as all 0s, which may or may not have allocated blocks
> > on the server file system".
> >
> > Although SEEK_HOLE typically returns the offset of an unallocated
> > region, I don't think either the POSIX draft (was it ever ratified?) no=
r
> > RFC7862 actually define a "hole" as an unallocated region.
>
> Opengroup ratified that one. See https://austingroupbugs.net/view.php?id=
=3D415
>
> >
> > On a similar vein, Deallocate can simply write 0s to the region.
> > (It does not actually have to "deallocate data blocks".)
> >
> > At least that is my understanding of POSIX and RFC7862, rick
>
> Can anyone please confirm that RFC7862 and READPLUS cannot distinguish
> between allocated and unallocated regions in a file?
The best place to ask this is the nfsv4@ietf.org mailing list.
Alternately, you just read the words yourself...
Having said that, here are a few snippets of RFC7862 (neither of which are
in the READ_PLUS section):
In definitions...
   Hole:  A byte range within a sparse file that contains all zeros.  A
      hole might or might not have space allocated or reserved to it.

And in the section on DEALLOCATE...
   All further READs from
   the region passed to DEALLOCATE MUST return zeros until overwritten.
   [irrelevant stuff snipped]
   Situations may arise where da_offset and/or da_offset + da_length
   will not be aligned to a boundary for which the server does
   allocations or deallocations.  For most file systems, this is the
   block size of the file system.  In such a case, the server can
   deallocate as many bytes as it can in the region.  The blocks that
   cannot be deallocated MUST be zeroed.

Now, if the above is not enough to convince you that "hole" does not
necessarily imply "unallocated", then I suggest you read it and then
ask on nfsv4@ietf.org.
(Btw, the DEALLOCATE section uses the term "unreserved" and not
"unallocated".)

I'll also admit I do not understand why you care?
Is there a Windows API that specifically returns unallocated regions
of files?

rick

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

