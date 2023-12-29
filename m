Return-Path: <linux-nfs+bounces-832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D824481FF76
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Dec 2023 13:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154061C20E78
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Dec 2023 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E11111A2;
	Fri, 29 Dec 2023 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cI0HlUwP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438910A24;
	Fri, 29 Dec 2023 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703853909; x=1704458709; i=markus.elfring@web.de;
	bh=2doc9tGjsfe7edwhPQC4ZU47xXYbFltN+jMs52TiMR8=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=cI0HlUwPQrZ4tA+iBLetN47oW3FeYGHfoEFunTLCwjxn424cn8PudYBzWvjmn0lm
	 77rMZLtgod9cAoRyO7nR/8B8ln+YXaye7LN04bI0vBpm1z2hj+05wRfv1czQwhZ6x
	 KpsXPTGi9dOaaoeZSjV1yhUu7ApCkClfzzRZK+MuCy2XWRbPWCrSQrMMTNCIFKUwS
	 jHIID4ohLGA0LR4TWv/v9GpsElevTVmjTTW4d8mmXyhW4yG50eBYbt1xxWYMYmMLz
	 uv1I+pH4r03+k3r0Nn/gTPuFCWesBojqgLaEFsolsGFWclPXUZAt0/uFb7jG2bhsF
	 nyQBntz+MRgoCi6qVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1rAZHg1H2f-00zcWB; Fri, 29
 Dec 2023 13:45:09 +0100
Message-ID: <bbf26021-798a-41a7-840e-62c8d383bb93@web.de>
Date: Fri, 29 Dec 2023 13:45:06 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] rpc_pipefs: Replace one label in bl_resolve_deviceid()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mzRfjuPlxk5vnDVMY1zbfyGBw2FMtZ8FjuEciWqcOhd2mAzhsR3
 32CPXaA32iHm7eADhE55jAoL8I9LZn/zgiWIom9+T/i7xy6rZg68GVJkg9MCIJ9gUIiaTaV
 9JNvGUHiiDbBhjNnsubnKOCxOFFuAZrb50D3IYBCLWctSAZojveQfL6KcXsZ9dFzSVLUYYS
 yf6EBJHqp2/QdtqzVsgeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qk1wAC/EVyA=;QgxENkvTw9f67KNy9dBqhxqTxae
 InW4/60sWTufBIVY95K8s+hZyRHwyH+CWQWq+HZz+DtZuvtT8gQZ5B/4o+G2D5oBh6es8LJR0
 PzByYQ0oRiDHjz88YbwOJ8aq5xsQNtJ4BP/WhDmNOe14lbLsL0JgyHGNs+PJqAcvATiwyA6qO
 kSqYH+cYTzwVnzJgKtb2OoXOHVvIbR8MI8nCL9j3jTJKvecNqFICGdUwGW1AXG+m3wcwBsfI8
 aCTXDopKSS4armUoyJRfrEcSr2CLYXMT7SiO1TyErgS6pmrYCHljh4b9B6k3/cIkPqKnV+6pJ
 DzG56g3il8tSmx/n5EbE6cwt0YnyeXP5qpogvSKwdM3KiN+ixGZRprTLXj3jm4vk8w7ZnLi3G
 ewPhfKqlq/lsdbhknG1JV6NVCbzDXPstZnIF0gVB8slkXwfCGw1NOXP4ktSKpp5SenDMY0Vwe
 8V0GYluJDQzNSMp9eZ6j9fHBwNxAxInKIKc459IG1hZV2CYGMnMw1rgipTF8pA/F9pTZQ8TPQ
 g7PFmuHOqouWZAnhXN1ryrjhbcsgLFwOf0Z8Gc1OEBHcBk9LGuFspjJpO+h4nE7UKGxEWPD5W
 DPeWnnLOpDIDuRRbmTwoVKVO18yXQjXoUKTh/B9/8ajzeZluLpkSPz0MO2Z4citqgI4mab/Wi
 2n1+W4Dm6YiN89qpOdCMQ4pOoqwDrKxyGATPxvu3IbQbN2yzVhiS11zQdYrwYBZnbbVmnoCCc
 OAhxrSJkg45QP/eK+EHkZQdWaOsYxK4pfiOCVHSoyjJQW2f/VK6tYupoUYNfx4qFvDmAUorcz
 b8oSt7e+nuGUB9HlvFu+ngZiNxSedmUFK2uhcbDiDnb9j9Ywll6JO4eevAQoQ4ExqeK3Id68J
 rkg4SHhFcNWtAggKBfkMrZKDMWIxJHVF6iDL5xPUWhqGCer9zTVO1NYo+Dw/9fHZpozA/wdgr
 XPLEJw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 13:18:56 +0100

The kfree() function was called in one case by
the bl_resolve_deviceid() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use an other label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/blocklayout/rpc_pipefs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipe=
fs.c
index 6c977288cc28..d8d50a88de04 100644
=2D-- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -75,7 +75,7 @@ bl_resolve_deviceid(struct nfs_server *server, struct pn=
fs_block_volume *b,
 	msg->len =3D sizeof(*bl_msg) + b->simple.len;
 	msg->data =3D kzalloc(msg->len, gfp_mask);
 	if (!msg->data)
-		goto out_free_data;
+		goto out_unlock;

 	bl_msg =3D msg->data;
 	bl_msg->type =3D BL_DEVICE_MOUNT;
=2D-
2.43.0


