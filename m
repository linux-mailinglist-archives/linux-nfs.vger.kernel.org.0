Return-Path: <linux-nfs+bounces-20712-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGOrAHII1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20712-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:36:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E93AF40E
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BC331107B5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78F3B774A;
	Tue,  7 Apr 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="UVk77sC4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AA3B6C10
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568524; cv=pass; b=G/GOPpmMXivxaGgrDWQsnXx4TrJ0lmcAW0/5MQTlkT4gySwIgMKwLbUvWsOsLwDp0FBrIDNrLAFlHo7bAEHJMRvZbW8e3oGFkNLOdLkVqh8QYY4eHsCIRa7HCe36aGu0u5BkBGX1HeIeUEIoG/az3ZnUbndMAzxw45iKyeieMs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568524; c=relaxed/simple;
	bh=8xcV5YsEwmkL3XbBRVxSFXDnGgyeExR/SEx+g992Pw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIfL5wGFez85jq2QJl3M3oKpJ2h1Dtyp6qODKofNRSGvYPxhEj/LNur0IVMC3zC9NPFCYPKc8+YRfqGAmup0tIQsf92xKSR7Uor8ChyFdzTmvAy5KxZL7A0F2tYGt5Zivv+XW2QjUtGzfXtIFRQ54ENyjyh05xydTHKQ/2sjlM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=UVk77sC4; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38de18126e7so32846581fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 07 Apr 2026 06:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775568521; cv=none;
        d=google.com; s=arc-20240605;
        b=ByAxzqrNEsr2VjJTPfdfmaLnW+Cydrr2sktRkIZIZlgKvIOOPY1Ksym+s8niQcoimd
         NhSHup1LGc0kKchZkkpt1jgfHkkLcuQiFWx5WaPnDgmqMyhSKT1TJICxdcSnw8+/XAjs
         0rjMG2qMGG1lMOP4gISGu2g5kpgI2fu7o54buQi8X046qBqVDm5k69m5qsk4JddmewlF
         /HqVIKiaNGkzQYnQJpEX75QiCmaZCD2a60M1KerN6ld2hDcra9iiKb+fREHnRT8DwzPf
         JM7P8NHnaTG9cbf7SFx0r7LL3rQYHtBSV+lD/RM5DMhJB5M06uLdLtV6w9h5udlM22+C
         /SoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vy9PYbHoKvdIUFjD1fFkeFz7oDowI5rlM8OkWfhJ0rY=;
        fh=EudDIgb3XoiCVnCvI8GIYSLke2OBkfz/Y7b14xpdymA=;
        b=h7KsdJ0FhddtDOLKldn2yEmuFtZmDlCi3T0hHmDsYapxS0O8cM9CdEJU/jR0sTWgBq
         64FBM3xzc6+wNPaBDD8XN0+qas2amo8OtxkiL8aWLvv8Ccqdyw1Bo3blZaYpMiY7DAVk
         E+AJA09l/oA0DEIL7xQnTwk2bQ6L1YtyxqfpeYmWC/Edh15N25ZaZOkHoEINJLc3NboV
         LqLT18mENaTvur6yXzFn5fB0XywlfuviwL51nb0Zh1eDEX5mP1qr/uOkk7f09j93J3on
         o646lXbdA1IO+n2qCZGvZIiyREA2elf1TfdJO2BQg9H2T31aJpOu4Cfhfi29VnTfcWgL
         S+Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775568521; x=1776173321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy9PYbHoKvdIUFjD1fFkeFz7oDowI5rlM8OkWfhJ0rY=;
        b=UVk77sC437YoPJYPH59SCDJccHlXnIeC9Vt0UiZO1JDGn2bGwd8X9j5K1BHQZF9j+u
         ijWS/MRqbHrBsmPyxukKCVAZACYVjZPGvCE5+xa2rHwdRqFpJMmUoFNjcQ2QKc/CbBuZ
         U2d0TAWFpS7sQ5rTyf01pDrLR5v5zrEXOvGV+qBh6QGDSzrzDqAgBWQCcWqud2m9Dqbq
         6uHA+FbFxj50DgnfqcQ/GwsUSiJToVSbBRDJFdlWzQnc67YhA5EbDS0/Q/+7aEDcl8cF
         TPmfL++Y5M4KYhsUzjWIzxYhCzad9g6Tcns6YlsgH5U9juem4hfAI0ntuMXPCOqGpQMN
         fwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568521; x=1776173321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vy9PYbHoKvdIUFjD1fFkeFz7oDowI5rlM8OkWfhJ0rY=;
        b=kLhlOWpLPd7Ift4cuL3oKUYvr82uaGs2goT/gVXDgeP5BAlWJeTYCMcbZkDv9TACRH
         GqD0azjotTgvRWPs3wizWR2pfhAsAq95FKopYhYqB5cxiSglXPFnfZlaKNexIrYf4C6X
         jAsPtUvfaEkdaMAhZC0mxPYF3OL1FQDyCrX6QFI+jQclhr5MHxtYj9ZCkZxnRnIGzCvq
         lRQbB4qV/WBo7G22i7/otdcetBKCshJR21ieZ8mZPUHS6RntzbpvUoJ2dYRWeNAFYQgU
         tLBNcKbbko78h/DeKlluJ7Yulb42b/g11YaqxUIa9lwbDyA7SuY+scxbaYwTwWsLBYSz
         L2aw==
X-Forwarded-Encrypted: i=1; AJvYcCVRcOZCc3iEjQSrrtK/ygljNtRiPCMTU+dnj1uuvgMxj6kVUkvWzAbhQLUrJYNMO5t0gr+Zlpu7R44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9oPVsiX/G5V/B1TwgzJF2JDYVQQlkgg/8g9KRGe8lXKE0xUYj
	Nb3+KqDTtV4rlQDDaBJ6fgoWMXYwpUHlf53nh8jZ93w3weY2LOioyoHTenJ6C63RMfMGygyhCaM
	RYGUp39k6vCe/8BsfXEb5v7/iN9rD1SI=
X-Gm-Gg: AeBDiesiNmYSVXhZFvKgzxGKIw1p6Nw79CLlXdWbri4Nw4PA3zB/uZWsmBH5NPIUZS2
	OJQIFd5ZBabF4fyvYY4K8+WA5rFVKtddOp1dAmzvji5aUzex9S5zKagWiXOlqKcXWJO5ucUhn3r
	4n978ybNoNM5V57ttp5W/zGWLVfW/Bt5CcrJLSbuqEKKtHvj/IxAGZiIulf2fURUFcYaUWUGZRz
	rU8ts8/qpDc//oForSkIooaqwGpzrhYvYA38DasNYP/b90ilfnhKNQk+kH7OlnISKyfheq6nNNw
	2aUTEC+ZXATK0MePtlCQHmTHCgmtQln6daOHZORF
X-Received: by 2002:a05:651c:4209:b0:38e:12b:a77f with SMTP id
 38308e7fff4ca-38e012baa17mr24915231fa.6.1775568520617; Tue, 07 Apr 2026
 06:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-1-d110da3c0036@kernel.org> <c36648f66b6e66f8aa555528c8969b1350c3a36f.camel@kernel.org>
In-Reply-To: <c36648f66b6e66f8aa555528c8969b1350c3a36f.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 7 Apr 2026 09:28:28 -0400
X-Gm-Features: AQROBzBBO9Bq6NpqAsp39TE04WOuuIF0MaWZsI01LRgS-tXPP0zyeQLk-3VRxBk
Message-ID: <CAN-5tyF2nxMaGsQS1B3oAMizGoCGvnTBYNgS9kMOfNoKKcwHxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfs: fix utimensat() for atime with delegated timestamps
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20712-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:dkim,umich.edu:email]
X-Rspamd-Queue-Id: 4E5E93AF40E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jeff and all,

With this patch and running against a server that would update the
c/mtime of a GETATTR in a compound with CLONE(COPY),  the timestamps
is (might be) going "backwards"? I see that SETATTR+DELEGRETURN (after
the CLONE) is setting a timestamp which is earlier than what's
returned by the server in the GETATTR. Though I haven't figured out
how to "show" it via test (I observe it on a network trace).

This is seen testing either against Hammerspace which already updates
the values or the linux server with the patch I'm working on to update
timestamp for CLONE/COPY.

I have to say I haven't figured out if this patch needs to modify such
that it fixes 221 but doesn't break 407 or we are fundamentally
dealing with a problem of including a GETATTR in a compound while
holding an attribute delegation that needs to be solved differently.
Like I said before, if the server were to update the value upon
receiving the GETATTR in the compound (regardless of the origin),
should it then do a CB_GETATTR first (which I already grumbled seems
like a poor choice)? Or, should the client be changed to not send a
GETATTR in CLONE of the compounds if it's holding an attribute
delegation and somehow figure out attributes differently then it does
now.


On Wed, Mar 25, 2026 at 8:30=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2026-03-24 at 13:32 -0400, Jeff Layton wrote:
> > xfstest generic/221 is failing with delegated timestamps enabled.  When
> > the client holds a WRITE_ATTRS_DELEG delegation, and a userland process
> > does a utimensat() for only the atime, the ctime is not properly
> > updated. The problem is that the client tries to cache the atime update=
,
> > but there is no mtime update, so the delegated attribute update never
> > updates the ctime.
> >
> > Delegated timestamps don't have a mechanism to update the ctime in
> > accordance with atime-only changes due to utimensat() and the like.
> > Change the client to issue an RPC in this case, so that the ctime gets
> > properly updated alongside the atime.
> >
> > Fixes: 40f45ab3814f ("NFS: Further fixes to attribute delegation a/mtim=
e changes")
> > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/inode.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 4786343eeee0f874aa1f31ace2f35fdcb83fc7a6..3a5bba7e3c92d4d4fcd6523=
4cd2f10e56f78dee0 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -757,14 +757,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry=
 *dentry,
> >       } else if (nfs_have_delegated_atime(inode) &&
> >                  attr->ia_valid & ATTR_ATIME &&
> >                  !(attr->ia_valid & ATTR_MTIME)) {
> > -             if (attr->ia_valid & ATTR_ATIME_SET) {
> > -                     if (uid_eq(task_uid, owner_uid)) {
> > -                             spin_lock(&inode->i_lock);
> > -                             nfs_set_timestamps_to_ts(inode, attr);
> > -                             spin_unlock(&inode->i_lock);
> > -                             attr->ia_valid &=3D ~(ATTR_ATIME|ATTR_ATI=
ME_SET);
> > -                     }
> > -             } else {
>
> This probably deserves a comment. How about something like:
>
>                 /*
>                  * An atime-only update via an explicit setattr (e.g.: ut=
imensat() and
>                  * the like) requires updating the ctime as well. Delegat=
ed timestamps
>                  * don't have a mechanism for updating the ctime with a d=
elegated
>                  * atime-only update, so an RPC must be issued.
>                  */
>
> > +             if (!(attr->ia_valid & ATTR_ATIME_SET)) {
> >                       nfs_update_delegated_atime(inode);
> >                       attr->ia_valid &=3D ~ATTR_ATIME;
> >               }
>
> --
> Jeff Layton <jlayton@kernel.org>

