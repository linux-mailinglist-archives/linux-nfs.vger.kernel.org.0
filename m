Return-Path: <linux-nfs+bounces-19088-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANH3E5MQm2lArgMAu9opvQ
	(envelope-from <linux-nfs+bounces-19088-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 15:20:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE016F528
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 15:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D30301907A
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E404350299;
	Sun, 22 Feb 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nx8KjheQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236634F498
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769985; cv=pass; b=KvlHVXNQzvNhViwqEUHt2FWt4+DFEEReeIOS6DLG5br9Dn5zw5SghbEjR/pzbca4m9ICfvBUFM+HsxJvrGIqQ5TSZfPuwJILB5RxRccy9RAw6sVeBbIt8T4vCGQd84Zvg/bddYE71nM5rFeseFDnFEQC10xmEyjAxA5JAY9RS6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769985; c=relaxed/simple;
	bh=ln+l2+kKkFDBmSOGuUA2y37XlX40B6GZOr01SweZv58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+j90i9R3kwBGK8rk3UIOTNTcAj3l32EkB5dwXZWR1l6wuI/uNfPq7O1fmID5VGy6MaWDjlF5N/UbZ/wilxJucpUMq+pjRmMx64nDsHXqrpcmqxEgzpyLLDXajQ0bG2wQ9KnUtThk3oe1yOw6J3AJ+MlHchebkfidFlxNMCteZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nx8KjheQ; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1820205b3a.0
        for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 06:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771769982; cv=none;
        d=google.com; s=arc-20240605;
        b=YZp86dO4hj+OWsJ1gBRluxtipSd02N358pvHABszeEoYic2WxODC1hbIfwInN+6Cvn
         5DH3GZvfGdvdRdNlucKaNSovctEDRB0GkEFwjwIzd2xoOLnvG2XfpxUa75g9c3FPXlWz
         3KS68MPK5P8bhwst9g8jEd7GlfmnmSCZ+jFRFHBLmGWnIks9vIPObJRLL4kqEDf4iokP
         nPrtmkAxxG3KfIkjRiearsiW6DRE49I5qOhZ4RsuCrOkakGUffVEWn6anxVK8bV3rQSN
         UX/JaJErmZlXspFe4MMIyP8VlzOwdjGEhf94zmpVW6P7ZsApxlOI3ulUiryC1pjsRIGt
         rOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        fh=fL6F8MAweRNUnyTOqMy8DtoFp6CkS4kmOV40Em2t1Bc=;
        b=HNVbPD0HmtF1MPDJ7iwtRSGdMTfqRYauZOStdi2LlWD1Auj5SpWFxk1T5aB1JBx//O
         M4PdAbQctE3xUOcw3wfMY4VzCEjXXK4o+NchNk63mVaQhD3Qvi0xcm4wOB+bzpZZhw16
         /pdOcCt8Y1ELOoojKN6klwDT8RP0KjJ3hBXKYwyvR6ychMUEbcco9GNpjzffnVTN2nyB
         YJINrJBhFIpQmX04B8MZxRjt8JACrbJSUPpleKfRv4PiJo85SGiZVxH4ZtCNt3Y3R5GQ
         SxCWIuwHy71rQK3lDdYSLhV/mKhBUI8OPtaZMLJ77VeDRCufgrbXDCbVnY2Vy47NrE0O
         aMaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771769982; x=1772374782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=Nx8KjheQqYFoKeSsWjSjDkljl7DeLxDbijMH0TCbUekr4yIocKBCavivrkgn95uFed
         XuSYjq8Pcd+5CapXKZGXMujHyPS8CM2XMsK1VFq/NEU9BlgNRr0AX30vP4yE32dv7A5Y
         Hbv2Gia3NHVN7Dbg7SLniPYX1r0AX1nZqO/QynXl0UmultKmwbPnGnBn1UVWQBCgarfe
         8XAXggaIceD/wiAeYgSlFc6fVQeagqwn9JRq9mELPGKgvBWXjAAEHwqVz4J9E4ZYYqaN
         3M/u7GK2xgYQYx/5yhpHJ3oZznFZe7PrOTMXiMph7pHCPiT63E99Qjf7j/+JE40HxrtR
         KZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771769982; x=1772374782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8lBMrpe1LcWoNp46tVs1SnCv/oupmsi0daofTsKyx8=;
        b=CeqcgHA/65Jwr674V1hapPCemKbTZF4zR5QpQ9LW4+6Kei3v5yFBy+SjsVGq8DM+wU
         Q4bc+VkFUlG15krftgiEjLtIX2cOt7ap79En/6u3OaW2cPdqn7XbeFjTjcZVodTsr/Q9
         WKM1Rsgnk7u0G2mPJ9DvkQBy47QlAeJPepKqbD7G/iz8aHzgRmAsqGc+QDdZnGAms2kd
         pp/fvjxLNDvTI1P/gX0ClW55HQ6gLOCWdnZAPmxuts1tfy4ZkigoCVpNVVkg6McGQgev
         MH49rwQU/jABovKqJoWZ3/dgTbF80U0+ihoyBhFbBdpHDqb7fskaQ1LO/3jRMcxjcNZ3
         5X9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQPIwwKMaefd1AqWxezmI7PmULeuPUI93LGDIka43fUt3ES9y9cj3sTHJV0HHRCamWlsj/ewQJpDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMTCz8lDrUmdBUYQncwTEP5bB3xGcrhYG1Q43bD0E0wU0FpyU
	Mfg1XPky8zpXxEgTaWV79RBo2rX0P4kbCntwizL3nihPulcRtdNBaNEak7CeAmLQ2Hb67DTwfM6
	8W8cFkEp2gxjouB657oiEmOgow2UyGz65pEX1eeAV
X-Gm-Gg: AZuq6aJP/8z2U7+0TZNaMOpmvroXuQvuDPhXuxzdI79NHFgfJ9WQhYG3vIPtTIsw56O
	gw8HIo9617GAVF3m3e3B7cSpyIXFCZyZ88Qbxp6eznNK5rgWTRRNWcS8zl/H5QfMR6/ukoS9WJ6
	sIn07Wlw2Wb/kZF6/XTJ9CI5seemZuHvKsL6rUW7RZD/IKiV/md08ukDZf5BzpZI8D8fNLADLKF
	nhy1FANrI5mAqR8cwQDsQrZNqA/q2bhAhKODl2eXwZ2IkG3c8zm/egnIcp4FsgcZNsOBJwr+UwK
	Vjmqb+c=
X-Received: by 2002:a05:6a21:6003:b0:38d:ebc4:b552 with SMTP id
 adf61e73a8af0-39545ed5054mr4712151637.27.1771769982592; Sun, 22 Feb 2026
 06:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
 <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com> <177171292163.8396.10671162503209732019@noble.neil.brown.name>
In-Reply-To: <177171292163.8396.10671162503209732019@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 09:19:30 -0500
X-Gm-Features: AaiRm50aSxTeiNBHciBrrBXQYNf54mJgxuioR2fz7pTB6PQcKrI6Gq_TY-UauFU
Message-ID: <CAHC9VhTv+K44q7+5d17jS8h9fJY_JfQVUw5NPNvPzjkHDpqp=g@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19088-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3AE016F528
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 5:28=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
> On Sat, 21 Feb 2026, Paul Moore wrote:
> > On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Instead of explicitly locking the parent and performing a lookup in
> > > selinux, use simple_start_creating(), and then use
> > > simple_done_creating() to unlock.
> > >
> > > This extends the region that the directory is locked for, and also
> > > performs a lookup.
> > > The lock extension is of no real consequence.
> > > The lookup uses simple_lookup() and so always succeeds.  Thus when
> > > d_make_persistent() is called the dentry will already be hashed.
> > > d_make_persistent() handles this case.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  security/selinux/selinuxfs.c | 15 +++++++--------
> > >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > Unless I'm missing something, there is no reason why I couldn't take
> > just this patch into the SELinux tree once the merge window closes,
> > yes?
>
> Yes - but ...
>
> Once this series lands (hopefully soon - I will resend after -rc1 is
> out) I have another batch which depends on the new start_creating etc
> API being used everywhere ...

Okay, thanks for letting me know.  I was curious about something like
that based on the cover letter, but the timing wasn't clear.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

