Return-Path: <linux-nfs+bounces-1623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05626844301
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDCB27AC0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDE5A7A1;
	Wed, 31 Jan 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQWzk6mE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7RGb3no";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQWzk6mE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7RGb3no"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A284A25
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714104; cv=none; b=sOQoKcBIXhRzSA4AaVvgDkjnOS+LM3wFeneQuowWTSKZ5MtgPTrefBPupHoEOg8fuXKv2E7RMCHRuKBJka4BnIK14urBB632t5cHWgmODWmYU88hQltMzBqGBu5TezMtVA1tfRaaWLD7Omryt/PkGjqkslxAL/7JqO/kaajvdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714104; c=relaxed/simple;
	bh=SbXm8YYXrGnyobmk+Ux2Iy1lHWVo9SKdEU/qRVQrgzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+kSjzDI12pgACZPe0JZBdaCwT8SWXWfJ4Ggkm5e4IaWDXQSr5ax7h3NAUIlWaE4j+PyRMgtuOO1ehPD5+6zNaANW01zYpdGiiTBchvXlA8ImKK2aoO0190dXoRnP2I4o/J10ZWOHPQgLNASZeplUDDzSat0HcCFyx6znhYeZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQWzk6mE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7RGb3no; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQWzk6mE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7RGb3no; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2782221FFB;
	Wed, 31 Jan 2024 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WkEfZOFY5ds2ShYMovl2gWMwlK2KdP+TID0DbMohA8=;
	b=IQWzk6mEGmR77s1cu8kqhe/0m96ewlfmV0KR3ZNuM/8X0np7tceGoI9UCSoLzA6z7RJyNO
	l2M1dsAS+FVuQVRKSBzNcJvpduNbflghvmeW93dzJ3/lIOgk0C/1/AgkBVdE2wxV3PgsFw
	LlyIMNIqtbg/67IRXgfbY5NCMiG6NQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WkEfZOFY5ds2ShYMovl2gWMwlK2KdP+TID0DbMohA8=;
	b=d7RGb3noPCGB+PbOBooPngvk06SnPQC09GDpdqlzSRVMZaZCq3XTdqNKDEuWBH7JxpHhRo
	oG0UNt3kuK9D+1CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WkEfZOFY5ds2ShYMovl2gWMwlK2KdP+TID0DbMohA8=;
	b=IQWzk6mEGmR77s1cu8kqhe/0m96ewlfmV0KR3ZNuM/8X0np7tceGoI9UCSoLzA6z7RJyNO
	l2M1dsAS+FVuQVRKSBzNcJvpduNbflghvmeW93dzJ3/lIOgk0C/1/AgkBVdE2wxV3PgsFw
	LlyIMNIqtbg/67IRXgfbY5NCMiG6NQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WkEfZOFY5ds2ShYMovl2gWMwlK2KdP+TID0DbMohA8=;
	b=d7RGb3noPCGB+PbOBooPngvk06SnPQC09GDpdqlzSRVMZaZCq3XTdqNKDEuWBH7JxpHhRo
	oG0UNt3kuK9D+1CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE1EE139F5;
	Wed, 31 Jan 2024 15:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EBpoMfNjumWJeQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:14:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>,
	linux-nfs@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH 1/4 v2] runtest/net.nfs: Rename test names
Date: Wed, 31 Jan 2024 16:14:43 +0100
Message-ID: <20240131151446.936281-2-pvorel@suse.cz>
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
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IQWzk6mE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d7RGb3no
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
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
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 2782221FFB
X-Spam-Flag: NO

Test names weren't obvious, rename to be more descriptive.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NFS developers can ignore this patch (LTP specific).

changes v1->v2:
* Use simpler names (Martin's suggestion).

 runtest/net.nfs | 188 ++++++++++++++++++++++++------------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 3461807cf..463c95c37 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -2,107 +2,107 @@
 #
 # PLEASE READ THE README FILE network/README.md BEFORE RUNNING THESE.
 #
-nfs3_01 nfs01.sh -v 3 -t udp
-nfs3t_01 nfs01.sh -v 3 -t tcp
-nfs4_01 nfs01.sh -v 4 -t tcp
-nfs41_01 nfs01.sh -v 4.1 -t tcp
-nfs42_01 nfs01.sh -v 4.2 -t tcp
-nfs3_ipv6_01 nfs01.sh -6 -v 3 -t udp
-nfs3t_ipv6_01 nfs01.sh -6 -v 3 -t tcp
-nfs4_ipv6_01 nfs01.sh -6 -v 4 -t tcp
-nfs41_ipv6_01 nfs01.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_01 nfs01.sh -6 -v 4.2 -t tcp
+nfs01_v30_ip4u nfs01.sh -v 3 -t udp
+nfs01_v30_ip4t nfs01.sh -v 3 -t tcp
+nfs01_v40_ip4t nfs01.sh -v 4 -t tcp
+nfs01_v41_ip4t nfs01.sh -v 4.1 -t tcp
+nfs01_v42_ip4t nfs01.sh -v 4.2 -t tcp
+nfs01_v30_ip6u nfs01.sh -6 -v 3 -t udp
+nfs01_v30_ip6t nfs01.sh -6 -v 3 -t tcp
+nfs01_v40_ip6t nfs01.sh -6 -v 4 -t tcp
+nfs01_v41_ip6t nfs01.sh -6 -v 4.1 -t tcp
+nfs01_v42_ip6t nfs01.sh -6 -v 4.2 -t tcp
 
-nfs3_02 nfs02.sh -v 3 -t udp
-nfs3t_02 nfs02.sh -v 3 -t tcp
-nfs4_02 nfs02.sh -v 4 -t tcp
-nfs41_02 nfs02.sh -v 4.1 -t tcp
-nfs42_02 nfs02.sh -v 4.2 -t tcp
-nfs3_ipv6_02 nfs02.sh -6 -v 3 -t udp
-nfs3t_ipv6_02 nfs02.sh -6 -v 3 -t tcp
-nfs4_ipv6_02 nfs02.sh -6 -v 4 -t tcp
-nfs41_ipv6_02 nfs02.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_02 nfs02.sh -6 -v 4.2 -t tcp
+nfs02_v30_ip4u nfs02.sh -v 3 -t udp
+nfs02_v30_ip4t nfs02.sh -v 3 -t tcp
+nfs02_v40_ip4t nfs02.sh -v 4 -t tcp
+nfs02_v41_ip4t nfs02.sh -v 4.1 -t tcp
+nfs02_v42_ip4t nfs02.sh -v 4.2 -t tcp
+nfs02_v30_ip6u nfs02.sh -6 -v 3 -t udp
+nfs02_v30_ip6t nfs02.sh -6 -v 3 -t tcp
+nfs02_v40_ip6t nfs02.sh -6 -v 4 -t tcp
+nfs02_v41_ip6t nfs02.sh -6 -v 4.1 -t tcp
+nfs02_v42_ip6t nfs02.sh -6 -v 4.2 -t tcp
 
-nfs3_03 nfs03.sh -v 3 -t udp
-nfs3t_03 nfs03.sh -v 3 -t tcp
-nfs4_03 nfs03.sh -v 4 -t tcp
-nfs41_03 nfs03.sh -v 4.1 -t tcp
-nfs42_03 nfs03.sh -v 4.2 -t tcp
-nfs3_ipv6_03 nfs03.sh -6 -v 3 -t udp
-nfs3t_ipv6_03 nfs03.sh -6 -v 3 -t tcp
-nfs4_ipv6_03 nfs03.sh -6 -v 4 -t tcp
-nfs41_ipv6_03 nfs03.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_03 nfs03.sh -6 -v 4.2 -t tcp
+nfs03_v30_ip4u nfs03.sh -v 3 -t udp
+nfs03_v30_ip4t nfs03.sh -v 3 -t tcp
+nfs03_v40_ip4t nfs03.sh -v 4 -t tcp
+nfs03_v41_ip4t nfs03.sh -v 4.1 -t tcp
+nfs03_v42_ip4t nfs03.sh -v 4.2 -t tcp
+nfs03_v30_ip6u nfs03.sh -6 -v 3 -t udp
+nfs03_v30_ip6t nfs03.sh -6 -v 3 -t tcp
+nfs03_v40_ip6t nfs03.sh -6 -v 4 -t tcp
+nfs03_v41_ip6t nfs03.sh -6 -v 4.1 -t tcp
+nfs03_v42_ip6t nfs03.sh -6 -v 4.2 -t tcp
 
-nfs3_04 nfs04.sh -v 3 -t udp
-nfs3t_04 nfs04.sh -v 3 -t tcp
-nfs4_04 nfs04.sh -v 4 -t tcp
-nfs41_04 nfs04.sh -v 4.1 -t tcp
-nfs42_04 nfs04.sh -v 4.2 -t tcp
-nfs3_ipv6_04 nfs04.sh -6 -v 3 -t udp
-nfs3t_ipv6_04 nfs04.sh -6 -v 3 -t tcp
-nfs4_ipv6_04 nfs04.sh -6 -v 4 -t tcp
-nfs41_ipv6_04 nfs04.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_04 nfs04.sh -6 -v 4.2 -t tcp
+nfs04_v30_ip4u nfs04.sh -v 3 -t udp
+nfs04_v30_ip4t nfs04.sh -v 3 -t tcp
+nfs04_v40_ip4t nfs04.sh -v 4 -t tcp
+nfs04_v41_ip4t nfs04.sh -v 4.1 -t tcp
+nfs04_v42_ip4t nfs04.sh -v 4.2 -t tcp
+nfs04_v30_ip6u nfs04.sh -6 -v 3 -t udp
+nfs04_v30_ip6t nfs04.sh -6 -v 3 -t tcp
+nfs04_v40_ip6t nfs04.sh -6 -v 4 -t tcp
+nfs04_v41_ip6t nfs04.sh -6 -v 4.1 -t tcp
+nfs04_v42_ip6t nfs04.sh -6 -v 4.2 -t tcp
 
-nfs3_05 nfs05.sh -v 3 -t udp
-nfs3t_05 nfs05.sh -v 3 -t tcp
-nfs4_05 nfs05.sh -v 4 -t tcp
-nfs41_05 nfs05.sh -v 4.1 -t tcp
-nfs42_05 nfs05.sh -v 4.2 -t tcp
-nfs3_ipv6_05 nfs05.sh -6 -v 3 -t udp
-nfs3t_ipv6_05 nfs05.sh -6 -v 3 -t tcp
-nfs4_ipv6_05 nfs05.sh -6 -v 4 -t tcp
-nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
+nfs05_v30_ip4u nfs05.sh -v 3 -t udp
+nfs05_v30_ip4t nfs05.sh -v 3 -t tcp
+nfs05_v40_ip4t nfs05.sh -v 4 -t tcp
+nfs05_v41_ip4t nfs05.sh -v 4.1 -t tcp
+nfs05_v42_ip4t nfs05.sh -v 4.2 -t tcp
+nfs05_v30_ip6u nfs05.sh -6 -v 3 -t udp
+nfs05_v30_ip6t nfs05.sh -6 -v 3 -t tcp
+nfs05_v40_ip6t nfs05.sh -6 -v 4 -t tcp
+nfs05_v41_ip6t nfs05.sh -6 -v 4.1 -t tcp
+nfs05_v42_ip6t nfs05.sh -6 -v 4.2 -t tcp
 
-nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
-nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
-nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
+nfs06_vall_ip4t nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06_v4x_ip6t nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
-nfs3_07 nfs07.sh -v 3 -t udp
-nfs3t_07 nfs07.sh -v 3 -t tcp
-nfs4_07 nfs07.sh -v 4 -t tcp
-nfs41_07 nfs07.sh -v 4.1 -t tcp
-nfs42_07 nfs07.sh -v 4.2 -t tcp
-nfs3_ipv6_07 nfs07.sh -6 -v 3 -t udp
-nfs3t_ipv6_07 nfs07.sh -6 -v 3 -t tcp
-nfs4_ipv6_07 nfs07.sh -6 -v 4 -t tcp
-nfs41_ipv6_07 nfs07.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_07 nfs07.sh -6 -v 4.2 -t tcp
+nfs07_v30_ip4u nfs07.sh -v 3 -t udp
+nfs07_v30_ip4t nfs07.sh -v 3 -t tcp
+nfs07_v40_ip4t nfs07.sh -v 4 -t tcp
+nfs07_v41_ip4t nfs07.sh -v 4.1 -t tcp
+nfs07_v42_ip4t nfs07.sh -v 4.2 -t tcp
+nfs07_v30_ip6u nfs07.sh -6 -v 3 -t udp
+nfs07_v30_ip6t nfs07.sh -6 -v 3 -t tcp
+nfs07_v40_ip6t nfs07.sh -6 -v 4 -t tcp
+nfs07_v41_ip6t nfs07.sh -6 -v 4.1 -t tcp
+nfs07_v42_ip6t nfs07.sh -6 -v 4.2 -t tcp
 
-nfs3_08 nfs08.sh -v 3 -t udp
-nfs3t_08 nfs08.sh -v 3 -t tcp
-nfs4_08 nfs08.sh -v 4 -t tcp
-nfs41_08 nfs08.sh -v 4.1 -t tcp
-nfs42_08 nfs08.sh -v 4.2 -t tcp
-nfs3_ipv6_08 nfs08.sh -6 -v 3 -t udp
-nfs3t_ipv6_08 nfs08.sh -6 -v 3 -t tcp
-nfs4_ipv6_08 nfs08.sh -6 -v 4 -t tcp
-nfs41_ipv6_08 nfs08.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_08 nfs08.sh -6 -v 4.2 -t tcp
+nfs08_v30_ip4u nfs08.sh -v 3 -t udp
+nfs08_v30_ip4t nfs08.sh -v 3 -t tcp
+nfs08_v40_ip4t nfs08.sh -v 4 -t tcp
+nfs08_v41_ip4t nfs08.sh -v 4.1 -t tcp
+nfs08_v42_ip4t nfs08.sh -v 4.2 -t tcp
+nfs08_v30_ip6u nfs08.sh -6 -v 3 -t udp
+nfs08_v30_ip6t nfs08.sh -6 -v 3 -t tcp
+nfs08_v40_ip6t nfs08.sh -6 -v 4 -t tcp
+nfs08_v41_ip6t nfs08.sh -6 -v 4.1 -t tcp
+nfs08_v42_ip6t nfs08.sh -6 -v 4.2 -t tcp
 
-nfslock3_01 nfslock01.sh -v 3 -t udp
-nfslock3t_01 nfslock01.sh -v 3 -t tcp
-nfslock4_01 nfslock01.sh -v 4 -t tcp
-nfslock41_01 nfslock01.sh -v 4.1 -t tcp
-nfslock42_01 nfslock01.sh -v 4.2 -t tcp
-nfslock3_ipv6_01 nfslock01.sh -6 -v 3 -t udp
-nfslock3t_ipv6_01 nfslock01.sh -6 -v 3 -t tcp
-nfslock4_ipv6_01 nfslock01.sh -6 -v 4 -t tcp
-nfslock41_ipv6_01 nfslock01.sh -6 -v 4.1 -t tcp
-nfslock42_ipv6_01 nfslock01.sh -6 -v 4.2 -t tcp
+nfslock01_v30_ip4u nfslock01.sh -v 3 -t udp
+nfslock01_v30_ip4t nfslock01.sh -v 3 -t tcp
+nfslock01_v40_ip4t nfslock01.sh -v 4 -t tcp
+nfslock01_v41_ip4t nfslock01.sh -v 4.1 -t tcp
+nfslock01_v42_ip4t nfslock01.sh -v 4.2 -t tcp
+nfslock01_v30_ip6u nfslock01.sh -6 -v 3 -t udp
+nfslock01_v30_ip6t nfslock01.sh -6 -v 3 -t tcp
+nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
+nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
+nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp
 
-nfsstat3_01 nfsstat01.sh -v 3
+nfsstat01_v30 nfsstat01.sh -v 3
 
-nfsx3 fsx.sh -v 3 -t udp
-nfsx3t fsx.sh -v 3 -t tcp
-nfsx4 fsx.sh -v 4 -t tcp
-nfsx41 fsx.sh -v 4.1 -t tcp
-nfsx42 fsx.sh -v 4.2 -t tcp
-nfsx3_ipv6 fsx.sh -6 -v 3 -t udp
-nfsx3t_ipv6 fsx.sh -6 -v 3 -t tcp
-nfsx4_ipv6 fsx.sh -6 -v 4 -t tcp
-nfsx41_ipv6 fsx.sh -6 -v 4.1 -t tcp
-nfsx42_ipv6 fsx.sh -6 -v 4.2 -t tcp
+fsx_v30_ip4u fsx.sh -v 3 -t udp
+fsx_v30_ip4t fsx.sh -v 3 -t tcp
+fsx_v40_ip4t fsx.sh -v 4 -t tcp
+fsx_v41_ip4t fsx.sh -v 4.1 -t tcp
+fsx_v42_ip4t fsx.sh -v 4.2 -t tcp
+fsx_v30_ip6u fsx.sh -6 -v 3 -t udp
+fsx_v30_ip6t fsx.sh -6 -v 3 -t tcp
+fsx_v40_ip6t fsx.sh -6 -v 4 -t tcp
+fsx_v41_ip6t fsx.sh -6 -v 4.1 -t tcp
+fsx_v42_ip6t fsx.sh -6 -v 4.2 -t tcp
-- 
2.43.0


