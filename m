Return-Path: <linux-nfs+bounces-1992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118A857DFF
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483951F25968
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2FE12BF0B;
	Fri, 16 Feb 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="UG3raTfE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A612BEB8;
	Fri, 16 Feb 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091193; cv=none; b=g3thNDvllvJ3sKEjfeLFXlWTLz2HsqVUFoV6NC+ZOtJruMmEjSx9tQBR3T+edAQrwLQMM0d6rtQFznWOvlEYPCW0il1qo1LXO6L3axLL4rsHlUO59f8bLpPHWIMjS/ZxkG47FluujbCGLOkvugcc6zQcWVvbrZlMlO7L8XpMo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091193; c=relaxed/simple;
	bh=yvpJWuM60ZPIcyXXM0SB7Q+oj//ZjvAfrXM/VqE+HUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzyVYmZQNH2/10RJTkoUWskFSFA/ZI3sR/uW43GXweMQky/3l5Xd/+pkR/xzEkeuQ160xMljx3qweLq2xtKzTPKsaxbKJx4rJQYe3AjytVSqKbopnlJ0qMZOS5HYwf582mA3jd+n77wrrBsz69Aou7FKo3dsWbs9ByjbP+1I2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=UG3raTfE; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id DD0DCCFEFE864;
	Fri, 16 Feb 2024 16:46:23 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id leNxKGuf2m42; Fri, 16 Feb 2024 16:46:23 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id AEC77CFEFE867;
	Fri, 16 Feb 2024 16:46:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru AEC77CFEFE867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1708091183;
	bh=qPIBi6C+A8vJ3oyRznET/i8fe773IKKnMw8e+TueiO0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=UG3raTfEkdR2YHFEaBj4ZpgMn2S7qe6nkNs2LcVRPyWWWJcrusj15hZbMNIFA3fsY
	 0tncMFqDBQjyFxzgSnCLsprNtLtAN1Sx/zk5mtwz0mPBKAgB55cDUlcxkXGagIAZMv
	 SR1r3Wkr8avxvwuRrKeHl/f/qTWwg3YOTuvyE40lPqaU26oq/YiX5v0e6aOaxH1qu2
	 kVoz+bYDyX9PiuhicXEp0/iqgxE/p9e2rBs3VXsKDB0my4z3oZmicHnzBHvUzNpGsD
	 E8DNAQNKAd8VfnCusP7va9Jx7Hv3llXF50fN3MDXcr9NerRfWX5jmhc2Olf+ZVM7ij
	 vwCCSkH4V7gaA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C84PylsAgnwt; Fri, 16 Feb 2024 16:46:23 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 4B700CFEFE864;
	Fri, 16 Feb 2024 16:46:23 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: huck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfsd: fix memory leak in __cld_pipe_inprogress_downcall()
Date: Fri, 16 Feb 2024 16:45:41 +0300
Message-Id: <20240216134541.31577-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dynamic memory, referenced by 'princhash.data' and 'name.data',=20
is allocated by calling function 'memdup_user' and lost=20
at __cld_pipe_inprogress_downcall() function return

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 11a60d159259 ("nfsd: add a "GetVersion" upcall for nfsdcld")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 fs/nfsd/nfs4recover.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2c060e0b1604..02663484782d 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -850,6 +850,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
 			kfree(princhash.data);
 			return -EFAULT;
 		}
+		kfree(name.data);
+		kfree(princhash.data);
 		return nn->client_tracking_ops->msglen;
 	}
 	return -EFAULT;
--=20
2.25.1


