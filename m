Return-Path: <linux-nfs+bounces-19171-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KI/FU6fnWnwQgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19171-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:53:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A6187424
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 13:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6DF3066BCA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9939B481;
	Tue, 24 Feb 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYvz/DEd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyWTkobD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32B39A7EA
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937597; cv=none; b=CyIvKPKUVnpNSRiqohDLBE3bXsUrUN5Lq5XZTGhVn4XclJF+8dZdJ0GkLuzXU/tw9LLM0mVZ4IiqJs2kxpJHw9BFHItypo7vfghHLkBzF+FvWdfjZrUD1fVG8uA0rFHu4fz8wRU5wivhC8/ZLiKIC6ZKHOkNd/jH2ga3pSPuNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937597; c=relaxed/simple;
	bh=VBdHJWIujmJY4fZ4m8TTkURIvojJ/csqsEXGvuHOkHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gFUEniBtcsTWk7jBQ/YdMwC/OFQWUgJWAUXOAOlyb2LakLbIYyjb0qGNckwjn9IUpqg0nT/zTLungND+p6WvG20pX1HVbWQTcbeyrRDcVvZxQosOo+1B5hMh4FAQwcBB1YNw6z1hBndoOxZDam8FN1pWogqBqMnRgoLbHabbkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYvz/DEd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyWTkobD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771937594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GJVS3O0XTC6ax5Ld92IWpZ30j9ZfGWiAilZ6Oyx2jw=;
	b=eYvz/DEdW4TPU0beb3MXIqcGKNtJ27gahKv5IFgbdqC15BiiK5uSdmgeHK3sj/p6dBQ9xA
	z3m9m3c5yYpdk7M1j+rJEsg2E9hJGOg7qIuVpsr1jItAQYoOn7M7MgcjBjs0R/zHS8KWGl
	YpYw3GgSHKUYzB8kKpzXpJpKT9tShsA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-sm46d1kVOHKwRsKoau_OSw-1; Tue, 24 Feb 2026 07:53:13 -0500
X-MC-Unique: sm46d1kVOHKwRsKoau_OSw-1
X-Mimecast-MFC-AGG-ID: sm46d1kVOHKwRsKoau_OSw_1771937593
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5033b4d599eso580537751cf.2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 04:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771937593; x=1772542393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GJVS3O0XTC6ax5Ld92IWpZ30j9ZfGWiAilZ6Oyx2jw=;
        b=QyWTkobDJuLP8E7L2+C+DihaKLTy2GheuZt8wWBhvk1yju7PYjQMh8bhmxHWh6leIW
         pr0OL17pbU5cxLH2tuXBVegwV2YXc4f426wvH6Q1sW5So+ALjheHcAOhobWFVfuzUIk4
         B/LlUfRFmMDHZlkO+A+5oJrr/+9kWuxnupJiBo/+qfVfsG5JUhIowgM4y9+E2zlu5jFL
         7chEofnz/h7wZGCkSdRcn9PjfalafbS8DFGhaISGy4sjm7bEj9GqKMa0PL102tfATzv2
         gEQzvRdFhJjLZPqYkHgu92GJRVna/WV5U5WG7ZqhFRkrTCtoKySBjaLTY54xkSI/wXc7
         WROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937593; x=1772542393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GJVS3O0XTC6ax5Ld92IWpZ30j9ZfGWiAilZ6Oyx2jw=;
        b=i1bHZVz5sPSw84q3ZlCwgDUH2bUx1zTzmBtWFgSC5YDETOAQvmDPbjo41s3hAHwNvf
         Jwznzc20HYNEF1VhQT211ZXO4NbuXUKQBk19hjNEn3NfRcG6w7IW83By30+7V2LqDxxW
         A0YEMCLnnwF1PWnTSg+HuxXwMGPCS7YMPlxDjDyWdZ6aOn9rx9C/myIj0o6T4KJu+OUR
         wS4exSWMPmvU9k29phGNoC7Abspxq+sGDlfUhfhB2QeqbCyTDvq+E3ueFgDTRSQDv6i8
         kKRQRsf8zLGh+UlCTmTJKpG1MUR1Dnu2oMHqAFO8CIjGXgzrU1E9wh004G084VZYdNls
         HGyw==
X-Forwarded-Encrypted: i=1; AJvYcCV+FLHFCHRuul9VVRMIzO+NffBA3yF5QmKdwBU+DKCHjlK1i6Yvmg0ZhQsaeonQj9JpPrNBuGBJMmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx997TqQDlA1Xuh54HONWs1TSCaHglk0HRnA72LBECiSvAljr3N
	RVxwsuJjrrh6D9dpo+U/VXDr2MuCmswXqOuIn5QsPdPXkEcb4bSHFsNbmlxahJf6aHQLOF0zCVi
	U/X5gSI4/YsyrI6Wkag4PLXZohDX5x2Dajx/6cxU/fpMPwhGI4uzVYZNABgX/uQ==
X-Gm-Gg: AZuq6aIkJBgFUkG3gnezl9r4tRu/IT9I9Z8udEqTc+Xwm5HVK6VhpVc+BCygRh0/FqB
	YGGfUvunt+cV+PuTaiSw8Gl2w8hsZZRVNIvCWWWr7BUXQ7aGkEUZgN8EbKND0Vbk4d2dgyVi4GE
	1HQH7Nir2KjUw15OHidkJWzRwvxVYonUuFLSBne2dpGH08mJlBHttbbebyl4kpdlvpdWc9Ki/3I
	7t03qqRnAePVSLggE99U88AL7b4GHXDR7HApML266KQrdVj1S3kJAM7jS4kuerCH+o8FyFDDZi/
	99ls8gMNkrUC8WWfx5xGwOpPmtiPvjxvoh6uxn0cEwiUrnZghbtmEAsNzHFjhMiqJuBbynZTCbZ
	sUJFQ8G8Ang4/B7dZMJ1W
X-Received: by 2002:a05:622a:1894:b0:506:2041:13be with SMTP id d75a77b69052e-5070bcb4b53mr158302941cf.52.1771937592778;
        Tue, 24 Feb 2026 04:53:12 -0800 (PST)
X-Received: by 2002:a05:622a:1894:b0:506:2041:13be with SMTP id d75a77b69052e-5070bcb4b53mr158302731cf.52.1771937592342;
        Tue, 24 Feb 2026 04:53:12 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c9de8sm93891861cf.26.2026.02.24.04.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:53:11 -0800 (PST)
Message-ID: <f3228597-2bd9-4e74-917e-6ed05341e7e6@redhat.com>
Date: Tue, 24 Feb 2026 07:53:09 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs-utils: conffile: fix discards const from pointer
 target
To: Rudi Heitbaum <rudi@heitbaum.com>, linux-nfs@vger.kernel.org
References: <aZFwasmAQKAa7nCc@1eac07209f0d>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <aZFwasmAQKAa7nCc@1eac07209f0d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19171-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,heitbaum.com:email]
X-Rspamd-Queue-Id: C72A6187424
X-Rspamd-Action: no action



On 2/15/26 2:06 AM, Rudi Heitbaum wrote:
> end is used as the return from strchr(line) which is a const char and
> then again as the return from strchr(name) which is a char pointer to
> the strdup(line). Declare a const char * pounter for use in the first
> case, addressing the warning.
> 
> fixes:
>      conffile.c: In function 'is_tag':
>      conffile.c:1711:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>       1711 |         end = strchr(line, '=');
>            |             ^
>      conffile.c: In function 'is_taggedcomment':
>      conffile.c:1825:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>       1825 |         end = strchr(line, ':');
>            |             ^
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
Committed... (tag: nfs-utils-2-8-6-rc2)

steved.
> ---
>   support/nfs/conffile.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
> index 137fac8d..8d242c2f 100644
> --- a/support/nfs/conffile.c
> +++ b/support/nfs/conffile.c
> @@ -1704,12 +1704,13 @@ static bool
>   is_tag(const char *line, const char *tagname)
>   {
>   	char *end;
> +	const char *equal;
>   	char *name;
>   	bool found = false;
>   
>   	/* quick check, is this even an assignment line */
> -	end = strchr(line, '=');
> -	if (end == NULL)
> +	equal = strchr(line, '=');
> +	if (equal == NULL)
>   		return false;
>   
>   	/* skip leading white space before tag name */
> @@ -1807,6 +1808,7 @@ static bool
>   is_taggedcomment(const char *line, const char *field)
>   {
>   	char *end;
> +	const char *equal;
>   	char *name;
>   	bool found = false;
>   
> @@ -1822,8 +1824,8 @@ is_taggedcomment(const char *line, const char *field)
>   	line++;
>   
>   	/* quick check, is this even a likely formatted line */
> -	end = strchr(line, ':');
> -	if (end == NULL)
> +	equal = strchr(line, ':');
> +	if (equal == NULL)
>   		return false;
>   
>   	/* skip leading white space before field name */


