Return-Path: <linux-nfs+bounces-321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93580428E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 00:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571452812E7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A32225AE;
	Mon,  4 Dec 2023 23:31:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9751D113
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 15:31:46 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1563E1FE7F;
	Mon,  4 Dec 2023 23:31:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1613E1398A;
	Mon,  4 Dec 2023 23:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZphuLV9hbmWQBQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 23:31:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Cedric Blancher" <cedric.blancher@gmail.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: PATH_MAX/max symlink length in the NFSv4/v4.1 protocol?
In-reply-to:
 <CALXu0Ufm+b+9wOLk2bG79rKFfPCY9K_2USZaFhso-dR_NaS+Hg@mail.gmail.com>
References:
 <CALXu0Ufm+b+9wOLk2bG79rKFfPCY9K_2USZaFhso-dR_NaS+Hg@mail.gmail.com>
Date: Tue, 05 Dec 2023 10:31:40 +1100
Message-id: <170173270053.7109.16328574544196615112@noble.neil.brown.name>
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 TO_DN_ALL(0.00)[];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.45)[0.986];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.06%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 11.24
X-Rspamd-Queue-Id: 1563E1FE7F

On Mon, 04 Dec 2023, Cedric Blancher wrote:
> Good evening!
> 
> Does NFSv4/v4.1 have a limit similar to PATH_MAX? What about
> symlinks/reparse points? Is there no limit, or is the limit
> configurable, or is the limit >= 4096?

See:
 https://www.rfc-editor.org/rfc/rfc5661

There is no explicit limit.
The local filesystem on the server might impose a limit, but the
protocol itself does not.

The protocol *does* declare that a symlink is valid UTF-8.  Linux
doesn't enforce this.  This might sometimes cause confusion.  But the
length should not.

NeilBrown


> 
> Ced
> -- 
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
> 
> 


