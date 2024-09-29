Return-Path: <linux-nfs+bounces-6700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8B98985E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 01:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB93F282E5C
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DB14D6F9;
	Sun, 29 Sep 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZKAo3Tbi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bMIcN4jA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZKAo3Tbi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bMIcN4jA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87B26AD9
	for <linux-nfs@vger.kernel.org>; Sun, 29 Sep 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727651607; cv=none; b=bG0lqQXbehZVJtZXBRa9jeLaSyUA+Rj4ukZlh5VgsIGa13dJOYbkHlj17DpUrkBIyoKTWAlHtA9nD4c2B3GQUFvTO5pw/noaSbeQHvKTH+ORITULdfGcwr4uDuc1oY5JmgLPqkap6ZDVLcI5JEYM2srweLRYp+gMfhyWusVyems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727651607; c=relaxed/simple;
	bh=ASe8KJ/wL/hfJdKEMQRCxX+u3mTpHX9cuIKzFwsEnC0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jUvUx8ruU+PWMYRhGJ7a4Z+rZpOdVfpmttinQkPmekTysRZNCsUGotz1zHQwuywNxLi612j94RVvYQoI6ayCOul6LEA6Lv003pwT/7AA4JqYiHk6VihYbpyIfw5beODbtoD8vdU18CQHzpPYF51gOQVfcbW0UxWgJzgyAnO1hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZKAo3Tbi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bMIcN4jA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZKAo3Tbi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bMIcN4jA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69FCF1F7D8;
	Sun, 29 Sep 2024 23:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727651598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DdQSXfSI6PcztzeY5d3BNhB8ocHdVNrtKPLkeiyGxs=;
	b=ZKAo3TbixGQwsJBotYqtVMFvgW6rY2p/2Qf5KQ/0Kq7l+r5tHGCfDOus9cn0ZmyjKJXYpH
	m9AiF+qJhd2yGtnr4FOKJTTufmx2eMjwZTfOp3CF153tOHhUopYPqr5pWRBnspoSfnhn5F
	OuKuLA7y8sUoU4KPBJfQU8tNwd9+4rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727651598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DdQSXfSI6PcztzeY5d3BNhB8ocHdVNrtKPLkeiyGxs=;
	b=bMIcN4jAiuW2PGMBXBtI/liZLo0mnXKwYIBOZv0RLx9sx8wqXoWtp9OKlg9ZQl4xD129K8
	xrf0kdRYk2AK9fDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727651598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DdQSXfSI6PcztzeY5d3BNhB8ocHdVNrtKPLkeiyGxs=;
	b=ZKAo3TbixGQwsJBotYqtVMFvgW6rY2p/2Qf5KQ/0Kq7l+r5tHGCfDOus9cn0ZmyjKJXYpH
	m9AiF+qJhd2yGtnr4FOKJTTufmx2eMjwZTfOp3CF153tOHhUopYPqr5pWRBnspoSfnhn5F
	OuKuLA7y8sUoU4KPBJfQU8tNwd9+4rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727651598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DdQSXfSI6PcztzeY5d3BNhB8ocHdVNrtKPLkeiyGxs=;
	b=bMIcN4jAiuW2PGMBXBtI/liZLo0mnXKwYIBOZv0RLx9sx8wqXoWtp9OKlg9ZQl4xD129K8
	xrf0kdRYk2AK9fDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959C9136CB;
	Sun, 29 Sep 2024 23:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tmbjEQvf+Wb0BwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 29 Sep 2024 23:13:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Anna Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>
Subject: Re: [PATCH] sunrpc: fix prog selection loop in svc_process_common
In-reply-to: <9347B5EE-1CD2-4FD6-BE32-3E14E1C50BEE@oracle.com>
References: <>, <9347B5EE-1CD2-4FD6-BE32-3E14E1C50BEE@oracle.com>
Date: Mon, 30 Sep 2024 09:13:08 +1000
Message-id: <172765158848.470955.7197226007411167339@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sun, 29 Sep 2024, Chuck Lever III wrote:
> 
> 
> > On Sep 25, 2024, at 5:25 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > [I fixed Dan's address - sorry about that]
> > 
> > On Thu, 26 Sep 2024, Chuck Lever wrote:
> >> Hi Neil -
> >> 
> >> On Wed, Sep 25, 2024 at 05:28:09PM +1000, NeilBrown wrote:
> >>> 
> >>> If the rq_prog is not in the list of programs, then we use the last
> >>> program in the list and subsequent tests on 'progp' being NULL are
> >>> useless.
> >> 
> >> That's the logic error, but what is the observed unexpected
> >> behavior?
> > 
> > The unexpected behaviour is that "if rq_prog is not in the list of
> > programs, then we use the last program in the list".  Isn't that a
> > behaviour?  Should I add that "we don't get the expected
> > rpc_prog_unavail error?
> 
> I'm thinking of something that would catch the eye of some
> overworked support engineer who might not be deeply familiar
> with NFS or RPC.
> 
> Clients won't see RPC_PROG_UNAVAIL, but what would they see
> instead? Under what conditions would they see this misbehavior?

I had thought of this being a bug with no observable consequences in
normal circumstance.  But upon reflection I realise that if an nfs
server was running on a kernel which didn't have NFS_ACL_SUPPORT then a
ping of the nfs_acl service on port 2049 would incorrectly report
success.  Do clients do an RPC ping without checking with portmap first?
Maybe, but only at mount time.  So if you rebooted a server that had ACL
support so that now it doesn't - the result might confuse the client.
Maybe.

I agree that it can be valuable decoding the likely user-visible effect
of a bug.  Not always easy.  I'll take your suggested way-out of noting
that the bug should never appear in a released kernel - only an -rc1

Thanks,
NeilBrown


> 
> It's no big deal, since this bug will never reach a stable
> kernel. I was thinking out loud, and forgot to label the
> remark as such.
> 
> 
> --
> Chuck Lever
> 
> 
> 


