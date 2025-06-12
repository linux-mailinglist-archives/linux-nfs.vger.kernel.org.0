Return-Path: <linux-nfs+bounces-12383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCC6AD77FF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204B618868FD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782B078F5D;
	Thu, 12 Jun 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbVVM6US"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76279221DA8
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744675; cv=none; b=t2gI1wTRVa71WlVPl+tevY1xvV8Gz7/Mc/ot1UuTOsMRTDZxmKXxr10DNrnFiOEJsv1SFJ25911WzqTMj9Ob15Oo0K547Pkp2SxZL96wJuvxhHRgtKjU2TdqOxM+hf8NzGwYM7LiPPOOM+3kagBqT63qtko5OmN2/uGsbgWvPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744675; c=relaxed/simple;
	bh=MqSW3poH6ixwDfb3GGJt0X6IcUbuMGVKEP74atM305w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/oGnP8X7rIzR2Wzod4WshiZHOAi5x9QIHj7ZzXIoau9QI06aCDsSS5wG0PjmLU099dXG7WgFMxRI51wCavWFb8TSKRiVywkLHXrCFdaMTINuLKvg8ttghUlEyS9kxSB5khllzmTqa5d9MFRu0XUydk6mZDeJUrBD8lSV3bF5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbVVM6US; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so2468467a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749744672; x=1750349472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nJd6v0a81vK3E7TC4EXwB6evZA/h2yZlatGVgkByac=;
        b=mbVVM6USSdwntafwpWvtvsObNZwN0Aaq3sFSmnDWgdKvBqSrgZLPjykvyy+DX+AjwB
         owwqd5DCHpkKbi6QTumoNw0uVryO2tZ+x6vxOatyU31+iiWKkLqZJ3XCujgqmhi25u5e
         vs5XsZQAqIgYbjlTU2wSTwHIlvY5LjfHBqorC4QjPoKX1tPhZlQpnCX8QPcpgBXRtVSf
         ErdwbSSl5B20PrL1eM1d+Jcil9Rn6P/3RFY7i5Eqwb2REglpBVHn8+GAIZDJy0OoEBX8
         rNHJOkQCrWobC4h/GkE5WYE9SuuN4t3J3JEc6/yJ4l7oGXf/uBolhHRfD5lCEA+dHhYP
         Gykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744672; x=1750349472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nJd6v0a81vK3E7TC4EXwB6evZA/h2yZlatGVgkByac=;
        b=l0mq5/MCvcHNpR2I4jjRDXAaZdadXJ7A3vA6BEyk7UIB5odi0wdOgVnzx4rSj4dD+7
         TLyPHxpc8uiYzTGqnmJi5Mh4qAwixj9REtaiE0kyLW1QsZD0f9QqXW1IsykKJ2/kpqrP
         WQ5YF3WH7TX2kaylHXuea5Ly9csDSMprxU2AuLKhVve1ai0I/cvr0XhF80JMEW0Dh9XG
         OEoKp0zE2mhpt22MdOXgW2b4z1/2IYkArNGCwJtFeoBlSN+Twzlxwa0pvY4vx5KH1y2W
         B1kng2N6/5R0q9pOD6fQRYCiKcE5kOIdHgP+OrmpE9/tDmrJnfcwOoA60eiSy4NW+gzA
         FQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwa495srhIGTC6NF4gfPL1HW2DHxnrMyt18Wb391s1bNsALGEJYfn96BpH3tJRcBnBerYPliLMfek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrUqcN0Vvvq8rKXfoyZqDAHnA+rWaN2GuHPymeFjSpuz/EKBY
	JHy8tKrxRw4PfdRGkkPIlCLgqJF+j6Wf41vzg8D+Bveew1LfMEmBI611meKDVIYlexeni+XfLtf
	YEgEuboIYZ9wLstWg+5MGhbrowAG4EA==
X-Gm-Gg: ASbGncsqiTLCe/K3StOlqfm+DwUhWjZeBY/DdglEL0mYxP685pVaY931TkL9j9IXZOj
	FwxvzHrxQs2K9xdvV1WeeyJMAK1BYtCJ1ss/ZnTNGu4mQo3uNNPWiIQvwC2JwuB3ujrC1uxr8rg
	eJE/1dg3HA/uMwbAaUdzJVKNNoAstBr1oIOudL7zjbQWwKq42mv+2PncD/o8UDmD9smzs0zHWVy
	icdqOToaFqFOQ==
X-Google-Smtp-Source: AGHT+IGHzgQu7WOGswPAzLHCiKpDBILB5+ix0JbZ9bhEwlfZwCueDgsYHPpVAW3VMlv0FDofgJ6VH40AoM6Pj9e1Txo=
X-Received: by 2002:a17:907:7ba7:b0:ade:43e8:8fa1 with SMTP id
 a640c23a62f3a-adec1a67e21mr37684966b.39.1749744671273; Thu, 12 Jun 2025
 09:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <CADaq8jd1gH1-f3Dqg+mAV2RTEwqVS-C21Be4QJT24+bNTuycYA@mail.gmail.com>
 <CAM5tNy5MUCAXs_4zWy33xqOJSMk1hW5006OpLoD32KWLbOfNLQ@mail.gmail.com> <CADaq8jdA7UBe4CxsAWVBzfqwpFhNSGnkdga9tyzwMEAXAa_pCw@mail.gmail.com>
In-Reply-To: <CADaq8jdA7UBe4CxsAWVBzfqwpFhNSGnkdga9tyzwMEAXAa_pCw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 12 Jun 2025 09:10:58 -0700
X-Gm-Features: AX0GCFtygbezjsNeYBj7KnseEhhNEBpIQ-Vm11P_xUj8i0-L4ar4xeebCTMZ8HY
Message-ID: <CAM5tNy4sUR3TseB5g8Ce3T1-hVLOhvBAKhnbeVxv-WK5Ztue9g@mail.gmail.com>
Subject: Re: [nfsv4] simple NFSv4.1/4.2 test of remove while holding a delegation
To: David Noveck <davenoveck@gmail.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:59=E2=80=AFAM David Noveck <davenoveck@gmail.com>=
 wrote:
>
>
>
> On Wed, Jun 11, 2025, 4:58=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>>
>> On Wed, Jun 11, 2025 at 9:28=E2=80=AFAM David Noveck <davenoveck@gmail.c=
om> wrote:
>> >
>> >
>> >
>> > On Mon, Jun 9, 2025, 7:35=E2=80=AFPM Rick Macklem <rick.macklem@gmail.=
com> wrote:
>> >>
>> >> Hi,
>> >>
>> >> I hope you don't mind a cross-post, but I thought both groups
>> >> might find this interesting...
>> >
>> >
>> > I find it interesting, but I can't speak.for either group.
>> >>
>> >>
>> >> I have been creating a compound RPC that does REMOVE and
>> >> then tries to determine if the file object has been removed and
>> >> I was surprised to see quite different results from the Linux knfsd
>> >> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
>> >> provide FH4_PERSISTENT file handles, although I suppose I
>> >> should check that?
>> >>
>> >> First, the test OPEN/CREATEs a regular file called "foo" (only one
>> >> hard link) and acquires a write delegation for it.
>> >> Then a compound does the following:
>> >> ...
>> >> REMOVE foo
>> >> PUTFH fh for foo
>> >> GETATTR
>> >>
>> >> For the Solaris 11.4 server, the server CB_RECALLs the
>> >> delegation and then replies NFS4ERR_STALE for the PUTFH above.
>> >> (The FreeBSD server currently does the same.)
>> >>
>> >> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
>> >> with nlinks =3D=3D 0 in the GETATTR reply.
>> >>
>> >> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
>> >> probably missed something) and I cannot find anything that states
>> >> either of the above behaviours is incorrect.
>> >> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
>> >> description of PUTFH only says that it sets the CFH to the fh arg.
>> >> It does not say anything w.r.t. the fh arg. needing to be for a file
>> >> that still exists.) Neither of these servers sets
>> >> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>> >>
>> >> So, it looks like "file object no longer exists" is indicated either
>> >> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
>> >> OR
>> >> by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply=
.
>> >>
>> >> To be honest, I kinda like the Linux knfsd version, but I am wonderin=
g
>> >> if others think that both of these replies is correct?
>> >
>> >
>> > I think they are both correct.  It seems to me that an attempt to choo=
se one of these as preferred and deprecating the other should be rejected s=
ince it unjustiably imposes a particular design choice on the server.
>> >>
>> >>
>> >> Also, is the CB_RECALL needed when the delegation is held by
>> >> the same client as the one doing the REMOVE?
>> >
>> >
>> > I think so.
>> From a practical point of view, I am not convinced it is needed.
>
>
> I see your point. The problem is in clearly explaining when it is not nee=
ded.
>
>> The server can determine if the REMOVE actually deleted the
>> file and, if it did, can throw away any delegation record(s) for the
>> file object.
>> The client knows it has a delegation and can either DELEGRETURN
>> it or throw it away if it knows the file object has been deleted and the
>> associated file handle is no longer valid (it receives a NFS4ERR_STALE
>> from the server for it).
>
>
> That case can be dealt with by stating that delegations associated with i=
nvalid fh's can be considered effectively obliterated without being returne=
d.
>
> The troublesome case is for servers that do not invalidate the fh.  They =
are still able to do a DELEGRETURN, so it would have to be separately state=
d that if it is done after removal it MAY fail that and, if it does, the cl=
ient can forget it
>
> I don't want to get into a situation in which client have to check the va=
lidity of the fh after the remove.
Given that the NFSv4.1/4.2 server might not recall the delegation,
I think the client has options for handling the case where it holds
a delegation for the file object it is doing a REMOVE of.
Here's three possibilities I can think of:
1 - Do the write flush and DELEGRETURN before REMOVE.
     (This is what the three extant clients I have for testing do.)
2 - Do the write flush and DELEGRETURN asynchronously after
     REMOVE, accepting that the write flush or DELEGRETURN
     may fail with NFS4ERR_STALE. (Having it fail with NFS4ERR_STALE
     is fine and reduces overhead.)
3 - Do a PUTFH and GETATTR numlinks after the REMOVE.
     if either of these fail with NFS4ERR_STALE
          - The client can discard dirty buffers/pages and the delegation
     else if numlinks > 0
          - Do nothing. The delegation is still valid.
     else
          - Do #2.
So, only #3 tries to check after the remove, but is really just an
optimization of #2.

rick
>>
>>
>> Also, wearing my pragmatic practitioner's hat, since the Linux knfsd
>> does not do a CB_RECALL now and has shipped this way to who
>> knows how many users, declaring that it must be CB_RECALL'd
>> does not seem useful?
>
>
> I think MUST would be wrong.  The trouble is that SHOULD would also be wr=
ong.  Stay tuned.
>>
>>
>> rick
>>
>> >
>> >> (I don't think it is, but there is a discussion in 18.25.4 which says
>> >> "When the determination above cannot be made definitively because
>> >> delegations are being held, they MUST be recalled.." but everything
>> >> above that is a may/MAY, so it is not obvious to me if a server reall=
y
>> >> needs to case?)
>> >
>> >
>> > This should be more clear.  Will be looking at a possible change in th=
e next rfc5661bis draft.
>
>
> Those changes need to be acceptable to pragmatic practitioners such as yo=
u but should be clear enough to helpbthose who are not looking at an existi=
ng implementation.
>
>> >>
>> >>
>> >> Any comments? Thanks, rick
>> >> ps: I am amazed when I learn these things about NFSv4.n after all
>> >>       these years.
>> >>
>> >> _______________________________________________
>> >> nfsv4 mailing list -- nfsv4@ietf.org
>> >> To unsubscribe send an email to nfsv4-leave@ietf.org

