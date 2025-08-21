Return-Path: <linux-nfs+bounces-13845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E1B301AC
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD771CE35AA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEFB1F948;
	Thu, 21 Aug 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="KYN9pwWT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-101a.earthlink-vadesecure.net (mta-101a.earthlink-vadesecure.net [51.81.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D71EB5C2
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799398; cv=none; b=CPC4YPBoSN3Z7dlZjv/6hkRnCfqUU7f5Vr+iZxP1qyQ6/ekrmUGMEAnUuiS+r0pnS3xW5b2fnRWru/dZVO4XQVrtIia25dTe49gR+lXEkvq4vyRxhPxVfXDuN1NJAcNPAyboXsfY5UP5mjW5EF2NA0JCNbnV8i1QscbzH05Vt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799398; c=relaxed/simple;
	bh=xWFMJjiUk3nXO8QqeaDpniI3ZC+mftG6x+XvrwnPke8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvDbODdxJxwbjU8f6r8+q02sH4gP4239vh3S8a0kYCNFdfQvI+XCa4iFFSNcrSBheh65uVVb5PzlPxi31jY0uYZ+cHYHTzSuX1pgfj7alDWB5tTIfpYDintMji1JGy8+8dji0lzdFgMd1dbzDj9c+P3FHjeJNHCmyUhsJevncH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=KYN9pwWT; arc=none smtp.client-ip=51.81.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=b8nwJd8wdf4mpqKbD9PPnqtX5VBjOMakiGjI5j
 iqttA=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1755798477; x=1756403277; b=KYN9pwWTAnVpb/yEp93cvLx4D+A
 zUo2G8nabyj5zKJHKW+oPSdTUcEM7eh/ukgJsNbhI6OiPmp5ZiXlxxPDVVXNj7daVBts5Pe
 GUymF8YM0hXrgfqicLoQ7fPduM08Y1n1wkvEPvTO4ZaHkEIZt93vckMqPFoHINNuR5HN3nj
 rSPRXprO9pMRrtm0BHQ7P9tRGvcMMI6J+BgXFmGV1k6cJe43rB7AYKxrYR0qzcvE7Nr6odf
 MBjcQec3BT1ShVUiPLPjWjzX7OHUvHCQh1Fdu+72JiTMv3iDedCnxYAFq6MEBk2hHd4z77R
 dpXmKeYQnZKgbV9/K3LFRx+Nv+tyuDA==
Received: from FRANKSTHINKPAD ([71.237.148.155])
 by vsel1nmtao01p.internal.vadesecure.com with ngmta
 id d1acf073-185dd9695d43ab8f; Thu, 21 Aug 2025 17:47:57 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Calum Mackay'" <calum.mackay@oracle.com>,
	<linux-nfs@vger.kernel.org>
Cc: "'Ofir Vainshtein'" <ofirvins@google.com>,
	"'Chuck Lever'" <chuck.lever@oracle.com>
References: <01d001dc0ba9$e4cb0080$ae610180$@mindspring.com> <44d19311-7644-4f6e-8509-ff7312ba3ad9@oracle.com> <009301dc12c1$4f9cb390$eed61ab0$@mindspring.com> <2c52fbdc-97b3-4f61-ba59-1377eedc6f13@oracle.com>
In-Reply-To: <2c52fbdc-97b3-4f61-ba59-1377eedc6f13@oracle.com>
Subject: RE: PYNFS LOCK20 Blocking Lock Test Case
Date: Thu, 21 Aug 2025 10:47:55 -0700
Message-ID: <00a101dc12c3$babd40c0$3037c240$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLX0cafepDmnK5On/trYyHnSs4j1gGuqD59AkSnxwMB0H1XHbJHxJVg
Content-Language: en-us

Thanks

> -----Original Message-----
> From: Calum Mackay [mailto:calum.mackay@oracle.com]
> Sent: Thursday, August 21, 2025 10:41 AM
> To: Frank Filz <ffilzlnx@mindspring.com>; linux-nfs@vger.kernel.org
> Cc: Calum Mackay <calum.mackay@oracle.com>; 'Ofir Vainshtein'
> <ofirvins@google.com>; 'Chuck Lever' <chuck.lever@oracle.com>
> Subject: Re: PYNFS LOCK20 Blocking Lock Test Case
>=20
> On 21/08/2025 6:30 pm, Frank Filz wrote:
> > Ah, I see the logic the test case is expecting.
> >
> > For Ganesha, we maintain the blocking lock so long as the clientid =
is being
> renewed, so we don't start the timer for claiming the lock until the =
lock becomes
> available which seems to be allowed per the RFC. Maybe we just need to =
not run
> that test case.
> >
> > But it would be nice to have a similar test case that just takes too =
long after
> the lock is available to retry.
>=20
> Thanks Frank; Chuck also made a similar suggestion to me privately. =
I'll have a
> look at either adjusting this test to report information that the lock =
was
> obtained "early", and/or a separate/optional test that more closely =
matches the
> RFC wording, regardless of how the server might behave.
>=20
> Of course, the RFC wording, and lack of nominative language, suggests =
this is an
> implementation choice, and thus difficult for pynfs tests to =
adjudicate on.

Yes, that can be tricky. I added a ganesha tag so there could be a few =
implementation specific tests.

> thanks,
> calum.
>=20
> >
> > Part of the challenge is we share a lot of logic between 4.0 and 4.1 =
and with
> the actual callback in 4.1, there is no expectation of the client =
polling for the
> lock.
> >
> > Let me mull this one over more.
> >
> > Thanks
> >
> > Frank
> >
> >> -----Original Message-----
> >> From: Calum Mackay [mailto:calum.mackay@oracle.com]
> >> Sent: Wednesday, August 13, 2025 6:30 PM
> >> To: Frank Filz <ffilzlnx@mindspring.com>; linux-nfs@vger.kernel.org
> >> Cc: Calum Mackay <calum.mackay@oracle.com>; 'Ofir Vainshtein'
> >> <ofirvins@google.com>; Chuck Lever <chuck.lever@oracle.com>
> >> Subject: Re: PYNFS LOCK20 Blocking Lock Test Case
> >>
> >> On 12/08/2025 5:55 pm, Frank Filz wrote:
> >>> I believe this test case is wrong, relevant text from RFC:
> >>>
> >>> Some clients require the support of blocking locks. The NFSv4
> >>> protocol must not rely on a callback mechanism and therefore is
> >>> unable to notify a client when a previously denied lock has been =
granted.
> >>> Clients have no choice but to continually poll for the lock. This
> >>> presents a fairness problem. Two new lock types are added, READW =
and
> >>> WRITEW, and are used to indicate to the server that the client is
> >>> requesting a blocking lock. The server should maintain an ordered
> >>> list of pending blocking locks. When the conflicting lock is
> >>> released, the server may wait the lease period for the first =
waiting
> >>> client to re-request the lock. After the lease period expires, the
> >>> next waiting client request is allowed the lock.
> >>>
> >>> Test case:
> >>>
> >>>       # Standard owner opens and locks a file
> >>>       fh1, stateid1 =3D c.create_confirm(t.word(),
> >> deny=3DOPEN4_SHARE_DENY_NONE)
> >>>       res1 =3D c.lock_file(t.word(), fh1, stateid1, =
type=3DWRITE_LT)
> >>>       check(res1, msg=3D"Locking file %s" % t.word())
> >>>       # Second owner is denied a blocking lock
> >>>       file =3D c.homedir + [t.word()]
> >>>       fh2, stateid2 =3D c.open_confirm(b"owner2", file,
> >>>                                      =
access=3DOPEN4_SHARE_ACCESS_BOTH,
> >>>                                      deny=3DOPEN4_SHARE_DENY_NONE)
> >>>       res2 =3D c.lock_file(b"owner2", fh2, stateid2,
> >>>                          type=3DWRITEW_LT, =
lockowner=3Db"lockowner2_LOCK20")
> >>>       check(res2, NFS4ERR_DENIED, msg=3D"Conflicting lock on %s" % =
t.word())
> >>>       sleeptime =3D c.getLeaseTime() // 2
> >>>       # Wait for queued lock to timeout
> >>>       for i in range(3):
> >>>           env.sleep(sleeptime, "Waiting for queued blocking lock =
to timeout")
> >>>           res =3D c.compound([op.renew(c.clientid)])
> >>>           check(res, [NFS4_OK, NFS4ERR_CB_PATH_DOWN])
> >>>       # Standard owner releases lock
> >>>       res1 =3D c.unlock_file(1, fh1, res1.lockid)
> >>>       check(res1)
> >>>       # Third owner tries to butt in and steal lock second owner =
is
> >>> waiting for
> >>>       # Should work, since second owner let his turn expire
> >>>       file =3D c.homedir + [t.word()]
> >>>       fh3, stateid3 =3D c.open_confirm(b"owner3", file,
> >>>                                      =
access=3DOPEN4_SHARE_ACCESS_BOTH,
> >>>                                      deny=3DOPEN4_SHARE_DENY_NONE)
> >>>       res3 =3D c.lock_file(b"owner3", fh3, stateid3,
> >>>                          type=3DWRITEW_LT, =
lockowner=3Db"lockowner3_LOCK20")
> >>>       check(res3, msg=3D"Grabbing lock after another owner let his =
'turn'
> >>> expire")
> >>>
> >>> Note that the RFC indicated the client has one lease period AFTER
> >>> the conflicting lock is released to retry while the test case =
waits
> >>> 1.5 lease period after requesting the blocking lock before it
> >>> releases the conflicting lock...
> >>>
> >>> Am I reading things right?
> >>
> >> I see what you mean.
> >>
> >> But since a waiting blocking lock client obviously doesn't know =
when
> >> the lock- holding client is going to release its lock, the waiting
> >> client has to start polling regularly as soon as its initial =
blocking
> >> lock request is denied. It has to poll at least once per lease =
period.
> >>
> >> If the server notices that a waiting client hasn't polled once in a
> >> lease period, after its initial blocking lock request was denied,
> >> then it seems reasonable for the server to forget that waiting
> >> client's interest in the pending lock there and then. There's no =
need
> >> for the server to wait a further lease period after the lock is =
released.
> >>
> >>
> >> Looking at the current Linux nfsd code, that does seem to be what =
it
> >> does. I see that when the server adds the blocking lock request to
> >> its pending list, it adds the current timestamp to it, i.e. the =
time that the
> blocking lock was requested.
> >>
> >> The nfsd background clean-up thread (which runs at least once per
> >> lease
> >> period) removes any pending blocking lock requests if a lease =
period
> >> has passed since they were placed on the list (i.e. when the =
blocking lock was
> requested).
> >> There's a corresponding comment:
> >>
> >> 	/*
> >> 	 * It's possible for a client to try and acquire an already held =
lock
> >> 	 * that is being held for a long time, and then lose interest in =
it.
> >> 	 * So, we clean out any un-revisited request after a lease period
> >> 	 * under the assumption that the client is no longer interested.
> >>
> >> =
https://elixir.bootlin.com/linux/v6.16/source/fs/nfsd/nfs4state.c#L68
> >> 24
> >>
> >>
> >> There's no pending locks action taken on lock release. The timing =
is
> >> based solely on when the blocking READW/WRITEW request occurred, =
i.e.
> >> the res2 WRITEW in the pynfs test, which is before the sleep.
> >>
> >> So, whilst the RFC may seem to suggest the timer should start at =
lock
> >> release, it doesn't seem unreasonable for the NFS server to start =
the
> >> timer earlier, at the blocking lock request, to avoid an =
unnecessary
> >> delay upon lock release if the client has lost interest in the =
lock, i.e. it isn't
> polling.
> >>
> >>
> >> Presumably, the pynfs test was originally written to match NFS =
server
> >> behaviour, rather than RFC wording. I'm not sure what other NFS =
servers do
> in this case.
> >> Waiting longer wouldn't change the test result in this case, I =
think.
> >>
> >>
> >> Does that seem reasonable to you?
> >>
> >> thanks,
> >> calum.
> >
>=20
> --
> Calum Mackay
> Linux Kernel Engineering
> Oracle Linux and Virtualisation



