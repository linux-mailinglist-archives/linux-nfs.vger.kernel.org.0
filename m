Return-Path: <linux-nfs+bounces-10955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979EA75AD4
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Mar 2025 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B452D3A7F9D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Mar 2025 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F5C13B59B;
	Sun, 30 Mar 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="OtQ+1mcZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF01581F0
	for <linux-nfs@vger.kernel.org>; Sun, 30 Mar 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743351157; cv=none; b=ExJckUwXHtg3GgcCZXSv+IuC35v7xgWyzxucbklVFSzNseHcWSDURNMof5LUF6Z8t+1xYqIO6V2xfAG12F8GFXVURfzjaveCemhtcGdLabrle6H8XRXq6rxCwwN6Di3NKG6yXYox+4l34BkYnoCXbKx4kZJI4oV376JWOV1fHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743351157; c=relaxed/simple;
	bh=95O2I5o3XCnUdRQMjgTUH67PGq+WOR6xYCIplkSLV3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzziIY7u80NW1GambZLHXaXOluhizgHmYxg8xfjZGBpIcmPFLCwfZq3NdMTyS7B9T/kJ+PaVKSyG6THlaLQRAyQw/tYZeRVYld9AjH9I2HhZQwf3vBEZl1uqvqzbLbgiQzk5f2oeWNlIQBZOl3hfPmVdhsAtGTlX0n0DfxcJTtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=OtQ+1mcZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so20259421fa.0
        for <linux-nfs@vger.kernel.org>; Sun, 30 Mar 2025 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1743351153; x=1743955953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4kwgNoQ7A0nH2IwXOKycqB+inM14bVbBE+NwtyKtxg=;
        b=OtQ+1mcZhf8+p3LLOlkxA1aXCbw4Boi8nuS5ttpevK3DdlfzJIXIiQ0fSeYjPCQh7x
         U61NqmhpXbc/81PAPaq7+rSaMzP0fJ2CbC7MtZ2QmkALVENtRWyHVZY9qFFCUgtHiA7H
         1yfyTIfdokeLslUyDmY+yQrZfCK2NJ88DBgGEBuomhpPop+HC9CLx33ba7f2Uzrd5KHw
         ND3XNHjkXGSj/zO37TVUV4ESOT9Iq7gsyp51S9ZzEqEkYZJfUTNhO0UPwYW490DBR4Lf
         qLNhUUgLm3NeMyUM8m8Ugq16HX+r9ckbbjVFWtsqwTqai+7wOMQ+P8TJh4cVP6ltzi0l
         jvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743351153; x=1743955953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4kwgNoQ7A0nH2IwXOKycqB+inM14bVbBE+NwtyKtxg=;
        b=OuuDg7DcqYpjK4l6E3mTc1SkWdZTCIExUT9Js6+2h0NFyC8CWCGrEeYqBTz5HRe5Ya
         t743WHNvhLw5GkVZxtDh2fvjwgz4PJAhwMMhqENf7cQv3DCnsrWtekyIWU6Fx6OFL81Y
         svF03Qc7vod3iy+CCAdx0bVgqj1K6TcsjSd8aZprNnCLk2MyOb4PNdVlYBLSnbCfl3kw
         T6NsZluL6Bwr9LNILrp3Iq/AYVa/6PRdsxB8d+sY7k3ACyf8xXKi7CM1+bsTr+drQNkY
         TwLXAIRHra3t3CY9HFvvuwvznq9RDdwsLSBow3RxboT2r7MGpiHgQbeHLkVtI33zvbJt
         igXg==
X-Forwarded-Encrypted: i=1; AJvYcCX24Rxk8VK66tMl9aMSE2RpOMciaFhLjJZIovTRmG/2I4CCKgtKAvpyRwCVEpsB2uo8SmKhdAne1q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UqYwQ222wnNmmT79Vc1hLIQ17poM/vV7v3zkamQVikJa3HFI
	4h7OTAwo6E48rL+IFDfEebsQnJA/y9qzW2Cz+UdwkeB/5MwP7EjMVoLcccBzofbVR7epAB3mbzd
	OY2L0XSGrxnbqiX6Wr17IElueP1w=
X-Gm-Gg: ASbGncsrlWPi/MFGvo7ReDbSdr1k3QL5LzbrmZqTpu85ZttXF5oDavpS1OkhMke/jmy
	ZQVjrEMG0nygKTU1RCg1NzQXB/IRuqO0hh+F/kVhRlhPUEGsfQPDHZFl+k2zn1QwDKEI+rVeN9T
	ifoSwxyvdz1LFYNK36FVIXlAZ6lo4=
X-Google-Smtp-Source: AGHT+IFPtppp8XDcVNUJAtK4gX+iGTwJZGFZTj/Na3syKTsbENnNKKwVRXITFbwd1nHnvYXc6oZIdscLb8txkwXJY/8=
X-Received: by 2002:a05:651c:211b:b0:30b:9813:b00d with SMTP id
 38308e7fff4ca-30de0329b54mr19747311fa.23.1743351152716; Sun, 30 Mar 2025
 09:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
 <174319880848.9342.18353626790561074601@noble.neil.brown.name>
In-Reply-To: <174319880848.9342.18353626790561074601@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Sun, 30 Mar 2025 12:12:19 -0400
X-Gm-Features: AQ5f1JrOrT5YErDIob7jelETmxBRFM7en68MlM-hgbHXl6Yvu2bk_Ik3KAxENsc
Message-ID: <CAN-5tyHWB9+Q9ONmWfF2LGe6wO1hZXvx2vEHb441Q3XkjzOFmQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
To: NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 5:53=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 29 Mar 2025, Olga Kornievskaia wrote:
> > On Thu, Mar 27, 2025 at 9:43=E2=80=AFPM NeilBrown <neilb@suse.de> wrote=
:
> > >
> > > On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
> > > > On Thu, Mar 27, 2025 at 7:54=E2=80=AFPM NeilBrown <neilb@suse.de> w=
rote:
> > > > >
> > > > > On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> > > > > > NLM locking calls need to pass thru file permission checking
> > > > > > and for that prior to calling inode_permission() we need
> > > > > > to set appropriate access mask.
> > > > > >
> > > > > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > ---
> > > > > >  fs/nfsd/vfs.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > index 4021b047eb18..7928ae21509f 100644
> > > > > > --- a/fs/nfsd/vfs.c
> > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, s=
truct svc_export *exp,
> > > > > >       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > > >               return nfserr_perm;
> > > > > >
> > > > > > +     /*
> > > > > > +      * For the purpose of permission checking of NLM requests=
,
> > > > > > +      * the locker must have READ access or own the file
> > > > > > +      */
> > > > > > +     if (acc & NFSD_MAY_NLM)
> > > > > > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > > > > > +
> > > > >
> > > > > I don't agree with this change.
> > > > > The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE i=
s also
> > > > > set.  So that part of the change adds no value.
> > > > >
> > > > > This change only affects the case where a write lock is being req=
uested.
> > > > > In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_RE=
AD.
> > > > > This change will set NFSD_MAY_READ.  Is that really needed?
> > > > >
> > > > > Can you please describe the particular problem you saw that is fi=
xed by
> > > > > this patch?  If there is a problem and we do need to add NFSD_MAY=
_READ,
> > > > > then I would rather it were done in nlm_fopen().
> > > >
> > > > set export policy with (sec=3Dkrb5:...) then mount with sec=3Dkrb5,=
vers=3D3,
> > > > then ask for an exclusive flock(), it would fail.
> > > >
> > > > The reason it fails is because nlm_fopen() translates lock to open
> > > > with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
> > > > acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling int=
o
> > > > inode_permission(). The patch changed it and lead to lock no longer
> > > > being given out with sec=3Dkrb5 policy.
> > >
> > > And do you have WRITE access to the file?
> > >
> > > check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
> > > granted the file must be open for FMODE_WRITE.
> > > So when an exclusive lock request arrives via NLM, nlm_lookup_file()
> > > calls nlm_do_fopen() with a mode of O_WRONLY and that causes
> > > nfsd_permission() to check that the caller has write access to the fi=
le.
> > >
> > > So if you are trying to get an exclusive lock to a file that you don'=
t
> > > have write access to, then it should fail.
> > > If, however, you do have write access to the file - I cannot see why
> > > asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.
> >
> > That's correct, the user doing flock() does NOT have write access to
> > the file. Yet prior to the 4cc9b9f2bf4d, that access was allowed. If
> > that was a bug then my bad. I assumed it was regression.
> >
> > It's interesting to me that on an XFS file system, I can create a file
> > owned by root (on a local filesystem) and then request an exclusive
> > lock on it (as a user -- no write permissions).
>
> "flock" is the missing piece.  I always thought it was a little odd
> implementing flock locks over NFS using byte-range locking.  Not
> necessarily wrong, but definitely odd.
>
> The man page for fcntl says
>
>    In order to place a read lock, fd must be open for reading.  In order
>    to place a write lock, fd must be open for writing.  To place both
>    types of lock, open a file read-write.
>
> So byte-range locks require a consistent open mode.
>
> The man page for flock says
>
>     A shared or exclusive lock can be placed on a file regardless of the
>     mode in which the file was opened.
>
> Since the NFS client started using NLM (or v4 LOCK) for flock requests,
> we cannot know if a request is flock or fcntl so we cannot check the
> "correct" permissions.  We have to rely on the client doing the
> permission checking.
>
> So it isn't really correct to check for either READ or WRITE.
>
> This is awkward because nfsd doesn't just check permissions.  It has to
> open the file and say what mode it is opening for.  This is apparently
> important when re-exporting NFS according to
>
> Commit: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
>
> So if you try an exclusive flock on a re-exported NFS file (reexported
> over v3) that you have open for READ but do not have write permission
> for, then the client will allow it, but the intermediate server will try
> a O_WRITE open which the final server will reject.
> (does re-export work over v3??)
>
> There is no way to make this "work".  As I said: sending flock requests
> over NFS was an interesting choice.
> For v4 re-export it isn't a problem because the intermediate server
> knows what mode the file was opened for on the client.
>
> So what do we do?  Whatever we do needs a comment explaining that flock
> vs fcntl is the problem.
> Possibly we should not require read or write access - and just trust the
> client.  Alternately we could stick with the current practice of
> requiring READ but not WRITE - it would be rare to lock a file which you
> don't have read access to.
>
> So yes: we do need a patch here.  I would suggest something like:
>
>  /* An NLM request may be from fcntl() which requires the open mode to
>   * match to lock mode or may be from flock() which allows any lock mode
>   * with any open mode.  "acc" here indicates the lock mode but we must
>   * do permission check reflecting the open mode which we cannot know.
>   * For simplicity and historical continuity, always only check for
>   * READ access
>   */
>  if (acc & NFSD_MAY_NLM)
>         acc =3D (acc & ~NFSD_MAY_WRITE) | NFSD_MAY_READ;

This code would also make the behaviour consistent with prior to
4cc9b9f2bf4d. But now I question whether or not the new behaviour is
what is desired going forward or not?

Here's another thing to consider: the same command done over nfsv4
returns an error. I guess nobody ever complained that flock over v3
was successful but failed over v4?

> I'd prefer to leave the MAY_OWNER_OVERRIDE setting in nlm_fopen().


>
> Thanks,
> NeilBrown

