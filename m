Return-Path: <linux-nfs+bounces-20390-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBoqAzcNxGk+vgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20390-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 17:28:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 715EA328FE0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6EE317360B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13503EE1E7;
	Wed, 25 Mar 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8jl6zl2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA13EDADE
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455089; cv=pass; b=Oqea0NnSlCy+2CD1RmtZHT8X6WJFAtbMBRoGUWIgMkUOsSPiO2hau1Wd47patvYBnyAb+JJfpO3A8xRqfEIDVHDqt6jZhwiRyTXzZedHaDBgIQ3GkFNhbW92PgSCVS4168t29iIUpF0Ugcfgsm4MGTJabbbTFRS7oLZ1c0srI5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455089; c=relaxed/simple;
	bh=YMUAIb6+tjHByjVsb9gE6RyJC7u95BxISweEekHtmA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTehfyl5oGbO1Y1OjmIN7lzje7mK1W5LpfAsI2rV88DeYjwXYP3n0qEOHFHvyBSelLzGLc3xrebv92CaARll/ClKZ6AJHnIO3u/HMS//KjH0ME8XT0E9sh57hMR+MsC9vfXkHbgZieEfvYZfQxsUZIkKa+hlaJlKot7qkx6T8iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8jl6zl2; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so710792241.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 09:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774455087; cv=none;
        d=google.com; s=arc-20240605;
        b=Moh1TvKC0qzitACU0tFwxwYCU2bf0pxRU0Z1E8fMqygYK0v9UOGnwVfqvnQ/NCLDI0
         NTouRBDKwSaICa8UlplnksIRRS2yMh2+SSXq5drQGyxqh29CVGsGSCKwW+Kvpx/FzEqh
         LFPazziR1Bi9TX3mXuZrqb0UlI17QWqdXKkz2aUmj8BXQwPEAIN5uoqVoMCvOoIZl24o
         wdSnMEb7QAzfvS6uwDs2mYmBH06nEOJGwElwsNzXiG88p39ac3R721S4JYaLDCx/jaaC
         N8WLZvDziXJhqC6pU1opGfS2sPtcWAFB7otwMGqKCkBpE/a/N2/Rx64ixyfDRkNPevSJ
         R4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ob/tioij4RGgCuGhzry9vdMuXjlPnMpr07oWMA9ttyM=;
        fh=Iw1js+AHZJ/y23eBZLlAPOGCJ9iziLiObRLJwfFOlwA=;
        b=Xy8LV0S6mXCPvUwrskmpQ1rLR0CdN76mnpolLahJqCIgzlcO1H/WoLYRB2bS9bvDO7
         8HbuyCyUXm7c10rJHBJP6OlNsOBwWATjjb6+Drz5kk/fk7j3PprltmkMLsXSdhhw9c9I
         bl/RtHYA5Jx6DxirfBGeAOPeCV8sWVEr91cEU4Jp183O804foT6xMOi5e4AP6zfVV9C0
         QF3aH63eQvo6Apda99uq+PLipE+nicZ432MAKehF5ZZmo/kw+NyNb0OoDzvWLLQr/yf3
         +Omqx2RQR/VUFJ4J+3913p9SXfKVS+QvjcMxF12CXakKj/a5nPV0tJklHx/4wjZ/RQ9y
         jD+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455087; x=1775059887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob/tioij4RGgCuGhzry9vdMuXjlPnMpr07oWMA9ttyM=;
        b=M8jl6zl2/+oV9eEvPatvk6iLC5oCRgnymcfrzHlDiLt867zb0/CO3UGjRZ4nBKA97S
         qQARg5ZU3I9sC81wUFiiKNaCW5eMeTcNjpGI9uWzmXxFXUEMS3NyRP/4mD/9++LIOQnM
         vPg22G7mtDnm+3GHMV1MPqAro6qydsPEEulmTwYkx6/La8DUbHvnpzrHAdXqUjxVbRPb
         oQ7voWlpEb9tVuGECzf2N/dmoeAzbgHVcawwoFD9KI6OW/A0bjoFXP3W9Phpezyf3sNG
         1682QQjl77eJ34mXEvCvPBTPCOOqbxrId/a5+cFyvbAAZwp2v8ZF+tOzsV+SF1WgIERI
         51vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455087; x=1775059887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ob/tioij4RGgCuGhzry9vdMuXjlPnMpr07oWMA9ttyM=;
        b=fk0LaGzHQLDmOrwLJtoEHja0BZx6vAxTjDikIkmeZVXWdVbxhayzRKD5xevz364cMc
         FrkrJNsTgpcqGI2v6626RwzOjH+Dev8jaTPJpKpzaiEGE8jq1Mj5RaawVPgr8InU7HLf
         1XNa6Am+qQ1L3MLp7IghUemQE6Xw8fJV6IX+DjSoGC8HdqPfUynEgtL1eOwktIkUumEK
         nECKTsbMEjTCDYnZBmIkUXwFYCOe5tP//7pbfFT6gBNxu8mZUFC+9ZlzUhr6ud2Dxw58
         NnbeRHfJHdR0HwvklalCwUu0aB4wZIGxP9z5rjg5ayvojnKa46vgUf1AG6ncaV7hsIIv
         zBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJjIIvABdJtF9w3mDxfO9snAQvXBxByDLNv2THFjIo+qnt8QYDXrZXa2f/sdJumTPRs8pD7OsJkDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8/uE/rlzELergGBhd+5VtfhIcTOB7J8FZwfJ7BcDHo1L/UnE
	OpWeS8Kw3QbyZeEkGZGVEi0/I2J1RPoyBcIQzzk9fMXLHsA92OZ5PJLIUiusXeJcJvMn0XtzXUd
	cQA88bbxMxZZ/9BCN7gxOBKrKtES9M6E=
X-Gm-Gg: ATEYQzybj3kEvbc80wShbU6ZYni8GHMVECl9cJ+bOMqPhqurPvHWT4kkB3C7DnpPFvk
	DtecEaCsE/mroKzXUzOz4JJTEwe/puKVl68g/TpvL0U8SxxSSSRIzqT9HVEJM+opBTv6TInPTXF
	MTnwifgdxtTMnqk2r4GbkROaU2VRium76xjRx/ePxnT/W1b999eQkq2/KX7749EReEzuj3BTrDt
	jtkp714ly6ojkebgHDLOlUMR/C7ik6FsK6TawzGOkVSWXDgOdAfCdQJZvvWEowweTSrtH2f2aJT
	db4rSI4=
X-Received: by 2002:a05:6102:809e:b0:602:d52:a32b with SMTP id
 ada2fe7eead31-603162bd00emr3341319137.21.1774455087102; Wed, 25 Mar 2026
 09:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-5-seanwascoding@gmail.com> <15f31b98-aa14-4f58-a685-d034aab61d73@oracle.com>
In-Reply-To: <15f31b98-aa14-4f58-a685-d034aab61d73@oracle.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 26 Mar 2026 00:11:16 +0800
X-Gm-Features: AQROBzAcweL5KZbzaZMpRagT77JFccHYGYrKwnui_hP3RMItd0lsAGF-3oSU0wA
Message-ID: <CAAb=EJWNU5DMhOZLifbPe5DCgQaWnXBBwRw81ttxLpFGKOtiMA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] nfs: Refactor nfs_errorf macros and remove unused ones
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Andrew Lunn <andrew@lunn.ch>, 
	David Laight <david.laight.linux@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20390-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,lunn.ch,gmail.com,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 715EA328FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/21/26 10:15 AM, Sean Chang wrote:
> > Refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
> > pattern for safer macro expansion and kernel style compliance.
> >
> > Additionally, remove nfs_warnf() and nfs_fwarnf() as `git grep`
> > confirms they have no callers in the current tree. Furthermore,
> > these functions have remained unused since the introduction in
> > commit ce8866f0913f ("NFS: Attach supplementary error information
> > to fs_context.").
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp=
@intel.com/
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> > ---
> >  fs/nfs/internal.h | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
>
> I need an Acked-by: from the NFS client maintainers on this one.
>

Hi Trond, Anna,

Could you please take a look at this refactoring patch for fs/nfs/internal.=
h?

This patch addresses a Sparse warning reported by the kernel test robot
where a ternary operation in the macros resulted in inconsistent types
(void vs int).
I have refactored the macros to use the standard do-while(0) pattern.

Andy Shevchenko has already reviewed and tested this, and Chuck is
looking for an Acked-by from the NFS client side to proceed with merging.

I'd appreciate your feedback or an Acked-by if this looks good to you.

Best Regards,
Sean

