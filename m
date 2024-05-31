Return-Path: <linux-nfs+bounces-3499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FC8D56B9
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 02:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947EC1C232E6
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4E7FF;
	Fri, 31 May 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="erRYXkkb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0752360;
	Fri, 31 May 2024 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114128; cv=none; b=gvqAifcBvoEUPzE5ZMkRImSGWftR43xevamIIQZ6jrYjqcUc1lSEJvyN5y064o+SAZ/MhS/KaHsnN4ms4breXimzZjRecAm9vUIk71HZPmww0Fd9fg+z0P188db0pp5+f3vVq57tShQ6UKaQlhkLgRFVlu7TREkxmpt06oIhMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114128; c=relaxed/simple;
	bh=YgrOCnw9ulU1r5JRbR7huVDAJo7JVb467/iuMszP/TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVvScX+0pAZ9i/sUNtoMlfBsLtFUYKrQateNp1JiltYyxWM5CZPNuN0C4UvrJGX9c2UudEqBlITZeAxq20P8xxW+vGTf7YWfQ+cxJv+x9WFe4EL4u6AB2M05LmaKrsz4p3JpujS6fhzlK69zIFKZn/57wSJ6HiiGvmwClSVI+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=erRYXkkb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=97Q9L64/KA5ybq/2GVgSFqmJYcC431bTwH2MKuPsTpM=; b=erRYXkkbbK51z6MK
	WVhE+FC9GG1FGmcCzQzzpCRhm5lj4E1j63nyp1z5W5k1wCvP6biEzZfYxjDzIUK9FEd84us5PHt8C
	O4Qwe7lOoDAiX7/tb/bS86q3FXWRzMS+ozuC3J4fYv1x97URl2v5n2q/oFdjPW7ii+jH+7lks9o2K
	HhsatfN2RAB6sRZVs3xtXiKqwx5CcY+mo64f/JtbjjuDRQHpWPVGhHlmciQkO3BEbzM2j/onKwTfX
	P1l76MRBkuEcBjIlnhz63eshPRXMwcNguwYaV7CCSkdoNNmplJql2qNmS8K/MPFRCFHLCIUHqLFWf
	WElnMcnNiCK7qtzyDw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCpp2-003T9n-0b;
	Fri, 31 May 2024 00:08:40 +0000
From: linux@treblig.org
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] NFSD: remove unused structs 'nfsd3_voidargs'
Date: Fri, 31 May 2024 01:08:38 +0100
Message-ID: <20240531000838.332082-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'nfsd3_voidargs' in nfs[23]acl.c is unused since
commit 788f7183fba8 ("NFSD: Add common helpers to decode void args and
encode void results").

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/nfsd/nfs2acl.c | 2 --
 fs/nfsd/nfs3acl.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 12b2b9bc07bf..4e3be7201b1c 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -308,8 +308,6 @@ static void nfsaclsvc_release_access(struct svc_rqst *rqstp)
 	fh_put(&resp->fh);
 }
 
-struct nfsd3_voidargs { int dummy; };
-
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 73adca47d373..5e34e98db969 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -221,8 +221,6 @@ static void nfs3svc_release_getacl(struct svc_rqst *rqstp)
 	posix_acl_release(resp->acl_default);
 }
 
-struct nfsd3_voidargs { int dummy; };
-
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
-- 
2.45.1


