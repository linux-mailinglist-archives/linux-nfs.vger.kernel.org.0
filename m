Return-Path: <linux-nfs+bounces-16562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78EC70510
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8073D502E99
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96A302179;
	Wed, 19 Nov 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQpHGNdt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B25327C12
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570080; cv=none; b=Iip4loMb6DGu4BmfOezuQNN9dkTYI3Ocpjd4vHvkB6AefVLWvuUm+Ko+JAeh49noYUS5ZC/bAX2v7gdUKTl/zLbRIetqyvtXzc5mh2ZNM+mSsH8yb7dSps6yviUSKh8Z/ymF9Yw2qOOb74GhDpSOMkW2/tnCuO45mw7wurslGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570080; c=relaxed/simple;
	bh=xzs7VSDad/NWfK1TG2m1ai8OrMEYDPxiqgu23XyDyCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9vhIxvRIIlYhj6sG2jyy6DUc/FpdSaPYNx/EDD1KShh1rERECgs5IW44pmsjH1opkOMA6tTpcqNuh6W+NSVSTunLKbzk7FJZdAl10jC3N1VEyRe2RaOoG5V91AEGFD88Lr/nYyMAyixAXnVW+F2usJYysP7ChyJRvk/bdDiOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQpHGNdt; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e8819eda8bso1324619fac.3
        for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 08:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763570078; x=1764174878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88XwnoRM3J0wM5KI8XUqqt/3L8/GOhZXLtMO8RYURQc=;
        b=eQpHGNdtTfj4KeCyU6oYAssLFFuRuQlMeFkJdJRWInMqWPlOx67kCMpcTu1wH2oiCW
         IYYXFYeeqt3xbsh4rXUOwo/EvYhp4A0/1txSOwm/d0TSpnqulUEGXJiOYglCHOODDlGK
         47SfwZX7wbeKCBpDa2gRpqVan26Vdt3QU1rkl/OiS/FSnCLhkele4GIUtxO1XlWnNbLX
         wZgXJav8jeJsgVTHbLSEDYt+NYl2mBFgW5y+V8MS0XgY43Qq0qmjIQs/nRoRnUc9QARI
         zJXptimZueWZiBIZ4swfgi+9e116Bfr5P8sj4aJ7MDmjeKPhcFu/Ewf2kGE9SfWf0e0k
         G5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570078; x=1764174878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88XwnoRM3J0wM5KI8XUqqt/3L8/GOhZXLtMO8RYURQc=;
        b=FflQK2/Tb5wWb3eKmDFqJ79ESWiZqo9Y/kLRLb/Ul0mXfX4JD/f8Ge5kYE+qhc0KB2
         0umsW9CAU8Q2h/XZDgq2zHjFluakFD4m3OxdZ422kapTJP3rYLplhooP/IlRFU+N9rlr
         y4muVw3G0ZyfCUt/NoAHxK+q108JAi9sao4U8Kr02r4az0hLFYCbxp0F2QJS2HRYyAfA
         RhH66Rk4a/m/25t3WdYSWE6ii02nPb0QRTLQ4rg/upmqk9kx+3Ris9D4IYW4VT/5xyOk
         +yadYld9FWXG0KJXhh8bLVc5IC99jGm36ScdpSJQfcLUuOuM8k0iHjA62yPNAFA+X8Sw
         Gwyw==
X-Forwarded-Encrypted: i=1; AJvYcCWon0V/5EmJfn7yAMsSGEDlAd/KGJJgeB7thLmf8bRoEoM2bpgZY8pEUpKGCoRM92T08YcOx+K3pNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjtsURj6pcnXBdFGO4dFBV/NizuUGUiC8K8DdkFOYjM+En5pm
	WrpaiISaR5VZasF6Bhos6dqTFlud/51xD8q37idU4H2yiGLmSEhU6pXL3C17Chswt4ydDMSZLM4
	3QZi6Bapg8URq4TCV/Vbg8NuNvbzfWLM=
X-Gm-Gg: ASbGncv2KBJ7LRlRdC58J9DVDEVvVYTXWdxfxVN4EJ2TlWC5zj9j62HrQNfrXmyj57K
	kn4pxnMcLFp8ZGvG92jiqsBiOy9XqU/v8gA66AR5MsHG90Qa7EneFTfBCOX7fVeP1WDQT2LeHqd
	OCU6zDKaWloQII3gG2HT85hsvGzVAu6KvvE+D467a4/WR96dH06VN9BpUC2aAtcJXlnML8msGFp
	49GsPhuEBLQkC42i8vnvoa6JuzpBdIWZen759bqmikQPMf5YTtCUPwoVZks5poCY4X1GBiHva9q
	6GcaXcboszbgV5mCRuY=
X-Google-Smtp-Source: AGHT+IF+gTUgL2upVCgMsAZlU4AANP3b9EbcrfUVT74WJSfIBoZI5xCGMvTa0XctqWto069Kj7OSRf2WXtDK5uFaCUs=
X-Received: by 2002:a05:6871:ea10:b0:3ec:41eb:6e48 with SMTP id
 586e51a60fabf-3ec41ebb131mr6275731fac.40.1763570078046; Wed, 19 Nov 2025
 08:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118105752.52098-1-gaurav.gangalwar@gmail.com>
 <fe6b3cb2fde809977394c5f605b844de043189ed.camel@kernel.org> <1fd78dbccac873a277e71e55409acc5d1d3e6886.camel@kernel.org>
In-Reply-To: <1fd78dbccac873a277e71e55409acc5d1d3e6886.camel@kernel.org>
From: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date: Wed, 19 Nov 2025 22:04:26 +0530
X-Gm-Features: AWmQ_bmE9UybyQ0mUlbTiaBYikhWY8HFkObCaYO3FJhrDXrp6WsZ6bf9UFARHTY
Message-ID: <CAJiE4O=62Yxeo=24p9k3H_dC6Z7LuVwLFo8ca98yJTvsSTMfhQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: Implement delayed data server destruction with hold cache
To: Trond Myklebust <trondmy@kernel.org>
Cc: anna@kernel.org, tom@talpey.com, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Trond for review comments, reply inline.

On Tue, Nov 18, 2025 at 9:46=E2=80=AFPM Trond Myklebust <trondmy@kernel.org=
> wrote:
>
> On Tue, 2025-11-18 at 09:43 -0500, Trond Myklebust wrote:
> > On Tue, 2025-11-18 at 05:57 -0500, Gaurav Gangalwar wrote:
> > > Introduce a hold cache mechanism for NFS pNFS data servers to avoid
> > > unnecessary connection churn when data servers are temporarily
> > > idle.
> > >
> > > Key changes:
> > >
> > > 1. Hold Cache Implementation:
> > >    - Add nfs4_data_server_hold_cache to namespace structure
> > >    - Move data servers to hold cache when refcount reaches zero
> > >    - Always update ds_last_access timestamp on every reference
> > >
> > > 2. Configurable Module Parameters:
> > >    - nfs4_pnfs_ds_grace_period: Grace period before destroying idle
> > >      data servers (default: 300 seconds)
> > >    - nfs4_pnfs_ds_cleanup_interval: Interval for periodic cleanup
> > >      work (default: 300 seconds)
> > >
> > > 3. Periodic Cleanup Work:
> > >    - Schedule delayed work on first DS usage (lazy initialization)
> > >    - Check hold cache and destroy data servers that exceed grace
> > > period
> > >    - Reschedule work automatically for continuous monitoring
> > >
> > > 4. Callback Mechanism:
> > >    - Use function pointer callback to avoid circular module
> > > dependencies
> > >    - nfsv4.ko registers cleanup callback during initialization
> > >    - nfs.ko calls callback during namespace cleanup (if registered)
> > >
> > > 5. Timestamp Tracking:
> > >    - Add ds_last_access field to nfs4_pnfs_ds structure
> > >    - Update timestamp on DS allocation, lookup, and reference
> > >
> > > Benefits:
> > > - Reduces connection setup/teardown overhead for intermittently
> > > used
> > > DSs
> > > - Allows DS reuse if accessed again within grace period
> > > - Configurable behavior via module parameters
> > >
> >
> > Please read RFC8881 Section 12.2.10
> > (https://datatracker.ietf.org/doc/html/rfc8881#device_ids)
> >
> > Specifically, the following paragraph, which disallows what you are
> > proposing:
> >
> > Device ID to device address mappings are not leased, and can be
> > changed
> > at any time. (Note that while device ID to device address mappings
> > are
> > likely to change after the metadata server restarts, the server is
> > not
> > required to change the mappings.) A server has two choices for
> > changing
> > mappings. It can recall all layouts referring to the device ID or it
> > can use a notification mechanism.
> >
nfs4_data_server_cache is per network namespace and cache ds_addrs ->
nfs_client, so it should be independent of device id.
I am trying to understand how a change in Device ID to device address
mapping can make difference to nfs4_data_server_cache,
since this cache lookup is done using ds address. As long as the
address and connections are valid it should be fine.
One scenario I can think of for address is valid but connection is not
could be an ip address move, but in that case connection should reset
and nfs client should reconnect.
>
> Note that you could circumvent the above restriction by adding a
> revalidating step.
> i.e. in order to figure out if the cached addresses and connections are
> still valid and preferred, call GETDEVICEINFO after receiving the first
> LAYOUTGET to re-reference the cached device id.
Didn't get this, GETDEVICEINFO should be already happening after
LAYOUTGET, so if there is change in device info it will get it.
>
> However given that we usually keep layouts around until the delegation
> is returned (assuming the server handed us one), we should be caching
> these connections for a minute or so already.

We have enabled only read delegations, so this is unlikely to help.

Regards,
Gaurav



>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

