Return-Path: <linux-nfs+bounces-19390-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMvLHNxpoWkOswQAu9opvQ
	(envelope-from <linux-nfs+bounces-19390-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 10:54:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A51B59F0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9487308A86C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F03803F8;
	Fri, 27 Feb 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SIYTU0p7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F436CE03;
	Fri, 27 Feb 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186062; cv=none; b=gPZThIsLMyYWoa8Ntph5Y6XSS4QFrnaKIy8NjxV0Ngvc/GuU2Z3Y2vHvI4Y1n/nnEyP/Rr3Aa75CiwkBHfxdMyRqHV6uH93O46M1AVSijFjji9S+atI+vmT9frH8IyutrpQl3goGOR7Vv0leU8VL6KfT2USzLMSWQmrtj91Y7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186062; c=relaxed/simple;
	bh=JEJTB5bNA2IqKg7kkoqkWEK6Z50IbTkVOuyUFMUaZQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pw5zhz4Ix/tdI91LqfLsBwQYgpmdK5zSUR1dhHJVONCzOKF5Em8Z68Fwrj873SJeAHEdiooJ0oWZBzzkVRq/SgGUiVvRCzuPzkoxj4tpKALRYbzoi5dUUD9+SAJu326OQAt13MuibGlpUa+En6lXn9StbEFD0yOLju+IDBmLV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SIYTU0p7; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fMkF54vvtz49CK;
	Fri, 27 Feb 2026 10:54:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1772186057;
	bh=JEJTB5bNA2IqKg7kkoqkWEK6Z50IbTkVOuyUFMUaZQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SIYTU0p7WQQrvQPKq9UJvs7+lo4Bdw6+S+yP/hQ/CdeUVvnHqc/MzQTaArU3il2sN
	 yXzHNpUPVsjNqZXnXHFeanMWj3tB9ywjKtfy3P9iU2p3S35Yfj45F6hoCz6NYgjyHs
	 vyMpyQrhJgP/KrysTyH+VyoxidI5+lr8CLJPk5+eY5A4Pd9mRI05Jxh44Gv4FIPT/c
	 dlEalmK1VPVLTkL7xx89DXm7+AydtYpTkd1S3CcFj56KJgsR5kBFRtqDWzlfppEbou
	 9lGRaAXe+/AmkplxQ2gWwS1gqWtHV4yTG5qgsadpJT/GJAhby1ATI/ShVaWAhGdW16
	 WDdc9Yj0r489g==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fMkF54BsYz7vxJ;
	Fri, 27 Feb 2026 10:54:17 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fMkF510Kjz8sbC;
	Fri, 27 Feb 2026 10:54:17 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 5039461786;
	Fri, 27 Feb 2026 10:54:16 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <418f30b5-06ae-471f-bf5f-f14f3f75deff@leemhuis.info>
Date: Fri, 27 Feb 2026 10:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No
 locks available
To: Tj <tj.iam.tj@proton.me>, 1128861@bugs.debian.org,
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177218605665.3127215.6362207666060754103@mxe9fb.netcup.net>
X-NC-CID: 2qkeduFVg/8fbJJvJbazbisUR09+48lXIaxci0UUPW39xtckrcQ=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-19390-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,leemhuis.info:mid,leemhuis.info:dkim];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 041A51B59F0
X-Rspamd-Action: no action

[CCing a few people and lists]

On 2/24/26 03:09, Tj wrote:
> Upstream commit 4cc9b9f2bf4dfe13fe573 "nfsd: refine and rename 
> NFSD_MAY_LOCK" and
>   stable v6.12.54 commit 18744bc56b0ec

In case anyone just like me is wondering: the latter is a backport of
the former.

>  (re)moves checks from  fs/nfsd/vfs.c::nfsd_permission().>   This causes NFS clients to see
> 
> $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks available

Does this happen on mainline (e.g. 7.0-rc1) as well?

Ciao, Thorsten

> Keeping the check in nfsd_permission() whilst also copying it to 
> fs/nfsd/nfsfh.c::__fh_verify() resolves the issue.
> 
> This was discovered on the Debian openQA infrastructure server when 
> upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (with 
> any earlier or later kernel version) pass NFSv3 mounted ISO images to 
> qemu-system-x86_64 and it reports:
> 
> !!! : qemu-system-x86_64: -device 
> scsi-cd,id=cd0-device,drive=cd0-overlay0,serial=cd0: Failed to get 
> "consistent read" lock: No locks available
> QEMU: Is another process using the image 
> [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
> 
> A simple reproducer with the server using:
> 
> # cat /etc/exports.d/test.exports
> /srv/NAS/test 
> fdff::/64(fsid=0,rw,no_root_squash,sync,no_subtree_check,auth_nlm)
> 
> and clients using:
> 
> # mount -t nfs [fdff::2]:/srv/NAS/test /srv/NAS/test -o 
> proto=tcp6,ro,fsc,soft
> 
> will trigger the error as shown above:
> 
> $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks available
> 
> A simple test program calling fcntl() with the same arguments QEMU uses 
> also fails in the same way.
> 
> $ ./nfs3_range_lock_test 
> /srv/NAS/test/debian-13.3.0-amd64-netinst.{iso,overlay}
> Opened base file: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> Opened overlay file: /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
> Attempting lock at 4 on /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> fcntl(fd, F_GETLK, &fl) failed on base: No locks available
> Attempting lock at 8 on /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
> fcntl(fd, F_GETLK, &fl) failed on overlay: No locks available
> 
> 


