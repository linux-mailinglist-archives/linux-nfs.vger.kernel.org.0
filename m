Return-Path: <linux-nfs+bounces-3990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01F490D64B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE1B34E7C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5701367;
	Tue, 18 Jun 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="Rns3Jg6w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB32139B1
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721171; cv=none; b=STto1brAZixI9vQE7v0ZUQ3LvZviRqyluQfUBAVIdrg1LfSEIYhcvnmGGGpUnna005hzffxVKP5iPkt4QRnq/uL5mVnCV2/1eP7R2QPWrPYpYebmf/roHqb6oQ6uW4J7MjcOaXis8pQilZ4WEqDk4rMm8b2DniywSJ4PO23vTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721171; c=relaxed/simple;
	bh=M0ZK8poYUnSDxE4fgB9fdquf9g9XH475b5V5xlhcFaM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tgsRU/YWlzyQZXifg6QbKt2Du+aYxqCOZlqsUjmc+AV3zvJddsu/G0gdF93q7+ahZczF8t8yBVj01haQO4HCSv+8XZqyufijFrGizuEMR5+8JmFOg1kLpZG0AjQPCeVB6drW6fBKAwiG03WSah+k7T/wwrMbmsmrD4awWrQ/BDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=Rns3Jg6w; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=M0ZK8poYUnSD
	xE4fgB9fdquf9g9XH475b5V5xlhcFaM=; h=in-reply-to:references:cc:to:from:
	subject:date; d=aixigo.com; b=Rns3Jg6wmZt+rAQlEBW6OfRMf5zYdYk4WnW8G1S+
	zT/gz66n4ZSc+clZusdfs6aT2gh8+Hs8ozCBISe+ACu1yPnYUybP3c4JTT3bm+o9uL/ANn
	c2E9Xa44ND21uMhA3+HwckWW7WWH9ed77QxiTg94d1N8NK6cDjPaSPQkzzYKs=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 217bef05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 16:32:43 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 45IEWh4J834362
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Jun 2024 16:32:43 +0200
Message-ID: <3a4f33f9-283c-4d0f-92bf-fd22ef57ae3e@aixigo.com>
Date: Tue, 18 Jun 2024 16:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: nfsd becomes a zombie
From: Harald Dunkel <harald.dunkel@aixigo.com>
To: Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <4eeb2367-c869-4960-869b-c23ef824e044@oracle.com>
 <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
Content-Language: en-US
In-Reply-To: <661a6c9a-81d6-46fd-87ec-274100b12189@aixigo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

PS: Do you think the problem could be related to running
nfsd inside a container?

