Return-Path: <linux-nfs+bounces-21305-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE6MDahp82ky2QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21305-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:39:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3144A423D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423B13010B87
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52740628F;
	Thu, 30 Apr 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY/bSVPO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4736C9C2
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559973; cv=pass; b=Aah8jTFUFg1sQDdL0BswGPQunj6RCfRpU994U70FJHZaMgaY37b0EaZdWhHNYQE4YsQrlCHNrxrMgRnotMa8y3jtcYnSQ9MpbXrr90R0FBJtR2HsQCpX/JoSgU1uanJvQ0vRMb0zlS9sFz6DzJU9pdXQfFHHc4kw0WogWBkPLsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559973; c=relaxed/simple;
	bh=QS03ALNxpRpoIhVBSAaRdwH0GZacLMgcmMxcqAQBIZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHaDOmcW9+YdZxkppOUhsKb9xEle3BhYbova3G1g/8TLL6hzdzGz2TAUFJh8ndM9zji9MNUEzvUjxuwmGUeDjlo24fxjrLicjTxXP5ib49plwXLP4E0086V4uKZpbY4sCEtCq/zexRvRBvQPdoT750JW2Wv3AUDQAeXfaZ1gqXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY/bSVPO; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501547d7edso947953d50.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 07:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777559971; cv=none;
        d=google.com; s=arc-20240605;
        b=JyTO5lToA/y/jVxj3FOJSyOHPMwSzPMtfogFSRqcxlaOT/PZQbV00bwm0+f4geQMHO
         iAQBKv1daztLYpJoXQX8UyfT1eZKA7rC46eagwz5giyTSaH/3c1UN/YcHzq19IKAz6gp
         HanPqptdMG7BaksSQHncYfe/IdD5+PLFRC5Vsw8FMrMxEwmXvauF0qD0n16hPQkuPGBW
         bGPrfYgOdYmALWQrnrW0v927pn1VNxRUbAHh5S4eSl4CcXLeUXKPWwNxGJwbFbxSx2+o
         65m9ukbPt5i+GqXcjQnlM/rR1HqjTPbsxphB2MjhJGtALIoMP5tbilM3gzA9YLbbD3uU
         WVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KLNd92V521/NslJQO1RDOzcTrmA4/Qzr+0uAjSb+2pw=;
        fh=mYcqdgzhZNYIpaSr8JJvPH8/Tw6t5BF65XBYZsTNwNg=;
        b=K8TgqJnINDC7WbmWHLZkt4iyr24p2CGn8uu4oE7ikhtzD9rqES8vnfYfZR1HhwhKER
         eqT8m7tA8hUEtSd91hclx4GGiRlPIrW4OkuAVDvFV9rGAmhAID9lfqY6AGGptlyoGy5b
         jZwXNZwFta9Pa3amhWmgs2rOy/5hFY2xQ1Epwxqv2J92RNlI9SHikr8Q2VPZRF/CJQDk
         4VtKRHAoIehpunubAoSYg46jhBjICw2cbwsZnThfp6eZ9eeuCcbIzQyhFVXJCOyqyocj
         Ju5mEG8CTKM0+bWDu2m0zU2Wmsz/nCcHgQ/mPq+zAHaDiB37YzdXtJqCIGLZwSnsduzM
         v33g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777559971; x=1778164771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLNd92V521/NslJQO1RDOzcTrmA4/Qzr+0uAjSb+2pw=;
        b=WY/bSVPOLW41mBdQHEIsL0gr9jDZXpv6RkTJ1ekxsHJMHxs5SRLgbE8/YjYudkWWWq
         2WWIgmP/+zuRpe9oHVIgRwoIcHIejxXqTpDOieJxruImIjtpdCy/sIogm+eTNVuSy8GE
         Ie/hZumK/bS7x3D2hbQUqrGkPqs4Vawm3XCJ+GiiR+g8PKtJOB3cy5wvZlI5KXyoFRDJ
         bfKAaxNgW3CP7YlcjzTroc+tecP4VlG0AW9K2OzjCAqQ7kKp5cpbYCuJR/Rcb7bGYJ4c
         TUx9M7Pil/xPhGp47ORtlRVzbCqbA4pHaX4UxZikP6d+LBhlm2v1/EISugh01CuxReuL
         MCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777559971; x=1778164771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KLNd92V521/NslJQO1RDOzcTrmA4/Qzr+0uAjSb+2pw=;
        b=UgHT+bIY4n6gvHuYK49A9PN/SIQi//mJMv8qy+DMAt3YF1PQxOnMaz1UOUh5SAJgNB
         fkv5fcHG3MvhRivkUjRFUKc2dGwx7tQs09jnAgapowKjigNISeU+HCuO668UL035F85w
         QCKQUXu8Erg4S+Kuj+AHn+vwwEHIYSVI42QgG5rsZzZW2CmCgCsokAExZCrrNbqjQfnA
         8963BUp+ZpLuzGAGkp6Z4SX5+FO+N9587QLLMzCUtpepBkbsmdtY2WbGTwZizeTC27fv
         ZA10/kTWciD4FYXkCjRW8yYzn+40WmJwyywVzylnFnrUFlWwZmKIIgF9Bml8U3f3bM3g
         YO9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xzOBBeK7WeCVbAX4LaCsFYkeFawoZUurGJ3oK6mdANM1J8okCr7ryy9ClIKphwUepQ5bm+s4FASM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYGQd/M7J6jl1qxdH7mFmwQ7LktCysJNCKHFFdWlM4xZXdtI5
	VvwCud3WIfz4quvbxGpY/FHOmW3eswdmly5kSjexcUPa3+Wo/416l8xSKGEFbpI0DRXn8vbsi4r
	SMFXmINp6tEYDFFTjKzT63xKKqqZikg==
X-Gm-Gg: AeBDieu5NXHIW9JuSkHhksJ/PiXXJmieHCAPEpS6lbOJ/G+A0A3g+kGxluVhNkY4X4+
	ENXJbn7rqGduEYVPop5a6ZKHDtNvsTuZ5urq7w/C1T+bF3644DB64wbMQvOQGi446iqCAIodAts
	8zKPP7MsqOUVPgkpi8aGo6HrG6Qy/0aYIj6IPo5BjwQKjh8RYhf3eXY35AywgjM3KmTQWypGcko
	y7Z/x0SZJ8gg+0cmXGCG+QVRP42TRh59dckz8/7BeePsL9v257X6NjRhAFVNrQuaSaRsR0629eI
	fC9pK8YSy7bHEIi+M+C9XRnHDCaf2qs2aSfEO7x08SRvgUV1mA==
X-Received: by 2002:a05:690e:12c5:b0:650:3459:a0f0 with SMTP id
 956f58d0204a3-65c19004f96mr2571670d50.56.1777559971178; Thu, 30 Apr 2026
 07:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com> <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
In-Reply-To: <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 30 Apr 2026 07:39:18 -0700
X-Gm-Features: AVHnY4JN3Y3OnLgFRJ_7UeTdY6bouhBAyawCUzNRAYKwySxsVuMA37VYHZViluw
Message-ID: <CAM5tNy6j0JhZ8yM1T_bT3pddBi21Q3JN-qnsMN8K5mn7KQdeiw@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8D3144A423D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21305-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kuleuven.be:email]

On Thu, Apr 30, 2026 at 7:26=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleuven.=
be> wrote:
>
> Hi Benjamin,
>
> On 4/30/26 3:27 PM, Benjamin Coddington wrote:
> > On 30 Apr 2026, at 2:53, Rik Theys wrote:
> >
> >> Hi,
> >>
> >> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) t=
hat is an NFS client to a RHEL10 server.
> >>
> >> Lately we've noticed that NFS performance is very poor for certain wor=
kloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.0.=
2). For example cloning git repositories is extremely slow.
> >>
> >> Looking at the server side there don't seem to be any saturations of t=
he disk or network subsystems.
> >>
> >> I've taken a network dump between the client and server. In that dump =
I see that the server frequently responds to requests from the client with =
NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatches=
? Is this always a client issue, or can this be caused by the server?
> > This is something you shouldn't normally see and probably indicates a b=
ug or
> > serious problem.  From the client side you'd only expect this if you're
> > doing a lot of task signaling so that the userland processes abandon RP=
Cs.
>
> Would there be any indications in the logs if this is the case?
>
>
> >
> > A packet capture is the best way to determine if the server is mis-repo=
rting
> > the sequencing problem, or if the client's sequencing is incorrect.  Gi=
ven
> > your description of the symptoms I'd also check to make sure your under=
lying
> > network isn't doing something totally nuts like duplicating packets.
>
> My previous capture was on the client, which is where I observed the
> NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the server
> and there I do see some duplicate packets, but not a large percentage.
> Should the NFS server not notice this is a duplicate packet and ignore it=
?
TCP will normally deal with duplicate TCP segments.

What I think Benjamin was referring to is an entire RPC request message
being duplicated, with the same seq# in the SEQUENCE operation at the
beginning of the RPC.

rick

>
> Regards,
>
> Rik
>
> --
> Rik Theys
> System Engineer
> KU Leuven - Dept. Elektrotechniek (ESAT)
> Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
> +32(0)16/32.11.07
> ----------------------------------------------------------------
> <<Any errors in spelling, tact or fact are transmission errors>>
>
>

