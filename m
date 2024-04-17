Return-Path: <linux-nfs+bounces-2874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731A8A8345
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 14:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16201F22428
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFD05A0E4;
	Wed, 17 Apr 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOnW7SBb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DA84E0F
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357662; cv=none; b=BFe/rhgb4ph51vR7pm8IsWKmL0KOhFlZkC6/wwFt2sPOefS9DXoqFHPR2m6TJ3DpOANtydjeaXeqUZDFbMDn270i1cd9Xpz0COI75f1f7qomKfCnb7HX5giDAHwLqgUdF6F+2YigQRb46J35izmfDIlnutIWEdbsni/EEMk/pQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357662; c=relaxed/simple;
	bh=BPnBbmZAkHvvIkhTfkJCRrjjWxXnvNi4ZkdE1EM+3bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9thcejNKOJP0R0GqziJlyUPvisvwVNKPLPnEqjI0mi57uVdBgEvBofnEI9bMZTpcYwHn8AZ/X71dohd/oLYrR/hdaBLByHuJOI1yvG6it/9/OPWrWruT89JFzdlvZajSNdPuvo1m/iznBTiA6OHFhwqCKAxYevYkA07e0E5yPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOnW7SBb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4702457ccbso691616266b.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713357659; x=1713962459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VE6FITerDH8NI0e3EaHeqLPGOQsRtqblnkpeRuelPK8=;
        b=sOnW7SBbcu79vWwKg8fOPN/PWFInoaZ23Hrt7jD6wQZtuQCvoV2X5phZBj9kKInSol
         5SDTcn76lP4JimXFT/TnTJkAi3eTj1YGkzaq6sCFzQbgZeKxZIIkzFsyOI/WrHNUc4DU
         W6oTw0Mh8+KMgWk4Ku+OAm5uA9ifaqGoV2XFK6h/2292sN93IV4Y+4+Dx5dB1hog2RjY
         OrWs4U7X9kbDgqjqZKHlvyTxHMKdL0YsZbV5PTzM5OGWqgMl2Pyht8EAVIiwwfRvh8CI
         qck5RIgp0xKvQg4CI+XB79ruQAr7nCnV+DlcmN0DWkkiv8z2A8XSJfo29gI4LSltpO1d
         t09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357659; x=1713962459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE6FITerDH8NI0e3EaHeqLPGOQsRtqblnkpeRuelPK8=;
        b=QCfFPsH/jub6Dm2cFFwedRKlfgHwQW0mv07C7nGR/klEEl4d1hPZjgfJpheoNq8R8U
         E0hTKr7k6Rp7rKtqbgm//7mBZGKQMDAnj2OWFtlOi+DpsDpladHIwRoyrYgXKMMn3PIa
         4aj+ZcIKRzariTeusgOpgamVR44uJiOgeFqk0udpFGd4taZU/872pUfUxUBFvF6shdnf
         nHZ2Wlge9b4m/1m/Gu2BmvJ4BbR9pLBQNpi9e6r8zU2jlUpLbS9LZ4wiMa4U4sLYkvfD
         M5Cm7ztYQlL4yVrfVWApqHuL2F18wB3cBh2uqsIIwtTAq2vI4ycXPYgl4U4RgVjGf7TN
         VHhg==
X-Gm-Message-State: AOJu0Yz0gPOP5t89u90M19I8bw6QqAVQ1nK6O0n+8MX8ghDTggeb0stM
	XPTT8nY9ut0zDL5i1W1ciDU6DoM3d74sfNrY00i8Ffkm1ocYW1WMP1chIEbukjc=
X-Google-Smtp-Source: AGHT+IFKHKVv8ToDGzj1BrtcluVif2UoBrSi6CT0ljYGs7DSCQw9fie09cuQmg6tzCPjq6qv88l3vA==
X-Received: by 2002:a17:907:7286:b0:a52:3eda:3a with SMTP id dt6-20020a170907728600b00a523eda003amr11879380ejc.33.1713357658572;
        Wed, 17 Apr 2024 05:40:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id en15-20020a17090728cf00b00a522fb5587esm7288476ejc.144.2024.04.17.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:40:58 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:40:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [bug report] NFSv4: Fix free of uninitialized nfs4_label on
 referral lookup.
Message-ID: <7c4df27b-9698-4d49-a35f-9395b75348d3@moroto.mountain>
References: <ae03a217-e643-4127-bb4a-4993ad6a9d00@moroto.mountain>
 <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13EE0F08-5567-48B8-A7C2-88A086FBDA89@redhat.com>

On Wed, Apr 17, 2024 at 08:00:04AM -0400, Benjamin Coddington wrote:
> On 15 Apr 2024, at 4:08, Dan Carpenter wrote:
> 
> > [ Why is Smatch only complaining now, 2 years later??? It is a mystery.
> >   -dan ]
> >
> > Hello Benjamin Coddington,
> 
> Hi Dan!
> 
> > Commit c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on
> > referral lookup.") from May 14, 2022 (linux-next), leads to the
> > following Smatch static checker warning:
> >
> > 	fs/nfs/nfs4state.c:2138 nfs4_try_migration()
> > 	warn: missing error code here? 'nfs_alloc_fattr()' failed. 'result' = '0'
> >
> > fs/nfs/nfs4state.c
> >     2115 static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred)
> >     2116 {
> >     2117         struct nfs_client *clp = server->nfs_client;
> >     2118         struct nfs4_fs_locations *locations = NULL;
> >     2119         struct inode *inode;
> >     2120         struct page *page;
> >     2121         int status, result;
> >     2122
> >     2123         dprintk("--> %s: FSID %llx:%llx on \"%s\"\n", __func__,
> >     2124                         (unsigned long long)server->fsid.major,
> >     2125                         (unsigned long long)server->fsid.minor,
> >     2126                         clp->cl_hostname);
> >     2127
> >     2128         result = 0;
> >                  ^^^^^^^^^^^
> >
> >     2129         page = alloc_page(GFP_KERNEL);
> >     2130         locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
> >     2131         if (page == NULL || locations == NULL) {
> >     2132                 dprintk("<-- %s: no memory\n", __func__);
> >     2133                 goto out;
> >                          ^^^^^^^^
> > Success.
> >
> >     2134         }
> >     2135         locations->fattr = nfs_alloc_fattr();
> >     2136         if (locations->fattr == NULL) {
> >     2137                 dprintk("<-- %s: no memory\n", __func__);
> > --> 2138                 goto out;
> >                          ^^^^^^^^^
> > Here too.
> 
> My patch was following the precedent set by c9fdeb280b8cc.  I believe the
> idea is that the function can fail without an error and the client will
> retry the next time the server says -NFS4ERR_MOVED.
> 
> Is there a way to appease smatch here?  I don't have a lot of smatch
> smarts.

Generally, I tell people to just ignore it.  Anyone with questions can
look up this email thread.

But if you really wanted to silence it, Smatch counts it as intentional
if the "result = 0;" is within five lines of the goto out.

regards,
dan carpenter


