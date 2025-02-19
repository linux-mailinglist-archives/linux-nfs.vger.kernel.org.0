Return-Path: <linux-nfs+bounces-10194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0DA3C684
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0378179D86
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59786214A64;
	Wed, 19 Feb 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBOVO6Gh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED91B2190;
	Wed, 19 Feb 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987225; cv=none; b=ZvSaxp0dskyFir4kUrtWVkTWlvRvvYQSk6YHMIUXjt6jHdbvMfklmMt6KJm6petOC4ohGJYtih0vSGn6eAgL26+hsnketGbOX66nzGEDd5exWOoDzyx2ROIVoBKt0mu+fV021frYE/1UNMNd6gTD1HJ0YObBPTG+ug3uZPqQOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987225; c=relaxed/simple;
	bh=d1ZYeuMhHkO0oxqrYs8tJ5GFoQq1+LWcyNKh3GzB+D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMz9rqkn2VNUIrZ72T4pBsP15+sVjqC+HteYjljeQLx+fBDJR4aGCBXqO8JM02ygPOpWwVcP8+v4HT5+OQbCpJ50rL9F9Q5rt5/JoWS0bWavQmpdQYCT/4s/6eYouJv37y88sE7w3KVnymT0dYgBxKqY+ScBLAYjKIAbgJzqFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBOVO6Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F88FC4CED6;
	Wed, 19 Feb 2025 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987224;
	bh=d1ZYeuMhHkO0oxqrYs8tJ5GFoQq1+LWcyNKh3GzB+D8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vBOVO6GhlT8eBPw42HHqRm54oL+/iHxKtzZ9ROOKri3EgAGprnM+k/2tE/Mgpknzn
	 3eTzppigFo9vx4z2p8pgoiwvurmxqgphsDSIbM/ptGYc6/HoxozF+FTPudO+Zc09sp
	 rarRbXHRdS+59GKyr00Oc42ue4aVmIYOzhFhervJqq0BTocWyuWcDVAlPd1GmzU6eD
	 W46+JP0Tnn3mKwNaNiR529F83zfjpsoGMOweid4M1rIX+I1lbabF5N1bonrxXEiD6n
	 dwBAIQIPqsr/ciOEeFym4JSo4J1Ng+A7yGoxmgVIUr47chYq5UkCtAJO5FUWj6tgKl
	 QzPVN2arCF2/g==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso5725315a12.3;
        Wed, 19 Feb 2025 09:47:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsjf1ktAmldVYxvn0TfAI6K04vpjKGCVK4tXDtz6eKs6IVBQQghUoO2W65qd0QxxFCc4elK7IGZbjYGfhN@vger.kernel.org, AJvYcCWGTJi2GVutRWolnaD0SC2XPNG6F5R4oHcwI7MPreArJ35UIbWODAYb4lGjSA5nr1Pxz7ojIecTQIpJ@vger.kernel.org, AJvYcCWKxanwdfVXT9bROkLWlCNvHQ9SphvhaQiYWMvO5w/r5sh5PjVZVACRRI7bKyeq87sws9GQhQlwqKwBogrBU9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77Cw68nrbsc5Plia8DmQLJZ1CGAz5+w02Xzqx4kGLniYd8BLV
	7npJety2XT4OxWFG/zRoC77DRyZ42+EFHBg3m7CjDmyMltRoCxapeZJbFlyvK2FAP5GJ7RhDOz8
	bfN9kwaG6tDmGKRvb5KlNRJaD6XQ=
X-Google-Smtp-Source: AGHT+IHMuMzeLdy87fphSwNbOzws8EQSnWlpHEJlABRsSLOUOmHw8YJ13jFgwAbCrZy1KT5wACv78lRZkZtQqa41m0k=
X-Received: by 2002:a05:6402:34ce:b0:5e0:82a0:50c8 with SMTP id
 4fb4d7f45d1cf-5e089f3025dmr4119566a12.27.1739987223500; Wed, 19 Feb 2025
 09:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6GDiLZo5u4CqxBr@kspp> <b16ac12f-166a-4d25-bf33-b1ccf6e0dac7@oracle.com>
 <57b70bbc-c8d0-4181-98a9-5174517270a0@oracle.com>
In-Reply-To: <57b70bbc-c8d0-4181-98a9-5174517270a0@oracle.com>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 19 Feb 2025 12:46:46 -0500
X-Gmail-Original-Message-ID: <CAFX2Jf=yktJ_Bz--c2VpoDmW13YyoY3MNSv5sJYSseWBGAV9Cw@mail.gmail.com>
X-Gm-Features: AWEUYZnSA-6PhHxWEf7laZ9dCHU7tRJodeeCclNmgyrJB448BV0Q7SFWROUMohU
Message-ID: <CAFX2Jf=yktJ_Bz--c2VpoDmW13YyoY3MNSv5sJYSseWBGAV9Cw@mail.gmail.com>
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

Hi Chuck,

On Tue, Feb 18, 2025 at 1:10=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 2/10/25 2:48 PM, Chuck Lever wrote:
> > On 2/3/25 10:03 PM, Gustavo A. R. Silva wrote:
> >> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> >> getting ready to enable it, globally.
> >>
> >> So, in order to avoid ending up with a flexible-array member in the
> >> middle of other structs, we use the `struct_group_tagged()` helper
> >> to create a new tagged `struct posix_acl_hdr`. This structure
> >> groups together all the members of the flexible `struct posix_acl`
> >> except the flexible array.
> >>
> >> As a result, the array is effectively separated from the rest of the
> >> members without modifying the memory layout of the flexible structure.
> >> We then change the type of the middle struct member currently causing
> >> trouble from `struct posix_acl` to `struct posix_acl_hdr`.
> >>
> >> We also want to ensure that when new members need to be added to the
> >> flexible structure, they are always included within the newly created
> >> tagged struct. For this, we use `static_assert()`. This ensures that t=
he
> >> memory layout for both the flexible structure and the new tagged struc=
t
> >> is the same after any changes.
> >>
> >> This approach avoids having to implement `struct posix_acl_hdr` as a
> >> completely separate structure, thus preventing having to maintain two
> >> independent but basically identical structures, closing the door to
> >> potential bugs in the future.
> >>
> >> We also use `container_of()` whenever we need to retrieve a pointer to
> >> the flexible structure, through which we can access the flexible-array
> >> member, if necessary.
> >>
> >> So, with these changes, fix the following warning:
> >>
> >> fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexible=
 array member is not at the end of another structure [-Wflex-array-member-n=
ot-at-end]
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >>  fs/nfs_common/nfsacl.c    |  8 +++++---
> >>  include/linux/posix_acl.h | 11 ++++++++---
> >>  2 files changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> >> index ea382b75b26c..e2eaac14fd8e 100644
> >> --- a/fs/nfs_common/nfsacl.c
> >> +++ b/fs/nfs_common/nfsacl.c
> >> @@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
> >>  };
> >>
> >>  struct nfsacl_simple_acl {
> >> -    struct posix_acl acl;
> >> +    struct posix_acl_hdr acl;
> >>      struct posix_acl_entry ace[4];
> >>  };
> >>
> >> @@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned in=
t base, struct inode *inode,
> >>          xdr_encode_word(buf, base, entries))
> >>              return -EINVAL;
> >>      if (encode_entries && acl && acl->a_count =3D=3D 3) {
> >> -            struct posix_acl *acl2 =3D &aclbuf.acl;
> >> +            struct posix_acl *acl2 =3D
> >> +                    container_of(&aclbuf.acl, struct posix_acl, hdr);
> >>
> >>              /* Avoid the use of posix_acl_alloc().  nfsacl_encode() i=
s
> >>               * invoked in contexts where a memory allocation failure =
is
> >> @@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xdr,=
 struct inode *inode,
> >>              return false;
> >>
> >>      if (encode_entries && acl && acl->a_count =3D=3D 3) {
> >> -            struct posix_acl *acl2 =3D &aclbuf.acl;
> >> +            struct posix_acl *acl2 =3D
> >> +                    container_of(&aclbuf.acl, struct posix_acl, hdr);
> >>
> >>              /* Avoid the use of posix_acl_alloc().  nfsacl_encode() i=
s
> >>               * invoked in contexts where a memory allocation failure =
is
> >> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> >> index e2d47eb1a7f3..62d497763e25 100644
> >> --- a/include/linux/posix_acl.h
> >> +++ b/include/linux/posix_acl.h
> >> @@ -27,11 +27,16 @@ struct posix_acl_entry {
> >>  };
> >>
> >>  struct posix_acl {
> >> -    refcount_t              a_refcount;
> >> -    unsigned int            a_count;
> >> -    struct rcu_head         a_rcu;
> >> +    /* New members MUST be added within the struct_group() macro belo=
w. */
> >> +    struct_group_tagged(posix_acl_hdr, hdr,
> >> +            refcount_t              a_refcount;
> >> +            unsigned int            a_count;
> >> +            struct rcu_head         a_rcu;
> >> +    );
> >>      struct posix_acl_entry  a_entries[] __counted_by(a_count);
> >>  };
> >> +static_assert(offsetof(struct posix_acl, a_entries) =3D=3D sizeof(str=
uct posix_acl_hdr),
> >> +          "struct member likely outside of struct_group_tagged()");
> >>
> >>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
> >>      for(pa=3D(acl)->a_entries, pe=3Dpa+(acl)->a_count; pa<pe; pa++)
> >
> > Trond, Anna -
> >
> > Let me know if I need to take this one via the NFSD tree. If not,
> >
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
>
> Gentle ping: Still waiting for a response.

If you want it, it's yours! :)

I am planning a bugfixes pull request soon, so I don't mind taking it
if you don't have anything else planned for 6.14 at the moment.

Anna
>
>
> --
> Chuck Lever

