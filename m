Return-Path: <linux-nfs+bounces-19-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA47F36EC
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 20:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CA12818A6
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5034205B;
	Tue, 21 Nov 2023 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="V7yNrwOZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56274197
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ge7gY6O2uZN2HTf9u5kTM3qGLDAdhKQje5WyGcm+Izo=; b=V7yNrwOZbkDVU/lgoFU3Fif+a/
	bx55adSS8wijE3sB0y8r9ak7/q1WNPpBlg2BBBGnYyplQULsFxjjNthFRvYPUONbJWkrehrFRizwU
	A0pfTaytUHgfU35yxCejl0o+CTSIh9xo8NQcsFsHe+uOdd7DCPiArTKN7NfABmHhOWJcs8lx5sfcb
	mg+g27rgAq49NWw+vzG9czuQOKPmEkwlJ++8qeM/yN39uqAFWk/DnqysJS5AHc2WZ0QfS2iiUkkZd
	sZQhqW6KVEPZ4oLMVnqKhwOdRX1U0SgIJq0O8Z0p5s7Ny2e6KwsNdlNGhRPk3lPU9TLWFlhDVRm/F
	chnXEsuw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1r5WjM-0055jz-4h; Tue, 21 Nov 2023 19:48:22 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 820B4BE2DE0; Tue, 21 Nov 2023 20:48:18 +0100 (CET)
Date: Tue, 21 Nov 2023 20:48:18 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Andreas Hasenack <andreas@canonical.com>, NeilBrown <neilb@suse.de>,
	Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 0/2] Prefer generator to static systemd units
Message-ID: <ZV0Jgs71NmIiUAVQ@eldamar.lan>
References: <CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com>
 <ZPdErauSK2sXuh1T@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPdErauSK2sXuh1T@eldamar.lan>
X-Debian-User: carnil

Hi Steve, Neil,

On Tue, Sep 05, 2023 at 05:09:33PM +0200, Salvatore Bonaccorso wrote:
> Hi Steve, Neil,
> 
> On Fri, Jul 28, 2023 at 01:06:49PM -0300, Andreas Hasenack wrote:
> > Hi,
> > 
> > in Debian and Ubuntu, the configuration file /etc/nfs.conf is only
> > placed on disk in the postinst script[1]. In this scenario it's possible
> > to have the nfs-common generators run before /etc/nfs.conf exists[2],
> > via another package's postinst calling systemctl daemon-reload. Since
> > there is no /etc/nfs.conf yet, defaults are assumed and the generators
> > exit silently, and the corresponding static units are used.
> > 
> > But in Debian/Ubuntu, the rpc_pipefs directory is /run/rpc_pipefs, and
> > not the one specified in the static units, and thus we get it mounted in
> > the wrong directory.
> > 
> > It seems best to always rely on the generators, as they will always be
> > able to produce the correct target and mount units.
> > 
> > For reference, this was first brought up in this thread[3].
> > 
> > Producing an upstream set of patches was a bit confusing, since these
> > systemd units are highly distro dependent. They are not even installed
> > via `make install` because of this, so I have more confidence in the
> > first patch of the series.
> > 
> > I produced a Debian package with these two patches applied on top of
> > Debian's 2.6.3[6], and ran the DEP8 tests of nfs-utils[4] and autofs[5],
> > which exercise some simple v3 and v4 mounts, with and without kerberos.
> > These tests passed[7][8] (ephemeral links, will be gone once the PPA is
> > destroyed).
> > 
> > 1. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/nfs-common.postinst?h=applied/ubuntu/devel#n6
> > 2. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/comments/22
> > 3. https://marc.info/?l=linux-nfs&m=165729895515639&w=4
> > 4. https://git.launchpad.net/ubuntu/+source/nfs-utils/tree/debian/tests?h=applied/ubuntu/lunar-devel
> > 5. https://git.launchpad.net/ubuntu/+source/autofs/tree/debian/tests?h=applied/ubuntu/lunar-devel
> > 6. https://code.launchpad.net/~ahasenack/ubuntu/+source/nfs-utils/+git/nfs-utils/+ref/upstream-nfs-utils-test
> > 7. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-nfs-upstream-test/mantic/amd64/a/autofs/20230728_135149_0895b@/log.gz
> > 8. https://autopkgtest.ubuntu.com/results/autopkgtest-mantic-ahasenack-nfs-upstream-test/mantic/amd64/n/nfs-utils/20230728_150122_3ef18@/log.gz
> > 
> > Andreas Hasenack (2):
> >   Always run the rpc_pipefs generator
> >   Use the generated units instead of static ones
> > 
> >  configure.ac                            |  8 +-------
> >  systemd/Makefile.am                     |  5 -----
> >  systemd/rpc-pipefs-generator.c          |  3 ---
> >  systemd/rpc_pipefs.target               |  3 ---
> >  systemd/rpc_pipefs.target.in            |  3 ---
> >  systemd/var-lib-nfs-rpc_pipefs.mount    | 10 ----------
> >  systemd/var-lib-nfs-rpc_pipefs.mount.in | 10 ----------
> >  7 files changed, 1 insertion(+), 41 deletions(-)
> >  delete mode 100644 systemd/rpc_pipefs.target
> >  delete mode 100644 systemd/rpc_pipefs.target.in
> >  delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount
> >  delete mode 100644 systemd/var-lib-nfs-rpc_pipefs.mount.in
> 
> Is this patch series as prposed by Andreas acceptable upstream?
> 
> We have this change in Debian since the 1:2.6.3-1 upload,
> https://tracker.debian.org/news/1442835/accepted-nfs-utils-1263-1-source-into-unstable/,
> with no regression reported TTBOMK.
> 
> For reference, the patch series is here in the linux-nfs archives
> (referencing it here explicitly as b4 mbox seems not to get all the 3
> mails when requesting the cover letter):
> https://lore.kernel.org/linux-nfs/CANYNYEEy2vf2rxLFeQ0hkstPrvF=eeA-joc0imGZt96Q+_r44w@mail.gmail.com/
> https://lore.kernel.org/linux-nfs/CANYNYEFKtw+_Y-NrOoQt9G9eund2C0=XMrXBj8mt1L=ebrSkLQ@mail.gmail.com/
> https://lore.kernel.org/linux-nfs/CANYNYEHETbcqmEhE7BB57bCH03J-XT986Bb+DucdpbV8KHeZug@mail.gmail.com/

Anything we can do here, to have this upstreamed? 

Or is there something missing to make it possible?

Regards,
Salvatore

