Return-Path: <linux-nfs+bounces-21048-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ1uA8JR6mkhxgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21048-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:07:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4B1455559
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D2D30036D7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75B34887E;
	Thu, 23 Apr 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="PN8ns4gM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C8149C6F
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963686; cv=pass; b=YjItRyRfL19qvvd20ZMWq8+fjsp1Pz9A9VlQEXfc6aNMIYTH22H6tTNE7V12N094WjxBxOMlnouyHWqfBys/3r97YxHYpXwj1AoPXiadV1OaeVDD3A6uNnwJKeb9ZOp93Hw20ZfS0q30/QLa49PphiDG9FIQLA2bjYW+HPAONSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963686; c=relaxed/simple;
	bh=oMn+kRk8o7kF+WEVlXEJQi1RFS85r1y0N0ZDaiurol8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS3wJHGhFqznDffAugJfinR9Q83EpR1N9SBg9SWnlwn+I/kynVd4HPrsknYkI5FDNz+wNhqVb2M9RoxAxQHz4VcqJDZUfWOROFnLz3w4GYJf/N+MO4R/K3lY8KXNE1QOdsWDT9D37PJ6RexYNob8eZzBZcXNNqEocf1RapZINmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=fail smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=PN8ns4gM; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 57001941DBD
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 14:40:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (100-97-142-198.trex-nlb.outbound.svc.cluster.local [100.97.142.198])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 05E5E942610
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 14:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1776955201;
	b=Nlw1dApfORUBh0+h3EFxlU8ql5S6cAuqV0ryy1ihRp6pvX82221L+fBZ8/yTHhm/mC8bso
	uFrimwhOSWXIpz0Fy6TytE73SMBpzbntbNZmgUp7KwoR2qegXLtUPozFQrFGLITgaUr9kL
	CrRp3tZQ7+Nacy0PKXjDyMD8QnZWhj4KWGMrCXdJIkrBXHAkkJ+5NFGkGyO9LDnat7wOiL
	Zfst+r8ZLP7yhssvUEgVPt3BR+rD8G+Ozg9YNE+4i68DJqddtjMjc90rTt7xdHq6KS/nVz
	Mlox/sXJd8PN4SopgtmTHSv4DHVAgx6P/+awZl8cYhRGRphRpioENmgegvsyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1776955201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CSMKb7zIELpkiDIk9dfUrRMZ9eQay4tUDcakEg7KvEw=;
	b=P5ZoFNNjWJffneNFDAdZyM86d0k86g3kYR0wFWFl6RvxBhsu8xi8hkNVWQXRukek1HfKx7
	zI7rtPgtbL/7ApoK3n2+lCflDd1HK3f+CzaehZZiQXS853k2DuEIaydNhcS73ma10rFbvD
	MGqTZw//+B8O1+Zv2HgRx7iW6oGJLKbsNInMKCFS8Lw/UCnGaftXHEkMAuH6lWnJq0BAcY
	rIjEzEIP2P/3rYrT2X/f6jorgEtgWwSzUGBlmkl3vtKJAXtTM8y/PMZzQrNttqEz3k5W87
	iXXZfcVW8owtyv4LsY6stnlm5eeU0ZD0auJunNGIgbC08cCGaZqiRQIITuKzAQ==
ARC-Authentication-Results: i=1;
	rspamd-55bb47d7db-bflh6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Abaft: 0fc501a71ea257f7_1776955201223_2371732217
X-MC-Loop-Signature: 1776955201223:1959084505
X-MC-Ingress-Time: 1776955201223
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.142.198 (trex/7.1.5);
	Thu, 23 Apr 2026 14:40:01 +0000
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4g1dzN5rlPz106x
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1776955200;
	bh=CSMKb7zIELpkiDIk9dfUrRMZ9eQay4tUDcakEg7KvEw=;
	h=From:Date:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=PN8ns4gMoY3mm1C7DGUzdfHUTs+tHwH1LRze362ErR7/Z08jV+JkXvDpO3uP+gHoZ
	 ClGR2y3jWIOba62tDh1U4iUK8NBbOViKFEMz1rbER2JSi1i7R+5XMAgTc2Y6eB1u+w
	 wCbcsjjJVMhJYCs160C7mYTBF+yWtQDgsT+oES9yk7vh+6qSCOpYNsaIKgQvwNdwEx
	 nt8wJ8FrLGZ1mDhP9X3SHcQNzIaRUtikd4QNB3rML0UUqbocjOYThaM31x7aC//tPN
	 hgBTU6wqAUsFNxwsqa+Q1rjXseedYnZGjRJ4gDub030ONchSG9saYXbyFThJQ0+iC8
	 ZtQYPiZ8A53lg==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so4456246f8f.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 07:40:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+QdsWLSqi5AJmgzs+pwPDke3yiXTXTJUZfhgo8/1XppejgpzYrYfWZx4WDv9oXoHem1alXpGjuOPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUalLJ994ylGnQ+/CseK6sztds9nrxuUyZd6PL7oXeUIgrj9GA
	Q7bC5miBkwHJf9rANPwDCdr+rFuR20oOo6f7YNuzxh8JSEZ9B/CievUYkraWXSlAAs+WfIsykTr
	jaSJ5HsNp/dnC0KaSkspVfW/cP/T6XLA=
X-Received: by 2002:a05:6000:2c01:b0:43d:7af0:3a8a with SMTP id
 ffacd0b85a97d-43fe3e20a0fmr42750560f8f.46.1776955199806; Thu, 23 Apr 2026
 07:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, 23 Apr 2026 16:39:21 +0200
X-Gmail-Original-Message-ID: <CAKAoaQnfCVGHPx0RP8C8YkpqtPZZOU98kxKm=Nv0b1bMBWFn8w@mail.gmail.com>
X-Gm-Features: AQROBzAEQMQBLMH8e_5RwKgwt68ChBFQWbVD9h1wV7ABf60ONeuwjPazJVpjv3Q
Message-ID: <CAKAoaQnfCVGHPx0RP8C8YkpqtPZZOU98kxKm=Nv0b1bMBWFn8w@mail.gmail.com>
Subject: Re: [PATCH v10 00/17] Exposing case folding behavior
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[nrubsig.org:s=dreamhost];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21048-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[nrubsig.org];
	DKIM_TRACE(0.00)[nrubsig.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roland.mainz@nrubsig.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1E4B1455559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 3:12=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> Following on from
>
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57f=
d@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
>
> I'm attempting to implement enough support in the Linux VFS to
> enable file services like NFSD and ksmbd (and user space
> equivalents) to provide the actual status of case folding support
> in local file systems. The default behavior for local file systems
> not explicitly supported in this series is to reflect the usual
> POSIX behaviors:
>
>   case-insensitive =3D false
>   case-nonpreserving =3D false
>
> The case-insensitivity and case-nonpreserving booleans can be
> consumed immediately by NFSD. These two attributes have been part of
> the NFSv3 and NFSv4 protocols for decades, in order to support NFS
> client implementations on non-POSIX systems.
>
> Support for user space file servers is why this series exposes case
> folding information via a user-space API. I don't know of any other
> category of user-space application that requires access to case
> folding info.
>
> The Linux NFS community has a growing interest in supporting NFS
> clients on Windows and MacOS platforms, where file name behavior does
> not align with traditional POSIX semantics.
>
> One example of a Windows-based NFS client is [1]. This client
> implementation explicitly requires servers to report
> FATTR4_WORD0_CASE_INSENSITIVE =3D TRUE for proper operation, a hard
> requirement for Windows client interoperability because Windows
> applications expect case-insensitive behavior. When an NFS client
> knows the server is case-insensitive, it can avoid issuing multiple
> LOOKUP/READDIR requests to search for case variants, and applications
> like Win32 programs work correctly without manual workarounds or
> code changes.
>
> Even the Linux client can take advantage of this information. Trond
> merged patches 4 years ago [2] that introduce support for case
> insensitivity, in support of the Hammerspace NFS server. In
> particular, when a client detects a case-insensitive NFS share,
> negative dentry caching must be disabled (a lookup for "FILE.TXT"
> failing shouldn't cache a negative entry when "file.txt" exists)
> and directory change invalidation must clear all cached case-folded
> file name variants.
>
> Hammerspace servers and several other NFS server implementations
> operate in multi-protocol environments, where a single file service
> instance caters to both NFS and SMB clients. In those cases, things
> work more smoothly for everyone when the NFS client can see and adapt
> to the case folding behavior that SMB users rely on and expect. NFSD
> needs to support the case-insensitivity and case-nonpreserving
> booleans properly in order to participate as a first-class citizen
> in such environments.
>
> [1] https://github.com/kofemann/ms-nfs41-client
>
> [2] https://patchwork.kernel.org/project/linux-nfs/cover/20211217203658.4=
39352-1-trondmy@kernel.org/
>
> ---
> Changes since v9:
> - nfs: always probe PATHCONF for case caps. Default to case-
>   preserving when the server does not report case_preserving
> - nfsd, ksmbd: tolerate -ENOTTY from vfs_fileattr_get() so
>   overlayfs exports on backing filesystems without fileattr_get
>   do not fail the RPC
> - xfs: map FS_XFLAG_CASEFOLD inside xfs_ip2xflags() so BULKSTAT
>   and FS_IOC_FSGETXATTR report the flag consistently
> - vboxsf: reject a short host reply to SHFL_INFO_VOLUME before
>   trusting volinfo.properties.case_sensitive

Looks good to me.
It also works with ms-nfs41-client, therefore:
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

