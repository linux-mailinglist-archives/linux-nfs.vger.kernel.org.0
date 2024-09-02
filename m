Return-Path: <linux-nfs+bounces-6114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4E967DA0
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 03:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFABE1F20F74
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF122309;
	Mon,  2 Sep 2024 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JGBItNBy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+36oGqIp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMRODlBA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pz/141Kd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C18460;
	Mon,  2 Sep 2024 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242292; cv=none; b=ggcLJQtFMHCyeXxO1CVSF/oTF7w+Xxf3f58ie7htgfvogTtKHgNQzX6a+0xZNhsqY9E4IWedZzskDgotcM5k/Drg4H76j91wfzal4HnBLIvNGFh/l+aMOzz82fW9fa7afBqVKL2D9brrJzLSmnVsTXIwb1G//rSf6cLDLhWU0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242292; c=relaxed/simple;
	bh=OL537CWRzAJ40IqGdqTBQMFURjJjl/WhL1Xlbp6rj/o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ipqvixUbxRlUg38ZuDPk1gc9aSWtHmBIcOqYQI4XcNN9GzEx9jBWQMamKiXIYwGEfwjp2rAkqxLpuvHAaFBcX6/h+/qE290jgWEMlJmD6R1YblKWpBwJjBoaCo2eS68M+dB/yy0fY93GRTWD846EGtYqrO7OpUzB1+FvSZ67SG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JGBItNBy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+36oGqIp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RMRODlBA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pz/141Kd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74ECA21B29;
	Mon,  2 Sep 2024 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725242288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvg7XWlJCXc4p7nkjWsafWzVfFPk1Lx+S4qCiaCPFaI=;
	b=JGBItNByrwjHzzMYfxCtB0cQ4QO4qRHMmRJq1Uv6WLu1+sagFs4Duq3+na5teL2Kg7+KNI
	nqEsbNx1/LobqtpzjKoCOacL18wkCNK+0XX3uJhRrNZmroBc+ts1GkPT6ApyRGhxvN4fme
	lxuERD+FqRQ68Qc2CXRpke1OJTetwbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725242288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvg7XWlJCXc4p7nkjWsafWzVfFPk1Lx+S4qCiaCPFaI=;
	b=+36oGqIpvuT6GoiOb9Z5uwZfjAnz6Qwz5NbeviUyyIeIUUVM7rcMsuTpxyztYyTz5nkMx5
	uZysaEnDemejWlCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RMRODlBA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pz/141Kd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725242287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvg7XWlJCXc4p7nkjWsafWzVfFPk1Lx+S4qCiaCPFaI=;
	b=RMRODlBAbsiu8ct/rp/blLPhBcoj2VGCMDuXkWaVzooRmdkwyeYkJim/WTuJYy04L3ZAkj
	bmZfOdmmDfuhsXwJ731gRpFb1oLCPYSDIHWy+iFK3sBKCOHgCa8dTNJx4Fg/QsPeybaBAF
	L8z5ezgicpxnhh2oJ+gaH2gJtyDpdKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725242287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvg7XWlJCXc4p7nkjWsafWzVfFPk1Lx+S4qCiaCPFaI=;
	b=pz/141KdIzYgxqESAy/4v4SxmqBfa6Coonr3fg42CRieWfNaQl4r/JypdFGewLVlHHCbqk
	WLqiUWMmYxZwAGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9191386E;
	Mon,  2 Sep 2024 01:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wn9rOKob1WZ2UgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 02 Sep 2024 01:58:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "syzbot" <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
Cc: Dai.Ngo@oracle.com, chuck.lever@oracle.com, dai.ngo@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, lorenzo@kernel.org, netdev@vger.kernel.org,
 okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
In-reply-to: <000000000000b5ba900620fec99b@google.com>
References: <0000000000004385ec06198753f8@google.com>,
 <000000000000b5ba900620fec99b@google.com>
Date: Mon, 02 Sep 2024 11:57:55 +1000
Message-id: <172524227511.4433.7227683124049217481@noble.neil.brown.name>
X-Rspamd-Queue-Id: 74ECA21B29
X-Spam-Score: -4.89
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.89 / 50.00];
	BAYES_HAM(-2.88)[99.47%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[d1e76d963f757db40f91];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 01 Sep 2024, syzbot wrote:
> syzbot has found a reproducer for the following issue on:

I had a poke around using the provided disk image and kernel for
exploring.

I think the problem is demonstrated by this stack :

[<0>] rpc_wait_bit_killable+0x1b/0x160
[<0>] __rpc_execute+0x723/0x1460
[<0>] rpc_execute+0x1ec/0x3f0
[<0>] rpc_run_task+0x562/0x6c0
[<0>] rpc_call_sync+0x197/0x2e0
[<0>] rpcb_register+0x36b/0x670
[<0>] svc_unregister+0x208/0x730
[<0>] svc_bind+0x1bb/0x1e0
[<0>] nfsd_create_serv+0x3f0/0x760
[<0>] nfsd_nl_listener_set_doit+0x135/0x1a90
[<0>] genl_rcv_msg+0xb16/0xec0
[<0>] netlink_rcv_skb+0x1e5/0x430

No rpcbind is running on this host so that "svc_unregister" takes a
long time.  Maybe not forever but if a few of these get queued up all
blocking some other thread, then maybe that pushed it over the limit.

The fact that rpcbind is not running might not be relevant as the test
messes up the network.  "ping 127.0.0.1" stops working.

So this bug comes down to "we try to contact rpcbind while holding a
mutex and if that gets no response and no error, then we can hold the
mutex for a long time".

Are we surprised? Do we want to fix this?  Any suggestions how?

NeilBrown

