Return-Path: <linux-nfs+bounces-697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2D817D02
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C17C28542F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967A9740A2;
	Mon, 18 Dec 2023 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="IS5PK0Bo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AFF74E1A
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id AF5584C842
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 22:46:31 +0100 (CET)
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 161A12003F6;
	Mon, 18 Dec 2023 22:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YeUjgxtgDOYlUIHkPW4Med7YaP/UHtPOrtGztdaBZ3w=; b=IS5PK0BoJdaBiKD9k8p81wo6u3
	ke1+/2R5qYN1iny3NkiSA4b0jRc2YMr5aBfD/cEmiaLbc5lx4i0Gn9pHB3AtWkWUkTJgK2Qu3czCT
	bsDsUuqczgc6XL3mxPAhm4qywCYlSoay/jtyugtDxL5nkPxRFPq3F7FWW9awT19eH4+w=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1rFLRO-0057gv-1g;
	Mon, 18 Dec 2023 22:46:22 +0100
Date: Mon, 18 Dec 2023 22:46:22 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: SUNRPC: crash from svc_alloc_arg()
Message-ID: <ZYC9rsno8qYggVt9@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chuck,

I believe commit 5f7fc5d "SUNRPC: Resupply rq_pages from node-local memory" in
Linux 6.5+ is incorrect. It passes unconditionnaly rq_pool->sp_id as the NUMA
node.

While the comment in the svc_pool declaration in sunrpc/svc.h says that
sp_id is also the NUMA node id, it might not be the case if the svc is
created using svc_create_pooled(). svc_created_pooled() can use the
per-cpu pool mode therefore in this case sp_id would be the cpu id.

from __svc_create:
	for (i = 0; i < serv->sv_nrpools; i++) {
		struct svc_pool *pool = &serv->sv_pools[i];

		dprintk("svc: initialising pool %u for %s\n",
				i, serv->sv_name);

		pool->sp_id = i;

When using the cpu-mode, this triggers a BUG on my machine:
BUG: unable to handle page fault for address: 0000000000002088

 #7 [ffffafa3dc42fc90] asm_exc_page_fault at ffffffffa3e00bc7
    [exception RIP: __next_zones_zonelist+9]
    RIP: ffffffffa32fbbc9  RSP: ffffafa3dc42fd48  RFLAGS: 00010286
    RAX: 0000000000002080  RBX: 0000000000000000  RCX: ffff8ba5f22bafc0
    RDX: ffff8ba5f22bafc0  RSI: 0000000000000002  RDI: 0000000000002080
    RBP: ffffafa3dc42fdc0   R8: 0000000000002080   R9: ffff8ba62138c2d8
    R10: 0000000000000001  R11: 0000000000000000  R12: 0000000000000cc0
    R13: 0000000000000002  R14: 0000000000000000  R15: 0000000000000001
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffafa3dc42fd50] __alloc_pages at ffffffffa334c122
 #9 [ffffafa3dc42fdc8] __alloc_pages_bulk at ffffffffa334c519
#10 [ffffafa3dc42fe58] svc_alloc_arg at ffffffffc0afc0d7 [sunrpc]
#11 [ffffafa3dc42fea0] svc_recv at ffffffffc0afe08d [sunrpc]
#12 [ffffafa3dc42fec8] nfsd at ffffffffc0dec469 [nfsd]
#13 [ffffafa3dc42fee8] kthread at ffffffffa30e4826

I believe the fix is to expose svc_pool_map_get_node() and use that in
the alloc_pages_bulk_array_node() call in svx_xprt.c. Reverting 5f7fc5d
would obviously work as well.

The comment in svc.h should probably be updated as well since it's misleading.

I didn't provide a patch because I wasn't quite sure which approach you would
prefer but could provide one if that's helpful.

HTH

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>

