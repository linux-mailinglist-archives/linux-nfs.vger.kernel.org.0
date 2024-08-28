Return-Path: <linux-nfs+bounces-5894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BA2963502
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 00:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBAB1C21C83
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF44165EF2;
	Wed, 28 Aug 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="mApg5wyC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB59125BA
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885359; cv=none; b=oHWJDYfXmTDZKIRpFOHJ8RXrsY3ekfVG694ELtlDgLnpSn/lYO7nJLQXjt/6qESk9HOSZInN/0HA0/OCcWhcaaDeKrD9Nu7Hy7dup+eNDlwzfm9FbRmIZ553LmElUCKh80FfzWwmw8owVpvcTBuJUAQUMLchxMukJTnK3sc4dSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885359; c=relaxed/simple;
	bh=43xHoWzC6W1R5GPll8SPD+EtfYnYTSe4z+Mc8Z/vSI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lo4SH7aF0/Gsit2zLoGY2us3mTZ2f9D3U/W9rtOvE+kZvv6uRCbR0L9zKPUdoIf1nbBoi1rYGDxJ+IBwF1BEXoW21FQ1g5tTBehzdV+/F6ki32W9vLMCj2eVY52INe3JjNYYk3/9uUDbnxtl+t2z0ZoDWqUsfhKm4hwjRLwD+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=mApg5wyC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso168621fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724885356; x=1725490156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we4zMF4Yt3INC7IfMbto0Ki3TQcfmDS3MGvyHnUw6RM=;
        b=mApg5wyC/G0+sUNhTiDEJQ+kr+dBozbz7fZ1dCuTMnWX9+vrBafM9kAb6jI6N/mhUs
         CMu1hhbSxWBonCz+55pEqX0xLJl+T1By6evs6MkQBhE6mwnY19OTWQqflhSug8vzUAf1
         8hYnl5i6TlGVdwP4WZTnmIVfjSqGvlBaHBIk/74R5ybm3GX1b3ezYBuV8MPUjL1VMqyX
         SnN+kUQa314kEg1jizVzD6dTXEOS6l+m0h3OyWMZdxCyUU6L5mSsNOaHGcqh09BWTixn
         5ZVylEex2XiEjksSkKh3C+0Eo7hEYmcHz+wx2jbXINylWydH8tK+QXDjTzGXSGr7WIOt
         gv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885356; x=1725490156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we4zMF4Yt3INC7IfMbto0Ki3TQcfmDS3MGvyHnUw6RM=;
        b=wjH1jwsGQGMVR+qmbhJbDpAPM3wzlyylE6BgLR2XJMFbNMAfL+gE+cDXCJVPuHjJSW
         I1CfLwoLAdN8Rf4ni6Q0O22gWu/P317U6hlA8u3YD3xEZKb7z9Av4v6dqyvcTH7Bcu5I
         R7vtzMOJ22WQCnxPm+/n4p74EoSTH24eWf2CfZSHIetCMv6er7u+PRnrlrt4gBNp+YHM
         5GyBj2m//3onJxFVwvOoimoc2cxIfFJHi6sIOfKpJ7V8jScHjtCJH+o7BkDUfn0snSyp
         riaiYzfJ5VxR18458Y1u8B9NUDbyF2Sgcvj3UAhDwA22RS72oN/opyGUCUn0SZg2P17M
         dGdg==
X-Gm-Message-State: AOJu0YyheYRWRq/xRR3zMB6Sq9Xq/hFV7OSkHwoSGvhb9RTlk/bT698e
	sl6GmiaHFCpEr9gCZP7HVJ7xb8uu2APV/LyLI5D1RhJOVaIEaTzQtyTbtTD+KWhz1nmZA73/nEX
	rIwcDH2gerQ63sVBPXim7Ft68w80=
X-Google-Smtp-Source: AGHT+IHUDuuHJ2M7eWOBnapW4WToBQ0ssYZKezQcKHuOVwOKagwkknbjFYz44+0HH50zvgVicwGfjfW557DjKBjovTY=
X-Received: by 2002:a2e:8511:0:b0:2ef:2344:deec with SMTP id
 38308e7fff4ca-2f610947866mr5457811fa.45.1724885355148; Wed, 28 Aug 2024
 15:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828174001.322745-9-cel@kernel.org> <20240828174001.322745-15-cel@kernel.org>
In-Reply-To: <20240828174001.322745-15-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 28 Aug 2024 18:49:03 -0400
Message-ID: <CAN-5tyEL6kDQ7N6yQDswj+JgmnjnhpzVoYA_tWrsR8Yu2Nyg2w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] NFSD: Document callback stateid laundering
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:40=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> NFSD removes COPY callback stateids after once lease period. This
> practice keeps the list of callback stateids limited to prevent a
> DoS possibility, but doesn't comply with the spirit of RFC 7862
> Section 4.8, which says:
>
> > A copy offload stateid will be valid until either (A) the client or
> > server restarts or (B) the client returns the resource by issuing an
> > OFFLOAD_CANCEL operation or the client replies to a CB_OFFLOAD
> > operation.
>
> Note there are no BCP 14 compliance keywords in this text, so NFSD
> is free to ignore this stateid lifetime guideline without becoming
> non-compliant.
>
> Nevertheless, this behavior variance should be explicitly documented
> in the code.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index aaebc60cc77c..437b94beb115 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6324,6 +6324,29 @@ static void nfsd4_ssc_expire_umount(struct nfsd_ne=
t *nn)
>  }
>  #endif
>
> +/*
> + * RFC 7862 Section 4.8 says that, if the client hasn't replied to a
> + * CB_OFFLOAD, that COPY callback stateid will live until the client or
> + * server restarts. To prevent a DoS resulting from a pile of these
> + * stateids accruing over time, NFSD purges them after one lease period.
> + */

I don't believe this is correct documentation for this piece of code.
There are two kinds of stateids in the copy offload world: one is
issued by the source server "cnr_stateid" in the response of the
COPY_NOTIFY  and given to be client (to be given to the destination
server to use for the read)  and those are the ones kept in the
knfsd's s2s_cp_stateids list and then cleaned up by the laundry thread
when copy isn't cleaned up on the source server. The text from the RFC
quoted here is for copy's callback stateids. In the current
implementation, we don't keep callback stateids around past when the
async copy is done. I agree that needs to be changed for
OFFLOAD_STATUS op and then we can add the wording of how long we are
keeping those.

> +static void nfs4_launder_cpntf_statelist(struct nfsd_net *nn,
> +                                        struct laundry_time *lt)
> +{
> +       struct nfs4_cpntf_state *cps;
> +       copy_stateid_t *cps_t;
> +       int i;
> +
> +       spin_lock(&nn->s2s_cp_lock);
> +       idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> +               cps =3D container_of(cps_t, struct nfs4_cpntf_state, cp_s=
tateid);
> +               if (cps->cp_stateid.cs_type =3D=3D NFS4_COPYNOTIFY_STID &=
&
> +                               state_expired(lt, cps->cpntf_time))
> +                       _free_cpntf_state_locked(nn, cps);
> +       }
> +       spin_unlock(&nn->s2s_cp_lock);
> +}
> +
>  /* Check if any lock belonging to this lockowner has any blockers */
>  static bool
>  nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
> @@ -6495,9 +6518,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>                 .cutoff =3D ktime_get_boottime_seconds() - nn->nfsd4_leas=
e,
>                 .new_timeo =3D nn->nfsd4_lease
>         };
> -       struct nfs4_cpntf_state *cps;
> -       copy_stateid_t *cps_t;
> -       int i;
>
>         if (clients_still_reclaiming(nn)) {
>                 lt.new_timeo =3D 0;
> @@ -6505,14 +6525,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>         }
>         nfsd4_end_grace(nn);
>
> -       spin_lock(&nn->s2s_cp_lock);
> -       idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> -               cps =3D container_of(cps_t, struct nfs4_cpntf_state, cp_s=
tateid);
> -               if (cps->cp_stateid.cs_type =3D=3D NFS4_COPYNOTIFY_STID &=
&
> -                               state_expired(&lt, cps->cpntf_time))
> -                       _free_cpntf_state_locked(nn, cps);
> -       }
> -       spin_unlock(&nn->s2s_cp_lock);
> +       nfs4_launder_cpntf_statelist(nn, &lt);
> +
>         nfs4_get_client_reaplist(nn, &reaplist, &lt);
>         nfs4_process_client_reaplist(&reaplist);
>
> --
> 2.46.0
>
>

