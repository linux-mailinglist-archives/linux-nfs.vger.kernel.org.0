Return-Path: <linux-nfs+bounces-18620-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABd2BFjdfGl1PAIAu9opvQ
	(envelope-from <linux-nfs+bounces-18620-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 17:33:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78941BC8BE
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41479300292F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA6320A33;
	Fri, 30 Jan 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmS+Z8no"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8D2367B3
	for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790801; cv=none; b=ZshfeFahKBqrDdbLHWFoVDXrjs9/FiyuLck6SIfSeBPgRvyoh+lohp13fQcVNMkWJ/VJc6dLwB92nv8/BkXFJPKD/3R/uYwGnzJw3P8yPKYuVlWMG+jWkmoDxM9Fz3FSA7Phy75Ry422z/LWuOmpclmR2SfSpj3qVxx5Zg5yzQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790801; c=relaxed/simple;
	bh=Nz0IQMj9gpqoNpwgfkSaMZrBqdMpWsXigzJrbzuVi0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlJVD+tZj5SYzHcC0UcIlF7YXeWnTHW2IQbHM2W4OOEzLYrOf7u+MpLpgDAB/SV9rEJLITDsQLQp+RzSRdfyffBRPF/NN5EeHwe7g5Lhw62x+CVpGFCiP8j+7KKYqnIOab5ulfjo5F0mP2M4+dKvptFry+hvZaVbN7IDQ6FZcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmS+Z8no; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4096aab5521so1653714fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 08:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769790799; x=1770395599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nz0IQMj9gpqoNpwgfkSaMZrBqdMpWsXigzJrbzuVi0A=;
        b=WmS+Z8noPYo6Lx/PNgOvWW4SElDfDGf/aIkbLySJKfbXYSANgBNuFoSDjnNZpQS3LC
         1+N7UfwPYvreZH7JvQQ9sLc/5ICvjg4Oa+bYbva0f/Sm0Zgp9bn2cjIKs0ofq59VzC9q
         abCj+x0U/6BEjPRXEHStgu9wtsm/7qzeVkfVXfvsere1eMXPpcew+NdWUmiHVAbvcTiA
         XQgLacwS4v1lgltyzpRVTvVraHrL0MOS0ldZPpVjcXCnC4kcjm1A+QKOR59wg83gnjlL
         jXldP/e+C6MRO5wSBEMmBVN//njJRRS1aoEdY/HZh0CO7SZFWr+Yd4QKy/Vuo/LL9l8+
         CdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769790799; x=1770395599;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz0IQMj9gpqoNpwgfkSaMZrBqdMpWsXigzJrbzuVi0A=;
        b=SCXjFZ0G5PsXgSft5kdMdgs/A+XP2/TGaH7SbQVwxo69USMMM08qiFLLJamfWtr1oX
         khvtklLfgIxRwssHmQDVWXcHkQr/kOJAhDmyGppcuXpEQJSbSI4t1HSNPAtN/2nrvKKr
         3Cq8gB3xub9A/Z146qXkZgsiradAE6n83DPLdeOpaais8Y+LoqZmgo0YEO5cOozi1oEC
         4vw7vOpoivnk2L6RPoC9+IlxgxtC1g7R+U88jdOExG7aAnR4TE/ISLpEAuiyL89pHkGQ
         VlSzITlb2h2lMHWzdtmXhh2DHVQjSOFiQgJ/yhFqcW3lGSr3wch5DrSxczMERXW4ScT0
         Z/0Q==
X-Gm-Message-State: AOJu0Yx4h6Cm08KiAHBk7b4dRMQFaTjrCVqM1BRiKBzHdp97kPDXjLJk
	5AcB/mTUQqUrNMQLFjrooXOeWQu8B01joHargyn4BTczZEz6lv7W7BA=
X-Gm-Gg: AZuq6aIWgzKmZveOe+WNMYf7JMSGl1Aiq6hA2Hf1Y48Kl9YY5jmqJjJA0/rTJ66hIzk
	wdsAO3Cn8E+ULj5oCYyAYWAtQxNPk15UBuNMORMeII/7vL4iNdtPKnHyFBEmxqLZSh014DunNh5
	/rLG2Yoo6SZcUPCCSarDZaFpaOqBzEAQqbTg+hmhXR3g+qpAIbX/soGF7jc3ZwpzPViE4LDlrVX
	g8UeOl56VJQM6yESlcb0uTcl2L4i6aC4jn7GbxiveZgtPUwvyDbbpykiG2uQQc/VQ8e4jp23Jf0
	IHkKtx2wX4zwgtmlp+LwiDsjwrXFz01/E/IvnwpzTLFyZ3BQc39zg8dbDLxSP20KeCkzCrdtP+l
	T3Es4A/h+0MQRdgd4JPHKuqjepiffMxSMen7wYAG+9KG8e2vPyix9GqVZYAhfxqKs53CNQdOupG
	2ai7trw6XXhArVVeEWO0Ju+/vM5Kq1RbRKCBff4C5NWf0l8vKM+u6HDmb74eM+1FRspIqIi5MYv
	ZUjvecKhIWPJGRfz+33DG/o1FeDGWbv+XXIk/lXaV1e6Uoq+xYkhUjoxMujz1QMGxykWYrzm/Hf
	HQ==
X-Received: by 2002:a05:6820:81c8:b0:662:bf0e:16a1 with SMTP id 006d021491bc7-6630f3cac58mr1638959eaf.83.1769790799063;
        Fri, 30 Jan 2026 08:33:19 -0800 (PST)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095753b347sm5469812fac.17.2026.01.30.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:33:18 -0800 (PST)
Message-ID: <f0c1d246022214e41ece2b42424be079b182c246.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
From: Trond Myklebust <trondmy@gmail.com>
To: Benjamin Coddington <bcodding@hammerspace.com>, Lionel Cons
	 <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Fri, 30 Jan 2026 11:33:17 -0500
In-Reply-To: <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
	 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
	 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
	 <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18620-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[hammerspace.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url]
X-Rspamd-Queue-Id: 78941BC8BE
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 08:25 -0500, Benjamin Coddington wrote:
> On 30 Jan 2026, at 7:58, Lionel Cons wrote:
>=20
> > [You don't often get email from lionelcons1972@gmail.com. Learn why
> > this is important at
> > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > On Wed, 21 Jan 2026 at 22:03, Benjamin Coddington
> > <bcodding@hammerspace.com> wrote:
> > >=20
> > > NFS clients may bypass restrictive directory permissions by using
> > > open_by_handle() (or other available OS system call) to guess the
> > > filehandles for files below that directory.
> > >=20
> > > In order to harden knfsd servers against this attack, create a
> > > method to
> > > sign and verify filehandles using siphash as a MAC (Message
> > > Authentication
> > > Code).=C2=A0 Filehandles that have been signed cannot be tampered
> > > with, nor can
> > > clients reasonably guess correct filehandles and hashes that may
> > > exist in
> > > parts of the filesystem they cannot access due to directory
> > > permissions.
> > >=20
> > > Append the 8 byte siphash to encoded filehandles for exports that
> > > have set
> > > the "sign_fh" export option.=C2=A0 The filehandle's fh_auth_type is
> > > set to
> > > FH_AT_MAC(1) to indicate the filehandle is signed.=C2=A0 Filehandles
> > > received from
> > > clients are verified by comparing the appended hash to the
> > > expected hash.
> > > If the MAC does not match the server responds with NFS error
> > > _BADHANDLE.
> > > If unsigned filehandles are received for an export with "sign_fh"
> > > they are
> > > rejected with NFS error _BADHANDLE.
> >=20
>=20
> Hi Lionel,
>=20
> > Random questions:
> > 1. CPU load: Linux NFSv4 servers consume LOTS of CPU time, which
> > has
> > become a HUGE problem for hosting them on embedded hardware (so no
> > realistic NFSv4 server performance on an i.mx6 or RISC/V machine).
> > And
> > this has become much worse in the last two years. Did anyone
> > measure
> > the impact of this patch series?
>=20
> We're essentially adding a siphash operation for every encode and
> decode of
> a filehandle.=C2=A0 Siphash is lauded as "faster than sha255, slower than
> xxhash".=C2=A0 Measuring the performance impact might look like crafting
> huge
> compounds of GETATTR, but I honestly don't think (after network
> latency) the
> performance impact will be measurable.
>=20
> I attempted to measure a time difference between runs of fstests
> suite --
> there were no significant measurable effects in my crude total time
> calculations.
>=20
> I could, if it pleases everyone, do a function profile for
> fh_append_mac and
> fh_verify_mac - but the users of this option do not care about gating
> it
> behind strict performance optimizations because we're fixing a
> security
> problem that matters much more to those users.
>=20
> > 2. Do NFS clients require any changes for this?
>=20
> No - the filehandle is opaque.
>=20
> Ben

The other thing to note is that this is an opt-in feature. If you don't
want to use it for fear of CPU load, you are free not to change your
/etc/exports config file.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

