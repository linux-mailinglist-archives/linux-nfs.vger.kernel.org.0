Return-Path: <linux-nfs+bounces-4058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DE90E4FC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 09:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D212849F2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C00182DB;
	Wed, 19 Jun 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="Tzgd1f/O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED577F0B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783791; cv=none; b=UbOKFbDhQdYkLftZ8OrAxziXjYDUtxwOCs9L9yWRI7rBvgudjExhF2s9+neoPc0OfXZtachaR3bl2jjH5GEvh+gVi8LlauGSzPy5nRSSAflTFYn0Xof3fml1Of4Cqf9erMjftFjcQgXojk6suMa8HI/9CgYSs1aEge9pdTei0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783791; c=relaxed/simple;
	bh=0fdCcYEhbPFd8wZWWdMbdCk2Ayjn8q0rQ0RuZolKMk8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OiEYQSROr6LLXSfQjYdX2MoWWzhWsd0UQ8/cUWs7WYxHjZbm5cWh00/yBC7Rjh0NogXSn+CDOlLpdldhQK/IhhqQAad5Ty7SDHLeiDHugoX1IBLzJvbu1uSDdw0J7sa/hXTanzcqh+8p2hkdBru10HIVnJv8WQAiVexKTbEwsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=Tzgd1f/O; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=0fdCcYEhbPFd
	8wZWWdMbdCk2Ayjn8q0rQ0RuZolKMk8=; h=in-reply-to:references:cc:to:from:
	subject:date; d=aixigo.com; b=Tzgd1f/OlVlVENrFsv/ie89leolQPYP/6/8/qzfp
	y2Xxnky8CiNi5qO3bZLg441VHWO4pDHoYImEnhxg3EtjlThlduKJ6KSQK8Uq7gqESm9ggH
	BwWByBFPO8d0m0bUUxGU/xZZHCGCBOHCimXEELbJBQx6twahCkfP9eTIaqlmk=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id b264cebc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Jun 2024 09:56:24 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 45J7uNS9996389
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 19 Jun 2024 09:56:23 +0200
Message-ID: <9523b03b-8851-4f7d-a789-f5613f45de80@aixigo.com>
Date: Wed, 19 Jun 2024 09:56:23 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: nfsd becomes a zombie
From: Harald Dunkel <harald.dunkel@aixigo.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
 <ZnGfEDvQB1FRGVQK@tissot.1015granger.net>
 <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
Content-Language: en-US
In-Reply-To: <668b479b-3a51-4287-b9d7-44d6dfa4eaf4@aixigo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-06-19 09:32:23, Harald Dunkel wrote:
> 
> I have 3 clients with more recent kernel versions 5.10.209, 5.10.218
> and 6.7.12. The 5.10.x hosts are running Debian 12 and this kernel

5.10.x kernel means Debian *11*, of course.

> for several months, but the host with 6.7.12 is running this kernel
> since May 16th.
> 

