Return-Path: <linux-nfs+bounces-14977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD677BB8A06
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 157BF3459DA
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143718FC97;
	Sat,  4 Oct 2025 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GOOGgvBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9KYnAQp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6F34BA51
	for <linux-nfs@vger.kernel.org>; Sat,  4 Oct 2025 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759559664; cv=none; b=hPLQkL+IfJBTz8pWJC6qfMWpq6pgIkqENX96yB5GqapEhOeDOOM8iyA9pXf/RqL99kXIunzgc5SsO4K1cqrX8FTDtWU5myVgXqyRF5LvW1dLd4tNCKNMfLCpYW1EU8mriedtbZCqEFc9gJOch3t3Twl0ngN423HywDJ0FfoUp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759559664; c=relaxed/simple;
	bh=4l6lCvu0FI7ShKlmXdb/h5Ej8b2/OtcHcQXwhnW6K1Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YWlpJrJhwQOhPJUYZF39gcHGJDlZNW30mzEwGH4xMduAF1JEU0CbvTQzza42b/Vevi1z2VKZWgdh4zSpn/b0QBLMlucapDJHLS9nuHn+FPwlTHXI42cUtDybTfdh/QNcj1rQv7kek/2bJLw/loQkCM16Faw9jOi6dQV9t76Enz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GOOGgvBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9KYnAQp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BC706EC010A;
	Sat,  4 Oct 2025 02:34:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 04 Oct 2025 02:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759559659; x=1759646059; bh=S7GqKwgipJQCkIXA2vtrlM68iWXwtvqNpEY
	owhnkE7Y=; b=GOOGgvBFNlLh5aesF7m1HbKSmGmZzE7LR9jSNFTwPit6JHiUE3o
	ADuQ80ANQRHSzYWR9a2/PTCz5Qo/ZieBDiiNzh5JMrB1nNYQd2aS/KAWe5IDNV9t
	XeXpWdKeS9XvvrbHeQA/RUrsffgCSAFbX36EeTTDQKSz8r/vKz4RkuA4g/VgrD9F
	k+HEOPEg9s104udYrwRQzTiPn4jMqDyeRdqQNKYU7QQjw7XbAT/3CXTVxjc8AGXn
	4nq8BQBKFlp/IL0aVKELW9vr/uTVl2o3vulVDXiN1s5Lcc+ZpIwnWlJGkdYbBM3F
	Qyz/OBCerNRs383NQZLxwwH9h/PfJP0HRUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759559659; x=
	1759646059; bh=S7GqKwgipJQCkIXA2vtrlM68iWXwtvqNpEYowhnkE7Y=; b=O
	9KYnAQpzKIpyC/iS0OcahfJPZaZS53r96Jy0MjR8ShJmzzS5w1aQZ1bL+8n7XyG/
	2/8vTxW+mP6Wzn9UWTm5UjuaZ/ekQZjMHOnh0warg2gV/wcpBplixGwzBddWNZ6R
	FwHxrszp4/gkYdcRsm3pRo99Y237frKY9a95eFgLw2BO+Lk99CA4KWXnTYihAKnv
	e+0sNNgvRp8y/dTD+e05GTBkcqHQ09qVR1gSy73rATdY7TJ9bNykyHJcJfxiiT3H
	6qpsCpA+hz928I2I3tekCIyMAr1h6wyuQBbQGeBeGRV7/eXhMRrWmRmOBtQ7PU6Q
	niMLEvuIxsXbL/X3g+wlQ==
X-ME-Sender: <xms:67_gaDsYmCP5ZNz-J5qp5DLZxSywh9VcFXjo_brIz5n7l_joaPGpfw>
    <xme:67_gaGtXuUyRTGVUt_EKb53c91s1bU5mSDg0O15pJouOokOfUg2r5WLfKFDiKgo2I
    PrR_7FbaLZF_vd_McdJRIBWYfLjTfcFd-ktvLem2KcK2TyP2ms>
X-ME-Received: <xmr:67_gaJA2XHvIErNdg5EzWexOGNbJHOPT8YuhlNWT1e7fzMBe-OqQTmObOYYmfcDPJbU_6hAD3CA0eFZEe-HsIH_KO-sM1rs08KnoTPnWa-Ky>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeluddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:67_gaIMJuBrNcOQWh9uYvr9Rs6DqZgwuu1EcCZesR8B27P7vbUALww>
    <xmx:67_gaCyTYF9IWlLqEF959yisLTma3hs3rKG65AHwfGV_riaTjv8hcw>
    <xmx:67_gaIWRNYeUGkigxVgIXDGEj6m1DRIzxkHtxt_2DVkd4D-1r4bRcg>
    <xmx:67_gaEPPAqMNpD4DDVRp2BoTBxIodsm3pSvt7F_mG0RKDop2gghbfQ>
    <xmx:67_gaOYQS0mcx2CQY0R2Pq-Soyl13ifDr9r23Ks4SFMtNP04J-XOpuia>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Oct 2025 02:34:17 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
In-reply-to: <2313f8b9-56ae-4b38-a419-1d5ab8582914@kernel.org>
References: <20250930140520.2947-1-cel@kernel.org>,
 <175928003792.1696783.17556773248679753110@noble.neil.brown.name>,
 <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>,
 <175947529411.247319.1453292585395648663@noble.neil.brown.name>,
 <2313f8b9-56ae-4b38-a419-1d5ab8582914@kernel.org>
Date: Sat, 04 Oct 2025 16:34:15 +1000
Message-id: <175955965542.1793333.13223432830700758756@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 03 Oct 2025, Chuck Lever wrote:
> On 10/3/25 3:08 AM, NeilBrown wrote:
> > On Wed, 01 Oct 2025, Chuck Lever wrote:
> >> On 9/30/25 8:53 PM, NeilBrown wrote:
> >>> On Wed, 01 Oct 2025, Chuck Lever wrote:
> >>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>
> >>>> When tracing is enabled, the trace_nfsd_read_done trace point
> >>>> crashes during the pynfs read.testNoFh test.
> >>>>
> >>>> Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 read pro=
c")
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> ---
> >>>>  fs/nfsd/nfs4proc.c | 7 ++++---
> >>>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>>> index e466cf52d7d7..f9aeefc0da73 100644
> >>>> --- a/fs/nfsd/nfs4proc.c
> >>>> +++ b/fs/nfsd/nfs4proc.c
> >>>> @@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> >>>>  static void
> >>>>  nfsd4_read_release(union nfsd4_op_u *u)
> >>>>  {
> >>>> -	if (u->read.rd_nf)
> >>>> +	if (u->read.rd_nf) {
> >>>> +		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> >>>> +				     u->read.rd_offset, u->read.rd_length);
> >>>>  		nfsd_file_put(u->read.rd_nf);
> >>>> -	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> >>>> -			     u->read.rd_offset, u->read.rd_length);
> >>>> +	}
> >>>>  }
> >>>
> >>> I must say this looks a bit weird.  rd_nf isn't used in the trace but if
> >>> it isn't set, you say the trace crashes...
> >>>
> >>> That is because rd_fhp being NULL (because there is no current_fh) is
> >>> one thing that results in rd_nf being NULL.  Seems a bit indirect.
> >>
> >> When rd_nf is NULL, no file or file handle is present. That's really all
> >> there is to it. You can read it as "when rd_nf is NULL, no processing is
> >> needed".
> >>
> >> The other read trace points are already skipped in this case as well, so
> >> there is no need to protect them.
> >=20
> > They are skipped because ALLOWED_WITHOUT_FH is not set so ->op_func
> > isn't called.  But ->op_release *is* called.  That seems inconsistent.
> > I wonder if we could move the ->op_release call out of
> > nfsd4_encode_operation() and only call it in cases were ->op_func
> > was called.
> >=20
> > Something like the following?  It isn't as elegant as I would have
> > liked, but I think it is better than hiding the ->op_release cxall in
> > nfsd4_encode_replay().
> >=20
> > Thanks,
> > NeilBrown
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 71b428efcbb5..4ed823d1e6be 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2837,6 +2837,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> > =20
> >  	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
> >  	while (!status && resp->opcnt < args->opcnt) {
> > +		bool called_func =3D false;
> > +
>=20
> Or call it "release_needed" ?

That might be a bit better - yes.

>=20
> This change is not something I'd care to have backported into stable
> kernels... So maybe keep the modification of nfsd4_read_release for
> backport, and then subsequently do this change too?

That seems like a sensible safe approach.

>=20
> I was reminded of a release-related change that Jeff did recently, maybe
> commit 15a8b55dbb1b ("nfsd: call op_release, even when op_func returns
> an error")... might be relevant, might not.

Definitely relevant.  I think this is the commit to mention in the
Fixes: tag.  Prior to this commit nfsd4_read_release wouldn't have been
called if there was no filehandle, so the trace point was perfectly
safe.

I wonder if this fix by Jeff was the best fix for the problem.
An alternative would be to require ->op_func to release any resources
before returning an error..... except that wouldn't work for=20
OP_NONTRIVIAL_ERROR_ENCODE functions like OP_LOCK as the ->op_release
frees the "deny" info which is needed to encode the reply....

But wait ...nfs4_encode_operation - which currently calls ->op_release -
is also called from nfsd4_enc_sequence_replay().  The status is set to
an error so ->op_release previously would not have been called, but now
it is.  Could that mean nfsd4_lock_release() can get called there even
tough nfsd4_lock wasn't called.  Could that be a problem?  It isn't
clear to me that is *isn't* a problem, should maybe there is a subtlety
that saves it.

I'm beginning to think that we don't want an op_release at all.
Anything allocated in ->op_func should either be freed in ->op_func when
an error is detected, or in the corresponding nfsd4_enc_ops function
after the allocated value is used for encoding.

Looking further...
 ->op_get_currentstateid is only called immediately before the one time
 that ->op_func is called.  So ->op_func could do that
 get_currentstateid work.
 and ->op_set_currentstateid looks like it could be folded in to
 ->op_func as well.

Does anyone have any thoughts about that?

Thanks,
NeilBrown


