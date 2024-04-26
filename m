Return-Path: <linux-nfs+bounces-3038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E38B3828
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8290FB20D83
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5C146A90;
	Fri, 26 Apr 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FinMnR3r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D3145B21
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137411; cv=none; b=YD3s7f/YptZ77LXA6rk6jahxbN719p3Lfc9auGO91egmCqG52DIcs3dyqZ0avyZ1mrqBiU412P1F68KhW2gVpb6Aj+poLAm9A8roqyLXdIZeDUBBaVhxBo9dDOE89hf2nS9CgKzjk3N1QQwNz+pPYjG3aM1DS5JtppTSQTRjfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137411; c=relaxed/simple;
	bh=+d4jEX6nAxK9SvpY2RMD67vh6hoaUz7du+03lh8VLZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/gPIWaqKDyZ9aYtcVbhrbh2Pz6rH5++Ql5XCRIeNZ2ITkpil//dASIX/1RqCV52BtcRQJBsgRa7gVXUOr5F/1lZv2WSkaCAIwqnpEQdiwIhdHmx/XtoNNuZo5CkpAIcTT0PZU7dA2kBg3Od8uAG7ZMkx2lD9J2E0Fsp1BsXUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FinMnR3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C12C32781
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714137411;
	bh=+d4jEX6nAxK9SvpY2RMD67vh6hoaUz7du+03lh8VLZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FinMnR3rKZkb7McogFZRDKtLUWkcDU8f+lQ7lzVLio1rlK05v4V1jqgaTZI93tFVq
	 HcxcGs8lYJB21uoV48d8BBugqqhMr272AYV+t+SJ7OUij1rKXSL8FrzVVGbybaAokk
	 ZhXZ7ssvsN49ISvdTaieFxYSD1cVvPhotkGcDjCz8973Ik0ldtAjviacIWEByz6EnV
	 ZbuGdi6laddZj6PR5871RoUndQEFDgW/lhFi7AmARF3Gt09GjLl5oge9euHiggAtmo
	 QDD12JHvgg7D2d3BmVxu4wXYfBCURUJcZVWorl9FByTeArNuLDyjb0LIGRb8cC+yjc
	 dB2wICXwHjK/g==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434c3d21450so10322871cf.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 06:16:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnapBt5AxxGFMNB9YT6WQW1W/oDq1N90BdreOY83ldfBfmGcQJ60f/4wBuDhFfU2WusFok3xxxS4ys8K2n1H8Rk8voIoQLYhK0
X-Gm-Message-State: AOJu0YxjWRv5oN0YdISuP3IaQr0oVemEu12RFfF8ovPEc4Pv3JfDwgQu
	0YL6ynuOpnRk8D2oi5IkCuU+NoAk95MlcBGUJerwBiLDoC4SLXfJjG4S4U15ayhdxyuamaF7gwY
	dkZLeaZso2dHLYUaE3VBpZXjY4w0=
X-Google-Smtp-Source: AGHT+IExdcd7fl7EQ6IqAPVD9ATWZiF2QJb8Xsla0VTcRj0FPu4JKOmwT1YbVzoxUPvaFVK82GIuPSgt1ra7SKcY3YY=
X-Received: by 2002:ac8:5a91:0:b0:43a:904d:8176 with SMTP id
 c17-20020ac85a91000000b0043a904d8176mr226536qtc.0.1714137410306; Fri, 26 Apr
 2024 06:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424104112.1053-1-chenhx.fnst@fujitsu.com> <76BBD76E-9CDC-4B97-81E0-72839DF63498@redhat.com>
In-Reply-To: <76BBD76E-9CDC-4B97-81E0-72839DF63498@redhat.com>
From: Anna Schumaker <anna@kernel.org>
Date: Fri, 26 Apr 2024 09:16:34 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkGsUQS9PEkzmMDiv0jrq0Xt1RqpfzJ1tpnBi2TKEZn7g@mail.gmail.com>
Message-ID: <CAFX2JfkGsUQS9PEkzmMDiv0jrq0Xt1RqpfzJ1tpnBi2TKEZn7g@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: rpc_show_tasks: add an empty list check
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:07=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 24 Apr 2024, at 6:41, Chen Hanxiao wrote:
>
> > add an empty list check, so we can get rid of some useless
> > list iterate or spin locks.
> >
> > Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> > ---
> >  net/sunrpc/clnt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 28f3749f6dc6..749317587bb3 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -3345,8 +3345,13 @@ void rpc_show_tasks(struct net *net)
> >       int header =3D 0;
> >       struct sunrpc_net *sn =3D net_generic(net, sunrpc_net_id);
> >
> > +     if (list_empty(&sn->all_clients))
> > +             return;
> > +
> >       spin_lock(&sn->rpc_client_lock);
> >       list_for_each_entry(clnt, &sn->all_clients, cl_clients) {
> > +             if (list_empty(&clnt->cl_tasks))
> > +                     continue;
> >               spin_lock(&clnt->cl_lock);
> >               list_for_each_entry(task, &clnt->cl_tasks, tk_task) {
> >                       if (!header) {
> > --
> > 2.39.1
>
>
> Why optimize this?  Can you show the locks are contended?  Its probably
> fine, but using list_empty outside of the lock has a bad smell to me.

I looked into list_empty(), and it's using READ_ONCE() internally so
it should be okay to use outside of the lock. Having said that, this
function is only used by sunrpc/sysctl.c, so it's not a path I would
think needs to be heavily optimized.

Anna

>
> Ben
>

