Return-Path: <linux-nfs+bounces-1835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2284D866
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 04:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D741F235E7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 03:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506EB28DBF;
	Thu,  8 Feb 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S84Rrlwr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA07224EF
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362322; cv=none; b=T4tBGYT1jhcu0cB+cVtZ8FeOV5nSBe07KbD0t/E8W8DBZlN00JYnZNapEt91SmY7mCO+jxuKIKpaFxtfyUUE0LXZ0ve1/QSdef9Lcwq84aYwjaoTeIfdsggfQ3v0IwD3pIizW/ZiqgVmsDGm33FxBbqejGDiQ8EwOEhkc6jkdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362322; c=relaxed/simple;
	bh=YzvPq98fcc53KPXN3o/EOZSLK+Tq38l7lseskpy4Be4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=eaTosLTQcR+WVp/jEJgoLg/TDUJNMVO54xnrKnFz9r1JNT9i6HoDs5dw3w0UVfTzDfZ3jSPQm8mj/HjgFbZb/Z6GmDR3pqQGCKxrmTU+lTUEaiMniBWqv9nfiKoh5D5l+hCkXkvV7+S+IO8RxaI7n03TSFjywJS8O7QzMIIrzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S84Rrlwr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a9f0f1d40so6301411cf.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362318; x=1707967118; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akq55Qa8ArVpFdym0liNQv3sXRyyD/vcw1QWZK89bEA=;
        b=S84RrlwrV+fIH3LACjE71r/jhGquzoF71sKc5NlngPDwaH5QmPbR0/CEeaSHtKeVzo
         Vo6ESeoYxPGUK5valfMurk/ol0KIO07lIlUaeObvzsvNYuM406LymhOCvSRSg9CnZPEL
         wvivhg0CHKPn6rICYFdLTRDm5wzWeIlY32CqrsSW5GRMYABuqcNMra1cyaABFXJbK8lo
         rkxFj4+vwVAR9HyiUYPBcJYqwIG923Aj6Q1vW2Zb5euGf8pugaEjov6GheUMVWmHldfV
         dwo95k3snMNobqyAVKlnI7IPtdQofD/Rxb8k9f3t4u7+83QMLjS2rp4TbVZ05QelWBAr
         ZXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362318; x=1707967118;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akq55Qa8ArVpFdym0liNQv3sXRyyD/vcw1QWZK89bEA=;
        b=tj4xq9rdEMInOwYNQoLDMbYELsMyCcUEveGRVr2u0pwhPFqMQOvtZOxlVgvyoBtRGN
         DKbLry3FR3hBR1ef8SuTTU94S7+h7JLcRnb2gtg4ZAsn/IJmH+XE0ErtW0DL4BmHMFrX
         T+jdWPoitHENVkzdE/mN5T1mIKiTdc6qQwIXcAOUPDazWmdq2A9tg8g/KDnsW89+mUf0
         2C765T4wW9ssCXsD/SMMM0o5Fhc/TttnG551gsqS5Fvqzck2wVODaArhv/upbA02YSPL
         4+bfIST4fqZ/Nd+1cs3rLsdSHMFO/tm6FW2v00zVwIsJpbdXosc05LbLA4Ha5bCv9WhS
         2cTg==
X-Forwarded-Encrypted: i=1; AJvYcCVbdn83qZI22wykG5twErHV8Y7Iq40Rl0DgJctTfr6mHPQZR5+o590nW7dk2/d8BiqtTOPxGgr+Zcv3DOLPWhQNrP4hiIJe97ro
X-Gm-Message-State: AOJu0Yxl8O7mjsOu9FFDeij5lhAKs8us8BCOhMLK4JCGvaCzWe0KKgNN
	0/TkPv1Z9umyNJHkHK/80nIlyrDVl/SpyUPQFYlb0uikYJ9FqUDftPUAYqnBoA==
X-Google-Smtp-Source: AGHT+IEcyq0GMBWXKVAYE9r+x2SOx0/uk+ns91BJCj2ArpBhVCymlH8RmtfxiAXBQZvVcY3rijO/QA==
X-Received: by 2002:a05:622a:1806:b0:42b:eee7:b33b with SMTP id t6-20020a05622a180600b0042beee7b33bmr9964311qtc.28.1707362317532;
        Wed, 07 Feb 2024 19:18:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSJf1UfUoVB+Q0MWO6Mxbq6AozXyARonbqfOmwIIr2TTxJqM3V/Vze3yCs5JcfuHykv6JkPpemjyywNo309jKw0TZsoiLD/beYhms5e9ORCbfehu7EdPYqGzVzr0N5xNRN1t9+T4VHRJMs0yRjp35/Fbuwj9+xZsAugF4tTCHH6IlmOT8DKWaZxE+7iJQmaiI6M4qhciyGHjPkCVIEURclyCz+aChtG3pdR5+GxYAa0vmvQ4HrXiVYVNimYCM9lmeaPUpHQyo7S2KhPUVQLLxCgzBAIlrnSbR1pO6qN4DQDEWxMmm26CJ3ArEV+UkdnzQfOmmBv3xSv81ReQ7fQXyyLst2wE4BvHhJRFGY2HXX5r2Wsn99NcLrwo87IBoQQztJVsy5Em4Y6zjzi6wfwNp9ZDo+5u7BJuxFYJ1+nvRjdpecB2tYFvkuqfLBrfhNyuHyiY8gVFWiWOH3q2ETkNt6CCk/fy+r8ixV4ZfbZ93X15BTkxh+1vheg1nIQfQwF8xCFVvasqtcoAWm1d57oF0yHWb0wCNvHe2wiJ9GC5+QOO4lplSpkcIdwfRuCi0uOr5fAfdLgPZqqHL8GeN9ud0Gh9+gCk+6TcZdgJgbibqCOULdvuCu3qHYPSevR7iUzx7+TPca8QLLaGJGx6FIfQUwJwsiVe/ob294/HiUZNASufA+n9YRGcboOuk2fXxcToshd5I15bH980Vya7bExPFrAU8IrM+/C/asOoR/iId6JQWcoaECutZSYMXsbaSPknAPuy8q4yqkOUU7rfbAO3sEb9crO6GPomVlg26HXhmVv66+4Xi0OZWnlcUsBu+6le1mmLloe5QLZX6nJMCpGWN5mljdTkstxxa7qIsXAH8uDrmJp2S4Aq5dAkR8c6K6QaiwBE0LUnR2c+81cAyAqLHYdnXXqzW3+PwQ9O+0n7IIZvIo9LNWOR12Cfxf0oZqsiaUak
 ZyY33lbQTNRcc=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g22-20020ac87d16000000b0042c45717dbesm669434qtb.53.2024.02.07.19.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:37 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:36 -0500
Message-ID: <9edf46c0c2060564bc4a52db6fbf54cc@paul-moore.com>
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
Subject: Re: [PATCH v9 5/25] ima: Align ima_post_read_file() definition with  LSM infrastructure
References: <20240115181809.885385-6-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-6-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change ima_post_read_file() definition, by making "void *buf" a
> "char *buf", so that it can be registered as implementation of the
> post_read_file hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/ima.h               | 4 ++--
>  security/integrity/ima/ima_main.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

