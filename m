Return-Path: <linux-nfs+bounces-4129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C437B90FC2F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99841C2192B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361791859;
	Thu, 20 Jun 2024 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="p6FWKQ49"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E62BD0F
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718861410; cv=none; b=qGKqzGB78wMHearhIEbeznEfyuDQZhXd78IrRjvXKfCR9/hJFbcYb9xSxVyfawT5/he4l/dfI7jaA9xSnDgdub1Ish+W7gJy6Xo7IEWYRokUpEZAGcx73pG++NurPtOBNtgX2yWX7YvV4x6UeUjSuCpBhOeCwwzU8+XUzFck1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718861410; c=relaxed/simple;
	bh=l3l8QOHLG8xzCY2XPrjSJLOI2CfXe3fYGdlgndwHU9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd+BnIIm3IzbaGiKD2T7xmHypJajH1vZuFpObYXXWiqRrutYJlad3b2EIfXIUnGC2kx5UEgLEHTiCJrp7MqR4Vs2ttYKYp+cJWzhSO9Ehthv2OSvIy0pGZCCn6IBTt5zZ6jpDfg0Vr7/3aaQugIsC6jjIN1OhcT33sdF1dS3oHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=p6FWKQ49; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=l3l8QOHLG8xz
	CY2XPrjSJLOI2CfXe3fYGdlgndwHU9k=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=p6FWKQ4987RV69PuEocbTpXRNYQGAbKCCGED7Ci/
	gFdZAQAmRBh8huzoQhzexapOVjV6paZ8smtT8vxyGLd1UmcJFcYULQXHDonNZDvFva/7VT
	wBNsh/nCrGuflMY006frun4ODNs2q5UPrRzqd7v5WCkRLxzaaE9HkDHo+YuvY=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 3a79ca6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Jun 2024 07:29:56 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 45K5Ttcp1218664
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 20 Jun 2024 07:29:55 +0200
Message-ID: <50d62fc9-206b-4dbc-9a9b-335450656fd0@aixigo.com>
Date: Thu, 20 Jun 2024 07:29:55 +0200
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
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <27922D49-743D-4FC2-86C6-6926FE52537D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi Chuck,

On 2024-06-19 15:14:15, Chuck Lever III wrote:
> 
> There's no way to answer either of these questions
> since we have no idea what the problem is yet.
> 

I am getting these messages again, similar to previous
incidents:

[Wed Jun 19 16:46:14 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000a5ff94a6 xid f9d6a568
[Wed Jun 19 18:42:23 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000a5ff94a6 xid 59d8a568
[Wed Jun 19 18:43:15 2024] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000a5ff94a6 xid 5cd8a568

nfsd is still running as usual. Assuming they are related to
NFS, Is there a way to map these weird messages to a remote IP
address? I could setup a similar system and use it to capture
the traffic without breaking privacy.


Regards

Harri

