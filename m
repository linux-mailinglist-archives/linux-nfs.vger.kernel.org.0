Return-Path: <linux-nfs+bounces-2078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85328866709
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3981C20958
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D362C1B94E;
	Sun, 25 Feb 2024 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5eX3yeC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="km57pojJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5eX3yeC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="km57pojJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398441B949
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905399; cv=none; b=Ajnv81Fye2mrg/VMmrs7iVyhbejQRUoAZlqv5nExdn8Z41WzUENQNknpRcguVIu6oxx03+POTPSgNg59N5fy0nQN46lRl39wMeDkZWinb6b7GZgFfKt5NU2cH+gzg93wWZd6udm+N9qEnVDA8zTmFOkPtup2an5qHfLOEWGWlmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905399; c=relaxed/simple;
	bh=M/4kDDiST2lZmUYfgNTrOfPi9g7fPcmK3pU4hesg4ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmahR53xXA51VN7WUfHHljCp5SC52bqRNqIBLnShRtmIp5I0B1Bc2g+OWzvaZqNo0Qmj2zChNeWgU8Wzb1tLr7yU62GC8n/P3w8RKyvzzeO6xUvqNPW0I236/B0g+FadQ2ojqiORafgmbgghqlqD3T1kMJHtVCuIFdsMfSDY5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5eX3yeC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=km57pojJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5eX3yeC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=km57pojJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DA8E224B0;
	Sun, 25 Feb 2024 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M/4kDDiST2lZmUYfgNTrOfPi9g7fPcmK3pU4hesg4ZY=;
	b=A5eX3yeCvttnBGnlzI0rdE1b+adZgcLMo1OLTjlNJ0fEmkYpf5xdrcOyKA8+wzjvN0USf2
	IrFWKdRJoIV4F11N+Iqmwed3fUsn1eowQNjJWb9i9htkrg0hnMXxFHpfh70VvYWeBpC3oY
	w50O/Nnh4C9GLw3w+n2zAygkv/ylD0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M/4kDDiST2lZmUYfgNTrOfPi9g7fPcmK3pU4hesg4ZY=;
	b=km57pojJerKzG2qDaamWDL00mcv7dYAPMZiK64DxwWx1aLfNSjJoi6VbJ5OT0NHnLmB2Sk
	dzMxP5kfbHd7YTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M/4kDDiST2lZmUYfgNTrOfPi9g7fPcmK3pU4hesg4ZY=;
	b=A5eX3yeCvttnBGnlzI0rdE1b+adZgcLMo1OLTjlNJ0fEmkYpf5xdrcOyKA8+wzjvN0USf2
	IrFWKdRJoIV4F11N+Iqmwed3fUsn1eowQNjJWb9i9htkrg0hnMXxFHpfh70VvYWeBpC3oY
	w50O/Nnh4C9GLw3w+n2zAygkv/ylD0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M/4kDDiST2lZmUYfgNTrOfPi9g7fPcmK3pU4hesg4ZY=;
	b=km57pojJerKzG2qDaamWDL00mcv7dYAPMZiK64DxwWx1aLfNSjJoi6VbJ5OT0NHnLmB2Sk
	dzMxP5kfbHd7YTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D83F013432;
	Sun, 25 Feb 2024 23:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q5nNHrLT22WcJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:56:34 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 0/4 rpcbind] Supprt abstract addresses and disable broadcast
Date: Mon, 26 Feb 2024 10:53:52 +1100
Message-ID: <20240225235628.12473-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.27%]
X-Spam-Flag: NO

The first two patches here I wrote some years ago but never posted - sorry.
The third and fourth allow rpcbind to work with an abstract AF_UNIX
address as preferentially used by recent kernels.

NeilBrown


 [PATCH 1/4] manpage: describe use of extra port for broadcast rpc
 [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
 [PATCH 3/4] Listen on an AF_UNIX abstract address if supported.
 [PATCH 4/4] rpcinfo: try connecting using abstract address.

