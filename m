Return-Path: <linux-nfs+bounces-20683-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGDcCzc51GkksQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20683-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 00:52:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFEE3A7F5D
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 00:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9C8D305541C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CAF39E6CB;
	Mon,  6 Apr 2026 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BYSPdryp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275602749DF
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515830; cv=pass; b=rxUHrglL3X9w3Cb0Hr0XwKkIy0N8+QTU+lJY6TgFkF1oLHuq949gZpmByHtpCVQbg3lG8obwLR5X2mh9q3OnfLWkotKr00UPNqZfePqhD8cXznV7GcLZT1mflgaSxjn9R6OFNlfYBYCE6DL5uAXcZdBKph9cFh05xGVbOM77Uyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515830; c=relaxed/simple;
	bh=XDyLpbc9ohDY7RWm/mcYbIKNlcaUGjbaFfb70lhLLII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqB9LJjQ7YfoIANHLv8b80WMTFPJ9CBiyUK551UCn4gZqaxSgd570OuXgHNqL0barCmYynk853gP3wA9Sz4PQanp0gh4scn17tdkE3n40N/6ux/cvcw65gO4/3yjUR234XcwtFnd2HIZlvVYQ7+ofi+V9o8IcsYPbGQRom8zu9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BYSPdryp; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66e6f1d8237so853908a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Apr 2026 15:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775515826; cv=none;
        d=google.com; s=arc-20240605;
        b=NEvXmwguhClv60tYdCtKG4SxvFNDb+BSDTnpCSEWBeb+nAAB+uP86mcIggn2MBcrT5
         GgWkda7Dgl0WMGkpXovIgk12zVxzjIl4z2iBYZGP82C3X79Yt2+MFEuHfZOLfOMpV0SC
         A50Z7mmxLIKRL+LaINKswvrMMjalVfm0ywwBljxD3qpjvy/eKzfJ8mDPKvChjvUF2BW8
         DiuZMhLW6w8ef2XS0lU2Qf4JHVfJok/KWML5Vfx04GUGZyALZlqUjmZyWjOJEtcxpAiD
         61Gnhp4+LtJtwqlojbNhJNcG53iFUNSZpj2itqfCGF1aRjEHKW0PURiZ9b1pM81aE8af
         AuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDyLpbc9ohDY7RWm/mcYbIKNlcaUGjbaFfb70lhLLII=;
        fh=Iy2qMoYOeiVQ69/VQqoyp0jUMvV0RukjWwJd91fGT3g=;
        b=Xt+zVN+f95GQ9FW7zSknZdnrRApffcuvT7tlP+T8YpO9tHV6E4OCu7qxG7xVxKLWvo
         o0Pke/TKNWy77LWqisSwR31Ex4VVZR1XeR9MAUXpXULIc15iZ+hxHDINg3ocsPhmH8hB
         hxyV1pAwylGXm1eX1Yw4nJ9X7kCZyg7AB5JtSSGPPQKRtXKqearKkvZqL7KqmdG85pfY
         pOKuUX6+rlv+jBiHBbZN+JrQWOxdNDBsvkhImL0a5yLjI93wxqFDeEUkB7IeUWyekbP9
         8JjgiMar9Fs5FsJlmxg7L0LJU+suOlNNK6CY1kfPiguJoYILgsw6GmdQYew3U7kT7cU/
         IegA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775515826; x=1776120626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDyLpbc9ohDY7RWm/mcYbIKNlcaUGjbaFfb70lhLLII=;
        b=BYSPdrypomd6Cls+27YMeWmjR2m84Zh7RbdO2sH7YL4ZTd9SCB+AX8Dol/YDLYgtWs
         9srXGFGXNkTwmH0WSGJvgu4RISuiPPx7/ehpGlg5g7VTMHcOtR+n3zrCVR79GT+0lrIy
         4pHMsTzgdcRuDy17RSdvuAeMKJPJJjcj1Cu6k1bn+1hvaAm8SAEMpMGRjuU4CyWdxpxE
         4KXUO/xGzjMlItiY5peSks8O8r1C3UUHhfQcsX4fesrAYCK2uBeTdmxqaj2WL0/GvL+h
         4WuLfSDBlLCu2tK6gkQHb+LEvVGXRnoUTzLnOeys8rV/ipsp6YChO2ClL1Yy/d5PADci
         mORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775515826; x=1776120626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDyLpbc9ohDY7RWm/mcYbIKNlcaUGjbaFfb70lhLLII=;
        b=aE5QI+QosCA+lrO+K9iNdgac57/AN5kHBc9bUHc7epgi0NX1zdAmbZET+p8nSCMIoC
         5rHdP9gUwmLYcDR/i8cAY+Yfxb0Wbd0vfev1oLmLof/fflA+UZfPtRMjJj1ZcKSkxXqe
         wK1qAEr414vbKl8RsZLTrx8xcBYPKuzJX/rYe08nHcbwKitTpEqO3alCETnUQrPDLgPL
         AgGli3KEA2lFhYVmFkg6685bH22pmACVYWWbdkUQT4BnwVqOJShdFn1tWnveFqrAjvOS
         piy0PBhScXKwqRm6wLrWslHv0Sa8J7I9U+0TT9A7Y2F5lxgkZ3+SMrNWqI6kBRUR0OAD
         9j3w==
X-Gm-Message-State: AOJu0Yz5XEQwN+/gylyhT4E0zQsC9j1c1sjCtA6UoBwULfQ2ExQq5JpP
	V88eNdKq/U8GCGElENQIIRiRato0jocXrKUdb2qlYVVewB5Pm1PqWx3VKdlUZjY5mPQKBZoYl0M
	vSH1Qco4/CBZMGSAyRbdDO3ryU3RnOQ5A4kf1Bok8fQJCJ1ajrWzmMUY=
X-Gm-Gg: AeBDieswv1nx0zb9tBSf7Ek6wd5u3uC/gXS+BnEwLbjq64OQfsg17Buz2GU9r53Ln36
	VwUxbfdA8wGnm6ZX3/pOf1b2l4Bp+fEovsd2FEqayRho0RaWMgFoynF3/t7ePd51NyBQ4rMgvXp
	2iTD0yNIR7EAQCDirO3NZ1tW0mIV//aQq6jDgcx8QndYJXRCHSwZ05tqNyiPVaZsc1IgKhT0wiv
	HMvJNfoNQ7BLeCGR6Vb6xgZ3250/fMuem5D8hb7uKRXeAehc26EE6xgcapM46jzcBs0zmT6ELhD
	H3T+JCe3pvA7EO9/5UtHPwvHjl86R5VPy5TVo8I=
X-Received: by 2002:a05:6402:4402:b0:66e:8dfb:3417 with SMTP id
 4fb4d7f45d1cf-66e8dfb350fmr5081527a12.11.1775515826328; Mon, 06 Apr 2026
 15:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeb9+nedZXHXzeCQOo5tJ_kYAYC=sVrzNEtGBACmQKEis4mJA@mail.gmail.com>
 <5b6c25a9f1d8d0f8c9a1fe8f7bf83f749aeacc20.camel@kernel.org>
In-Reply-To: <5b6c25a9f1d8d0f8c9a1fe8f7bf83f749aeacc20.camel@kernel.org>
From: Jon Curley <jcurley@purestorage.com>
Date: Mon, 6 Apr 2026 15:49:50 -0700
X-Gm-Features: AQROBzD_ClLd4N7QwC9lOZVDFXSSxmX-8xanTrFLEL-U_Z-vdE2iV4PekmJyLmU
Message-ID: <CAHeb9+=3d+yErB+a0rhW0v+n1kV348E+8veznYszXzkkbOMVJg@mail.gmail.com>
Subject: Re: NFS close does not block when server is unavailable
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-20683-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jcurley@purestorage.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7FFEE3A7F5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 1:58=E2=80=AFPM Trond Myklebust <trondmy@kernel.org>=
 wrote:
>
> Hi Jon,
>
> On Mon, 2026-04-06 at 08:36 -0700, Jon Curley wrote:
> > Hi Trond,
> >
> > We've recently been investigating test failures in our automation
> > linked to server failures. What we've noticed is that failures during
> > WRITE do not block close(). Close simply returns success even though
> > the writes are in a failure loop.
> >
> > This is easy to reproduce using flexfiles. For example, the flexfile
> > RFC states that returning EACCES is a mechanism for fencing files. If
> > you create a server where writes always return that error, commands
> > like dd will return success while the writes are in a RESET_TO_PNFS
> > loop.
> >
> > I'm not trying to get into an O_PONIES argument here but I always
> > thought NFS close-to-open semantics meant that NFS close makes a
> > strict effort to flush writes to the server before finishing.
> >
> > I've been digging into how the NFS client guarantees writes get
> > flushed. I noticed that nfs/file.c:nfs_file_fsync goes through a much
> > more rigorous algorithm to flush writes in the face of server
> > unavailability when compared to nfs/file.c:nfs_file_flush. The
> > redirtied_pages interlock is especially critical for ensuring
> > RESET_TO_PNFS events block the syscall from returning.
> >
> > At first I thought this was intentional. But after looking at the
> > history, I found this commit:
> >
> > "NFS: Don't inadvertently clear writeback errors" -
> > https://github.com/torvalds/linux/commit/aded8d7b54f250af6deb72fde47529=
1cfba513d1
> >
> > That diff replaced calls to "vfs_fsync" with "nfs_wb_all" in several
> > places including nfs_file_flush. Since the diff makes no mention of
> > reducing the guarantees of nfs_file_flush & etc I'm wondering if this
> > effect was unintentional?
> >
> > Does it make sense to modify nfs_wb_all to have a loop like
> > nfs_file_fsync does? Or introduce a new function?
> >
>
> We've always had the rule that errors that are classified as "fatal" on
> the server should be reported as such through the same mechanisms as
> they would in POSIX, and that the effects should be the same. While
> "EACCES" is not technically allowed by POSIX as a response to WRITE, it
> was necessary to allow it in NFS because NFS servers do check
> permissions on I/O. Even in NFSv4, the presence of a stateid that
> passed OPEN checks does not guarantee that the client is allowed to
> write out its data to the file.
>
> Now that said, the pNFS flexfiles protocol introduces a subtlety here
> in that the client should not be considering any error that was
> returned by a data server as being fatal. Instead, it should be
> reporting the error back to the metadata server, and either failing
> over to another mirror (for the case of a READ) or returning the layout
> and asking for a new layout (for the case of a WRITE or if there are no
> more mirrors to READ from). The LAYOUTGET may then return the fatal
> error, if the metadata server is out of options for fixing the problem.
>
> So the above governs how hard mounts handle write errors.
>
> Now the difference between how fsync() and close() work is really down
> to whether or not we need to give a hard guarantee that the data is
> really on disk or not when the syscall completes.
>
> fsync() definitely needs to guarantee that data is really on storage in
> the case where it doesn't flag an error. The problem is that a system
> that relies on resends, and that doesn't block new writes from
> occurring is inherently prone to live locks. We try to handle that in
> nfs_file_fsync() by monitoring a 'redirtied_pages' counter that tells
> us how many resends occurred in the last attempt to flush, however that
> doesn't suffice to completely avoid live locks.
>
> close() does not need to guarantee that the data is on storage, because
> POSIX doesn't require it to. It's just a convenience that ensures
> close-to-open semantics can be made to work. For that reason, it just
> calls nfs_wb_all(), which does not wait for resends to finish, and thus
> avoids live locks.
>
> Now we can definitely discuss whether or not that close() behaviour is
> correct: it does not lose data (so there are no hard mount violations),
> but it also doesn't offer the same guarantees that fsync() does w.r.t.
> whether the data is on disk on exit. I just wanted to first make sure
> that we're on the same page concerning hard mount semantics.

Right, I agree that POSIX doesn't require persistence to storage after
close. If this were simply a matter of persistence I think I might be
satisfied with that answer. My concern is incorrect application
behavior & compatibility.

NFS introduces additional complications because of its distributed
nature. Here is an example from our automated testing. The test
involved writing to a file and then calling truncate from a single
client:

1. Write to the file, extending it to size N. (dd write to file)
2. Assert the file size equals N. (stat file)
3. Truncate the file to size M. M < N (ftruncate file)
4. Assert that the file size equals M. (stat file)

This test would occasionally fail at step 4 in our automation. The
file size will equal the written size N. We discovered that because
the close flush did not finish the writes in step 1, the client
reordered writeback after the setattr in step 3. This resulted in an
application failure regardless of data persistence. Reordering
operations to storage caused incorrect behavior. I suspect this
violates POSIX semantics?

NFS client as currently implemented seems to require strict close
semantics to achieve correct application behavior. Other cases can be
imagined with applications that require close-to-open semantics when
coordinating updates among multiple clients. I already hear plenty of
complaints that NFS with default mount settings isn't POSIX compatible
because writes aren't visible to other clients after the write syscall
completes. Would we start telling people that the rule is really
fsync-close-to-open?

