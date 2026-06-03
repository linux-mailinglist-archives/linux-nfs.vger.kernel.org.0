Return-Path: <linux-nfs+bounces-22246-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HLa8LJdxIGop3gAAu9opvQ
	(envelope-from <linux-nfs+bounces-22246-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:25:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DE63A87A
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:25:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WDW4VNKM;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22246-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22246-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCF33018293
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CA3AC0FA;
	Wed,  3 Jun 2026 18:24:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710137E310
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 18:24:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511063; cv=pass; b=MvRxDU8xYq7k1kKVzunf2MfizQvsvuN2uB+FXD1rj4Gpc8+LyHOAucEBLzFn9EkxKT+YB1bEYBSvHTYi5kLNKAsx7avlmKACHJBJZDA+uu9LsHJMDqkL2qbE1aKWXqpDbimZ87+xqhKBcAT491MRs4bzmp49/CBP3wkZ/FpLD6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511063; c=relaxed/simple;
	bh=HWdGSfSJ6XiOwsk/gmwA/nVjIEvHExoXM0cys0ZgUws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdzBirx/aoQXP9WvwL2iYsMrcOsJc5nGkLQvraoO+Kje9gNIJ/tSdCdzvSdndi5V75RFZkWESGBHBljFmfJxSlLSGWaEEDUc+TfEjRlr+75fJEKUMrsEVSzAkPIBQogYKjaw3n2l14394vesnFSrqzA6Xas4S65SuaA9KwRu8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDW4VNKM; arc=pass smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so1704a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 11:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780511061; cv=none;
        d=google.com; s=arc-20240605;
        b=dpnksc0rp0P2L0igXiAdl9l1hvq18jvmy4/tb24OzvMp7yI1+QzPO+C/u96dS1coHG
         QRHQpF1nBQJizzs4yz6aWoeo0mbq+YoFkF9iCMsm4/6Sh6Zno4GUWOdqqYRXcQp5Rgc6
         2He7r+gujmtOrGkLTLD5C399RkB3g8Jg3jeV+JsFnE51HQBUAAKSMdZZ/kOSPNPIZUzr
         2yRb4ukcnFXYXAXWB2cYLtEXbCOWCG/wtLYeK1JY0cLB+B5L4QMvChNgKuLU0Uwc40eA
         Ne8XS4IU+LV2/bK5Va5/q4VxF2BQQ8C4cGhJR7yuwfapHTMyI47CluLVJzFY7+Q2jfYl
         g9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        fh=G4ZNvM/dw4XHsRqMntElE6Y1ujDgIz4r8qqIXxx3i4E=;
        b=DpAFaI8hZKR5uJvLw0GseV97f2J2VCoozwhGMM5WJ3awXvHNH721FEUMV9Lz3HOS/j
         tRlOe2t7Gxtwx06ILjRGOGZKvYqtbdQayiclbk1alCcRG06Hm2NVzB6ZGiA7FXCzo/zM
         ttdrYo5Ho3Mn0Qw5lM+GsmzwXo2jr5IdjAwHYyJxx+x+Veniy3+bz54Uop4Tt54sg5JD
         q4HEsEiON8ODx4tuoXOzYvLFZgliYo5O5t08CFMSV3EawI5MHMnEf8jPDv8i4eQVVGvP
         dWc+0L3GpNWYxICMMuopKltNZf1gSZGoBoS66QPWSizWTHwzIMfJnJw5thHizgKXY0FO
         OMnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780511061; x=1781115861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        b=WDW4VNKMeS1T1upBXj2gFftz54NnBPendE2Fw3Z6doAar8VU5J7nu5zsWtAtu3mx3D
         RV3T4SziMwoF+S6BRxkeYIPXCRM3z2HpM23w4d9NieV3rO6SNqrNGZaQmKivjSgYSknc
         TlCMaB2tdwVKgjPnosOKJ6jsbdfu1fCmWlMRBaTznJiYtAi7Ogg/OhhZIlxdGKUTorJE
         sGIAfHsNXH4rS/PJGrcI3vl0UGCRIEiBhNP5w0ZQb5/JeNcBbx/7N5Jqv0207U2fn7Ol
         8WkDdX3tSqmW7GqzZmCe9k9/5JvQxBXGbBSF8A4Jq4Fyaz+P8LdGSiJ5rvPuKhcoyCHf
         IlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511061; x=1781115861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        b=XT3ZdwHzIQ1mdSDk1IKFj8Iuc75DZiaDRXjI4xI4h2EBYGr+FV9ASjcSYfnF6o2C37
         eQatBdE5Q7IbwJ9UHFkBfBogXcUFeqIDCcrZCyiVN3k2p2Aacc/ODDKXB4ujFIX9hFK8
         qUNvqUZjGnpA5vo5XaEGYAXcZUk3i/JEkJAjeRvDwtLXtoPBsEUIVvtUL2gYHOGGwsFn
         GsBsLHRYXPLKHVFlXTvWzheBbqfXIRyyW5pYnYi3Ri9RckkAuLGBj0b5W+98CtiwDf1T
         MlRKEtkhofCvFicp8gzuNeIfHXRbOiGuTYxlQVvxGD6vq4epidjTwvqh6xg2gMxHIJLn
         PcDw==
X-Forwarded-Encrypted: i=1; AFNElJ9oQMeA0IfBp2tkAn7JJXRxgoregujVX1aibvt26eUBYEd2SDmp671bAIUdGBXxKwyPxTRJC2mt+WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijzrMc+VqiHc3n2EtuGi7Y4NbTQ4cley1bS+3vlCT88PfLNJW
	9vYlSjeQ4p2LxVjgdaKB/nUxSZQnvSqbVoDJeAqDLD0xuyNcaGBBUurzUNq7h6u44myeDTdclBO
	Y9eCS2tgTh4O4znNZ4txe8hm89r9sDsAGUkdgD1Uj
X-Gm-Gg: Acq92OEeho8D/4jm3HFl3ce7cgf77waNWoAGre7gpcc6wx44VPw+ZstZ9ESCTaEe8Nw
	VBaTArhBP7InmU771qJTvuQNgJjdkF0g8QfmgviDYMddogXOCrFR6QDGm9QS5femBs1ryH1WBws
	TS/259FPlCvaaLs1FoKZUq8RNfenENL7kSIsPVle2IUBUu//cFu5A3A2p2vMHH0AHIocJxFvuSf
	HAnBzyxabXfGflGdi/Igp+WWUOiyGzmiasorMbIFdtgf6Fs+MrM+5V1vdsh1hXnbq7igp0RmH8B
	Q/kaWk9pycefr6yiT0x7KH4QwJnyPsJq0K8ubh3kuli+yfATHapwvRYnQpY=
X-Received: by 2002:a05:6402:4d:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-68f120888f3mr9598a12.2.1780511060391; Wed, 03 Jun 2026 11:24:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com> <20260603181523.GW2636677@ZenIV>
In-Reply-To: <20260603181523.GW2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 20:23:44 +0200
X-Gm-Features: AVHnY4KcxLLBzYv04O16lPgfRsGmNsi92bRo0L6SiX4sR-aXpPDHaC3GJOZ42Y4
Message-ID: <CAG48ez1DGQ8MbFWWi+n0Br84cBF_wSrNgPqd+NSxAcbAK7WR7g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22246-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 159DE63A87A

On Wed, Jun 3, 2026 at 8:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
> > in __prepend_path().
>
> > +     /*
> > +      * Containing namespace.
> > +      * Normally protected by namespace_sem, but there are also lockle=
ss
> > +      * readers (which must use RCU to guard against the namespace bei=
ng
> > +      * freed).
> > +      */
> > +     struct mnt_namespace *mnt_ns;
>
> Umm...  It's somewhat subtle - at the very least you need to explain why
> there will be an RCU delay between umount_tree() clearing that and
> having the sucker freed.

I guess I could write something like this instead, to make it clear
that this basically follows normal RCU rules, except that this code
isn't actually using RCU markings and accessors?

"This is like an __rcu pointer which is protected by RCU and
namespace_sem; however, because most accesses happen under
namespace_sem, it is not marked as __rcu, and RCU access is done with
READ_ONCE()."

Or we could put __rcu on this pointer, and annotate all the locked
accesses with rcu_dereference_protected(...,
lockdep_is_held(&namespace_lock)), but I guess you'd probably prefer
to not do that?

