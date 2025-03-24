Return-Path: <linux-nfs+bounces-10782-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F2BA6E46B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0894217035B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0D1D5159;
	Mon, 24 Mar 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d43+xMfO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFE1E8326
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848197; cv=none; b=kVwewP34Sja/YlVHCBXeBNGpHl1K5N5Vd3ZoeVJjvEBq4pVFyd7w7mdpYFJ2/Hx3bkAI406babHsb7XQPks21cZC4HtClIi7eSu1l9RHyjdy/GGV5599wtWvPzk8JzseNeul+AICqrxPY1avMfPjoXh2bTnEwfzPliwGfMdteq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848197; c=relaxed/simple;
	bh=FrqpZlDcVbHqLnA2SROmUMkLStFlAf0y2uGzRHY4E9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qwQT3Fmka4WkhdPem6XVo9SuMzQEM3UhqhmLv7/ibGFhSwmB6LUyIGSSxA/ByXkg3Bw4/TXey+RqR0rW3NF0JojHAZnyqp2UAqXmkZep5LhBx7t9W6QrNYvzEfMJQG6VZR1wg8aR+DwIyiQ+b7OsLoITNDlix6Qc73byFnwreVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d43+xMfO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742848194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxdEZ3+S3yXb33nBpvb94g6lgCZsROpKiGm8VQuRPxs=;
	b=d43+xMfOcpZRLYshuwYnwajTgfKLHXrBN8YNmGPeb4GISTw2oDwqg8IsZSvQ04EpCTUis5
	0cFp+0jr5zH0z0aT5M2K+Q5yMJs83T0aTKMKHzXJ9aPWiTwx7tZBkwmqPpQkGcNheg67Cz
	xySVVLShEtSUoi4oaoziOX6E+095Fls=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-YXEfXii-M6-yaWjJi93Abg-1; Mon, 24 Mar 2025 16:29:53 -0400
X-MC-Unique: YXEfXii-M6-yaWjJi93Abg-1
X-Mimecast-MFC-AGG-ID: YXEfXii-M6-yaWjJi93Abg_1742848193
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ece036a581so61640196d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848192; x=1743452992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxdEZ3+S3yXb33nBpvb94g6lgCZsROpKiGm8VQuRPxs=;
        b=heYXq+w/vfWWpcCHif/hvRd3pl4ydt6TqAqOBJuJ20oBke71WrkfZ561/bcHnezJcb
         jPlq84Fd1+j7hdSG5RelgLYGYEJ1Ls85Cqn4m3V1K0M6xzitBisSY1Ac/RioE7BoM2VP
         rIWOFPOYO1hTYYcH57q7Zsj20bIJaliaYNx4hXzDhh9Iwt35fS+wYpqKC+m2zIY3KBk+
         9BQINNCHl1mzVidt0dVdm3LgnoITiNX6qJfgYs3aR4LqanKV/Ns5rQk9L+PO4psF6MwK
         j7jewJZOjbG5IW1e/j2Y6xyYsLnncXIckaW+vhZdIMBnk4LaaRVRtixnwt5JWdlSAr1f
         p7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW3FfRrCDWcGjRvOcKCGlEbNM5a7XI0jSfC315WE6tGZyXANBcqrAy0TlvmM/wUAoKy/Z+W8WbiMjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmMvkhzbp9gEYjuz9AR5eQfjyPpc2trahKNdv0GqRqkpjv6LoT
	z3n+1HuJ/XI3cb9cGVCYlbIKb5WbtziouI1pOYjN8F5udlu2ouyb3QbTru8tqCg05sI6YQFbvd/
	c6FFKR5GKrt7Io8SsTIZpLjGq9w2mMw2P9hlgUQAg3JkvBiom/it9uYudCwzQ8MS2xZOI
X-Gm-Gg: ASbGncsjgf7bR5OtWcqJW/tJOfZrAA8vrks/AG+MSU10epI5dcx9ODvx1+7GK7+M5og
	c9GfajptU+ohHPrxAcSCkZZoTVIS6s/0a/lvM9LC799q6TotuEo0csLZ0r7G4GuLa9knSm+uNB8
	GP1YtKVGPAPgIS7u+7gGYbHong8rrwqNrUE5tG6bjR0q3wu5EtzaTHg8cfGEghJgbIdZ4yWTAWE
	ozKcMwFX7dI/XEkHd8RnqVBuSaBByZ42mVmtcnvnVVa/aVqm2tSQpdTkJ6C5b7cST0OhWFR2KgE
	1ftllKtUN/aRrtU=
X-Received: by 2002:a05:6214:d44:b0:6d4:1425:6d2d with SMTP id 6a1803df08f44-6eb3f3b6e48mr164217116d6.43.1742848192152;
        Mon, 24 Mar 2025 13:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZzIisBoFCsVVMBZjSqqKm9VGrvVX4TbAbCvQbVqh7qUVbknMXGTxLbzJcAI655RjvDs+dqg==
X-Received: by 2002:a05:6214:d44:b0:6d4:1425:6d2d with SMTP id 6a1803df08f44-6eb3f3b6e48mr164216886d6.43.1742848191681;
        Mon, 24 Mar 2025 13:29:51 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0f21fsm48625026d6.24.2025.03.24.13.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:29:51 -0700 (PDT)
Message-ID: <a5d324eb-5023-407c-b5ff-5b7bd347eb12@redhat.com>
Date: Mon, 24 Mar 2025 16:29:50 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils][PATCH] support/nfs/xcommon.c: fix a formatting error
 with clang
To: Alexander Kanavin <alex@linutronix.de>, linux-nfs@vger.kernel.org
References: <20250321113147.3477702-1-alex@linutronix.de>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250321113147.3477702-1-alex@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/21/25 7:31 AM, Alexander Kanavin wrote:
> Specifically, this happens:
> 
> | xcommon.c:101:24: error: format string is not a string literal [-Werror,-Wformat-nonliteral]
> |   101 |      vfprintf (stderr, fmt2, args);
> |       |                        ^~~~
> 
> A similar approach (print \n seprately) is already used elsewhere in
> the same file.
> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved.
> ---
>   support/nfs/xcommon.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/support/nfs/xcommon.c b/support/nfs/xcommon.c
> index 3989f0bc..1d04dd11 100644
> --- a/support/nfs/xcommon.c
> +++ b/support/nfs/xcommon.c
> @@ -94,13 +94,11 @@ xstrconcat4 (const char *s, const char *t, const char *u, const char *v) {
>   void
>   nfs_error (const char *fmt, ...) {
>        va_list args;
> -     char *fmt2;
>   
> -     fmt2 = xstrconcat2 (fmt, "\n");
>        va_start (args, fmt);
> -     vfprintf (stderr, fmt2, args);
> +     vfprintf (stderr, fmt, args);
> +     fprintf (stderr, "\n");
>        va_end (args);
> -     free (fmt2);
>   }
>   
>   /* Make a canonical pathname from PATH.  Returns a freshly malloced string.


