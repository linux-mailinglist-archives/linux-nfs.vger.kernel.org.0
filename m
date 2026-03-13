Return-Path: <linux-nfs+bounces-20141-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KxRFGbBs2mEagAAu9opvQ
	(envelope-from <linux-nfs+bounces-20141-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 08:48:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC80A27EF94
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 759193016C9A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75D32ED32;
	Fri, 13 Mar 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIMW47ff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0363375C5
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388131; cv=pass; b=fcaNIxAl1ub8F1d22Ov4PBpQBbK7V5Q28SFoY8Ol8lHigB5+uMoxySiWUQUGfgOdVlHjuP1ICPB1EYhN2ozaSmrugukXuue0jwzFp6KWhyubexRq0IAw5LWGSxCjwOuspNR6Dfp7t0uwSSQCdL4CjthrrVx3xW1sqHiFFpAy/uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388131; c=relaxed/simple;
	bh=aPicCyBvHIB1Nnvt60mnyduee5HrIS4HKOLlnxU0qrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWw84ODGn1FBcDUiYqUfaq4/57cvfNn0BB0jU1XCu6AGgnkx99JtDe7V4YxtdUBE9dVacrRoq1koQNqNmYzvVnpdxMg87kFS9a7cWPZswNuIqm91++NZt3fk9saK9xQXXoBKvEke+VYYeRlkQQZMU6Qc6g6m02/PkENLSAoAtes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIMW47ff; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b955351e0a6so313523966b.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 00:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773388128; cv=none;
        d=google.com; s=arc-20240605;
        b=HNMQ3IXedUn72IBjCm4gc77ZMhWIpaVOaOVL2FS2d+1Plap3Xxj8Tr5PIQPh9pGldf
         O+EQYsnFHxMQAx25upAo2nJ3bJ+yis6wdG8Uv79azxOdALEwcKCbCDIljyObgA5oeb/e
         aYrvssVU1FbiTON3swDkB7aoyBbjj36SNtvCKC7R2lvj1dZz9gryOBixGqrYClr3uPNy
         bZMpT570g9/GNyZlOsg5LPHcoa1ge+YadzpJVc8N/S/7ObNw+773TS/Nd8gWg3qJVRSd
         J8yDV2DsPcihOifiqDVepDbnkCfLwIFPpF8VU65IVlJ36xhyxINhwYQ04+tpYARZVipA
         +KNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aPicCyBvHIB1Nnvt60mnyduee5HrIS4HKOLlnxU0qrk=;
        fh=DhjGmOSiaVrhsYQCKCbdu9kCDrgOTsS+LKOOTnQbd68=;
        b=c4t9ODILyp+i85vkvQQ/gi7sn8f0Glze5bHZ891NoTCWtqk0K7GCZX86YdNUqEck1Y
         4ifZAjBHcTH4uK0q5OZ9nM/AW8aBQrYbsTgUMoFL0O1flqqQMZaTMleeY8fjIDcs/L6r
         xDWjoB3FvSBXubNVlSA+3Uo3Cw5FZq6jmpcBIFqOfjr3608wXnamp4jWNUxWA8nvwAmJ
         Joy3rfPzt4IAxx/M7Cq3AKNmSqvHQuue7GiT4igNxSsKG14OY8vN+K9Sx2HDWioja2gu
         HyVjy4+3+mT4q4iff2bX9WFFUV9cMPGkd6DymueR1rX4TVocaglFm7pm0BpU7/f73+CU
         2M9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773388128; x=1773992928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPicCyBvHIB1Nnvt60mnyduee5HrIS4HKOLlnxU0qrk=;
        b=EIMW47ffo6gx6rkYOlTR7U38OLrYTfeQjBfis1QOserUM3LUDawH5Gk0jdjXRh2WpT
         3biKBe719GLSy6k3zi2N7bodD0GIjqdh1BAH2u871oWJa8wb/lsZe5YaHgd+HNZAT4eV
         nCEn218OUqUGIhu4YL4+rIGcc9NbY/DiDYRS7NirkDYKcEnb/bk+gjQG0G0dRqZKm4jl
         2IKiYgIKc/5bDiNZ2ImiiwMF5DyluuKD7Ny+2aJKOWQ5aHQ8di3SKN0PjAVdw5HQsXeL
         dcr411nzSFjIeXeZTvLvV78+1ie9OTHyHoHapVp7Pe2kQGeyY+NM/URebvFq4SqIot1a
         IyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773388128; x=1773992928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPicCyBvHIB1Nnvt60mnyduee5HrIS4HKOLlnxU0qrk=;
        b=dE60GIPGSIiqtGWLgFE8DqpzgrL1vY/80LHnUI4RrE2QRV8hgXSQi0k7NyemjOy3dS
         5VWpJ8otkkvEAqJ4jsdMG9jDLR8uILXScTpcBy4K0DKLSa8FmwV6II00geSZmkKKAK6k
         0ql2qCQYVA9cvedxQgyEsJjAxVZ1xluYbDQK3WgmL4isKYU9IoxhfXRn3tHFTNiP5ABV
         AU06VS+lZA6rPbtu3xxdXd7SZ95GOO3jX9eTtgoS8JA2lnZwL52XVTxizsNm7+fcZzIe
         7StlGZROEv1ucgQWtj13CPy1c+ajuExUoIarcFXEVZnbqj/9Bc5L88dYOMFOXhrISDD9
         wttQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBfRUv3xgOXXXjiKlxavmW+h2ZW97qrlA8YSbipYU99O8O3jYgdy/xS3+hSuhf/UncwcRNHjK7LqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGT2GMpOWbZmUHg5fUjeOCqfl3KIrQbt6iZycsLVkj7iFOBBj
	eL2Qyy00vomAcgAk0wL93EWfwz/izj+9o+6MpDu/Qm1LHmdZl2vShqSugfkKQc9MRAoHpMROQYf
	mRheL9tMk/RaHA8X/1MnX8FsG3iyilJQ=
X-Gm-Gg: ATEYQzyFwSK9Uz9vJ0l+xew5jYfqAHWp2UM5OWbwd8s7eRI3qfP9y4kUwpbkw18r1xr
	c2A9/5Twlspxa5wEKBNuUcyBVhabuBEH9dA5uvBgfHDe2l+WPjHjMgmBhjozeiBkSEtoYdWAk0P
	cVTodzQKEThMDNrQWt77/r3cJ+6mpvjMj6BRalim5CFNsWPd2hBNRtEuRjPgt/wXMF/8r/jG1N2
	EdV5uHGERbK+4P1wXRa8k0Dz88dRP1WqffoQw4pTF8kPhYjMQnIn6oY3KLM1BC+EURou375D4gD
	3hzr0LCoMNEBrpakMiGAMQPbewh5MhUzw4x2aRWpLde4QaIPk1Yi2qqFkTMnjLdt/Xa2gQ==
X-Received: by 2002:a17:907:25cc:b0:b8e:36ec:88e1 with SMTP id
 a640c23a62f3a-b9765318e41mr116229066b.61.1773388128180; Fri, 13 Mar 2026
 00:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net> <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
 <780e05c1-f790-41e5-a0e5-cf7484e31a92@oracle.com>
In-Reply-To: <780e05c1-f790-41e5-a0e5-cf7484e31a92@oracle.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Fri, 13 Mar 2026 08:48:11 +0100
X-Gm-Features: AaiRm50fbgJE0R0DX34Pwk5ATeDyiThbFlX_oQxqj0ooqX4GdeycHhsA2YsC6RA
Message-ID: <CA+1jF5rBpt60L3=j=t_msPj_4wMcUXxZW6X0k3sTKQ3mnMb3YQ@mail.gmail.com>
Subject: Re: pynfs tests for set-acl-on-file/dir/dev creation time? Re: [PATCH
 v1] NFSD: NFSv4 file creation neglects setting ACL
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20141-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,nrubsig.org:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: AC80A27EF94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary appears to
be down at the moment. Could you please post the URL of the commits
once the site is up again?

Aur=C3=A9lien

On Wed, Mar 11, 2026 at 10:36=E2=80=AFPM Calum Mackay <calum.mackay@oracle.=
com> wrote:
>
> Apologies; I have a number of patches queued up that I need to push out.
> Will do that asap.
>
> best wishes,
> calum.
>
> On 01/03/2026 12:29 pm, Aur=C3=A9lien Couderc wrote:
> > On Sun, Nov 23, 2025 at 4:46=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aur=C3=A9lien Couderc wrote:
> >>> On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> =
wrote:
> >>>>
> >>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>
> >>>> An NFSv4 client that sets an ACL with a named principal during file
> >>>> creation retrieves the ACL afterwards, and finds that it is only a
> >>>> default ACL (based on the mode bits) and not the ACL that was
> >>>> requested during file creation. This violates RFC 8881 section
> >>>> 6.4.1.3: "the ACL attribute is set as given".
> >>>>
> >>>> The issue occurs in nfsd_create_setattr(), which calls
> >>>> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> >>>> However, nfsd_attrs_valid() checks only for iattr changes and
> >>>> security labels, but not POSIX ACLs. When only an ACL is present,
> >>>> the function returns false, nfsd_setattr() is skipped, and the
> >>>> POSIX ACL is never applied to the inode.
> >>>>
> >>>> Subsequently, when the client retrieves the ACL, the server finds
> >>>> no POSIX ACL on the inode and returns one generated from the file's
> >>>> mode bits rather than returning the originally-specified ACL.
> >>>>
> >>>> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> >>>> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> >>>> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> >>>> X-Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Chuck Lever <cel@kernel.org>
> >>>
> >>> As said the patch works, but are there any tests in the Linux NFS
> >>> testsuite which cover ACLs with multiple users and groups, at OPEN an=
d
> >>> SETATTR time?
> >>
> >> I developed several new pynfs [1] tests while troubleshooting this
> >> issue. I'll post them soon.
> >>
> >> --
> >> Chuck Lever
> >>
> >> [1] git://git.linux-nfs.org/projects/cdmackay/pynfs.git
> >
> > https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary was not
> > updated since 10 months. Are the patches stuck, or something else
> > happened
> >
> > Aur=C3=A9lien
>
>


--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

