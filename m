Return-Path: <linux-nfs+bounces-16772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993AC90E56
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 06:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AF73AAF90
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0080624466C;
	Fri, 28 Nov 2025 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr6+48NU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44B3B1B3
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764308930; cv=none; b=p3eMvg52vhVGZt+1+RW7/H/dMcLBQdT+suEKNICEkS3p7kZcHpBS2lswQGQU8w3Veydt4qa1q58dqjRxyPgK6kPsHqnvMjw54WyjBEYSQ+UFlqFAGVvDIdK2IxMuYgtE3YM1PpsP1+9m2SvSyDujDE1WEEOp/PJ7myweE2xqlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764308930; c=relaxed/simple;
	bh=fSjIyGyS4jVRIJpVP5drxPSucJxMk9FPbAbE4rfGF1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmBJOJfAocNCg9hcwxQw7rCyvbU5pOYB/TkAdDBTERC7xJv3nnOXc6dCQnypaZVg0E2XfbbIUOIHwbU+21ocy/A5JIndtlyigS/eUPteC2Ppt47T+E1rpA+I1FMMO7B+N+R/EU52ZRL2jkPeW2hytWTRGe3Xj9PtHpzh1rUMNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr6+48NU; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-657490df6f3so564402eaf.2
        for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 21:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764308928; x=1764913728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSjIyGyS4jVRIJpVP5drxPSucJxMk9FPbAbE4rfGF1U=;
        b=mr6+48NUxGK1ER18Fu2U63afyQliZseZXRlBwnTh6JhblgEOrN4KvvnKCGG8v8KYf+
         nvaJA0gUsoCJ76Z5VFSav2X4CKzjZahSE5N4NfQvyq0yH9IO4OwfG4PMeozn2HVy/9Bw
         +kzJQu0AUw7VomAFJIo+DliWIrl2+CFlMEAYOkqC8saD4JxjWVig3i1oiN/z9+ol9wiF
         uGxeSZR6RbFhWYVVcmStQhKIqT+/BlwoQtOX3v/YXcOuWJwLWXK7ZOY0wSw6HubNJnMt
         yrHwzotjd/tnUMgNiZX5GeeF5rKhbYJb+yoNZ55r/vmbwDiSkVNCUUxXyBt1jQNpYzv/
         ahTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764308928; x=1764913728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSjIyGyS4jVRIJpVP5drxPSucJxMk9FPbAbE4rfGF1U=;
        b=qn79p7Q0333sbZYI5VsPiPDiZPgbsF1+xrkEKiGT+I9rvtiTGuU2Us+721tYhfpdS7
         SaKyHiOLWE5qr2smPWKlHyH7IjQRMOkXBT7O1wfR7CloVo6qhK9e8wIaGtzuAV7HlpF4
         DMPyA/l3veACjN/efgNG1UKD9h4POx2MF0H6oEpszZ8iN0Up2do2MnXX1KlKkO8HKuUT
         glb7bDyxe5yodWxdZJa4cazyvMawFFhWaNZJriIa3YaPjc30J5rdJplrnoPbtwts1lvS
         ldl7XRUWrlZuquDgKEoUxa+sb5TZmVn1iUBiTbOJ032Wk1DLqKXpzdGOALM7PQxmY5KL
         E8gg==
X-Forwarded-Encrypted: i=1; AJvYcCWITXEJXOTvVdFwJozXAA6OQO2Z3G4bS3Ama5wgoIRrEZi1VTUg9gA3GHRpPJPBnWoLybhUAedh2uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLVQ1KC9gWqalv+9iOgbL8KYaJQ1eBMkbWiyv8f10m/veytXg
	aHt5ifYbramti7ebRKTuuinHK4DIU7xRsuQC3rFv9kqoGcMZv4LmuVPJq5EvQWsCDXz1TKQirBW
	BlFyEO+u2XeBZE5DYdga0Z4vllIOyDwY=
X-Gm-Gg: ASbGncvywiTsQ8hYIH2nJ0F3ZZGS82vQq4tsWixzaLlIZa/24PnF5TVFyIp5SVbAFBA
	WwVZFzE7phJsSIhT5k6gVGnOulxrPA5FmHB8k9aVb9O+epcjEOslKBph25Z2gG7efgUKhsZT9dN
	laEvnldpWk8uizImu52B9aK+hA3RbUQLMCSVdF2JGnt6CI43ImPk05DHbWA22Ab1+6HX5NfUXcV
	f/DxoipIEgCcXdn0aSLnnQOL6quuPevR4LGPhTO6xLcKLkqeReiPwFMDmkG7Y/Ptfak4HREIw==
X-Google-Smtp-Source: AGHT+IETVVoMLF/ZbBbT6Lkyv00mgDtVUreHT7hilfznapRWibURo+ZvVRSnOJY7itZuwYEpeHBeJgOOfD2EIXJG9co=
X-Received: by 2002:a05:6820:2017:b0:657:5cc3:f38 with SMTP id
 006d021491bc7-657908538bcmr9144016eaf.0.1764308928307; Thu, 27 Nov 2025
 21:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
 <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com> <CAJiE4O=zhEaJKQO7bBc8g9gXCiMoi7G7qSiVbQ5Cq+SwBK8OVw@mail.gmail.com>
 <fc58b0f2-d00b-4e4e-a353-ffe43bec6c6e@oracle.com> <55be56d3-b286-4b39-8246-4be80b03c22c@talpey.com>
In-Reply-To: <55be56d3-b286-4b39-8246-4be80b03c22c@talpey.com>
From: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date: Fri, 28 Nov 2025 11:18:37 +0530
X-Gm-Features: AWmQ_bm2eeyH_w63djEYQd-J6wll3KLYlQ4mWv5zbTcFuZT9EAoM28QZhLoY65k
Message-ID: <CAJiE4OndWrE5jCrVXg4jse-nWUawPXnzEkYA9L1UAoMCL=KfAw@mail.gmail.com>
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Tom Talpey <tom@talpey.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, neilb@brown.name, 
	Jeff Layton <jlayton@kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:34=E2=80=AFAM Tom Talpey <tom@talpey.com> wrote:
>
> On 11/13/2025 12:41 PM, Chuck Lever wrote:
> > On 11/13/25 11:39 AM, gaurav gangalwar wrote:
> >> On Thu, Nov 13, 2025 at 7:49=E2=80=AFPM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>>
> >>> On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
> >>>> Bumped up rpcrdma_max_recv_batch to 64.
> >>>> Added param to change to it, it becomes handy to use higher value
> >>>> to avoid hung.
> >>>
> >>> [ Resend with correct NFSD reviewer email addresses and linux-rdma@ ]
> >>>
> >>> Hi Gaurav -
> >>>
> >>> Adding an administrative setting is generally a last resort. First,
> >>> we want a full root-cause analysis to understand the symptoms you
> >>> are trying to address. Do you have an RCA or a simple reproducer to
> >>> share with us?
> >>
> >> Issue found while testing fio workload over RDMA
> >> Client: Ubuntu 24.04
> >> Server: Ganesha NFS server
> >> We have seen intermittent hung on client with buffered IO workload at
> >> large scale with around 30 RDMA connections, client was under memory
> >> pressure.
> >> Ganesha log shows
> >>
> >> 10/11/2025 16:39:12Z : ntnx-10-57-210-224-a-fsvm 1309416[none]
> >> [0x7f49a6c3fe80] rpc :TIRPC :EVENT :rpc_rdma_cq_event_handler() cq
> >> completion status: RNR retry counter exceeded (13) rdma_xprt state 5
> >> opcode 2 cbc 0x7f4996688000 inline 1
> >>
> >> Which points to lack of posted recv buffers on client.
> >> Once we increased rpcrdma_max_recv_batch to 64, issue was resolved.
> >
> > That still doesn't convince me that increasing the receive batch count
> > is a good fix, though it's certainly a workaround.
>
> It's not a workaround, this will fail on any RDMA provider that doesn't
> perform RNR retry, for example iWARP. But more importantly, RNR retry is
> unnecessary because the rpcrdma protocol implements a strict crediting
> exchange. A proper rpcrdma implementation will never trigger RNR.
>
> This is almost certainly an rpcrdma protocol violation in the sender,
> which is failing to honor the credit limit granted by the receiving
> peer and is overrunning the peer's receive queue. A wireshark trace
> would prove it. Please do this research.
>
> Tom.
>
>
> >
> > The client's RPC/RDMA code is supposed to track the number of Sends and
> > keep the correct number of Receives on the Receive Queue. The goal of
> > the implementation is to never encounter an RNR.
> >
> > Therefore, if it's not doing that (and the RNR retries suggests that's
> > the case) there is an actual bug somewhere. The extra batch Receives ar=
e
> > an optimization, and should have no impact on correct operation.
> >
> > If you can't reproduce this with the Linux NFS server, the place to
> > start looking for misbehavior is NFS/Ganesha, as it is the newer NFS
> > over RDMA implementation of the two servers. Maybe it's not handling
> > credit accounting correctly, or perhaps it's putting more Sends on
> > the wire than the credit limit allows.
> >
> >
>
Thanks for the review, I was going through server implementation for
NFS Ganesha, we strictly honor read_chunks, write_chunks and
reply_chunks, so the credit limit should be client driven only.
Only in case of callbacks from server to client, as of now there is no
credits check, we advertise server_credits in cb call similar to
rb_bc_max_requests in linux NFS server, but don't check for
client_credits from client in reply. We need to limit callbacks to
MIN(server_credits, client_credits)

Regards,
Gaurav

