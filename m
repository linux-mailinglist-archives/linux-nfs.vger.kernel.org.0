Return-Path: <linux-nfs+bounces-19157-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCQDE9wbnWmVMwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19157-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 04:32:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A730E181654
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 04:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A290D3036EF4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873003EBF17;
	Tue, 24 Feb 2026 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW+fI8PF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD371A3179
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903890; cv=pass; b=eQkxsz2x937gag/SGSz1jVOrUPrQdu2PILSY6u6SBMoPP5V3KTzjpU8USa1LxPji+TEViUYXU7gQuavcVuQewBCfeXt7LiUH+0W9MI75NwgROUUS9yP1fK5l3X3/n2ewg5L1Vq3N6axDruos59ak3XE30iVDKuxYmMFatbie05I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903890; c=relaxed/simple;
	bh=0veLAPKnNtqrllFgu4YwWXDXJZfIIcfAA8eZ3piGHCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8w8VtJ9Ujw/oXHNbtGIuklCH+L9iFHOZhIQurI62Q1Oo/yS5zUPynSvPXle/WXbxQWCxGpKprUPYr8IRIMhMrLB8mnDfUHANG1qeJBhMH5hPlq11KmT4dVZpSZMh2ysXxHUPCikm6uesa9nFEmYlXVQB0gR5xeKBEi1e5+vHgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW+fI8PF; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so5611348a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 19:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771903887; cv=none;
        d=google.com; s=arc-20240605;
        b=dOZQdC/0e7OzDssvB4xIdsLTcWOAv5n3Pbg9fw35yfKjO6iUOcBDSmYj5JfGQC6wHC
         aPDyK1H/taClux8Jnhajk+7LLDNxPC49HrPWUWOqH6rBUOcoiP2BTnj797S8ujNa7Lgs
         iOLgkpuJOsEWultFdKC2N5htKfkO8lvGCicjRdGZca5r5PX5//1xPigJrbw75irBR6D3
         oBR6b2vWWi9cBk1NfSH8TReeJtVUoc3InS/vgxR8MBxQI+YPt8YI94lrlOD5WBog1p3A
         GYK9EuaexinxRtkSgGbl+1k79QeyRNasgHaFoGrn/xtlumJf+sdtzEN85aM75s9oUNzq
         nIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0veLAPKnNtqrllFgu4YwWXDXJZfIIcfAA8eZ3piGHCo=;
        fh=KfmfHQ3NKIEiH0mAUEGfhbPqwZvZnDJ6ZRY/+jyvc8Q=;
        b=W3HVOtEE47DyJtfd53erP8qDpUPP/XhWcjgPuwDULYC/96Z1ab4o8f0jSQ7+HZlICM
         48qnuODlwFS1t6F7+fjgSXcYtUgHiNSalk0VOj9eKbPxhcK6T3YhdTybnRlyO3wwxgb3
         QVRaM0xxqC2mKRdqLleJlpruGH25ZTCj6k5U2TwfVOW1C1e9HhpaaT5kb6iHqdvDsW3p
         ckak/RU9JsxsuZEX8d/KzWIcuj25YsjC4/510aU2YBVRm9gla1VwY0VGVD4hfloL2DlF
         izdr+KaWxwB8Rt/O04VeeRrtsIxn9+YWNgfDD7acYRQLt0F+ex8fzRTxr+4/gKnIVi0y
         5JkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771903887; x=1772508687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0veLAPKnNtqrllFgu4YwWXDXJZfIIcfAA8eZ3piGHCo=;
        b=LW+fI8PFY89pqrElgzFwJqMnsTm/UpDQIht7hFc2pXBeg//TE8uJXxteoG4If5INom
         5+s2VWcVghcYv5h4lgyclCrmqX10dS2dOOTvd9RdCBFhs75rclL+y8zzCSFLMpLL+Bol
         sVLAEKl5HY+L6sdJGtm8t8BhNCJhUF5qjQMu27ZjLzvaGb9QWotS27SyuaA2aygMgfJF
         J4ZfFt2vHxGUNwlYAD4OxZymmybP7sYxAKLaqu/aG6+jtbfPHgkDa0KIEjAQSJp/RPmy
         9moM3uGcT6BntswnG30fp7JNFBLkugnkoJV6XS4vT4tP6x4R0CaZyU5aRsg5cG9rTLaX
         OmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771903887; x=1772508687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0veLAPKnNtqrllFgu4YwWXDXJZfIIcfAA8eZ3piGHCo=;
        b=l9zeDUKNv/eTrq/ZG+C7DZZcIJLAk5z22gUhbbI7oUj8/w1ts7IcuMEZfeNhMCICpX
         b4+HOwgs/DXIC1vv3UqDFYD6DsvxZJlu263GvjhVvx6nxsL+0XAz90csV5ufrqf+IquI
         2DY1hIT5/2G5YTCYck61PBpwwETuvxKFKRRg5UopEQhiSoibUcQPYUHjZYN6l5lgYpuo
         qV1t9YWKzWvLrcSwrsysPTHpDzNCo6LH8q0VooKieEIIKrS7kaCbilZKceu5D+XwhbR5
         sLVUo3VXBNzjKnqbZa3RFogQzBHXl3Z9JoBHD25QxZJ76Ew4eGTFqCRmPXJER4Pp3leG
         js9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZZtIJQJNPlGkN/JWmaWiiX/3zS306gnZORWEM2b30cfuaerS4eRdx6TbA6vQcdH0SFPoje2xyB44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFqq/YTObqTiv/G6lvgNtRzODYKZzVx+3dEzasEshcDKmj/sf
	gzVlvQ3ZxyuCSSxLZ+mNSe2tRNtxo/jjqIq7I1oGxsA6RAboYEl2xlg5LXo+1swbRsllRqfVpot
	QmINAAmibjv1ouzAxybCFvdew5ERhyoc=
X-Gm-Gg: ATEYQzy8H07YxOMM17vEFNhMzn004XnPAl7jYlgpECzYJTxItknRYd9a9z40PeiFJV7
	SnoAz5Ze5K93pHap4GPhHG9LcFNp7rwz7mx3rsAiMD2ODlB3Wo4HYuyzz4/c6j2T0aiu2XgSPzZ
	OPttJkIshGjIaRAAJ5ZA/X1jaehUH/I7fUj5HBZTV1OKfrKwIiyo7lbVdZjQdNqZ3u5tE+3L9mb
	XIBo3vc3f0m/ujs5gVMtf/nwSfxfkNWY6qXDIrUyyCV+wmMapHhtrTYr9h1CYvdanV4F59SivJ3
	l9e1aA==
X-Received: by 2002:a05:6402:3496:b0:659:4099:877 with SMTP id
 4fb4d7f45d1cf-65ea4b5bb64mr6789273a12.0.1771903887278; Mon, 23 Feb 2026
 19:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com> <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
 <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com> <785793ea21fb65c3e721b51f24897b3000e4aec3.camel@kernel.org>
In-Reply-To: <785793ea21fb65c3e721b51f24897b3000e4aec3.camel@kernel.org>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 09:01:12 +0530
X-Gm-Features: AaiRm53-xi1CQSq700hQjQkka5CX1DHq2zZa9svc3qYxT3AcYdWXHPXYne2Dd1c
Message-ID: <CANT5p=qmNsBEDuMFjNUUV15hgnZ8_pQjjJo0HD0Aj-ezL9vM+Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19157-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A730E181654
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 8:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2026-02-17 at 09:21 -0500, Chuck Lever wrote:
> >
> > On Mon, Feb 16, 2026, at 11:14 PM, Shyam Prasad N wrote:
> > > On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> =
wrote:
> > > >
> > > >
> > > > On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
> > > > > Kernel filesystems sometimes need to upcall to userspace to get s=
ome
> > > > > work done, which cannot be achieved in kernel code (or rather it =
is
> > > > > better to be done in userspace). Some examples are DNS resolution=
s,
> > > > > user authentication, ID mapping etc.
> > > > >
> > > > > Filesystems like SMB and NFS clients use the kernel keys subsyste=
m for
> > > > > some of these, which has an upcall facility that can exec a binar=
y in
> > > > > userspace. However, this upcall mechanism is not namespace aware =
and
> > > > > upcalls to the host namespaces (namespaces of the init process).
> > > >
> > > > Hello Shyam, we've been introducing netlink control interfaces, whi=
ch
> > > > are namespace-aware. The kernel TLS handshake mechanism now uses
> > > > this approach, as does the new NFSD netlink protocol.
> > > >
> > > >
> > > > --
> > > > Chuck Lever
> > >
> > > Hi Chuck,
> > >
> > > Interesting. Let me explore this a bit more.
> > > I'm assuming that this is the file that I should be looking into:
> > > fs/nfsd/nfsctl.c
> >
> > Yes, clustered towards the end of the file. NFSD's use of netlink
> > is as a downcall-style administrative control plane.
> >
> > net/handshake/netlink.c uses netlink as an upcall for driving
> > kernel-initiated TLS handshake requests up to a user daemon. This
> > mechanism has been adopted by NFSD, the NFS client, and the NVMe
> > over TCP drivers. An in-kernel QUIC implementation is planned and
> > will also be using this.
> >
> >
> > > And that there would be a corresponding handler in nfs-utils?
> >
> > For NFSD, nfs-utils has a new tool called nfsdctl.
> >
> > The TLS handshake user space components are in ktls-utils. See:
> > https://github.com/oracle/ktls-utils
>
>
> I think the consensus at this point is to move away from usermodehelper
> as an upcall mechanism. The Linux kernel lacks a container object that
> allows you to associate namespaces with one another, so you need an
> already-running userspace process to do that association in userland.
>
> netlink upcalls are bound to a network namespace. That works in the
> above examples because they are also bound to a network namespace.
> netlink upcalls require a running daemon in that namespace, which is
> what ties that network namespace to other sorts of namespaces.

As long as the "connection" is initiated from the userspace, I think
it should be aware of all namespaces (not just net namespace).
As you said, this will also mean that there's a need for a daemon to
watch this fd.

>
> So, a related discussion we should have is whether and how we should
> deprecate the old usermodehelper upcalls, given that they are
> problematic in this way.

I see a few other users of UMH: coredump, initrd, kmod and kobject.
https://elixir.bootlin.com/linux/v6.19.3/C/ident/call_usermodehelper_setup
Based on the descriptions, most of these are used in early boot or are
done in subsystems that don't need namespace awareness.
To me, request_key is the odd one out here. I think we should have
upcall handlers in the different namespaces to watch for upcalls.

> --
> Jeff Layton <jlayton@kernel.org>



--=20
Regards,
Shyam

