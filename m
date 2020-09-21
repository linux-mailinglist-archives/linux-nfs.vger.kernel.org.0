Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B6D27318C
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIUSLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255BC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r9so16501354ioa.2
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RZfYu8TVTNWCRC6zypzUKpXdfOzY+3EeGlMI81YzUKo=;
        b=K0p+1zLbzu2cIFfQ0wLhZAK1jOIM/gJbGjXxjXZ/gVDKI6fRLvZKzsIjeYOHO5Tq8H
         Z8ORoWpjacNyMPYr9h1rmuqPAt0n/l383zYU1j/TrIQWZrsyh9GrhTeMF8yNDUj7Rdug
         E5g2Zjx/H5qshg4jKFSXLv/UY9xsJcrzHEEOzcxcdgdV9azZ+xTy1Dqar2cgcW04Ttqe
         61IfQzP/oUOu0QIPYjPCJB/JCVKLrOLzGzimzZ52LU7RfntThxhk/MpUq9y2w3lGhhfe
         rxEiNkcrTyThozZYK8h8HIkeyxFSRZwaAr++ecMbNeHJMmEIzF+Rsm6S2LyOjheKaEXh
         XWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RZfYu8TVTNWCRC6zypzUKpXdfOzY+3EeGlMI81YzUKo=;
        b=a9Pcb60AKu4wK7/hB3s4+/NUT+cTidyqdMyOP/m3FCN7gkWJh7eRYaezKqVLWR5FIm
         yZ2bvbG2zCwkjfIPyz+BMloBZLhSJ60D5KPY6JbQoxcZcr24UoVLLGdzP7gLMbuE4uVO
         9+WbnH/rWwLKLI+kR20QhQ/Nc/ZcVBoAr93kBW4q8cWipJN41moyxB0wElUFlmqF+EZ5
         FvTtWnI4nVMRqbhoQ5k8i4Q/8KD4y3/iVJLgvTlkc08jGeR/ENHXfPnjjQIVL13yrRaz
         jSyjp6myYa5A+WLXqrC32APj0EFLwi8FZC2v6ZAIPlhjvu/ad9LZPrUr8PYJ8FNxysyQ
         27LA==
X-Gm-Message-State: AOAM5307q6JPew0tjr/8nhVqsTrdf6XA7cFjyYqZw+WbHPTeoxWqqj9w
        9kJpdQPvKyO5m9dUvGXY/ZVqHiipzvQ=
X-Google-Smtp-Source: ABdhPJxCUShRH6prAdX4TO9E/U2vIGcCHhAXi7fU1zpuM/OLWVpzAMl97pDL5BPFmsEimyVMhc1t7Q==
X-Received: by 2002:a02:9986:: with SMTP id a6mr1113807jal.28.1600711862272;
        Mon, 21 Sep 2020 11:11:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c18sm4274803ild.35.2020.09.21.11.11.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:01 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIB06p003848;
        Mon, 21 Sep 2020 18:11:00 GMT
Subject: [PATCH v2 02/27] NFS: Move NFS protocol display macros to global
 header
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:00 -0400
Message-ID: <160071186041.1468.5870892464266935503.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: surface useful show_ macros so they can be shared between
the client and server trace code.

Additional clean up:
- Housekeeping: ensure the correct #include files are pulled in
  and add proper TRACE_DEFINE_ENUM where they are missing
- Use a consistent naming scheme for the helpers
- Store values to be displayed symbolically as unsigned long, as
  that is the type that the __print_yada() functions take

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h         |  387 ++++----------------------------------------
 fs/nfs/nfstrace.h          |  113 ++-----------
 fs/nfs/pnfs.h              |    4 
 fs/nfsd/trace.h            |    1 
 include/linux/nfs4.h       |    4 
 include/trace/events/nfs.h |  361 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 414 insertions(+), 456 deletions(-)
 create mode 100644 include/trace/events/nfs.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 502b13651c94..e5dfed490a1b 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -11,309 +11,7 @@
 #include <linux/tracepoint.h>
 
 #include <trace/events/fs.h>
-
-TRACE_DEFINE_ENUM(EPERM);
-TRACE_DEFINE_ENUM(ENOENT);
-TRACE_DEFINE_ENUM(EIO);
-TRACE_DEFINE_ENUM(ENXIO);
-TRACE_DEFINE_ENUM(EACCES);
-TRACE_DEFINE_ENUM(EEXIST);
-TRACE_DEFINE_ENUM(EXDEV);
-TRACE_DEFINE_ENUM(ENOTDIR);
-TRACE_DEFINE_ENUM(EISDIR);
-TRACE_DEFINE_ENUM(EFBIG);
-TRACE_DEFINE_ENUM(ENOSPC);
-TRACE_DEFINE_ENUM(EROFS);
-TRACE_DEFINE_ENUM(EMLINK);
-TRACE_DEFINE_ENUM(ENAMETOOLONG);
-TRACE_DEFINE_ENUM(ENOTEMPTY);
-TRACE_DEFINE_ENUM(EDQUOT);
-TRACE_DEFINE_ENUM(ESTALE);
-TRACE_DEFINE_ENUM(EBADHANDLE);
-TRACE_DEFINE_ENUM(EBADCOOKIE);
-TRACE_DEFINE_ENUM(ENOTSUPP);
-TRACE_DEFINE_ENUM(ETOOSMALL);
-TRACE_DEFINE_ENUM(EREMOTEIO);
-TRACE_DEFINE_ENUM(EBADTYPE);
-TRACE_DEFINE_ENUM(EAGAIN);
-TRACE_DEFINE_ENUM(ELOOP);
-TRACE_DEFINE_ENUM(EOPNOTSUPP);
-TRACE_DEFINE_ENUM(EDEADLK);
-TRACE_DEFINE_ENUM(ENOMEM);
-TRACE_DEFINE_ENUM(EKEYEXPIRED);
-TRACE_DEFINE_ENUM(ETIMEDOUT);
-TRACE_DEFINE_ENUM(ERESTARTSYS);
-TRACE_DEFINE_ENUM(ECONNREFUSED);
-TRACE_DEFINE_ENUM(ECONNRESET);
-TRACE_DEFINE_ENUM(ENETUNREACH);
-TRACE_DEFINE_ENUM(EHOSTUNREACH);
-TRACE_DEFINE_ENUM(EHOSTDOWN);
-TRACE_DEFINE_ENUM(EPIPE);
-TRACE_DEFINE_ENUM(EPFNOSUPPORT);
-TRACE_DEFINE_ENUM(EPROTONOSUPPORT);
-
-TRACE_DEFINE_ENUM(NFS4_OK);
-TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
-TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
-TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
-TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
-TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
-TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
-TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
-TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
-TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
-TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
-TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
-TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
-TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
-TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
-TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
-TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
-TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
-TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
-TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
-TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
-TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
-TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
-TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
-TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
-TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
-TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
-TRACE_DEFINE_ENUM(NFS4ERR_IO);
-TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
-TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
-TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
-TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
-TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
-TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
-TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
-TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
-TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
-TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
-TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
-TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
-TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
-TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
-TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
-TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
-TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_PERM);
-TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
-TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
-TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
-TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
-TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
-TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
-TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
-TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
-TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
-TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
-TRACE_DEFINE_ENUM(NFS4ERR_SAME);
-TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
-TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
-TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
-TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
-TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
-
-TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
-TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
-
-#define show_nfsv4_errors(error) \
-	__print_symbolic(error, \
-		{ NFS4_OK, "OK" }, \
-		/* Mapped by nfs4_stat_to_errno() */ \
-		{ EPERM, "EPERM" }, \
-		{ ENOENT, "ENOENT" }, \
-		{ EIO, "EIO" }, \
-		{ ENXIO, "ENXIO" }, \
-		{ EACCES, "EACCES" }, \
-		{ EEXIST, "EEXIST" }, \
-		{ EXDEV, "EXDEV" }, \
-		{ ENOTDIR, "ENOTDIR" }, \
-		{ EISDIR, "EISDIR" }, \
-		{ EFBIG, "EFBIG" }, \
-		{ ENOSPC, "ENOSPC" }, \
-		{ EROFS, "EROFS" }, \
-		{ EMLINK, "EMLINK" }, \
-		{ ENAMETOOLONG, "ENAMETOOLONG" }, \
-		{ ENOTEMPTY, "ENOTEMPTY" }, \
-		{ EDQUOT, "EDQUOT" }, \
-		{ ESTALE, "ESTALE" }, \
-		{ EBADHANDLE, "EBADHANDLE" }, \
-		{ EBADCOOKIE, "EBADCOOKIE" }, \
-		{ ENOTSUPP, "ENOTSUPP" }, \
-		{ ETOOSMALL, "ETOOSMALL" }, \
-		{ EREMOTEIO, "EREMOTEIO" }, \
-		{ EBADTYPE, "EBADTYPE" }, \
-		{ EAGAIN, "EAGAIN" }, \
-		{ ELOOP, "ELOOP" }, \
-		{ EOPNOTSUPP, "EOPNOTSUPP" }, \
-		{ EDEADLK, "EDEADLK" }, \
-		/* RPC errors */ \
-		{ ENOMEM, "ENOMEM" }, \
-		{ EKEYEXPIRED, "EKEYEXPIRED" }, \
-		{ ETIMEDOUT, "ETIMEDOUT" }, \
-		{ ERESTARTSYS, "ERESTARTSYS" }, \
-		{ ECONNREFUSED, "ECONNREFUSED" }, \
-		{ ECONNRESET, "ECONNRESET" }, \
-		{ ENETUNREACH, "ENETUNREACH" }, \
-		{ EHOSTUNREACH, "EHOSTUNREACH" }, \
-		{ EHOSTDOWN, "EHOSTDOWN" }, \
-		{ EPIPE, "EPIPE" }, \
-		{ EPFNOSUPPORT, "EPFNOSUPPORT" }, \
-		{ EPROTONOSUPPORT, "EPROTONOSUPPORT" }, \
-		/* NFSv4 native errors */ \
-		{ NFS4ERR_ACCESS, "ACCESS" }, \
-		{ NFS4ERR_ATTRNOTSUPP, "ATTRNOTSUPP" }, \
-		{ NFS4ERR_ADMIN_REVOKED, "ADMIN_REVOKED" }, \
-		{ NFS4ERR_BACK_CHAN_BUSY, "BACK_CHAN_BUSY" }, \
-		{ NFS4ERR_BADCHAR, "BADCHAR" }, \
-		{ NFS4ERR_BADHANDLE, "BADHANDLE" }, \
-		{ NFS4ERR_BADIOMODE, "BADIOMODE" }, \
-		{ NFS4ERR_BADLAYOUT, "BADLAYOUT" }, \
-		{ NFS4ERR_BADLABEL, "BADLABEL" }, \
-		{ NFS4ERR_BADNAME, "BADNAME" }, \
-		{ NFS4ERR_BADOWNER, "BADOWNER" }, \
-		{ NFS4ERR_BADSESSION, "BADSESSION" }, \
-		{ NFS4ERR_BADSLOT, "BADSLOT" }, \
-		{ NFS4ERR_BADTYPE, "BADTYPE" }, \
-		{ NFS4ERR_BADXDR, "BADXDR" }, \
-		{ NFS4ERR_BAD_COOKIE, "BAD_COOKIE" }, \
-		{ NFS4ERR_BAD_HIGH_SLOT, "BAD_HIGH_SLOT" }, \
-		{ NFS4ERR_BAD_RANGE, "BAD_RANGE" }, \
-		{ NFS4ERR_BAD_SEQID, "BAD_SEQID" }, \
-		{ NFS4ERR_BAD_SESSION_DIGEST, "BAD_SESSION_DIGEST" }, \
-		{ NFS4ERR_BAD_STATEID, "BAD_STATEID" }, \
-		{ NFS4ERR_CB_PATH_DOWN, "CB_PATH_DOWN" }, \
-		{ NFS4ERR_CLID_INUSE, "CLID_INUSE" }, \
-		{ NFS4ERR_CLIENTID_BUSY, "CLIENTID_BUSY" }, \
-		{ NFS4ERR_COMPLETE_ALREADY, "COMPLETE_ALREADY" }, \
-		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, \
-			"CONN_NOT_BOUND_TO_SESSION" }, \
-		{ NFS4ERR_DEADLOCK, "DEADLOCK" }, \
-		{ NFS4ERR_DEADSESSION, "DEAD_SESSION" }, \
-		{ NFS4ERR_DELAY, "DELAY" }, \
-		{ NFS4ERR_DELEG_ALREADY_WANTED, \
-			"DELEG_ALREADY_WANTED" }, \
-		{ NFS4ERR_DELEG_REVOKED, "DELEG_REVOKED" }, \
-		{ NFS4ERR_DENIED, "DENIED" }, \
-		{ NFS4ERR_DIRDELEG_UNAVAIL, "DIRDELEG_UNAVAIL" }, \
-		{ NFS4ERR_DQUOT, "DQUOT" }, \
-		{ NFS4ERR_ENCR_ALG_UNSUPP, "ENCR_ALG_UNSUPP" }, \
-		{ NFS4ERR_EXIST, "EXIST" }, \
-		{ NFS4ERR_EXPIRED, "EXPIRED" }, \
-		{ NFS4ERR_FBIG, "FBIG" }, \
-		{ NFS4ERR_FHEXPIRED, "FHEXPIRED" }, \
-		{ NFS4ERR_FILE_OPEN, "FILE_OPEN" }, \
-		{ NFS4ERR_GRACE, "GRACE" }, \
-		{ NFS4ERR_HASH_ALG_UNSUPP, "HASH_ALG_UNSUPP" }, \
-		{ NFS4ERR_INVAL, "INVAL" }, \
-		{ NFS4ERR_IO, "IO" }, \
-		{ NFS4ERR_ISDIR, "ISDIR" }, \
-		{ NFS4ERR_LAYOUTTRYLATER, "LAYOUTTRYLATER" }, \
-		{ NFS4ERR_LAYOUTUNAVAILABLE, "LAYOUTUNAVAILABLE" }, \
-		{ NFS4ERR_LEASE_MOVED, "LEASE_MOVED" }, \
-		{ NFS4ERR_LOCKED, "LOCKED" }, \
-		{ NFS4ERR_LOCKS_HELD, "LOCKS_HELD" }, \
-		{ NFS4ERR_LOCK_RANGE, "LOCK_RANGE" }, \
-		{ NFS4ERR_MINOR_VERS_MISMATCH, "MINOR_VERS_MISMATCH" }, \
-		{ NFS4ERR_MLINK, "MLINK" }, \
-		{ NFS4ERR_MOVED, "MOVED" }, \
-		{ NFS4ERR_NAMETOOLONG, "NAMETOOLONG" }, \
-		{ NFS4ERR_NOENT, "NOENT" }, \
-		{ NFS4ERR_NOFILEHANDLE, "NOFILEHANDLE" }, \
-		{ NFS4ERR_NOMATCHING_LAYOUT, "NOMATCHING_LAYOUT" }, \
-		{ NFS4ERR_NOSPC, "NOSPC" }, \
-		{ NFS4ERR_NOTDIR, "NOTDIR" }, \
-		{ NFS4ERR_NOTEMPTY, "NOTEMPTY" }, \
-		{ NFS4ERR_NOTSUPP, "NOTSUPP" }, \
-		{ NFS4ERR_NOT_ONLY_OP, "NOT_ONLY_OP" }, \
-		{ NFS4ERR_NOT_SAME, "NOT_SAME" }, \
-		{ NFS4ERR_NO_GRACE, "NO_GRACE" }, \
-		{ NFS4ERR_NXIO, "NXIO" }, \
-		{ NFS4ERR_OLD_STATEID, "OLD_STATEID" }, \
-		{ NFS4ERR_OPENMODE, "OPENMODE" }, \
-		{ NFS4ERR_OP_ILLEGAL, "OP_ILLEGAL" }, \
-		{ NFS4ERR_OP_NOT_IN_SESSION, "OP_NOT_IN_SESSION" }, \
-		{ NFS4ERR_PERM, "PERM" }, \
-		{ NFS4ERR_PNFS_IO_HOLE, "PNFS_IO_HOLE" }, \
-		{ NFS4ERR_PNFS_NO_LAYOUT, "PNFS_NO_LAYOUT" }, \
-		{ NFS4ERR_RECALLCONFLICT, "RECALLCONFLICT" }, \
-		{ NFS4ERR_RECLAIM_BAD, "RECLAIM_BAD" }, \
-		{ NFS4ERR_RECLAIM_CONFLICT, "RECLAIM_CONFLICT" }, \
-		{ NFS4ERR_REJECT_DELEG, "REJECT_DELEG" }, \
-		{ NFS4ERR_REP_TOO_BIG, "REP_TOO_BIG" }, \
-		{ NFS4ERR_REP_TOO_BIG_TO_CACHE, \
-			"REP_TOO_BIG_TO_CACHE" }, \
-		{ NFS4ERR_REQ_TOO_BIG, "REQ_TOO_BIG" }, \
-		{ NFS4ERR_RESOURCE, "RESOURCE" }, \
-		{ NFS4ERR_RESTOREFH, "RESTOREFH" }, \
-		{ NFS4ERR_RETRY_UNCACHED_REP, "RETRY_UNCACHED_REP" }, \
-		{ NFS4ERR_RETURNCONFLICT, "RETURNCONFLICT" }, \
-		{ NFS4ERR_ROFS, "ROFS" }, \
-		{ NFS4ERR_SAME, "SAME" }, \
-		{ NFS4ERR_SHARE_DENIED, "SHARE_DENIED" }, \
-		{ NFS4ERR_SEQUENCE_POS, "SEQUENCE_POS" }, \
-		{ NFS4ERR_SEQ_FALSE_RETRY, "SEQ_FALSE_RETRY" }, \
-		{ NFS4ERR_SEQ_MISORDERED, "SEQ_MISORDERED" }, \
-		{ NFS4ERR_SERVERFAULT, "SERVERFAULT" }, \
-		{ NFS4ERR_STALE, "STALE" }, \
-		{ NFS4ERR_STALE_CLIENTID, "STALE_CLIENTID" }, \
-		{ NFS4ERR_STALE_STATEID, "STALE_STATEID" }, \
-		{ NFS4ERR_SYMLINK, "SYMLINK" }, \
-		{ NFS4ERR_TOOSMALL, "TOOSMALL" }, \
-		{ NFS4ERR_TOO_MANY_OPS, "TOO_MANY_OPS" }, \
-		{ NFS4ERR_UNKNOWN_LAYOUTTYPE, "UNKNOWN_LAYOUTTYPE" }, \
-		{ NFS4ERR_UNSAFE_COMPOUND, "UNSAFE_COMPOUND" }, \
-		{ NFS4ERR_WRONGSEC, "WRONGSEC" }, \
-		{ NFS4ERR_WRONG_CRED, "WRONG_CRED" }, \
-		{ NFS4ERR_WRONG_TYPE, "WRONG_TYPE" }, \
-		{ NFS4ERR_XDEV, "XDEV" }, \
-		/* ***** Internal to Linux NFS client ***** */ \
-		{ NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
-		{ NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
+#include <trace/events/nfs.h>
 
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
@@ -354,7 +52,7 @@ DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_printk(
 			"error=%ld (%s) dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__get_str(dstaddr)
 		)
 );
@@ -378,29 +76,6 @@ DEFINE_NFS4_CLIENTID_EVENT(nfs4_bind_conn_to_session);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_sequence);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_reclaim_complete);
 
-#define show_nfs4_sequence_status_flags(status) \
-	__print_flags((unsigned long)status, "|", \
-		{ SEQ4_STATUS_CB_PATH_DOWN, "CB_PATH_DOWN" }, \
-		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING, \
-			"CB_GSS_CONTEXTS_EXPIRING" }, \
-		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED, \
-			"CB_GSS_CONTEXTS_EXPIRED" }, \
-		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, \
-			"EXPIRED_ALL_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, \
-			"EXPIRED_SOME_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_ADMIN_STATE_REVOKED, \
-			"ADMIN_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	 \
-			"RECALLABLE_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_LEASE_MOVED, "LEASE_MOVED" }, \
-		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED, \
-			"RESTART_RECLAIM_NEEDED" }, \
-		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION, \
-			"CB_PATH_DOWN_SESSION" }, \
-		{ SEQ4_STATUS_BACKCHANNEL_FAULT, \
-			"BACKCHANNEL_FAULT" })
-
 TRACE_EVENT(nfs4_sequence_done,
 		TP_PROTO(
 			const struct nfs4_session *session,
@@ -414,7 +89,7 @@ TRACE_EVENT(nfs4_sequence_done,
 			__field(unsigned int, seq_nr)
 			__field(unsigned int, highest_slotid)
 			__field(unsigned int, target_highest_slotid)
-			__field(unsigned int, status_flags)
+			__field(unsigned long, status_flags)
 			__field(unsigned long, error)
 		),
 
@@ -433,16 +108,16 @@ TRACE_EVENT(nfs4_sequence_done,
 		TP_printk(
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u target_highest_slotid=%u "
-			"status_flags=%u (%s)",
+			"status_flags=0x%lx (%s)",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
 			__entry->seq_nr,
 			__entry->highest_slotid,
 			__entry->target_highest_slotid,
 			__entry->status_flags,
-			show_nfs4_sequence_status_flags(__entry->status_flags)
+			show_nfs4_seq4_status(__entry->status_flags)
 		)
 );
 
@@ -479,7 +154,7 @@ TRACE_EVENT(nfs4_cb_sequence,
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
 			__entry->seq_nr,
@@ -516,7 +191,7 @@ TRACE_EVENT(nfs4_cb_seqid_err,
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
 			__entry->seq_nr,
@@ -650,7 +325,7 @@ TRACE_EVENT(nfs4_state_mgr_failed,
 			"hostname=%s clp state=%s error=%ld (%s) section=%s",
 			__get_str(hostname),
 			show_nfs4_clp_state(__entry->state), -__entry->error,
-			show_nfsv4_errors(__entry->error), __get_str(section)
+			show_nfs4_status(__entry->error), __get_str(section)
 
 		)
 )
@@ -686,7 +361,7 @@ TRACE_EVENT(nfs4_xdr_status,
 		TP_printk(
 			"task:%u@%d xid=0x%08x error=%ld (%s) operation=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
-			-__entry->error, show_nfsv4_errors(__entry->error),
+			-__entry->error, show_nfs4_status(__entry->error),
 			__entry->op
 		)
 );
@@ -791,7 +466,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 			"name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
 			"openstateid=%d:0x%08x",
 			 -__entry->error,
-			 show_nfsv4_errors(__entry->error),
+			 show_nfs4_status(__entry->error),
 			 __entry->flags,
 			 show_fcntl_open_flags(__entry->flags),
 			 show_fmode_flags(__entry->fmode),
@@ -895,7 +570,7 @@ TRACE_EVENT(nfs4_close,
 			"error=%ld (%s) fmode=%s fileid=%02x:%02x:%llu "
 			"fhandle=0x%08x openstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->fmode ?  show_fmode_flags(__entry->fmode) :
 					  "closed",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -950,7 +625,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			show_fcntl_cmd(__entry->cmd),
 			show_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
@@ -1026,7 +701,7 @@ TRACE_EVENT(nfs4_set_lock,
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x lockstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			show_fcntl_cmd(__entry->cmd),
 			show_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
@@ -1192,7 +867,7 @@ TRACE_EVENT(nfs4_delegreturn_exit,
 			"error=%ld (%s) dev=%02x:%02x fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			__entry->fhandle,
 			__entry->stateid_seq, __entry->stateid_hash
@@ -1235,7 +910,7 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1282,7 +957,7 @@ DECLARE_EVENT_CLASS(nfs4_lookup_event,
 		TP_printk(
 			"error=%ld (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -1329,7 +1004,7 @@ TRACE_EVENT(nfs4_lookupp,
 		TP_printk(
 			"error=%ld (%s) inode=%02x:%02x:%llu",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->ino
 		)
@@ -1368,7 +1043,7 @@ TRACE_EVENT(nfs4_rename,
 			"error=%ld (%s) oldname=%02x:%02x:%llu/%s "
 			"newname=%02x:%02x:%llu/%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->olddir,
 			__get_str(oldname),
@@ -1403,7 +1078,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_event,
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle
@@ -1461,7 +1136,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1513,7 +1188,7 @@ DECLARE_EVENT_CLASS(nfs4_getattr_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"valid=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1569,7 +1244,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1630,7 +1305,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1679,7 +1354,7 @@ DECLARE_EVENT_CLASS(nfs4_idmap_event,
 
 		TP_printk(
 			"error=%ld (%s) id=%u name=%s",
-			-__entry->error, show_nfsv4_errors(__entry->error),
+			-__entry->error, show_nfs4_status(__entry->error),
 			__entry->id,
 			__get_str(name)
 		)
@@ -1757,7 +1432,7 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			"offset=%lld count=%u res=%u stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1831,7 +1506,7 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			"offset=%lld count=%u res=%u stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1895,7 +1570,7 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%lld count=%u layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1980,7 +1655,7 @@ TRACE_EVENT(nfs4_layoutget,
 			"iomode=%s offset=%llu count=%llu stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -2202,7 +1877,7 @@ DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%llu count=%u stateid=%d:0x%08x dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -2258,7 +1933,7 @@ TRACE_EVENT(ff_layout_commit_error,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%llu count=%u dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 91677dea7e3d..99b8cb359c0f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -12,6 +12,7 @@
 #include <linux/iversion.h>
 
 #include <trace/events/fs.h>
+#include <trace/events/nfs.h>
 
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
@@ -134,7 +135,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"type=%u (%s) version=%llu size=%lld "
 			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s)",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -225,7 +226,7 @@ TRACE_EVENT(nfs_access_exit,
 			"type=%u (%s) version=%llu size=%lld "
 			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s) "
 			"mask=0x%x permitted=0x%x",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -311,7 +312,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 
 		TP_printk(
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_vfs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -402,7 +403,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 		TP_printk(
 			"error=%ld (%s) flags=0x%lx (%s) fmode=%s "
 			"name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_fcntl_open_flags(__entry->flags),
 			show_fmode_flags(__entry->fmode),
@@ -473,7 +474,7 @@ TRACE_EVENT(nfs_create_exit,
 
 		TP_printk(
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -543,7 +544,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event_done,
 
 		TP_printk(
 			"error=%ld (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -633,7 +634,7 @@ TRACE_EVENT(nfs_link_exit,
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			__entry->fileid,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -720,7 +721,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 		TP_printk(
 			"error=%ld (%s) old_name=%02x:%02x:%llu/%s "
 			"new_name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->old_dir,
 			__get_str(old_name),
@@ -774,7 +775,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 
 		TP_printk(
 			"error=%ld (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -957,16 +958,6 @@ TRACE_EVENT(nfs_pgio_error,
 	)
 );
 
-TRACE_DEFINE_ENUM(NFS_UNSTABLE);
-TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
-TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
-
-#define nfs_show_stable(stable) \
-	__print_symbolic(stable, \
-			{ NFS_UNSTABLE, "UNSTABLE" }, \
-			{ NFS_DATA_SYNC, "DATA_SYNC" }, \
-			{ NFS_FILE_SYNC, "FILE_SYNC" })
-
 TRACE_EVENT(nfs_initiate_write,
 		TP_PROTO(
 			const struct nfs_pgio_header *hdr
@@ -980,7 +971,7 @@ TRACE_EVENT(nfs_initiate_write,
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(u32, count)
-			__field(enum nfs3_stable_how, stable)
+			__field(unsigned long, stable)
 		),
 
 		TP_fast_assign(
@@ -1004,7 +995,7 @@ TRACE_EVENT(nfs_initiate_write,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->count,
-			nfs_show_stable(__entry->stable)
+			show_nfs_stable_how(__entry->stable)
 		)
 );
 
@@ -1024,7 +1015,7 @@ TRACE_EVENT(nfs_writeback_done,
 			__field(u32, arg_count)
 			__field(u32, res_count)
 			__field(int, status)
-			__field(enum nfs3_stable_how, stable)
+			__field(unsigned long, stable)
 			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
 
@@ -1057,7 +1048,7 @@ TRACE_EVENT(nfs_writeback_done,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->arg_count,
 			__entry->res_count, __entry->status,
-			nfs_show_stable(__entry->stable),
+			show_nfs_stable_how(__entry->stable),
 			__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
 		)
 );
@@ -1159,7 +1150,7 @@ TRACE_EVENT(nfs_commit_done,
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(int, status)
-			__field(enum nfs3_stable_how, stable)
+			__field(unsigned long, stable)
 			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
 
@@ -1188,7 +1179,7 @@ TRACE_EVENT(nfs_commit_done,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->status,
-			nfs_show_stable(__entry->stable),
+			show_nfs_stable_how(__entry->stable),
 			__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
 		)
 );
@@ -1226,76 +1217,6 @@ TRACE_EVENT(nfs_fh_to_dentry,
 		)
 );
 
-TRACE_DEFINE_ENUM(NFS_OK);
-TRACE_DEFINE_ENUM(NFSERR_PERM);
-TRACE_DEFINE_ENUM(NFSERR_NOENT);
-TRACE_DEFINE_ENUM(NFSERR_IO);
-TRACE_DEFINE_ENUM(NFSERR_NXIO);
-TRACE_DEFINE_ENUM(ECHILD);
-TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
-TRACE_DEFINE_ENUM(NFSERR_ACCES);
-TRACE_DEFINE_ENUM(NFSERR_EXIST);
-TRACE_DEFINE_ENUM(NFSERR_XDEV);
-TRACE_DEFINE_ENUM(NFSERR_NODEV);
-TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
-TRACE_DEFINE_ENUM(NFSERR_ISDIR);
-TRACE_DEFINE_ENUM(NFSERR_INVAL);
-TRACE_DEFINE_ENUM(NFSERR_FBIG);
-TRACE_DEFINE_ENUM(NFSERR_NOSPC);
-TRACE_DEFINE_ENUM(NFSERR_ROFS);
-TRACE_DEFINE_ENUM(NFSERR_MLINK);
-TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
-TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
-TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
-TRACE_DEFINE_ENUM(NFSERR_DQUOT);
-TRACE_DEFINE_ENUM(NFSERR_STALE);
-TRACE_DEFINE_ENUM(NFSERR_REMOTE);
-TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
-TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
-TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
-TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
-TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
-TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
-TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
-TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
-TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
-
-#define nfs_show_status(x) \
-	__print_symbolic(x, \
-			{ NFS_OK, "OK" }, \
-			{ NFSERR_PERM, "PERM" }, \
-			{ NFSERR_NOENT, "NOENT" }, \
-			{ NFSERR_IO, "IO" }, \
-			{ NFSERR_NXIO, "NXIO" }, \
-			{ ECHILD, "CHILD" }, \
-			{ NFSERR_EAGAIN, "AGAIN" }, \
-			{ NFSERR_ACCES, "ACCES" }, \
-			{ NFSERR_EXIST, "EXIST" }, \
-			{ NFSERR_XDEV, "XDEV" }, \
-			{ NFSERR_NODEV, "NODEV" }, \
-			{ NFSERR_NOTDIR, "NOTDIR" }, \
-			{ NFSERR_ISDIR, "ISDIR" }, \
-			{ NFSERR_INVAL, "INVAL" }, \
-			{ NFSERR_FBIG, "FBIG" }, \
-			{ NFSERR_NOSPC, "NOSPC" }, \
-			{ NFSERR_ROFS, "ROFS" }, \
-			{ NFSERR_MLINK, "MLINK" }, \
-			{ NFSERR_OPNOTSUPP, "OPNOTSUPP" }, \
-			{ NFSERR_NAMETOOLONG, "NAMETOOLONG" }, \
-			{ NFSERR_NOTEMPTY, "NOTEMPTY" }, \
-			{ NFSERR_DQUOT, "DQUOT" }, \
-			{ NFSERR_STALE, "STALE" }, \
-			{ NFSERR_REMOTE, "REMOTE" }, \
-			{ NFSERR_WFLUSH, "WFLUSH" }, \
-			{ NFSERR_BADHANDLE, "BADHANDLE" }, \
-			{ NFSERR_NOT_SYNC, "NOTSYNC" }, \
-			{ NFSERR_BAD_COOKIE, "BADCOOKIE" }, \
-			{ NFSERR_NOTSUPP, "NOTSUPP" }, \
-			{ NFSERR_TOOSMALL, "TOOSMALL" }, \
-			{ NFSERR_SERVERFAULT, "REMOTEIO" }, \
-			{ NFSERR_BADTYPE, "BADTYPE" }, \
-			{ NFSERR_JUKEBOX, "JUKEBOX" })
-
 TRACE_EVENT(nfs_xdr_status,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
@@ -1335,7 +1256,7 @@ TRACE_EVENT(nfs_xdr_status,
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__get_str(program), __entry->version,
 			__get_str(procedure), -__entry->error,
-			nfs_show_status(__entry->error)
+			show_nfs_status(__entry->error)
 		)
 );
 
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 2661c44c62db..bd4b397b98d3 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -80,10 +80,6 @@ enum pnfs_try_status {
 	PNFS_TRY_AGAIN     = 2,
 };
 
-/* error codes for internal use */
-#define NFS4ERR_RESET_TO_MDS   12001
-#define NFS4ERR_RESET_TO_PNFS  12002
-
 #ifdef CONFIG_NFS_V4_1
 
 #define LAYOUT_NFSV4_1_MODULE_PREFIX "nfs-layouttype4"
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1861db1bdc67..1909fc57435f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -9,6 +9,7 @@
 #define _NFSD_TRACE_H
 
 #include <linux/tracepoint.h>
+
 #include "export.h"
 #include "nfsfh.h"
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index b8360be141da..985fb3def3df 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -292,6 +292,10 @@ enum nfsstat4 {
 	NFS4ERR_XATTR2BIG      = 10096,
 };
 
+/* error codes for internal client use */
+#define NFS4ERR_RESET_TO_MDS   12001
+#define NFS4ERR_RESET_TO_PNFS  12002
+
 static inline bool seqid_mutating_err(u32 err)
 {
 	/* See RFC 7530, section 9.1.7 */
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
new file mode 100644
index 000000000000..8e3de3b421f4
--- /dev/null
+++ b/include/trace/events/nfs.h
@@ -0,0 +1,361 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for NFS protocol elements
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/nfs4.h>
+#include <uapi/linux/nfs.h>
+
+TRACE_DEFINE_ENUM(NFS_OK);
+TRACE_DEFINE_ENUM(NFSERR_PERM);
+TRACE_DEFINE_ENUM(NFSERR_NOENT);
+TRACE_DEFINE_ENUM(NFSERR_IO);
+TRACE_DEFINE_ENUM(NFSERR_NXIO);
+TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
+TRACE_DEFINE_ENUM(NFSERR_ACCES);
+TRACE_DEFINE_ENUM(NFSERR_EXIST);
+TRACE_DEFINE_ENUM(NFSERR_XDEV);
+TRACE_DEFINE_ENUM(NFSERR_NODEV);
+TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
+TRACE_DEFINE_ENUM(NFSERR_ISDIR);
+TRACE_DEFINE_ENUM(NFSERR_INVAL);
+TRACE_DEFINE_ENUM(NFSERR_FBIG);
+TRACE_DEFINE_ENUM(NFSERR_NOSPC);
+TRACE_DEFINE_ENUM(NFSERR_ROFS);
+TRACE_DEFINE_ENUM(NFSERR_MLINK);
+TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
+TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
+TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
+TRACE_DEFINE_ENUM(NFSERR_DQUOT);
+TRACE_DEFINE_ENUM(NFSERR_STALE);
+TRACE_DEFINE_ENUM(NFSERR_REMOTE);
+TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
+TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
+TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
+TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
+TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
+TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
+TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
+TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
+TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
+
+#define show_nfs_status(x) \
+	__print_symbolic(x, \
+		{ NFS_OK,			"OK" }, \
+		{ NFSERR_PERM,			"PERM" }, \
+		{ NFSERR_NOENT,			"NOENT" }, \
+		{ NFSERR_IO,			"IO" }, \
+		{ NFSERR_NXIO,			"NXIO" }, \
+		{ ECHILD,			"CHILD" }, \
+		{ NFSERR_EAGAIN,		"AGAIN" }, \
+		{ NFSERR_ACCES,			"ACCES" }, \
+		{ NFSERR_EXIST,			"EXIST" }, \
+		{ NFSERR_XDEV,			"XDEV" }, \
+		{ NFSERR_NODEV,			"NODEV" }, \
+		{ NFSERR_NOTDIR,		"NOTDIR" }, \
+		{ NFSERR_ISDIR,			"ISDIR" }, \
+		{ NFSERR_INVAL,			"INVAL" }, \
+		{ NFSERR_FBIG,			"FBIG" }, \
+		{ NFSERR_NOSPC,			"NOSPC" }, \
+		{ NFSERR_ROFS,			"ROFS" }, \
+		{ NFSERR_MLINK,			"MLINK" }, \
+		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
+		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
+		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
+		{ NFSERR_DQUOT,			"DQUOT" }, \
+		{ NFSERR_STALE,			"STALE" }, \
+		{ NFSERR_REMOTE,		"REMOTE" }, \
+		{ NFSERR_WFLUSH,		"WFLUSH" }, \
+		{ NFSERR_BADHANDLE,		"BADHANDLE" }, \
+		{ NFSERR_NOT_SYNC,		"NOTSYNC" }, \
+		{ NFSERR_BAD_COOKIE,		"BADCOOKIE" }, \
+		{ NFSERR_NOTSUPP,		"NOTSUPP" }, \
+		{ NFSERR_TOOSMALL,		"TOOSMALL" }, \
+		{ NFSERR_SERVERFAULT,		"REMOTEIO" }, \
+		{ NFSERR_BADTYPE,		"BADTYPE" }, \
+		{ NFSERR_JUKEBOX,		"JUKEBOX" })
+
+TRACE_DEFINE_ENUM(NFS4_OK);
+TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
+TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
+TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
+TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
+TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
+TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
+TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
+TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
+TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
+TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
+TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
+TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
+TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
+TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
+TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
+TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
+TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
+TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
+TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
+TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
+TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
+TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
+TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
+TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
+TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
+TRACE_DEFINE_ENUM(NFS4ERR_IO);
+TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
+TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
+TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
+TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
+TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
+TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
+TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
+TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
+TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
+TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
+TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
+TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
+TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
+TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
+TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
+TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
+TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_PERM);
+TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
+TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
+TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
+TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
+TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
+TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
+TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
+TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
+TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
+TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
+TRACE_DEFINE_ENUM(NFS4ERR_SAME);
+TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
+TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
+TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
+TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
+TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
+
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
+
+#define show_nfs4_status(x) \
+	__print_symbolic(x, \
+		{ NFS4_OK,			"OK" }, \
+		{ EPERM,			"EPERM" }, \
+		{ ENOENT,			"ENOENT" }, \
+		{ EIO,				"EIO" }, \
+		{ ENXIO,			"ENXIO" }, \
+		{ EACCES,			"EACCES" }, \
+		{ EEXIST,			"EEXIST" }, \
+		{ EXDEV,			"EXDEV" }, \
+		{ ENOTDIR,			"ENOTDIR" }, \
+		{ EISDIR,			"EISDIR" }, \
+		{ EFBIG,			"EFBIG" }, \
+		{ ENOSPC,			"ENOSPC" }, \
+		{ EROFS,			"EROFS" }, \
+		{ EMLINK,			"EMLINK" }, \
+		{ ENAMETOOLONG,			"ENAMETOOLONG" }, \
+		{ ENOTEMPTY,			"ENOTEMPTY" }, \
+		{ EDQUOT,			"EDQUOT" }, \
+		{ ESTALE,			"ESTALE" }, \
+		{ EBADHANDLE,			"EBADHANDLE" }, \
+		{ EBADCOOKIE,			"EBADCOOKIE" }, \
+		{ ENOTSUPP,			"ENOTSUPP" }, \
+		{ ETOOSMALL,			"ETOOSMALL" }, \
+		{ EREMOTEIO,			"EREMOTEIO" }, \
+		{ EBADTYPE,			"EBADTYPE" }, \
+		{ EAGAIN,			"EAGAIN" }, \
+		{ ELOOP,			"ELOOP" }, \
+		{ EOPNOTSUPP,			"EOPNOTSUPP" }, \
+		{ EDEADLK,			"EDEADLK" }, \
+		{ ENOMEM,			"ENOMEM" }, \
+		{ EKEYEXPIRED,			"EKEYEXPIRED" }, \
+		{ ETIMEDOUT,			"ETIMEDOUT" }, \
+		{ ERESTARTSYS,			"ERESTARTSYS" }, \
+		{ ECONNREFUSED,			"ECONNREFUSED" }, \
+		{ ECONNRESET,			"ECONNRESET" }, \
+		{ ENETUNREACH,			"ENETUNREACH" }, \
+		{ EHOSTUNREACH,			"EHOSTUNREACH" }, \
+		{ EHOSTDOWN,			"EHOSTDOWN" }, \
+		{ EPIPE,			"EPIPE" }, \
+		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
+		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
+		{ NFS4ERR_ACCESS,		"ACCESS" }, \
+		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
+		{ NFS4ERR_ADMIN_REVOKED,	"ADMIN_REVOKED" }, \
+		{ NFS4ERR_BACK_CHAN_BUSY,	"BACK_CHAN_BUSY" }, \
+		{ NFS4ERR_BADCHAR,		"BADCHAR" }, \
+		{ NFS4ERR_BADHANDLE,		"BADHANDLE" }, \
+		{ NFS4ERR_BADIOMODE,		"BADIOMODE" }, \
+		{ NFS4ERR_BADLAYOUT,		"BADLAYOUT" }, \
+		{ NFS4ERR_BADLABEL,		"BADLABEL" }, \
+		{ NFS4ERR_BADNAME,		"BADNAME" }, \
+		{ NFS4ERR_BADOWNER,		"BADOWNER" }, \
+		{ NFS4ERR_BADSESSION,		"BADSESSION" }, \
+		{ NFS4ERR_BADSLOT,		"BADSLOT" }, \
+		{ NFS4ERR_BADTYPE,		"BADTYPE" }, \
+		{ NFS4ERR_BADXDR,		"BADXDR" }, \
+		{ NFS4ERR_BAD_COOKIE,		"BAD_COOKIE" }, \
+		{ NFS4ERR_BAD_HIGH_SLOT,	"BAD_HIGH_SLOT" }, \
+		{ NFS4ERR_BAD_RANGE,		"BAD_RANGE" }, \
+		{ NFS4ERR_BAD_SEQID,		"BAD_SEQID" }, \
+		{ NFS4ERR_BAD_SESSION_DIGEST,	"BAD_SESSION_DIGEST" }, \
+		{ NFS4ERR_BAD_STATEID,		"BAD_STATEID" }, \
+		{ NFS4ERR_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
+		{ NFS4ERR_CLID_INUSE,		"CLID_INUSE" }, \
+		{ NFS4ERR_CLIENTID_BUSY,	"CLIENTID_BUSY" }, \
+		{ NFS4ERR_COMPLETE_ALREADY,	"COMPLETE_ALREADY" }, \
+		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, "CONN_NOT_BOUND_TO_SESSION" }, \
+		{ NFS4ERR_DEADLOCK,		"DEADLOCK" }, \
+		{ NFS4ERR_DEADSESSION,		"DEAD_SESSION" }, \
+		{ NFS4ERR_DELAY,		"DELAY" }, \
+		{ NFS4ERR_DELEG_ALREADY_WANTED,	"DELEG_ALREADY_WANTED" }, \
+		{ NFS4ERR_DELEG_REVOKED,	"DELEG_REVOKED" }, \
+		{ NFS4ERR_DENIED,		"DENIED" }, \
+		{ NFS4ERR_DIRDELEG_UNAVAIL,	"DIRDELEG_UNAVAIL" }, \
+		{ NFS4ERR_DQUOT,		"DQUOT" }, \
+		{ NFS4ERR_ENCR_ALG_UNSUPP,	"ENCR_ALG_UNSUPP" }, \
+		{ NFS4ERR_EXIST,		"EXIST" }, \
+		{ NFS4ERR_EXPIRED,		"EXPIRED" }, \
+		{ NFS4ERR_FBIG,			"FBIG" }, \
+		{ NFS4ERR_FHEXPIRED,		"FHEXPIRED" }, \
+		{ NFS4ERR_FILE_OPEN,		"FILE_OPEN" }, \
+		{ NFS4ERR_GRACE,		"GRACE" }, \
+		{ NFS4ERR_HASH_ALG_UNSUPP,	"HASH_ALG_UNSUPP" }, \
+		{ NFS4ERR_INVAL,		"INVAL" }, \
+		{ NFS4ERR_IO,			"IO" }, \
+		{ NFS4ERR_ISDIR,		"ISDIR" }, \
+		{ NFS4ERR_LAYOUTTRYLATER,	"LAYOUTTRYLATER" }, \
+		{ NFS4ERR_LAYOUTUNAVAILABLE,	"LAYOUTUNAVAILABLE" }, \
+		{ NFS4ERR_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ NFS4ERR_LOCKED,		"LOCKED" }, \
+		{ NFS4ERR_LOCKS_HELD,		"LOCKS_HELD" }, \
+		{ NFS4ERR_LOCK_RANGE,		"LOCK_RANGE" }, \
+		{ NFS4ERR_MINOR_VERS_MISMATCH,	"MINOR_VERS_MISMATCH" }, \
+		{ NFS4ERR_MLINK,		"MLINK" }, \
+		{ NFS4ERR_MOVED,		"MOVED" }, \
+		{ NFS4ERR_NAMETOOLONG,		"NAMETOOLONG" }, \
+		{ NFS4ERR_NOENT,		"NOENT" }, \
+		{ NFS4ERR_NOFILEHANDLE,		"NOFILEHANDLE" }, \
+		{ NFS4ERR_NOMATCHING_LAYOUT,	"NOMATCHING_LAYOUT" }, \
+		{ NFS4ERR_NOSPC,		"NOSPC" }, \
+		{ NFS4ERR_NOTDIR,		"NOTDIR" }, \
+		{ NFS4ERR_NOTEMPTY,		"NOTEMPTY" }, \
+		{ NFS4ERR_NOTSUPP,		"NOTSUPP" }, \
+		{ NFS4ERR_NOT_ONLY_OP,		"NOT_ONLY_OP" }, \
+		{ NFS4ERR_NOT_SAME,		"NOT_SAME" }, \
+		{ NFS4ERR_NO_GRACE,		"NO_GRACE" }, \
+		{ NFS4ERR_NXIO,			"NXIO" }, \
+		{ NFS4ERR_OLD_STATEID,		"OLD_STATEID" }, \
+		{ NFS4ERR_OPENMODE,		"OPENMODE" }, \
+		{ NFS4ERR_OP_ILLEGAL,		"OP_ILLEGAL" }, \
+		{ NFS4ERR_OP_NOT_IN_SESSION,	"OP_NOT_IN_SESSION" }, \
+		{ NFS4ERR_PERM,			"PERM" }, \
+		{ NFS4ERR_PNFS_IO_HOLE,		"PNFS_IO_HOLE" }, \
+		{ NFS4ERR_PNFS_NO_LAYOUT,	"PNFS_NO_LAYOUT" }, \
+		{ NFS4ERR_RECALLCONFLICT,	"RECALLCONFLICT" }, \
+		{ NFS4ERR_RECLAIM_BAD,		"RECLAIM_BAD" }, \
+		{ NFS4ERR_RECLAIM_CONFLICT,	"RECLAIM_CONFLICT" }, \
+		{ NFS4ERR_REJECT_DELEG,		"REJECT_DELEG" }, \
+		{ NFS4ERR_REP_TOO_BIG,		"REP_TOO_BIG" }, \
+		{ NFS4ERR_REP_TOO_BIG_TO_CACHE,	"REP_TOO_BIG_TO_CACHE" }, \
+		{ NFS4ERR_REQ_TOO_BIG,		"REQ_TOO_BIG" }, \
+		{ NFS4ERR_RESOURCE,		"RESOURCE" }, \
+		{ NFS4ERR_RESTOREFH,		"RESTOREFH" }, \
+		{ NFS4ERR_RETRY_UNCACHED_REP,	"RETRY_UNCACHED_REP" }, \
+		{ NFS4ERR_RETURNCONFLICT,	"RETURNCONFLICT" }, \
+		{ NFS4ERR_ROFS,			"ROFS" }, \
+		{ NFS4ERR_SAME,			"SAME" }, \
+		{ NFS4ERR_SHARE_DENIED,		"SHARE_DENIED" }, \
+		{ NFS4ERR_SEQUENCE_POS,		"SEQUENCE_POS" }, \
+		{ NFS4ERR_SEQ_FALSE_RETRY,	"SEQ_FALSE_RETRY" }, \
+		{ NFS4ERR_SEQ_MISORDERED,	"SEQ_MISORDERED" }, \
+		{ NFS4ERR_SERVERFAULT,		"SERVERFAULT" }, \
+		{ NFS4ERR_STALE,		"STALE" }, \
+		{ NFS4ERR_STALE_CLIENTID,	"STALE_CLIENTID" }, \
+		{ NFS4ERR_STALE_STATEID,	"STALE_STATEID" }, \
+		{ NFS4ERR_SYMLINK,		"SYMLINK" }, \
+		{ NFS4ERR_TOOSMALL,		"TOOSMALL" }, \
+		{ NFS4ERR_TOO_MANY_OPS,		"TOO_MANY_OPS" }, \
+		{ NFS4ERR_UNKNOWN_LAYOUTTYPE,	"UNKNOWN_LAYOUTTYPE" }, \
+		{ NFS4ERR_UNSAFE_COMPOUND,	"UNSAFE_COMPOUND" }, \
+		{ NFS4ERR_WRONGSEC,		"WRONGSEC" }, \
+		{ NFS4ERR_WRONG_CRED,		"WRONG_CRED" }, \
+		{ NFS4ERR_WRONG_TYPE,		"WRONG_TYPE" }, \
+		{ NFS4ERR_XDEV,			"XDEV" }, \
+		/* ***** Internal to Linux NFS client ***** */ \
+		{ NFS4ERR_RESET_TO_MDS,		"RESET_TO_MDS" }, \
+		{ NFS4ERR_RESET_TO_PNFS,	"RESET_TO_PNFS" })
+
+TRACE_DEFINE_ENUM(NFS_UNSTABLE);
+TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
+TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
+
+#define show_nfs_stable_how(x) \
+	__print_symbolic(x, \
+			{ NFS_UNSTABLE, "UNSTABLE" }, \
+			{ NFS_DATA_SYNC, "DATA_SYNC" }, \
+			{ NFS_FILE_SYNC, "FILE_SYNC" })
+
+#define show_nfs4_seq4_status(x) \
+	__print_flags(x, "|", \
+		{ SEQ4_STATUS_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
+		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING,	"CB_GSS_CONTEXTS_EXPIRING" }, \
+		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED,	"CB_GSS_CONTEXTS_EXPIRED" }, \
+		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, "EXPIRED_ALL_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, "EXPIRED_SOME_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_ADMIN_STATE_REVOKED,	"ADMIN_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	"RECALLABLE_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
+		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
+		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })


