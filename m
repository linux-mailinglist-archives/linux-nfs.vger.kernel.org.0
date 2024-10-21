Return-Path: <linux-nfs+bounces-7343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D779D9A9443
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE5283868
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 23:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A01FF617;
	Mon, 21 Oct 2024 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4FRDqRK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628791FF029
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553992; cv=none; b=JnFTDR5eFcO5nM8WsEuoKFU4kuzVOeezAbhjteVJvf3GH2VOjVnCJI1A7oTEUg2R8StFmWoCZlUS8tOTjN5Z2rCH+ixUCbcWJDjziKAnjfMUGgdqZmNBK0Ey5s1OpTTMnFc6uAeWyp4duD2RsNVlPk336cGECIDW3kre+4M4W4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553992; c=relaxed/simple;
	bh=9Mjk+knGxo9nQGglniMu8WtjiPcCZiTfSPn+6KQqmgY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=PASlkixFNKIxK52OcjxyfK2sPXPxj8uHO0+ZuGizQljpO9cq6DKqMfx3amtH3S6vyvcCRV4e9q9D1awBxpfd6a/0BgRepDy4CQXWBKY/PA84lfRzSXaOIIfmseSyvisSr8ooeBvRyCWG/T8KSei16OWk/iWwYsbTye0Vn5JaRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4FRDqRK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so38118116d6.2
        for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729553989; x=1730158789; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e2lRCBhF/0lrzI1nrw+s1eH3A9IyPYDFt7tmHKeZEQ=;
        b=B4FRDqRKcaXEsQ//LBESnkawFmz/cI2L8teK23drofWiu86po54i+Jmpgw0/dFNdze
         YQCu1kUfCGmgBgvwV0yAepGWwGWwfxf3x/ebdrE/kRYvCytocfehOmw+dpLludhxI2DQ
         D/BKYp5q5VHz9Vo6sw2ITl5PvT2Dm3Xc0kn92xekAY2E+uMIO6eTKI60FcFQO4eGUT31
         OUZwJkyBDdfmV8HOqqyg8UXmc/5vzIFEESga7lB0uJWyQCydBW3U3KVwd3+e2E4LQgQ7
         ITjgpVIgQ/2d+WElpNBfZK/TN54B6wNxU59bYyX3G6N2H5WSfuZHVcD/30USnOEkkyY7
         15rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553989; x=1730158789;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5e2lRCBhF/0lrzI1nrw+s1eH3A9IyPYDFt7tmHKeZEQ=;
        b=uWOsY8YWd2XCiO6wFl5V8FiFuVjYM5YSnnCaLh7WSHk1gc2NpMNifDPKyTRjJl6xH1
         vrzVdFFCPWG4dOsKGwVYrgZXES+RnnH0ky3pKjmmz5OtuO2c9f4v2EyqJMURrJj/YGxd
         Y04cYaFoXi1X2xWDBBVhFkskdccTgQdo3xSjZzzYpDav0qzRodtsXxRNUR3J8T5j8JP+
         mA+T/8L5nEFd4kBV+lUciyXV3HdPHhndjEbIpkmKxvk+kk3a5SYY2adbjM9CHBThH56I
         NY4qYzAP/CJYOL0o3xLaJ5jLpyr9DBRYCrXF+/RuzH4fpn8JKKU3V4twNP5k5PBoWlsK
         rDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW+VdLyH0Qld1lWsi1GpqhBa4b1nWQq8HOqMlm28Ro0dw0AHKb/3peUi1474cmrCQ+HsWkV8JEYvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Hkd0cb2nWI26i4Ao+ndmRTRlJn3Q08iwBlHA3q/DjXGjZLoR
	wjGntD2GGlTomg1NHSuj5/0cVovWGZLZ65opTQder9qsPX9TfNPH+KNHYFK+Hw==
X-Google-Smtp-Source: AGHT+IGc+EQuKBMmGMWGtVywnHwWIVFIhDEjXA67LbbrFi385rmMBG2jWd5aax6vHPWRTUq/OlgvAA==
X-Received: by 2002:a05:6214:44a1:b0:6cb:9b65:5c75 with SMTP id 6a1803df08f44-6cde15d2f09mr209558626d6.32.1729553989320;
        Mon, 21 Oct 2024 16:39:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fe843sm23160626d6.45.2024.10.21.16.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:39:48 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:39:48 -0400
Message-ID: <dad74779768e7c00d2a3c9bf8c60045d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241021_1626/pstg-lib:20241021_1624/pstg-pwork:20241021_1626
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 1/6] LSM: Ensure the correct LSM context releaser
References: <20241014151450.73674-2-casey@schaufler-ca.com>
In-Reply-To: <20241014151450.73674-2-casey@schaufler-ca.com>

On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a new lsm_context data structure to hold all the information about a
> "security context", including the string, its size and which LSM allocated
> the string. The allocation information is necessary because LSMs have
> different policies regarding the lifecycle of these strings. SELinux
> allocates and destroys them on each use, whereas Smack provides a pointer
> to an entry in a list that never goes away.
> 
> Update security_release_secctx() to use the lsm_context instead of a
> (char *, len) pair. Change its callers to do likewise.  The LSMs
> supporting this hook have had comments added to remind the developer
> that there is more work to be done.
> 
> The BPF security module provides all LSM hooks. While there has yet to
> be a known instance of a BPF configuration that uses security contexts,
> the possibility is real. In the existing implementation there is
> potential for multiple frees in that case.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> Reviewed-by: Serge Hallyn <sergeh@kernel.org>
> ---
>  drivers/android/binder.c                | 24 ++++++-------
>  fs/ceph/xattr.c                         |  6 +++-
>  fs/nfs/nfs4proc.c                       |  8 +++--
>  fs/nfsd/nfs4xdr.c                       |  8 +++--
>  include/linux/lsm_hook_defs.h           |  2 +-
>  include/linux/security.h                | 35 +++++++++++++++++--
>  include/net/scm.h                       | 11 +++---
>  kernel/audit.c                          | 30 ++++++++---------
>  kernel/auditsc.c                        | 23 +++++++------
>  net/ipv4/ip_sockglue.c                  | 10 +++---
>  net/netfilter/nf_conntrack_netlink.c    | 10 +++---
>  net/netfilter/nf_conntrack_standalone.c |  9 +++--
>  net/netfilter/nfnetlink_queue.c         | 13 ++++---
>  net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++--------------
>  net/netlabel/netlabel_user.c            | 11 +++---
>  security/apparmor/include/secid.h       |  2 +-
>  security/apparmor/secid.c               | 11 ++++--
>  security/security.c                     |  8 ++---
>  security/selinux/hooks.c                | 11 ++++--
>  19 files changed, 167 insertions(+), 110 deletions(-)

...

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 1bc2d0890a9f..8303bbcfc543 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		secid = addr6->secid;
>  	}
>  
> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
> +	ret_val = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
>  			  NLBL_UNLABEL_A_SECCTX,
> -			  secctx_len,
> -			  secctx);
> -	security_release_secctx(secctx, secctx_len);
> +			  ctx.len,
> +			  ctx.context);

Nitpicky alignment issue; please keep the arguments aligned as they
are currently.

> +	security_release_secctx(&ctx);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  

--
paul-moore.com

