Return-Path: <linux-nfs+bounces-10396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6166CA4ACEB
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558F61895CD1
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578D1E285A;
	Sat,  1 Mar 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YcfZPEW6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F319E975
	for <linux-nfs@vger.kernel.org>; Sat,  1 Mar 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847897; cv=none; b=twDeTmMXXICFLw8z0+l4gla2Et35X5RbPXdRpYKdCG9XBcgv9yjMu6rSliZ26wWo2qI1hl6NGK0FA/5PZ084AUhi6+uF/Vop7sYeR8ogOTtBxAx/P3BR/XbZEjpQ779ojVJ31x9lMkj69uIg5oPdoUMUuG5FE3gBU5VtLvm5s1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847897; c=relaxed/simple;
	bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+iVBSwpzd0sD7/M2+voIOhUmGM0+iNt9IWBMrDWR0a3vvh4KPhQiFqKQmyCLX0eu6apWum59syib5DyZamBxakvMzS+LNYbA/wNXEO4OztJR7K+ka0kSbo60hHR7s+f1OBUtIb35VAUtikHxaxGV61dsQg8xXwKfwcQn8tgOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YcfZPEW6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf5e1a6cd3so54195366b.2
        for <linux-nfs@vger.kernel.org>; Sat, 01 Mar 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740847894; x=1741452694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
        b=YcfZPEW6weDNQbjKvzwErtZMKs1YJdLNenLjjAlFx/RYkbM1Cj/W/l15R6cLm+rMxS
         0UXKGhQ1Bj/5/DHhfJDT5T7cXayxx6zTvW9F+SAlUsBidsR2lSkappTEjDlJgDW2YYGZ
         8BKl/gcoXKWVFLproDue8uEWGyHa3zKxkmubeb0NeZ0eJxsEghG7kAqFZI+0Uf+Ma5BC
         O0jn8JIrofG0sfQIihuWOhO8qcMquSeu26RhQQUJCo0O55IM5q4zfLwTP2yfLtoMneu0
         MkZLHINKwC2keVsTTcWJZ8v6ADcb8B4wYn6sIBtsFVgP0o7a0TrqgkC99C8vG7sX2BYY
         Pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847894; x=1741452694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
        b=H8MA1vLrKLfKfbssVEhD609neNvVyRMJUFJfdGgkV5Y7OvBAqevCyVZlp02FcXe1+2
         Ob2CLnkYwyoZBOyLbQVrxot8hPak1D2Ua9pxWmmp5nMz7LDuj5ejgGKVhyUTKUkBLwPo
         rCaMZadoZ9EVDiSyq40VXp97rzA6GKwf8HDabZiPQ3KA3FzG1xCoLvOJg51tKf4EK4L7
         UZk05MSElhAwhCAU04J2kHFyPCZJCLL5wtnG+kzNHC5Lsp7YIMG9ECPEH6fn9p1RtE2W
         oK1Wf37ucLsVchcb5tBiJ/qBi1+sR8bsryCnGd7ONET3Ho+DC6flla5okK4jXCviPPcT
         YHKA==
X-Forwarded-Encrypted: i=1; AJvYcCWJyglNS22U2tQj6ZKVOtTV6WX/hTXpR67c/7BcW132cEAQmuT921ajhQ848LDfZaBhgxl0rGc9yQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBSC+T2KzCJOP4iqmijIDKLw/RpjfLVSb7633GkNt6JYdK0JZ
	1Pd6nOB/3vqgcedEXYiUG52VgJda6fAt0DsFHyRtrV9eO+GZisjx0v9fGb3mPMxuTcrYRAPUpF/
	tfC0GXKpYAA9p6WypnF7fZ2dwuWv+gI4wMzRP8w==
X-Gm-Gg: ASbGnctX/wfC0xiUY7zISCZuy7rdd1FOwyTlzVneea4nj/Ob9HcGoPK01aIw2YtKQDZ
	ED3HvMW700+7EKXzSOcZe84yFdAktcakoDtFCW6ba5fMl+jxB2WVbvSQ1hoc+JZaX00P+bpotQQ
	UGznZs2ExLK4jBkR11b/t/HSNyl8Kkc3WRdksRkTNP8TjRauoIkVbyLJE=
X-Google-Smtp-Source: AGHT+IFYXvc121y6bi2508QH8dUTqeSWY5NhZJZqG4nMfOIOhL1fYaF1K2onpqRPcyP27mIyLfm41qyBG2MUuYbO9F0=
X-Received: by 2002:a17:907:9494:b0:abf:5d3e:7ca5 with SMTP id
 a640c23a62f3a-abf5d3e800amr254015566b.3.1740847893706; Sat, 01 Mar 2025
 08:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
 <2025022051-rockband-hydroxide-7471@gregkh> <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
 <Z8MW86zYK3VEPcHF@eldamar.lan>
In-Reply-To: <Z8MW86zYK3VEPcHF@eldamar.lan>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 1 Mar 2025 17:51:22 +0100
X-Gm-Features: AQ5f1Jq9sC4S5xjkMHqwwE2FS3xuXaRrtGAbEBdSC6KdiEIvXgpvhHXpBM86jWw
Message-ID: <CAKPOu+_WAM3RQJnHsKfEh5sG5tBuCPt1EWtoUFVC2ma=ORjHkg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Howells <dhowells@redhat.com>, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 3:17=E2=80=AFPM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
> Do I see it correctly that this will be 6.12.y and 6.13.y specific
> backports since the code in mainline changed substantially with
> e2d46f2ec332 ("netfs: Change the read result collector to only use one
> work item") and so your change does not apply there anymore?

Correct.

> I'm asking since we got a bug report in Debian which seems to idicate
> it might have the same root cause as you report, and it is at
> https://bugs.debian.org/1098698 .

This indeed looks similar.

Note that this is one of four netfs crash fixes I posted recently.
Two other fixes have been released with 6.13.4 already:
https://lore.kernel.org/netfs/20250211093432.3524035-1-max.kellermann@ionos=
.com/
https://lore.kernel.org/netfs/20250210223144.3481766-1-max.kellermann@ionos=
.com/
The fourth bug (that got no reviews so far) is here (this one affects
master as well):
https://lore.kernel.org/netfs/20250228123602.2140459-1-max.kellermann@ionos=
.com/

Max

