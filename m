Return-Path: <linux-nfs+bounces-20233-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD4vBAZTuWnYAgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20233-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 14:11:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625502AA950
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D1A3081F2C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C403AA50F;
	Tue, 17 Mar 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvOeYzVn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DE3921E0
	for <linux-nfs@vger.kernel.org>; Tue, 17 Mar 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752661; cv=pass; b=bDbctTI5erMnEpGDcqXu515fIvjHnJ9YIzkwpxTHboWy9nvzYE2blsJJjDiX8Iy1p1vDkEwtI2val20YYzod9whyhu1Fy8Krckc/60cPSvSWWHwACoXakQjYEgn8R5n9XhDKDcdpCUPvvHcjfDuDqLBpclmfogKvivPxJfU3wt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752661; c=relaxed/simple;
	bh=p2NriXN8t9UCererd0tVBy0OBqYtEpeYdnd+MQjf4Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYeMN4CdiWlCU+d5k6HTyyoRVmGmg5yzY4cpYfwfIjRcTtgAwDP1WaDdbshATulVWWI6GTZA03nFfm5W4I9Hoolrw8q1ywk6eQoPKM928T10d7m4co5dCMrkKmC8dhAy4IsSL4SbC3SbBNBjK+g4/0SDaKS7p+iEORLTu0v87gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvOeYzVn; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffe41e8e83so429657137.1
        for <linux-nfs@vger.kernel.org>; Tue, 17 Mar 2026 06:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773752659; cv=none;
        d=google.com; s=arc-20240605;
        b=jVPQxR1wosljJQrQe9Y8rgPtPINXU+ebJBeu8X2cAdku9ZKZRqr06+c011iO5ThY/a
         7I+XuMbKBJyCpsxnkM5QadBx2UvfS1lXwAmjvRI4ClLxEGcm/Ujmlvwrq77DD0Cwk1es
         1EQhQkkYYKNZjK/GBs2ly7IVkRpBBc34JVxnDT7mWYwObqqf/Hbv6tSV8VkN4t6TGCn7
         EvIvcRHUwZjEss/JydU0mGsmYBtDEtUzcM4k19zCUr7Mvoq9/Q5PIQ5nSKKNIZTquOEF
         nWC6Mey8k9AcqY5q1OyOMHRx0kBEipUa42wAdQitrRZGma7PLabrFsZEZAtVvcChX489
         9qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xn6ze0oE0cD+lz/jwl85dV+3isrvgPJIHKnPoDqqSx4=;
        fh=G+oqsw9nYS6thUx6ifw3VuIzPSKCWu1SvpoDW9IXPuI=;
        b=XvXCezyINHlKXeqq65MLG3v6kzt1Fw/FAwN/XKpEtE4GmVQ4JGGJXK/ctZ4JykwMYK
         FAdRsX/6d9XM2cGe69xeQ4rigxoeJDDChZpBXcqBJeMR50IjxM7u8+MoDhXvhvVoaCqF
         Q0MytdXF+/y8Xp1dgWPRtfA9MuLMtzyYTwFRn8mFcOfQkW4NM+A/TFFotUVDhL7IRt3S
         a2i0Fty7dBoK3J9YNaXXvdfb/1einbfpkbFKb8lf3sQ6D8WFX/lKadtNUSz6OcaSqg5w
         wvqyCaJPIokwv2Gp6xiXa/kBUDxu9P7RSDveuuybddV/4pKpHCDF0x0hgsL+eeGoDJw8
         t08w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752659; x=1774357459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn6ze0oE0cD+lz/jwl85dV+3isrvgPJIHKnPoDqqSx4=;
        b=bvOeYzVnTqJppmVTjfHAmCWZ4z9Qd4m7dsWTTm6+61gCF5C+tFJvNcF/tOMf49TARa
         ddbE6TM5qChX0V0rKjEr2T+fqZoj9RP8FdV701Y82jChIhmwJeTmbt1r1EaUCRrCbQSj
         TJWBTuTJiV0O36lYgCbVjuyO956Jl3KkwE/5WxLoAPUefww4eFnGbsTqprg16el4ew66
         0o4wkRIxURijgjgXuOJGBOzpIngnTPkRK0S5uUL18ZLqaFzYLlv9La3KpeAznlT9EmqD
         RVdTe1K/GgGQJdr4sbWbumChE9MuYkSUb0s5BDpCDXVRovk9PXqtpEhswr2LOHwquPVN
         NqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752659; x=1774357459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xn6ze0oE0cD+lz/jwl85dV+3isrvgPJIHKnPoDqqSx4=;
        b=OC0M2sIBrPHKEUWs8Q9dt4QY0fQzf9C8+NqhmwZNo9H1dnllX9WlWyrJpWyVqXCPC8
         tlMuxr5mvWUMJ8C9pZo1mD/mJuQSYFO6utzVwY7LAuXvUTGShffhzke4OyuPO4HiBhoW
         u8R3Cn8iJAqeL07wNjvZFT6sqfca3VVSCCqNZJawtXGlaZ9rlJQnVh0l9Mnb0KPe0HtS
         C4pKapzKQUeQkLlVI+7j35nzn0B/YmEpXHgqhnlq9KmpNTfbQrXfoYVhBwIs8QVzmzj1
         iKvFPoiYZ5RCBt7PZmdHb4EUycWqD9siMp2QkPIU5jLAVagPNvcMotaKPVyNCLVK6BjI
         MTzw==
X-Forwarded-Encrypted: i=1; AJvYcCVKDYYNBYYwvveX0YVqYkLcVZc9KFEmO+qb9dTlVvIHhWksTbDhZznapw6XSXSx6TEKMuJX9ch9trA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHY3qkIsWFixdJfnMtB6V+qVg9In/h/BfGIsmstEEtHOorGMD
	1gBUvZOUd3qHexPy5S/J8o/hSaQY1z5P4iArovXjqePg3pKUtqc2sfdnVy6DXcBiv3MPZwtOAQB
	jXA24sI9B1gu2kES/dqG5fD2tfiNfKuQ=
X-Gm-Gg: ATEYQzxZNjy6zII6+6JbGsCdt1Ydnx7HrNES/O4ifAubinLFQDtzc/10f7esxYuu7C+
	X7z2pfCvwsmZ9KiInXVEx0JN+7T59vuMOOYExHfa6IA/YU9cDF9CvJnlfrH5L68aVqzHLfiLS5H
	bfX/kO4priZFwAIRTl91ecwjUuGGXz+TdbvHaJCCksbRcnpaQCb8UTv5xpCyQHu2Y+DAKUBMkst
	aQi0xPJJpZVmnQQOxtOoIuRgr5WzPbWfoSWWH2UQw9NdcIuflae2Z7nCpQzteFK6/TmvjYcud5L
	FYfmvkE=
X-Received: by 2002:a05:6102:e0d:b0:5fd:f9fa:db61 with SMTP id
 ada2fe7eead31-60263d9e6demr1302152137.1.1773752658991; Tue, 17 Mar 2026
 06:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com> <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
 <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
In-Reply-To: <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Tue, 17 Mar 2026 21:04:07 +0800
X-Gm-Features: AaiRm52nHo-oplJQXa4sR-xaQ7OqdfCP-csU4asnyo5VppV-q7OwRQAc8GJwHno
Message-ID: <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
To: Chuck Lever <cel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20233-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 625502AA950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 12, 2026 at 11:54:15PM +0800, Sean Chang wrote:
> > On Thu, Mar 12, 2026 at 5:47=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:
> > > > Following David Laight's suggestion, simplify the macro definitions=
 by
> > > > removing the unnecessary 'fmt' argument and using no_printk(__VA_AR=
GS__)
> > > > directly.
> > > >
> > > > Verification with .lst files under -O2 confirms that the compiler
> > > > successfully performs "dead code elimination". Even when variables
> > > > (like char buf[] in nfsfh.c) or static helper functions (like
> > > > nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they a=
re
> > > > completely optimized out (no stack allocation, no symbol references=
 in
> > > > the final executable) as they are only referenced within no_printk(=
).
> > >
> > > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> >
> > Regarding the LKP report:
> > I have reproduced the Sparse warning (void vs int mismatch) locally.
> > To resolve this, I'll use the do-while(0) form in v3 to ensure the macr=
o
> > always evaluates to void:
> > -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> > -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> > +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } =
while (0)
> > +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } =
while (0)
>
> Wouldn't be better to drop ({}) in nfs_error*() macros?
>

Hi Andy,
I understand that the ({}) wrapper might look redundant at first
glance. However,
even if I remove it, the return type remains an issue because no_printk() (=
which
dprintk() expands to) already contains its own ({}) statement expression.

To resolve this without refactoring errorf(), which hasn't been
touched in years,
I believe modifying dfprintk() is the better path.

One alternative is to explicitly force the return type to void like this:
({ dprintk(fmt "\n", ##__VA_ARGS__); (void)0; })

While this ensures the return type remains void (consistent with the
behavior before
dprintk() was redefined), it is admittedly clunky. We could wrap
(void)0 in a macro like
#define nothing_to_do ((void)0), but that adds unnecessary complexity.

Therefore, I still prefer Option 1, as it restores the original
behavior from before the
recent commits and maintains the cleanest code structure for this subsystem=
.
What do you think?

On Fri, Mar 13, 2026 at 1:53=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
> >
> > Hi Chuck,
> > To make the review and merging process easier across different
> > subsystems, I will
> > send v3 as a 3-patch series:
> > [PATCH v3 1/3] sunrpc: Fix dprintk type mismatch using do-while(0)
> >     include/linux/sunrpc/debug.h
> > [PATCH v3 2/3] nfsd/lockd: Remove redundant debug checks
> >     fs/nfsd/nfsfh.c, fs/lockd/svclock.c
> > [PATCH v3 3/3] sunrpc/xprtrdma: Simplify variable declarations and debu=
g checks
> >     net/sunrpc/xprtrdma/svc_rdma_transport.c
>
> I can take all three of those, if that's what you'd like. Just let
> me know when the review is complete.
>

Hi Chuck,
That would be great, thank you! I will send out the v3 series once the
discussion with Andy is settled.

Best Regards,
Sean

