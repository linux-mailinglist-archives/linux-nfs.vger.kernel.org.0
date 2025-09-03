Return-Path: <linux-nfs+bounces-14022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5EB42B54
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330165E0DE6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1512E8DF0;
	Wed,  3 Sep 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl+gVbOc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE972DCF73
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932692; cv=none; b=oNYK5UNeFWnJLEZlrvrsQxTbdJfF6m6YUM9vNZ/3DsoStifN/jflpvrQrioI3H6VaC15R5ZWMBAu/Nw2FyKsbv4WQfM+kVQwolXQxHm9PT6qaN0vPwK7KzX1J1rU4jRIQJbUUEux+Ags7tF3SuqpsuO6NFvSS8bKNxUvxt1oO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932692; c=relaxed/simple;
	bh=alIq6iy2SOKQ66En19xXVE1/O9+x+2+UNpNsHqMxdqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIx/BmCpGA5VPuRJMAipO5YAd/XWh4a08Q4t6+ijrldFMZIIplvARlvF3Ng43W+QN4N2pg9DnRIxn+D+5WPaH46QOivWZ1RqXltcGRN/aLHNKmup+io4BlC+bEx4VUyFJa8Ok5AnTrCkqyPUyHmkRVdVbEy3hBSFjYtr+qvl+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl+gVbOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C36C4CEE7;
	Wed,  3 Sep 2025 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932692;
	bh=alIq6iy2SOKQ66En19xXVE1/O9+x+2+UNpNsHqMxdqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fl+gVbOcT9Yn/2FFUspWL+b55cI1TyYq/qsdmYCp/5vEHT/8U2/d4e68V3ytUKOtq
	 s8TOWcwUdxD2pbCeO+/u/VlEAWb1JWsjCDspCztUWLMVai1vPBQPgbYrEPg8bL8Khu
	 NZky0gKRKTANBafw+3P91KoaLtFM3SHGR6ZTyXWhRc5YuJa+Ty3TQu8XNq5rIHo4KY
	 zbxGw9V2LXD+S5E2HPS/dPYfcFBP1uezNzZtPr7Jwn7PMp3Uygf9whdWmRNZN86hUo
	 Nhw70D0aR3IMkMd8C9F6+N4piqJEkh8DWgutyqXlFYf4nISzR0xBfTwu6t/iLa9jtp
	 xizzJdayg61UQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 7/9] NFSD: add nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events
Date: Wed,  3 Sep 2025 16:51:19 -0400
Message-ID: <20250903205121.41380-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250903205121.41380-1-snitzer@kernel.org>
References: <20250903205121.41380-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EVENT_CLASS nfsd_analyze_dio_class and use it to create
nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events.

The nfsd_analyze_read_dio trace event shows how NFSD expands any
misaligned READ to the next DIO-aligned block (on either end of the
original READ, as needed).

 This combination of trace events is useful for READs:
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

 Which for this dd command:
  dd if=/mnt/share1/test of=/dev/null bs=47008 count=2 iflag=direct

 Results in:
  nfsd-23908[010] ..... 10375.141640: nfsd_analyze_read_dio: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+47008 end=47008+96
  nfsd-23908[010] ..... 10375.141642: nfsd_read_vector: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47104
  nfsd-23908[010] ..... 10375.141643: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0x0 bytecount 0xb800
  nfsd-23908[010] ..... 10375.141773: nfsd_read_io_done: xid=0x82c5923b fh_hash=0x857ca4fc offset=0 len=47008

  nfsd-23908[010] ..... 10375.142063: nfsd_analyze_read_dio: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=46592+416 middle=47008+47008 end=94016+192
  nfsd-23908[010] ..... 10375.142064: nfsd_read_vector: xid=0x83c5923b fh_hash=0x857ca4fc offset=46592 len=47616
  nfsd-23908[010] ..... 10375.142065: xfs_file_direct_read: dev 259:2 ino 0xc00116 disize 0x226e0 pos 0xb600 bytecount 0xba00
  nfsd-23908[010] ..... 10375.142103: nfsd_read_io_done: xid=0x83c5923b fh_hash=0x857ca4fc offset=47008 len=47008

The nfsd_analyze_write_dio trace event shows how NFSD splits a given
misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
extent.

 This combination of trace events is useful for WRITEs:
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

 Which for this dd command:
  dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct

 Results in:
  nfsd-23908[010] ..... 10374.902333: nfsd_write_opened: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008
  nfsd-23908[010] ..... 10374.902335: nfsd_analyze_write_dio: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+46592 end=46592+416
  nfsd-23908[010] ..... 10374.902343: xfs_file_direct_write: dev 259:2 ino 0xc00116 disize 0x0 pos 0x0 bytecount 0xb600
  nfsd-23908[010] ..... 10374.902697: nfsd_write_io_done: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008

  nfsd-23908[010] ..... 10374.902925: nfsd_write_opened: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008
  nfsd-23908[010] ..... 10374.902926: nfsd_analyze_write_dio: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=47008+96 middle=47104+46592 end=93696+320
  nfsd-23908[010] ..... 10374.903010: xfs_file_direct_write: dev 259:2 ino 0xc00116 disize 0xb800 pos 0xb800 bytecount 0xb600
  nfsd-23908[010] ..... 10374.903239: nfsd_write_io_done: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/trace.h | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   | 13 +++++++++--
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a664fdf1161e9..cd757d2c52c84 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,6 +473,67 @@ DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
 DEFINE_NFSD_IO_EVENT(commit_done);
 
+DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*fhp,
+		 u64		offset,
+		 u32		len,
+		 loff_t		start,
+		 ssize_t	start_len,
+		 loff_t		middle,
+		 ssize_t	middle_len,
+		 loff_t		end,
+		 ssize_t	end_len),
+	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(u64, offset)
+		__field(u32, len)
+		__field(loff_t, start)
+		__field(ssize_t, start_len)
+		__field(loff_t, middle)
+		__field(ssize_t, middle_len)
+		__field(loff_t, end)
+		__field(ssize_t, end_len)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->offset = offset;
+		__entry->len = len;
+		__entry->start = start;
+		__entry->start_len = start_len;
+		__entry->middle = middle;
+		__entry->middle_len = middle_len;
+		__entry->end = end;
+		__entry->end_len = end_len;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%zd middle=%llu+%zd end=%llu+%zd",
+		  __entry->xid, __entry->fh_hash,
+		  __entry->offset, __entry->len,
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+)
+
+#define DEFINE_NFSD_ANALYZE_DIO_EVENT(name)			\
+DEFINE_EVENT(nfsd_analyze_dio_class, nfsd_analyze_##name##_dio,	\
+	TP_PROTO(struct svc_rqst *rqstp,			\
+		 struct svc_fh	*fhp,				\
+		 u64		offset,				\
+		 u32		len,				\
+		 loff_t		start,				\
+		 ssize_t	start_len,			\
+		 loff_t		middle,				\
+		 ssize_t	middle_len,			\
+		 loff_t		end,				\
+		 ssize_t	end_len),			\
+	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len))
+
+DEFINE_NFSD_ANALYZE_DIO_EVENT(read);
+DEFINE_NFSD_ANALYZE_DIO_EVENT(write);
+
 DECLARE_EVENT_CLASS(nfsd_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c163afe13ab35..5b3c6072b6f5c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1128,6 +1128,12 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return false;
 	}
 
+	/* Show original offset and count, and how it was expanded for DIO */
+	middle_end = read_dio->end - read_dio->end_extra;
+	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
+				    read_dio->start, read_dio->start_extra,
+				    offset, (middle_end - offset),
+				    middle_end, read_dio->end_extra);
 	return true;
 }
 
@@ -1371,7 +1377,7 @@ nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
 		start_offset = 0;
 		start_len = 0;
-		return true;
+		goto out;
 	}
 
 	start_end = round_up(offset, dio_blocksize);
@@ -1384,7 +1390,10 @@ nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	write_dio->middle_len = middle_end - start_end;
 	write_dio->end_offset = middle_end;
 	write_dio->end_len = orig_end - middle_end;
-
+out:
+	trace_nfsd_analyze_write_dio(rqstp, fhp, offset, len, start_offset, start_len,
+				     write_dio->middle_offset, write_dio->middle_len,
+				     write_dio->end_offset, write_dio->end_len);
 	return true;
 }
 
-- 
2.44.0


