Return-Path: <linux-nfs+bounces-10038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E9A30BB8
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 13:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C10165056
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E071FCF74;
	Tue, 11 Feb 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2l4RAjI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B001FCD06
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276790; cv=none; b=pLmHRGgT7B7p+qhruPANQBXxm2SIzCz0D4TjCvl+W952eYPuEb1zDXe5mLgAjE1GAl42ncysMdeijgfUjZFXhgffcdHt90k9OEESA8b3nJP3V0JPU6QPenovejQeYiBHRYznvu1AuXj8AXSs1W7gT84uBL4647z+Sk014VcbLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276790; c=relaxed/simple;
	bh=bmSL0hQntS4R9NbGXAD9xVG/hvrNRIgsuqWRGGCHttE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jelEpypIQU/Kg7O46S0mlaSqwjFvgN10IVPQ0c+soU9f0bL7JMc1YRu0xr+rrAhPZHGlZbZvg4NODYJcx87sQbeCf796PbcitTS90BTmtOtODGS5UKbJ9B87h+sMonzuWtwY3+DNZ+AUecMcWybeHBN8T8sXsBRbOGyrO9BRevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2l4RAjI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso12592639a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739276787; x=1739881587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K5NMZguhXblQQvrLqwvBZEIfW5mqDzH9A16q9k26rM=;
        b=W2l4RAjIssY3shmxEkYc9QDoj786bKXVe9VQnymBlWO/XXPLwyF+vgoF2beQ34BTOW
         I6qLS/4O05QCHMSDpxUCJK4mtEH8DHMI5M+VOJdqpDGVGbjWt9L7p2fs2mheKB0zI+OD
         WIbN51TkmrKtFQgKWfj/kmAT3XmpgYwJ6IBImWXT59QXvCi7HhrSxGwMYm7ksomSZXR5
         vUK17k8MfJFaQRORl662wj2uMbzX6/8+XuFM1y7J/6Wi8/1I1NAPbwDgq93benQnINUn
         GKFon1eumddnN0wli+v+8itCdyz6jT7Jz9fbqFiuYmB5xkN2MlDo1eERzRx62h6UrO6C
         wIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739276787; x=1739881587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K5NMZguhXblQQvrLqwvBZEIfW5mqDzH9A16q9k26rM=;
        b=YlVQrp3rZ9DELr1Li8TYqDjzLE6wk+MgzINBmxQJNgMZEh+s0HasJjI3K/1uKmvfKq
         eqCOecKoVeSunpr48zM3Pb/+ufFj/OxW8BcRI+M+HIa+zYi4epCJ8WpVecMbFnnatCAy
         hdgL5nxpYx6INrkJTQMZ62AX4x27qZ4aYL74fT7YWx+t5+bT26X04ysq7fYV3MVAgsBW
         tRJnDosAIReZ8rCM7D5ILxROVu/fmvkodFO5X1sleMjl7C2G27ZaJnyixsoJybJeDQiE
         DUpZEyn7Ojo1KOhqyTI66E5kHZHOXDZVGpoG/D4zaBKug+PcwAWYgFPwZFxihluFdOw3
         F0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW302IvGAV94RYs4NcnrcvlOgs1XTqyML56vCUFamzCkabV+qi5m6eC8GhH2quataLeZCsIi8gSAJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PROV6Gr4mw+tsXUlnCFezTT5aHf9hoMPEKgz+7Z8WoCDymFw
	h/7ewos8Ww17el5OzCTqsE7H/MjldQQT/tcpprnv+3qTcYPQpRPpMjOVoAk8vBzebePUIU22t2N
	Bg3DyuN+5OmcQo8IOWunZbTlEvQ==
X-Gm-Gg: ASbGnctANymg7/FbM+CzS43TlUmPDQSJwDsVbEuvefI1MqKbGTEXSG7eIWmaymamjSk
	SPvSX5Kyb4F6D6wGVkSqQ5d59LfOUBo45hXUG150pCiTfXjXoz6cenCSNTsnWJpmmrPEJq49Ejy
	rW56kjlMT2yJDJV/T/zF4fGbEY2lNusA==
X-Google-Smtp-Source: AGHT+IF7HjUYdwOm1jmc1lUaEDR8vT1IsXiNqbL0+IwSqcQqipXrjyDZnJglFCiao2Wb7KJJhgTkHw9kbTnITzdkUkU=
X-Received: by 2002:a05:6402:5206:b0:5de:50b4:b71f with SMTP id
 4fb4d7f45d1cf-5de9b9b630emr2893059a12.12.1739276786800; Tue, 11 Feb 2025
 04:26:26 -0800 (PST)
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
Date: Tue, 11 Feb 2025 04:26:13 -0800
X-Gm-Features: AWEUYZn3axx-eNRiDYD949uc5aSFcUw3wjvPzDjnMPc8ozt0nU-myTzDOue0f5Y
Message-ID: <CAM5tNy4wnvpinT58wOJtAObdadn-hffb5XqvTfmtFoG30sG7AA@mail.gmail.com>
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
Well, I think both you and Tom are correct, in a sense...
Here is what RFC8881, sec. 2.10.6.1 says:

     The replier SHOULD retain the slots it wants to retire until the
      requester sends a request with a highest_slotid less than or equal
      to the replier's new enforced highest_slotid.

I think the above is at least misleading and maybe outright incorrect.
So, if the above were considered "correctly done", I think Tom is right.

I did the original post in part to see if others agreed that the server/rep=
lier
must wait until it sees a SEQUENCE with sa_highest_slot <=3D the
new sr_target_highest_slot on a slot where the new sr_target_highest_slot
has been sent in a previous reply to SEQUENCE. (Without this additional
requirement of "a slot where..." I think the SEQUENCE could be in an RPC
that was generated before the client/requestor saw the new
sr_target_highest_slot.

I might post about this on nfsv4@ietf.org, but I do not know if it could
be changed as an errata?

Thanks for all the comments, rick


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

