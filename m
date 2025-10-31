Return-Path: <linux-nfs+bounces-15823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EEEC23047
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30D9425096
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1F2E62C0;
	Fri, 31 Oct 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NlgoOoSi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9942E5B12
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877823; cv=none; b=Uo7wJPKkKS2maqQo4PGHM46Ky0aDl2QU6FRHsQT+qzHUizh8e6ZNZmRd3tLwPxE7FhOfgvq3KTV5kUV0adGeEMhC0hacEDUyXjszLh6rzs9D/H+TVXaDC5z0VCasFL4wSc9E1uvSY8FFV1YAN8RbfhBEvbDqZaAXTlV9rYkp++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877823; c=relaxed/simple;
	bh=Dcwkm7hZqquxeZkPTP8zfTHO+29DHqjuVIfEdi9nv7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgREAKLM55CblpDi9Xup93Er774uthme0vltRIwGxai3ud0u9ilbMuvlXt7XbWQMnZeV/L01Syz6MA0EMvFHgmaY++DxMZd9wyTbo4pINImHyoGCvLBWBllo2CuncXcB/UayeNkIwGokEK6TyCbPbzYkKXlNAI01KzVy4mPOVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NlgoOoSi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ro
	HfU/a6Bb3sxIIAPvQDNjXS0GAU/cSDqTL7PDbSXPQ=; b=NlgoOoSi+CPm5xsIYn
	y9hJSh/b7lDYSIn2xA/fEDiBrQktQxAOW2/FGcmc48rBznXT6WKTkCxP27qk/iRx
	MpBnRv6D/2h16rCdbZSeChULmg0m4VfwweJR0652/XQk1PRpt0tyCISdzNmlLi5c
	/CwkOjTCjZooai+H0DqP5BlH0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAHDGwPHwRp0MbaAQ--.433S2;
	Fri, 31 Oct 2025 10:29:38 +0800 (CST)
From: Yang Xiuwei <yangxiuwei2025@163.com>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Yang Xiuwei <yangxiuwei@kylinos.cn>,
	trondmy@kernel.org,
	anna@kernel.org,
	bcodding@redhat.com,
	linux-nfs@vger.kernel.org,
	yangxiuwei2025@163.com
Subject: Re: [PATCH] NFS: sysfs: fix leak when nfs_client kobject add fails
Date: Fri, 31 Oct 2025 10:29:06 +0800
Message-Id: <20251031022906.1381844-1-yangxiuwei2025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <07314e0f-76cf-42d8-b729-a6b61f2fbad0@oracle.com>
References: <07314e0f-76cf-42d8-b729-a6b61f2fbad0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHDGwPHwRp0MbaAQ--.433S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy3ArWxZr15JFWfXF1xAFb_yoWDGrgEqr
	WSgF1DZw1jgF47K3Wakr4rArZFga9xC3yrArZxAF92qry8Xr9ruF12g3WfAw1kGa1jgFs0
	krykt3srA342vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUUGYPUUUUU==
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwRInt2kEHxJWPgAA3L

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Hi Anna,

On 10/30/25 21:13, Anna Schumaker wrote:
> Good catch! But I think there is still a leak here. Don't we also need
> to call kfree() on 'p' in this case? And also if the first kobject_init_and_add()
> call fails?

Thanks for your feedback. The original patch should be correct:

First failure path: kobject_put(&p->nfs_net_kobj) triggers nfs_netns_object_release()
which already calls kfree(p). Adding manual kfree(p) would cause a double-free.

Second failure path: The patch adds kobject_put(&p->nfs_net_kobj),
which triggers the release callback to kfree(p). This is sufficient.

According to lib/kobject.c:443-444, when kobject_init_and_add() fails, 
calling kobject_put() is the proper cleanup method - it will trigger the 
release callback to free the memory.

If there are specific edge cases where the release callback isn't triggered, 
please let me know and I'll adjust accordingly.

Thanks,
Yang


