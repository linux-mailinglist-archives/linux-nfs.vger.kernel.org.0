Return-Path: <linux-nfs+bounces-20596-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN3WFWpuzWnvdQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20596-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:13:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C819937FB3C
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5E0430305F2
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EBD37DEB2;
	Wed,  1 Apr 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsFz6DVr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D931E822;
	Wed,  1 Apr 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070680; cv=none; b=e16rmGk+Y125mGkCH4y/imOLRr26IFfhS033pgeDENvhOFbac/Nh6BmmZtTjyt5+Y7Is8FAMqejCmOqnq1GG3AjVdHowngLqwe7qPvagJtM2RAC32YQi62P6Gy/2YjsV5xSLa2EYOslVhiJBz7M8qBiGvyuwMzMkrb9aKuJWKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070680; c=relaxed/simple;
	bh=bOe16hkUqbqlZCJU8w30Z5j55Ar6Gej61o9MPI+OrvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9n1W6UaxK3SJARl+oXyCpyXnCI3LhDP71hmcJbZyJPkaIil1l9Xhrm9leEhVrSh3iiNVe38Oe10xbQoTifO06OmhrDapLpGrP8rUazPYXFpwf8vfwOqLgiLuxg7PkQkpVy1iVYuJYSzejwYU83EqzIj21+K6WAZGw4WhNpNd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsFz6DVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ED2C2BCB2;
	Wed,  1 Apr 2026 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775070680;
	bh=bOe16hkUqbqlZCJU8w30Z5j55Ar6Gej61o9MPI+OrvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MsFz6DVr/Ad+viBQxt7EKPRr3hWIB+yuzGZEntIDplLs3LBGri8Xl8j1CJU4brkSm
	 FiS3M3355DIrRglMNdt2+q33GkdPVfLqMY8afHJ9EhxSCLPa4JAKHcrQQeQJvv1SWr
	 e0VkGtKq61zGX/umvM1kOgzoPH+iCzFOSrafUnkSIoRcYCGAoEaL+IBSeA/OjD8ii7
	 8HJRTQbOc+nGQn2kxq/uuKBJVnR9n1R8t1dtx586spadqAHtsgZ2u7KrJnFoIarVin
	 323HmyWIQY93UihThmi3VXjSvCaadaNOe/80lj4qR7kj9os0ScD1e4UXSHHkLOTFnk
	 wRET25BGoJgMw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 01 Apr 2026 15:10:58 -0400
Subject: [PATCH 1/4] mm: fix IOCB_DONTCACHE write performance with
 rate-limited writeback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-dontcache-v1-1-1f5746fab47a@kernel.org>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
In-Reply-To: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <msnitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bOe16hkUqbqlZCJU8w30Z5j55Ar6Gej61o9MPI+OrvA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpzW3TYYBGxB56wbiSNOObN6S4exPYnQ+w1A6S3
 USLKZ4d5smJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCac1t0wAKCRAADmhBGVaC
 FSj/EADCTOcmKwq7ER+CHpVYKKkKxZKs6LtlI+SGxgJR7bR2Ytq1OHRCgdxX/mFBolJ3jWmFGCo
 UN5zb8G7MsLL7+RA3wZch+lVZ+HtrT8VK33trWUwWiZ3/Y0pT8/szAL6kjkKF/YyEUxjn0ps2IM
 3bJd1f6fPRKwsnk0X7x/rhvRocAol7QnLsRgZBMeQ7+j+ZF9RpYhKf1J8bN4sdEkYdetphsVqaV
 5nNKaCKmGRfA7q7sl9RgeBLHr68nZpA0aFhZoKO10UvVqVp+TgBVcvLTHOiI9qx3pxU3ZH4lhtm
 QHAbpLt2FFphXNir6sLBoR5sJW1u/2ScCVxj5f+AJHxA0ha0jHhQMkeYgipgPITocCDghBr9N1g
 Xlilb2Vwf6YqvVKZiQE4+B2U7XDKGz6XcGTPntUzVCWKFBrzzrtr0gBXKsn7eCagRYhucoo4F1/
 UkjNW6of6HjuRG0XcSVvEpQBfD/d6rcV9zm7K7IUUaS/QNLrQWqR6yT+1EWoBTHj4NxfPorpvp0
 dH8Z/31MrgFT1mPQJxvuqmwQxDtZrHe6zz50HF8RVlC1SFd6eAQKnUHcUNW+RLq+kHlydHjEdIR
 WrvYJtr23sc2IK3WkYXB1lRgpoSya7nuyslzkCuySX1bpQstObmlZ6YrYycq0UkSvXazf0nJRz7
 UhUIwXTGWPBRjoA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20596-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C819937FB3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IOCB_DONTCACHE calls filemap_flush_range() with nr_to_write=LONG_MAX
on every write, which flushes all dirty pages in the written range.
Under concurrent writers this creates severe serialization on the
writeback submission path, causing throughput to collapse to ~47% of
buffered I/O with multi-second tail latency.  Even single-client
sequential writes suffer: on a 512GB file with 256GB RAM, the
aggressive flushing triggers dirty throttling that limits throughput
to 575 MB/s vs 1442 MB/s with rate-limited writeback.

Replace the filemap_flush_range() call in generic_write_sync() with a
new filemap_dontcache_writeback_range() that uses two rate-limiting
mechanisms:

  1. Skip-if-busy: check mapping_tagged(PAGECACHE_TAG_WRITEBACK)
     before flushing.  If writeback is already in progress on the
     mapping, skip the flush entirely.  This eliminates writeback
     submission contention between concurrent writers.

  2. Proportional cap: when flushing does occur, cap nr_to_write to
     the number of pages just written.  This prevents any single
     write from triggering a large flush that would starve concurrent
     readers.

Both mechanisms are necessary: skip-if-busy alone causes I/O bursts
when the tag clears (reader p99.9 spikes 83x); proportional cap alone
still serializes on xarray locks regardless of submission size.

Pages touched under IOCB_DONTCACHE continue to be marked for eviction
(dropbehind), so page cache usage remains bounded.  Ranges skipped by
the busy check are eventually flushed by background writeback or by
the next writer to find the tag clear.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h |  7 +++++--
 mm/filemap.c       | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25ec12b00ac1df17a952d9116b88047..53e9cca1b50a946a1276c49902294c3ae0ab3500 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2610,6 +2610,8 @@ extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
 int filemap_flush_range(struct address_space *mapping, loff_t start,
 		loff_t end);
+int filemap_dontcache_writeback_range(struct address_space *mapping,
+		loff_t start, loff_t end, ssize_t nr_written);
 
 static inline int file_write_and_wait(struct file *file)
 {
@@ -2645,8 +2647,9 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
-		filemap_flush_range(mapping, iocb->ki_pos - count,
-				iocb->ki_pos - 1);
+		filemap_dontcache_writeback_range(mapping,
+				iocb->ki_pos - count,
+				iocb->ki_pos - 1, count);
 	}
 
 	return count;
diff --git a/mm/filemap.c b/mm/filemap.c
index 406cef06b684a84a1e0c27d8267e95f32282ffdc..af2024b736bef74571cc22ab7e3cde2c8e872efe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -437,6 +437,35 @@ int filemap_flush_range(struct address_space *mapping, loff_t start,
 }
 EXPORT_SYMBOL_GPL(filemap_flush_range);
 
+/**
+ * filemap_dontcache_writeback_range - rate-limited writeback for dontcache I/O
+ * @mapping:	target address_space
+ * @start:	byte offset to start writeback
+ * @end:	last byte offset (inclusive) for writeback
+ * @nr_written:	number of bytes just written by the caller
+ *
+ * Rate-limited writeback for IOCB_DONTCACHE writes.  Skips the flush
+ * entirely if writeback is already in progress on the mapping (skip-if-busy),
+ * and when flushing, caps nr_to_write to the number of pages just written
+ * (proportional cap).  Together these avoid writeback contention between
+ * concurrent writers and prevent I/O bursts that starve readers.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_dontcache_writeback_range(struct address_space *mapping,
+		loff_t start, loff_t end, ssize_t nr_written)
+{
+	long nr;
+
+	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		return 0;
+
+	nr = (nr_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
+			WB_REASON_BACKGROUND);
+}
+EXPORT_SYMBOL_GPL(filemap_dontcache_writeback_range);
+
 /**
  * filemap_flush - mostly a non-blocking flush
  * @mapping:	target address_space

-- 
2.53.0


