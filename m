Return-Path: <linux-nfs+bounces-21479-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II5rHYO9AmrKwAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21479-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:41:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E051A4B3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C3113014FC8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCB3D6CB3;
	Tue, 12 May 2026 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KIK+jQvS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA53B7744;
	Tue, 12 May 2026 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564208; cv=none; b=T7dHhhPt/U6aIJa6HWkdyj/VQXrESpZ0RNvnjIyPAvm7cnU8gx/1Z5dXW0ybbmND14xbN0bsR44MgHIGNQu9gIbtxGq11yUTm5MqVBuljRcUAgHAHjmXxrUKncva7Z1QvG4vWcYFJWwVocSb+rVjjwi7xfJpFY73AsS4yAyP6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564208; c=relaxed/simple;
	bh=XFV7RR6J0X5n+Nu9/rm5rxtB2SpA+lJioNk9zcWWi6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjCbxmtOUPouerY+7M3/W4D8PgmAEb/nnKmBQR3Q34qRquXNWu2cWv+gBihqgwR42QJMYEPjotlxua1V9luRn6eEtDr/LVd6oLEg1PqN8HlJI5sslZF1GM1Nyw4NoLt5m9T2nX8bk5HK79ElCx1DaGmzabD77py8pkp82nNBM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KIK+jQvS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=L6G3lv4jbdMbQ4QsNCiCXE8kA9OQYRVEnsOclxNjvlk=; b=KIK+jQvSnKRXIFRrePcKSt8tSC
	gTDIoVa3ilaBJgAv2JyiBq1oBQNEEVuR8cAKQZACHFbXeQgzOq5bCCS43yMoo3rZpQpygSiDzL+5p
	k8ewxMk5abPknkbI0BLQkk18U//bp1Se74dgd8ytTOIwgIqIRD8+j0upZnmtm9RP/nG0Iay4iv5BI
	0R0Ux2iGn5C8GSW0QkgvHRpchKQA0HU/3surCqZ+w6g1XBcpaQIEofBGAUjsWIOw9fW5TdRUHOoZH
	pIElcotsE4NXj4I4GC6C78nmVfU4K8GqhWK2VIAj1M/0+2fkttDIMP1Vqdy9WFOxCQtHvlSJJWz7z
	NqzmFnXw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfnF-0000000FfDa-0NfM;
	Tue, 12 May 2026 05:36:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong " <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: improve the swap_activate interface
Date: Tue, 12 May 2026 07:35:16 +0200
Message-ID: <20260512053625.2950900-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 1C8E051A4B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21479-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid,infradead.org:dkim]
X-Rspamd-Action: no action

Hi all,

Darrick recently posted iomap support for fuse-iomap, which was trivial
but a bit ugly, which triggered me into looking how this could be done
in a cleaner way.  The result of that is this fairly big series that
reworks how the MM code calls into the file system to activate swap
files to make it much cleaner and easier to use.

I've tested this with swap devices manually, and using the swap tests
in xfstests on btrfs, ext3, ext4, f2fs and xfs to exercise the different
implementation.  Out of those all passed, but f2fs actually notruns all
tests even in the baseline as it requires special preparation for
swapfiles which never got wired up in xfstests.

Diffstat:
 Documentation/filesystems/iomap/operations.rst |    3 
 Documentation/filesystems/locking.rst          |   35 +--
 Documentation/filesystems/vfs.rst              |   40 ++--
 block/fops.c                                   |   15 +
 fs/btrfs/btrfs_inode.h                         |    3 
 fs/btrfs/file.c                                |    4 
 fs/btrfs/inode.c                               |   72 -------
 fs/ext4/file.c                                 |    6 
 fs/ext4/inode.c                                |   11 -
 fs/f2fs/data.c                                 |   50 -----
 fs/f2fs/f2fs.h                                 |    2 
 fs/f2fs/file.c                                 |    4 
 fs/iomap/swapfile.c                            |  165 +++---------------
 fs/nfs/direct.c                                |    1 
 fs/nfs/file.c                                  |   21 --
 fs/nfs/nfs4file.c                              |    3 
 fs/ntfs/aops.c                                 |    8 
 fs/ntfs/file.c                                 |    6 
 fs/smb/client/cifsfs.c                         |   18 +
 fs/smb/client/cifsfs.h                         |    3 
 fs/smb/client/file.c                           |   16 -
 fs/xfs/xfs_aops.c                              |   48 -----
 fs/xfs/xfs_file.c                              |   39 ++++
 fs/zonefs/file.c                               |   30 +--
 include/linux/fs.h                             |   11 -
 include/linux/iomap.h                          |    5 
 include/linux/nfs_fs.h                         |    3 
 include/linux/swap.h                           |  129 +-------------
 mm/page_io.c                                   |   45 ----
 mm/swap.h                                      |   92 ++++++++++
 mm/swapfile.c                                  |  227 ++++++++++++++-----------
 31 files changed, 471 insertions(+), 644 deletions(-)

