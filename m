Return-Path: <linux-nfs+bounces-5724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968CE95F011
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 13:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16923B228A5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3215532C;
	Mon, 26 Aug 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Jg+gnVXN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C61514F6
	for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672662; cv=none; b=m2p7nBeyuyHmqHXRMG4HvdlH/sQc5mkae/9e9zSX0HPVgI5K8/qYSoLcv1YfvF2WWwrsohoThNtFeVWpRF5ouppqtSqgob2N9GKzuMxM+3zPINfUh4K86T3IIAjg23lsHIh0ltpYkCytx43e2258viqi2h4jwz1gwxtGkxF6ZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672662; c=relaxed/simple;
	bh=Q0WCBQ+YQhJIRNMx8ZqrxOmrXT56oBALfKJQmsCvtjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCKfh84uA+0dEKN5DfMDqp6zgvClUgS2CKaUSb4Jn4SUbmRKCY9gY6j9oYdvudSH/5VZnKPzAav74jkHZEGjHAqtbZ55lJFYMW3R4p5qN0VHA5NM5kXHzg7TRZmbxIrTmpuY7J7tyaVAp8dKVaXcqKlKHFZIeZoJcogZWq/J9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Jg+gnVXN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e3129851so37589765e9.3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724672659; x=1725277459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUOttzFKwY2nuZEkD+CwQhqUwBV7ybSocpNKcj+DgY=;
        b=Jg+gnVXN47c4XZ/bOLnGZ+jCShSixFgRKiR3S10+NjKVG8A3+nen0q0/G27JlnFSsZ
         paZVCYJRR0pJZEtASFwZMWqjtEN9OfGX1HcXbb/nvHoQytjSMdEr88EqW6VwNcPY8SSN
         E3W/u8C7vtgf0NeIo/8N9CoCnp9Kq6F+TwH2/gCQ0LhmLIsJFfm0eIL5MGSfHDkMHMDN
         ZweNRtTmvN+HWVo5syRyXqq+o6J7O+BWpHRF3y4s6XSCW2p65muWqQp9tyzfW45k2w/0
         AXyim/u8MDr98fCv36vXSI8D8fsCzi96j7BinzFzKhY9djvBoewLVHah8ELlu/UOPaHm
         dbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672659; x=1725277459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjUOttzFKwY2nuZEkD+CwQhqUwBV7ybSocpNKcj+DgY=;
        b=OwOQIVDTDmMWJQW5DTCXTgGzIgh6JPBeOAzkgIp5qxLsTC/AQ9agPAPTJYR1abnKu7
         9a8OtuznRbVKmhbxK0ySUlG54UIJ0AAQO78URQm/MQ1Ciz8BDcofNCtGD4XUJd1q/jqc
         VHZcFWfKMJYo3bidT8b03gae6Db5aAGDKeeDgKXNmPrR624ti4qCg/h0EokR/95kifKw
         gWCCIIZhV8OH2Y8N/Mb1k/UGlncBXvpLzo+4a6I14MD1pcNJzP6e8O6qWSnDgWoChXvt
         6BT0EWd/gvup+m4ceAqQFXKE3DE4beo18WToqrs1j63aWrSj2YrMyounIcAwGJtqeJXf
         gPYA==
X-Forwarded-Encrypted: i=1; AJvYcCUHG8XD5onIsp/5rz2fGVw5QgWVWXNvuIQOBHdGiZGR++rliXQIlMdbIqp39rMONkrgFnTK5lHGdS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBioGTuSJhbmGYB1GLGTf5He8hJGkkWdv1Ya/alWQ9MgymAM9
	NcwSeOmY8xAloRkRHhPf/Wgmvsl0UvWJD//rKbjK/hsXiFCDpGjAyLhJq6A6VPk=
X-Google-Smtp-Source: AGHT+IEmvcGc7wd4ir9DzV0B4XPRNnCMACGg2Jljc1sciB66eE9kAhJjzoAZa61suLeAH/Jsj+VoBg==
X-Received: by 2002:a05:600c:3b90:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-42acc8d35e0mr64320925e9.6.1724672659114;
        Mon, 26 Aug 2024 04:44:19 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811044bsm10569394f8f.23.2024.08.26.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:44:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:44:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yan Zhen <yanzhen@vivo.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
	anna@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] sunrpc: Fix error checking for d_hash_and_lookup()
Message-ID: <ZsxqjkYDk1k0EbPn@nanopsycho.orion>
References: <20240826112509.2368945-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826112509.2368945-1-yanzhen@vivo.com>

Mon, Aug 26, 2024 at 01:25:09PM CEST, yanzhen@vivo.com wrote:
>The d_hash_and_lookup() function returns either an error pointer or NULL.
>
>It might be more appropriate to check error using IS_ERR_OR_NULL().
>
>Fixes: b7ade38165ca ("sunrpc: fixed rollback in rpc_gssd_dummy_populate()")

That certainly does not look correct.


>Signed-off-by: Yan Zhen <yanzhen@vivo.com>
>---
>
>Changes in v2:
>- Providing a "fixes" tag blaming the commit.
>
> net/sunrpc/rpc_pipe.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
>index 910a5d850d04..fd03dd46b1f2 100644
>--- a/net/sunrpc/rpc_pipe.c
>+++ b/net/sunrpc/rpc_pipe.c
>@@ -1306,7 +1306,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
> 
> 	/* We should never get this far if "gssd" doesn't exist */
> 	gssd_dentry = d_hash_and_lookup(root, &q);
>-	if (!gssd_dentry)
>+	if (IS_ERR_OR_NULL(gssd_dentry))
> 		return ERR_PTR(-ENOENT);
> 
> 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
>@@ -1318,7 +1318,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
> 	q.name = gssd_dummy_clnt_dir[0].name;
> 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
> 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
>-	if (!clnt_dentry) {
>+	if (IS_ERR_OR_NULL(clnt_dentry)) {
> 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
> 		pipe_dentry = ERR_PTR(-ENOENT);
> 		goto out;
>-- 
>2.34.1
>
>

