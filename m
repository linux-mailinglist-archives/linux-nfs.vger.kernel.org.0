Return-Path: <linux-nfs+bounces-5878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7739631B7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 22:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3381C21F59
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD81ABEA7;
	Wed, 28 Aug 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kESqIMtE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27D15749A;
	Wed, 28 Aug 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876711; cv=none; b=m17B+1aIL28JM+mFtXBb5rNOQNGstQWPUnX0PR3vLkFdt0NgkLGctRpPx7qbxLnvCZaOe5A0+JJfllfTy8riH/54y+/n31EjuYJMCq7ovpfuYrB0p+EStzsX6dfjm3ZTp8mJxD5tHQ/XS01EGlxmz7EaBibQP0jzxIZc/g/Iz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876711; c=relaxed/simple;
	bh=uBzK29h3Wh6e0YeFL9zV/5o5Il6973lCrLvdGTFVRkw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DLVsS6kEGWkvgRGPkDcHF19G+LWSbjveq9Z67LD3J+n9wagb4B5CXbipsqfmghDUR2Km6fz+SBdcshSXismYUrvi6iBL35PjnkDYib1Q262msCRh3+nWVmDt9CGFhwrfPXh9ixS2bRTe9jYi/BX6FAKUuybUg5BQxhz22teXB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kESqIMtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31981C4CEC0;
	Wed, 28 Aug 2024 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724876710;
	bh=uBzK29h3Wh6e0YeFL9zV/5o5Il6973lCrLvdGTFVRkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kESqIMtEyaI6zQPj+eFkdX2qp6FfujEgsyeUTXA8nqaZVEDggX0J7y2PWqdjnzzdd
	 DzbuD0A2ZUpJ1bnu0jyPugCnINMWbwSVcWndrHgYBhQ4mtp6i+P+khKFFJDtXv4Ovr
	 Js/dyblXotDccUNnKDO5Ql519VNFNhYtsiVi8eTo=
Date: Wed, 28 Aug 2024 13:25:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <kees@kernel.org>, <andy@kernel.org>, <trondmy@kernel.org>,
 <anna@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
Message-Id: <20240828132509.4447ff09665fa0d7b8020294@linux-foundation.org>
In-Reply-To: <a6ea03c9-f92b-4faa-b924-8df58484fb13@huawei.com>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
	<20240827024517.914100-2-lihongbo22@huawei.com>
	<20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
	<8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com>
	<20240827202204.b76c0510bf44cdfb6d3a74bd@linux-foundation.org>
	<a6ea03c9-f92b-4faa-b924-8df58484fb13@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 11:49:51 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:

> > Anything which is calling these functions is not performance-sensitive,
> > so optimizing for space is preferred.  An out-of-line function which
> > returns a const char * will achieve this?
> I think this helper can achieve this. Because it is tiny enough, the 
> compiler will handle this like #define macro (do the replacement) 
> without allocating extra functional stack. On the contrary, if it is 
> implemented as a non-inline function, it will cause extra functional 
> stack when it was called every time. And it also should be implemented 
> in a source file (.c file), not in header file(.h file).

No, my concern is that if, for example, str_high_low() gets used in 100
.c files then we get 100 copies of the strings "high" and "low" in
vmlinux.  Making str_high_low() uninlined would fix this.

However a quick experiment tells me that the compiler and linker are
indeed able to perform this cross-object-file optimization:

--- a/fs/open.c~a
+++ a/fs/open.c
@@ -34,6 +34,8 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/filelock.h>
 
+#include <linux/string_choices.h>
+
 #include "internal.h"
 
 int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
@@ -42,6 +44,8 @@ int do_truncate(struct mnt_idmap *idmap,
 	int ret;
 	struct iattr newattrs;
 
+	printk("%s\n", frozzle(dentry == NULL));
+
 	/* Not pretty: "inode->i_size" shouldn't really be signed. But it is. */
 	if (length < 0)
 		return -EINVAL;
--- a/fs/inode.c~a
+++ a/fs/inode.c
@@ -22,6 +22,9 @@
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
 #include <trace/events/writeback.h>
+
+#include <linux/string_helpers.h>
+
 #include "internal.h"
 
 /*
@@ -110,6 +113,8 @@ static struct inodes_stat_t inodes_stat;
 static int proc_nr_inodes(const struct ctl_table *table, int write, void *buffer,
 			  size_t *lenp, loff_t *ppos)
 {
+	printk("%s\n", frozzle(table == NULL));
+
 	inodes_stat.nr_inodes = get_nr_inodes();
 	inodes_stat.nr_unused = get_nr_inodes_unused();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
--- a/include/linux/string_choices.h~a
+++ a/include/linux/string_choices.h
@@ -4,6 +4,11 @@
 
 #include <linux/types.h>
 
+static inline const char *frozzle(bool v)
+{
+	return v ? "frizzle" : "frazzle";
+}
+
 static inline const char *str_enable_disable(bool v)
 {
 	return v ? "enable" : "disable";
_


x1:/usr/src/25> strings vmlinux|grep frazzle
frazzle
x1:/usr/src/25> 

See, only one copy!


