Return-Path: <linux-nfs+bounces-19469-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFryJqExpGnZaAUAu9opvQ
	(envelope-from <linux-nfs+bounces-19469-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 13:31:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A81CF998
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3893010518
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8427080E;
	Sun,  1 Mar 2026 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH/PCtuZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958122E65D
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368259; cv=pass; b=q/m75TIOdSwi8rRVgtAru/uiF0hEoM07Tq03UaZiTLrWrnU8FfSzV0VlJoVCaNogxLzu6t7aljXZ3H0y/tOl95aoAFVqmpgR/aHmnb2lVqEOEYqKWVyzPGjT7OzjvhWPmy2i+0+1+oXtqi1+KqBXOwhtn3xfwqLNKU8pzYiR8fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368259; c=relaxed/simple;
	bh=+BemQ53wHbXQ1wrgK9pcl5STnYiph6e5zVCLb2uojwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXxCfYQ1OWMkE14ALq/1kyeyizyaH3bOq0DdzG6P/vQ3qqKT2wJiRM3SMDMoXNHF3x7Om6LMX5/n30fViXTf4oeWdOGPvfRlrxwZwMxiRXUOHVi8UyTCbvN/cMU6Kgs6ai+eFuFV4DTi2nK+BZPMbDDR+qoGgrQi2CdAiZIqxxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH/PCtuZ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso7104417a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 04:30:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772368256; cv=none;
        d=google.com; s=arc-20240605;
        b=ItFcnOJsnnHS0sq/C342dWPMr5UXSLI9/dYX2yQ1beKK2dHJAgpD8YjXS7CDq+2FR1
         BYzGeIBTVlCYd7kicXG2RtB760gclpICep2+wTp7N0HXV3n4tu5bS2MaSwLEtH3w2qW9
         JXmurNgHgU0dZnDP9UKfoSiqu9ai7qhjm34xSdR+92kk/fsm+lep2Jz63f4HaBc/C4XE
         VL/xizBWZuL2F0GQ5mxZrEAJnoTmHvnbHa+wDBLeq4k2LT2PX7hYiu/NlpluZNtwrO+J
         Knj3KBn0FMYZAr/WQlRu3p5MOg+xQ4J3H13E1o56Ut5Rwtgsz753MOlftIVm7F8ZT7yV
         h8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+BemQ53wHbXQ1wrgK9pcl5STnYiph6e5zVCLb2uojwI=;
        fh=PyVhScwbBqK6sWUuAFx0h95sqaRYnZlk+a22+45WYaA=;
        b=BnEZlr47iDQWZYmJco9WEq2BgHqCVX5YvuL8dK2+9uMQSMSthgK5znIt1APez9eLaV
         CICL4ZJI3Arof6kqR1JSwK4uNK+p/fSTtC0y1Wa4lbEEsAKm9NhhkuW/cb5nOyEaywy8
         dVaCSbFKIY4LQdmVbNdYM1dZ7gVMjIH2m7Ch0g8XJg08wq6GZLFibJReFWMG6SOGCTxy
         arWfU4WHY660nWVscrlG52sDPbJL1qC8zTQ/dElu8IsrTQhcJIecRXhvMcZc2UJK/rri
         OZ0Mrn90FJBbVcVT3qNEneWmBfQTAEGNsZ8MYckx74DOc+egkq+qhu79brhhlo1CdJHL
         2bzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772368256; x=1772973056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BemQ53wHbXQ1wrgK9pcl5STnYiph6e5zVCLb2uojwI=;
        b=MH/PCtuZCgkTLPSH6IpguD6VcRs1S9nRK+NfegVi2yYaY8MtlHHlUptZZVtB3HKMFN
         vakZlFqHThCqU9DhqUduWdv/L5gOODqDNDspUYdUM9mCkY7yZx5dsYqgZUcEqIiIEQew
         bpHYQC7LiUNGFpn4LbiB+WrZ/RoCs43tPxb1iInC0167c63LVrPdliw+i9+8esCTxIMv
         xMFZstgQxgI3q1Lp/Nr7va89lbRybcg2fnbqIkzaJ0fm5O3CJ6Vtt1JbnHWHzHF3SWuB
         eTDmlxQ2prN+Qlf6QA3M80M5hgl+jDxb5Vk0FtOaJUFzvRVuZ70fxnRKecVLwfB6Ytnn
         a0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772368256; x=1772973056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BemQ53wHbXQ1wrgK9pcl5STnYiph6e5zVCLb2uojwI=;
        b=CoFQOL8Rcn7Z8b5SCCpjT3XkPhQCmiRXTvDz8zXOpg5H9iSVv/Vd4KtkQVChkpqHds
         j7Ls0leHKt40J8fKr2mbF5Qkep9stjWA29kNJyLGMxa5533t28M9q0fej9r8q1fF9brH
         hvFaMZxj3OPQQ8SxEjzttxH+qdi6CNTCN8fVaqwVvxgAX6To/32AiXrDyQ93mgLsrQwn
         qEp0/oJBhu4O5wVMK+IIhCxsq/lyrUSXUshGVxX6kuD1/TYYpZcfS3iU6TCT0v4Y/paV
         CZ1c09UzFa/ICTl+U2PB8yuTjcBRYVS9u1Kz4XBgNYpPKe8msh7y8XcwQ1pniX1hk14U
         MR2A==
X-Gm-Message-State: AOJu0YwWM1SU3xG1dL+f7XasPPNZdb4N587GicLb4nW49JuX+KYEVpLc
	91C4x9YJ05AY64hHNBm8uWVn0FUQdlErb/93fbYFO0rplTO5/MirzzRhQsPj+9bJXQ0c+NmQlEH
	SmK9hk6KIU/zs/H8czNtyq4LrrH7o+So=
X-Gm-Gg: ATEYQzyaSZvdeA1fIxN4RHAD2gDGAfaqleBa8+83MSJX7hPNjbhsSjCbDD8M4t7NJEI
	WxGHOzxpi83xn0f12i5bS1wLUR3nwqwVSObegpFuMF4/wU+00mMiOaMHobWWYqHlNMwGmBmt6aD
	Amoe6iEGmNpjpcQDaAeXh3p6BvYE0aL9wS0nV8h2py4mNP4+6RVmnYxN0y+pRttzy5yoGaPX+3P
	JCo+KAFwGD/YEkS6Ckg3i4Ebp6ODT0v4zb0xnLF1uq8C2HIvK0BJr3KvJqNk9h5u0fBzJVc9NTw
	Y05LBNDjO1LmieWjWxJcCaNg47lpKd/agafHJYM=
X-Received: by 2002:a17:906:f590:b0:b83:3295:15d2 with SMTP id
 a640c23a62f3a-b9375a97109mr520096866b.30.1772368255650; Sun, 01 Mar 2026
 04:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
In-Reply-To: <aSMsb350kJgqysbz@morisot.1015granger.net>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sun, 1 Mar 2026 13:29:00 +0100
X-Gm-Features: AaiRm51TfPwuNRd1nrwvvEgeDrL6OeEHVknTHBdJ4B0Wh_HgFuDjbu61hzIEYjQ
Message-ID: <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
Subject: pynfs tests for set-acl-on-file/dir/dev creation time? Re: [PATCH v1]
 NFSD: NFSv4 file creation neglects setting ACL
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19469-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid,nrubsig.org:email,linux-nfs.org:url];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: CC9A81CF998
X-Rspamd-Action: no action

On Sun, Nov 23, 2025 at 4:46=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aur=C3=A9lien Couderc wrote:
> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
> > >
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > An NFSv4 client that sets an ACL with a named principal during file
> > > creation retrieves the ACL afterwards, and finds that it is only a
> > > default ACL (based on the mode bits) and not the ACL that was
> > > requested during file creation. This violates RFC 8881 section
> > > 6.4.1.3: "the ACL attribute is set as given".
> > >
> > > The issue occurs in nfsd_create_setattr(), which calls
> > > nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> > > However, nfsd_attrs_valid() checks only for iattr changes and
> > > security labels, but not POSIX ACLs. When only an ACL is present,
> > > the function returns false, nfsd_setattr() is skipped, and the
> > > POSIX ACL is never applied to the inode.
> > >
> > > Subsequently, when the client retrieves the ACL, the server finds
> > > no POSIX ACL on the inode and returns one generated from the file's
> > > mode bits rather than returning the originally-specified ACL.
> > >
> > > Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> > > Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> > > Cc: Roland Mainz <roland.mainz@nrubsig.org>
> > > X-Cc: stable@vger.kernel.org
> > > Signed-off-by: Chuck Lever <cel@kernel.org>
> >
> > As said the patch works, but are there any tests in the Linux NFS
> > testsuite which cover ACLs with multiple users and groups, at OPEN and
> > SETATTR time?
>
> I developed several new pynfs [1] tests while troubleshooting this
> issue. I'll post them soon.
>
> --
> Chuck Lever
>
> [1] git://git.linux-nfs.org/projects/cdmackay/pynfs.git

https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dsummary was not
updated since 10 months. Are the patches stuck, or something else
happened

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

