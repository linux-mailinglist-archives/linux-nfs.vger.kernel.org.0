Return-Path: <linux-nfs+bounces-6694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4E9894A8
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 12:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330211C21CF4
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3914A093;
	Sun, 29 Sep 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X/FeR2+p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VRi+rOXF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nms3yLIJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1vTvuysg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827214D6E6
	for <linux-nfs@vger.kernel.org>; Sun, 29 Sep 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727604005; cv=none; b=ONBfULDiXGXZq2LGGAwDQB9Dh0DdUxXkpBp8jPLLQ7xCMY5mO/jWaxjcv4j6QW7KqFJs5hRO6lsGAabnWqdO5QdoXK791sLMysodBW5SICyzB8+4tf8Lk1rAqExN4pot+pRmt409w7vJtJ0mYqIMNyv+dHtIajgqcSTvjyRNV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727604005; c=relaxed/simple;
	bh=uur9WwY/rmfTVzs8abWmZA7YEe76LOUxmah9ShNRrRY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=I4u65xMKZN17nnZTvxKhF1uh9LXEUeSugp48A0vg19xvvKQaeoz5xw7uCEX/n76fUywbhfj8iYih07Po97P+EjNeBeGNVlSb6xIuoinE4jVMwcJQ1BhEYi0ehN1Wem8s1jTUcKYGXYYZVPghlA5RX/dYWHlingFQPoUFyJ1XUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X/FeR2+p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VRi+rOXF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nms3yLIJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1vTvuysg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BEE421A79;
	Sun, 29 Sep 2024 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727604000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCeTNcBDUKXgqPLehLflaocAG6qDG+EONJj21nDYZEQ=;
	b=X/FeR2+pmDcKC2gI+pQHkiNaoZ4jMpHIM78BkTcenp3IneOXUlEVXrSD5QY0NE1oG/2csw
	aLNHh32Vi/MEGONG31MvtqMUCMImYvZZguSiPjWUry+/pa/ZzLQWATkJouh3F4+hKwSBIi
	Z2GdBuZOoo2zcsGKIxUQxCk1FTVJ55U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727604000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCeTNcBDUKXgqPLehLflaocAG6qDG+EONJj21nDYZEQ=;
	b=VRi+rOXF4DZaFsuV3llOprP23wxWpU9SEW4d3pb4iMvBCpr55EpWb6oaEXBASaTqyJMRQY
	ViWllqgz6bsQ4hBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nms3yLIJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1vTvuysg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727603999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCeTNcBDUKXgqPLehLflaocAG6qDG+EONJj21nDYZEQ=;
	b=Nms3yLIJvPUGr9bnNan0TCj7YhAx7oJAxggNyr4o5og+VA44Ql8OdaSTA/uu6IntHKZ0ym
	Ltz0vyKuIztiIHpJRDSoQ8Bi7D9Nqn7xrDdyDNkYEqje5E6qDBptiPUR/K4PnNyB7L0WlB
	ElAfZSRp3P6sjJtKw5V9xESm32nKZEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727603999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCeTNcBDUKXgqPLehLflaocAG6qDG+EONJj21nDYZEQ=;
	b=1vTvuysgbHuQ0QS98+a4ecLIDOA54xjFXyeY9Q+6O/FyxNrzm/lSmAHpv7a4EH07+gwhCj
	Pap/ezi5bp796XBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9041E136CB;
	Sun, 29 Sep 2024 09:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGQ9ERwl+WYSTAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 29 Sep 2024 09:59:56 +0000
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
In-reply-to: <90750d21-61fa-4243-8c6b-dbf6fa185ae4@afaics.de>
References: <>, <90750d21-61fa-4243-8c6b-dbf6fa185ae4@afaics.de>
Date: Sun, 29 Sep 2024 19:59:36 +1000
Message-id: <172760397625.470955.13033558054733497181@noble.neil.brown.name>
X-Rspamd-Queue-Id: 9BEE421A79
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[b568ba42c85a332a88ee];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 29 Sep 2024, Harald Dunkel wrote:
> Hi Neil,
> 
> On 2024-09-29 00:23:18, NeilBrown wrote:
> > 
> > Thanks for the logs.  The point to flush_workqueue() being a problem,
> > presumably from nfsd4_probe_callback_sync(), though I'm not 100% sure of
> > that.  Maybe some deadlock in the callback code.  I'm not very familiar
> > with that code and nothing immediately jumps out.
> > 
> > I had thought that hung_task_all_cpu_backtrace would show a backtrace of
> > *all* tasks - I missed the "cpu" in there.
> > If if it happens again and if you can
> >    echo t > /proc/sysrq-trigger
> > to get stack traces of everything, that might help.  Maybe it won't be
> > necessary if I or someone else can spot a deadlock with
> > flush_workqueue().
> > 
> 
> I just learned that kernel.hung_task_panic = 1 should have been set, too.
> Sorry for that. Currently I have
> 
> 	kernel.hung_task_panic = 1
> 	kernel.hung_task_all_cpu_backtrace = 1
> 
> Please confirm.

You DON'T want hung_task_panic in this case.  If the system panics, it
might do so before the watchdog you mention below fires.  We really need
the sysrq-trigger output and the panic might interfere with that.

Thanks,
NeilBrown


> 
> I have set a watchdog to run the sysrq trigger on the NFS server if df
> on an NFS client doesn't respond.
> 
> 
> Regards
> Harri
> 


