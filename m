Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3348443E438
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhJ1Ov3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 10:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbhJ1OvX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 10:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635432535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UIYbOziW51u2byUvGVtTIrupxRtN6iTZkPJbMBaXmdE=;
        b=ToVdKz+Dt8Fe5GotHTD3UNz7+wM8d6v+XZUfMjZ58gv3UEAPPzF4X0CLO/BoHOH3XBnwhi
        ZM3PmXraHNSsq9h5UakMxF3E2Ph9qmkMQE699nYNmh98lZ3u11DMqGNnfhOpexPuatDF1u
        ScaX7XG2773KHh8faswUo6W1a46Tncw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-aEjvHmGHPNm6g_6B-47IfA-1; Thu, 28 Oct 2021 10:48:53 -0400
X-MC-Unique: aEjvHmGHPNm6g_6B-47IfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF4B18735C1
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:48:52 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-186.phx2.redhat.com [10.3.114.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7558919729
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:48:52 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/1] Enable inter server to server copies on a export
Date:   Thu, 28 Oct 2021 10:48:50 -0400
Message-Id: <20211028144851.644018-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This kernel patch and an upcoming nfs-utils patch
adds a new export option 's2sc' which will allow
inter server to server copies.

The option needs to be set on the destination server.

The idea behind the option is to allow admins the 
ability to control which export can do these 
types of copies.

Steve Dickson (1):
  nfsd4_copy: Adds the ability to do inter server to server on an export

 fs/nfsd/nfs4proc.c               | 3 ++-
 include/uapi/linux/nfsd/export.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.31.1

