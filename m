Return-Path: <linux-nfs+bounces-15861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1A5C27441
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 01:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959AD405A11
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73DD1D63C2;
	Sat,  1 Nov 2025 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YgHI6+vi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9fYAyeN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121982D7BF
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956702; cv=none; b=DL9sBTMl5hmFDb+9UAC/afRIvwIbeDDdWtfH+f+n+aLRGAMrT9UL8ZJCM9lr33eRxif6qxtAvaFFj1xLH1jLhBGTIp0AEDXDuXfN+4+fVNefa6JCMjQ1yaT/eJ7gDE3Pd3gJ00KaWxgKKz9HdGGhwKPBq/JnR2IhZ5njmLhap2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956702; c=relaxed/simple;
	bh=mM4kgAOkv1mk7cyxe10e7wqTLtI0dfdnnHFC3gDBLH8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kWp4sgtTi3YrhUzdaeILPXraK/LjGieA3KAsJ9U8LZamxZrdCPuvvSPxfE5YL38PsdDB86cLJsH542Nsj14XVxzX3ZJbQTVWfKsBXIibMjsLrbFQ2IKalFBS50tthe+YqNngVu7SFGQjY5lBEMUd3zpnEAu+8wGkLVPSTZb7nFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YgHI6+vi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9fYAyeN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F0746EC0222;
	Fri, 31 Oct 2025 20:24:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 20:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761956699; x=1762043099; bh=pZDU1Qb878r3unSefeUUm1uQIp6tM82KEj6
	/xJAl9LQ=; b=YgHI6+viD+dNBAMWnFShsItiuYG/C3Pp4IjihysQGCKNknrL6Ni
	q4pEFexwUfCu6TY64X59gnBRy6CY4Xz8iAlpH+IknrjEor5cfqPv7ynApY0BU0Zh
	9iaGZmojtata7l+chmnP+ENJP6L69qwi2dlo+pgdrQ8m1Idg5pa41slwuqYa3JHs
	vgaP2VFRqswI7+KeET87pYY65AGnTQ3iuXra/TpC9OznmtXZKZ86//zZLV87vWEn
	9gaK+xULnmJZHbL/tJll8+5kWQjCKp2jhqMpDoqlbiC2IkoLKXzZoSe+Ds0iptR5
	l9/cL/DG+3brzZKR7v1QdGBhkA9AbsPWk7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761956699; x=
	1762043099; bh=pZDU1Qb878r3unSefeUUm1uQIp6tM82KEj6/xJAl9LQ=; b=V
	9fYAyeNYXaEbnGaQTkVDYQ7T6cHSDchDdTTPb/NKqkEVKRoXnxUJpeI0qdjoYQnh
	BNEylHrwJD9zdEt2AqkeryJuuzV9iAl99875OXb7It5dtOUPMNMZZzaF98K2O+/l
	OqaeYZodxhv+iCFcwAVuLwRdHH/TstF5QjmHhqKJzzCtU7GghxVwf63FQvg37TVV
	xQS7+g593KqXLOoD1y7ltCI2R5/k7j31kJpUiQOl/+lJHJbfYXx1Rmp+J8Cojrmi
	SKjYaRWrqx2djBvcF6eUTpq1hzTgUwo0zE0Tk8h/bulP7Z5Z936fB/vXjHBXnqAj
	9kRl61pNtwDLHvwT9EnNQ==
X-ME-Sender: <xms:W1MFaRkk1a4m7MhuzjMaasCHgSE4uHda5-iBG3I0GkTMF9RSwrSYGw>
    <xme:W1MFaQgWrNuxGEcmhSPRoV156du6LQkp6n69WwMgVMTeenm8RAbYHy5Qx2SEXHt6t
    Urxqiq_-AraZQirn4UAg-Lhj3mSo9DzaKnCesROdMF9LSHeNQ>
X-ME-Received: <xmr:W1MFaRfsM6xUyRhK8xacDBJlO5bikyG68117chPhklG5qvLlf1338EHRfALdhj95JMwmm-9rSefZVZe_kVcsGkUYBGqOO202b6WBYM4-SVyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W1MFaYifWXPMzJrGOhEnBWXfh2X0it2h_GqdZTbqVfs3wqGDurFMFQ>
    <xmx:W1MFaRzsUgqjeGr58Ouv5EwO9BksK8N__mA2WtzyNmEfV6ucbXE8pg>
    <xmx:W1MFacPOb2Zw4Y-WG8sb9X4pUzyKIpkecpHxXMOgcHyK3y_2lgb1lQ>
    <xmx:W1MFaaWxKtUcbAuo_neiz-b455KGvT4YeFMdvlTi_oJyU2d9h0ZzUQ>
    <xmx:W1MFaXGu0NgL4BCOgCBMTjkGwNRkhdFrKqJGe5xnbneHUEelBsrN3-QT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 20:24:57 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 06/10] nfsd: change bools in svc_fh it single-bits.
In-reply-to: <3f209a8e-594e-4180-b8a4-25791d4d5295@oracle.com>
References: <20251031032524.2141840-1-neilb@ownmail.net>,
 <20251031032524.2141840-7-neilb@ownmail.net>,
 <3f209a8e-594e-4180-b8a4-25791d4d5295@oracle.com>
Date: Sat, 01 Nov 2025 11:24:55 +1100
Message-id: <176195669572.1793333.3936693579462442180@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 01 Nov 2025, Chuck Lever wrote:
> On 10/30/25 11:16 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > There are now 9 consecutive bools which, one x86_64, results in a 7 byte
> > hole reported by pahole.  When there were 8, there was no hole.
> > 
> > If we switch them to :1 bit fields then they use 2 bytes instead of 9.
> > There is still a hole, but the struct is the same size as when there
> > were 8 bools.
> > 
> > Providing we *don't* change fh_want_write to a bit field, this also
> > reduces the code size on x86_64.  fh_want_write is set in lots of places
> > (via a static inline) and I think that causes significant code growth.
> 
> Anyone with even a hint of OCD is going to look at this and want to
> turn fh_want_write into a bit field.
> 
> Anyone who wants to add a new field will not know whether to make it
> a common bool or a bit field.
> 
> I don't find the bit fields improve readability, but that's entirely
> subjective.
> 
> In any event, I think a code comment is necessary to explain what's
> going on.
> 

That's fair.  I'm curious to understand exactly what operations are made
smaller by bits fields and which are make larger.  I'd guess stored
(which are now read-modify-write) are bigger, but I'd suspect tests to
be the same size..

I'm probably going to have to do test compiles on multiple architectures
and figure out what is going on.

Thanks,
NeilBrown


> 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfsfh.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 995fafc383a0..a570b8a7adfe 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -85,18 +85,18 @@ typedef struct svc_fh {
> >  	struct svc_export *	fh_export;	/* export pointer */
> >  
> >  	bool			fh_want_write;	/* remount protection taken */
> > -	bool			fh_no_wcc;	/* no wcc data needed */
> > -	bool			fh_no_atomic_attr;
> > +	bool			fh_no_wcc:1;	/* no wcc data needed */
> > +	bool			fh_no_atomic_attr:1;
> >  						/*
> >  						 * wcc data is not atomic with
> >  						 * operation
> >  						 */
> > -	bool			fh_use_wgather;	/* NFSv2 wgather option */
> > -	bool			fh_64bit_cookies;/* readdir cookie size */
> > -	bool			fh_foreign;
> > -	bool			fh_have_stateid; /* associated v4.1 stateid is not special */
> > -	bool			fh_post_saved;	/* post-op attrs saved */
> > -	bool			fh_pre_saved;	/* pre-op attrs saved */
> > +	bool			fh_use_wgather:1;/* NFSv2 wgather option */
> > +	bool			fh_64bit_cookies:1;/* readdir cookie size */
> > +	bool			fh_foreign:1;
> > +	bool			fh_have_stateid:1; /* associated v4.1 stateid is not special */
> > +	bool			fh_post_saved:1;/* post-op attrs saved */
> > +	bool			fh_pre_saved:1;	/* pre-op attrs saved */
> >  
> >  	/* Pre-op attributes saved when inode is locked */
> >  	__u64			fh_pre_size;	/* size before operation */
> 
> 
> -- 
> Chuck Lever
> 


