Return-Path: <linux-nfs+bounces-7851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4429C3BFE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67951C20FFA
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9162158555;
	Mon, 11 Nov 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="Fn++xnHS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84612F59C
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321097; cv=none; b=fJJe4vUNL/rDjuKfsq96XQ8TECq+x3yIvRmKKPs/3KgpqbEKvAvxisePPEzFduTPZhaSp+Iuuc6rE8LjDnZRC11V3ts0iK066cJlhZW92oZeIRZGt98qK/GcJVk0DJ9ePQEo7gEauVuJFIpLQHx5YjkCrvLJGzyTk3pEBSjDiyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321097; c=relaxed/simple;
	bh=EwCOwEd4qpHeVZZTuQttp3/QFj5uQrHY17yyi25Z+rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkUy1L9AaYiddwTNoNWxby9+eFxLaNXgjUoTexnsWISKCjLmavI6RBXXpXInxZrJuUM1eoA8QsRM317NbzF9/JJltICwXHhOs/81XMB3PN2YQxkzlF/qpTYrITNCgj3zUEMPaVqEatLghVOzxTJrbStrNAlPN+t9sAkbxvBSB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=Fn++xnHS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so33518691fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 02:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1731321094; x=1731925894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwCOwEd4qpHeVZZTuQttp3/QFj5uQrHY17yyi25Z+rE=;
        b=Fn++xnHS1El3LaxXXfXvArCjM8396sMJIokuoFc6rbCbukOjbLDRJzNnP2slke4SKQ
         +U9IT+MhJo6LffGVSen7ELYmnuBT/2Kd9bSDKXKBDc+FkMySBzzEasD+CL1L9xBrU08O
         E67BSixu+M6fikQqIocbOu9YSo2ndOkv91bQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321094; x=1731925894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwCOwEd4qpHeVZZTuQttp3/QFj5uQrHY17yyi25Z+rE=;
        b=FazfBWYrLJTGNj9Pt95qeDuB6VVnViSuMADIYr5DuUUaRV9gHYA/TeFEkBpaLbkfwS
         CQEUNnXQtmCwkH3j2yqhC2Q2TIeZLFHbpnAS8eRpyR3eTafPC8LYOj3A9wOW3q//k2EB
         IpGyL4qTrCP9FQwCEk7mIrVeuIcPnYPpbk/Z7f2QlvA0m7oMLZh0efYu06uh8kpaQfiG
         hyHgfB7yRZ/Xxm8WdGVLE8AE8az/5u42PX7kBwjwtr9j52ksGZ81lhWJyYAzl1n1GXXo
         8NmdzQ8cSLC4tL7o2QS3+hfC66kuG/BFYsZksl9lYxSgX2mLmAzDCd6bLxsJzvXXaZQf
         UR0A==
X-Forwarded-Encrypted: i=1; AJvYcCXYiX+tT0eZ2HU5xyoQd4brVYqXQC0F7grwBCjmi0Az0ALviYY1jLCgw0I3kK5314g5zS4wmczoVyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwztY0QmbLs7PIZ52fIL/y77WYkT7yPJUfiOlYtkJcAaK0KP4
	H0BwL/Q1UI/WA9HpNYfHc40F4VC3bEWbfD43RiUSG5GrVdM1VN1Uemr/Ji2pv/1um6oJQkDjD5d
	OkKb7IYw2VlNYQLGtPyjCOc5lo80QHB5JDSqb
X-Google-Smtp-Source: AGHT+IFaHt2ZktVBU0g61fusZHYJHhoZPkeD3I5YFeNCTZrVWICp7Z90V1XgXteN4papvB+oUhHHn2jz/vOV6Rhm1dY=
X-Received: by 2002:a05:651c:248:b0:2fb:3c16:a44a with SMTP id
 38308e7fff4ca-2ff20245165mr57577171fa.19.1731321093731; Mon, 11 Nov 2024
 02:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9F6400FB-AF3C-4B56-B38F-E964B60B508D@oracle.com> <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
In-Reply-To: <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
From: Igor Raits <igor@gooddata.com>
Date: Mon, 11 Nov 2024 11:31:21 +0100
Message-ID: <CA+9S74goQzFYVu0JkOJ36Uwo9mcWtiB+O6pr9SC37H+D9CojPQ@mail.gmail.com>
Subject: Re: Soft lockup with fstests on NFSv3 and NFSv4.0
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna.schumaker@oracle.com" <anna.schumaker@oracle.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Trond,

On Mon, Nov 4, 2024 at 7:04=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
> =E2=80=A6 [skip]
> I suspect it might be commit b571cfcb9dca ("nfs: don't reuse partially
> completed requests in nfs_lock_and_join_requests").
> That patch appears to assume that if one request is complete, then the
> others will complete too before unlocking. I don't think that is a
> valid assumption, since other requests could hit a non-fatal error or a
> short write that would cause them not to complete.
>
> So can you please try reverting only that patch and seeing if that
> fixes the problem?

In our environment, reverting the mentioned patch helps to fix the
issue (and does not cause any other issues so far).

If you will have patches to test in the future, happy to do so.

