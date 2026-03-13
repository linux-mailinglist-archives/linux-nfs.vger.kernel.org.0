Return-Path: <linux-nfs+bounces-20149-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGiSF3g0tGn4igAAu9opvQ
	(envelope-from <linux-nfs+bounces-20149-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 16:59:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC8128682A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CE113026A43
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7D3644C2;
	Fri, 13 Mar 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="p8DLFlYZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4B3630BC
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417554; cv=pass; b=jndqY8t/vPFMFJu0OXAdUAGGLAnJJ8QiL+KzP9Usv/cblNRSG0GkhRVPw96uRil1iKxe+xweonlc1MHpSlFlSUhVOJWwgrxDz7rsMLxvw+fcWPVczjdrTPbD+F9S1KQg7AMpWOTY/rwZ8Iynapb0y+/AysNRZDFpis8lUnqjA14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417554; c=relaxed/simple;
	bh=pjFuXIlXmbezXV3nIMR2pA6o2l4L7prDkCWcNoOhmJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRVWgM5is/sVqP2aa5hzCRrQbBzmA9eJupvMm2ff0K+BhNrl5mB1ExBybzJLrP10XSprV4szis3LgmhRI7Ja7UkHsNHZ/hJoOLr5KmmE9l3oFL/ZZttZAXnw//6kvTgg+m4JTT7xDTPp9zb0saU29HYRNJ+jwb0M18YknkXEJGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=p8DLFlYZ; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a41026318so20496851fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 08:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773417551; cv=none;
        d=google.com; s=arc-20240605;
        b=br+vM3ACZzZYlVqeJC1Odpwwm8wv3HAR0kkcEevigtP898/5Jl+Ji5+DHGVfZE8PcH
         7dmNCbje/9txnRakh3Cjrc3jgSILQ9d+EIBsc13yOO5ofbATD5hzmwaJZ5WeD0ig9UaU
         BnQar9K/PncQQtfRQV1UezIdOmUaLKZmfr0aQHreQuLdozDr5Agp2Gb60lJZCIQW/+NX
         uFCe6TtGs+hT62gbfq1aQszYwNDZbwmmXJsNZJxPaUd+XIBrbqsgxsYqK9XCMK0/4TDI
         rd6BKSTLU+KVQGVhjXCmxFyOotBfe0HeKIlu+AgHylwmheyxF9LcRbmDrNdX8/zMZo8v
         Gp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vuQ1yYu8au1sg249Fitvb+tajlpXlBicQVWC5t+xhI=;
        fh=tzlu6mv6K2wYP73+LSQdeVPW8Rq4wO0foiJsTfWG0yE=;
        b=CRA4lVTZcRQyhtyZG6df4K+Yxj143PdOg48mqCbnL34QLczbKFY/RDK34oBGiiaLny
         DWRqc9/K97sQikwpBoMCgmbeE1fwgk6cHBIzxg3m7vQoEesgX+SClSLWH/Bao8PB1Vj8
         wNGFcDaLNbtBCvenlphicMXk3cAAFDKFRkwVs1uMq7Dp3phg8VB6hsp5ZBj4OPFlKaMm
         +S2qEYvBMtlMDLUyM451l/0134rl90vt1aOZMIqaKD3Ij4maxEH8AQwrYSjveRDwh3Pm
         S7aQxCeI4lEYRyiZd0kRgLoL74bgMuSwJjwwKtla87YoFGLcOyIF0cHGcwD/FtghICym
         lfGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1773417551; x=1774022351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vuQ1yYu8au1sg249Fitvb+tajlpXlBicQVWC5t+xhI=;
        b=p8DLFlYZ31pPJUsE2AkCKNgXbBiG8ObizeVBhJ64p0Pcm6kOCDVbWSY2kT/JdjRHkh
         wehff/96DF7MnyAFC67YVhu8W3XKUhf74KWs7qsX0tAOBTjwbLGLkUxpLB1sRhJdcyMy
         bLAJN0q2txVnMKuhH5uYES+sOgcZKF6pLkVoh0Esl9ZAkuvOjQmLGzbELp3ff3pOtDiC
         KcDu9/uSFkiJrEm4Ne8daxDDBN7HguaYSyhNEho2dGofGPukKF68VFbkwxJM+pQAdCDY
         jgnt35mWEZN/rrv+HeapiGTYrH4bxrNQLef0FkskWyn2NJG04JinvsGDUgxrCS0Nu22Z
         MluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417551; x=1774022351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vuQ1yYu8au1sg249Fitvb+tajlpXlBicQVWC5t+xhI=;
        b=SLQXbIUdRjBTg6xrVGFUMhBcwGiaDARkqFdHX7FWhrTQR0ZRr3uu3oD+CiMOdgazQj
         vuNGCc+SzYVMgKNPBYuk1wA+U4F9ettxyDOrTf/GQXnbT7nKukea0k/n/FlV3pJ/wYp2
         ecFR/r6vLFfm5V4JM+tYoAlp9kVbS6/y7JA7bvJK1Abo6bhfvLpL3soK6XK9OFGfkmqP
         TazPWPtlJU9NsiEEdqq7bNpd6NfvRVxaxWioG37vWci4qUC9JzGS4m9uI2geAtqQRnVT
         kvo5iHCkj9rAdyQ9z1u506D4qQl63UcsL6HF0VzTaalwdztUfLAz6C2h2x4SZdNf5Geq
         tl+w==
X-Forwarded-Encrypted: i=1; AJvYcCXiFAy23VOLnzH6PlpkhUV64gr0W5QskAydDgDoYPvlM590TDsMOXKCypJhWgKNh9arUlPzaEorpjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMAFJwfYjVVwXNwu9uK1c1uvRWgYUyZGTjScU9g14dqk6qZ0I
	wK/7Rn0RNBiTO0okhsaE7sSx+ChK5WT+qcga7JDeqNW+Ps1bIEiglRoH/o+1JZagSfgMumsd8FY
	90KJsutT0n4ovnymr70KGofKUnyTDgh1odJG8
X-Gm-Gg: ATEYQzxIdRwbUpdvIrwCs2cfToEou5qODYVOmBKTqWdKHIxE1T7u0iDr+eUO6wjhDAO
	U3owU8aYJug+eRRiilOaFMDTfJUVWj6i4MdjeeZGCYvBy003c1YF86Fi0k/i7XK5r9rPEPPr/I5
	UZRwuqI+iCEVyHZCaMFApRn+BvU5j2fg1CkZq0DOWxtx9KuvP02Ni+MDVraBVjNKmZkIm7tHaHu
	ewPUFT/s5DdcJ5su5YkzVc46XW+njexl2is/CLvOyxuel3idbNwwVoQT+hS+WchUU1GVZH3EiNk
	nH3/SVwepdMY8EAVFGg3zLvyDlMuAWDYNU+KBVw9
X-Received: by 2002:a05:651c:419b:b0:387:710:7bd8 with SMTP id
 38308e7fff4ca-38a8981f5b1mr12302691fa.33.1773417550796; Fri, 13 Mar 2026
 08:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
In-Reply-To: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 13 Mar 2026 11:58:59 -0400
X-Gm-Features: AaiRm51vp2RXO8LLWR74bWqPUaIUUpuii3WzUwx7BKr4QyEAEHzCU8GIpwKDgaw
Message-ID: <CAN-5tyHJhwJU=71gxiKJYFnJFGA5xWUg0CQpbJ9=YgqMVi72RQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] nfs: delegated attribute fixes
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20149-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,umich.edu:dkim]
X-Rspamd-Queue-Id: 7DC8128682A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I can confirm that generic/221 and generic/728 no longer fail with
this patch series applied.

On Thu, Mar 5, 2026 at 1:53=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> This patchset fixes a couple of test failures in xfstests when delegated
> timestamps are enabled. Please consider for v7.1!
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (2):
>       nfs: fix utimensat() for atime with delegated timestamps
>       nfs: update inode ctime after removexattr operation
>
>  fs/nfs/inode.c          |  9 +--------
>  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
>  fs/nfs/nfs42xdr.c       | 10 ++++++++--
>  include/linux/nfs_xdr.h |  3 +++
>  4 files changed, 28 insertions(+), 12 deletions(-)
> ---
> base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
> change-id: 20260305-nfs-7-1-9f71bcde58c5
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

