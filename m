Return-Path: <linux-nfs+bounces-2180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30125870B80
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 21:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8A41F2174A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 20:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4267AE66;
	Mon,  4 Mar 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="c4F68e+s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0174AEF9
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583921; cv=none; b=d/hlLI29+9DPXnQpLZ0uA5QFuwLGgDuHOLf24JnZadX0Fn/bWjXkqKNrB/wdhL5Cxq405GHfR0hdrmkvxy19MBsDYSlAEbOjcBb85phjpOCxB3EtWWFmOfqTXq5jf8DOC7r1t29xJP8pn9RUAG08TrAXLNT7ZNYnVyIqUZrdpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583921; c=relaxed/simple;
	bh=xIHBbJ9++nBo7r+L0EXme2880qQwylMI8q7N0X40RqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVg74T5W0wfRdMbrgxs0yyRGD69ZZmbTWGRgPbnz0RdNDZkp+QsmT7m8lXHzZmGVhQKHibOcppxd+a/r+jZo1FB99vGalZHI+ctm4C9EbVDQSxenUurGfwM9xCGNX9lGPo0E0jfpUo06P7rM/g5novGrnESK9PxdS8+pp52g2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=c4F68e+s; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2579378c4so4355651fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 12:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1709583917; x=1710188717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIHBbJ9++nBo7r+L0EXme2880qQwylMI8q7N0X40RqU=;
        b=c4F68e+s++r+3d68F2GmBF9fux2b5mErRbgOYrbYVJycThrA8YCxq1czcLBhPyKqR6
         KjmbXrhaoQyLo6TA9Ko73OnLgOJTjnltTsHVJqnFe2zdcsuW9C71dDtE5BNh7tYHo2Vd
         lRhsKLwTLGf4v4sgAZuVZwX68MPMC/m0hdFqPenvEW83XRF8q6sfM0FV2JEYg4scoZe6
         0+mm7urrTzard1BQKLTkxr1VfeN8MbaVMrnwz0djhFG0u5vvF+7Qjpk60IYAq0VaewOw
         EyKNohxtKYXJcpWHcj7fvIgjiMR5vYqIMZ3WPqIa6OpL8vyv78wWkKzH6qo36i2LMlIM
         Q3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583917; x=1710188717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIHBbJ9++nBo7r+L0EXme2880qQwylMI8q7N0X40RqU=;
        b=e1t19ZZoP2S2l8ZYTyVkxq6lyzwlw2ri1a+Wszx6QFtHWryw0t2aOFrVqIFg2Cb8Rp
         Gm/uwVkbJgU1FUqYvgFppRRMuX6dOQDOh+MKn1oTI2IUnkIhguJd3Gy8JByBbnt90eNG
         Lwp4qti73uy0czByyvMRzMDuybTT/OpuODhFdG8Kvrwd1SHQoOjLvK/rvkBc601VSeJn
         jum30ObJAp2sxdwKLAtwMQE5fvIh4je/wT6YrdbbVw933zOBOBOj4mLTIH7kS3aNhCtx
         9lXSDB34Id8fllctS2vZM09G58y8IF/XFkUT+namYvzRXoqPIcXNwhzZTSkdjDEwy1xV
         SYyA==
X-Forwarded-Encrypted: i=1; AJvYcCWgOwQM6kC4BmoxGE15Pz8rqR+UlYPyWJtinrdoJqUSp6CKndxyrCtjtih6YZW4miTOk1jsIKcyywRbpgagLprTqpjBcWFgSHSh
X-Gm-Message-State: AOJu0Yykr42jmwrGfpd3NFitkBVtv+TBddgbqYc7n8Nd9zA3RKZ9yist
	gd7pgczPwL8rl+k5Ml5XYkvHUSdOWN2sKwQlVaDn4bgs2HOSE6gFgiAc6RaaplsOg8zrBhuomdb
	zVV+/nA/Fus63JgBHldt7zyYtuEaM9PMu
X-Google-Smtp-Source: AGHT+IFh2j9++bCbkHdSE8kl/2ZDxD4Vqeh7FMDcuwsFSrf7AU4IXRfhGyDlERzL4ahV/GdbXFyUyMfAlWUFgVgvUDY=
X-Received: by 2002:a2e:819a:0:b0:2d2:a4e6:a5b0 with SMTP id
 e26-20020a2e819a000000b002d2a4e6a5b0mr67859ljg.4.1709583917222; Mon, 04 Mar
 2024 12:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228213523.35819-1-trondmy@kernel.org> <ZeTC2h59TXUTuCh_@manet.1015granger.net>
 <CAN-5tyH2dkLbt9dMau46ebrU=PfvLgo2=mr8u3_C1gUnAGM_ow@mail.gmail.com> <51189037-DD10-4806-8596-D4374067FDFB@oracle.com>
In-Reply-To: <51189037-DD10-4806-8596-D4374067FDFB@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 4 Mar 2024 15:25:05 -0500
Message-ID: <CAN-5tyE_27_AUo-ZWuSStyr3kkku_YutBH6FjMsHyuqezBGuEg@mail.gmail.com>
Subject: Re: [PATCH] NFS: enable nconnect for RDMA
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:33=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Mar 4, 2024, at 2:01=E2=80=AFPM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
> >
> > On Sun, Mar 3, 2024 at 1:35=E2=80=AFPM Chuck Lever <chuck.lever@oracle.=
com> wrote:
> >>
> >> On Wed, Feb 28, 2024 at 04:35:23PM -0500, trondmy@kernel.org wrote:
> >>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>
> >>> It appears that in certain cases, RDMA capable transports can benefit
> >>> from the ability to establish multiple connections to increase their
> >>> throughput. This patch therefore enables the use of the "nconnect" mo=
unt
> >>> option for those use cases.
> >>>
> >>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>
> >> No objection to this patch.
> >>
> >> You don't mention here if you have root-caused the throughput issue.
> >> One thing I've noticed is that contention for the transport's
> >> queue_lock is holding back the RPC/RDMA Receive completion handler,
> >> which is single-threaded per transport.
> >
> > Curious: how does a queue_lock per transport is a problem for
> > nconnect? nconnect would create its own transport, would it now and so
> > it would have its own queue_lock (per nconnect).
>
> I did not mean to imply that queue_lock contention is a
> problem for nconnect or would increase when there are
> multiple transports.

Got it. I wanted to make sure I didn't misunderstand something.You are
stating that even for a single transport there could be improvements
made to make sending and receiving more independent of each other.


> But there is definitely lock contention between the send and
> receive code paths, and that could be one source of the relief
> that Trond saw by adding more transports. IMO that contention
> should be addressed at some point.
>
> I'm not asking for a change to the proposed patch. But I am
> suggesting some possible future work.
>
>
> >> A way to mitigate this would be to replace the recv_queue
> >> R-B tree with a data structure that can perform a lookup while
> >> holding only the RCU read lock. I have experimented with using an
> >> xarray for the recv_queue, and saw improvement.
> >>
> >> The workload on that data structure is different for TCP versus
> >> RDMA, though: on RDMA, the number of RPCs in flight is significantly
> >> smaller. For tens of thousands of RPCs in flight, an xarray might
> >> not scale well. The newer Maple tree or rose bush hash, or maybe a
> >> more classic data structure like rhashtable, might handle this
> >> workload better.
> >>
> >> It's also worth considering deleting each RPC from the recv_queue
> >> in a less performance-sensitive context, for example, xprt_release,
> >> rather than in xprt_complete_rqst.
>
>
> --
> Chuck Lever
>
>

