Return-Path: <linux-nfs+bounces-8643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096019F5D24
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 03:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410D57A2182
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AD42048;
	Wed, 18 Dec 2024 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvcchV9Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PLFQqDOV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cWA1rnmQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HEQILEmv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772835961
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734490686; cv=none; b=g9vHSvD85eEjbzYK5EAmMHM6+mEpkkv6Obp1htDWXqnFzghNdE6NjjXvJPLqYDqFVEMBGC7dqO24gyvUDxUW8aXcWdrjbG8yv3QH86GRiU2VHA7Yhhat1s7ts/UDXp19EOeoYJXFaBcbQxYXSm2KGzLyzXLFZQJLvHVSBwAMezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734490686; c=relaxed/simple;
	bh=ia7q5u/NPx0mND9+mHGw6itu51QJcF0ja2ZrpjfUHwc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=NiBCyuFElSu8Rg+3IotodAf3uzIF3aozK1MCEpGq8SxQwfn6KhfdgLmQx1fQkXMJNSpDwZ+DznkaIHEQk4DFHLq2MkvLhQYYf28x/2tqAB0Rn90A5dl0gWA1DNt2IARvHHA3MPpAAR8NaQ/m5BczBrlta03NGeTpi9kHdsPIkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jvcchV9Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PLFQqDOV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cWA1rnmQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HEQILEmv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68EBD2116C;
	Wed, 18 Dec 2024 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734490681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y2oovWKOOkcOBbFnsf3bPIm7JOvVt1V0ScClZItPdAQ=;
	b=jvcchV9Yo779OdM6YHQoNsintFO65WDD4O+xy2YbHW+1CnVzMNLGDY1/+ydhgQUi63kpNH
	iYryCqVv5EBQrFrmySQsScipXsd2ympBDz0Nolo9m4dak9gYDVvKDZi6o9gjxkVYrETkek
	QF/FEZ8emUsbtuukG8NgQHND8E3z5XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734490681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y2oovWKOOkcOBbFnsf3bPIm7JOvVt1V0ScClZItPdAQ=;
	b=PLFQqDOVXLUYv7zw/ZSbHM80adiP7q/36xaRo573DO1ka+yUY35892ob05XACeJVqcrhCs
	QwPwpsW4zKcXstAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734490680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y2oovWKOOkcOBbFnsf3bPIm7JOvVt1V0ScClZItPdAQ=;
	b=cWA1rnmQ36FvzHLnG3bbB5zZpAaQ+KgEh9lB1URlIqNnaQLdzAYRi22CLdvb2SmxKdw6TJ
	+NuzJ3V5tOifkztHO6VVDfCY+d2DE3KF16R3YIbRuFts/TFvFcViXsRNegzgZCqhFqL197
	pjNw9JhIa47LTmqjCFqQxDY5gETWLP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734490680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y2oovWKOOkcOBbFnsf3bPIm7JOvVt1V0ScClZItPdAQ=;
	b=HEQILEmv0ya1K8iCTG+il5OS7LulcwIrWwyQyGqBH5vKh0FuP3WShJIwT0Wp5cEKxtVkQI
	0kd0CD8kfvbW3wBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6357132EA;
	Wed, 18 Dec 2024 02:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0btxFzY6YmeKXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 18 Dec 2024 02:57:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: does nfsd reset the callback client too hastily?
Date: Wed, 18 Dec 2024 13:57:55 +1100
Message-id: <173449067508.1734440.12408545842217309424@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.29
X-Spam-Flag: NO


Hi,
 I've been pondering the messages

 receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt XXXXXXX xi=
d XXXXXX

that turn up occasionally.  Google reports a variety of hits and I've
seen them in a logs from a customer though I don't think they were
directly related to the customer's problem.

These messages suggest a callback reply from the client which the server
was not expecting.  I think the most likely cause that the server called
  rpc_shutdown_client(clp->cl_cb_client);
while there were outstanding callbacks.
This causes rpc_killall_tasks() to be called so that the tasks stop
waiting for a reply and are discarded.

The rpc_shutdown_client() call can come from nfsd4_process_cb_update()
which gets runs whenever nfsd4_probe_callback() is called.  This happens
in quite a few places including when a new connection is bound to a
session.

So if a new connection is bound, the current callback channel is aborted
even though it is working perfectly well.  That is particularly
problematic as callback request are not currently retransmitted.

So I'm wondering if nfsd4_process_cb_update() should only shutdown the
current cb client if there is evidence that it isn't work.

I'm not certain how best to do that.  One option might be to do a search
similar to that in __nfsd4_find_backchannel() and see if the current
session and xprt are still valid.  There might be a better way.

Thoughts?

Thanks,
NeilBrown

