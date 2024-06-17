Return-Path: <linux-nfs+bounces-3886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C636A90A629
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7144F1F21456
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63D39FFB;
	Mon, 17 Jun 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="SAdnvYJ+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17671CD02
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607324; cv=none; b=oPUBh3iwnnrax6ijssKJftRvVZdFHjqCDE0FWQEw9+fXsKdkR25rG2rSRgMAyRYsw9RtzbbejTX23EttB1sQ0DBD3X0PKa6wXk9rYHVV/MM7SiNjIrxCOB6NWmmuYPP2C8caIMIZgtJvstcDrRY9aV+vpjtFiKFD22rn+ofEyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607324; c=relaxed/simple;
	bh=+oCTun2pOLphI72oMNdRma5b6r9ace89QL/ZL7IvoXg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=M71SSAOXHhsQF8U390wkNkdgcnBR5jy6u5yW+Qk34N3O92Xu/gRnR4VyaP0B2sTtOilOuR8c5vuMIlSlinJgqIzWwuvS5vPHRRpla6xY4bD4pHaDTiXFhmCwlJUgzcgG7wRZAii4h6OCCMmS87CrCDH31JSIeCf/BQN/ZB5uwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=SAdnvYJ+; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=+oCTun2pOLph
	I72oMNdRma5b6r9ace89QL/ZL7IvoXg=; h=subject:from:to:date;
	d=aixigo.com; b=SAdnvYJ+mzcz3i+wodyhDgvMaq0Ml45p18g4Pf107isXL6NeF2NqZa
	BtnQqDhViwGUBPKiIeZ+YFsqIBbAR+txiNn1fn+ht6RGMceFYtJMkhpSMClr6yBMjUmrEE
	JlY7yvAteAy20txODvwP5U+m6FMnjiktp07hqJG3yhihIqc=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 62ef5789 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-nfs@vger.kernel.org>;
	Mon, 17 Jun 2024 08:55:09 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 45H6t7UE453666
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Jun 2024 08:55:07 +0200
Message-ID: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
Date: Mon, 17 Jun 2024 08:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: linux-nfs@vger.kernel.org
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
Subject: nfsd becomes a zombie
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi folks,

what would be the reason for nfsd getting stuck somehow and becoming
an unkillable process? See

- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
- https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568

Doesn't this mean that something inside the kernel gets stuck as
well? Seems odd to me.


Regards
Harri

