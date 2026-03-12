Return-Path: <linux-nfs+bounces-20078-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APfZEBY0s2mDTAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20078-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:45:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BFE27A2BE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 22:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC95B317EF63
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85633F1677;
	Thu, 12 Mar 2026 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HynKVXD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sD1IpxmF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB423F0768;
	Thu, 12 Mar 2026 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351870; cv=none; b=T8gi5K2EdvGVk41BvXFahFM2GeGswx0/QHlUSlz7hFlqmeDksAySsw8gaKHOPXSnN6Gzkyu85rZAL9NegwwXfG44EQ6VNYjQSV7L73LjuMfCVZ90Y/PVQ70mOQn/pIVbybI3E+AlnTwZXVcIN1h1O+VONBWk45Bw4aQ0wh5lvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351870; c=relaxed/simple;
	bh=Dfk/v8M2XGUkYMjdT8IWZm5Z9z/SvJrEfRIjyScAHm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXgEs+3emdQ4KvGP7H1b8+17qdstyp0+MLHZe+0utR3IbVnkFjUkotitD3iQDNyH8mzg19d7bBznEtQ8I6IjFCf7LjsA8L/5gQlRa89U5/ACzWL1JB5PjflR2rrxU3RH1Q3GFsEtNGrJtnQy+cc1HkRKgSo9l4Z8rmfdtG1p1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HynKVXD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sD1IpxmF; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 649AD1300FE6;
	Thu, 12 Mar 2026 17:44:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 17:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1773351865; x=1773359065; bh=FHJsH8Kre5
	d09x8tLYt2s8UM1ZjvIsbiC0DN+DyY4Wk=; b=HynKVXD7sGiagH9pyAhm4nEmbG
	vnoLEKsMRIiSoa4G7euyElVNaPJlW0anEmEFcWVt480xGfw7ZBeWqyJHh/ktIp9H
	PvZZACKxP9UOdtcmm83xJahGzP6ashogKl0QDSMPEPl70AAQ3icBB8PfEnzEFMRq
	sX3yWNvxvY/eWlaObNEhjpO2PDvl14q8XwgFR80C8mJOcy9vmuKQRaNg5N7I0NBu
	YzYQ2wP8zbtuE/A1y/UOTxlh7tZ0N66BfUwAQyR2N36DYGboFbAHY0UTwAvDGw1M
	d6RYVJexiZ6tvhPF9XL+NJ38N7femUBleqpharU4wR7cs3N8FjN0xclTa88Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773351865; x=1773359065; bh=FHJsH8Kre5d09x8tLYt2s8UM1Zjv
	IsbiC0DN+DyY4Wk=; b=sD1IpxmFFBbUWLaj2WkVbBMNwpLBYky36Wu3DMHfzT0X
	nYRW/ck1rxXdAMzJNXUejfFN/jOa+nMSve9JT7wFkvNE8kcvSIA6yoXL/zieN3xM
	iZ+dMzyq43JMAdlzXgdWh8E1/CDLAWkabqAdcZh+T2TEs39XC5Dyt8plLkNXPMtI
	Y+r2Dz3efkKqhCljIQwPhIv8XYGf4dd7RG0/DSMZfTI3O1ghah+7C1QcisTS9EWV
	p5Ay6DlW7fs9l7Lbcemw1oXfwXFw+gQWGOzjp8GKsZTmGNsABOtouzH+861W6TOI
	iR7R/iP6i1+Z6AxnjMg7KFFlVxvvm0hDCXBMXVB/MQ==
X-ME-Sender: <xms:tjOzaYKtAlzNy0f_EhbkSUlhoa8KZMOzdeNH9009TcjkYG6tbvC7Aw>
    <xme:tjOzab1mfdu_QmTDPbYrOK1x4qA-DPLvzT8zO8FZQfoiZZpM2Q7PewNcOWSFkbzBx
    CSJqJJgR4xO9u5VcliHKe4FVdaI6_GR5jWwjPvhZ8TLoSIpYA>
X-ME-Received: <xmr:tjOzaTyaQLH6LrWbZtAo1MENQavCeD4QUFklDYoSz_Wa54OtONiqLZpomwLKI-d-C--YgCofWm54r8ueiEOhXittozc2IECd2HHHlL6ixNjG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:tjOzaS1z3HXh4-ifJRBEJTkKAyUPCr8OJLgJiRXU1S3hJu4gX6A32Q>
    <xmx:tjOzaU6VCxafI3qHQH8oosSQuqDVIy-CStyT6UaG1DYXnTDBEu-EpA>
    <xmx:tjOzadctLaB3wfFUZXTX37T5TIQ88OOFc6eu00-UyziGYU-aaSZemw>
    <xmx:tjOzaQYHqOUYatlEsE5TwG61VUO_YB38t6wNqngJFK5w5KsHFjx8_w>
    <xmx:uTOzacGeKHU7F90aeYZNDwvYEnwYDWXkCfp88n2OwGQGooB6gIONyBVa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 17:44:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,	Carlos Maiolino <cem@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,	Tyler Hicks <code@tyhicks.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	coda@cs.cmu.edu,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-efi@vger.kernel.org
Subject: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
Date: Fri, 13 Mar 2026 08:11:47 +1100
Message-ID: <20260312214330.3885211-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20078-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,cs.cmu.edu,google.com,linux.alibaba.com,redhat.com,auristor.com,samba.org,samsung.com,sony.com,debian.org,mit.edu,dilger.ca,goodmis.org,dubeyko.com,tyhicks.com,nod.at,cambridgegreys.com,sipsolutions.net,ozlabs.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E0BFE27A2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set progresses my effort to improve concurrency of
directory operations and specifically to allow concurrent updates
in a given directory.

There are a bunch of VFS patches which introduce some new APIs and
improve existing ones.  Then a bunch of per-filesystem changes which
adjust to meet new needs, often using the new APIs, then a final bunch
of VFS patches which discard some APIs that are no longer wanted, and
one (the second last) which makes the big change.  Some of the fs
patches don't depend on any preceeding patch and if maintainers wanted
to take those early I certainly wouldn't object!  I've put a '*' next
to patches which I think can be taken at any time.

My longer term goal involves pushing the parent-directory locking down
into filesystems (which can then discard it if it isn't needed) and using
exclusive dentry locking in the VFS for all directory operations other
than readdir - which by its nature needs shared locking and will
continue to use the directory lock.

The VFS already has exclusive dentry locking for the limited case of
lookup.  Newly created dentries (when created by d_alloc_parallel()) are
exclusively locked using the DCACHE_PAR_LOOKUP bit.  They remain
exclusive locked until they are hashed as negative or positive dentries,
or they are discarded.

DCACHE_PAR_LOOKUP currently depends on a shared parent lock to exclude
directory modifying operations.  This patch set removes this dependency
so that d_alloc_parallel() can be called without locking and all
directory modifying operations receive either a hashed dentry or an
in-lookup dentry (they currently recieve either a hashed or unhashed,
or sometimes in-lookup (atomic_open only)).

The cases where a filesystem can receive an in-lookup dentry are:
 - lookup. Currently can receive in-lookup or unhashed.  After this patch set
    it always receives in-lookup
 - atomic_open.  Currently can receive in-lookup or hashed-negative.
    This doesn't change with this patchset.
 - rename. currently can receive hashed or unhashed.  After this patchset
    can also receive in-lookup where previously it would receive unhashed.
    This is only for the target of a rename over NFS.
 - link, mknod, mkdir, symlink.  currently received hashed-negative except for
    NFS which notices the implied exclusive create and skips the lookup so
    the filesystem can received unhashed-negative for the operation.

There are two particular needs to be addressed before we can use d_alloc_parallel()
outside of the directory lock.

1/ d_alloc_parallel() effects a blocking lock so lock ordering is important.
  If we are to take the directory lock *after* calling d_alloc_parallel() (and 
  still holding an in-lookup dentry, as happens at least when ->atomic_open
  is called) then we must never call d_alloc_parallel() while holding the
  directory lock, even a shared lock.
  This particularly affects readdir as several filesystems prime the dcache
  with readdir results and so use d_alloc_parallel() in the ->iterate_shared
  handler, which will now have deadlock potential.  To address this we
  introduce d_alloc_noblock() which fails rather than blocking.

  A few other cases of potential lock inversion exist.  These are
  addressed by dropping the directory lock when it is safe to do so
  before calling d_alloc_parallel().  This requires the addtion of
  LOOKUP_SHARED so that ->lookup knows how the parent is locked.  This
  is ugly but is gone by the end of the series. After the locking is
  rearranged in the second last patch, ->lookup is only ever called
  with a shared lock.


2/ As d_alloc_parallel() will be able to run without the directory lock,
  holding that lock exclusively is not enough to protect some dcache
  manipulations.  In particular, several filesystems d_drop() a dentry
  and (possibly) re-hash it.  This will no longer be safe as
  d_alloc_parallel() could run while the dentry was dropped, would find
  that name doesn't exist in the dcache, and would create a new dentry
  leading to two uncoordinated dentries with the same name.

  It will still be safe to d_drop() a dentry after the operation has
  completed, whether in success or failure.  But d_drop()ing before that
  is best avoided.  An early d_drop() that isn't followed by a rehash is
  not clearly problematic for a filesystem which still uses parent locking
  (as all do at present) but is good to discourage that pattern now.

  This is addressed, in part, by changing d_splice_alias() to be able to
  instantiate any negative dentry, whether hashed, unhashed, or
  in-lookup.  This removes the need for d_drop() in most cases.

New APIs added are:

 - d_alloc_noblock - see patch 05 for details
 - d_duplicate - patch 06

Removed APIs:

 - d_alloc
 - d_rehash
 - d_add
 - lookup_one
 - lookup_noperm

Changed APIs:

 - d_alloc_paralle - no longer requires a waitqueue_head_t
 - d_splice_alias - now works with in-lookup dentry
 - d_alloc_name - now works with ->d_hash

d_alloc_name() should be used with d_make_persistent().  These don't require
VFS locking as the filesystem doesn't permit create/remove via VFS calls,
and provides its own locking to avoid duplicate names.

d_splice_alias() should *always* be used:
  in ->lookup 
  in ->iterate_shared for cache priming.
  in ->atomic_open, possibly via a call to ->lookup
  in ->mkdir unless d_instantiate_new() can be used.
  in ->link ->symlink ->mknod if ->lookup skips LOOKUP_CREATE|LOOKUP_EXCL

Thanks for reading this far!  I've been testing NFS but haven't tried
anything else yet.  As well as the normal review of details I'd love to
know if I've missed any important conseqeunces of the locking change.
It is a big conceptual change and there could easily be surprising
implications.

Thanks,
NeilBrown


 [PATCH 01/53] VFS: fix various typos in documentation for
 [PATCH 02/53] VFS: enhance d_splice_alias() to handle in-lookup
 [PATCH 03/53] VFS: allow d_alloc_name() to be used with ->d_hash
 [PATCH 04/53] VFS: use global wait-queue table for d_alloc_parallel()
 [PATCH 05/53] VFS: introduce d_alloc_noblock()
 [PATCH 06/53] VFS: add d_duplicate()
 [PATCH 07/53] VFS: Add LOOKUP_SHARED flag.
 [PATCH 08/53] VFS/xfs: drop parent lock across d_alloc_parallel() in
*[PATCH 09/53] nfs: remove d_drop()/d_alloc_parallel() from
 [PATCH 10/53] nfs: use d_splice_alias() in nfs_link()
 [PATCH 11/53] nfs: don't d_drop() before d_splice_alias()
 [PATCH 12/53] nfs: don't d_drop() before d_splice_alias() in
 [PATCH 13/53] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
 [PATCH 14/53] nfs: use d_alloc_noblock() in silly-rename
 [PATCH 15/53] nfs: use d_duplicate()
*[PATCH 16/53] ovl: drop dir lock for lookups in impure readdir
*[PATCH 17/53] coda: don't d_drop() early.
 [PATCH 18/53] shmem: use d_duplicate()
*[PATCH 19/53] afs: use d_time instead of d_fsdata
*[PATCH 20/53] afs: don't unhash/rehash dentries during unlink/rename
 [PATCH 21/53] afs: use d_splice_alias() in afs_vnode_new_inode()
 [PATCH 22/53] afs: use d_alloc_nonblock in afs_sillyrename()
 [PATCH 23/53] afs: lookup_atsys to drop and reclaim lock.
 [PATCH 24/53] afs: use d_duplicate()
*[PATCH 25/53] smb/client: use d_time to store a timestamp in dentry,
*[PATCH 26/53] smb/client: don't unhashed and rehash to prevent new
*[PATCH 27/53] smb/client: use d_splice_alias() in atomic_open
 [PATCH 28/53] smb/client: Use d_alloc_noblock() in
*[PATCH 29/53] exfat: simplify exfat_lookup()
*[PATCH 30/53] configfs: remove d_add() calls before
 [PATCH 31/53] configfs: stop using d_add().
*[PATCH 32/53] ext4: move dcache modifying code out of __ext4_link()
*[PATCH 33/53] ext4: use on-stack dentries in
 [PATCH 34/53] tracefs: stop using d_add().
 [PATCH 35/53] cephfs: stop using d_add().
*[PATCH 36/53] cephfs: remove d_alloc from CEPH_MDS_OP_LOOKUPNAME
 [PATCH 37/53] cephfs: Use d_alloc_noblock() in
 [PATCH 38/53] cephfs: Don't d_drop() before d_splice_alias()
 [PATCH 39/53] ecryptfs: stop using d_add().
 [PATCH 40/53] gfs2: stop using d_add().
 [PATCH 41/53] libfs: stop using d_add().
 [PATCH 42/53] fuse: don't d_drop() before d_splice_alias()
 [PATCH 43/53] fuse: Use d_alloc_noblock() in fuse_direntplus_link()
 [PATCH 44/53] hostfs: don't d_drop() before d_splice_alias() in
 [PATCH 45/53] efivarfs: use d_alloc_name()
 [PATCH 46/53] Remove references to d_add() in documentation and
 [PATCH 47/53] VFS: make d_alloc() local to VFS.
 [PATCH 48/53] VFS: remove d_add()
 [PATCH 49/53] VFS: remove d_rehash()
 [PATCH 50/53] VFS: remove lookup_one() and lookup_noperm()
 [PATCH 51/53] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
 [PATCH 52/53] VFS: lift d_alloc_parallel above inode_lock
 [PATCH 53/53] VFS: remove LOOKUP_SHARED

