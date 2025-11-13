Return-Path: <linux-nfs+bounces-16366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8394C5A4D1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 23:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C063A7628
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C4320CCD;
	Thu, 13 Nov 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ0Bn01F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0428405C
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072422; cv=none; b=dyMrCPODXXFe9AJE3S6uyGnapcyg7QqfBEbFxfBEa3i3q9bw/tI0e6ipk3hb98rLQiMRNn6itr0aTWWgFiALr8yYyjSaBazSvNg7qYQzQqG5w2tFodewV2fVsIpM0aTj9AQtkfTiifWIC+90ayVEOwL0/O37WuRVf/17LND7WtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072422; c=relaxed/simple;
	bh=q3qpMo01f8XaBD3HWLZ1JfzQDmrbrutVRvh9hYqKids=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlZAXDjsO/98iXNI9M0ij2RPstKDRka0D51+zRC5pfM0PWEiUW+pbhSe4JAMJis+2FscIfaLD+ILO6aXzl6R44Jui5lNJHaSVOv6XdAH2kHGJxChf25Ge1s7FL48T7pnDKqrPFMhlW7DUWMkJgsdBiUISVxed+JIioie5O3cNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ0Bn01F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b427cda88so961670f8f.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763072419; x=1763677219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxD6Va4nlrGdLx84AnZel4scwr9uai3z0FsuYN7KzXI=;
        b=cJ0Bn01FsO1/ybg+6F92/lu3Z5xKYHlZFL0ZZEGlfH8ns/bTCmRHOLetiD7t1fuXUZ
         x4KJfm2WwJIprceMuDGent6XFLgvNjxWZ0aovsuW+HPshf/xCGKy4hzj26nqJjSdxZlH
         S0RNgY8fVVdNqq3CQaNV+a4nkTb7JakPELFtgJvehKd0PFV9HvJt+AMUlhTCs/dLI4Gf
         RagvSwIHUlobTDN6B4YYXOM5ttf8XFtBGFI6rnHgizmd4ZnGmT9y+Nyff0W9khgHEcEk
         OSy3VWBjzLlPmbVl9hNV+xrrs4OsuGxQpy4QbCMqg8GzvWIdOWEXyV8p2xKB4bflGb5a
         ZguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763072419; x=1763677219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mxD6Va4nlrGdLx84AnZel4scwr9uai3z0FsuYN7KzXI=;
        b=BCjk53cTUjjnbqFhw4xIVVBQ/e50daFZDwIjTHq4f6ArVp0JQc0enUU9JNoKmUgED7
         rao//Eho+Su2tw/tr1BC5OF7B8KJUzY78m5GPtlxbV4QfZfSsgx1PJ9pLAkZC+URcUgl
         evHlvcLGOKFz7L+T0Fu5nHyyXI9O7MXM6/nyP15c2fA2dQCOHlREsDrQCNWePsu9PPnO
         6P401v8/x/ezmBQjQWZVNxZdkn5Zh4yz11OO5uAz0ZaCNg49ut7bjXKvWfdlB3WQOQLB
         Cz0630v8ME2kVdPR0K0T1SPRlRrKFQYRp4Avf3cNu8bQvKNussRknRX/pzMRRCLCLP/I
         aZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9U95Jg87unsNuQL23oP0MZKso0dQB6EnWes1yQkdrKzSyOrrUGerpw8ZrMo6LyZBxxcpxFTcmFEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaYlH91rAFIP0gIoHe19qs3f1M6dWJRT/VHEEZpbhtTSdQv3a
	A63QpwvCIT4HNTw7UGoUFYKqTupBK50ipID1rEcBj79E2dNpIhW8p0kB
X-Gm-Gg: ASbGnctQxLlOZQZfdnL5qJTAg3R2pO2lTK2xdHwaFsrYkzq4dvxMdjJJL3Y9snEQe8x
	2oI6JCcGjGh+tzTMhKB5jOVxorC9d/DeDHC63m+c0phO5k9WPK0rbMOoJZn4CtiVvF++TN95kDv
	weRV/2K1Pn0ROCSxwlJuCQUj3x7QuV7ZXbYdr3Kp9RplX31Grfj0l+dO6ixwC8Yyq681D8bjjrh
	0rNlTTtN8Z4K675gLOvZjwTyxIvoRw7ha557KBQ5kklvg6RbXiyMRX5gb+cGeYvFVm05jaoM28j
	lWOdBWsd/DQ1FBOnVYXfHyK7otFUsSiJ3nmNvh5zF4UG3axVK6Cy8rSZQGng9HQAdSyfoZwAB22
	paGZRuYHCP1fzYkF2hr8EGz6gVApEqBUFGGHYCMAxNHUz9ILZGJt+R4lR7ZWjMc1rRtTf26yeMi
	/roqA0BMqaYO3U0sNq/lzfmI3bNzai+CSDQA==
X-Google-Smtp-Source: AGHT+IEZr/jgTUzIzh92CEqHXY9JBpXDSThmF8hDmL5x+X3hWg9F2OP0W6O2TCfdZmtA3yVNYmboqg==
X-Received: by 2002:a05:6000:2f83:b0:429:d3e9:694 with SMTP id ffacd0b85a97d-42b5932360dmr897283f8f.5.1763072418673;
        Thu, 13 Nov 2025 14:20:18 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e982d6sm6400196f8f.21.2025.11.13.14.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 14:20:17 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id D2AD4BE2EE7; Thu, 13 Nov 2025 23:20:16 +0100 (CET)
Date: Thu, 13 Nov 2025 23:20:16 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Tyler W. Ross" <TWR@tylerwross.com>,
	"1120598@bugs.debian.org" <1120598@bugs.debian.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Scott Mayhew <smayhew@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
Message-ID: <aRZZoNB5rsC8QUi4@eldamar.lan>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <aRZL8kbmfbssOwKF@eldamar.lan>
 <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>

Hi Chuck,

On Thu, Nov 13, 2025 at 04:23:52PM -0500, Chuck Lever wrote:
> On 11/13/25 4:21 PM, Salvatore Bonaccorso wrote:
> > Hi Chuck,
> > 
> > On Thu, Nov 13, 2025 at 12:47:23PM -0500, Chuck Lever wrote:
> >> On 11/13/25 12:16 PM, Tyler W. Ross wrote:
> >>> Thanks, Chunk.
> >>>
> >>> Suggested trace-cmd report from the client follows. Last 3 lines appear salient, but I've included the full report just in case.
> >>>
> >>>           <idle>-0     [001] ..s2.   270.327040: xs_data_ready:        peer=[10.108.2.102]:2049
> >>>    kworker/u16:0-12    [001] ...1.   270.327048: xprt_lookup_rqst:     peer=[10.108.2.102]:2049 xid=0x7b569c7a status=0
> >>>    kworker/u16:0-12    [001] ...2.   270.327050: rpc_task_wakeup:      task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=0x6 status=0 timeout=15000 queue=xprt_pending
> >>>    kworker/u16:0-12    [001] .....   270.327054: xs_stream_read_request: peer=[10.108.2.102]:2049 xid=0x7b569c7a copied=988 reclen=988 offset=988
> >>>    kworker/u16:0-12    [001] .....   270.327055: xs_stream_read_data:  peer=[10.108.2.102]:2049 err=-11 total=992
> >>>               ls-969   [003] .....   270.327062: rpc_task_sync_wake:   task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
> >>>               ls-969   [003] .....   270.327062: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=xprt_timer
> >>>               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
> >>>               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_decode
> >>>               ls-969   [003] .....   270.327063: rpc_xdr_recvfrom:     task:00000008@00000005 head=[0xffff8895c29fef64,140] page=4008(88) tail=[0xffff8895c29feff0,36] len=988
> >>>               ls-969   [003] .....   270.327067: rpc_xdr_overflow:     task:00000008@00000005 nfsv4 READDIR requested=8 p=0xffff8895c29fefec end=0xffff8895c29feff0 xdr=[0xffff8895c29fef64,140]/4008/[0xffff8895c29feff0,36]/988
> >>
> >> Here's the problem. This is a sign of an XDR decoding issue. If you
> >> capture the traffic with Wireshark, does Wireshark indicate where the
> >> XDR is malformed?
> >>
> >> If it doesn't, then there is some problem with the client code. Since
> >> Fedora 43 is working as expected, I would guess there's a misapplied
> >> patch on Debian 13's kernel...?
> > 
> > if it is helpful: Debian follows the stable upstream releases (6.12.y
> > for trixie/Debian 13, right now 6.17.y for Debian unstable) and we try
> > to keep the patches limited which we apply on top. So far I see none
> > which touches net/sunrpc/. The patches applied:
> > https://salsa.debian.org/kernel-team/linux/-/tree/debian/6.17/forky/debian/patches?ref_type=heads
> > (in case this could help narrowing down more the issue).
> > 
> > But we could try here additionally, if Tylor has the possibility to do
> > so, to try directly the 6.17.7 upstream version without Debian patches
> > applied.
> 
> A bisect between broken v6.12.y and working v6.17.7 could identify
> what is possibly missing from v6.12.y.

There seems to be a missundestanding? 6.17.7 as present in Debian
unstable is neither working, at least Tyler said:

> 2. Freshly installed Debian sid via mini ISO (2025-11-01). Same
> configuration as 1/above.

which includes a 6.17.y based kernel (6.17.7-1).

Regards,
Salvatore

