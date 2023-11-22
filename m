Return-Path: <linux-nfs+bounces-27-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82C7F3B22
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFEB2828BD
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773F1FC9;
	Wed, 22 Nov 2023 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PChyWPep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mi0A87rP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77346199
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 17:18:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF6C41F85D;
	Wed, 22 Nov 2023 01:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700615878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umDw/nilTX6SzjBFyFPYeLskMhG4VL6/Y9cHdAxBZOA=;
	b=PChyWPep0emwf+WqCT9srCKzKAwtvVCCujrrtad97guclzgZ9uEdG8vFxpTyhDcYTmvhND
	kw7xhubhNe+iUgLjcZ9KAYMPgbcEsIH4zuRZ3netnfwakYpXkZhg9X1p1DyW4BDQgFiXdN
	9nteT+gk5LqhB81ebhsT2cqezdE1UVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700615878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umDw/nilTX6SzjBFyFPYeLskMhG4VL6/Y9cHdAxBZOA=;
	b=Mi0A87rPI60juwbk8BG2CgfdR26JSMVzDaPI4poKT/ukcqPS2FWjKJb6WoSW2ldUE3Cqnq
	DOvpq1ScfHVOd5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4207C1390F;
	Wed, 22 Nov 2023 01:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SkTvN8NWXWWWKgAAMHmgww
	(envelope-from <neilb@suse.de>); Wed, 22 Nov 2023 01:17:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Salvatore Bonaccorso" <carnil@debian.org>
Cc: "Andreas Hasenack" <andreas@canonical.com>,
 "Steve Dickson" <steved@redhat.com>, linux-nfs@vger.kernel.org,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Benjamin Coddington" <bcodding@redhat.com>,
 "Ben Hutchings" <benh@debian.org>
Subject: Re: [PATCH 0/2] Prefer generator to static systemd units
In-reply-to: <ZV0Jgs71NmIiUAVQ@eldamar.lan>
References:
 <CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com>,
 <ZPdErauSK2sXuh1T@eldamar.lan>, <ZV0Jgs71NmIiUAVQ@eldamar.lan>
Date: Wed, 22 Nov 2023 12:17:53 +1100
Message-id: <170061587302.7109.13249686228797355406@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 SEM_URIBL(3.50)[ubuntu.com:url];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, 22 Nov 2023, Salvatore Bonaccorso wrote:
> Hi Steve, Neil,
>=20
> On Tue, Sep 05, 2023 at 05:09:33PM +0200, Salvatore Bonaccorso wrote:
> > Hi Steve, Neil,
> >=20
> > On Fri, Jul 28, 2023 at 01:06:49PM -0300, Andreas Hasenack wrote:
> > > Hi,
> > >=20
> > > in Debian and Ubuntu, the configuration file /etc/nfs.conf is only
> > > placed on disk in the postinst script[1]. In this scenario it's possible
> > > to have the nfs-common generators run before /etc/nfs.conf exists[2],
> > > via another package's postinst calling systemctl daemon-reload. Since
> > > there is no /etc/nfs.conf yet, defaults are assumed and the generators
> > > exit silently, and the corresponding static units are used.
> > >=20
> > > But in Debian/Ubuntu, the rpc_pipefs directory is /run/rpc_pipefs, and
> > > not the one specified in the static units, and thus we get it mounted in
> > > the wrong directory.
> > >=20
> > > It seems best to always rely on the generators, as they will always be
> > > able to produce the correct target and mount units.
> > >=20
> > > For reference, this was first brought up in this thread[3].
> > >=20
> > > Producing an upstream set of patches was a bit confusing, since these
> > > systemd units are highly distro dependent. They are not even installed
> > > via `make install` because of this, so I have more confidence in the
> > > first patch of the series.
> > >=20
> > > I produced a Debian package with these two patches applied on top of
> > > Debian's 2.6.3[6], and ran the DEP8 tests of nfs-utils[4] and autofs[5],
> > > which exercise some simple v3 and v4 mounts, with and without kerberos.
> > > These tests passed[7][8] (ephemeral links, will be gone once the PPA is
> > > destroyed).
> > >=20
> > > 1. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/nfs-c=
ommon.postinst?h=3Dapplied/ubuntu/devel#n6
> > > 2. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/com=
ments/22
> > > 3. https://marc.info/?l=3Dlinux-nfs&m=3D165729895515639&w=3D4
> > > 4. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/tests=
?h=3Dapplied/ubuntu/lunar-devel
> > > 5. https://git.launchpad.net/ubuntu/+source/autofs/tree/debian/tests?h=
=3Dapplied/ubuntu/lunar-devel
> > > 6. https://code.launchpad.net/~ahasenack/ubuntu/+source/nfs-utils/+git/=
nfs-utils/+ref/upstream-nfs-utils-test
> > > 7. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-=
nfs-upstream-test/mantic/amd64/a/autofs/20230728_135149_0895b@/log.gz
> > > 8. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-=
nfs-upstream-test/mantic/amd64/n/nfs-utils/20230728_150122_3ef18@/log.gz
> > >=20
> > > Andreas Hasenack (2):
> > >   Always run the rpc_pipefs generator
> > >   Use the generated units instead of static ones
> > >=20
> > >  configure.ac                            |  8 +-------
> > >  systemd/Makefile.am                     |  5 -----
> > >  systemd/rpc-pipefs-generator.c          |  3 ---
> > >  systemd/rpc_pipefs.target               |  3 ---
> > >  systemd/rpc_pipefs.target.in            |  3 ---
> > >  systemd/var-lib-nfs-rpc_pipefs.mount    | 10 ----------
> > >  systemd/var-lib-nfs-rpc_pipefs.mount.in | 10 ----------
> > >  7 files changed, 1 insertion(+), 41 deletions(-)
> > >  delete mode 100644 systemd/rpc_pipefs.target
> > >  delete mode 100644 systemd/rpc_pipefs.target.in
> > >  delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount
> > >  delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount.in
> >=20
> > Is this patch series as prposed by Andreas acceptable upstream?
> >=20
> > We have this change in Debian since the 1:2.6.3-1 upload,
> > https://tracker.debian.org/news/1442835/accepted-nfs-utils-1263-1-source-=
into-unstable/,
> > with no regression reported TTBOMK.
> >=20
> > For reference, the patch series is here in the linux-nfs archives
> > (referencing it here explicitly as b4 mbox seems not to get all the 3
> > mails when requesting the cover letter):
> > https://lore.kernel.org/linux-nfs/CANYNYEEy2vf2rxLFeQ0hkstPrvF=3DeeA-joc0=
imGZt96Q+_r44w@mail.gmail.com/
> > https://lore.kernel.org/linux-nfs/CANYNYEFKtw+_Y-NrOoQt9G9eund2C0=3DXMrXB=
j8mt1L=3DebrSkLQ@mail.gmail.com/
> > https://lore.kernel.org/linux-nfs/CANYNYEHETbcqmEhE7BB57bCH03J-XT986Bb+Du=
cdpbV8KHeZug@mail.gmail.com/
>=20
> Anything we can do here, to have this upstreamed?=20
>=20
> Or is there something missing to make it possible?
>=20

Hi,
 thanks for being persistent....

 Allowing generators to run before /etc/nfs.conf exists seems like a bug...
 Maybe that situation could be improved a bit by having the package
 install some config directly into e.g. /etc/nfs.conf.d/rpc_pipe.conf

 Also I cannot see how we can "always rely on the generators" if they
 might be run before /etc/nfs.conf is created.

 However I agree that the current idiosyncratic behaviour, where
 sometimes the generator is and sometimes it isn't, is not good and
 bound to cause confusion.

 So I like the patches and think they should be applied.  I would
 probably combine them both into one as they are working in the same
 direction and having one without the other seems even less consistent.

 Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

