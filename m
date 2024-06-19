Return-Path: <linux-nfs+bounces-4057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FF90E48D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1B1F213AA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10207603A;
	Wed, 19 Jun 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="kHAA1aDK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAE47F59
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782352; cv=none; b=efz1aV9PkJW61Rxbmz8qNeL+AyWbV2KAW8Np2HOCyz29d67+WET9T/efSbZmty1nJ1nS54pI9Ud8zyCslr7VuAAy9vpJSt8rYwCMZIpP2ntt+s/gElFRVFT61QW3UM4RdYUbgOaoNAiFNnG5cVqZS3nlm9zUCIJmWYGAy1E8YB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782352; c=relaxed/simple;
	bh=DCAu6t5pcRXYs5HyZM2YIz1I6yu4Zs+38FdhbHE3Ilc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPgVrQBLhk8QR79Mo49mpKQ73PmOHqn+jPLYmHi+wKEMMsHRgF8PcgdlIK1jlHptFlqIQ8QN6uSW0q0fkTqqbjSNosaRZOvKV+RiDdvzJNAArLJ1Doaj+AJnDz2zeT1ZRxpBB/dx0SAJfm+dEB6S11XLjc7ZbpLqZ46sBkkhPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=kHAA1aDK; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=DCAu6t5pcRXY
	s5HyZM2YIz1I6yu4Zs+38FdhbHE3Ilc=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=kHAA1aDK4NBBL2Dnl3O9znkEPLjUMIw6GhVV8l9e
	I7GCulg7fqQoIVLvwctzzLBWGF7jCLvmsEn2tcQ+Ru0bbNOApfcKKRT99dpHXHvWDVPeXQ
	8yN4Q8lOs1Qwr3UWGDQZ8KcE5jzQZt1t94DUUR+h3hPKLz5Y8NupKSqXmoXYY=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id f83f6d54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Jun 2024 09:32:24 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 45J7WNnW990680
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 19 Jun 2024 09:32:23 +0200
Message-ID: <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
Date: Wed, 19 Jun 2024 09:32:23 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: nfsd becomes a zombie
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
 <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-06-18 16:52:00, Chuck Lever wrote:
> 
> I can find no NFSD or SUNRPC changes between v6.1.85 and v6.1.90.
> Between v6.1.76 and v6.1.85, there are 48 NFSD changes, 8 changes to
 > fs/nfs/, and 3 changes to net/sunrpc/.
 > > Are there any NFS client changes during the second half of May that
> correlate with the NFSD misbehavior?
> 
> 
There was a big change: Most clients (>100) were upgraded from Debian
11 to Debian 12 within the last couple of months. A big chunk of
about 40 hosts have been upgraded on May 21st. This included the
kernel upgrade to 6.1.xx, and the upgrade of the "nfs-common" package
from version 1.3.4 to 2.6.2.

The current nfs-common package provides these tools:

/sbin/mount.nfs
/sbin/mount.nfs4
/sbin/rpc.statd
/sbin/showmount
/sbin/sm-notify
/sbin/umount.nfs
/sbin/umount.nfs4
/usr/sbin/blkmapd
/usr/sbin/mountstats
/usr/sbin/nfsconf
/usr/sbin/nfsidmap
/usr/sbin/nfsiostat
/usr/sbin/nfsstat
/usr/sbin/rpc.gssd
/usr/sbin/rpc.idmapd
/usr/sbin/rpc.svcgssd
/usr/sbin/rpcctl
/usr/sbin/rpcdebug
/usr/sbin/start-statd

I have 3 clients with more recent kernel versions 5.10.209, 5.10.218
and 6.7.12. The 5.10.x hosts are running Debian 12 and this kernel
for several months, but the host with 6.7.12 is running this kernel
since May 16th.

These "backports" kernels were installed for testing purposes. Would
you recommend to downgrade these kernels to 6.1.90?

As asked before, do you think the problem could be related to running
nfsd inside an LXC container?


Regards
Harri

