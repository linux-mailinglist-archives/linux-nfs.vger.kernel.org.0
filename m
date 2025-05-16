Return-Path: <linux-nfs+bounces-11768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C56AB9B6B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 13:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D5C16B1E4
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC93223DE9;
	Fri, 16 May 2025 11:47:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CE22F743;
	Fri, 16 May 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396032; cv=none; b=e0R+4H6ihCAj35WEID/0OnuZ/6peVyDIpRVvQH+WkP5jbRdNbmQPx0MhIKO+BPhurOfpiTuLuxPYH9ewcQBkpchisqt361zGtEtivebzQN5iLNrFV2uWihw4hPVUQUZ4Xs473CchWK+ix3uL+7FVlgbe4jwpE7Wy5JIWEeAqYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396032; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXEnxneAbYJE/hvr7ppKKl8wv6NAfej72/uo0VDGTFYKN62WQgAKetOOGPu4iMwa3t9R4R03RgOFzyk+acSviFjhjnfINf8HluQe08ePb6mnpGJUK+8rRcz61MTbC3B9ZD0fYXVS805NVosOyOErfCV8+55Y5IIv2aOuwvxFzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a363ccac20so151415f8f.2;
        Fri, 16 May 2025 04:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747396029; x=1748000829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NGLevsawGK5nOmLG0Dykx0mikjPd13NufAwyuJ6ADlCP8U8c8LKrTl4SHAczswHbBH
         8yhVzeiJ4MDROouSq9h8aRLVW44wBszJhQ3Dwx3aACrPyxjO5CUxsqGMtJysUg65yYy6
         uk4DOh/t3j0W4hi3jjO/os6Z2QOdMTIa6qc0W9GfFFFyBFrPF3NxiYw0wxBK86yE5XtS
         3SIA/G2M8kw6mnvF1nbqMSIZrwmSmOCoTTdFkhlA1zuXZs3NfyVBAOdCnJVGF7+WYvfF
         BvJhIquD64+LkyUHwDdY1RWkS2MnYmYNwJvcfRR+eYs4ni4+2prvaX6q6QU1aECHUCgT
         R+mw==
X-Forwarded-Encrypted: i=1; AJvYcCUckLbynKUFC2vda/p4fGVcsyd3Bk7LRJMJIIsNtbmda0kvSpEhfDHThT+jPdfCBq5h2qO8e/PcjA==@vger.kernel.org, AJvYcCWCZGLOGIBmw4Fp1UDQ9V3W5GIJ50hbzWeriji71qARBCPjuWkiOYDbtVDKpXzcMIfIKwEdsEQmWFlk@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoi33H4Glw7hqjGRM+Uyu+Cf0GW4ikDav9eoF8W3P0ySW6Vpq
	9brpBUYl/uS0S/fEAXBbFKZaRVxiE5YnLSIJQRzvc74mgl91CNDIyK6N
X-Gm-Gg: ASbGncupXfWHgvGXsJwXhXxmxCadR2B6nhivz9b7pq6/iY/GQscGUzDt9MAm49CeguR
	aDWcOn3U/lmEdY/OKtbBiCrXMAehTn2wpEO005qG4rU4JXfQhtg137rFgPksobSa3Bn7LcgVMGd
	Mp66rMcRCsBbCAmjtJLVPa6pAWe+4uq7UHK2exaZMtRrhq8Mh1zYm9/IHMcylIUTA0TOQWrSm9p
	0lSf2ASfOBUxJ7bWL9GrigDogw5I0Oc/5H2qIDPqzpcsG+mybyD/MsB2gtW+96hmUWVRG752BZd
	nb8/fyDOJX+PyWC4Ww43BmgAq1cDEvpCX7eoZaWE/PL3LuqxeLpqmNugoUcSxqj8+QnO8bss4rc
	e+LZBrfhw
X-Google-Smtp-Source: AGHT+IFr5TUeVMMUuFzng/gsAi732GGdSNi4MQXvc/J9k97Q+tXi1RLh0SzgjIJRvHMOeNnVFUtbXA==
X-Received: by 2002:a5d:64e8:0:b0:3a0:8383:ef19 with SMTP id ffacd0b85a97d-3a35c84f442mr3728733f8f.51.1747396028939;
        Fri, 16 May 2025 04:47:08 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a79asm2563189f8f.25.2025.05.16.04.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 04:47:08 -0700 (PDT)
Message-ID: <2c83a75a-31af-42ba-8d18-973800f9026d@grimberg.me>
Date: Fri, 16 May 2025 14:47:07 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250515115107.33052-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

