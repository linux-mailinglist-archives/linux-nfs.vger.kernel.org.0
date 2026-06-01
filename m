Return-Path: <linux-nfs+bounces-22140-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPIFFEQuHWqcWAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22140-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:01:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E04F61A8D8
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 09:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52D273001FD1
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB5B349CFA;
	Mon,  1 Jun 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VnggBfyR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRQyc7QF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA638331B;
	Mon,  1 Jun 2026 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297260; cv=none; b=XVEWEiYQGdWvjeZyImJRocFayZcjruQe2NvPhPWhOYeR4D2dLX+4fhL1VpbHCQAW20yyFRaF+QPTVjskm6DFUtF5b2pLxUvAVKUKEn09++qS5r9ocGP6eaE2FPazV185tD0NE70cLwioQglEY4Ry1oXbzauYXDsdWJzFc2w6+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297260; c=relaxed/simple;
	bh=HtEGur30ONjX0XCzmTkk9oiyMEz7flz5TOH5Gyb6Pq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tL22Azi+1vun24VXhwKIehNyqgra/lXZmD8WvkiqsJL8MvNxKi+QBGt0DdcdAnN6g+lLu+XgCWvnoOBJZiAigzqfFKdd2Byl5P0+ge5/4oxM984nqKmSF9zxl3aok/nn5fl7O9ylr/xE70e7vEO8GqXfN2D1i3Qf45ogrHfLvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VnggBfyR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRQyc7QF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CCCA2EC0204;
	Mon,  1 Jun 2026 03:00:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 03:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1780297257; x=1780383657; bh=9tZKCZ8wfP
	tQr3TpBjD57HRuQH1aHs7PpqT888yE79s=; b=VnggBfyRnGRV1+MNIp3+8rLlx8
	NaNURLoCwLMJKpuKhnHaurdZQLg/A9s/cZzhfGJ15VFyp/kzdiq2o5lzS2b8XpnW
	HuPcnmGBnNzSRfpNVRmplsv2FZRJECkK3su8l9NvmOEahbdwmCuh+4yTYID3bIk5
	A6UO+mgn6g+8ggrwqVhNy29AX3PBVaMSXyYkCH33lwHyFiuo+7XIasNFghFHzcs4
	mvfMLop1/doqaGFoOl7BG1TNCiB1Rhkv0enXfOWozRALckKvoVO+hmZ7kPpadHUl
	33kVqEDfFYlv+HEXn7dGVgrI/GG95pUfjO5d/1rxGiax3ZkTgakrYed2KbhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780297257; x=1780383657; bh=9tZKCZ8wfPtQr3TpBjD57HRuQH1a
	Hs7PpqT888yE79s=; b=lRQyc7QFXxKJwxS99E8EPJjkgA22LXi5+sranKdAWv1t
	HJQw4l7xTJQN5kOOi9moAmabT/RnmKHmD6cPJUQelhGMEyM/8Mpy5R6se5kv/RKc
	6/VfKz9hciLLNoqjcJYLtONuU4oSCBOYi459nJIh7Rz+oJYlzx0lRPyGC1nchlou
	sSrsV6Ve0uuiKypOXGwWV/H+hbsM8CK0ImBe9AoqHihNiIMP/rpVJBkm4ZgoWIqD
	68FVsqQnTnqvUJ6qghMK745ebHS9wXQiTKG0Re8+OEVkTJWB9wvXptHDR9Awu0RR
	+cu+aEn78DM+odI4nEDEP3VXVunngyi5iL1zVgFUnA==
X-ME-Sender: <xms:KC4datifj3Nxq9XmN8prymT6hBgZZXY_AVyQuWiSd7hLnS2S-ukduw>
    <xme:KC4daqMvVav6gKCN4P9L7_5C2gZlOEtBCpnqvawHMj1N4xU-KkbZcsU1_fIdKBhqH
    jQPgR6InlZUU6l23YpQZVF3lLvwHIMReueq-HOiRzNLsWrn4A>
X-ME-Received: <xmr:KC4daop80En2a5SNBWMBNT5fUnw4E8t2Q8oSaT3FCwfjmNRXZFi9xXBRrUEbxm_Io6lnZ89erbWTiWb1_2BFmVKeqF0DKGE>
X-ME-Proxy-Cause: dmFkZTGPlWyPr3JACsgWTzAlk0Do0GkMs63pD9gwNiu57SIDqFmwP8uqLy8lfN2N4bUknm
    NT4+ENlMpG1YeprdXON67irsEdiNKDjIecvaMvdPQCGF8W63txovNSmCT3WW3J3SRod2Xf
    KYG7VtXGXwDzOHyVNrY1ubibNIGwvxCRXTa2NXNj1VClqjZYs3Oam9LWwFtXboEzRZYOfe
    Hk9dYqkDdCf82KemBUTGrU1QXXxQXM45CCJv1MiO+upMqK8ciuXHBQVDKPmcgOZA2JYbdT
    CbEA+uf5zeT5z7rCeW9MRii/odNegrup6Ri4o75R4SkMeltVpNCjkOmKU8eCGEPLLMtHSK
    7VDXQQIMBrAg8T989nyrCYXfSUtLChvArvOUBt1JEqxjrGvdIDLLCVG20SNsIVwaJomI/d
    fkcaxvkV99f2uZIr/eD1+fgYfSRx8ATKakGEzNsy9x7ji/8ZvPBGBrtRCP+uv4RkbMfFwR
    4MrzcXbnyqslPoy7qOmOX5Q8Mw+wnHZjLeRxYgbg6VpCIJL3jgTavCFrwWd5nAPyzSdcax
    0YtESnRw9aZLvFlZXnKDYecU29sVgA8znsCBPMaQEuaNl0r98gZvFpiiiotVRwCdjDyNpI
    sXhAYSY7bKNaP3o2rMhGj9FPBHlQf0LpbybF0n2IG9jS8GA9SutT0pw2wfrQ
X-ME-Proxy: <xmx:KC4das6IWZsxxFS7-49DN_GPKPc8o6HuyRPIQ1zCIbnEMDWTV5oJ_g>
    <xmx:KC4damiXPk8lNY_tHTd74IV0Bws8afSKoVdiYm0ajqWfur4Kft-t_A>
    <xmx:KC4dai66crSevVyTb6aSsADvfs69xRlPyPxmmCGL389L91oBjzUeqA>
    <xmx:KC4darG0UT5AYcPzub1zoxEjG62ZmQzzdkGmUzckuz-dyTRWkVxNfw>
    <xmx:KS4dainBDkKjmXyMZ5JiLrAgW3OL88WIE2RD2WYig7qkcnzFrMgcTV2R>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 03:00:53 -0400 (EDT)
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
Subject: [PATCH/RFC 00/18] VFS/nfsd: replace dentry_create()
Date: Mon,  1 Jun 2026 16:37:48 +1000
Message-ID: <20260601070042.249432-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22140-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 6E04F61A8D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

My recent proposal for inverting the order between inode_lock() on a
parent dir and d_alloc_parallel()[1] missed that fact that atomic_open()
has two callers, and would have resulted in easy deadlocks from nfsd
when re-exporting and NFS filesystem.

I think the best way to fix this is to provide a richer interface for
nfsd to use, which includes all the locking as well as inode_operations
calls.  This allows the nfsd behaviour to share more code with the
system-call behaviour.

This series refactors code between lookup_open() and
open_last_lookups(), and uses the new lookup_open() to provide
vfs_lookup_open().  It then rearranges the code in nfsd so that it can
easily use vfs_lookup_open() instead of dentry_create().  Finally
dentry_create() is removed.

This series is based on a merge of nfsd-testing, vfs-next/work.dcache,
and vfs/vfs.fixes (though I can't see my "Fix possible failure to
unlock.."[2] patch in there yet).  So I probably will need to resubmit
after a bunch of that has hit mainline - though a few of the patches
could easily be cherry-picked now.

This will conflict with the O_CREAT|O_DIRECTORY work so obviously we'll need to
work out how to order them once we both have enough positive review.

All these patches are in github/neilbrown/linux in branch pdirops.
You can also preview the other stuff I need this for in pdirops-next.

Please review if you have time.

Thanks,
NeilBrown


[1] https://lore.kernel.org/all/20260312214330.3885211-1-neilb@ownmail.net/
[2] https://lore.kernel.org/all/177969022571.3379282.16448744624428323496@noble.neil.brown.name/

 [PATCH 01/18] VFS: move mnt_want_write() and locking into
 [PATCH 02/18] VFS: move delegated_inode retry loop into lookup_open()
 [PATCH 03/18] VFS: replace nameidata and open_flag args to
 [PATCH 04/18] VFS: add vfs_lookup_open()
 [PATCH 05/18] VFS: dentry_create: always set FMODE_CREATE when file
 [PATCH 06/18] nfsd: replace fh_fill_both_attrs() with
 [PATCH 07/18] nfsd: move fh_want_write() after preamble in
 [PATCH 08/18] nfsd: move more nfs-specific code into preamble of
 [PATCH 09/18] nfsd: remove subtlety from nfsd4_create_file()
 [PATCH 10/18] nfsd: in nfsd4_create_file() let VFS report if file was
 [PATCH 11/18] nfsd: nfsd4_create_file(): remove NFSD_MAY_CREATE
 [PATCH 12/18] nfsd: reduce range of directory lock in
 [PATCH 13/18] nfsd: open-code nfsd4_vfs_create() into
 [PATCH 14/18] nfsd: move some code out of the d_really_is_negative()
 [PATCH 15/18] nfsd: reduce want-write range in nfsd4_create_file(
 [PATCH 16/18] nfsd: switch nfsd4_create_file() to use
 [PATCH 17/18] nfsd: use vfs_lookup_open() for non-creating open
 [PATCH 18/18] VFS: remove dentry_create()

