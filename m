Return-Path: <linux-nfs+bounces-1842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0084D89F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 04:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDB4B2382C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FD36AE5;
	Thu,  8 Feb 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dJSBc1HI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965428691
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362330; cv=none; b=nm0ea4T79KEuo1dzhdxgd5Jbfj+R1CXfjv7aSKeOFXaNgLXqUBC4sDuzxqzKm+avJbIww+ePRw10TseIPHFiTLBJXZQJoKXfOLU8UpBeqLllJ6a/KW6uIN4L3C6Si9iboKbvCyutBeQWoS4par6Aly0q/Gg/BMVkjIquwlleP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362330; c=relaxed/simple;
	bh=MJmgTQ/Z+N83kdaNSKZw8l5C67PPLjsvryWXsYHw4W4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=IqWVmfcrRyMYtEjUBQzxma6pSTrJbeSofK0ZbPQ2TDZD5TG/FByJiyG20do5o9yPnTMhxios3slQ+Zyz6hDjfUn2lOJWvvhZP8CuJrt0VF9PpxYzPw1wLhppF76WjfBRRQ5qb3VvZC8cDmEv1MOxCWWXjX1B2fItfVXGBRj47LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dJSBc1HI; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c0232861afso493212e0c.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 19:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362325; x=1707967125; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rHdU2RZz6m9RtlvtgEcA8+RigKqt3SBGaLQIaKub/WU=;
        b=dJSBc1HIFA2rm/oSzAExowCXLr5sPUCJzOuHjlgJSmMWQ6G/AMp+CgaXRN0j25Yb5X
         DoAHirarYpnmzssFa6d0rWqoC7H9ZGnZSaglq3eH0sXu4oNZGgR89EjxB0AUM64a9mbe
         yaJi//tJI3YmQGFG9JFjGG1MdM+vMq8atrSJB9OAPw0t6BslKSZjKHBkO4D0fVdNaq99
         22veuVxM6m4eK6YlBeLUzXcZ5QkU6bFzHey1Gt5ZmSMY76GXYcDtnHToocWGDSgPYXHr
         +Fva2xyc1eOK/Ks9CvWmZE93Pb2dSP8inCOxtLg2y0IzdPkTxNgz9SPSv8IzsDeNxiBK
         Ffvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362325; x=1707967125;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHdU2RZz6m9RtlvtgEcA8+RigKqt3SBGaLQIaKub/WU=;
        b=eGHVaigffPsvq8PI68sb2woMAmjrb/gTYPcfHzvmmssOkTee1xYkdNyTPcbP9zFTl+
         Ax3KqIOGE1MTNKtrrprxAWFnD8sWyOpzEtwkdrBnUWlLRD/2jhqHnKd6Qe9aF448Fx03
         pr/INHcDdMzHTv29X/6GliMaddFI43X6qP/+AYiJtsxPZOP6a0NKnhM5rtxfFMjH02Ha
         hB8nIGxExv9spgqDRKye2JRTkF2PYFsm0u/fCAoNHmtzPLcnr2Dso8pwJOJVzeageikI
         /bGH+CU/tKPc3d0Y4bom0dEt1Ub9wXA7Oq7/W5MOlCvIKjccoEStzCZ0CtgfcOSOFngT
         ZEag==
X-Gm-Message-State: AOJu0YxsMBywaHEJuPmhpcLVspQY1GzNFm2t0AMqxTshkSvYL9i0ycvE
	+P/kNasqFTVzykG6QeioPAjFF+qZgITUPfqIkLmLvnxfMirlq+upEPRH6DVhLQ==
X-Google-Smtp-Source: AGHT+IHvLQXcq02jdtXjiYB+EWO8RyH6kJBsuW0V4+EMflYCtSk02qVo7oOf/26kTUWhTj/jicMJag==
X-Received: by 2002:a67:e348:0:b0:46d:20a1:e884 with SMTP id s8-20020a67e348000000b0046d20a1e884mr5620089vsm.19.1707362325290;
        Wed, 07 Feb 2024 19:18:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVF6nCVblYoyOFaQAXpPZtiMxlfIdAAnQaKHDAzvZsXMoIL9XGJ6mdlcyCxY8xHen+T7dhpf/k1PPwwCez2gmAS4UDsGdlcjx9SCzFdq3GuQxuAqrkuuwDrdGyrNVph28wbPuri/mH7r3mq7qxFoUV+65uvvR6gneV2kKvM324oHB+71gWoKRNNmE30IuzujhOf7GVrMKhmkJw7nLuwbXvQWs4fohpVlbbybADTwp6M1oWJ12iYXqLoXeyu9iUzocLZMzDuhUl42ekGP+RqvtaAYaJtwhvc/ryCNtk3DEDfof4aLrW7L0M9sdvd2IZQqiF/Nz6v9Ju4JZhCBMNOQUbtDK1V+YPZgtPd8ShImplEIbda2sGXxzmCQ489BptIpyAobl1phcETLwGVvPCZyJjYqIoWjW+ua37fLPP/iYJiQTvWfI5cKsMim8SSurVI15GlxH4ZcszJ/+Tbb7R2bouVwy4yJy8EA9IazHiEZfykUTqdAUVhh6jwunsQF12iV5r/2XxmuwDUy01AJMFVQ4gzjLQaZ2VggI7vnu7BI2ZBgDPyEiaddJ3VMD2dwJhCGs1/h0vx/lO7lttcnRvTT1ssfF7WqiDJBisTxb2Fx6q/wRHjtasUJ7XqyD5iNDZYWeSkxYsVAaZS1KyM8O3YVvNxIPoy72pLpUSccMJxyWOLarp9rc2NkeSsJwpukzr7ZU+gVAjmY8XKTruRDLuoYDSOAGH3BSlDXURd1bfhr8PbyvXr8OoHXvnPuwaC4290ZCNn60CE+jL1/PXnnBOwmL047tBJ8q517f3W+YRJOnHg+zkQQBh7nn49Nb2LfhzL8KcBp2zFOgPgMbXp2nGKFJaZb2bcAC6nfeqMe8VGCtYBv31LIDnIIzt/JAPZMHDNvLP3iOqhI3FQSS6w59WZxKw5laYqxvSixuirWTLq4pVZPorrqtB
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w4-20020a0cf704000000b0068c89047955sm1189707qvn.112.2024.02.07.19.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:44 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:44 -0500
Message-ID: <77e42fa37a24378fbb4f19ee9a4d2e74@paul-moore.com>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
References: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_release hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> An LSM could implement an exclusive access scheme for files, only allowing
> access to files that have no references.

Let's drop the above sentence as it is is a little vague and is causing
some concern with the VFS folks.  While I want to see the hooks explained
and documented in the code, I've never been a big fan of speculating
about potential future uses of the hook, that's dangerous IMO.

Otherwise this looks good.

Acked-by: Paul Moore <paul@paul-moore.com>

> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)

--
paul-moore.com

