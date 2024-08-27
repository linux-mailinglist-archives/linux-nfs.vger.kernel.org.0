Return-Path: <linux-nfs+bounces-5827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B199961ABB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417F91F240B3
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C81D4611;
	Tue, 27 Aug 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O5JA68mO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241D19EEBB;
	Tue, 27 Aug 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802140; cv=none; b=Lhpvz7nUc2FKunDRLcZXUJ02nH4WiLj40fEyz3WxcyzlAqUh0NdYl8UMM3YCRP6N0X7wUI+lr+WE8lSRbZTqC1sgg2b5WZwAhs9KkN2PHGVFou5/8Ve8UT+aMm5+Nb54pzYTtod/kBs0fyoRXfBWpRwWKkGCMbxofUiW2V5CgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802140; c=relaxed/simple;
	bh=PkPinK6GtuRFl5Q/O1ftstgZgoYWTnwkOR/Zk5lgJT4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bDnsbOMwCM8/9+bEpF27dKgP8hsbdegS7yYrOPeI1Qk2aQ9lekZdjuE5KYF89WukJOcc78ne9QaKT2uS1Rb/pgi5EGuZWE6Ym5tc1n9CJq5RzobULlp1485eQ0C/rlTiNDyzteAg7w84PlITJZfYmGnsIdfC2o05UaRQ99FnCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O5JA68mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4747CC4AF60;
	Tue, 27 Aug 2024 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724802139;
	bh=PkPinK6GtuRFl5Q/O1ftstgZgoYWTnwkOR/Zk5lgJT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O5JA68mOh4xXaS8Xhw6ckkzQc60NQgcKn7WQEr3fM/rULfLqVGY4j118Oo9uxvstD
	 fyPG6pST8mdkoAnisnwfYqOv9HBPyZ05BgYh/1SpFlfUJzo59ms0gddgLSg6r7HDS7
	 Q3cnwodv45q3v75x3gd9iDLPESS0MCtXF37FZqTg=
Date: Tue, 27 Aug 2024 16:42:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <kees@kernel.org>, <andy@kernel.org>, <trondmy@kernel.org>,
 <anna@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
Message-Id: <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
In-Reply-To: <20240827024517.914100-2-lihongbo22@huawei.com>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
	<20240827024517.914100-2-lihongbo22@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 10:45:15 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:

> Add str_true_false()/str_false_true() helper to return "true" or
> "false" string literal.
> 
> ...
>
> --- a/include/linux/string_choices.h
> +++ b/include/linux/string_choices.h
> @@ -48,6 +48,12 @@ static inline const char *str_up_down(bool v)
>  }
>  #define str_down_up(v)		str_up_down(!(v))
>  
> +static inline const char *str_true_false(bool v)
> +{
> +	return v ? "true" : "false";
> +}
> +#define str_false_true(v)		str_true_false(!(v))
> +
>  /**
>   * str_plural - Return the simple pluralization based on English counts
>   * @num: Number used for deciding pluralization

This might result in copies of the strings "true" and "false" being
generated for every .c file which uses this function, resulting in
unnecessary bloat.

It's possible that the compiler/linker can eliminate this duplication. 
If not, I suggest that every function in string_choices.h be uninlined.

