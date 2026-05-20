Return-Path: <linux-nfs+bounces-21749-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SARKD9IwDmoK7wUAu9opvQ
	(envelope-from <linux-nfs+bounces-21749-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 00:08:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A459BC6E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 00:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 358A73007B8D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5939D6D1;
	Wed, 20 May 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgUDSO+6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE7328616
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314895; cv=none; b=PklG/mgSEryiwZIyPyBnWhWQIGUUl5251oaI2gAANH8iMc8yjPYf7XrvGLHydpKNVFIWN287SQX5P3/DR/idyj8uqBvpouc8HUEM43zwDEewJDhEe//K7954Gh0eTmrxdrnoZSNoCIDZMo3493EgAj44sd3HF0G7w6qmVTZdX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314895; c=relaxed/simple;
	bh=GvMI6GZ6LhvTDZecYkpbYTgU6jedPDRWg3orSOZbT+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyhfbiZKZ4nGX2H6JL2JYaQ5+3w0bdllmibBH7ou4tyj/YDfKK6tp27c5D/i6jWUYoOI1KVq6ci2FUmsPDoKnJfVVAIN0Q05NCAe11jimaTGXjhab7qnhWS2V/bma8lMbko3kj7Mo6kjsGPrz4h9C4IsDqmW41lkRqRN8tauBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgUDSO+6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39397d63804so1272391fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314892; x=1779919692; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvSI9lGtRBDdBjj3Ro7aY2gU3MVGI1l1ASVg3vXh40E=;
        b=kgUDSO+6diQVbvh4rTthlTlxGmPojbeu7AykCjOh9wcUo9p2m+OtYlW1IqVEEF/ODB
         4RjYOI5joJ/La1avp9i/xixwX8MuUT33AI2bSUuSR/a+GLuED3hUlTrqdoP5CSue7UI1
         Nk441GhPRu4B9jaQ0u41DRAUuvuIf3BF8PLwE+ptFTVaA2kRflY6y/ViuwmFPVdGGukp
         OK1Oh9rD7GUpYPTFBGaB8zQVGyoLnf6CpNvrcyv5SBREDsKRjPYb7Cck/tlQJ6HHUZW7
         JqRAjYeXJ6KtgkcPEPw45SoshASvyyddoCfirWByeDHC1l9kUj3rfA2E4RHdtJtNnIj3
         O0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314892; x=1779919692;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvSI9lGtRBDdBjj3Ro7aY2gU3MVGI1l1ASVg3vXh40E=;
        b=MHYIrmrKYUv3Y4+jx7qnaxU00KwfgG9J0bxO+DTA78FJKZNIjwfpUz+fP2l077qQAq
         V3pTzg8GKaz02yVkntSXaSYRN53TFlWhqNxSDTw5RbM6YKuPaiImBGckMC3Ev3ZLNlSP
         lCvfiw8OKgZbKiVlmu/qVPWwfr1phP5iP0bCd2tBVH79rpQ6xAyeY+NKeWtuGB6EAyMm
         rfH+vt/EFqr3+YyRAUUPdRHx7s4Ss+hEb7TfeebmN7kQEIvwZtPb1PGdkSseTsVLvqq+
         WWFe8peJ9O6iAuqhrr0bZVRhyuXEKYlINJws5pgMoMj/hdy7QLi8JIQi6bzPC717s2ZR
         Utow==
X-Forwarded-Encrypted: i=1; AFNElJ/gaHHp38l6PaUa29brgMqBhSFa/tf4c237Chxkq8R68og+KJrk/LMCRveQcqYFk+ToZRJqwn+GOWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nJov6YT4L/rkb0HS8BQ9CvaS9yBGCkXYdfSNZvXBeFdFcTaV
	YOcH4+61dYKlqYcWJlPiSwjS4SStItnaaYzWGlPaOnuWVVK2/yoqTAghnnATkm0t
X-Gm-Gg: Acq92OHxJhhTyjXdeX4PDs0BHbauCPI4GUynTcmhe8VIIc5vbysv2h+FCl0gMr1VUma
	KBkMjLyR3U4cOXOJHCl+at59hMFsQ7+Lgn/EZ33KT1LaYWtFb1JKcbx742M7Ek4SjzWITss23nU
	OBZSMbO7yKtGPbxTRRHthqZ3HL4g32fzw/eSUKLCdIKzCv8FVgn1jKl9+lJH3Y6WYR5EuHEt9PZ
	SD0frCQzZqin3UCX4KC9YB+wQDH+ddT87kz8Ua0rhQvtVAy0WvSi07g0M05/EC1oMFt3XqoqUOU
	ojHE3cXHDiNcEdB+wmzSJop3DmX/VCFRKAUfNrv1ipdF9kOl1to8ghrqY35vJLfvblPUHZ3w+7c
	fFXkJGQoisPpqsTg/Avm3TaRLNtejWY3U1n5iPGcd8yplv96ZGEyY7oAh56txCA/p77bbq0E6oN
	KhrsIhlircMHCG4+Mbch5K14ISnEvtYjGR+tj+s8y6vnX9ML1M
X-Received: by 2002:a2e:9d89:0:b0:393:bffa:d815 with SMTP id 38308e7fff4ca-395ca5ff64cmr455481fa.21.1779314891777;
        Wed, 20 May 2026 15:08:11 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([62.183.16.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887dfbbfsm32241421fa.40.2026.05.20.15.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:08:11 -0700 (PDT)
Date: Thu, 21 May 2026 01:08:09 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Dai Ngo <dai.ngo@oracle.com>, Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <dgc@kernel.org>, 
	cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <c5dgxtly3l66e6ukv7isresztq5le5mtyoyk4wqldolu5x3hqo@dx62gtu6o2w6>
References: <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
 <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
 <20260519145949.GH9555@frogsfrogsfrogs>
 <ag1vwFHoYatausLK@infradead.org>
 <e55a29a9-ed18-4e3a-8378-f712bcbc940f@oracle.com>
 <20260520164856.GI9555@frogsfrogsfrogs>
 <790b9c07-7b32-499c-913f-9b50f019ba21@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <790b9c07-7b32-499c-913f-9b50f019ba21@oracle.com>
User-Agent: NeoMutt/20231103
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21749-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergeybashirov@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D74A459BC6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Christoph, Dai, Darrick,
Thanks for the add!

On Tue, May 19, 2026 at 10:34:20AM -0700, Dai Ngo wrote:
> I think this is what happened.
>
> Assuming the current map of the file as follow:
>
>   0000-4095: IOMAP_UNWRITTEN - block allocated
>   4096-8191: IOMAP_HOLE - no block allocated
>   8192-12287: IOMAP_UNWRITTEN - block allocated
>
> NOTE:
>    . the bmapi_flags used by xfs_bmapi_read is set to XFS_BMAPI_ENTIRE.
>    . the nimaps count is set to 1. xfs_bmapi_read can return only 1 extent.
>
> 1st call from nfsd to xfs_fs_map_blocks(), specifying offset 0, length 12288 and
> write is true.
>
> Extent Returned:
>
>   - offset: 0
>   - length: 4096 bytes (one filesystem block)
>   - type: IOMAP_UNWRITTEN (existing preallocated extent)
>   - addr: physical block number of the first unwritten extent.
>
> 2nd call from nfsd to xfs_fs_map_blocks(), specifying offset 4096, length 8192
> and write is true.
>
> Returned Extent:
>
>   - offset: 4096
>   - length: 4096 bytes (one filesystem block)
>   - type: IOMAP_UNWRITTEN (freshly allocated unwritten extent)
>   - addr: physical block number assigned when filling the hole at 4096
>
> 3rd call from nfsd to xfs_fs_map_blocks(), specifying offset 8192, length
> 4096 and write is true.
>
> Returned Extent
>
>   - offset: 0
>   - length: 12288 bytes (three contiguous blocks)
>   - type: IOMAP_UNWRITTEN
>   - addr: physical address of the merged unwritten allocation
>
> After the second call, filling the hole merged the three unwritten segments
> into a single extent (br_startoff = 0, br_blockcount = 3). When the third call
> looks up the range starting at 8192, xfs_bmapi_read() finds that single extent.
> Because XFS_BMAPI_ENTIRE is set, xfs_bmapi_trim_map() bypasses trimming and
> returns the full extent to xfs_bmbt_to_iomap().

Great job! I think so too.

On Wed, May 20, 2026 at 08:09:29AM -0700, Dai Ngo wrote:
> On 5/20/26 1:24 AM, Christoph Hellwig wrote:
> >
> > > 2) Now that NFS apparently can serve up multiple mappings at once,
> > > should ->map_blocks pass in an array element count so that we can do
> > > multiple iomaps in a single lock cycle?
> >
> > I guess we need to do that, or revert the code to provide multiple maps
> > for now.
>
> I think we should address the immediate problem first by replacing XFS_BMAPI_ENTIRE
> with 0, and handle support for returning multiple map entries from a single
> call to xfs_fs_map_blocks() in follow-up patches. That work is more involved,
> as it requires coordinated changes in both the nfsd and XFS code.

Agree with Dai. I believe that a revert is unnecessary as the upcoming
patchset should fix the issue. At the same time, passing the array element
count to the XFS code to find all iomaps in one lock cycle is a great
direction for further improvement.

During LAYOUTGET processing, before extents are mapped, the nfsd server
allocates a layout stateid and takes a lease on the file. Consequently,
it is impossible for multiple clients to acquire layouts to the same file
simultaneously. The server will first recall the layout from one client
and then grant it to another. Additionally, two LAYOUTGET requests to the
same file from a single client cannot be processed simultaneously as well,
they are strictly ordered by the seqid. Thus, I do not know a race condition
with two processes/threads accessing the same file via pNFS. And direct
access to XFS on the MDS server, bypassing pNFS, is strictly discouraged,
since it may have unexpected side effects regardless of this issue.

--
Sergey Bashirov

