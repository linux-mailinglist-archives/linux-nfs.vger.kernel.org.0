Return-Path: <linux-nfs+bounces-5929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C4963786
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 03:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5211F239F0
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 01:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31E12B8B;
	Thu, 29 Aug 2024 01:12:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D2134D1;
	Thu, 29 Aug 2024 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893973; cv=none; b=XyeQYJWeRI8IZbKnkMk/Nwxbzh8cR0KaajeYqlfN8irK8I+Z6wGWuRn89KJN/wLPLSdb3qutC3IgAKKDBysegpTcjg/Advswuag9sUjaKZINFvIxI66efvecJAiQcgYZQPD9w11NGstvhSNaSrH1ZVdwMqZU+yrK9fg2/krmKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893973; c=relaxed/simple;
	bh=EBah3YTcsWvYHErDqJV7akZ4qINwmKVAArOHjcuwmsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EDT4GkNQdDONWGYYV5R6izGLUYhAqrtn4Sp+PJWH0ObiobZ5M3Pb3p2zWdFP0RoMZB6qPk/ORvx5nNMBvcX0mJi1Sbh818OOwebRKVKObqvdiHIalPQC8YtuQjAUro3wT8P2woESGAu9TUJwFNaJs8Ifz/pcbrr8cEY7ZNxu030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvNSD0H7Rz20mvZ;
	Thu, 29 Aug 2024 09:07:56 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FB5F140257;
	Thu, 29 Aug 2024 09:12:46 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 09:12:45 +0800
Message-ID: <3f40ff3c-0f66-49cc-806f-1cab6c8a8c50@huawei.com>
Date: Thu, 29 Aug 2024 09:12:45 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
To: Andrew Morton <akpm@linux-foundation.org>
CC: <kees@kernel.org>, <andy@kernel.org>, <trondmy@kernel.org>,
	<anna@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
 <20240827024517.914100-2-lihongbo22@huawei.com>
 <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
 <8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com>
 <20240827202204.b76c0510bf44cdfb6d3a74bd@linux-foundation.org>
 <a6ea03c9-f92b-4faa-b924-8df58484fb13@huawei.com>
 <20240828132509.4447ff09665fa0d7b8020294@linux-foundation.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240828132509.4447ff09665fa0d7b8020294@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/29 4:25, Andrew Morton wrote:
> On Wed, 28 Aug 2024 11:49:51 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:
> 
>>> Anything which is calling these functions is not performance-sensitive,
>>> so optimizing for space is preferred.  An out-of-line function which
>>> returns a const char * will achieve this?
>> I think this helper can achieve this. Because it is tiny enough, the
>> compiler will handle this like #define macro (do the replacement)
>> without allocating extra functional stack. On the contrary, if it is
>> implemented as a non-inline function, it will cause extra functional
>> stack when it was called every time. And it also should be implemented
>> in a source file (.c file), not in header file(.h file).
> 
> No, my concern is that if, for example, str_high_low() gets used in 100
> .c files then we get 100 copies of the strings "high" and "low" in
> vmlinux.  Making str_high_low() uninlined would fix this.

At first, I didn't consider these aspects.

> 
> However a quick experiment tells me that the compiler and linker are
> indeed able to perform this cross-object-file optimization:
> 
That's very good!

Thanks,
Hongbo

> --- a/fs/open.c~a
> +++ a/fs/open.c
> @@ -34,6 +34,8 @@
>   #include <linux/mnt_idmapping.h>
>   #include <linux/filelock.h>
>   
> +#include <linux/string_choices.h>
> +
>   #include "internal.h"
>   
>   int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
> @@ -42,6 +44,8 @@ int do_truncate(struct mnt_idmap *idmap,
>   	int ret;
>   	struct iattr newattrs;
>   
> +	printk("%s\n", frozzle(dentry == NULL));
> +
>   	/* Not pretty: "inode->i_size" shouldn't really be signed. But it is. */
>   	if (length < 0)
>   		return -EINVAL;
> --- a/fs/inode.c~a
> +++ a/fs/inode.c
> @@ -22,6 +22,9 @@
>   #include <linux/iversion.h>
>   #include <linux/rw_hint.h>
>   #include <trace/events/writeback.h>
> +
> +#include <linux/string_helpers.h>
> +
>   #include "internal.h"
>   
>   /*
> @@ -110,6 +113,8 @@ static struct inodes_stat_t inodes_stat;
>   static int proc_nr_inodes(const struct ctl_table *table, int write, void *buffer,
>   			  size_t *lenp, loff_t *ppos)
>   {
> +	printk("%s\n", frozzle(table == NULL));
> +
>   	inodes_stat.nr_inodes = get_nr_inodes();
>   	inodes_stat.nr_unused = get_nr_inodes_unused();
>   	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> --- a/include/linux/string_choices.h~a
> +++ a/include/linux/string_choices.h
> @@ -4,6 +4,11 @@
>   
>   #include <linux/types.h>
>   
> +static inline const char *frozzle(bool v)
> +{
> +	return v ? "frizzle" : "frazzle";
> +}
> +
>   static inline const char *str_enable_disable(bool v)
>   {
>   	return v ? "enable" : "disable";
> _
> 
> 
> x1:/usr/src/25> strings vmlinux|grep frazzle
> frazzle
> x1:/usr/src/25>
> 
> See, only one copy!
> 

