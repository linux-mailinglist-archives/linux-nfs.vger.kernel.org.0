Return-Path: <linux-nfs+bounces-11912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6107AC4091
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 15:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC181788C6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D215687D;
	Mon, 26 May 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmoJCWyR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBF146D6A
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266603; cv=none; b=d30WQGR8Oh3mxgPtac6uryixA6//X4XGslqVqnuOh53a0QVFHHvbkgAYqSeoDGYzTXF8nvBl+j2NfssatYn0BAgDEECsn+rNIItIqPZTbqIXyb0cgu7GnVo2YfwxwK2BuHGfZvqI4JaBRPP6by4ZlZLGF2fX4pEdHYxccffrVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266603; c=relaxed/simple;
	bh=IkozAPWCPAfnwCh+gx5Ai1poQH6h+loEYsP3DKIsfpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdtu0JJ/rNg0UTebN7aH3lRZjLljEr6XQlmcOo8RufqrFJCetWDDyhwRzczSJtFIb249VWVy29uSBD0OXWrDZxeM4ALUPgUwdv2fDYUh46dLTHSBIpsDwLN6XDGmcegRZqMaI5i1SPYhP2xXDa8I5wJP5J6CPighpjaJyTuheLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmoJCWyR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-602c4eae8d5so4414728a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266599; x=1748871399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0U/33VU0oIhAnm3EU9oTcxC9lCHuG2Fh8KwwnDgtNc=;
        b=hmoJCWyRyCw+v2TeuoW52PCGCDLSEr52PSw0XZo7zUJmX096U3uCEio4+dGkMAAPJJ
         JMqwJ1WnSqOyVAtz7M6zjnqQhx56sf7ujCXj70mIDhqezCmgA43RBncaY3uaA11I/IWS
         2p/M1Bo3b4viqojJv7HUCUGcZUPacMmXHjDzjUUk5eENWJrie92Eu8LYuK1z5BW555L2
         MI2SPPvP6IFlmAi5AskCGHn09++2+RdPvPy+d6UtebR6fdluIs8KMi49WZwsimHn1ES6
         /dPuiJRB8bg5BRd3jxLBlH6xLFzuOAwc2uTNQuo1X+0iLhQC952I+jcbGyZ1PySjQ6jh
         XV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266599; x=1748871399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0U/33VU0oIhAnm3EU9oTcxC9lCHuG2Fh8KwwnDgtNc=;
        b=VYxVJgVC8/2YTvx/1XqWNCP9Z+Uy8BJwr7Nl/5XeaZ6ElMdlduhJnDNzHtJWYpd0BB
         x/6lqVhdhnrKx2AI8dlCpiLSFNL/fNhJTUwG+yCcImPsd395ney9kLSZhxyuPOT5/tdR
         j+VC5+qKR/XQEt9pEi4/cCIDV44+unIG/7Pis81uR7kpZa+RF9RWn0uFp5Pw9sKgU732
         hBp9ogJKAML/4cZEvJVilGtBM49ZwXUfzcs7rgCiow9BZeTRJdQhco8mCkaTI8uceKOg
         BUmFQ3XdWZk6whi7bzh7IcBd+1ogIQGEzeRBKBl3KWR/3YLHDmHTJL8PZXukCabqIhzX
         PVtA==
X-Forwarded-Encrypted: i=1; AJvYcCWC4Px4nOQ1p59oQoXC3DdXMgdD+gH596FsIxKf2t0m+QTgedWN/2zF64Um8sQbUvLNhTRrwFyOVHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7okMl8wg+4heClOAryUlkMI20b1GGQ2aiugFkoBMcL/ei9zaU
	R9nGPY4taYBLOmO9mH6IrhJFB1Hb218jz1Y9Q4+yduenfafcbReSpuRV77i+i4amKyof13mGf1g
	u6T2ft4LuhKPiUYY6yxp92bplfdxAVw==
X-Gm-Gg: ASbGncsD6Nj1atISiPHdYIxgkfU8qWmv5cMOXp0jpGnnLE6b9LoPioXGdg3Gl2xGvBZ
	0fiLUO7dCaQYj8vsoSF36/2915Ch9VVOo22LqT4aZxF+KQ/0ejQ6rkiQc3ICYnGyDrt37gFmw4j
	d6pkECgnDWc4jp+gizuLWXbkaWhOgKmcGpcsGGSrr1z0t37Ra0SEO+yJfJal3aTBI=
X-Google-Smtp-Source: AGHT+IEJINICsDK9OUdB4ODfO5XNIs/bi3lFLWRqM9f94t6DRwP9utP1kea/Jzzk1S9Oa0TN5ImO57e/dcWo14BnGw4=
X-Received: by 2002:a05:6402:210b:b0:5fc:8c24:814d with SMTP id
 4fb4d7f45d1cf-602ce1ecbc1mr7493093a12.14.1748266599250; Mon, 26 May 2025
 06:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
 <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com> <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
In-Reply-To: <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 26 May 2025 06:36:26 -0700
X-Gm-Features: AX0GCFthEwOtNOMFZFBUm75sCf5Wq5Ru1KkMavKNEvU5mRHdMvOqyH1YVau3OLw
Message-ID: <CAM5tNy65G2jc15sVNFcb-6fEoB=Ei95uCftbx0Z9VevWeeBKFg@mail.gmail.com>
Subject: Re: Questions Regarding Delegation Claim Behavior
To: Petro Pavlov <petro.pavlov@vastdata.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Roi Azarzar <roi.azarzar@vastdata.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 4:10=E2=80=AFAM Petro Pavlov <petro.pavlov@vastdata=
.com> wrote:
>
> Hello Chuck,
>
> Thank you for your response, and apologies for the confusion regarding th=
e kernel version =E2=80=94 the correct version is 6.15.0-rc3+ (I believe it=
's from the branch you gave us). Regarding the client, I'm using hand-writt=
en tests based on pynfs.
>
> I believe the following section of the RFC may be relevant to the use of =
a delegation stateid in relation to the file being accessed:
>
> If the stateid type is not valid for the context in which the stateid app=
ears, return NFS4ERR_BAD_STATEID. Note that a stateid may be valid in gener=
al, as would be reported by the TEST_STATEID operation, but be invalid for =
a particular operation, as, for example, when a stateid that doesn't repres=
ent byte-range locks is passed to the non-from_open case of LOCK or to LOCK=
U, or when a stateid that does not represent an open is passed to CLOSE or =
OPEN_DOWNGRADE. In such cases, the server MUST return NFS4ERR_BAD_STATEID.
>
>
> I did some further investigation and identified another scenario that see=
ms problematic:
>
> Client1 creates file1 without a delegation, with read-write access. It wr=
ites some data, changes the file mode to 444, and then closes the file.
>
> Client2 opens file1 with read access, receives a read delegation (deleg1)=
, and closes the file without returning the delegation.
>
> Client2 then creates file2 with read-write access, receives a write deleg=
ation (deleg2), and leaves the file open (delegation is not returned).
>
> Client2 tries to open file1 with write access and receives an ACCESS_DENI=
ED error (expected).
>
> Next, Client2 attempts to open  file1  with write access using CLAIM_DELE=
GATE_CUR, providing the stateid from  deleg2  (which was issued for  file2)=
 =E2=80=94 unexpectedly, the operation succeeds.
>
> Client2 proceeds to write to file1, and it also succeeds =E2=80=94 despit=
e the file being set to 444, where no write access should be allowed.
>
> This behavior seems incorrect, as I would expect the write operation to f=
ail due to file permissions.
The behaviour is incorrect because the client is being malicious (or
buggy, if you prefer) (not playing by the rules).
Then the question becomes "How well should a server handle a client
that is not playing by the rules?".
Imho (I am not a Linux developer), the most that a server
implementation should strive for is to:
- Not crash.
- Avoid DOS attacks, if possible.
Other than that, malicious clients should be blocked via /etc/exports
or a firewall or ???

Just my $0.02 worth, rick

>
> Please see the attached PCAP file for reference.
>
> Best regards,
> Petro Pavlov
>
>
> On Fri, May 23, 2025 at 5:41=E2=80=AFPM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
>>
>> On 5/22/25 11:51 AM, Petro Pavlov wrote:
>> > Hello,
>> >
>> > My name is Petro Pavlov, I'm a developer at VAST.
>> >
>> > I have a few questions about the delegation claim behavior observed in
>> > the Linux kernel version 3.10.0-1160.118.1.el7.x86_64.
>> >
>> > I=E2=80=99ve written the following test case:
>> >
>> >  1. Client1 opens *file1* with a write delegation; the server grants
>> >     both the open and delegation (*delegation1*).
>>
>> Since you mention a write delegation, I'll assume you are using Linux
>> as an NFS client, and the server is not Linux, since that kernel version
>> does not implement server-side write delegation.
>>
>>
>> >  2. Client1 closes the open but does not return the delegation.
>> >  3. Client2 opens *file2* and also receives a write delegation
>> >     (*delegation2*).
>> >  4. Client1 then issues an open request with CLAIM_DELEGATE_CUR,
>> >     providing the filename from step 3 *(file2*), but using the
>> >     delegation stateid from step 1 (*delegation1*).
>>
>> Would that be a client bug?
>>
>>
>> >  5. The server begins a recall of *delegation2*, treating the request =
in
>> >     step 4 as a normal open rather than returning a BAD_STATEID error.
>>
>> That seems OK to me. The server has correctly noticed that the
>> client is opening file2, and delegation2 is associated with a
>> previous open of file2.
>>
>> A better place to seek an authoritative answer might be RFC 8881.
>>
>> The server returns BAD_STATEID if the stateid doesn't pass various
>> checks as outlined in Section 8.2. I don't see any text requiring the
>> server to report BAD_STATEID if delegate_stateid does not match the
>> component4 on a DELEGATE_CUR OPEN -- in fact, Table 19 says that
>> DELEGATE_CUR considers only the current file handle (the parent
>> directory) and the component4 argument.
>>
>>
>> > My understanding is that the server should have verified whether the
>> > delegation stateid provided actually belongs to the file being opened.
>> > Since it does not, I expected the server to return a BAD_STATEID error
>> > instead of proceeding with a standard open.
>> >
>> > From additional tests, it seems the server only checks whether the
>> > delegation stateid is valid (i.e., whether it was ever granted), but
>> > does not verify that it is associated with the correct file or client.
>> > Please see the attached PCAP for reference.
>> >
>> > Questions:
>> >
>> > Is this behavior considered a bug?
>> >
>> > Are there any known plans to address or fix this issue in future kerne=
l
>> > versions?
>>
>> AFAICT at the moment, NOTABUG
>>
>>
>> --
>> Chuck Lever

