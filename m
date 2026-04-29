Return-Path: <linux-nfs+bounces-21270-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPIXA2jZ8Wm3kgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21270-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 12:11:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB22492AC9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE7D5304D0B9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499E3BED74;
	Wed, 29 Apr 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FIHQa9GV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ST5zMI5S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735C3C9EE6
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456725; cv=none; b=MV/4/d5M4hLWFI4WH6DVHgz7f/s3io1o8I3bKY3g5/c8AacG32erzGCs1FljhTUVXsL5CHUefzAZbZjnGyCyUJ7lPyGObKFZYZKZv7WZ8E5GIwwsf/f9rlbpTvKnOU7L8/h90m59aGIMSCUU3lFqKIA4YOfh72ypmABMQidStxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456725; c=relaxed/simple;
	bh=AEqw5XfCJ6Kv7+ZpDfai2UdjR6fUtubt2JuGs5qu1ZA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=T73/hKLeeaw4Ezk4W9XZ19TixHUeuHrobV1Eoa9roA0l9YCtGAvWJ+2OdSutoQMvKjdwKrPnBkE7B5+63B+qtRVsHzMoDMniyo4eeWuLIHqTqEAZ8ptgPB+cLhg+5QTB6fonOGub4O4dKa5JoSMy4oQjqDCPpYmsZvP7Wj+Oq3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FIHQa9GV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ST5zMI5S; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DD421D0018F;
	Wed, 29 Apr 2026 05:58:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777456722; x=1777543122; bh=jJAViKPp3pGbMxfM0OGSIr5LDTzyKBiyZqk
	DCbmZcW4=; b=FIHQa9GV8LsHvaMaIGdfNl12eLW0vS1PtStjKdhLyTvoORI5Sjr
	JwE/RDUk7U/lMnQp8tdIgKJlCIgHx1e5GYzNxLYPkl4pHx0Ri/bal8MOJc0q01Fm
	SRWKslwRMUQ8+JqDBFOxUVLj/D4Y23m6wmZVmHUwUm/B/lzdpBo6EhdM08C0S9ji
	OT3BSRIVTXB13qURs+q2Vto9DfCV4CCDYtS25Z3flEa5bghJEcrdZKbWDDZKvJ4D
	Dw1V7oA7dj5T9BCWA2QQZzZuT6SI3JnO24o8bhxWolqWsRoZIoGhupby3jl7vYx6
	dy5UoYR6488X9pwUXDT7pf2TvSMs4P26O3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777456722; x=
	1777543122; bh=jJAViKPp3pGbMxfM0OGSIr5LDTzyKBiyZqkDCbmZcW4=; b=S
	T5zMI5Syt16ZNrCL7gERlWwmAY6H6eRaWAT4p1mg1+VSb5TZfyeg9su5vojRZXRJ
	9d277cUkc5ventr3EQo2yVLItyQ5s6QmbIa8ejiNpP+6UHoX9Dl1O25XwaWfR5fR
	nYV00hv+1TrOD+aXsqPo3WF3PXba8R1oYRWCTlAUBRzF+cReRbcNk/uuqQmHX9mJ
	j2zWSmn6hRYPG65UCEijYwkADVIYEotVd6cB9xhhRmQVWmNRBNtk7saMgSUcsJ6S
	w6XsOaNeMXpBA07WPahDWi85FKxOvbVt6YY7X4KxPq5fCm78pJpB8V7GHCyC7ITM
	MYrlZitj4Q00OqiqJxSaA==
X-ME-Sender: <xms:UtbxaX0D6l-fRgtRynqPfh2UkNcUDTW2pezdvCl7hshLLI-rKS4Wfw>
    <xme:UtbxaZwLc6p2bMfbvIj4ym1KenL1ibJn4u_2mdT6kRwJiliygK7QAb01njSAKEtM-
    2hKVp5IaRKQvfk9ZJcm4VVnpUDDMfPnpFK1qdT0zZzeE5NMsA>
X-ME-Received: <xmr:UtbxaRt0_TMArbyj9WrdJKIH1KPPY65uZKVjjIWkow3nId5ohqi531IKxLmRAjqgjsy00f5gE9XnIIOxr8S0KezjRZcreVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrsehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghroh
    hslhgrvhdrphhulhgthhgrrhhtsehgohhouggurghtrgdrtghomhdprhgtphhtthhopehj
    rghnrdgtihhprgesghhoohguuggrthgrrdgtohhmpdhrtghpthhtohepihhgohhrsehgoh
    houggurghtrgdrtghomh
X-ME-Proxy: <xmx:UtbxaTwhDDBFm7UgfVUJl6iP-dSx4aJeel82uvZxb8wHfpCk522Rng>
    <xmx:UtbxacDdy2zKkJ4QXZdxgemvhyGV6yCyHin319Mu_oalnt6pCkBXYw>
    <xmx:UtbxaZcJOPgsn3EGV26vtew0U9savi9CzHcH1piEjpXtWlEakIsSDw>
    <xmx:Utbxaek1tt-uOaWkE3j86Cv0YyqYnzK6GgEsFN87bw7p4w567SQwAw>
    <xmx:UtbxaUAjuYNeyPPJ9nkO8Vu3aswwFCdZHOcl2k9ZmP1AgzLAX2Q7Am7k>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 05:58:40 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Igor Raits" <igor@gooddata.com>
Cc: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 "Jaroslav Pulchart" <jaroslav.pulchart@gooddata.com>,
 "Jan Cipa" <jan.cipa@gooddata.com>
Subject:
 Re: REGRESSION: NFSv4: mkdir returns EEXIST after NFS4ERR_DELAY-then-success;
In-reply-to:
 <CA+9S74i=TJBJjFWy1-LDqMLf1hmj5kcqNi-Yb5k79-mX1yCrLQ@mail.gmail.com>
References:
 <CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com>
  <CA+9S74i=TJBJjFWy1-LDqMLf1hmj5kcqNi-Yb5k79-mX1yCrLQ@mail.gmail.com>
Date: Wed, 29 Apr 2026 19:58:36 +1000
Message-id: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: AFB22492AC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21270-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]

On Wed, 29 Apr 2026, Igor Raits wrote:
> On Wed, Apr 29, 2026 at 7:02=E2=80=AFAM Igor Raits <igor@gooddata.com> wrot=
e:
> >
> > Hi all,
> >
> > I think I've run into an NFSv4 client regression and wanted to report
> > it before I forget the details. Apologies in advance if I'm
> > mis-reading the code =E2=80=94 please correct me if so.
> >
> > Symptom: an occasional mkdir(2) on an NFSv4 mount returns -EEXIST,
> > but the directory it was supposed to create is actually present
> > afterwards. It's reproducible on both NFSv4.0 and NFSv4.2 against an
> > in-kernel Linux nfsd. Both client and server are running 6.19.14.
> >
> > Reproducer (random 16-hex names so collisions are not the cause):
> >
> >   N=3D2000000; base=3D/var/gdc/export
> >   for ((i=3D1; i<=3DN; i++)); do
> >       d=3D$base/$(openssl rand -hex 8)
> >       mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=3D$i $d"
> >       rmdir "$d" 2>/dev/null
> >   done
> >
> > Failures cluster every ~2-3 minutes, and also reliably trigger on the
> > first mkdir after a few minutes of mount idleness. Each failed mkdir
> > takes about 100 ms.
> >
> > strace shows just one syscall, so userspace isn't retrying:
> >
> >   $ strace -ttt -e trace=3Dmkdir mkdir "$dir"
> >   mkdir("/var/gdc/export/954ce422698ef4b1", 0777) =3D -1 EEXIST (File exi=
sts)
> >   +++ exited with 1 +++
> >
> > A packet capture for one failure (NFSv4.2; the v4.0 capture has the
> > same shape):
> >
> >   client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4ERR_DELAY (10=
008)
> >   ~100 ms later
> >   client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4_OK          =
  =E2=86=90 dir created
> >   ~80 =C2=B5s later
> >   client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4ERR_EXIST (17=
) =E2=86=90 server is right
> >
> > Three CREATE RPCs from one mkdir(2). The server looks correct: it
> > returns DELAY, then OK on the retry, then EXIST when the client asks
> > again for a name that now exists. The client then surfaces that final
> > EXIST to userspace even though its own previous retry already
> > succeeded.
> >
> > While poking around in fs/nfs/nfs4proc.c I noticed nfs4_proc_mkdir()
> > looks like this in current master:
> >
> >   do {
> >       alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
> >       trace_nfs4_mkdir(dir, &dentry->d_name, err);
> >       if (err)
> >           alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
> >                                                 err, &exception));
> >   } while (exception.retry);

Oh dear, that was careless of me.  We *always* need to call
nfs4_handle_exception().=20

> >
> > If I'm reading this right, on a successful retry (err =3D=3D 0)
> > nfs4_handle_exception() is skipped, so exception.retry stays at the
> > value it had after the previous DELAY iteration (which is 1). The
> > loop then runs once more, sends another CREATE for the same name,
> > and that one legitimately gets NFS4ERR_EXIST. Other do-while loops
> > in the same file (e.g. nfs4_proc_symlink) seem to call
> > nfs4_handle_exception() unconditionally, which would reset
> > exception.retry to 0 on success and exit the loop.
> >
> > git blame points at:
> >
> >   dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors
> >                  in nfs4_do_mkdir()")
> >
> > (stable backport: 062feb506caf). The change makes sense in itself =E2=80=
=94
> > the goal of returning the int separately from the dentry is good =E2=80=
=94 but
> > the `if (err)` gate around nfs4_handle_exception() seems to be what
> > introduced the retry-state issue. I might be wrong about that, though,
> > so please take it with a grain of salt.
> >
> > Happy to provide pcaps, more traces, or test a patch if useful.
> > Reproduces on demand here, so iteration should be quick.
>=20
>=20
> FTR I have applied following patch and it seems to fix our issue:
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a0885ae55abc..ffd14141ea1d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct
> inode *dir, struct dentry *dentry,
>         do {
>                 alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
>                 trace_nfs4_mkdir(dir, &dentry->d_name, err);
> +               err =3D nfs4_handle_exception(NFS_SERVER(dir), err, &except=
ion);
>                 if (err)
> -                       alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(=
dir),
> -                                                             err,
> -                                                             &exception));
> +                       alias =3D ERR_PTR(err);
>         } while (exception.retry);
>         nfs4_label_release_security(label);
>=20

That is exactly the patch I was thinking of when I saw your first email.
If you would like to create a properly formatted patch for submission,
please add
  Reviewed-by: NeilBrown <neil@brown.name>

If you don't want to, I can do it for you.

Thanks for the report.

NeilBrown


