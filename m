Return-Path: <linux-nfs+bounces-3313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB088CB090
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8981F2126F
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA081422D9;
	Tue, 21 May 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="czHWkrEP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE16D1D2
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302206; cv=none; b=tNtiLb3jsmzoZjQNFEUn3ISJilHkPqjLMdZC/M0Aqi+QHLjf+gdsm6YlR2Xg5adb2pGtva6Obhs1LprrUsNJ5P2oAJ4GZjl7TXNMCkBJYGhxTdjrdUPlmQdVwoVj9HEIKqpQaIlNb3ttM0PHxRlCAvwDdwYHDAzAIZ5261U1P7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302206; c=relaxed/simple;
	bh=KLNJpdjen5QpCVrloZrbN0FSw6+bQlfYewV8gNXMw2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ13wFibZQkFMt0/kXPrJQXTpF+E6zH3fLjf0TDAKlTGAKRRm6efAx8lv7/nk66socHQLZHcwUgNXFTBJIU6pHj84eS562tmo9qfRt/bD9/SlRn3oCqOenzts+ok+irSRKvcVnY1L/S9MRU+hhslDyE7j7p6Wzgi3ou5RukpPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=czHWkrEP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso32099665e9.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1716302201; x=1716907001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Df+ldFiDTtuYxQTswWr2fb8Xly2lhHhw9MnzrPttflg=;
        b=czHWkrEPJ/bRtFVNudIbFINhnfPwfh9PWrcjF6q/SRq2LTw5Odc4P9SC8jjbn3z/o7
         2kK8QsByYlHU9vH0bXvauHrWnlEPScsIz7bMZjaCoyNnP0JMMrgtBJE7KotzJwHeMf5C
         smgbgD6LFsdhzX+FBsDBxqpIX9WEUQDuDxHw+E8bFefKEDUC+bHjmCAxWDwHSe/4Y/yq
         t8fnKlH9X90tbjKvX2Fnv/JGtXg7dCDKQo/nlys6CmmhSA3+jYbBLT5rraaglbU7esRZ
         X2BwGsW4sPFYoyKT54L4ypd9MtgrMOzHK27pGnMfJuBvN4Nus2/R81/FhVOqd05y8Ija
         GQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302201; x=1716907001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df+ldFiDTtuYxQTswWr2fb8Xly2lhHhw9MnzrPttflg=;
        b=AiL4DRWkmf3H+4MwicR11jii9MVHdmfeNr2ioVwJW/dUgp5SveARfMYrHgEVt5i8/1
         8KWMAz0YbKRLTxWLWgLXvv8Gn0vUDQ+d1ctQQ9gBZ5E3vqDeLN+SSIWd/RECHJgE8zbR
         V9T7juMsEXNAlQ2eexqQ7EwvQhP8m7hg6xsK3HULcOHcF4wZrQPe+Iu8aigUmMoNQqTf
         si6geFQ/MXQAGrsDQRCIeRXtT6XZphBrKj1WZ9m/ezevmkH8z9SPJtP3kXQCWAzeoDKU
         YJNlleLLNJZkuNfE+2oDPMpAov5Kz/fQIMip5b9RIAWFznM4okmBhQReaniYpBcYj0il
         mXcg==
X-Forwarded-Encrypted: i=1; AJvYcCVjw5iyOU0+a9JKzBMGIgIAbdPlOotwWyc3Zv7NBNKj6CAg1Y4aD6pb7oRv5FQTVi1tZiyE4XzHPdT/yWr58qnOXzvHBm8pZkvj
X-Gm-Message-State: AOJu0YwepNcjsgHxObEAa2C2mFzFXsg/mFz59G2DAKRHl+lA3juU5/zS
	gMFcnHPbKYQFOwHbrJNQuluZla+W1ZldnebmBUt/pxwNwrEcDWpusmfXCm0SuZ/7ojtSg8FKRKO
	FRS8=
X-Google-Smtp-Source: AGHT+IG8GLmaWg/wiuqP4w1J2gA1OYgTQwNSGRdCeysuEGKB6L4NffaiV742SGnq4tCbt3n45y5bbQ==
X-Received: by 2002:a05:600c:5685:b0:418:f991:713f with SMTP id 5b1f17b1804b1-41feab42b13mr263670915e9.23.1716302201502;
        Tue, 21 May 2024 07:36:41 -0700 (PDT)
Received: from gmail.com (IGLD-84-229-89-93.inter.net.il. [84.229.89.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012a025dbsm367404265e9.23.2024.05.21.07.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:36:41 -0700 (PDT)
Date: Tue, 21 May 2024 17:36:38 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Message-ID: <20240521143638.34u3kn6nm5qslaao@gmail.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>

On 2024-05-21 09:22:46, Jeff Layton wrote:
> On Tue, 2024-05-21 at 15:58 +0300, Sagi Grimberg wrote:
> > There is an inherent race where a symlink file may have been overriden
> > (by a different client) between lookup and readlink, resulting in a
> > spurious EIO error returned to userspace. Fix this by propagating back
> > ESTALE errors such that the vfs will retry the lookup/get_link (similar
> > to nfs4_file_open) at least once.
[..]
> FWIW, I think we shouldn't try to do any retry looping on ESTALE beyond
> what we already do.
> 
> Yes, we can sometimes trigger ESTALE errors to bubble up to userland if
> we really thrash the underlying filesystem when testing, but I think
> that's actually desirable:
> 
> If you have real workloads across multiple machines that are racing
> with other that tightly, then you should probably be using some sort of
> locking or other synchronization. If it's clever enough that it
> doesn''t need that, then it should be able to deal with the occasional
> ESTALE error by retrying on its own.

We saw an issue in a real workload employing the method I describe in
the following test case, where the user was surprised getting an error.

It's a symlink atomicity semantics case, where there's a symlink that is
frequently being overridden using a rename. This use case works well
with local file systems and with some other network file systems
implementations (this was also noticeable as other options where
tested).

There is fixed set of regular files `test_file_{1,2,3}`, and a 'shunt'
symlink that keeps getting recreated to one of them:

    while true; do
        i=1;
	while (( i <= 3 )) ; do
	    ln -s -f test_file_$i shunt
	    i=$((i + 1))
	done
    done

Behind the scenes `ln` creates a symlink with a random name, then
performs the `rename` system call to override `shunt`. When another
client is trying to call `open` via the symlink so it would necessarily
resolve to one of the regular files client-side. The previous FH of `shunt`
becomes stale and sometimes fails this test.

It is why we saw a retry loop being worthwhile to implement, whether
inside the NFS client or outside in the VFS layer, the justification for
it was to prevent the workload from breaking when moving between file
systems.

-- 
Dan Aloni

