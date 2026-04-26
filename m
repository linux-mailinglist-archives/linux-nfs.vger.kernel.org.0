Return-Path: <linux-nfs+bounces-21113-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zzzRF2+n7mm4wQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21113-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 02:01:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E66A846B981
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 02:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC7873001D6A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 00:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D5DDA9;
	Mon, 27 Apr 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjbZtCb8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CE5695
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248106; cv=none; b=BVhrNlAHLbsJU88tAWdGBYioY4ugGmhVRDhrVPhQ4V+Cnh5YXZNn7MTglWoe1WQbAbMnBUxVBFEpNdr+xvxb2z8/pE04UbVlYT9XJp4qSpLYlU4Zx4VxBjx/m4b3Tt5YqLt/3gSH5DMpwt0cSP/3toqs6LxcumkMVpgSxy0ao08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248106; c=relaxed/simple;
	bh=m+OcXCtyDOvxnxJBKahNiKM8NtlieJ6bMOjObt0m7n8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=B+kdj/54Uv5SobcW3cL2PtKgYA4udBthyi7e7qpR1MkcD0+QaTOIXGgmE8QF2qm7mF6Bstn7GgtLwekQ6XzhVg6YblCYwCPIVBheffuNrZPh9/Psj/lLD7wnBNxB9igfUXO+6QvFjw0HQBXQSN/og2Z8vDSduP5QQVdaXu/h/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjbZtCb8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76d797b180so6502595a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 26 Apr 2026 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248105; x=1777852905; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m+OcXCtyDOvxnxJBKahNiKM8NtlieJ6bMOjObt0m7n8=;
        b=WjbZtCb8F2KkTx258M02IMTdboaHnREo5WqpcnNtVrHN6cVu6Ll5hDmprGY4IKyM4M
         rs6hywfA56DJRK+hzIjcnzg34Br2GThGQpgb4lb8ykVrenT7TsnPz5ThBSKTvgRCz4yr
         WSt7QYVCVvsDnqfILnv+YKRfzSJ8MmLQvZqsKWLhJBbWwMaVLcTv73VsvWu+WpvtvrX9
         CHQyZ72LHQTYDdxkejEKqov6FCDzEDsu8a+/+i8HE6eqaeI4Eh+tZHdLM1GZC7WlcwK0
         flMS5Sr+eYtdZRmqnde/9XSNG5eOQ3ZBxl5sfR1MNKjaWgKj29F/JXC0VHVdc1IUtyRK
         Qo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248105; x=1777852905;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+OcXCtyDOvxnxJBKahNiKM8NtlieJ6bMOjObt0m7n8=;
        b=WyvNDJXSYv4vr72x/7oYREEwBbOqft784s2OEDPc/cHy6R8IAaQaVA69XgJBjNve2b
         4JrMBSi++Mmrz8e9X/KZLIlpeUyPr3/24wJL1AEUOmyZqJ1E8eGWl+KbY1c83Xn4hvx6
         28DMgernMrRkZuKAfMubez98xBaNwOVWWQB7pdy+azwR65sVJWgDHgr3kxlopwEuX0xR
         zlGbj+SBDF7mmLdMWJplq/a/IljDwtmn0Cntl22clsrFAPbwVoER4B1ctFHouJlz47G3
         +JJmztA/lImDk8AiO2DCeTHawtKIPpzyV6c16nyfNHn8tGAMHzGDFC1DxH/Y8CDszFRS
         HZpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iEHa9bX73VgBXdmiPFBWeKqORn2H8wFyoF8cOuhBy4u5+HZDr1WWs5E8cLFB8JfERxipaHEGV/XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudcHMW3Tl14QIBLKPRQ7RxzLVVgBjTkMgujXldAfrwzk2oP+J
	CnDAcxZ2VOgaqA00/OXAW2dKbTTCh7+Wir9CM2w6MRSQnP+hZIHg+EC6Hwky1Q==
X-Gm-Gg: AeBDievUuT/YiBhTj4RlmekTQUUyw2FcrBFmP8EERfV2DjBJllrfbOygZ76qV53AXNW
	ME9Xb3xEnGUTX0CKwHVh+gwGzHlzYtY2LFvGDfeTAsGj/hMwlxouCgienzqq5G28m2VunJCEauH
	sdQXiTH3lNGrEPGFZFWii6+zz5nSZwnuTfFEZhfLlHNwUqiZNwh8XlcZx7FP4dv+XV4jNN78flb
	yie9X+TRqj0Qt9DsPphuacinX4TBkHh4zBVqb/o6E2KCrXDr/6feMg5Oef3QsjNGsCbv73PbUFa
	HuMd5gjnkkiFacotfz82jfddEcLJYG0xlGLYx8zhiPcqkiRFaIgONvv2sOrfif7znGnPvVbSpPH
	xMLf/8+NNATyXtqgZ1hVurWiGOmJ6DRwIcjnPQNVVQhS91Zda3XLyUDYjBzz77p/RPZsTqT7gHU
	IrhHr5vlfeZUTLX9wL2YcEwy8bLgRXuizPRGipAix6rKg=
X-Received: by 2002:a05:6a20:1588:b0:3a2:d629:16b3 with SMTP id adf61e73a8af0-3a2d6291cbemr35605566637.34.1777248104974;
        Sun, 26 Apr 2026 17:01:44 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm37959290b3a.10.2026.04.26.17.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:01:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH v3 3/4] testing: add nfsd-io-bench NFS server benchmark suite
In-Reply-To: <a1e784d7006fe5d4331d41a0638be117ac67fb21.camel@kernel.org>
Date: Mon, 27 Apr 2026 05:24:15 +0530
Message-ID: <mryps2fs.ritesh.list@gmail.com>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org> <20260426-dontcache-v3-3-79eb37da9547@kernel.org> <20260426053455.4c06140446976964e6fbb8ab@linux-foundation.org> <a1e784d7006fe5d4331d41a0638be117ac67fb21.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E66A846B981
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21113-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

Jeff Layton <jlayton@kernel.org> writes:

> On Sun, 2026-04-26 at 05:34 -0700, Andrew Morton wrote:
>> So how are we to maintain this?

Maybe in xfstests? It has tests/perf/, but that just have 1 test.
Maybe others can tell whether it make sense to maintain such fio based
performance benchmarking scripts in there.

-ritesh

