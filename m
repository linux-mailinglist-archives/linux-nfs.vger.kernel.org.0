Return-Path: <linux-nfs+bounces-10734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7BCA6AF57
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 21:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AE3AC52B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C91E32CF;
	Thu, 20 Mar 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diFa1RlG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37407190072
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503637; cv=none; b=DPJVyiGWDX3zb4GemSWY81RKS8HaSNX0jul6ls9gT3XPKCpx7w1wa5gwAqhNbCxbbDbOOUipQnM0ViBXE5w9UaBm6VbkSmDOO9RNijrXqwsb1htsclE2+Uyn18EfyyV21Bk6FM1ezsLVFIavE1cuijno81g+nxYJ7pbUaSx+m5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503637; c=relaxed/simple;
	bh=o46XRdQeXuQDfeYdq7TJHwJGUU7kf7JB1M6+3KJ9CyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7UducKNOerxY3fQc0PbdHxLloHQfhefEsElVU/LE2UscBumpU8CxIALeDPKaf1STqm4e8cmeIilqglwP/d78BFoHkGx4eHFuhN8BuWFv8MQRK7/aZNTQ2r/s3AmazijJIuv5ojn3MQVssL+fzRdIyI3kpeP+YkGKE0fQwL9V5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diFa1RlG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742503634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4TSKaEMA4GMUSWPT84px6NODQT0cJH6T/9jDMaaz/g=;
	b=diFa1RlGqSt1U7wJwWFD7S/hrXriafFxdllP1BlRe/97a+taAK2Kei7b/q4fQNy4sWeOMP
	Vroz2X0FsbnMUeX6qN5z8N9P0sYsI5+4+prFFiFpz4oPNDe0P6PmqSvJVBeZNoPcOwQYcF
	SDR9xo9SL+eIrqsfPkyTbCFEYKWLfYM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-3SbOa0NwNjirNfuViLmjNg-1; Thu, 20 Mar 2025 16:47:12 -0400
X-MC-Unique: 3SbOa0NwNjirNfuViLmjNg-1
X-Mimecast-MFC-AGG-ID: 3SbOa0NwNjirNfuViLmjNg_1742503631
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3d3cd9accso120306466b.3
        for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 13:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503631; x=1743108431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4TSKaEMA4GMUSWPT84px6NODQT0cJH6T/9jDMaaz/g=;
        b=affm528Uqet+DZOew8okLwxl7bmyzd5eT03Fo01lxlD68Z/Q4K8ZmWqt1RnhyzCR+j
         TO7QLChKVdKFN/Nbwef8BeG0Ca/k82wJSauCtD3NVKKY7mu4enTAQqgnddaQam5HwHL5
         idvTHt5FBbZ5ENrATPHga9Po8asG16n3N/5RPSAsZ4oHly2pineac5SHXl45lWU0Mub8
         ctqqnFfAu298Ro7vXDYcObNTd+B3ZDv0hlbM/YVMCoibZsSBf7sUhrR3DqMVf0mVkbps
         UkDsNx/4VnVb1jHIQ22LiTXDmc+ZZARkIo9QgQMjB0VpS8DnvV9eSQZQ2cahGxIhqOEc
         gMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdYtaaJhlURlWiltWP/TRJnb/FgVgiG4NSo6RR11cNYZ+Hy5+Uukuwcv+s2aOf9df0xYrfFKCvzJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwcxu7XwGSYAfVpgrlz90xrwboMV9rCy1qMvElntC5/NDZlTYy
	Fa0L5eOVuasA2ItKKdCXMDJOiA5Xkm0mvHpvCTfB2BWAPOS9loEzpimzdUc+PP/oWV2YJMKGtgX
	ZmfIFGAydfSETzGB8MbDj6Cv826Ye/Ecf5RaRHwJ70VoanD5/UUWoDhshUBhQTOc/UVgEuwLO66
	36I7H5E5QrByDdcl0PmfSIYjbVsXxTPUnJ
X-Gm-Gg: ASbGncvS+BUGnevmW1aq1g4B1JL2oD4wl7cacMkwPDBtNAFU9hfbYfdSd7MTf4whG0T
	Foj5zkl7YIml4t+d2Ni5RDMYmmkL8kPj/u7IjxzhDP7tiI+6ttM3CwUnqt+YeH6Oc4mTJ9Sl15g
	UF+ngvArKOlD9NvsCJa+D6AVHsIM0s
X-Received: by 2002:a17:906:4fcd:b0:abf:67de:2f1f with SMTP id a640c23a62f3a-ac3f24b43b1mr49537966b.44.1742503631081;
        Thu, 20 Mar 2025 13:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwOCjvsjMdKVTGQnpsWXdxO72bvcrVhnDHOrXygnNLlqaillEAMGNpKDTi5eajnOhcA2r5vxSdHKPFKDJPnXQ=
X-Received: by 2002:a17:906:4fcd:b0:abf:67de:2f1f with SMTP id
 a640c23a62f3a-ac3f24b43b1mr49535466b.44.1742503630549; Thu, 20 Mar 2025
 13:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319214641.27699-1-okorniev@redhat.com> <c8262248-2dcc-463e-b76c-7beee2786171@oracle.com>
 <CAN-5tyHgjfGDnaJkKaPFmU4M1WJiGnUh0LRFJ3GT2bvXNMdM_A@mail.gmail.com> <801ded98-5661-4e6b-b39f-2b3b7ad0981b@oracle.com>
In-Reply-To: <801ded98-5661-4e6b-b39f-2b3b7ad0981b@oracle.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 20 Mar 2025 16:46:58 -0400
X-Gm-Features: AQ5f1JqHSLMPtpkKKvDmhvvGdDiWCFw5oOdeYPN7FsLBG2BMCkH0cBqVHB2L2YQ
Message-ID: <CACSpFtD0T+avEk-gecCZkmEbQ5qKNf=K7mBUKMAYV1e-khV7-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix NLM access checking
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, neilb@suse.de, 
	Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:32=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 3/20/25 12:29 PM, Olga Kornievskaia wrote:
> > On Thu, Mar 20, 2025 at 9:58=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> Hi Olga -
> >>
> >> Thanks for taking a stab at this. Comments below.
> >>
> >>
> >> On 3/19/25 5:46 PM, Olga Kornievskaia wrote:
> >>> Since commit 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> >>> for export policies with "sec=3Dkrb5:..." or "xprtsec=3Dtls:.." NLM
> >>> locking calls on v3 mounts fail. And for "sec=3Dkrb5" NLM calls it
> >>> also leads to out-of-bounds reference while in check_nfsd_access().
> >>>
> >>> This patch does 3 fixes.
> >>
> >> That suggests to me this should ideally be three patches. That's a nit=
,
> >> really, but 3 patches might be better for subsequent bisection.
> >
> > I can break it into 3 patches but all would have "Fixes" for the same
> > patch, right?
>
> Yes.
>
>
> >>> 2 problems are related to sec=3Dkrb5.
> >>> First is fixing what "access" content is being passed into
> >>> the inode_permission(). Prior to 4cc9b9f2bf4df, the code would
> >>> explicitly set access to be read/ownership. And after is passes
> >>> access that's set in nlm_fopen but it's lacking read access.
> >>> Second is because previously for NLM check_nfsd_access() was
> >>> never called and thus nfsd4_spo_must_allow() function wasn't
> >>> called. After the patch, this lead to NLM call which has no
> >>> compound state structure created trying to dereference it.
> >>> This patch instead moves the call to after may_bypass_gss
> >>> check which implies NLM and would return there and would
> >>> never get to calling nfsd4_spo_must_allow().
> >>>
> >>> The last problem is related to TLS export policy. NLM dont
> >>> come over TLS and thus dont pass the TLS checks in
> >>> check_nfsd_access() leading to access being denied. Instead
> >>> rely on may_bypass_gss to indicate NLM and allow access
> >>> checking to continue.
> >>
> >> NFSD doesn't check that NLM is TLS protected because:
> >>
> >> a. the current Linux NFS client doesn't use TLS, and
> >> b. NFSD doesn't support NLM over krb5, IIRC.
> >>
> >> But that doesn't mean NLM will /never/ be protected by TLS.
> >
> > But if the future NFSD would support NLM with TLS wouldn't it be a new
> > feature with possible new controls. We'd still need existing code to
> > all interoperability with clients that don't support it (and thus
> > having a configuration that would allow NLM without TLS when xprtsec
> > is TLS-enabled?
> >
> >> I'm thinking aloud about whether the reorganization here might make
> >> adding TLS for NLM easier or more difficult. No conclusions yet.
> >
> > Do we need that complexity now vs if and when such support is added?
>
> The question is would we need to revert some or all of your patch
> to make that work in the future in order to support NLM with TLS.
> But perhaps that is an unanswerable question today.
>
>
> >>> Fixes: 4cc9b9f2bf4df ("nfsd: refine and rename NFSD_MAY_LOCK")
> >>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>
> >>> ---
> >>>  fs/nfsd/export.c | 23 +++++++++++++----------
> >>>  fs/nfsd/vfs.c    |  4 ++++
> >>>  2 files changed, 17 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> >>> index 0363720280d4..4cbf617efa7c 100644
> >>> --- a/fs/nfsd/export.c
> >>> +++ b/fs/nfsd/export.c
> >>> @@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_export *exp=
, struct svc_rqst *rqstp,
> >>>                   test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> >>>                       goto ok;
> >>>       }
> >>> -     goto denied;
> >>> +     if (!may_bypass_gss)
> >>> +             goto denied;
> >>>
> >>>  ok:
> >>>       /* legacy gss-only clients are always OK: */
> >>> @@ -1142,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *ex=
p, struct svc_rqst *rqstp,
> >>>                       return nfs_ok;
> >>>       }
> >>>
> >>> -     /* If the compound op contains a spo_must_allowed op,
> >>> -      * it will be sent with integrity/protection which
> >>> -      * will have to be expressly allowed on mounts that
> >>> -      * don't support it
> >>> -      */
> >>> -
> >>> -     if (nfsd4_spo_must_allow(rqstp))
> >>> -             return nfs_ok;
> >>> -
> >>>       /* Some calls may be processed without authentication
> >>>        * on GSS exports. For example NFS2/3 calls on root
> >>>        * directory, see section 2.3.2 of rfc 2623.
> >>> @@ -1168,6 +1160,17 @@ __be32 check_nfsd_access(struct svc_export *ex=
p, struct svc_rqst *rqstp,
> >>>               }
> >>>       }
> >>>
> >>> +     /* If the compound op contains a spo_must_allowed op,
> >>> +      * it will be sent with integrity/protection which
> >>> +      * will have to be expressly allowed on mounts that
> >>> +      * don't support it
> >>> +      */
> >>> +     /* This call must be done after the may_bypass_gss check.
> >>> +      * may_bypass_gss implies NLM(/MOUNT) and not 4.1
> >>> +      */
> >>> +     if (nfsd4_spo_must_allow(rqstp))
> >>> +             return nfs_ok;
> >>> +
> >>
> >> Comment about future work: This is technical debt (that's the 21st
> >> century term for spaghetti), logic that has accrued over time and is
> >> now therefore difficult to reason about. Would be nice to break
> >> check_nfsd_access() apart into "for NLM", "for NFS-legacy", and "for N=
FS
> >> with COMPOUND". For another day, perhaps.
> >>
> >>
> >>>  denied:
> >>>       return nfserr_wrongsec;
> >>>  }
> >>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >>> index 4021b047eb18..95d973136079 100644
> >>> --- a/fs/nfsd/vfs.c
> >>> +++ b/fs/nfsd/vfs.c
> >>> @@ -2600,6 +2600,10 @@ nfsd_permission(struct svc_cred *cred, struct =
svc_export *exp,
> >>
> >> More context shows there is an NFSD_MAY_OWNER_OVERRIDE check just
> >> before the new logic added by this patch:
> >>
> >>         if ((acc & NFSD_MAY_OWNER_OVERRIDE) &&
> >>
> >>>           uid_eq(inode->i_uid, current_fsuid()))
> >>>               return 0;
> >>>
> >>> +     /* If this is NLM, require read or ownership permissions */
> >>> +     if (acc & NFSD_MAY_NLM)
> >>> +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> >>> +
> >>
> >> So I'm wondering if this new test needs to come /before/ the existing
> >> MAY_OWNER_OVERRIDE check here? If not, the comment you add here might
> >> explain why it is correct to place the new logic afterwards.
> >
> > Why would you think this check should go before?
>
> Because this code is confusing.
>
> So, for NLM, MAY_OWNER_OVERRIDE is already set for the uid_eq check.
> The order of the new code is not consequential. But it still catches
> the eye.

I just re-checked the original code and the re(set)ing of acc was done
before the MAY_OWNER_OVERRIDE check. So changing my patch as you
suggest would be consistent with how things worked before. I will do
that.

> > NFS_MAY_OWNER_OVERRIDE is actually already set by nlm_fopen() when it
> > arrives in check_nfsd_access() .
>
> This code is /clearing/ the other flags too. That's a little subtle.
>
> The new comment should explain why only these two flags are needed for
> the subsequent code.

inode_permission() only care about READ, WRITE (EXEC)? NFSD_MAY_READ
is supposed to be the same as MAY_READ etc. Thus I believe passing
other values is of no consequence so to be honest I don't understand
why NFSD_MAY_OWNER_OVERRIDE is needed here. But what is of consequence
is (not) passing a NFSD_MAY_WRITE (which is what gets passed in by
nlm_fopen()).

> That is, explain not only why NFSD_MAY_READ is
> getting set, but also why NFSD_MAY_NLM and NFSD_MAY_BYPASS_GSS are
> getting cleared.
>
> Or, if clearing those flags was unintentional, make the code read:
>
>         acc |=3D NFSD_MAY_READ;
>
> I don't understand this code well enough to figure out why nlm_fopen()
> shouldn't just set NFSD_MAY_READ. Therefore: better code comment needed.

My comment came from the comment that was removed by commit
4cc9b9f2bf4df. I don't have a good understanding of the code to
provide a "better" comment.

nlm_fopen assigns the access based on the requested lock type. an
exclusive lock i'm assuming gets translated to the "write" =3D
NFSD_MAY_WRITE. But the the user might not have write access to the
file but still be allowed to request an exclusive lock on it, right?

@@ -2531,16 +2531,6 @@ nfsd_permission(struct svc_cred *cred, struct
svc_export *exp,
        if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
                return nfserr_perm;

-       if (acc & NFSD_MAY_LOCK) {
-               /* If we cannot rely on authentication in NLM requests,
-                * just allow locks, otherwise require read permission, or
-                * ownership
-                */
-               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
-                       return 0;
-               else
-                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
-       }
        /*
         * The file owner always gets access permission for accesses that
         * would normally be checked at open time. This is to make

>
>
> > Prior to the 4cc9b9f2bf4df inode_permission() would get NFSD_MAY_READ
> > | NFSD_MAY_OWNER_OVERRIDE in access argument. After, it gets
> > NFSD_MAY_WRITE | NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE |
> > NFSD_MAY_BYPASS_GSS. It made inode_permission() fail the call. Isn't
> > NLM asking for write permissions on the file for locking?
> >
> > My attempt was to return the code to previous functionality which
> > worked (and was only explicitly asking for read permissions on the
> > file).
>
> So the patch is reverting part of 4cc9b9f2bf4df; perhaps that should be
> called out in the patch description (up to you). However, the proposed
> fix doesn't make this code easier to understand, and that's probably my
> main quibble.
>
>
> > Unless you think more is needed here: I would resubmit with 3 patches
> > for each of the chunks and corresponding problems.
>
> Agreed, and I don't think I have any substantial change requests for the
> first two fixes.
>
>
> >>>       /* This assumes  NFSD_MAY_{READ,WRITE,EXEC} =3D=3D MAY_{READ,WR=
ITE,EXEC} */
> >>>       err =3D inode_permission(&nop_mnt_idmap, inode,
> >>>                              acc & (MAY_READ | MAY_WRITE | MAY_EXEC))=
;
> >>
> >>
> >> --
> >> Chuck Lever
> >>
>
>
> --
> Chuck Lever
>


