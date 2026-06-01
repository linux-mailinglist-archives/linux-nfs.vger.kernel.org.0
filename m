Return-Path: <linux-nfs+bounces-22145-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEI0GJ0uHWo4WAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22145-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFF61A971
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB9D53008692
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFA3612E9;
	Mon,  1 Jun 2026 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ijEs6HjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqvkv9W5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C70331209;
	Mon,  1 Jun 2026 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297286; cv=none; b=idhhDvwrEPIT0hdFf1Y9aw99L2R5Y3uui1EOAoNedGjWjpowJ+puWqboaznhUMBsMOwuarLz/kIUR9Vqzfk7tQjfL10VeH0g9tUHxGN8xE9w0uRK4vvy06Z18EU24DJeRt4EgHz7snVTdwWDgXVTznWmSRCPuKCA48q6sj1Y8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297286; c=relaxed/simple;
	bh=ABOLkeRLy27cCGBUfp+fu/LC3lskhpYWtXvtw2QDu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuGd0LSk/yRtZMza+2FO5h2ewOfkzov05b5v3TcHnsxANREGZfnUiItPMt8stZaFUFCkP9eanA/5s6VoKeAWbdIjdfL3FWvqEEPCleN3fI+aFgL/cD3sOE2/HvvBjJt2Kn5Y4ssMkAHBumneqj6cFEHNIIj3RqhYiWgiFJ5apvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ijEs6HjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jqvkv9W5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D0681400065;
	Mon,  1 Jun 2026 03:01:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 01 Jun 2026 03:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1780297284;
	 x=1780383684; bh=c/7kgpRqV4M4nBRy7agIHBAjwLBs+T+zAEyrYZPkYV8=; b=
	ijEs6HjLEYg/5lS68EbqcjoAfwBzklctxQk16Jr6pTza1tth9tl30rXKZFv4MOK9
	ApVrq2tx1E0m1C/qY9KEO0dMu3j3KSH00n7PBfwF0Bi2ILkBE3A54u5qdc1HGbWN
	skJrb1m3FuUwh7xE502ZDhUe3oBSK3a67R0NvQHmmQehq2DYI76PBLfEjPhxwvLV
	FCAoHuM42sW55Njjx0K8Kv+huQ1bP1qVCOwwJPQpNPV3oW30Uzs+sivOROImvEo1
	ZDu2lCvvCVjEBDiKqavpmXHZ80Z8Pn9sbJsppYW4uLiQFrDMVoS/tSWU8SZSW7cG
	CyqZrxwSdxDSFBI2NBte+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780297284; x=1780383684; bh=c
	/7kgpRqV4M4nBRy7agIHBAjwLBs+T+zAEyrYZPkYV8=; b=jqvkv9W59k3TFE728
	SRUQe0kscc4s+isDghF1B85Y15K1o0emODh13rGx1UI8czzSgBm+1zvcoVNuTcOY
	uY9ZFJdogH13QUf03dgTpOsZSCqUIzgt04KFC5VMO3TVJjt5Rp7hefJCfMxPQHRj
	qlnuHUEwLyXefxz5G78kM+nYsAk8vBltYCnyl1fSOPTu7Jwna5VEGbPuuXtw2J5x
	wbIqWg7gUQeNLE+3W/JZuVl5L0v+rhUkrr6I78vxZtgzmd2lo5UrHar4xCVHBn/M
	k6yn6o3K30zhgcQPRPHKRkPQINltLFDb+yKhAdN4JGqDOpkP7CRZMeOgGQkxvltm
	jTVRA==
X-ME-Sender: <xms:RC4dao0tdKZ0dAYsc5KVGGdkyTZiCCYFc_S3qxpOqa_Zyg0admpW5A>
    <xme:RC4darQj0kYpNzh20Lhn5vOEJmeo6SqLcDudPByB-yzD9bHENi_O8PVpJM5dC30Kw
    R3IlIww_BlV2C53gZIDbMTMvGR_WWkzjUtb547zv3U3Tv5zYg>
X-ME-Received: <xmr:RC4daset936jWNlDeTZIEWdx5p54nct7xonKxyAVnYlxI5n02T3U02CQhsIfbXl1SlT5E_mOb7Wh1bB3TQgDJttE5UuzNcg>
X-ME-Proxy-Cause: dmFkZTFNn2voCuMJwaZn4mQi+8OwFwP8MbOGesQswPxVACwdUxRDwWa/f62FrT4OS5+etX
    lpbG0CyNEC5ZEzEebDdmEkKKuwA8JYmTcJZDLGOjQuIsuC+VlGFN4cDtTpsp4TJxEBMQJN
    5UaE10g4X93jUBy1AA+vqprc2pKvYMKhkYGmTUuEeZluqnZwRRSGljv9KpJxnsuimm38u7
    Jp9HDBymSY6zDSdT1QCsnlup35Rls5SW6aC9Hwu2QHQS3M6fNepFkcCA+NA6zsxp9+rhtV
    lYy3c44qrxynOl4BJrfimD+Q/JXYY7JxRkwisEy5dkxg8tlTtB+eaV0PCk5+Kq5N3tTrEB
    obM9nydVO4O0C7k3eg8ThWxlop289eJfsg2c1fuPH2Si2qQzh50qY0Rhqi6j1WLRQyFYQk
    kt1sqYes8wap+YDhNQhgbYHlQC+CRH1DhjXsfYfp/uZPDQIuq36/trjK5ipOB1ibElLSQ0
    9TLmyx9c0ekP3MsiDDL5ivxIUrIj+X4kM9cZ3M5GKdoZZhh4uL6Y6E/Apo70YD2xJodVug
    oydsMeecZseMGq4yxeCbN/HTZC1F8bkRwYPfcRF8ipX+SWEJnNfNDoM2K6ScfMNjoxausP
    79VhQEG3u/hRoVkdyjXuO5cGWUYI3GWNsfosMVvUL/4yl+nmKhLyFKz+s7rw
X-ME-Proxy: <xmx:RC4dasdNgr1sb9_Y2cgngU0PBToDoa4PmzRuZfwNQLbGBk3uninThA>
    <xmx:RC4dam0rHv-6uNJ6qoUzqavW1-oGQBfgZa_TwKZFyzMwZ0YbHRgIPg>
    <xmx:RC4dak8-PUDgJDJJ2f7xoHVGsdRuaC_JoVqd25KdrF9jBs2gTvaVMw>
    <xmx:RC4dar6crSITiC1-rURbPQOuv7uQVqZmwl69ikAuch0xSnkSMfaOzA>
    <xmx:RC4dapZyxAsxoJv5xMZ6KYpCZHkQDvdt4erX0bZFcQ6nvDMx07dzFSUD>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:01:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	"Jori Koolstra" <jkoolstra@xs4all.nl>,
	Benjamin Coddington <ben.coddington@hammerspace.com>,
	"Mateusz Guzik" <mjguzik@gmail.com>
Subject: [PATCH 05/18] VFS: dentry_create: always set FMODE_CREATE when file is created.
Date: Mon,  1 Jun 2026 16:37:53 +1000
Message-ID: <20260601070042.249432-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260601070042.249432-1-neilb@ownmail.net>
References: <20260601070042.249432-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22145-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: 8FEFF61A971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NeilBrown <neil@brown.name>

atomic_open() may or may not need to create the file, and sets
FMODE_CREATE to indicate that it has.  To allow the caller to know if
the file was actually created, set FMODE_CREATE in the vfs_create()
branch too.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index db3fddbccd21..e4f3c0d00c8c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5137,6 +5137,8 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
 		if (!error)
 			error = vfs_open(path, file);
+		if (!error)
+			file->f_mode |= FMODE_CREATED;
 	}
 	if (unlikely(error))
 		return ERR_PTR(error);
-- 
2.50.0.107.gf914562f5916.dirty


