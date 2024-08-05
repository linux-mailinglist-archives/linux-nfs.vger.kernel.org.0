Return-Path: <linux-nfs+bounces-5233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298939478AE
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5D1C20DA8
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB10137772;
	Mon,  5 Aug 2024 09:46:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA110953
	for <linux-nfs@vger.kernel.org>; Mon,  5 Aug 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851166; cv=none; b=sqUODy6W7I8312PluXo87zzqYhE3/nOya+nntwEeNCGkb87j+fBi1ztCbjVowr26hRca/MNyrXq+nXP9z9tROpGRs5OA0CaOLjKVMMpNGNUcIiPMJkWm8mGCiTXNbHNc2ar5r0VZXPbzvh4209oEF7SMOU8DK1GrYFgvQaUVMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851166; c=relaxed/simple;
	bh=6vZvaRxZoDkpRz0O1Z2ssgONM++703KaP98tcOIX9tI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ej7BD1ePgaZK3x1JdfGNklUYiUFMmQseMJJj2RooE8RMsJ7KDR1wxvlJf+8+n0BB6QwcxUiok14w+P5XTUBy5pFpScYHdS1rRtU341seg8zw9Ut+/tf60Ceqe96UHB/xRCXZDNPoZZr2pX5vUGl4FFP/LgfgWuI3wi1NdNX3myU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36841f56cf6so1308709f8f.3
        for <linux-nfs@vger.kernel.org>; Mon, 05 Aug 2024 02:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722851162; x=1723455962;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gTDTCRTfdjRj+rq39uLI+rpooJiIiuSJBDZ3lGjzGiI=;
        b=Pyoep/BF4g+MnJF0s8DFj9O6ZFTl2D/bJ4+FUjQQ5TKuW3Ay880myCJXrfD8y98EGJ
         wV5Y6V49O4WRnK2dU8nX9BYwQKKgi1z4m6ogMMb0hmKoEiddnHaH1zQ4PR2L1wTqpHuQ
         2gzlYs/p3fZtg3h9HoYScNpMc8Ov7UPYTWM5TNNlEuzZRVQkwbEqPz4AnXArUXWGlC2y
         dBdkcfxbPIMZZntXuSYRQh5KRp6nysHIiTvFi1QAzujYEDvfk8dcpsJCLYvohpD8RDyt
         dHQUYDfmvbJJGi8+vP7sQnUVcZdVoqsn9WF/2WBXAsdxObplEtouFaZiqcR6m1rfec0z
         p1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI25MRMBf1kZO9T+CbCfQvHzVe3MpgR9tCYw8sKuM3+HnClKiF+pWdPFH6QPJMech/dx1HEFMIW/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqC5V6fSOnqBYZtgg6+4W2eFBaf69KVbErBzkpmQEfnQZMZT4
	9gg5WCZAE9P0TXGxeo/VSpmp9ZNf87b6n/wkL0F35VGN/T6sLyF+m4ylOA==
X-Google-Smtp-Source: AGHT+IEyNo3TeJL+cCsKtdTL/c/VvnphI2tfasnMxUKOJOvRRGPiELqhZeR6EoPMwmZPHVeganAc6Q==
X-Received: by 2002:a05:600c:3b03:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428e6b835b9mr50207395e9.3.1722851162236;
        Mon, 05 Aug 2024 02:46:02 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baba4f1sm191178875e9.23.2024.08.05.02.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 02:46:01 -0700 (PDT)
Message-ID: <6378987a-e289-4173-9f09-093ba50ee75f@grimberg.me>
Date: Mon, 5 Aug 2024 12:46:00 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Jeff Layton <jlayton@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Question about NFS client locks and delegations
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey,

I'm looking at the NFS client locking code, and it seems to me that it 
violates the spec
by caching locks when holding a read delegation.

 From 18.10.4.  IMPLEMENTATION
--
    When a client holds an OPEN_DELEGATE_WRITE delegation, the client
    holding that delegation is assured that there are no opens by other
    clients.  Thus, there can be no conflicting LOCK operations from such
    clients.  Therefore, the client may be handling locking requests
    locally, without doing LOCK operations on the server.  If it does
    that, it must be prepared to update the lock status on the server, by
    sending appropriate LOCK and LOCKU operations before returning the
    delegation.

    When one or more clients hold OPEN_DELEGATE_READ delegations, any
    LOCK operation where the server is implementing mandatory locking
    semantics MUST result in the recall of all such delegations. The
    LOCK operation may not be granted until all such delegations are
    returned or revoked.  Except where this happens very quickly, one or
    more NFS4ERR_DELAY errors will be returned to requests made while the
    delegation remains outstanding.
--

I don't see how the second paragraph can be met if the client caches locks.
I've added a set of changes to address this [1] (untested, its designed 
to illustrate the point).

Any thoughts on this?

[1]
--
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ce48e26dc825..290b7ff1cce0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7444,7 +7444,7 @@ static int nfs4_lock_reclaim(struct nfs4_state 
*state, struct file_lock *request

         do {
                 /* Cache the lock if possible... */
-               if (test_bit(NFS_DELEGATED_STATE, &state->flags) != 0)
+               if (nfs_have_write_delegation(state->inode))
                         return 0;
                 err = _nfs4_do_setlk(state, F_SETLK, request, 
NFS_LOCK_RECLAIM);
                 if (err != -NFS4ERR_DELAY)
@@ -7470,7 +7470,7 @@ static int nfs4_lock_expired(struct nfs4_state 
*state, struct file_lock *request
                 return 0;
         }
         do {
-               if (test_bit(NFS_DELEGATED_STATE, &state->flags) != 0)
+               if (nfs_have_write_delegation(state->inode))
                         return 0;
                 err = _nfs4_do_setlk(state, F_SETLK, request, 
NFS_LOCK_EXPIRED);
                 switch (err) {
@@ -7516,7 +7516,7 @@ static int _nfs4_proc_setlk(struct nfs4_state 
*state, int cmd, struct file_lock
                 goto out;
         mutex_lock(&sp->so_delegreturn_mutex);
         down_read(&nfsi->rwsem);
-       if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
+       if (nfs_have_write_delegation(state->inode)) {
                 /* Yes: cache locks! */
                 /* ...but avoid races with delegation recall... */
                 request->c.flc_flags = flags & ~FL_SLEEP;
--


