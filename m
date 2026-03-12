Return-Path: <linux-nfs+bounces-20115-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNhqDZFOs2mNUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20115-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:38:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A217E27B4A6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 00:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 804063065AFB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B22401A0C;
	Thu, 12 Mar 2026 23:38:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D043D0921;
	Thu, 12 Mar 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773358733; cv=none; b=gNc7QzVANDcghrzlXK9ogXcKcIQ4CL6h7lL1fp0b6P+dcjGMjADiI7+bw02kwq92U/AkKRPyEnI4UpvBO+z+SxSt78lul8514e8qJlo4fkaKvStQDIukEwckiRrBT5SuQmTAxG7XRL5oL0w/6h7m2iV9zXK2XuM1n9lV3/LwIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773358733; c=relaxed/simple;
	bh=PjQnm7PdIi0z/ruBJQNhneZVuQrhBMEPnKL7b5RdF4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHOn912MrD9Mv4A7skBR0PKUAd2YQONvoGuwmegZk+aLI9xDD64Nugvzp0iJt4bxlkIkoSwd5wWoP6lhbKURLpIEvFTAfF8iFVn0f6tUGppkidhOO0VZp2fruKxRiTKt/8m8dYiPUK2EujsuU6cB8wBkEbJ+7EAzu6l1zAKT4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 75BA61A0463;
	Thu, 12 Mar 2026 23:38:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 437DE20024;
	Thu, 12 Mar 2026 23:38:32 +0000 (UTC)
Date: Thu, 12 Mar 2026 19:38:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: NeilBrown <neilb@ownmail.net>
Cc: NeilBrown <neil@brown.name>, Linus Torvalds
 <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff
 Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Jan
 Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, Namjae
 Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o"
 <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Masami
 Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex
 Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
 Tyler Hicks <code@tyhicks.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel
 <ardb@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
 ecryptfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
Message-ID: <20260312193847.28c32a2c@gandalf.local.home>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
References: <20260312214330.3885211-1-neilb@ownmail.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uw6f48jbt5c7m69ogen7zm3qrgdgnged
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188/YrC5TApof6JUD5+VNztl2shXsvgY5o=
X-HE-Tag: 1773358712-902307
X-HE-Meta: U2FsdGVkX1+OxQ2+Isx7vF4UixzzITSWoLGanhQdmOUQzHc1ErHaC2HhfFr20UjnVfuApzdY0CnNI9X2EzaFzoxWkp+inh8h89+ue9tsCje/WXI2p8TViZKD1rgZ9aRmWPzAaOFt9AR3SlccruGvmKX1nd3X2qcHF/Qj4v2Ic2F2kBtdL+HvK1KWscULRrzA7ZXclvIVR+DpEPprYwt/KKB72qtNEyxLFZN/ZdoFOmgI0OmUW9WSqFmPDtGp6NNUkGL68vmGr0d1dJsWkcANTfDGT58FCBs3Q3TWI/CNur9ihaDpBPfKeDQH86AL8k3ONIIfeCwhZyBEr7FfTAOuyi2fOWNNYZopJrxvZi0zu3x2dKf/Woo8mIogKoo/MSw6
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org,vger.kernel.org,kvack.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20115-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_GT_50(0.00)[52];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A217E27B4A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 08:11:47 +1100
NeilBrown <neilb@ownmail.net> wrote:

> *[PATCH 26/53] smb/client: don't unhashed and rehash to prevent new
> *[PATCH 27/53] smb/client: use d_splice_alias() in atomic_open
>  [PATCH 28/53] smb/client: Use d_alloc_noblock() in
> *[PATCH 29/53] exfat: simplify exfat_lookup()
> *[PATCH 30/53] configfs: remove d_add() calls before
>  [PATCH 31/53] configfs: stop using d_add().
> *[PATCH 32/53] ext4: move dcache modifying code out of __ext4_link()
> *[PATCH 33/53] ext4: use on-stack dentries in

>  [PATCH 34/53] tracefs: stop using d_add().

Hmm, another reason I hate being Cc'd on every patch of a patch bomb where
I only need to look at one (and maybe the first) patch.

For some reason, I'm missing several patches, and this is one of them :-p

-- Steve


>  [PATCH 35/53] cephfs: stop using d_add().
> *[PATCH 36/53] cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME
>  [PATCH 37/53] cephfs: Use d_alloc_noblock() in
>  [PATCH 38/53] cephfs: Don't d_drop() before d_splice_alias()
>  [PATCH 39/53] ecryptfs: stop using d_add().
>  [PATCH 40/53] gfs2: stop using d_add().

