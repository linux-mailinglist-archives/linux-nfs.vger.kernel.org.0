Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5063386B5F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhEQUbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 16:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234249AbhEQUbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 16:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621283389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=h+GTfhmeBgDj/UpoAJ2mhJrbp6L76sYhn23+JMEI2wY=;
        b=VTbRrxQVjsg5DV/HTxP3ttW/JFwAJyk0u1CQEY3TmwU5R8+qOytiysJ1NQurxLuFnT8wxu
        W9k4uFmY5nOWMV0C3pMskFXrEEJUfI3Rsijbek1P8dZX4iEzsY4xt58ANJu9RcUofJGCKz
        GcM0dNTTyK0plSJjzdb8lSxg8wt4wPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-iKV66ooIMomviw9u-qPiyw-1; Mon, 17 May 2021 16:29:48 -0400
X-MC-Unique: iKV66ooIMomviw9u-qPiyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65689803620;
        Mon, 17 May 2021 20:29:47 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-119-128.rdu2.redhat.com [10.10.119.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 042735D6D7;
        Mon, 17 May 2021 20:29:46 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/1] Add callback address and state to nfsd4 client info
Date:   Mon, 17 May 2021 16:29:44 -0400
Message-Id: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For troubleshooting, it is useful to show the callback address and state
inside the nfsd4 client info.  Note the callback address and state is
also available via trace events, so use a common function and output.

Changes since v1:
- fix indents, run checkpatch (Chuck L)
- create cb_state2str() inside fs/nfsd/trace.c (Bruce F)
- rebase on Chuck v3 nfsd patches and test

Dave Wysochanski (1):
  nfsd4: Expose the callback address and state of each NFS4 client

 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.c     | 15 +++++++++++++++
 fs/nfsd/trace.h     |  9 ++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
1.8.3.1

