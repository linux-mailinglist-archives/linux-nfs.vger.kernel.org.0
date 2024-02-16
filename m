Return-Path: <linux-nfs+bounces-1988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D95857560
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 05:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35BEB21578
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 04:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871411183;
	Fri, 16 Feb 2024 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBYbynhN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B06DF46
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708058620; cv=none; b=X373bWuSvpbA+wNg35kqxPK2oMwJpxjPrCsNMfyd6Poc7PMtWrrV3vR7j9LVUY0mp6d2QQwvSeS2DJY17zRcu76x5JZsvRX/DQjiHlh/LFTLbHPbMezEkWR2S3RpWLSYi+RyRAQqyUGorvxFyJBf6eZkSHmWZ5W0TKSE/N6qVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708058620; c=relaxed/simple;
	bh=waeuX8RtjIW86KprZNCOqRp/iiUFgtT5YVoezffu7hk=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=MtkhLd6iZ374okYUBp9zk0y2wRUJcqeST+3Ny03KU3pxpu34UCOpdilT6qEAqKS2dZT1zI6YFv5nvi/Lm1H+scPlpN+HAz48zL44r99jSg6258EwQo+XJfNfh2T6ibwsqQrXausz2N+QHGzu/+LjPWIVVM4o1vkhSX1yJZHKAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBYbynhN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f2a6fdeffso4893406d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 20:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708058617; x=1708663417; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hzH2XjdwcrudKK0By8Y9Nwkfc0y204g7SCh9Xtz36uI=;
        b=QBYbynhNm8tm4vtdLyIvMt4Z2Zw06EGImgeGy0UxZw8I8v3PH1UoZU15fXXsza7pr3
         0DiSaO4AgoLH864p9y6EK/IUAzWOkbDxO1zpB0L6ZlRLiTFvRe3/ZAGMR4NT3r2KSvUT
         DuUYIK3JZ6eYl3E6XGDdycU8Mvi8ClRnqREG/QRHmW/PtTw91XI3RmZPnajFuGUcTFlZ
         /Z9ogEJgRdSq8/YY1IA/W+QhWM890BLLr1IUSou+ADEvV+tq4Cc8fW600rXRkiRlhQv4
         uDXs6dgWvdheOELMLWtwzXTmzysYMq5aQT9or6Aq/Ap74n22SX8wBxDlI5DpsM8/4Faq
         b5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708058617; x=1708663417;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzH2XjdwcrudKK0By8Y9Nwkfc0y204g7SCh9Xtz36uI=;
        b=OkUJp12rHhoonOf9mrSUfBrmsz0ZgwqQfK2GHCFhPPJNsvyYoLcDWDpxt44dpQEfhx
         w7a4Y2m7rkEmgd2U3xoPsmXFE7YnZXPgZ6h+Hw+82QqKoHGThppDxixfisUexDJ7yquy
         d5TV9TwQmfwXi10g0POr9/AMz8VuJWVxVeOU6wFBRf8zaR7BzTOtCM1VvHMUr8uLvb9c
         9B9xuNdm1akQKwd9/cgnKCnMy5B6rVPbzQZMHhl2T0HpIhuO6XdT9aL96f2v6l0Zee27
         zYVVr9As7oXhhwpvh4xEQyiNPCa+9K24arqq2I7kneXs12Hm+KYFGFwRUFk7AYcP1yDe
         G74Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH/WBLPK7uhEMH4f6fznY9Qi2AFp3CA/2Knkx0lslSLz3AXgdNj4DpZYm/qqS/ovt/4+W3jds38yyrOnFKOXxBUK+cqxXyWw63
X-Gm-Message-State: AOJu0Yx6qgCPZMn2vKSfHhhBM2+L9ISUQ3jFgZJfEf/5hu/YNvd3nid+
	LHv4EbVkVGc3hV8JfkCQCr1B7DgZdm2IN/P2JQ/XXrV2yFvt6QSjIrLuXX3Xiw==
X-Google-Smtp-Source: AGHT+IH4Re2re96Bj4x8lZKg32bzmDSpm8k6SPGJJSdEF1RKaSe7UJnZBT4cDAJ/C8/g+lnnFGrBLg==
X-Received: by 2002:a05:6214:23ce:b0:68d:129e:f5c1 with SMTP id hr14-20020a05621423ce00b0068d129ef5c1mr4407697qvb.45.1708058617658;
        Thu, 15 Feb 2024 20:43:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id og8-20020a056214428800b0068c4b445991sm1367791qvb.67.2024.02.15.20.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:43:37 -0800 (PST)
Date: Thu, 15 Feb 2024 23:43:36 -0500
Message-ID: <2cdfefc8661d0a82c28250fc22a93a47@paul-moore.com>
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
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v10 0/25] security: Move IMA and EVM to the LSM
 infrastructure
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>

On Feb 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> IMA and EVM are not effectively LSMs, especially due to the fact that in
> the past they could not provide a security blob while there is another LSM
> active.
> 
> That changed in the recent years, the LSM stacking feature now makes it
> possible to stack together multiple LSMs, and allows them to provide a
> security blob for most kernel objects. While the LSM stacking feature has
> some limitations being worked out, it is already suitable to make IMA and
> EVM as LSMs.
> 
> The main purpose of this patch set is to remove IMA and EVM function calls,
> hardcoded in the LSM infrastructure and other places in the kernel, and to
> register them as LSM hook implementations, so that those functions are
> called by the LSM infrastructure like other regular LSMs.

As discussed earlier, I've just merged this into the lsm/dev tree; a big
thank you to Roberto for working on this and to all helped along the way
with reviews, testing, etc.  I've wanted to see IMA/EVM integrated as
proper LSMs for a while and I'm very happy to finally see it happening.

Mimi, Roberto, I'm going to hold off on merging anything into the lsm/dev
tree for a few days in case you decide you would prefer to take these
patches yourselves.  If I don't hear anything from the two of you, I'll
plan to send these to Linus during the next merge window.

--
paul-moore.com

