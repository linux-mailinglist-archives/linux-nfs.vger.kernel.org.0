Return-Path: <linux-nfs+bounces-3989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B716C90D5BE
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C98287B97
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBE18EFF3;
	Tue, 18 Jun 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="dP0pTa09"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D306142E9E
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721012; cv=none; b=WFv3diJr4JaALOGoM5DetKThjuMRmIm+o/mJ28/6PpSPDWAYsWKGSkZbcBvWpaCBj48PlqIJ2JBh0KUU2S7+1s1GWrYa4IGtjToHLMHft8FvpEU2ufZ0H9QEHKkUnhjKx95iGLF2HDotShLNKxT8PpW3URy848d5s0t30i0IFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721012; c=relaxed/simple;
	bh=m+lufUCVJy8Qq6t2fyvRq59q+gXkYSrez1SCu5tFaAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5qjrQbAXKlRUVAYQl6QXqf6+42ePThSXTSdDfEN1z3TuyzwnfNPNwULrOharE255rSprbeVh0lMsSixhoqZdlKF233TZf+Dj1/mQRenMmHfgcwm7nFjBKrK6DqtV2rTbeBhwc8i7AL6gZKSOQ2/m97+rsQXZVH3nTtOSOD+FOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=dP0pTa09; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=m+lufUCVJy8Q
	q6t2fyvRq59q+gXkYSrez1SCu5tFaAM=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=dP0pTa09XEB/7I5PHoEqMTvvQmxRt8SiUGpk0e++
	2gl8/7AKoeNB3jLj3IBsZUyyIIaHVwuoaXBDW6iN/pmbF8tMpeFclcTGzaEqjGWTR/VXFL
	b+uV+AHkQDbh0mrXabLOtuBaq3TEIh3LGfKrijx3smQmedkAmlcJG4BcD69Yk=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 9a2eb13f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 16:29:56 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 45IETt8E833597
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Jun 2024 16:29:55 +0200
Message-ID: <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
Date: Tue, 18 Jun 2024 16:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: nfsd becomes a zombie
To: Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-06-17 21:20:54, Calum Mackay wrote:
> 
> Harald: do you have a Debian/Ubuntu kernel version that doesn't see the
> issue, please? i.e. ideally from the same 6.1.y series…
> 

I had migrated the Server from Debian 11 to Debian 12 on Dec 11th 2023.
The kernel version provided by Debian 11 at that time was 5.10.197. I
can't remember having seen a frozen nfsd with this version.

Since Dec 11th I had these kernels in use (all provided by Debian):

	6.1.66			linux-image-6.1.0-15-amd64
	6.1.69			linux-image-6.1.0-17-amd64
	6.1.76			linux-image-6.1.0-18-amd64
	6.1.85			linux-image-6.1.0-20-amd64
	6.1.90			linux-image-6.1.0-21-amd64

These are all "upstream" version numbers. The second column lists
Debian's package names.

AFAIR nfsd got stuck only on the 6.1.90 kernel (installed and booted
on May 18th, first time freeze on May 26th). But I've got a weak
memory in cases like this. I haven't found older kernel log files.

Please remember that I have seen a frozen nfsd only 3 times since
May 26th. Its not easy to reproduce.


Regards

Harri

