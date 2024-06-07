Return-Path: <linux-nfs+bounces-3617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE17900BB8
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2C61F21796
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B8E19415D;
	Fri,  7 Jun 2024 18:09:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90C13793E
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783788; cv=none; b=WWPYxCPhDc7LYb/icHPt8PEwXVP7JEfkXaMEwMRRFVmqFDZ+Xhl6JBEeUK5wbjo2JQSRaRRUuJUESuZCofbUxC1JjIKt3R1cTt8iAlRDAvzfwPLifxRr/KvkHZgZqaKb2zKVI2s7HPpMOIq0K8Hu6Dr+i0d8jScdaspEzzKI59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783788; c=relaxed/simple;
	bh=fpi8Vyb+Li3D/1JBkgd0S5vi1rjs3dJmW/xHwSMKXD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2cHIajFrYRYqU3rCaxpD0OjTncZvjGm3iPUEYc7ouJpdncKsdHDAQbS/aXMOAnsUYNDsnsWQvf4tIGPtm3zCgukz7qo5VEEM0yTf3Fk1v+xK0PPm/pRCqnTrDBcGPciAu57zC+hixLKS0flrDROTLue6UmJuG4aBlGf5+QKRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b05c9db85fso4851316d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 11:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783785; x=1718388585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5Zh/43/xQ7AYe5qg5zcZU31R5wWNY8+4Jdsl0IcVhE=;
        b=lnnTyBUwcYRZWIoHMfJqirhJMAKksxFZMZq+ViDqKLIhEEHsvNoXKd6kEqlDVl1iti
         LfFa13lJwM92lVk4mS6FZFEaJckGa+Ct2RUa6JNjpS6iJpSV208tbozHr6ImXmpSiZQ5
         HHVWqAzP0QCfYxT2kX7212pYrwd5lEIrEkwuphjplm7BGsaiVJQIy4mokBn0bKAJZxJ5
         5esuDt4DlhsRzbvm/q2H58z3BejRzyTYEGG/D2Ef6L8MtZCcliBENGaZW86TI0MZ9/zH
         g6xOfSAkPZg/8i/6gwgqhpsj5ACYGVgaQ/0uRAHbyrXpqpWWQ3i/WHOemSD7rClSVeKM
         oT3w==
X-Gm-Message-State: AOJu0YwFQOSR5EDwROcUkOE37kBVsJ4RdaCGm3aoajSDmIYOX15CsEnD
	bG/NXHb0TG/Hk+dTFGr7xOKtjGn3P+AC87Vyq1WI/Xy6TQ3lgYv+1AHjGAH5Mdw3okL1wfHLNR8
	GO30TOg==
X-Google-Smtp-Source: AGHT+IG90SHyyeekxe+0FKrpDuMMXhOZgW8m6KKzkymM5/Oao1Sk+Qfh+Pa4RWX+fBModroW5BWaeA==
X-Received: by 2002:a05:6214:3d0b:b0:6af:5500:44a7 with SMTP id 6a1803df08f44-6b059b35214mr43459786d6.7.1717783785210;
        Fri, 07 Jun 2024 11:09:45 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f718fb7sm19215336d6.62.2024.06.07.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 11:09:44 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:09:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 00/29] nfs/nfsd: add support for localio bypass
Message-ID: <ZmNM58Zx8sltLxtp@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>

On Fri, Jun 07, 2024 at 10:26:17AM -0400, Mike Snitzer wrote:
> 
> My container testing was done in terms of podman managed containers.
> I'd appreciate additional review relative to network namespaces.
> fs/nfsd/localio.c:nfsd_local_fakerqst_create() in particular is simply
> using the client's network namespace with rpc_net_ns(rpc_clnt). I have
> an extra patch that updates nfsd_open_local_fh()'s first argument to
> be the server's 'struct net' -- but I stopped short of formally
> including that change in this series because it hasn't proven needed
> (but more exotic hypothetical scenarios could easily expose the need
> for it). I can append it to the series as an "RFC PATCH 30/29" as
> needed.

I did just post that 30/29 patch to this thread.

And here is my git tree for these changes:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-6.11

