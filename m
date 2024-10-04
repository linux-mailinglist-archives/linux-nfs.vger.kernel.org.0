Return-Path: <linux-nfs+bounces-6871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E299132B
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 01:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CA91C22CDA
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB890231C9A;
	Fri,  4 Oct 2024 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pJwIHT05";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JEPAD7cE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pJwIHT05";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JEPAD7cE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3814D299
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085085; cv=none; b=RM9x/P/JVAg08AmOCM00A5ax/QRm7eMycxL3ojWZQ+UKItOGnaYzOhrnwaCqBIUFai0cpmuaJxKR/gdALfpTBHZj98hdkr+s48JniBUVZKyIVD0Kx9gGpasy2Au6mV+cFVulpNJT4InCeAD6NgghqSZ6oYCplANs36ViFCI27Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085085; c=relaxed/simple;
	bh=hyBJo3UYlxE8GzlHLv21C0YPNkDcNgvoVas94mFzNsg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UMLMON8gRI6YzB2emPLWMrNUTwHtZNYBqxrSsNd8cEmNYFmOcjLaQW0TYatbfGvm6D9nQYKz/vYxake/eyZDrZlscggzSBJMJ2qy/tyNxNNwlD8fWPlJYUBT32bRW9nHk6qBVWaf4VRA/SxA4CVfrLwNRtJDkZV3m9oreSccdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pJwIHT05; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JEPAD7cE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pJwIHT05; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JEPAD7cE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C70DC1F7DC;
	Fri,  4 Oct 2024 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728085081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyBJo3UYlxE8GzlHLv21C0YPNkDcNgvoVas94mFzNsg=;
	b=pJwIHT052wzKnJpaIoFlZc2gRjpI7BOtzarnYXWXW16lEJ0v7bYNs5VkVy3HWePyM1dZXW
	amxPufR//cC6uHTc19dUgTlZJviqrS0D/R8X6xosxmPqwscdiXNNQtcg9TAvg7CtjSgFfd
	iOvbpoMbnV9mXndfdG2rK6ZBxEavze4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728085081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyBJo3UYlxE8GzlHLv21C0YPNkDcNgvoVas94mFzNsg=;
	b=JEPAD7cE7PFoSoVMo20oI6OGghy3lO1Vcut7vZt7KQIs7E2GZq8LGFsXXlltfHnAuJrzCQ
	eh2xEadZVUFEAIAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pJwIHT05;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JEPAD7cE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728085081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyBJo3UYlxE8GzlHLv21C0YPNkDcNgvoVas94mFzNsg=;
	b=pJwIHT052wzKnJpaIoFlZc2gRjpI7BOtzarnYXWXW16lEJ0v7bYNs5VkVy3HWePyM1dZXW
	amxPufR//cC6uHTc19dUgTlZJviqrS0D/R8X6xosxmPqwscdiXNNQtcg9TAvg7CtjSgFfd
	iOvbpoMbnV9mXndfdG2rK6ZBxEavze4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728085081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyBJo3UYlxE8GzlHLv21C0YPNkDcNgvoVas94mFzNsg=;
	b=JEPAD7cE7PFoSoVMo20oI6OGghy3lO1Vcut7vZt7KQIs7E2GZq8LGFsXXlltfHnAuJrzCQ
	eh2xEadZVUFEAIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFE0513793;
	Fri,  4 Oct 2024 23:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h8jxIFZ8AGfLegAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 04 Oct 2024 23:37:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Harald Dunkel" <harri@afaics.de>
Cc: "syzbot" <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 "Jeff Layton" <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
In-reply-to: <d8e1e97f-997f-4dca-8b3f-0628a3783957@afaics.de>
References: <>, <d8e1e97f-997f-4dca-8b3f-0628a3783957@afaics.de>
Date: Sat, 05 Oct 2024 09:37:51 +1000
Message-id: <172808507143.1692160.17519936392458356798@noble.neil.brown.name>
X-Rspamd-Queue-Id: C70DC1F7DC
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[b568ba42c85a332a88ee];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, 03 Oct 2024, Harald Dunkel wrote:
> PS: dmesg -T attached as well.

This doesn't contain stacks for all processes - there are too many and
the buffer wrapped.
This is addressed with the log_buf_len kernel parameter.
1M is probably enough, so maybe set log_buf_len=4M to be sure you have
more than enough.

Unfortunately it requires a reboot to change this.

NeilBrown

