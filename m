Return-Path: <linux-nfs+bounces-22256-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yDwpN0B9IGr74AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22256-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:15:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E65EA63AC77
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=jfCgoD20;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22256-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22256-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8430B301C9CE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA4A481FCC;
	Wed,  3 Jun 2026 19:15:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D1481FB9
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 19:15:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514107; cv=pass; b=KXK5lSKP9bMNAJwBh0MoFUZtHcllsCb9n1Ov8s5A1T4tfTjBxFNO11pyyeeZhosPZ4d/I6HvTve1JtW5K4WkAiU48IqlFx2aH0mQtiwMWkFiXMuiAs43qMFR615e/EaDAkGkpSZ23qsUQ+aOo6ZFEmwDSvWv8HNJDVKvXPEr4r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514107; c=relaxed/simple;
	bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSZ+8X9daf4BSwX9LoqbPLiyb1FGfWIJ5TCLha00Q0BPG0z+6bmomMYX6ef4E8fbaAREL+R4+/BZhjaDTDzOIT9P7GALY4jAfcsgxUgu3W+ISDVAr1tO0pkaoJKlq05447qYOfP/Gzp23DC8doB/mE/NCWEjuXilLP4mfmcgMIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfCgoD20; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso2180a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 12:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780514104; cv=none;
        d=google.com; s=arc-20240605;
        b=a7MqkDuFbQWDQhjwMLOfi96Uqwi+7ffnRhAI+c8hnM6nvgTU47QZ8gL8TfdqpGFPxE
         iqGuESTIdd7+Bp3lrg/K1bk6XtCUi4Bn8+6P3m6JSzKr6cpobXUYJ1K+C+kwjg46Onfu
         LossDnw/HwkCudD0vxS3vnLtUgE89jm7ygYXVceD3U20IOxlbkI5DI9StNDuSTA5i9Ip
         V1NMeKo4SDVXY7yent+0ruGvDLC0Mk1aEx1HxebFjvgfvRGdfa+QOUljIyTY8TCmOAtg
         CrjUhP2xcOtaC/qCSDg3PxfVUtySNVtE6hBKX+FvXF0DhXeEy/1X1NxOU/muNyhrhqIx
         i/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        fh=oVOBP4AUItzB3+gHg6swvEK/gogItB8PtIBA+HDT9hY=;
        b=Pt96lEHR/jo7YbUlQHE50sxtnKWl9Pq8R3jX3cvXlV2XndgfghBwV6gEPeWAVoC5sZ
         HblNS5uGfSo0z+1kKjrCMBg3baEPjz8HVeU0KQRty7/Kqan3xglUdW0eb0zuFocYRcnq
         azqsz7sTrATiKkG69A8aiAoOAjT0Iq/6WcgMGtMiy8WeqawoKoPL9RRKaXUHfnnWAJNZ
         XdF77d6Z9dZaXamtfAqqXFby1ng31p0aYRDiMuIAdcW+eI9aBaY/C6pFHFRIjJzKtcw6
         KuL5+50aqKSu5W1mUlkqLVZc+psqOp29dPJEQaOmZ/gM/eVd5zmO1W+UK6d/V0tgkUzo
         vwJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780514104; x=1781118904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        b=jfCgoD20x0qu8FZprg93X9hh0T1PTypoAvgZBKJeink+mL18zBqEY2pmwVerCEJwsl
         GkyNgfsCPofojIJhn5Vd3Vk2Pk/J9HMcfJpABhiw6yoEAyK+q4dApFG4OIn0bqfECNyQ
         2oJZbCI9bmLnfOblCoqW15O4RUQ6Vhwd4Z/505wVP/FxtDmKGW+oXozWxRwWxYpMpb04
         5o03yP6rSexzL0vFgJZNBAY+fEm863IlApogxPgsRsNc5tZb8Uj1bsAUr12J+EZuNS+6
         ppnBooS/9tfJ3kDEPidU5nkDnrnLpKoSXs9FIcgPYlHQPwkg58N1spmmlbQS5DXFnpsU
         Pe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514104; x=1781118904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        b=eBN3FHOy/DAJrmvaEtc4uI8GRbOpWtfnNTLPx7fm7kFV9/8w+YiaCej/20yay4xIqy
         lzI08aOiI5UFln8ksFcx0mY0HtdG8/Pa2FZIZCI70CKWgGbpdOK0fEdHu5IS6TyLMShW
         bCzzt9793OUXN/z5sgxkiZhc9P0qUf0PQYGhX/hnVz+kyu2Y6xqokw8q8J+q1feS18qt
         mZBfncgiC6dI/gFmAae6to1claLudeU9g2qZjDluKJsmJzg6PQ8mwhCKTc/+Ab1IY7be
         RPhlSo1OBWESvHtjHcFjgWFCDIzETIeN5FneCjB488mpZKhpTnKVhWgXA/dT0Rfxz8np
         xzeA==
X-Forwarded-Encrypted: i=1; AFNElJ8QqHnwVt/bQtzHZxO6KKPAkNrjQsV9R3erEKKu79TcDkszgQS62mrMt3vm/5bVweSkuJOTzwOEz50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdG7bz5ALUNH61ux85lvoA9jWCCIobB9iDopnrtFJlOP1lPdKb
	YdRYnRPyhbXXk+M10z/8NJUGt/qw0aCZeST+LabDubqqIT+5fuIGF4mZcfESUiGW12o2lM/0D+Z
	f0MVQcNS+yWBzd8WgxUMJOyCwaE6euE+a8UrD1KPR
X-Gm-Gg: Acq92OGDtjtpUxstdLF6DEEjiXzpNcit8JUVBEntewNpftDUSOHbVbAhtD87o5TKRZW
	wViiVgvnOj+9Hxxjv/fFWoVOReVtvtvP0aALGOo+j4sWceh/raqccclICD6s8HOyVPVPEIDUPzx
	o/MMllM4HpHFmDZ7ScS3LfHRMo+6AkCHe1Fg1mDNK/FkqBlAAD5kUh3iB4wLZDvJ0MKhQLv4qBx
	kxuyMkT7f46f3sHx6tKU58rTwXwJgcD0DnyvAkuRmYxFajZabFCbnuuIGSicueg0bwH+T0+dTph
	S5Om465slDPsCN5CMwvVoj0YRVHGydn+j4/zho7lx8Guy+wW
X-Received: by 2002:a05:6402:a2c5:10b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-68f129a2317mr14728a12.10.1780514103934; Wed, 03 Jun 2026
 12:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
 <20260603185324.GA2636677@ZenIV> <20260603190225.GB2636677@ZenIV> <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
In-Reply-To: <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:14:25 +0200
X-Gm-Features: AVHnY4Jw9NWOm2jCBllhmHRKUG5CK3R17Tf93bIq0FGTh8la-bdsWtIarmCo4Tk
Message-ID: <CAG48ez2kK2dB4Tva0aNdWphV6BS021A4bf6a_cu_yOEJ8Uy=PQ@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22256-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E65EA63AC77

On Wed, Jun 3, 2026 at 9:08=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> (And there's also that weird detail of how, for anonymous namespaces,
> the active refcount isn't used and AFAICS never actually drops to
> zero...)

(Er, nevermind, I missed that anonymous namespaces just have their
active refcount set to 0 from the start already.)

