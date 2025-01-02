Return-Path: <linux-nfs+bounces-8887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F490A0013F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 23:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11CD7A1238
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA919CC0A;
	Thu,  2 Jan 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSNcT2DK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB01957FF
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857789; cv=none; b=fSDY9U7W4Fq+nqO9aFGu3pF3fG6GxkQKThfWrdiM1LNE4uhm6ahrPvjjVXw1SI7v2FzQt3EvwR/ylGtI0LjfhDrxxfaUPF1ILsoDf+NASB9xuUKOW1l1PKfkDXwzahqnIY5PwmMT7hAfw9s3CUpKhfIqeiKlzeOx56gfuWkGHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857789; c=relaxed/simple;
	bh=0pAtcEgdbtFgaQLaAsThHp/WGgyAhTugMcOZ/HNKcTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9kJj9fTfad3+pWuSoP/qs/z3PglGQMhVZ45wN4iNcfFcoKWj86VHU3Uctrr91dX3JHBpny45iYDczrq7sLVFZNU+WJyzuRiALhnntcjv4MhOgIWmGnG3wr1KntK39HhV54dIN0HHuT4VBkEhOPqNVMhieF4dJlUxSGsjKg8PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSNcT2DK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735857787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYt/mD89GISGPbXMHtXOlC3lh66mT3G+ZuzK9+u2wQ4=;
	b=WSNcT2DKlpKaFk2Dtu7XRgtdV9VIR4hr+JQM8ebQH3r7Obs8FiFOYOk8uB55Zj1anlClCD
	hRM27tlEFkSaGCQFeNLMpKeXLSxMgxsd8tfN937iftcGvmeYcU4KlSC4F7TwAbptGnDSyF
	R/zThBF+CoXpNgpIOcG4bT6wz35h2zo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-y1s10AhTMZCknz1CctQ20Q-1; Thu,
 02 Jan 2025 17:43:03 -0500
X-MC-Unique: y1s10AhTMZCknz1CctQ20Q-1
X-Mimecast-MFC-AGG-ID: y1s10AhTMZCknz1CctQ20Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA7F319560A3;
	Thu,  2 Jan 2025 22:43:02 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC5E219560AA;
	Thu,  2 Jan 2025 22:43:02 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 360612E9166; Thu, 02 Jan 2025 17:43:01 -0500 (EST)
Date: Thu, 2 Jan 2025 17:43:01 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Charles Hedrick <hedrick@rutgers.edu>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: problem with nfsmount.conf
Message-ID: <Z3cWdSaCcE9fVx65@aion>
References: <PH0PR14MB5493E6F4ACD3CA4385C7E294AA142@PH0PR14MB5493.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR14MB5493E6F4ACD3CA4385C7E294AA142@PH0PR14MB5493.namprd14.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Charles,

On Thu, 02 Jan 2025, Charles Hedrick wrote:

> Is this the right place for nfs-utils?
> 
> /etc/nfsmount.conf if you have a global section and multiple servers, vers= only works for some servers (the last?) I'm unable to find the exact algorithm.
> 
> I've replicated this with Ubuntu 22.04, 24.04, and Redhat 9.5. It also occurs with the latest source (2.8.2) built on Ubuntu 24.04.
> 
> [ NFSMount_Global_Options ]
> vers=3
> rsize=65536
> wsize=393216
> [ Server "communis.lcsr.rutgers.edu" ]
> vers=4.2
> [ Server "eternal.lcsr.rutgers.edu" ]
> vers=4.2
> 
> mount communis.lcsr.rutgers.edu:/xxx /mnt
> 
> will mount version 3.  Eternal will mount version 4.2
> 
Can you test the patch I just sent to the list ("conffile: add 'arg'
argument to conf_remove_now()").

-Scott


