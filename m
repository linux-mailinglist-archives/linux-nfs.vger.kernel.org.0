Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537DC153269
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgBEOCT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 09:02:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728018AbgBEOCT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 09:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580911338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5lRmpGvzisEa2DVVVMJu9Kts+4NR5hx+8FbYl2A/2kY=;
        b=SBY1n15fbJAfx/GfYXkm8YYZokLW+6fV4VGhcFMDKJFReahZehsItA5vGoSh6+nvbh24iM
        ZX93t//F6gi+MMqqxzgVobNN/Mw6RuEw0OHE8Qh4t6v6qInqasPpcX5SqwssyDziZPv9aQ
        pGyqKAHKkUWSwfE+w3VJofnHvHmDdPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-HewY4UGsMI-aa4hRzgo-0g-1; Wed, 05 Feb 2020 09:01:58 -0500
X-MC-Unique: HewY4UGsMI-aa4hRzgo-0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3ECBDBA3;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 644475DA7B;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E4BEC10C1FC7; Wed,  5 Feb 2020 09:01:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Dentry revalidation fixups
Date:   Wed,  5 Feb 2020 09:01:51 -0500
Message-Id: <cover.1580910601.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond's helped me out with my dentry revalidation woes.  The first two
patches fix races that may occur, and the third patch fixes a problem I'v=
e
tried to solve in the past where the client can decide not to revalidate =
a
dentry because we hold a delegation, but really it should be revalidated
because we cached that dentry before the delegation.  The most recent
attempt and discussion of that problem was here:

https://lore.kernel.org/linux-nfs/bcb5ffd399c4434730e6d100a5b7cae5e207244=
e.1580225161.git.bcodding@redhat.com/#t

That patch went to linux-next and should be dropped.  Anna, it looks like
you've already dropped it, but I just wanted to make a note of it.

Thanks for all the help, Trond!

Trond Myklebust (3):
  NFS: Fix up directory verifier races
  NFSv4: Fix races between open and dentry revalidation
  NFSv4: Fix revalidation of dentries with delegations

 fs/nfs/delegation.c    |   6 ++
 fs/nfs/dir.c           | 124 +++++++++++++++++++++++++++++++++++++----
 fs/nfs/inode.c         |   1 +
 fs/nfs/nfs4file.c      |   1 -
 fs/nfs/nfs4proc.c      |  18 +++++-
 include/linux/nfs_fs.h |  26 ++-------
 6 files changed, 143 insertions(+), 33 deletions(-)

--=20
2.20.1

