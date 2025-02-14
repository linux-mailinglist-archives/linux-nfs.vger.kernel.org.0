Return-Path: <linux-nfs+bounces-10111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2AA354D3
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 03:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC5E3AC226
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED713B592;
	Fri, 14 Feb 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBrvhuwl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04460139D0A
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500792; cv=none; b=F1mL+4f2BtBnt/1MAZ+b1yLw7QTO/cux4NCsiFSDvIJULU3yk+yTIhkNRe8AE5jcD7NRkukb8L29bZ1QQ0cddC/7p7maV7JdbZWuaITOOIAB2B0nqjXHQcVtJnlmJ6sRK1w+dHE45ioK3QJARYVIwz5WHgB38QbjIMo9GAvpmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500792; c=relaxed/simple;
	bh=omHmFTa/ACvlVVV8JiNlSDPlqet4Fjy8kscG+telnq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6UHMPWSDz9I1MJO5c9KJixxRy8MB5eniSlSxenoM4xQbTSLx8d/zUj1CVpLS/IOMe4vU2yffAXAuexhlXc5ody9OnUN1vRhtYHm4pcH7SDmNn5lODb/MOj12gcbu9DtbRDJ7pu8S6BrzND+GdQuoNcth7X1ofLetquAiKXRihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBrvhuwl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so1113153a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 18:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739500788; x=1740105588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyxXirhc/H8VT3VKuENN7mXTF8a7304WHYSZzL5AyIY=;
        b=XBrvhuwlkBrALZs+4MqGM+d12amg2WUw8AJ/ZoOI3Qn9yfqOY04+2YsyqfXA4Cv6vi
         OdzGCD66S1AqtEfc2BbWBYZhkxU36kM7PaXvhlWwKBJ0hHjtic9MUzYHcE1l4XKH2Amp
         V5Bh7aRLDq0kU7lfw8GPFS9MFaw/s0yriYNgxLhcArVJ/t0OoJ5jCrTl/u3EN2KpX4QX
         JzTVV8hFCuBrxET7JcOJ71P5cnw/3AGdKp9j7hR5IFAduDnN0WVF4dPPs6vfbf8zqhVB
         6oZX+ZkjwMYR3WjifASNQaDGrN2FqSSN8kbkeJKQnv2m8NuTmhcoSKEeENFtm8iCaiB4
         7x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500788; x=1740105588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyxXirhc/H8VT3VKuENN7mXTF8a7304WHYSZzL5AyIY=;
        b=ukhneVySYrnQvZD9EH8vF6+pM4pn1jUZT6OuJi9Rig7ABZAmC/b2BKz0PvjNuSRkCW
         o58yZVoV0NwF941gYOSKBrrNakKhCPdtwSPVSITRhCndJrEFSPTGMS4+YA3dRKOlTqIw
         noxkCl+FmSTrddw+tgN4quWy0luXO2bzWxc/KW9hClD/pcXftunGoM7xr+IwifoTVF3R
         cb5qHG2uzWant/dQce8xKeawu5BAyWf5NHFnNIQWgfHZSX3ogBcrqXKi0frplWTV42B9
         t03yDLwoSqhy4ixIyw+R9dcrMvkosFylC8DEw1J3QWIasBk5jyos9X3DYgNy3OInhh/a
         EXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLZqfzIEUJ9WYoWW8gDuuU2hTFXctZrmuzkVs00sn+XpiZkVfHZD96UZTS+gA538W7Ohk9ZYphri8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEURp0u99L3wLUyeR/YoA98d0flgRxjYapFiuAbyPiwHPbQXT
	p477bPUBxMAZuCLhtM1k9O32GeqlwcEPwfRxzIg69VbureBmUDJ3d8qagKS7KKaWoBRE4VfcY49
	CIT83IMRUW1UJ0mULXgIF/szESw==
X-Gm-Gg: ASbGncuelYixbmPCNvVkhOOmzK8+HO7rL2RAJYRJquGg4v84uwK/kfu3WYC0IFlr4R0
	yLeP4Ak4sKHHlB+Qf6INuzLbtUE6JpqdwWUEJk/OiL5ed5ajSZezywpSuDQZwaMAO0YsbXJl61Y
	pJ/drkTWjDgm8TEGpWVdyGnTtGRS1NWQ==
X-Google-Smtp-Source: AGHT+IEtlEFrUbu2fe8zNj6vZQS8Yp/GgSizCv24+hhderHtYjPg6LsRI/E3J6AiCk3PcpEk0CMfBWPf9/gfDmFZ+R0=
X-Received: by 2002:a05:6402:2084:b0:5de:a7db:3a7c with SMTP id
 4fb4d7f45d1cf-5deaddba613mr9590425a12.17.1739500787750; Thu, 13 Feb 2025
 18:39:47 -0800 (PST)
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
 <CAM5tNy4wnvpinT58wOJtAObdadn-hffb5XqvTfmtFoG30sG7AA@mail.gmail.com>
 <d7c63c2e-460c-48c3-8eb5-48dbaeefd527@talpey.com> <CAM5tNy4tGm18OEHiFSjMXyqjutvuCfgaF9fOV6VD9gv+NSy_mA@mail.gmail.com>
 <b8b9fa85-5fc2-4f72-b382-6fd44a3aa422@talpey.com>
In-Reply-To: <b8b9fa85-5fc2-4f72-b382-6fd44a3aa422@talpey.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 13 Feb 2025 18:39:32 -0800
X-Gm-Features: AWEUYZn5x4LkqglbeX8BKiTsAf9w58Q6m4-EOWDvVFXjgoWEOY78oQh8LJ5ZhyU
Message-ID: <CAM5tNy7yWxwQ1Lw_7vSOhwmeEdBHGo7aPZRu4VYRaqp=6+hb7Q@mail.gmail.com>
Subject: Re: resizing slot tables for sessions
To: Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:59=E2=80=AFPM Tom Talpey <tom@talpey.com> wrote:
>
> On 2/13/2025 7:55 PM, Rick Macklem wrote:
> > On Tue, Feb 11, 2025 at 11:05=E2=80=AFAM Tom Talpey <tom@talpey.com> wr=
ote:
> >>
> >> On 2/11/2025 7:26 AM, Rick Macklem wrote:
> >>> On Mon, Feb 10, 2025 at 11:11=E2=80=AFAM Trond Myklebust
> >>> <trondmy@hammerspace.com> wrote:
> >>>>
> >>>> On Mon, 2025-02-10 at 13:07 -0500, Tom Talpey wrote:
> >>>>> On 2/10/2025 8:52 AM, Chuck Lever wrote:
> >>>>>> On 2/9/25 8:34 PM, Rick Macklem wrote:
> >>>>>>> On Sun, Feb 9, 2025 at 3:34=E2=80=AFPM Trond Myklebust
> >>>>>>> <trondmy@hammerspace.com> wrote:
> >>>>>>>>
> >>>>>>>> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>> I thought I'd post here instead of nfsv4@ietf.org since I
> >>>>>>>>> think the Linux server has been implementing this recently.
> >>>>>>>>>
> >>>>>>>>> I am not interested in making the FreeBSD NFSv4.1/4.2
> >>>>>>>>> server dynamically resize slot tables in sessions, but I do
> >>>>>>>>> want to make sure the FreeBSD handles this case correctly.
> >>>>>>>>>
> >>>>>>>>> Here is what I believe is supposed to be done:
> >>>>>>>>> For growing the slot table...
> >>>>>>>>> - Server/replier sends SEQUENCE replies with both
> >>>>>>>>>       sr_highest_slot and sr_target_highest_slot set to a
> >>>>>>>>> larger value.
> >>>>>>>>> --> The client can then use those slots with
> >>>>>>>>>          sa_sequenceid set to 1 for the first SEQUENCE
> >>>>>>>>> operation on
> >>>>>>>>>          each of them.
> >>>>>>>>>
> >>>>>>>>> For shrinking the slot table...
> >>>>>>>>> - Server/replier sends SEQUENCE replies with a smaller
> >>>>>>>>>      value for sr_target_highest_slot.
> >>>>>>>>>      - The server/replier waits for the client to do a SEQUENCE
> >>>>>>>>>         operation on one of the slot(s) where the server has
> >>>>>>>>> replied
> >>>>>>>>>         with the smaller value for sr_target_highest_slot with
> >>>>>>>>> a
> >>>>>>>>>         sa_highest_slot value <=3D to the new smaller
> >>>>>>>>>          sr_target_highest_slot
> >>>>>>>>>         - Once this happens, the server/replier can set
> >>>>>>>>> sr_highest_slot
> >>>>>>>>>            to the lower value of sr_target_highest_slot and
> >>>>>>>>> throw the
> >>>>>>>>>             slot table entries above that value away.
> >>>>>>>>> --> Once the client sees a reply with sr_target_highest_slot
> >>>>>>>>> set
> >>>>>>>>>          to the lower value, it should not do any additional
> >>>>>>>>> SEQUENCE
> >>>>>>>>>          operations with a sa_slotid > sr_target_highest_slot
> >>>>>>>>>
> >>>>>>>>> Does the above sound correct?
> >>>>>>>>
> >>>>>>>> The above captures the case where the server is adjusting using
> >>>>>>>> OP_SEQUENCE. However there is another potential mode where the
> >>>>>>>> server
> >>>>>>>> sends out a CB_RECALL_SLOT.
> >>>>>>> Ouch. I completely forgot about this one and I'll admit the
> >>>>>>> FreeBSD client
> >>>>>>> doesn't have it implemented.
> > Btw, I just coded this for the FreeBSD client and used a fake server
> > to test it. I found that wireshark doesn't know how to decode the
> > argument for CB_RECALL_SLOT, which is another hint that it is
> > not being used. (It will take a while to get into releases.)
> >
> > I, personally, think CB_RECALL_SLOT is pretty useless, since it can onl=
y be used
> > for sessions with backchannels (no sessionid argument).
>
> The primary reason for it is for managing RDMA credit resources used by
> idle clients. If the client is sending no traffic, there are no
> opportunities for the server to send back target slot changes. Since
> RDMA credits consume significant memory and RDMA NIC-based resources,
> releasing these, or sharing them more usefully without just closing
> connections, becomes a big win.
I'll take your word on this. I know nothing about RDMA and FreeBSD's NFS
doesn't support RDMA channels.

>
>
> >>>>>
> >>>>> The client is free to refuse to return slots, but the penalty may b=
e
> >>>>> a forcible session disconnect.
> >>>>>
> >>>>> I agree you've captured the basics of the graceful-reduction
> >>>>> scenario,
> >>>>> but I do wonder if nconnect > 1 might impact the termination
> >>>>> condition.
> >>>>>
> >>>>> Because nconnect may impact the ordering of request arrival at the
> >>>>> server, it may be possible to have a timing window where one
> >>>>> connection
> >>>>> may signal a reduction while another connection's request is still
> >>>>> outstanding?
> >>>>
> >>>> Not if the client is doing it right. It doesn't really matter which
> >>>> connections were used, because the client is telling the server that=
 "I
> >>>> have now received all the replies I'm expecting from those slots".
> >>>>
> >>>> IOW: the client is supposed to wait to update the value of
> >>>> sa_highest_slot in OP_SEQUENCE until it has actually received replie=
s
> >>>> for all RPC requests that were sent on the slot(s) being retired.
> >>>> It shouldn't matter if there are duplicate requests or replies
> >>>> outstanding since the client is expected to ignore those (and so the
> >>>> server is indeed free to return NFS4ERR_BADSLOT if it has dropped th=
e
> >>>> cached reply).
> >>>>
> >>>> Now there is a danger if the server starts increasing the value of
> >>>> sr_target_highest_slot before the client is done retiring slots. So
> >>>> don't do that...
> >>> Well, I think both you and Tom are correct, in a sense...
> >>> Here is what RFC8881, sec. 2.10.6.1 says:
> >>>
> >>>        The replier SHOULD retain the slots it wants to retire until t=
he
> >>>         requester sends a request with a highest_slotid less than or =
equal
> >>>         to the replier's new enforced highest_slotid.
> >>>
> >>> I think the above is at least misleading and maybe outright incorrect=
.
> >>> So, if the above were considered "correctly done", I think Tom is rig=
ht.
> >>
> >> I think both Trond and I are right. :) In any event we're not disagree=
ing,
> >> it's just thaty the client implementation needs to be careful.
> >> If there are multiple forechannels, they all need to be taken
> >> into consideration. The server doesn't have any protocol-specific
> >> guarantee that the client has done so. Therefore it's on the client.
> > All the client needs to do is not use the slots above the new target_hi=
ghest.
>
> Pretty much, yes.
>
> > To me, it is the server that needs to be careful to not throw away the =
slots
> > above target_highest before any RPCs issued by the client before the
> > target_highest was lowered might still be in flight.
>
> Also correct. The slots can be retired (and freed by the server) when
> the client reduces its slot highwater.
True, but the server does have to be careful w.r.t. temporal ordering
(or it must ensure that the SEQUENCE request with a small enough
slot highwater was generated on the client after the client processed
the target highwater
in a SEQUENCE reply).

For the SEQUENCE case:
- It must see the small enough high water on a slot where the server
   had sent the new target highwater in a prior reply.
For the CB_RECALL_SLOT case:
- It must see the small enough high water on a slot where the server
   had sent a reply on the slot after receiving the NFS_OK reply to the
   CB_RECALL_SLOT.

rick

>
> Tom.
> >
> > At least that is my current understanding of it, rick
> >
> >>
> >>> I did the original post in part to see if others agreed that the serv=
er/replier
> >>> must wait until it sees a SEQUENCE with sa_highest_slot <=3D the
> >>> new sr_target_highest_slot on a slot where the new sr_target_highest_=
slot
> >>> has been sent in a previous reply to SEQUENCE. (Without this addition=
al
> >>> requirement of "a slot where..." I think the SEQUENCE could be in an =
RPC
> >>> that was generated before the client/requestor saw the new
> >>> sr_target_highest_slot.
> >>>
> >>> I might post about this on nfsv4@ietf.org, but I do not know if it co=
uld
> >>> be changed as an errata?
> >>
> >> I'm not sure it's wrong, but it could perhaps be clarified if there is
> >> an ambiguity that leads to a flawed implementation. Adding informative
> >> text can be a slippery slope however, it can lead to new ambiguities.
> >> Either way, it's an IETF matter.
> >>
> >> Tom.
> >>
> >>>
> >>> Thanks for all the comments, rick
> >>>
> >>>
> >>>>
> >>>>>
> >>>>> Tom.
> >>>>>
> >>>>>
> >>>>>>>
> >>>>>>> Just fyi, does the Linux server do this, or do I have some time
> >>>>>>> to implement it?
> >>>>>>
> >>>>>> As far as I can tell, Linux NFSD does not yet implement
> >>>>>> CB_RECALL_SLOT.
> >>>>
> >>>> No, but according to RFC 8881 Section 17, CB_RECALL_SLOT is labelled=
 as
> >>>> REQuired to implement if the client ever creates a back channel. So
> >>>> other servers may expect it to be implemented.
> >>>>
> >>>>>>
> >>>>>>
> >>>>>>>> In the latter case, it is up to the client to send out enough
> >>>>>>>> SEQUENCE
> >>>>>>>> operations on the forward channel to implicitly acknowledges
> >>>>>>>> the change
> >>>>>>>> in slots using the sa_highestslot field (see RFC8881, Section
> >>>>>>>> 20.8.3).
> >>>>>>>>
> >>>>>>>> If the client was completely idle when it received the
> >>>>>>>> CB_RECALL_SLOT,
> >>>>>>>> it should only need to send out 1 extra SEQUENCE op, but if
> >>>>>>>> using RDMA,
> >>>>>>>> then it has to keep pounding out "RDMA send" messages until the
> >>>>>>>> RDMA
> >>>>>>>> credit count has been brought down too.
> >>>>
> >>>> --
> >>>> Trond Myklebust
> >>>> Linux NFS client maintainer, Hammerspace
> >>>> trond.myklebust@hammerspace.com
> >>>>
> >>>>
> >>>
> >>
> >
>

