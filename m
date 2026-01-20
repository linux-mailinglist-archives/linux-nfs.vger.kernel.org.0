Return-Path: <linux-nfs+bounces-18210-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM5HJh0EcGmUUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18210-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 23:39:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157F4D190
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 23:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1392629E85
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19F3A9005;
	Tue, 20 Jan 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ZheE2naJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594B344029
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941983; cv=pass; b=RYSF9BkduaVTXHgg4fnXg0bx3VXDe41GyC+Mmu9Wq11u0uvQ1CiEbj9PH5m2LJkes7ZI14Z4axo5EQNqVG3co+3N/wHM+uFeEaw8NYdDTLQyLQQAQ/X1T8tGYG0j7Bkxi6pqYugtXIcNlIQwQ02sIXA2kMhpyCErhydl7v3IKds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941983; c=relaxed/simple;
	bh=CEMzOUejJfIYE2p6jHiWUBVuI9kfnYhXVVr5YQ8rYW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl5Bi1K/QOORhwQZNVT/ExzvWsJ63VrSCvEw41ufnXanKUzB+WjGXZzFZgJzkcNZdR6EJlGopRwfl8O3zZT1t7LjXvEKNlt9jRS9lSEtmM+goXG3BlTTXAEnb9CxEX/ZEF9NG/o40aOoeTYNdMo0MLuc4QDwsU5YwqxYtVSYbG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ZheE2naJ; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b7b27ebf2so5591219e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 12:46:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768941980; cv=none;
        d=google.com; s=arc-20240605;
        b=IGeceWB8KRO9D/EnCzXnePxm7XeRui3Ku0GMdL5LKW0+2cJlZL5Z7NyiW0TN3nnwC7
         gqlMjeHq+sBZjwzcpPZ8AXrjjKg+WVQe4tjfmr0tGjgPbtCznlL0RLSF9dXbKXyC0BhZ
         pA6Y2b11Lthtf6kPrSXwehTTTnBGPy2hVzgDNJFdHelPO3n75wAFSau25506nC5h0hAw
         g9t6Dt+XDe53BL4Ap6AnHryLOuxktnfPz7qCSKWkB3IOz+q80nw45/prof4x8K2via98
         9px48+wgHHkK9J1+39af/QOKfCvIth6tTyUE32QrEOvsROzyN+Pw7CHi1z7WDeUP2g14
         TGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVdG4XUhuqmzvuL/YVQnOB0BZo4WFY509880sNsYnrY=;
        fh=q/ec8dMEbTTDg5Vpy6fbetUAsGLy6WNYOoxcRPdEURo=;
        b=C5ouVImQIR4c2SU86kqETJvLGYcUMsZFrJKjfSnGF9Cd0fnt6AvzZ6dUz4h9g5QTpy
         v+xz70aIX79oISLS0CU0tbIopN4mjSsjICszJHMXTeWXT2htJrzTsuyDRprFo+hVQIQD
         O1krpNey7IslWcw2htmyyU/FZ36ri9Na+tZVjQkuz6DUXKKfrd7wA2bNr3vpAm5+nL5B
         v0QryrauJ6KabFDI8dbu3NpGdQRiIJB2OLCZGxoSfh75HFkcguGrh2C5XnXlaEQPSbNQ
         w6I1yHTECdRU+fWtKNxTTlUC2+lufvDlsy4Pg3MxyBWqTs/ihMihO0D2DY+kuwSBJ+pO
         AsJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1768941980; x=1769546780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVdG4XUhuqmzvuL/YVQnOB0BZo4WFY509880sNsYnrY=;
        b=ZheE2naJxjoaBYfNmRAvXEfMxPK3F3UU+oN7MbCAfFqH/o9Qb5Z1/yR1evEPKMe3XZ
         tgHVdZBBsTQ3hOKkuFkBBVEoEynd1gNMfIZKUNqsDJM0oCT49F3zfGNEAsURIU7Gprdl
         esUkw0h2a7dzmU9CbaDNZfDguG50p981u4iMnnYQj/T2KIscHGDgP9aeXvNCHKJq54Q8
         5Ww5+Wm5shNGL1xKgjyVwVHXjmyJR3As9gFG8q2ZYxArteqYdHIGpU2ycr3KMygWOfD8
         S/vJYU0abFzBwcr3M65BNYLwmdO/Ce3p4hikHiUJPw7gbT4Y6dCOvdRoWXJ8Ty+Ph2KF
         hZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941980; x=1769546780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVdG4XUhuqmzvuL/YVQnOB0BZo4WFY509880sNsYnrY=;
        b=L5QvEJQE4OtGLOqYrkGsJQk4Cwjjypey1hy+nyqFsWQ4mauM1CMEdO01y0lM3SXn+2
         9Atc2ycNrdo0PxwJ06q0N0kFwbW7WiT/B8Dq28xXzrCPqG0bBUtiDP2CN1rrqZpl8LzH
         ipQnwkz3cS4Zeoa7GfDIrgbFAcDXhISsPei5LUTwhk5QUXPZHBm5vP/EBQgS3Ijyma4l
         j6qCypR0GSSZyJuIfhjO7dsatfXRcOB+24XzsylbzJn8d85Esij5q3kFLtWTpcobWOsa
         LpzbPa1m2/KLznb/3T4nrvOnfSH3YXhaiFFPtEI+SNYRPc7bDLra1rTmQu0HBwJ5BVI4
         i/xw==
X-Forwarded-Encrypted: i=1; AJvYcCVCWqo3gy8PoO1dUBFhvQQNmxi3DgniwbBjtiBVNS5Ng8H9RcuPZ6x6JomNw3NqxSysyUQIfL3/1sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJR6bm3o3WQ7Ym9Rfmm/q/KhsjNjiy+ziLyufRDkaCusEFUXyv
	HVHA9UgwMUvF3E/fKltXR1QpV1XCiC+fitlZ6yPIfVZBzbcmtkStLuZhN+b7eedKkQVcRj1mw2d
	eDGsh9Mh/dDz7dyKeclOlYPCTjxUm2Jk=
X-Gm-Gg: AZuq6aLiDuiOvIWheiOnD6q78nIKoOX7vsJY8fVJyeg/ee59XbDkzh1vhd6CLij+OAO
	EeN7F04ZjMy0KbyKpQcvBcc76F+FhJ2rRF+jGlJVuhFyjPb4SzRR/iUrfAGGHfdJNrOaJXIeDnH
	AOq/ZAvju2kRuoUnn+TkkgQ31b7Da2GrhdO3UQtQNpv4OItdgGnV3MUkOFaH9H/VaPwLq27SJFq
	YJHIiNpbP2Ru0pwPFIPZfG+f0UqwRYpAA0CWKl/32SRoyXo4xFVJgGnrwDKZlyyLYCmJ6ATX1QY
	TmC++srR5DLSIlmv7ewrxpvyiUzKoK0YQjQmd4A=
X-Received: by 2002:a05:6512:1246:b0:59b:8436:79da with SMTP id
 2adb3069b0e04-59baffd6f05mr5680541e87.44.1768941979454; Tue, 20 Jan 2026
 12:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125001544.18584-1-smayhew@redhat.com> <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
In-Reply-To: <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 20 Jan 2026 15:46:07 -0500
X-Gm-Features: AZwV_QhrGhTFIqcsYJB7vH79PIAubr_YqI-HfwhssGwgTc-YonSQ27SkChju6qU
Message-ID: <CAN-5tyGHz0yAQToc8cSUW=ka_F1a7Yqe5w1pkx1Vx3F-9nhESA@mail.gmail.com>
Subject: Re: [PATCH RFC] NFS: Add some knobs for disabling delegations in sysfs
To: Trond Myklebust <trondmy@kernel.org>
Cc: Scott Mayhew <smayhew@redhat.com>, anna@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18210-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[umich.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[umich.edu,none];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hammerspace.com:email]
X-Rspamd-Queue-Id: 9157F4D190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Nov 24, 2025 at 8:01=E2=80=AFPM Trond Myklebust <trondmy@kernel.org=
> wrote:
>
> Hi Scott,
>
> On Mon, 2025-11-24 at 19:15 -0500, Scott Mayhew wrote:
> > There's occasionally a need to disable delegations, whether it be due
> > to
> > known bugs or simply to give support staff some breathing room to
> > troubleshoot issues.  Currently the only real method for disabling
> > delegations in Linux NFS is via /proc/sys/fs/leases-enable, which has
> > some major drawbacks in that 1) it's only applicable to knfsd, and 2)
> > it
> > affects all clients using that server.
> >
> > Technically it's not really possible to disable delegations from the
> > client side since it's ultimately up to the server whether grants a
> > delegation or not, but we can achieve a similar affect in NFSv4.1+ by
> > manipulating the OPEN4_SHARE_ACCESS_WANT* flags.
> >
> > Rather than proliferating a bunch of new mount options, add some
> > sysfs
> > knobs to allow some of the nfs_server->caps flags related to
> > delegations
> > to be adjusted.
> >
>
> Shouldn't we rather be allowing the application to select whether it
> wants to request a delegation or not?
>
> IOW: while there may or may not be a place for a 'big hammer' solution
> like you propose, should we not rather first try to enable a solution
> in which someone could add a O_DELEGATION or O_NODELEGATION flag to
> open() in order to specify what they want.

Hi Trond,

Shouldn't open flags be something that's a generic concept for all
filesystems? O_DELEGATION seems to be NFS specific (or at most network
filesystem specific).

> That might also allow someone to add an LD_PRELOAD library to add or
> remove these flags from an existing application's open() calls.
>
> It might also be useful for the directory delegation functionality that
> Anna and Jeff have been working on...

Being able to control directory delegations feature (might be) useful
too? We used to be able to toggle features via mount options, wouldn't
it be nice if we could again.... Toggling features via sysfs is useful
for when mount is already in place though.

>
> Just some food for thought while you're digesting on Thursday :-)...
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>

