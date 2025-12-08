Return-Path: <linux-nfs+bounces-16987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47CCACC82
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFFC0300614C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178831CA46;
	Mon,  8 Dec 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="FMxNCVCM";
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="FMxNCVCM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12131BCB9;
	Mon,  8 Dec 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765187777; cv=none; b=s3rD1jiCqBljIrrqViCCMAhCGtY+HFo1QjH2HL1fSU4FSd0vRUQoWbjdWVPVi7xAYyZkjKeYVcnsPHYoWK3DAPhWwoBsFakOw0j+5Usz3vuyo50NI53vUUS2P9thHxR+2kSUcPS2QS9i78Pd8OHdrq5H8t7cr9YtgtiDdcXIH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765187777; c=relaxed/simple;
	bh=e/uROyPMHIRFeOPSItP50Jy8z0uBMXZntADnssQfm3g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ml/5UHuba855CAUKjMMlozFdLIsN2K3xQHf3O08Ydt2Xdq6WOp4GtEtD8t+aarM8h+ur/g1X00FsmfiMMxHe7DvmM8r0zePgajHvzi8BdKe+RdoWeEB+WWrPMwuvCxE/lW2av9nJgXpR9LkgW4ovb08dxv8dIRXSxs+DG1dAQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=FMxNCVCM; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=FMxNCVCM; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=twA+W597NFGI0J+KIKwQRx3CHDy7Ai7taeqrpUm87j8=;
	b=FMxNCVCMxUADMYdLFAZp6cSxRu0KtsvyS7rLKlacVHTwtTbIeA9lK7CT3U5XqqJ3z1vLtYVlD
	8enhJoIXRPEfneM5zeCzx+WZZYH25YRPTAU0y8fYVQgE8xZ7w9GNR6IOeg4xt/6QNoDKwozy09U
	0SsagypmukoiRVnD2fRTR5Q=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dPy6X2WPdz1BFrL;
	Mon,  8 Dec 2025 17:56:04 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=twA+W597NFGI0J+KIKwQRx3CHDy7Ai7taeqrpUm87j8=;
	b=FMxNCVCMxUADMYdLFAZp6cSxRu0KtsvyS7rLKlacVHTwtTbIeA9lK7CT3U5XqqJ3z1vLtYVlD
	8enhJoIXRPEfneM5zeCzx+WZZYH25YRPTAU0y8fYVQgE8xZ7w9GNR6IOeg4xt/6QNoDKwozy09U
	0SsagypmukoiRVnD2fRTR5Q=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dPy4H4bqfzRhVS;
	Mon,  8 Dec 2025 17:54:07 +0800 (CST)
Received: from dggpemr100013.china.huawei.com (unknown [7.185.36.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 1ABD518047C;
	Mon,  8 Dec 2025 17:56:03 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 dggpemr100013.china.huawei.com (7.185.36.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Dec 2025 17:56:02 +0800
Message-ID: <b3ef1024-bc81-4436-ae65-f1bdaf07efe8@huawei.com>
Date: Mon, 8 Dec 2025 17:56:01 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [Question] nfsacl: why deny owner mode when deny user
From: "zhangjian (CG)" <zhangjian496@huawei.com>
To: <stfrench@microsoft.com>, <chuck.lever@oracle.com>, <bfields@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
References: <32686cd5-f149-4ea4-a13f-8b1fbb2cca44@huawei.com>
 <a4435153-eb55-4160-9b46-aa937cffa575@huawei.com>
In-Reply-To: <a4435153-eb55-4160-9b46-aa937cffa575@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemr100013.china.huawei.com (7.185.36.198)

When user read bit is denied by nfs4_setfacl, owner read bit is also
denied.
Example:

[root@localhost ~]# nfs4_getfacl test/a
# file: test/a
A::OWNER@:rwatTcCy
A::1000:rwatcy
A::GROUP@:rtcy
A::EVERYONE@:rtcy

[root@localhost ~]# nfs4_setfacl -a D::1000:r test/a
[root@localhost ~]# nfs4_getfacl test/a
# file: test/a
D::OWNER@:r
A::OWNER@:watTcCy
D::1000:r
A::1000:watcy
A::GROUP@:rtcy
A::EVERYONE@:rtcy

In function process_one_v4_ace, I see read bit is denied for owner:
case ACL_USER:
	i = find_uid(state, state->users, ace->who);
	if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
		allow_bits(&state->users->aces[i].perms, mask);
	} else {
		deny_bits(&state->users->aces[i].perms, mask);
		mask = state->users->aces[i].perms.deny;
		deny_bits(&state->owner, mask);
	}
This change is commit in 09229ed. But I wonder why it is implemented
like this.

