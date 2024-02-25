Return-Path: <linux-nfs+bounces-2077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A7862DE1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609ADB209E4
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE51B949;
	Sun, 25 Feb 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHC5CNIY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xgkCGI9g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHC5CNIY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xgkCGI9g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9E1367
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905019; cv=none; b=h6+NVHu1dyBGMqucKh+Z2Jx8ffXCiBJdcEzuRlu8XZEgTj/ZtCUkEATPwGsLmJ2hJWcrIGHV379Bm3PsJ//3xderr5+nqCghYrGGV+afcUsN2+62BEvAgyVYgOdJ2zWyGG6G9j/cq+nvahgjeY1irWQze4MUvR6sVE6T3iifi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905019; c=relaxed/simple;
	bh=a2ukon8as98OY6kkUNf+iFDpsqPm2C1npgZJNcf5NNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRbsxbDB9hX+KJyzoiDpKhrst9qZdT/oC9sK/HAP88rSLqxz4W31Mox8JeQqkUMwJUcrjCsw6QVSZexJuV9tjOZfDjvfiUsYA1m0o3nNh/L5CK1sbwJGwnV09gJl9SAyu93RC+oMGW4W8VVTf5aC4QuH9FNFda2tJQqLPEq7uFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHC5CNIY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xgkCGI9g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHC5CNIY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xgkCGI9g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 665DF1FB40;
	Sun, 25 Feb 2024 23:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a2ukon8as98OY6kkUNf+iFDpsqPm2C1npgZJNcf5NNE=;
	b=BHC5CNIYiFauih1GxmFi6pC4Mhir4wojOVXrDNjTt61uVLkdeUf3q5HemkO5SaFqAL8SZH
	ErUQxAyo178LVHuiA2nk6In4YY6b89d1K9KR/jVN8s7bwe/56iz81HEVho8L7fkOUvbKiM
	JmOSFymj2jX5JApTEeycWva0EsmhZ2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a2ukon8as98OY6kkUNf+iFDpsqPm2C1npgZJNcf5NNE=;
	b=xgkCGI9gTFL556742z5uwYXaEUkgwjDP4KRedbuybvljjBtvuoL3eiFJg4oKJi8LXiJSlZ
	swUrfrDI+X40oMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a2ukon8as98OY6kkUNf+iFDpsqPm2C1npgZJNcf5NNE=;
	b=BHC5CNIYiFauih1GxmFi6pC4Mhir4wojOVXrDNjTt61uVLkdeUf3q5HemkO5SaFqAL8SZH
	ErUQxAyo178LVHuiA2nk6In4YY6b89d1K9KR/jVN8s7bwe/56iz81HEVho8L7fkOUvbKiM
	JmOSFymj2jX5JApTEeycWva0EsmhZ2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a2ukon8as98OY6kkUNf+iFDpsqPm2C1npgZJNcf5NNE=;
	b=xgkCGI9gTFL556742z5uwYXaEUkgwjDP4KRedbuybvljjBtvuoL3eiFJg4oKJi8LXiJSlZ
	swUrfrDI+X40oMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFC7613A89;
	Sun, 25 Feb 2024 23:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y729G8LQ22U4JAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:44:02 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 0/3 libtirpc] Support abstract addresses for rpcbind in libtirpc
Date: Mon, 26 Feb 2024 10:40:47 +1100
Message-ID: <20240225234337.19744-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BHC5CNIY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xgkCGI9g
X-Spamd-Result: default: False [4.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.43)[78.51%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.26
X-Rspamd-Queue-Id: 665DF1FB40
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

I posted these patches in May 2023 at the same time as I posted patches
for the kernel to connect to an abstract address.
The kernel patches landed and I forgot to follow-up with these.
Thanks Petr for the reminder.

NeilBrown


 [PATCH 1/3] Allow working with abstract AF_UNIX addresses.
 [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
 [PATCH 3/3] Try using a new abstract address when connecting rpcbind

