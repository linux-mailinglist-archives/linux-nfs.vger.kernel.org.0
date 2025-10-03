Return-Path: <linux-nfs+bounces-14942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D67BB6238
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 09:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70653A898A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D656922A7E5;
	Fri,  3 Oct 2025 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SL0v4j9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtMEo+oc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D422759C
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475305; cv=none; b=LXERhpKTUmEtUokG+uEgdcukc4y99q4oVM1ML0fNH86WwjLE5LJNVjGEZnr25xaW5Jqylx31O1qtjENi9/2cRlkRvNHCNER+WupUO6Hu8gNDBnIiS6CeVG73l5C3aoLCRJXwvn9WeIMaYi9HYA1Xjqi6q9f/AiaA79DwxGXQgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475305; c=relaxed/simple;
	bh=g5suKPoEfI6LPUQgyie4DUCbouqvRhCbdgJxsUqkopM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=isSYjOSva6Jx0umluSMZh9JPfa3pgLyg7/vGzrlmU6S4NK4ZaOmpAxqxxE5Zyl5Q93Ma5cAsia0GE2Zpmo7xH7++aLHHysQhGsVo0bVWhZqRfcX7nGeLiVa4VkEVCFONWnhNY5wuvZ91LT4bYo+Ifv1fzWFwzIo9dX2uMFUHTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SL0v4j9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtMEo+oc; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 033831D00141;
	Fri,  3 Oct 2025 03:08:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 03 Oct 2025 03:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759475300; x=1759561700; bh=wB60ZSYz+DRsakNKJ3rmVt/DgCgabVEI/uB
	EMakUjV8=; b=SL0v4j9NyVL5W+rtIfMzoCDts8OS7LHuDTjcbmlwA+df6Ya8uol
	eOBDsClAElS1QGi68k37D/YZ+N4GNXBgFbspfGxQ+p6O6ct1EoHi3V1JYEJ/2+yV
	okgGU0+OS3iSCZadZNTgluXpohJH8keFNM1QWS2qQ9IrXGGyBDfEf6acJgALhDKi
	ZqZOG+TBNVVpO4K6ZQpasS95a1RiyLdclnuBmFgjEPz06EJKIh0XX/zM3XBXFg+B
	+PrVdV9MWQXvYhdmmMUg3Nl54Rj/XlsJYdf115bMgfSHuT6MXBA46fFxqdv3iSwY
	HrDA4XjlefX8uH1vRNBE0cU/+0SIe21MlTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759475300; x=
	1759561700; bh=wB60ZSYz+DRsakNKJ3rmVt/DgCgabVEI/uBEMakUjV8=; b=C
	tMEo+oc44oDn72aBFeWUZKsRd5q0WyiEyVbgmr+lDScwe7gTNC1Dj0hXMGKpacqq
	rTAe6wloO2EwiQNSW4m7k9RHPkNWG2orytUMf2+q8um5QigKzZHmEwQI4pByGaEe
	26SsICSg+cUYWOfS1JA0Ah2GPi0j9AFWD1gQ7Q6gF6t1sdKRI0+uAS0Wq43TYosO
	Km/2XGRGNjmo8ld3LFjSiaahbFlfoPJ80fTIE9cw7qw9iOXRx1s7uWb9/21/VQm2
	m9F4halpcfwp0F3AA1qaIt9HeTO/yfxdMplz0r74B0E2rCvQspKl7kfbOCVCRaAy
	Qb3I2O/G4UDC8BcRylvpw==
X-ME-Sender: <xms:ZHbfaJgZ2a2xMcSxEGsJAuODiB4kEdQNj71ICHPMhdOvaBEXYqDZ7w>
    <xme:ZHbfaLlR0mWISYixsOqo4xL6giK8zrKooVftK0VMg793ZVMejvPHsdOocXTFSal-D
    2ww-2KVYgsGJu3S6CIE9GD5wSffOs47K5amxjntUjO21PDA-A>
X-ME-Received: <xmr:ZHbfaPhvNKOaYm_Y6PTFZ2Fd1jfpVcAqrt7BHBGlwnKXTI84fp-pxE5JSNoVQ54RysojGhqCBNG6lxUXkD-IJx9XT2qVTCMY0NOqx1ie86sP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedviecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ZHbfaP1QQSqxn_mzA3bHGovvQfI4BENjdZsR4xmtpxe8_uzMBib-UA>
    <xmx:ZHbfaIIpHA5hBRHnoFrk_CahaLKFmgI7F-JrKl2gFe4m18ny8-xnew>
    <xmx:ZHbfaPzT-sIzbj8KQHNgrMR6z0Yr8QVlTIYwlzLQTXilVUwI7rsU8Q>
    <xmx:ZHbfaGWl-eGSJ91EbO9k07OpTu36ihmpuMNwcJxVM2cWdwbSk7Jbhw>
    <xmx:ZHbfaNESu1JnYmlZ2kJPuiomnKeQLyt9K7qpXK-byd2mHu6XUjyHeXgC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 03:08:17 -0400 (EDT)
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
In-reply-to: <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>
References: <20250930140520.2947-1-cel@kernel.org>,
 <175928003792.1696783.17556773248679753110@noble.neil.brown.name>,
 <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>
Date: Fri, 03 Oct 2025 17:08:14 +1000
Message-id: <175947529411.247319.1453292585395648663@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 01 Oct 2025, Chuck Lever wrote:
> On 9/30/25 8:53 PM, NeilBrown wrote:
> > On Wed, 01 Oct 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> When tracing is enabled, the trace_nfsd_read_done trace point
> >> crashes during the pynfs read.testNoFh test.
> >>
> >> Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 read proc")
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/nfs4proc.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >> index e466cf52d7d7..f9aeefc0da73 100644
> >> --- a/fs/nfsd/nfs4proc.c
> >> +++ b/fs/nfsd/nfs4proc.c
> >> @@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >>  static void
> >>  nfsd4_read_release(union nfsd4_op_u *u)
> >>  {
> >> -	if (u->read.rd_nf)
> >> +	if (u->read.rd_nf) {
> >> +		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> >> +				     u->read.rd_offset, u->read.rd_length);
> >>  		nfsd_file_put(u->read.rd_nf);
> >> -	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> >> -			     u->read.rd_offset, u->read.rd_length);
> >> +	}
> >>  }
> >=20
> > I must say this looks a bit weird.  rd_nf isn't used in the trace but if
> > it isn't set, you say the trace crashes...
> >=20
> > That is because rd_fhp being NULL (because there is no current_fh) is
> > one thing that results in rd_nf being NULL.  Seems a bit indirect.
>=20
> When rd_nf is NULL, no file or file handle is present. That's really all
> there is to it. You can read it as "when rd_nf is NULL, no processing is
> needed".
>=20
> The other read trace points are already skipped in this case as well, so
> there is no need to protect them.

They are skipped because ALLOWED_WITHOUT_FH is not set so ->op_func
isn't called.  But ->op_release *is* called.  That seems inconsistent.
I wonder if we could move the ->op_release call out of
nfsd4_encode_operation() and only call it in cases were ->op_func
was called.

Something like the following?  It isn't as elegant as I would have
liked, but I think it is better than hiding the ->op_release cxall in
nfsd4_encode_replay().

Thanks,
NeilBrown

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb5..4ed823d1e6be 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2837,6 +2837,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
=20
 	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
+		bool called_func =3D false;
+
 		op =3D &args->ops[resp->opcnt++];
=20
 		/*
@@ -2886,6 +2888,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		if (op->opdesc->op_get_currentstateid)
 			op->opdesc->op_get_currentstateid(cstate, &op->u);
 		op->status =3D op->opdesc->op_func(rqstp, cstate, &op->u);
+		called_func =3D true;
 		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
=20
 		/* Only from SEQUENCE */
@@ -2914,6 +2917,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			nfsd4_encode_operation(resp, op);
 			status =3D op->status;
 		}
+		if (called_func && op->opdesc->op_release)
+			op->opdesc->op_release(&op->u);
+
=20
 		trace_nfsd_compound_status(args->opcnt, resp->opcnt,
 					   status, nfsd4_op_name(op->opnum));
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ea91bad4eee2..e7b4363aadb0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5885,10 +5885,10 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp=
, struct nfsd4_op *op)
 	nfsd4_enc encoder;
=20
 	if (xdr_stream_encode_u32(xdr, op->opnum) !=3D XDR_UNIT)
-		goto release;
+		goto out;
 	op_status_offset =3D xdr->buf->len;
 	if (!xdr_reserve_space(xdr, XDR_UNIT))
-		goto release;
+		goto out;
=20
 	if (op->opnum =3D=3D OP_ILLEGAL)
 		goto status;
@@ -5944,10 +5944,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp,=
 struct nfsd4_op *op)
 				      resp->cstate.minorversion);
 	write_bytes_to_xdr_buf(xdr->buf, op_status_offset,
 			       &op->status, XDR_UNIT);
-release:
-	if (opdesc && opdesc->op_release)
-		opdesc->op_release(&op->u);
-
+out:
 	/*
 	 * Account for pages consumed while encoding this operation.
 	 * The xdr_stream primitives don't manage rq_next_page.



