Return-Path: <linux-nfs+bounces-16348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EEBC58E7A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 846894F8051
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA0364040;
	Thu, 13 Nov 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0RUEn5P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3263624CC
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052006; cv=none; b=uJ3X3VyC0FRsLaeXtR0MwrjFyUbhSp9dkPHxDYSxv/DZsUAB3YGm0QK9jyY2MoQa4uaA2G3tcIsgD2nxQDdL1QyS6c3tvZ6sLR7GzuSycQpD/20oSKR4uHpfDyVxs9rZnFCwWaIaq3FCEA099BSEKTvMivyVb+guFkzXlNaID+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052006; c=relaxed/simple;
	bh=cfUyfdfoseBOG/IIFMm69pza3MAGUSwuLoioALnWuqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIfAJ1qywlyLzwZZloBNPYDNUjMNqtceOevajGHZ+v7U4ZjuqaY56ReRL6r2ExxHeupo1s9egoW8WanL8foLxXZ/5eVGq8aknsyRl9WmoAZnjQDgZ3P1dYUt7z9WXJ0o5osgYnuSMZCoDKe9GqW1imCB6YA/RghwqHMOtJjiluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0RUEn5P; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c52fa75cd3so812653a34.3
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051994; x=1763656794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se0BzQfhUIXRIhwOdc92HTHcn3k85Yzr+cc0apDQrn0=;
        b=O0RUEn5PkjxMqBmYudiMxNpW78ql0jBBMDhwc5ctwN8SjrOF6fcYa88eJzD0NsNn7c
         dxYy3pYhb/P6K+YhUbenSbTaX23RaxzbbkQAuE9dksC+hcEli+JOC47JIB9REs8OzKej
         Fg4bkRed4CwgtSjAKT/3LtO5E1L7TK77oNXVimT+A1t69S8JnYu0WdzScTbWIUQytgLV
         uFRpGOqBbmi24uNc3QkOAWauJip+XT4wyTaJC7Sc4RDmJgTPT3ZP5kgkwciPPImd8efL
         5n0xLjPa0lzSu77XmfdjuS02Cr3zBRiXtwVCCeWZa5iW67vUsBDMmLEi+b5jTsvVmsVy
         DHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051994; x=1763656794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=se0BzQfhUIXRIhwOdc92HTHcn3k85Yzr+cc0apDQrn0=;
        b=wYbAjLo1pzkPnS/Rv8/3gpK53kvaan6FJyMCcDShLqkrX12yMhDs8cat0vkBbEY3fh
         OOCRjlyHOxp+9DZy2nWyU+lSS+Pn7woSEaLiueceWk8d64M3T9oRZcwJa8b/L/IZ0til
         t2/S5pYtTy//7D85T3w7ivKuxI28YIt/zXVBkXfmcaJIT9Co11SgXT6ySNmTn4Mhzyqc
         a0VA0k0NGOjM+nM+QU80XdpxF32+R3VhEKoKVVGnH9PCIVijw4d/ut+SJ7/7XUOSMm+t
         CYQ6IbOsXl2VhAtWRcWtBpJHB+mmME1I9w6yG/73I6acl2vDxz4ja5OCsYsrbH1ncTFz
         y7xA==
X-Gm-Message-State: AOJu0YxmLoIw2mbXOsFqRSjsVviSk7ikRxieUGO4ig+b9AG0d0xyCbn9
	iD49XAfgWuuRSZZtmMxBG+AubEoHfuh3nrIDjHhhmGPy/am+ytvIZT06nkwd4+kanPAi7YGlnGp
	0Q2VXE5x9WKpaZOKXaVUORTxekEbL1eY=
X-Gm-Gg: ASbGncsZBprD567qGl9nrsPSmsnkN4E7v94OXeZMLTXPZyuXsKBXNmQbeYDuwhG3ukK
	L7oBUg74XqVpnZEw6eQyOk1bL5G0zMbnG7eAn80ADZ+sOsEulliml93NthEadLBFiC7XVc3TqgU
	ITLnnCsmaDvb+0Nhy+Wf6eoiwT9vZboylNfQIzpnAQgxTAs0ANoKZdmCXqrqzWYPNLpjuZcJ+fF
	Cd8QdNnazicd2pjN2sX6npl1JRpngPp+1nta+VPk4qBHMxEMpqduL3idTDg5D8=
X-Google-Smtp-Source: AGHT+IEndtZZsK45bH4jx+1r32khIVU4HA4AkYZe5QPu1pRamSRgdhEW2MVN2FCQBg5hpSOAQD7TbHvZVb3fjT25kIM=
X-Received: by 2002:a05:6808:2207:b0:441:cabe:907 with SMTP id
 5614622812f47-450744c0d92mr3066733b6e.14.1763051994189; Thu, 13 Nov 2025
 08:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com> <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com>
In-Reply-To: <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com>
From: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date: Thu, 13 Nov 2025 22:09:43 +0530
X-Gm-Features: AWmQ_bkSZE-n1DH_iYWgff-3lXgeme6WKnJOSdsAvBVe4POA7_OmdEZ9nK16GD8
Message-ID: <CAJiE4O=zhEaJKQO7bBc8g9gXCiMoi7G7qSiVbQ5Cq+SwBK8OVw@mail.gmail.com>
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, neilb@brown.name, 
	Jeff Layton <jlayton@kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:49=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
> > Bumped up rpcrdma_max_recv_batch to 64.
> > Added param to change to it, it becomes handy to use higher value
> > to avoid hung.
>
> [ Resend with correct NFSD reviewer email addresses and linux-rdma@ ]
>
> Hi Gaurav -
>
> Adding an administrative setting is generally a last resort. First,
> we want a full root-cause analysis to understand the symptoms you
> are trying to address. Do you have an RCA or a simple reproducer to
> share with us?

Issue found while testing fio workload over RDMA
Client: Ubuntu 24.04
Server: Ganesha NFS server
We have seen intermittent hung on client with buffered IO workload at
large scale with around 30 RDMA connections, client was under memory
pressure.
Ganesha log shows

10/11/2025 16:39:12Z : ntnx-10-57-210-224-a-fsvm 1309416[none]
[0x7f49a6c3fe80] rpc :TIRPC :EVENT :rpc_rdma_cq_event_handler() cq
completion status: RNR retry counter exceeded (13) rdma_xprt state 5
opcode 2 cbc 0x7f4996688000 inline 1

Which points to lack of posted recv buffers on client.
Once we increased rpcrdma_max_recv_batch to 64, issue was resolved.

>
>
> > Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
> > ---
> >  net/sunrpc/xprtrdma/frwr_ops.c           | 2 +-
> >  net/sunrpc/xprtrdma/module.c             | 6 ++++++
> >  net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
> >  net/sunrpc/xprtrdma/verbs.c              | 2 +-
> >  net/sunrpc/xprtrdma/xprt_rdma.h          | 4 +---
> >  5 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_=
ops.c
> > index 31434aeb8e29..863a0c567915 100644
> > --- a/net/sunrpc/xprtrdma/frwr_ops.c
> > +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> > @@ -246,7 +246,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const =
struct ib_device *device)
> >       ep->re_attr.cap.max_send_wr +=3D 1; /* for ib_drain_sq */
> >       ep->re_attr.cap.max_recv_wr =3D ep->re_max_requests;
> >       ep->re_attr.cap.max_recv_wr +=3D RPCRDMA_BACKWARD_WRS;
> > -     ep->re_attr.cap.max_recv_wr +=3D RPCRDMA_MAX_RECV_BATCH;
> > +     ep->re_attr.cap.max_recv_wr +=3D rpcrdma_max_recv_batch;
> >       ep->re_attr.cap.max_recv_wr +=3D 1; /* for ib_drain_rq */
> >
> >       ep->re_max_rdma_segs =3D
> > diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.=
c
> > index 697f571d4c01..afeec5a68151 100644
> > --- a/net/sunrpc/xprtrdma/module.c
> > +++ b/net/sunrpc/xprtrdma/module.c
> > @@ -27,6 +27,12 @@ MODULE_ALIAS("svcrdma");
> >  MODULE_ALIAS("xprtrdma");
> >  MODULE_ALIAS("rpcrdma6");
> >
> > +unsigned int rpcrdma_max_recv_batch =3D 64;
> > +module_param_named(max_recv_batch, rpcrdma_max_recv_batch, uint, 0644)=
;
> > +MODULE_PARM_DESC(max_recv_batch,
> > +              "Maximum number of Receive WRs to post in a batch "
> > +              "(default: 64, set to 0 to disable batching)");
> > +
> >  static void __exit rpc_rdma_cleanup(void)
> >  {
> >       xprt_rdma_cleanup();
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprt=
rdma/svc_rdma_transport.c
> > index 3d7f1413df02..32a9ceb18389 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > @@ -440,7 +440,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_=
xprt *xprt)
> >       newxprt->sc_max_req_size =3D svcrdma_max_req_size;
> >       newxprt->sc_max_requests =3D svcrdma_max_requests;
> >       newxprt->sc_max_bc_requests =3D svcrdma_max_bc_requests;
> > -     newxprt->sc_recv_batch =3D RPCRDMA_MAX_RECV_BATCH;
> > +     newxprt->sc_recv_batch =3D rpcrdma_max_recv_batch;
> >       newxprt->sc_fc_credits =3D cpu_to_be32(newxprt->sc_max_requests);
> >
> >       /* Qualify the transport's resource defaults with the
> > diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> > index 63262ef0c2e3..7cd0a2c152e6 100644
> > --- a/net/sunrpc/xprtrdma/verbs.c
> > +++ b/net/sunrpc/xprtrdma/verbs.c
> > @@ -1359,7 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xp=
rt, int needed)
> >       if (likely(ep->re_receive_count > needed))
> >               goto out;
> >       needed -=3D ep->re_receive_count;
> > -     needed +=3D RPCRDMA_MAX_RECV_BATCH;
> > +     needed +=3D rpcrdma_max_recv_batch;
> >
> >       if (atomic_inc_return(&ep->re_receiving) > 1)
> >               goto out;
> > diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt=
_rdma.h
> > index 8147d2b41494..1051aa612f36 100644
> > --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> > +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> > @@ -216,9 +216,7 @@ struct rpcrdma_rep {
> >   *
> >   * Setting this to zero disables Receive post batching.
> >   */
> > -enum {
> > -     RPCRDMA_MAX_RECV_BATCH =3D 7,
> > -};
> > +extern unsigned int rpcrdma_max_recv_batch;
> >
> >  /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send comple=
tes
> >   */
>
>
> --
> Chuck Lever

