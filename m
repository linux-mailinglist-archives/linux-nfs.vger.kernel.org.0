Return-Path: <linux-nfs+bounces-109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659B7FAC8E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 22:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C501C281BA1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530EF4644C;
	Mon, 27 Nov 2023 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EnNWv26X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qRU0ejNa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563D131
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 13:31:36 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4973F1F37E;
	Mon, 27 Nov 2023 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701120692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWfjt8/gO2fghOO4GO1l3lIEc+p4zh7B/MoHkClRzYw=;
	b=EnNWv26XlHFZ6bE3nFGSJTSQFaSuBcGin9ukqPjA73f+OnQEmZsydWTpJsza7cDQvpjU+4
	NDA1PNCo0MblP+woDramAHaSRk4B3NBVCTvdUWi2g6js6VvHI5d87d0S0wyMRtggjGeq0p
	K2WadKnZSSg2kxrZdZM087qGOK5LCAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701120692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWfjt8/gO2fghOO4GO1l3lIEc+p4zh7B/MoHkClRzYw=;
	b=qRU0ejNaFHRd2YbxtRhPDQ+Bg45oxI7kxASy1Hs7qSZtNLpfm2EbYtNcFXuh22Ea4A5scG
	Bj6Ax/YN56EomLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61AA51367B;
	Mon, 27 Nov 2023 21:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OzIFBbEKZWUwMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Nov 2023 21:31:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>,
 "thfeathers@sina.cn" <thfeathers@sina.cn>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "tom@talpey.com" <tom@talpey.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
 "kolga@netapp.com" <kolga@netapp.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: _xprt_switch_find_current_entry return xprt with
 condition find_active
In-reply-to: <aa9e250a966c47782f79d258ea9818ae4fcbdbc5.camel@hammerspace.com>
References: <20231127153959.2067-1-thfeathers@sina.cn>,
 <aa9e250a966c47782f79d258ea9818ae4fcbdbc5.camel@hammerspace.com>
Date: Tue, 28 Nov 2023 08:31:22 +1100
Message-id: <170112068218.7109.1172633879607916557@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.85
X-Spamd-Result: default: False [-3.85 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.75)[98.93%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.cn];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,hammerspace.com:email,sina.cn:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,sina.cn,oracle.com,talpey.com,netapp.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]

On Tue, 28 Nov 2023, Trond Myklebust wrote:
> On Mon, 2023-11-27 at 23:39 +0800, jsq wrote:
> > [You don't often get email from thfeathers@sina.cn. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > current function always return a active xprt or NULL no matter what
> > find_active
> 
> 
> This patch clearly breaks xprt_switch_find_current_entry_offline().

I think it actually fixes xprt_switch_find_current_entry_offline().

Looking closely at _xprt_switch_find_current_entry:

		if (found && ((find_active && xprt_is_active(pos)) ||
			      (!find_active && xprt_is_active(pos))))

and comparing with similar code in xprt_switch_find_next_entry:

		if (found && ((check_active && xprt_is_active(pos)) ||
			      (!check_active && !xprt_is_active(pos))))

There is a difference in the number of '!'.  I suspect the former is
wrong.
If the former is correct, then "find_active" is irrelevant.

NeilBrown

> Furthermore, we do not accept patches without a real name on a Signed-
> off-by: line.
> 
> So NACK on two accounts.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
> 


