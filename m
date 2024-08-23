Return-Path: <linux-nfs+bounces-5618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4CB95D0BA
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD811F22C80
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F018A94F;
	Fri, 23 Aug 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="AxH80s9W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3462188A1D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425275; cv=none; b=P2kenrZpv3wru1ah5hHfQMcCUBMNZKDj7os5UF8CdPMyObs5dr52Mprk7PcuhjZWQ58O0zF/MsAFhhM7MDvSZvhEkNkMOo4yUQ7oV/aYCUX47jeaKBRz30/zkScoigIivlMXnE4euayRgE7Fu6rXizF8VPYju8F3YK+guVHOzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425275; c=relaxed/simple;
	bh=PMDdzrlYnf1XJ/yJu+sdQtD1cvMXZkl11yoAmdRDkGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlvKdouFtWWKeQqa+PPMYEi+RbAGot78Rjjwp+3ole6SkCxbxykzAnqudmkZGP/+RPLi0mOfIT53NY/n1c6yebXRzLJbJZOrQ03WSYI086doo3YyVlNdy/A2sEtxXrxxOfpry36E3rWeYuA6GdOHrOkjqOUW7Q+VgkLFOs+/LrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=AxH80s9W; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f4f2868783so13176951fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724425272; x=1725030072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaMiNX7ZdAf2AXIvFUv2nR5LNkkkuvqqBexf4O8yoSY=;
        b=AxH80s9W0P7Pn4Z6Mx4IVzkuJEFl4i3XqXQb6zA2W6OQmaNPBUFPr5P3bS18OKJIkE
         5n7NYElURhO9yT0mo2yNS7pJyJ/SgyhPGxz511b4EjGPADIuDFWPrCLgpgjQeC8iUJkg
         HCEtOnDpQ3D8USHP5mzlYazdVUtgRyJtNyMeDiRSpEzChmMsZWrUzxg2k4Dn4L2PR91b
         mtkq6pGUHeu9EbjZ0IwotcHlBNwteZNhe4A+3rDho0SN7ZQ4+rypMzzRfzdRrr4gwTPZ
         gaTnoGPvFHzaf9ZkGH6zEYw8Tbt1/+xucLRsqdEphyIE1yQKNiKhejkNs/JRU6RFG4sd
         eNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425272; x=1725030072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaMiNX7ZdAf2AXIvFUv2nR5LNkkkuvqqBexf4O8yoSY=;
        b=ihxr/J+kUGMT28+2ZOBPEDv8n6eBX+GKTKPKWHxG9hmz6OFNAZ8HaPJH1a39738I/r
         ajiN8KZltc9LkI+nSweu3YfjvkPvyukQ4mT/IQofLY1KhyyU0NXY5zKqGxzaw59KaHEo
         KRBLbmSWUc0xNSBmKOlI8+/eaC1v5GJx96DcJs/JkQvk8+AqdIKzD+60KQpha7X2cUpe
         DcXh58BXU3YFZT2+SVutr8B2KpBc7j8D8WddJY4eApR1/S46wO/ZLOfLSiEpWvxis2/3
         +bkb8F1FD6X+RhyuRtRi0/04jw2KogqHGfknhxurIlsnrfNNwpQmC2SSDw7t1rmvHm+n
         cNdg==
X-Forwarded-Encrypted: i=1; AJvYcCUAI0NNHsXBXv+fMHbCi5ZTIOx4EGZf5Fojw6Gdaj8TlV/p8oAkt1Wwf4HDUqjEMsQtMjl0lT2Hy6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaaQpuzIeQbHe4QdAw49pbfP+DQ1Te7+aAWhflzGF8bPnI0SH5
	vDPQYx1r7qhFlYF/5Bf3LUPEHd99jpltgKVqB1rwKad8qz41X0SYSrXNFlprR6WOEMoD7ePUPzo
	N8Wl++K2UvuoJNZlYeTRh0K8WK6o=
X-Google-Smtp-Source: AGHT+IF0ycmrO+QC81c6UQTTYtMxnJHe/XJk92BeOwp6M8Ihuai5U/P4KaEtWUo6MBpv5JUobFZer3dV63afNvnzg/4=
X-Received: by 2002:a05:651c:542:b0:2ef:296d:1dda with SMTP id
 38308e7fff4ca-2f4f48f0f44mr21051631fa.1.1724425271014; Fri, 23 Aug 2024
 08:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823141401.71740-1-okorniev@redhat.com> <c02d3cc6561b5c06c2c51df70c6c4de19d2f9d28.camel@kernel.org>
In-Reply-To: <c02d3cc6561b5c06c2c51df70c6c4de19d2f9d28.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 23 Aug 2024 11:00:59 -0400
Message-ID: <CAN-5tyFWxiva70G9sWgBrmqoY2LKtwDYogEO-mdN+Ays_h=p5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: prevent states_show() from using invalid stateids
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2024-08-23 at 10:14 -0400, Olga Kornievskaia wrote:
> > states_show() relied on sc_type field to be of valid type
> > before calling into a subfunction to show content of a
> > particular stateid. But from commit 3f29cc82a84c we
> > split the validity of the stateid into sc_status and no longer
> > changed sc_type to 0 while unhashing the stateid. This
> > resulted in kernel oopsing as something like
> > nfs4_show_open() would derefence sc_file which was NULL.
> >
> > To reproduce: mount the server with 4.0, read and close
> > a file and then on the server cat /proc/fs/nfsd/clients/2/states
> >
> > [  513.590804] Call trace:
> > [  513.590925]  _raw_spin_lock+0xcc/0x160
> > [  513.591119]  nfs4_show_open+0x78/0x2c0 [nfsd]
> > [  513.591412]  states_show+0x44c/0x488 [nfsd]
> > [  513.591681]  seq_read_iter+0x5d8/0x760
> > [  513.591896]  seq_read+0x188/0x208
> > [  513.592075]  vfs_read+0x148/0x470
> > [  513.592241]  ksys_read+0xcc/0x178
> >
> > Fixes: 3f29cc82a84c ("nfsd: split sc_status out of sc_type")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c3def49074a4..8351724b8a43 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2907,6 +2907,9 @@ static int states_show(struct seq_file *s, void *=
v)
> >  {
> >       struct nfs4_stid *st =3D v;
> >
> > +     if (!st->sc_file)
> > +             return 0;
> > +
> >       switch (st->sc_type) {
> >       case SC_TYPE_OPEN:
> >               return nfs4_show_open(s, st);
>
> OPEN stateids are the only ones that stick around for a while after
> we've closed them out (and that's only for v4.0, IIRC). The others all
> only release the file after unhashing.

That's good to know. I had a reproducer for the open but the locking
stateid seem to be not affected by it (and I dont know yet how to
setup a pnfs server).  If only nfs4_show_open() needs to be fixed, I
can do that.

> I think it'd be better to still display that stateid, and just not do
> any of the bits in nfs4_show_open that require ->sc_file. We have the
> "admin-revoked" string that we display now when SC_STATUS_ADMIN_REVOKED
> is set. Maybe we can display "closed" or something in this case?

I'll do as you suggest and then add "closed" if sc_file is null.

Thank you.

> --
> Jeff Layton <jlayton@kernel.org>
>

