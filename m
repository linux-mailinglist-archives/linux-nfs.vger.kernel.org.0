Return-Path: <linux-nfs+bounces-7611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB69B865D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4C3B21847
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 22:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110901EBFF6;
	Thu, 31 Oct 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CTnMub5d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFF1D1310
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415232; cv=none; b=QA9Qe1EhCYPp3P1UriEs0w7edAopTaNkMto4YHpxtLzW3nP0bTej5w3r8OFpyRUawj3wlp68fkGNIZZvqO7jp8u7vM4x8KTZsNM6kp1lfbzwf6M3T8tHXLbm3AkGXvvdJ7NQgIxCtjj+xpyyB36RmLvjndUMi31Y5YDkQh5NbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415232; c=relaxed/simple;
	bh=BDJdR5tVzmh5dizUpgrVvPq8LICL0s5XylwlqyMeGjM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=DZWbYLwn+K4Yw9JBJFz61q06mb5AaNjkPgFyaHztW+UKAWZEbs37i0c2vnAXC4inbkWnUpLjBHZ1dmGETBtxyUK314Wuq6W6PVxxS5dz9oKrPW946fZ0Nni3YOH8Wph1e4lPUxxAbehJqSZowrtND5z4bv8AlTufdW3qikkg2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CTnMub5d; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b18da94ba9so123365085a.0
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415220; x=1731020020; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMeaJ3dGSvREgbPQf+JCmGH6FTTejL81SGUx/vgLdsc=;
        b=CTnMub5dVwuBSTlgfxp5Q+Nt0Xs2d7LU2Q1PT77d6vOhJ1s0rT00Rnnu0R2SQUoDUp
         NBtQ8JUYtg/EExoymmtCvx7OVz6EUU8XST4xeOlVNMQomDYor63PXjWQLjPgWmSJ5C0v
         jyqSXg5AD2vyHhmYiirzLQIBLy9hcMVsX5wCt3+pzLBk2izXlM6GAp8OaOa6wVWCGfGv
         /PmdJBnnnTKX93sUUQ122cJDomNb5Ieq48sKGfNJEOP7HoLdVcuqSRcwtz1TfvqBFEUt
         0fCT3pqgeOoAZOq3+o9eM2FKhzx58GAdTcRdW9vcOzdlgVjvwNaac6KwKN09nW6+tu/I
         a+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415220; x=1731020020;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMeaJ3dGSvREgbPQf+JCmGH6FTTejL81SGUx/vgLdsc=;
        b=eTep2pB3tF13KAxNM2dwRKIseYkkPHmU8IHD4KI0Ryl9wiHtgr3q8lGpSgHzUEFnVY
         fnqyt3iV4m/uJ/ocwRCpN7j/Thl64tmF8EW/fl/53cTydNITAOSqAqfWegHoo1TrlJKl
         APfVCy+9/TT2rnCQMvqDIy0L1TJZvmrLwj47TLOKAr6lLmkKIC0B/g7PCEqzf9xCzP+5
         6GsWw4XMNqcijAW6ssSAW048CXnszGKrvHaKj3AjYfEs0YQ7frhi2oSIjbvj0LnN0E6E
         u2c/yToySmFFJzENrXDZgnmohs5mGJy7Ov2g+PIxaeshHnd9gcw/IOfLyLGA4kTJ1oKH
         k9yw==
X-Forwarded-Encrypted: i=1; AJvYcCXulW87nY0fOsc3y4rPmW4Csh2vUePnPqrVea439MMAoY6pvzDcwMC6qkm7hAJG/S900bqwsRLahSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEdljxTzUo+9R0ey8p680g95tH3po24s5M4f/VxZhNFrJlIY5
	TtnIQEsG8P4+WwLtYPnmol5iKUVEkh2mVcCVhNnJmUOMDyVZuJNTLQPzLNbuQw==
X-Google-Smtp-Source: AGHT+IG+igldW75wPFcvIPuMqdxa+k8g3IwKJeTuYvaI0vnsn5mlrSCaSUavQE103p36m8T74a9/hw==
X-Received: by 2002:a05:620a:2956:b0:7ac:9b07:dbd3 with SMTP id af79cd13be357-7b2fa60b808mr303815785a.5.1730415220453;
        Thu, 31 Oct 2024 15:53:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9ae1bsm114481885a.123.2024.10.31.15.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:39 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:39 -0400
Message-ID: <5e5c5e04ff82a8a8e94f02ecbe63b1fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 3/5] LSM: Use lsm_context in security_inode_getsecctx
References: <20241023212158.18718-4-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-4-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Change the security_inode_getsecctx() interface to fill a lsm_context
> structure instead of data and length pointers.  This provides
> the information about which LSM created the context so that
> security_release_secctx() can use the correct hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/nfsd/nfs4xdr.c             | 26 ++++++++++----------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  security/security.c           | 12 ++++++------
>  security/selinux/hooks.c      | 10 ++++++----
>  security/smack/smack_lsm.c    |  7 ++++---
>  6 files changed, 31 insertions(+), 33 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com

