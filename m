Return-Path: <linux-nfs+bounces-21269-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEPmI32v8WmwjgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21269-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 09:13:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53F490478
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 09:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53FEF30000BD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DBB31B830;
	Wed, 29 Apr 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="gMe3Vrd4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC3378D98
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446774; cv=pass; b=kjJBtreO8ZoLYdgV3e5wmAtjYgSUbNHTmKhh0vEeEUlNUpYmgM2MhiK1r8D1rdQY8sCUNUkF/Ir8owNt3ObWPJi8X84i7OpbF68kcjfRAjHGzuw0kco/j4sZ04v+i/JOPlqdAXZGc9GZUk4XdA0h6kwKBKKjDzGk722MiO3VzNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446774; c=relaxed/simple;
	bh=sA9Pu5mLtLWzz+S+AMlP3hv27GJvAn4Cza3HkpwQ1WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkKwsjdznTfmqaod4VCcRBkYK30abgeLy9y+Vg193+9Z/lHjBvVhykoDo77P3Sio1z+zrAw70EgPFasLeDaOYDEQ9XS3vtKhbMSbWR6FpABfSciunYDEVKQoYlbRCBTN1fXbir6aYVhGLPVR8/OCHhqycq6+Z0XMVO1mm+NmQRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=gMe3Vrd4; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso80929661fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 00:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777446771; cv=none;
        d=google.com; s=arc-20240605;
        b=hJ/8U88elrxG2uDygCV+96jfHRcxg2xBWd+N5FgFTm0WmiXTh1OqWZe7VxaB0Ej9cB
         ZbdNcBHfZBTf+vltkm3LOmylXUJFOHeF7r7k0fEuCtFvtQog/zeVljG9XtLBrgTEBpRY
         d8wIgcQe/I8IxnlH7ddsxo2V60JYhkr928hmkeFMuBZQZDLrXsqS9au/Q3+kPVBw74If
         Crg4W7Lo3oruC00Ki/+fea7aFuey/p/VAEFDmeQI4OhEz1aX5tsZw6/d2FtyfUVzaUyw
         C6qyjqJHTjoCFTcWcqg6HqUmSCLb013uvQA0ccf3fRaCrNAgepAsoet5pWXzW4GDTj+X
         MKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hd0QiK/3+MZ5bH6Qbcfj4w3emw4MOcn1cfE+KsEwnMI=;
        fh=FTf5WqloWt+YRZKv+iPD35IZOi3u/isvbT3on/lljc0=;
        b=TRTz8W+B7gaXE/57O1vRHxZArANN0n6Q83Qyoy341PuVKBQ/XG+C0NkYrLUxQoh4Wq
         0SShD+WxN0n6gqRD8h64w7DY0dqPqvm+SXvR+sChtBio5Ad5hBadAFETjLR8UEsd0sqJ
         RgLjnLA6Mjf1gXT6OgDAexGqq+DRJYEpSf0zptQLOyCvDY7HWfWDWWrO/aa2X4CNqokH
         11eib9UP9Xfbc4J8Fr3Sx5OHdkSoPADq+YXEj7vJshBBoieM+sy+YIBMZb21wFMM+3xF
         Nu4UjWx/vuzOMXh6SGkt3NmTlFotwRZBRrgxDcdAg/CmQ+CXGjRAvCOxvJXuosJ/H9OJ
         LMCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1777446771; x=1778051571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd0QiK/3+MZ5bH6Qbcfj4w3emw4MOcn1cfE+KsEwnMI=;
        b=gMe3Vrd4VjoThv00c1vgG1pEM09FZrT4TzJFMKvex6uZYrvFniFpZUeH+cmYmsKYCB
         LFlVxVoEfCktUO/LYp27iu6Nb9n7xj/IN2qvwQHku9AaYNG0sst0nIar3DyBTM1t5l96
         +uI2loQ5aduA4A0tw2dhl9AMKMpuaA0zC9QAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446771; x=1778051571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hd0QiK/3+MZ5bH6Qbcfj4w3emw4MOcn1cfE+KsEwnMI=;
        b=GjWMXKYAa9KPv04UXkQ+NX+EHptSjl+4wuq/DNMvZi0FoN/996SmYXThocWU9z+32x
         opuApzNuEfflyy7YGbCJFG3rzdShpG6RIGqbHMK/Op1EgVzsHr5JOrB/8ImoEGZE8pH/
         FBxPaP78VrlHsb4rRv2lmvAJ2s3LDmE3rZGnsXPDxH/lQflFk0GGQ0SiXuXwwxo4dJcw
         ANKW6nsZsuhwvO9Pa5bp1UmLcELuJWCDe/gpHs6fjeZIFyKIzLdCf7lNbdUrc71ggKZe
         yo7OWgEt4zJ/9vhFC58FHyApUorIrtNmlT1vkBhXCznIFzRCuQbHv6NgGBuVxWUmgXOd
         DZjg==
X-Forwarded-Encrypted: i=1; AFNElJ8V/JeyDVlPN+f4ax2ZcPGDBNP2FoEaoTaeJl3y9pUO0sBfYXj4wodtam60KoRQX0A/MbXeFyH4tiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Dnj9Cs1oltT2xuBVeggAqyFwj6ebrnXsM0EbCG2PpLms8AHs
	B1z8XKQNU4TDVniY9XZqZgAeHMKBGXvm0waOD8QH8+twCf+Jx7zpwk6z6rxplt6BDAY0WB1lvUk
	xfp4/ZGef4a4HD46fMZYlE/WeZOW/sUUrgg9WS65E
X-Gm-Gg: AeBDievD7anMaKiphuEIkASgNrpvVdGWzYnNtNIowDNNea6d9iuDgEMfAcZFjjko4mV
	t2+Co6JJRRvJn4y9VECRJ+BZG4ewq7Qnc5j4LRtCcXLsYfAjqe6IyQzfh0aeKQprpEpmnoCZmjL
	8AGxDejhHGcf3AIbG1cvsKnHPDzri6HwRAuGVnJbYdWjwlJkX6XnGCWAN1DJ5hGK+Wn00hKMUaP
	ffIiQ6CP6gzfFCS6RPKRhwU24j8vp+SyOdyfmMKI3RikgA6co/q/HEVMuPbQNl+LoZ1tL/41MeN
	4V3tK3lQxxzCS12bKPw=
X-Received: by 2002:a05:651c:154c:b0:38e:c9f:a14c with SMTP id
 38308e7fff4ca-39240f93b8emr22511341fa.24.1777446771519; Wed, 29 Apr 2026
 00:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com>
In-Reply-To: <CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com>
From: Igor Raits <igor@gooddata.com>
Date: Wed, 29 Apr 2026 09:12:40 +0200
X-Gm-Features: AVHnY4Jy2QQc-aebnhufwooi_MjKejzbo4JQLkP__QtpzVqL53dxWnMxpcmc58U
Message-ID: <CA+9S74i=TJBJjFWy1-LDqMLf1hmj5kcqNi-Yb5k79-mX1yCrLQ@mail.gmail.com>
Subject: Re: REGRESSION: NFSv4: mkdir returns EEXIST after NFS4ERR_DELAY-then-success;
To: NeilBrown <neil@brown.name>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8D53F490478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21269-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,gooddata.com:dkim,gooddata.com:email]

On Wed, Apr 29, 2026 at 7:02=E2=80=AFAM Igor Raits <igor@gooddata.com> wrot=
e:
>
> Hi all,
>
> I think I've run into an NFSv4 client regression and wanted to report
> it before I forget the details. Apologies in advance if I'm
> mis-reading the code =E2=80=94 please correct me if so.
>
> Symptom: an occasional mkdir(2) on an NFSv4 mount returns -EEXIST,
> but the directory it was supposed to create is actually present
> afterwards. It's reproducible on both NFSv4.0 and NFSv4.2 against an
> in-kernel Linux nfsd. Both client and server are running 6.19.14.
>
> Reproducer (random 16-hex names so collisions are not the cause):
>
>   N=3D2000000; base=3D/var/gdc/export
>   for ((i=3D1; i<=3DN; i++)); do
>       d=3D$base/$(openssl rand -hex 8)
>       mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=3D$i $d"
>       rmdir "$d" 2>/dev/null
>   done
>
> Failures cluster every ~2-3 minutes, and also reliably trigger on the
> first mkdir after a few minutes of mount idleness. Each failed mkdir
> takes about 100 ms.
>
> strace shows just one syscall, so userspace isn't retrying:
>
>   $ strace -ttt -e trace=3Dmkdir mkdir "$dir"
>   mkdir("/var/gdc/export/954ce422698ef4b1", 0777) =3D -1 EEXIST (File exi=
sts)
>   +++ exited with 1 +++
>
> A packet capture for one failure (NFSv4.2; the v4.0 capture has the
> same shape):
>
>   client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4ERR_DELAY (10=
008)
>   ~100 ms later
>   client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4_OK          =
  =E2=86=90 dir created
>   ~80 =C2=B5s later
>   client =E2=86=92 server  CREATE name=3D...  =E2=86=92 NFS4ERR_EXIST (17=
) =E2=86=90 server is right
>
> Three CREATE RPCs from one mkdir(2). The server looks correct: it
> returns DELAY, then OK on the retry, then EXIST when the client asks
> again for a name that now exists. The client then surfaces that final
> EXIST to userspace even though its own previous retry already
> succeeded.
>
> While poking around in fs/nfs/nfs4proc.c I noticed nfs4_proc_mkdir()
> looks like this in current master:
>
>   do {
>       alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
>       trace_nfs4_mkdir(dir, &dentry->d_name, err);
>       if (err)
>           alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
>                                                 err, &exception));
>   } while (exception.retry);
>
> If I'm reading this right, on a successful retry (err =3D=3D 0)
> nfs4_handle_exception() is skipped, so exception.retry stays at the
> value it had after the previous DELAY iteration (which is 1). The
> loop then runs once more, sends another CREATE for the same name,
> and that one legitimately gets NFS4ERR_EXIST. Other do-while loops
> in the same file (e.g. nfs4_proc_symlink) seem to call
> nfs4_handle_exception() unconditionally, which would reset
> exception.retry to 0 on success and exit the loop.
>
> git blame points at:
>
>   dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors
>                  in nfs4_do_mkdir()")
>
> (stable backport: 062feb506caf). The change makes sense in itself =E2=80=
=94
> the goal of returning the int separately from the dentry is good =E2=80=
=94 but
> the `if (err)` gate around nfs4_handle_exception() seems to be what
> introduced the retry-state issue. I might be wrong about that, though,
> so please take it with a grain of salt.
>
> Happy to provide pcaps, more traces, or test a patch if useful.
> Reproduces on demand here, so iteration should be quick.


FTR I have applied following patch and it seems to fix our issue:

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a0885ae55abc..ffd14141ea1d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct
inode *dir, struct dentry *dentry,
        do {
                alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err)=
;
                trace_nfs4_mkdir(dir, &dentry->d_name, err);
+               err =3D nfs4_handle_exception(NFS_SERVER(dir), err, &except=
ion);
                if (err)
-                       alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(=
dir),
-                                                             err,
-                                                             &exception));
+                       alias =3D ERR_PTR(err);
        } while (exception.retry);
        nfs4_label_release_security(label);

