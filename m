Return-Path: <linux-nfs+bounces-8653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEE9F69C2
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 16:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819BF189737A
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537951BEF60;
	Wed, 18 Dec 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQtXdWA/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0637189F2B
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534715; cv=none; b=AVZoudIno6H4YFWbY2z7Z2e607U4qFXOhKnJbsHLqAZoEngTYsAmEDsUwKMJVIGcIeuoBklvwk5cKmEMdpjIqgAM1YSRdvRqL0Wr0ZBDOtjMobQ1XL4tlyJY3pnNtMRQ5PIErnbxo5+YfJfGxhWwMo0zfnabhz+JB9qW8PKXbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534715; c=relaxed/simple;
	bh=R+try+RfmuI5idpwgCK59NxsfBbJVo2MvgXWGidK9aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAyuZD30peiTMT/SFMh4q452HcUlFj25EieCDDMnXeshkbPFPC/+M4LwtWgWaNEaS1D0ur7Z0EO8LeAMlnMUy4k1E2Ah1CYbLF0q7t7GeN2JRx/FDPc1qRo6tLhqS2x4xMt1VfPM5a/1/L4EvWVDiM7aHW7q6OYij7F2tTdPSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQtXdWA/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734534712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKNTmBt743FcaTDi2mwFJxCsPfiytiWrNSq57tYzXto=;
	b=UQtXdWA//4H5K6NgbkOTpqrdAuw+bKw1HSczzRwDlUhLDNt8kxzf+3h/zDm+T9T+QX7UEP
	z5RwE9Agy36UBnU9YDmf8Efk7lgUq37e44zSKZ8Ycm3wgw3mEUZEctIwAD79mudg8dGWSo
	i5KKKeZaLfLIp6LYB9XPPP0EZ/WgNvI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-BxnPGReFP6a7Bb6dLzALNg-1; Wed, 18 Dec 2024 10:11:51 -0500
X-MC-Unique: BxnPGReFP6a7Bb6dLzALNg-1
X-Mimecast-MFC-AGG-ID: BxnPGReFP6a7Bb6dLzALNg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a922so2275739a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 07:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534710; x=1735139510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKNTmBt743FcaTDi2mwFJxCsPfiytiWrNSq57tYzXto=;
        b=dgDEOTl6Ko0eKu9PsDeZTiXcBJ1jGIjoWBnw3eLWNXh9dezhJdxXf//t8ABhRACZ//
         AT6TIvxiCVm1VqBpQRT1mNdPHKy9VVeDs9fZdlbGAGZRAdHbWsI3FGJm1GM35keP/y9u
         s73hyPDhnz4eEZbmU/sKkRiZyQZTnN3Ojav1E7UlE6CijVANVh9WXsH+HnMl858T8WUd
         Mw3I0zaDlXGiPAbWXxvvq7QSJeSHu4JrMPPNikjKtpLc4RCgVXR2uIxOfl2Xh38Mj8Vx
         BNTT2kQoN9RqxsR16xLkCeq9DE/KIYeoZsh5sQ0MbxN3Gwc8+kY6kBF2M2wNyu9wVr8f
         d6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZrOOX1AGA0oRZ/oguRaaG4JLcwo4Tj2u3hIZgcMoZAcJ5LuaLoaw1m5hDC30PMtcDiQvE6d6/4zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQm5fbu4MUySYQJsYSY/s+1iMUhPdtbi051i77HKYhUlj7Bpkn
	vTSkA92AMO3mXj791L3tsk2PdPqmhL7k91SuNAMeuD7yaVPqZKev2FUOKRcofvlO+0EkhssIFDX
	u7zoGiaywjnTRrY4wqV+mYVTZyWzFHc2X++xgcMJzQCLIJds/WMj7QaGByE+Uz096y6DIjkqzvP
	vH7A6spx3Mr7YOTILG1l57DN3ZQK3BmvMk
X-Gm-Gg: ASbGncv1CXoQHM3OGiEVN5xZIiIA/xbT5EEQC+GB2imto1HbY8sRqU3DvGYrYMiYI5O
	lIIKrNPWs6xduK8fLqHHGJ6fdyIk72nxHfqLw+2Jrtut97/Cz6ymtm1+23MubVLMv4LYxoTg=
X-Received: by 2002:a05:6402:4498:b0:5d3:ba42:e9f4 with SMTP id 4fb4d7f45d1cf-5d7ee3ff1e3mr2854045a12.23.1734534710161;
        Wed, 18 Dec 2024 07:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvGsg1NUO6l9abXMUwq6bTbKqd7zjlTgzbxTgfGPITaLOLaXQ8Fo7FTknMiGuyKGqO9/srPflmhW8YzdheD2Q=
X-Received: by 2002:a05:6402:4498:b0:5d3:ba42:e9f4 with SMTP id
 4fb4d7f45d1cf-5d7ee3ff1e3mr2854016a12.23.1734534709799; Wed, 18 Dec 2024
 07:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173449067508.1734440.12408545842217309424@noble.neil.brown.name>
In-Reply-To: <173449067508.1734440.12408545842217309424@noble.neil.brown.name>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Wed, 18 Dec 2024 10:11:39 -0500
Message-ID: <CACSpFtA20yrYg6uoUXKQuYOpwpn5NOa_kgLRABWJCgN5y19-Fg@mail.gmail.com>
Subject: Re: does nfsd reset the callback client too hastily?
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Dai Ngo <Dai.Ngo@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 9:58=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
>
> Hi,
>  I've been pondering the messages
>
>  receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt XXXXXX=
X xid XXXXXX

I wonder why are you seeing this? There was this commit 05a4b58301c3
"SUNRPC: remove printk when back channel request not found" from a
year ago....

> that turn up occasionally.  Google reports a variety of hits and I've
> seen them in a logs from a customer though I don't think they were
> directly related to the customer's problem.
>
> These messages suggest a callback reply from the client which the server
> was not expecting.  I think the most likely cause that the server called
>   rpc_shutdown_client(clp->cl_cb_client);
> while there were outstanding callbacks.
> This causes rpc_killall_tasks() to be called so that the tasks stop
> waiting for a reply and are discarded.
>
> The rpc_shutdown_client() call can come from nfsd4_process_cb_update()
> which gets runs whenever nfsd4_probe_callback() is called.  This happens
> in quite a few places including when a new connection is bound to a
> session.
>
> So if a new connection is bound, the current callback channel is aborted
> even though it is working perfectly well.  That is particularly
> problematic as callback request are not currently retransmitted.
>
> So I'm wondering if nfsd4_process_cb_update() should only shutdown the
> current cb client if there is evidence that it isn't work.
>
> I'm not certain how best to do that.  One option might be to do a search
> similar to that in __nfsd4_find_backchannel() and see if the current
> session and xprt are still valid.  There might be a better way.
>
> Thoughts?
>
> Thanks,
> NeilBrown
>


