Return-Path: <linux-nfs+bounces-21640-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIZFFZOWB2qj9wIAu9opvQ
	(envelope-from <linux-nfs+bounces-21640-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 23:56:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7855F5587D0
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 23:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B3AF30421DB
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A03EEAD3;
	Fri, 15 May 2026 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3+DAMfE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DF3EDE77
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881221; cv=none; b=lkucXeGxsOnq8sMXvgNPgRjYF1RkbLeg6xu84kkrFf0rMsLOqprlEVO/NOE4jWEsJcdx0OU1H1FngYS/lrGKgQrX9Bx8NU0tmfKbrntFuYZeK9mhoaPSIYQpnGhBeCdzVaIA8NZo4HAJ08gYrXtxZqnkvtOPexxtTZEC3kXQdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881221; c=relaxed/simple;
	bh=yn5Ug5k2IASPmOnTWh5/NWKfju83Ji8V+BAWrGXvmqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBokfFVRnEddi1loMQR8QpI2VKcFL9gaLamMgH4Jv2WsKThZ1Hripnc7pUQ1/OtSCcnQ+JfgYhHD1r4W5qk+AnyExiXyBwx8bCdMh5YQBpCw8MSNZQFxhoam5iNI4FVjDUoKmlcf/2AzN9sF+rXJIL6rqFVeYI3ACkU3/i3raes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3+DAMfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE0DC2BCFA
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778881220;
	bh=yn5Ug5k2IASPmOnTWh5/NWKfju83Ji8V+BAWrGXvmqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d3+DAMfESZJkisVvHKKrjt0gii6H7nYuEwvudROpBZnSc+iV0LyluLPNfM2vJVOUH
	 tAuR2YoS18X6YDqToo6siVV+uoO0xGC2vIDrXh1aU8LanvWje3f3zpqLKldceV4mt0
	 JuW/GkJRMD/ClkcVcVvjhB2Axlcd9Zwx+Iyh2QdZz0w0+SNOJqRY/j0K4/zumDC4L3
	 BIqqOSARo6PLEPoy9C+Kl6x/IPtvJgJzDVFm0Lg6NocAwcBBQT2pc6T4qHesGHBymk
	 IRD4eeACwuUK5PJ84QjNOS7fdqqCZf/oFfOdb2Htjb1BetQEs9qnMzHMWbEporg6mi
	 2OuWmiVdYpuxg==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c5361142fso663677d50.0
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 14:40:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hgi/U8j2Y9Ij7Dguj2fBPDneH3aTf9NKWKiITbk1j9QJ3pkGLKzdwIr0yQEpmZPUyx/9xm4QVsxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8RuXRdlpN5R7mTZg/lBdF8gLWrI9IHV3aRItZhf/YMmYWYvy
	bP/RJnzeZ47lBndakk3rA8LLPyyGo8kNadZHu9TcIo4QFwLS85wU98Fbf2QLyYxoEVjUD8UQ5T1
	UgR8f4YEw87fRUIOnBgtqLRT3ey8QUTzGlU8I7nC10A==
X-Received: by 2002:a53:accf:0:20b0:651:d6a2:f766 with SMTP id
 956f58d0204a3-65e227bae88mr5109450d50.35.1778881220197; Fri, 15 May 2026
 14:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 May 2026 14:40:09 -0700
X-Gmail-Original-Message-ID: <CACePvbUj0-fAd-gjRjxFXYz22hGQaT9upFL85KUqD=W=SWX+0Q@mail.gmail.com>
X-Gm-Features: AVHnY4IVYDXe6JpHvzKEq9XldjgLC8IpryDPCEhie3HNTVfz3whVFC9mf8Ia0bI
Message-ID: <CACePvbUj0-fAd-gjRjxFXYz22hGQaT9upFL85KUqD=W=SWX+0Q@mail.gmail.com>
Subject: Re: improve the swap_activate interface
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7855F5587D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21640-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,tencent.com,kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,lst.de:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:36=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> Darrick recently posted iomap support for fuse-iomap, which was trivial
> but a bit ugly, which triggered me into looking how this could be done
> in a cleaner way.  The result of that is this fairly big series that
> reworks how the MM code calls into the file system to activate swap
> files to make it much cleaner and easier to use.

My first impression it looks very promising. I will need more time to
take a closer look.

BTW, I just tried it, this series conflicts with Kairui's swap table
phase IV series. Might need to coordinate the merge order with Kairui.

Chris

