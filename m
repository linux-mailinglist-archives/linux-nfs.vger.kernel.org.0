Return-Path: <linux-nfs+bounces-8192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5052A9D5A10
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 08:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11B21F23513
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D7170A37;
	Fri, 22 Nov 2024 07:35:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78F16F8EB;
	Fri, 22 Nov 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260930; cv=none; b=OkWyCAMvVeK2BCsT83KhuLgrInxLsXRchMxrDkdwBenreXgJZkYYLmoITgxTk0jgoXRV/1S+OkDEGUEYG89Dqun8LeHwtuKSCDIcuQzDFxLykzrGlh1TfeAE36FZX/F93stIPDZi9JAyfia8+vmBLgwJ5dQapQQmVdWXBIdeps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260930; c=relaxed/simple;
	bh=WyfnA0cfDY9D9kNbER7iMR31f4KMc+iYa3nvmoAJYtk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rGVnNgIFLlJOlNLJruAH365ShVIlEnBpOpZ8E38If+kRyGx0SqWvV2gfVHhrvJMhoINIbmqUKArzee/0TnjRIpEI64k4C8TqC1QHP3jKUgI9fFTB7kb9KbW3qgFqCQRpdmP7A/VnuaFcwCz0keVK0ckMQvQ+AFTTVUChu4ZrtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xvmzd2bh8z1T5TF;
	Fri, 22 Nov 2024 15:33:17 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (unknown [7.185.36.88])
	by mail.maildlp.com (Postfix) with ESMTPS id 55D8D1A016C;
	Fri, 22 Nov 2024 15:35:19 +0800 (CST)
Received: from client.huawei.com (10.137.16.211) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 15:35:18 +0800
From: jiangheng <jiangheng14@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yanan@huawei.com>, <gaoxingwang1@huawei.com>
Subject: NFS client hangs due to waiting for FSSTAT to complete and NFS server returning NFS_JUKEBOX(10008) to FSSTAT
Date: Fri, 22 Nov 2024 15:24:08 +0800
Message-ID: <20241122072408.2973342-1-jiangheng14@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)

some nfs servers in the server cluseter restart, and other servers return NFS_JUKEBOX.
The client's applications hang for more than 600s due to rpc tasks are repeatedly retried:

nfs3_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
{
    int res;
    do {
        res = rpc_call_sync(clnt, msg, flags);
        if (res != -EJUKEBOX)
            break;
        __set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
        schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
        res = -ERESTARTSYS;
    } while (!fatal_signal_pending(current));
    return res;
}

Does the nfs3_rpc_wrapper function need to add a retry times and exit the loop when retry times reaches the maximum?


