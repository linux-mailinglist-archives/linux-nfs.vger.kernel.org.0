Return-Path: <linux-nfs+bounces-19038-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE1mEHFol2nfxwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19038-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:45:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAA162256
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 20:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21EC1301FFA9
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD23093C3;
	Thu, 19 Feb 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="YkZIZDS3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2F2D0600
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530256; cv=pass; b=E5JTIgDgPYCqxuRM0QUppV1YQYogJ2toRbAev9lF1BcmwJ5DN4586Jm1pCaUtGi29fekmRXewzp3H+zWS1Y5BN4S2No2veQJroW58T1HK236nNn//FrAjNCQquppgoydZ0+GAocLwATub9pU5FrlG4tRv2xmAFi3zaMCfKadtWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530256; c=relaxed/simple;
	bh=hsZT6RS5nLhfg9oC2IDk8/0IDDbujvnD9lesm/d3ugM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMRzqdRr8iOz7m5SlfskX/tE5oTSWN4tP2+4Rj7lc4D1YmX9arIYDdck3NE9tAlfzRzXxHrFF+V/sYLAJ9dk6K696gjBvQUE8+x7zQfell+WHGLsZvNPcyAdid2HkO1XJefIFlYWTmLBy0Ea7jTM1fThD65nsyKKj500Q+MKScY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=YkZIZDS3; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-385c23b88e8so11838081fa.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 11:44:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771530252; cv=none;
        d=google.com; s=arc-20240605;
        b=RnNpoLmZC8U87eDeAMMF8jxfKlbWJzS6CxgTwleaQnaeLRjiYD0+EO1Hf+WvNmNUUP
         fVXoOEmZYU4vDZdYOwj0d2rtUYCrO2VD3vtER76xMGp14M0YDrW/mgsxpuzC0sUk7eZH
         BmUAhDU047CLMdrsCZFHL5MbykHFjVvYsEotftEdvWyO+RqWx9wYrIY8yIZE3nmen7cy
         r+g1frKd5jqiTwJ6Oj/DdfGuVLmYGeUx9zvq0iBBXeuhQF9biIEPYiXtFPxnYaRflrQf
         UwgdNXlsM7c8gz5xm381Aadm+I1uA8igMTy8OVjPCm1MMlzjT3Wlf6GYjY+IZew/TMse
         v/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NAoKDdyZBPE7OWmJqiO7HIs5ZuFQhWuCWqvHd1qiLK0=;
        fh=vsOVM1LEn2YwrKdqyD2OM75AYysN1GGIChhcYgJukgM=;
        b=hXsphenuP3B9rb5S+xd3ysXZfgYgCvdwOMbjtENfJ0EJAd/MFd37mJ/2e1fWPXLlrw
         OVV0HZQ7V76NK4uFdzT0bIqWi7jJ7KMAKKvzZb8tXSlnxN20RTDA9AM8s2a2NGzsbUu7
         fxqdFap3UR6mXD++VX9w+NGXDu5xpm4Wa4lFmoa+HALtnknwwwj9r+T+GlQNHjdfVwnb
         4wf/MOfskuAJDENubKOPJ2c1XuiWd4KV5NfNRREeKg0VkAnATZB7QLykP0+6260oRaQs
         oDs72q8S1hJP6tgGKqouZNv7unvsD2WzG5YX6k+k/UtfFiWnWJW8f+PdQk6RePH9f9eS
         kjeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1771530252; x=1772135052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAoKDdyZBPE7OWmJqiO7HIs5ZuFQhWuCWqvHd1qiLK0=;
        b=YkZIZDS3EWaRKpU3oIRZkdqsds18bvL5pM/T36wR2sed7CNDRlTkAAELGDHZYyf9It
         dlXkrBBmGC1ddKMmMp6n3jZg3yaNQJm39cnGmI4yOt6bs2x2Y6z1eM5HhRbOzAz2CuGM
         TiKCiRCuISsgt6HAmM9Xm8h1mscKyLrKZ9bUBps6HR1TiDsGvU5JOaXcSbslCyGJloMs
         SV+0StaAV/cp7eWfa1tLIsajZUwofMdKcbl/c1dKIyKQYtIpsZJhyIzDMYsXH+B3IAUi
         17Gn/mhsmyU+AV43ewkE6uY8pLuYwR+QZmrgzhZXP1Rbl5AV3ZyvK1yDiLO3+Du9jJpl
         7hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771530252; x=1772135052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAoKDdyZBPE7OWmJqiO7HIs5ZuFQhWuCWqvHd1qiLK0=;
        b=ryoYENWyUxr7gw10dreSbWf/aNKDinGUi2A3tuW+JPBU9HzIN+F5aZyaGIpJAE9ZOB
         ZRMrKKA6b35yH1jXzUygc5rMkjiNZMrWkIQEDCC+HnnmythxlWcpmSh7M2Yr5jJZwQXK
         a8yg1jpLyv3TO1G027F6ztrvokqCFU9M0CQ4jKruRf+ueQiEbSZkbBW6/wG00SLagfH8
         Wd1HWkMcXjRVzp80oTaC3wQe8pLMeSQAK8xSazjjK/2g/kZYdieEqa2igd5RLe9S3+qp
         UV+aNKnC+YNKrUOYo1BZp2u3zgR1h1gwMimwiCO9KuVC+x3+VbQ5ceCyA5fUOjxBM/cQ
         MwfA==
X-Forwarded-Encrypted: i=1; AJvYcCVE4/ewbgn++/pfv9f1W+6J0vXG9wJtEJp3zBn2nKr/7/YIx403mXA1K/sY6K179WdlwTDlC9uEayU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmf0o68DvBbBHTibk8q+7MyRhocGN5jJZrUXZsUdvNiG6MUUF
	/OXiEpvjNBcJBW0DozVyO4w+GKaGxSoz6cZjkgCfP5K1UK2kXQ9V2ngKwUj+PUfPbHyoSEraY8s
	zt7ckn6iOqhPl8Hf1sbnhkexEHuQc2Pw=
X-Gm-Gg: AZuq6aL+RKaQLbJ+VqFrWQv9vIjNMXr/UKPeEksSQWc27M+Vt0PRPSm44EjyG16JjX1
	sbXfcd3UUU5x/etfufq+qfGfABjO/3o1q+1eFzyHwZNz7iqaXiPhEJTsEEAKHARAYO6xsiQO54F
	wX0igUwXHhRvnuXZTVLjR86stQHwY9DwPPacluOA3dDtzXJoPrwT67mdl6rk3u99V4egE+k362e
	t+YTJpUE39WatQt0ZfsaMqRuijQV4AMCdAIZwj46Dp5C2A1sHhyhMEM0i3TgeiVbdo0YaW1fDHG
	q9275tGVn6O7qYIwRrZVKXYqY5YyiD2qb54fSa0img==
X-Received: by 2002:a05:651c:507:b0:386:91a1:f207 with SMTP id
 38308e7fff4ca-3885056d42amr10235631fa.2.1771530252050; Thu, 19 Feb 2026
 11:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219192327.34732-1-okorniev@redhat.com> <c6be70378ce90b3316c997bfc9443172eaa145c5.camel@hammerspace.com>
In-Reply-To: <c6be70378ce90b3316c997bfc9443172eaa145c5.camel@hammerspace.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 19 Feb 2026 14:44:00 -0500
X-Gm-Features: AaiRm50ZxgQUuThLbVrkQDRO7oLtsZE4lO3vtfsLnhbAXsiZGFd66sfI8nqRPAg
Message-ID: <CAN-5tyFec2nw1=1-wsGYj4TnXmSbw4p+qW_1v9sPD+nPKiP1Gg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pnfs: improve "Server wrote zero bytes" error
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org" <anna@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19038-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[umich.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,hammerspace.com:email]
X-Rspamd-Queue-Id: 1FBAA162256
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 2:40=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> Hi Olga,
>
> On Thu, 2026-02-19 at 14:23 -0500, Olga Kornievskaia wrote:
> > When a pnfs error occurs, the IO is retried against the MDS. However,
> > the initial IO leads to the kernel logging "Serer wrote zero bytes"
> > when in fact the MDS IO will not fail and thus the error misleads
> > administrators that the system is experiencing issues.
> >
> > Instead, recognize that a re-try-against-MDS type of error has
> > occuried before printing the "Server wrote zero bytes" warning.
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfs/filelayout/filelayout.c | 1 +
> >  fs/nfs/write.c                 | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/filelayout/filelayout.c
> > b/fs/nfs/filelayout/filelayout.c
> > index 5c4551117c58..2cf405c370b4 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -323,6 +323,7 @@ static int filelayout_write_done_cb(struct
> > rpc_task *task,
> >
> >       switch (err) {
> >       case -NFS4ERR_RESET_TO_MDS:
> > +             hdr->pnfs_error =3D task->tk_status;
> >               filelayout_reset_write(hdr);
> >               return task->tk_status;
> >       case -EAGAIN:
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index 2d0e4a765aeb..8e8e3f8ef362 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -1558,7 +1558,7 @@ static void nfs_writeback_result(struct
> > rpc_task *task,
> >               nfs_inc_stats(hdr->inode, NFSIOS_SHORTWRITE);
> >
> >               /* Has the server at least made some progress? */
> > -             if (resp->count =3D=3D 0) {
> > +             if (resp->count =3D=3D 0 && !hdr->pnfs_error) {
> >                       if (time_before(complain, jiffies)) {
> >                               printk(KERN_WARNING
> >                                      "NFS: Server wrote zero
> > bytes, expected %u.\n",
>
> Hmm... Is this needed? Shouldn't the test for task->tk_status < 0 in

task_status is 0 when it gets to nfs_writeback_done because in
filelayout/filelayout.c in filelayout_reset_write() is doing this

task->tk_status =3D pnfs_write_done_resend_to_mds(hdr);

> nfs_pgio_result() ensure that we can't call nfs_writeback_result() in
> the above case?
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

