Return-Path: <linux-nfs+bounces-1626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3B8442CB
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB71C21D92
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188E80C07;
	Wed, 31 Jan 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilnNwczO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PttOVIja";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilnNwczO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PttOVIja"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E084A48
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714105; cv=none; b=korpEclbjdrwA4ecXT+Cu7hZpp3+TFOUVRWVAXfKcjFrzUpSuGg10B+sA3IGt+OSaUv9DGWEMSRT9NvdU4/3ZlCSRJpxbhRPYSuTZPIWDA0Ejl0gENAkYg3VuAWwhERBY+jgZx124zVBrbgqK92yhzdbrSrTXSPuT+A3KhhmH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714105; c=relaxed/simple;
	bh=sNqsOFgXjLpDMBxDZxTZuBAwRphOAB57ww++y8kugCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tklJ1g65dEqVNOnyu3AGfxXRkwKasRMG0GZ4JOP13T3LGEfKgKZdwQQtlDYfxrl35HUCkoyuldcR15hkx5TkXO1d7PIDRmvtnGTjrV49ba80CedC07ur+1OeMHvge1EgugCSIIVDqVEdZSVtj8GqSDLHz4IX51PU5XGFS8bCHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilnNwczO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PttOVIja; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilnNwczO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PttOVIja; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA9CC1FB87;
	Wed, 31 Jan 2024 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAuhXawdoWTktAvjDe0rk2w8Lrgku5Y0TAar1HOcuyE=;
	b=ilnNwczOzX2HnjZZBxMayHnfmsRvR9DwIhvYmAvQPagZyBxhTo5hTqut1cOe/aryQ5b4j7
	46YPdVVirTVwqktzBg8BfgXYz95rYUGTuLnAlS+UrO51Po4i6lxwRz1hRL7vxefJFWteN4
	HMGaMePLW7zsRVAX2XjfRmTOv3zu56s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAuhXawdoWTktAvjDe0rk2w8Lrgku5Y0TAar1HOcuyE=;
	b=PttOVIjaS161Xk8Dj3DNKbh+uknCZors5RVXmZvGhhqT1hkWxhDq5Wek1i0UGqAnTp98q9
	I7nTFePfI/ODUIBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAuhXawdoWTktAvjDe0rk2w8Lrgku5Y0TAar1HOcuyE=;
	b=ilnNwczOzX2HnjZZBxMayHnfmsRvR9DwIhvYmAvQPagZyBxhTo5hTqut1cOe/aryQ5b4j7
	46YPdVVirTVwqktzBg8BfgXYz95rYUGTuLnAlS+UrO51Po4i6lxwRz1hRL7vxefJFWteN4
	HMGaMePLW7zsRVAX2XjfRmTOv3zu56s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAuhXawdoWTktAvjDe0rk2w8Lrgku5Y0TAar1HOcuyE=;
	b=PttOVIjaS161Xk8Dj3DNKbh+uknCZors5RVXmZvGhhqT1hkWxhDq5Wek1i0UGqAnTp98q9
	I7nTFePfI/ODUIBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2465F132FA;
	Wed, 31 Jan 2024 15:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MC1lBvVjumWJeQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:15:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH 4/4] nfsstat01.sh: Run on all NFS versions, TCP and UDP
Date: Wed, 31 Jan 2024 16:14:46 +0100
Message-ID: <20240131151446.936281-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131151446.936281-1-pvorel@suse.cz>
References: <20240131151446.936281-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ilnNwczO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PttOVIja
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.81%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: AA9CC1FB87
X-Spam-Flag: NO

Due fix in previous version we can run nfsstat01.sh on all NFS versions
(added NFSv4, NFSv4.1, NFSv4.2) and on TCP and UDP.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.nfs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 463c95c37..9c1c5c63e 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -94,7 +94,16 @@ nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
 nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
 nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp
 
-nfsstat01_v30 nfsstat01.sh -v 3
+nfsstat01_v30_ip4u nfsstat01.sh -v 3 -t udp
+nfsstat01_v30_ip4t nfsstat01.sh -v 3 -t tcp
+nfsstat01_v40_ip4t nfsstat01.sh -v 4 -t tcp
+nfsstat01_v41_ip4t nfsstat01.sh -v 4.1 -t tcp
+nfsstat01_v42_ip4t nfsstat01.sh -v 4.2 -t tcp
+nfsstat01_v30_ip6u nfsstat01.sh -6 -v 3 -t udp
+nfsstat01_v30_ip6t nfsstat01.sh -6 -v 3 -t tcp
+nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
+nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
+nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp
 
 fsx_v30_ip4u fsx.sh -v 3 -t udp
 fsx_v30_ip4t fsx.sh -v 3 -t tcp
-- 
2.43.0


