Return-Path: <linux-nfs+bounces-3399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC38CF9A0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 08:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274D21F21269
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBFD1CAA9;
	Mon, 27 May 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="VGntrcmx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E221C686
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793023; cv=none; b=VP231juAoz27mZJCWbi3eh9pNL30l+iPjBn7BpWRuQpDsxLb2LJV7rjjffU0xiWkDderQ+S4F9gaMkhkR3QHN9+HEMovEfQ/dREVDZdwrJu/BrCcVgzi0OyNUxMvh3WpcfuHK2pyQhwo8G4yRZvzASwAQ//HW0YDkggcBR1+owQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793023; c=relaxed/simple;
	bh=0qdsT1SiVVhdtrlVIN72WGxjOECihKeaVZq3QaoKHF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcE/vitBOAvTFNqgTHNDHMoghvX8UvOab0hR+FitxcBZxxsVxjm1ZoPTNxz/dniYnJK7SIsycqJW2a8gFGGu27zmLgGgPN+DlUEDupGjUMTpD3YXTiFE9JDrouJoGf9nbC+Q3GhbnhiQPmtrkyluQtjGPbBIoJDCtRWmlM/VWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=VGntrcmx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-578517c8b49so3275325a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 26 May 2024 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1716793020; x=1717397820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HfGzq1IZ9ig1OLmh0kVriw0ljpLO3lDDDWH1fMF0D0A=;
        b=VGntrcmx0vPMMC8E2Bh5rta0KAR5XRB9CfDazR9LJZOQ/TocsDBDkZZp7dXEch+evN
         Sp98S3L1ZgQsIINEvVIdV9zWmMnFBerR8ZuMG2Roh3oylismSs2LCKujSpLs4I2B9KZr
         oZY/balvad2AtId+jblHcB7MmnzQXYgV3Jm5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793020; x=1717397820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfGzq1IZ9ig1OLmh0kVriw0ljpLO3lDDDWH1fMF0D0A=;
        b=WU0PeBuFHqn/F+MCxXMNvjH+fJidocePEC8zC7/4mIuEPWgUkX6/cF1KA8+hBLfnoy
         XyKnKLjePg6U3190s0VVJAPZ06hwv6k7YtsiApZEQdFCo13Y7VvteT4cdtLNHQjbSYiA
         rXKYUtP82A8ZKftO8wiRQWLFZeTupI+eiNG9adxPb6hpyokoBzr55llm6fJFw5bbWLf1
         /m1p1GOaXKx/Pw1Fsp9fk0apTnthQQyrEl9boOdOwqsoglxkfn7MnuJVw5/fU29T4+VA
         SNxTTmVvOpNW7euM/cMIArWrGfDbgam+h1l6rATk08t5fOS+ZK002NJbJ9CIW+2w4NEX
         DRCQ==
X-Gm-Message-State: AOJu0YxwolYNde6/x/hf+t4aknZLcNkuQqs9Bx6nxuSzKgtzydTbMvEX
	omD9SK92ETnSiyaPu4klLhZGV6HjH2wBwxcdUxepXTm/ZXTREGLGl4WVt+Vr/TJ79VYLzYznN2M
	m7eE7WyYC5c2G42ZvBXp4e2aI8DFHizIwv4XZ
X-Google-Smtp-Source: AGHT+IEnYRiSoczNdt2OC3zsKoeCgJN4riPNOUs0wCSv+sdJJ220iRxFi6afV9oz/CycPnmR5aHoevDlphsxGp2FbNk=
X-Received: by 2002:a17:906:b0cf:b0:a59:bcfd:d950 with SMTP id
 a640c23a62f3a-a62645d650amr528923466b.46.1716793020292; Sun, 26 May 2024
 23:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526000122.386951-1-cel@kernel.org>
In-Reply-To: <20240526000122.386951-1-cel@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 27 May 2024 08:56:33 +0200
Message-ID: <CAK8fFZ63r=Dc1nNKt5p_oTutgMYLWCQ=F10W7k5ahPDpVRjPHg@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: use the struct net as the svc proc private
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, rankincj@gmail.com, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Igor Raits <igor@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> From: Josef Bacik <josef@toxicpanda.com>
>
> [ Upstream commit 418b9687dece5bd763c09b5c27a801a7e3387be9 ]
>
> nfsd is the only thing using this helper, and it doesn't use the private
> currently.  When we switch to per-network namespace stats we will need
> the struct net * in order to get to the nfsd_net.  Use the net as the
> proc private so we can utilize this when we make the switch over.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> I investigated the crash reported by Chris and Jaroslav. This patch
> is missing from v6.8.y.
>
>
> diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
> index 65fc1297c6df..383860cb1d5b 100644
> --- a/net/sunrpc/stats.c
> +++ b/net/sunrpc/stats.c
> @@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
>  struct proc_dir_entry *
>  svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
>  {
> -       return do_register(net, statp->program->pg_name, statp, proc_ops);
> +       return do_register(net, statp->program->pg_name, net, proc_ops);
>  }
>  EXPORT_SYMBOL_GPL(svc_proc_register);
>
> --
> 2.45.1
>

I applied a mentioned commit 418b9687dece5bd763c09b5c27a801a7e3387be9
as a patch for 6.8.y and the system did not get stuck by the "nfsstat"
command.

