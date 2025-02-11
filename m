Return-Path: <linux-nfs+bounces-10036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4846A3026A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 05:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619AA3A612F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999D35962;
	Tue, 11 Feb 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTz/VInJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E68C07
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739246419; cv=none; b=izFIUZ+YT/QpozGayjrMlQwygh9yKvYh+50ILfevdJUJPlHj08MZe8fjXJAhSHD5fiqqy0GpKpMSkoq5n1luN7qoCleBdrnPOsIc0SRTO1ctt6P4uwsrgvlhb/F7VxapVogPM/aKHWp8X5F//gPmZY1ayQp8/5/ImJVFLlnNmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739246419; c=relaxed/simple;
	bh=dRgl2QaejzgBnr2CP1SWhgNGWvAXwO591VWepsHAKfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpjqvTXnoHVSdJIxuEuGYFt59sg3/H6LF6m/e7yS4Fhz4XhKyYy6z4PTwLpnpzQLpPwroMij3A8l3XYioTapIb/0xVYPifUuhuXPnVjrrcclkcP5eGEqvvQ4k0r8e2u6PYPbp+ACzfrPg3PL10TUYNXOo1Y6r4fUZAAxmPVygnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTz/VInJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so35975a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 20:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739246416; x=1739851216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEE0Eliu1+MpYyHyR9g17I3odR7nyoD0jgEI4V923dg=;
        b=dTz/VInJ8Ovt5lYHq8Fxb25Un0/3tQNBvzILAfIE2rVwXUjuVFfFiXwcB6rKvY8B0e
         8z6GBlmN/eemkEc5sfE2kDp1NxyqIaFONZup9qrr5X/ypo7FZZvosXZDR3NB5KxCxlor
         KOgghodZ9wsqh5nCpJJHes5AnK2lvrv8EI7eSlvupJTaRQ+6AW7HJrbkN3yweiaikji7
         RlMzUbVHbcLEyfT+XuBO31N5nTRCi68Evs9uiy14lBdJwyeVupEIBNSeWVwQ4BYxQXUS
         yMN+E5PEMW/cGu+61yQJrKtk0C6MTp85IWO+bdYmnud0pRJdeHb6xZZ7a8D//8L8dMiI
         phOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739246416; x=1739851216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEE0Eliu1+MpYyHyR9g17I3odR7nyoD0jgEI4V923dg=;
        b=u8vuwfxAyNR13PiJGZMZEEpqeaUAuIbWP4yPOgb2Ah1bXzWSc+cfeq5TPxLVYdtFu7
         7y9sd7dWfuQnl2ibS/HeVVjvlNtREnw4rx6bisa2WVGw//OFomA6VYHNC1sNrtIBbgPK
         rJ3Ttj7Vf8J/RQE97g82w/xtyGV+tgsItjak3SR7CCAnCyd9zh0nN2n8/4zTg5sV3Q+C
         x6m22/cXE79r1sbuN6LIyVIoVKdrwYK/ijp2Fj5yWnzCQ1bGvN0a6HCmGkzyURajZvNu
         0mfFdHAbiNS/A0S76ThhB5/GxOIXbXwFYWVCfebRbrZlvO6mlpyQVqHVvWKHcLl0ifz0
         9nHw==
X-Forwarded-Encrypted: i=1; AJvYcCV70toGtpm8d5TYMZabOitUuSUVZQ09ogny5mjREXUkrbWptDY0ReWU2YhaXcXZcywHbkyssbhsUfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQ6onzUDUMlTi9QMVepsKJnSgsbUeLuqYz+osVSFQkUdJ/iav
	4mES+d2x0aqlMkxpqXOimrsinV8OexlUtF/xyF1QeMB/kZNfVW2ea4zrsS2q/9l7TZwydJAyB/R
	D2Nv/9rz272KUl8BrhkJO+5XOAw==
X-Gm-Gg: ASbGncuB8UZjb3JfBIPW6czysATWWqqxLEDqYiWbv/arLzTIWmNyKibwf1N9W+164ad
	Y1RiVmeZZBamwGHNGRXgstr7ok5jvU6QS1xXr38B3yj6saULNjUvcLITtc/JSMeIxn8MG19tWRQ
	gTfJja8s9++W6whvdPAsDGY9l4g2bH5A==
X-Google-Smtp-Source: AGHT+IHeWyDF2oT/FAF29iQcJ/B9DGGlbKufQXnLnQGgMXr1RrHnMjjnrJAtIhK4BRPXcWFN0WmCvWKJVwrOHrDUD7A=
X-Received: by 2002:a05:6402:4608:b0:5dc:7538:3b6 with SMTP id
 4fb4d7f45d1cf-5de44feb687mr14416489a12.1.1739246415640; Mon, 10 Feb 2025
 20:00:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
 <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
 <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com> <e937d6d9-9d58-4c09-aeed-9b7e676d8799@talpey.com>
 <8e25d16b9d94179cd9214f46ca214012116ff7bd.camel@hammerspace.com>
In-Reply-To: <8e25d16b9d94179cd9214f46ca214012116ff7bd.camel@hammerspace.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 10 Feb 2025 20:00:03 -0800
X-Gm-Features: AWEUYZm8DtZ-v6GNbQNS4uJhwlfNSmcUgmnowYMv9i0RDeDxyAfHXmkxTvxWy2U
Message-ID: <CAM5tNy5sxXmg-SbW4k-Gh0GN3isdY=r94wAPhyDVuK1OLR0Q=w@mail.gmail.com>
Subject: Re: resizing slot tables for sessions
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "tom@talpey.com" <tom@talpey.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:11=E2=80=AFAM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Mon, 2025-02-10 at 13:07 -0500, Tom Talpey wrote:
> > On 2/10/2025 8:52 AM, Chuck Lever wrote:
> > > On 2/9/25 8:34 PM, Rick Macklem wrote:
> > > > On Sun, Feb 9, 2025 at 3:34=E2=80=AFPM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I thought I'd post here instead of nfsv4@ietf.org since I
> > > > > > think the Linux server has been implementing this recently.
> > > > > >
> > > > > > I am not interested in making the FreeBSD NFSv4.1/4.2
> > > > > > server dynamically resize slot tables in sessions, but I do
> > > > > > want to make sure the FreeBSD handles this case correctly.
> > > > > >
> > > > > > Here is what I believe is supposed to be done:
> > > > > > For growing the slot table...
> > > > > > - Server/replier sends SEQUENCE replies with both
> > > > > >     sr_highest_slot and sr_target_highest_slot set to a
> > > > > > larger value.
> > > > > > --> The client can then use those slots with
> > > > > >        sa_sequenceid set to 1 for the first SEQUENCE
> > > > > > operation on
> > > > > >        each of them.
> > > > > >
> > > > > > For shrinking the slot table...
> > > > > > - Server/replier sends SEQUENCE replies with a smaller
> > > > > >    value for sr_target_highest_slot.
> > > > > >    - The server/replier waits for the client to do a SEQUENCE
> > > > > >       operation on one of the slot(s) where the server has
> > > > > > replied
> > > > > >       with the smaller value for sr_target_highest_slot with
> > > > > > a
> > > > > >       sa_highest_slot value <=3D to the new smaller
> > > > > >        sr_target_highest_slot
> > > > > >       - Once this happens, the server/replier can set
> > > > > > sr_highest_slot
> > > > > >          to the lower value of sr_target_highest_slot and
> > > > > > throw the
> > > > > >           slot table entries above that value away.
> > > > > > --> Once the client sees a reply with sr_target_highest_slot
> > > > > > set
> > > > > >        to the lower value, it should not do any additional
> > > > > > SEQUENCE
> > > > > >        operations with a sa_slotid > sr_target_highest_slot
> > > > > >
> > > > > > Does the above sound correct?
> > > > >
> > > > > The above captures the case where the server is adjusting using
> > > > > OP_SEQUENCE. However there is another potential mode where the
> > > > > server
> > > > > sends out a CB_RECALL_SLOT.
> > > > Ouch. I completely forgot about this one and I'll admit the
> > > > FreeBSD client
> > > > doesn't have it implemented.
> >
> > The client is free to refuse to return slots, but the penalty may be
> > a forcible session disconnect.
> >
> > I agree you've captured the basics of the graceful-reduction
> > scenario,
> > but I do wonder if nconnect > 1 might impact the termination
> > condition.
> >
> > Because nconnect may impact the ordering of request arrival at the
> > server, it may be possible to have a timing window where one
> > connection
> > may signal a reduction while another connection's request is still
> > outstanding?
>
> Not if the client is doing it right. It doesn't really matter which
> connections were used, because the client is telling the server that "I
> have now received all the replies I'm expecting from those slots".
>
> IOW: the client is supposed to wait to update the value of
> sa_highest_slot in OP_SEQUENCE until it has actually received replies
> for all RPC requests that were sent on the slot(s) being retired.
> It shouldn't matter if there are duplicate requests or replies
> outstanding since the client is expected to ignore those (and so the
> server is indeed free to return NFS4ERR_BADSLOT if it has dropped the
> cached reply).
>
> Now there is a danger if the server starts increasing the value of
> sr_target_highest_slot before the client is done retiring slots. So
> don't do that...
>
> >
> > Tom.
> >
> >
> > > >
> > > > Just fyi, does the Linux server do this, or do I have some time
> > > > to implement it?
> > >
> > > As far as I can tell, Linux NFSD does not yet implement
> > > CB_RECALL_SLOT.
>
> No, but according to RFC 8881 Section 17, CB_RECALL_SLOT is labelled as
> REQuired to implement if the client ever creates a back channel. So
> other servers may expect it to be implemented.
Yes, and someday I will get this implemented. For the FreeBSD client, not
running the callback daemon (called nfscbd) results in no backchannel and
my understanding is that a NFSv4.1/4.2 client is permitted to run without a
backchannel. (The server should not issue or layouts for this case.)

rick

>
> > >
> > >
> > > > > In the latter case, it is up to the client to send out enough
> > > > > SEQUENCE
> > > > > operations on the forward channel to implicitly acknowledges
> > > > > the change
> > > > > in slots using the sa_highestslot field (see RFC8881, Section
> > > > > 20.8.3).
> > > > >
> > > > > If the client was completely idle when it received the
> > > > > CB_RECALL_SLOT,
> > > > > it should only need to send out 1 extra SEQUENCE op, but if
> > > > > using RDMA,
> > > > > then it has to keep pounding out "RDMA send" messages until the
> > > > > RDMA
> > > > > credit count has been brought down too.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

