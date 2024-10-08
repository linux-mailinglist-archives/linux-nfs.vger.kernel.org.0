Return-Path: <linux-nfs+bounces-6920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBE99451B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647B2287679
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513818FDC9;
	Tue,  8 Oct 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9pPhiyH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB818DF65
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382385; cv=none; b=LCa5AeOADicXNNEYObA2ldqkUXvmHxOlmaY34s5GPKBASpDNqbLmpRGzIclkY2Apv/HMfspLr/PxQ07aPO5KDUghxTyklhwO7IBwR3IVpkrdNaR7WqZf/9Y2sRuDTCdQgWymPpunUyCeAs4XxTrXVMy8zVBC9LyB2vuwQaJeMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382385; c=relaxed/simple;
	bh=up8LL8r/gb7q2HcdSabEI+LPjO2WM9OptcadNzpoLSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8RrgAH/ps6k3ZxnU429hX5aJdDj+tiUEH++wCLk1z/UM9TlXCh6NZSMKJbS3HigkusesI7UswSA0o2F+h5lb/1LCaH1/2HCNTQJWivN2WYPrCkkhRCHvApjkTP1d2Dm6fdCohSAxavi1yAvJbinDoPygm0gpdvUOdGfJubKbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9pPhiyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728382382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaeq56OvuUcJMmOVG0lJqXNFtuHXeBSUvSuZJk0QoHM=;
	b=Q9pPhiyH3NJYtlQFlam8vr0f//cOJKtEMQA/QK0bkNc3b4XpEM3GhJGJWuXsK/0nnI2iWc
	upUFg7WuKwSNPcN/wZPBnEk6hP7esGBISxHvSX9WnXzblfedtO5MYUc8egA31qzFOgPDXB
	ABb8lIwuMKxARj7Upmc146u4fx961B8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-pK5GIjsdPtm3_o9Glf3tYw-1; Tue, 08 Oct 2024 06:13:01 -0400
X-MC-Unique: pK5GIjsdPtm3_o9Glf3tYw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-458353d3635so101311891cf.0
        for <linux-nfs@vger.kernel.org>; Tue, 08 Oct 2024 03:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728382381; x=1728987181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaeq56OvuUcJMmOVG0lJqXNFtuHXeBSUvSuZJk0QoHM=;
        b=pPDSXtXan6Yym+dIGuqaZhAQF6ySDBqvcA2w70WCNnGjFSX+e+akZz0hlf0EiZHNzv
         ZI6mGLWty6Nb6nYp0gkCDDhbGdUd8nygXWsZ2SziiP+8f4iImigBDO3JA3eKneUAJXPR
         1WGc92JS6GpJ/3IjXAFn2+B2l8emy71Q3kxiyJVVqazg5stzrVyiaq/eux7BqOl22j/D
         70US07vuFDKGipeqnl9FS7vAOBLAjQNJXAp2Rs3Jz5E9bN9Ut/GaW+BLbTHYuqdhc7ni
         Pu0oTjDb8E1BLuUB6n+TxzQZ0j6L1KH6Z27SFy8lVzpgevLm3CTFGR5xLArb5Bu6vDEF
         oSag==
X-Gm-Message-State: AOJu0YwSPII5GLp2d35uPqe/MSP+KGi3qlkfDhdFDm1Vn845nnzG9Nps
	l9iv5ruFPuvRaNbmk6KKsI+Q/rVW2h28In0ZDRMU3iCVZEvWeE2nuF1RYlvqOooQ7CvXj6GaAUm
	M8/lIqJXxVNuOCNIA3GpBnKAwSOOkfjPEO8VzbvNgVqARQ/vjaIibXDhoAg==
X-Received: by 2002:a05:622a:494:b0:45c:e4f:e026 with SMTP id d75a77b69052e-45dc2640105mr43065521cf.19.1728382381139;
        Tue, 08 Oct 2024 03:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmfXxmnWbdNnd9XZk1fZegHgGHecEO2WqSwJyMShRpcRbQ/X4r/ygdqJqjj93vSs2xnWW0+w==
X-Received: by 2002:a05:622a:494:b0:45c:e4f:e026 with SMTP id d75a77b69052e-45dc2640105mr43065321cf.19.1728382380738;
        Tue, 08 Oct 2024 03:13:00 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7576e9a9sm337902885a.134.2024.10.08.03.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 03:12:59 -0700 (PDT)
Message-ID: <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
Date: Tue, 8 Oct 2024 06:12:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4 referrals broken when not enabling junction support
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Zv7NRNXeUtzpfbJg@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> Hi Steve, hi linux-nfs people,
> 
> it got reported twice in Debian that  NFSv4 referrals are broken when
> junction support is disabled. The two reports are at:
> 
> https://bugs.debian.org/1035908
> https://bugs.debian.org/1083098
> 
> While arguably having junction support seems to be the preferred
> option, the bug (or maybe unintended behaviour) arises when junction
> support is not enabled (this for instance is the case in the Debian
> stable/bookworm version, as we cannot simply do such changes in a
> stable release; note later relases will have it enabled).
> 
> The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> Moved cache upcalls routines  into libexport.a"), so
> nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> in /etc/exports.
> 
> I had a quick conversation with Cuck offliste about this, and I can
> hopefully state with his word, that yes, while nfsref is the direction
> we want to go, we do not want to actually disable refer= in
> /etc/exports.
+1

> 
> Steve, what do you think? I'm not sure on the best patch for this,
> maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> which are touched in 15dc0bead10d would be enough?
Yeah there is a lot of change with 15dc0bead10d

Let me look into this... At the up coming Bake-a-ton [1]

steved.

[1] http://www.nfsv4bat.org/Events/2024/Oct/BAT/index.html


