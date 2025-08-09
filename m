Return-Path: <linux-nfs+bounces-13524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA135B1F201
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC963A4B17
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA578F4C;
	Sat,  9 Aug 2025 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI1Plh32"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F475AD51
	for <linux-nfs@vger.kernel.org>; Sat,  9 Aug 2025 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754711218; cv=none; b=qsSPMxx2iK95hLXXOfkxkxRPniZuvp1DAtblTTgJnfMIkwB5aG7JUpoxyl5pm57jbNvti43WjFUZt7NNkDlFCJcpG2zil3KMiqQNRTuwmay5NGBCNbHg/nep8EIKhCcV5v2RZF19CQhy4FMF1yxislE23/Kqh0Z2WA6Hfqr94Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754711218; c=relaxed/simple;
	bh=SuqSwyajU+RcqvmgM5RhyKFSgDxQig0LOwixTmaYtik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpSWOY03ialyDKlxvtinwWksj0ltyMbyn4RU5Bsx9LkZ3ULtT0qDKq6Xv8GJJFmu183FSw3bMNZELMM5sjAYtDrncTd94QoS7lLunkSyu9YbrwN8YYzcuAr6PtJnelTTnL73grVm5Lk01cjb9Lfdcb2sYXD2uaZtxUHDJ/gN+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI1Plh32; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af91a6b7a06so482540766b.2
        for <linux-nfs@vger.kernel.org>; Fri, 08 Aug 2025 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754711215; x=1755316015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIb9AGHJZZ+eUw4y4CQAxPduzvvsjZCr0X9+gqRz3BA=;
        b=HI1Plh32Sfw75jGESwQGv2Nd59h7I/jSykGpq1uSib/SIqcL5R5LF7Eby3Wp8xHdqu
         kVPcuGNxyZeeyk42cJevjCVPbG8JaLW1EhN4/Zr38cbKlyWTrElqjei+t6dDU+XHGIWI
         FtPgX7ljqw2MUcXac30yTPUr8TCn0YMifuezJ0lBD7cZ/RFPKmvRfdz53JDkbnfNkwNY
         B/WJN3tQhxothoHQXbiPD6oJlCR6UKaA0z+kAfuRMBPi8VxbfXcDSJm3t37bh6xo63DJ
         Q4tW6R+vlthCxkWjUoI+byVlHWFGdmpEpeLx3uO1urSLkg+RyOUKQSETNBMztxUfprlC
         or+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754711215; x=1755316015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIb9AGHJZZ+eUw4y4CQAxPduzvvsjZCr0X9+gqRz3BA=;
        b=ZzTpN2FyJA1UWMazVpeybbZALJtNvaaPMEd9ALJ1V6LG2HRk2pZIsjQvDl9lOo57kU
         IXn9Cy2One8vQc1BLfxOlKYBLDE45r8XKawO0K70SY0iq7Kt/VyAb/EE1ejnrzDMoIBG
         38FDMz7zYxn0vtkQjI1HLI7YJSaZ0HOkPqvgJZwIIosCAPwNe1CT6AViFd8zPe7AawJ3
         d5ufcygdCd+vJoK65XbfpAekmYC3/FOxVTWiqYp57CrLK/NplFr6VH1yiSFV9OebLDNv
         EMDHgOHowQ5OgRQbLKOrcoe9a39SmaYBva9bgCWoNhi6Dw7uxeEM4d073hd33Tq5NpGr
         0zhw==
X-Forwarded-Encrypted: i=1; AJvYcCUtYIXemdq4OZro6/Fhb7yp7TnCHhKBOsM2oBDAJlG7gJapaHXONzAY2atg5LjDAdspQ8dBtwQSoP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4506jyhc7KUeiQrOI90Ag7ppfCYpPKu4VOUGrohGpXeMmySS
	0PnSmGH4YzH1F2tZuZaHlL1d5W9N8lZnSfEULC3CyF9I1BUbG1MwZ6BSCY6zybNZgAVFE0rGdTl
	7DNUCLis2S8qewEyms5zhBH3wYJv3wg==
X-Gm-Gg: ASbGncvEUXi/vu5BG6ow+u3T8hMZ8sY6rHW5eCdc7jH4pUM5MV86wNgmBndX/pPx/8c
	mzvCDQHt5FB9KDd9B7USVrdNtD5ROiZzI7UMESElBLHvPGPMx3sk5GJyrcRkHPs+GxqayBebEaC
	+hrfYHEDy3nqUy6a0JX9p40MwiEcI9aU4HDYDTbN9HWPVIMwfQmMkIH070IiKIex8q6SZePjYMG
	EXyXA1QdxVmPbgxMze0CNeUP3CHLJHkpbxnJs4=
X-Google-Smtp-Source: AGHT+IGxmBWWeKkRLp9wiCuzbvnPGDPyvcv2rrXt5mndRESHW27kacDZYzdGonslMFDQM2NRJhbUl/ylalZM9dyhYWI=
X-Received: by 2002:a17:907:7fa0:b0:af9:adc8:66e3 with SMTP id
 a640c23a62f3a-af9c6525420mr451387366b.60.1754711214487; Fri, 08 Aug 2025
 20:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4L1Smwc-H01AuKjNbtu9WMzWxJVRtuOjr0Fp_yLiZX7Q@mail.gmail.com>
 <CAABAsM5nzVzPDB3Ubeqg35F7Qd8pBveiYPi1M+KFnMPjb2dxXw@mail.gmail.com>
In-Reply-To: <CAABAsM5nzVzPDB3Ubeqg35F7Qd8pBveiYPi1M+KFnMPjb2dxXw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 8 Aug 2025 20:46:43 -0700
X-Gm-Features: Ac12FXz9Qu9tKj9OazQy3WKApAhCWEkFHWuMPxu2QUWNgPxuQ3ffWM4f7dweuiw
Message-ID: <CAM5tNy7Aab8fQ58BghMBsWvs6Xc5U90q9gXWaKeEaZaqcs2Ltw@mail.gmail.com>
Subject: Re: Is NFSv4.2's clone_blksize per-file or per-file-system?
To: Trond Myklebust <trondmy@gmail.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy@gmail.com> =
wrote:
>
>
>
> On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.macklem@gmail.c=
om> wrote:
>>
>> Hi,
>>
>> I'm looking at RFC7862 and I cannot find where it
>> states if the clone_blksize attribute is per-file or
>> per-file-system.
>>
>> If it is not in the RFC, which do others think it is?
>> (Or maybe, if you have implemented CLONE,
>> which does your implementation assume?)
>>
>> In case you are wondering why I am asking,
>> it turns out that files in a ZFS volume can have
>> different block sizes. (It can be changed after the
>> file system is created.)
>>
>> Thanks, rick
>>
>
> Yes, but since ZFS only supports filesystem level snapshots, and not actu=
al file cloning, does that matter to anything?
ZFS now has a feature it calls block cloning, which does clone file ranges.
(It was only added recently. I do not know if the Linux port uses it yet?)

rick

>
> Cheers
>   Trond

