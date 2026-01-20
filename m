Return-Path: <linux-nfs+bounces-18200-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAo1KZ2ib2l7DgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18200-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 16:43:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1146771
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 16:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106AB98C1D5
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AFD4534A7;
	Tue, 20 Jan 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RAEsCP5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB924534A2
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920296; cv=pass; b=nn+xhpyVLvts0pHYq9s2mx7ney1da96VIRN0UOOabBNQT7krLbH6kEixQ77k/XKVLfWMz+T92vzILHIPOLDOuroc8zwwX5YpqOUNfE/C2OUNkCONuaHhXU5Iq3gou0Eis2MOvBwvNs1T185lCzUdhS9F8AT1Z6CDLn1Fe6lAAL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920296; c=relaxed/simple;
	bh=rz53VO5WEJ6mEttqNh9dmuyaN1HDtXctdjvaFqiWAyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxb1XApsebzXQj27k7s/AX1vXCUPwZOPVAsSyVf9CYL2bZ6Hi+XqbgmeylPaEp7oOz6BlcsnxTObqm7aOho/iYKcOelrrSyQWySBGOOQkrAyeb7Ke0ylVCUUCqhcV/H5xHN+rF3oAQj/Q2wAhw6qiu7pyjYdBH4cU4QITqTRz9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RAEsCP5u; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502a26e8711so21994631cf.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 06:44:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768920294; cv=none;
        d=google.com; s=arc-20240605;
        b=IzL1Lu8fnw6zFgZk14wUD+02qZuF85NCDmk/heBw7P9YDWKpkCnaW1sB41XeOgw92K
         p1++ZPGCk4H+HzFLdD576k8ooiP9SS1EeEk8f/T02lCN0jU6vQKHdg4URxTe7d2LyUOC
         yW0Q7ZCiqzVLj0w90z5rhnrV1glkNbPBC9hzbU6nuZAca/mVSf+39Mv/qUz+HkaKadsv
         nIESOeJVOj8yIzjXDLsAARqkpBhCovdbc/+brRP2iVOnKNa+OGsTPwpy37kIgEvmjD8R
         7qkzcDYZfF/kpCBxH9SiLP2VXyn6DtzDbPKaDJkwyKPMHxOkd6pyFOQsbDbDJ0uyMQKn
         AUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9TI6H3WwESCL57aO4N/M7cKOKDQ2SmqGN3AlwYF6YfY=;
        fh=EoRcWdKr3ZCjJNKzRktZ0QxbnrG9l1zXuXTg9AgNXtQ=;
        b=CzOTG1BrCUjlDlukqxBRQbu0TQHGxk1IfXDV0mt8ac3ATCvHV7B5rOsd9r6cIBRUyd
         M6lk26tnAS484Xcmvvuj2ruNDgVDy0lkjLNvavclkdMTQTFp/y/I+7ZDuRD88ZNmQ2fr
         oVG2FJ9j6LcAOpE6AOcCBF37V6fNh6qs9XX4yNDbtc1XZmc1XG9sFdIYoowkPxyVxq3K
         PX+jB9dLCxRHss3I148gX/X6FZOsHgXsNmM7BoUZhb4v0Q9N7xp38FYGSU63mlhQ5QOa
         BMN+1hM8SrhXQYl18M9Bv/KOGXcXoHu3aGLXAGGdm2r96obxFvw9CM/PThfjNXO7efna
         dbxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768920294; x=1769525094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9TI6H3WwESCL57aO4N/M7cKOKDQ2SmqGN3AlwYF6YfY=;
        b=RAEsCP5uWSwcoqwjgXUxDH8ShyWti1UENOl+fypUwRkC2ol2hwKVPCeKrRBTUkXQvs
         kbwjIbWVkGTVMqYhHJKN5b53WUERJ0dd4nubxVaUnbtizmXJD9xdTU39z6J5qeExq5na
         zkMmhca3udNBBjliEBgzcNeul2H1SgoHnYsb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768920294; x=1769525094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TI6H3WwESCL57aO4N/M7cKOKDQ2SmqGN3AlwYF6YfY=;
        b=ofxYAhx/vawlwj3mOEvWIGmqjxZQ9a0c3NLroRQhPlo35JMiz7dIhL9EtF4egGN5Ze
         vfSFfE17Sd1kdtEF8c/QbvV0qS0YyAI4nmKa5oQ+9+MNpBh+/1OJzWhCl8mXzXh8hytq
         CNUjz5IUPlE2ibGkQjOGVvyo5jYs3oTjXLzNw98fitg/c1Ec65dqSvHWpLnc+jiIdLzq
         rfMNU+XmJzCC2+srNAwxvQT6mW2GGTFNiQkVwWwJ7rmSHS9ajBz8L5S18LzW6T1E3eg7
         7diRM2KoJaM4fl48ISLttZMdRlyazEdBNdVk+Yh1ZMEgYMzH7sZwFFD1ZcIt6wuhUjdU
         2rEg==
X-Forwarded-Encrypted: i=1; AJvYcCWCFsbtieyH446AJmGl+cI6sYJwOR+hsPlJ8sKHqTvXuSJExifd2OaHhV5rhcNJ5EWPXDGHS6vOx7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxfk78CSihkgvMTMpf4V2e0Xx1wZ6h5R1JYi8ZuZNDEypPgao6
	FyzuN4FMjxZluBveKWNa5bggOYAyuRQ/3UCZ9GW4WaXdR5RbGgzYTSnnrtzeIaEidjaAsZXnbsV
	B/puITXLe/ZYS7PQwt010fxo3vPFcuH9Elkp23RAZmA==
X-Gm-Gg: AY/fxX6gg+WCDkcpUTs1CH0kjkdd598rmCBEZxcwXwr4rpaNCOohOcKXK4mn/VdRO5k
	Bs2LXJhtA69yZtGVNDLhoIzEvJZZno17tEU4IW69efDM1dbTh1a0fXPnLpPhSxN60CTRvCUYwU0
	j9H4FUObRjfkAeSeR0j56q6FjF+QWiOXrT1YDVDiSk6Emr1U1VFdiiB3rLNFCF0sT67Nn0jJbA0
	GvJDsLy26FnFGWlIO26tUKO7RELpGzSTQxZsEs4/s/H/XLIRQD/7i7zrfuOyNiSnM0jG9EZWg==
X-Received: by 2002:ac8:578a:0:b0:501:3bdf:f0eb with SMTP id
 d75a77b69052e-502d850754fmr21826231cf.39.1768920293837; Tue, 20 Jan 2026
 06:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <CAJfpegt=eV=2OxgfiVYG7drw_yN14b7edJhj+bsF_ku7cVGuig@mail.gmail.com> <223B0693-49B1-4370-9F17-A1A71F231EF3@hammerspace.com>
In-Reply-To: <223B0693-49B1-4370-9F17-A1A71F231EF3@hammerspace.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Jan 2026 15:44:42 +0100
X-Gm-Features: AZwV_QhDJIknwKN18eydHboBF4zqKqUes2ycxxJujxBh2JV7RqxmtX4z6Jrqa9Q
Message-ID: <CAJfpegsDTopCcAQzxfqvrMJajfCRt5MnTzEM0oCmVSM=1ik3gw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18200-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[szeredi.hu,quarantine];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hammerspace.com:email,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 16E1146771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 14:03, Benjamin Coddington
<bcodding@hammerspace.com> wrote:
>
> On 20 Jan 2026, at 5:55, Miklos Szeredi wrote:
>
> > On Fri, 16 Jan 2026 at 15:36, Benjamin Coddington
> > <bcodding@hammerspace.com> wrote:
> >
> >>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
> >>  fs/nfsd/export.c                      |  5 +-
> >
> > Would this make sense as a generic utility (i.e. in fs/exportfs/)?
> >
> > The ultimate use case for me would be unprivileged open_by_handle_at(2).
>
> It might - I admit I don't know if signed filehandles would sufficiently
> protect everything that CAP_DAC_READ_SEARCH has.  I've been focused on the
> NFS (and pNFS/flexfiles) cases.

Problem is that keeping access to a file through an open file
descriptor can be better controlled than through a file handle, which
is just a cookie in memory.  Otherwise the two are equivalent, AFAICS.

I guess this is something that can be decided by the admin by weighing
the pros and cons.

> Would open_by_handle_at(2) need the ability to set/change the confidential
> key used, and how can it be persisted?  Neil has some ideas about using a
> per-fs unique value.

I think an automatically generated per-userns key would work in some
situations, for example.

An unprivileged userspace NFS server that can survive a reboot would
need a persistent key, but that would have to be managed by a
privileged entity.

Thanks,
Miklos

