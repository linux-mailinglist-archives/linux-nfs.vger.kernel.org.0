Return-Path: <linux-nfs+bounces-14162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD2B50A8F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 03:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F45640B6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC071FAC42;
	Wed, 10 Sep 2025 01:54:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243C2033A
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469284; cv=none; b=Up7Abc3qRp4vzTzXRPDL4TuHOfk+o0IxSrHRZfbXORmBtkzgwO39MB6hHx27fJ6xJZ4Fhmwyqg3p88dGBwcn460hRcEPv3lnzXyyfqtviHG486s3EBD08vKhE/qYfL/g04c3WjVZK7xCitSaH2oGf5EB7GFW53Om4vJTH1r4lpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469284; c=relaxed/simple;
	bh=DewKSWTJOytStfDiOsZFIVcc1H9vYwPgrk2Yo20aCy0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qfAhkItFzbNAGJ7ZSZs6zUezJNbvYdIKAorigOH7i2VOU/oYgxsE1MmeUPYrE3Lpe+Y8GREqemF3xxC5UwjGm1NV25xJjD2Wnr3juAYxRtM415YE4bWxClrI7fEYSOrpTdl5/Bpoy8IUA++VRBsHiPAtGDJ7Q99CwBoKm6Ka4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwA2f-008tVx-E7;
	Wed, 10 Sep 2025 01:54:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
In-reply-to: <7a7feb18-a24b-432d-918b-8dbe44af51c9@oracle.com>
References: <>, <7a7feb18-a24b-432d-918b-8dbe44af51c9@oracle.com>
Date: Wed, 10 Sep 2025 11:54:38 +1000
Message-id: <175746927890.2850467.11462085063594405629@noble.neil.brown.name>

On Wed, 10 Sep 2025, Chuck Lever wrote:
> On 9/9/25 7:39 PM, Chuck Lever wrote:
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 441267d877f9..9665454743eb 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1074,6 +1074,79 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
> >>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err=
);
> >>  }
> >> =20
> >> +/*
> >> + * The byte range of the client's READ request is expanded on both
> >> + * ends until it meets the underlying file system's direct I/O
> >> + * alignment requirements. After the internal read is complete, the
> >> + * byte range of the NFS READ payload is reduced to the byte range
> >> + * that was originally requested.
> >> + *
> >> + * Note that a direct read can be done only when the xdr_buf
> >> + * containing the NFS READ reply does not already have contents in
> >> + * its .pages array. This is due to potentially restrictive
> >> + * alignment requirements on the read buffer. When .page_len and
> >> + * @base are zero, the .pages array is guaranteed to be page-
> >> + * aligned.
> > Where do we test that this condition is met?
> >=20
> > I can see that nfsd_direct_read() is only called if "base" is zero, but
> > that means the current contents of the .pages array are page-aligned,
> > not that there are now.
>=20
> The above comment might be stale; I'm not sure the .page_len test is
> necessary. As long as the payload starts on a page boundary, it should
> meet most any plausible buffer alignment restriction.
>=20
> However, if there are additional restrictions needed, checks can be
> added in nfsd_iter_read() just before nfsd_direct_read() is called.

I think that current test against rq_maxpages (in the WARN_ON) only
makes sense if .page_len was zero.

NeilBrown


>=20
>=20
> --=20
> Chuck Lever
>=20


