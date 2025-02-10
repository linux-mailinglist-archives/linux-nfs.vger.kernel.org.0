Return-Path: <linux-nfs+bounces-10012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DEA2F0D2
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1943A8A35
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE51EF01;
	Mon, 10 Feb 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="a1cWuZTN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545482309AC
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199847; cv=none; b=FwV4E6t/8MuHm3EBh3WFTn2NnulHVPw/1cg9oj4umufvVlC6O+lUW/xKJuqcn/hI3xtviDNVnqB6fkSrURhkPUZvdT4gAnO5+phjj1igSH6Fth0wE7m5QhacWc2cXadQHrPCXved318Pm65FrYEpYOR4R6JSw+74PPK9NS1lKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199847; c=relaxed/simple;
	bh=iE0I9ss9y9o3fJIkPtHddkd0T99JlfHp0cRAjee5tfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHnhWStm/AnD3PAGvDQkY64eCIv+cGiOt/lWGrXne6KtMkHr56s+hE6lZi9OJ7VtIHd911rmkoy7PDU3SF0LPpYkZap3Ec7LViafF+w2PL59eBWh3ELO/FFrBfNIvj9XWCEPnCzthfLxoFBNGooFBbfCcsbsgHGx4I4+5MYGB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=a1cWuZTN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307d9a13782so39300171fa.2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739199843; x=1739804643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE0I9ss9y9o3fJIkPtHddkd0T99JlfHp0cRAjee5tfg=;
        b=a1cWuZTN8kvDros+ITGbGB0KPZ9CN7Y/A2zzMpZpYGj0zwBlZQ5eK29aPR4kqWyD2j
         0lfzFDvS/8ZWJv0XHu96in67rSjxDxyEQD30pqhMFwSBzWnaLFRG5d4r9zCzNy8u1vyl
         fThOr6F1QUxjtWmatmSmS2cBSvmNiSwS1IyNVaHKUyAi++SgFzgfC24HtxCC2BTJr4vR
         AqXZwD3lkwJsuCTEjpxI5dj9d2xujq5MFfXWpY8Bv8CBIGvyHWCjTWmueUrqojF8o2FR
         Jww/gKZ8ID5/B5L9lU0Y+xAI6tBtc1E0zXgBQ+OawOLfonZSFuG5fv6jGeDJnjHYcr5E
         ae8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199843; x=1739804643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE0I9ss9y9o3fJIkPtHddkd0T99JlfHp0cRAjee5tfg=;
        b=fwBydM//B4y6rkwf09Bk6DsNclSBdGCY+SXO0/ClhvE9LX4IDKngzua+2C5tJ+Cdzl
         QNNRZwLBJq8YHlMoEadEQa9SDK58rG1ZugvuouDh4maE8UKy3acYNC7WenBdwvlxQ3nr
         FPrm8ki0YfJUWArQ5ypNNhEeeCUi4keGgcOAcTWf6yTgNfuN/wvZevOgStbijSyD4g6B
         TG/Xn3A6Vadvrp0O24VNUtBjwUeNySu5aZ5J8Ukk2ZkId8ICqRF2ZZE5D1HR+8Z7SdDT
         UhCInpuxJIlX5waZtn8toFif9KK7O4+/2RRK720FHLeGED0j4mv5rANxZgaq/wUGM87X
         tAVA==
X-Gm-Message-State: AOJu0YzI6PQbfD2bvdwMZswJdyK0EbBNjEgHi7RdWTU1FWkrLjzVtBsD
	3qI4KZXYHz9q7/n+sfwNJSTqF9j/omeFKVYykGwzld4rTKuXQ+p9mmKcPmChiLG1f6diZ6m73ZD
	LlOqpL3f1l3Q8LBQ2sjb7N3fnat8B9VEx
X-Gm-Gg: ASbGncsIUYhxSpLSlDYEQSCwoq0dJ0yBPEzrlXUw8Lfk3iIala0iEMWW8/8r8S8jPvz
	0/n0k8BLTPyf0Ov4Ahsn+8OXbYQYE0mWdY/AvvRsAb1haroF8JRd1+PDru/yGQCv8FzVHiAcVBf
	/uGtPJ2C6qtClBccrmXKrInUxLyueuZRY=
X-Google-Smtp-Source: AGHT+IGjWzu/OlwkSUQQGv9F51mlIa8+/c2McoR9/uw0Pame967cQYp2nnJfZVaDhzXcpZ1+y/noC/T14fg/O1+kQNo=
X-Received: by 2002:a05:651c:154e:b0:308:f0c9:c4c9 with SMTP id
 38308e7fff4ca-308f0c9cec0mr13798071fa.7.1739199841453; Mon, 10 Feb 2025
 07:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-b219737c7-947e192554be@bugzilla.kernel.org> <20250204-b219737c8-56e36733bccb@bugzilla.kernel.org>
In-Reply-To: <20250204-b219737c8-56e36733bccb@bugzilla.kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 10 Feb 2025 10:03:50 -0500
X-Gm-Features: AWEUYZleEWRXHDmBHfKNDHiXax6_Erjq7wYetf47RnI1Swk5RA_68ql215JiSW4
Message-ID: <CAN-5tyG0STqGPAo623i_Q3nkpT=CTh7t_qA+74NmOB--dHjX4A@mail.gmail.com>
Subject: Re: warning in nfsd4_cb_done
To: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Cc: linux-nfs@vger.kernel.org, cel@kernel.org, trondmy@kernel.org, 
	anna@kernel.org, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 8:29=E2=80=AFAM Chuck Lever via Bugspray Bot
<bugbot@kernel.org> wrote:
>
> Chuck Lever writes via Kernel.org Bugzilla:
>
> (In reply to rik.theys from comment #7)
> > Is it possible this patch has not (yet) been sent to stable@vger.kernel=
.org
> > so it ends up in 6.12.y?
>
> Commit 1b3e26a5ccbf has been in a publicly released kernel for exactly tw=
o days (as of this writing). It will take some time before it appears in an=
y LTS kernel. For now, if you would like to test the commit, you need to ap=
ply it manually.

I believe there is something more to this problem. 1b3e26a5ccbf commit
isn't sufficient. I also have report of "cb_status=3D-521
tk_status=3D-10036 cb_opcode=3D3" triggered warning.

>
> View: https://bugzilla.kernel.org/show_bug.cgi?id=3D219737#c8
> You can reply to this message to join the discussion.
> --
> Deet-doot-dot, I am a bot.
> Kernel.org Bugzilla (bugspray 0.1-dev)
>

