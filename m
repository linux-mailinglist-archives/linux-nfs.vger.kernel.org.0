Return-Path: <linux-nfs+bounces-20869-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPe7C1T/4GkSoQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20869-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:25:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF1410AF9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D2AD300F1AC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945E3E3C55;
	Thu, 16 Apr 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4lVbpH3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EF3E277A
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352939; cv=pass; b=gozBESEK9zIf/rJxmew2ltPoxZI1nxDN37v9nksaGu5FER8Jp+hCLxvuw18AybHfjoJJyQn6AS3NNmV6Mbz7asHTw2AgdrYD//woCNbAxLq112aAXHPGxKCSdk9Svd5SnX1gjKTlYrdP+Dsrp5haJk+4FH3NnzJOEIF05eA9dWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352939; c=relaxed/simple;
	bh=d8h0wpCxAz5qr8QgJAWyo5NPmRw20h5MEF24J15IyVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nppMNHPk41dyNGTamniaRxswWpT3KVxfcSmXFTSdUwotd7nlusiDB10NsgXwwVbsMvCD5lDVN9QaynCoZATJfPlIKxzBAPfHuSA6HI6mi0icejiW0y5YrSycTayXVdMTecllR6Heuba+ZPtmkSh4QDrEpocbtOohnaApVRVIQ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4lVbpH3; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-612d8a59cc0so712979137.3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352935; cv=none;
        d=google.com; s=arc-20240605;
        b=c7GHso7Bk9c7UbLKjMe80OJiow8dDHEmjgCgrSiH5I5arQZ7s05hD6QKl/IYEZrYET
         hNsMkVP/p+02cp+yuO1GJL0x6B9Rzh7XGBu+d9Ak9XWe+3N5ARLNb3NxrjIhUL3E3Osn
         5w4lkjtpoWSBMNspfM2TIaLMDfj/cGEF4IyTX4e1nXhIG99WX/4DZK2GDyJjHi/kx80i
         xr5VMIKFikDdK8x0qwwwmCliCRJlXo5Wr8oPq2uZqSOL1RPzrrAnyNDdNZ9KiWZjDMU4
         4GQN7HkD9GaGbPx2FYGmKvBtQJnpmASKxp8n5hPOErEWAvQS5jo2Onpa57N/JHNbp4Sj
         A3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        fh=ULDSMEkNAd2WCwUZ1QOccgsmcAXS9+hWnExRug3jizw=;
        b=d8eHzImJ9WXD/hbL+qgGIXgZKJBVPhcM2WxxKNEc7orozpce0pBJbwPiZVQGtPjWYj
         eBPGwafJwGteTsOWv6duQQwqNv6Lm6oI5OwPBOf1q9Rnzn9yKVWc6c6uBFi2GDouuMeR
         Xpprdu8DDMsHO52Ra+cAB5JW50FYCIBmmyBxp2XRpjmx5fFwab08KBB4pkVxQIaALrRR
         AqtCIXq6JfQp6nlURTWglBN2/RAVEJ7q6WnFHcPyK9wYf3Zz2VqhTz2i4cReAZZQpmvD
         k5aNcxE+6Nd5c6ml0ZCxknio6ZPHb3+XNI2tb8gRWhMKoRyh+zmsgNxU05dVjVBh2RsK
         yYbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352935; x=1776957735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=g4lVbpH3NYuTwHK4zof4cI1R5F3IIOc7rqMOk/MWHpRmevLzRVb+qRlTlkjItjBIHx
         c7M0jhqWfaQ2vMdmdCGZvAPwF+odTZ9kyd6p7sv+kuJPT06vFRz8sGzxEE+RDZyrNUPi
         T43wkAslMCjJ0svGA08kUb5Gbx/3985K1GhQDZgh/+pTKuxWXmHDa0LxQ7N8Y6D+AdMV
         pK9JcsBfafPuXYE4xQ1M0Bsj7zmPTRKj8Oqs1QY2itp7CaL3brWr7nECH3oyQEx2Fb50
         mvvGzjXFjjCeXabKEm078u3WnFCD8fkfLKek/kSJSKQGUKyNJa4mEQC63tdpwccNytZ5
         6URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352935; x=1776957735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=JdPJf3NemQZFTdvWFGS4q2j8PbAjhy1aZk/n9bpdZIFJTNSaGH6PUhbNFYd8/Hd2gK
         Ln+MJ5qN4YmIc2V4IO3AzdtU8LdKWjaCjFPxPyH8rN6vTKJlCgX4rasXmATHr1AhokLN
         f6Q04jKFESGgUkYEdBqCK/zRwulb6pWJQHKr6YOPkxcouXZtNlcQFd0wKVVGqpl+LQOB
         IDgL/aDqb9vUuutlM9DtrtvTcJlq2LvopJFadmRoXQiaqWD2bRIb3GxjgWIclRLE0Ncj
         YfvSOJScvcNj3hmEpZg7ISddybdU7u5rqmRxYz4fVpzlLFoZJPgeaKd6bf4XY8z0rrww
         Xwdw==
X-Forwarded-Encrypted: i=1; AFNElJ/154SBcvxNyMrJJF8R9GmiTY94kTxicumE20A45Fap0rlaBZMNIP8dOFOOERkSQs8nH/knCHbxAy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyvy14Sp4oFbnTvcD1qHOax2ciolknYMoRwK3/yFfZU9w937q7
	aDTntRNmKhn0bJ2aSmO12PiwDoMtrNbbTgbDMOZCBvf6Km13L9k9pxqrp552e4IAORq7LUVpFjW
	dcjqcB+HWpwc8HDAsVYb2e7KjfDEb2/U=
X-Gm-Gg: AeBDieulnvsdbgSBrwl3tXRQESfETCdrkKlhG+uvsilQxr8jw8NiFTLybzSKHLpuzii
	a5RxeOU8lwsJ6EfAmuoc7AyLiufuAM638qrlXUogy1U8he/puYIK1F5v5b83Is/wqUvhzvwSLTL
	RDkfbQH1E5UYeFFtxu5xmLfyolFCXTcILeqm64lAFC9JdDkKn1AItccA02ebpGvojo/WNgPOc6l
	WYFBpNzG3R6yBo/1R9vnCLDTihDwazI8XR/FrQuVhKkNRHLsWsRQ0WXKa9eiMnaX3GelM255qu7
	aEuTbR8pzsUrdjhSSNUEOOZYfm1KUp1DbLlOdabCBA==
X-Received: by 2002:a05:6102:4194:b0:610:48e8:8c4a with SMTP id
 ada2fe7eead31-61048e896d0mr7561251137.24.1776352934841; Thu, 16 Apr 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com> <20260416-abgraben-seeweg-a44ce660957f@brauner>
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 21:22:03 +0600
X-Gm-Features: AQROBzDwlhonUu0OdB2GZDkt71Qp2GPutRABZHn8dYTEqH0ntcAPsZO_it5641c
Message-ID: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20869-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCEF1410AF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > The following filesystems have been tested by building and booting the =
kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGUL=
AR that
> > regular files can be successfully opened and non-regular files (directo=
ry, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> >
> > [...]
>
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
>
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
>
> - I split the EFTYPE errno introduction into a separate patch.
>
> ---

Thanks for fixing up and picking this one up!

>
> Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.openat.regular branch should appear in linux-next =
soon.
>

I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
git.kernel.org.  Maybe this hasn't been pushed yet?

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: master
>

I guess you wanted to mean vfs-7.2.openat.regular here?

Regards,
Dorjoy

