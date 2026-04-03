Return-Path: <linux-nfs+bounces-20623-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIGGOFG6z2kd0AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20623-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:02:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAE394480
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892CE30AB609
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4863B0AC3;
	Fri,  3 Apr 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXoZfRqR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuhV1B6G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F013ACA46
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221011; cv=none; b=Z9zJFI+a4rKqRZHVI5t9wZUXaIx36TNPI0iD8AGmne2FAcAc45Oey4QN5iDZJgtjmv4mN1bch8YgpKDa+4ZsztnmGRlngJcQw6wxjV29eNM8TyCdfnSiTMIKy8vLo6J173WOl9TZjukcuZFKtgug8c6fh26y44EPms9zgQ0j+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221011; c=relaxed/simple;
	bh=BBH0UPnowGXo0c/pOBVyKuoVZV2tVnA4j1dWyn8K2jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYkLNb5KlT4+qGpcAEQD9zrIeYQZDNvQ6eLuLzr0CMvQfZ1ZiDrN2Kg/JETHJktGZWTXLKrbJPU6fYggrjFTg2q0HoaJwl7EzwW0Vph19nvybHTH3TCW5JEny0c1ZMjumeytJW55EpPJFTgWGLp1z4XgypANw1fTTc8qy9ArSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXoZfRqR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuhV1B6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775220998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkDbnzgFZyJLtns9wQGwwzMnLezdLmwC4PncLpVj4QA=;
	b=aXoZfRqR3xE+zsP/eE9Vkuzty7N39NQJYLfYWd1jgRcd9DRzMBK1L1Z9zFxJ2pcONrH2wZ
	XfSyaPY7fvALwJZpKSi/8CJkkvF6Gi45chtBreE+ohi8E3tU2HjJ6ZtfcwqkdVDdTGQrmg
	5qNLZwa6b6h5AH2dWat5CRzBAhU50m8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-k5VVwzhiNMSyaOI4b-aQaw-1; Fri, 03 Apr 2026 08:56:37 -0400
X-MC-Unique: k5VVwzhiNMSyaOI4b-aQaw-1
X-Mimecast-MFC-AGG-ID: k5VVwzhiNMSyaOI4b-aQaw_1775220997
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so43853231cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2026 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775220997; x=1775825797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkDbnzgFZyJLtns9wQGwwzMnLezdLmwC4PncLpVj4QA=;
        b=XuhV1B6GHCx4vbMjEL6GMAueR8dlanmExuzo6L7GYHishB8pSG9SrJOqi8EYMRpa/y
         +7ioUTldG4HUjNwYYxk76n/HKyRtMUsZ8Xt8uivM0SVOPoQG0fvfrRfqeY5qjB51qtgC
         VMTvZQs2GKYJMDJEMnhJEZcSp9DHiH+/X+OVoZCTlVBwrQ+Q3AX/+eBf+AYiurYOTZWC
         4QlSXginjDnGeJoo8UHxXu7rqMpNQya9sNOZ/ofi2LGm4jzFspxwWHM4w+bw6ctqs1I+
         CAx5HCOhZSMkXEOtpho2vqd1ELwCUnUrnbm9z4XvEJ5/0Cdy71bpzPkH6ctFrxHQBMud
         BoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775220997; x=1775825797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkDbnzgFZyJLtns9wQGwwzMnLezdLmwC4PncLpVj4QA=;
        b=O9WQwPjBw52ePitAYPQidNzNUD0HSJ6FcTjMrxLIRX6v52F88MIvyVoyfpq52yr50n
         VaisZDYQBMnLxOzu/N5kpu4q0TLSefVqnrd7kMXstY0/ngVtxXncR10IkZZ14oIpFzLS
         fl3Sh26Xk16C1ya7hbKs2HV8AaCc8bNPX/WE1IhtGlMGptjPh7DrMm+BUBges0URTBMk
         XSboMXAHxmacv605vDoqZSET8819I5BjuXpgDz1Idw4CUDamHRmXY5gNKDuFT2o7XkYK
         EU2tnrtE9p9zmUJJjkIcd/3ZNZgBeZBu469dEI19sIZwrHak5AHoplIkH1twEaW2Q7bi
         D/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrYmqKGu4R8z6Pa8UsrCRRKhQGcPiSrrbzxn57fx7QHFecibxVL+9Vpi9dv6e1OXqXadDROUGHSug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CVk7u12ZEwXcYqVvjyKRIV//MaxTuIAxARp5kQ+rkn/piyMJ
	B7w48vU+8MEH5RxcERujCa0m7vwxWWq5CVGEJt7GHLUZzjJoVs8XhuI3WCCTj5vmXm1epLRPxMp
	3EpNqHnltvWD0IaIYOm430JqRYPuV0/zpbfAF03YDNd2hgslapTOF4B1DlRJlsw==
X-Gm-Gg: ATEYQzzQHc25aNl5GcHxXFDPgYUxxKnrZnRRWEn+almOGdCH/eaR180XV4wFvgCruwq
	FcyBcabJCoMxCN3Ks6EJCpiM0C4iRNVKQJRE9gQsGzRO/VylycxsCBe7TKWVrjbc6nV/a44bDeE
	cqKLD4jc8L81wpFuZujvdGiN/voSjT9u8/apk7XocZVjZbvCVLXDSDJ07GIKANr2lIuRs7sNSm8
	BBE44ta2MqjGYI94OKBcpzkmNZGNu8Hjmr+nS1ZXWDjnt8+d/l5p6tf574g4Ye959UvokfA3ikQ
	q/FLaxXybM5NpMAzVwryWsVREqChR8sePLZsuxF0+pYh36n81gdwo2DD6+4avev30i8yNIh3BZV
	qYv6vTBRE4617KnfZ1cwG
X-Received: by 2002:a05:622a:5e10:b0:509:764:2f02 with SMTP id d75a77b69052e-50d62c6cb13mr44558681cf.45.1775220996761;
        Fri, 03 Apr 2026 05:56:36 -0700 (PDT)
X-Received: by 2002:a05:622a:5e10:b0:509:764:2f02 with SMTP id d75a77b69052e-50d62c6cb13mr44558271cf.45.1775220996269;
        Fri, 03 Apr 2026 05:56:36 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.240.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333d0sm54220396d6.1.2026.04.03.05.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 05:56:34 -0700 (PDT)
Message-ID: <5ba84228-2033-42f8-b1ba-dfc01eea28ad@redhat.com>
Date: Fri, 3 Apr 2026 08:55:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 00/16] exportfs/exportd/mountd: allow them to
 use netlink for up/downcalls
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20623-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: 1ACAE394480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/30/26 9:38 AM, Jeff Layton wrote:
> Minor revision to rebase onto recent upstream changes. Original cover
> letter follows:
> 
> This adds support for the new netlink-based upcalls and downcalls in
> mountd, exportd and exportfs. With this, mountd is no longer reliant on
> /proc for sunrpc cache upcalls.
> 
> There are also a few bugfixes and cleanups for existing code and
> documentation too.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed... (tag: nfs-utils-2.9.1-rc3)

steved.
> ---
> Changes in v2:
> - Consolidate UAPI header updates into one patch
> - Rebase onto nfs-utils-2-9-1-rc2
> - Link to v1: https://lore.kernel.org/r/20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org
> 
> ---
> Jeff Layton (16):
>        nfsdctl: move *_netlink.h to support/include/
>        support/export: remove unnecessary static variables in nfsd_fh expkey lookup
>        exportfs: remove obsolete legacy mode documentation from manpage
>        support/include: update netlink headers for all cache upcalls
>        build: add libnl3 and netlink header support for exportd and mountd
>        xlog: claim D_FAC3 as D_NETLINK
>        exportd/mountd: add netlink support for svc_export cache
>        exportd/mountd: add netlink support for the nfsd.fh cache
>        exportd/mountd: add netlink support for the auth.unix.ip cache
>        exportd/mountd: add netlink support for the auth.unix.gid cache
>        mountd/exportd: only use /proc interfaces if netlink setup fails
>        support/export: check for pending requests after opening netlink sockets
>        exportd/mountd: use cache type from notifications to target scanning
>        exportfs: add netlink support for cache flush with /proc fallback
>        exportfs: use netlink to probe kernel support, skip export_test
>        mountd/exportd/exportfs: add --no-netlink option to disable netlink
> 
>   configure.ac                                       |   33 +-
>   support/export/Makefile.am                         |    5 +-
>   support/export/cache.c                             | 1892 +++++++++++++++++---
>   support/export/cache_flush.c                       |  166 ++
>   support/include/Makefile.am                        |    7 +-
>   {utils/nfsdctl => support/include}/lockd_netlink.h |    0
>   support/include/nfsd_netlink.h                     |  240 +++
>   support/include/sunrpc_netlink.h                   |   84 +
>   support/include/xlog.h                             |    2 +-
>   support/nfs/cacheio.c                              |   49 +-
>   utils/exportd/Makefile.am                          |    2 +-
>   utils/exportd/exportd.c                            |   10 +-
>   utils/exportd/exportd.man                          |   12 +-
>   utils/exportfs/Makefile.am                         |    6 +-
>   utils/exportfs/exportfs.c                          |   55 +-
>   utils/exportfs/exportfs.man                        |   79 +-
>   utils/mountd/Makefile.am                           |    2 +-
>   utils/mountd/mountd.c                              |    9 +-
>   utils/mountd/mountd.man                            |    9 +
>   utils/nfsdctl/nfsd_netlink.h                       |   99 -
>   20 files changed, 2350 insertions(+), 411 deletions(-)
> ---
> base-commit: a06a3251c2eb1316f781149f8b7f9acd9d41e7fc
> change-id: 20260316-exportd-netlink-a53bf66ae034
> 
> Best regards,


