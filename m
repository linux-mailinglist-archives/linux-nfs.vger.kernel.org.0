Return-Path: <linux-nfs+bounces-14042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F56CB442D9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D080A62138
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6371302CC8;
	Thu,  4 Sep 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiIyztLM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCF23507B
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003585; cv=none; b=u2PjvgX9a2Ht9lTeNirVX7N6+uZGpHOOcPKp0IFkgg9ST4914FIaa/nm9/usY9lL2mfJit5nK9R0YyPa21P6O1frMGjbK11wsHbR/1A0Zsxp1LPuYRnnup3JKqeilwnOMKhNUffKQtZRtSpcft0GwnOtsC2DN0vtUDXD7N+jdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003585; c=relaxed/simple;
	bh=SqjskM7dnqaPMufRBGiY63yd9KaPyCw/5fGslfni1Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBHuLd0HUZ7wlzNzSHci+LZpGIuc9PjAy0qRUN6OWesBjjQFovPX9rtLyEuvse2z2NTcg8uOvX3VEIJkM+XD78oqrmssLSY2I/5PizBaUMdz0ScGxevq0ktreXYeV25BRiqDBnF/kNUleJ6EiiH1Xhjfd9pXwcQussxHVTTJGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiIyztLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC6DC4CEF0;
	Thu,  4 Sep 2025 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003585;
	bh=SqjskM7dnqaPMufRBGiY63yd9KaPyCw/5fGslfni1Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiIyztLM2EPJvvUd7WXRRruarSjIc1ZVTi1S1RO1BC+e6gr9MK6MSyaBWZIGuMnVB
	 XGUMjIwFUGxn8KsRV4Z2q3acsvFi8VbFrFBhDZiBQ/Y2mbjreiNu7aNHNrMAAtzmpR
	 zHppU1i3GFkwS24GfFj2QAT1ypjSCCp0NFeDZs1bZXTWmNMVw/ynRyWEOjero4ROo+
	 AsVPBLInZv0Z01b0puPyxuRws2QBymxYn5qIw21wE5Fr3aIs6aHAQYwYZrpvfZO3Qe
	 p9HLRPUp13rhSrVQHlWMcjYNVxdSV72yCdhbeqe3UUrl5BWuFOOzLb+JfyPOa0tyUw
	 EFiGb3EJu3yHQ==
Date: Thu, 4 Sep 2025 12:33:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a
 start_extra_page, exposes rpcrdma bug?
Message-ID: <aLm_PxH2FJc7PVZ1@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
 <20250830173852.26953-2-snitzer@kernel.org>
 <2559f795-bdc9-4d39-aa03-e6a6d89e9f84@oracle.com>
 <92908105-9261-42f9-a0fd-ebfaf3e2f564@oracle.com>
 <aLdcbnELMGHB-B_E@kernel.org>
 <18b20826-3c9f-4763-b0ac-c7f1dc2be4d4@oracle.com>
 <aLdhL7xFxR-r7H_m@kernel.org>
 <aLmlY-xdYh73UaAf@kernel.org>
 <3e877306-6e1b-4428-8a1c-e0bf4e768367@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e877306-6e1b-4428-8a1c-e0bf4e768367@oracle.com>

On Thu, Sep 04, 2025 at 12:10:00PM -0400, Chuck Lever wrote:
> On 9/4/25 10:42 AM, Mike Snitzer wrote:
> > On Tue, Sep 02, 2025 at 05:27:11PM -0400, Mike Snitzer wrote:
> >> On Tue, Sep 02, 2025 at 05:16:10PM -0400, Chuck Lever wrote:
> >>>
> >>> I am testing with a physically separate client and server, so I believe
> >>> that LOCALIO is not in play. I do see WRITEs. And other workloads (in
> >>> particular "fsx -Z <fname>") show READ traffic and I'm getting the
> >>> new trace point to fire quite a bit, and it is showing misaligned
> >>> READ requests. So it has something to do with dt.
> >>
> >> OK, yeah I figured you weren't doing loopback mount, only thing that
> >> came to mind for you not seeing READ like expected.  I haven't had any
> >> problems with dt not driving READs to NFSD...
> >>
> >> You'll certainly need to see READs in order for NFSD's new misaligned
> >> DIO READ handling to get tested.
> > 
> > I was doing some additional testing of the v9 changes last night and
> > realized why you weren't seeing any READs come through to NFSD:
> > "flags=direct" must be added to the dt commandline. Otherwise it'll
> > use buffered IO at the client and the READ will be serviced by the
> > client's page cache.
> > 
> > But like I said in another reply: when I just use v3 and RDMA (without
> > the intermediary of flexfiles at the client) I'm not able to see the
> > data mismatch with dt...
> > 
> > So while its unlikely: does adding "flags=direct" cause dt to fail
> > when NFSD handles the misaligned DIO READ?
> Applied v9.
> 
> Multiple successful runs, no failures after adding "flags=direct".
> Some excerpts from the last run show the server is seeing NFS
> READs now:
> 
> Filesystem options:
>   rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,
>   fatal_neterrors=none,proto=rdma,port=20049,timeo=600,retrans=2,
>   sec=sys,mountaddr=192.168.2.55,mountvers=3,mountproto=tcp,
>   local_lock=none,addr=192.168.2.55
> 
> nfsd-1342  [004]   463.832928: nfsd_analyze_read_dio: xid=0x89784d89
> fh_hash=0x024204eb offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
> nfsd-1342  [004]   463.833105: nfsd_analyze_read_dio: xid=0x8a784d89
> fh_hash=0x024204eb offset=47008 len=47008 start=46592+416
> middle=47008+47008 end=94016+192
> nfsd-1342  [004]   463.833185: nfsd_analyze_read_dio: xid=0x8b784d89
> fh_hash=0x024204eb offset=94016 len=47008 start=93696+320
> middle=94016+47008 end=141024+288

OK, thanks for testing!

So yeah, patch 9/9 of v9 does workaround the problem relative to
flexfiles+RDMA (though patch header should really be updated to add
"flags=direct" to the dt command line):
https://lore.kernel.org/linux-nfs/20250903205121.41380-10-snitzer@kernel.org/

Is it a tolerable intermediate workaround you'd be OK with?  To be
clear, I'm continuing to work the problem (and will be discussing it
with Trond)... but its a tricky one for sure.

Mike

