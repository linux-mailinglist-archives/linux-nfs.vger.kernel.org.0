Return-Path: <linux-nfs+bounces-8902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDC9A00FE7
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7426218833E4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77802145B3F;
	Fri,  3 Jan 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB76Ftdg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C96145B03
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940069; cv=none; b=X2FtP0rtlF/SK+W2X2UBo7gzyQGkufj4Vi2KgltNrG2OfgSPxt+pJ44VW44887PHw+O/4aKk+QbKwWIdb7eM2Mr2S/UzLsdvQ/tDxKUjRhHq9cdcqlgAbnNhXbikLUW/+/U/twbCXOpF2QpaMnLr+5ol566BK1FNqlPg0vxDkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940069; c=relaxed/simple;
	bh=tZULhj/fC8iE6t310rX24YFkqR0GH5t9uIfERvqa6gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdn3AoShdKbuZmTrV4WjqtFLQf9mDYYD8LYj/Cjea22V8k64E9+ZqCi/GEha/H4zrwmfpiijOnX5+wqyJo3E31dpJO4j2KhG2N8+DWh3XEZI58M3JgxgZ+50B+ifRKY2Vm3r+HN+c7WoEc35SsgJ8wkwspB17wC+bs10V4Fwu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XB76Ftdg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735940066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2ridlovvFvl/a4MMnh/z7enSVtUkDH5C/uOb3u0q/Y=;
	b=XB76FtdgrZr7fi91Q6A+GHe1ZFptwZ4wDGgLGspHgMULlJ4+11Dd4nSnYzdc1cSKR9OAf9
	jFUOzUlQ3KJjYNjY7Vh8WZG29f03q7KNLWtFhSclWKt/Gj+1MSijxvca93OyxBAN4RQZyl
	SJkSnPdeF+Mg+3u9HrIuhStHnXs9t8M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-JIsWB234OpOha-SxI6XBLA-1; Fri, 03 Jan 2025 16:34:25 -0500
X-MC-Unique: JIsWB234OpOha-SxI6XBLA-1
X-Mimecast-MFC-AGG-ID: JIsWB234OpOha-SxI6XBLA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f94518c9so264687706d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735940063; x=1736544863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2ridlovvFvl/a4MMnh/z7enSVtUkDH5C/uOb3u0q/Y=;
        b=qHMo/mIMrXVkBTZegUbxCbY5xyQwh/u7t3G5YIUW135SiJPazuSdmW/ff39wGcU9vB
         6ua+9ReLCy6Uf1sQSFmXRxpM9M8izPn6BKR6YwWBALozxReiEBRyU9Da/J5QzNjkcy4K
         knOYcBs2cT0OzmyZHhEDcUNbCSuUbcbOLmw5Wv7/IiRo8RwkVjVPYqp9f+TtnZcYa8Ur
         ANqgINPk1yhJQkRo99vTfLEitnWUzEXd1bTOuEwsz2xYP8la4TtuYGeSmns2L5l8sGnH
         09B6rnbheBr9tICatCpbvkqTIAheipDkSlN5e/8xQFNMszrZDzgzKdjNZ4OevaZdcWMD
         rmuw==
X-Gm-Message-State: AOJu0YyFsauR3wNEKmPOUOSNLOcQe/5jp0z1vQ7V0cBk6JksKWM3arEf
	7/+8j6xxO06aPgciOh3MOJFtVlbBUQl8SG9+bfbF+IWAVjkbNQm0eoVWn+oKEgWsJzFjNoNiDAm
	WQdJRciBlTVgVNGDDAMF7ro+5Orf/fTteVIRcnXzGY2EmMO4EdOLAhTcK1HtMTa8mQg==
X-Gm-Gg: ASbGnct+Igbwxl7VPFQYotAAO4RftajnwDtEJqMmd6HGNXRaC0NDsAtk6tr/q8CCly1
	Ai9qx6LTa6Z+xOHcH5TSfgspiulpTVbXCgcuSxQsu8lu250Ng8z27Jj8zciz7gspUIq4iUyOsyC
	64xb+g8ihJWRS6czuViUF1wwBTMJXZdOp9g6LiC5bdjM1GvxFixKPApPPYT3NE3O4OdCPx8/i1U
	yyxa8pVHsKMg86qqzjX5a6DmrFUK9wJFwVWelQ6U2DzFahavPAJfJYn
X-Received: by 2002:a05:6214:5f11:b0:6d8:a730:110c with SMTP id 6a1803df08f44-6dd2339b10dmr1068513976d6.38.1735940063217;
        Fri, 03 Jan 2025 13:34:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCIMKx/8/PBpTLS0odKgpE1ey6jDao5RjKJu2hY3LT7ADi5nULKO/wlAtkiVPjOUNACymYBQ==
X-Received: by 2002:a05:6214:5f11:b0:6d8:a730:110c with SMTP id 6a1803df08f44-6dd2339b10dmr1068513746d6.38.1735940062916;
        Fri, 03 Jan 2025 13:34:22 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea715sm144917366d6.11.2025.01.03.13.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:34:21 -0800 (PST)
Message-ID: <bab50cf1-5b87-49ff-b268-560c07fe6a65@redhat.com>
Date: Fri, 3 Jan 2025 16:34:21 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] conffile: add 'arg' argument to
 conf_remove_now()
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250102224109.634190-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250102224109.634190-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/2/25 5:41 PM, Scott Mayhew wrote:
> Commit 9350a97a added an optional 'arg' to section names, but the logic
> to remove configurations wasn't updated to check the 'arg' argument.
> This wasn't really a problem until commit 15e17993 updated
> conf_parse_line() to call conf_set() with override=1, the end result
> being that we'll only remember the last value seen for any given
> section/tag combination.
> 
> Fixes: 9350a97a ("Added an conditional argument to the Section names")
> Fixes: 15e17993 ("conffile: process config.d directory config files.")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc1)

steved.
> ---
>   support/nfs/conffile.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
> index 1e9c22b5..137fac8d 100644
> --- a/support/nfs/conffile.c
> +++ b/support/nfs/conffile.c
> @@ -169,13 +169,15 @@ static void free_conftrans(struct conf_trans *ct)
>    * Insert a tag-value combination from LINE (the equal sign is at POS)
>    */
>   static int
> -conf_remove_now(const char *section, const char *tag)
> +conf_remove_now(const char *section, const char *arg, const char *tag)
>   {
>   	struct conf_binding *cb, *next;
>   
>   	cb = LIST_FIRST(&conf_bindings[conf_hash (section)]);
>   	for (; cb; cb = next) {
>   		next = LIST_NEXT(cb, link);
> +		if (arg && (cb->arg == NULL || strcasecmp(arg, cb->arg) != 0))
> +			continue;
>   		if (strcasecmp(cb->section, section) == 0
>   				&& strcasecmp(cb->tag, tag) == 0) {
>   			LIST_REMOVE(cb, link);
> @@ -217,7 +219,7 @@ conf_set_now(const char *section, const char *arg, const char *tag,
>   	struct conf_binding *node = 0;
>   
>   	if (override)
> -		conf_remove_now(section, tag);
> +		conf_remove_now(section, arg, tag);
>   	else if (conf_get_section(section, arg, tag)) {
>   		if (!is_default) {
>   			xlog(LOG_INFO, "conf_set: duplicate tag [%s]:%s, ignoring...",
> @@ -1254,7 +1256,7 @@ conf_end(int transaction, int commit)
>   						node->is_default);
>   					break;
>   				case CONF_REMOVE:
> -					conf_remove_now(node->section, node->tag);
> +					conf_remove_now(node->section, node->arg, node->tag);
>   					break;
>   				case CONF_REMOVE_SECTION:
>   					conf_remove_section_now(node->section);


