Return-Path: <linux-nfs+bounces-3569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C08FD19B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AAC2815F7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D7D51C;
	Wed,  5 Jun 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astro.su.se header.i=@astro.su.se header.b="j6yrkPmc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-prod-route09.it.su.se (mail-prod-route09.it.su.se [77.238.37.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E44642D
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.37.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601311; cv=none; b=FyXtv34rGxY2tOgb0InxUizivx+BBcBgOs7m6YVi+Re8V9+k0I2N2lBr/7xxGFnLiYb+M3Uu0PDbyAXu1oDXaUOeJ8guJ8MXueazAaaZtxGNyZqApu5da1mxOu1kiHWS5YzG3Bnpyu0sS6H/bCcTyZXTZMNKo17VL+pZfY2VHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601311; c=relaxed/simple;
	bh=ky+DR9D5U4OB3BhsOl/ExlX3bUDhf9lVSSWx2x9Fz7Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sg/tUBJfsHjscSE7bf33f7KgKzi+Fs+VUPm3C02i6w2yYaNigjSZl5ynYUiw2btmaRfw5fwnYAnfJbbe7OAfW19sfJ6cfThIEIlHBP0aACjuBB3dZ/YcqIXkPI3y628Ns6m+P/ioJavpZvTql7pEq34ORowOdlnf2Fo5Uh4inSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astro.su.se; spf=pass smtp.mailfrom=astro.su.se; dkim=pass (2048-bit key) header.d=astro.su.se header.i=@astro.su.se header.b=j6yrkPmc; arc=none smtp.client-ip=77.238.37.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=astro.su.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astro.su.se
Received: from mailfilter-ng-1.sunet.se (mailfilter-ng-1.sunet.se [192.36.171.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail-prod-route09.it.su.se (Postfix) with ESMTPS id 4VvWN017fbz10q
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 17:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=astro.su.se; s=halonv1;
	h=content-type:mime-version:message-id:subject:to:from:date:from;
	bh=5d/pjiFMHHkwKOyyLqyyN1VxibIHz8MK/dmBFyQGSPs=;
	b=j6yrkPmcq/C/Ya9CeRj+DOvH7WwkHrly6Q7HhG7nrRKPI1nKAYwLXKpTNr3hn9NcdMHYptabiI+d1
	 OypGXoigcPY4KkzloQ4e7ajePI6ce2cDXaTqYgOM7qzxHTjgeeA8re0nCLdN0ECHnUbYHLGtd27ez3
	 0Bt15eWK3RA2d/b2xqPybCydZ2AUpyepN+twBt+U5aPsXJeBvFDgCIKV8Qg0+zSlZT5VZnJ3MtNNUt
	 ytThig92zaxuTS+vG+dFiJx6pqx1MVKJU3rTYP13QEWL1RaV8w1N+XlFeDt/ZiBLCbQYxuM/4S3iwa
	 WNEZoTRq8aQUjjDLbbMme+NZFivLzjw==
X-Halon-ID: ffc19ed0-234e-11ef-9819-0050569a42e2
Received: from smtp.su.se (mail-prod-smtp01.it.su.se [130.237.181.91])
	by mailfilter-ng-1.sunet.se (Halon) with ESMTPS
	id ffc19ed0-234e-11ef-9819-0050569a42e2;
	Wed, 05 Jun 2024 15:19:27 +0000 (UTC)
Received: from duamutef.astro.su.se (duamutef.astro.su.se [130.237.166.114])
	by smtp.su.se (Postfix) with ESMTPS id 4VvWMz4zBSz17x
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 17:19:27 +0200 (CEST)
Received: by duamutef.astro.su.se (Postfix, from userid 1014)
	id 64FFA5D93; Wed,  5 Jun 2024 17:19:27 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:19:27 +0200
From: Sergio Gelato <sergio.gelato@astro.su.se>
To: linux-nfs@vger.kernel.org
Subject: rpc.idmapd runs out of file descriptors
Message-ID: <ZmCB_zqdu2cynJ1M@astro.su.se>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fWu1xATJOHaVe+Hh"
Content-Disposition: inline


--fWu1xATJOHaVe+Hh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Observed on Debian 12 (nfs-utils 2.6.2):

May 28 09:40:25 HOSTNAME rpc.idmapd[3602614]: dirscancb: scandir(/run/rpc_pipefs/nfs): Too many open files
[repeated multiple times]

Investigation with lsof on one of the affected systems shows that file desciptors are not being closed:

[...]
rpc.idmap 675 root  126r      DIR               0,40        0      10813 /run/rpc_pipefs/nfs/clnt11e6 (deleted)
rpc.idmap 675 root  127u     FIFO               0,40      0t0      10817 /run/rpc_pipefs/nfs/clnt11e6/idmap (deleted)
rpc.idmap 675 root  128r      DIR               0,40        0      10834 /run/rpc_pipefs/nfs/clnt11ef (deleted)
rpc.idmap 675 root  129u     FIFO               0,40      0t0      10838 /run/rpc_pipefs/nfs/clnt11ef/idmap (deleted)
rpc.idmap 675 root  130r      DIR               0,40        0      10855 /run/rpc_pipefs/nfs/clnt11f8 (deleted)
rpc.idmap 675 root  131u     FIFO               0,40      0t0      10859 /run/rpc_pipefs/nfs/clnt11f8/idmap (deleted)

Raising the verbosity level to 3 results in no "Stale client:" lines.
strace shows no close() calls other than for the /run/rpc_pipefs/nfs directory.

I believe this is because in dirscancb() the loop is exited prematurely
the first time nfsopen() returns -1, preventing later entries in the queue
from being reaped. I've tested the patch below, which seems indeed to cure
the problem. The bug appears to be still unfixed in the current master branch.

--fWu1xATJOHaVe+Hh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0013-rpc.idmapd-nfsopen-failures-should-not-be-fatal.patch"

From: Sergio Gelato <Sergio.Gelato@astro.su.se>
Date: Tue, 4 Jun 2024 16:02:59 +0200
Subject: rpc.idmapd: nfsopen() failures should not be fatal

dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
Some of these directories contain /idmap files, others don't. nfsopen()
returns -1 for the latter; we then want to skip the directory, not abort
the entire scan.
---
 utils/idmapd/idmapd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index e79c124..f3c540d 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
 			if (nfsopen(ic) == -1) {
 				close(ic->ic_dirfd);
 				free(ic);
-				goto out;
+				continue;
 			}
 
 			if (verbose > 2)

--fWu1xATJOHaVe+Hh--

