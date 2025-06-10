Return-Path: <linux-nfs+bounces-12270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D0AD3C52
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3998173FFE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8423505B;
	Tue, 10 Jun 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="WXU0+pHw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-101a.earthlink-vadesecure.net (mta-101b.earthlink-vadesecure.net [51.81.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821314D8D1
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568148; cv=none; b=BuARZGjRY60P3mO3oXMY/lLtZbxL4clGIZ/mD8P1TteSksDQOmqv+E40eCqzDIRnXf4DjWDZ9gXUFzUcD5RfOX1xLMcrB4Ob1cMiy0t0MoPMG/xo7g/lu9qx4pYG05CcPMYPc4jTqVZFwUM3U+8wwVD6H/XcGkr1p8GOY6BhIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568148; c=relaxed/simple;
	bh=YHBvjlV5ySAQmnbDq17J2f127V1qMeaV/hFIhBpEKLs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJ4FDW6FtFzgjyIdO3rnkM5k5Xa8yJ/DcdrR5x/gM/oZTiGvR0+z1RLtD7e7HRDEEV3YnlOPfFdl6BwxwqTYGotrIRVvAJFENhIBSwFP4WLm7GBgtb9+tlRmFocR8AzbxpgbYvtFqftWJNrv6QIwR8P3AuP07nZePpRsmNFgRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=WXU0+pHw; arc=none smtp.client-ip=51.81.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=asCgIZjuo1a9Zx29JHrTgLDXh5xnMCXUECsLVS
 wKSwM=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1749567210; x=1750172010; b=WXU0+pHwQOghC8cQZ7U9iLUX6So
 IkHlj2KV/pv42xbsjk4wuyU5DilzaTZSAyKEjIpVCXwWA+/Pk6oiOsF0OzrvIZqh0wwG/pR
 qyJundeh9PDJcHWYKt/5kxUIbIKa6JiWvuMezc65pnMSDylEVoThBNFyIovQLH7n9RLWwVq
 /dwZN1Poqpwfsgv9XP40XOj1/EtlKzpOxaelod6GTT81OqO59rdp1Du+AS27PlEA9UTbZFN
 bK/rTxE7HC/s+SLGr3okikC9whOVkCEGJh4l68CJsWVo00Y4n8XYPkUSSfSNGc+6y6Dnxve
 Edt4mw2uBe6pZIjPN7GPiDcq+XzY50g==
Received: from FRANKSTHINKPAD ([71.237.148.155])
 by vsel1nmtao01p.internal.vadesecure.com with ngmta
 id d60d8c0c-1847b61b82553e6d; Tue, 10 Jun 2025 14:53:30 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Chuck Lever'" <chuck.lever@oracle.com>,
	"'Dai Ngo'" <dai.ngo@oracle.com>,
	"'Jeff Layton'" <jlayton@kernel.org>,
	<neilb@suse.de>,
	<okorniev@redhat.com>,
	<tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com> <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org> <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com> <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org> <c187763c-09a3-4027-9833-a78244a4329b@oracle.com> <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com> <11364da2-761a-4f67-9bb6-908e9d718f5b@oracle.com>
In-Reply-To: <11364da2-761a-4f67-9bb6-908e9d718f5b@oracle.com>
Subject: RE: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Tue, 10 Jun 2025 07:53:28 -0700
Message-ID: <09eb01dbda17$6e4f8610$4aee9230$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ7uM1NkQrxLEAk2o+QzyCKbcz9hQI5SYcdAh8rVtgCCRqr/AH6IWERAgVKmFoCjxfEBrJVPCQg
Content-Language: en-us

From: Chuck Lever [mailto:chuck.lever@oracle.com]
> On 6/10/25 10:12 AM, Dai Ngo wrote:
> >
> > On 6/10/25 7:01 AM, Chuck Lever wrote:
> >> On 6/10/25 9:59 AM, Jeff Layton wrote:
> >>> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
> >>>> On 6/10/25 9:50 AM, Jeff Layton wrote:
> >>>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
> >>>>>> When the client sends an OPEN with claim type =
CLAIM_DELEG_CUR_FH
> >>>>>> or CLAIM_DELEGATION_CUR, the delegation stateid and the file
> >>>>>> handle must belongs to the same file, otherwise return
> NFS4ERR_BAD_STATEID.
> >>>>>>
> >>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>>>>> ---
> >>>>>>   fs/nfsd/nfs4state.c | 5 +++++
> >>>>>>   1 file changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c index
> >>>>>> 59a693f22452..be2ee641a22d 100644
> >>>>>> --- a/fs/nfsd/nfs4state.c
> >>>>>> +++ b/fs/nfsd/nfs4state.c
> >>>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst
> >>>>>> *rqstp, struct svc_fh *current_fh, struct nf
> >>>>>>           status =3D nfs4_check_deleg(cl, open, &dp);
> >>>>>>           if (status)
> >>>>>>               goto out;
> >>>>>> +        if (dp && nfsd4_is_deleg_cur(open) &&
> >>>>>> +                (dp->dl_stid.sc_file !=3D fp)) {
> >>>>>> +            status =3D nfserr_bad_stateid;
> >>>>>> +            goto out;
> >>>>>> +        }
> >>>>>>           stp =3D nfsd4_find_and_lock_existing_open(fp, open);
> >>>>>>       } else {
> >>>>>>           open->op_file =3D NULL;
> >>>>> This seems like a good idea. I wonder if BAD_STATEID is the =
right
> >>>>> error here. It is a valid stateid, after all, it just doesn't
> >>>>> match the current_fh. Maybe this should be nfserr_inval ?
> >>>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs =
to
> >>>> be tested. BAD_STATEID is mandated by the spec, so if we choose =
to
> >>>> return a different status code here, it needs a comment =
explaining why.
> >>>>
> >>> Oh, I didn't realize that error was mandated, but you're right.
> >>> RFC8881, section 8.2.4:
> >>>
> >>> - If the selected table entry does not match the current =
filehandle,
> >>> return NFS4ERR_BAD_STATEID.
> >>>
> >>> I guess we're stuck with reporting that unless we want to amend =
the
> >>> spec.
> >> It is spec-mandated behavior, but we are always free to ignore the
> >> spec. I'm OK with NFS4ERR_INVAL if it results in better behavior =
(as
> >> long as there is a comment explaining why we deviate from the
> >> mandate).
> >
> > Since the Linux client does not behave this way I can not test if =
this
> > error get us into a loop.
>=20
> Good point!
>=20
>=20
> > I used pynfs to force this behavior.
> >
> > However, here is the comment in nfs4_do_open:
> >
> >                 /*
> >                  * BAD_STATEID on OPEN means that the server =
cancelled
> > our
> >                  * state before it received the OPEN_CONFIRM.
> >                  * Recover by retrying the request as per the
> > discussion
> >                  * on Page 181 of RFC3530.
> >                  */
> >
> > So it guess BAD_STATEID will  get the client and server into a loop.
> > I'll change error to NFS4ERR_INVAL and add a comment in the code.
>=20
> Thanks, we'll start there. If that's problematic, it can always be =
changed later.
>=20
> Maybe someone should file an errata against RFC 8881. <whistles
> tunelessly>

An interesting case. Ganesha doesn't handle this. It would definitely be =
good to see an errata for it. Also a pynfs test case.

Thanks

Frank


