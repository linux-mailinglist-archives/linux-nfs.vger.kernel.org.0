Return-Path: <linux-nfs+bounces-10109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C947A3534B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 01:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F0F3AACF7
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288C79F5;
	Fri, 14 Feb 2025 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImUeDQtR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B13BBC9
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494578; cv=none; b=XaN+QDEAVz+z1/7bvlxGopxSXmIwNYjSPw5Fh2CNLX8F54SKrzwZIJwvxTpR8nuoBldcredjVqBd3UwsLRhfSH90dJE8M68O9XuAXFNEVkDBeUKyxxW/ezqhodk5V6XVZ85ohQM1vduQQTwvfsZo+Fy83HBHT94aY2qlRJ8FBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494578; c=relaxed/simple;
	bh=wWR3SY9rYyPkOrnG2H8GGfy/5QhLf2jr7E3KTddHi84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbnLPHJlL2TIlZbmMIdqNTyMuK8X1/o7Kore3h+KkkAvQWMmLu+TTzbRNI+WBzGRQXJb2YsR0sNL75hfCVWA2Lm4IdVgQ/lbp0tmYWzJa5qX/dZpCOsxISshfmhlowmg5pYBwtPYJQAR+kPsaSnaQQuEZOkFD7AUDjM3RfRjhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImUeDQtR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso2440788a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494575; x=1740099375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHFlWRxMozB6QY/rGhduY+uZ+2rYi78x5FybrGIcVH4=;
        b=ImUeDQtR/e/cqrJTAGp8lSnyuQV13fRyOgjd2WMtqguU8o6wTODLXnF1+Ad0dYLa10
         xcxu8aZexOd+dsS2UqqUOZxMbg/yNvpPXgZcTF1oVuAVbG/IyBoeoGKqr3PrBCqB8FSg
         p5GsXjq8rVy/Te2J5EgAedfPeW5WdhhyL84A/Wynt4HuRkWCHSRI7kYLTuPSpmPgf0he
         1qZ3Lo3EDRcxHrTru9imLo7fBvjzO9jtS9cqZJFpfyNhpGpMQbfju+bZ+JmC3cZ/5U4O
         4p+fCnOIcNEyiXNvFuJBypd4rRVZIfiWeE1yKkUHEfH0R/UtjUeYgLjZyS7KyFMlMqWk
         9BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494575; x=1740099375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHFlWRxMozB6QY/rGhduY+uZ+2rYi78x5FybrGIcVH4=;
        b=leCDXFdIA3a0KmwlNS/lY6c2nG/zkWQQFPtFyDnvxYtKvZXUebB2hpl3hitnPRbIuS
         631k4YLFs2kb2jthI23r5nk7lrJ/fQgopktp7u0unYMw7HJiIRY0e+sgzOOCdT6isnRZ
         uZIREUG5Rpolnnl0wiFpnCsnMbS/cFlIXlrNxbaQ+e4BCNihga6jGBIhDz2tSTh42Ru2
         lNTNiVOOKr5sZEUhgH8IivYge2BZyW0XimIvQykgd2QvzGbT7botvWO6m3d0vIO+zoE9
         iW44rgfOq6L6JV9arPvjpITFW+JptpTi3ZTEikRWorgANqxM+ektjVVUO2jv6KmhHDtv
         zMSg==
X-Forwarded-Encrypted: i=1; AJvYcCVPV59dH1KTGvgoEyQEh64xfpI8svjOcSen2MyzjW7j+P052nIKn3elSoZyP4/3c3uCDtU/vR86I6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/Z/Bv+HmohJU3WKM1wRGFyJFOqnt00acjMEY/Au3mGWoYJ/k
	Jkl/2cgW0PdBYRGYxCK6zqO4qQaqtb7aEM2J99zqkby6ZtljDENd4TNstsNv6IppY3Dg1JBMuO7
	bJjWv+05mQsmTzcuFPsXYvb3ZGWU1
X-Gm-Gg: ASbGncvp8+VtZtzYLvjl+SBClBks4Ivns7+/Fb7QdERVM0zFTKOEubT3rDcwo1CM0iK
	vHIWUIawF8M7IVVGv80MompcTTFSbxo0UYY38vX4z3DkC2aRrn8sWfHpN4JBQC0rU2oaTRxp8Lj
	bKFHGYCUWzcy+A7Om01nPWN/rHvGxMiw==
X-Google-Smtp-Source: AGHT+IElBFDlZExa38mD4FbExkJaDonvR5xC+R1wrmByFwf+74Kdfz2PFiLM2gPUbIQfLumuBmPab85pgzG1umQKTtM=
X-Received: by 2002:a05:6402:40d1:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5deadd7b87fmr8240000a12.2.1739494574480; Thu, 13 Feb 2025
 16:56:14 -0800 (PST)
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
 <CAM5tNy4wnvpinT58wOJtAObdadn-hffb5XqvTfmtFoG30sG7AA@mail.gmail.com> <d7c63c2e-460c-48c3-8eb5-48dbaeefd527@talpey.com>
In-Reply-To: <d7c63c2e-460c-48c3-8eb5-48dbaeefd527@talpey.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 13 Feb 2025 16:55:58 -0800
X-Gm-Features: AWEUYZl64XGB61EW1ZiiAkau8H276Kty0QrlPHg-sysXvKQ0jpuPzCSPUTmADaM
Message-ID: <CAM5tNy4tGm18OEHiFSjMXyqjutvuCfgaF9fOV6VD9gv+NSy_mA@mail.gmail.com>
Subject: Re: resizing slot tables for sessions
To: Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:05=E2=80=AFAM Tom Talpey <tom@talpey.com> wrote:
>
> On 2/11/2025 7:26 AM, Rick Macklem wrote:
> > On Mon, Feb 10, 2025 at 11:11=E2=80=AFAM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> >>
> >> On Mon, 2025-02-10 at 13:07 -0500, Tom Talpey wrote:
> >>> On 2/10/2025 8:52 AM, Chuck Lever wrote:
> >>>> On 2/9/25 8:34 PM, Rick Macklem wrote:
> >>>>> On Sun, Feb 9, 2025 at 3:34=E2=80=AFPM Trond Myklebust
> >>>>> <trondmy@hammerspace.com> wrote:
> >>>>>>
> >>>>>> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I thought I'd post here instead of nfsv4@ietf.org since I
> >>>>>>> think the Linux server has been implementing this recently.
> >>>>>>>
> >>>>>>> I am not interested in making the FreeBSD NFSv4.1/4.2
> >>>>>>> server dynamically resize slot tables in sessions, but I do
> >>>>>>> want to make sure the FreeBSD handles this case correctly.
> >>>>>>>
> >>>>>>> Here is what I believe is supposed to be done:
> >>>>>>> For growing the slot table...
> >>>>>>> - Server/replier sends SEQUENCE replies with both
> >>>>>>>      sr_highest_slot and sr_target_highest_slot set to a
> >>>>>>> larger value.
> >>>>>>> --> The client can then use those slots with
> >>>>>>>         sa_sequenceid set to 1 for the first SEQUENCE
> >>>>>>> operation on
> >>>>>>>         each of them.
> >>>>>>>
> >>>>>>> For shrinking the slot table...
> >>>>>>> - Server/replier sends SEQUENCE replies with a smaller
> >>>>>>>     value for sr_target_highest_slot.
> >>>>>>>     - The server/replier waits for the client to do a SEQUENCE
> >>>>>>>        operation on one of the slot(s) where the server has
> >>>>>>> replied
> >>>>>>>        with the smaller value for sr_target_highest_slot with
> >>>>>>> a
> >>>>>>>        sa_highest_slot value <=3D to the new smaller
> >>>>>>>         sr_target_highest_slot
> >>>>>>>        - Once this happens, the server/replier can set
> >>>>>>> sr_highest_slot
> >>>>>>>           to the lower value of sr_target_highest_slot and
> >>>>>>> throw the
> >>>>>>>            slot table entries above that value away.
> >>>>>>> --> Once the client sees a reply with sr_target_highest_slot
> >>>>>>> set
> >>>>>>>         to the lower value, it should not do any additional
> >>>>>>> SEQUENCE
> >>>>>>>         operations with a sa_slotid > sr_target_highest_slot
> >>>>>>>
> >>>>>>> Does the above sound correct?
> >>>>>>
> >>>>>> The above captures the case where the server is adjusting using
> >>>>>> OP_SEQUENCE. However there is another potential mode where the
> >>>>>> server
> >>>>>> sends out a CB_RECALL_SLOT.
> >>>>> Ouch. I completely forgot about this one and I'll admit the
> >>>>> FreeBSD client
> >>>>> doesn't have it implemented.
Btw, I just coded this for the FreeBSD client and used a fake server
to test it. I found that wireshark doesn't know how to decode the
argument for CB_RECALL_SLOT, which is another hint that it is
not being used. (It will take a while to get into releases.)

I, personally, think CB_RECALL_SLOT is pretty useless, since it can only be=
 used
for sessions with backchannels (no sessionid argument).

> >>>
> >>> The client is free to refuse to return slots, but the penalty may be
> >>> a forcible session disconnect.
> >>>
> >>> I agree you've captured the basics of the graceful-reduction
> >>> scenario,
> >>> but I do wonder if nconnect > 1 might impact the termination
> >>> condition.
> >>>
> >>> Because nconnect may impact the ordering of request arrival at the
> >>> server, it may be possible to have a timing window where one
> >>> connection
> >>> may signal a reduction while another connection's request is still
> >>> outstanding?
> >>
> >> Not if the client is doing it right. It doesn't really matter which
> >> connections were used, because the client is telling the server that "=
I
> >> have now received all the replies I'm expecting from those slots".
> >>
> >> IOW: the client is supposed to wait to update the value of
> >> sa_highest_slot in OP_SEQUENCE until it has actually received replies
> >> for all RPC requests that were sent on the slot(s) being retired.
> >> It shouldn't matter if there are duplicate requests or replies
> >> outstanding since the client is expected to ignore those (and so the
> >> server is indeed free to return NFS4ERR_BADSLOT if it has dropped the
> >> cached reply).
> >>
> >> Now there is a danger if the server starts increasing the value of
> >> sr_target_highest_slot before the client is done retiring slots. So
> >> don't do that...
> > Well, I think both you and Tom are correct, in a sense...
> > Here is what RFC8881, sec. 2.10.6.1 says:
> >
> >       The replier SHOULD retain the slots it wants to retire until the
> >        requester sends a request with a highest_slotid less than or equ=
al
> >        to the replier's new enforced highest_slotid.
> >
> > I think the above is at least misleading and maybe outright incorrect.
> > So, if the above were considered "correctly done", I think Tom is right=
.
>
> I think both Trond and I are right. :) In any event we're not disagreeing=
,
> it's just thaty the client implementation needs to be careful.
> If there are multiple forechannels, they all need to be taken
> into consideration. The server doesn't have any protocol-specific
> guarantee that the client has done so. Therefore it's on the client.
All the client needs to do is not use the slots above the new target_highes=
t.
To me, it is the server that needs to be careful to not throw away the slot=
s
above target_highest before any RPCs issued by the client before the
target_highest was lowered might still be in flight.

At least that is my current understanding of it, rick

>
> > I did the original post in part to see if others agreed that the server=
/replier
> > must wait until it sees a SEQUENCE with sa_highest_slot <=3D the
> > new sr_target_highest_slot on a slot where the new sr_target_highest_sl=
ot
> > has been sent in a previous reply to SEQUENCE. (Without this additional
> > requirement of "a slot where..." I think the SEQUENCE could be in an RP=
C
> > that was generated before the client/requestor saw the new
> > sr_target_highest_slot.
> >
> > I might post about this on nfsv4@ietf.org, but I do not know if it coul=
d
> > be changed as an errata?
>
> I'm not sure it's wrong, but it could perhaps be clarified if there is
> an ambiguity that leads to a flawed implementation. Adding informative
> text can be a slippery slope however, it can lead to new ambiguities.
> Either way, it's an IETF matter.
>
> Tom.
>
> >
> > Thanks for all the comments, rick
> >
> >
> >>
> >>>
> >>> Tom.
> >>>
> >>>
> >>>>>
> >>>>> Just fyi, does the Linux server do this, or do I have some time
> >>>>> to implement it?
> >>>>
> >>>> As far as I can tell, Linux NFSD does not yet implement
> >>>> CB_RECALL_SLOT.
> >>
> >> No, but according to RFC 8881 Section 17, CB_RECALL_SLOT is labelled a=
s
> >> REQuired to implement if the client ever creates a back channel. So
> >> other servers may expect it to be implemented.
> >>
> >>>>
> >>>>
> >>>>>> In the latter case, it is up to the client to send out enough
> >>>>>> SEQUENCE
> >>>>>> operations on the forward channel to implicitly acknowledges
> >>>>>> the change
> >>>>>> in slots using the sa_highestslot field (see RFC8881, Section
> >>>>>> 20.8.3).
> >>>>>>
> >>>>>> If the client was completely idle when it received the
> >>>>>> CB_RECALL_SLOT,
> >>>>>> it should only need to send out 1 extra SEQUENCE op, but if
> >>>>>> using RDMA,
> >>>>>> then it has to keep pounding out "RDMA send" messages until the
> >>>>>> RDMA
> >>>>>> credit count has been brought down too.
> >>
> >> --
> >> Trond Myklebust
> >> Linux NFS client maintainer, Hammerspace
> >> trond.myklebust@hammerspace.com
> >>
> >>
> >
>

