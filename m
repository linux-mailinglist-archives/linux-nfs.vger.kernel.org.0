Return-Path: <linux-nfs+bounces-21586-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPnpNObrA2ruAgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21586-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 05:11:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6C52CA9C
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 05:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39379306F477
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D760391E7C;
	Wed, 13 May 2026 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD1MlNX4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F2391E49
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641630; cv=none; b=JAEGgiGBEIu8vAGTZSfed61ubV1ZHlfKfaMbXB9IBooSCmwxmbK0riWJ6HUEMvJo8aXBP5Cib0gZtfrwJmZpHB6XEL2Gh/kfOWmQmvS6qTXnpwlXJBGgXWGPz/9y1QkCAm25JZwbF2qado5Rt96AA3SVeQy+P/MjjRJugAq+GLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641630; c=relaxed/simple;
	bh=lFHjfb/iiiQv7LiZLlzYMEvqX40z619Do1ZMUYCjtwQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Epr77wXubSjSBBbPEn7mdNi7fDnhQC0iBPNTsEtdh56w77wb5tdGRRauJczR9uNUpKvtpuIaKB+5p4g9ZYWg1EX/YSs7FBKvSHRbv1Cpb8ftUk0yTh3kHxALuWpx+pN8GaclsnUkG/WHGETSiKqo3MweOtdmgdpYBtiX7Z/+b5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD1MlNX4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8367df48711so2910507b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 20:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778641628; x=1779246428; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mr8B54nCUqKe73fttlmYFbpBv8yytDHMFbs5Gt5TGns=;
        b=gD1MlNX4OzLVqGRpDnYDW+bLaSTHiFyAJNdS/zfI/S1rU67Yfmoa318gequ5lMwkrR
         ZYajs/Bt9Xh/Cu8QlWCM75ynkmM+mw+hF362ePV1z757CIw9y9hGzlDBrwQI2Zl/YA4z
         tzd2EzVlrbF6BTkyG2qOCiSRsHV6TOgIKLiM83MOgueqQJ1KaJ8odidvLptqOWXByTBP
         XYFN8lTCUWwYupDKvvQQH6/tBL+4DXZrhGeVWnuvtsup47HM+nvl1Qvu4OxgvKv7boY3
         xaGUYeOD90u4IRK674tXS123h7t/dqwbwx1rEqNeS6C3nOHykBqeQ6omWWmK7WIrbckV
         lxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778641628; x=1779246428;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr8B54nCUqKe73fttlmYFbpBv8yytDHMFbs5Gt5TGns=;
        b=VffYi7855ISVdvoRt5GBwepoHLoqJmi3mMxNcFDN7EM41A9H7aLey9XYVkYgbv03Ha
         +OGcrrywuF6mdGNzz8cBrz9bv5mwsQH1MY0A8zezPya+8ufmMLcbp73VIW15rGQUTEsq
         TZCTu9Fiea5CTuC7YFgTa5jOCJz0Cx02AE8kabCF86HkkFufHKS7LtrRfPNM1rHJqDjP
         818oKqVs9caC05DkLTBpJlyNKenOV8zhdvrejeBSVY62hI/TwbC2CarSsLj2dm+WxwO1
         4PO2kCHJ5n474RlUOQKHP//WsTJgqzVGLDlh4vwsRxgGKI9AVeMvcbscFv60UVFqDI5H
         5fEg==
X-Forwarded-Encrypted: i=1; AFNElJ+lYW07mVrL83yArQ27uVjc6QdYlb2Vs6Bq/s3pi8MZcDiQIDIjPtxltd75prELJxB90AAnHHmelFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe0YaPs+0gc4UoiCBLdfsOAbReIwrXbxFFFDmIxB4TlxGf+N8
	xjlUOlzmPferUwdFZaTQHVilOv1GvEWsq7RVBzQ2rTHkZrfjLKfX6HDo
X-Gm-Gg: Acq92OGbz018WTMNupJk+CTBF/WBEZESvn5jdRJauUkCp/zHo3XEDj2hPuMAuKNbsQF
	Z2VPGhJQRzKAS4RFuYc/G1HkgvZxXvuo9ms7bduTtHq78u2f+rzfhhWlbHv/0kf6ECqq/r1iSMK
	nP4Zbm1IV9xLD02xLXyynKy79nXRvqFDb495kwXqJP3sEklpxJojpVs/8PPkgiUioQaxiI8J0MK
	V0qh7gP6MRCDNPFhFJLagZSWF3GmQ1saBkb0IZMWTCxmnyCSnQOrKmfKEd7Iu4wApErJJPrZo7z
	Ye7guRpUaTKVCbyUggxsLjh7yxORacd1krksQazx8x7GH4Y94684WQpvJhlrC/QyA6SBWtAKuTz
	+pfAMpw0jqfkBaLs7aA9OSqPPF1jg75Wc/V2SQf3sSyr1tmmeu6/4N7lvkPDIvfZiPX2gd8Nqhl
	z/YmNRPC6QyQGqLXkECXCZ4jP3hKUvblhn
X-Received: by 2002:a05:6a00:4146:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-83f03e92ea5mr1356854b3a.1.1778641627973;
        Tue, 12 May 2026 20:07:07 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839685a3187sm25369465b3a.60.2026.05.12.20.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:07:07 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 3/3] mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
In-Reply-To: <20260511-dontcache-v7-3-2848ddce8090@kernel.org>
Date: Wed, 13 May 2026 08:31:23 +0530
Message-ID: <y0hoqags.ritesh.list@gmail.com>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org> <20260511-dontcache-v7-3-2848ddce8090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 45D6C52CA9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21586-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Jeff Layton <jlayton@kernel.org> writes:

> dontcache-bench results (same host, T6F_SKL_1920GBF, 251 GiB RAM,
> xfs on NVMe, fio io_uring):
>
> Buffered and direct I/O paths are unaffected by this patchset. All
> improvements are confined to the dontcache path:
>
> Single-stream throughput (MB/s):
>                         Before    After    Change
>   seq-write/dontcache      298      897    +201%
>   rand-write/dontcache     131      236     +80%
>
> Tail latency improvements (seq-write/dontcache):
>   p99:    135,266 us  ->  23,986 us   (-82%)
>   p99.9: 8,925,479 us ->  28,443 us   (-99.7%)
>
> Multi-writer (4 jobs, sequential write):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     2,529    4,532     +79%
>   dontcache p99 (us)             8,553    1,002     -88%
>   dontcache p99.9 (us)         109,314    1,057     -99%
>
>   Dontcache multi-writer throughput now matches buffered (4,532 vs
>   4,616 MB/s).
>
> 32-file write (Axboe test):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     1,548    3,499    +126%
>   dontcache p99 (us)            10,170      602     -94%
>   Peak dirty pages (MB)          1,837      213     -88%
>
>   Dontcache now reaches 81% of buffered throughput (was 35%).
>
> Competing writers (dontcache vs buffered, separate files):
>                                 Before    After
>   buffered writer                  868      433 MB/s
>   dontcache writer                 415      433 MB/s
>   Aggregate                      1,284      866 MB/s
>
>   Previously the buffered writer starved the dontcache writer 2:1.
>   With per-bdi_writeback tracking, both writers now receive equal
>   bandwidth. The aggregate matches the buffered-vs-buffered baseline
>   (863 MB/s), indicating fair sharing regardless of I/O mode.
>
>   The dontcache writer's p99.9 latency collapsed from 119 ms to
>   33 ms (-73%), eliminating the severe periodic stalls seen in the
>   baseline. Both writers now share identical latency profiles,
>   matching the buffered-vs-buffered pattern.
>
> The per-bdi_writeback dirty tracking dramatically reduces peak dirty
> pages in dontcache workloads, with the 32-file test dropping from
> 1.8 GB to 213 MB. Dontcache sequential write throughput triples and
> multi-writer throughput reaches parity with buffered I/O, with tail
> latencies collapsing by 1-2 orders of magnitude.
>
Thanks for also considering multiple request for performance numbers
into account, this indeed is a nice improvement overall to
RWF_DONTCACHE.

With Christian simplification - the patch looks good to me.
So, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


