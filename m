Return-Path: <linux-nfs+bounces-1832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C784D854
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 04:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380F81F2335E
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F1523759;
	Thu,  8 Feb 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IcWVCa8T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C81EB2F
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362318; cv=none; b=hL2JRCIOzjW404EqnUU1QIZmCzXFomRPwEyKMRRZr6XKcvf2BGz38JxixoNw5Lpd8uMPqfurr8Bn0Lag9BLZoU8UiWm5130flCvYRFkGIzwfB+OBx+k04tI2UnIi5UThi3oEfjjrRz5EOzdAMtJTSv7rmE4xDRd+mMSYdYQPar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362318; c=relaxed/simple;
	bh=Mj1oVEs8/tR2ejpl52OYxSdsxpbLKdfh+SYW6wdbBe0=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=EVq/UuX2FB2C9zyfSzRlElyWdABrAV5X2jSKN7LuJBmVMn8UpJx3ciJz0IChXlG5ZkF6pqMJ1cIZ8v5P590I2f538sKFsOPFWChZ4rUkguK7cOp6hphHd7cCir0c2zwDQ1Na6QrtvoDfr0+MTd+HFVjRbkwz6GmLAPGgiGhrV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IcWVCa8T; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7838af983c1so96284185a.3
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 19:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362315; x=1707967115; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcq2+hqFR1nHX4LJfZARWtReUR07r8T5xEdLZZG4A8c=;
        b=IcWVCa8TDTXNtBVwkeVYFAXdE2CT2gd2x4YrlJ90mlwRGtZP0VThrSLYX3ERo43h0u
         2q+v2SKbVfJWV1BljdI+MZd4cTxDrr5mKZ1Mhfb8N+zMSn0OmsxP5H2QQDCtxaKFnqGv
         kiaH0ZW+cVkejjGZM3l90W5Y66r7x0weQhxdtAnQ8NindecL5TlEHbEs+O986wcJAzpl
         lK6XtnrCH81kjyoKyiyZWj3zsVQcXkyAPIkVlC3hxO/nUo89aJfSb+5o9UwHlTr4uf3c
         vxo6Ev1ftfhdsp0mWjIFYul/xG4/7QzuWqcDuv1mSRHdXzMflDST8jNrQgWnc3XwUmc6
         WU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362315; x=1707967115;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcq2+hqFR1nHX4LJfZARWtReUR07r8T5xEdLZZG4A8c=;
        b=LTq8G+WsYdnlboptrCxD7OFICNeiexTT67pX/MVQGkdt+kRCK+OQxl+BYLeXD3pZMC
         0Ue27Y0IEpSgWzOHDaNiwGBT5wosRaG2gZSlqjUGS9s0TMk/uRFDuytkSYzl2kuxni+H
         PeG7SMGl8yQNhroIViXmhHUicCv5pXnq5enBxINQoGYZV2C1LgCq+lhQJ9WoIp0C+qrS
         KhZs8DEPsixSTbCs3GhG3RKWiN1nuNfXEjziIyCLNEgMma0ZCjvuC5XKKu/cLfMYC0X4
         aed6cJI3rnt3ulUqfaUnHLRXJ+T4TQz8oTYYZxAiZZTQl5LWenIQv6S/cfYXhPiDEdnD
         pjDw==
X-Gm-Message-State: AOJu0YxBCWKAoVw2mqv92eEqFmxsTSBGLWwZr1S0AMJIb6py00/JJXAv
	p955Nl1z7XWWMgeYCrp3SJRx4yx9MZ4Q/0ViX9dXcX3TZR7B+qC4+WrpWb/ttA==
X-Google-Smtp-Source: AGHT+IEfv1OE/sBvIbTDyX6+68RdPWz2aYQtrH+l/gU8LYTFbO0FjQcuyg2zT0j+2BuurnJO9A3B3Q==
X-Received: by 2002:a05:620a:4942:b0:785:5ffc:805f with SMTP id vz2-20020a05620a494200b007855ffc805fmr8019603qkn.61.1707362315514;
        Wed, 07 Feb 2024 19:18:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyg/tK9UCxQzBrnYzW1BOqhfbb3kVzTXzx9zfKYJTaQbs8buhfOVx20lF+CXwWUbIlaHaRrMvFDy3S84fnjuEbRQhKLrWISof2M+4lXxvt1x1fEfxWbNRMgRuSFiFL99yxAywyKDOiioaVbx3pXu0bH+gq2kv6UQyZTg2Y2yw2bUiBNBMok8Aep5FU0NIomITJzx1tBxVmkDRrY9/iufe3YqVjk9mKNVqgfhbz1NUQpGTvwfNmXPG7A5IcB7V+dCVMivlqWEknq3nu4SWQCx3V4Ei31AeYC37+JjANO4NGiYT8P3PfJgXgOMmS93g/jVoT4gN6MOZuVZ2WF9Y7lvoJ4i+JLV448ecapxC1EGxiFdkAwihcZqNVjdRMLsFexUYrOo92MA9N4auVUwjh7IE/Mi+ljv59ptVxsbOZS7NX+pCoAGLue+cJCy2ht3Hl3jdxuHWMBxfuw7WNZr5J79AI7Pdmdf+7ZyS3QffR6i5qf1W+9o5cCt4KwpJOSJXXnhUP7eHx3ODLYsPceN/rKgV7quw+unxkJUo+PXDsnqL2Wi1YaW3GgezaxryhxpjyKlGent4xzOPt4AwsKXroJLzzlvgtYOilZZI2hJg5xRnq2aSdzF/J8AyfbQ9kuHb3LsJpTwQRv0p/7Ok2XfkvmQmjh7webBKSAREirkPiaDWb4DU4v9eYnvc5fjeMzYlOPZ/NfwMKc8152WesuRgU9ScHvVzTYxN+CzVWJ71OvcMxbMziLzKC6HhTE2xLgpx6ne9rIwYAeoovz+JSxxID3dgWZsXSllbr8Cf9GyTootqpmoO7QpaasUO0n8DpDL8K1J2xKLUbd9H4JQJsXFCjN56p1mbNESsNiJaqoTc9IvyUQwFocTvECpY6dbI8mA3TkhtD0qE7/oSGHmuHgXCy2JbhaDlr6sBnYEQWWITUueRx+XyvQcm88lFdJBGLRG+isrl9Iu
 vpyM/8Gvo/P2E=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id oo9-20020a05620a530900b007859ed62a9fsm900195qkn.40.2024.02.07.19.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:35 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:34 -0500
Message-ID: <b063486921215de8cfa228780c66dbfc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 3/25] ima: Align ima_inode_setxattr() definition with  LSM infrastructure
References: <20240115181809.885385-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-4-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change ima_inode_setxattr() definition, so that it can be registered as
> implementation of the inode_setxattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/ima.h                   | 11 +++++++----
>  security/integrity/ima/ima_appraise.c |  5 +++--
>  security/security.c                   |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

