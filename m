Return-Path: <linux-nfs+bounces-3354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA18CD8C0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428D7281F67
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E822334;
	Thu, 23 May 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSKBFgEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mDqPLG81";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSKBFgEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mDqPLG81"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D1376E6
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483295; cv=none; b=q7KL7D9uEHRUKJl/oX+rPv+lBl+4R2jU2MLngrnAlXahN7RadmtNRArFrbzRT9QSKefDk4vFyOxhriVIVWDvOISVSTZU3IjDcA7ChDx+c6M5WORdQh7+647fnPT2QK5tD6nOtJAaOo8Q11UWvLfhh+GqAbBMF5l5AZJ4ZQoFuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483295; c=relaxed/simple;
	bh=ohdZHSXOUutxEUre5DFBnnW4dAjvsrpiFgHd2sF+cag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VBTiCgVDne7fGcCoAEszwiMyhXasVlLufyVWZbL9h8mCxY1bIrp9NioxBeVWgrmif0Nu4mG33lIR44aVR5kM08Zq4DJYRWl8J8ySR1LJU0HgDvYslA5sQimtI4TyZGhqQ3OHVgP2sAEax4ltOskJPpIEiFBc3NgnMW6A1UHeF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NSKBFgEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mDqPLG81; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NSKBFgEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mDqPLG81; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5381229F5;
	Thu, 23 May 2024 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716483291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c2PbDfq99BmHxAN8DwvDDwdAWN3IEiVUwBDZUfyriYI=;
	b=NSKBFgEXUBcvc8Gvnv+r4otaYVCcTSUBdr/4Eukf+mwie00QMEVQJNbYOLTG96Tl8wp8/g
	YTZ1DtdolDak0ehVPzV3Qg1xtiQRc0hq+Ly0mNs4iARlm8b74XrSz5tt+3VxX/euW2OKqH
	v/qUxd2mh3fiaHrHQ8AQK0UG9OkiBoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716483291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c2PbDfq99BmHxAN8DwvDDwdAWN3IEiVUwBDZUfyriYI=;
	b=mDqPLG8131ZHXHvOcw4QIEH3IO1ubqB+EeiDlWjmgyxQE3v0q4uPwww8vqrRNetbNf0wFM
	yjZ8EYShLDfwsxAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716483291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c2PbDfq99BmHxAN8DwvDDwdAWN3IEiVUwBDZUfyriYI=;
	b=NSKBFgEXUBcvc8Gvnv+r4otaYVCcTSUBdr/4Eukf+mwie00QMEVQJNbYOLTG96Tl8wp8/g
	YTZ1DtdolDak0ehVPzV3Qg1xtiQRc0hq+Ly0mNs4iARlm8b74XrSz5tt+3VxX/euW2OKqH
	v/qUxd2mh3fiaHrHQ8AQK0UG9OkiBoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716483291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=c2PbDfq99BmHxAN8DwvDDwdAWN3IEiVUwBDZUfyriYI=;
	b=mDqPLG8131ZHXHvOcw4QIEH3IO1ubqB+EeiDlWjmgyxQE3v0q4uPwww8vqrRNetbNf0wFM
	yjZ8EYShLDfwsxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD1413A6B;
	Thu, 23 May 2024 16:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g7iuKdt0T2YNewAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 May 2024 16:54:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5CC75A0770; Thu, 23 May 2024 18:54:36 +0200 (CEST)
Date: Thu, 23 May 2024 18:54:36 +0200
From: Jan Kara <jack@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Bad NFS performance for fsync(2)
Message-ID: <20240523165436.g5xgo7aht7dtmvfb@quack3>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hello!

I've been debugging NFS performance regression with recent kernels. It
seems to be at least partially related to the following behavior of NFS
(which is there for a long time AFAICT). Suppose the following workload:

fio --direct=0 --ioengine=sync --thread --directory=/test --invalidate=1 \
  --group_reporting=1 --runtime=100 --fallocate=posix --ramp_time=10 \
  --name=RandomWrites-async --new_group --rw=randwrite --size=32000m \
  --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1 \
  --filename_format='FioWorkloads.$jobnum'

So we do 4k buffered random writes from 4 threads into 4 different files.
Now the interesting behavior comes on the final fsync(2). What I observe is
that the NFS server getting a stream of 4-8k writes which have 'stable'
flag set. What the server does for each such write is that performs the
write and calls fsync(2). Since by the time fio calls fsync(2) on the NFS
client there is like 6-8 GB worth of dirty pages to write and the server
effectively ends up writing each individual 4k page as O_SYNC write, the
throughput is not great...

The reason why the client sets 'stable' flag for each page write seems to
be because nfs_writepages() issues writes with FLUSH_COND_STABLE for
WB_SYNC_ALL writeback and nfs_pgio_rpcsetup() has this logic:

        switch (how & (FLUSH_STABLE | FLUSH_COND_STABLE)) {
        case 0:
                break;
        case FLUSH_COND_STABLE:
                if (nfs_reqs_to_commit(cinfo))
                        break;
                fallthrough;
        default:
                hdr->args.stable = NFS_FILE_SYNC;
        }

but since this is final fsync(2), there are no more requests to commit so
we set NFS_FILE_SYNC flag.

Now I'd think the client is stupid in submitting so many NFS_FILE_SYNC
writes instead of submitting all as async and then issuing commit (i.e.,
the switch above in nfs_pgio_rpcsetup() could gain something like:

		if (count > <small_magic_number>)
			break;

But I'm not 100% sure this is a correct thing to do since I'm not 100% sure
about the FLUSH_COND_STABLE requirements. On the other hand it could be
also argued that the NFS server could be more clever and batch the
fsync(2)s for many sync writes to the same file. But there the heuristic is
less clear.

So what do people think?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

