Return-Path: <linux-nfs+bounces-509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E18038108CC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 04:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778371F219B0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE116FD2;
	Wed, 13 Dec 2023 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z1GSwrIh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+0/ZzvbZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PRUQt/0G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbKR+itK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026359C;
	Tue, 12 Dec 2023 19:45:55 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBE471FD33;
	Wed, 13 Dec 2023 03:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702439154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB/CuiPsCVYhhs8X0d5ijJC7gSRRgR/wwL/5IAyij/Y=;
	b=z1GSwrIhHoadFf+Zz90vurdfah6C/mBdRxuIlMKM1jGLa9aCCZ4/1QIHNaaNmmBCsW45Vw
	B1VafVo6edCiemPPi+A8WCrBDz94dqbuMWMoTQ2hfm+34ziu7VF3VBJ3Ye1C15oAJjKjTg
	kujYuf1i+jfhhHdgd4QQmv2yhS5QkPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702439154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB/CuiPsCVYhhs8X0d5ijJC7gSRRgR/wwL/5IAyij/Y=;
	b=+0/ZzvbZoI5IoMv9E1ci4Pe4TyjFeVVBCz8cXBzbusoLJYx/xF0TQ2+dKconSds42NN3Ai
	lLmGKYNnB9P/toCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702439153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB/CuiPsCVYhhs8X0d5ijJC7gSRRgR/wwL/5IAyij/Y=;
	b=PRUQt/0GPjZOlP7W2X7bEsAT8FsO8+wNI1IAZhauYlUQ9D4mDtmt0dbDpEAI3OIcGdXKv8
	n94Zzz35ZCVTrPjnPdxo3YL0TV67P/Cw2jdqazyC1+nEfOedw1qoT5sim1zLkt8zIOwcEg
	IyU+GQRWOuy/EiSGjDzt9LpWq+ZnShQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702439153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB/CuiPsCVYhhs8X0d5ijJC7gSRRgR/wwL/5IAyij/Y=;
	b=wbKR+itKky0GzyREaVkaWOPIW0Jjo+hkcuCHlX1tFHuYtWnrApsby/3TBT04STsFCPu8Jh
	RlK2kw3sOnKnmrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C0591388B;
	Wed, 13 Dec 2023 03:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MD7PAO8oeWVjbAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Dec 2023 03:45:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Zhi Li" <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: properly tear down server when write_ports fails
In-reply-to: <ZXhot6zUt6G1xaos@tissot.1015granger.net>
References: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>,
 <170233558429.12910.17902271117186364002@noble.neil.brown.name>,
 <a2b59634a697ae07a315d6f663afaff5cd5bf375.camel@kernel.org>,
 <ZXhlNtQ9o+howGbH@tissot.1015granger.net>,
 <ZXhot6zUt6G1xaos@tissot.1015granger.net>
Date: Wed, 13 Dec 2023 14:45:48 +1100
Message-id: <170243914810.12910.1721447953189600231@noble.neil.brown.name>
X-Spam-Level: **********
X-Spam-Score: 10.29
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PRUQt/0G";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wbKR+itK;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-15.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -15.51
X-Rspamd-Queue-Id: EBE471FD33
X-Spam-Flag: NO

On Wed, 13 Dec 2023, Chuck Lever wrote:
> On Tue, Dec 12, 2023 at 08:50:46AM -0500, Chuck Lever wrote:
> > On Mon, Dec 11, 2023 at 06:11:04PM -0500, Jeff Layton wrote:
> > > On Tue, 2023-12-12 at 09:59 +1100, NeilBrown wrote:
> > > > On Tue, 12 Dec 2023, Jeff Layton wrote:
> > > > > When the initial write to the "portlist" file fails, we'll currentl=
y put
> > > > > the reference to the nn->nfsd_serv, but leave the pointer intact. T=
his
> > > > > leads to a UAF if someone tries to write to "portlist" again.
> > > > >=20
> > > > > Simple reproducer, from a host with nfsd shut down:
> > > > >=20
> > > > >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> > > > >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> > > > >=20
> > > > > The kernel will oops on the second one when it trips over the dangl=
ing
> > > > > nn->nfsd_serv pointer. There is a similar bug in __write_ports_addf=
d.
> > > > >=20
> > > > > This patch fixes it by adding some extra logic to nfsd_put to ensure
> > > > > that nfsd_last_thread is called prior to putting the reference when=
 the
> > > > > conditions are right.
> > > > >=20
> > > > > Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_p=
ut()")
> > > > > Closes: https://issues.redhat.com/browse/RHEL-19081
> > > > > Reported-by: Zhi Li <yieli@redhat.com>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > This should probably go to stable, but we'll need to backport for v=
6.6
> > > > > since older kernels don't have nfsd_nl_rpc_status_get_done. We shou=
ld
> > > > > just be able to drop that hunk though.
> > > > > ---
> > > > >  fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++++----
> > > > >  fs/nfsd/nfsd.h   |  8 +-------
> > > > >  fs/nfsd/nfssvc.c |  2 +-
> > > > >  3 files changed, 30 insertions(+), 12 deletions(-)
> > > >=20
> > > > This is much the same as
> > > >=20
> > > > https://lore.kernel.org/linux-nfs/20231030011247.9794-2-neilb@suse.de/
> > > >=20
> > > > It seems that didn't land.  Maybe I dropped the ball...
> > >=20
> > > Indeed it is. I thought the problem seemed familiar. Your set is
> > > considerably more comprehensive. Looks like I even sent some Reviewed-
> > > bys when you sent it.
> > >=20
> > > Chuck, can we get these in or was there a problem with them?
> >=20
> > Offhand, I'd say either I was waiting for some review comments
> > to be addressed or the mail got lost (vger or Exchange or I
> > accidentally deleted the series). I'll go take a look.
>=20
> I reviewed the thread:
>=20
> https://lore.kernel.org/linux-nfs/20231030011247.9794-1-neilb@suse.de/
>=20
> From the looks of it, I was expecting Neil to address a couple of
> review comments and repost. These are the two comments that stand
> out to me now:
>=20
> On 1/5:
>=20
> > > Then let's add
> > >=20
> > > Fixes: ec52361df99b ("SUNRPC: stop using ->sv_nrthreads as a refcount")
> > >=20
> > > to this one, since it addresses a crasher seen in the wild.
> >=20
> > Sounds good.
> >=20
> > > > but it won't fix the hinky error cleanup in nfsd_svc. It looks like t=
hat
> > > > does get fixed in patch #4 though, so I'm not too concerned.
> > >=20
> > > Does that fix also need to be backported?
> >=20
> > I think so, but we might want to split that out into a more targeted
> > patch and apply it ahead of the rest of the series. Our QA folks seem to
> > be able to hit the problem somehow, so it's likely to be triggered by
> > people in the field too.
>=20
> This last paragraph requests a bit of reorganization to enable an
> easier backport.

I think the "error cleanup" was addressed in a different series.  Maybe
it hasn't landed either.

>=20
> And on 2/5:
>=20
> > > > > +struct pool_private {
> > > > > +	struct svc_serv *(*get_serv)(struct seq_file *, bool);
> > > >=20
> > > > This bool is pretty ugly. I think I'd rather see two operations here
> > > > (get_serv/put_serv). Also, this could use a kerneldoc comment.
> > >=20
> > > I agree that bool is ugly, but two function pointers as function args
> > > seemed ugly, and stashing them in 'struct svc_serv' seemed ugly.
> > > So I picked one.  I'd be keen to find an approach that didn't require a
> > > function pointer.
> > >=20
> > > Maybe sunrpc could declare
> > >=20
> > >    struct svc_ref {
> > >          struct mutex mutex;
> > >          struct svc_serv *serv;
> > >    }
> > >=20
> > > and nfsd could use one of those instead of nfsd_mutex and nfsd_serv, and
> > > pass a pointer to it to the open function.
> > >=20
> > > But then the mutex would have to be in the per-net structure.  And maybe
> > > that isn't a bad idea, but it is a change...
> > >=20
> > > I guess I could pass pointers to nfsd_mutex and nn->nfsd_serv to the
> > > open function....
> > >=20
> > > Any other ideas?
> >=20
> > I think just passing two function pointers to svc_pool_stats_open, and
> > storing them both in the serv is the best solution (for now). Like you
> > said, there are no clean options here. That function only has one caller
> > though, so at least the nastiness will be confined to that.
> >=20

We can't store the function pointers in the serv because the purpose of
the first function is to find the serv.

I guess I should just repost everything again....  but it isn't a good
time for year for sustained debates.

NeilBrown


> > Moving the mutex to be per-net does make a lot of sense, but I think
> > that's a separate project. If you decide to do that and it allows you to
> > make a simpler interface for handling the get/put_serv pointers, then
> > the interface can be reworked at that point.
>=20
> The other requests I see in that thread have already been answered
> adequately.
>=20
>=20
> --=20
> Chuck Lever
>=20


