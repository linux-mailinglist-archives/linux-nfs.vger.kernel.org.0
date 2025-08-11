Return-Path: <linux-nfs+bounces-13548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D1FB2092A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB818A37BB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952A26D4CE;
	Mon, 11 Aug 2025 12:48:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C462367CC;
	Mon, 11 Aug 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916509; cv=none; b=i4ONk4q5PMo2G+Le0K8xPgMijBN6w4CsnQqKcg/QyRtmbwyBfAhYwc0yNJ+FEHaLLuZ2YNDCc9Rs/kKRq1Ohl2GplfsvdNaJWwjrQ24bozfUBnJxPyqd90ckDNePHDHkXIAyXQVBnJs5mdNTssaasK4pOqyS9snGuWYBtAPILdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916509; c=relaxed/simple;
	bh=2/D1Ymz7CVU1irMC5sx7KAJW6CSMN0e/hmw83sWrjnU=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=c39b67TVtw+IIPwkiry4tHvgmG/5zNtLXHK9exoHCrzSoTz05cYNQYyKna2KIXw298jl4DLX/lKvEz3l8VURYsSI34MhOXND6Sy9IWMCT2ikgLCtbwdmFr5k5PgpkB9Lrkm/5fZsuWzfEDEuIYiGueDSWZrEuK9xpwJDEX7BSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c0vY64SfDztTCZ;
	Mon, 11 Aug 2025 20:47:22 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 2731F18048F;
	Mon, 11 Aug 2025 20:48:23 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:48:22 +0800
Message-ID: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
Date: Mon, 11 Aug 2025 20:48:21 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "zhangjian (CG)" <zhangjian496@huawei.com>
To: Trond Myklebust <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [Question]nfs: never returned delegation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp200004.china.huawei.com (7.202.195.99)

Recently, we meet a NFS problem in 5.10. There are so many test_state_id request after a non-privilaged request in tcpdump result. There are 40w+ delegations in client (I read the delegation list from /proc/kcore).
Firstly, I think state manager cost a lot in nfs_server_reap_expired_delegations. But I see they are all in NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED (I read this from /proc/kcore too). 
I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED and never return it again. NFS server will keep the revoked delegation in clp->cl_revoked forever. This will result in following sequence response with RECALLABLE_STATE_REVOKED flag. Client will send test_state_id request for all non-revoked delegation.
This can only be solved by restarting NFS server.
I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not the only case that cause lots of non-terminable test_state_id requests after any non-privilaged request. 
Wish NFS experts give some advices on this problem.


