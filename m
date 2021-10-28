Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97B343E47E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 16:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhJ1PCM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 11:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhJ1PCL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 11:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635433183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8evBocWGMbenIqU8miIf/AiquULU+4cexIBGxFwoiAg=;
        b=VGnERXWRxk278cOfpxUQrKBDxrVtZ77Z+imBs6F3nVoGgyDTIwzbJQ5h/uhoXCWuNGlYGZ
        QO1sufjeZLGapn4Yi7dmduLBBN2mRxuB+UXbGLchIh26hHj4TWpysqwt2WtD5e53g6e/at
        TL17Br76jMDzp4BrtdGC8B8qwNOc51o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-UmHvLj1mO2WzAxNHStPFKA-1; Thu, 28 Oct 2021 10:59:41 -0400
X-MC-Unique: UmHvLj1mO2WzAxNHStPFKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D76AA1023F4D
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:59:40 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-186.phx2.redhat.com [10.3.114.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BCF15C1C5
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:59:40 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/1] Enable inter server to server copies on a export
Date:   Thu, 28 Oct 2021 10:59:38 -0400
Message-Id: <20211028145939.644286-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The patch introduces the 's2sc' export option to exportfs
and along with the recently sent kernel patch will
enable inter server to server copies on specified
exports

The idea being when servers have very interconnect
(as in cluster environments) admins can use this 
option to create very fast copy paths. 

Steve Dickson (1):
  exportfs: Add the 's2sc' option allowing inter server to server copies

 support/include/nfs/export.h |  1 +
 support/nfs/exports.c        |  5 +++++
 utils/exportfs/exportfs.c    |  2 ++
 utils/exportfs/exports.man   | 14 ++++++++++++++
 4 files changed, 22 insertions(+)

-- 
2.31.1

