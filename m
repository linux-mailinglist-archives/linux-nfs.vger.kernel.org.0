Return-Path: <linux-nfs+bounces-22020-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOjoNC8WF2px3wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22020-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 18:05:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681C5E76DF
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C74F309715F
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91B391E7F;
	Wed, 27 May 2026 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6AweTLN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9B3803D9
	for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897760; cv=pass; b=tfeRfOm0rZRNKC2KOYOCaySJ3920FPCnJbI2/qyHGHKfYgGuJ2wyurAtCIb0xG8ncWPDZCA79PzyLX8Hd21+Lbdtgfqp22Ig4DiWSBVuAt+2jtb7NbCfhZ6BisozzhPsYPhR7UwI0rHW7B/u4ZQkrNP4cin9eXWieZCLkxgBc/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897760; c=relaxed/simple;
	bh=AHt0+86vpId0YnypIvt+8kocwI6bTxlsvlDW/zwRB5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eENRfpbxWwNoJCHDfaPR+UBkCO/xhpiKas5984ZRm7WoinmynBBGMVuRe/7qTAg+VhwK/1j7HtNZfbR3JhZFgrgGEo6HqCyJZwY+SJ7opaEGfttGsc1zI4tXENPhuroR9geb/X+YLtszHQLOOgfux2/n5r8QIAaEEjIK5GaRtgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6AweTLN; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa4a628ab0so1083572e87.2
        for <linux-nfs@vger.kernel.org>; Wed, 27 May 2026 09:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779897756; cv=none;
        d=google.com; s=arc-20240605;
        b=dYAWe33JKRSruIm40j53/j0grUqHAPv4KavcgSZO3ZA0R0BkQ8T/5naSEUNEjgezJd
         DXwLz1rS3WOixSJLuG1mBvOgJdvatv9lguiHQ2m555Mq6c4UyyzKi7HuSwrf1lRtPxCk
         cnRZf7ZzP/cJxzZdOy8Y3c2vk5AZq6zdyO4zT/wNbARNofSvkT2kez065jplpaULHsFy
         w76gq/N0oKqGSZs3wm34Ieo5QqtyJoRRo7w+GgHnt3wwuWpAKiPl6f9CU7+PKL/x33PH
         Fwmfkyooc6KT67p9eoK8tNFFNj7ZPkC4+e6TkgUVwLAXlZ43P+hDsYsfShIr2NpiOdgH
         rqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2Cy0T5Ytizh+1Br6nvrDriJnRVK9iMYXygh/HS+xaY=;
        fh=8Doo2omZE+6wT77pQipoVjk4tjHDtUaRbFOwpA/lCYc=;
        b=e30qco+haTw7bnT3U7aAu4ipeWaFmvZYB4CZfkuF5Ekabvq24ASh8vSsLvMv9eLFnA
         zcpmla6d5oWwbEQ7UHtMVypZ08RPQtlLfP4YqthwoG3rCw1wpD09I4sfbh16Js18AC28
         ictweZiZTPyuEdYChY0hMPDvb2M+hZRbX+5W30EFFUJOgqiw5CQpA7+19aTu5DMpVhka
         alMQXjY8aRbtoi93Dkcfq6JtApJ75hdlkWvLGHG6P7iWqTG5kMVvjrAl5qI3Ri9kRznc
         qTC6JhBR9F2CC51Kkf/PaFgBW+Vk7LxjfYwPvWmiX/th/Dzrlo7tP2vEUlpP0hhhUtr5
         nzEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897756; x=1780502556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Cy0T5Ytizh+1Br6nvrDriJnRVK9iMYXygh/HS+xaY=;
        b=L6AweTLNHy/Z0BzaB6cRHkDYdErwcaMUEx8sJqTCu6h0qBQaMI0UE7aPhCgR72qWxR
         SZBJ7t2RaoXpz4Fldpeu3WtNvtR9fGkYodPHOCr6ktBnEdknHAi631onR1oC5MFvlZy2
         moajP1VpZItzXpnNDN9Vh/8h3PzgP5amoobLKOr4RvS6L4yacQa55e2mV8a00urNt5nn
         HTjaq768EtXo9tfUIVpinlcto7s/5nLIsy4HiNkmZN86ifJim24oHWq+N95dQY3ntf3J
         Z5ZtSXPJv5DKW3uIy9zRs41yXQqczJ0rvHLa8rUvUrd3+qC9SeiuGsQYj4VxNAhx6cpR
         KzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897756; x=1780502556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2Cy0T5Ytizh+1Br6nvrDriJnRVK9iMYXygh/HS+xaY=;
        b=G99CrNwvB/r8nUhi3cCBEQPASjwT5Llpg5SM7I5AHVYUMrHSjqt1V+0QwO/4aHOsdq
         d2UGig1I7HIHywKI+d3bLsQUxGpISNhRcaAhENSZI7pRDuFCXYKe3zpm77KupDd11LJK
         br9rkwlGZ4xuyQ+bFNsxrrmtVeZB7uCdspHthYVirHFPPASvugChVNiYsQV8lm3B89yL
         ZgK+XacFOkjmvuOJtSJBzri+SmVCBYxJyzikEYYpg6KNSCae/82ITrUV7uj+U0NhD7rU
         6DxrbMBAmC+IyO7LxvZ19qyQ4zBWqw91Y0YBrKS/K1Jfloo9eaWh9cuqO3WaShOgy5ZO
         NLsg==
X-Forwarded-Encrypted: i=1; AFNElJ+jNW0HQJe0BhJlHnnZBCPT0U1i8cmJEbWu/1+pT7T9E6+43UCxO92xmf2Aa14suMDDTJEC/dZfF5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQMIU6XRveCrF4kyeXVM0uVFaLYx7vvfL71PocuRR7YFmM2ui
	KPddo/Dy4CuiFsxxV8+LD6JeCSSJg31CNqCzDQgbu1b67eKKgBjX9AdyFtAD5DB3ni48Y9TCrVP
	VzKBuALqc9vaspHWBHdsYh+JbYJDibgs=
X-Gm-Gg: Acq92OEsHJmdXfmE7hZ6JZDrq3tN5G1zO/WuFbsXNeFwOVcfklp2KbxugT48sLsGWoI
	34ZnDi1H9qSYXIgjNGzgYZjnifHqWpMEqerKTWJ+Z4yVFLdjqzLtXWwseKF2T/XoYDAxR7fgJF4
	4LcLekWEnDgUG0kwe/CFvR+di06uqZNDFcNihZEXwnttRwcJFl3JpyCxHBnN/ZADQiyGvoG6ATr
	BT/68nF6FLDWOSfrH20FpfIM1yhyh6JEENXSVl6W3vaVjRsb+857BV2R7vS8lCwog+7lEePZXSD
	DSTxtk+P
X-Received: by 2002:a05:6512:1082:b0:5a8:96cf:c8c4 with SMTP id
 2adb3069b0e04-5aa3232a140mr8148267e87.15.1779897755653; Wed, 27 May 2026
 09:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org> <20260523-b4-fs-v1-4-275e36a83f0e@kernel.org>
 <1bb537f6dc36b00788b613fb8f71579478418457.camel@redhat.com>
In-Reply-To: <1bb537f6dc36b00788b613fb8f71579478418457.camel@redhat.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 28 May 2026 01:02:19 +0900
X-Gm-Features: AVHnY4KetSSI45sZ2YEgAEZTRsUQAA2DaTD5AcJyh7fDYB4FmiHhDhxOxGAj9DM
Message-ID: <CAKFNMokr_mk8xhMQ7u8RGRd1XPQSSd_uVKXR=-ui5Zjk8AhfTw@mail.gmail.com>
Subject: Re: [PATCH 04/17] nilfs2: replace get_zeroed_page() with kzalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22020-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[redhat.com,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,dubeyko.com,kernel.org,oracle.com,brown.name,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org,gmail.com,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,dubeyko.com:email]
X-Rspamd-Queue-Id: 5681C5E76DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 2:07=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Sat, 2026-05-23 at 20:54 +0300, Mike Rapoport (Microsoft) wrote:
> > nilfs_ioctl_wrap_copy() allocates a temporary buffer with
> > get_zeroed_page().
> >
> > kzalloc() is a better API for such use and it also provides better
> > scalability and more debugging possibilities.
> >
> > Replace use of get_zeroed_page() with kzalloc().
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  fs/nilfs2/ioctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> > index e0a606643e87..b73f2c5d10f0 100644
> > --- a/fs/nilfs2/ioctl.c
> > +++ b/fs/nilfs2/ioctl.c
> > @@ -69,7 +69,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *ni=
lfs,
> >       if (argv->v_index > ~(__u64)0 - argv->v_nmembs)
> >               return -EINVAL;
> >
> > -     buf =3D (void *)get_zeroed_page(GFP_NOFS);
> > +     buf =3D kzalloc(PAGE_SIZE, GFP_NOFS);
> >       if (unlikely(!buf))
> >               return -ENOMEM;
> >       maxmembs =3D PAGE_SIZE / argv->v_size;
> > @@ -107,7 +107,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *=
nilfs,
> >       }
> >       argv->v_nmembs =3D total;
> >
> > -     free_pages((unsigned long)buf, 0);
> > +     kfree(buf);
> >       return ret;
> >  }
> >
>
> Makes sense to me.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

This conversion looks reasonable and won't affect the behavior of the
ioctls that use the modified function.

Thanks,
Ryusuke Konishi

