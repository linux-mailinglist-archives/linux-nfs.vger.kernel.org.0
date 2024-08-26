Return-Path: <linux-nfs+bounces-5721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846E95ED7F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51961F21995
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C71448E4;
	Mon, 26 Aug 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1D6h97nm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCA13D630
	for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665148; cv=none; b=Gr8YcF9Zolg+Tue6arLjdF79N7770uwohXLYl6B+b9LUExvPyslhLhUl4uMlp6L1dTxnI3l0qbRPiYC5eFzYXWA9wWyHB/E9psaURa8ZHnRXzpLog3wWfKU4ZWorhwfWo1EHfpUFVJvWySVPdavoD19bsRsou3C09Z0AwNoR1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665148; c=relaxed/simple;
	bh=q5NKpvpQmHFhkVuhB1yf1UaD8tdgXAOJImWQRQKU2yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRGFOL20BU2DifwXLc0FgX58SRi/Qk7NVSK9Oga4Gf2Ra5N4YYZm7dfLuY4mJYL7yR38FrKwSx8vcfUwEC54XoSvCOjKvQLDN5P+JqaOq8wjdNYnwS4TzDH2pzyxTY0dxUU4dUuR4p3lBOyycDBs8X7hRpGV6Knt/1Ye+Cf6Hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1D6h97nm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a867a564911so492654266b.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724665145; x=1725269945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x/Iy4WGMT/angdlokuIQnh2/Lh8TylG6czBnlIKoXY=;
        b=1D6h97nm5Ehb4XrmamqBRFsGGI4VTACwW5KzkGYoWzxvaeUmHozj6BtajzISbxCpgz
         H/jAgTB0nuveezaz3/Sh6KKHXNHRYhvb94OnDQadgsTBjs8C2kWJE+Nejv8qx38cTBhb
         CF9/ZFB8m8xW8JgXOBtr6jkmu3F/6M1R/gksdDEts1F8jTA+8FHfZ9OkAkfegQmJ3Nja
         ct75JrG6DKKUm1OonPHCoztYMZrlciw85g5ycWeqWUJFAdm69WTyk/woPlV/zXGh5YE9
         IQek1fNvIOsjQbqoGK0nArOw88D27kagz3L7LXzRo4wslz8QBgEKzfP0hI7q7JVAA0DJ
         Y2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724665145; x=1725269945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x/Iy4WGMT/angdlokuIQnh2/Lh8TylG6czBnlIKoXY=;
        b=PVqCfcxnx6UJI03FMf2O8Mbi6QBrOjUuD62+G5NfOQYw8aBhI8IlqxjjkVtEr1wD2M
         nqQzdW1oTuDrwTwHtPahcTRGUJUZtnzpXRddrlFMeJk81y50nZevKWyw1DRKK/2ErxoR
         zJqipEf7V0Tnzlv+dU9IozYZV/z+fhmDqQl/UEvCyZ7Ds12yzA3Nq89u+sbUg25izSmk
         y5QrkPoITrfWjwDysF8LH+yOp0cZ9lRTqr1HlaQLwODuqw8YlFS8YIiHD+Liy7RsFjbn
         Fv9FOS5BNIIbWGAxHF508JzlqNaM/AAIg2FpxnGsg9e2zDgZJg15NJWgjuxwHI+abwVH
         4uIw==
X-Forwarded-Encrypted: i=1; AJvYcCU39OPjW02YZwV5cxwa97sozAsGphXyr79jxooUIJFIlbIjhICosDX/imoOzCFnFkA5uZjpfeVs0pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOH73rY+WoX01zTqLlvzpICIop8BskU0TFQ7J3fquUzjbYorHT
	qIfxXHVpqDcWBVyYaICptSRB6mQNk6Hpq5hnO1tqT94ya3uXx1dq4cAfigQw5Kg=
X-Google-Smtp-Source: AGHT+IFpRjFOKt+B50Fc+4D5fJb5MlFKXArq0SrGZwNTFTrYVvRDghIi0mHC4rGnYSH+FWm20Km7cg==
X-Received: by 2002:a17:907:f702:b0:a86:a3a6:c143 with SMTP id a640c23a62f3a-a86a52c1b29mr619779866b.31.1724665145123;
        Mon, 26 Aug 2024 02:39:05 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4360c0sm640406166b.108.2024.08.26.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 02:39:04 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:39:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yan Zhen <yanzhen@vivo.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org,
	anna@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net: sunrpc: Fix error checking for
 d_hash_and_lookup()
Message-ID: <ZsxNN-CmxarJi9ns@nanopsycho.orion>
References: <20240826070659.2287801-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826070659.2287801-1-yanzhen@vivo.com>

Mon, Aug 26, 2024 at 09:06:59AM CEST, yanzhen@vivo.com wrote:
>The d_hash_and_lookup() function returns either an error pointer or NULL.
>
>It might be more appropriate to check error using IS_ERR_OR_NULL().
>
>Signed-off-by: Yan Zhen <yanzhen@vivo.com>

You need to provide a "fixes" tag blaming the commit that introduced the
bug.


>---
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

