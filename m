Return-Path: <linux-nfs+bounces-20832-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PDDMnsG3mlRmQkAu9opvQ
	(envelope-from <linux-nfs+bounces-20832-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 11:18:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D53F7CA8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8207C307DA73
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9E2798F8;
	Tue, 14 Apr 2026 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOEi+I+l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6913B9D90
	for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158107; cv=pass; b=BRlYnbJMMqL/wfStV+2yY7l9bs7ikL0p8JI7LXfuDmGcLWElavZ/iBEocz7zxA1EofdLmw1bk90U1VWCraOFje2UhkZ7OxB/WK1ugdcwhvo1r2uVojmWwVtZbQmnb9HU02hBXsahakXr8v/cU+FNqI7LLYemqlhmpRTzcSHxACo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158107; c=relaxed/simple;
	bh=WnXOQMiCJI53iJTCn2AHE2xTy/c/D1yUEs7YV07bdJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxZYve3nvSS0YxUN2vBJfdl6kp2VBvdTqtYYro9AOlQN6VLRk/S5z8ggDbNjZLEjWMgrVLjowirfvoBzmOmQjHE7J8FmXMpyOcTv9tVeEk5KWgaEHWLjKqdgDH4mhbX68Sdc4t3UJyXsNQCfAJ8NccF0qRSEtwVVzJJAzlNkAfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOEi+I+l; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56d958880ecso1770309e0c.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 02:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776158106; cv=none;
        d=google.com; s=arc-20240605;
        b=PT4dMmF9SZiesUGHrQIr9oTcI5JotJTJDSrD9R0/pt7abxCrlNDaaG5FvToS0RWkWQ
         eu1Cl9QJ4IdxxyKpdXhkMHLp0G+easGVslXN1XY2x1FTnGEwVBeiC2DX/fl77TcufGZB
         UfzeG6KC5KVmSjS1ANKASNHUaPf6mhYSiu2mnutA4u7EniJiooxAgatx8mE58P0+kQp1
         tZvdxOtdEkppyQ/luYjiEkrORwCOfwXcdLrfMmnDhg11hxAq9RJ+Wqr5RMV0i+Oaaia1
         EsieqONah+VpbooJhz5+vqo/WDl+X0PQDw39Y3rEptMlF7hbFqb3psU3/0euXXjiF3hg
         skNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1kdavCpS5iI7FbmLAnxwCqeBAmYPClS8ewolD7iIUp4=;
        fh=UdvNg2Si6H37JM+/1med+pICadAMmYxdo22w+h+/ibc=;
        b=bZeFHjxXtWSLQMKMlcBzWm/8taW0FpcGp+Et1gpE3+pawf4tcNabZo2oobXCvj7BDW
         lBydLk1fJqyzlOkz0k14q4ywbBMQDx8kZIXSSLWLrghzm9nw+z/ABgMU/+K0Z0AsFOwV
         6FGM15LtHU3bcX/7QpUsAwJaE8Z/ic100XIT0//Y9gGDrkgyIRap1jEHPPA1wItV32Uc
         NtlywxOR/D7MUXT3nmAVwHwbqA79jZvmc3kpVrnj243+FsMq6q7ssBOUWln2w9JcNPaM
         TR88eCt5aPR2yoB4Ti6aqlyjg290My+kiBqCFb3HoB+rl6y+7PMPEwYofux3m+1SU/9I
         wgag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158106; x=1776762906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kdavCpS5iI7FbmLAnxwCqeBAmYPClS8ewolD7iIUp4=;
        b=AOEi+I+lHUs/121Zo6J32NMOtx15Py4Hu4IgOXntqDpzUCcN3AMTV5ENhHnAh1RwFT
         yQAVKOyJYt3S9gkYR8AHLbE/sObCdlaQOdceqE3Dym7HqX1x5ENUd49NvO6BsIv6d5vo
         AQcAepydub7WEjvsh64qHcV2gStypgOrTjBKJ4MvWONq2TaFiko07Z9ndejTQW3m5Tfa
         p6pvl2BlNWHGjeuE9BqVJDzH0Qe63fJvam4/XP7Oj+77GzDlNHkwq1LA/kxKq+LfkCrj
         d/rkPxr5cOUopmpX+9Ac9RnOYBvtHU2tDEY8py2vgwBEWDiGbBaVqwZkhVQKiD7MX3YE
         9SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158106; x=1776762906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1kdavCpS5iI7FbmLAnxwCqeBAmYPClS8ewolD7iIUp4=;
        b=c9maDRz/AjF69mqUJff1wVOJlVhtK0ETcNrlnBkCGpYcKK1wre7Ef+cJFxsiP/CSMC
         25K+DjTWbj29MbpFfPix4N3wfxK5nWsXYeGzrPXbrUpFNK7oHj6Fqp76LWfWhkxOqH+M
         fzWjEHCOc/FkrkTpA8xxL8o3p2fv7PmrUwITzGsqDB2dNjAxczx4mT27PPOE22/rIPbc
         Drjb494P20/N53UyUnMGxwuSGP1fmclUtQYTjSCgeBhAD+Q/z/jsHyN53p7RnTprvb5Q
         DkiCG57WCzQP/8dgK6ybFbfDOqMFzqBF7Zn3CDh4g9soFwQ/qiKsGwAy9tmEH1iiqP/k
         QwDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UEg+LTg/0UnjmAXKQ75c4HRTaVPhBivNSxLvJ/4DoNgLhNYiIESdYtsjbf1BIUrdZmXLXK0IRJyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OPyxYDffz45Q3/05AY2/G7IcfeY50cAvtgoWO/vwG4DVZlr+
	1WAMDSlobvoO54fquJlMYUP4gdKAfPXfd3e0/T7sGpxiWRBYiahwOgqU4xj27jobiWSVQt8Efnr
	L9+wV1GRi3/GfTYIvX8kdVYz9StSdzfs=
X-Gm-Gg: AeBDievF1slm+P9N1BAGbE12P6SeAuKH74GC3mgUvOyjRO4h2lafPwN01JHg6gBPIr5
	DMb6pYkFlKkkONFSzqy09yZftURMz57RLIXlqkLfM4+oqMKyGE1TngMOFfxHEl5sTzLfu8hme92
	Yw+F6qEjGlC2f9VUQTS9Ng2oljbPqxK2JMB+zxFoCTTRCRl0t1M7iFzeyjAjVVj3KJ+5t1TeL5u
	5s6eyfAca2InpUp2aq/ErzK5v0dBwB7ea1RnVt3dXamcK3RlbJdm/MQP8qfxQSlK2naEvOdJv1D
	uWyx2Wk=
X-Received: by 2002:a05:6122:6581:b0:56c:d81a:5863 with SMTP id
 71dfb90a1353d-56f3bc914f4mr7486928e0c.8.1776158105828; Tue, 14 Apr 2026
 02:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408161428.155169-1-seanwascoding@gmail.com>
 <20260408161428.155169-3-seanwascoding@gmail.com> <F701DA6B-3D88-4EF6-AD22-5B93B7809E6B@hammerspace.com>
In-Reply-To: <F701DA6B-3D88-4EF6-AD22-5B93B7809E6B@hammerspace.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Tue, 14 Apr 2026 17:14:53 +0800
X-Gm-Features: AQROBzCHcNdJ0JB6PqydTEvf-EYDEpcZl2Q8ACZnezKuovfdk29PgSZj1mQ5nbA
Message-ID: <CAAb=EJWgCFvx6rz7tL3kEeEuKuv1D-nqvnzY1Ni7jjg4EUhYtA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] NFS: use unsigned long for req field in nfs_page_class
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20832-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,hammerspace.com:email]
X-Rspamd-Queue-Id: 406D53F7CA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:23=E2=80=AFPM Benjamin Coddington
<ben.coddington@hammerspace.com> wrote:
>
> Hi Sean,
>
> On 8 Apr 2026, at 12:14, Sean Chang wrote:
>
> > The nfs_page_class tracepoint used a pointer for the req field. This
> > caused Sparse to complain about dereferencing a pointer marked as
> > __private within the trace ring buffer context.
> >
> > Change the field type to unsigned long to store the address of the
> > request without dereferencing it. Update TP_printk to use 0x%lx for
> > consistent hexadecimal output, allowing for unique identification of
> > requests across the trace log.
>
> Probably we don't want to bypass the %p formatting because some
> configurations use it to obfuscate kernel pointers.
>
> I think in this context the __private annotation is incorrect.  We deref =
the
> nfs_page pointer only in TP_fast_assign() which runs at the call site, an=
d
> the TP_printk only outputs the pointer value.
>

Hi Ben,

Thanks for pointing this out.

I realize that using unsigned long results in printing the raw pointer
address, which bypasses the intended %p formatting.

You are right that the __private annotation is not appropriate here,
since the req pointer is only dereferenced in TP_fast_assign() at the
call site and only printed from the trace buffer context.

I will rework the patch to remove __private and keep the pointer type
with %p formatting.

Best Regards,
Sean

