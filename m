Return-Path: <linux-nfs+bounces-14547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F3B826F9
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 02:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7944A4E2D1F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A421FF2E;
	Thu, 18 Sep 2025 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C911E51E0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156379; cv=none; b=gSf8Oh/It3J9Ab0rwoF6zCcCtEL0xGnV0NyRqg9KDxwdx+IMDEU0iEjjhhyR1sDNRlL0ls6HirBW7RBljwQqQyEP5tlKg0iom8eEjXi1Llbv/5uTQje2LNVBHUJ37OxohX8V0YZvVPOPkv3h7pf+vrfDNNAkK8iAOgjMMKmX8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156379; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHyA67E6b1rMtxLMPplWxk2MLUI40OxdF32GNNT4jn6OSVik0Xj9AJHJoViVB9Ff5tMjINKcDfNRtEONKzhvcBGRneMYGLh1w2Gx3XdpMkngAGxLJhSZfaYrBVfI21EsTn1r1JT3o+h8ZqJ91lOOlxI878Oda/53qJTmaktyiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so52636966b.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=iu2LXM6zNwSe3kYj2yd/67RrbtFDjnidjueki3aSuHBXg0rnr4pGz0zt2gPGVFjTiW
         huKpIuvigtb3M90m6OrveJW4IrkdyQSgIusvUj4YGRd9yVyH37YEnYq7MPiGkCu8HR+D
         NNVXalKR5B5MmPakrSsMWMWXJeq/Tqw0OITTUO17qSE7qCdgwLdAyCGJtmu2XtHVnYyW
         GjCMC/omIgppf6afZV8QGU1ZwEka6rBl3IFV4muYmELnIzcROSN9IOxif0rAbhQ3Fvho
         cvMSEDbcqU4YK3RLsaQiuBR4NzTX1cpfWC7dZ0D/AMGTiWrJvlzyyjpgqqqpphEpILPq
         cMtA==
X-Forwarded-Encrypted: i=1; AJvYcCVQx1pMD7z9mKVzBaA/3ttCu/a/7ydbnyXk1njOtOYRPKIiJzb0eC+Mrp2UE5IolPzsafDX4EDK/m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy937V4UngazOn3S3rk3EOb7wuSEyOumlNYdGI7cORl4jfUfN
	/ceo+fnrGIhoEfDZZIAhpZvKUPB1qZnwZ/aB7V0evBM7A2RuXwlCBwoM
X-Gm-Gg: ASbGncu2wtTblA6FH7ALUa2NiR/CEpXHBrV8EUXNoKZMc+QJp2/YhpfSmalZy29lbSh
	w8KU7toObDM6LleoessTtVqP5ZAGk+O3LKf3Is5HZrbtS1o6zqNe+GTQ2kclGKXjB8/+TOJ4Iug
	DmelucylJcVs7NLmsFtKR64lH7Fk3iBE20NDi+Ig0+/gu80LUTg8Jlbf09sVqs6puMkfyK4xTIQ
	4YCRQUxrlMT1lMilYSYjvd0fYc7P8gYS99v+0LDGM9lCP8HyVNE9Lh+KfMcCXsv99RnCBMgU5PB
	MCWix3sPEb5NFJ9ddYaFbwtkS57xGAlIua/4IAnJrq3DiSjS44P2oblqaNgEjKaRnvGw0yXDR25
	8Vcj8E85f3XX3ejF48qVuvI7bs0NDzkP1ffhT/Q==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin

