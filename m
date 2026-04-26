Return-Path: <linux-nfs+bounces-21109-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tg4VAqtY7mn7sQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21109-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 20:25:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E646AC10
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80A993001D70
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B129D26C;
	Sun, 26 Apr 2026 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlybZ2Iu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AB282F32;
	Sun, 26 Apr 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777227942; cv=none; b=EH44fiVRqtAa0MPvROrOnJQ79lrN3mbNFmJBoV/uSwj80gqXxqD6Q5kPI5+sKzARtnSLNHgEJNLrkLF1BhqZbyRW7i30jBoqkEF4x5QXPq6GLiUIFjRaEiMcBJsSOFfl+wzrswXAxqY7LQ8RqMqwf6xhh7lEqTp25C8NFRE72yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777227942; c=relaxed/simple;
	bh=xAvxxc+GJErYibe3Dff2VWhiLf5NPpiX6PZCm4fg5XE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDTZdgBuNlfN10y9Ks3Fx4j+/8btDHZEiaE7QPaGZeJED88QL5W/z07V+sAWrvmAJwLgcamzsliNNZ0akdBwtPXDWc/pKlCqqQBldZJBRE0J+JbcD93Uf/aCzeOaCIGlfuDvRWon1Kzanc2O6WUfWYJm+oN8VPufQCHxjcl8v5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlybZ2Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71ADC2BCAF;
	Sun, 26 Apr 2026 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777227941;
	bh=xAvxxc+GJErYibe3Dff2VWhiLf5NPpiX6PZCm4fg5XE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OlybZ2IujoiP0PzXbBns5uTh4PTxWaHeIyjJv3sUFL0Gs2b1QykWluRggP1n8afkT
	 Tq64WvAky+PcSkCdPLQoi1XQKpzWaIE5S9Hq0bAgaNwjG/YAML+vcXZvB41M3Y+0MW
	 03N6Bxtmc7AttYs0TnoQMfCZVteNmubunXMc5EoEyLXxp/avrcMGqHQ7y2hgGVCEAm
	 65kY8DfTP/9i5W2XpsDILrABn5LvN6fDJFYgxnC+0gUS5d5t+wv8Ze9gSzyJfDgISS
	 +HXIGCbeOz2z90jMgod1z2BzA7Gf4pyF9XvSEf92vW6XoiK1XI4yum3wwl6sFBzfxs
	 AJsNfRtkS2ZZg==
Message-ID: <c40b691f76e6d397b889b4ee27e43490320660f1.camel@kernel.org>
Subject: Re: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
From: Jeff Layton <jlayton@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)"	
 <willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes	 <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka	 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan	 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Mike Snitzer	 <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ritesh
 Harjani	 <ritesh.list@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Kairui Song	 <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt	 <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel
 Rasmussen	 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu	 <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Date: Sun, 26 Apr 2026 14:25:36 -0400
In-Reply-To: <20260426052854.8372fb9d4c616f16a8aa0a0f@linux-foundation.org>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
		<20260426-dontcache-v3-2-79eb37da9547@kernel.org>
	 <20260426052854.8372fb9d4c616f16a8aa0a0f@linux-foundation.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 944E646AC10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21109-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,tencent.com,linux.dev,goodmis.org,efficios.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Sun, 2026-04-26 at 05:28 -0700, Andrew Morton wrote:
> Naive questions...
>=20
> On Sun, 26 Apr 2026 07:56:08 -0400 Jeff Layton <jlayton@kernel.org> wrote=
:
>=20
> > The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> > filemap_flush_range() on every write, submitting writeback inline in
> > the writer's context.  Perf lock contention profiling shows the
> > performance problem is not lock contention but the writeback submission
> > work itself =E2=80=94 walking the page tree and submitting I/O blocks t=
he writer
> > for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
> > (dontcache).
>=20
> So in the current case, when generic_write_sync() returns, all that
> memory is written back and clean&reclaimable (or freed?), yes?
>=20
> > Replace the inline filemap_flush_range() call with a flusher kick that
> > drains dirty pages in the background.  This moves writeback submission
> > completely off the writer's hot path.
>=20
> Whereas after this change, that pagecache is probably still dirty,
> unreclaimable, waiting for the flusher to do its thing?
>=20
> So is there potential that the system will get all gummed up with
> dirty, to-be-written-soon pagecache?  Is there something which limits
> this buildup?
>=20
> > ...
> >=20
> > dontcache-bench results on dual-socket Xeon Gold 6138 (80 CPUs, 256 GB
> > RAM, Samsung MZ1LB1T9HALS 1.7 TB NVMe, local XFS, io_uring, file size
> > ~503 GB, compared to a v6.19-ish baseline):
> >=20
> >   Single-client sequential write (MB/s):
> >                        baseline    patched     change
> >   buffered              1449.8     1440.1      -0.7%
> >   dontcache             1347.9     1461.5      +8.4%
> >   direct                1450.0     1440.1      -0.7%
> >=20
> >   Single-client sequential write latency (us):
> >                        baseline    patched     change
> >   dontcache p50         3031.0    10551.3    +248.1%
> >   dontcache p99        74973.2    21626.9     -71.2%
> >   dontcache p99.9      85459.0    23199.7     -72.9%
> >=20
> >   Single-client random write (MB/s):
> >                        baseline    patched     change
> >   dontcache              284.2      295.4      +3.9%
> >=20
> >   Single-client random write p99.9 latency (us):
> >                        baseline    patched     change
> >   dontcache             2277.4      872.4     -61.7%
> >=20
> >   Multi-writer aggregate throughput (MB/s):
> >                        baseline    patched     change
> >   buffered              1619.5     1611.2      -0.5%
> >   dontcache             1281.1     1629.4     +27.2%
> >   direct                1545.4     1609.4      +4.1%
> >=20
> >   Mixed-mode noisy neighbor (dontcache writer + buffered readers):
> >                        baseline    patched     change
> >   writer (MB/s)         1297.6     1471.1     +13.4%
> >   readers avg (MB/s)     855.0      462.4     -45.9%
>=20
> These results look ambiguous.  Sometimes better, sometimes worse?
>=20

Forgot to comment on this part earlier...

This is the "mixed-mode" (dontcache writes + buffered reads). I played
with a bunch of different settings under nfsd, and those settings
turned out to perform the best with this benchmark.

I suspect what's happening is that the increase in write throughput
from writing via the flusher thread is crowding out reads. So, read
throughput suffers in this test from that. There are a number of ways
we could probably make that more fair.

> > nfsd-io-bench results on same hardware (XFS on NVMe, NFSv3 via fio
> > NFS engine with libnfs, 1024 NFSD threads, pool_mode=3Dpernode,
> > file size ~502 GB, compared to v6.19-ish baseline):
> >=20
> >   Single-client sequential write (MB/s):
> >                        baseline    patched     change
> >   buffered              4844.2     4653.4      -3.9%
> >   dontcache             3028.3     3723.1     +22.9%
> >   direct                 957.6      987.8      +3.2%
> >=20
> >   Single-client sequential write p99.9 latency (us):
> >                        baseline    patched     change
> >   dontcache            759169.0   175112.2     -76.9%
> >=20
> >   Single-client random write (MB/s):
> >                        baseline    patched     change
> >   dontcache              590.0     1561.0    +164.6%
> >=20
> >   Multi-writer aggregate throughput (MB/s):
> >                        baseline    patched     change
> >   buffered              9636.3     9422.9      -2.2%
> >   dontcache             1894.9     9442.6    +398.3%
> >   direct                 809.6      975.1     +20.4%
> >=20
> >   Noisy neighbor (dontcache writer + random readers):
> >                        baseline    patched     change
> >   writer (MB/s)         1854.5     4063.6    +119.1%
> >   readers avg (MB/s)     131.2      101.6     -22.5%
>=20
> Ditto but less so.
>=20

Same reason for the drop, I think.

> > The NFS results show even larger improvements than the local benchmarks=
.
> > Multi-writer dontcache throughput improves nearly 5x, matching buffered
> > I/O. Dirty page footprint drops 85-95% in sequential workloads vs.
> > buffered.
>=20
> It sounds that you like the results, so OK ;)

I think it's a win overall. As with anything writeback-related, it's a
game of tradeoffs. The good news is that DONTCACHE is still fairly new
and not many applications are using it yet, so the blast radius from
any change here should be rather small.

As a side note: I've long thought that we in general wait too long to
kick off writeback with normal buffered I/O, particularly with modern
memory sizes. DONTCACHE gives us a place to experiment with this
scheme, but we may want to think about kicking off writeback earlier in
the normal buffered case too.
--=20
Jeff Layton <jlayton@kernel.org>

