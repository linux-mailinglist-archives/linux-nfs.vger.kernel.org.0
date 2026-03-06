Return-Path: <linux-nfs+bounces-19820-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK7RC3dAqmlQOAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19820-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 03:48:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DFE21AB9B
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 03:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC2AE304261C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8E2D46A1;
	Fri,  6 Mar 2026 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="bb7G1vwz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80A23EA89;
	Fri,  6 Mar 2026 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765230; cv=none; b=TAJMTjm/K35WuVGTX14TtxB857xUATll7q2zYoggWLFuF3Hh3fcH4JFZ51E0VTctNZ/CmuBGD4pkEX7C2FJ1/Htmcgta/ym9kVy72lHTKYa14KuRUsSbZwE/sI4eZKAGNHvyU0XR32fFWOtAUJdwcBRRI/yPJ0/Bvz5XxbYLIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765230; c=relaxed/simple;
	bh=9/eClTh+JzBeyBcz/Qwseb7D9WH7kr/ukhBJs0hnfO4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mP6LGknz/AKbdUi/Gat8W2wp4v1JtDbB2AEBU7B1L/dMWhWPy+ElzWy+We9uJ4K3Anwks6AZs2Qwt3pzXVueizgaenO3Q9Yfhp6S3gBDspEo7XbXQBGWLNJGHFDEOCzjCMME1jOo5OsrV3b4iwnM+nsqHJS3sBdNOB6NMgSWnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=bb7G1vwz; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9/eClTh+JzBeyBcz/Qwseb7D9WH7kr/ukhBJs0hnfO4=;
	b=bb7G1vwzRSM1odvKm4Ngf7yLoiZhg7Utx1PYXRecDj3RMlQ/fj0O5HYev2u7orYNmi1AxEpF2
	8Azl5anJ4NjKP5ZBwhwYD1J7CdFI1GX6L1W8Im0YDjTzACcjs9C7wa2PWf2HfcrDY6y3K4LJo2O
	a5SfY8hEgJwwl3pxCtHWpos=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fRrK60w7pzpTJW;
	Fri,  6 Mar 2026 10:42:02 +0800 (CST)
Received: from dggpemr100013.china.huawei.com (unknown [7.185.36.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 89EF02022B;
	Fri,  6 Mar 2026 10:47:04 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 dggpemr100013.china.huawei.com (7.185.36.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Mar 2026 10:47:03 +0800
Message-ID: <23b52d16-4b74-43e4-9fff-73ac57c9ef89@huawei.com>
Date: Fri, 6 Mar 2026 10:46:37 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]nfs: never returned delegation
From: "zhangjian (CG)" <zhangjian496@huawei.com>
To: <trond.myklebust@hammerspace.com>, <anna@kernel.org>, Jeff Layton
	<jlayton@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
 <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
 <1e1eadf5-fab9-4919-a71a-864aa7109c7b@huawei.com>
In-Reply-To: <1e1eadf5-fab9-4919-a71a-864aa7109c7b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr100013.china.huawei.com (7.185.36.198)
X-Rspamd-Queue-Id: 93DFE21AB9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	TAGGED_FROM(0.00)[bounces-19820-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian496@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,h-partners.com:dkim]
X-Rspamd-Action: no action

Hi experts on NFS:

Recently we meet an error:
1.Nfs wait for sunrpc
2.Sunrpc send OPEN message and hang the rpc task onto sunrpc pending queue.
3.Server never reply, and since NFS_CS_NO_RETRANS_TIMEOUT is forced and
connection is ESTABLISHED, task will never be retransmitted.
This cause procedures waiting on this file hang forever.
I know using "umount -f " to kill rpc task works. And the key to the
problem most likely lies in the network layer. But should nfs retransmit
it after waiting for so long?

Wish for reply. Thanks

Zhangjian


