Return-Path: <linux-nfs+bounces-10719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9AEA6AB05
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91180174344
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4B192B82;
	Thu, 20 Mar 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ONRXmFGe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25671DA612
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488156; cv=none; b=TP5TgK2UBjfkYBQP0ZryftLmeuH9bRx5MjfqdoXRk9l0FspBmmT2PY+/HQEK4VbsW1JwPzozd7ncFIr21qdAlbHZFFnp2L9NVf9/clkQ0PAHS3yol32EL18H5fbeMQ9IxI4zgdlce3OW1eI26+FSv+nz9hV4VnLS2E+BsLOjzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488156; c=relaxed/simple;
	bh=c3449XYIIat9L8w2M/BZnG7A/DxoBiY8AjVBtwWSp1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFNnbN+kTjmr7GSSPbuvCKlje9NnzacKsBuqash58b/nz8AKac1WCgsqe+x4IC5+YvgeHtID2JIup0VDD7588I9C24DToJ1MGsv/QI7oBCXALE1QJPyaiM666IBSXcpMEx0NlS1F9khCjEkuXHHJ9lh/kluifiFvczNltw/NywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ONRXmFGe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307c13298eeso11933231fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1742488153; x=1743092953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g36FkegX0DbRInt91qNxp31FCdb7urDVnxj4MAMPfbQ=;
        b=ONRXmFGe52I7/JVNiNBsV2hnatKPORav1ICsiqCndPdJyA4wiXHKrAPRWdqK4LNcN9
         cCvjUUlHgPAp9fbb1DDvT8jhD6+TTyhicLrogdwUmvh6TlRAQf5fI+Ab/x2IM9ScEDTf
         Qrxrj+WOqpLvwy3+RN+sfQ3yPRzrth3KCaYAvh3qCFHMZAFTU8mPZOUT8V1U0CUlw/n6
         z0HJbZqlXgjr9etxJsrBG5pWttIcGUswEA3l9PXLbJYPNrZ1ONRw6nLqHLr8PaZgxhJY
         Aj/fPlk8NzE7xpsXcUcXOQ6ZgMiVB3IushSE/Y9ojGMVqrrY/BbkmSJ7aWjMoPdgZ7RM
         f0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742488153; x=1743092953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g36FkegX0DbRInt91qNxp31FCdb7urDVnxj4MAMPfbQ=;
        b=XlSt+9uWmomajQ5dalvsiF+b8VDSW+OmKe9vHkMaWQ2c9kgtqajSf22c/gaqALw4DV
         R2V7U+G/zo4fE0qRSlsNUbsyitbpaq0qVX4530JxqCfxdYJ1jij+/GOIDyo0WDi2cHcl
         MDbp+bxSopSEIi9PT4iAt9gqZF4ZEY4F6gIZ1x+ldHShoq3AdSgewWwZNVQLyBjUUjl7
         aFNvIawmcUmBMInshs0RrkBteLb2OVTh/qJze+3zMhc+R4fU9/fHpOYeKZHY38totvRq
         BJfSRf3SAGEXpD59N5HVeaBrGFSdYDEnckxIwKUyAaLW7CMYINgfBPEh5xswMy9r7idd
         EFJw==
X-Forwarded-Encrypted: i=1; AJvYcCU03Q827jgJcoBSsXj/QtoTO3iflN6PJcJI6pAqs216YPqOQo7qEe8k/H0lhCYm++9fTYq8C65DNbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64YX56X2vW8mbll/nCtSgj1GjGtTtZVS+xjuviguUMKM+FM+A
	QHAjVc+z4YhodwTWRYcMywefA1Z+bBCxeUYffUoE3DfrcYNpHn3+G4Kq+5KgwcidatCD7rScEDH
	wOGZUJmohfUb9MeM6W9/GNco+SDSKeLqq
X-Gm-Gg: ASbGncurEZ/VKPaSpq/IGgDjjTZPIjh9+fQEqcXd4smaDgmTXw+Taj1C1D764msLO0r
	cA2J2YiYfkZrUGIcMe96uqwVYoc6qZvasWt483no3lSg2YhS7lynX0ViNb9kEiel7AvFFcE9Tcl
	/45E5TNttaLqwzIleKNhdS+d2orEnhRVlwTQqlVFI7Mlm6rr412UsXEAX27A==
X-Google-Smtp-Source: AGHT+IEEaxRO0TRnodM8hAemTjU/vi8qNTJm98giWeuRFNbbfYVr/4TCO504O3Sr1nqQSEOmSI1LlsQsZntK9MDg18s=
X-Received: by 2002:a2e:9d97:0:b0:30b:e936:e832 with SMTP id
 38308e7fff4ca-30d727aad0emr16500151fa.13.1742488152360; Thu, 20 Mar 2025
 09:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319214641.27699-1-okorniev@redhat.com> <c8262248-2dcc-463e-b76c-7beee2786171@oracle.com>
In-Reply-To: <c8262248-2dcc-463e-b76c-7beee2786171@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 20 Mar 2025 12:29:00 -0400
X-Gm-Features: AQ5f1Jqx0agfXvLoUtZotJiuM0ZI9r25WU4qBtQA7zTQnWs51ss9d5HlbSJNWbY
Message-ID: <CAN-5tyHgjfGDnaJkKaPFmU4M1WJiGnUh0LRFJ3GT2bvXNMdM_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix NLM access checking
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, neilb@suse.de, 
	Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:58=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> Hi Olga -
>
> Thanks for taking a stab at this. Comments below.
>
>
> On 3/19/25 5:46 PM, Olga Kornievskaia wrote:
> > Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> > for export policies with "sec=3Dkrb5:..." or "xprtsec=3Dtls:.." NLM
> > locking calls on v3 mounts fail. And for "sec=3Dkrb5" NLM calls it
> > also leads to out-of-bounds reference while in check_nfsd_access().
> >
> > This patch does 3 fixes.
>
> That suggests to me this should ideally be three patches. That's a nit,
> really, but 3 patches might be better for subsequent bisection.

I can break it into 3 patches but all would have "Fixes" for the same
patch, right?

> > 2 problems are related to sec=3Dkrb5.
> > First is fixing what "access" content is being passed into
> > the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
> > explicitly set access to be read/ownership. And after is passes
> > access that's set in nlm_fopen but it's lacking read access.
> > Second is because previously for NLM check_nfsd_access() was
> > never called and thus nfsd4_spo_must_allow() function wasn't
> > called. After the patch, this lead to NLM call which has no
> > compound state structure created trying to dereference it.
> > This patch instead moves the call to after may_bypass_gss
> > check which implies NLM and would return there and would
> > never get to calling nfsd4_spo_must_allow().
> >
> > The last problem is related to TLS export policy. NLM dont
> > come over TLS and thus dont pass the TLS checks in
> > check_nfsd_access() leading to access being denied. Instead
> > rely on may_bypass_gss to indicate NLM and allow access
> > checking to continue.
>
> NFSD doesn't check that NLM is TLS protected because:
>
> a. the current Linux NFS client doesn't use TLS, and
> b. NFSD doesn't support NLM over krb5, IIRC.
>
> But that doesn't mean NLM will /never/ be protected by TLS.

But if the future NFSD would support NLM with TLS wouldn't it be a new
feature with possible new controls. We'd still need existing code to
all interoperability with clients that don't support it (and thus
having a configuration that would allow NLM without TLS when xprtsec
is TLS-enabled?

> I'm thinking aloud about whether the reorganization here might make
> adding TLS for NLM easier or more difficult. No conclusions yet.

Do we need that complexity now vs if and when such support is added?

> > Fixes: 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >
> > ---
> >  fs/nfsd/export.c | 23 +++++++++++++----------
> >  fs/nfsd/vfs.c    |  4 ++++
> >  2 files changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 0363720280d4..4cbf617efa7c 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp, =
struct svc_rqst *rqstp,
> >                   test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> >                       goto ok;
> >       }
> > -     goto denied;
> > +     if (!may_bypass_gss)
> > +             goto denied;
> >
> >  ok:
> >       /* legacy gss-only clients are always OK: */
> > @@ -1142,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *exp,=
 struct svc_rqst *rqstp,
> >                       return nfs_ok;
> >       }
> >
> > -     /* If the compound op contains a spo_must_allowed op,
> > -      * it will be sent with integrity/protection which
> > -      * will have to be expressly allowed on mounts that
> > -      * don't support it
> > -      */
> > -
> > -     if (nfsd4_spo_must_allow(rqstp))
> > -             return nfs_ok;
> > -
> >       /* Some calls may be processed without authentication
> >        * on GSS exports. For example NFS2/3 calls on root
> >        * directory, see section 2.3.2 of rfc 2623.
> > @@ -1168,6 +1160,17 @@ __be32 check_nfsd_access(struct svc_export *exp,=
 struct svc_rqst *rqstp,
> >               }
> >       }
> >
> > +     /* If the compound op contains a spo_must_allowed op,
> > +      * it will be sent with integrity/protection which
> > +      * will have to be expressly allowed on mounts that
> > +      * don't support it
> > +      */
> > +     /* This call must be done after the may_bypass_gss check.
> > +      * may_bypass_gss implies NLM(/MOUNT) and not 4.1
> > +      */
> > +     if (nfsd4_spo_must_allow(rqstp))
> > +             return nfs_ok;
> > +
>
> Comment about future work: This is technical debt (that's the 21st
> century term for spaghetti), logic that has accrued over time and is
> now therefore difficult to reason about. Would be nice to break
> check_nfsd_access() apart into "for NLM", "for NFS-legacy", and "for NFS
> with COMPOUND". For another day, perhaps.
>
>
> >  denied:
> >       return nfserr_wrongsec;
> >  }
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 4021b047eb18..95d973136079 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -2600,6 +2600,10 @@ nfsd_permission(struct svc_cred *cred, struct sv=
c_export *exp,
>
> More context shows there is an NFSD_MAY_OWNER_OVERRIDE check just
> before the new logic added by this patch:
>
>         if ((acc & NFSD_MAY_OWNER_OVERRIDE) &&
>
> >           uid_eq(inode->i_uid, current_fsuid()))
> >               return 0;
> >
> > +     /* If this is NLM, require read or ownership permissions */
> > +     if (acc & NFSD_MAY_NLM)
> > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > +
>
> So I'm wondering if this new test needs to come /before/ the existing
> MAY_OWNER_OVERRIDE check here? If not, the comment you add here might
> explain why it is correct to place the new logic afterwards.

Why would you think this check should go before?
NFS_MAY_OWNER_OVERRIDE is actually already set by nlm_fopen() when it
arrives in check_nfsd_access() .

Prior to the 4cc9b9f2bf4df inode_permission() would get NFSD_MAY_READ
| NFSD_MAY_OWNER_OVERRIDE in access argument. After, it gets
NFSD_MAY_WRITE | NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE |
NFSD_MAY_BYPASS_GSS. It made inode_permission() fail the call. Isn't
NLM asking for write permissions on the file for locking?

My attempt was to return the code to previous functionality which
worked (and was only explicitly asking for read permissions on the
file).

Unless you think more is needed here: I would resubmit with 3 patches
for each of the chunks and corresponding problems.



> >       /* This assumes  NFSD_MAY_{READ,WRITE,EXEC} =3D=3D MAY_{READ,WRIT=
E,EXEC} */
> >       err =3D inode_permission(&nop_mnt_idmap, inode,
> >                              acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
>
>
> --
> Chuck Lever
>

