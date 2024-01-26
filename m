Return-Path: <linux-nfs+bounces-1454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB083D47E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43087282165
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339744C82;
	Fri, 26 Jan 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h2uQ0i/I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="30ZhKQU0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h2uQ0i/I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="30ZhKQU0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3E44C83
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253991; cv=none; b=sQu4SRkOBsbZ+4OSJ34ZXNTJ7FOftIoIE3knH7a1DStvezwGbzTstCeNCxauXLaDviKhhsk3Z//ukniJ2ngRJFiqotmuqrJ+N7keblqVaxGduaCvHhjaOO0nAUgeNlds7C0xp6s/dp9B//Vn4UXuDt5R3Srw25LyhVsGcH482Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253991; c=relaxed/simple;
	bh=lIon5KMgkUKZ+eFh0JizRQhxh/QgZG0/YLaWDZxxBtA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jCcDOhCAl1IVG8owXP4zyltER19BwMda5I6JGCvZiX7G2W+I+ynfC5tB7MdSkJiaAcDgaN8p5dxmWohUDPdO1Fdz9G1HS+4JNJpt9co328PYoEeIREstP5jiGc2Ss8OU+QgNGt1NPf6aOEgrPOTzSrVSIg9Q68U9KWYh0Hu2goQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h2uQ0i/I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=30ZhKQU0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h2uQ0i/I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=30ZhKQU0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16C031FB65;
	Fri, 26 Jan 2024 07:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706253987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNUlaWFtC+RyeukO+R6ztZ+9Wlxf46OpmVWJfSTpu1w=;
	b=h2uQ0i/IzdM/YUOsFXKocEIOYuOeWboANuSFnxb6sNi+qkg59jjHqHhtod24uTuwlaNle+
	BnAorS4M9yECIgvKcI+ISaPWD1rtrtQZdxTA19GQwnklzwbqzSmX0Hpd1rcyNH9IN0BTSm
	vPpq+oRpG4w4S5eUD64+tVWUfLo5mCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706253987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNUlaWFtC+RyeukO+R6ztZ+9Wlxf46OpmVWJfSTpu1w=;
	b=30ZhKQU0HlaoLRWxU6kXH/CdfNB/CscuZrq8IpYGKxFHpeSOAESKRcoNC1KvH9DBf+89Xo
	Rtbjnq9xF6yLo3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706253987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNUlaWFtC+RyeukO+R6ztZ+9Wlxf46OpmVWJfSTpu1w=;
	b=h2uQ0i/IzdM/YUOsFXKocEIOYuOeWboANuSFnxb6sNi+qkg59jjHqHhtod24uTuwlaNle+
	BnAorS4M9yECIgvKcI+ISaPWD1rtrtQZdxTA19GQwnklzwbqzSmX0Hpd1rcyNH9IN0BTSm
	vPpq+oRpG4w4S5eUD64+tVWUfLo5mCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706253987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNUlaWFtC+RyeukO+R6ztZ+9Wlxf46OpmVWJfSTpu1w=;
	b=30ZhKQU0HlaoLRWxU6kXH/CdfNB/CscuZrq8IpYGKxFHpeSOAESKRcoNC1KvH9DBf+89Xo
	Rtbjnq9xF6yLo3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33DF6134C3;
	Fri, 26 Jan 2024 07:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aG1HN59es2ViZQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jan 2024 07:26:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Shelton" <dan.f.shelton@gmail.com>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Cedric Blancher" <cedric.blancher@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>,
 "Olga Kornievskaia" <olga.kornievskaia@gmail.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
In-reply-to:
 <CAAvCNcA4x1vR2Bh0vTy+kc7tK0t7sdM0JPJa5-XfLhD+-mLQTg@mail.gmail.com>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>,
 <CALXu0UcV0b8OvH7_05tD7+GRgoXRcp9fd1aXuHjtF2OBDPmSJw@mail.gmail.com>,
 <66892D4F-4721-48E5-A088-BD75500275AD@oracle.com>,
 <CAAvCNcA4x1vR2Bh0vTy+kc7tK0t7sdM0JPJa5-XfLhD+-mLQTg@mail.gmail.com>
Date: Fri, 26 Jan 2024 18:26:17 +1100
Message-id: <170625397708.21664.9569848474622251060@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="h2uQ0i/I";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=30ZhKQU0
X-Spamd-Result: default: False [-3.26 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 BAYES_HAM(-0.45)[78.95%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,redhat.com,talpey.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 16C031FB65
X-Spam-Level: 
X-Spam-Score: -3.26
X-Spam-Flag: NO

On Fri, 26 Jan 2024, Dan Shelton wrote:
> 
> Also, it might be good for hosters to allow more than one nfsd
> instance with seperate exports file, each running on its own
> address/port combination. And not force them to use a VM to bloat
> resources.

This is possible with containers.  If you try to start nfsd in a new
network namespace, it will be a new instance independent of nfsd running
in any other namespace.
You would need a filesystem namespace of the various tools to see the
/etc/exports that you want it to.

I would like it to be easier to configure this, but I'm certain that
namespaces are the right way to create a new instance.
(It might be nice to allow separate NFSD namespaces in the same network
namespace but we'd need clear evidence that using network namespaces
causes genuine problems.)

NeilBrown

