Return-Path: <linux-nfs+bounces-11786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA954ABA935
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A68D4C0E4A
	for <lists+linux-nfs@lfdr.de>; Sat, 17 May 2025 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B791D61BC;
	Sat, 17 May 2025 09:45:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508961DEFD9;
	Sat, 17 May 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747475108; cv=none; b=ghQeM8dKSGuhujgLAmoc9P0wcSs29XvF7OuMI8SRFyHz6v6n4Oj/eDHDVTZaFqtgVul7dQfwIK4XJP6eG3x9k7YPY7aX+W77kzlhMZXylbTXNZANKuLpRAi54zo8Wfv+E0FheJVT+2d0glfPlI3paAZsf6uooZPt7AbixgRf7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747475108; c=relaxed/simple;
	bh=Wmr5ohTXPKdyo8kcG6Jmsfp9sjQdnBz8HB4WyVN+qxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPTgwhh376jLlUJF86QjG+wAPcJAPzp1WL9g5dQ52ocKkEFMPdOblD4b4y7uNgQz/9EIAIPSi7eOLv81697xv9d+78gIscqMvbc7NCKKFLBvOo1WfJn2oCGJsEd4FsM7e92zVwOQjTAEw+15jJirmvu6utjmW+jlsKONA5dcrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso27959685e9.0;
        Sat, 17 May 2025 02:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747475104; x=1748079904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59Ev6Sd7fd/e7l1k5vr2tNy3baDisKIlgFDy502JZ1c=;
        b=QTRKxRoVclENZ4q+SUcMBRn0JadZca0LcMxvUhE3xmeaojXtjE9Tr4cG2UlHl+I0Ir
         iONUpZNj0S0RJkyPNIRtNam/dds/MryamFpExR6T4JqqLHFjagxt5UbKJHKKKzVTU06K
         4LUB0mX7iGqDhVDk4VSrET71k+B/qQ+DYPO9TY5kYpcnP+Oscz8FNiOB9bOwuf5nBf5u
         32Q8nAx4GLB3gGmcKLHyZlv+rfDxxC4JFwrnETTFlSOCjt9ioe7gwX1dVYYldg9aCrpU
         HbUbY4Q2U1leSTr+nbWPw7uH9nPP2v34JJbaCOM3FN6t2Y4DsqQxG42xai6fVY+pWHcL
         EFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUKZkngTQXpKWMeIsQS/jHLs8hxTZRIe+2vsdffGx/1wyZtRqBejiEi8vOMXI7bmhUx4tf3vZ9pRQPy@vger.kernel.org, AJvYcCX1QCiQJfLCtu2yYF5oIUSxyRZiS4Kv6qiVn+SjWLwcwkMXd+pK0leCslVVKCJSH5+F5hjzrtrXpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtMHZF8ez8VvNqJk6GQBTxXm9P6x0dMTr3ul9+jb70jX7b4Gi
	jtFbrxetJc6EcC0MjQZO8AtEBSx5UaX78jpYsfwUqXhFk2JJJ18AY3Eq
X-Gm-Gg: ASbGncuCoouHZT8hwrnBL4rbQJZT/Gt2uvOadM6yPAlUGgkD6IxfSJs5KSbNBYYSV2y
	jZgNyKarr8GvrMdtwSPd6OPzaZE4Eb7kfKALdGIofGEfjVutTviWolusmQhGpbQwEuDj7e1DsDE
	hcSyGeZZCgrZ5MaPyXevNjazk1M/s2i+CqNsGNSbUZru2D7eLVSOxts5IUzJCkdZCpbw+UyZYNb
	l9fdjwwzTR1L1zFcQZNDktdWj293QDjK7xiVcBISqfmjYml3TtrFVHy6m4zX2dzvvBzh+OzKwY4
	9Yt1s4nOzSOQ5sz0PktxQErIyV7WaQJRJXbTW90U9ydeuSvCnJL7rGYk38CWsysZQVUftwxdTEu
	virfJVUA8
X-Google-Smtp-Source: AGHT+IEPe+vH7uFlOf+TSGvbTNcnl43YmfmsDp9u6x+rtqvyh9yZj9hPQWU9IyvvhHf3yqZKQNucBQ==
X-Received: by 2002:a05:600c:4ec6:b0:442:e147:bea6 with SMTP id 5b1f17b1804b1-442fd950bd4mr64220845e9.11.1747475104304;
        Sat, 17 May 2025 02:45:04 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cf66sm5565802f8f.87.2025.05.17.02.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 02:45:03 -0700 (PDT)
Message-ID: <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me>
Date: Sat, 17 May 2025 12:45:02 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-3-hch@lst.de>
 <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>
 <aCdv56ZcYEINRR0N@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aCdv56ZcYEINRR0N@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/05/2025 20:03, Jarkko Sakkinen wrote:
> On Fri, May 16, 2025 at 02:47:18PM +0300, Sagi Grimberg wrote:
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Based on?

Based on the same that nvme is doing. The only reason I see to have it
is to avoid having the user explicitly set perms on the key for tlshd to be
able to load it. nvme creates its own keyring that possessors can use, 
so makes
sense that nfs has this keyring as well.

