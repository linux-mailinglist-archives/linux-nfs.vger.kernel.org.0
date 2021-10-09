Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF256427A1D
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Oct 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbhJIM3b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Oct 2021 08:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232926AbhJIM3b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Oct 2021 08:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633782454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Krhw/lmep+HEAZsQDm6kMj/I38/LCH//uF3qblz0H9M=;
        b=CJr/OSwMH1LkeMuS0KhIXTT3GgcliLU18ObUgF9NUlnBHmuFG8evWG9KEB/fO3o2/NnRwn
        q486/PG+Iyu7vkZBm0iJbwGcI/qmZe0Ow11uWkRuiy/ytxVyLNqoyE7PEB0jKTqDpiUPQz
        9aLnO5AuEqfr6hbrhzhii9fMapynC04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ysIg-r4aMfePI9kAbwscEw-1; Sat, 09 Oct 2021 08:27:26 -0400
X-MC-Unique: ysIg-r4aMfePI9kAbwscEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62DC8015C7;
        Sat,  9 Oct 2021 12:27:25 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14FEF60C05;
        Sat,  9 Oct 2021 12:27:22 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/1] Update nfsiostat to display readahead counts
Date:   Sat,  9 Oct 2021 08:27:20 -0400
Message-Id: <1633782441-17839-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Changes from v1
* Move parsing of 'statsver' into parse routine
* Simplify logic

Dave Wysochanski (1):
  nfsiostat: Handle both readahead counts for statsver >= 1.2

 tools/nfs-iostat/nfs-iostat.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.1

