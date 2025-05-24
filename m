Return-Path: <linux-nfs+bounces-11895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89889AC2FFE
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E6B7AD9F8
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A356072633;
	Sat, 24 May 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiOZapmE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1B33E4
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748097207; cv=none; b=Vqpqby9tQDXl1GJAP4hShqXaO5uVDgUG8QvSUFRizn8IpyER6D6qMFPp7cpv3XG1SuciDmvstHwq26l3QZwhxrmjzP1j5yXHpgNZestxwTbT2XRkqy2C+IGi3BZEOcWh+bVNDtkU4P8atFiQehmZg29ucTTYq7vdB89dQpJcj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748097207; c=relaxed/simple;
	bh=Yw5ALNNCXtStH0tsGsL/m5skRR4dGsYlI4zkT+wqlok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABXVOBhp/Spc2ugkEiZXjaS7dBUpv+nZX+aYkVxiY6Q0VhffUNIRxfB7qUNqsI9R8nlBkwfOckSKV/cM63UxSgt+ZRAylxdLFdCNZ4oc9Geyif3sWopn6TrtwsHaInewCOjGQLTKTETqEJGvZi8S1WkmYYDjffyn3wRDwF4LtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiOZapmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC80C4CEE4;
	Sat, 24 May 2025 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748097206;
	bh=Yw5ALNNCXtStH0tsGsL/m5skRR4dGsYlI4zkT+wqlok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiOZapmEUUxMrSX21r2VCtU3O47zPqWciGAYkioGL7vVYGELTa6qYbBpiAZO5Rwxr
	 Mq7PBLbJyFkX26/QzHU5ACeIp2gjYkfEJKOAZ2rTW7W2e/cC22A2W/4Kgz7+rjDGqP
	 d/BUWuIsRuptIq1viViRGpcIG94ijyog+PJuHvc9tfUSVDoXUcbckjd8Ec0CA50ivi
	 IJyI24yZLwXteWzvQE4CeOJ8Izr9NM5/kqZts1sDjFp/mCw4qbsUmMJaXNbblomK+C
	 UdUIJSWoVTObn+lRvKwsxzxItPgd3S/8SbtD65k/Y75JY/wOvtQG2iVg5Un9AY38PG
	 ET8T/3v2c+ppg==
Date: Sat, 24 May 2025 10:33:25 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: steved@redhat.com, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>, linux-nfs@vger.kernel.org
Subject: Re: unable to run NFSD in container if "options sunrpc
 pool_mode=pernode"
Message-ID: <aDHYtTJxeAr5FDRK@kernel.org>
References: <aDC-ftnzhJAlwqwh@kernel.org>
 <f93f70ce429f2dd6d11f6900808fc4ab737f765f.camel@kernel.org>
 <aDD0VxdSk0O6LdFG@kernel.org>
 <6bb9e9cce27e2a222bf55e272d690aab8f0eef13.camel@kernel.org>
 <aDEAJzELBTH0CqHI@kernel.org>
 <aDFCuXj2JBQuv-Yd@kernel.org>
 <73c6caaa51804da9ae850ee65b6ab51640706d74.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c6caaa51804da9ae850ee65b6ab51640706d74.camel@kernel.org>

On Sat, May 24, 2025 at 08:05:19AM -0400, Jeff Layton wrote:
> On Fri, 2025-05-23 at 23:53 -0400, Mike Snitzer wrote:
> > On Fri, May 23, 2025 at 07:09:27PM -0400, Mike Snitzer wrote:
> > > On Fri, May 23, 2025 at 06:40:45PM -0400, Jeff Layton wrote:
> > > > On Fri, 2025-05-23 at 18:19 -0400, Mike Snitzer wrote:
> > > > > On Fri, May 23, 2025 at 02:40:17PM -0400, Jeff Layton wrote:
> > > > > > On Fri, 2025-05-23 at 14:29 -0400, Mike Snitzer wrote:
> > > > > > > I don't know if $SUBJECT ever worked... but with latest 6.15 or
> > > > > > > nfsd-testing if I just use pool_mode=global then all is fine.
> > > > > > > 
> > > > > > > If pool_mode=pernode then mounting the container's NFSv3 export fails.
> > > > > > > 
> > > > > > > I haven't started to dig into code yet but pool_mode=pernode works
> > > > > > > perfectly fine if NFSD isn't running in a container.
> > > > > > > 
> > > > 
> > > > Oops, I went and looked and nfsd isn't running in a container on these
> > > > boxes. There are some other containerized apps running on the box, but
> > > > nfsd isn't running in a container.
> > > 
> > > OK.
> > > 
> > > > > I'm using nfs-utils-2.8.2.  I don't see any nfsd threads running if I
> > > > > use "options sunrpc pool_mode=pernode".
> > > > > 
> > > > 
> > > > I'll have a look soon, but if you figure it out in the meantime, let us
> > > > know.
> > > 
> > > Will do.
> > > 
> > > Just the latest info I have, with sunrpc's pool_mode=pernode dd hangs
> > > with this stack trace:
> > 
> > Turns out this pool_mode=pernode issue is a regression caused by the
> > very recent nfs-utils 2.8.2 (I rebuilt EL10's nfs-utils package,
> > because why not upgrade to the latest!?).
> > 
> > If I use EL9.5's latest nfs-utils-2.5.4-37.el8.x86_64 then sunrpc's
> > pool_mode=pernode works fine.
> > 
> > And this issue doesn't have anything to do with running in a container
> > (it seemed to be container related purely because I happened to be
> > seeing the issue with an EL9.5 container that had the EL10-based
> > nfs-utils 2.8.2 installed).
> > 
> > Steved, unfortunately I'm not sure what the problem is with the newer
> > nfs-utils and setting "options sunrpc pool_mode=pernode"
> > 
> 
> I tried to reproduce this using fedora-41 VMs (no f42 available for
> virt-builder yet), but everything worked. I don't have any actual NUMA
> hw here though, so maybe that matters?
> 
> Can you run this on the nfs server and send back the output? I'm
> wondering if this setting might not track the module option properly on
> that host for some reason:
> 
>     # nfsdctl pool-mode

(from EL9.5 container with nfs-utils 2.8.2)
# nfsdctl pool-mode
pool-mode: pernode
npools: 2

(on host)
# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 11665 MB
node 0 free: 9892 MB
node 1 cpus: 8 9 10 11 12 13 14 15
node 1 size: 6042 MB
node 1 free: 5127 MB
node distances:
node   0   1
  0:  10  20
  1:  20  10

(and yeahh I was aware the newer nfs-utils uses the netlink interface,
will be interesting to pin down what the issue is with
pool-mode=pernode)

