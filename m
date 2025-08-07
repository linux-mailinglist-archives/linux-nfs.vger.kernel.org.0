Return-Path: <linux-nfs+bounces-13476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC859B1DB79
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68EE7A201E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0C26FD9F;
	Thu,  7 Aug 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig09r9Xj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAE26E71E
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583311; cv=none; b=G79ERsR5NdDD9xNNJEqqeZWaVHOTeo5ZXm/DgkpMu8MojehF6vpdmVcu3faY6wzkmQmh/GNKhNZiueS6VYJoq/MImqNOypkiLcra+VymlZPlCbMii9VWGPAErNL4l+MTLe8NxcKtXWgUBQYxNcuUvimMrJK6n/hFPrWkl/iot74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583311; c=relaxed/simple;
	bh=5jStWWCjaP0JV4+FcpprNQXMf0EfrFjzCaVhf4bzd4M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FGo4Egf4Vd/McoVzyCQOnNXYgEw65q7umnw6gVxbw5slVACJjwrKg9awXGPS10/yP9lYXYeBlx9pq3Jjo1JthLLnuHm8pEJZKwu2kUgXz8wCTHfNONYUiYwxexSwzVc7XCXeI5dr1cR2cT09jNXT5pE1ZsofUvcPEd68wAoPCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig09r9Xj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4aeb2e06b82so6554471cf.2
        for <linux-nfs@vger.kernel.org>; Thu, 07 Aug 2025 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754583309; x=1755188109; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WF6nBEqiFr25e1JDP4OVyxkoh94QRguP3Taix+F8VOs=;
        b=ig09r9XjE2ru8ydRdV5bsxOB3M8e6HStZN0uSNO2EU+RaNc/dekeLaXzTYsgbrtJMX
         /1lQbmlpAaWz/QAn4DRB2rxqyOSnS7krBS1iq72nPYHtwO3nQUApjLfQS8OapWFoNpAr
         TOZGxv8miFsaFFuCxN0+r9+/n8KOnqU5z89zotUhZ2fa2TX73Jp08tAFHQUVPGYA87SM
         /JHsAppn/eEVzpY0hUynWGTxwyGnrOBZ/XrJF3Jud7LbXsoHXLBxC8chtv2hmxi8z4bW
         Jv7vFPzuT5tb4TzWfpLY79iB6dDrnDYaWgM1t+ZIzqCnwm2W84VjKJMfX5Gc4ZBeQiHV
         Y8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754583309; x=1755188109;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WF6nBEqiFr25e1JDP4OVyxkoh94QRguP3Taix+F8VOs=;
        b=F2tVxxQNVEAGh8C+1kNnTwrXqiyNoCFT+nZvFxYlsokht8MAp67c9ovUhc+DNo+1kG
         U2yrdgS1Dv7shHC2X+lZr0TSNB87C8DUdILD7MovCjp2Liq4LthdfRQyqvRiw+EmILJT
         Wimj5qa8lPrXcKgvIRcg2EJaHEVfgHJ7/5ec32VfL0SxFEcY+pvLl0NVMLV13V5S4qGY
         jGkJosXjNYj8DhQ3e+JMYmk4xg6AHnzXZ1w69Ta4OfhSmRC2eiEnUPww/I3eFAVMRMwA
         31aNI9rh/QPHh0nIqZJPj1s5NcOuDPte5MgWR0cShhbgiACCFvLAccRqKhzfB6ViEiof
         OwIQ==
X-Gm-Message-State: AOJu0Yxs8Iexpi78eFoFsAmuB7hh4AqezEvFrZs/pO0JQruiZUdWQBZX
	NLFNVCsxFE+b4Xmcjl6V0N94ZKdfHc/umsPdHjrFKvurIKhKOSnbWIRFoiSJC+Pl+5yByRFQXOo
	bCf+5MaPd8HD3QfhDSyXWhD31WNaih1wD3cDA
X-Gm-Gg: ASbGncvqd1rUrD1cxgWU8SvDrMI0o+bBCN61kDbE0506qTkEMOiHMzbHfqHYmKYbes0
	r3YMPLDQP9iPBmdd/JtbAlVThVs0UhO9sAN4T5UJ3x8GzuPme2REb76RS0t//4LIUPb/eD7+7Xw
	XklwS1j+9yZwTANWrmYwwUO73TG1Qaqimivlopf8TyxYFaza7WE/DWWqNm4N97M19tJboCQutPi
	A38zBvahIJh3d/emLs=
X-Google-Smtp-Source: AGHT+IGYnUG/eo1c7+2UYvBuQDrRJfWPT9e7QodlhNPd42BAKoIZYykdFsqO6arQqeR+cw9OZNk28S1NC0NC4X6/0lw=
X-Received: by 2002:a05:622a:413:b0:4b0:6da3:26df with SMTP id
 d75a77b69052e-4b09268dfe0mr126142711cf.29.1754583307979; Thu, 07 Aug 2025
 09:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haihua Yang <yanghh@gmail.com>
Date: Thu, 7 Aug 2025 09:14:57 -0700
X-Gm-Features: Ac12FXxnPG-FS8i3PdenrK0cpZlofLqcVgVJsNEW8momWCYHIZjaGlmnkqU9QZc
Message-ID: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
Subject: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout Scenario
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm observing a consistent failure of LAYOUTCOMMIT when the NFS client
accesses a pNFS share using filelayout. Below is the sequence of
events:
  1, The client opens a file for writing and successfully receives a
layout (stateid with seqid =3D 1).
  2, The client writes data to the data server (DS) successfully.
  3, The NFS server sends a CB_LAYOUTRECALL (stateid with seqid =3D 2)
due to some change on the server side.
  4, The client sends a LAYOUTCOMMIT (still with seqid =3D 1), followed
by a LAYOUTRETURN (with seqid =3D 2).
  5, The server responds to LAYOUTCOMMIT with NFS4ERR_OLD_STATEID.
  6, The server responds to LAYOUTRETURN with NFS4ERR_OK.
  7, The client retries LAYOUTCOMMIT (still using seqid =3D 1).
  8, The server replies with NFS4ERR_BAD_STATEID because the state was
already removed when processing the LAYOUTRETURN.

It seems there may be two issues with the Linux NFS client=E2=80=99s behavi=
or:
  1, The client should not send LAYOUTRETURN before receiving a
non-retryable response to LAYOUTCOMMIT.
  2, After receiving a CB_LAYOUTRECALL, the client should not continue
using the old seqid.

Would you consider this a bug in the client? Or is there something I
may have misunderstood in the protocol behavior?

Thanks,
Haihua Yang

