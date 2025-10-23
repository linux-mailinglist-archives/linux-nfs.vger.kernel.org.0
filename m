Return-Path: <linux-nfs+bounces-15580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38AC03B36
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 00:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AD03B1125
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E22BB1D;
	Thu, 23 Oct 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="yF6OjMw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pQib80bg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B52264D9
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259631; cv=none; b=G9tm1Ac8XRuc1+Whr88aLqkELvdxT+UR1oWveLC0LvZHFx6Auoq34NoGTD44AN0EFuyK5fjgL25ZDfaDfk5qkBuJRGGUoLET3RsKP8xK9vlFqHaBUwQ7IbmO3vcfgPQd+98hGZrQWquKdQJizb+QsHrVdm+kjEnn9hvFRNKPcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259631; c=relaxed/simple;
	bh=c/exDhq/dG+eGwhHYMJG3vbUPw7PF++eGg2TjdT38uA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dhfhFFP+NubUt8ad9WZYGVyfjPS5D46yKAozV96KBGaRWZfuGI+kXnyVi8WbRspy+5wE7m2QB/WR+XSGfdOp+UOdBfBG1Q8QJFoXMsgFQpy2/HzXvLkPb0yjFYXUE8ZUM9iNUOHKVlAz7HCGQHlj0hlzTiFRG6sASk0WDHRQAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=yF6OjMw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pQib80bg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45BF77A0096;
	Thu, 23 Oct 2025 18:47:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 18:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761259627; x=1761346027; bh=Je3UmNS4bKQ1ilPJFcMTMGfqvXidGun0e7Q
	tvCvheKQ=; b=yF6OjMw3cEHxn2Gw0aUyqOwN2mcCUOcsIQMnoQzsrIJstmY7rav
	eDLGW9VmkPko60JDdYQTBdxI4da5DqUmV3Seu4BKX/cqjqoMRYEvvwXZDgbEvNru
	KHZdd9pwwfvXV8WgUbnElXBDplwx58/hxVlUkdHBh97J1cDm6GrvLz6NxMS86F7n
	YxbS/gaVg6ak9GW/vBSyzQAN8JRG36OsdqrKlX9g9EqHlIjeYWwIEIJli2DBKEC/
	QYc/wDIsXsnbdK+rW9OLMSvEcJP/X5YLwDURsYKVjLMisExSx/yGoHa5PQrkpgJ5
	GSxHYk/Db+anzJmGKX6kbm50cLwQv7wvekg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761259627; x=
	1761346027; bh=Je3UmNS4bKQ1ilPJFcMTMGfqvXidGun0e7QtvCvheKQ=; b=p
	Qib80bgZbFOwXRBsz+UkzkB6/pmxvqYvZ2VlMURvGqBw88WRkuCL1hIgXvxfIZkg
	xxnuQo9XOwWP7uz3VMlv2aqPYcbRRpi0p/abE376/0QdCLYj9fyLpSfFIHO10Waw
	QjdXnFXO/I2DbKXDgI/weWdkPCMIyDUCQA5kbjzqpdKcmPJsjlj/thdRsOMnqs8R
	PtkyAlOOxtjiHPz8aX0/5Xt981510NWMOC/W+zD9BYtSgyHW1XCeub8ObkyjYBGz
	bLKB7EsM/dBPvSAUOd6OlACW09b6KIOx/eNgELuzIVsel4zxto/I17aLCtFVoOv+
	fTeUXB0K4KhXCwyIimu5A==
X-ME-Sender: <xms:arD6aCcAoJMIj_HberIRK_rhf4YzkHOk6bdim19V7MgqcWv700ZkBg>
    <xme:arD6aP5bqIitS-zmyRBaqVdFvT4Nlu5uIRQrXfsCg4FzFzF6of8MFwNFZcCkWQcXg
    OK1Kxazov_3uvsSS8s-ZYN2okGOhehyrK_lYluZL3w44fv3>
X-ME-Received: <xmr:arD6aNW5QM12cHcBh3j682ImjfZ-Z9UDqe6pDCPyazArkRICAQ6v0IX1AzCovQcYBPPleUWd8KFlsINBIzreQRRlofXQpuVWFG4yqrdrHtGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:arD6aG7tzXWu4WSTTrl02rrEvklK5SdgnQnSp8g_8v_DZryEj130Vg>
    <xmx:arD6aAq73NdcLAW6P7dlh3cuT_H73ReG5IN_CLZ-pTDiPnNwBgg-7A>
    <xmx:arD6aBm-buGWa4os28janp0NYGFsfT7_BesfjFKSx-90vCb77T-S3g>
    <xmx:arD6aEPdBXbWKHUvqu6TIDM5OVnaf22fpo5A6xS6XsUuBKVYsggQRg>
    <xmx:a7D6aP_nc9Q-OXfnQ1JI-_tTdv92gLmQozF5ymPlYS1fTCvMI0CKMeD5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 18:47:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Subject: Re: [PATCH v2 1/8] nfsd: revise names of special stateid, and
 predicate functions.
In-reply-to: <fe0c00c8-88aa-445d-a13d-9d41e69e8362@oracle.com>
References: <20251022223713.1217694-1-neilb@ownmail.net>,
 <20251022223713.1217694-2-neilb@ownmail.net>,
 <fe0c00c8-88aa-445d-a13d-9d41e69e8362@oracle.com>
Date: Fri, 24 Oct 2025 09:46:58 +1100
Message-id: <176125961826.1793333.1976179461197405160@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 24 Oct 2025, Chuck Lever wrote:
> On 10/22/25 6:34 PM, NeilBrown wrote:
> > When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
> > is testing the stateid to see if it is a special stateid.  I find that
> > IS_CURRENT_STATEID(foo) is clearer.
> >=20
> > There are other special stateid which are described in RFC 8881 Section
> > 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
> > currently names them "zero", "one" and "close" which doesn't help with
> > comparing the code to the RFC.
> >=20
> > So this patch changes the names of those special stateids, adds "IS_" to
> > the front of the predicates, and introduces IS_SPECIAL_STATEID() which
> > tests if a given stateid is any of those listed in 8.2.3.
> >=20
> > I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
> > it IS_READ_STATEID().
>=20
> IMHO IS_BYPASS_STATEID would be a more purpose-specific name.
>=20

I particularly liked how

+	if (IS_READ_STATEID(stateid) && (flags & RD_STATE))

looked, but I agree that "bypass" is more important.


>=20
> > Places where we now use IS_SPECIAL_STATEID() didn't previously check for
> > "current_stateid", but I think they should.  I don't think that change
> > actually affects behaviour.
>=20
> This needs expansion, it's a little hand-wavy. How are you certain that
> including IS_CURRENT_STATEID in some of these checks is OK?

Fair critique..

IS_CURRENT_STATEID() is used in two places.
In practice it isn't needed as in both cases there is a subsequent call
to find_stateid_XXX which will fail for these stateid, resulting in the
same error.  However:

In one case it is called (in nfsd4_validate_stateid() from
nfsd4_test_stateid()) to validate a stateid in the TEST_STATEID v4.1 op.
RFC8881 explicitly says: "Special stateids are always considered
invalid" and in that context this can only mean all 4 special stateid.

The other case is in nfsd4_lookup_stateid() which is called in multiple
places where a stateid appears in a request.
It is always *after* op_set_currentstateid has been called to use
put_stateid() to replace the CURRENT_STATEID special value with whatever
is the current stateid, so the ......

Uhm, it appears that the code doesn't match RFC8881 (or RFC5661).
Section 16.2.3.1.2 suggests that there should *always* be a
current_stateid, but it might be anon_stateid after e.g. a PUTFH op.
Our code will invalidate the current stateid after OP_PUTFH, thanks to
OP_CLEAR_STATEID.

If we implemented the spec, then I would be able to say that where
IS_SPECIAL_STATEID() is called in nfsd4_lookup_stateid is always after
put_stateid() was called, so the value current_stateid is not possible.

I wonder if I should just remove the test from nfsd4_lookup_stateid().
It seems pointless as the lookup will always fail.

>=20
>=20
> > -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(=
stateid_t)))
> > -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(s=
tateid_t)))
> > -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, si=
zeof(stateid_t)))
> > -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, size=
of(stateid_t)))
>=20
> A comment here that directs the reader to Section 8.2.3 of RFC 8881
> would be nice.

Yep.

>=20
>=20
> > +#define IS_ANON_STATEID(stateid) (!memcmp((stateid), &anon_stateid, size=
of(stateid_t)))
> > +#define IS_READ_STATEID(stateid)  (!memcmp((stateid), &read_bypass_state=
id, sizeof(stateid_t)))
> > +#define IS_CURRENT_STATEID(stateid) (!memcmp((stateid), &current_stateid=
, sizeof(stateid_t)))
> > +#define IS_INVALID_STATEID(stateid)  (!memcmp((stateid), &invalid_statei=
d, sizeof(stateid_t)))
> > +
> > +static inline bool IS_SPECIAL_STATEID(stateid_t *stateid)
> > +{
> > +	return IS_ANON_STATEID(stateid) ||
> > +		IS_READ_STATEID(stateid) ||
> > +		IS_CURRENT_STATEID(stateid) ||
> > +		IS_INVALID_STATEID(stateid);
> > +}
>=20
> Might be nicer overall if these were static inline functions rather than
> pre-processor macros.

In general I would agree.  In this case it would turn 4 lines into 20 if we
used standard formatting.

What would you think of this 12 line version?

static inline bool IS_ANON_STATEID(stateid_t *stateid) {
	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
}
static inline bool IS_BYPASS_STATEID(stateid_t *stateid) {
	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
}
static inline bool IS_CURRENT_STATEID(stateid_t *stateid) {
	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
}
static inline bool IS_INVALID_STATEID(stateid_t *stateid) {
	return memcmp(stateid, &read_invalid_stateid, sizeof(stateid_t));
}

>=20
> The other patches in the series LGTM.

Thanks,
NeilBrown

