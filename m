Return-Path: <linux-nfs+bounces-367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE198078C8
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 20:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E461C20A85
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611347F55;
	Wed,  6 Dec 2023 19:42:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E176490
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 11:42:26 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6FCB1FD36;
	Wed,  6 Dec 2023 19:42:24 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AEDB133DD;
	Wed,  6 Dec 2023 19:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id D1U/CaDOcGUfYwAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 06 Dec 2023 19:42:24 +0000
Date: Wed, 6 Dec 2023 20:42:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: linux-nfs@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>,
	Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH v2] support/backend_sqlite.c: Add missing <sys/syscall.h>
Message-ID: <20231206194220.GA159824@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231205223543.31443-1-pvorel@suse.cz>
 <20231205223543.31443-2-pvorel@suse.cz>
 <be8ead05-1ebd-45c8-84e7-78b6b0e7202b@benettiengineering.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8ead05-1ebd-45c8-84e7-78b6b0e7202b@benettiengineering.com>
X-Rspamd-Queue-Id: D6FCB1FD36
X-Spam-Score: 2.19
X-Spamd-Result: default: False [2.19 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[19.67%];
	 ARC_NA(0.00)[];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.00)[suse.cz];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of pvorel@suse.cz) smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd1

Hi Giulio,

> Hi Petr,

> On 05/12/23 23:35, Petr Vorel wrote:
> > From: Petr Vorel <petr.vorel@gmail.com>

> > This fixes build on systems which actually needs getrandom()
> > (to get SYS_getrandom).

> > Fixes: f92fd6ca ("support/backend_sqlite.c: Add getrandom() fallback")
> > Fixes: http://autobuild.buildroot.net/results/c5fde6099a8b228a8bdc3154d1e47dfa192e94ed/
> > Reported-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> thank you for fixing. I've tested this and the other patch with
> Buildroot's test-pkg and built fine for many toolchain/arch/libc
> combinations.

Thank you for extensive testing! I test only the basic 6 tests (the default
test-pkg).  I suppose you run test-pkg also with -a (these 45 arch
combinations).

> Reviewed-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Maybe you can add your Tested-by: ?

Kind regards,
Petr


> Best regards

