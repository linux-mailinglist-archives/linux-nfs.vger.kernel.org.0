Return-Path: <linux-nfs+bounces-1831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6C84D848
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 04:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9FC2836F9
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA01EB51;
	Thu,  8 Feb 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WKvJaqBQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0451D539
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362316; cv=none; b=qwECoUl0B77mU9fWChfS+6UGtnsCwarBKeGjDyGfuq2HZpHrHacnMD39tTdYRRVptmv6pE1bciB2W59SyL4fDG4n+c0V4Kn4AbILZ2sS609lI6RSCe+T6cGdpNwtqAGoWRpuCWO36G11SebWM/Dtt4NMztxBORxwaheKLoPPshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362316; c=relaxed/simple;
	bh=BrPfVu5oLZnua+KnnV2NiZuCnyuAO6VAjXx6aQnK2UA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=qgClQ/nxUZje+fOH0RsHVdr/OVhtJI0/yOAvSN2m47prXgpJtxXfHiukLYx9vgirxfp6ktRgo1EwFTS/QYwpUaHRtbwfJg99kltAddTu7EkpmaPLIuL/mnR0pDJfpxM9XLgEMYvYmP3oEaF1Nxatsa0C84Pm4lR9u3esSTd5zzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WKvJaqBQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68cc87d4aabso1317286d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 19:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362313; x=1707967113; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3vzjcGH1uL7Dmc9tdMqNKzuA3MJTgNjNbLGTmDXmOLE=;
        b=WKvJaqBQ/A/I5+fZEhU0hWwYdW9gPtxNYEioE2RjDo9h6XOi7Y45aegOj7PfpvmP7z
         wd6dSRiHhfJSAPB57HCXd3VBYzt6YeX939xXu1olg5aftCRYb1CNlnWPGI/ai1ylL3OT
         D4Jj772zyepGjfRlqVzwWFvLrBVBgBzc8pI+8uE7q/jUIZ5JBxf+R1rOO/cNIlkpZkIt
         Gh1Wg+kowEZxKStaY547tjscEyTP3cfEYc08woW0MHHWFMhU8egaaBWRgAz4kNeGi5FR
         pSN47pYMw0lFQ6uoECSoiGw0vVm3a8DfFi+0R7yqgtGqlq8iKk+qd7fBr65pDKwThdsE
         fJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362313; x=1707967113;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vzjcGH1uL7Dmc9tdMqNKzuA3MJTgNjNbLGTmDXmOLE=;
        b=SuJBQYaTiw2Bn8y8mEHFhP8/al0RxZxpWxnFfzm1bnvA5yOPUaQWKrq2SmFApWUfqw
         cmIG+G3Mq5nTdwH3px1mrUuPomNfKMBO3GTHRz3Y+wEA4rlC3P8z+9k6L3g16te4gu4q
         N8ecbysj9NI+KFb7M1fxhbf+YrNaupAR+aq+72Lt5NGXGu6e+q1bqA/rTcTZ9KjspnNr
         bt10CqzEU8cTNN+HhwLhO7737QzFpQGyyfRZ48gDSAT0eXlcfh6vDRAjNf6idTOyc+ce
         axBd6g8AhqxmBNCUkKORAb7QOoMaF1TMZBt9XIferzSm7uRce+et5kHsoS0O9T0gC8Q1
         cnWg==
X-Forwarded-Encrypted: i=1; AJvYcCXG27SlxZXi5sRZoSaYj3RI+Et+Us5YL2zb0ZFKCNDF0HP1FJ+rHWAmRrT1L/WRk2fCHpMu6Ux1uGrshJeo2YzMx4fHWjyTe+xB
X-Gm-Message-State: AOJu0YzHIuqjZmZ3/hqoUmL7afv9RNj6g3Tzm7RACKPm+0RAUKQSiPVr
	8rYRNdqUjkUlofN46d/RQ7uYboWjIQu1FkXGHOg5KeS5XAlz5pGoYaKGsiNNVA==
X-Google-Smtp-Source: AGHT+IGAK6/Q7VNUogAk8bpd3HNHeMFWN1QJTPltCD3uyCm2Iid+xioJVSp/YwEaoy0UzFYgesmhRw==
X-Received: by 2002:a05:6214:260f:b0:686:7256:c9f4 with SMTP id gu15-20020a056214260f00b006867256c9f4mr10854419qvb.9.1707362313325;
        Wed, 07 Feb 2024 19:18:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpz7JaTL7c7CgMN5p4OrEGqsElzDSWbNYDsISz3Fpm4v1miOSj7Lm4/EmO8h9dJu5lHji1rEACPhbwsDQO36QdjHIkLQcU5V+IDHNnXfU0bW21rIaX7u3oRkiv76JKb/0sgZL8qAir9hhZI6j90R+6vycUBRYD79brjSiRyX1EH0ul1j421INs4FbH7OoViB50pDbSPUJXqyth++rSgUq2oKYTQAQ0/FIv80IDgjVQDlnjSdoAgHC425V0mHc+d72PMvVOkh2NG+oKJLxTK71vpjCH6SRU7/C/nllgxVOT1BTSWNa48wmkSUn3c1ORjKRLaWPiBujcjsQ+kLmW97ZSmZmT8ddIqV0vcnMjNjmnyYW2OQPC0WULumamqM1t0j+kONc62Hg2BP9ITHaGdaY+hf0HgCgLNY6q6ouGah1GPiIplWGjguPgr/RjlhClwoLqHUzQpoBBHyitbof45+0uxFt3dLHly1xbrp8Oc1u+39JpGki1d6uhWP18AcAq3nHfnGnGiKKeRvZ2223kNL2N9cyNpZD0apGhTX87ByM6Rv8/yR0AfdhkeFgdPzoHaWNx5dT55CR4gW8WapITBfyudAdqxk3+45BjFff6LfgOPwFTd4cL1YBgQSA8AOeDU1/HTFeQuwP3HvnDzXGKU3Ln63mvIHOW1ln+bj9StHm7EYyOaJAX7n6+3EzF5uQLlC+rJafnOQ9eFq12csK8OaSh8J9KHDcHlG86zdUVZwpyaS5rIf5I9cqa3bfU6ZOpzxLuWR0tOJ2WPgGiDIIDCkPGRcPX0hQamnIDTQH6RhCFfeTTaGZBa0uThMf3FEASSosqNsFweD56VZLVT1N15GuvpgnzBEpRYXBtLVCSL6FaS0aQL8m+2iscjWE2EXaz+DOMQRWZBqPDW9ZJgxsOdlQGpl00+W0eKTNG273fyL4Ij9s44NYfUjw2BhLLYLSY857Cnn
 6Vp63LKHpb1S4=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ma8-20020a0562145b0800b00685422c9e35sm1178716qvb.84.2024.02.07.19.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:32 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:32 -0500
Message-ID: <b513285be179ebeecebcaded9019aa5a@paul-moore.com>
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
Subject: Re: [PATCH v9 1/25] ima: Align ima_inode_post_setattr() definition  with LSM infrastructure
References: <20240115181809.885385-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-2-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change ima_inode_post_setattr() definition, so that it can be registered as
> implementation of the inode_post_setattr hook (to be introduced).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/attr.c                             | 2 +-
>  include/linux/ima.h                   | 4 ++--
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

