Return-Path: <linux-nfs+bounces-3350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A18CD1E0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CBD2832FC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34011474B2;
	Thu, 23 May 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="S0RPIWLv";
	dkim=pass (3072-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="WeZSwvHg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fw.sz-a.kwebs.cloud (fw.sz-a.kwebs.cloud [109.61.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950C13B7A6
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.61.102.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466333; cv=none; b=sJ7OsR9Zcmwrxc4isSC6hdN/lwKpgeKU9qE8kPnrsI+2n7o/Pb8XaBYmOXd4qDZ3G+mGNXeuepo70wrmTt7tHU9adwAb9EE0rWtXMc84MvXjy2zIhLjM47gd5dM4+XHs2LkfvS27YV/OaKoic4N/vDxeUfaGcK75nFWcUFhEdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466333; c=relaxed/simple;
	bh=C1H9OEiNUVXOLU36s+PeUAre37IDfD+7MUIu++9I65I=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XM8pk3rHMiKgy3NNZtT+ALDezZur0eLI0is4TzgyKwBE91RL4Azn/ROItzyB+ICT2JBjTqbfv/eZZDleML4Sum76MEngsOAT+KHymoWBlBV/oY3SbhUEJ2FyFOAwEIJtVA8LTMEPRndpxvXpriRkeZwly+RW4QQ7F0GixGkhWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kojedz.in; spf=pass smtp.mailfrom=kojedz.in; dkim=pass (2048-bit key) header.d=kojedz.in header.i=@kojedz.in header.b=S0RPIWLv; dkim=pass (3072-bit key) header.d=kojedz.in header.i=@kojedz.in header.b=WeZSwvHg; arc=none smtp.client-ip=109.61.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kojedz.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kojedz.in
Received: from webmail.srv.kwebs.cloud (172-16-36-102.prometheus-node-exporter.monitoring.svc.cluster.local [172.16.36.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: richard@kojedz.in)
	by mx.kwebs.cloud (Postfix) with ESMTPSA id CDEE81A44;
	Thu, 23 May 2024 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s02;
	t=1716466322; bh=V/jnBPIzY9Je5JnUDaqbwxpcaxuNN6jW300AaFbN0Ck=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=S0RPIWLvtPaAof2D5PZJCbCfjZc2L8jonKKO8jUUJn9oIkudW3gOZdZhdSMrhvTVw
	 26OClAW1w+S/0/g00XEYFYF+IY4GUkAqaDPeis1MDshGMHWllSbU1nY027nUk1iyDP
	 XN0euIMWd5ju2vInD2S57pDChU4ofUiPAA4FIiKSRR6XRJXbFiAlOXmMoBs7ET5UTY
	 Ak8HWut8iD7r0krokPBuZ/wONcgcM1Swf7Ug14iPEM0zpIuZ/2RkibJpiEqCUYrV4R
	 VD3pni4uH36ggjhAEnRljHTTvalwXpUX7EbvDRES87EeqKoGv//rim9HGAbbtpqOJF
	 O6vS8UqzJdQrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s01;
	t=1716466322; bh=V/jnBPIzY9Je5JnUDaqbwxpcaxuNN6jW300AaFbN0Ck=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=WeZSwvHgm4wzwA12FEo8VWimSD8XbZSlA1qK2E4pGfLMkHCka9UXRcYgk46FK2U84
	 kZG19lE5bc88HH1Yi/sncmI8ypMM46NHTmFNp0jJrP9k8oimYPEyi3PfC6AzmK93q3
	 KxOwvvmdSKtgbd7HxFoW5Xhg6Sgd2d4w+i48D0iJJy6Y8QpeX0Av69c+C43F3O3jsW
	 pVAI6gBvhttszwMg7tu0UWcE4vgtfkeQD3ExPdoN7NC0PNEPlaURM/znD+CfrWaxNs
	 0FepPP/1beM/6ZbtIGN2nztWxvuv0Es+NL3QapIEuJFitjRhNvsr36jR3WTc1Eq1y4
	 yhVU8hbF9tH2DiCBYpYF3HxAFzcRgTplITQUZ2VR22+/5tNO0ooWlSqSOuch9vGpPy
	 zffktvwNOuXcK7l0lwKA6eKn03cviYZyJA/Ci6rLam+Yno6ipfp1jJffhNk1PP3go+
	 FtXpgbLFrF0uhkQ3AI7jT8juVSgz0CZ4vFrQ0dO+g8JAHLqJqlN
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 May 2024 14:12:02 +0200
From: Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>
To: linux-nfs@vger.kernel.org, 1071501@bugs.debian.org
Subject: Re: Linux NFS client hangs in nfs4_lookup_revalidate
In-Reply-To: <0473c552b6fd8e96ef2ffbf0435a7552@kojedz.in>
References: <0473c552b6fd8e96ef2ffbf0435a7552@kojedz.in>
Message-ID: <73e081764d06746be27c5f0d2f181938@kojedz.in>
X-Sender: richard+debian+bugreport@kojedz.in
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Dear devs,

Now bisecting turned out that 3c59366c207e4c6c6569524af606baf017a55c61 
is the bad commit for me. Strangely it only affects my dovecot process 
accessing data over NFS.

Can you please confirm that this may be a bad commit?

My earlier attached programs may be used to demonstrate/trigger the 
issue. It even could be stripped down to minimal operations to trigger 
the bug.

Thanks in advance,
Richard


2024-05-23 09:10 időpontban Richard Kojedzinszky ezt írta:
> Dear NFS developers,
> 
> I am running multiple PODs on a Kubernetes node, they all mount 
> different NFS shares from the same nfs server. I started to notice 
> hangups in my dovecot process after I switched to Debian's kernel from 
> upstream 5.15. You can find Debian bugreport at 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071501.
> 
> So, effectively I am running dovecot in Kubernetes, and dovecot's data 
> directory is accessed over NFS. Eventually one dovecot process stucks 
> in nfs4_lookup_revalidate(). From that point, that process cannot be 
> killed, howewer, other processes can access NFS as normal. Also, 
> another dovecot process running on the very same node accessing the 
> same NFS share works too.
> 
> Now, I am still in the process of bisecting, howewer, I cannot reliably 
> trigger the bug. Originally it took a few days after I've noticed a 
> hanging process. Now I am trying to mimic file operations what dovecot 
> does in a faster way. Now it seems that it triggers the bug in a few 
> hours, howewer, during bisects, I can still make mistakes.
> 
> I've scheduled many of my applications which use NFS shares to the same 
> node, to have more NFS load on that node.
> 
> I am attaching my simple app which triggers the bug in a few hours, at 
> least in my lab. I have two dedicated NFS shares for this test case, 
> and I am running 3 instances of the applications for both shares. Also, 
> I am running other production applications on the same node which also 
> use NFS, howewer, I dont experience lockups with them. They are 
> librenms, prometheus, and a docker private registry. This way I dont 
> know if running the attached app only is enough to trigger the bug.
> 
> Once I have a suspectible commit based on my bisecting process, I will 
> report it here.
> 
> My NFS server is a TrueNAS, based on FreeBSD 13.3.
> 
> Thanks in advance,
> Richard

