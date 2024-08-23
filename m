Return-Path: <linux-nfs+bounces-5597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EC95C25A
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 02:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD941C21E10
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 00:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685BAD59;
	Fri, 23 Aug 2024 00:23:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5FB679
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372618; cv=none; b=jRrzsACtVcGlQYx6VTU/V2WxfnF2LV6ENKJ9pVoUD4PBZ+5MexfI4gW4Kk4Yn8sOXD4J/bXqRdqZWQm9nE0ozV0OhWDpsBYq7sJz1t8zwr3WHZXTcAXkgFN7L84Et6oKrpTWDPa5lbuGJRxeGbcP3DI7+KgVVwkdnXSg/apA23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372618; c=relaxed/simple;
	bh=PZXMezTF7B0uupmNARSNJp0rATFdjCP8Zcqf37PQ4zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa9EHW2I9SphVwJxohzZSHO1gcdw9dRbNTPdYfb9HLRjeUovvMoYIk5YWI0+YkZ49Aa9AkPlGt3SpTcn4U+iG8GDWnBAnznaW1PWmBGym+BUeZ+h+jvymPfZG1w+xf38aGNoo/iv73v44gJgnfb+Q0K5PsgUGAa3bjHjQxNOF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D24E20274;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 088CB13A3A;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KH8+AYbWx2bwBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 00:23:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	Josue Ortega <josue@debian.org>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>
Subject: [PATCH rpcbind 1/4] systemd/rpcbind.service.in: Add few default EnvironmentFile
Date: Fri, 23 Aug 2024 02:23:19 +0200
Message-ID: <20240823002322.1203466-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823002322.1203466-1-pvorel@suse.cz>
References: <20240823002322.1203466-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 3D24E20274
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Add some defaults so that distros can drop patches to configure it.

* openSUSE and Fedora use /etc/sysconfig/rpcbind
https://build.opensuse.org/projects/network/packages/rpcbind/files/0001-systemd-unit-files.patch?expand=1
https://src.fedoraproject.org/rpms/rpcbind/blob/f41/f/rpcbind-0.2.3-systemd-envfile.patch

* Debian uses /etc/rpcbind.conf and /etc/default/rpcbind
https://salsa.debian.org/debian/rpcbind/-/blob/buster/debian/rpcbind.service?ref_type=heads

Add all these 3 in order:
* /etc/rpcbind.conf
* /etc/default/rpcbind
* /etc/sysconfig/rpcbind

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 systemd/rpcbind.service.in | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
index c892ca8..c5bbd5e 100644
--- a/systemd/rpcbind.service.in
+++ b/systemd/rpcbind.service.in
@@ -12,6 +12,9 @@ Wants=rpcbind.target
 [Service]
 Type=notify
 # distro can provide a drop-in adding EnvironmentFile=-/??? if needed.
+EnvironmentFile=-/etc/rpcbind.conf
+EnvironmentFile=-/etc/default/rpcbind
+EnvironmentFile=-/etc/sysconfig/rpcbind
 ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS @warmstarts_opt@ -f
 
 [Install]
-- 
2.45.2


