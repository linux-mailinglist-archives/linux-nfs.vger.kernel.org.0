Return-Path: <linux-nfs+bounces-4578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915CC925209
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 06:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499B228F2E0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 04:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB32262A3;
	Wed,  3 Jul 2024 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="iUa6CHYm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB917C96
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980055; cv=none; b=EQ40IGDRjQuNTBiryBOoFcs7/T6I/KViOXGSBbq0LnXQjS18DkenHeD4w2kImbLvtkNHCuASQ5eiYM1QqVmur4vBUjDlLVkXHZOtUARNe4vhgRZH4LfkwTAMRxusDC2T9dhv0ayBL5w5IfX3fJC2569T/xCGXq8449LoaNHZJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980055; c=relaxed/simple;
	bh=HEJzM15wL0I3VJrzBBzKJy03JWcp7ufs/ElOqg9a4iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpylTwyBa3hthwpEYCuzPj/Ru+T93jnusip2XFmqJlhfkKJbIxC1R4s3TtBfFpJtYt79mM0FlhXKWmgB9LML2lK2CVGcHifpX1zG/g2gCf/xLvE1X7iISN6nIyhopTd3zz7PciDM2WCAdP4RrQbrhqd3WQ8tCmlzjE/ubUEXeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=iUa6CHYm; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=HEJzM15wL0I3
	VJrzBBzKJy03JWcp7ufs/ElOqg9a4iw=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=iUa6CHYmGM/YhlmXVM9kejfEijIdPczFp03tBbsx
	uR/LlW6rH9UFdoeHS+LMU0e/Qe/udg0F5faqhBQK7ATvNTj47j5eJca2TCKCJHg4GOzaFd
	dxzzFqK+rWXIJxfbqxtbM6eBoEPFY8GYJcExPPCWzD3aljNAf3pSAHOGF6O+c=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 10626f0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jul 2024 06:14:02 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2+deb12u2) with ESMTPS id 4634E1VD092873
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Jul 2024 06:14:01 +0200
Message-ID: <987ec8b2-40da-4745-95c2-8ffef061c66f@aixigo.com>
Date: Wed, 3 Jul 2024 06:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: nfsd becomes a zombie
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
 <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
 <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
 <27922D49-743D-4FC2-86C6-6926FE52537D@oracle.com>
 <88734306-3076-422a-9884-47f76756fcc9@aixigo.com>
 <91607B76-4A08-47A2-98CC-8DA10215CD69@oracle.com>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <91607B76-4A08-47A2-98CC-8DA10215CD69@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.5 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-07-02 20:17:11, Chuck Lever III wrote:
> 
> Harald, none of this is any more probative than the first
> report you sent. We can't tell what's going on unless you
> can help us debug the problem. We're just not set up as a
> help desk. Have you contacted your Linux vendor and asked
> for help?
> 

Understood. I highly appreciate your work on the NFS implementation.

Maybe it is not important, but did you notice that the most recent
"Got unrecognized reply" messages in dmesg did not show up in /var/\
log/kern.log, except for the first message immediately before NFS got
frozen? Usually both show the same.


Regards

Harri

