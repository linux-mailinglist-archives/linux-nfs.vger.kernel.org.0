Return-Path: <linux-nfs+bounces-23311-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9/UkKvj2VWoyxAAAu9opvQ
	(envelope-from <linux-nfs+bounces-23311-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 10:44:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2997528A4
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 10:44:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=Utf51hUD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23311-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23311-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 650063006231
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A141DEDD;
	Tue, 14 Jul 2026 08:43:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C083FBED8
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 08:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018595; cv=none; b=U+UDHittmUjvtrzF9a6BzZr/ZU//NC3pLmrWHXmofW2PozZA0sP1QXE62g2bxDknXGoi19uGsferFz8jHEdqaQ68ZDAQCAlvQ4W9JKgGn6BGdy0TMBGYV3xAqRQFmPfcbX9qo5N4UTgMUpZce9sEC1EKocbXX334oTR53N5SQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018595; c=relaxed/simple;
	bh=ly7bQ4BAnAOC8P9fjgAl9GIS2fX6P0BTqvr7CwPzgS0=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=nBVYzed2MMbb+Y7m1yc4lCuXakfi+VP/sGTRigLafl+NYdBuERubgQtvxCWD+k4qjvJAkproH6thFlXQv3SxYQxgABufQWgdj6WI5Kk0Y6+t9mJSHeJYF20yBeqL6MIQm+/wHbIItqvk/3GRL89h0WmXEMLoQkNk3FsP9pU3BFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Utf51hUD; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sUKQH4VdGipxeXjGUWsLEH0zhGUCBwnfMjsCPjNx1EE=;
	b=Utf51hUDz+WQ9d29LQZ4k3Ycp9Uym5CLgesz8TbAVCjDVOabOGx9y3aupiq4wT83JcFu0Ca5x
	pvI10KwSujLDe0uQIixcIGIfSPL19FeW5Cn06XR/59G0+e6l3YnbE6K9qKLt0omc8QmECQCGkUd
	dT4NbhQC4TyMf/K9LDrMbJY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gzsz94Djpz1T4HL;
	Tue, 14 Jul 2026 16:33:57 +0800 (CST)
Received: from dggpemr100013.china.huawei.com (unknown [7.185.36.198])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE1740579;
	Tue, 14 Jul 2026 16:43:06 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 dggpemr100013.china.huawei.com (7.185.36.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 16:43:06 +0800
Message-ID: <356736aa-25d8-4b79-a50f-33b4e7035856@huawei.com>
Date: Tue, 14 Jul 2026 16:43:05 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "zhangjian (CG)" <zhangjian496@huawei.com>
To: <steved@redhat.com>, <chuck.lever@oracle.com>
CC: <linux-nfs@vger.kernel.org>
Subject: nfsd: fix memory overflow for haddr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr100013.china.huawei.com (7.185.36.198)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23311-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhangjian496@huawei.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:chuck.lever@oracle.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian496@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2997528A4

when hcounter is not 0, haddr memory is not enough.
asan report heap-buffer-overflow error in following scene:
CFLAGS="-fsanitize=address -g" ./configure && make
./utils/nfsd/nfsd -H 192.168.1.1 -H 192.168.1.2

Signed-off-by: zhangjian <zhangjian496@huawei.com>
---
 utils/nfsd/nfsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index c95d32f4..e3fcdde4 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -185,7 +185,7 @@ main(int argc, char **argv)
 				hcounter = 0;
 			}
 			if (hcounter) {
-				haddr = realloc(haddr, sizeof(char*) * hcounter+1);
+				haddr = realloc(haddr, sizeof(char*) * (hcounter+1));
 				if(!haddr) {
 					fprintf(stderr, "%s: unable to allocate "
 							"memory.\n", progname);
-- 
2.33.0


