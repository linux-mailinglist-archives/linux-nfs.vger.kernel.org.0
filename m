Return-Path: <linux-nfs+bounces-3401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E28CFE53
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 12:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B8EB21338
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66D13A414;
	Mon, 27 May 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCePCHVy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B56BB26
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806797; cv=none; b=ssv0aMECkF68nvA0U+m9zdSW+BTB2LWCECc4C28bdD/F8NdCaYnJFAJ95QZUWAojctrqYBm/bC3eFbrRhl1oAxsIhRqzrOUPwDr7aI0/mz3+ozMkK0d5GASplHrZ9DXFD1Z9znfDkarWL4qpXOBtthTBrqtEtF4KWiXdt4EvL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806797; c=relaxed/simple;
	bh=bAGluZtXN1UqO/B9jhkw+i0dytW2FCVHQey8RRP6FhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQhipsppN1XNAyYiYG84D1OO+G0sGOOBuYTLkz+DqaMNSbq2y5BeGoEUw6fOgoB7tMneKc7zVKVlakHhcA0IkgZIya7OjRQEvxaCuyenykr0XGAo+VDvuzzojHOrDnHyZ7EOsV2v4OXf1KuE9s5KugHTT/x1I1hWAnbpMKgdEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCePCHVy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7948b7e4e5dso497511385a.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716806795; x=1717411595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1RV7ej7Q9vd5FZAT7lmmBzRY/e1cPUGRAkFSyaKIB04=;
        b=RCePCHVyfekqIkZwIf2hpS2KAScsCpmU/Eh+qUSzDD41NgM9rSqQLE2pU41QroiBzr
         1HrQJrERcAIb74290ZZPbDMcUOkgRep1ULhSHbVdhKoj6H82y3pRYjBnTlVrVShu8jOV
         8EXh2NfO/6NsczdZF10i0I0eTU1Y6iOgtE6l9iLlvaBCsGTKZ0kdEY/nKnfIa8iU0tAe
         AhJ2BwomhnvXPToq9kDk8lpWkd2rCSegg3cfpaKN5ULHO8tAWrrskzuffwhUMJkIJYtY
         vjidIJ77hst5rgsl8VkmriB5rYHoiLXoR0CV9Q5DeObENxkMVi/nrj2lQLBO/1PEl1CI
         R4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716806795; x=1717411595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RV7ej7Q9vd5FZAT7lmmBzRY/e1cPUGRAkFSyaKIB04=;
        b=hsdQMBGhCEM3Ms3w7qFHWcmRZ7axyBEi3U4I4HUywRDSg6FNXiyItT1hq8HxvkZ3Fd
         HTKVaE9P1EnGs5FfI8CyDwuarfGDDAzHOK8aBXST1aSKbyXOCAUss9cT/hn0aidHDDbI
         QJ3KeG1j6B23tqoepCGBM/LucvnFXmaGjm42vY3PTmw1QfBi9rieP/q06ZJZ/n1LHUvF
         32wjHGbhCBgeMg3s3N9GXHseTCaOA95t/JxtO07xzn3+1Q8E1jdqX+J1wa5GwmHA8MBn
         3bDTB6yqb0W+X+9O6qU3MMogANWLFBFnJnCPJY9UuqCVuEnlSdRMfZ4y6KDGhvTu05pG
         FaGA==
X-Forwarded-Encrypted: i=1; AJvYcCUGiannYdtWNnTxsOMLug9e0LrYQdJ4bsER1V9pzqSqZ99eHSgptZ3SxI7+cdra2A5Jm0RO12GCF4m3O7VpeRwVVoGUnzzFu7CE
X-Gm-Message-State: AOJu0YyPaBDGr79Urg+eWZvPA2MGzBG1a2JJKQSmNbU381/swhPRYw0O
	H/MJDU3jWqB9K3rVUqpa6gTSsleLJ7oCqJdiR2kKoHWjmen1tFtASKTGP7or/RGCAO0tqN6/u6w
	LoEHjBpebodPhdZaj+xtIVzhbpg/HhSay
X-Google-Smtp-Source: AGHT+IEJEUpp+9uJvc4z/iENS9d5gJtCe/8WDplNW73B/XvDf1jES+/d6mnjJCxET6zucKnJUGoAJ4Uved2YtisA7UM=
X-Received: by 2002:a05:6214:3a8c:b0:6ad:7cb7:e599 with SMTP id
 6a1803df08f44-6ad7cb7e9f8mr33943806d6.54.1716806794644; Mon, 27 May 2024
 03:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526000122.386951-1-cel@kernel.org> <CAK8fFZ63r=Dc1nNKt5p_oTutgMYLWCQ=F10W7k5ahPDpVRjPHg@mail.gmail.com>
In-Reply-To: <CAK8fFZ63r=Dc1nNKt5p_oTutgMYLWCQ=F10W7k5ahPDpVRjPHg@mail.gmail.com>
From: Chris Rankin <rankincj@gmail.com>
Date: Mon, 27 May 2024 11:46:23 +0100
Message-ID: <CAK2bqV+WKFfXx8Au3iOt7CE2S6Om83haLUmkyuMKAm=KM+k2RA@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: use the struct net as the svc proc private
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Igor Raits <igor@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This patch also fixes the periodic oops from my kernel. (I suspect
Fedora 40 is invoking nfsstat or similar in the background every 5
minutes.)

Thanks,
Chris

On Mon, 27 May 2024 at 07:57, Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> wrote:
>
> >
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > [ Upstream commit 418b9687dece5bd763c09b5c27a801a7e3387be9 ]
> >
> > nfsd is the only thing using this helper, and it doesn't use the private
> > currently.  When we switch to per-network namespace stats we will need
> > the struct net * in order to get to the nfsd_net.  Use the net as the
> > proc private so we can utilize this when we make the switch over.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/stats.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > I investigated the crash reported by Chris and Jaroslav. This patch
> > is missing from v6.8.y.
> >
> >
> > diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
> > index 65fc1297c6df..383860cb1d5b 100644
> > --- a/net/sunrpc/stats.c
> > +++ b/net/sunrpc/stats.c
> > @@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
> >  struct proc_dir_entry *
> >  svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
> >  {
> > -       return do_register(net, statp->program->pg_name, statp, proc_ops);
> > +       return do_register(net, statp->program->pg_name, net, proc_ops);
> >  }
> >  EXPORT_SYMBOL_GPL(svc_proc_register);
> >
> > --
> > 2.45.1
> >
>
> I applied a mentioned commit 418b9687dece5bd763c09b5c27a801a7e3387be9
> as a patch for 6.8.y and the system did not get stuck by the "nfsstat"
> command.

