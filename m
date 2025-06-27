Return-Path: <linux-nfs+bounces-12802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF92AEAF11
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 08:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0320D560F31
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE78212FBE;
	Fri, 27 Jun 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="OASwFf43"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDF2F3E
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006283; cv=none; b=hVKsOogJezUQ/ao3m2wijtjvoywhA9kXpawzjLelsKxGYQ7gFOQrpx7tpUGsC8PNs0fxSDFCoZLhV50P4FP0MLIggh2L1PotgM/HNoxgZxQbFFFXDWvDR5ZZDM91n0lvXdRGaAoOGH22OIGWCjbcoopaTls1/nG8j1qz1dXPMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006283; c=relaxed/simple;
	bh=8aEIiEExHIiOZW81kfkBZYF4oztHEz1vL9useAbrl3s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JSbVvHbc8kEOm6ABv6zU7iItDEjk9OeSrAWCie9QKkM9Gu+/IJAi+Gdgv9Tsd6Qia9OfveFTjS8Is18OffqzO8VaraUGa1l50mERKxSL/m0aiSAZqPrXy0fW1d1yVxHZ1yd4DIexoz9d6CDLZUIOuekxvdBi9goyB8GGKdHyF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=OASwFf43; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id C99F613F651
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 08:37:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de C99F613F651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1751006272; bh=O26z/BdBpuZ6SUZjoIyFTOeSBRIRGg3IIEP2T83P6Hw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OASwFf43sG+k6Q9utQM2dM8qSkttryW606tLbndlJEOA2Q7kM+j3ALrEFO8KBeJwr
	 1+J3YWJQGC70M2Poz6NS4wjewVxYIxGcCcURDiQ7YhYoAoaz8Ve+G6LnrvXTy0nBZ3
	 bmnDylcaLMqgPrj6drXNzNE6otRTYnI9CNPxQLjs=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id BC1FA120043;
	Fri, 27 Jun 2025 08:37:52 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id AA81916003F;
	Fri, 27 Jun 2025 08:37:52 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 44E43320093;
	Fri, 27 Jun 2025 08:37:50 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 893E22004C;
	Fri, 27 Jun 2025 08:37:50 +0200 (CEST)
Date: Fri, 27 Jun 2025 08:37:50 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: kernel test robot <lkp@intel.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Message-ID: <2024057888.423104.1751006270267.JavaMail.zimbra@desy.de>
In-Reply-To: <202506270701.wUk38xC4-lkp@intel.com>
References: <20250626091202.130567-1-tigran.mkrtchyan@desy.de> <202506270701.wUk38xC4-lkp@intel.com>
Subject: Re: [PATCH] pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_423105_962662865.1751006270440"
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4784)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: k2tgoQPfb0fk10AGxU0g9t+pS0kk0w==

------=_Part_423105_962662865.1751006270440
Date: Fri, 27 Jun 2025 08:37:50 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: kernel test robot <lkp@intel.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Message-ID: <2024057888.423104.1751006270267.JavaMail.zimbra@desy.de>
In-Reply-To: <202506270701.wUk38xC4-lkp@intel.com>
References: <20250626091202.130567-1-tigran.mkrtchyan@desy.de> <202506270701.wUk38xC4-lkp@intel.com>
Subject: Re: [PATCH] pNFS/flexfiles: don't attempt pnfs on fatal DS errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4784)
Thread-Topic: pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Thread-Index: k2tgoQPfb0fk10AGxU0g9t+pS0kk0w==

Thank you, robot!

----- Original Message -----
> From: "kernel test robot" <lkp@intel.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker"
> <anna@kernel.org>, "root max-exfl020" <root@max-exfl020.desy.de>, "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Sent: Friday, 27 June, 2025 01:42:33
> Subject: Re: [PATCH] pNFS/flexfiles: don't attempt pnfs on fatal DS errors

> Hi Tigran,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on trondmy-nfs/linux-next]
> [also build test WARNING on linus/master v6.16-rc3 next-20250626]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:
> https://github.com/intel-lab-lkp/linux/commits/Tigran-Mkrtchyan/pNFS-flexfiles-don-t-attempt-pnfs-on-fatal-DS-errors/20250626-171336
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> patch link:
> https://lore.kernel.org/r/20250626091202.130567-1-tigran.mkrtchyan%40desy.de
> patch subject: [PATCH] pNFS/flexfiles: don't attempt pnfs on fatal DS errors
> config: i386-buildonly-randconfig-005-20250627
> (https://download.01.org/0day-ci/archive/20250627/202506270701.wUk38xC4-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project
> 6146a88f60492b520a36f8f8f3231e15f3cc6082)
> reproduce (this is a W=1 build):
> (https://download.01.org/0day-ci/archive/20250627/202506270701.wUk38xC4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes:
>| https://lore.kernel.org/oe-kbuild-all/202506270701.wUk38xC4-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>   fs/nfs/flexfilelayout/flexfilelayoutdev.c:56:9: warning: variable 'ret' set but
>   not used [-Wunused-but-set-variable]
>      56 |         int i, ret = -ENOMEM;
>         |                ^
>>> fs/nfs/flexfilelayout/flexfilelayoutdev.c:379:6: warning: variable 'status' is
>>> used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>     379 |         if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/nfs/flexfilelayout/flexfilelayoutdev.c:421:15: note: uninitialized use occurs
>   here
>     421 |         ds = ERR_PTR(status);
>         |                      ^~~~~~
>   fs/nfs/flexfilelayout/flexfilelayoutdev.c:379:2: note: remove the 'if' if its
>   condition is always false
>     379 |         if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     380 |                 goto noconnect;
>         |                 ~~~~~~~~~~~~~~
>   fs/nfs/flexfilelayout/flexfilelayoutdev.c:377:12: note: initialize the variable
>   'status' to silence this warning
>     377 |         int status;
>         |                   ^
>         |                    = 0
>   2 warnings generated.
> 
> 
> vim +379 fs/nfs/flexfilelayout/flexfilelayoutdev.c
> 
> cefa587a40bb53 Trond Myklebust       2019-02-28  350
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  351  /**
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  352   *
> nfs4_ff_layout_prepare_ds - prepare a DS connection for an RPC call
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  353   * @lseg: the layout
> segment we're operating on
> 2444ff277a686d Trond Myklebust       2019-02-14  354   * @mirror: layout mirror
> describing the DS to use
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  355   * @fail_return: return
> layout on connect failure?
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  356   *
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  357   * Try to prepare a DS
> connection to accept an RPC call. This involves
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  358   * selecting a mirror to
> use and connecting the client to it if it's not
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  359   * already connected.
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  360   *
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  361   * Since we only need a
> single functioning mirror to satisfy a read, we don't
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  362   * want to return the
> layout if there is one. For writes though, any down
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  363   * mirror should result in
> a LAYOUTRETURN. @fail_return is how we distinguish
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  364   * between the two cases.
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  365   *
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  366   * Returns a pointer to a
> connected DS object on success or NULL on failure.
> 95e2b7e95d43c5 Jeff Layton           2016-05-17  367   */
> d67ae825a59d63 Tom Haynes            2014-12-11  368  struct nfs4_pnfs_ds *
> 2444ff277a686d Trond Myklebust       2019-02-14  369
> nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
> 2444ff277a686d Trond Myklebust       2019-02-14  370  			  struct
> nfs4_ff_layout_mirror *mirror,
> d67ae825a59d63 Tom Haynes            2014-12-11  371  			  bool fail_return)
> d67ae825a59d63 Tom Haynes            2014-12-11  372  {
> 6468b866bac7de root max-exfl020      2025-06-26  373  	struct nfs4_pnfs_ds *ds =
> ERR_PTR(-EAGAIN);
> d67ae825a59d63 Tom Haynes            2014-12-11  374  	struct inode *ino =
> lseg->pls_layout->plh_inode;
> d67ae825a59d63 Tom Haynes            2014-12-11  375  	struct nfs_server *s =
> NFS_SERVER(ino);
> d67ae825a59d63 Tom Haynes            2014-12-11  376  	unsigned int max_payload;
> a33e4b036d4612 Weston Andros Adamson 2017-03-09  377  	int status;
> d67ae825a59d63 Tom Haynes            2014-12-11  378
> cefa587a40bb53 Trond Myklebust       2019-02-28 @379  	if
> (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
> 0a156dd58274b0 Trond Myklebust       2019-02-27  380  		goto noconnect;
> d67ae825a59d63 Tom Haynes            2014-12-11  381
> d67ae825a59d63 Tom Haynes            2014-12-11  382  	ds =
> mirror->mirror_ds->ds;
> a2915fa06227b0 Baptiste Lepers       2021-09-06  383  	if
> (READ_ONCE(ds->ds_clp))
> a2915fa06227b0 Baptiste Lepers       2021-09-06  384  		goto out;
> d67ae825a59d63 Tom Haynes            2014-12-11  385  	/* matching smp_wmb() in
> _nfs4_pnfs_v3/4_ds_connect */
> d67ae825a59d63 Tom Haynes            2014-12-11  386  	smp_rmb();
> d67ae825a59d63 Tom Haynes            2014-12-11  387
> d67ae825a59d63 Tom Haynes            2014-12-11  388  	/* FIXME: For now we
> assume the server sent only one version of NFS
> d67ae825a59d63 Tom Haynes            2014-12-11  389  	 * to use for the DS.
> d67ae825a59d63 Tom Haynes            2014-12-11  390  	 */
> 2444ff277a686d Trond Myklebust       2019-02-14  391  	status =
> nfs4_pnfs_ds_connect(s, ds, &mirror->mirror_ds->id_node,
> 2444ff277a686d Trond Myklebust       2019-02-14  392  			     dataserver_timeo,
> dataserver_retrans,
> d67ae825a59d63 Tom Haynes            2014-12-11  393
> 			     mirror->mirror_ds->ds_versions[0].version,
> 7d38de3ffa75f9 Anna Schumaker        2016-11-17  394
> 			     mirror->mirror_ds->ds_versions[0].minor_version);
> d67ae825a59d63 Tom Haynes            2014-12-11  395
> d67ae825a59d63 Tom Haynes            2014-12-11  396  	/* connect success, check
> rsize/wsize limit */
> 260f32adb88dad Trond Myklebust       2017-04-20  397  	if (!status) {
> d488b9d01fbc2f Trond Myklebust       2024-09-05  398  		/*
> d488b9d01fbc2f Trond Myklebust       2024-09-05  399  		 * ds_clp is put in
> destroy_ds().
> d488b9d01fbc2f Trond Myklebust       2024-09-05  400  		 * keep ds_clp even if
> DS is local, so that if local IO cannot
> d488b9d01fbc2f Trond Myklebust       2024-09-05  401  		 * proceed somehow, we
> can fall back to NFS whenever we want.
> d488b9d01fbc2f Trond Myklebust       2024-09-05  402  		 */
> 1ff4716f420b5a Mike Snitzer          2025-05-13  403
> 		nfs_local_probe_async(ds->ds_clp);
> d67ae825a59d63 Tom Haynes            2014-12-11  404  		max_payload =
> d67ae825a59d63 Tom Haynes            2014-12-11  405
> 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
> d67ae825a59d63 Tom Haynes            2014-12-11  406  				       NULL);
> d67ae825a59d63 Tom Haynes            2014-12-11  407  		if
> (mirror->mirror_ds->ds_versions[0].rsize > max_payload)
> d67ae825a59d63 Tom Haynes            2014-12-11  408
> 			mirror->mirror_ds->ds_versions[0].rsize = max_payload;
> d67ae825a59d63 Tom Haynes            2014-12-11  409  		if
> (mirror->mirror_ds->ds_versions[0].wsize > max_payload)
> d67ae825a59d63 Tom Haynes            2014-12-11  410
> 			mirror->mirror_ds->ds_versions[0].wsize = max_payload;
> 3dc147359e3dcd Trond Myklebust       2016-08-29  411  		goto out;
> 3dc147359e3dcd Trond Myklebust       2016-08-29  412  	}
> 0a156dd58274b0 Trond Myklebust       2019-02-27  413  noconnect:
> d67ae825a59d63 Tom Haynes            2014-12-11  414
> 	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
> d67ae825a59d63 Tom Haynes            2014-12-11  415  				 mirror,
> lseg->pls_range.offset,
> d67ae825a59d63 Tom Haynes            2014-12-11  416
> 				 lseg->pls_range.length, NFS4ERR_NXIO,
> d67ae825a59d63 Tom Haynes            2014-12-11  417  				 OP_ILLEGAL,
> GFP_NOIO);
> f0922a6c0cdb92 Trond Myklebust       2019-02-10  418
> 	ff_layout_send_layouterror(lseg);
> 094069f1d96f69 Jeff Layton           2016-05-17  419  	if (fail_return ||
> !ff_layout_has_available_ds(lseg))
> d67ae825a59d63 Tom Haynes            2014-12-11  420
> 		pnfs_error_mark_layout_for_return(ino, lseg);
> 6468b866bac7de root max-exfl020      2025-06-26  421  	ds = ERR_PTR(status);
> d67ae825a59d63 Tom Haynes            2014-12-11  422  out:
> d67ae825a59d63 Tom Haynes            2014-12-11  423  	return ds;
> d67ae825a59d63 Tom Haynes            2014-12-11  424  }
> d67ae825a59d63 Tom Haynes            2014-12-11  425
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

------=_Part_423105_962662865.1751006270440
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIH
XzCCBUegAwIBAgIQGrSZ0tLzGu9JoeeaXGroSzANBgkqhkiG9w0BAQwFADBVMQswCQYDVQQGEwJO
TDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA0QjAeFw0yNDEyMDQwOTQzMjZaFw0yNjAxMDMwOTQzMjZaMIGpMRMwEQYK
CZImiZPyLGQBGRMDb3JnMRYwFAYKCZImiZPyLGQBGRMGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRMD
dGNzMQswCQYDVQQGEwJERTEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEoMCYGA1UEAwwfVGlncmFuIE1rcnRjaHlhbiB0aWdyYW5AZGVzeS5kZTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKZ1aJleygPW8bRzYJ3VfXwfY2TxAF0QUuTk/6Bqu8Bi
UQjIgmBQ1hCzz8DVdJ8saw7p5/c1JDmVHqm2DJPwXLROKACiDdSHPf+N8PFZvxHxOqFNPeO/oJhO
jHXG1c/tL8ElfiUlMtEZYtoS60/VUz3A/4FIWP2A5s/UIOSZyCcKz3AUcAanHGEJVS8oWKQj7pNX
yjojvX4aPHzsKP+c+c/5wq08/aziRXLCekhKk+VdS8lhlS/3AL1G0VSWKj5/pOpz4ozmv44GEw9z
FAsPWuTcLXqCX993BOoWAyQDcygAsb0nQQMzx+4wlSGsI31/gKOE5ZOJ3SErWDswgzxWm8Xht/Kl
ymDHPXi8P0ohQjJrQRpJXVwD/tXDwSSbWP9jnVbtqpvLLBkNrSy6elW19nkE1ObpSPcn+be5hs1P
59Y+GPudytAQ3MOoFoNd7kxpVQoM6cdQjRHdyIDbavZrdxr33s7uqSbcI/PE8W5M0iPNnd4ip4kH
UIOdpsjk7b7kEdO4Jf9dDrz/fduAEaW+AUTfb+G42LiftUBXkANa50nOseW3tocadYOTySufN9or
IwvcQ/1uemVd83On7k8bWevfU159x28aidxv8liqJXrrT28tp/QxtGtDXjo9jdkWi/5d/9XfqQgN
IT7KH42fc3ZlaL3pLuJwEQWVtFnWUTRJAgMBAAGjggHUMIIB0DAfBgNVHSMEGDAWgBQQMuoC4vzP
6lYlVIfDmPXog9bFJDAOBgNVHQ8BAf8EBAMCBaAwCQYDVR0TBAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwRQYDVR0gBD4wPDAMBgoqhkiG90wFAgIFMA0GCyqGSIb3TAUCAwMDMA0G
CyqGSIb3TAUCAwECMA4GDCsGAQQBgcRaAgMCAjBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vY3Js
LmVudGVycHJpc2Uuc2VjdGlnby5jb20vR0VBTlRUQ1NBdXRoZW50aWNhdGlvblJTQUNBNEIuY3Js
MIGRBggrBgEFBQcBAQSBhDCBgTBPBggrBgEFBQcwAoZDaHR0cDovL2NydC5lbnRlcnByaXNlLnNl
Y3RpZ28uY29tL0dFQU5UVENTQXV0aGVudGljYXRpb25SU0FDQTRCLmNydDAuBggrBgEFBQcwAYYi
aHR0cDovL29jc3AuZW50ZXJwcmlzZS5zZWN0aWdvLmNvbTAjBgNVHREEHDAagRh0aWdyYW4ubWty
dGNoeWFuQGRlc3kuZGUwHQYDVR0OBBYEFMmhx6vILo+tVVV6rojJTwL+t2eGMA0GCSqGSIb3DQEB
DAUAA4ICAQARKKJEO1G3lIe+AA+E3pl5mNYs/+XgswX1316JYDRzBnfVweMR6IaOT7yrP+Mwhx3v
yiM8VeSVFtfyLlV6FaHAxNFo5Z19L++g/FWWAg0Wz13aFaEm0+KEp8RkB/Mh3EbSukZxUqmWCgrx
zmx+I5zlX8pLxNgrxcc1WW5l7Y7y2sci++W6wE/L7rgMuznqiBLw/qwnkXAeQrw2PIllAGwRqrwa
37kPa+naT1P0HskuBFHQSmMihB5HQl6+2Rs9M5RMW3/IlUQAqkhZQGBXmiWDivjPFKXJQnCmhQmh
76sOcSOScfzYI5xOD+ZGdBRRufkUxaXJ2G//IgkK2R8mqrFEXxBFaBMc0uMBJHKNv+FO7H6VPOe9
BD9FwfLiqWvGwKJrF11Bk/QSfWh+zCJ8JHPAi6irwQO4Xf+0xhPsxb+jBfKK3I84YMf6zsDkdDzH
lkNPhDh4xhYhEAk+L228pjTEmnbb2QVv52grZ0dbITuN+Hz2ypvLfaS8p06lrht45COlkmuIUVqp
bsc3kRt610qwXSjYcc8zeCQI0Rqnnq+0UN5T0KU7JSzUho6vaTSUG57uc7b3DkIW2Z9VpXX5xKb/
vfl++jC5JzKrbCeS+QOStpXwwaH62IUHwdfWfkvpzb8EFALEmCvu8nlT9NaqYlB/xogMH6oHBm+Y
nxmRQxWROAAAMYIDZTCCA2ECAQEwaTBVMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRpY2F0aW9uIFJTQSBDQSA0QgIQGrSZ
0tLzGu9JoeeaXGroSzANBglghkgBZQMEAgEFAKCBzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MjcwNjM3NTBaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIHCgLcbGkyVronmwretXYOd41aO7
ErcaN8xMiG37R64WMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICABae2U+UHn7ZvNH/4vvubNHYZ/+qcgJ6PznlBhyC
vfFRoNDFLAf77Zp3wdSaeBTcg5B4XVkl1gzdqjo3o/fBbkYaT4u0rPB1odMR0gU6glrH141aruyo
cq6/wtr+ZsQrd1JRq6oeK0MlXJbtV9XNeqSmhG7oKga/YK4jcfUQVJ3EnAwrzsQ0IGSPDsfDse34
CwIcFpR0Gvlxz0Bs6i5gV8XHT1kmTrLvE3ddoqMXdTYZdFlnXdaqP8dEjKJsbPc/1EfffLh6Uwyn
Q2FuxxPTHMh8+ywAiLFrZamHLvbfxEJz7hr6yHwnYrTFYLieHHrLsg8teSoFYaJ5DCCQcu9ltAoV
Nfr3M7epd8aiDw1WjdZOyzw4TLWp1anq581eZjha5h5JtIsmzyiuJ71WUZZwCZhzT8u5uKueFS/a
MHRIfxLy7/PqMLPY7hqMl63jcYBkYsNJi50JR6avVQZfiV73cjg/gfpPUQx1SxQGoN365j2FxK6r
dB9l6w66wV8/EoQ/DSCO50ZRDfV1RG5gQkAbG2Noco59tPAZP2Dvt2SObEEP3X+3+yNx8KauYaRO
DhogY1PmuQam5yAYc5mSyxNCN6BGmM27bDKy7JzsuTVqsNSxvJI7sU+4FnW43HAE9W4bFGQuIEob
FZCV5UXI+wn7wyoszcm0+8V7B/W/mw7ho8+sAAAAAAAA
------=_Part_423105_962662865.1751006270440--

