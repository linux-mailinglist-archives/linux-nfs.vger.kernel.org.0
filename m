Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3914A6B5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgA0PAb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:00:31 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:42564 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA0PAa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:00:30 -0500
Received: by mail-yb1-f179.google.com with SMTP id z125so2920249ybf.9
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 07:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l46+hA+YJF48dQjV9Oj6chBzCq5FvgQEXpVraEaa2oU=;
        b=bf9b8YNTC5iryyB6cx8FRi2RxqfgbKJENQEdt4IBDuFcfrU9+ZVDH8GV1Drqn+sgRp
         D9YJ/u0caJSZZ+hDDJJBJUri4LxTl1HMQW0LtlK0+jgkp9mZMwrVtMWjCDCHdhwxZfqd
         ayeHUIZs55CtNm7z2FVqxRtHlThPyqJP9psp1wS51mL77IqJ8Dq+u/P8u/ia82VIiDsY
         Hv/ZP5b1rC+GZZ2I515fFA2atIIIzQE0d+httFy95dP1eah2MEsIXqwxnGJBQTLwJzM8
         ir8HwQ13yTwE3O3JyrbNYP656oXXc5T5SqpswHPtyPAfzyYn9y/Fb2fYmUfyzfCdGM2Y
         W71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l46+hA+YJF48dQjV9Oj6chBzCq5FvgQEXpVraEaa2oU=;
        b=ix1bHC2Rv7XH7OiZ4GKNFV9grojEat3Ap2ICTG7vhSuzngDhk0YaRJE7TyZCEnRN5V
         aj/fpGOQaVzDbZ8VGtZKawPcHYBGstwyPRY5z7pDIJWKGI86rOFUAC7mM9IimMALeOQ9
         a1zvmOHDDF16fPzTb52wGZCBT2dY0mXyyR+vpE8I8rDVNvdXW9n3fyq9EuEdzTvwXlUV
         7+cDc9wya9MyWHAQqrpgZd222VOC0BuCiU2z6VxArVLFk8W3HGbqNXRzH06g4MbPDgBW
         i5QhcAgxwizHn5FZ4Y75ohsormxYRhrWne7OQO0/cpq5lM2MOF4iEEFlPZUrjyzMF2dG
         Tyww==
X-Gm-Message-State: APjAAAWsTY0IZ9+b0HNxfjYCUjHtXgT2ROF19r4oaPDmK6KnkJaXMb2i
        BNjC1+LMV5q0T5TQbXb0oA==
X-Google-Smtp-Source: APXvYqztx1znynFsIdAtj5Mjwi3MCdDVUkOhMf3cs4x0OhcQ6OL2UlUnhKyB42gSlpLnlHq6thuzzQ==
X-Received: by 2002:a25:c589:: with SMTP id v131mr13531020ybe.490.1580137228912;
        Mon, 27 Jan 2020 07:00:28 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d186sm6809096ywe.0.2020.01.27.07.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:28 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] Fix up delegation management
Date:   Mon, 27 Jan 2020 09:58:14 -0500
Message-Id: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Delegations allow the client to cache various objects aggressively,
however they can also be a source of scalability issues on the server
if not returned when not it use.
The following patchset allows the client to set a limit on the number
of delegations that it holds. Once it hits that limit, it starts to
return the delegations on close in order to avoid swamping the server
with state.

Trond Myklebust (5):
  NFSv4: nfs_inode_evict_delegation() should set
    NFS_DELEGATION_RETURNING
  NFS: Clear NFS_DELEGATION_RETURN_IF_CLOSED when the delegation is
    returned
  NFSv4: Try to return the delegation immediately when marked for return
    on close
  NFSv4: Add accounting for the number of active delegations held
  NFSv4: Limit the total number of cached delegations

 fs/nfs/delegation.c | 80 +++++++++++++++++++++++++++++++++++++--------
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4state.c  |  1 +
 3 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.24.1

