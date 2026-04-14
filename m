Return-Path: <linux-nfs+bounces-20841-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEAmKgyd3mlrGQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20841-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 22:01:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 273163FE343
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 22:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EC6630036C6
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20B199E89;
	Tue, 14 Apr 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p72VqbeV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F371CF8B
	for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196847; cv=none; b=tqnsfochGHjvnZVgirD6y7T7WZO9qyl2tQeJt1y/KlwWLZ5UUQexmOqGApTsj34tKpLwHN2jQUOUD4i8mOqrnhSGaiChDiKfa9pL5gZdcqqOsIvlnYipUjLoFc3wpGyf9lIWw4q6Fo8EN6HEKxtJSffak4Qq1vwuTNvVhGNSn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196847; c=relaxed/simple;
	bh=ithCxZ94/lpCyjWS5Q1yqtuB5xCNWYQO26fHa8taySU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu8ggxv7BcFzOtheeFcp11iGNFp8kNlmMedzokSOjuska4hXEFsZJ321NqE/gQMWggyLNNDSG1o3dW9EsRmfeNAEg2t22EtU91NNKYNDDiI4xtlH3+q002vBGpVMiw4hYZGW8RpqI4t6NVbpjzgWNTOjcqzbAOicnxRy92sW3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p72VqbeV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso262965ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196846; x=1776801646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lj5suPMM0090nuUB3pghGeuC5Cz7fnPMxIf04NMBZA=;
        b=p72VqbeV7ejGRWmzuBeMbSS1hfzW+2NVze5lL/voUPyLSzlc8iYZG8iqNhtL4blI2R
         yKqaA6kgZBzDShPUNBdXMuH78b+V1SEf93gqKgjQMelc0PdAYN8yrTJgOCbmTh8r4zrl
         LOu+pkGANKtQqvFR+c/DscqTnT6/zg3tzxS+nSoTYyrd2N8mcm4tKtWBdm99E0SFmEK6
         R/p0wmq2MTJX/I+v+ByceT97n23YdGizOSUIngpiioIy3vLHQokNDHEONxLgaIRG/zDQ
         MchVOryx2k3h9F4zJac/9877khuc00ccrXWy7t8VJEDQuBcdJrWGmmolp4ubTnJEOJxv
         gALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196846; x=1776801646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lj5suPMM0090nuUB3pghGeuC5Cz7fnPMxIf04NMBZA=;
        b=ZLtnKEpR2TfL2igowFqdJUHUOMa1EamL56VnqNONIE3FAE4Ec+cH3El8x1cQZIHv4U
         rgmlPRSpWi2GPfck4IAJepBCHuEsFP7RDHmG+MA++JefP4dC5e6XkoxMUzgKNXEPIeP/
         p9VOaIUDr9Pc7JH759hzJWbWVptYC1VkAOonvqDa71d25TcZ8aCgVX4lRjHvOMw9+t1E
         cBMyJnVyhF8wTQ72H9CHMuInvHaVxS4w316p1Kl68Ok+4qnanBtmwaeOWLe+todBOkKS
         ScyTROGMKE0eAMXXcbJtW8fq1Ks58BNdqzCIqJbgIzP72GvWx32boD9XLRtM05ye9jQc
         +jxw==
X-Forwarded-Encrypted: i=1; AFNElJ9bU7JFx8z4aP9ede6nl8UT81iJs5kPSWUiVoCGxqElBFAgjEEeOhttdLJrJmk1zfzctOmdQqxW2UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRnzSjF4PLu6ZP5crR2IEFX4AR8zzdt5GMsivYLyIf4unBhez
	QG3hH569GNQ4zkrQ7RbNTiqe4zezfuJTZOrqzxEHXv71gmB9pPRw13mIIjrMGtdnwQ==
X-Gm-Gg: AeBDietI8+ZHhtrERyd5FzoAW0/R+izXTZrJni+XamnxefBIzKDPAJatroy7ylLV/YN
	nWMp5pA0lCZiDshPl8uBm2a5lRzJkYSd6PID9N7RpkEGEAWXzAK0y1JglkXKiOtZXcESL+X3XQr
	l+6Kr04NiEssAnqmlbB6zW81zC2fNq7bqex7j5DMHP2uvz4khWbxzdPQAPqpYy3vjwWtgzKeVpo
	I+DCPEg1wdCBNcKGY/jxYFApmtbj9Xo9Yfu3u4pd48W6+0PJziTMqRC6W68iCWpvvhvcrY/OZJW
	EdCXf+16+rZT6D++dzS87LRyzEBUCqNrmZXYtwKt7aRo/G5Ysy0Ibtw2TbThWBvjKWDgxBLMQEt
	Dh85ZisVZej6ZTau1ZaUFf2JxiOtnsfm5ecYragm/FqGuQo12vAhWj/eTqcmDZb/BNQ7o/L8kay
	23PWYWJFg3wnfxyNzozP+70SH5KobOExIq5F3l/cl45+RyCCXU1nT6U7uy7hD+3eEOABMfw0vt6
	W8xvRM=
X-Received: by 2002:a17:903:4b50:b0:2b2:70ba:304b with SMTP id d9443c01a7336-2b474d3d9b5mr926455ad.10.1776196845352;
        Tue, 14 Apr 2026 13:00:45 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0adbbsm158961075ad.46.2026.04.14.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:00:43 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:00:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com,
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] nfs: allow P2PDMA in direct I/O path
Message-ID: <ad6c5fI0HsHkUbKH@google.com>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-5-praan@google.com>
 <ac35ICYHuw4lEOri@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac35ICYHuw4lEOri@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20841-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 273163FE343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:05:36PM -0700, Christoph Hellwig wrote:
> On Wed, Apr 01, 2026 at 07:45:00PM +0000, Pranjal Shrivastava wrote:
> > Migrate the NFS Direct I/O path from the legacy iov_iter_get_pages_alloc2()
> > API to the modern iov_iter_extract_pages() API. This migration enables
> > support for PCI Peer-to-Peer DMA (P2PDMA) by allowing the setting the
> > ITER_ALLOW_P2PDMA flag.
> > 
> > Pass ITER_ALLOW_P2PDMA to iov_iter_extract_pages() only if the local
> > mount indicates support via the NFS_CAP_P2PDMA capability bit (detected
> > at mount time for RDMA transports).
> 
> Please split theconversion to iov_iter_extract_pages into a separate
> preparation patch, and even series.  That is a long overdue change
> that fixes potential data corruption in XFS.
> 

Sure, I'll send out a series with the migration to 
iov_iter_extract_pages, should I club this with the pin-aware + folios
for direct I/O or send it as a separate series?

Thanks,
Praan

