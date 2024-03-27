Return-Path: <linux-nfs+bounces-2488-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37E88D782
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 08:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C8D29A1F2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5312C1B6;
	Wed, 27 Mar 2024 07:41:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B12C1A2;
	Wed, 27 Mar 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525299; cv=none; b=uRP+NNLYWM9mUnOc0AhK8hRMi3lp1op4ylicnuvWp7w/BEzdPNE51Z6rsvXKUAZaqiXQ6IKLzP+mUZIDE2u7dW/E2xVjiyQWqKqxt+iW3u/4OmebwSNB98Qxaeza1fN7VpIoz9fFYcZqBAjTEm67i2sMRAj3qDFwhuEqbSlACwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525299; c=relaxed/simple;
	bh=WEZbm4Q05nrIoUPa93HT1baOMt9IyxBknCAiOcLJqc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tSviREG1O217XV08EvjgjTPV/nILzmrgNtRMU2K6dYsBUmu/syNwWuMp09GRcKb8Rx6EewFh4SGzY9y7NduGzpmcMn1L2KZFihPdDF5V/GD5ZqwQwdbTmFgelWIzzR8g91cTO8wfI4Olb2obxK2rhiAymJiQf1hg8l6flZwRnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 DFB3A364686B451CA267CD06A10D08A9; Wed, 27 Mar 2024 14:11:02 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,Anna Schumaker <anna@kernel.org>,Chuck Lever <chuck.lever@oracle.com>,Jeff Layton <jlayton@kernel.org>,Neil Brown <neilb@suse.de>,Olga Kornievskaia <kolga@netapp.com>,Dai Ngo <Dai.Ngo@oracle.com>,Tom Talpey <tom@talpey.com>,"David S. Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@google.com>,Jakub Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,<linux-nfs@vger.kernel.org>,<netdev@vger.kernel.org>,<linux-kernel@vger.kernel.org>,<lvc-project@linuxtesting.org>
Subject: [PATCH] sunrpc: removed redundant procp check
Date: Wed, 27 Mar 2024 14:10:44 +0700
Message-ID: <20240327071044.365284-1-aaprelkov@usergate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: BCE3BE4874C140DD802FC89A20BCC59A
X-MailFileId: CE9AECCD9CD84540A70607A1150C868E

since vs_proc pointer is dereferenced before getting it's address there's
no need to check for NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8e5b67731d08 ("SUNRPC: Add a callback to initialise server requests")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
 net/sunrpc/svc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b33e429336fb..2b4b1276d4e8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1265,8 +1265,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argzero);
-- 
2.34.1


