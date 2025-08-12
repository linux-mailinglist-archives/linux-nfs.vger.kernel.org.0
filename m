Return-Path: <linux-nfs+bounces-13580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A34B22EB3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2776213FC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A923D7F6;
	Tue, 12 Aug 2025 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="BcEdqfbC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-201a.earthlink-vadesecure.net (mta-201b.earthlink-vadesecure.net [51.81.229.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43062242D74
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.229.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018641; cv=none; b=mEA6wn/6wHuLIEH5eGJA5m8+ecIEZeQlFrbwXTe3ph4aAljmsN9mYnZj1OTVvMe3a5kj5GiafArDVYWiL0yFiJsevIJn4Q/VMB9zIVIqdpYRgXakImG1OwjbMSVUSmwwnlbIYhD1xnDZGEdxN7mp5gkGWqDLve5k8mMXlXt4ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018641; c=relaxed/simple;
	bh=obgfCFL7qbPyeXvj1u7JrHVVG8IbLK6ClTbSlSm1NZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ubWPE/o4HeEZvDzdTvuwBBPn3Ng3hBF2FXcsmwbulcjjUnyjRpG9YJn0DHlFS85g5WQh+Wa8Umse//1jVARMmY5rMCHT9Do7luA376a0ZYeF5z67CCsMgt/2TGMhCJPL+0seNXNxWrUiZqMVVRhWX8hLH0NcQvpWg+biHYtINDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=BcEdqfbC; arc=none smtp.client-ip=51.81.229.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=N5k0yHVx5qUaP/DuMjNkgBa3VqFYoL3aG5jgko
 tCDhU=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1755017722; x=1755622522; b=BcEdqfbCukMlcJo4n0pzAhgMZ2k
 Xze4jyWhnRqOCZSkrTHljL6DhGOfR4Fjznda6DCpKtkDcSYEpEhs/GheKDpoHxWC2vMsgcU
 3pI31UCy3E4UIvVOtTxHEgNWdtCPFiY+5va/KXcNmWKM9/+dwy6TNo37IPdzD6UHCxQKivR
 AXO4sw3al7OZYZOIS4vpjz3xD/zIGbaUTMO5uLlfo0x6zoubNvQ/hn9FnhT9MNFm/hn+lTs
 iolMHkMWmVieKFNd0/CVNhsQplxaF5Tt20LAYgXcLORK4FeVYJpFqJrwi94sbgjkmCkmijY
 TxN7ZMmwlr0zMZYAffYx0UIo1/eIbrw==
Received: from FRANKSTHINKPAD ([71.237.148.155])
 by vsel2nmtao01p.internal.vadesecure.com with ngmta
 id eca43610-185b1351f011347f; Tue, 12 Aug 2025 16:55:22 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: <linux-nfs@vger.kernel.org>
Cc: "'Calum Mackay'" <calum.mackay@oracle.com>,
	"'Ofir Vainshtein'" <ofirvins@google.com>
Subject: PYNFS LOCK20 Blocking Lock Test Case
Date: Tue, 12 Aug 2025 09:55:21 -0700
Message-ID: <01d001dc0ba9$e4cb0080$ae610180$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AdwLqQSxtgSqEAE9Q+SSqZvQr4D24A==

I believe this test case is wrong, relevant text from RFC:

Some clients require the support of blocking locks. The NFSv4
protocol must not rely on a callback mechanism and therefore is
unable to notify a client when a previously denied lock has been
granted. Clients have no choice but to continually poll for the
lock. This presents a fairness problem. Two new lock types are
added, READW and WRITEW, and are used to indicate to the server that
the client is requesting a blocking lock. The server should maintain
an ordered list of pending blocking locks. When the conflicting lock
is released, the server may wait the lease period for the first
waiting client to re-request the lock. After the lease period
expires, the next waiting client request is allowed the lock.

Test case:

    # Standard owner opens and locks a file
    fh1, stateid1 = c.create_confirm(t.word(), deny=OPEN4_SHARE_DENY_NONE)
    res1 = c.lock_file(t.word(), fh1, stateid1, type=WRITE_LT)
    check(res1, msg="Locking file %s" % t.word())
    # Second owner is denied a blocking lock
    file = c.homedir + [t.word()]
    fh2, stateid2 = c.open_confirm(b"owner2", file,
                                   access=OPEN4_SHARE_ACCESS_BOTH,
                                   deny=OPEN4_SHARE_DENY_NONE)
    res2 = c.lock_file(b"owner2", fh2, stateid2,
                       type=WRITEW_LT, lockowner=b"lockowner2_LOCK20")
    check(res2, NFS4ERR_DENIED, msg="Conflicting lock on %s" % t.word())
    sleeptime = c.getLeaseTime() // 2
    # Wait for queued lock to timeout
    for i in range(3):
        env.sleep(sleeptime, "Waiting for queued blocking lock to timeout")
        res = c.compound([op.renew(c.clientid)])
        check(res, [NFS4_OK, NFS4ERR_CB_PATH_DOWN])
    # Standard owner releases lock
    res1 = c.unlock_file(1, fh1, res1.lockid)
    check(res1)
    # Third owner tries to butt in and steal lock second owner is waiting
for
    # Should work, since second owner let his turn expire
    file = c.homedir + [t.word()]
    fh3, stateid3 = c.open_confirm(b"owner3", file,
                                   access=OPEN4_SHARE_ACCESS_BOTH,
                                   deny=OPEN4_SHARE_DENY_NONE)
    res3 = c.lock_file(b"owner3", fh3, stateid3,
                       type=WRITEW_LT, lockowner=b"lockowner3_LOCK20")
    check(res3, msg="Grabbing lock after another owner let his 'turn'
expire")

Note that the RFC indicated the client has one lease period AFTER the
conflicting lock is released to retry while the test case waits 1.5 lease
period after requesting the blocking lock before it releases the conflicting
lock...

Am I reading things right?

Thanks

Frank Filz


