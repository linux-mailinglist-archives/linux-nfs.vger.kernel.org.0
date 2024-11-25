Return-Path: <linux-nfs+bounces-8214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654059D8B54
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C72816FF
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFA18C322;
	Mon, 25 Nov 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H52zhZ4q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70714D43D;
	Mon, 25 Nov 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555952; cv=none; b=VlNA3b944T+L1QwIjlJUE3VuFZ8xL2Q0r1XYtFD9fhL3Ln0Y/2cs7ordNckFTqeO6gDl+0xbZvIDYNodol2AbIFZHU9FhEnDzGzzNuKD/SPSOXAAtgb8U1jRn5FOqjPythdbceMoF/39sixYg7uEGLM/wAfNBDBMkPrJqK4Laaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555952; c=relaxed/simple;
	bh=533O6ns9KT6+m26kcisDRO8AtxQ937NG6RCCuYdsiVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oaYs/OIAwm2pmk5KwS3y5WYyWT6asXK52habE9Ed5OMdf0HS4pnKVxLBIR6sPmllKnPAlkioz0YSz/wHuMRRegxVmN/IgYsTYcPRdVV1CObW6usrEJTaWXbHZUpzVQS5i5lPuThGb4YluTyuoA+MvAHiBfapTakXGaGNCnINS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H52zhZ4q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so3007129b3a.2;
        Mon, 25 Nov 2024 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732555950; x=1733160750; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S037ld6ZL9afLpj/61zbahHnRd5s/qC93kigSsGcnvk=;
        b=H52zhZ4qFPqKbH64uQls8EbuXjBmrI1SR7Ii3bscYz4OKfdcrxj5ytlwU2jBQQTc4R
         bviYweclwUPZ/cIMn0G3eluF0Q/ExtLLybzZ3hdl1+g8P2SiSVqFYyHBebqdKiaycUrN
         TktPpJinb5eeiwpzmZiBLhxeu1lMyrrcC8TSa+79/BcrVyJ3JFSVnIx/LC8x/HDy7aOL
         3dJ5ghp4hJTCsbaYLEBLPix8cwsyfN/5s6kpIFmt3TC+IU0u9fVzOZrv8YCOL/uXjQ4a
         FLP+UqSH/YEVs7BnjJ5mwjWL0/vgCbqtbU3mxgjrSSdTqilsJzJWPTVJnlaoRtXCxg/g
         xXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555950; x=1733160750;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S037ld6ZL9afLpj/61zbahHnRd5s/qC93kigSsGcnvk=;
        b=HO0cmtVskt6FV7OJ7KtXjv6k24XV2MEpNhhVw1jGO9Fpr8zgv+cx+JoFWRiP3YyC74
         +ykujQc5+mOj7Xl5srQKiTaPGxB7HBybMcRJsIHu1MkydbwjlGXrsX7z9dbxQPUCwil0
         y5BG8rRs54ly/YvTWN1n/282RyCBZ8KGKJDtTg8m0geoO+np0RegacLgp8wcrmMEHIJq
         sWCp6DcmmKLXhxrF+YLg+iDL2N/rVjJ4kzch8RgI6+Nsgc+XfLUAo3jkEC/QigPhokuR
         M1xj5nIHfWClhoVQ8ThlbMdhqjtqcgn+9Dk+7MC+zA8nbhvaFpe2XmnKb7Wgjebdzoc6
         KV7w==
X-Forwarded-Encrypted: i=1; AJvYcCVn7fgY1YzN60HJrLUqw5a4TtxRMPQzzucmzbWGWLGKIvsqV2cnoqlLikXxv6o8KqhQep2CGJ921NR6aU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8D1Tj1MHa/VzApC9jDQc+Dj6o2ttzvIGMEG8Qm/Sc4uVZZo8
	M6fJ3CBx0wh80kW8jRvpGZSXhYoSa9cDGXPrnxhw0LxQuI1KbT839e4/kzgQhsva5DnoQVyHeLG
	n6n/E0LdQsT+qHuCYbX/vamj6SHiFLg==
X-Gm-Gg: ASbGnctHu7fHowFcpN3nzjvMWeFwqIHo9tTYwIr11VvR6RBsTSjki9qVnfPGmDu41Hw
	S22bFb6CrSIee8LfrV3UXX+s0YADPLZs=
X-Google-Smtp-Source: AGHT+IHxAodAs7gPCvqHIwOgOycxtggq7W5FbnP/w0S93qjOoZRokO5goyg0PfuwFjlSwnck/eYFCrf9aNbqK8Oi7jQ=
X-Received: by 2002:a05:6a00:92a2:b0:720:6c6c:52a9 with SMTP id
 d2e1a72fcca58-724df660052mr19656883b3a.18.1732555948220; Mon, 25 Nov 2024
 09:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
In-Reply-To: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Mon, 25 Nov 2024 18:32:00 +0100
Message-ID: <CAN0SSYwzsVEvopiuJuQTbJkOeGhDtLLFMsetVM2m5zOa0JEwDA@mail.gmail.com>
Subject: Re: [bug report] deploying both NFS client and server on the same
 machine triggle hungtask
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 1:48=E2=80=AFPM Li Lingfeng <lilingfeng3@huawei.com=
> wrote:
>
> Hi, we have found a hungtask issue recently.
>
> Commit 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low
> memory condition") adds a shrinker to NFSD, which causes NFSD to try to
> obtain shrinker_rwsem when starting and stopping services.
>
> Deploying both NFS client and server on the same machine may lead to the
> following issue, since they will share the global shrinker_rwsem.
>
>      nfsd                            nfs
>                              drop_cache // hold shrinker_rwsem
>                              write back, wait for rpc_task to exit
> // stop nfsd threads
> svc_set_num_threads
> // clean up xprts
> svc_xprt_destroy_all
>                              rpc_check_timeout
>                               rpc_check_connected
>                               // wait for the connection to be disconnect=
ed
> unregister_shrinker
> // wait for shrinker_rwsem
>
> Normally, the client's rpc_task will exit after the server's nfsd thread
> has processed the request.
> When all the server's nfsd threads exit, the client=E2=80=99s rpc_task is=
 expected
> to detect the network connection being disconnected and exit.
> However, although the server has executed svc_xprt_destroy_all before
> waiting for shrinker_rwsem, the network connection is not actually
> disconnected. Instead, the operation to close the socket is simply added
> to the task_works queue.
>
> svc_xprt_destroy_all
>   ...
>   svc_sock_free
>    sockfd_put
>     fput_many
>      init_task_work // ____fput
>      task_work_add // add to task->task_works
>
> The actual disconnection of the network connection will only occur after
> the current process finishes.
> do_exit
>   exit_task_work
>    task_work_run
>    ...
>     ____fput // close sock
>
> Although it is not a common practice to deploy NFS client and server on
> the same machine, I think this issue still needs to be addressed,
> otherwise it will cause all processes trying to acquire the shrinker_rwse=
m
> to hang.

I disagree with that comment. Most small companies have NFS client and
NFS server on the same machine, the client being used to allow logins
by users, or to support schroot or containers.

Mark
--=20
IT Infrastructure Consultant
Windows, Linux

