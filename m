Return-Path: <linux-nfs+bounces-3637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E746E902746
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ECB1F215AD
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982F1482F9;
	Mon, 10 Jun 2024 16:50:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67911148308
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038219; cv=none; b=tZMBRGKnWcz2RdUN8O5cXETbZC6Ji9sH8E0pNpaZQt/S1oJVXc51/sx/d3AWmPnfB7PQ86jgLOml4Wz6C5ufUPmxcHmc0MqJ22ZskusTgqgz+e5srJBSeJMQE7d8CZpRQ08edlEd45HPVtfe3YiIP9uWFjF23dm2h08247LXeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038219; c=relaxed/simple;
	bh=Z+0jScfH1G7pmL6vbJOQoykvr4MVWzmPvRo70VDKKtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/OujaRx6QRpFZ8kcufxhFL3mgvvLDhzlqXQ4JG5dijF9ovl4UKSMirQ/fErYCg4Cp4shI9KyJgJ2PbKRVKNkLH0JjtN+7pnVo4AkFOP9vmYLCgK/xEw1Bk44ZT74GQiXPpdYyz4M5V/j8HNzwdEzQfjjO0iqg0PSMtMqlnI1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4404fae8c6aso15668371cf.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 09:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718038217; x=1718643017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY9VU2Vdt9DZPNVgz3omV/LzsiT6fHb6OMdsw9aB2hQ=;
        b=OEeiSmdZy27CC3SB+BHKSmRfJ0rMbgR2owch6NnBGOJiHxQ7QCVvzrd0kdTYr7ij2+
         MKHf14K+of9sTZmaHBHhojKiXQTyiBRzRI49O3pxn0F7pWhL/JwnKT2Hz2pOQB1U8Qdk
         6S2br4+oRwvpD+gOmSakSrVy19LtMErCpbY/rYuSqo++A9dWQdSBPuKqD16LfbiZYLYj
         1SU7S4ytA9lejNNOLELvlzvgiYei9nVcJXcuL93SEEqAWVwzeLWm0y36CniVr3TrO7A7
         lUz7qMUm89vMVaf51KgeaD7zx2Cr7ljjh2mGwj/jxoT24AN9Ct03K+yUinL/cy2ufBYZ
         Ycdg==
X-Gm-Message-State: AOJu0YyH3OXOLMN+0o5GXS388/XDyEtHcQ3ZX9pujW5d9uTRX6uXwSPs
	aG3hkf0V0gPF3Lbt/bmL21Q0UIFUBUWr76EjKIwy8MitctU2oTC1IFwTjfXMCjM=
X-Google-Smtp-Source: AGHT+IH269/22BZAEJNcaGFsvfDjLSbGiVkx9IUkiel6/eR8tPzSPAbwp/Q+nCsxEPUrHyDSRQGReQ==
X-Received: by 2002:ac8:5f46:0:b0:43e:34d3:dae6 with SMTP id d75a77b69052e-44041c7a734mr123748071cf.39.1718038216964;
        Mon, 10 Jun 2024 09:50:16 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4404efeb448sm27607191cf.75.2024.06.10.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:50:16 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:50:15 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 30/29] nfs/nfsd: ensure localio server always
 uses its network namespace
Message-ID: <Zmcux5OZbspwpXRo@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
 <ZmNMCejlYlDgfA1Q@kernel.org>
 <ZmXN2/e5FmRXsvIG@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmXN2/e5FmRXsvIG@tissot.1015granger.net>

On Sun, Jun 09, 2024 at 11:44:27AM -0400, Chuck Lever wrote:
> 
> For some reason, I received only patch 30/29.
> 
> -- 
> Chuck Lever

Odd, I did send 30/29 after as a follow-up (in reply to 00/29).  But
linux-nfs definitely got the 29 other patches.

I'll be sure to cc you for v2!

