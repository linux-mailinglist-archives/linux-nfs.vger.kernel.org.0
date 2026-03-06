Return-Path: <linux-nfs+bounces-19834-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB2tG1voqml1YAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19834-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 15:44:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1466222F92
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1C6A303A85A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029D34F48B;
	Fri,  6 Mar 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JA3XqE5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2B32FA32;
	Fri,  6 Mar 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808266; cv=none; b=kdF/ChNNRFn8O0b/rOOJnas/MUELS9Rfy/fOIEDEVO/2fFgjaSXp0WszVnn3PxQBC6OtjpWymyiiwA2Hm6jzG8DeKzBdBKzc7ku2BzBqqqeNqHYVSwxDvwARnQGtNpNHDE9GI1pb7zxf6bR0Z9PCv9VYx1n55iSQTbjA1LVnrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808266; c=relaxed/simple;
	bh=+VBbq9UzaWur6twhDuNiRG4r0DAb13yn7dE5RDQcjgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYTrOwdV7VSYvJsoeh6xYqGHr42ezuSJKPA7gLjheHnshAwz5RVQHfdpjRD+zz/BOlkfyRhD6wq0wFxD7Uvq42c+YRctgA4CpxVEFN0azhQSw0XYjX86Zknl/cw1qM7MgptgggPza9YyQ0YrTfSBl63EcS1DvSUPqV3G4uEJmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JA3XqE5u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VWTkm0Py2p+wz88VT9Hqx7K/ZonBVtOJH06852VoXOU=; b=JA3XqE5uFcQXjgS48gQNz00qJQ
	V6NvzQnPz0dLEfUkFr6v91VHgvqcg5qfgsoKf6PeQilDqsM74PycLCxKcCQqxgy7Jba0gDmqJ9JW/
	NgK8svWPdbhmbTxM1IGW96Fl6Q5kgptn4+UTY5wCSPDZtAQEujRXAMGdueLxAtYhb1ljA0njMsjNb
	+9MUzvq9pmf+eFyCsW2Q9xkXMkRXFPboxXXeoTwz2NEq0K/V4NCFal4zl9+n+sFeGpUOYFRuPx9yg
	lzWCi/8DbTfProMdivYKbTEcubS3vegmE9ppiQTpM1Fh1ummPCx2i3rzFS4cqVDuqtbOaCMDkvaqB
	hoof68/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyWPd-00000003xun-3YXy;
	Fri, 06 Mar 2026 14:44:21 +0000
Date: Fri, 6 Mar 2026 06:44:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-nfs@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kthread: remove kthread_exit()
Message-ID: <aaroReSCj1qXUeQb@infradead.org>
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
 <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: C1466222F92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19834-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,suse.com,google.com,atomlin.com,oracle.com,brown.name,redhat.com,talpey.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,arm.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

More a comment on the previous patch, but I think exporting do_exit
which can work on any task is a really bad idea.  I'd much rather re-add
a kthread_exit wrapper that checks PF_KTHREAD first and only export
that, which would obsolete this patch.


