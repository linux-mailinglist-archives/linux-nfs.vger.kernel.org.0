Return-Path: <linux-nfs+bounces-18456-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F2YJCOkdmnnTgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18456-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 00:15:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D9831C8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A897300351C
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106821CAA68;
	Sun, 25 Jan 2026 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="EEJS0CjG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8E3EBF1B
	for <linux-nfs@vger.kernel.org>; Sun, 25 Jan 2026 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769382942; cv=pass; b=sWPpczBNnqlnzqWpcHrPNqedULSsY9NaczakOYK+2HzdRIu79iYmoXLQIRGGqGO8AY710xNKkMt0qNxRUD1lxDGbFfPayYuBgDB6MI86v03HRYlehv3vHPP55JF+Bs5F0cV4PMW7Qz5iZjhm/k44Abc6bwkxlYh42ieSLyeTZ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769382942; c=relaxed/simple;
	bh=TBAq1VsFDYAWxrJJaAmJpXA2koZbdXSZ4DT9jl6nJM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPcaFvaU2gzUYJFM7sRpK78FJbmd03BI4a67oCRKJIratO/JPydldGK2dwEy3mb41igqnCfhiw9HmNizhKrDGJRQ9R/BBLZ6xNUSfOsEh1vTUdCNNYzVi9DaKto3DsSJUKoluQljB+4uuPPD6Svq/uSZepJzA7Aag+iKoKAxQVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=EEJS0CjG; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso7878813a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 25 Jan 2026 15:15:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769382939; cv=none;
        d=google.com; s=arc-20240605;
        b=IkyxXA8pu07HOTlzSioXL0tymvhKfEcKZpWCtryMNdSicOBDwdu6XNeVUXnuKif7nK
         UE4LxnqpAJAfeLqZZDI5tp2uLgUs7mzcDuOzbnM91pOrdqQDjLe4eWfOIlV3Rwck6ejt
         GQmBEQRCZt8M3/IxG0RW/IcR00pKTOB/eNhb9jNLNnko+fvTy4avHOhY7IubhwagbjF1
         T+Gmd2/8E1uPGEnkAqS45oXnRkrBMYrbMIvcPeHfTXra6jJ5fqILPmK4SYHSbNdtvNHb
         1P2K6W4W/ODAtQvXWGgI+iIO8OPGbRv1Gq42iWTV9otoE0AfCTCNJGJWKKX+fhoZPPzI
         fuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9bslZBYF+rfYC7SYnIHBibktJ+5o6X+f+01Wzl/nLRc=;
        fh=wsBKygEep/cHveVY/v2X/TnrTtniMA9nP9j/TNgVkKg=;
        b=DZ5BcBxsQm4EmxPvJ6mcPsEVPwz/GJiLINqEpWTBgSb8WlMnDssk3yz/oqfbYwftRW
         zhM/GhFgsjRsR5UsAYqQQSLf/F+qR+TQwW1/RFfuPg08ieeeNM1F/gTx2DWpZwIrERNX
         bEQpYd6QF4UusBECEJPplaJuQ5M+mkc1Dpe0gh9ADEU/1vTMMBljax1WPcvzL1IsHZcv
         2UtTuLBU2Cn/MSdTeHt9EKAmnwlBj2At6zTyHmSd1JXX7MYZsdPGkPNjxv94j0XMbCPJ
         dZ/IC+QaBGpqlXML/IGDOLMYNc4qeB3ZW1fn3l/ZQeqVb5ihrVakdo0WGqU1YptXNPWp
         9JIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1769382939; x=1769987739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bslZBYF+rfYC7SYnIHBibktJ+5o6X+f+01Wzl/nLRc=;
        b=EEJS0CjGyLVoqOZsPTWTiaQo2NOMc+xPTHHAqTlCBBBY0wCl2jKcTMMJxZxlTOXF24
         KOufXC/2Wg+9n1k1zvU3u8bVtE/KGXl3JtSwvXR2Fb1e5Zs2XpjGqFNMksP0TFy7PG7W
         CM22z66RRgV/qQhBiyzyqAzT4tpJ2+7ac8/UuoCFIW55AwpJ5lFzMmEg3BJRzo8bVUF/
         h88nray2jbJXIR2/m9yEZRlx/oSYtRtxbNNasakuV+WoMK/i8ud1Lhz0AV/cxZWpUHVK
         ZuMDXRi0/eAZdi0jM7puuse1rFCtxYzlhKvwcv/iitL2Qh6IuXajF7Xp7+rjXJzfadlb
         IQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769382939; x=1769987739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bslZBYF+rfYC7SYnIHBibktJ+5o6X+f+01Wzl/nLRc=;
        b=u80lp7/1vvs1UZVcIw5Aq64hlbW9t357GwN3I1ToB4wvLoDbiGIJFs+zFo8P0/GCQe
         yOCHFVbMcurcLfCgTR/Z9fGBdXzLvPTequX23Ds7znyjO/R/xLqyxFfPWZB2Nn1dkWk1
         Qe5KyHEKXWttNOzTa5XevEjLt5xZiH/4RW8RCfc+DbpaVm2iZLsIvS3jCtPlE9XG8Yq3
         ECz/cAlArAjhPDtOOXB5xbDgr2hplFqhQ0imEfOTdcjToPrjRnaf9GHmcBPR824dNIrE
         aDcV6bTrqkss2529melNKO6RZ3R+Qp0R6WE9PEs1hSPO5xrqrveXITaa10sqfRa5r+Nf
         ABAA==
X-Gm-Message-State: AOJu0YxKslNTes0u81pNxsGSCL9q7X1inZr44sqa6emB/Df5wts+hGgz
	bMSR495WpEE6Dag/xyIGphDYR9UhuiU0LA8zqxsleyfidErGKi4DXyiJLQHys5kpXrUtLRUE1Ux
	NSvPO8eoF5KiIcdG2YzT313fY2fpPK0iEk+VaaQ0vsn9BabQ85khhBhg=
X-Gm-Gg: AZuq6aJ4VnltJS2NBJ2B98rkxGmM4sxclrkhGmpNfOxTkUUH71hn5nNyAu/5/MKyaw+
	OuobVF9AUTeST1B0D3noqM2sslQYPO8s1IF9SmEKIX/KxgBZfsubYtzIinKeuwdijj+CUp/bd1p
	oRnJxx85pOoDwew9k3NmRlqR9lD4kPuqihZGNjFRWvXij/HvnkqZLP8ZHFih8wBtZFpj1gCeE/m
	OrMU6kOyIvIsNBJltHalLJCfGyvoTq3se7OQcicDCLUylaJpZNndVWMjYUrRwPrUH++lQ==
X-Received: by 2002:a17:907:6d16:b0:b87:65c5:603a with SMTP id
 a640c23a62f3a-b8d2e6eb3b4mr186932466b.39.1769382939510; Sun, 25 Jan 2026
 15:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <dd2ac9c1-5656-499f-b97c-4c5155523330@oracle.com>
In-Reply-To: <dd2ac9c1-5656-499f-b97c-4c5155523330@oracle.com>
From: Daire Byrne <daire@dneg.com>
Date: Sun, 25 Jan 2026 23:15:03 +0000
X-Gm-Features: AZwV_Qgg2Dcil6jvx3583HFmeG9GqNnE25XTQVVWa3iwuLgx0Zs5RL81TgrH13c
Message-ID: <CAPt2mGOhR_XSifdTOCkRnTZ36mWgZXAHVxv=SCbonw0yLR8a_A@mail.gmail.com>
Subject: Re: knfsd read iops limits?
To: Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[dneg.com,quarantine];
	R_DKIM_ALLOW(-0.20)[dneg.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-18456-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@dneg.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[dneg.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dneg.com:dkim]
X-Rspamd-Queue-Id: F34D9831C8
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 at 21:01, Dai Ngo <dai.ngo@oracle.com> wrote:
>
>
> On 1/25/26 4:26 AM, Daire Byrne wrote:
> > Hi,
> >
> > We recently came across a workload that consisted of 100s of clients
> > under (cgroup) memory pressure and so their page cache was all but
> > exhausted. This resulted in lots of repeat small 4k-8k random reads
> > hitting our NFS servers which maxed out their CPUs and flatlined
> > performance.
> >
> > Uniquely, the data being read easily fit in the server's page cache so
> > there was no backend IO to limit throughput.
> >
> > The fix was to put in place a system to kill workloads under such
> > memory pressure. But it piqued my curiosity, so I decided to do some
> > simple benchmarks to see where the server limits are.
> >
> > I ran something like this across 200 client hosts simultaneously using
> > NFSv3 to reproduce:
> >
> >   fio --directory /hosts/nfs1/xfs1/ --name test-file --direct=0
> > --buffered=1 --size=1g --time_based --runtime=600s --bs=4096
> > --rw=randread --numjobs=2
> >
> > By reading the same small file from many hosts, we are essentially
> > serving from server page cache so can rule out disk IO (I even tried
> > files on /dev/shm)
> >
> > The main things I found:
> > * across a wide range of server hardware, we top out around 300k-400k
> > read iops/s.
> > * whether the server has 24/48/96 cores, the results were pretty much the same.
> > * 24 knfsd threads is the optimal with more threads reducing
> > performance until threads=ncores
> > * multiple nics (bonded) or single socket (no numa) makes little or no
> > difference
> > * different nic hardware make little difference (2x100g, 4x25g,
> > broadcom, mellanox etc).
> > * various network tuning (queues, txqueuelen, qdisc, etc) makes little
> > difference.
> > * NFSv4.2 has less read iops/s (160k/s) but it also has sequence &
> > pufh ops too (+ 2x160k/s).
> > * increasing nconnect (>1) reduces aggregate read iops performance (8 -> 120k/s)
> >
> > It feels like there is some thread locking contention limitation such
> > that the number of CPUs and/or knfsd threads reaches some plateau and
> > throwing more cores/threads at the workload just results in more CPU
> > time spent spinning but you get no more performance out.
> >
> > The top level perf report looks something like the attached (for v6.18).
> >
> > Like I said, we can work around this pretty rare workload (random
> > small reads from server page cache), but it just piqued my interest as
> > to what the underlying (knfsd) server limit is (it doesn't seem to be
> > hardware).
>
> Have you tried to increase the slot table on the NFS client side?
> By default it has 64 entries:
>
> # cat /sys/module/nfs/parameters/max_session_slots
> 64
> #
>
> Try to double it to see if that makes any different:
>
> # echo 128 > /sys/module/nfs/parameters/max_session_slots
>
> Maximum number of slots per session on the NFS server is 2048
> on the newer kernel, so that should be sufficient.

I guess I am less interested in improving the per client performance,
more the aggregate performance of the server. I did try your
suggestion, but it makes no difference to the server aggregate.

This random read 4k workload only requires around 100 client hosts to
saturate the server and the aggregate iops pretty much flatlines no
matter how many more clients you add (I tried up to 500 clients).

And this 300-400k iops limit is probably the maximum that anyone can
get, because I tested a wide range of hardware and kernel vintages.
The results are all very similar.

Daire

