Return-Path: <linux-nfs+bounces-13422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA65B1AB0F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 00:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D26B18A28FA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9223C8AE;
	Mon,  4 Aug 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkOdZnu0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EB23B0
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347867; cv=none; b=EmzNnwvm2GB7nerESOEtImu2JvWNhEhFqYIJV1J/bZgQh1or5+XzAPWJw/2JIVrixOKJ13DSs8JMeNd+aeETaI+TUlaBMwLzrBLJJm8We5Ndge+S8nkYZRbEX7xGOjVRZKYaGOP1wPILLB+QrhcMwC0kGD+Ci7XAWSWY110ug20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347867; c=relaxed/simple;
	bh=G5O+IfH+3PNo3xxSwcjkAR+5t80OUR7AvYXEsix5Hww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4o/8CmQy4hHhCt+lI++w+CxXWNovCSWyjS1tZszUuQMGWKsG64XdF89T4bJfH2pR4XwMnkmuUSuy+M+PSfPRjyEsA0/Z5HP9SlVIDXi5aXBfo+X6uts0wRNmu8tLT0Gf71Yd86qz5ow4fwXhn2VB5PLpG46NMDJrRFkp3YL3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkOdZnu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B57BC4CEE7;
	Mon,  4 Aug 2025 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754347867;
	bh=G5O+IfH+3PNo3xxSwcjkAR+5t80OUR7AvYXEsix5Hww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkOdZnu0HqxqzF3zyyFbcKLonuSqnvYPBu3Jc7fQ10MTV6iEhBhMMqpfUQbysx1M+
	 jntEdkWFU+L9DxQfCs6T7i1bhYCweFhCRirZnPGJgl0gXfDjByxkqX7FEfXS/N2WQt
	 JImyYdBqZx9BNaA5F4nkZ0MVqN5Yq7my5ubBPaDHkDdcHazzRfAGlHFy4MHcEV4otU
	 Ffnh+4h4ReuTq2q7OSoUeIlxqTx2CTx7IM/67z82bE02qyzVbUOh3Hupn9P7Fiaukr
	 dxktbic5Ex3PiDQbWhaSYRfI5vbYQcb8hzqOimsjR9omZrCcCVCIwuIfAlmuUYn3Uv
	 aLKO95o9l4g9g==
Date: Mon, 4 Aug 2025 22:51:05 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] nfsd: Replace open-coded conversion of bytes to hex
Message-ID: <20250804225105.GB54248@google.com>
References: <20250803212448.117174-1-ebiggers@kernel.org>
 <360b8b4e-b8fc-4d21-84a9-2b908719d348@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360b8b4e-b8fc-4d21-84a9-2b908719d348@oracle.com>

On Mon, Aug 04, 2025 at 10:01:49AM -0400, Chuck Lever wrote:
> On 8/3/25 5:24 PM, Eric Biggers wrote:
> > Since the Linux kernel's sprintf() has conversion to hex built-in via
> > "%*phN", delete md5_to_hex() and just use that.  Also add an explicit
> > array bound to the dname parameter of nfs4_make_rec_clidname() to make
> > its size clear.  No functional change.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  fs/nfsd/nfs4recover.c | 18 ++----------------
> >  1 file changed, 2 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 2231192ec33f5..54f5e5392ef9d 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -90,26 +90,12 @@ static void
> >  nfs4_reset_creds(const struct cred *original)
> >  {
> >  	put_cred(revert_creds(original));
> >  }
> >  
> > -static void
> > -md5_to_hex(char *out, char *md5)
> > -{
> > -	int i;
> > -
> > -	for (i=0; i<16; i++) {
> > -		unsigned char c = md5[i];
> > -
> > -		*out++ = '0' + ((c&0xf0)>>4) + (c>=0xa0)*('a'-'9'-1);
> > -		*out++ = '0' + (c&0x0f) + ((c&0x0f)>=0x0a)*('a'-'9'-1);
> > -	}
> > -	*out = '\0';
> > -}
> > -
> >  static int
> > -nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
> > +nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
> >  {
> >  	struct xdr_netobj cksum;
> >  	struct crypto_shash *tfm;
> >  	int status;
> >  
> > @@ -131,11 +117,11 @@ nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
> >  	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
> >  					 cksum.data);
> >  	if (status)
> >  		goto out;
> >  
> > -	md5_to_hex(dname, cksum.data);
> > +	sprintf(dname, "%*phN", 16, cksum.data);
> 
> Hello Eric,
> 
> Can the raw "16" be replaced with "HEXDIR_LEN / 2" ?
> 
> 
> >  	status = 0;
> >  out:
> >  	kfree(cksum.data);
> >  	crypto_free_shash(tfm);
> > 
> > base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994

It's the same 16 as was there before.  It really should be
MD5_DIGEST_SIZE, but there are a few more things to clean up regarding
that.  I didn't want to bloat the scope of this patch.

I sent a new series with this patch unchanged, but the digest size stuff
cleaned up in another patch.

- Eric

