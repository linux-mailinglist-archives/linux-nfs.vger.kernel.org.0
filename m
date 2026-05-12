Return-Path: <linux-nfs+bounces-21513-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB0nNps3A2p31wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21513-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:22:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B25224F5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82FD63557BD3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CED3E1720;
	Tue, 12 May 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkRjBjP3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA237DAD7
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591941; cv=pass; b=k4AdxC6sO0NBF/ozXwl3MqPvDUyaB18HvatUcTIdri+es/nLZj70n/OinVTV+MqCOg5pzmv1UjxZCcAzPLBgvgT5zMw18DJuisrmKFnj1EJJHCc6o6ocshCq2D01JO13TCuMJ7Htn7ZfyeblU88Raz/ubxAO7QolDOZZE+gxG5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591941; c=relaxed/simple;
	bh=4IeInsZ/n2uK48CMRJM5tqogXIZ/5tgK9rWfJ3UdsMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dl3hvrZfzW6PqO86F6/6T59WTIOKLyS7x4YbvkNRRukAdypbkIuaus6fM6/LHpwG5iJ+i1FOHRtoXihipUzn1vKazCHiqE2ObIHDRi3JYEWJ8zwhgs3jIvgra05b1bKWQ6AYRnexghQOUP7EleOgytTJvSwqgzCWPBRXtwkPs9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkRjBjP3; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e36bb16a92so2067357a34.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 06:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778591939; cv=none;
        d=google.com; s=arc-20240605;
        b=CH+u72e1SEGZTsExvGCcCdqc6pBj+eeXDQc9cqavteW2MuHQYJWdMaRMYlZUQcD+/i
         xLdxYJaCaI32D4hnXP/WgnQ35nm06AiX7W57+kIgt0HHNj2QnDyu3zSrIEMUmWMwzkZS
         dl52sNAW8LkgA3qXoDy6nSKGYQ5VRrG7FStUYMcJsf7FW3OUuU8rQ3twb9jXWZidixNG
         7NK1LkgS+hemmWGdStR4FkXlcH475kFDo17T6Fz4Z3Lazv/5euq36YIVyv04iPJ3aQTd
         6tTSbOVxI/+CLJzjWZtV7d20SUXYhLX3wWlOT/QWsxMXkfL2Fi+WNSvhdW8QI9pWx8zM
         YNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4IeInsZ/n2uK48CMRJM5tqogXIZ/5tgK9rWfJ3UdsMo=;
        fh=MzBoCUgZTosw1TMwZ6rD7xUaRcA3oruvJ+IB5AFPiog=;
        b=j5BLs4P9/YETPzdF+RUQiuI38uq2YIYZ7LNwKtFZRObB3mg5skap+0aiOnT//Puyks
         dr0c9ONz0DIT59eRoVT7RuuVJ9j/g3xqwHo1LEas4jvTQdO8bj4JASTNdrBNlj1a1pB8
         SnmjwzQmDvWiTbjLdAx5pf9xqVsEdNtu3HOJEqA3P4GlZL0LrdjTeUnIZ9VETdtzv2Cu
         JiHlB/csFUnUA24rSlRii1Hh9lUFeX9PJ9HgdEl4HeEG2ibgBOhCGGiylX89YJ0jJHl9
         JjhpgDHX3uOBz26Jdzcr42Qdg5i+VclEkI+iAPFpC/cp6FJ97p8IuITo/IjXNMNSb2oT
         Ztpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591939; x=1779196739; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IeInsZ/n2uK48CMRJM5tqogXIZ/5tgK9rWfJ3UdsMo=;
        b=FkRjBjP3qQD6vEPtt/efH3V8RpFETmM+AwgHZFQvqsR9BqU19Oa0kCjkjJnXtCowbg
         uTcxX87VJGYupjkaBW/P0ktkZLO4nZE6jMF+jZudqnOL7QsJ9+KyMej+rit29SAVXsGv
         +hVUFZVTE9HdhloctUVimbPXp2jhTqwwqyJhEhsD6k/7pbzzQdNGE5kaRvBkDkegNrXm
         UN5KK3qxXxd79IAAAXmiu39MtYfpcVxBjWXbM7+U75D31JPF91eNhJu0UmAIWgZK9Uhz
         Tmy+S/PHQSpiLArLwi/qAwBfUkAkweLVKUsglSf+W1Sd+R3hX+q6EI/vfbFW5Al7efKb
         35BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591939; x=1779196739;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4IeInsZ/n2uK48CMRJM5tqogXIZ/5tgK9rWfJ3UdsMo=;
        b=pY4USnQtcQZS1ic/D6YW4VHdo5GdCzgtVK+kXkJSkH45Hm92IzPniV8CwJN1zS87tz
         HXlRAKCoVvnGYBSu2oZFVReGmTH7uPp5SALNbEYf4jZPsmNeREvCtXaB6VB+nzUjF+Mr
         WO8VD2LUZbu5Y59FHYnZ9X06YonHHBYZplORr/e5zib2TleIDaA1Ul+65/LB2Vu1PxwD
         S1DDwFhRtUF6bTMaBuD9ujYhI2Pu+ITX4uKNZTTNo0JzTjrVVCIXFnHydDn+vEh9HLQ9
         F1Lm1nQIYZSt4vyA0V7KEBr66/Tp7UJMLEAqSgoP2cJ5gR0EoBz2kUxGl/Ps3+M0SHVK
         5XIA==
X-Forwarded-Encrypted: i=1; AFNElJ8kcmNc/8E9aupAS22a9xSNYanvpu/2AuMna2sa8+Ve3kx4d/xT5+pD9wmHtLLf85n0iogaYH2XFaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWE1Q4ypxWTmUcL2nhb4lpgiP0Wi2HyFJ95wiztUD9RyNb0+W
	ePv/Qxz5VmpjGoEqew5QX+sU0Heh0tylZvPBWACMXpTUdnXr1gF2og0MPKDHg8zJf3IUgQVimwK
	Ipmpib4eeds5PPqwiR6QjZKn4T8OBJGmRyQ==
X-Gm-Gg: Acq92OFBZ+mOUlMxgRVyvLpDv0hIRiB29JcsUfs7VriL9itjGheblenr4ZhjEQXvGrX
	31b1P/x1XrbFV8Fr6r0yFPeyx6QvopxdyATZuq8rBgMkF3kAiZBGlJ/QS8ClKpJlyiNgJ/qIYr1
	C+Z3i/XzlKfK+Mt3GIdKnLCPd1A6UW769HP0L+oJRK0dZWk4fU19aU5OpE7HnE+68wr1iWJUEgo
	8ZLlFnfv6pe49G/iULICwogSodIWmjafEYsYqorz90oXT5wmfR1dZ/iuuALnCgnPLt/wdcI/muf
	E3LOY6s=
X-Received: by 2002:a05:6830:378a:b0:7dc:e37b:b5d3 with SMTP id
 46e09a7af769-7e1deecda2fmr17165119a34.7.1778591938923; Tue, 12 May 2026
 06:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com> <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
In-Reply-To: <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 12 May 2026 15:18:00 +0200
X-Gm-Features: AVHnY4J4-ZNCmEFD4f9QkUevBdi0g7HXLL98QKC94zDZH-Up3R_AKybze21AMy0
Message-ID: <CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com>
Subject: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default NFSv4
 server size "max_block_size" to 4MB
To: Rick Macklem <rick.macklem@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, freebsd-hackers@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3D7B25224F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21513-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,freebsd.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Tue, 17 Mar 2026 at 00:35, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> >
> > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > > As debated a while ago, can the default NFSv4 server size for
> > > "max_block_size" be increased to 4MB, please?
> >
> > There is an administrative setting to raise this limit for
> > recent versions of the kernel. Can you report your experience
> > when you raise the limit? Hiccups, performance issues, etc? I
> > would kind of like this exercise to be data-driven.
> >
> > What is still unknown to me is which NFS client implementations
> > can support 4MB or 8MB. Without client support, an increase in
> > the default in NFSD doesn't mean anything. Rick, Anna, Roland?
> Although it has not seen much testing, it is possible to do a > 1Mbyte NF=
Sv4
> mount in FreeBSD.
> For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the settings woul=
d be..
> In /boot/loader.conf
> kern.maxphys=3D2097152
> vfs.maxbcachebuf=3D2097152
>
> and in /etc/sysctl.conf
> kern.ipc.maxsockbuf=3D9455616
>
> Then a mount will use 2Mbytes if the server supports it.

How can I verify that the FreeBSD NFSv4 nfsd now uses 2M for NFS buffers?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

