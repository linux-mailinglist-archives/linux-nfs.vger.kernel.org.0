Return-Path: <linux-nfs+bounces-16362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9818C5A17C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B7FD4E735E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04AE3168F5;
	Thu, 13 Nov 2025 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd4hb4Z7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC10314B8F
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068920; cv=none; b=e0RHsyPsy0o9bzqfnc0hALntkc+AhSjfMw1lsRHtRh5bW7wqPCDpdGorKKAZaHeGmIxejDPRsnWK1i1XprvpZ+rN9bj+lzCHvruefpe9IecUO8dKzs7nxZEXh90xGfsUfM+iwOCnWD2i1iT5JJE93pKl7ZoqXqQe8X4uUoLPEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068920; c=relaxed/simple;
	bh=TjDU/af5FiAhFROINzGit2UUjQ3aPYBQkK+NOxk+7eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZC6Pls6sqKzCKl7ArNTuV0H1CIH7MwuyZxlOYNwcio6z73aLCd6b603ZSfdmSzv6pnRGp87BfqpXm3Oq/urHiq48fI4zZOuxw41uhN6TwAq9+IswmqRO5+RxgdSU519HJm/RFQdarZmxY91AKehkuKOXP1C+4x08RDJ184yHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd4hb4Z7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1078509f8f.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763068916; x=1763673716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoHlN1Uh/L/WCMIqqxrIQUNXoefV1yby25Jl36zSEDw=;
        b=Rd4hb4Z7vYqhidTfUJC4XKaWaA/Koi6CAWMKcKHRgzVe43rV4BD9vSk82ci9yqzF/1
         wMXCV068w1G5pn6ps0l60ECdvsdzEIoCs/dmUNFDq9QW5xmmM7NqfrOyUDS4dVKCOyPL
         jbbmQKVsBxOb6wQl2YiYJ0COmEeOq9UJrm/laZEZ9xU5BggVMpzpP/7AQOLFn/Zn6QJQ
         fiW/UO8CR4rD+si+ExJnh8G2FBz3yBXgkdV5VPjGEhHcCQkizAxdGkDEOqnkIuDYGl/4
         EGY59QExRzq+Vy678kgpbmeBzOMC8cCcZosGLD/IvkOgc4BHGNFtS13+vLCWlEi/0Sz+
         DdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763068916; x=1763673716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VoHlN1Uh/L/WCMIqqxrIQUNXoefV1yby25Jl36zSEDw=;
        b=kwBh+TjIkhX/k7lLGPRa9sl3eQDI0UfVCfJgsaxdQvP4IEPyDxN/t3eQsLxoAjsL21
         AQgTfTk6bv4MPI0v35lQhxPLPTpD1nSxu7cB18s3ecUhNc1WSFEFsGrxKVx7jz7kVKTf
         fjKQ/qIVhtsjyXtXxRiABCEjtYMIh1/W5gwrzWZJUJ6zIVmysYQe4mB7Z2ANhCtVldt7
         dXaeNsSFxoqcYe/XIK8APyK5T7EmIUaZmmlbfoFIMs5oH4Om4CIwtHQYDL0MvTLLDb4u
         bRRQY2Xy8090ILuxut9qebcTENS7Jaa6VJrN+AdClpDtxPLTdqK+QQNEHxmoNr1Ndikc
         grNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IuJU2kDsASNhJ9mnOzzGDJUgh3nt/xLGc2gDulpFtDdyUA5pQFyEQFM8wbgIkY+4Dpwxawc47UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwvbeC35Q/527dF/UM5CxoQ6rhqKYGp4J+8fbpTUiYCV3n/PD
	T3Z2CjoOSg4EzTGZ34op7byHTp31CsZjBb5OCCQ0NALkSJWgxUg0t1lH
X-Gm-Gg: ASbGnctkwWAY55Ojgb30wPh9yl/xlct+ol6psa0/dVrPi/4e6T5Gkj3lEKPUUdn3zU7
	sLgNrtX8b67q9zT7zPXkbMRwKr50eGrojlP5XZmBpGnA3+R+yePwT0XKsmLtO/fTDB829UXTV3c
	HDvyGRITo22Y9bPz3EjNtrAM94Ht1NqVmFrP5bUNmhW0kMotfQsjIkgg/CJsDsyK6GEWCdno121
	nbIKAi3mH3iFSnxNvpIEKJ23W60zAO8P9BLQJkmMLyR1zhXb+P3kOj32zGSSJ86a4gF5rfhk+ly
	mpJWtBsl/syopBNQuxj1HEknBNOn+LU25sbm6ZsyzRWYzbEp06c3Z608COPuMVWaZNwzZDBTEe5
	H/5xvSriGov5V8AFub7lrKg0UZbEis573/9upd8w8lgm+5N2VsW99Jc9uUUPVdcUes+Nu1Sn1tc
	6Vv+Vti/d2PqwAYg58YEIeYxpvVhG0wouOnA==
X-Google-Smtp-Source: AGHT+IGgdlQfJ5OD5HJ3tyT6iHcoRgEsMixVoGakZcW9KLWIBx8U/Y3z4mMK6LTxbeNZ0lbK+OCTag==
X-Received: by 2002:a05:6000:1447:b0:42b:3a84:1ee6 with SMTP id ffacd0b85a97d-42b5934e2d7mr692084f8f.24.1763068916210;
        Thu, 13 Nov 2025 13:21:56 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b513sm5950645f8f.30.2025.11.13.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:21:54 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0BDE7BE2EE7; Thu, 13 Nov 2025 22:21:54 +0100 (CET)
Date: Thu, 13 Nov 2025 22:21:54 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Tyler W. Ross" <TWR@tylerwross.com>,
	"1120598@bugs.debian.org" <1120598@bugs.debian.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Scott Mayhew <smayhew@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
Message-ID: <aRZL8kbmfbssOwKF@eldamar.lan>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>

Hi Chuck,

On Thu, Nov 13, 2025 at 12:47:23PM -0500, Chuck Lever wrote:
> On 11/13/25 12:16 PM, Tyler W. Ross wrote:
> > Thanks, Chunk.
> > 
> > Suggested trace-cmd report from the client follows. Last 3 lines appear salient, but I've included the full report just in case.
> > 
> >           <idle>-0     [001] ..s2.   270.327040: xs_data_ready:        peer=[10.108.2.102]:2049
> >    kworker/u16:0-12    [001] ...1.   270.327048: xprt_lookup_rqst:     peer=[10.108.2.102]:2049 xid=0x7b569c7a status=0
> >    kworker/u16:0-12    [001] ...2.   270.327050: rpc_task_wakeup:      task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=0x6 status=0 timeout=15000 queue=xprt_pending
> >    kworker/u16:0-12    [001] .....   270.327054: xs_stream_read_request: peer=[10.108.2.102]:2049 xid=0x7b569c7a copied=988 reclen=988 offset=988
> >    kworker/u16:0-12    [001] .....   270.327055: xs_stream_read_data:  peer=[10.108.2.102]:2049 err=-11 total=992
> >               ls-969   [003] .....   270.327062: rpc_task_sync_wake:   task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
> >               ls-969   [003] .....   270.327062: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=xprt_timer
> >               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
> >               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_decode
> >               ls-969   [003] .....   270.327063: rpc_xdr_recvfrom:     task:00000008@00000005 head=[0xffff8895c29fef64,140] page=4008(88) tail=[0xffff8895c29feff0,36] len=988
> >               ls-969   [003] .....   270.327067: rpc_xdr_overflow:     task:00000008@00000005 nfsv4 READDIR requested=8 p=0xffff8895c29fefec end=0xffff8895c29feff0 xdr=[0xffff8895c29fef64,140]/4008/[0xffff8895c29feff0,36]/988
> 
> Here's the problem. This is a sign of an XDR decoding issue. If you
> capture the traffic with Wireshark, does Wireshark indicate where the
> XDR is malformed?
> 
> If it doesn't, then there is some problem with the client code. Since
> Fedora 43 is working as expected, I would guess there's a misapplied
> patch on Debian 13's kernel...?

if it is helpful: Debian follows the stable upstream releases (6.12.y
for trixie/Debian 13, right now 6.17.y for Debian unstable) and we try
to keep the patches limited which we apply on top. So far I see none
which touches net/sunrpc/. The patches applied:
https://salsa.debian.org/kernel-team/linux/-/tree/debian/6.17/forky/debian/patches?ref_type=heads
(in case this could help narrowing down more the issue).

But we could try here additionally, if Tylor has the possibility to do
so, to try directly the 6.17.7 upstream version without Debian patches
applied.

Regards,
Salvatore

