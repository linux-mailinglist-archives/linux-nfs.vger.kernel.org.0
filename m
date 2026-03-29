Return-Path: <linux-nfs+bounces-20512-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCNcGiKRyWmUzQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20512-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 22:52:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E335416B
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43BD7301FD65
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD63876A9;
	Sun, 29 Mar 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isAgSAgZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbk0llG7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C24379ED6
	for <linux-nfs@vger.kernel.org>; Sun, 29 Mar 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817545; cv=none; b=rjQO2SAeOzQuiIQj1v9G5sV5ktky2H1VNOqBNnu29vxzxXp6eJnh91lRo2FwFaB2PVPX5CgZdukcg9F26j1Qvtil6UO54nAuQOkLrKpa31wD5S7ECd050b5SyiRRIvxAviUyOBNC8qi5V/7zbIvxqvGs0+8JIBMKprAf8SHkdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817545; c=relaxed/simple;
	bh=7tjXHRH/KuWJgo+NqdsvzW0xA9jVYkndfHHjEV+4ezE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHOqv+h3fNdZsOTciw+9sjrA7LKL1sbTS0iezIWWHkXCTP5tspPB1/j9kHZolq4oBgvPnEW2uMJ+7dwcxAQdS5hXCDj4OZEgKpyUEMyBm4TKKVOorw5gfi8IzR6gsNTuE1wxNYUvDlVX95Cm0Oz4nKgUpam91rcwtjTHECMnlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isAgSAgZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hbk0llG7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774817542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkxx8Ili6u56WY1Dpu47+7Fxo2wOOHde/Ul9c9mLo0k=;
	b=isAgSAgZJoO9uPOazRgvohmT2dvnZ/RBt8BcjetPlc8PtRY75u0pr6rZlZKM7wWjWuuGWG
	3krPu0vnJ1KCXv1pv5AUehCHXNQKXnwINeBdaO342Dq4ONkWyCdky7gZuZb2EFtn1vwJPC
	G/gP6KuiXsbSsTlMycpHh6TqCTMqpBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-MdsWR3vcMu68COuhgXY_Eg-1; Sun, 29 Mar 2026 16:52:21 -0400
X-MC-Unique: MdsWR3vcMu68COuhgXY_Eg-1
X-Mimecast-MFC-AGG-ID: MdsWR3vcMu68COuhgXY_Eg_1774817540
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89ce5eec0f0so32240556d6.3
        for <linux-nfs@vger.kernel.org>; Sun, 29 Mar 2026 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774817540; x=1775422340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkxx8Ili6u56WY1Dpu47+7Fxo2wOOHde/Ul9c9mLo0k=;
        b=Hbk0llG7jqnLZrQuQaxqCpaEsnx6mpqS5sREjpTe5eJxL9zVCtvneQWYhAcWrYhyIu
         uestCQepS7aribSeHNm/8pOyfB60I+PxwVraD1gstqQbNbZVAo1rvhBUrW739KTgG9mX
         ++QtmEuDk/WE+d8TpxZHpmJ5xJ2JCw3rrOME+2dlgZOxffd9qW6ogJ9URDT1+iHsk2KU
         tElu8+sG4thQ6rZQChbbLvon1bfqZuSW5bqKD0jYBpox8HfHCS6beD+k5nYA9Vkd9qSc
         qOSJHgy2mnxxqLOD4ku0vy4+RuhOqvp/+vbSNj6cENU9QYDkX1Zqszu4z0jP+M6DVWh1
         ypfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817540; x=1775422340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkxx8Ili6u56WY1Dpu47+7Fxo2wOOHde/Ul9c9mLo0k=;
        b=Zf46PaO+B6JPq3pTSSCscIPkq8Zd4tBJPUD+K6OLPguI7UKdcxQmyAgXpG6EDTuavL
         2jhEyDqugRqj3rXcgrgt1u8bkCDKROfgVRIEw/vCmoa7A72TiGPr6X1W1+U5kr0pftWy
         /dBkk0ROomksklnGfBkaeK15jBXsNUU9XwuuNP1EPrU6EjPtfUJE3ErAflg5OKgpYc9h
         7nKTzePintWQkdbePG4IBVs2/17jD+GmjwVBLicLtRovDcQzIb3m6SqbQU3ly6g45sGK
         mP8EG7u3uFMGJY0HwYuCoVZILT+57LiAI3lYm42zi+Q1qjlgm0oUIhXUdIpuOdtXiKsp
         8t/A==
X-Gm-Message-State: AOJu0YxJ9xBtbkcZnOn8QDXbsziOFtfY1JfpzrxvybbvMQu6cNBk7JVp
	XdzPJA+/lM9lz1DuckHCzfi54fEAd5RIWMrMLiV488RzqWxGauKgvmYOlh94o6oSQQuYp7ovVHZ
	fKpqoqeFPX8c7BXu61fdgLbSaBOEHe+n+PFqjIeuFoUgo8HSagw2zjFE2WAkSxQ==
X-Gm-Gg: ATEYQzzxghfbSnVw+Ndoo24FEfmikYK50uNf7ZLg/7o6eATC/KgNqh3yIVQ1x4FlgyP
	xCmQbYc8kAok1kjDX3Mboe2AQFtS4nV7A9OrmOx5TDQ1L9WHmQ4KLn75wknxmWDa68GS56Xtk9Y
	00yrOU/w/v7XqAGfOyfOmN+NVc5raHWsqGrFDBCL15fa4q9cZAgY134dkVH8yiqkT8thwj1ge/t
	R8XjM/sv+0o86hhfJsKib9nPYJL7zE8SCduO9VA3F5fdc4q1jTv3EgLJtwx9pJMjw3e3lNGEzwN
	3UjppEVEtQkCrmXMmEirrxaJHFUkizA5LXtMqc5UuQD9a9wYw1zAyC78uOTTxKCrFPmMJOcKd6j
	FwLLe8UWWKVozmI3Eog1H
X-Received: by 2002:a05:6214:d81:b0:89a:e77:1f7f with SMTP id 6a1803df08f44-89ce8f0721emr142932536d6.46.1774817540541;
        Sun, 29 Mar 2026 13:52:20 -0700 (PDT)
X-Received: by 2002:a05:6214:d81:b0:89a:e77:1f7f with SMTP id 6a1803df08f44-89ce8f0721emr142932376d6.46.1774817540066;
        Sun, 29 Mar 2026 13:52:20 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.240.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecb5cb530sm48498986d6.7.2026.03.29.13.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 13:52:19 -0700 (PDT)
Message-ID: <3d888a3d-fa6e-41c0-9b28-6dbb878a0a77@redhat.com>
Date: Sun, 29 Mar 2026 16:52:18 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] nfs-utils: signed filehandle support
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
References: <cover.1772638460.git.bcodding@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <cover.1772638460.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20512-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C04E335416B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/4/26 10:40 AM, Benjamin Coddington wrote:
> Here are two patches allowing userspace to set a secret key for kNFSD to
> sign filehandles, and also set the option to sign filehandles for an
> export.
> 
> The secret key passed to the server is the first 128 bits of a sha1 hash of
> the contents of a file configured via the nfs.conf server section
> "fh_key_file".  Exports that have the option "sign_fh" set will cause the
> server to use this key to append an 8-byte siphash of the filehandle onto
> each filehandle.
> 
> This version of the userspace patches correspond with the v7 of the kernel
> changes which have been posted here:
> https://lore.kernel.org/linux-nfs/cover.1772022373.git.bcodding@hammerspace.com
> and are currently queued up for potentical inclusion to linux kernel v7.1.
> 
> Changes on v5:
> 	- add -k,--fh-key_file= argument to "nfsdctl threads" command (Jeff Layton)
> 	- fail if "nfsdctl threads -k" unsuported by kernel (Jeff Layton)
> 
> Changes on v6:
> 	- fix a premature exit from fh-key-file hashing routine
> 
> Changes on v7:
> 	- fix another corner-case for hasing fh-key-file, simplify.
> 
> Benjamin Coddington (2):
>    exportfs: Add support for export option sign_fh
>    nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key
> 
>   nfs.conf                     |  1 +
>   support/include/nfs/export.h |  2 +-
>   support/include/nfslib.h     |  2 ++
>   support/nfs/Makefile.am      |  4 +--
>   support/nfs/exports.c        |  4 +++
>   support/nfs/fh_key_file.c    | 63 ++++++++++++++++++++++++++++++++++++
>   systemd/nfs.conf.man         |  1 +
>   utils/exportfs/exportfs.c    |  2 ++
>   utils/exportfs/exports.man   |  9 ++++++
>   utils/nfsd/nfssvc.h          |  1 +
>   utils/nfsdctl/nfsd_netlink.h |  1 +
>   utils/nfsdctl/nfsdctl.8      |  8 ++++-
>   utils/nfsdctl/nfsdctl.c      | 57 ++++++++++++++++++++++++++++----
>   13 files changed, 145 insertions(+), 10 deletions(-)
>   create mode 100644 support/nfs/fh_key_file.c
> 
> 
> base-commit: 4706bac0345f67c50b73fd8da1c2629ed15ff79d
Committed... (tag: nfs-utils-2-9-1-rc2)

steved.


