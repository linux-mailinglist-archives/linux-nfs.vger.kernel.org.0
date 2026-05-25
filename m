Return-Path: <linux-nfs+bounces-21912-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFRpKiYkFGrfKAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21912-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:27:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6D5C93D2
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3D230068D8
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72F332EC8;
	Mon, 25 May 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KP3N/G0H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVlzX5Wv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86425324B22
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704868; cv=pass; b=IfCOxvKDbHPY7WblSAKOp9UIZ+EVO57Zjhm1R79qP3S9Aw0N+2cmsz7IdNQkxLXhy68TmRea1XxGy5ybB2ocCdSWxEZV1YNWpm+vaBE02QJZI+bAX3Vqr+17U/CLwgYbDI96aIPlrQmkbifi8vQulauicnK7VjKV7kn4yQa3h6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704868; c=relaxed/simple;
	bh=3+CJJSAcNOvTroPkljRRRI6NmbMgoySrV7CNc/Xfp2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V135xXgOa0oVrnGvDPyMW9mA2MFRcMOgl2JAMQoE3Iaf17q8YRDRisYqg2xOV69KmuvqE7Gf9gl60keaVa4bPK2JireyyzCdnrf9w3/UBtzs5T1H5mjoYHSUjNM8CrW3WemHlTz4qNn26Ufgi0dqkoFXSxbu4TpGiLuo2tpxaYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KP3N/G0H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVlzX5Wv; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779704865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuAV0Vn0ry6gKLZxEEv4Gj/qkGI1CGH4xvvJ2wkLbfc=;
	b=KP3N/G0Hq+7DiinanL/rseChFvXs0WTySwlg6iCfVtCpeIpMXb8X0AZR8PWsnuffWMp/xN
	+905Z1llEPZXWycTpPEAwnWpq50qHWtfpzXf8Q98fTpkS/VW15Y8mDfrW1NuX3pzfZctS2
	p8uV/aF+hI5y1ZXsXrDLB32RCgvi2os=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-_jehSRQfNnq0av42IROjeA-1; Mon, 25 May 2026 06:27:43 -0400
X-MC-Unique: _jehSRQfNnq0av42IROjeA-1
X-Mimecast-MFC-AGG-ID: _jehSRQfNnq0av42IROjeA_1779704863
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6aeb3637so227985545ad.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 03:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779704863; cv=none;
        d=google.com; s=arc-20240605;
        b=EzWCOkhafyNihXj2LBF5K6j+jRnWQD/aHjyKQz0SpLBqYQwoDLffpHlJsv9ZE8y79p
         wM0bb0QKSuICTrmmVzSzWxwb0vkqvDZoR2z8KRHzNT15iBfo7EYEdnDwHvJx8uSQHokb
         DI2n4uFymKEQ+kM5sRIv3snaw8xyejY/9PMcQo3YB0h7LPEdIaaWcmAMbnJ8aclpY3ej
         bNBfzGVjluqaWAtO3QHAMRA29nrh5TDkBz0WdgQ4waFlM4MUZXNLUe1B+xN28mKFpfKj
         333hf4k7xjTmEZe/j1o2HgSU75FEt9sC2LJQthAlVSGYVgUGdFlTIjP03xj2t3q/RaWE
         UNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BuAV0Vn0ry6gKLZxEEv4Gj/qkGI1CGH4xvvJ2wkLbfc=;
        fh=E4BTQDYkR4dCXWX08zurlnjpPA9mGUpU7RVQsLCbozY=;
        b=gKKZxMQ9o+9kQmem/EwVuSDGO8FbJd2k3mkLi3nBSresoWBXPCmSPpFh63NKFB6Qm3
         hXeuFWx18fef3fggBYNstJoP+FHPz3j56cJxbCsqov9s+9L0yZO7ELah+mLzlRNRpa+7
         JFflkLl0gbCkJf9nr1ALrj+QqZFfCUukw7e07qfus4L3QUG+MvPJYmqN+jKtOctMD05k
         NGnVzjhpVp5QtqTrHhS8/ybyNtgi8bNoPojHY8Q7e8V1zeQPN4dyhmox65zIMqKzkpMo
         BvRM2pfLpW5GMvOOL51vbpjb9zI3RQ5aSvYeIwG0a4J7/qmbHgCCFT5nSADDlbkdVVMK
         NXbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779704863; x=1780309663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuAV0Vn0ry6gKLZxEEv4Gj/qkGI1CGH4xvvJ2wkLbfc=;
        b=BVlzX5Wv6ahaFvDLuPk84MvXUfpylFevTAH7MmZ65fSeZFVkXF8NtG1nTbMw4WXM5m
         1hRORt0hIWbYGAhHuQVyVO0CbptKqefwsKKPrt+T7qLtnpRc0HQjh4tW00uM4/sC0Ota
         N49LOkkwBUugFK/+7tcUCexFuk3WxFJPqJJvfV0kNwvxoYutaXXETMQbTCcUyiQQZpVh
         TqxOhwKCUVkx5AzcjddMgIoHNqJlvTx3DpL07bEetJ7pfeHgedPodkD+9MvsT6EjGBob
         mcLwIVXLOUIZnGbrWGW08RWprthsI5y7/sr525tftPFEUAjU3dqchqKdpun9kKm9tkWp
         8bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704863; x=1780309663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BuAV0Vn0ry6gKLZxEEv4Gj/qkGI1CGH4xvvJ2wkLbfc=;
        b=khxBapbZotr8nDucr7SV/cyAvYBl/4u5xfTsyQPsm0L0hh2smMjWKEmgRVL3yt+zgw
         dkrgDpRgXifsSV7xW0Hwx/tzo+fPKvtzPS598GIbN+Ekf/o0+W7EIP92rDP55lC6WoSV
         uMBN7+jXTi84SBp6rwXGN0P4xDonTx4W7PsODEjtGeeCpU6xWh0ZJPX9hxHr/UNFi/Ne
         RvUZaEeo7xO8gd5X0kFgNf5ktj9NSeCQvy3lEqX/UL2JRTdinv7rFwWDxacrFozq7snB
         V6bakY7qU64KrrpmK9rlw6QTFfnbCxBTcRWzETvINyDxwI2gK7YSXlgnMkyEwo9v28Ue
         31Sg==
X-Gm-Message-State: AOJu0YzhdBg1NyZuZmMg0v24n32GBP933etw/x2aRbivlT7dDOMVTEsP
	SM6jW+aJOnITWBxsyuF6bTlMVUKJHiL1/Tl+LiDrmLHBo7bDwHxh9i7BPaSA8uHdbVciMxGbMpN
	S2ziS43VQx3Al1jlga+iczb5k6GZxp+yAwJZY2UVTYwvUsPWwePAp/O2o2/uWF3v0jr60f5l8wu
	2MiDurXDNWO21TLEbnW4cxNlPM/RHWJRaWquZOa4DY+hKtdK9deA==
X-Gm-Gg: Acq92OHbFBh2e5KX4tysqtus6tLSNUhX+pfNvXriuXzoo4XY/4lD46+oR1fuMZLb8we
	4doCKgm9RPWbrOaKr43ihqFchYgxuH6dOFWDhnk6vSDTfnIn8IB47jgU/1YF6hwI/n5MHNz/jy6
	hTExjnRC9nDdHZMza2g62+4BDYdp54mHA4EKk89sdVYJ1CV6XgiS35EyF9MvfhK4cefh9b5PPXN
	cJLhQ==
X-Received: by 2002:a17:902:d4c9:b0:2bc:dd58:3dc4 with SMTP id d9443c01a7336-2beb0758026mr153442135ad.32.1779704862799;
        Mon, 25 May 2026 03:27:42 -0700 (PDT)
X-Received: by 2002:a17:902:d4c9:b0:2bc:dd58:3dc4 with SMTP id
 d9443c01a7336-2beb0758026mr153441825ad.32.1779704862283; Mon, 25 May 2026
 03:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521132410.1072478-1-omosnace@redhat.com>
In-Reply-To: <20260521132410.1072478-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 25 May 2026 12:27:31 +0200
X-Gm-Features: AVHnY4I34BHZQpEIJhB2UVJZv1FrxJSirG4tpeEuI6JCPBzag-eJWlH-dw9AYwQ
Message-ID: <CAFqZXNuURbDyH4fnx+Dk5vV+7_bqWnB+r5ZT=aC2fc5ZQqfAFQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_access_calc_mask() corner cases
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21912-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 28A6D5C93D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The special case for special files (neither regular file nor directory)
> is inconsistent with the perms requested in nfs_do_access() and the
> MAY_WRITE condition seems incorrect (checks just `access_result &
> NFS_MAY_WRITE` instead of `(access_result & NFS_MAY_WRITE) =3D=3D
> NFS_MAY_WRITE` as is the pattern for the other cases).
>
> Since nfs_access_calc_mask() requests the same access bits for regular
> and special files, we end up with nfs_access_calc_mask() that treats
> both the same as well.
>
> Notably, this fixes a corner case inconsistency between NFS and classic
> filesystems when calling access("...", X_OK) on special files (i.e.
> fifo, block device, and character device; symlink is special here). On
> classic filesystems the result of that call depends on the UNIX
> permissions of the file, while on NFS it would always fail. See a test
> script below that demonstrates this difference:
>
>     tmpdir=3D"$(mktemp -d)"
>     trap 'rm -rf "$tmpdir"' EXIT
>
>     systemctl start nfs-server
>     exportfs -o rw,no_root_squash,fsid=3D0 "localhost:$tmpdir"
>     mount -t nfs localhost:/ /mnt
>
>     mkfifo "$tmpdir/fifo"
>     mknod "$tmpdir/chrdev" c 1 3
>     mknod "$tmpdir/blkdev" b 7 0
>
>     for f in fifo chrdev blkdev; do
>         python3 -c "import os; print(os.access('$tmpdir/$f', os.X_OK))"
>     done
>
>     for f in fifo chrdev blkdev; do
>         python3 -c "import os; print(os.access('/mnt/$f', os.X_OK))"
>     done
>
>     umount /mnt
>     chmod u+x "$tmpdir/"*
>     mount -t nfs localhost:/ /mnt
>
>     for f in fifo chrdev blkdev; do
>         python3 -c "import os; print(os.access('$tmpdir/$f', os.X_OK))"
>     done
>
>     for f in fifo chrdev blkdev; do
>         python3 -c "import os; print(os.access('/mnt/$f', os.X_OK))"
>     done
>
>     umount /mnt
>     exportfs -u "localhost:$tmpdir"
>
> Note that on some Fedora/RHEL systems you may need to also do
> `setenforce 0` before running the script, because the SELinux policy
> could block the execute permission for the special files on the server
> side - this bug will be fixed independently in the policy.
>
> Fixes: ecbb903c5674 ("NFS: Be more careful about mapping file permissions=
")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

I can see that the patch has been marked as "Not Applicable" in
Patchwork [1], but I can't see any reply explaining why. Did it happen
by mistake? Or otherwise what's wrong with the patch?

[1] https://patchwork.kernel.org/project/linux-nfs/patch/20260521132410.107=
2478-1-omosnace@redhat.com/

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


