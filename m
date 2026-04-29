Return-Path: <linux-nfs+bounces-21266-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDusB+KQ8WmviAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21266-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 07:02:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C2948F583
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 07:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 847E33012CCF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 05:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E89463;
	Wed, 29 Apr 2026 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="E8W7yT9F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A454315F
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777438942; cv=pass; b=Nf3PQo6Ic1Wwy1FXESD7XlE7/WsmJ86PA2XgvxQk4UM68i3XL9b9+v3CrArNtR9RBp+jvyD1uNnc8MRM9t7svAKEB7t4vzWhm5PFqcfI/nCmd3BEqlAjTsIVLnhkUnpsEhZ05g5Mr0UwGjcEuleRft8itmCtx53GdSr807tAqf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777438942; c=relaxed/simple;
	bh=Fy+dsR76z+szAs2ilbwSLWoevPh//rY8lx2TWPwq4Jc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o+UsO2c2jfkPLIVylU0BUO7RmingsBCzQGRXDs6NqzsXKpF985SvXc3XE+lv75Ef+jXxX0eGszi2zs+On4HPG51T8IRfyAKK/nVDplYT5oII/XpTO2sxBBIe0Itq9YhBH1KIWRH7oBLsx2DnewA9Gh43BjrH/tZ/00ppe8FXEDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=E8W7yT9F; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a01c80c34so119281161fa.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 22:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777438939; cv=none;
        d=google.com; s=arc-20240605;
        b=FTSrUv5c2oZ3nDCPFCSecjUCw3W0aK4H2XOqpsLmjKogxHk1SAgcuVUSAr/HIguM2p
         gFR1lFoVcBKWkzDHDKhbPxvZJE7rgZqb8OfKhcWFa0f8cbi33ktOIK5MCo6kW1w3G0yP
         kAk7jKav6VP2+YxwK1Vas+WXH+7YiDAYB8/IL4wWwVjc1rWN6aGlQP3O2v0bcq87KsVI
         KTV3Bt2/mLeAvSSTy51D4z5sRMV7CIRR6Puq+nrCRfypXe7G3d1CmGIdCUi6pB33lwIz
         hg4K7LGtgD2/MWiJA4WO9hB6TEaryamRhpE1p9lxiXfUegGYHCODCNbvc5Io0IQ0ljF5
         eqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=AFE3ltD1Kz0RN04a7QywuACZ5qroCXvzl9hCdk/3d6E=;
        fh=7J9Sdove5eUmyIFLeirS0gfG6OOdoZBxxOZOZsuae+o=;
        b=aM9abpYis9i5swe7w8lEQp+XmiVeVjnPtiUgxKtT1cIHqs+xGRTOZoC1fZDga1rpKB
         ERh2pS5URiqfuOU7WOsKFQc/tbLb62LPavqj0yWhPyb9MxUdxa6d5quEYSCLeL4tZBop
         d3UXNOxd+J1BXQq6T/kBiJ+vevc+8T3qbL1wDCxl4EVUZO5Zt8bPaEn4p/j22no6rCxi
         dvykXAEx3at/9Q5sHA19YnTIRCk7CJQbI2scFhzfYhfl3VAxI5VZ6JxiVMyZ4qGDcu3T
         505qgDR191ysFyskP8f9CWNHo6FTmHtFL/5OlFq+Gc6Hrz/9BeI+sRDBAZ6wjgsL8FCZ
         OknA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1777438939; x=1778043739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFE3ltD1Kz0RN04a7QywuACZ5qroCXvzl9hCdk/3d6E=;
        b=E8W7yT9FbyQYaaLqTXIkxMqDEhp0LJ+/o7IPEUpKPZP5lgAAluKq/IMjYyKES2Eb7+
         MIVFwUHOMAWCftRWQEkF6lJeO9GC2684hh+I0SI3PCPmoa3QHqfveZ60RbM4+ZKiUQCp
         VktV25WfMmIl+fhEqA9AjtqLVEogGBXAkwyHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777438939; x=1778043739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFE3ltD1Kz0RN04a7QywuACZ5qroCXvzl9hCdk/3d6E=;
        b=D3Nynn6nZdhze063hb8fcS7VEOHRqmQmJkyTCuXT9YD3arSrqL29kQwxaz+aDH3Z8B
         bVs1vmohX4mAeKxMg7pPkZvsAPQjPYD3PUBPGLoXqbucObi+U9KdCSg/QPPfA0LuoIms
         /1/K795hO32E5+Tx02z7tRRG3RmHYEPTM1twd9evsM/Oi7rQ2sQho5QyDnt1Kod2nKr5
         DgD5XvRqiQkts37dEfpR2MgZ9wWfq8s3mUtZ8sPBQBFMkYg+5cqg+SZzcSchfJU886QP
         wwakW3+lJW5IvB3+x2cyUer9i5BWUgRdtAojk2bw2o+gGUC7j2YwYdscopgbCYpGP2d1
         DggQ==
X-Forwarded-Encrypted: i=1; AFNElJ/o173NCNF9iHVzYwIsw/tTAldLt2LqTXo7A4mG1utKxcwjZQf7fEo7C9dRmBYTyEBqhXJlm+Z1do8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssS55PIRvyVQF40IH5zOdGmqkynQYCuATFttne3Jajjlvhs7j
	y8/KYFwef4FEC3Cvxm8rrdKDaJMKGWonsRhmDbX4pOudZZK2Khy8zDAJHLSjMHhEay4CwbvF2GM
	LXMqhwkiwtEbEZvcDVovJcMWZDbk2JXW02jmi0yDR
X-Gm-Gg: AeBDiesCNzFfrXJCea/HbNuJZ/48p8eKlc1D3WYB0Za+GXCK/Tg9NSowi2cjkRiKZ0O
	MFelpk4k9oRAXlNSX0uVq3IkwTFDl5B3opRycGRtv3B08x2OcbSZEm04q2L23H6A3dqGz1/xq7o
	dgjDRvp9bL0lrAO8uINvmO5Qe2jDo+jdIiIjYdxkZWuuGhIo55KLNxgFYuxuUlolRrB6BRIiTwQ
	gZo2+3df1+FJ/kJ0pVDL8peHMu/tsfrrNBkwQu28P6j+zgTwpeqdIwUZekoVfNZZJEYruLWRuPy
	xzEw6JPzCjW2SqwfXu0=
X-Received: by 2002:a05:6512:3b11:b0:5a2:b903:3b43 with SMTP id
 2adb3069b0e04-5a74660485amr2295809e87.7.1777438939221; Tue, 28 Apr 2026
 22:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Igor Raits <igor@gooddata.com>
Date: Wed, 29 Apr 2026 07:02:08 +0200
X-Gm-Features: AVHnY4JpLY_MPfm1ZCuATJIZatk8cSp_s7l210KHBWS-tsS0rMjfYtshcj6Zp5I
Message-ID: <CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com>
Subject: REGRESSION: NFSv4: mkdir returns EEXIST after NFS4ERR_DELAY-then-success;
To: NeilBrown <neil@brown.name>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D9C2948F583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21266-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor@gooddata.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gooddata.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,gooddata.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi all,

I think I've run into an NFSv4 client regression and wanted to report
it before I forget the details. Apologies in advance if I'm
mis-reading the code =E2=80=94 please correct me if so.

Symptom: an occasional mkdir(2) on an NFSv4 mount returns -EEXIST,
but the directory it was supposed to create is actually present
afterwards. It's reproducible on both NFSv4.0 and NFSv4.2 against an
in-kernel Linux nfsd. Both client and server are running 6.19.14.

Reproducer (random 16-hex names so collisions are not the cause):

  N=3D2000000; base=3D/var/gdc/export
  for ((i=3D1; i<=3DN; i++)); do
      d=3D$base/$(openssl rand -hex 8)
      mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=3D$i $d"
      rmdir "$d" 2>/dev/null
  done

Failures cluster every ~2-3 minutes, and also reliably trigger on the
first mkdir after a few minutes of mount idleness. Each failed mkdir
takes about 100 ms.

strace shows just one syscall, so userspace isn't retrying:

  $ strace -ttt -e trace=3Dmkdir mkdir "$dir"
  mkdir("/var/gdc/export/954ce422698ef4b1", 0777) =3D -1 EEXIST (File exist=
s)
  +++ exited with 1 +++

A packet capture for one failure (NFSv4.2; the v4.0 capture has the
same shape):

  client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4ERR_DELAY (1000=
8)
  ~100 ms later
  client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4_OK            =
=E2=86=90 dir created
  ~80 =C2=B5s later
  client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4ERR_EXIST (17) =
=E2=86=90 server is right

Three CREATE RPCs from one mkdir(2). The server looks correct: it
returns DELAY, then OK on the retry, then EXIST when the client asks
again for a name that now exists. The client then surfaces that final
EXIST to userspace even though its own previous retry already
succeeded.

While poking around in fs/nfs/nfs4proc.c I noticed nfs4_proc_mkdir()
looks like this in current master:

  do {
      alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
      trace_nfs4_mkdir(dir, &dentry->d_name, err);
      if (err)
          alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
                                                err, &exception));
  } while (exception.retry);

If I'm reading this right, on a successful retry (err =3D=3D 0)
nfs4_handle_exception() is skipped, so exception.retry stays at the
value it had after the previous DELAY iteration (which is 1). The
loop then runs once more, sends another CREATE for the same name,
and that one legitimately gets NFS4ERR_EXIST. Other do-while loops
in the same file (e.g. nfs4_proc_symlink) seem to call
nfs4_handle_exception() unconditionally, which would reset
exception.retry to 0 on success and exit the loop.

git blame points at:

  dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors
                 in nfs4_do_mkdir()")

(stable backport: 062feb506caf). The change makes sense in itself =E2=80=94
the goal of returning the int separately from the dentry is good =E2=80=94 =
but
the `if (err)` gate around nfs4_handle_exception() seems to be what
introduced the retry-state issue. I might be wrong about that, though,
so please take it with a grain of salt.

Happy to provide pcaps, more traces, or test a patch if useful.
Reproduces on demand here, so iteration should be quick.

Thanks for all the work on NFS,
Igor

