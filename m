Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9121BE96
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGJUhE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 16:37:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727086AbgGJUhE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 16:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hT08BMjw/4UeT3A1ba84465T9AIXzKJxlIjglRTTEsE=;
        b=daOeRwg3mY1+ofoNfOwaReUc437Im4bZil3qHmyjei7jvolJRp3erp9OEsQmWnso7GZWVT
        D8F+JVoucD3YsZaZ/Sr4BHzJS2PKdDRxiUm+4vQB0xor1DPU4L0VFQXv0Mbeu1+gNkKXhy
        K3Qjuen6L5d3ETKhpo1oFW6xFNKgwGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-FB3wo0E7O22aNKNhqujfpA-1; Fri, 10 Jul 2020 16:37:02 -0400
X-MC-Unique: FB3wo0E7O22aNKNhqujfpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42CAC1083
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-242.rdu2.redhat.com [10.10.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 268107EF99;
        Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 5ABB51A0245; Fri, 10 Jul 2020 16:37:00 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 0/5] nfsdcld: Fix a number of Coverity Scan
Date:   Fri, 10 Jul 2020 16:36:55 -0400
Message-Id: <20200710203700.2546112-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches fix some errors in nfsdcld flagged by the Coverity scan
software.

Scott Mayhew (5):
  nfsdcld: Fix a few Coverity Scan RESOURCE_LEAK errors
  nfsdcld: Fix a few Coverity Scan TOCTOU errors
  nfsdcld: Fix a few Coverity Scan STRING_NULL errors
  nfsdcld: Fix a few Coverity Scan CLANG_WARNING errors
  nfsdcld: Fix a few Coverity Scan CHECKED_RETURN errors.

 utils/nfsdcld/legacy.c  | 38 ++++++++++++--------------------------
 utils/nfsdcld/nfsdcld.c |  7 +++++--
 utils/nfsdcld/sqlite.c  |  5 +++--
 3 files changed, 20 insertions(+), 30 deletions(-)

-- 
2.25.4

