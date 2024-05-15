Return-Path: <linux-nfs+bounces-3264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BE8C6DF0
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DEEB225DE
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812615B141;
	Wed, 15 May 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7h+LF3U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42899155A57
	for <linux-nfs@vger.kernel.org>; Wed, 15 May 2024 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809594; cv=none; b=WuXvtLrsT+LWdDLGNlFJDuemr4qyq0Oq6Pc/nRErg3IHN0W46DxJYN6xWJI7ddBquM4wYbKOf2rd6TRppvBAjkIFN9E6k5B1Uocf2UVA/gjPekRUT4QzasOcqnIgJLqUy4eiRaACDKK6s3b01lUxPT9c4aNP4jRX+IuQBCFdoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809594; c=relaxed/simple;
	bh=Mtxt2rY3/XFM2ji6GZmsvL2Mc1RTPIJMRiTNgCCIukU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kvc+oLzVt/ZFBqwnz7HNWBjkFNcd2yewwzOf3uF1n7jF8JTpihdzzi1L2OKUaTqLTTAEbU6+0UYpP8+VczeMCtpkPDSIC9x3Aq16HzMxR8AQwN8Z7ovqqKkbSbWdIhDUvEinmTOvjpuvk9G87nqqGqvAAdrCbdKSNd3IhJWQWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7h+LF3U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715809592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwRNbWW6VaWKaV+sl5tKr/AhW6Op5oAwqY6Mvsd2BQU=;
	b=A7h+LF3Ui9+SlmjuKu4HGePhiLRJLARs1BTX4E16kR/nkPVqVbmuAguky1U3FuMtLzNQZM
	+wJAKAPVvuOo0+gqcXC5V7WfU+2/t4dsKyoMuCzsLAZGyGkYc8n1T4k35GPG+FkkbuWrpV
	+TLbCB6aVsL4PYF6Si6F5+Rwkkz6Yb8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-vKl5Gm7jMVyleSQ1K545yQ-1; Wed, 15 May 2024 17:46:30 -0400
X-MC-Unique: vKl5Gm7jMVyleSQ1K545yQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a35d03abb4so1812756d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 May 2024 14:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809590; x=1716414390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwRNbWW6VaWKaV+sl5tKr/AhW6Op5oAwqY6Mvsd2BQU=;
        b=Ovc1QLobWRUEIzKp+n8R1KtD+IPyz4hTdiXJuws1uTSJjE115MXdhz8ZCgQepquads
         /s1uPqwzi8n/j8Da4mKa96D3VhGuKSkbWmAeAXO4ieQBQ0ZjUlnY51y/c1YX0gAhF7Q9
         /PnpqZs5mx25q2wVl2wJDexezZxIe+WYmcabEZseW8hV/iPitxuHpEG5CaS7z5JgQVO7
         3RwZ0/IDHuiDqbRfDlvbCLBBaG0BJfkIc4fFnGJdNrOIsxDRRkpRytB/MH2vMokhfzpi
         9CoyuvUBwLX3n9Is8CdkPY8NxwmqRkJ2TAmAUNHGJ+N3H0QCOyCObt3UhV/JZgcUAngu
         8E0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp/F3sIzSnQcz2qsadUa2W8Vs2tft6X3mfAJMjNiZl8vSxMZSbllhj4/TUIjIpuIMW0UX//xfGdcVbemlyHrO3vwcsO/EUHDLD
X-Gm-Message-State: AOJu0YyRjMbSASkRcV4NZ0CIaeQUNTIGhA8i6JVPQo+yIyH10bHjin7w
	t6+t8ctOkIrEiZszUTTTttqlq2Sdd7uPzofuerb+XjJ1+IyfGmYbI1BWB1rylmsfQa9Pedp41BN
	iQzlupYJ4C4v3RbXeUPJDkl5l5Vp0QJT8A7jXbgweP5gTG4kpjLSej68BcA==
X-Received: by 2002:ad4:5fcf:0:b0:699:dfe:6015 with SMTP id 6a1803df08f44-6a168381784mr170934906d6.5.1715809589648;
        Wed, 15 May 2024 14:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK+WLWnWPui0ae+Rks7mwr4rVCjTQLDWewVFaxG0hulDilufGBB9niivlizLJzatArherp0A==
X-Received: by 2002:ad4:5fcf:0:b0:699:dfe:6015 with SMTP id 6a1803df08f44-6a168381784mr170934676d6.5.1715809589132;
        Wed, 15 May 2024 14:46:29 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194c88sm67890636d6.65.2024.05.15.14.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 14:46:28 -0700 (PDT)
Message-ID: <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com>
Date: Wed, 15 May 2024 17:46:27 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
To: Dan Shelton <dan.f.shelton@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey!

On 5/14/24 5:57 PM, Dan Shelton wrote:
> Hello!
> 
> Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, which
> provide platform-independent paths where resources can be mounted
> from, i.e. nfs://myhost//dir1/dir2
> 
> Could Linux /sbin/mount.nfs4 support this too, please?
Why? What does it bring to the table that the Linux client
does already do via v4... with the except, of course, public
filehandles, which is something I'm pretty sure the Linux
client will not support.

So again why? WebNFS died with Sun... Plus RFC2224 talks
about v2 and v3... How does it fit in a V4 world.

But of course... Patches are welcome.

steved.

> 
> Dan


