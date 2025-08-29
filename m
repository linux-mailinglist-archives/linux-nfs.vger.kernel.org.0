Return-Path: <linux-nfs+bounces-13945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD01B3B038
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 03:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF23E7AD432
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4119F40B;
	Fri, 29 Aug 2025 01:04:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2332F84F
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429499; cv=none; b=WIttlf4Xi6ydwncVcmrs5LlLIk7BdN9Ngz76T1NRK5Vnbyf1ceJ8HsWRY1rggdaI0nJxDhhgxNQuPA9rWGql44JYJH46fFmiRx8AfgKWgQ8Yw/KncbVjhFTgjTJ9POLMXBXdaHUBpBA2JvGCo9Zqt7Jx7AV87X6ceLZmXxVGlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429499; c=relaxed/simple;
	bh=Vlxp7/nhem4fkR2PYHBgYYSgZdrWyYH7Y6rq30+3LCI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WDCwKcIzWC6RRdVOD7XMMQg6Hhuho/F1Y5Sixb2vKuitEulAxEeuqx+s1BDkSF5pQm7IiGI4nKK3onXiSqdlZuboGrq+P7vwhh6AtCgFgZ+T6Qwiz76+CnNvKHxvvwsD8rQzszCuAKCUlgHjg2Y51J34sWk+8YPsSmwaLejMYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1urnXq-007XeN-LP;
	Fri, 29 Aug 2025 01:04:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Harshvardhan Jha" <harshvardhan.j.jha@oracle.com>,
 "Anna Schumaker" <anna@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: don't fail immediately in rpc_wait_bit_killable()
In-reply-to: <e954bac8c996015ce93e54731c30d20a4b9c56c7.camel@kernel.org>
References: <>, <e954bac8c996015ce93e54731c30d20a4b9c56c7.camel@kernel.org>
Date: Fri, 29 Aug 2025 11:04:48 +1000
Message-id: <175642948807.2234665.11287496645872411211@noble.neil.brown.name>

On Thu, 28 Aug 2025, Trond Myklebust wrote:
> On Thu, 2025-08-28 at 18:12 +0530, Harshvardhan Jha wrote:
> > Hi there,
> >=20
> > On 20/08/25 3:08 AM, NeilBrown wrote:
> > > rpc_wait_bit_killable() is called when it is appropriate for a
> > > fatal
> > > signal to abort the wait.
> > >=20
> > > If it is called late during process exit after exit_signals() is
> > > called
> > > (and when PF_EXITING is set), it cannot receive a fatal signal so
> > > waiting indefinitely is not safe.
> > >=20
> > > However aborting immediately, as it currently does, is not ideal as
> > > it
> > > mean that the related NFS request cannot succeed, even if the
> > > network
> > > and server are working properly.
> > >=20
> > > One of the causes of filesystem IO when PF_EXITING is set is
> > > acct_process() which may access the process accounting file.=C2=A0 For a
> > > NFS-root configuration, this can be accessed over NFS.
> > >=20
> > > In this configuration LTP test "acct02" fails.
> > >=20
> > > Though waiting indefinitely is not appropriate, aborting
> > > immediately is
> > > also not desirable.=C2=A0 This patch aims for a middle ground of waiting
> > > at
> > > most 5 seconds.=C2=A0 This should be enough when NFS service is working,
> > > but
> > > not so much as to delay process exit excessively when NFS service
> > > is not
> > > functioning.
> > >=20
> > > Reported-by: Mark Brown <broonie@kernel.org>
> > > Reported-and-tested-by: Harshvardhan Jha
> > > <harshvardhan.j.jha@oracle.com>
> > > Link:
> > > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furl=
defense.com%2Fv3%2F__https%3A%2F%2Flore.kernel.org%2Flinux-nfs%2F7d4d57b0-39a=
3-49f1-8ada-60364743e3b4%40sirena.org.uk%2F__%3B!!ACWV5N9M2RV99hQ!LaRJdjZulcG=
71nHFWdEAszB9mJEhezxPsDxHO8xeQJ7P8a9UfYNRIm1ziuuHU5wxgEXW14vAqC1dlpSQraWaxA%2=
4&data=3D05%7C02%7Ctrondmy%40hammerspace.com%7C5463825a86c248e5766c08dde63063=
12%7C0d4fed5c3a7046fe9430ece41741f59e%7C0%7C0%7C638919817692991630%7CUnknown%=
7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF=
OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DGBRM89CFMk2vKyeN4yKBvjiV9I=
rODC4tbwMfRSk4Cfc%3D&reserved=3D0
> > > =C2=A0
> > > Fixes: 14e41b16e8cb ("SUNRPC: Don't allow waiting for exiting
> > > tasks")
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > > =C2=A0net/sunrpc/sched.c | 14 +++++++++-----
> > > =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> > > index 73bc39281ef5..92f39e828fbe 100644
> > > --- a/net/sunrpc/sched.c
> > > +++ b/net/sunrpc/sched.c
> > > @@ -276,11 +276,15 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
> > > =C2=A0
> > > =C2=A0static int rpc_wait_bit_killable(struct wait_bit_key *key, int
> > > mode)
> > > =C2=A0{
> > > -	if (unlikely(current->flags & PF_EXITING))
> > > -		return -EINTR;
> > > -	schedule();
> > > -	if (signal_pending_state(mode, current))
> > > -		return -ERESTARTSYS;
> > > +	if (unlikely(current->flags & PF_EXITING)) {
> > > +		/* Cannot be killed by a signal, so don't wait
> > > indefinitely */
> > > +		if (schedule_timeout(5 * HZ) =3D=3D 0)
> > > +			return -EINTR;
> > > +	} else {
> > > +		schedule();
> > > +		if (signal_pending_state(mode, current))
> > > +			return -ERESTARTSYS;
> > > +	}
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > Is it possible to get this merged in 6.17? I have tested this and the
> > LTP tests pass
>=20
> If we are in this situation, it is because some signal has already
> killed the parent task. That throws any data integrity guarantees right
> out of the window.

Or it could be because the task has exited normally.

>=20
> So what problem is this patch trying to fix?

Process accounting writes a record to the accounting file when a process
exits.  It writes this record from the context of the process that is
exiting.  It does this after signals have been disabled.

So this is not related to data integrity for any data that the process
wrote.  I believe that is all handled correctly, partly because writes
and close are performed asynchronously and partly because nfs_wb_all()
ultimately uses a non-killable wait.

It is only related to writing to the process accounting file.

Thanks,
NeilBrown



>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>=20


