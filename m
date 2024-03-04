Return-Path: <linux-nfs+bounces-2178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52624870A06
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE26C1F22357
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6F78B50;
	Mon,  4 Mar 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ip52+2Rv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEA48CC7
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578941; cv=none; b=IJlcHcheOUU65CC95ZXRwrmYMCbh8HWDdSMAnWG1JRZaTGR+pOYqJ1qWbhanahpwL/wpAGBhYJqkDhvx77Y/WNO+eN+eKL45ALwIkMpMfcQSFdxFZBD7ZjBI1NdW6vNQokoGqezUOslku/SnNA3xYiV76xHuOLDkFZr4cyJ9wwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578941; c=relaxed/simple;
	bh=WlM3FoAqQxTqSOUEaXRRHmg2miEHXKIAKE3U/wd+rd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMG7QtjPfRQURu7DUigvRBVXEOFdj8TrPHD3vBUGrYlDczI+bzLp5ryGU/tkRAZig6PzR0S4gfnj3r0aJnTyRUPQFFVicj17tP/I1o8CPdfiut7Er0bJZsFvVDvgBFY8lFdMd/Aq81bL34BU6FsZg7vp0Xdxyr3L312Zse44BGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ip52+2Rv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4566964aadso24175266b.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1709578938; x=1710183738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9msy1KlBqNo7jQQ8jj1J69f6oAqOb+IJFtdA0QRUY7o=;
        b=ip52+2Rv0Ozp7wOK83VtW5qyu3aMogbXUsoRVISKvSpXjESwrHsCQhCMVYMDDhj11w
         mJhqVpY1lbfK9wv8TTto1tbssKJ4jFq+e/DjtHEzBpOTC/Cv15q2Bke1AbmrEUywkflh
         fxigMouk+1LXPbjsQ5YlrDpdzFmzXKopue6gdb+csBqeD776BWGccoeVlwwYdOaTsVVp
         tKyU3k2en7FL/pgVCw95zpXeOt4voXporcDTx9mjxmpUhjrGpUL9uJOyzOXFuNryYA6k
         ErBm5eQrfOFWFHUROrf5/p4z+3mxBkmvG6zflgyf8D0DlGe7ErNJjoq2YhpSAU5a0U8e
         lEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578938; x=1710183738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9msy1KlBqNo7jQQ8jj1J69f6oAqOb+IJFtdA0QRUY7o=;
        b=WT2p/7lWUGiF3cAbTxpqRIPjS+nCfRXI1LH8pIU35duYMLqovL5+goihQDEtu1UX5b
         yWNPwwNLJ6M9+k9s5Uq5Cj9ac/dSXQRruQqJTNwMW5DqCT2Wjs7DGZjFp4I1TfFB7rkh
         DzUZVY9Q3aIOQMXu8O71YaX9FF/xi1fK0M6reaXBX7UjZptLfkMSbFtJ1z/pmRiYtbmm
         fl4LuKwL0kz8gnazwmEcwl1grmXwXZ97GzVIH9CG/dtdqDUdVqBOhHNz7JGRe8ZHVDMa
         KcjbtduzdMUU6/RPF3pcpoinXkAO3Ak9o2UtPIVFSYYZjWD3HOWeN5n2vQhvWQnFNEof
         pSkw==
X-Forwarded-Encrypted: i=1; AJvYcCXyss/RhtWg7QJgsO+U3mk2NeOuxFrBV0m/2aLS292vSxV+0jSZa6QdFiGY9WzF3xzfXKmg2qNgF0gRwRLlWz1Tney6lVTrYuvf
X-Gm-Message-State: AOJu0Yw3rEwxgERdekoxUd59lOJCITlnr7MIF4ONcyZEEF0j5ljwWkhd
	FcIbQG/JH8rKu+4SrJ2smBlWpZWAnNPo82xMRdfIRdL3oIazSosEHEdaW/wjKA2ZyiRR1ZrIi5B
	U+c7QC3v8Wy/L1hy8SRwTLrw1HD8TcuBE
X-Google-Smtp-Source: AGHT+IGylkS2JumOlqXLBaiRUFj0hGj9S4Z33HyJ2U7n0wyEA0R6qGjD23Gb6r3ICwOw37Yo6s4hRqOr6VJRMtlABOI=
X-Received: by 2002:a2e:b0ca:0:b0:2d3:2242:e7df with SMTP id
 g10-20020a2eb0ca000000b002d32242e7dfmr6383288ljl.0.1709578917538; Mon, 04 Mar
 2024 11:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228213523.35819-1-trondmy@kernel.org> <ZeTC2h59TXUTuCh_@manet.1015granger.net>
In-Reply-To: <ZeTC2h59TXUTuCh_@manet.1015granger.net>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 4 Mar 2024 14:01:45 -0500
Message-ID: <CAN-5tyH2dkLbt9dMau46ebrU=PfvLgo2=mr8u3_C1gUnAGM_ow@mail.gmail.com>
Subject: Re: [PATCH] NFS: enable nconnect for RDMA
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 1:35=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Wed, Feb 28, 2024 at 04:35:23PM -0500, trondmy@kernel.org wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > It appears that in certain cases, RDMA capable transports can benefit
> > from the ability to establish multiple connections to increase their
> > throughput. This patch therefore enables the use of the "nconnect" moun=
t
> > option for those use cases.
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> No objection to this patch.
>
> You don't mention here if you have root-caused the throughput issue.
> One thing I've noticed is that contention for the transport's
> queue_lock is holding back the RPC/RDMA Receive completion handler,
> which is single-threaded per transport.

Curious: how does a queue_lock per transport is a problem for
nconnect? nconnect would create its own transport, would it now and so
it would have its own queue_lock (per nconnect).

> A way to mitigate this would be to replace the recv_queue
> R-B tree with a data structure that can perform a lookup while
> holding only the RCU read lock. I have experimented with using an
> xarray for the recv_queue, and saw improvement.
>
> The workload on that data structure is different for TCP versus
> RDMA, though: on RDMA, the number of RPCs in flight is significantly
> smaller. For tens of thousands of RPCs in flight, an xarray might
> not scale well. The newer Maple tree or rose bush hash, or maybe a
> more classic data structure like rhashtable, might handle this
> workload better.
>
> It's also worth considering deleting each RPC from the recv_queue
> in a less performance-sensitive context, for example, xprt_release,
> rather than in xprt_complete_rqst.
>
>
> > ---
> >  fs/nfs/nfs3client.c | 1 +
> >  fs/nfs/nfs4client.c | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
> > index 674c012868b1..b0c8a39c2bbd 100644
> > --- a/fs/nfs/nfs3client.c
> > +++ b/fs/nfs/nfs3client.c
> > @@ -111,6 +111,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_se=
rver *mds_srv,
> >       cl_init.hostname =3D buf;
> >
> >       switch (ds_proto) {
> > +     case XPRT_TRANSPORT_RDMA:
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_TCP_TLS:
> >               if (mds_clp->cl_nconnect > 1)
> > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > index 11e3a285594c..84573df5cf5a 100644
> > --- a/fs/nfs/nfs4client.c
> > +++ b/fs/nfs/nfs4client.c
> > @@ -924,6 +924,7 @@ static int nfs4_set_client(struct nfs_server *serve=
r,
> >       else
> >               cl_init.max_connect =3D max_connect;
> >       switch (proto) {
> > +     case XPRT_TRANSPORT_RDMA:
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_TCP_TLS:
> >               cl_init.nconnect =3D nconnect;
> > @@ -1000,6 +1001,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_=
server *mds_srv,
> >       cl_init.hostname =3D buf;
> >
> >       switch (ds_proto) {
> > +     case XPRT_TRANSPORT_RDMA:
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_TCP_TLS:
> >               if (mds_clp->cl_nconnect > 1) {
> > --
> > 2.44.0
> >
> >
>
> --
> Chuck Lever
>

