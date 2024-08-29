Return-Path: <linux-nfs+bounces-5980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA1964914
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471871C22875
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836281B1414;
	Thu, 29 Aug 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ymo5fg1i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE931B0134
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943132; cv=none; b=ohJdpXgCQ53bI5p/FpyBsYjkygpDxTG7+7UJdc08C8TORw05a2qPBBJkyojJL+uZFD+cFzZiYAk+ZVHiPf/XOi7AUCToAkqIMFTCtV04RB0lgl85tKTxLfFv+0eWmjn9oWCdI1Oc3kLS2PImkjtC47iRodCYhlSK/vw2xPxFUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943132; c=relaxed/simple;
	bh=uEAB6ta2JZwjFZ7plQrRuqXV6ei6Dpsz9poZgoZwKkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofTsC7jQF/QPE8V5CLixsWSD9UpuKDay19Jz8aBqikRxZ+9/HL7XiKuNYioeBoZ1+mm63UlsZNBhmPnGDcblgEhO7cEhVpVt2zv5LJfZeEUwFVQGGHneRrlEou1m0E5bdMjlFdFdwV7hiN6Oj7R2dNaXjLv3XXCc8+XmbuqGFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ymo5fg1i; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e13d5cbc067so801466276.2
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724943130; x=1725547930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heXj/PLtLCheEdpzHoOrFp/LD19hFuENsctMARZGC64=;
        b=Ymo5fg1iJzDjVRXG53SnAvhhJQR4YN1H282FwU8cXfZENQ4wzVHmsmMAcE8z7j8F9Q
         njlmqE2fdF/Ne775Wk1KjnWmO+Jf6OuJgOE7lPmH5uavmwZV1ltFJFtofR0l+xig4dLM
         tLbEphL9tGNHvri1U5x3X/YXz0pNOKWM9A3mt7ytnJPEe888jN2seuryYsBcK/9+Bf1N
         SXjsSOfgWmz4847u01DkSn81AOKvirtApx5SxTp7FGvDuBR6xYVe5nMZIWL6SUnUmb3E
         5laZQMqlbj8j2hq2TtTj1l6Nsh/2laAES37WG9U+FFBU0wYUPlaTERzWMAciuDNv7+Oa
         RbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943130; x=1725547930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heXj/PLtLCheEdpzHoOrFp/LD19hFuENsctMARZGC64=;
        b=gDEIxPL5uMa/rXW/wUt7VEOm/HpvPK9cq5khP+KQVxj1OG6R6IcJUtmW9TEKX2BAMv
         q2MhRyJsW8HxsGhF/heq8DtzkvIe+wpgVyDr3Z+1h5pqRl/GkKsoJb/8ycz0K3hDgAlW
         tavzRKwokZD6xhK/H6AN/ywYapwGT/gLScFhalgVgzBRkPlKL2XQ0zgPT9Dg0iQNU/YO
         Wn00oY8ojSHZ1ZlVE5zYne2MIuVtbSg2k/LC/spH9NWjP9+CVgDsWDqgz74hM8QonFk/
         NzKcbm22IbtzIw7eyspfc0Q1OBexGC54RJuCGDUHRMcMjLf06FZNif6fin1Za1Fd5raY
         tbtg==
X-Forwarded-Encrypted: i=1; AJvYcCW9yD1ymjErR4mnaO0riXEyHkzSzxXRxXOPpwajKxgFUKwQ/Fq3nffIuUlNkwPst742apwVC6TksAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywfcMUYzHafDFJifsZk+/68vCZ1KowWfSYav6GQUHpzQ/YOWeG
	XfBa2SNwMrmaqOalrPs190/Rbp6rMMgKhITqoTqev4fWE8IE7gE1V/wkyk9Zp3gIu4dZLnxO9oL
	fztVSqSg66HPfdxWjBjXwidq/xt8bN94r/1/f
X-Google-Smtp-Source: AGHT+IFff2XbuR3O9v38KhfG2mcj8LpUQiMK+cRSxdux07tWdh+BIWmOr7/roSvogIAeRxJfaBMgjQZ3Q0/rAqHEsqs=
X-Received: by 2002:a05:6902:1b86:b0:e13:ca39:f7f1 with SMTP id
 3f1490d57ef6-e1a5ab72e0dmr3164785276.16.1724943129841; Thu, 29 Aug 2024
 07:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195129.223395-1-smayhew@redhat.com> <20240828195129.223395-2-smayhew@redhat.com>
 <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
 <CAHC9VhS3yhOxZYD1gZ-HF5XkGq0Qr8h4n+XrttUBsHL4cg0Xww@mail.gmail.com> <288CD342-1534-4FF3-9B2D-7E824FF4AA20@oracle.com>
In-Reply-To: <288CD342-1534-4FF3-9B2D-7E824FF4AA20@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Aug 2024 10:51:59 -0400
Message-ID: <CAHC9VhTFU7feDZ5bE+gefYn0jpxmH5KV2xtydEyKijkJusN3mA@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, 
	"marek.gresko@protonmail.com" <marek.gresko@protonmail.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:16=E2=80=AFAM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
> > On Aug 28, 2024, at 7:19=E2=80=AFPM, Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Merged into lsm/stable-6.11 so we can get this into linux-next and the
> > automated SELinux testing, assuming all goes we'll I'll send this up
> > to Linus later this week.  Thanks all!
>
> Paul, may I recommend adding Cc: stable once your testing passes?

Yep, I did that yesterday before merging.  Typically if I merge
anything into one of the stable-X.Y branches it gets a stable too.
I'll update the commit in a few minutes with the tags from Jeff and
Stephen.

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=3Dst=
able-6.11

--=20
paul-moore.com

