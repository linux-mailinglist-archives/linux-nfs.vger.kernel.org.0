Return-Path: <linux-nfs+bounces-19868-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPsuBbwXrWmyyAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19868-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 08 Mar 2026 07:31:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96BD22EBA0
	for <lists+linux-nfs@lfdr.de>; Sun, 08 Mar 2026 07:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A780C3006B5F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Mar 2026 06:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862A35893;
	Sun,  8 Mar 2026 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoBC7Wij"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655712DC76A
	for <linux-nfs@vger.kernel.org>; Sun,  8 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951479; cv=pass; b=PDJ56T52fjRGLzgz9/kw3SfKK/kNRARznrakSiypqwbPNogM6M0Lct1MK7W02PbGhd0fPdiJj7ZcHuXsJiyY/0s++BJUVk6s0gYNjA4+TyQ/lR9Wl/ADfof0LIlVQzdAG7yc/y2rfdPM7By9Rg6+PetaDplp+3T+T1JWwAylyzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951479; c=relaxed/simple;
	bh=bqMEOQ0Ckcrgyric5QOWebyRcZKyiXhkKZw3Ukws05o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI5YrYedZbb9qHOHWrFdXixqlYXV8vb//1Xnbe8J2jL0CSHTNQbr6nce+dLJrx974acEWqH1Ayti0l9MWESnoAQ64VTgygw7TPmqdnstxKmgWqTnOF8uoRwuYFXrAcZJXE+JO5EL1xwZfIrgLXVMmKYQVNqKZWFsa0XuTL6mmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoBC7Wij; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94de664b541so2992246241.1
        for <linux-nfs@vger.kernel.org>; Sat, 07 Mar 2026 22:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772951477; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7O+09Vrwfatl4OxcFcpMhPHqwnIhZy2xxN2egSolxMNHsJcheKpYeijFfq6FO9Oq6
         meQ9YqcMe4wPgAFE+Ic1K7zBhgJGmrphxSzJVRLSLPDPyyvqk8OEGqvkfN0RV/qcfYTG
         Shh5IkucOwuP/JTZfQ0qkXGugFIjpPXK75qIACU5ut8E8jruUW+u8u/jWhZaQ2uWauF3
         tQeK/l/7wVANu+BdTxcXezQmJsVc6QDSXMcH2gmRB4MpFiLP1htSrAa8xrYgaRylkGsz
         hoCEHxOV/AKP1jIcwton9+So/6nQZtu0mr52bswzS7mmxaSgokex/3HHtif76e8eWST5
         yw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        fh=SIDbn0BKKKfmpqJBFxO3gorhx8+6/MEPGseFlkvBob0=;
        b=jUr1NYLimzSjLEg9eSXcQ6ix3mvvuRCDdBtwOOZsmfHCJjsE5re6qLbYLe5+ybwnaC
         PyjHrLfwY6GN46GAh6YPEuxaA32om3tcw4EfE2bxS99ZSn8NXMP+m2sLg3YeLYduvnAG
         bzvAZPwr+EA1x5WeFv9m+jDMtRviGjmCv41/CFMPW6XxCLedcj8jRSz+YVp6e4ZxcHEC
         6GikQ/6Fu8P7K3RWe5DZBVkw5rSAu/iCa0ZQEsj0J3Y4aJhxtJBotJBNeZ8JiLWzJlS+
         tiPw+JUvPqlVB6kulBY7rU4jPho+fbe0HgPCRmpD+ayKdVMCh/SfB3mhtAZfP/qIwUdH
         WF9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772951477; x=1773556277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=UoBC7WijfmQjVlLHxpWqT3DlTCrRD4bQJHimo+Ve0AMx+0bxsR3bN/1HscBrJM5qp4
         hAoHmEH3IXVxPHPjHP72bQjLwytOTAT5lJd6vLsKUfcx09gi0FJHs8GAtUs2Zp97KKRS
         FEk475ub7vx4XQABNB53DotIZxjsKUBLPuPd0GzyFt/3v07yHqf9qXCPxfHICyaytCF/
         wULC1pF4Xso5tHqPjvY31TUJdWMLPO7UZMC4SdrzuK11/bdvaGVzvdmvJy12Y+tEql+T
         EYn1klj2Rf4ROnNVpKQExB+BChYuTiyYbqJmdmRYKShyl6hiOYBewDd9lUoEbhAHN1Ij
         57aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772951477; x=1773556277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=O7bY8UJyR2Mi2JYd46InhrNaTlTYaitqYh4nUjILT9PQlwRIKtojjdJa5HwGMtNXa8
         fRryYoGwHK90LPtlGosfazvQAGr7gkWK2nMrwg0XBoRottmTkt1v/n8h6/5sdtWLa6Zi
         c5ytT6Ro3ey7TpuXBdJFjoNNzc/qtWNO1ZeCLz80CGQJnXGxmu+T2dgRBuJZc10fApXh
         I26t0T1RRc7uNxVGQhL3ioiMMflFtH7Hp4V2r8zYrKTLT5cYdS2zeM55tlNpHrxSGZaP
         14mLkzRR2FA30XWe7HPs61scbGQekuDL9wAB1VO0MsXJ3hIRqgpYAF7WaFdcTlgUwgru
         FOWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7iNerVdU3B/92M+4xh6kFcyei9LQ2rFjR8kPX3/RSi4Y870kZKdqzcPGnMJYOjsO2k6CzWv8U0t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaDdafc6m6Tftaj3njjLQgK8w/3G6ZvowpJ4woR/g7ZpK1nAC
	JUuLNuwW/j0m1s3wzDSoK0kw4I+Ik+ZK8CkalizeLjVH4HH/PN+xgur0Cyt7vjwoAc8II7eYNXq
	9mjbz48l3UQX8XaayO5akhCAMPCEqOr4=
X-Gm-Gg: ATEYQzzosBX+r5l6b9aiR74ukL4AFVfhkwRbY79e7n4c/TcwvuyrPvj7eSI3sk+MJ0F
	HGrBYnoySh3krOHYlw2dTobrD8pmb9Mex6yaA86Z3KQX0buJIHbW07pcjR6G1HDuMT1KbUTv0d+
	4tnIEGhyr5MUpbIc9sWjtR69WCv2X4veyGFoWSxMWhuDC3GPiu6uODsz2dipVw2DpMl79h19SZK
	Q208y60mC0Oj10gM+UIAu11uROfdBs3sZ+O6hZwOAWllWKUyy1hLM+jYWtcjpLtWH/9wGQ+asow
	AMn69/wBB5CY3Qwob0SDYvEvY6s6j51rJcaI5BzD0Q==
X-Received: by 2002:a05:6102:41a6:b0:600:11e1:2a4b with SMTP id
 ada2fe7eead31-60011e12bf3mr732622137.34.1772951477120; Sat, 07 Mar 2026
 22:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
In-Reply-To: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 8 Mar 2026 12:31:06 +0600
X-Gm-Features: AaiRm51WCqo6sYLOpIV6hZ1XNIYME3jM_VRhuXhqPcz8hjUnJuRMBp96SANcO1M
Message-ID: <CAFfO_h4g-QtE1gsp3nw7+BUYnRj29au=pYs1goEnppbdU-8DbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Andy Lutomirski <luto@amacapital.net>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A96BD22EBA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19868-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 12:56=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gma=
il.com> wrote:
> >
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
>
> I think this needs a lot more clarification as to what "regular"
> means.  If it's literally
>
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
>
> I think this needs more clarification as to what "regular" means,
> since S_IFREG may not be sufficient.  The UAPI group page says:
>
> Use-Case: this would be very useful to write secure programs that want
> to avoid being tricked into opening device nodes with special
> semantics while thinking they operate on regular files. This is
> particularly relevant as many device nodes (or even FIFOs) come with
> blocking I/O (or even blocking open()!) by default, which is not
> expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Co=
nsider
> implementation of a naive web browser which is pointed to
> file://dev/zero, not expecting an endless amount of data to read.
>
> What about procfs?  What about sysfs?  What about /proc/self/fd/17
> where that fd is a memfd?  What about files backed by non-"fast" disk
> I/O like something on a flaky USB stick or a network mount or FUSE?
>
> Are we concerned about blocking open?  (open blocks as a matter of
> course.)  Are we concerned about open having strange side effects?
> Are we concerned about write having strange side effects?  Are we
> concerned about cases where opening the file as root results in
> elevated privilege beyond merely gaining the ability to write to that
> specific path on an ordinary filesystem?
>

Good questions. I had assumed regular file means S_IFREG when
implementing this as mentioned in the UAPI page:
"O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
which opens a file only if it is of type S_IFREG"
I think Christian Brauner (cc-d) can better answer your above questions.

Regards,
Dorjoy

