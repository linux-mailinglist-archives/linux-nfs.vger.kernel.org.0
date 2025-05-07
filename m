Return-Path: <linux-nfs+bounces-11576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5080AAE2C0
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1655B540D0A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4595221262;
	Wed,  7 May 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiQFdf6X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404F28A720
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627266; cv=none; b=k4WdFQzYJoC+gyEGOTjAffVPq4Bd1rlfEINJ/+/sZ2c5mUuoF+10gmOYEQZbtPrGWl/0kQ9ylf+GXJ2FrXeJj1bipItKuRjKUSXhuRhk21D3dcARbszHnUYldz/cUm1Yx5w5flqPcg8+O7UsYZ29sAgGrToys9DNLpAwOAdHk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627266; c=relaxed/simple;
	bh=2Ks9Vw1T5TzAwM/ox7LNsnEISSDm+0ixnJfzhOB/WSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYQM+2JFCK/wWiEZMJCgO5JZ1oYmsnpmwU+matGhBL3i9luenoP2Om2nOas8KTF8DDuixfXBzX0ksBZgKiO0/mS/2kdTH5K+Hmck1n/SsF/VX9PZykVIYjXJnzInT57srDFDfxmBk+pocHQg67q8owTXn/aFdH7B/Vxgv1QLwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiQFdf6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746627263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6Yr/pEE5FBcxY6C1aKgrc4+fPRys1v2ap5g9FWKRYI=;
	b=GiQFdf6X7s24IFhTxshGMlJYijuTuxfx/xVL3jsP8GLMviHmZIiP/840jby3eHEBsgBktb
	GVFwiWzWL+mroxaa+GsR5L/g2HPeJn6lz+UTjrygmlQvdLtcLQRfqwP8WRgTylJr8EW8od
	1tqW9CJ977PiU+ZshIv7mLN9LxQRBSI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-fqw7Au6yPvaZ1lDKuDrO_A-1; Wed, 07 May 2025 10:14:22 -0400
X-MC-Unique: fqw7Au6yPvaZ1lDKuDrO_A-1
X-Mimecast-MFC-AGG-ID: fqw7Au6yPvaZ1lDKuDrO_A_1746627262
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5f876bfe0so1168009085a.3
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 07:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627260; x=1747232060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Yr/pEE5FBcxY6C1aKgrc4+fPRys1v2ap5g9FWKRYI=;
        b=lq0NAlHjWr+5FyMWHUKHjAyG96OIJS+zNBDyHrcvWnJm4RqO8RpyagMOV/+UTNv90G
         RP7ejm1mQtncpcmgdshLdxd2TxvuYfShBlZtgNQrgCrPt4C3+AqT/ljfLHRA1kAstRo4
         XfAaxJTqZeTW4Prk4bc9moTJjU9wr2ldRSKquvkJwM/7Ijj76Y/OieexCv9hJqJ5PT6r
         iEGQiDxAxtfP2s9Xx0zPXL7EWMo+d3zG3AeOxGUJU6I4MB/vzwpSlE4q1g8Mw3wYC5Sw
         +8clw77ifucUuDvn6JcwEjxKSjq8DlkFrnEP4MjLopnSt/F0vnuPoP9hzQ/nCjHLCSMq
         nusg==
X-Forwarded-Encrypted: i=1; AJvYcCXBUZMv7xBJJuONu1DZZqYSGrKMq6DJEO7xMUMgFJSbkomfp2SLvPkE8DSqDlUFWglC/02CseTJMHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9kUDe8NbJEESKTdbcqTtS6Muk5BLo1lEzueBtJSk3Kbng642
	RhVAPkF+87SJidsh1sVhDij4W8lfG4ApKPfPpn1VHKTs88MPg961kWvWL1dFrWOhTXF5OWT0poy
	Q66E9hMV7zSRNmPBR7PwDxc1L19dJ1LO+pfZQfl3fvo5n4cCmG1q7KgtSGangHRt8aQ==
X-Gm-Gg: ASbGnctBBH6B1Qfa1tazP54J6Bxq33wLBmxB4Op+Jpk3WYVcWxV24TvueK4xpBOmupV
	lR5wpzgqaIcvRUr3lPgGt43IHJr3/c3bijDHSCVmShThUJBIt/EWgA839ac6HnExVqUIs2Eo6dV
	Ir92/TB0UbR6cMi87LCa6CK4jLf+ip0XxO7qysIVaosByAdOhfCaYVPI5G7VbmYho6h8mC+DmoD
	b12Et+2ZRwElez4ZaHE6U5pVQMV+jUzjQ4Zo+H0FHnQo1LKBZnacmTaC6JcjYcnhyrHvrEchwwE
	wR2xVx/B8g==
X-Received: by 2002:a05:620a:4106:b0:7c5:5edb:f4d5 with SMTP id af79cd13be357-7caf736ff5dmr398811085a.2.1746627260757;
        Wed, 07 May 2025 07:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+wxBV6mkZ+1wV0D/aLFLFZ0qiBp6Idh5DpcSipqxOsnsFSgUzfIdfOYYG5yXqm+uQ3TAxGA==
X-Received: by 2002:a05:620a:4106:b0:7c5:5edb:f4d5 with SMTP id af79cd13be357-7caf736ff5dmr398808785a.2.1746627260409;
        Wed, 07 May 2025 07:14:20 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.247.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf751a374sm158173585a.5.2025.05.07.07.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:14:19 -0700 (PDT)
Message-ID: <a5abb4c4-e9a3-42db-9aa0-1f442496d65a@redhat.com>
Date: Wed, 7 May 2025 10:14:19 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdcld:Fix a memory leak
To: 597607025@qq.com, linux-nfs@vger.kernel.org
Cc: zhangyaqi@kylinos.cn
References: <tencent_44C49EC60F8F9D7E3647861067115D0DEA05@qq.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <tencent_44C49EC60F8F9D7E3647861067115D0DEA05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/3/25 1:33 AM, 597607025@qq.com wrote:
> From: zhangyaqi <zhangyaqi@kylinos.cn>
> 
> Signed-off-by: zhangyaqi <zhangyaqi@kylinos.cn>
Committed... (tag: nfs-utils-2-8-4-rc1)

steved.

> ---
>   utils/nfsdcld/nfsdcld.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> index f7737d92..8551dc97 100644
> --- a/utils/nfsdcld/nfsdcld.c
> +++ b/utils/nfsdcld/nfsdcld.c
> @@ -822,6 +822,7 @@ main(int argc, char **argv)
>   	evbase = event_base_new();
>   	if (evbase == NULL) {
>   		fprintf(stderr, "%s: unable to allocate event base.\n", argv[0]);
> +		free(progname);
>   		return 1;
>   	}
>   	xlog_syslog(0);


