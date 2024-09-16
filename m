Return-Path: <linux-nfs+bounces-6510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAF97A262
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909D5286060
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033941527A7;
	Mon, 16 Sep 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astro.su.se header.i=@astro.su.se header.b="CVjJJe9S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-prod-route10.it.su.se (mail-prod-route10.it.su.se [77.238.35.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837204C70
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.35.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490136; cv=none; b=GVYGKJIiW4IG8KbKfraCDcomWFJtN53T2ItggrzcJeTpFPBOLOiPb6qPaeqpfgTl0hwbQb7X3pdpY0eIWoCcx0ZpVmDfdzGxtojttbx4c6R3Aq3n0RnvoUMI1cqxu6Qy6ImLpb261Vs1VGINMlZx6wG4A+nAcapPa93MNzoSIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490136; c=relaxed/simple;
	bh=lUlqZWg8aY/BZU7l9Ke0GtAjFlTIiMXH9xv4MwralPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivLKQuNCJPz5D7c36vhdRYVAXsV8uc+nBObLemgZ16829jM/1zdYp70+C0/PLPhL2BpL+GaGc8MzV1zWyyOv7Xa54UTMb+U20cyVTDzwYRWImsiTTwWhUqrt4GZ7edgtT0YCTbPDztQKVdXjzgWmrN9Bf0Vnib3Um0gigkfpNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astro.su.se; spf=pass smtp.mailfrom=astro.su.se; dkim=pass (2048-bit key) header.d=astro.su.se header.i=@astro.su.se header.b=CVjJJe9S; arc=none smtp.client-ip=77.238.35.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astro.su.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astro.su.se
Received: from mailfilter-ng-3.sunet.se (mailfilter-ng-3.sunet.se [192.36.171.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-prod-route10.it.su.se (Postfix) with ESMTPS id 4X6kjt12s1z1YQ
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 14:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=astro.su.se; s=halonv1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=CxCbCgEJn4UHdMil6SvV3pBUMZYmwatW+l+tlBH/NX4=;
	b=CVjJJe9SCiPhigrwBRAZpFK4bUJ82KMwABP5BiCsx5yrFN56F8hlrzYSQsmw7jH4NLWW6bfXCOpId
	 O3IZwOmm0Sdc6eXKDqpAbA22kcwLrvpG++uHN+0wRtUvKn5spd8T9nnDxdRNcgD0fNoPpp6DO/1Obm
	 W0As/DfHsoDe4yFeLPNCvoRXiRSFPiw1M6fX9jGGVDnWsjMSop5EWqdcKmlnxiNhZmN3qM06NhRBV0
	 NkWHC+JthALW93FnqjLXeN9RmyudJIREE9wPdXNt9k/CQc9YfIzu+Krq7Z4Zm0XOd9Pl+vUwjxhUOu
	 /fBA51DMZ4LIaLdxZfko0NWwK2tzZIQ==
X-Halon-ID: 4347a6c5-7427-11ef-b006-0050569a1168
Received: from smtp.su.se (mail-prod-smtp11.it.su.se [2001:6b0:5:132:250:56ff:feaf:5896])
	by mailfilter-ng-3.sunet.se (Halon) with ESMTPS
	id 4347a6c5-7427-11ef-b006-0050569a1168;
	Mon, 16 Sep 2024 12:29:05 +0000 (UTC)
Received: from EBOX-PROD-SRV20.win.su.se (ebox-prod-srv20.win.su.se [IPv6:2001:6b0:5:1462:5455:3248:4844:b999])
	by smtp.su.se (Postfix) with ESMTPS id 4X6kjr4T1zz1dh;
	Mon, 16 Sep 2024 14:29:04 +0200 (CEST)
Received: from as-2866.astro.su.se (130.237.200.211) by
 EBOX-PROD-SRV20.win.su.se (2001:6b0:5:1462:5455:3248:4844:b999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 14:29:04 +0200
Date: Mon, 16 Sep 2024 14:28:50 +0200
From: <Sergio.Gelato@astro.su.se>
To: Steve Dickson <steved@redhat.com>
CC: Salvatore Bonaccorso <carnil@debian.org>, Kevin Coffman
	<kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: rpc.idmapd runs out of file descriptors
Message-ID: <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>
 <ZuU7S2Gli6oAALPJ@eldamar.lan>
 <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
X-ClientProxiedBy: EBOX-PROD-SRV15.win.su.se
 (2001:6b0:5:1162:85f3:6da2:459d:88c7) To EBOX-PROD-SRV20.win.su.se
 (2001:6b0:5:1462:5455:3248:4844:b999)

On Mon, Sep 16, 2024 at 01:54:35PM +0200, Steve Dickson wrote:
> It did because it was not in the appropriate format... The patch
> was an attachment, not in-line, no  Signed-off-by: line and
> the patch was not create by git format-patch command (which
> adds PATCH in the subject line).

I see no mention of formatting requirements at
https://www.linux-nfs.org/wiki/index.php/Reporting_bugs
(not even by reference to the Linux kernel tree).

