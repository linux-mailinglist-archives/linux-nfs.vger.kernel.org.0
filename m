Return-Path: <linux-nfs+bounces-6520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E397A741
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A451E1C21DBD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE24179654;
	Mon, 16 Sep 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hqEbiej7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA715852F
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510707; cv=none; b=QS5QfBRRDOyC7QA9fcUX2OPjDMkb6ojthcpczYHo4nCe6oAysQLcO71ku2Vy4Vbxf431s2MeQhay0lPWecQ2qZN08xoACGZ4GWwQxx12wDKysbAQxHxyJQeKjEk8GTN+KESAQOmS7LcFg5LZcOBISZFHyH0QYcy8PTmBT80Id1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510707; c=relaxed/simple;
	bh=a5KsG5MP/V5bdsnzcJlHF/3Gr9EY3xd1iRhvxFKlL4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S55N05oNJVqTxs2ZuGyZY74hbvf8vUKNbkWP2bhHTAbTGL9eSy4FxAiW1D5+xfFUVLKblrREtLkvWRhAH+y7OuPcyKWbH0HjE6iA45ZTZk1vRBSGonEaSjZZ7vEa8ATaDtVhqqYwbh8JtGsqDKiRJw5YhXf3inV3INKKaEwvzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hqEbiej7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xc854+f/jFrnUFz7tlmguTtPICZPzPWOxGq1VSnbFIo=; b=hqEbiej7NBUHNBODuFQuj7wnsI
	hcfQIBL7yzijeSNkqPYaD1+g1vzOPwh0R46pnoZtYhb4KzDCOQmFPcrM9JD/vzwj72oLEpnMEcYR5
	3/v/5+MxNAJ7e3BKkzeFhnQRMmLkkJk9hGmHv1MJGFmc2/z8K4KjPR545kH7C/kJK9saTmkREftc2
	EQtw7ZjTn0EA8p0N2D+DMoRwnIajmfOaH26353xXhPongA3LTlOU3ZpxCWpDWmxgjD67Xzj3PlQgS
	XaUzGh2YStHBixh4wWO4hyDi9x+7ddHraPKoYg0JCh9unIlxqIlEEE+CkertTtY8jKRPIdwdeMUnO
	JTy7xW6w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1sqGIj-009VUx-Rd; Mon, 16 Sep 2024 18:18:17 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 28D4EBE2DE0; Mon, 16 Sep 2024 20:18:16 +0200 (CEST)
Date: Mon, 16 Sep 2024 20:18:16 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sergio.Gelato@astro.su.se, Steve Dickson <steved@redhat.com>
Cc: Kevin Coffman <kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rpc.idmapd runs out of file descriptors
Message-ID: <Zuh2aG50e-cg3h81@eldamar.lan>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>
 <ZuU7S2Gli6oAALPJ@eldamar.lan>
 <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
 <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se>
 <ZuhR1bpMZmDWsNew@eldamar.lan>
 <ZuhovpK7Xhkuu3h9@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuhovpK7Xhkuu3h9@eldamar.lan>
X-Debian-User: carnil

Hi,

On Mon, Sep 16, 2024 at 07:19:58PM +0200, Salvatore Bonaccorso wrote:
> Hi all,
> 
> On Mon, Sep 16, 2024 at 05:42:13PM +0200, Salvatore Bonaccorso wrote:
> > Hi all,
> > 
> > On Mon, Sep 16, 2024 at 02:28:50PM +0200, Sergio.Gelato@astro.su.se wrote:
> > > On Mon, Sep 16, 2024 at 01:54:35PM +0200, Steve Dickson wrote:
> > > > It did because it was not in the appropriate format... The patch
> > > > was an attachment, not in-line, no  Signed-off-by: line and
> > > > the patch was not create by git format-patch command (which
> > > > adds PATCH in the subject line).
> > > 
> > > I see no mention of formatting requirements at
> > > https://www.linux-nfs.org/wiki/index.php/Reporting_bugs
> > > (not even by reference to the Linux kernel tree).
> > 
> > Thank you all for looking into it. Steve, do you need to have it
> > re-submitted in a git format-patch format? At least a Signed-off-by
> > line by Sergio would be needed in my understanding.
> 
> I guess otherwise we can use soemthing like the following though a
> Signed-off-by is probably not right here, or is it enough if I say
> Reported-by: and Patch-originally-by: although the later is not an
> official kernel doc mentioned tag?

And then one seems to be able to do so many mistakes around one patch.
Here is an improved version (v2), fixing a typo in the Link reference
and using a Closes: tag after the Reported-by:

This now should be better than the previous one.

Regards,
Salvatore

From 46989ce210d27dbb3ad89095030c687db70c78be Mon Sep 17 00:00:00 2001
From: Sergio Gelato <Sergio.Gelato@astro.su.se>
Date: Tue, 4 Jun 2024 16:02:59 +0200
Subject: [PATCH v2] rpc.idmapd: nfsopen() failures should not be fatal

dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
Some of these directories contain /idmap files, others don't. nfsopen()
returns -1 for the latter; we then want to skip the directory, not abort
the entire scan.

Reported-by: Sergio Gelato <sergio.gelato@astro.su.se>
Closes: https://lore.kernel.org/linux-nfs/ZmCB_zqdu2cynJ1M@astro.su.se/
Link: https://bugs.debian.org/1072573
Patch-originally-by: Sergio Gelato <sergio.gelato@astro.su.se>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
Changes in v2:
- Fix typo in URL for Debian bug reference
- Reorder patch tags and use Closes tag after Reported-by

 utils/idmapd/idmapd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index cd9a965f8fbc..5231f56d24a8 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
 			if (nfsopen(ic) == -1) {
 				close(ic->ic_dirfd);
 				free(ic);
-				goto out;
+				continue;
 			}
 
 			if (verbose > 2)
-- 
2.45.2


