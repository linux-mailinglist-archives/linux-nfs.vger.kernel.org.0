Return-Path: <linux-nfs+bounces-7591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC929B6FE6
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 23:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA282818E8
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 22:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6641D0F76;
	Wed, 30 Oct 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMu947JE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1381925AE
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730327816; cv=none; b=cLCnERfetwJJMf3V5CIC+4Qihq59o0ZewzeP3h3S4/3EfZJI+1yBc2RY8tJ3NAnnM6hKx6pshh63T0IYgRs8r6/f1RVzuVHzV+0NRsAXrhr6cquD5fIPWQqQK47hzXmSlLfQfYWls4C4hbhVnmTh/XlixqhnnWcSl9ubMMWbRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730327816; c=relaxed/simple;
	bh=X52ZqZvQto3fD3hsX2fGYk5stbKNIzSO+UTDXqhql80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6zzC+6PhbPlS3Mn3oHBjawDg0g9U7YLYI6PnOxIF/FzlZFkEz5jO0dKB0Had14524z3AM4eNEvmAsJLa30UCl5xZ+FcQAn6CXApGzk48Ma3055n9mvJUGqnrjOIIwC8ToxbCJm5YRvMTUYItyDHOA+4thBw65fJgZpzvYlgd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMu947JE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso411917a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730327812; x=1730932612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojMEYuUSNlxC1FenFFlkweiGYXMs89Qom19x558cxQE=;
        b=TMu947JErSLApgnoUoE+cYIPJwynDv8Nt9lujkKPflZ1SafB7V8I5t8Mhjn5PDSSBV
         xqrAkApyMnKOMP/dX4d8FQQvXBELUVRCHfYj1cStHiERRNPRwR39Iqy7qYF9wegXm+0C
         hR+zqpiwjJX4Ai5ieBwOaXpkSh5vOfJSidK2eRxrHlx4hyXEGjp3ADcEhlQCrPJGdts9
         DAC01aVKX6am15OLUZ8t5+anzxinpk3fIojSwC/vjLGRhNxkRWg85sCfCKU13Hfrziqr
         d9wWy6DVl7S9DzKthB3i6TC2q3x7hGwKKxjiSNyh8iCLRmmIYf9Uk/I3oG1F9HP03jIR
         MPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730327812; x=1730932612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojMEYuUSNlxC1FenFFlkweiGYXMs89Qom19x558cxQE=;
        b=qA5ZiiVaKeADQ2fvbSj0G2qwVElKIaLDSz1El8W2DSqj/khtlcvqb+IsN7CqOnmn4k
         qgoNNQR0L58lDDJNk6b94mEsAg9XktbouBZ+A8HBgt+6Vdev6/gKNYkv7lqLeRfFx0Bz
         jiWoxysiPlvAJ1PIZlowY8JWPxZOib2NLtBUYn7iszjswE91AzCSyRkMbJZQgZ5c9cXs
         J9o5xksMGcaBkB4xvy/elKD5ob8rOBVgFacaYvI8DuVvay+EYZJSZTQdt5GsTXqNFJmz
         GpE2s+PMyQyu0vgo+F8Xh0MTkP7NAP+k5wweMWe57sU9hujr9UWqHANAhNigqTDebS1y
         mxZA==
X-Gm-Message-State: AOJu0Yz8kpEZRgW4+U+5+kic20/xR5xWRDOC/9ozRBjOaUZKSGLMbmvI
	k/rNUXnBkQZ0gR8lTxvuNsvnO1v1mhmOhX/TTp6mdRRy/VKbYF8YUeWhAq10/22fifcc6utLUYQ
	pCUSIcv0OGFsv6MRvpopzXdhw4lB1k1k=
X-Google-Smtp-Source: AGHT+IECdjwGviiyjg9NAAIXvCBvMzMWav5C00kr/73OGGqsE2rftf2t0VCv9ahAL7TlCzkpIJJsSc/N13O6UlS3zyY=
X-Received: by 2002:a05:6402:208a:b0:5cb:ad37:4f60 with SMTP id
 4fb4d7f45d1cf-5cea96f4c4dmr944596a12.26.1730327811767; Wed, 30 Oct 2024
 15:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4xVcJa+qrfuze5s61rO_-tXkY60gF5WHGAvzJQ=9ZXmw@mail.gmail.com>
 <45988263-042D-4A3A-A236-3B2AD786A0C9@oracle.com>
In-Reply-To: <45988263-042D-4A3A-A236-3B2AD786A0C9@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 30 Oct 2024 15:36:41 -0700
Message-ID: <CAM5tNy421mRGKaUn4ghac6qJNd57amisU8NxFtCVjvT_WP+51w@mail.gmail.com>
Subject: Re: RFC: handling (or not) VERIFY for POSIX draft ACL attributes
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:19=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 29, 2024, at 10:43=E2=80=AFPM, Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > Hi,
> >
> > I've run into a rough patch (no pun intended;-) w.r.t. the server
> > side implementation of the POSIX draft ACL attribute extension.
> >
> > (N)VERIFY operations need to compare attributes for "equal" and
> > that is not easy.
> >
> > First, the current server code compares raw XDR and that will
> > only compare "equal" if the ACEs are in the exact same order
> > and all the "who" strings (which represent users and groups)
> > are in the exact same format.
> >
> > It would be a lot of work to rewrite VERIFY so that it does not
> > compare raw XDR and, even then, any difference in the way
> > the "who" strings are expressed on-the-wire vs what is generated
> > from the server's current ACL (a number in a string vs user@domain
> > for example) would be difficult to compare.
> >
> > To avoid this problem, I am considering not allowing the POSIX
> > draft ACLs to be used for (N)VERIFY operations in the Internet
> > Draft.
> >
> > Does this sound reasonable?
>
> IMHO you should ask the WG first.
I will ask the WG. I asked here first because it looks like it would
be a "royal pita" to re-write the knfsd VERIFY/NVERIFY support
to make the POSIX draft ACL attributes work.

Maybe I should word it as...
"Does anyone see a big problem with not allowing the POSIX draft
ACL attributes to be used by VERIFY/NVERIFY?"

> Would NFSv4 ACLs have the same
> issues?
The first "who" issue, yes. (It also applies to Owner/Owner_group.)

I see two ways (N)VERIFY can compare the who values "same".
A) - Require the string to be identical.
or
B) - Require the string to map to the same user/group (uid/gid
      for POSIX like servers).
Right now, it appears the Linux knfsd does A) and the FreeBSD
server does B).
Which is correct?
I have no idea, since the RFCs do not seem to discuss this.
--> This is definitely one for the WG.

The ACE order issue, I'd say no. When ACEs in a NFSv4
ACL are reordered, the access semantics changes.
(This in not true for POSIX draft ACLs, although Linux
chooses to sort them based on tag and id. See sort_pacl()
in fs/nfsd/nfs4acl.c and posix_acl_valid() in fs/posix_acl.c.)
--> Neither the withdrawn draft nor Grunbacher paper specifies
      an ACE ordering. This is done internally for Linux to simplify
      the implementation of access checking, from what I can see.

I will post about both of these on nfsv4@ietf.org, in case anyone
is interested.

rick

>
> --
> Chuck Lever
>
>

