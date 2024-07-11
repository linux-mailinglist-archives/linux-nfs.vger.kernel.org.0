Return-Path: <linux-nfs+bounces-4790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64992E17A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69285283DFA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B814B095;
	Thu, 11 Jul 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="M2aJwt1C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44714BF90
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685172; cv=none; b=LUts+tHqQjNMS/2RqJFkh7MKvvT47rp2Z2oYlEDFMihTcTLy7iDihpgWv59HHZYAVmq2XTHTaJJ2rmfRwULYhCv/OAk6/rFEKJuqto+jtBePSeCC9NmYkhL33kWgzixloWh8vh/H7ELsqUzAn9BNMQHnpARXNHPyy1W+cdQUFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685172; c=relaxed/simple;
	bh=/BrMFqsjgj2VlYpqGoEgVQpbHgljPR+vIRy1BYXrhXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUmZuTo/0y0PCEeAFLXP3knpZLFA+Fn/zVpbxAADtAt4uOL1S0ePLg4SfLHIFsoaLSFpX3aFQo+T38wXeuP11ovhnFaFAELX0OUiSoA1+1i6CtxVkHJjL1ENUhRQDAjSzNjZUL5ycYickqFJYckS1CPPpZl35yan9WEtaS0StPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=M2aJwt1C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426717a2d12so3489515e9.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 01:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1720685168; x=1721289968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6rkVekRuNSjzTYjX6o36LpV8zC7zY46tfH12XV8Te0=;
        b=M2aJwt1CQlKXJ4SiR66FPIEmKx2D8eBO3qzqq1QKMQblmSkLmMjyrsPl/pz6xIUcw4
         nEjhpaF6J5B38Q+uYItKEF8IvcLUW/l0INjDAG70hW7iMA0egcjFZyy+X5xs4brxSmk+
         XTy2oqDtNpqjVieSoD6QEGSv7xCWG8u7SaiTEiOAhmxcyXgNrNZYdZWPD3HMgMEIVaB+
         eUVq++gxJv0hGjHTy6Xp7s2VBWlnooPgBsjF66ryw+3wDHwUP1uripOPgNCIaSi5QbZ8
         3BlhP/9O12Ph+G3gbeaLIW7X5zcXrvNT8KH6f0Xayfk5RtbbIm33+LlGYy0phXI+oFOb
         iYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720685168; x=1721289968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6rkVekRuNSjzTYjX6o36LpV8zC7zY46tfH12XV8Te0=;
        b=QBfWc3pBnOep/iaFZgAWS6M/sKxGckUWePxQavi3caSZFDaUCbmLTSX3FkH9gvz4KT
         1PF+rnGVY2dVi1Z3fMfqP3pjextkxPoQ/yMhNRT37yixI1a1OzS9wqr0UpIdYNyXBqQP
         RVifYoUi+iSMagBoJn1Tee3pySuyf+49I/NkvZTERFnxj9Gk3WjrgjrAKxaQwL8GYcNo
         7jNb2lPcpMrW/BdV5NyB6CXXZMHcMUYAOuf2u1tl/QKezIuLBmdtVoCcrUTa2r/dX61G
         l+iKT/zfMzbeiIINIrWLh0YP7fX4+PzRb9a+BdeSlBYRXDafhORhP6kHj//92e2GLqcm
         9zug==
X-Gm-Message-State: AOJu0YyuRzR/sh3Aog0Zv5UmGZ3iurjBo2dEcuoMs9sCPto1UHJ5UwJu
	mufyytSpMxDazrp1aQx4Ac077+cY4chzym5ImRUilGCJ3QPnU8Ntltm39CeHIQM8u1iYTKBEvaP
	M
X-Google-Smtp-Source: AGHT+IGzrThZhhwFKmqQYKGHE3IZckycWyEsQiSlYVUE2JG4yugVEFPKmghGwCi9BTWGG++dZwalPQ==
X-Received: by 2002:a7b:c059:0:b0:426:686f:7ad with SMTP id 5b1f17b1804b1-427981c79ebmr16988665e9.10.1720685168610;
        Thu, 11 Jul 2024 01:06:08 -0700 (PDT)
Received: from gmail.com ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42725eca905sm85220715e9.11.2024.07.11.01.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:06:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:06:05 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost
 writes' prevention
Message-ID: <20240711080605.tvnimzndq4kuhp6l@gmail.com>
References: <20240627100129.2482408-1-dan.aloni@vastdata.com>
 <1e66a583-f18f-41ed-b87c-9e7b4045e009@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e66a583-f18f-41ed-b87c-9e7b4045e009@grimberg.me>

On 2024-07-03 22:09:58, Sagi Grimberg wrote:
> 
> 
> On 27/06/2024 13:01, Dan Aloni wrote:
> > There are some applications that write to predefined non-overlapping
> > file offsets from multiple clients and therefore don't need to rely on
> > file locking. However, if these applications want non-aligned offsets
> > and sizes they need to either use locks or risk data corruption, as the
> > NFS client defaults to extending writes to whole pages.
> > 
> > This commit adds a new mount option `noalignwrite`, which allows to turn
> > that off and avoid the need of locking, as long as these applications
> > don't overlap on offsets.
> > 
> > Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> 
> The new name seems a better choice.
> I'm also on Christoph's camp that having this behavior be the default makes
> sense given that we have large folios.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> 
> Trond, Anna,
> What are your thoughts on this?

Pinging. Do we need to do anything further? I can prepare the nfs-utils
patch too.

-- 
Dan Aloni

