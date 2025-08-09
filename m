Return-Path: <linux-nfs+bounces-13535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41095B1F6D0
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 23:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F3017E596
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72DB1F0995;
	Sat,  9 Aug 2025 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6JlJV0G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6431EF36C
	for <linux-nfs@vger.kernel.org>; Sat,  9 Aug 2025 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754776163; cv=none; b=CMoPcyL09NHzCEfFKWAUXcB0EoGWuIp6NJ/0NXDpKj4ZDrsp4+XqwYoi3NinFPICRJx4aZ6Qny1abwJEdoxdMNQPoUCE5gFb5XC5c7IbpodF0Q3oOk3Cw4g7ZLO+JNoyXYBASDELLIB2HCDjedwmbi3T+8AWd7WC7Qpboe6P0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754776163; c=relaxed/simple;
	bh=3s+s5jZXp7+sQ4wMIB06M4OsbH3OAC4VIVLciUaQM/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgnKw0UKLIGKINeWxvuATNgSW12H5PohHBnpS0dIALgoAMj/ptqrHPnsEbepZphgLwALRvsadgbjNj1t22PYyWm3Yi9Cqu9u1LISrn3Z8AitqTQOjG036PEmLnjuLsXWbmPVNRPMKDN30n0EyinqwMUEvyLItZh3yt6kqE0QmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6JlJV0G; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af958127df5so487274466b.2
        for <linux-nfs@vger.kernel.org>; Sat, 09 Aug 2025 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754776160; x=1755380960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvIMDpu2zN5g2oRoi0l5nbArIbsRkaGUCdBnPURC2pI=;
        b=Q6JlJV0GLjXG+nPh9/nobXfRvYqbtRSILPTS++l7wqS/e8+UxKBiBNLQqZVxqLFs+b
         wCyLwnUkagC2+lvW/kFus0S0M2E2U/uecGXTMBh6svVqTpaDmSR7jcq7tCVr+b0WsAUE
         3bugHWiE4A6gaitA1VO0lGqYd7NuGdL9j9loXYs5vfyWJp//sB4aTL3TjhYEYNIoGDq8
         H/q9KQkw9R05RBZ9TUSnmmg7h5FrD8hVEQNWzQO9F/cXsmdfb1guYjdD3qLV4DC5eDyH
         Ks8Ijilw+sC0voaK9eMdmcVyT8ZG5hzUbC4BO+3KEZbwXaBMPGakqWrFSdaoceBuXM23
         890A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754776160; x=1755380960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvIMDpu2zN5g2oRoi0l5nbArIbsRkaGUCdBnPURC2pI=;
        b=t2C3LJlbRl4AyYUV0MslmJAtpZwGq54lGq2lAEB4rRgCN0VOzdkAsYqretGQ624iRB
         EI4gHcqWk0U/+FkQY4ZnWhRMWJRcEEvvufH2xW0KljW/DnEUSnlSPf0v8k46PaAm+jWw
         4/YYKvfPOUlSMqQHe0ahCshKGlowtnZuwhMzrpe91BhLMP0AA2D0cdtfnmJROpoqEpoO
         ZLIxZmvhr82vuVOpoqZktuJFHlbfwW34r2gnijCGEplsZlcTcSoPEqeK2vXrhzBHW5iT
         cNpYYN7FngJEzSqePei5D+agf2jn5RbtekK5taUD23LnQdD7lGZYOYndfrOKdG1/2lcM
         lbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVastUWt2ogaiJZNCfaJ6Ll2dgdNxxYn6lC6l0cI7jRaacioIN2sLfcyICZmvrxCCB+nNlrhhvHjy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrZyCNbyD6fC2JD8SCCNKVi/3mOaBioG+rUAKdPJ2eD7HjQt4
	JK987cuo0Wy3Lc2Ud5c6R1T09ZX/toe3/4cTk1XNMSXnp4QWTlWZLZq4mVw2+megr7a6cIJLquq
	yPhW6+dAgXSKqFhtYwbTJgg4TQGvRaQ==
X-Gm-Gg: ASbGncuMPPjVUxW5cAHwl9einTwam/ZoDD6bOY4FrVJqGH5Qui0klDbR0lLJKsik9xJ
	t8DS4LZ6tBsVcoE5DVa0gTp2vOdgVwWdwxBGm6OBz1tigN3CjoLoYHZfWw7e/O6uSX43W25vgkG
	KpqJjgRpdFwbVZy9Du5acEesDCnOJWeX/Azy39QvEgQ86V3TpoCw/tQVRifrMAU1BNJQ5d+2mTz
	25IvngznKv2ahPhEXC8ZAKA8bMsIlnk/jgjMVY=
X-Google-Smtp-Source: AGHT+IEBLIUhJN76tMfEFdV34jQVF+8FGQtZsGd7tYG1hkpzthb4aRZ/APJTm+dbUZUzq61faWjNlrZDvlSudrd3Bks=
X-Received: by 2002:a17:907:3e89:b0:af9:34a0:1b20 with SMTP id
 a640c23a62f3a-af9c63b09e9mr815496866b.5.1754776160046; Sat, 09 Aug 2025
 14:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4L1Smwc-H01AuKjNbtu9WMzWxJVRtuOjr0Fp_yLiZX7Q@mail.gmail.com>
 <CAABAsM5nzVzPDB3Ubeqg35F7Qd8pBveiYPi1M+KFnMPjb2dxXw@mail.gmail.com>
 <CAM5tNy7Aab8fQ58BghMBsWvs6Xc5U90q9gXWaKeEaZaqcs2Ltw@mail.gmail.com> <CADaq8jeAhdOLrD9Y6o1xJsMuGYZLoJdMAonfB5RuX63xV_i0UA@mail.gmail.com>
In-Reply-To: <CADaq8jeAhdOLrD9Y6o1xJsMuGYZLoJdMAonfB5RuX63xV_i0UA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 9 Aug 2025 14:49:08 -0700
X-Gm-Features: Ac12FXxpfRsCQBJxtDjCq6SjpVONxOO6ayl19g1RB0NNN1ioWl27HnQpbQ7rpgU
Message-ID: <CAM5tNy7RoMK7pSRcVnAVkREaJpNzxoHo-rsPQ5_X7AJk0fMM9g@mail.gmail.com>
Subject: Re: [nfsv4] Is NFSv4.2's clone_blksize per-file or per-file-system?
To: David Noveck <davenoveck@gmail.com>
Cc: Trond Myklebust <trondmy@gmail.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 1:12=E2=80=AFPM David Noveck <davenoveck@gmail.com> =
wrote:
>
>
>
> On Friday, August 8, 2025, Rick Macklem <rick.macklem@gmail.com> wrote:
>>
>> On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy@gmail.co=
m> wrote:
>> >
>> >
>> >
>> > On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
>> >>
>> >> Hi,
>> >>
>> >> I'm looking at RFC7862 and I cannot find where it
>> >> states if the clone_blksize attribute is per-file or
>> >> per-file-system.
>> >>
>> >> If it is not in the RFC, which do others think it is?
>
>
>  Before you told us about ZFS,  I would have assumed per-fs.
>
> Given the uncertainty in the spec, you may wind up dealing clients that a=
ssume it is per-fs.
Actually, it looks like the Linux client assumes per-server.
(I'm going to ask over on linux-nfs@ to see what the implications of
getting the value wrong are. All I can see is that remap_file_range will
return EINVAL if a request isn't aligned.
--> The NFSv4.2 server would also reply EINVAL if the alignment is not
      correct, I think? (Actually RFC7862 says it must be aligned, but fail=
s
      to specify the error reply for this case. However it specifies
NFS4ERR_INVAL
      for other cases, so I think it makes sense to return that.)

      Hopefully someone over on linux-nfs@ will know if returning NFS4ERR_I=
NVAL
      for CLONE from the NFSv4.2 server will be more serious than a return =
of
      EINVAL for remap_file_range. (Other than a wasted RPC roundtrip.)

rick

>
> Although this is not a  catastrophe, you might want to file an errata rep=
ort explaining the negative consequences of assuming this is per-fs. It won=
't get into a spec for a long while but it does provide as much warning as =
you can right now .
>
>
>
>>
>> >> (Or maybe, if you have implemented CLONE,
>> >> which does your implementation assume?)
>> >>
>> >> In case you are wondering why I am asking,
>> >> it turns out that files in a ZFS volume can have
>> >> different block sizes. (It can be changed after the
>> >> file system is created.)
>
>
> The guy who allowed that probably thinks it's a helpful feature.  Sigh!
>
>> >>
>
>
>>
>> >> Thanks, rick
>> >>
>> >
>> > Yes, but since ZFS only supports filesystem level snapshots, and not a=
ctual file cloning, does that matter to anything?
>> ZFS now has a feature it calls block cloning, which does clone file rang=
es.
>> (It was only added recently. I do not know if the Linux port uses it yet=
?)
>>
>> rick
>>
>> >
>> > Cheers
>> >   Trond
>>
>> _______________________________________________
>> nfsv4 mailing list -- nfsv4@ietf.org
>> To unsubscribe send an email to nfsv4-leave@ietf.org

