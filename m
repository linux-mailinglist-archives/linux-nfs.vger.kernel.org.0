Return-Path: <linux-nfs+bounces-10196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA7A3C6B2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836377A5E89
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0662144C2;
	Wed, 19 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1OS2KG+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694461B6CE1;
	Wed, 19 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987467; cv=none; b=J/OaTET0PqnBUSqkhFhcu2wwhzSeGKQcWDKGxOmHfocNtYALWlTQznuyKxMS6uivnaZMsnVnB2YDEH9ny8F0EAk0ZNhPp/eHSmM7yoHOp//cBljnwu7LpX2oL/wlCwvR5ps3KDVIRlm7/lYfU27gpr/2KJkOkNZY4yoTep8taY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987467; c=relaxed/simple;
	bh=rZq5shPOxTksQy7eMPX745S268mJN4kuifZgD2XUNDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iild6iqgWcIjE0VnhZdMfDQCsTtX25KiLR7/E/x3W5cEZTmOgIUAZv5STaOx/TWoUH4k1PgEAlg0N7KH5bbnW70onrD6XTKzYJ0nraMSJv4aVW2J05O/pXDTGBFLiWj2loEx2DB/igIv/mMCrLWc9qkG7uFv/3JKYJpNbDgdi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1OS2KG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B3CC4CEE6;
	Wed, 19 Feb 2025 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987466;
	bh=rZq5shPOxTksQy7eMPX745S268mJN4kuifZgD2XUNDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i1OS2KG+o4RQ4riPqf1kn536az+uq1VE29UXllFEmktDRwvaxtqEm5MjOuWxqTOvo
	 U86FKb8bSUgqcgC9tbboS5FX1KTXorjuJKBPpYNkm27Eg6Qg3pzJrrv72rIkL/4bbF
	 bU7HTvbpzfbcpTN6T8EJHDpAkQMNb7xCBZeUcXKqmsb/WiPOXhvL+Of2Rs7kZ5z5pt
	 Bz/2am8SNYOZrIl+XDKDotcWjf+3m7OpINQain3AAz5rTL9Fwb0r/tL3xmm6gvGUeV
	 9xfqeduF8bl5MZXDZ9MDCwBLKZAl+dfq3cHpNBTHB3neq8zXvkupv2SfCWMO98sh5I
	 lTMv9VSBHMGXw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so174934a12.1;
        Wed, 19 Feb 2025 09:51:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD5HvrNhC+6ZhGhrqNAb8StLBJdZsidzElA6cSJJHBOIIRSo8F8jj1kFHCUIslKObKM9hDrT0Z2iUYUut7hNI=@vger.kernel.org, AJvYcCVQeK8DqEmYbyW6ibZXB9Q23x/HhLBB/s4pK3XqxehV626MNBeB79bD0ZD7CsvjfpHS6RAiThTCgwQq@vger.kernel.org, AJvYcCWkXn+pxpg6YF/SctZhKxo+eSCUM/tDtcnMt/ZsiekN27zEDM8J4G88vs0wEKb9gLcCx3NhSUgw3Jgt1Ysb@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/TP1S5ce2KWdOV1tcqcQ/AdTLrp1V+QEHMeGNfnghMwK+sz9
	F10r/6faHl8Hzx2IFsh53g6d2rXqt/Thhz/ffsBGneDLtglRggOvIbLDffN+J1moGvjJezhQG6/
	5/WJH0AWLZ4Lrha7m15/DH6h8a1k=
X-Google-Smtp-Source: AGHT+IEcIR2sCxUot4XQbj6ANo59l5iFBJbJzbCYxaaMIQFtGd/3ncuB0BdMQ6St84iPMy5+WzS3SOBdcqQAMyhhJ/w=
X-Received: by 2002:a05:6402:3215:b0:5dc:8fc1:b3b5 with SMTP id
 4fb4d7f45d1cf-5e0a12c7561mr128280a12.15.1739987465682; Wed, 19 Feb 2025
 09:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6GDiLZo5u4CqxBr@kspp> <b16ac12f-166a-4d25-bf33-b1ccf6e0dac7@oracle.com>
 <57b70bbc-c8d0-4181-98a9-5174517270a0@oracle.com> <CAFX2Jf=yktJ_Bz--c2VpoDmW13YyoY3MNSv5sJYSseWBGAV9Cw@mail.gmail.com>
 <0e5cf4db-8a69-4416-8514-b76daed3455c@oracle.com>
In-Reply-To: <0e5cf4db-8a69-4416-8514-b76daed3455c@oracle.com>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 19 Feb 2025 12:50:47 -0500
X-Gmail-Original-Message-ID: <CAFX2JfnrYnV664Ri-GJHqO6R72D+NJh0wKQRiKeKQWsQVq_QyA@mail.gmail.com>
X-Gm-Features: AWEUYZmlJVmxNQW2wPkxZPYr4I0e1aqLvM8sMvVGx2Y7icsiLY0AlDZFh7qSzZw
Message-ID: <CAFX2JfnrYnV664Ri-GJHqO6R72D+NJh0wKQRiKeKQWsQVq_QyA@mail.gmail.com>
Subject: Re: [RESEND PATCH][next] fs: nfs: acl: Avoid -Wflex-array-member-not-at-end
 warning
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>, 
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:49=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 2/19/25 12:46 PM, Anna Schumaker wrote:
> > Hi Chuck,
> >
> > On Tue, Feb 18, 2025 at 1:10=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 2/10/25 2:48 PM, Chuck Lever wrote:
> >>> On 2/3/25 10:03 PM, Gustavo A. R. Silva wrote:
> >>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> >>>> getting ready to enable it, globally.
> >>>>
> >>>> So, in order to avoid ending up with a flexible-array member in the
> >>>> middle of other structs, we use the `struct_group_tagged()` helper
> >>>> to create a new tagged `struct posix_acl_hdr`. This structure
> >>>> groups together all the members of the flexible `struct posix_acl`
> >>>> except the flexible array.
> >>>>
> >>>> As a result, the array is effectively separated from the rest of the
> >>>> members without modifying the memory layout of the flexible structur=
e.
> >>>> We then change the type of the middle struct member currently causin=
g
> >>>> trouble from `struct posix_acl` to `struct posix_acl_hdr`.
> >>>>
> >>>> We also want to ensure that when new members need to be added to the
> >>>> flexible structure, they are always included within the newly create=
d
> >>>> tagged struct. For this, we use `static_assert()`. This ensures that=
 the
> >>>> memory layout for both the flexible structure and the new tagged str=
uct
> >>>> is the same after any changes.
> >>>>
> >>>> This approach avoids having to implement `struct posix_acl_hdr` as a
> >>>> completely separate structure, thus preventing having to maintain tw=
o
> >>>> independent but basically identical structures, closing the door to
> >>>> potential bugs in the future.
> >>>>
> >>>> We also use `container_of()` whenever we need to retrieve a pointer =
to
> >>>> the flexible structure, through which we can access the flexible-arr=
ay
> >>>> member, if necessary.
> >>>>
> >>>> So, with these changes, fix the following warning:
> >>>>
> >>>> fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexib=
le array member is not at the end of another structure [-Wflex-array-member=
-not-at-end]
> >>>>
> >>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>>> ---
> >>>>  fs/nfs_common/nfsacl.c    |  8 +++++---
> >>>>  include/linux/posix_acl.h | 11 ++++++++---
> >>>>  2 files changed, 13 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> >>>> index ea382b75b26c..e2eaac14fd8e 100644
> >>>> --- a/fs/nfs_common/nfsacl.c
> >>>> +++ b/fs/nfs_common/nfsacl.c
> >>>> @@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
> >>>>  };
> >>>>
> >>>>  struct nfsacl_simple_acl {
> >>>> -    struct posix_acl acl;
> >>>> +    struct posix_acl_hdr acl;
> >>>>      struct posix_acl_entry ace[4];
> >>>>  };
> >>>>
> >>>> @@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned =
int base, struct inode *inode,
> >>>>          xdr_encode_word(buf, base, entries))
> >>>>              return -EINVAL;
> >>>>      if (encode_entries && acl && acl->a_count =3D=3D 3) {
> >>>> -            struct posix_acl *acl2 =3D &aclbuf.acl;
> >>>> +            struct posix_acl *acl2 =3D
> >>>> +                    container_of(&aclbuf.acl, struct posix_acl, hdr=
);
> >>>>
> >>>>              /* Avoid the use of posix_acl_alloc().  nfsacl_encode()=
 is
> >>>>               * invoked in contexts where a memory allocation failur=
e is
> >>>> @@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xd=
r, struct inode *inode,
> >>>>              return false;
> >>>>
> >>>>      if (encode_entries && acl && acl->a_count =3D=3D 3) {
> >>>> -            struct posix_acl *acl2 =3D &aclbuf.acl;
> >>>> +            struct posix_acl *acl2 =3D
> >>>> +                    container_of(&aclbuf.acl, struct posix_acl, hdr=
);
> >>>>
> >>>>              /* Avoid the use of posix_acl_alloc().  nfsacl_encode()=
 is
> >>>>               * invoked in contexts where a memory allocation failur=
e is
> >>>> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> >>>> index e2d47eb1a7f3..62d497763e25 100644
> >>>> --- a/include/linux/posix_acl.h
> >>>> +++ b/include/linux/posix_acl.h
> >>>> @@ -27,11 +27,16 @@ struct posix_acl_entry {
> >>>>  };
> >>>>
> >>>>  struct posix_acl {
> >>>> -    refcount_t              a_refcount;
> >>>> -    unsigned int            a_count;
> >>>> -    struct rcu_head         a_rcu;
> >>>> +    /* New members MUST be added within the struct_group() macro be=
low. */
> >>>> +    struct_group_tagged(posix_acl_hdr, hdr,
> >>>> +            refcount_t              a_refcount;
> >>>> +            unsigned int            a_count;
> >>>> +            struct rcu_head         a_rcu;
> >>>> +    );
> >>>>      struct posix_acl_entry  a_entries[] __counted_by(a_count);
> >>>>  };
> >>>> +static_assert(offsetof(struct posix_acl, a_entries) =3D=3D sizeof(s=
truct posix_acl_hdr),
> >>>> +          "struct member likely outside of struct_group_tagged()");
> >>>>
> >>>>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
> >>>>      for(pa=3D(acl)->a_entries, pe=3Dpa+(acl)->a_count; pa<pe; pa++)
> >>>
> >>> Trond, Anna -
> >>>
> >>> Let me know if I need to take this one via the NFSD tree. If not,
> >>>
> >>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Gentle ping: Still waiting for a response.
> >
> > If you want it, it's yours! :)
> >
> > I am planning a bugfixes pull request soon, so I don't mind taking it
> > if you don't have anything else planned for 6.14 at the moment.
>
> This change doesn't look like a "fix" to me, so I would include it in
> nfsd-testing / nfsd-next, as long as you (or Trond) can send me an
> Acked-by.

Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

>
>
> --
> Chuck Lever

