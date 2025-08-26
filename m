Return-Path: <linux-nfs+bounces-13906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AFEB372B7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807B37A7FCD
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054451FECAB;
	Tue, 26 Aug 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgvjQLbP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA02D1F40
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234650; cv=none; b=WV7yUn6yt3psWE6tml3OUzSTA9a84P/3iXDmvpfZth7m+XQ79FoVlOUMrUga3k7QqMS/ZhfHkirM42wWMvOpa8iBqwYg7u13QEENpg6fSWUjF7CjbqW8Sw6DF/19VZvs0useQjhTdXlmu3n8vcnmOMDkZc6kjXHfr6Ycd8ukKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234650; c=relaxed/simple;
	bh=C+dCDygYOhJhYWUV+W387xb9Zw6Vu30FaRYv60AFb1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnHIGML1eXKA6S4tm2Qzt46zLSbWyfFNFp7kePCYxmENZcRxxZz+1jJlEZ5pHaJ5r/wHMvWT7AYrocMsu4N6BJ8VMn/g1QVVebQ00BV70LMpFvKdg2x7DppUrug+x2qP2/9TDeHcPX5EUhvWNXiOkLpYOBDecnz/D6gQe/tO7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgvjQLbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42604C4CEF1;
	Tue, 26 Aug 2025 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234650;
	bh=C+dCDygYOhJhYWUV+W387xb9Zw6Vu30FaRYv60AFb1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgvjQLbPveiidJLmHS1aBHmMd3s5coNlorz9TRtNcZW2CO44VdJpCeK2lImTv2mSc
	 AWMS1MdEgvwHU2tH2Omo32li++rMxEE09hA04eefoHbI8d3GezP3HbcJx6UQm3ZXMq
	 EC/T1K+FjBJB8y7hw83t5hauNPD96odYU5NaAWGNj69FxXSLktdFyirYNd3o2EPrvs
	 kTyhPp8cz66YxQ6MFCySecNPRWNffPYrbbwLnuL7M/3fT0r19sb1qMyrKdRHo+3i2M
	 AZrks0Pog9jF7cj1SvCuSKQ58VYzu8NLy9buD0roS85B2X35kK5NP0nQk6rlmoCj2H
	 JqtB+egFtU1BA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 7/7] NFSD: add nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events
Date: Tue, 26 Aug 2025 14:57:18 -0400
Message-ID: <20250826185718.5593-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250826185718.5593-1-snitzer@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
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
index 967ca67f197fc..c2b044cb3b76c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1143,6 +1143,12 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		}
 	}
 
+	/* Show original offset and count, and how it was expanded for DIO */
+	middle_end = read_dio->end - read_dio->end_extra;
+	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
+				    read_dio->start, read_dio->start_extra,
+				    offset, (middle_end - offset),
+				    middle_end, read_dio->end_extra);
 	return true;
 }
 
@@ -1392,7 +1398,7 @@ nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
 		start_offset = 0;
 		start_len = 0;
-		return true;
+		goto out;
 	}
 
 	start_end = round_up(offset, dio_blocksize);
@@ -1405,7 +1411,10 @@ nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


