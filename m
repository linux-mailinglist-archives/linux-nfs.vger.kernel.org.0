Return-Path: <linux-nfs+bounces-4375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA72891B583
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 05:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5831C21453
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 03:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D598208D0;
	Fri, 28 Jun 2024 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/SkELcJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eLHOmGRp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NwkZ8yUk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0xlfS0Jt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335C2033A
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545725; cv=none; b=XCAh7eQe7cn24bSKQcctQhXI3iaIwStSAnV7Hp7Gfo3sJ34CQEhPfcq5jGZE3Ck2hnQZ833sTU1ZdxUlGMZSUoDCVSgjoKZzTDD0DIBIzjfbOMMz5ESO9Ztm5UVwqKM6cA0TsGaMoVXbNnCkLLlHlq9gEEYQzbHjsdyeJuoNQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545725; c=relaxed/simple;
	bh=8dVddlF5IOeLIalHBakJKOennWUk2Cml5cIxjIklZDk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ENtTwDAlKI4lZAvJluPneSQhLogqF0EXH/iMUGmbpGXFyMP2lSFquPkbWJUbeQWhBvHPE4zNEWQDK38CwS4Tiju11SDrAGJayjBxnGwSD1WRVVblNgTzsXZq2rOQv3O3nOVhm4dVd/Tf6Z8LVr2hzgfg9ivi0NQHty9yYiY/nzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/SkELcJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eLHOmGRp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NwkZ8yUk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0xlfS0Jt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 579AF1FCDC;
	Fri, 28 Jun 2024 03:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719545721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8V3eAySfYfLszNJS0l7gIgcdI4EurFwRucuz0qv+iqo=;
	b=g/SkELcJ1sM8FJkOUMXNvaIr7KWBCjNWtceuSCj7aG2C2/Mgrpn8hOLY+3NoARnoXpn2/4
	O5MDZZWK4UeIJn3/2FF6bhBOACAmo9CqwCgspfJcIsYP+wv+DEBlecvyHiQIAVZIoVmA5T
	1ys3BLybMU8tfAbcykT02mTfSRGE8sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719545721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8V3eAySfYfLszNJS0l7gIgcdI4EurFwRucuz0qv+iqo=;
	b=eLHOmGRpOLIGQNFoGoAlkSrsDKbnBbRG9ZViQJt+nXBARH2L2ocSuGeJmXKXwuA99z9ksc
	/tLhfDsMsW3NOyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719545720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8V3eAySfYfLszNJS0l7gIgcdI4EurFwRucuz0qv+iqo=;
	b=NwkZ8yUkhEsr6GJr4hQs6bJow4r9wJYus7Jd6YgxKCDW1wnMLXlWnx4XxKNRFMUbQAQ0e4
	nf5i2xZW4h/bhtl1V3fKokKALYaWMccdscgKJURpZW+nlnXEhPNXgx72x1FmSeEqTpPYW2
	oVZ0VaEXCrWcf6GfIazQakPx3lPyu+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719545720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8V3eAySfYfLszNJS0l7gIgcdI4EurFwRucuz0qv+iqo=;
	b=0xlfS0JtIR8Ge+c/tKsWcP7C3f6PcN/cuqZXIuFfTHXcsonLuf628N1MhswsxhQ07Ub+bD
	5TJxbVvUXnsuIJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6288413A63;
	Fri, 28 Jun 2024 03:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O1LIAXUvfmaMTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 28 Jun 2024 03:35:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v8 07/18] nfsd: add "localio" support
In-reply-to: <639F4CEB-04FD-44D1-A781-06D3223B01B2@oracle.com>
References: <>, <639F4CEB-04FD-44D1-A781-06D3223B01B2@oracle.com>
Date: Fri, 28 Jun 2024 13:35:13 +1000
Message-id: <171954571368.16071.11625198645464096617@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,primarydata.com:email,hammerspace.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Fri, 28 Jun 2024, Chuck Lever III wrote:
>=20
>=20
> > On Jun 27, 2024, at 1:27=E2=80=AFPM, Mike Snitzer <snitzer@kernel.org> wr=
ote:
> >=20
> > On Thu, Jun 27, 2024 at 12:07:03PM -0400, Chuck Lever wrote:
> >> On Thu, Jun 27, 2024 at 11:48:09AM -0400, Jeff Layton wrote:
> >>> On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> >>>> Pass the stored cl_nfssvc_net from the client to the server as
> >>>> first argument to nfsd_open_local_fh() to ensure the proper network
> >>>> namespace is used for localio.
> >>>>=20
> >>>> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> >>>> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> >>>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> >>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >>>> ---
> >>>>  fs/nfsd/Makefile    |   1 +
> >>>>  fs/nfsd/filecache.c |   2 +-
> >>>>  fs/nfsd/localio.c   | 246 ++++++++++++++++++++++++++++++++++++++++++++
> >>>>  fs/nfsd/nfssvc.c    |   1 +
> >>>>  fs/nfsd/trace.h     |   3 +-
> >>>>  fs/nfsd/vfs.h       |   9 ++
> >>>>  6 files changed, 260 insertions(+), 2 deletions(-)
> >>>>  create mode 100644 fs/nfsd/localio.c
> >>>>=20
> >>>> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> >>>> index b8736a82e57c..78b421778a79 100644
> >>>> --- a/fs/nfsd/Makefile
> >>>> +++ b/fs/nfsd/Makefile
> >>>> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> >>>>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >>>>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >>>>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayo=
utxdr.o
> >>>> +nfsd-$(CONFIG_NFSD_LOCALIO) +=3D localio.o
> >>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >>>> index ad9083ca144b..99631fa56662 100644
> >>>> --- a/fs/nfsd/filecache.c
> >>>> +++ b/fs/nfsd/filecache.c
> >>>> @@ -52,7 +52,7 @@
> >>>>  #define NFSD_FILE_CACHE_UP      (0)
> >>>> =20
> >>>>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> >>>> -#define NFSD_FILE_MAY_MASK (NFSD_MAY_READ|NFSD_MAY_WRITE)
> >>>> +#define NFSD_FILE_MAY_MASK (NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOC=
ALIO)
> >>>> =20
> >>>>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> >>>>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> >>>> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> >>>> new file mode 100644
> >>>> index 000000000000..ba9187735947
> >>>> --- /dev/null
> >>>> +++ b/fs/nfsd/localio.c
> >>>> @@ -0,0 +1,246 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>> +/*
> >>>> + * NFS server support for local clients to bypass network stack
> >>>> + *
> >>>> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> >>>> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.co=
m>
> >>>> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> >>>> + */
> >>>> +
> >>>> +#include <linux/exportfs.h>
> >>>> +#include <linux/sunrpc/svcauth_gss.h>
> >>>> +#include <linux/sunrpc/clnt.h>
> >>>> +#include <linux/nfs.h>
> >>>> +#include <linux/string.h>
> >>>> +
> >>>> +#include "nfsd.h"
> >>>> +#include "vfs.h"
> >>>> +#include "netns.h"
> >>>> +#include "filecache.h"
> >>>> +
> >>>> +#define NFSDDBG_FACILITY NFSDDBG_FH
> >>>> +
> >>>> +/*
> >>>> + * We need to translate between nfs status return values and
> >>>> + * the local errno values which may not be the same.
> >>>> + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> >>>> + *   all compiled nfs objects if it were in include/linux/nfs.h
> >>>> + */
> >>>> +static const struct {
> >>>> + int stat;
> >>>> + int errno;
> >>>> +} nfs_common_errtbl[] =3D {
> >>>> + { NFS_OK, 0 },
> >>>> + { NFSERR_PERM, -EPERM },
> >>>> + { NFSERR_NOENT, -ENOENT },
> >>>> + { NFSERR_IO, -EIO },
> >>>> + { NFSERR_NXIO, -ENXIO },
> >>>> +/* { NFSERR_EAGAIN, -EAGAIN }, */
> >>>> + { NFSERR_ACCES, -EACCES },
> >>>> + { NFSERR_EXIST, -EEXIST },
> >>>> + { NFSERR_XDEV, -EXDEV },
> >>>> + { NFSERR_NODEV, -ENODEV },
> >>>> + { NFSERR_NOTDIR, -ENOTDIR },
> >>>> + { NFSERR_ISDIR, -EISDIR },
> >>>> + { NFSERR_INVAL, -EINVAL },
> >>>> + { NFSERR_FBIG, -EFBIG },
> >>>> + { NFSERR_NOSPC, -ENOSPC },
> >>>> + { NFSERR_ROFS, -EROFS },
> >>>> + { NFSERR_MLINK, -EMLINK },
> >>>> + { NFSERR_NAMETOOLONG, -ENAMETOOLONG },
> >>>> + { NFSERR_NOTEMPTY, -ENOTEMPTY },
> >>>> + { NFSERR_DQUOT, -EDQUOT },
> >>>> + { NFSERR_STALE, -ESTALE },
> >>>> + { NFSERR_REMOTE, -EREMOTE },
> >>>> +#ifdef EWFLUSH
> >>>> + { NFSERR_WFLUSH, -EWFLUSH },
> >>>> +#endif
> >>>> + { NFSERR_BADHANDLE, -EBADHANDLE },
> >>>> + { NFSERR_NOT_SYNC, -ENOTSYNC },
> >>>> + { NFSERR_BAD_COOKIE, -EBADCOOKIE },
> >>>> + { NFSERR_NOTSUPP, -ENOTSUPP },
> >>>> + { NFSERR_TOOSMALL, -ETOOSMALL },
> >>>> + { NFSERR_SERVERFAULT, -EREMOTEIO },
> >>>> + { NFSERR_BADTYPE, -EBADTYPE },
> >>>> + { NFSERR_JUKEBOX, -EJUKEBOX },
> >>>> + { -1, -EIO }
> >>>> +};
> >>>> +
> >>>> +/**
> >>>> + * nfs_stat_to_errno - convert an NFS status code to a local errno
> >>>> + * @status: NFS status code to convert
> >>>> + *
> >>>> + * Returns a local errno value, or -EIO if the NFS status code is
> >>>> + * not recognized.  nfsd_file_acquire() returns an nfsstat that
> >>>> + * needs to be translated to an errno before being returned to a
> >>>> + * local client application.
> >>>> + */
> >>>> +static int nfs_stat_to_errno(enum nfs_stat status)
> >>>> +{
> >>>> + int i;
> >>>> +
> >>>> + for (i =3D 0; nfs_common_errtbl[i].stat !=3D -1; i++) {
> >>>> + if (nfs_common_errtbl[i].stat =3D=3D (int)status)
> >>>> + return nfs_common_errtbl[i].errno;
> >>>> + }
> >>>> + return nfs_common_errtbl[i].errno;
> >>>> +}
> >>>> +
> >>>> +static void
> >>>> +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> >>>> +{
> >>>> + if (rqstp->rq_client)
> >>>> + auth_domain_put(rqstp->rq_client);
> >>>> + if (rqstp->rq_cred.cr_group_info)
> >>>> + put_group_info(rqstp->rq_cred.cr_group_info);
> >>>> + /* rpcauth_map_to_svc_cred_local() clears cr_principal */
> >>>> + WARN_ON_ONCE(rqstp->rq_cred.cr_principal !=3D NULL);
> >>>> + kfree(rqstp->rq_xprt);
> >>>> + kfree(rqstp);
> >>>> +}
> >>>> +
> >>>> +static struct svc_rqst *
> >>>> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> >>>> + const struct cred *cred)
> >>>> +{
> >>>> + struct svc_rqst *rqstp;
> >>>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >>>> + int status;
> >>>> +
> >>>> + /* FIXME: not running in nfsd context, must get reference on nfsd_se=
rv */
> >>>> + if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
> >>>> + dprintk("%s: localio denied. Server not running\n", __func__);
> >>>=20
> >>> Chuck mentioned this earlier, but I don't think we ought to merge the
> >>> dprintks. If they're useful for debugging then they should be turned
> >>> into tracepoints. This one, I'd probably just drop.
> >>=20
> >> Right; the problem with dprintk() is they can create so much chatter
> >> that the systemd journal will automatically toss those messages and
> >> they are lost. No diagnostic value in that.
> >>=20
> >> Also you probably won't find it useful if lots of debugging info
> >> goes into the trace log but a handful of the stuff you are
> >> looking for is dumped into the system journal; the two use different
> >> timestamps and so are really hard to line up after the fact.
> >>=20
> >> We're trying to transition away from dprintk() in NFSD for these
> >> reasons.
> >=20
> > OK, I understand wanting to not allow new dprintk() to be added.
> >=20
> > Meanwhile:
> > $ grep -ri dprintk fs/nfsd/*.[ch]  | wc -l
> >     181
> >=20
> > So I'm struggling to get motivated to convert to tracepoints.  Feels
> > like a needless make-work hurdle, these could be converted by others
> > more proficient with tracepoints if/when needed.
> >=20
> > Making everyone have to be proficient at developing debugging via
> > tracepoints seems misplaced (but I also understand that forcing others
> > to fish enables "others" to not be doing the conversion work).
>=20
> Trace points are part of the cost of contributing to NFSD,
> just like XDR, RCU, lockdep_assert, and dozens of other
> kernel facilities. Not a hurdle, and I don't ask for busy
> work changes.

I think trace points are quite different from the other facilities you
highlight.
You need to know XDR and RCU etc to get correct performant code.  If you
get it wrong, then the code won't work or (hopefully) a reviewer will
tell you.

But trace points .... when and where are they really useful?  The answer
to that question is no where near as clear cut.

While I'm sure they can be useful, I rarely find them to be so.  I've
certainly had a few positive experiences, but also seen a lot of noise
that doesn't really help me with the particular behaviour that I'm
trying the analyse.  system-tap can be incredibly useful as it is
targeted.  Fixed trace points are (for me) only occasionally useful.

So I would recommend removing all dprintks and not add any trace points
unless we have good reason to think they will be useful - and the person
with the good reason will probably be motivated to do the work (I don't
think I've ever added a new tracepoint, though I have moved them and
revised them slightly).

I think it would be good to know if localio is active - maybe something
in /proc/self/mountinfo could provide that.
I think it might be useful to know what server-uuid each server and each
mount was using.  The client could again have it in
/proc/self/mountinfo.  The server ...  maybe in /proc/fs/nfsd/, maybe
available over netlink...

But these aren't tracing messages, these are status messages.

just fyi, the most valuable part of the dprintk debugging in my
experience is the rpc_show_tasks() call when rpc debugging is turned on
or off.  This view into the current status can be very useful.

>=20
> > This is the end of my mild protest.. I'll shutup and either convert
> > the dprintk()s or kill them all. ;)
>=20
> IMO, if a dprintk is killable (or you don't know its needed
> yet) then it shouldn't be included in the patch series.

I agree.  Kill them all for now.

NeilBrown


>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


